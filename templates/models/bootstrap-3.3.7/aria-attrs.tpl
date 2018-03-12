{strip}
    {if isset($aria_labelledby)} aria-labelledby="{$aria_labelledby}" {/if}
    {if isset($aria_label) && is_string($aria_label)} aria-label="{$aria_label|escape:"html"}"{/if}
    {if isset($aria_hidden) && is_string($aria_hidden)} aria-hidden="{$aria_hidden|escape:"html"}"{/if}
    {if isset($role) && is_string($role)} role="{$role}"{/if}
{/strip}
