-- ============================================================
-- PVP99 - VOCATION SELECTOR V2
-- Medieval / Tibia Classic
-- ============================================================

local BASE_URL =
  "https://raw.githubusercontent.com/oficiallpvp99/PVP99-Caves/refs/heads/main/"

local VOCATIONS = {
  knight = {
    name = "KNIGHT",
    desc = "Defesa e combate corpo a corpo",
    file = "knight.lua",
    image = BASE_URL .. "knight.png"
  },

  monk = {
    name = "MONK",
    desc = "Combos rapidos e combate agil",
    file = "monk.lua",
    image = BASE_URL .. "monk.png?v=2"
  },

  paladin = {
    name = "PALADIN",
    desc = "Ataques a distancia e precisao",
    file = "paladin.lua",
    image = BASE_URL .. "paladin.png"
  },

  sorcerer = {
    name = "SORCERER",
    desc = "Poder magico e alto dano",
    file = "sorcerer.lua",
    image = BASE_URL .. "sorcerer.png"
  },

  druid = {
    name = "DRUID",
    desc = "Suporte, cura e magia natural",
    file = "druid.lua",
    image = BASE_URL .. "druid.png"
  }
}

local loading = false

-- ============================================================
-- UI
-- ============================================================

g_ui.loadUIFromString([[

Pvp99ClassCard < Button
  width: 96
  height: 64

  background-color: #29231d

  border-width: 1
  border-color: #554735

  color: #efe4cd

  $hover:
    background-color: #382f24
    border-color: #d8ad61

  $pressed:
    background-color: #473929
    border-color: #ffd27a


Pvp99CancelButton < Button
  width: 88
  height: 22

  background-color: #34291f

  border-width: 1
  border-color: #756047

  color: #d8c8aa

  font: verdana-11px-rounded

  $hover:
    background-color: #493725
    border-color: #d4a85b
    color: #fff1cd

  $pressed:
    background-color: #251c16
    border-color: #f0c56d


Pvp99VocationWindow < MainWindow
  id: pvp99VocationWindow

  text: PVP99

  size: 238 292

  @onEscape: self:hide()


  Label
    id: title

    text: ESCOLHA SUA VOCACAO

    anchors.top: parent.top
    anchors.horizontalCenter: parent.horizontalCenter

    margin-top: 4

    color: #e1b765

    font: verdana-11px-rounded


  Label
    id: subtitle

    text: Escolha sua classe

    anchors.top: title.bottom
    anchors.horizontalCenter: parent.horizontalCenter

    margin-top: 2

    color: #c9bda7

    font: verdana-11px-rounded


  -- ========================================================
  -- KNIGHT
  -- ========================================================

  Pvp99ClassCard
    id: knightButton

    anchors.top: subtitle.bottom
    anchors.left: parent.left

    margin-top: 7
    margin-left: 10

    Label
      id: knightImage

      anchors.top: parent.top
      anchors.horizontalCenter: parent.horizontalCenter

      margin-top: 1

      size: 42 40

      opacity: 0.82
      phantom: true

    Label
      id: knightName

      text: KNIGHT

      anchors.bottom: parent.bottom
      anchors.horizontalCenter: parent.horizontalCenter

      margin-bottom: 3

      color: #ffffff

      font: verdana-11px-rounded

      phantom: true

    Label
      id: knightCheck

      text: ✓

      anchors.top: parent.top
      anchors.right: parent.right

      margin-top: 2
      margin-right: 3

      color: #7cff8c

      visible: false
      phantom: true


  -- ========================================================
  -- MONK
  -- ========================================================

  Pvp99ClassCard
    id: monkButton

    anchors.top: subtitle.bottom
    anchors.right: parent.right

    margin-top: 7
    margin-right: 10

    Label
      id: monkImage

      anchors.top: parent.top
      anchors.horizontalCenter: parent.horizontalCenter

      margin-top: 1

      size: 42 40

      opacity: 0.82
      phantom: true

    Label
      id: monkName

      text: MONK

      anchors.bottom: parent.bottom
      anchors.horizontalCenter: parent.horizontalCenter

      margin-bottom: 3

      color: #ffffff

      font: verdana-11px-rounded

      phantom: true

    Label
      id: monkCheck

      text: ✓

      anchors.top: parent.top
      anchors.right: parent.right

      margin-top: 2
      margin-right: 3

      color: #7cff8c

      visible: false
      phantom: true


  -- ========================================================
  -- PALADIN
  -- ========================================================

  Pvp99ClassCard
    id: paladinButton

    anchors.top: knightButton.bottom
    anchors.left: parent.left

    margin-top: 5
    margin-left: 10

    Label
      id: paladinImage

      anchors.top: parent.top
      anchors.horizontalCenter: parent.horizontalCenter

      margin-top: 1

      size: 42 40

      opacity: 0.82
      phantom: true

    Label
      id: paladinName

      text: PALADIN

      anchors.bottom: parent.bottom
      anchors.horizontalCenter: parent.horizontalCenter

      margin-bottom: 3

      color: #ffffff

      font: verdana-11px-rounded

      phantom: true

    Label
      id: paladinCheck

      text: ✓

      anchors.top: parent.top
      anchors.right: parent.right

      margin-top: 2
      margin-right: 3

      color: #7cff8c

      visible: false
      phantom: true


  -- ========================================================
  -- SORCERER
  -- ========================================================

  Pvp99ClassCard
    id: sorcererButton

    anchors.top: monkButton.bottom
    anchors.right: parent.right

    margin-top: 5
    margin-right: 10

    Label
      id: sorcererImage

      anchors.top: parent.top
      anchors.horizontalCenter: parent.horizontalCenter

      margin-top: 1

      size: 42 40

      opacity: 0.82
      phantom: true

    Label
      id: sorcererName

      text: SORCERER

      anchors.bottom: parent.bottom
      anchors.horizontalCenter: parent.horizontalCenter

      margin-bottom: 3

      color: #ffffff

      font: verdana-11px-rounded

      phantom: true

    Label
      id: sorcererCheck

      text: ✓

      anchors.top: parent.top
      anchors.right: parent.right

      margin-top: 2
      margin-right: 3

      color: #7cff8c

      visible: false
      phantom: true


  -- ========================================================
  -- DRUID
  -- ========================================================

  Pvp99ClassCard
    id: druidButton

    anchors.top: paladinButton.bottom
    anchors.horizontalCenter: parent.horizontalCenter

    margin-top: 5

    Label
      id: druidImage

      anchors.top: parent.top
      anchors.horizontalCenter: parent.horizontalCenter

      margin-top: 1

      size: 42 40

      opacity: 0.82
      phantom: true

    Label
      id: druidName

      text: DRUID

      anchors.bottom: parent.bottom
      anchors.horizontalCenter: parent.horizontalCenter

      margin-bottom: 3

      color: #ffffff

      font: verdana-11px-rounded

      phantom: true

    Label
      id: druidCheck

      text: ✓

      anchors.top: parent.top
      anchors.right: parent.right

      margin-top: 2
      margin-right: 3

      color: #7cff8c

      visible: false
      phantom: true


  -- ========================================================
  -- RODAPE
  -- ========================================================

  Label
    id: description

    text: Passe o mouse sobre uma vocacao

    anchors.top: druidButton.bottom
    anchors.horizontalCenter: parent.horizontalCenter

    margin-top: 5

    color: #bba98a

    font: verdana-11px-rounded


  Pvp99CancelButton
    id: cancelButton

    text: CANCELAR

    anchors.top: description.bottom
    anchors.horizontalCenter: parent.horizontalCenter

    margin-top: 5

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
-- ELEMENTOS
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

local images = {
  knight =
    window:recursiveGetChildById("knightImage"),

  monk =
    window:recursiveGetChildById("monkImage"),

  paladin =
    window:recursiveGetChildById("paladinImage"),

  sorcerer =
    window:recursiveGetChildById("sorcererImage"),

  druid =
    window:recursiveGetChildById("druidImage")
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

local description =
  window:recursiveGetChildById(
    "description"
  )

local subtitle =
  window:recursiveGetChildById(
    "subtitle"
  )

-- ============================================================
-- IMAGENS REMOTAS
-- ============================================================

local function loadRemoteImage(widget, url)

  if not widget or
     not url
  then
    return
  end

  HTTP.downloadImage(
    url,

    function(path, err)

      if err then
        print(
          "[PVP99] Erro imagem: " ..
          tostring(err)
        )
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

    end
  )

end

for key, data in pairs(VOCATIONS) do

  loadRemoteImage(
    images[key],
    data.image
  )

end

-- ============================================================
-- HOVER
-- ============================================================

local function setupHover(key)

  local button =
    buttons[key]

  local image =
    images[key]

  local data =
    VOCATIONS[key]

  if not button or not data then
    return
  end


  button.onHoverChange =
    function(widget, hovered)

      if hovered then

        description:setText(
          data.name ..
          " - " ..
          data.desc
        )

        description:setColor(
          "#e0be7a"
        )

        -- "Brilho" leve da imagem
        if image and image.setOpacity then
          image:setOpacity(1.0)
        end

      else

        description:setText(
          "Passe o mouse sobre uma vocacao"
        )

        description:setColor(
          "#bba98a"
        )

        if image and image.setOpacity then
          image:setOpacity(0.82)
        end

      end

    end

end

for key, _ in pairs(VOCATIONS) do
  setupHover(key)
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
-- CARREGAR MACRO
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


  loading = true

  selectVocation(key)


  subtitle:setText(
    "Carregando " ..
    data.name ..
    "..."
  )

  subtitle:setColor(
    "#e4c27d"
  )


  HTTP.get(
    BASE_URL .. data.file,

    function(script)

      loading = false


      if not script or
         script == ""
      then

        clearChecks()

        subtitle:setText(
          "Falha ao carregar"
        )

        subtitle:setColor(
          "#ff6b6b"
        )

        return
      end


      local func, err =
        loadstring(script)


      if not func then

        clearChecks()

        subtitle:setText(
          "Erro no macro"
        )

        subtitle:setColor(
          "#ff6b6b"
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

        clearChecks()

        subtitle:setText(
          "Erro ao executar"
        )

        subtitle:setColor(
          "#ff6b6b"
        )

        print(
          "[PVP99] " ..
          tostring(runError)
        )

        return
      end


      subtitle:setText(
        data.name ..
        " carregado"
      )

      subtitle:setColor(
        "#91e79f"
      )


      schedule(
        350,

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
    loadVocation("knight")
  end

buttons.monk.onClick =
  function()
    loadVocation("monk")
  end

buttons.paladin.onClick =
  function()
    loadVocation("paladin")
  end

buttons.sorcerer.onClick =
  function()
    loadVocation("sorcerer")
  end

buttons.druid.onClick =
  function()
    loadVocation("druid")
  end

-- ============================================================
-- CANCELAR
-- ============================================================

window:recursiveGetChildById(
  "cancelButton"
).onClick =
  function()

    window:hide()

  end

-- ============================================================
-- OPEN
-- ============================================================

window:show()
window:raise()
window:focus()
