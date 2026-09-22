-- ============================================================
-- PVP99 - SELETOR DE VOCACAO
-- IMAGENS REMOTAS + MACROS REMOTOS
-- ============================================================

local BASE_URL =
  "https://raw.githubusercontent.com/oficiallpvp99/PVP99-Caves/refs/heads/main/"

-- Se trocar alguma imagem no GitHub e quiser forcar a atualizacao
-- no mesmo OTClient, mude 1 para 2, depois 3, etc.
local IMAGE_VERSION = "1"

local VOCATIONS = {

  knight = {
    name = "KNIGHT",
    file = "knight.lua",
    image = BASE_URL .. "knight.png?v=" .. IMAGE_VERSION
  },

  monk = {
    name = "MONK",
    file = "monk.lua",

    -- ATENCAO:
    -- no seu GitHub esta monk.PNG com PNG maiusculo
    image = BASE_URL .. "monk.PNG?v=" .. IMAGE_VERSION
  },

  paladin = {
    name = "PALADIN",
    file = "paladin.lua",
    image = BASE_URL .. "paladin.png?v=" .. IMAGE_VERSION
  },

  sorcerer = {
    name = "SORCERER",
    file = "sorcerer.lua",
    image = BASE_URL .. "sorcerer.png?v=" .. IMAGE_VERSION
  },

  druid = {
    name = "DRUID",
    file = "druid.lua",
    image = BASE_URL .. "druid.png?v=" .. IMAGE_VERSION
  }

}

local loading = false


-- ============================================================
-- INTERFACE
-- ============================================================

g_ui.loadUIFromString([[

Pvp99VocationCard < Button
  width: 102
  height: 62

  background-color: #29272d

  border-width: 1
  border-color: #45414b

  color: #ffffff

  font: verdana-11px-rounded

  text-align: bottom
  text-offset: 0 -3

  $hover:
    background-color: #342b3a
    border-color: #d65cff
    color: #ffffff

  $pressed:
    background-color: #412d49
    border-color: #f486ff
    color: #ffffff


Pvp99VocationWindow < MainWindow

  id: pvp99VocationWindow

  text: PVP99

  size: 248 280

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
      id: knightCheck

      text: ✓

      anchors.top: parent.top
      anchors.right: parent.right

      margin-top: 2
      margin-right: 4

      color: #5cff7c

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
      id: monkCheck

      text: ✓

      anchors.top: parent.top
      anchors.right: parent.right

      margin-top: 2
      margin-right: 4

      color: #5cff7c

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
      id: paladinCheck

      text: ✓

      anchors.top: parent.top
      anchors.right: parent.right

      margin-top: 2
      margin-right: 4

      color: #5cff7c

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
      id: sorcererCheck

      text: ✓

      anchors.top: parent.top
      anchors.right: parent.right

      margin-top: 2
      margin-right: 4

      color: #5cff7c

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
      id: druidCheck

      text: ✓

      anchors.top: parent.top
      anchors.right: parent.right

      margin-top: 2
      margin-right: 4

      color: #5cff7c

      font: verdana-11px-rounded

      visible: false
      phantom: true


  Button
    id: cancelButton

    text: CANCELAR

    width: 82
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


-- Remove janela antiga se executar o loader novamente
local oldWindow =
  root:recursiveGetChildById(
    "pvp99VocationWindow"
  )

if oldWindow then
  oldWindow:destroy()
end


local window =
  UI.createWindow(
    "Pvp99VocationWindow",
    root
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


local subtitle =
  window:recursiveGetChildById(
    "subtitle"
  )


-- ============================================================
-- IMAGENS REMOTAS
-- ============================================================

local function createRemoteImage(button, url)

  if not button or
     not url
  then
    return
  end


  local image =
    g_ui.createWidget(
      "UIImage",
      button
    )


  if not image then
    return
  end


  -- Area reservada para a arte
  image:setSize({
    width = 46,
    height = 42
  })


  image:addAnchor(
    AnchorTop,
    "parent",
    AnchorTop
  )


  image:addAnchor(
    AnchorHorizontalCenter,
    "parent",
    AnchorHorizontalCenter
  )


  image:setMarginTop(2)

  image:setPhantom(true)


  -- Mantem a proporcao original da imagem
  if image.setImageFixedRatio then
    image:setImageFixedRatio(true)
  end


  if image.setImageSmooth then
    image:setImageSmooth(true)
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


      if image then
        image:setImageSource(path)
      end

    end
  )

end


-- Baixa e mostra as cinco imagens
for key, data in pairs(VOCATIONS) do

  createRemoteImage(
    buttons[key],
    data.image
  )

end


-- ============================================================
-- CHECK DE SELECAO
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

  local check =
    checks[key]

  if check then
    check:show()
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


  -- Nao coloca mensagem verde grande.
  -- Mantem somente o pequeno check.
  subtitle:setText(
    "Carregando " ..
    data.name ..
    "..."
  )

  subtitle:setColor(
    "#d8b4e3"
  )


  HTTP.get(

    BASE_URL .. data.file,

    function(script, err)


      loading = false


      -- ERRO DE DOWNLOAD
      if err or
         not script or
         script == ""
      then

        clearChecks()

        subtitle:setText(
          "Falha ao carregar"
        )

        subtitle:setColor(
          "#ff6666"
        )

        print(
          "[PVP99] Download " ..
          data.name ..
          ": " ..
          tostring(err)
        )

        return
      end


      -- COMPILA LUA
      local func, luaError =
        loadstring(script)


      if not func then

        clearChecks()

        subtitle:setText(
          "Erro no macro"
        )

        subtitle:setColor(
          "#ff6666"
        )

        print(
          "[PVP99] Lua " ..
          data.name ..
          ": " ..
          tostring(luaError)
        )

        return
      end


      -- EXECUTA PROTEGIDO
      local ok, runError =
        pcall(func)


      if not ok then

        clearChecks()

        subtitle:setText(
          "Erro ao executar"
        )

        subtitle:setColor(
          "#ff6666"
        )

        print(
          "[PVP99] Execucao " ..
          data.name ..
          ": " ..
          tostring(runError)
        )

        return
      end


      -- SUCESSO
      subtitle:setText(
        data.name ..
        " carregado"
      )

      subtitle:setColor(
        "#aee8b9"
      )


      -- deixa o check aparecer rapidamente
      -- e fecha a janela
      schedule(
        450,

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
