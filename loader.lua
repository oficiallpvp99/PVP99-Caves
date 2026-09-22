-- ============================================================
-- PVP99 - SELETOR DE VOCACAO
-- IMAGENS REMOTAS + MACROS REMOTOS
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

-- ============================================================
-- INTERFACE
-- ============================================================

g_ui.loadUIFromString([[

Pvp99VocationCard < Button
  width: 100
  height: 66

  background-color: #29272d

  border-width: 1
  border-color: #45414b

  color: #ffffff

  font: verdana-11px-rounded

  text-align: bottom
  text-offset: 0 -3

  $hover:
    background-color: #352c3b
    border-color: #d65cff
    color: #ffffff

  $pressed:
    background-color: #402f47
    border-color: #ef80ff


Pvp99VocationWindow < MainWindow
  id: pvp99VocationWindow

  text: PVP99

  size: 246 285

  @onEscape: self:hide()


  Label
    id: title

    text: ESCOLHA SUA VOCACAO

    anchors.top: parent.top
    anchors.horizontalCenter: parent.horizontalCenter

    margin-top: 4

    color: #ed78ff

    font: verdana-11px-rounded


  Label
    id: subtitle

    text: Selecione o macro

    anchors.top: title.bottom
    anchors.horizontalCenter: parent.horizontalCenter

    margin-top: 2

    color: #c5c0c8

    font: verdana-11px-rounded


  Pvp99VocationCard
    id: knightButton

    text: KNIGHT

    anchors.top: subtitle.bottom
    anchors.left: parent.left

    margin-top: 8
    margin-left: 10

    Label
      id: knightImage

      anchors.top: parent.top
      anchors.horizontalCenter: parent.horizontalCenter

      margin-top: 2

      size: 46 44

      phantom: true

    Label
      id: knightCheck

      text: OK

      anchors.top: parent.top
      anchors.right: parent.right

      margin-top: 2
      margin-right: 3

      color: #55ff77

      font: verdana-11px-rounded

      visible: false
      phantom: true


  Pvp99VocationCard
    id: monkButton

    text: MONK

    anchors.top: subtitle.bottom
    anchors.right: parent.right

    margin-top: 8
    margin-right: 10

    Label
      id: monkImage

      anchors.top: parent.top
      anchors.horizontalCenter: parent.horizontalCenter

      margin-top: 2

      size: 46 44

      phantom: true

    Label
      id: monkCheck

      text: OK

      anchors.top: parent.top
      anchors.right: parent.right

      margin-top: 2
      margin-right: 3

      color: #55ff77

      font: verdana-11px-rounded

      visible: false
      phantom: true


  Pvp99VocationCard
    id: paladinButton

    text: PALADIN

    anchors.top: knightButton.bottom
    anchors.left: parent.left

    margin-top: 5
    margin-left: 10

    Label
      id: paladinImage

      anchors.top: parent.top
      anchors.horizontalCenter: parent.horizontalCenter

      margin-top: 2

      size: 46 44

      phantom: true

    Label
      id: paladinCheck

      text: OK

      anchors.top: parent.top
      anchors.right: parent.right

      margin-top: 2
      margin-right: 3

      color: #55ff77

      font: verdana-11px-rounded

      visible: false
      phantom: true


  Pvp99VocationCard
    id: sorcererButton

    text: SORCERER

    anchors.top: monkButton.bottom
    anchors.right: parent.right

    margin-top: 5
    margin-right: 10

    Label
      id: sorcererImage

      anchors.top: parent.top
      anchors.horizontalCenter: parent.horizontalCenter

      margin-top: 2

      size: 46 44

      phantom: true

    Label
      id: sorcererCheck

      text: OK

      anchors.top: parent.top
      anchors.right: parent.right

      margin-top: 2
      margin-right: 3

      color: #55ff77

      font: verdana-11px-rounded

      visible: false
      phantom: true


  Pvp99VocationCard
    id: druidButton

    text: DRUID

    anchors.top: paladinButton.bottom
    anchors.horizontalCenter: parent.horizontalCenter

    margin-top: 5

    Label
      id: druidImage

      anchors.top: parent.top
      anchors.horizontalCenter: parent.horizontalCenter

      margin-top: 2

      size: 46 44

      phantom: true

    Label
      id: druidCheck

      text: OK

      anchors.top: parent.top
      anchors.right: parent.right

      margin-top: 2
      margin-right: 3

      color: #55ff77

      font: verdana-11px-rounded

      visible: false
      phantom: true


  Button
    id: cancelButton

    text: CANCELAR

    width: 80
    height: 21

    anchors.top: druidButton.bottom
    anchors.horizontalCenter: parent.horizontalCenter

    margin-top: 6

]])

-- ============================================================
-- CRIA JANELA
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

-- ============================================================
-- ELEMENTOS
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

local images = {

  knight =
    window:recursiveGetChildById(
      "knightImage"
    ),

  monk =
    window:recursiveGetChildById(
      "monkImage"
    ),

  paladin =
    window:recursiveGetChildById(
      "paladinImage"
    ),

  sorcerer =
    window:recursiveGetChildById(
      "sorcererImage"
    ),

  druid =
    window:recursiveGetChildById(
      "druidImage"
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
-- SELECAO
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
-- CARREGA MACRO
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

  HTTP.get(
    BASE_URL .. data.file,

    function(script)

      loading = false

      if not script or
         script == ""
      then

        clearChecks()

        print(
          "[PVP99] Falha ao baixar " ..
          data.name
        )

        return
      end

      local func, err =
        loadstring(script)

      if not func then

        clearChecks()

        print(
          "[PVP99] Erro no " ..
          data.name ..
          ": " ..
          tostring(err)
        )

        return
      end

      local ok, runError =
        pcall(func)

      if not ok then

        clearChecks()

        print(
          "[PVP99] Erro executando " ..
          data.name ..
          ": " ..
          tostring(runError)
        )

        return
      end

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
-- ABRIR
-- ============================================================

window:show()
window:raise()
window:focus()
