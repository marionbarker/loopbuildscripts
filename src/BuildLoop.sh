#!/bin/bash # script BuildLoop.sh

#!inline common.sh
#!inline run_script.sh

function placeholder() {
    section_divider
    echo -e "  The feature is not available, coming soon"
    echo -e "  This is a placeholder"
    exit_message
}

############################################################
# The rest of this is specific to the particular script
############################################################

FIRST_TIME_SHOWN=0

function first_time_menu() {
    section_separator
    echo -e "${INFO_FONT}Welcome to the Loop and Learn\n  Build-Select Script\n${NC}"
    echo "You will have the opportunity to choose from one of these options:"
    echo "  1 Download and Build Loop"
    echo "  2 Download and Build Related Apps"
    echo "  3 Run Maintenance Utilities"
    echo "  4 Run Customization Utilities"
    echo "  5 Exit Script"
    echo ""
    echo "After completing a given option, you can choose another or exit the script"
    section_divider
    FIRST_TIME_SHOWN=1
}

function repeat_menu() {
    section_separator
    echo -e "Option completed"
    echo -e "You may choose another or exit the script"
    section_divider
}

############################################################
# Welcome & What to do selection
############################################################

while true; do
    if [ FIRST_TIME_SHOWN -eq 0 ]; then
        first_time_menu
    else
        repeat_menu
    fi

    options=(\
        "Build Loop" \
        "Build Related Apps" \
        "Maintenance Utilities" \
        "Customization Utilities" \
        "Exit Script")
    actions=(\
        "WHICH=Loop" \
        "WHICH=OtherApps" \
        "WHICH=UtilityScripts" \
        "WHICH=CustomizationScripts" \
        "cancel_entry")
    menu_select "${options[@]}" "${actions[@]}"

    if [ "$WHICH" = "Loop" ]; then

        run_script "BuildLoopReleased.sh" $CUSTOM_BRANCH

    elif [ "$WHICH" = "OtherApps" ]; then

        section_separator
        echo -e "Select the app you want to build"
        echo -e "  Each selection will indicate documentation links"
        echo -e "  Please read the documentation before using the app"
        echo -e ""
        options=(\
            "Build Loop Follow" \
            "Build LoopCaregiver" \
            "Build xDrip4iOS" \
            "Build Glucose Direct" \
            "Cancel")
        actions=(\
            "WHICH=LoopFollow" \
            "WHICH=LoopCaregiver" \
            "WHICH=xDrip4iOS" \
            "WHICH=GlucoseDirect" \
            "cancel_entry")
        menu_select "${options[@]}" "${actions[@]}"
        if [ "$WHICH" = "LoopFollow" ]; then
            run_script "BuildLoopFollow.sh" $CUSTOM_BRANCH
        elif [ "$WHICH" = "LoopCaregiver" ]; then
            run_script "BuildLoopCaregiver.sh" $CUSTOM_BRANCH
        elif [ "$WHICH" = "xDrip4iOS" ]; then
            run_script "BuildxDrip4iOS.sh" $CUSTOM_BRANCH
        elif [ "$WHICH" = "GlucoseDirect" ]; then
            run_script "BuildGlucoseDirect.sh" $CUSTOM_BRANCH
        fi

    elif [ "$WHICH" = "UtilityScripts" ]; then

        section_separator
        echo -e "${INFO_FONT}These utility scripts automate several cleanup actions${NC}"
        echo -e ""
        echo -e " 1. Delete Old Downloads:"
        echo -e "     This will keep the most recent download for each build type"
        echo -e "     It asks before deleting any folders"
        echo -e " 2. Clean Derived Data:"
        echo -e "     Free space on your disk from old Xcode builds."
        echo -e "     You should quit Xcode before running this script."
        echo -e " 3. Xcode Cleanup (The Big One):"
        echo -e "     Clears more disk space filled up by using Xcode."
        echo -e "     * Use after uninstalling Xcode prior to new installation"
        echo -e "     * It can free up a substantial amount of disk space"
        section_divider

        options=(
            "Delete Old Downloads"
            "Clean Derived Data"
            "Xcode Cleanup"
            "Cancel"
        )
        actions=(
            "run_script 'DeleteOldDownloads.sh'"
            "run_script 'CleanDerived.sh'"
            "run_script 'XcodeClean.sh'"
            "cancel_entry"
        )
        menu_select "${options[@]}" "${actions[@]}"

    else
        section_separator
        echo -e "${INFO_FONT}Selectable Customizations for:${NC}"
        echo -e "    Released code: Loop or Loop with Patches"
        echo -e "    Might work for development branches of Loop"
        echo -e ""
        echo -e "Reports status for each customization:"
        echo -e "    can be or has been applied or is not applicable"
        echo -e ""
        echo -e "Automatically finds most recent Loop download unless"
        echo -e "    terminal is already at the LoopWorkspace folder level"
        section_divider

        options=(
            "Loop Customizations"
            "Placeholder"
            "Cancel"
        )
        actions=(
            "run_script 'CustomizationSelect.sh'"
            "placeholder"
            "cancel_entry"
        )
        menu_select "${options[@]}" "${actions[@]}"
    fi
done
