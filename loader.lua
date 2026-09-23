-- ============================================================
-- PVP99 - SELETOR DE VOCACAO MEDIEVAL
-- ============================================================

local BASE_URL =
  "https://raw.githubusercontent.com/oficiallpvp99/PVP99-Caves/refs/heads/main/"

local VOCATIONS = {
  knight = {
    name = "KNIGHT",
    desc = "Tanque",
    file = "knight.lua",
    image = BASE_URL .. "knight.png"
  },

  monk = {
    name = "MONK",
    desc = "Combo",
    file = "monk.lua",
    image = BASE_URL .. "monk.png?v=2"
  },

  paladin = {
    name = "PALADIN",
    desc = "Distancia",
    file = "paladin.lua",
    image = BASE_URL .. "paladin.png"
  },

  sorcerer = {
    name = "SORCERER",
    desc = "Magia",
    file = "sorcerer.lua",
    image = BASE_URL .. "sorcerer.png"
  },

  druid = {
    name = "DRUID",
    desc = "Suporte",
    file = "druid.lua",
    image = BASE_URL .. "druid.png"
  }
}

local loading = false

g_ui.loadUIFromString([[

Pvp99VocationCard < Button
  width: 108
  height: 82
  background-color: #2b241f
  border-width: 1
  border-color: #5b4a35

  $hover:
    background-color: #342a22
    border-color: #d0a45b

  $pressed:
    background-color: #3b2f25
    border-color: #f2c676


Pvp99VocationWindow < MainWindow
  id: pvp99VocationWindow
  text: PVP99
  size: 270 338
  @onEscape: self:hide()

  Label
    id: title
    text: ESCOLHER VOCATION
    anchors.top: parent.top
    anchors.horizontalCenter: parent.horizontalCenter
    margin-top: 5
    color: #f0c36d
    font: verdana-11px-rounded

  Pvp99VocationCard
    id: knightButton
    anchors.top: title.bottom
    anchors.left: parent.left
    margin-top: 8
    margin-left: 12

    Label
      id: knightImage
      anchors.top: parent.top
      anchors.horizontalCenter: parent.horizontalCenter
      margin-top: 2
      size: 46 40
      phantom: true

    Label
      id: knightName
      text: KNIGHT
      anchors.bottom: parent.bottom
      anchors.horizontalCenter: parent.horizontalCenter
      margin-bottom: 15
      color: #ffffff
      font: verdana-11px-rounded
      phantom: true

    Label
      id: knightDesc
      text: Selecionar
      anchors.bottom: parent.bottom
      anchors.horizontalCenter: parent.horizontalCenter
      margin-bottom: 3
      color: #c7ab7a
      font: verdana-11px-rounded
      phantom: true

    Label
      id: knightCheck
      text: ✓
      anchors.top: parent.top
      anchors.right: parent.right
      margin-top: 2
      margin-right: 4
      color: #74ff8b
      font: verdana-11px-rounded
      visible: false
      phantom: true


  Pvp99VocationCard
    id: monkButton
    anchors.top: title.bottom
    anchors.right: parent.right
    margin-top: 8
    margin-right: 12

    Label
      id: monkImage
      anchors.top: parent.top
      anchors.horizontalCenter: parent.horizontalCenter
      margin-top: 2
      size: 46 40
      phantom: true

    Label
      id: monkName
      text: MONK
      anchors.bottom: parent.bottom
      anchors.horizontalCenter: parent.horizontalCenter
      margin-bottom: 15
      color: #ffffff
      font: verdana-11px-rounded
      phantom: true

    Label
      id: monkDesc
      text: Selecionar
      anchors.bottom: parent.bottom
      anchors.horizontalCenter: parent.horizontalCenter
      margin-bottom: 3
      color: #c7ab7a
      font: verdana-11px-rounded
      phantom: true

    Label
      id: monkCheck
      text: ✓
      anchors.top: parent.top
      anchors.right: parent.right
      margin-top: 2
      margin-right: 4
      color: #74ff8b
      font: verdana-11px-rounded
      visible: false
      phantom: true


  Pvp99VocationCard
    id: paladinButton
    anchors.top: knightButton.bottom
    anchors.left: parent.left
    margin-top: 6
    margin-left: 12

    Label
      id: paladinImage
      anchors.top: parent.top
      anchors.horizontalCenter: parent.horizontalCenter
      margin-top: 2
      size: 46 40
      phantom: true

    Label
      id: paladinName
      text: PALADIN
      anchors.bottom: parent.bottom
      anchors.horizontalCenter: parent.horizontalCenter
      margin-bottom: 15
      color: #ffffff
      font: verdana-11px-rounded
      phantom: true

    Label
      id: paladinDesc
      text: Selecionar
      anchors.bottom: parent.bottom
      anchors.horizontalCenter: parent.horizontalCenter
      margin-bottom: 3
      color: #c7ab7a
      font: verdana-11px-rounded
      phantom: true

    Label
      id: paladinCheck
      text: ✓
      anchors.top: parent.top
      anchors.right: parent.right
      margin-top: 2
      margin-right: 4
      color: #74ff8b
      font: verdana-11px-rounded
      visible: false
      phantom: true


  Pvp99VocationCard
    id: sorcererButton
    anchors.top: monkButton.bottom
    anchors.right: parent.right
    margin-top: 6
    margin-right: 12

    Label
      id: sorcererImage
      anchors.top: parent.top
      anchors.horizontalCenter: parent.horizontalCenter
      margin-top: 2
      size: 46 40
      phantom: true

    Label
      id: sorcererName
      text: SORCERER
      anchors.bottom: parent.bottom
      anchors.horizontalCenter: parent.horizontalCenter
      margin-bottom: 15
      color: #ffffff
      font: verdana-11px-rounded
      phantom: true

    Label
      id: sorcererDesc
      text: Selecionar
      anchors.bottom: parent.bottom
      anchors.horizontalCenter: parent.horizontalCenter
      margin-bottom: 3
      color: #c7ab7a
      font: verdana-11px-rounded
      phantom: true

    Label
      id: sorcererCheck
      text: ✓
      anchors.top: parent.top
      anchors.right: parent.right
      margin-top: 2
      margin-right: 4
      color: #74ff8b
      font: verdana-11px-rounded
      visible: false
      phantom: true


  Pvp99VocationCard
    id: druidButton
    anchors.top: paladinButton.bottom
    anchors.horizontalCenter: parent.horizontalCenter
    margin-top: 6

    Label
      id: druidImage
      anchors.top: parent.top
      anchors.horizontalCenter: parent.horizontalCenter
      margin-top: 2
      size: 46 40
      phantom: true

    Label
      id: druidName
      text: DRUID
      anchors.bottom: parent.bottom
      anchors.horizontalCenter: parent.horizontalCenter
      margin-bottom: 15
      color: #ffffff
      font: verdana-11px-rounded
      phantom: true

    Label
      id: druidDesc
      text: Selecionar
      anchors.bottom: parent.bottom
      anchors.horizontalCenter: parent.horizontalCenter
      margin-bottom: 3
      color: #c7ab7a
      font: verdana-11px-rounded
      phantom: true

    Label
      id: druidCheck
      text: ✓
      anchors.top: parent.top
      anchors.right: parent.right
      margin-top: 2
      margin-right: 4
      color: #74ff8b
      font: verdana-11px-rounded
      visible: false
      phantom: true


  Button
    id: cancelButton
    text: CANCELAR
    width: 92
    height: 22
    anchors.top: druidButton.bottom
    anchors.horizontalCenter: parent.horizontalCenter
    margin-top: 8

]])

local root = g_ui.getRootWidget()
if not root then return end

local old = root:recursiveGetChildById("pvp99VocationWindow")
if old then
  old:destroy()
end

local window = UI.createWindow("Pvp99VocationWindow", root)

local buttons = {
  knight = window:recursiveGetChildById("knightButton"),
  monk = window:recursiveGetChildById("monkButton"),
  paladin = window:recursiveGetChildById("paladinButton"),
  sorcerer = window:recursiveGetChildById("sorcererButton"),
  druid = window:recursiveGetChildById("druidButton")
}

local images = {
  knight = window:recursiveGetChildById("knightImage"),
  monk = window:recursiveGetChildById("monkImage"),
  paladin = window:recursiveGetChildById("paladinImage"),
  sorcerer = window:recursiveGetChildById("sorcererImage"),
  druid = window:recursiveGetChildById("druidImage")
}

local checks = {
  knight = window:recursiveGetChildById("knightCheck"),
  monk = window:recursiveGetChildById("monkCheck"),
  paladin = window:recursiveGetChildById("paladinCheck"),
  sorcerer = window:recursiveGetChildById("sorcererCheck"),
  druid = window:recursiveGetChildById("druidCheck")
}

local function loadRemoteImage(widget, url)
  if not widget or not url then return end

  HTTP.downloadImage(url, function(path, err)
    if err then
      print("[PVP99] Erro imagem: " .. tostring(err))
      return
    end

    if not path then return end

    if widget then
      widget:setImageSource(path)
      if widget.setImageFixedRatio then
        widget:setImageFixedRatio(true)
      end
    end
  end)
end

for key, data in pairs(VOCATIONS) do
  loadRemoteImage(images[key], data.image)
end

local function clearChecks()
  for _, check in pairs(checks) do
    if check then
      check:hide()
    end
  end
end

local function selectVocation(key)
  clearChecks()
  if checks[key] then
    checks[key]:show()
  end
end

local function loadVocation(key)
  if loading then return end

  local data = VOCATIONS[key]
  if not data then return end

  loading = true
  selectVocation(key)

  HTTP.get(BASE_URL .. data.file, function(script)
    loading = false

    if not script or script == "" then
      clearChecks()
      print("[PVP99] Falha ao baixar " .. data.name)
      return
    end

    local func, err = loadstring(script)
    if not func then
      clearChecks()
      print("[PVP99] Erro no " .. data.name .. ": " .. tostring(err))
      return
    end

    local ok, runError = pcall(func)
    if not ok then
      clearChecks()
      print("[PVP99] Erro executando " .. data.name .. ": " .. tostring(runError))
      return
    end

    schedule(350, function()
      if window then
        window:hide()
      end
    end)
  end)
end

buttons.knight.onClick = function() loadVocation("knight") end
buttons.monk.onClick = function() loadVocation("monk") end
buttons.paladin.onClick = function() loadVocation("paladin") end
buttons.sorcerer.onClick = function() loadVocation("sorcerer") end
buttons.druid.onClick = function() loadVocation("druid") end

window:recursiveGetChildById("cancelButton").onClick = function()
  window:hide()
end

window:show()
window:raise()
window:focus()
