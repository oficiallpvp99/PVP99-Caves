local ropeId = 3003  -- ID da Rope
local useOnSelf = true  -- Variável para usar em você mesmo

corda = macro(1000, function()
  if useOnSelf then
    usewith(ropeId, player)  -- Usa a Rope no personagem
  end
end)

addIcon("Co", {item=3003, text="ropa",}, function(icon, isOn) 
  corda.setOn(isOn) 
end)

local function hideAllIcon()
  for i, child in ipairs(modules.game_interface.gameMapPanel:getChildren()) do
    if child:getStyleName() == "BotIcon" then
      if icon then
        child:hide()
      else
        child:show()
      end
    end
  end
end

hotkey("F2", "Esconder Iconos", function() 
  icon = not icon
  hideAllIcon()
end)


local npcCities = {
  ['King Tibianus'] = {'promotion'},
  ['Stutchs'] = {'Ab\'Dendriel'}
}

local npcs = {
  'King Tibianus',
  'Stutchs'
}


-- Interfaz de usuario
g_ui.loadUIFromString([[
CityTravelWindow < MainWindow
  text: By Pvp99
  size: 110 70

  ComboBox
    id: travelOptions
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.top: parent.top
    margin-top: 1
    width: 80
    height: 20

  HorizontalSeparator
    id: separator
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.top: travelOptions.bottom
    margin-top: 5

]])

local panelName = "cityTravel"
if not storage[panelName] then
  storage[panelName] = {
    enabled = false,
  }
end

local config = storage[panelName]

rootWidget = g_ui.getRootWidget()
if rootWidget then
  local cityTravelWindow = UI.createWindow('CityTravelWindow', rootWidget)
  cityTravelWindow:hide()

  for _, npcName in ipairs(npcs) do
    NPC[npcName] = function(text)
        if g_game.getClientVersion() >= 810 then
            g_game.talkChannel(11, 0, text)
        else
            return say(text)
        end
    end
  end

  local function updateTravelOptions(npcName)
    cityTravelWindow:recursiveGetChildById('travelOptions'):clearOptions()
    cityTravelWindow:recursiveGetChildById('travelOptions'):addOption("Comprar")
    if npcCities[npcName] then
      for _, city in ipairs(npcCities[npcName]) do
        cityTravelWindow:recursiveGetChildById('travelOptions'):addOption(city)
      end
    end
  end

  macro(100, function()
    for _, npcName in ipairs(npcs) do
      local findNpc = getCreatureByName(npcName)
      local playerPos = pos()
      if findNpc and getDistanceBetween(playerPos, findNpc:getPosition()) <= 2 then
        updateTravelOptions(npcName)
        cityTravelWindow:show()
        break
      else
        cityTravelWindow:hide()
      end
    end
  end)

  cityTravelWindow:recursiveGetChildById('travelOptions').onOptionChange = function(widget, option, data)
    if option ~= "Comprar" then
      NPC.say('hail king')
      schedule(200, function()  -- 2 seconds delay
        for _, npcName in ipairs(npcs) do
          local findNpc = getCreatureByName(npcName)
          if findNpc and getDistanceBetween(pos(), findNpc:getPosition()) <= 2 then
            NPC[npcName](option)
          end
        end
      end)
      schedule(500, function()  -- 4 seconds delay from the start (2 seconds after the previous command)
        for _, npcName in ipairs(npcs) do
          local findNpc = getCreatureByName(npcName)
          if findNpc and getDistanceBetween(pos(), findNpc:getPosition()) <= 2 then
            NPC[npcName]('yes')
          end
        end
      end)
    end
  end
end

--========================================================--
--                 PVP99 - NPC SYSTEM
--      Banco + Viagem + Trade em um único macro
--========================================================--

local npcGroups = {

  --======================================================--
  -- BANCO
  -- Sequência:
  -- hi -> opção -> yes
  --======================================================--

  Banco = {
    final = "yes",

    npcs = {
      ["Naji"] = {"deposit all"},
      ["Anya"] = {"deposit all"},
      ["Eva"] = {"deposit all"},
      ["Kepar"] = {"deposit all"},

      -- ADICIONE NOVOS NPCs DE BANCO AQUI
      -- ["Nome NPC"] = {"deposit all"},
    }
  },


  --======================================================--
  -- VIAGENS
  -- Sequência:
  -- hi -> cidade -> yes
  --======================================================--

  Cidades = {
    final = "yes",

    npcs = {

      ["Captain Bluebear"] = {
        "Carlin",
        "Ab'Dendriel",
        "Venore",
        "Port Hope",
        "Liberty Bay",
        "Svargrond",
        "Yalahar",
        "Roshamuul",
        "Oramond",
        "Edron",
        "Krailos",
        "Rangiroa",
        "Arcadia"
      },

      ["Captain Greyhound"] = {
        "Thais",
        "Ab'Dendriel",
        "Venore",
        "Svargrond",
        "Yalahar",
        "Edron",
        "Arcadia"
      },

      ["Captain Fearless"] = {
        "Issavi",
        "Thais",
        "Carlin",
        "Ab'Dendriel",
        "Port Hope",
        "Edron",
        "Darashia",
        "Liberty Bay",
        "Svargrond",
        "Yalahar",
        "Gray Island",
        "Ankrahmun",
        "Rangiroa",
        "Arcadia"
      },

      ["Captain Seagull"] = {
        "Thais",
        "Carlin",
        "Venore",
        "Yalahar",
        "Edron",
        "Gray Island"
      },

      ["Captain Cookie"] = {
        "Liberty Bay"
      },

      ["Jack Fate"] = {
        "Edron",
        "Thais",
        "Venore",
        "Darashia",
        "Ankrahmun",
        "Yalahar",
        "Port Hope"
      },

      ["Charles"] = {
        "Thais",
        "Darashia",
        "Venore",
        "Liberty Bay",
        "Ankrahmun",
        "Yalahar",
        "Edron"
      },

      ["Karith"] = {
        "Ab'Dendriel",
        "Darashia",
        "Venore",
        "Ankrahmun",
        "Port Hope",
        "Thais",
        "Liberty Bay",
        "Carlin",
        "Arcadia"
      },

      ["Captain Max"] = {
        "Calassa",
        "Yalahar",
        "Liberty Bay"
      },

      ["Captain Seahorse"] = {
        "Thais",
        "Carlin",
        "Ab'Dendriel",
        "Venore",
        "Port Hope",
        "Ankrahmun",
        "Liberty Bay",
        "Gray Island",
        "Cormaya"
      },

      ["Pemaret"] = {
        "Edron",
        "Eremo"
      },

      ["Eremo"] = {
        "passage"
      },

      ["Captain Pelagia"] = {
        "Edron",
        "Darashia",
        "Oramond",
        "Venore",
        "Issavi"
      },

      ["Captain Gulliver"] = {
        "Thais",
        "Krailos"
      },

      ["Captain Chelop"] = {
        "Thais"
      },

      ["Captain Harava"] = {
        "Oramond",
        "Krailos",
        "Venore",
        "Darashia"
      },

      ["Captain Grenald"] = {
        "Carlin",
        "Thais",
        "Venore",
        "Yalahar",
        "Svargrond"
      },

      ["Gurbasch"] = {
        "Kazordoon",
        "Farmine",
        "Gnomprona"
      },

      ["Thorgrin"] = {
        "Cormaya",
        "Kazordoon"
      },

      ["Brodrosch"] = {
        "Cormaya",
        "Farmine",
        "Gnomprona",
        "Ticket"
      },

      ["Melian"] = {
        "Darashia",
        "Femor Hills",
        "Svargrond",
        "Edron",
        "Issavi"
      },

      ["Chemar"] = {
        "Farmine",
        "Femor Hills",
        "Svargrond",
        "Edron",
        "Issavi",
        "Marapur",
        "Kazordoon"
      },

      ["Gewen"] = {
        "Farmine",
        "Femor Hills",
        "Svargrond",
        "Edron",
        "Issavi",
        "Marapur",
        "Darashia",
        "Ticket"
      },

      ["Uzon"] = {
        "Farmine",
        "Kazordoon",
        "Svargrond",
        "Edron",
        "Issavi",
        "Marapur",
        "Darashia"
      },

      ["Tanyt"] = {
        "Farmine",
        "Femor Hills",
        "Svargrond",
        "Edron",
        "Issavi",
        "Marapur",
        "Darashia",
        "Kazordoon",
        "Arcadia"
      },

      ["Alfrida"] = {
        "Farmine",
        "Femor Hills",
        "Svargrond",
        "Edron",
        "Issavi",
        "Marapur",
        "Darashia",
        "Kazordoon"
      },

      ["Iyad"] = {
        "Farmine",
        "Femor Hills",
        "Edron",
        "Issavi",
        "Marapur",
        "Darashia",
        "Kazordoon"
      },

      ["Petros"] = {
        "Venore",
        "Ankrahmun",
        "Yalahar",
        "Port Hope",
        "Issavi",
        "Gray Island"
      },

      ["Captain Sinbeard"] = {
        "Darashia",
        "Yalahar",
        "Port Hope",
        "Edron",
        "Venore",
        "Liberty Bay"
      },

      ["Lorek"] = {
        "Center",
        "West",
        "Banuta",
        "Chor",
        "Darama"
      },

      ["Imbul"] = {
        "Centre",
        "east"
      },

      ["Old Adall"] = {
        "east",
        "west"
      },

      ["Pino"] = {
        "Farmine",
        "Femor Hills",
        "Edron",
        "Issavi",
        "Marapur",
        "Darashia",
        "Kazordoon"
      },

      ["Captain Frank"] = {
        "Venore"
      },

      ["Captain Breezelda"] = {
        "Carlin",
        "Venore",
        "Thais",
        "Arcadia"
      },

      ["Quentin"] = {
        "twist of fate"
      },

      ["Scrutinon"] = {
        "Ab'Dendriel",
        "Darashia",
        "Edron",
        "Venore"
      },

      -- ADICIONE NOVOS NPCs DE VIAGEM AQUI
      -- ["Novo Captain"] = {"Thais", "Carlin", "Venore"},
    }
  },


  --======================================================--
  -- TRADE
  -- Sequência:
  -- hi -> opção -> trade
  --======================================================--

  Trade = {
    final = "trade",

    npcs = {

      ["Yasir"] = {"sell"},
      ["Sarina"] = {"buy/sell"},
      ["Imalas"] = {"sell"},
      ["Cornelia"] = {"buy/sell"},
      ["Liane"] = {"buy"},
      ["Legola"] = {"buy"},
      ["Nydala"] = {"buy"},
      ["Perac"] = {"buy/sell"},
      ["Rowenna"] = {"buy/sell"},
      ["Florentine"] = {"buy"},
      ["Benjamin"] = {"buy"},
      ["Furry"] = {"buy/sell"},
      ["Urd"] = {"buy/sell"},
      ["Frodo"] = {"buy"},
      ["Quero"] = {"buy"},
      ["Xodet"] = {"buy/sell"},
      ["Hanna"] = {"buy/sell"},
      ["Gorn"] = {"buy"},
      ["Sam"] = {"buy/sell"},
      ["Turvy"] = {"buy/sell"},
      ["Topsy"] = {"buy/sell"},
      ["Gamon"] = {"buy"},
      ["Baxter"] = {"buy/sell"},
      ["Lubo"] = {"buy/sell"},
      ["Enpa-Deia Pema"] = {"buy/sell"},
      ["Zethra"] = {"buy"},
      ["Alesar"] = {"buy/sell"},
      ["Yaman"] = {"buy/sell"},
      ["Rashid"] = {"buy/sell"},
      ["Nah'Bob"] = {"buy/sell"},
      ["Haroun"] = {"buy/sell"},
      ["Nelliem"] = {"buy"},
      ["Shiantis"] = {"buy/sell"},
      ["Chephan"] = {"buy"},
      ["Julian"] = {"buy"},
      ["Rachel"] = {"buy/sell"},

      -- ADICIONE NOVOS NPCs DE TRADE AQUI
      -- ["Novo NPC"] = {"buy/sell"},
    }
  }
}


--========================================================--
-- NÃO PRECISA ALTERAR DAQUI PARA BAIXO
--========================================================--

local NPC_DISTANCE = 2

local DELAY_OPTION = 200
local DELAY_FINAL = 500
local DELAY_RESET = 800


--========================================================--
-- CRIA ÍNDICE AUTOMÁTICO DOS NPCs
--========================================================--

local npcIndex = {}

for categoryName, category in pairs(npcGroups) do

  for npcName, npcData in pairs(category.npcs) do

    local options = npcData
    local finalCommand = category.final

    -- Permite configuração especial futuramente
    if npcData.options then

      options = npcData.options

      if npcData.final ~= nil then
        finalCommand = npcData.final
      end
    end

    npcIndex[npcName] = {
      category = categoryName,
      options = options,
      final = finalCommand
    }
  end
end


--========================================================--
-- INTERFACE
--========================================================--

g_ui.loadUIFromString([[
Pvp99NpcWindow < MainWindow
  id: pvp99NpcWindow
  text: By Pvp99
  size: 155 85

  Label
    id: npcName
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.top: parent.top
    margin-top: 1
    text: NPC

  ComboBox
    id: travelOptions
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.top: npcName.bottom
    margin-top: 6
    width: 125
    height: 20

  HorizontalSeparator
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.top: travelOptions.bottom
    margin-top: 5
]])


--========================================================--
-- FUNÇÕES
--========================================================--

local rootWidget = g_ui.getRootWidget()

if rootWidget then

  local oldWindow =
    rootWidget:recursiveGetChildById("pvp99NpcWindow")

  if oldWindow then
    oldWindow:destroy()
  end


  local npcWindow =
    UI.createWindow("Pvp99NpcWindow", rootWidget)

  npcWindow:hide()


  local combo =
    npcWindow:recursiveGetChildById("travelOptions")

  local npcLabel =
    npcWindow:recursiveGetChildById("npcName")


  local currentNpc = nil

  local updatingOptions = false

  local busy = false


  --======================================================--
  -- FALA NO CHANNEL DO NPC
  --======================================================--

  local function npcSay(text)

    if not text then
      return
    end

    if g_game.getClientVersion() >= 810 then
      g_game.talkChannel(11, 0, text)
    else
      say(text)
    end
  end


  --======================================================--
  -- VERIFICA SE NPC CONTINUA PERTO
  --======================================================--

  local function npcIsNear(npcName)

    local creature = getCreatureByName(npcName)

    if not creature then
      return false
    end

    local distance =
      getDistanceBetween(
        pos(),
        creature:getPosition()
      )

    return distance <= NPC_DISTANCE
  end


  --======================================================--
  -- PROCURA NPC MAIS PRÓXIMO
  --======================================================--

  local function findNearbyNpc()

    local playerPos = pos()

    local nearestNpc = nil
    local nearestDistance = nil

    for npcName, _ in pairs(npcIndex) do

      local creature =
        getCreatureByName(npcName)

      if creature then

        local distance =
          getDistanceBetween(
            playerPos,
            creature:getPosition()
          )

        if distance <= NPC_DISTANCE then

          if not nearestDistance or
             distance < nearestDistance then

            nearestNpc = npcName
            nearestDistance = distance
          end
        end
      end
    end

    return nearestNpc
  end


  --======================================================--
  -- ATUALIZA COMBOBOX
  --======================================================--

  local function updateNpcOptions(npcName)

    local data =
      npcIndex[npcName]

    if not data then
      return
    end

    updatingOptions = true

    combo:clearOptions()

    combo:addOption(data.category)

    for _, option in ipairs(data.options) do
      combo:addOption(option)
    end

    npcLabel:setText(npcName)

    updatingOptions = false
  end


  --======================================================--
  -- DETECTOR AUTOMÁTICO DE NPC
  --======================================================--

  macro(100, "PVP99 NPC", function()

    local npcName =
      findNearbyNpc()


    -- Encontrou NPC
    if npcName then

      -- Mudou de NPC
      if currentNpc ~= npcName then

        currentNpc = npcName

        busy = false

        updateNpcOptions(npcName)

        npcWindow:show()
      else

        if not npcWindow:isVisible() then
          npcWindow:show()
        end
      end

      return
    end


    -- Nenhum NPC próximo
    currentNpc = nil

    busy = false

    npcWindow:hide()
  end)


  --======================================================--
  -- QUANDO SELECIONAR UMA OPÇÃO
  --======================================================--

  combo.onOptionChange =
    function(widget, option, data)


      -- Evita disparar ao atualizar ComboBox
      if updatingOptions then
        return
      end


      if not currentNpc then
        return
      end


      local npcData =
        npcIndex[currentNpc]

      if not npcData then
        return
      end


      -- Ignora Banco / Cidades / Trade
      if option == npcData.category then
        return
      end


      -- Impede comandos simultâneos
      if busy then
        return
      end


      local actionNpc =
        currentNpc

      if not npcIsNear(actionNpc) then
        return
      end


      busy = true


      --==================================================--
      -- 1 - HI
      --==================================================--

      say("hi")


      --==================================================--
      -- 2 - OPÇÃO
      --==================================================--

      schedule(DELAY_OPTION, function()

        if npcIsNear(actionNpc) then
          npcSay(option)
        end
      end)


      --==================================================--
      -- 3 - YES / TRADE
      --==================================================--

      schedule(DELAY_FINAL, function()

        if npcIsNear(actionNpc) then

          local actionData =
            npcIndex[actionNpc]

          if actionData and
             actionData.final then

            npcSay(actionData.final)
          end
        end
      end)


      --==================================================--
      -- RESET DA LISTA
      -- Permite escolher a mesma opção novamente
      --==================================================--

      schedule(DELAY_RESET, function()

        busy = false

        if currentNpc == actionNpc and
           npcIsNear(actionNpc) then

          updateNpcOptions(actionNpc)
        end
      end)

    end
end

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




local countMP = addIcon("MP", {text="MP", item = 23374}, 
function(widget,isOn)
   local id =  23374
   local contar = macro(1000,function() 
      local countItem = itemAmount(id)
      widget.text:setText(countItem.."\n")
      widget.text:setColor("green")
   end)
   contar:setOn()
end)

-- ============================================================
-- MONK AURERA / TELARIA - V5
-- VIRTUES + ROTACAO COMPLETA + ICONES NATIVOS
--
-- HARMONY = utori virtu
-- JUSTICE = utito virtu
-- SUSTAIN = utura tio
--
-- Padrao V5:
-- * sem PNG externo
-- * icones nativos do .dat/.spr do cliente
-- * texto fixo nos botoes
-- * verde/vermelho instantaneo ao clicar
-- * mensagem do servidor sincroniza o estado depois
-- * Thousand Fist Blows + Chained Penance
-- * Builders/Spenders completos com fallbacks
-- * Inflict Wound como utilidade
-- * cura respeita grupo de 1s
-- * sem bloqueio por player proximo
-- * rotacao inicia desligada
-- ============================================================

setDefaultTab('MAIN')

-- Mantem o mesmo storage da V2 para preservar configuracoes antigas.
storage.monkAureraV2 = storage.monkAureraV2 or {}
local cfg = storage.monkAureraV2

local function default(k, v)
  if cfg[k] == nil then
    cfg[k] = v
  end
end

default('attackGap', 2100)
default('actionGap', 350)

default('healAt', 70)
default('massHealAt', 45)
default('massHealOn', true)

default('thousandOn', true)
default('spiritualOn', true)

-- ============================================================
-- ICONES NATIVOS DO SERVIDOR / CLIENTE
--
-- Nao usa PNG. O addIcon usa diretamente o sprite existente
-- no .dat/.spr carregado pelo OTClient.
--
-- Pode trocar somente os IDs abaixo se quiser outro visual.
-- ============================================================

local SERVER_ICONS = {
  -- Monk Robe
  harmony = 50258,

  -- Stag Footwraps
  justice = 52354,

  -- Stag Shield
  sustain = 52357,

  -- Icone nativo escolhido para rotacao
  rotation = 50271
}

-- ============================================================
-- ESTADO
-- ============================================================

local function clock()
  return now or g_clock.millis()
end

local last = {}
local globalNext = 0
local actionNext = 0
local healingNext = 0

local virtue = 'unknown'
local pending = nil
local pendingAt = 0

-- Contador local da Harmony usado pela rotacao.
local harmony = 0

local icons = {}
local rotation = nil

-- ============================================================
-- UI
-- ============================================================

local function label(icon, text, color)
  if icon and icon.text then
    icon.text:setText(text)
    icon.text:setColor(color)
  end
end

local function refreshVirtues()
  label(
    icons.harmony,
    'utori virtu',
    virtue == 'harmony' and '#55ff55' or '#ff5555'
  )

  label(
    icons.justice,
    'utito virtu',
    virtue == 'justice' and '#55ff55' or '#ff5555'
  )

  label(
    icons.sustain,
    'utura tio',
    virtue == 'sustain' and '#55ff55' or '#ff5555'
  )

  if icons.rotation and rotation then
    label(
      icons.rotation,
      'atack',
      rotation:isOn() and '#55ff55' or '#ff5555'
    )
  end
end

-- ============================================================
-- TROCA / DESATIVA VIRTUE
--
-- A cor muda imediatamente no clique.
-- Depois a mensagem do servidor confirma/corrige o estado real.
-- ============================================================

local function chooseVirtue(wanted, words)
  if not g_game.isOnline() then
    return
  end

  if pending then
    return
  end

  local togglingOff = (virtue == wanted)

  pending = togglingOff and 'off' or wanted
  pendingAt = clock()

  if togglingOff then
    virtue = 'unknown'
  else
    virtue = wanted
  end

  -- Evita carregar Harmony local de uma virtue para outra.
  harmony = 0

  refreshVirtues()

  globalNext = math.max(
    globalNext,
    clock() + cfg.actionGap
  )

  say(words)
end

-- ============================================================
-- ICONES DAS VIRTUES
-- ============================================================

icons.harmony = addIcon(
  'monkAureraHarmonyV5',
  {
    item = { id = SERVER_ICONS.harmony, count = 1 },
    text = 'utori virtu',
    switchable = false,
    moveable = true
  },
  function()
    chooseVirtue('harmony', 'utori virtu')
  end
)

icons.harmony:setSize({
  width = 64,
  height = 64
})

icons.justice = addIcon(
  'monkAureraJusticeV5',
  {
    item = { id = SERVER_ICONS.justice, count = 1 },
    text = 'utito virtu',
    switchable = false,
    moveable = true
  },
  function()
    chooseVirtue('justice', 'utito virtu')
  end
)

icons.justice:setSize({
  width = 64,
  height = 64
})

icons.sustain = addIcon(
  'monkAureraSustainV5',
  {
    item = { id = SERVER_ICONS.sustain, count = 1 },
    text = 'utura tio',
    switchable = false,
    moveable = true
  },
  function()
    chooseVirtue('sustain', 'utura tio')
  end
)

icons.sustain:setSize({
  width = 64,
  height = 64
})

-- ============================================================
-- CONFIRMACAO DAS VIRTUES PELO SERVIDOR
--
-- O filtro abaixo e propositalmente tolerante:
-- procura activated/deactivated + nome da virtue.
-- ============================================================

onTextMessage(function(mode, text)
  local msg = (text or ''):lower()

  local activated =
    msg:find('activated', 1, true)
    or msg:find('activate', 1, true)

  local deactivated =
    msg:find('deactivated', 1, true)
    or msg:find('deactivate', 1, true)

  local isHarmony =
    msg:find('virtue of harmony', 1, true)
    or msg:find('harmony virtue', 1, true)

  local isJustice =
    msg:find('virtue of justice', 1, true)
    or msg:find('justice virtue', 1, true)

  local isSustain =
    msg:find('virtue of sustain', 1, true)
    or msg:find('sustain virtue', 1, true)

  if activated and isHarmony then
    virtue = 'harmony'
    pending = nil
    harmony = 0

  elseif activated and isJustice then
    virtue = 'justice'
    pending = nil
    harmony = 0

  elseif activated and isSustain then
    virtue = 'sustain'
    pending = nil
    harmony = 0

  elseif deactivated and (isHarmony or isJustice or isSustain) then
    virtue = 'unknown'
    pending = nil
    harmony = 0

  else
    return
  end

  refreshVirtues()
end)

-- ============================================================
-- DISTANCIA / SNAPSHOT
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

local function makeSnapshot(p)
  local data = {
    monsters = {}
  }

  for _, creature in ipairs(getSpectators()) do
    local cp = creature:getPosition()

    if cp and cp.z == p.z then
      if
        creature:isMonster()
        and not ignore[creature:getName()]
      then
        data.monsters[#data.monsters + 1] = cp
      end
    end
  end

  return data
end

local function countMonsters(snapshot, p, range)
  local count = 0

  for _, cp in ipairs(snapshot.monsters) do
    if distance(p, cp) <= range then
      count = count + 1
    end
  end

  return count
end

-- ============================================================
-- CURA - SUSTAIN
--
-- Prioridade:
-- 1. Mass Spirit Mend <= 45%
-- 2. Spirit Mend      <= 70%
-- 3. Exura Gran       <= 70% (fallback)
-- ============================================================

local heals = {
  mass = {
    words = 'exura mas nia',
    mana = 250,
    level = 150,
    cd = 12000
  },

  spirit = {
    words = 'exura gran tio',
    mana = 210,
    level = 80,
    cd = 1000
  },

  fallback = {
    words = 'exura gran',
    mana = 70,
    level = 20,
    cd = 1000
  }
}

local function tryHeal(time)
  if virtue ~= 'sustain' then
    return false
  end

  if time < healingNext then
    return false
  end

  local hp = hppercent()

  local function ready(spell)
    return
      mana() >= spell.mana
      and lvl() >= spell.level
      and time >= (last[spell.words] or 0)
  end

  if
    cfg.massHealOn
    and hp <= cfg.massHealAt
    and ready(heals.mass)
  then
    last[heals.mass.words] = time + heals.mass.cd
    healingNext = time + 1000
    globalNext = time + cfg.actionGap
    say(heals.mass.words)
    return true
  end

  if hp <= cfg.healAt and ready(heals.spirit) then
    last[heals.spirit.words] = time + heals.spirit.cd
    healingNext = time + 1000
    globalNext = time + cfg.actionGap
    say(heals.spirit.words)
    return true
  end

  if hp <= cfg.healAt and ready(heals.fallback) then
    last[heals.fallback.words] = time + heals.fallback.cd
    healingNext = time + 1000
    globalNext = time + cfg.actionGap
    say(heals.fallback.words)
    return true
  end

  return false
end

-- ============================================================
-- BUILDERS
--
-- Mantidos da V2.
-- Cada Builder usado aumenta Harmony local em +1, ate 5.
-- ============================================================

local builders = {

  {
    words = 'exori med pug',
    mana = 180,
    level = 70,
    cd = 4000,
    range = 7,
    mobs = 1,
    area = true
  },

  {
    words = 'exori mas amp pug',
    mana = 145,
    level = 120,
    cd = 8000,
    range = 7,
    mobs = 1,
    area = true,
    enabled = function()
      return cfg.thousandOn
    end
  },

  {
    words = 'exori gran mas pug',
    mana = 300,
    level = 90,
    cd = 16000,
    range = 2,
    mobs = 2,
    area = true
  },

  {
    words = 'exori mas pug',
    mana = 110,
    level = 35,
    cd = 4000,
    range = 2,
    mobs = 2,
    area = true
  },

  {
    words = 'exori gran pug',
    mana = 325,
    level = 110,
    cd = 60000,
    range = 1,
    mobs = 1
  },

  {
    words = 'exori amp pug',
    mana = 150,
    level = 30,
    cd = 8000,
    range = 7,
    mobs = 1
  },

  {
    words = 'exori pug',
    mana = 30,
    level = 14,
    cd = 4000,
    range = 1,
    mobs = 1
  },

  {
    words = 'exori infir amp pug',
    mana = 30,
    level = 6,
    cd = 20000,
    range = 7,
    mobs = 1
  },

  {
    words = 'exori infir pug',
    mana = 3,
    level = 1,
    cd = 4000,
    range = 1,
    mobs = 1
  }
}

-- ============================================================
-- SPENDERS
--
-- So entram com Harmony local = 5.
--
-- Harmony virtue:
-- apos spender volta para 1.
--
-- Justice / Sustain:
-- apos spender volta para 0.
-- ============================================================

local spenders = {
  {
    words = 'exori gran mas nia',
    mana = 425,
    level = 1,
    cd = 24000,
    range = 7,
    mobs = 3,
    area = true,
    enabled = function()
      return cfg.spiritualOn
    end
  },

  {
    words = 'exori mas nia',
    mana = 195,
    level = 60,
    cd = 8000,
    range = 2,
    mobs = 2,
    area = true
  },

  {
    words = 'exori gran nia',
    mana = 210,
    level = 125,
    cd = 8000,
    range = 7,
    mobs = 1
  },

  {
    words = 'exori nia',
    mana = 50,
    level = 18,
    cd = 8000,
    range = 1,
    mobs = 1
  },

  {
    words = 'exori infir nia',
    mana = 18,
    level = 1,
    cd = 8000,
    range = 1,
    mobs = 1
  }
}

-- ============================================================
-- UTILIDADE DE ATAQUE
-- Inflict Wound nao gera nem gasta Harmony.
-- ============================================================

local utilitySpells = {
  {
    words = 'utori kor',
    mana = 30,
    level = 40,
    cd = 30000,
    range = 1,
    mobs = 1
  }
}

-- ============================================================
-- CAST DE ATAQUE
-- ============================================================

local function canCast(spell, time, p, tp, snapshot)
  if spell.enabled and not spell.enabled() then
    return false
  end

  if distance(p, tp) > spell.range then
    return false
  end

  if countMonsters(snapshot, p, spell.range) < spell.mobs then
    return false
  end

  if mana() < spell.mana then
    return false
  end

  if lvl() < spell.level then
    return false
  end

  if time < (last[spell.words] or 0) then
    return false
  end

  return true
end

local function castAttack(spell, time, spender)
  last[spell.words] = time + spell.cd
  globalNext = time + cfg.attackGap

  say(spell.words)

  if spender then
    harmony = (virtue == 'harmony') and 1 or 0
  else
    harmony = math.min(5, harmony + 1)
  end

  return true
end

local function castUtility(spell, time)
  last[spell.words] = time + spell.cd
  globalNext = time + cfg.attackGap
  say(spell.words)
  return true
end

-- ============================================================
-- ROTACAO
-- ============================================================

rotation = macro(
  100,
  'Monk Rotacao V5',
  function()
    if not g_game.isOnline() or not player then
      return
    end

    if pending then
      return
    end

    if
      virtue ~= 'harmony'
      and virtue ~= 'justice'
      and virtue ~= 'sustain'
    then
      return
    end

    local time = clock()

    if time < globalNext or time < actionNext then
      return
    end

    actionNext = time + cfg.actionGap

    -- Sustain tenta cura antes de qualquer ataque.
    if tryHeal(time) then
      return
    end

    local target = g_game.getAttackingCreature()

    if not target or not target:isMonster() then
      return
    end

    local p = player:getPosition()
    local tp = target:getPosition()

    if not p or not tp or p.z ~= tp.z then
      return
    end

    local snapshot = makeSnapshot(p)

    -- Com Harmony cheio, tenta spender primeiro.
    if harmony >= 5 then
      for _, spell in ipairs(spenders) do
        if canCast(spell, time, p, tp, snapshot) then
          castAttack(spell, time, true)
          return
        end
      end
    end

    -- Depois tenta utilidade que nao gera/gasta Harmony.
    for _, spell in ipairs(utilitySpells) do
      if canCast(spell, time, p, tp, snapshot) then
        castUtility(spell, time)
        return
      end
    end

    -- Depois tenta builders.
    for _, spell in ipairs(builders) do
      if canCast(spell, time, p, tp, snapshot) then
        castAttack(spell, time, false)
        return
      end
    end
  end
)

rotation.setOff()

-- ============================================================
-- ICONE ROTACAO
-- ============================================================

icons.rotation = addIcon(
  'monkAureraRotationV5',
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

local wasOnline = g_game.isOnline()

macro(
  250,
  function()
    local online = g_game.isOnline()

    if not online then
      virtue = 'unknown'
      pending = nil
      harmony = 0
      last = {}
      globalNext = 0
      actionNext = 0
      healingNext = 0

    elseif not wasOnline then
      virtue = 'unknown'
      pending = nil
      harmony = 0
      last = {}
      globalNext = 0
      actionNext = 0
      healingNext = 0
    end

    wasOnline = online

    -- Se o servidor nao confirmar em ate 5s,
    -- volta o visual para estado desconhecido/desativado.
    if
      pending
      and clock() - pendingAt > 5000
    then
      pending = nil
      virtue = 'unknown'
      harmony = 0
    end

    refreshVirtues()
  end
)

-- ============================================================
-- INICIALIZACAO
-- ============================================================

refreshVirtues()


local ignoreNames = {
  ["Grovebeast"] = true,
  ["Skullfrost"] = true,
  ["Omniphant"] = true,
  ["Emberwing"] = true,
  ["Thundergiant"] = true
}

atkAll = macro(100, function()
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
