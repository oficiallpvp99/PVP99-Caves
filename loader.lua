-- ============================================================
-- PVP99 - SELETOR DE VOCACAO MEDIEVAL
-- VERSAO CORRIGIDA / COMPACTA
-- ============================================================

local BASE_URL =
  "https://raw.githubusercontent.com/oficiallpvp99/PVP99-Caves/refs/heads/main/"

local VOCATIONS = {
  knight = {
    name = "KNIGHT",
    file = "knight.lua",
    image = BASE_URL .. "knight.png"
  },

  monk = {
    name = "MONK",
    file = "monk.lua",
    image = BASE_URL .. "monk.png?v=2"
  },

  paladin = {
    name = "PALADIN",
    file = "paladin.lua",
    image = BASE_URL .. "paladin.png"
  },

  sorcerer = {
    name = "SORCERER",
    file = "sorcerer.lua",
    image = BASE_URL .. "sorcerer.png"
  },

  druid = {
    name = "DRUID",
    file = "druid.lua",
    image = BASE_URL .. "druid.png"
  }
}

local loading = false

g_ui.loadUIFromString([[

Pvp99VocationCard < Button
  width: 114
  height: 76
  background-color: #2b241f
  border-width: 1
  border-color: #5b4a35

  $hover:
    background-color: #2b241f
    border-color: #5b4a35

  $pressed:
    background-color: #433428
    border-color: #f2c676


Pvp99CancelButton < Button
  width: 74
  height: 18
  background-color: #35291f
  border-width: 1
  border-color: #765f45
  color: #e8dcc4
  font: verdana-11px-rounded

  $hover:
    background-color: #483625
    border-color: #d7ad61
    color: #fff2d1

  $pressed:
    background-color: #261d17
    border-color: #f2c676


Pvp99VocationWindow < MainWindow
  id: pvp99VocationWindow
  text: PVP99
  size: 278 346
  @onEscape: self:hide()

  Label
    id: title
    text: ESCOLHER VOCATION
    width: 250
    text-align: center
    anchors.top: parent.top
    anchors.horizontalCenter: parent.horizontalCenter
    margin-top: 5
    color: #f0c36d
    font: verdana-11px-rounded

  Label
    id: subtitle
    text: Selecione
    width: 250
    text-align: center
    anchors.top: title.bottom
    anchors.horizontalCenter: parent.horizontalCenter
    margin-top: 2
    color: #d9d0c2
    font: verdana-11px-rounded


  Pvp99VocationCard
    id: knightButton
    anchors.top: subtitle.bottom
    anchors.left: parent.left
    margin-top: 8
    margin-left: 13

    Label
      id: knightImage
      anchors.top: parent.top
      anchors.horizontalCenter: parent.horizontalCenter
      margin-top: 3
      size: 42 36
      phantom: true

    Label
      id: knightName
      text: KNIGHT
      width: 112
      text-align: center
      anchors.bottom: parent.bottom
      anchors.horizontalCenter: parent.horizontalCenter
      margin-bottom: 7
      color: #ffffff
      font: verdana-11px-rounded
      phantom: true

    Label
      id: knightCheck
      text: ✓
      anchors.top: parent.top
      anchors.right: parent.right
      margin-top: 3
      margin-right: 5
      color: #74ff8b
      font: verdana-11px-rounded
      visible: false
      phantom: true


  Pvp99VocationCard
    id: monkButton
    anchors.top: subtitle.bottom
    anchors.right: parent.right
    margin-top: 8
    margin-right: 13

    Label
      id: monkImage
      anchors.top: parent.top
      anchors.horizontalCenter: parent.horizontalCenter
      margin-top: 3
      size: 42 36
      phantom: true

    Label
      id: monkName
      text: MONK
      width: 112
      text-align: center
      anchors.bottom: parent.bottom
      anchors.horizontalCenter: parent.horizontalCenter
      margin-bottom: 7
      color: #ffffff
      font: verdana-11px-rounded
      phantom: true

    Label
      id: monkCheck
      text: ✓
      anchors.top: parent.top
      anchors.right: parent.right
      margin-top: 3
      margin-right: 5
      color: #74ff8b
      font: verdana-11px-rounded
      visible: false
      phantom: true


  Pvp99VocationCard
    id: paladinButton
    anchors.top: knightButton.bottom
    anchors.left: parent.left
    margin-top: 5
    margin-left: 13

    Label
      id: paladinImage
      anchors.top: parent.top
      anchors.horizontalCenter: parent.horizontalCenter
      margin-top: 3
      size: 42 36
      phantom: true

    Label
      id: paladinName
      text: PALADIN
      width: 112
      text-align: center
      anchors.bottom: parent.bottom
      anchors.horizontalCenter: parent.horizontalCenter
      margin-bottom: 7
      color: #ffffff
      font: verdana-11px-rounded
      phantom: true

    Label
      id: paladinCheck
      text: ✓
      anchors.top: parent.top
      anchors.right: parent.right
      margin-top: 3
      margin-right: 5
      color: #74ff8b
      font: verdana-11px-rounded
      visible: false
      phantom: true


  Pvp99VocationCard
    id: sorcererButton
    anchors.top: monkButton.bottom
    anchors.right: parent.right
    margin-top: 5
    margin-right: 13

    Label
      id: sorcererImage
      anchors.top: parent.top
      anchors.horizontalCenter: parent.horizontalCenter
      margin-top: 3
      size: 42 36
      phantom: true

    Label
      id: sorcererName
      text: SORCERER
      width: 112
      text-align: center
      anchors.bottom: parent.bottom
      anchors.horizontalCenter: parent.horizontalCenter
      margin-bottom: 7
      color: #ffffff
      font: verdana-11px-rounded
      phantom: true

    Label
      id: sorcererCheck
      text: ✓
      anchors.top: parent.top
      anchors.right: parent.right
      margin-top: 3
      margin-right: 5
      color: #74ff8b
      font: verdana-11px-rounded
      visible: false
      phantom: true


  Pvp99VocationCard
    id: druidButton
    anchors.top: paladinButton.bottom
    anchors.horizontalCenter: parent.horizontalCenter
    margin-top: 5

    Label
      id: druidImage
      anchors.top: parent.top
      anchors.horizontalCenter: parent.horizontalCenter
      margin-top: 3
      size: 42 36
      phantom: true

    Label
      id: druidName
      text: DRUID
      width: 112
      text-align: center
      anchors.bottom: parent.bottom
      anchors.horizontalCenter: parent.horizontalCenter
      margin-bottom: 7
      color: #ffffff
      font: verdana-11px-rounded
      phantom: true

    Label
      id: druidCheck
      text: ✓
      anchors.top: parent.top
      anchors.right: parent.right
      margin-top: 3
      margin-right: 5
      color: #74ff8b
      font: verdana-11px-rounded
      visible: false
      phantom: true


  Pvp99CancelButton
    id: cancelButton
    text: CANCELAR
    anchors.bottom: parent.bottom
    anchors.horizontalCenter: parent.horizontalCenter
    margin-bottom: 5

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

local names = {
  knight = window:recursiveGetChildById("knightName"),
  monk = window:recursiveGetChildById("monkName"),
  paladin = window:recursiveGetChildById("paladinName"),
  sorcerer = window:recursiveGetChildById("sorcererName"),
  druid = window:recursiveGetChildById("druidName")
}

local title = window:recursiveGetChildById("title")
local subtitle = window:recursiveGetChildById("subtitle")

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

-- ============================================================
-- HOVER: BRILHO SOMENTE NO NOME DA VOCACAO
-- ============================================================

local function setNameHighlight(key, hovered)
  local nameWidget = names[key]
  if not nameWidget then return end

  if hovered then
    nameWidget:setColor("#ffd46e")
  else
    nameWidget:setColor("#ffffff")
  end
end

for key, button in pairs(buttons) do
  button.onHoverChange = function(widget, hovered)
    setNameHighlight(key, hovered)
  end
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
  clearChecks()

  title:setText("ATIVANDO...")
  title:setColor("#f0d8a0")
  subtitle:hide()

  HTTP.get(BASE_URL .. data.file, function(script)
    loading = false

    if not script or script == "" then
      clearChecks()
      title:setText("ERRO NO MACRO")
      title:setColor("#ff6b6b")
      subtitle:hide()
      print("[PVP99] Falha ao baixar " .. data.name)
      return
    end

    local func, err = loadstring(script)

    if not func then
      clearChecks()
      title:setText("ERRO NO MACRO")
      title:setColor("#ff6b6b")
      subtitle:hide()
      print("[PVP99] Erro no " .. data.name .. ": " .. tostring(err))
      return
    end

    local ok, runError = pcall(func)

    if not ok then
      clearChecks()
      title:setText("ERRO NO MACRO")
      title:setColor("#ff6b6b")
      subtitle:hide()
      print("[PVP99] Erro executando " .. data.name .. ": " .. tostring(runError))
      return
    end

    clearChecks()
    title:setText("MACRO ATIVADO")
    title:setColor("#8dff9c")
    subtitle:hide()

    schedule(850, function()
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

local cancelButton = window:recursiveGetChildById("cancelButton")

if cancelButton then
  cancelButton.onClick = function()
    if window then
      window:destroy()
      window = nil
    end
  end
end

window:show()
window:raise()
window:focus()
