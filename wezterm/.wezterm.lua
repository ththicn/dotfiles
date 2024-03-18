local wezterm = require 'wezterm'

local config = {}

if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- カラースキームの設定(おすすめはMaterialDesignColors)
config.color_scheme = 'MaterialDesignColors'

-- 背景透過
config.window_background_opacity = 0.85

-- 最初からフルスクリーンで起動
local mux = wezterm.mux
wezterm.on("gui-startup", function(cmd)
    local tab, pane, window = mux.spawn_window(cmd or {})
    window:gui_window():toggle_fullscreen()
end)

-- フォントの設定
config.font = wezterm.font("Cica", {weight="Medium", stretch="Normal", style="Normal"})

-- フォントサイズの設定
config.font_size = 16

return config
