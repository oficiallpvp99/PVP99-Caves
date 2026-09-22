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

local healingSpells = {
  {spell = 'exura gran san', threshold = 65},  -- Cura mais forte quando HP for 70% ou menos
  {spell = 'Exura san', threshold = 80},  -- Cura intermediária quando HP for 90% ou menos
  {spell = 'Exura', threshold = 90}        -- Cura básica quando HP for 99% ou menos
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


addIcon("CUR", {item=12809, text="exura",}, function(icon, isOn) 
  curaru.setOn(isOn) 
end)

Pally_PvP= macro(500, function()
  if g_game.isAttacking() then
   say("exori gran con")   
   say("exori con")   
  end
end)

addIcon("(RP) PvP", {item=34089, text="exori con"}, function(icon, isOn)
Pally_PvP.setOn(isOn)
end)

local pvp = false
local comboDelay = 500

local Spells = {
    {name = "exevo mas san", cast = true, manaCost = 40, level = 90},
    {name = "exori con", cast = true, manaCost = 115, level = 35},
    {name = "exori gran con", cast = true, manaCost = 200, level = 70},
}

local nextCombo = 0

local function getSpell(name)
    for _, spell in ipairs(Spells) do
        if spell.name == name then
            return spell
        end
    end
    return nil
end

local function canCastSpell(spell)
    if not spell then
        return false
    end

    if not spell.cast then
        return false
    end

    if mana() < spell.manaCost then
        return false
    end

    if lvl() < spell.level then
        return false
    end

    return true
end

exori = macro(250, function()

    if now < nextCombo then
        return
    end

    if not g_game.isAttacking() then
        return
    end

    local target = g_game.getAttackingCreature()

    if not target then
        return
    end

    local isSafe = true
    local direct
    local specAmount = 0

    local whitelistMonsters = {
        "Emberwing",
        "Skullfrost",
        "Groovebeast",
        "Thundergiant"
    }

    ----------------------------------------------------------------
    -- DIREÇÃO DO ALVO
    ----------------------------------------------------------------

    if player:getPosition().z == target:getPosition().z then

        if player:getPosition().x > target:getPosition().x then
            direct = 3 -- west

        elseif player:getPosition().x < target:getPosition().x then
            direct = 1 -- east

        elseif player:getPosition().y > target:getPosition().y then
            direct = 0 -- north

        elseif player:getPosition().y < target:getPosition().y then
            direct = 2 -- south
        end
    end

    ----------------------------------------------------------------
    -- CONTA OS MONSTROS
    ----------------------------------------------------------------

    for i, mob in ipairs(getSpectators()) do

        if mob:isMonster() and
           getDistanceBetween(player:getPosition(), mob:getPosition()) <= 1 then

            if not table.find(whitelistMonsters, mob:getName()) then
                specAmount = specAmount + 1
            end
        end

        if mob:isPlayer() and player:getName() ~= mob:getName() then
            isSafe = false
        end
    end

    ----------------------------------------------------------------
    -- PRECISA TER PELO MENOS 1 MONSTRO
    ----------------------------------------------------------------

    if specAmount < 1 then
        return
    end

    ----------------------------------------------------------------
    -- PVP SAFE
    ----------------------------------------------------------------

    if pvp and not isSafe then
        return
    end

    ----------------------------------------------------------------
    -- PRIMEIRA MAGIA SEMPRE EXORI CON
    ----------------------------------------------------------------

    local firstSpell = getSpell("exori con")

    if not canCastSpell(firstSpell) then
        return
    end

    say(firstSpell.name)

    ----------------------------------------------------------------
    -- 1 OU 2 MONSTROS
    --
    -- EXORI CON
    --     ↓ 500ms
    -- EXORI GRAN CON
    ----------------------------------------------------------------

    if specAmount <= 2 then

        nextCombo = now + comboDelay + 250

        schedule(comboDelay, function()

            if not g_game.isAttacking() then
                return
            end

            local spell = getSpell("exori gran con")

            if canCastSpell(spell) then
                say(spell.name)
            end

        end)

    ----------------------------------------------------------------
    -- 3 OU MAIS MONSTROS
    --
    -- EXORI CON
    --     ↓ 500ms
    -- EXEVO MAS SAN
    ----------------------------------------------------------------

    else

        nextCombo = now + comboDelay + 250

        schedule(comboDelay, function()

            if not g_game.isAttacking() then
                return
            end

            local spell = getSpell("exevo mas san")

            if canCastSpell(spell) then
                say(spell.name)
            end

        end)
    end

end)

exori = addIcon("exori", { item =34079, text = "mas san"}, exori)

local SpellTab = addTab("Target")
local name = UI.Label("RUNAS")

macro(800, function()
  local rainbowDelay = 0
  for k, color in ipairs({"#ffffff", "#f2f2f2", "#e6e6e6", "#d9d9d9", "#cccccc", "#bfbfbf"}) do
    schedule(rainbowDelay, function()
      name:setColor(color)
    end)
    rainbowDelay = rainbowDelay + 100 -- tempo entre elas
  end
end)

-- ============================================================
-- PALADIN AURERA / TELARIA - V5
-- SHARPSHOOTER + DIVINE DEFIANCE + ROTACAO COMPLETA
--
-- ATAQUE = utori con
-- DEFESA = utori hur
--
-- Padrao V5:
-- * sem PNG externo
-- * icones nativos do .dat/.spr do cliente
-- * texto fixo nos botoes
-- * verde/vermelho instantaneo ao clicar
-- * mensagem do servidor sincroniza o estado depois
-- * rotacao circular para nao prender sempre na primeira magia
-- * Divine Barrage + Ethereal Barrage preservadas
-- * cura com Salvation + Divine Healing fallback
-- * sem bloqueio por player proximo
-- * rotacao inicia desligada
-- ============================================================

setDefaultTab('MAIN')

storage.paladinAureraV5 = storage.paladinAureraV5 or {}
local cfg = storage.paladinAureraV5

local function default(k, v)
  if cfg[k] == nil then
    cfg[k] = v
  end
end

default('attackGap', 2100)
default('actionGap', 300)

-- Cura:
-- DEFESA: Salvation em <= 70%
-- ATAQUE: emergencia em <= 45%
default('defenseHealAt', 70)
default('attackHealAt', 45)
default('salvationOn', true)
default('divineHealingOn', true)

-- Magias opcionais
default('etherealBarrageOn', true)
default('divineBarrageOn', true)
default('divineCalderaOn', true)
default('divineGrenadeOn', true)
default('strongSpearOn', true)
default('etherealSpearOn', true)
default('divineMissileOn', true)

-- ============================================================
-- ICONES NATIVOS DO SERVIDOR / CLIENTE
--
-- Nao usa PNG.
-- O addIcon usa os sprites existentes no .dat/.spr do OTClient.
-- ============================================================

local SERVER_ICONS = {
  -- Soulbleeder
  attack = 34088,

  -- Soulbastion
  defense = 34099,

  -- Icone escolhido para a rotacao
  rotation = 47377
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

local stance = 'unknown'
local pending = nil
local pendingAt = 0

local icons = {}
local rotation = nil

-- Indices da rotacao circular.
local attackIndex = 1
local defenseIndex = 1

-- ============================================================
-- UI
-- ============================================================

local function label(icon, text, color)
  if icon and icon.text then
    icon.text:setText(text)
    icon.text:setColor(color)
  end
end

local function refreshStances()
  label(
    icons.attack,
    'utori con',
    stance == 'attack' and '#55ff55' or '#ff5555'
  )

  label(
    icons.defense,
    'utori hur',
    stance == 'defense' and '#55ff55' or '#ff5555'
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
-- TROCA / DESATIVA STANCE
--
-- Clicou:
-- ativa = verde na hora
-- desativa = vermelho na hora
--
-- Depois a mensagem do servidor confirma/corrige.
-- ============================================================

local function chooseStance(wanted, words)
  if not g_game.isOnline() then
    return
  end

  if pending then
    return
  end

  local togglingOff = (stance == wanted)

  pending = togglingOff and 'off' or wanted
  pendingAt = clock()

  if togglingOff then
    stance = 'unknown'
  else
    stance = wanted
  end

  refreshStances()

  globalNext = math.max(
    globalNext,
    clock() + cfg.actionGap
  )

  say(words)
end

-- ============================================================
-- ICONES DAS STANCES
-- ============================================================

icons.attack = addIcon(
  'paladinAureraAttackV5',
  {
    item = { id = SERVER_ICONS.attack, count = 1 },
    text = 'utori con',
    switchable = false,
    moveable = true
  },
  function()
    chooseStance('attack', 'utori con')
  end
)

icons.attack:setSize({
  width = 64,
  height = 64
})

icons.defense = addIcon(
  'paladinAureraDefenseV5',
  {
    item = { id = SERVER_ICONS.defense, count = 1 },
    text = 'utori hur',
    switchable = false,
    moveable = true
  },
  function()
    chooseStance('defense', 'utori hur')
  end
)

icons.defense:setSize({
  width = 64,
  height = 64
})

-- ============================================================
-- CONFIRMACAO PELO SERVIDOR
--
-- Filtro tolerante para diferentes mensagens do OTServer:
-- Sharpshooter / Sniper = ataque
-- Divine Defiance       = defesa
-- ============================================================

onTextMessage(function(mode, text)
  local msg = (text or ''):lower()

  local deactivated =
    msg:find('deactivated', 1, true)
    or msg:find('deactivate', 1, true)
    or msg:find('disabled', 1, true)

  local activated =
    msg:find('activated', 1, true)
    or msg:find('activate', 1, true)
    or msg:find('enabled', 1, true)

  local isAttack =
    msg:find('sharpshooter', 1, true)
    or msg:find('sniper', 1, true)

  local isDefense =
    msg:find('divine defiance', 1, true)

  if deactivated and (isAttack or isDefense) then
    stance = 'unknown'
    pending = nil

  elseif activated and isAttack then
    stance = 'attack'
    pending = nil

  elseif activated and isDefense then
    stance = 'defense'
    pending = nil

  else
    return
  end

  refreshStances()
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

-- Familiares ignorados no contador.
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
-- CURA
-- ============================================================

local salvation = {
  words = 'exura gran san',
  mana = 210,
  level = 60,
  cd = 1000
}

local divineHealing = {
  words = 'exura san',
  mana = 160,
  level = 35,
  cd = 1000
}

local function tryHealing(time)
  local limit

  if stance == 'defense' then
    limit = cfg.defenseHealAt
  elseif stance == 'attack' then
    limit = cfg.attackHealAt
  else
    return false
  end

  if hppercent() > limit then
    return false
  end

  if time < healingNext then
    return false
  end

  -- Prioridade 1: Salvation
  if
    cfg.salvationOn
    and lvl() >= salvation.level
    and mana() >= salvation.mana
    and time >= (last[salvation.words] or 0)
  then
    last[salvation.words] = time + salvation.cd
    healingNext = time + 1000
    globalNext = time + cfg.actionGap
    say(salvation.words)
    return true
  end

  -- Prioridade 2: Divine Healing
  if
    cfg.divineHealingOn
    and lvl() >= divineHealing.level
    and mana() >= divineHealing.mana
    and time >= (last[divineHealing.words] or 0)
  then
    last[divineHealing.words] = time + divineHealing.cd
    healingNext = time + 1000
    globalNext = time + cfg.actionGap
    say(divineHealing.words)
    return true
  end

  return false
end

-- ============================================================
-- ROTACAO ATAQUE
--
-- Circular:
-- depois de conjurar uma magia, continua da proxima.
-- Isso evita ficar sempre presa na primeira magia disponivel.
-- ============================================================

local attackSpells = {
  {
    name = 'Ethereal Barrage',
    words = 'exori dir moe',
    mana = 135,
    level = 60,
    range = 7,
    mobs = 1,
    cd = 4000,
    area = true,
    enabled = function()
      return cfg.etherealBarrageOn
    end
  },

  {
    name = 'Strong Ethereal Spear',
    words = 'exori gran con',
    mana = 55,
    level = 90,
    range = 5,
    mobs = 1,
    cd = 8000,
    enabled = function()
      return cfg.strongSpearOn
    end
  },

  {
    name = 'Divine Barrage',
    words = 'exori dir san',
    mana = 175,
    level = 70,
    range = 7,
    mobs = 1,
    cd = 4000,
    area = true,
    enabled = function()
      return cfg.divineBarrageOn
    end
  },

  {
    name = 'Ethereal Spear',
    words = 'exori con',
    mana = 25,
    level = 23,
    range = 5,
    mobs = 1,
    cd = 2000,
    enabled = function()
      return cfg.etherealSpearOn
    end
  },

  {
    name = 'Divine Missile',
    words = 'exori san',
    mana = 20,
    level = 40,
    range = 5,
    mobs = 1,
    cd = 3000,
    enabled = function()
      return cfg.divineMissileOn
    end
  }
}

-- ============================================================
-- ROTACAO DEFESA
--
-- Mantida a versao que voce aprovou:
-- Divine Caldera com mobs = 1.
-- ============================================================

local defenseSpells = {
  {
    name = 'Divine Barrage',
    words = 'exori dir san',
    mana = 175,
    level = 70,
    range = 7,
    mobs = 1,
    cd = 4000,
    area = true,
    enabled = function()
      return cfg.divineBarrageOn
    end
  },

  {
    name = 'Divine Caldera',
    words = 'exevo mas san',
    mana = 160,
    level = 50,
    range = 3,
    mobs = 1,
    cd = 4000,
    area = true,
    enabled = function()
      return cfg.divineCalderaOn
    end
  },

  {
    name = 'Divine Grenade',
    words = 'exevo tempo mas san',
    mana = 160,
    level = 1,
    range = 7,
    mobs = 1,
    cd = 26000,
    area = true,
    enabled = function()
      return cfg.divineGrenadeOn
    end
  },

  {
    name = 'Ethereal Barrage',
    words = 'exori dir moe',
    mana = 135,
    level = 60,
    range = 7,
    mobs = 1,
    cd = 4000,
    area = true,
    enabled = function()
      return cfg.etherealBarrageOn
    end
  },

  {
    name = 'Divine Missile',
    words = 'exori san',
    mana = 20,
    level = 40,
    range = 5,
    mobs = 1,
    cd = 3000,
    enabled = function()
      return cfg.divineMissileOn
    end
  },

  {
    name = 'Strong Ethereal Spear',
    words = 'exori gran con',
    mana = 55,
    level = 90,
    range = 5,
    mobs = 1,
    cd = 8000,
    enabled = function()
      return cfg.strongSpearOn
    end
  },

  {
    name = 'Ethereal Spear',
    words = 'exori con',
    mana = 25,
    level = 23,
    range = 5,
    mobs = 1,
    cd = 2000,
    enabled = function()
      return cfg.etherealSpearOn
    end
  }
}

-- ============================================================
-- VALIDACAO / CAST
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

local function castSpell(spell, time)
  last[spell.words] = time + spell.cd
  globalNext = time + cfg.attackGap

  say(spell.words)
  return true
end

-- ============================================================
-- ROTACAO CIRCULAR
-- ============================================================

local function tryCircular(list, startIndex, time, p, tp, snapshot)
  local total = #list

  if total == 0 then
    return false, 1
  end

  if startIndex < 1 or startIndex > total then
    startIndex = 1
  end

  for offset = 0, total - 1 do
    local index = ((startIndex - 1 + offset) % total) + 1
    local spell = list[index]

    if canCast(spell, time, p, tp, snapshot) then
      castSpell(spell, time)

      local nextIndex = index + 1
      if nextIndex > total then
        nextIndex = 1
      end

      return true, nextIndex
    end
  end

  return false, startIndex
end

-- ============================================================
-- MACRO PRINCIPAL
-- ============================================================

rotation = macro(
  100,
  'Paladin Rotacao V5',
  function()
    if not g_game.isOnline() or not player then
      return
    end

    if pending then
      return
    end

    if stance ~= 'attack' and stance ~= 'defense' then
      return
    end

    local time = clock()

    if time < globalNext or time < actionNext then
      return
    end

    actionNext = time + cfg.actionGap

    -- Cura antes do ataque conforme a stance.
    if tryHealing(time) then
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

    if stance == 'attack' then
      local casted
      casted, attackIndex = tryCircular(
        attackSpells,
        attackIndex,
        time,
        p,
        tp,
        snapshot
      )

      if casted then
        return
      end

    elseif stance == 'defense' then
      local casted
      casted, defenseIndex = tryCircular(
        defenseSpells,
        defenseIndex,
        time,
        p,
        tp,
        snapshot
      )

      if casted then
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
  'paladinAureraRotationV5',
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
      stance = 'unknown'
      pending = nil

      attackIndex = 1
      defenseIndex = 1

      last = {}
      globalNext = 0
      actionNext = 0
      healingNext = 0

    elseif not wasOnline then
      stance = 'unknown'
      pending = nil

      attackIndex = 1
      defenseIndex = 1

      last = {}
      globalNext = 0
      actionNext = 0
      healingNext = 0
    end

    wasOnline = online

    -- Se o servidor nao confirmar em ate 5 segundos,
    -- volta o visual para desativado.
    if
      pending
      and clock() - pendingAt > 5000
    then
      pending = nil
      stance = 'unknown'
    end

    refreshStances()
  end
)

-- ============================================================
-- INICIALIZACAO
-- ============================================================

refreshStances()


