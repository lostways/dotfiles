#!/usr/bin/env fish

# Set Theme
#fish_config theme choose "ayu Dark"

function check_anthropic_key
    # Check if ANTHROPIC_API_KEY exists
    if not set -q ANTHROPIC_API_KEY
        echo "ANTHROPIC_API_KEY environment variable is not set"
        echo "Would you like to set it now? [y/N]"
        
        read -l confirm
        
        switch $confirm
            case Y y
                echo "Please enter your Anthropic API key:"
                read -s api_key  # -s flag keeps the input secret
                
                if test -n "$api_key"
                    set -Ux ANTHROPIC_API_KEY $api_key
                    echo "API key has been set as a universal variable"
                    return 0
                else
                    echo "No API key provided. Exiting..."
                    return 1
                end
                
            case '*'
                echo "Setup cancelled. Please set ANTHROPIC_API_KEY manually"
                echo "You can do this by running:"
                echo "set -Ux ANTHROPIC_API_KEY your_api_key_here"
                return 1
        end
    else
        echo "ANTHROPIC_API_KEY is already set"
        return 0
    end
end

# Fisher
echo "\nInstalling Fisher..."
curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher

# Tide
echo "\nInstalling Tide Plugin"
fisher install IlanCosman/tide@v5

# Z
echo "\nInstalling Z Plugin"
fisher install jethrokuan/z

# Alias
echo "\nSetting up aliases..."
alias --save vim="nvim"

# Anthropic API Key
echo "\nChecking for Anthropic API Key..."
check_anthropic_key
