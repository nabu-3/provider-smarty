{strip}
    {if isset($class) && strlen($class) > 0}
        {assign var=class value="btn-toolbar {$class}"}
    {else}
        {assign var=class value="btn-toolbar"}
    {/if}
    {assign var=role value=toolbar}
    <div {include file="general-attrs.tpl"} {include file="aria-attrs.tpl"}>
{/strip}
