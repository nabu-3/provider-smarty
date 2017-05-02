{strip}
    {if isset($aria_labelledby)} aria-labelledby="{$aria_labelledby}" {/if}
    {if isset($aria_label) && is_string($aria_label)} aria-label="{$aria_label|escape:"html"}"{/if}
{/strip}
