local ignoreNames = {
  ["Grovebeast"] = true,
  ["Skullfrost"] = true,
  ["Omniphant"] = true,
  ["Emberwing"] = true,
  ["Thundergiant"] = true
}

atkAll = macro(250, function()
  if not g_game.isOnline() then return end

  -- se já tem target, mantém fixo
  if g_game.getAttackingCreature() then return end

  local myPos = player:getPosition()
  local closest
  local closestDist

  for _, creature in ipairs(getSpectators()) do
    if creature
      and creature:isMonster()
      and not creature:isDead()
      and not creature:isNpc()
      and not creature:isPlayer()
      and creature:getPosition().z == myPos.z
      and not ignoreNames[creature:getName()]
    then
      local dist = getDistanceBetween(myPos, creature:getPosition())

      if not closest or dist < closestDist then
        closest = creature
        closestDist = dist
      end
    end
  end

  if closest then
    attack(closest)
  end
end)

addIcon("AtkAll", { item = 12692, text = "target" }, function(icon, isOn)
  atkAll.setOn(isOn)
end)

local countMP = addIcon("HP", {text="HP", item = 23375}, 
function(widget,isOn)
   local id =  23375
   local contar = macro(1000,function() 
      local countItem = itemAmount(id)
      widget.text:setText(countItem.."\n")
      widget.text:setColor("green")
   end)
   contar:setOn()
end)

local countMP = addIcon("MP", {text="MP", item = 53164}, 
function(widget,isOn)
   local id = 53164
   local contar = macro(1000,function() 
      local countItem = itemAmount(id)
      widget.text:setText(countItem.."\n")
      widget.text:setColor("green")
   end)
   contar:setOn()
end)

local healingSpells = {
  {spell = 'exura med ico', threshold = 80}        -- Cura básica quando HP for 99% ou menos
}

curaru = macro(250, function()
  local currentHp = hppercent()
  
  for _, healing in ipairs(healingSpells) do
    if currentHp <= healing.threshold then
      say(healing.spell)
      break
    end
  end
end)


addIcon("CUR", {item=12809, text="exura med ico",}, function(icon, isOn) 
  curaru.setOn(isOn) 
end)

-- ============================================================
-- EK AURERA / TELARIA - STANCES + ROTACAO V5
--
-- BLOOD RAGE = utito tempo
-- PROTECTOR   = utamo tempo
--
-- ICONES NATIVOS DO CLIENTE:
-- usa sprites do proprio .dat/.spr do servidor (sem PNG externo)
--
-- Blood Rage:
-- prioridade exori > exori gran > exori mas
--
-- Protector:
-- com escudo:
-- 1 Shield Slam
-- 2 Shield Bash
-- 3 Inflict Wound
-- 4 rotacao normal do Knight
-- com arma 2H/sem escudo:
-- Inflict Wound + rotacao normal
-- e mantem utamo tempo ativo
-- ============================================================

setDefaultTab('MAIN')

storage.ekAureraV1 = storage.ekAureraV1 or {}
local cfg = storage.ekAureraV1

local function default(k, v)
  if cfg[k] == nil then
    cfg[k] = v
  end
end

default('gap', 2100)

-- ============================================================
-- SHIELD BASH
-- ============================================================

default('bashWords', 'exori ico scu')
default('bashCD', 4)
default('bashMana', 30)
default('bashLevel', 18)
default('bashRange', 1)
default('bashOn', true)

-- ============================================================
-- SHIELD SLAM
-- ============================================================

default('slamWords', 'exori scu')
default('slamCD', 6)
default('slamMana', 110)
default('slamLevel', 30)
default('slamRange', 1)
default('slamOn', true)

default('shieldSpells', true)

-- ============================================================
-- ICONES NATIVOS DO SERVIDOR / CLIENTE
--
-- O addIcon desenha o sprite diretamente do .dat/.spr carregado
-- pelo OTClient. Nao precisa criar pasta, copiar PNG ou editar APK.
--
-- Se o Aurera alterar algum sprite, basta trocar somente os IDs.
-- ============================================================

local SERVER_ICONS = {
  -- Soulshredder / ATAQUE
  attack = 34083,

  -- Soulbastion / DEFESA
  defense = 34099,

  -- Icone da rotacao
  rotation = 47375
}

-- ============================================================
-- ESTADO
-- ============================================================

local function clock()
  return now or g_clock.millis()
end

-- ============================================================
-- DETECCAO 2H / ESCUDO
--
-- No OTCv8:
-- SlotRight = mao direita
-- SlotLeft  = mao esquerda
--
-- Com arma 1H + escudo, os dois slots ficam ocupados.
-- Com arma 2H, apenas um slot de mao fica ocupado.
-- ============================================================

local function hasShieldSetup()
  local left = nil
  local right = nil

  if getLeft then
    left = getLeft()
  elseif player and player.getInventoryItem then
    left = player:getInventoryItem(InventorySlotLeft)
  end

  if getRight then
    right = getRight()
  elseif player and player.getInventoryItem then
    right = player:getInventoryItem(InventorySlotRight)
  end

  return left ~= nil and right ~= nil
end

local last = {}
local globalNext = 0

local stance = 'unknown'
local pending = nil
local pendingAt = 0

local icons = {}

-- ============================================================
-- TEXTO DO ICONE
-- ============================================================

local function label(icon, text, color)

  if icon and icon.text then
    icon.text:setText(text)
    icon.text:setColor(color)
  end
end

-- ============================================================
-- TEXTOS FIXOS DOS ICONES
-- ============================================================

local function refreshStances()
  -- Texto fixo, sem ON/OFF. A cor mostra o estado confirmado pelo servidor.
  label(
    icons.attack,
    'utito tempo',
    stance == 'attack' and '#55ff55' or '#ff5555'
  )

  label(
    icons.defense,
    'utamo tempo',
    stance == 'defense' and '#55ff55' or '#ff5555'
  )
end

-- ============================================================
-- TROCA DE STANCE
-- ============================================================

local function choose(wanted, words)

  if not g_game.isOnline() then
    return
  end

  -- Já esperando confirmação
  if pending then
    return
  end

  -- Se clicar na stance que ja esta ativa, envia a mesma fala
  -- novamente para o servidor desativar. Caso contrario, ativa/troca.
  local togglingOff = (stance == wanted)

  pending = togglingOff and 'off' or wanted
  pendingAt = clock()

  -- RESPOSTA VISUAL INSTANTANEA:
  -- nao espera a mensagem do servidor para trocar a cor.
  -- Ativou/trocou -> fica verde na hora.
  -- Desativou     -> fica vermelho na hora.
  if togglingOff then
    stance = 'unknown'
  else
    stance = wanted
  end

  refreshStances()

  globalNext =
    math.max(
      globalNext,
      clock() + cfg.gap
    )

  say(words)
end

-- ============================================================
-- ICONE ATAQUE
-- BLOOD RAGE / UTITO TEMPO
-- ============================================================

icons.attack = addIcon(
  'ekAureraAttack',
  {
    item = { id = SERVER_ICONS.attack, count = 1 },
    text = 'utito tempo',
    switchable = false,
    moveable = true
  },
  function()

    choose(
      'attack',
      'utito tempo'
    )

  end
)

icons.attack:setSize({
  width = 64,
  height = 64
})


-- ============================================================
-- ICONE DEFESA
-- PROTECTOR / UTAMO TEMPO
-- ============================================================

icons.defense = addIcon(
  'ekAureraDefense',
  {
    item = { id = SERVER_ICONS.defense, count = 1 },
    text = 'utamo tempo',
    switchable = false,
    moveable = true
  },
  function()

    choose(
      'defense',
      'utamo tempo'
    )

  end
)

icons.defense:setSize({
  width = 64,
  height = 64
})


-- ============================================================
-- CONFIRMACAO DAS STANCES PELO SERVIDOR
-- ============================================================

onTextMessage(function(mode, text)

  text =
    (text or ''):lower()

  -- ==========================================================
  -- BLOOD RAGE ATIVADO
  -- ==========================================================

  if text:find(
    'you have activated the blood rage',
    1,
    true
  ) then

    stance = 'attack'
    pending = nil

  -- ==========================================================
  -- PROTECTOR ATIVADO
  -- ==========================================================

  elseif text:find(
    'you have activated the protector',
    1,
    true
  ) then

    stance = 'defense'
    pending = nil

  -- ==========================================================
  -- STANCE DESATIVADA
  -- ==========================================================

  elseif
    text:find(
      'deactivated',
      1,
      true
    )
    and
    (
      text:find(
        'blood rage',
        1,
        true
      )
      or
      text:find(
        'protector',
        1,
        true
      )
    )
  then

    stance = 'unknown'
    pending = nil

  else

    return

  end

  refreshStances()
end)

-- ============================================================
-- MAGIAS DA STANCE ATAQUE
--
-- PRIORIDADE:
--
-- 1 - exori
-- 2 - exori gran
-- 3 - exori mas
-- 4 - exori min
-- 5 - exori gran ico
-- 6 - exori ico
-- 7 - exori hur
-- ============================================================

local spells = {

  {
    words = 'exori',
    mana = 125,
    level = 35,
    range = 1,
    mobs = 1,
    cd = 4000,
    area = true
  },

  {
    words = 'exori gran',
    mana = 360,
    level = 90,
    range = 1,
    mobs = 1,
    cd = 6000,
    area = true
  },

  {
    words = 'exori mas',
    mana = 200,
    level = 33,
    range = 2,
    mobs = 1,
    cd = 8000,
    area = true
  },

  {
    words = 'exori min',
    mana = 200,
    level = 70,
    range = 1,
    mobs = 2,
    cd = 6000,
    area = true,
    turning = true
  },

  {
    words = 'exori gran ico',
    mana = 300,
    level = 110,
    range = 1,
    mobs = 1,
    cd = 30000
  },

  {
    words = 'exori ico',
    mana = 30,
    level = 16,
    range = 1,
    mobs = 1,
    cd = 6000
  },

  {
    words = 'exori hur',
    mana = 40,
    level = 28,
    range = 5,
    mobs = 1,
    cd = 6000
  }

}

-- ============================================================
-- MAGIA EXTRA DO KNIGHT
-- Inflict Wound = utori kor
-- Level 40 / 30 mana / 30s / alcance 1 SQM
-- ============================================================

local inflictWound = {
  words = 'utori kor',
  mana = 30,
  level = 40,
  range = 1,
  mobs = 1,
  cd = 30000
}

-- ============================================================
-- FAMILIARES / SUMMONS IGNORADOS
-- ============================================================

local ignore = {

  Emberwing = true,

  Skullfrost = true,

  Snowbash = true,

  Grovebeast = true,

  Mossmasher = true,

  Groovebeast = true,

  Thundergiant = true,

  Bladespark = true,

  Sandscourge = true,

  Omniphant = true,

  Moonhunter = true

}

-- ============================================================
-- DISTANCIA
-- ============================================================

local function distance(a, b)

  if not a or not b then
    return 999
  end

  if a.z ~= b.z then
    return 999
  end

  return math.max(
    math.abs(a.x - b.x),
    math.abs(a.y - b.y)
  )
end

-- ============================================================
-- SCAN DE CRIATURAS
-- ============================================================

local function makeSnapshot(p)
  local data = {
    monsters = {}
  }

  for _, creature in ipairs(getSpectators()) do
    local cp = creature:getPosition()

    if cp and cp.z == p.z and creature:getId() ~= player:getId() then
      local d = distance(p, cp)

      if
        creature:isMonster()
        and not ignore[creature:getName()]
      then
        data.monsters[#data.monsters + 1] = d
      end
    end
  end

  return data
end

local function countMonsters(snapshot, range)
  local count = 0

  for _, d in ipairs(snapshot.monsters) do
    if d <= range then
      count = count + 1
    end
  end

  return count
end


-- ============================================================
-- ROTACAO
-- ============================================================

local rotation = macro(
  100,
  'EK Rotacao',
  function()

    -- Offline
    if not g_game.isOnline() then
      return
    end

    -- Player inexistente
    if not player then
      return
    end

    -- Esperando stance
    if pending then
      return
    end

    -- Global delay
    if clock() < globalNext then
      return
    end

    -- ========================================================
    -- PRECISA TER STANCE CONFIRMADA
    -- ========================================================

    if
      stance ~= 'attack'
      and
      stance ~= 'defense'
    then

      return

    end

    -- ========================================================
    -- TARGET
    -- ========================================================

    local target =
      g_game.getAttackingCreature()

    if
      not target
      or
      not target:isMonster()
    then

      return

    end

    local p =
      player:getPosition()

    local tp =
      target:getPosition()

    if
      not p
      or
      not tp
      or
      p.z ~= tp.z
    then

      return

    end

    local time =
      clock()

    local list = {}

    -- Faz apenas UM scan de criaturas por ciclo.
    -- Isso reduz bastante o trabalho no mobile.
    local snapshot = makeSnapshot(p)

    -- ========================================================
    -- STANCE DEFESA / PROTECTOR
    --
    -- COM ESCUDO:
    -- 1 - Shield Slam
    -- 2 - Shield Bash
    -- 3 - Inflict Wound
    -- 4 - Rotacao normal do Knight
    --
    -- 2H:
    -- Inflict Wound + Rotacao normal
    -- ========================================================

    if stance == 'defense' then

      -- ======================================================
      -- PROTECTOR COM ESCUDO
      -- Prioridade:
      -- 1 - Shield Slam
      -- 2 - Shield Bash
      -- ======================================================

      if hasShieldSetup() then

        for _, key in ipairs({

          'slam',

          'bash'

        }) do

          if
            cfg.shieldSpells
            and
            cfg[key .. 'On']
            and
            cfg[key .. 'Words'] ~= ''
            and
            cfg[key .. 'CD'] > 0
          then

            list[#list + 1] = {

              words =
                cfg[key .. 'Words'],

              mana =
                cfg[key .. 'Mana'],

              level =
                cfg[key .. 'Level'],

              range =
                cfg[key .. 'Range'],

              mobs =
                (
                  key == 'slam'
                  and 2
                  or 1
                ),

              cd =
                cfg[key .. 'CD']
                * 1000,

              area =
                (
                  key == 'slam'
                )

            }

          end

        end

        -- Depois das magias de escudo, continua atacando normalmente.
        list[#list + 1] = inflictWound

        for _, spell in ipairs(spells) do
          list[#list + 1] = spell
        end

      -- ======================================================
      -- PROTECTOR COM ARMA 2H / SEM ESCUDO
      --
      -- Mantem utamo tempo ativo, mas nao tenta Shield Slam
      -- ou Shield Bash, pois essas magias exigem escudo.
      -- Usa a mesma rotacao ofensiva como fallback.
      -- ======================================================

      else

        list[#list + 1] = inflictWound

        for _, spell in ipairs(
          spells
        ) do

          list[#list + 1] =
            spell

        end

      end

    -- ========================================================
    -- BLOOD RAGE / STANCE ATAQUE
    -- ========================================================

    else

      list[#list + 1] = inflictWound

      for _, spell in ipairs(
        spells
      ) do

        list[#list + 1] =
          spell

      end

    end

    -- ========================================================
    -- PROCURA PRIMEIRA MAGIA DISPONIVEL
    -- ========================================================

    for _, spell in ipairs(
      list
    ) do

      local count =
        countMonsters(
          snapshot,
          spell.range
        )

      if

        distance(
          p,
          tp
        ) <= spell.range

        and

        count >= spell.mobs

        and

        mana() >= spell.mana

        and

        lvl() >= spell.level

        and

        time >= (
          last[spell.words]
          or 0
        )

      then

        -- ====================================================
        -- EXORI MIN
        -- VIRA PARA O MONSTRO
        -- ====================================================

        if spell.turning then

          local dx =
            tp.x - p.x

          local dy =
            tp.y - p.y

          local direction

          if
            dx ~= 0
            or
            dy ~= 0
          then

            if
              math.abs(dx)
              >
              math.abs(dy)
            then

              direction =
                dx > 0
                and 1
                or 3

            else

              direction =
                dy > 0
                and 2
                or 0

            end

            if
              player:getDirection()
              ~=
              direction
            then

              turn(
                direction
              )

              globalNext =
                time + 150

              return

            end

          end

        end

        -- ====================================================
        -- CAST
        -- ====================================================

        last[spell.words] =
          time
          +
          spell.cd

        globalNext =
          time
          +
          cfg.gap

        say(
          spell.words
        )

        -- Uma magia por ciclo
        return

      end
    end
  end
)

-- Começa desligada
rotation.setOff()

-- ============================================================
-- ICONE ROTACAO
-- ============================================================

icons.rotation = addIcon(
  'ekAureraRotation',
  {
    item = { id = SERVER_ICONS.rotation, count = 1 },
    text = 'atack',
    moveable = true
  },
  rotation
)

icons.rotation:setSize({
  width = 64,
  height = 64
})


-- ============================================================
-- LOGIN / LOGOUT / TIMEOUT
-- ============================================================

local wasOnline =
  g_game.isOnline()

macro(
  250,
  function()

    local online =
      g_game.isOnline()

    -- ========================================================
    -- DESLOGOU
    -- ========================================================

    if not online then

      stance =
        'unknown'

      pending =
        nil

      last = {}
      globalNext = 0

    -- ========================================================
    -- LOGOU NOVAMENTE
    -- ========================================================

    elseif not wasOnline then

      stance =
        'unknown'

      pending =
        nil

      last = {}
      globalNext = 0

    end

    wasOnline =
      online

    -- ========================================================
    -- SERVIDOR NAO CONFIRMOU STANCE
    -- ========================================================

    if
      pending
      and
      clock() - pendingAt > 5000
    then

      pending =
        nil

      stance =
        'unknown'

    end

    refreshStances()

  end
)

-- ============================================================
-- INICIALIZA TEXTOS
-- ============================================================

refreshStances()

-- V5: cor instantanea no clique. Ativar deixa verde imediatamente;
-- desativar deixa vermelho imediatamente. A mensagem do servidor continua
-- confirmando/corrigindo o estado depois. Sem ON/OFF escrito.




