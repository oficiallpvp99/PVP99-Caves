-- ============================================================
-- PVP99 - VOCATION LOADER
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

-- ============================================================
-- ESTADO
-- ============================================================

local loading = false
local selectedButton = nil

-- ============================================================
-- INTERFACE
-- ============================================================

g_ui.loadUIFromString([[

VocationCard < Button
  width: 135
  height: 90
  background-color: #17131f
  border-width: 1
  border-color: #51445f
  color: #eeeeee
  font: verdana-11px-rounded
  text-align: bottom
  text-offset: 0 -8
  checkable: true

  $hover:
    background-color: #261831
    border-color: #d65cff
    color: #ffffff

  $pressed:
    background-color: #321b42
    border-color: #ff77ff

  $checked:
    background-color: #18251d
    border-color: #54ff83
    color: #7dff9c


Pvp99VocationWindow < MainWindow
  id: pvp99VocationWindow
  text: PVP99
  size: 330 355
  @onEscape: self:hide()

  Label
    id: title
    text: ESCOLHA SUA VOCACAO
    anchors.top: parent.top
    anchors.horizontalCenter: parent.horizontalCenter
    margin-top: 7
    color: #e682ff
    font: verdana-11px-rounded

  Label
    id: subtitle
    text: Selecione o macro que deseja carregar
    anchors.top: title.bottom
    anchors.horizontalCenter: parent.horizontalCenter
    margin-top: 5
    color: #a99bb4
    font: verdana-11px-rounded


  VocationCard
    id: knightButton
    text: KNIGHT
    anchors.top: subtitle.bottom
    anchors.left: parent.left
    margin-top: 15
    margin-left: 20

    Label
      id: knightCheck
      text: ✓
      anchors.top: parent.top
      anchors.right: parent.right
      margin-top: 5
      margin-right: 7
      color: #55ff88
      font: verdana-11px-rounded
      visible: false
      phantom: true


  VocationCard
    id: monkButton
    text: MONK
    anchors.top: subtitle.bottom
    anchors.right: parent.right
    margin-top: 15
    margin-right: 20

    Label
      id: monkCheck
      text: ✓
      anchors.top: parent.top
      anchors.right: parent.right
      margin-top: 5
      margin-right: 7
      color: #55ff88
      font: verdana-11px-rounded
      visible: false
      phantom: true


  VocationCard
    id: paladinButton
    text: PALADIN
    anchors.top: knightButton.bottom
    anchors.left: parent.left
    margin-top: 10
    margin-left: 20

    Label
      id: paladinCheck
      text: ✓
      anchors.top: parent.top
      anchors.right: parent.right
      margin-top: 5
      margin-right: 7
      color: #55ff88
      font: verdana-11px-rounded
      visible: false
      phantom: true


  VocationCard
    id: sorcererButton
    text: SORCERER
    anchors.top: monkButton.bottom
    anchors.right: parent.right
    margin-top: 10
    margin-right: 20

    Label
      id: sorcererCheck
      text: ✓
      anchors.top: parent.top
      anchors.right: parent.right
      margin-top: 5
      margin-right: 7
      color: #55ff88
      font: verdana-11px-rounded
      visible: false
      phantom: true


  VocationCard
    id: druidButton
    text: DRUID
    anchors.top: paladinButton.bottom
    anchors.horizontalCenter: parent.horizontalCenter
    margin-top: 10

    Label
      id: druidCheck
      text: ✓
      anchors.top: parent.top
      anchors.right: parent.right
      margin-top: 5
      margin-right: 7
      color: #55ff88
      font: verdana-11px-rounded
      visible: false
      phantom: true


  Label
    id: status
    text: Selecione uma vocacao
    anchors.top: druidButton.bottom
    anchors.horizontalCenter: parent.horizontalCenter
    margin-top: 9
    color: #8e8298
    font: verdana-11px-rounded


  Button
    id: cancelButton
    text: CANCELAR
    width: 100
    height: 25
    anchors.bottom: parent.bottom
    anchors.horizontalCenter: parent.horizontalCenter
    margin-bottom: 6

]])

-- ============================================================
-- ROOT
-- ============================================================

local root = g_ui.getRootWidget()

if not root then
  return
end

-- Remove janela anterior caso loader seja executado novamente
local oldWindow =
  root:recursiveGetChildById("pvp99VocationWindow")

if oldWindow then
  oldWindow:destroy()
end

local window =
  UI.createWindow(
    "Pvp99VocationWindow",
    root
  )

-- ============================================================
-- ELEMENTOS
-- ============================================================

local status =
  window:recursiveGetChildById("status")

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
-- ICONES
--
-- Usa sprites nativos do .dat/.spr.
-- Depois podemos trocar cada ID pela imagem ideal da vocacao.
-- ============================================================

local function createVocationIcon(button, itemId)

  if not button then
    return
  end

  local ok, icon =
    pcall(function()
      return g_ui.createWidget(
        "UIItem",
        button
      )
    end)

  if not ok or not icon then
    return
  end

  icon:setId("vocationIcon")

  icon:setSize({
    width = 52,
    height = 52
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

  icon:setMarginTop(7)

end

for key, data in pairs(VOCATIONS) do

  createVocationIcon(
    buttons[key],
    data.icon
  )

end

-- ============================================================
-- LIMPA SELECAO
-- ============================================================

local function clearSelection()

  for key, button in pairs(buttons) do

    if button.setChecked then
      button:setChecked(false)
    end

    if checks[key] then
      checks[key]:hide()
    end

  end

end

-- ============================================================
-- SELECIONA CARD
-- ============================================================

local function selectVocation(key)

  clearSelection()

  local button =
    buttons[key]

  if not button then
    return
  end

  selectedButton = key

  if button.setChecked then
    button:setChecked(true)
  end

  if checks[key] then
    checks[key]:show()
  end

end

-- ============================================================
-- CARREGA SCRIPT
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

  status:setText(
    "Carregando " ..
    data.name ..
    "..."
  )

  status:setColor("#e682ff")

  local url =
    BASE_URL ..
    data.file

  HTTP.get(
    url,
    function(script)

      loading = false

      if not script or
         script == ""
      then

        status:setText(
          "Falha ao baixar " ..
          data.name
        )

        status:setColor("#ff5555")

        return
      end

      local func, err =
        loadstring(script)

      if not func then

        status:setText(
          "Erro no script " ..
          data.name
        )

        status:setColor("#ff5555")

        print(
          "[PVP99] " ..
          tostring(err)
        )

        return
      end

      local ok, runError =
        pcall(func)

      if not ok then

        status:setText(
          "Erro ao executar " ..
          data.name
        )

        status:setColor("#ff5555")

        print(
          "[PVP99] " ..
          tostring(runError)
        )

        return
      end

      status:setText(
        data.name ..
        " CARREGADO!"
      )

      status:setColor("#55ff88")

      schedule(
        700,
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
-- CLIQUES
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
-- ABRE
-- ============================================================

window:show()
window:raise()
window:focus()
