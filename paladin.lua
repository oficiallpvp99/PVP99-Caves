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

local healingSpells = {
  -- HP máximo para usar / mana mínima recomendada
  {spell = "exura gran san", hp = 65, mana = 20},
  {spell = "exura san",      hp = 82, mana = 12},
  {spell = "exura",          hp = 96, mana = 5}
}

local EMERGENCY_HP = 45

local curaru = macro(250, "Paladin Heal V2", function()
  local hp = hppercent()
  local mana = manapercent()

  -- Emergência: prioriza a cura mais forte
  if hp <= EMERGENCY_HP then
    say("exura gran san")
    return
  end

  -- Cura inteligente por faixa de HP
  for _, heal in ipairs(healingSpells) do
    if hp <= heal.hp and mana >= heal.mana then
      say(heal.spell)
      return
    end
  end
end)

addIcon("CUR", {
  item = 12809,
  text = "real"
}, function(icon, isOn)
  curaru.setOn(isOn)
end)

-- =========================================================
-- CAVE BOT + TARGET BOT ICONS
-- =========================================================

local CAVE_ICON_ITEM   = 16770 -- troque pelo ID do item que quiser
local TARGET_ICON_ITEM = 50158 -- troque pelo ID do item que quiser

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

local countMP = addIcon("HP", {text="HP", item = 23374}, 
function(widget,isOn)
   local id =  23374
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

-- PVP99 - NPC SYSTEM V2 COMPLETO
-- Banco + Viagem + Balsas + Tapetes + Trade + Serviços
-- Base original preservada + NPCs oficiais adicionais do Tibia
-- Detector rápido, alvo estável e sem janela/macro duplicado

local npcGroups = {

  -- BANCO

  Banco = {
    final = "yes",

    npcs = {
      ["Naji"] = {"deposit all"},
      ["Anya"] = {"deposit all"},
      ["Eva"] = {"deposit all"},
      ["Kepar"] = {"deposit all"},

      ["Suzy"] = {"deposit all"},
      ["Paulie"] = {"deposit all"},
      ["Finarfin"] = {"deposit all"},
      ["Atur"] = {"deposit all"},
      ["Sissek"] = {"deposit all"},
      ["Gerib"] = {"deposit all"},
      ["Flavius"] = {"deposit all"},
      ["Adrian"] = {"deposit all"},
      ["Hector the Mentor"] = {"deposit all"},

      -- ADICIONE NOVOS NPCs DE BANCO AQUI
      -- ["Nome NPC"] = {"deposit all"},
    }
  },


  -- VIAGENS

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

      ["Stutchs"] = {"Ab'Dendriel"},


      -- ===== CAPITÃES / ROTAS OFICIAIS ADICIONAIS =====

      ["Anna"] = {
        options = {"passage"},
        final = "yes"
      },

      ["Captain Dreadnought"] = {
        options = {"passage"},
        final = false
      },

      ["Captain Indigo"] = {
        "Thais"
      },

      ["Captain Jack"] = {
        options = {"passage"},
        final = "yes"
      },

      ["Captain Jack Rat"] = {
        options = {"passage"},
        final = false
      },

      ["Captain Kurt"] = {
        options = {"passage"},
        final = false
      },

      ["Captain Tiberius"] = {
        options = {"passage"},
        final = "yes"
      },

      ["Captain Waverider"] = {
        options = {"peg leg"},
        final = "yes"
      },

      ["Dalbrect"] = {
        "Isle of the Kings"
      },

      ["Harlow"] = {
        "Vengoth",
        "Yalahar"
      },

      ["Hawkhurst"] = {
        "Ingol"
      },

      ["Junkar"] = {
        "Kazordoon",
        "Thais",
        "Eyes of the Deep",
        "Underground Isle"
      },

      ["Kendra"] = {
        "Vigintia",
        "Thais"
      },

      ["Maris"] = {
        "Yalahar",
        "Fenrock",
        "Mistrock"
      },

      ["Sebastian"] = {
        "Liberty Bay",
        "Nargor"
      },

      ["Urks The Mute"] = {
        "Cormaya"
      },

      ["Zurak"] = {
        "Chazorai"
      },

      -- ===== BALSAS =====

      ["Buddel"] = {
        "Tyrsung",
        "Okolnir",
        "Svargrond",
        "Raider Camp",
        "Helheim"
      },

      ["Anderson"] = {
        "Carlin",
        "Senja"
      },

      ["Carlson"] = {
        "Carlin",
        "Vega"
      },

      ["Cornell"] = {
        "Edron",
        "Grimvale"
      },

      ["Ferryman Kamil"] = {
        "Fibula",
        "Meluna"
      },

      ["Nielson"] = {
        options = {"passage"},
        final = false
      },

      ["Rascalio"] = {
        "Banor's Eye",
        "Fryclops Island",
        "Meriana",
        "Reokon's Tundra"
      },

      ["Svenson"] = {
        "Carlin",
        "Folda"
      },

      ["Tarak"] = {
        "Yalahar",
        "Monument Tower"
      },

      -- ===== TAPETE MÁGICO / TRANSPORTE AÉREO =====

      ["Ziyad"] = {
        "Darashia",
        "Edron",
        "Farmine",
        "Femor Hills",
        "Issavi",
        "Kazordoon",
        "Svargrond"
      },

      -- ADICIONE NOVOS NPCs DE VIAGEM AQUI
      -- ["Novo Captain"] = {"Thais", "Carlin", "Venore"},
    }
  },


  -- TRADE

  Servicos = {
    final = "yes",
    npcs = {
      ["King Tibianus"] = {
        options = {"promotion"},
        hello = "hail king"
      }
    }
  },

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

      -- COMERCIANTES ADICIONAIS (hi -> trade)
      ["Alexander"] = {options = {"trade"}, final = false},
      ["Asima"] = {options = {"trade"}, final = false},
      ["Sandra"] = {options = {"trade"}, final = false},
      ["Tandros"] = {options = {"trade"}, final = false},
      ["Lily"] = {options = {"trade"}, final = false},
      ["Nelly"] = {options = {"trade"}, final = false},
      ["Faloriel"] = {options = {"trade"}, final = false},
      ["Ghorza"] = {options = {"trade"}, final = false},
      ["Nipuna"] = {options = {"trade"}, final = false},
      ["Sundara"] = {options = {"trade"}, final = false},
      ["Rock In A Hard Place"] = {options = {"trade"}, final = false},
      ["Uzgod"] = {options = {"trade"}, final = false},
      ["Shanar"] = {options = {"trade"}, final = false},
      ["Morpel"] = {options = {"trade"}, final = false},
      ["H.L."] = {options = {"trade"}, final = false},
      ["Gamel"] = {options = {"trade"}, final = false},
      ["Ulrik"] = {options = {"trade"}, final = false},
      ["Flint"] = {options = {"trade"}, final = false},
      ["Cedrik"] = {options = {"trade"}, final = false},
      ["Dario"] = {options = {"trade"}, final = false},
      ["Silas"] = {options = {"trade"}, final = false},
      ["Vincent"] = {options = {"trade"}, final = false},
      ["Willard"] = {options = {"trade"}, final = false},
      ["Xed"] = {options = {"trade"}, final = false},
      ["Aurelia"] = {options = {"trade"}, final = false},
      ["Bertha"] = {options = {"trade"}, final = false},
      ["Gnomally"] = {options = {"trade"}, final = false},
      ["Timur"] = {options = {"trade"}, final = false},
      ["Valentina"] = {options = {"trade"}, final = false},
      ["Wes The Blacksmith"] = {options = {"trade"}, final = false},
      ["Zora"] = {options = {"trade"}, final = false},
      ["Black Bert"] = {options = {"trade"}, final = false},
      ["Azil"] = {options = {"trade"}, final = false},
      ["Rudolph"] = {options = {"trade"}, final = false},
      ["Eliyas"] = {options = {"trade"}, final = false},
      ["The Librarian"] = {options = {"trade"}, final = false},
      ["Yonan"] = {options = {"trade"}, final = false},
      ["Inkaef"] = {options = {"trade"}, final = false},
      ["Avriel"] = {options = {"trade"}, final = false},

      -- ADICIONE NOVOS NPCs DE TRADE AQUI
      -- ["Novo NPC"] = {"buy/sell"},
    }
  }
}

local NPC_DISTANCE = 2
local DETECT_DELAY = 50
local DELAY_OPTION = 200
local DELAY_FINAL = 500
local DELAY_RESET = 800

-- Índice único dos NPCs
local npcIndex = {}

for categoryName, category in pairs(npcGroups) do
  for npcName, npcData in pairs(category.npcs) do
    local options = npcData
    local finalCommand = category.final
    local hello = "hi"

    if npcData.options then
      options = npcData.options

      if npcData.final ~= nil then
        finalCommand = npcData.final
      end

      if npcData.hello then
        hello = npcData.hello
      end
    end

    if type(options) ~= "table" then
      options = {tostring(options)}
    end

    npcIndex[npcName] = {
      category = categoryName,
      options = options,
      final = finalCommand,
      hello = hello
    }
  end
end

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

local rootWidget = g_ui.getRootWidget()

if rootWidget then
  local oldWindow = rootWidget:recursiveGetChildById("pvp99NpcWindow")
  if oldWindow then
    oldWindow:destroy()
  end

  local npcWindow = UI.createWindow("Pvp99NpcWindow", rootWidget)
  local combo = npcWindow:recursiveGetChildById("travelOptions")
  local npcLabel = npcWindow:recursiveGetChildById("npcName")

  local currentNpc
  local updatingOptions = false
  local busy = false

  npcWindow:hide()

  local function npcSay(text)
    if not text then return end

    if g_game.getClientVersion() >= 810 then
      g_game.talkChannel(11, 0, text)
    else
      say(text)
    end
  end

  local function npcIsNear(npcName)
    local creature = npcName and getCreatureByName(npcName)
    return creature
      and getDistanceBetween(pos(), creature:getPosition()) <= NPC_DISTANCE
  end

  local function findNearbyNpc()
    local playerPos = pos()
    local bestName
    local bestDistance

    for npcName in pairs(npcIndex) do
      local creature = getCreatureByName(npcName)

      if creature then
        local distance = getDistanceBetween(playerPos, creature:getPosition())

        if distance <= NPC_DISTANCE
          and (not bestDistance or distance < bestDistance) then
          bestName = npcName
          bestDistance = distance
        end
      end
    end

    return bestName
  end

  local function updateNpcOptions(npcName)
    local data = npcIndex[npcName]
    if not data then return end

    updatingOptions = true
    combo:clearOptions()
    combo:addOption(data.category)

    for _, option in ipairs(data.options) do
      combo:addOption(option)
    end

    npcLabel:setText(npcName)
    updatingOptions = false
  end

  local function actionStillValid(npcName)
    return currentNpc == npcName and npcIsNear(npcName)
  end

  macro(DETECT_DELAY, "PVP99 NPC", function()
    -- Enquanto o mesmo NPC continuar perto, evita varrer a lista inteira.
    local npcName =
      currentNpc and npcIsNear(currentNpc)
      and currentNpc
      or findNearbyNpc()

    if not npcName then
      currentNpc = nil
      busy = false

      if npcWindow:isVisible() then
        npcWindow:hide()
      end

      return
    end

    if currentNpc ~= npcName then
      currentNpc = npcName
      busy = false
      updateNpcOptions(npcName)
    end

    if not npcWindow:isVisible() then
      npcWindow:show()
    end
  end)

  combo.onOptionChange = function(widget, option, data)
    if updatingOptions or busy or not currentNpc then
      return
    end

    local actionNpc = currentNpc
    local actionData = npcIndex[actionNpc]

    if not actionData
      or option == actionData.category
      or not npcIsNear(actionNpc) then
      return
    end

    busy = true
    say(actionData.hello or "hi")

    schedule(DELAY_OPTION, function()
      if actionStillValid(actionNpc) then
        npcSay(option)
      end
    end)

    schedule(DELAY_FINAL, function()
      if actionStillValid(actionNpc) and actionData.final then
        npcSay(actionData.final)
      end
    end)

    schedule(DELAY_RESET, function()
      busy = false

      if actionStillValid(actionNpc) then
        updateNpcOptions(actionNpc)
      end
    end)
  end
end


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
