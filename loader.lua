-- =========================================================
-- PVP99 - SELETOR DE VOCAÇÃO
-- =========================================================

local VOCATIONS = {
  knight = "https://raw.githubusercontent.com/oficiallpvp99/PVP99-Caves/refs/heads/main/knight.lua",

  monk = "COLOQUE_LINK_RAW_MONK",

  paladin = "COLOQUE_LINK_RAW_PALADIN",

  sorcerer = "COLOQUE_LINK_RAW_SORCERER",

  druid = "COLOQUE_LINK_RAW_DRUID"
}

-- =========================================================
-- CARREGADOR
-- =========================================================

local loading = false

local function loadVocation(name)

  if loading then
    return
  end

  local url = VOCATIONS[name]

  if not url or url == "" then
    print("[PVP99] Link nao configurado: " .. name)
    return
  end

  loading = true

  HTTP.get(url, function(script)

    loading = false

    if not script or script == "" then
      print("[PVP99] Erro ao baixar: " .. name)
      return
    end

    local func, err = loadstring(script)

    if not func then
      print("[PVP99] Erro no script " .. name .. ": " .. tostring(err))
      return
    end

    func()

    print("[PVP99] " .. name .. " carregado com sucesso!")

  end)
end

-- =========================================================
-- INTERFACE
-- =========================================================

g_ui.loadUIFromString([[

Pvp99VocationWindow < MainWindow
  id: pvp99VocationWindow
  text: PVP99 - Selecione sua Vocacao
  size: 330 260
  @onEscape: self:hide()

  Label
    id: title
    text: ESCOLHA SUA VOCACAO
    anchors.top: parent.top
    anchors.horizontalCenter: parent.horizontalCenter
    margin-top: 10
    font: verdana-11px-rounded

  Button
    id: knightButton
    text: KNIGHT
    width: 135
    height: 55
    anchors.top: title.bottom
    anchors.left: parent.left
    margin-top: 15
    margin-left: 20

  Button
    id: monkButton
    text: MONK
    width: 135
    height: 55
    anchors.top: title.bottom
    anchors.right: parent.right
    margin-top: 15
    margin-right: 20

  Button
    id: paladinButton
    text: PALADIN
    width: 135
    height: 55
    anchors.top: knightButton.bottom
    anchors.left: parent.left
    margin-top: 10
    margin-left: 20

  Button
    id: sorcererButton
    text: SORCERER
    width: 135
    height: 55
    anchors.top: monkButton.bottom
    anchors.right: parent.right
    margin-top: 10
    margin-right: 20

  Button
    id: druidButton
    text: DRUID
    width: 135
    height: 45
    anchors.top: paladinButton.bottom
    anchors.horizontalCenter: parent.horizontalCenter
    margin-top: 10

  Button
    id: cancelButton
    text: CANCELAR
    width: 90
    height: 25
    anchors.bottom: parent.bottom
    anchors.horizontalCenter: parent.horizontalCenter
    margin-bottom: 5

]])

-- =========================================================
-- CRIA JANELA
-- =========================================================

local root = g_ui.getRootWidget()

if root then

  local old =
    root:recursiveGetChildById("pvp99VocationWindow")

  if old then
    old:destroy()
  end

  local window =
    UI.createWindow(
      "Pvp99VocationWindow",
      root
    )

  -- KNIGHT
  window:recursiveGetChildById(
    "knightButton"
  ).onClick = function()

    window:hide()
    loadVocation("knight")

  end

  -- MONK
  window:recursiveGetChildById(
    "monkButton"
  ).onClick = function()

    window:hide()
    loadVocation("monk")

  end

  -- PALADIN
  window:recursiveGetChildById(
    "paladinButton"
  ).onClick = function()

    window:hide()
    loadVocation("paladin")

  end

  -- SORCERER
  window:recursiveGetChildById(
    "sorcererButton"
  ).onClick = function()

    window:hide()
    loadVocation("sorcerer")

  end

  -- DRUID
  window:recursiveGetChildById(
    "druidButton"
  ).onClick = function()

    window:hide()
    loadVocation("druid")

  end

  -- CANCELAR
  window:recursiveGetChildById(
    "cancelButton"
  ).onClick = function()

    window:hide()

  end

  window:show()
  window:raise()
  window:focus()

end
