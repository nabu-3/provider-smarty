{strip}
{if isset($class) && is_string($class)}
    {assign var=class value="{$class} alert"}
{else}
    {assign var=class value="alert"}
{/if}
{if isset($type) && is_string($type) && strlen($type)>0}
    {assign var=class value="{$class} alert-{$type}"}
{/if}
{if isset($dismissible) && $dismissible===true}
    {assign var=class value="{$class} alert-dimissible"}
{/if}
{if !isset($role)}
    {assign var=role value=alert}
{/if}
{if isset($fade) && $fade===true}
    {assign var=class value="{$class} fade in"}
{/if}
<div role="alert"
     {include file="general-attrs.tpl"}
     {include file="aria-attrs.tpl"}
>{/strip}
    {strip}
        {if isset($dismissible) && $dismissible===true}
            <button type="button" class="close" data-dismiss="alert"
                    {if isset($aria_hidden) && is_string($aria_hidden)} aria-hidden="{$aria_hidden|escape:"html"}"{/if}
            >
                <span aria-hidden="true">&times;</span>
            </button>
        {/if}
    {/strip}
