local version = "4.8"
local currentVersion
local available = false

storage.checkVersion = storage.checkVersion or 0

-- check max once per 12hours
if os.time() > storage.checkVersion + (12 * 60 * 60) then

    storage.checkVersion = os.time()
end

UI.Label("Instagram \n @oficialpvp99")
UI.Button("Official Site PVP99!", function() g_platform.openUrl("https://www.pvp99.com.br/") end)
UI.Separator()

schedule(5000, function()

    if not available then return end
    if currentVersion ~= version then
        
        UI.Separator()
        UI.Label("New vBot is available for download! v"..currentVersion)
        UI.Button("Buy Script", function() g_platform.openUrl("https://www.pvp99.com.br/") end)
        UI.Separator()
        
    end

end)

setDefaultTab("MAIN")

local name = UI.Label(">>Book World Knight 150+ Profissional<<")

macro(800, function()
  local rainbowDelay = 0 

  for k, color in ipairs({"#990af2", "#9200b3", "#0077b3", "#005c99", "#5e0080", "#e80036"}) do
    schedule(rainbowDelay, function()
      name:setColor(color) 
    end)

    rainbowDelay = rainbowDelay + 100
  end
end, SpellsTab)

UI.Separator()

local name = UI.Label(">>CURAS<<")

macro(800, function()
  local rainbowDelay = 0 

  for k, color in ipairs({"#990af2", "#9200b3", "#0077b3", "#005c99", "#5e0080", "#e80036"}) do
    schedule(rainbowDelay, function()
      name:setColor(color) 
    end)

    rainbowDelay = rainbowDelay + 100
  end
end, SpellsTab)

if type(storage.healing1) ~= "table" then
  storage.healing1 = {on=false, title="HP%", text="exura ico", min=51, max=90}
end
if type(storage.healing2) ~= "table" then
  storage.healing2 = {on=false, title="HP%", text="exura ico", min=0, max=50}
end
if type(storage.healing3) ~= "table" then
  storage.healing3 = {on=false, title="HP%", text="exura med ico", min=0, max=50}
end

-- create 3 healing widgets
for _, healingInfo in ipairs({storage.healing1, storage.healing2, storage.healing3}) do
  local healingmacro = macro(250, function()
    local hp = player:getHealthPercent()
    if healingInfo.max >= hp and hp >= healingInfo.min then
      if TargetBot then 
        TargetBot.saySpell(healingInfo.text) -- sync spell with targetbot if available
      else
        say(healingInfo.text)
      end
    end
  end)
  healingmacro.setOn(healingInfo.on)

  UI.DualScrollPanel(healingInfo, function(widget, newParams) 
    healingInfo = newParams
    healingmacro.setOn(healingInfo.on)
  end)
end

UI.Separator()

local name = UI.Label(">>POTIONS<<")

macro(800, function()
  local rainbowDelay = 0 

  for k, color in ipairs({"#990af2", "#9200b3", "#0077b3", "#005c99", "#5e0080", "#e80036"}) do
    schedule(rainbowDelay, function()
      name:setColor(color) 
    end)

    rainbowDelay = rainbowDelay + 100
  end
end, SpellsTab)

if type(storage.hpitem1) ~= "table" then
  storage.hpitem1 = {on=false, title="HP%", item=266, min=51, max=90}
end
if type(storage.hpitem2) ~= "table" then
  storage.hpitem2 = {on=false, title="HP%", item=3160, min=0, max=50}
end
if type(storage.manaitem1) ~= "table" then
  storage.manaitem1 = {on=false, title="MP%", item=268, min=51, max=90}
end
if type(storage.manaitem2) ~= "table" then
  storage.manaitem2 = {on=false, title="MP%", item=3157, min=0, max=50}
end

-- Tabela local para armazenar último uso de cada potion (evita spam)
local lastUsed = {}

for i, healingInfo in ipairs({storage.hpitem1, storage.hpitem2, storage.manaitem1, storage.manaitem2}) do
  local healingmacro = macro(250, function()
    local now = now or g_clock.millis() -- tempo atual
    local key = healingInfo.item .. "-" .. i

    -- Obter valor atual de HP ou MP
    local hp = i <= 2 and player:getHealthPercent() or math.min(100, math.floor(100 * (player:getMana() / player:getMaxMana())))

    -- Verifica se deve usar potion E se passou pelo menos 800ms desde o último uso
    if healingInfo.max >= hp and hp >= healingInfo.min and (not lastUsed[key] or now - lastUsed[key] >= 250) then
      lastUsed[key] = now  -- Atualiza último uso
      
      if TargetBot then 
        TargetBot.useItem(healingInfo.item, healingInfo.subType, player)
      else
        local thing = g_things.getThingType(healingInfo.item)
        local subType = g_game.getClientVersion() >= 1100 and 0 or 1
        if thing and thing:isFluidContainer() then
          subType = healingInfo.subType
        end
        g_game.useInventoryItemWith(healingInfo.item, player, subType)
      end
    end
  end)

  healingmacro.setOn(healingInfo.on)

  UI.DualScrollItemPanel(healingInfo, function(widget, newParams) 
    healingInfo = newParams
    healingmacro.setOn(healingInfo.on and healingInfo.item > 100)
  end)
end


local colorTable = {
  ["Lion Hydra"] = "yellow",
  ["Bluebeak"] = "yellow",
  ["Headwalker"] = "white",
  ["Arachnophobica"] = "white",
  ["Crusader"] = "yellow",
  ["Hawk Hopper"] = "yellow",
  ["Bramble Wyrmling"] = "yellow",
  ["Crazed Winter Vanguard"] = "blue",
  ["Carniphila"] = "red",
  ["Snake "] = "red",
  ["Wasp"] = "red",
  ["Tarantula"] = "red",
  ["Bug"] = "red",
  ["Tiger"] = "red",
  ["Spider"] = "red",
  ["Cobra"] = "red",
  ["Bat"] = "red",
  ["Fire Elemental"] = "red",
  ["Massive Fire Elemental "] = "red",
  ["Medusa"] = "white",
}
local monstercolor = macro(10000, function() end)
onCreatureAppear(function(creature)
  if monstercolor:isOff() then creature:setInformationColor('#00cc00') return end
  if creature:isMonster() or creature:isPlayer() then
    local name = creature:getName()
    local color = colorTable[name]

    if color then
      creature:setInformationColor(color)
    end
  end
end)

--só precisa alterar a mensagem dentro da caixinha de texto no jogo, não precisa mudar nada no script pra customizar, quando o botão tiver verde ele vai responder automaticamente o que vc escrever lá
local afkMsg = false
addSwitch("afkMsg", "responder auto", function(widget)
    afkMsg = not afkMsg
    widget:setOn(afkMsg)
end)

onTalk(function(name, level, mode, text, channelId, pos) --quando receber uma pm vai responder com a mensagem escolhida abaixo
    if mode == 4 and afkMsg == true then
        g_game.talkPrivate(5, name, storage.afkMsg)
        delay(5000)
    end
end)
UI.TextEdit(storage.afkMsg or "Script by pvp99", function(widget, newText) -- campo de texto pra alterar a mensagem que vai ser a resposta (mude somente o texto)
storage.afkMsg = newText
end)

-- CUSTOM MESSAGE ALERT (onTalk & onTextMessage)

-- START CONFIG
local macroName = "msg alerta"
local flashClient = true
local clientWindowText = "Custom Message"
local soundStyle = "/sounds/Private_Message.ogg"
-- END CONFIG

storage.customMessageAlert = storage.customMessageAlert or "Insert Text Here"

local lastCall = now
local function alarm()
  if lastCall > now then return end
  if modules.game_bot.g_app.getOs() == "windows" and flashClient then g_window.flash() end
  g_window.setTitle(player:getName() .. " - " .. clientWindowText)
  playSound(soundStyle)
  lastCall = now + 6000 -- alarm.ogg length is 6s
end

local customAlert = macro(5*60*1000,macroName,function() end)

UI.TextEdit(storage.customMessageAlert, function(widget, newText)
  storage.customMessageAlert = newText
end)

onTextMessage(function(mode, text)
  if not customAlert:isOn() then return true end
  text = text:lower()
  if not text:find(storage.customMessageAlert:lower()) then return true end
  print("Global onTextMessage Mode: "..mode.." Text: "..text)
  alarm()
end)

onTalk(function(name, level, mode, text, channelId, pos)
  if not customAlert:isOn() then return true end
  text = text:lower()
  if not text:find(storage.customMessageAlert:lower()) then return true end
  local posText = pos and " Pos: "..pos.x.." "..pos.y.." "..pos.x or ""
  print("Global onTalk - Name: "..name.." Level: "..level.." Mode: "..mode.." Text: "..text.." ChannelId: "..channelId..posText)
  alarm()
end)

UI.Separator()

UI.Label("Stack")

local STACK_DELAY = 100 -- velocidade do macro
local MAX_STACK = 100

macro(STACK_DELAY, "Stack items", function()

  local containers = g_game.getContainers()
  local stacks = {}

  -- 1. Mapeia todos os itens stackáveis
  for _, container in pairs(containers) do

    -- Ignora loot containers de monstros
    if not container.lootContainer then

      local items = container:getItems()

      for slot, item in ipairs(items) do

        if item:isStackable() and item:getCount() < MAX_STACK then

          local id = item:getId()

          if not stacks[id] then
            stacks[id] = {}
          end

          table.insert(stacks[id], {
            item = item,
            count = item:getCount(),
            position = container:getSlotPosition(slot - 1)
          })

        end
      end
    end
  end

  -- 2. Procura itens iguais que podem ser unidos
  for id, itemList in pairs(stacks) do

    if #itemList >= 2 then

      -- Deixa as pilhas mais cheias primeiro
      table.sort(itemList, function(a, b)
        return a.count > b.count
      end)

      -- Destino = pilha mais cheia
      local destination = itemList[1]

      -- Procura uma pilha para completar o destino
      for i = 2, #itemList do

        local source = itemList[i]

        if destination.count < MAX_STACK and source.count > 0 then

          local missing = MAX_STACK - destination.count
          local amount = math.min(missing, source.count)

          if amount > 0 then
            g_game.move(
              source.item,
              destination.position,
              amount
            )

            return
          end
        end
      end
    end
  end
end)

local ms = 0 -- Garante que a variável existe antes do primeiro uso

local qw = modules.game_bot.contentsPanel.config
macro(500, function()
qw:setText("Book-EK")
qw:setColor("white")
qw:setFont("verdana-11px-rounded")
schedule(600, function()
  qw:setColor("red")
end)
schedule(800, function()
  qw:setColor("yellow")
end)
schedule(1200, function()
  qw:setColor("orange")
end)
schedule(1400, function()
  qw:setColor("#00FFFF")
end)
end)

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

-- =========================================================
-- CAVE BOT + TARGET BOT ICONS
-- =========================================================

local CAVE_ICON_ITEM   = 16770 -- troque pelo ID do item que quiser
local TARGET_ICON_ITEM = 47375 -- troque pelo ID do item que quiser

-- =========================================================
-- CAVE BOT
-- =========================================================

local cIcon = addIcon("cI", {
  item = CAVE_ICON_ITEM,
  text = "CAVE",
  switchable = false,
  moveable = true
}, function()

  if CaveBot.isOff() then
    CaveBot.setOn()
  else
    CaveBot.setOff()
  end

end)

cIcon:setSize({
  height = 50,
  width = 60
})

cIcon.text:setFont("verdana-11px-rounded")


-- =========================================================
-- TARGET BOT
-- =========================================================

local tIcon = addIcon("tI", {
  item = TARGET_ICON_ITEM,
  text = "TARGET",
  switchable = false,
  moveable = true
}, function()

  if TargetBot.isOff() then
    TargetBot.setOn()
  else
    TargetBot.setOff()
  end

end)

tIcon:setSize({
  height = 50,
  width = 60
})

tIcon.text:setFont("verdana-11px-rounded")


-- =========================================================
-- ATUALIZAÇÃO VISUAL
-- =========================================================

macro(100, function()

  -- CAVE BOT
  if CaveBot.isOn() then

    cIcon.text:setColoredText({
      "cave\n", "yellow",
      "on", "green"
    })

  else

    cIcon.text:setColoredText({
      "cave\n", "yellow",
      "off", "red"
    })

  end


  -- TARGET BOT
  if TargetBot.isOn() then

    tIcon.text:setColoredText({
      "target\n", "yellow",
      "on", "green"
    })

  else

    tIcon.text:setColoredText({
      "target\n", "yellow",
      "off", "red"
    })

  end

end)

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




