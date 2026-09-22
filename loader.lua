-- ============================================================
-- PVP99 - SELETOR DE VOCACAO COMPACTO
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
-- INTERFACE
-- ============================================================

g_ui.loadUIFromString([[

VocationCard < Button
  width: 112
  height: 66

  background-color: #252329

  border-width: 1
  border-color: #45404b

  color: #ffffff

  font: verdana-11px-rounded

  text-align: bottom
  text-offset: 0 -4

  checkable: true

  $hover:
    background-color: #302936
    border-color: #d75cff

  $pressed:
    background-color: #382640
    border-color: #ef82ff

  $checked:
    background-color: #202b23
    border-color: #55ff77
    color: #7dff95


Pvp99VocationWindow < MainWindow

  id: pvp99VocationWindow

  text: PVP99

  size: 280 300

  @onEscape: self:hide()


  Label
    id: title

    text: ESCOLHA SUA VOCACAO

    anchors.top: parent.top
    anchors.horizontalCenter: parent.horizontalCenter

    margin-top: 5

    color: #ed73ff

    font: verdana-11px-rounded


  Label
    id: subtitle

    text: Selecione o macro que deseja carregar

    anchors.top: title.bottom
    anchors.horizontalCenter: parent.horizontalCenter

    margin-top: 3

    color: #dddddd

    font: verdana-11px-rounded



  VocationCard
    id: knightButton

    text: KNIGHT

    anchors.top: subtitle.bottom
    anchors.left: parent.left

    margin-top: 10
    margin-left: 16


    Label
      id: knightCheck

      text: ✓

      anchors.top: parent.top
      anchors.right: parent.right

      margin-top: 3
      margin-right: 5

      color: #55ff77

      visible: false
      phantom: true



  VocationCard
    id: monkButton

    text: MONK

    anchors.top: subtitle.bottom
    anchors.right: parent.right

    margin-top: 10
    margin-right: 16


    Label
      id: monkCheck

      text: ✓

      anchors.top: parent.top
      anchors.right: parent.right

      margin-top: 3
      margin-right: 5

      color: #55ff77

      visible: false
      phantom: true



  VocationCard
    id: paladinButton

    text: PALADIN

    anchors.top: knightButton.bottom
    anchors.left: parent.left

    margin-top: 7
    margin-left: 16


    Label
      id: paladinCheck

      text: ✓

      anchors.top: parent.top
      anchors.right: parent.right

      margin-top: 3
      margin-right: 5

      color: #55ff77

      visible: false
      phantom: true



  VocationCard
    id: sorcererButton

    text: SORCERER

    anchors.top: monkButton.bottom
    anchors.right: parent.right

    margin-top: 7
    margin-right: 16


    Label
      id: sorcererCheck

      text: ✓

      anchors.top: parent.top
      anchors.right: parent.right

      margin-top: 3
      margin-right: 5

      color: #55ff77

      visible: false
      phantom: true



  VocationCard
    id: druidButton

    text: DRUID

    anchors.top: paladinButton.bottom
    anchors.horizontalCenter: parent.horizontalCenter

    margin-top: 7


    Label
      id: druidCheck

      text: ✓

      anchors.top: parent.top
      anchors.right: parent.right

      margin-top: 3
      margin-right: 5

      color: #55ff77

      visible: false
      phantom: true



  Button
    id: cancelButton

    text: CANCELAR

    width: 86
    height: 22

    anchors.top: druidButton.bottom
    anchors.horizontalCenter: parent.horizontalCenter

    margin-top: 7

]])


-- ============================================================
-- JANELA
-- ============================================================

local root =
  g_ui.getRootWidget()

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


local status =
  window:recursiveGetChildById(
    "subtitle"
  )


-- ============================================================
-- BOTOES
-- ============================================================

local buttons = {

  knight =
    window:recursiveGetChildById(
      "knightButton"
    ),

  monk =
    window:recursiveGetChildById(
      "monkButton"
    ),

  paladin =
    window:recursiveGetChildById(
      "paladinButton"
    ),

  sorcerer =
    window:recursiveGetChildById(
      "sorcererButton"
    ),

  druid =
    window:recursiveGetChildById(
      "druidButton"
    )

}


local checks = {

  knight =
    window:recursiveGetChildById(
      "knightCheck"
    ),

  monk =
    window:recursiveGetChildById(
      "monkCheck"
    ),

  paladin =
    window:recursiveGetChildById(
      "paladinCheck"
    ),

  sorcerer =
    window:recursiveGetChildById(
      "sorcererCheck"
    ),

  druid =
    window:recursiveGetChildById(
      "druidCheck"
    )

}


-- ============================================================
-- ICONES
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
    width = 38,
    height = 38
  })


  if icon.setItemId then

    icon:setItemId(
      itemId
    )

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
-- SELECAO
-- ============================================================

local function clearSelection()

  for key, button in pairs(buttons) do

    button:setChecked(false)

    if checks[key] then
      checks[key]:hide()
    end

  end

end


local function selectVocation(key)

  clearSelection()

  local button =
    buttons[key]

  if not button then
    return
  end


  button:setChecked(true)


  if checks[key] then
    checks[key]:show()
  end

end


-- ============================================================
-- CARREGAMENTO
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


  status:setColor(
    "#ed73ff"
  )


  HTTP.get(

    BASE_URL .. data.file,

    function(script)


      loading = false


      if not script or
         script == ""
      then

        status:setText(
          "Falha ao carregar"
        )

        status:setColor(
          "#ff5555"
        )

        return

      end


      local func, err =
        loadstring(script)


      if not func then

        status:setText(
          "Erro no script"
        )

        status:setColor(
          "#ff5555"
        )

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
          "Erro ao executar"
        )

        status:setColor(
          "#ff5555"
        )

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


      status:setColor(
        "#55ff77"
      )


      schedule(
        600,
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

buttons.knight.onClick =
  function()

    loadVocation(
      "knight"
    )

  end


buttons.monk.onClick =
  function()

    loadVocation(
      "monk"
    )

  end


buttons.paladin.onClick =
  function()

    loadVocation(
      "paladin"
    )

  end


buttons.sorcerer.onClick =
  function()

    loadVocation(
      "sorcerer"
    )

  end


buttons.druid.onClick =
  function()

    loadVocation(
      "druid"
    )

  end


window:recursiveGetChildById(
  "cancelButton"
).onClick =
  function()

    window:hide()

  end


-- ============================================================
-- ABRE
-- ============================================================

window:show()
window:raise()
window:focus()
