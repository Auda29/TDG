import re

def update_tscn():
    with open('../../scenes/ui/mvp_hud.tscn', 'r', encoding='utf-8') as f:
        lines = f.readlines()
    
    # 1. Update BossBar offset (move down slightly if needed, wait, boss bar is at top, let's keep it but offset it below TopBar)
    content = "".join(lines)
    
    # Actually, we find node names and replace their blocks.
    # SelectedPanel
    content = re.sub(
        r'\[node name="SelectedPanel" type="PanelContainer" parent="."\]\s*layout_mode = 0.*?offset_bottom = -8.0',
        r'''[node name="SelectedPanel" type="PanelContainer" parent="."]
layout_mode = 1
anchors_preset = 11
anchor_left = 1.0
anchor_top = 0.0
anchor_right = 1.0
anchor_bottom = 1.0
offset_left = -352.0
offset_top = 64.0
offset_right = -20.0
offset_bottom = -64.0''',
        content,
        flags=re.DOTALL
    )

    # BuildDrawerPanel
    content = re.sub(
        r'\[node name="BuildDrawerPanel" type="PanelContainer" parent="."\]\s*layout_mode = 0.*?offset_bottom = -8.0',
        r'''[node name="BuildDrawerPanel" type="PanelContainer" parent="."]
layout_mode = 1
anchors_preset = 9
anchor_left = 0.0
anchor_top = 0.0
anchor_right = 0.0
anchor_bottom = 1.0
offset_left = 20.0
offset_top = 64.0
offset_right = 352.0
offset_bottom = -64.0''',
        content,
        flags=re.DOTALL
    )

    # BuildDrawerToggle
    content = re.sub(
        r'\[node name="BuildDrawerToggle" type="Button" parent="."\]\s*layout_mode = 0.*?offset_bottom = 216.0',
        r'''[node name="BuildDrawerToggle" type="Button" parent="."]
layout_mode = 1
anchors_preset = 9
anchor_left = 0.0
anchor_top = 0.0
anchor_right = 0.0
anchor_bottom = 0.0
offset_left = 360.0
offset_top = 168.0
offset_right = 396.0
offset_bottom = 216.0''',
        content,
        flags=re.DOTALL
    )

    # Cut off at BottomBar and replace
    bottom_bar_idx = content.find('[node name="BottomBar"')
    if bottom_bar_idx == -1:
        print("BottomBar not found!")
        return

    content = content[:bottom_bar_idx]
    
    new_ui = """[node name="TopBar" type="PanelContainer" parent="."]
layout_mode = 1
anchors_preset = 10
anchor_right = 1.0
offset_bottom = 48.0
grow_horizontal = 2
mouse_filter = 1

[node name="Margin" type="MarginContainer" parent="TopBar"]
layout_mode = 2
theme_override_constants/margin_left = 24
theme_override_constants/margin_top = 8
theme_override_constants/margin_right = 24
theme_override_constants/margin_bottom = 8

[node name="TopHBox" type="HBoxContainer" parent="TopBar/Margin"]
layout_mode = 2
theme_override_constants/separation = 32

[node name="ResourceHBox" type="HBoxContainer" parent="TopBar/Margin/TopHBox"]
layout_mode = 2
size_flags_horizontal = 3
theme_override_constants/separation = 24

[node name="BaseLabel" type="Label" parent="TopBar/Margin/TopHBox/ResourceHBox"]
layout_mode = 2
text = ""

[node name="CreditsLabel" type="Label" parent="TopBar/Margin/TopHBox/ResourceHBox"]
layout_mode = 2
text = ""

[node name="WaveHBox" type="HBoxContainer" parent="TopBar/Margin/TopHBox"]
layout_mode = 2
theme_override_constants/separation = 16

[node name="WaveLabel" type="Label" parent="TopBar/Margin/TopHBox/WaveHBox"]
layout_mode = 2
text = ""

[node name="WaveFlowHBox" type="HBoxContainer" parent="TopBar/Margin/TopHBox"]
layout_mode = 2
size_flags_horizontal = 3
alignment = 2
theme_override_constants/separation = 12

[node name="PauseButton" type="Button" parent="TopBar/Margin/TopHBox/WaveFlowHBox"]
layout_mode = 2
text = ""

[node name="AutoWaveButton" type="CheckButton" parent="TopBar/Margin/TopHBox/WaveFlowHBox"]
layout_mode = 2
text = ""

[node name="NextWaveButton" type="Button" parent="TopBar/Margin/TopHBox/WaveFlowHBox"]
layout_mode = 2
text = ""

[node name="SettingsButton" type="Button" parent="TopBar/Margin/TopHBox/WaveFlowHBox"]
layout_mode = 2
text = ""

[node name="BottomBar" type="PanelContainer" parent="."]
layout_mode = 1
anchors_preset = 12
anchor_top = 1.0
anchor_right = 1.0
anchor_bottom = 1.0
offset_top = -48.0
grow_horizontal = 2
grow_vertical = 0
mouse_filter = 1

[node name="Margin" type="MarginContainer" parent="BottomBar"]
layout_mode = 2
theme_override_constants/margin_left = 24
theme_override_constants/margin_top = 8
theme_override_constants/margin_right = 24
theme_override_constants/margin_bottom = 8

[node name="BottomHBox" type="HBoxContainer" parent="BottomBar/Margin"]
layout_mode = 2
theme_override_constants/separation = 24

[node name="ModeLabel" type="Label" parent="BottomBar/Margin/BottomHBox"]
layout_mode = 2

[node name="PlacementLabel" type="Label" parent="BottomBar/Margin/BottomHBox"]
layout_mode = 2

[node name="CommanderLabel" type="Label" parent="BottomBar/Margin/BottomHBox"]
layout_mode = 2

[node name="HintLabel" type="Label" parent="BottomBar/Margin/BottomHBox"]
layout_mode = 2
size_flags_horizontal = 3
horizontal_alignment = 2
autowrap_mode = 3

[node name="MessagesVBox" type="VBoxContainer" parent="."]
layout_mode = 1
anchors_preset = 10
anchor_right = 1.0
offset_top = 64.0
offset_bottom = 104.0
mouse_filter = 2

[node name="EventLabel" type="Label" parent="MessagesVBox"]
layout_mode = 2
horizontal_alignment = 1

[node name="ThreatLabel" type="Label" parent="MessagesVBox"]
layout_mode = 2
horizontal_alignment = 1

"""
    content += new_ui
    
    with open('../../scenes/ui/mvp_hud.tscn', 'w', encoding='utf-8') as f:
        f.write(content)

def update_gd():
    with open('../../scripts/ui/mvp_hud.gd', 'r', encoding='utf-8') as f:
        content = f.read()

    # Replacements in variables
    content = re.sub(
        r'@onready var bottom_bar: PanelContainer = \$BottomBar.*?@onready var hint_label[^=]*= [^\n]*\n',
        r'''@onready var top_bar: PanelContainer = $TopBar
@onready var bottom_bar: PanelContainer = $BottomBar
@onready var base_label: Label = $TopBar/Margin/TopHBox/ResourceHBox/BaseLabel
@onready var credits_label: Label = $TopBar/Margin/TopHBox/ResourceHBox/CreditsLabel
@onready var wave_label: Label = $TopBar/Margin/TopHBox/WaveHBox/WaveLabel
@onready var pause_button: Button = $TopBar/Margin/TopHBox/WaveFlowHBox/PauseButton
@onready var auto_wave_button: CheckButton = $TopBar/Margin/TopHBox/WaveFlowHBox/AutoWaveButton
@onready var next_wave_button: Button = $TopBar/Margin/TopHBox/WaveFlowHBox/NextWaveButton
@onready var settings_button: Button = $TopBar/Margin/TopHBox/WaveFlowHBox/SettingsButton
@onready var mode_label: Label = $BottomBar/Margin/BottomHBox/ModeLabel
@onready var placement_label: Label = $BottomBar/Margin/BottomHBox/PlacementLabel
@onready var commander_label: Label = $BottomBar/Margin/BottomHBox/CommanderLabel
@onready var hint_label: Label = $BottomBar/Margin/BottomHBox/HintLabel
@onready var event_label: Label = $MessagesVBox/EventLabel
@onready var threat_label: Label = $MessagesVBox/ThreatLabel
''',
        content,
        flags=re.DOTALL
    )
    
    # Remove old center panel stuff
    content = re.sub(
        r'@onready var flow_title_label[^=]*= [^\n]*\n', '', content
    )
    content = re.sub(
        r'@onready var pause_button[^=]*= [^\n]*\n.*?@onready var settings_button[^=]*= [^\n]*\n', '', content, flags=re.DOTALL
    )
    
    content = re.sub(r'status_panel\.self_modulate.*?\n', '', content)
    content = re.sub(r'center_panel\.self_modulate.*?\n', '', content)
    content = re.sub(r'bottom_bar\.self_modulate\s*=\s*UI_PANEL_TINT', 'bottom_bar.self_modulate = UI_PANEL_TINT\n\ttop_bar.self_modulate = UI_PANEL_TINT', content)
    
    content = re.sub(r'flow_title_label\.add_theme_color_override.*?\n', '', content)
    content = re.sub(r'flow_title_label\.text.*?\n', '', content)
    

    with open('../../scripts/ui/mvp_hud.gd', 'w', encoding='utf-8') as f:
        f.write(content)

if __name__ == "__main__":
    update_tscn()
    update_gd()
    print("Done")
