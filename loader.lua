-- ============================================================
-- PVP99 - VOCATION SELECTOR CLEAN
-- ============================================================

local BASE_URL =
  "https://raw.githubusercontent.com/oficiallpvp99/PVP99-Caves/refs/heads/main/"

local VOCATIONS = {
  knight = {
    name = "KNIGHT",
    file = "knight.lua",
    icon = 34083
  },

  monk = {
    name = "MONK",
    file = "monk.lua",
    icon = 47375
  },

  paladin = {
    name = "PALADIN",
    file = "paladin.lua",
    icon = 47375
  },

  sorcerer = {
    name = "SORCERER",
    file = "sorcerer.lua",
    icon = 47375
  },

  druid = {
    name = "DRUID",
    file = "druid.lua",
    icon = 47375
  }
}

local loading = false

-- ============================================================
-- UI
-- ============================================================

g_ui.loadUIFromString([[

VocationCard < Button
  width: 100
  height: 62
  background-color: #242229
  border-width: 1
  border-color: #47434f
  color: #ffffff
  font: verdana-11px-rounded
  text-align: bottom
  text-offset: 0 -4

  $hover:
    background-color: #302737
    border-color: #d75cff
    color: #ffffff

  $pressed:
    background-color: #3a2942
    border-color: #ef7aff


Pvp99VocationWindow < MainWindow
  id: pvp99VocationWindow
  text: PVP99
  size: 250 265
  @onEscape: self:hide()


  Label
    id: title
    text: ESCOLHA SUA VOCACAO
    anchors.top: parent.top
    anchors.horizontalCenter: parent.horizontalCenter
    margin-top: 5
    color: #ed74ff
    font: verdana-11px-rounded


  Label
    id: subtitle
    text: Selecione o macro
    anchors.top: title.bottom
    anchors.horizontalCenter: parent.horizontalCenter
    margin-top: 3
    color: #bdb8c2
    font: verdana-11px-rounded


  VocationCard
    id: knightButton
    text: KNIGHT
    anchors.top: subtitle.bottom
    anchors.left: parent.left
    margin-top: 10
    margin-left: 14

    Label
      id: knightCheck
      text: ✓
      anchors.top: parent.top
      anchors.right: parent.right
      margin-top: 3
      margin-right: 5
      color: #55ff88
      visible: false
      phantom: true


  VocationCard
    id: monkButton
    text: MONK
    anchors.top: subtitle.bottom
    anchors.right: parent.right
    margin-top: 10
    margin-right: 14

    Label
      id: monkCheck
      text: ✓
      anchors.top: parent.top
      anchors.right: parent.right
      margin-top: 3
      margin-right: 5
      color: #55ff88
      visible: false
      phantom: true


  VocationCard
    id: paladinButton
    text: PALADIN
    anchors.top: knightButton.bottom
    anchors.left: parent.left
    margin-top: 6
    margin-left: 14

    Label
      id: paladinCheck
      text: ✓
      anchors.top: parent.top
      anchors.right: parent.right
      margin-top: 3
      margin-right: 5
      color: #55ff88
      visible: false
      phantom: true


  VocationCard
    id: sorcererButton
    text: SORCERER
    anchors.top: monkButton.bottom
    anchors.right: parent.right
    margin-top: 6
    margin-right: 14

    Label
      id: sorcererCheck
      text: ✓
      anchors.top: parent.top
      anchors.right: parent.right
      margin-top: 3
      margin-right: 5
      color: #55ff88
      visible: false
      phantom: true


  VocationCard
    id: druidButton
    text: DRUID
    anchors.top: paladinButton.bottom
    anchors.horizontalCenter: parent.horizontalCenter
    margin-top: 6

    Label
      id: druidCheck
      text: ✓
      anchors.top: parent.top
      anchors.right: parent.right
      margin-top: 3
      margin-right: 5
      color: #55ff88
      visible: false
      phantom: true


  Button
    id: cancelButton
    text: CANCELAR
    width: 82
    height: 21
    anchors.top: druidButton.bottom
    anchors.horizontalCenter: parent.horizontalCenter
    margin-top: 7

]])

-- ============================================================
-- WINDOW
-- ============================================================

local root = g_ui.getRootWidget()

if not root then
  return
end

local old =
  root:recursiveGetChildById(
    "pvp99VocationWindow"
  )

if old then
  old:destroy()
end

local window =
  UI.createWindow(
    "Pvp99VocationWindow",
    root
  )

-- ============================================================
-- BUTTONS
-- ============================================================

local buttons = {
  knight =
    window:recursiveGetChildById("knightButton"),

  monk =
    window:recursiveGetChildById("monkButton"),

  paladin =
    window:recursiveGetChildById("paladinButton"),

  sorcerer =
    window:recursiveGetChildById("sorcererButton"),

  druid =
    window:recursiveGetChildById("druidButton")
}

local checks = {
  knight =
    window:recursiveGetChildById("knightCheck"),

  monk =
    window:recursiveGetChildById("monkCheck"),

  paladin =
    window:recursiveGetChildById("paladinCheck"),

  sorcerer =
    window:recursiveGetChildById("sorcererCheck"),

  druid =
    window:recursiveGetChildById("druidCheck")
}

-- ============================================================
-- ICONS
-- ============================================================

local function createIcon(button, itemId)

  if not button then
    return
  end

  local icon =
    g_ui.createWidget(
      "UIItem",
      button
    )

  if not icon then
    return
  end

  icon:setSize({
    width = 36,
    height = 36
  })

  if icon.setItemId then
    icon:setItemId(itemId)
  end

  if icon.setVirtual then
    icon:setVirtual(true)
  end

  icon:setPhantom(true)

  icon:addAnchor(
    AnchorTop,
    "parent",
    AnchorTop
  )

  icon:addAnchor(
    AnchorHorizontalCenter,
    "parent",
    AnchorHorizontalCenter
  )

  icon:setMarginTop(2)

end

for key, data in pairs(VOCATIONS) do

  createIcon(
    buttons[key],
    data.icon
  )

end

-- ============================================================
-- CHECK
-- ============================================================

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

-- ============================================================
-- LOAD
-- ============================================================

local function loadVocation(key)

  if loading then
    return
  end

  local data =
    VOCATIONS[key]

  if not data then
    return
  end

  selectVocation(key)

  loading = true

  HTTP.get(
    BASE_URL .. data.file,

    function(script)

      loading = false

      if not script or script == "" then

        print(
          "[PVP99] Falha ao baixar " ..
          data.name
        )

        clearChecks()

        return
      end

      local func, err =
        loadstring(script)

      if not func then

        print(
          "[PVP99] Erro " ..
          data.name ..
          ": " ..
          tostring(err)
        )

        clearChecks()

        return
      end

      local ok, runError =
        pcall(func)

      if not ok then

        print(
          "[PVP99] Erro executando " ..
          data.name ..
          ": " ..
          tostring(runError)
        )

        clearChecks()

        return
      end

      -- fecha sem mensagem verde bugada
      schedule(
        250,
        function()

          if window then
            window:hide()
          end

        end
      )

    end
  )

end

-- ============================================================
-- CLICK EVENTS
-- ============================================================

buttons.knight.onClick = function()
  loadVocation("knight")
end

buttons.monk.onClick = function()
  loadVocation("monk")
end

buttons.paladin.onClick = function()
  loadVocation("paladin")
end

buttons.sorcerer.onClick = function()
  loadVocation("sorcerer")
end

buttons.druid.onClick = function()
  loadVocation("druid")
end

window:recursiveGetChildById(
  "cancelButton"
).onClick = function()

  window:hide()

end

-- ============================================================
-- OPEN
-- ============================================================

window:show()
window:raise()
window:focus()
