-- ============================================================
-- PVP99 - VOCATION SELECTOR V3
-- Medieval Compacto
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

Pvp99ClassCard < Button
  width: 104
  height: 76
  background-color: #2a241d
  border-width: 1
  border-color: #5e4a33

  $hover:
    background-color: #372d22
    border-color: #d7ad61

  $pressed:
    background-color: #473829
    border-color: #f0ca74


Pvp99CancelButton < Button
  width: 88
  height: 22
  background-color: #35291f
  border-width: 1
  border-color: #786046
  color: #e1d2b3
  font: verdana-11px-rounded

  $hover:
    background-color: #493726
    border-color: #d7ad61
    color: #fff1cb

  $pressed:
    background-color: #281f18
    border-color: #f0ca74


Pvp99VocationWindow < MainWindow
  id: pvp99VocationWindow
  text: PVP99
  size: 256 292
  @onEscape: self:hide()

  Label
    id: title
    text: ESCOLHA SUA VOCACAO
    anchors.top: parent.top
    anchors.horizontalCenter: parent.horizontalCenter
    margin-top: 4
    color: #e3b96a
    font: verdana-11px-rounded

  Label
    id: subtitle
    text: Selecione
    anchors.top: title.bottom
    anchors.horizontalCenter: parent.horizontalCenter
    margin-top: 2
    color: #d8ccb4
    font: verdana-11px-rounded


  -- KNIGHT
  Pvp99ClassCard
    id: knightButton
    anchors.top: subtitle.bottom
    anchors.left: parent.left
    margin-top: 8
    margin-left: 12

    Label
      id: knightImage
      anchors.top: parent.top
      anchors.horizontalCenter: parent.horizontalCenter
      margin-top: 2
      size: 42 38
      opacity: 0.85
      phantom: true

    Label
      id: knightName
      text: KNIGHT
      anchors.bottom: parent.bottom
      anchors.horizontalCenter: parent.horizontalCenter
      margin-bottom: 16
      color: #ffffff
      font: verdana-11px-rounded
      phantom: true

    Label
      id: knightAction
      text: Selecionar
      anchors.bottom: parent.bottom
      anchors.horizontalCenter: parent.horizontalCenter
      margin-bottom: 3
      color: #cbb38a
      font: verdana-11px-rounded
      phantom: true

    Label
      id: knightCheck
      text: ✓
      anchors.top: parent.top
      anchors.right: parent.right
      margin-top: 2
      margin-right: 4
      color: #7cff8c
      visible: false
      phantom: true


  -- MONK
  Pvp99ClassCard
    id: monkButton
    anchors.top: subtitle.bottom
    anchors.right: parent.right
    margin-top: 8
    margin-right: 12

    Label
      id: monkImage
      anchors.top: parent.top
      anchors.horizontalCenter: parent.horizontalCenter
      margin-top: 2
      size: 42 38
      opacity: 0.85
      phantom: true

    Label
      id: monkName
      text: MONK
      anchors.bottom: parent.bottom
      anchors.horizontalCenter: parent.horizontalCenter
      margin-bottom: 16
      color: #ffffff
      font: verdana-11px-rounded
      phantom: true

    Label
      id: monkAction
      text: Selecionar
      anchors.bottom: parent.bottom
      anchors.horizontalCenter: parent.horizontalCenter
      margin-bottom: 3
      color: #cbb38a
      font: verdana-11px-rounded
      phantom: true

    Label
      id: monkCheck
      text: ✓
      anchors.top: parent.top
      anchors.right: parent.right
      margin-top: 2
      margin-right: 4
      color: #7cff8c
      visible: false
      phantom: true


  -- PALADIN
  Pvp99ClassCard
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
      size: 42 38
      opacity: 0.85
      phantom: true

    Label
      id: paladinName
      text: PALADIN
      anchors.bottom: parent.bottom
      anchors.horizontalCenter: parent.horizontalCenter
      margin-bottom: 16
      color: #ffffff
      font: verdana-11px-rounded
      phantom: true

    Label
      id: paladinAction
      text: Selecionar
      anchors.bottom: parent.bottom
      anchors.horizontalCenter: parent.horizontalCenter
      margin-bottom: 3
      color: #cbb38a
      font: verdana-11px-rounded
      phantom: true

    Label
      id: paladinCheck
      text: ✓
      anchors.top: parent.top
      anchors.right: parent.right
      margin-top: 2
      margin-right: 4
      color: #7cff8c
      visible: false
      phantom: true


  -- SORCERER
  Pvp99ClassCard
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
      size: 42 38
      opacity: 0.85
      phantom: true

    Label
      id: sorcererName
      text: SORCERER
      anchors.bottom: parent.bottom
      anchors.horizontalCenter: parent.horizontalCenter
      margin-bottom: 16
      color: #ffffff
      font: verdana-11px-rounded
      phantom: true

    Label
      id: sorcererAction
      text: Selecionar
      anchors.bottom: parent.bottom
      anchors.horizontalCenter: parent.horizontalCenter
      margin-bottom: 3
      color: #cbb38a
      font: verdana-11px-rounded
      phantom: true

    Label
      id: sorcererCheck
      text: ✓
      anchors.top: parent.top
      anchors.right: parent.right
      margin-top: 2
      margin-right: 4
      color: #7cff8c
      visible: false
      phantom: true


  -- DRUID
  Pvp99ClassCard
    id: druidButton
    anchors.top: paladinButton.bottom
    anchors.horizontalCenter: parent.horizontalCenter
    margin-top: 6

    Label
      id: druidImage
      anchors.top: parent.top
      anchors.horizontalCenter: parent.horizontalCenter
      margin-top: 2
      size: 42 38
      opacity: 0.85
      phantom: true

    Label
      id: druidName
      text: DRUID
      anchors.bottom: parent.bottom
      anchors.horizontalCenter: parent.horizontalCenter
      margin-bottom: 16
      color: #ffffff
      font: verdana-11px-rounded
      phantom: true

    Label
      id: druidAction
      text: Selecionar
      anchors.bottom: parent.bottom
      anchors.horizontalCenter: parent.horizontalCenter
      margin-bottom: 3
      color: #cbb38a
      font: verdana-11px-rounded
      phantom: true

    Label
      id: druidCheck
      text: ✓
      anchors.top: parent.top
      anchors.right: parent.right
      margin-top: 2
      margin-right: 4
      color: #7cff8c
      visible: false
      phantom: true


  Pvp99CancelButton
    id: cancelButton
    text: CANCELAR
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

local subtitle = window:recursiveGetChildById("subtitle")

local function loadRemoteImage(widget, url)
  if not widget or not url then
    return
  end

  HTTP.downloadImage(url, function(path, err)
    if err then
      print("[PVP99] Erro imagem: " .. tostring(err))
      return
    end

    if not path then
      return
    end

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

local function setImageOpacity(widget, value)
  if widget and widget.setOpacity then
    widget:setOpacity(value)
  end
end

for key, button in pairs(buttons) do
  local img = images[key]

  button.onHoverChange = function(widget, hovered)
    if hovered then
      setImageOpacity(img, 1.0)
    else
      setImageOpacity(img, 0.85)
    end
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

  subtitle:setText("Ativado")
  subtitle:setColor("#8ff09c")
end

local function loadVocation(key)
  if loading then
    return
  end

  local data = VOCATIONS[key]
  if not data then
    return
  end

  loading = true
  selectVocation(key)

  HTTP.get(BASE_URL .. data.file, function(script)
    loading = false

    if not script or script == "" then
      clearChecks()
      subtitle:setText("Falha ao carregar")
      subtitle:setColor("#ff6b6b")
      return
    end

    local func, err = loadstring(script)
    if not func then
      clearChecks()
      subtitle:setText("Erro no macro")
      subtitle:setColor("#ff6b6b")
      print("[PVP99] " .. tostring(err))
      return
    end

    local ok, runError = pcall(func)
    if not ok then
      clearChecks()
      subtitle:setText("Erro ao executar")
      subtitle:setColor("#ff6b6b")
      print("[PVP99] " .. tostring(runError))
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
