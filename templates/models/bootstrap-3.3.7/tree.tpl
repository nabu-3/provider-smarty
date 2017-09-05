{nabu_model model="bootstrap-3.3.7"}
{if isset($metadata) && is_array($metadata)}
    {if array_key_exists('toolbar', $metadata) && is_array($metadata.toolbar)}
        {assign var=toolbar value=$metadata.toolbar}
    {else}
        {assign var=toolbar value=false}
    {/if}
    {if array_key_exists('translations', $metadata) && is_array($metadata.translations)}
        {assign var=translations value=$metadata.translations}
    {else}
        {assign var=translations value=false}
    {/if}
{/if}
{if !isset($selectable)}
    {assign var=selectable value=false}
{/if}
{assign var=api_url value=false}
{if isset($api)}
    {nabu_exists cta=$api}
        {nabu_assign var=api_cta cta=$api}
        {if is_array($api_cta.translation)}
            {assign var=api_url value=$api_cta.translation.final_url}
        {elseif $nb_site.api_language_id && array_key_exists($nb_site.api_language_id, $api_cta.translations)}
            {assign var=api_url value=$api_cta.translations[$nb_site.api_language_id].final_url}
        {else}
            {foreach from=$api_cta.translations item=translation}
                {assign var=api_url value=$translation.final_url}
                {break}
            {/foreach}
        {/if}
    {nabu_exists_else}
        {assign var=api_url value=$api}
    {/nabu_exists}
{/if}
{assign var=editor_url value=false}
{if isset($editor)}
    {nabu_exists cta=$editor}
        {nabu_assign var=editor_cta cta=$editor}
        {if is_array($editor_cta.translation)}
            {assign var=editor_url value=$editor_cta.translation.final_url}
        {elseif $nb_site.api_language_id && array_key_exists($nb_site.api_language_id, $editor_cta.translations)}
            {assign var=editor_url value=$editor_cta.translations[$nb_site.api_language_id].final_url}
        {else}
            {foreach from=$editor_cta.translations item=translation}
                {assign var=editor_url value=$translation.final_url}
                {break}
            {/foreach}
        {/if}
    {nabu_exists_else}
        {assign var=editor_url value=$editor}
    {/nabu_exists}
    {if is_string($editor_url) && (!isset($editor_mode) || ($editor_mode!=='ajax' && $editor_mode!=='page'))}
        {assign var=editor_mode value=page}
    {/if}
{/if}
{if isset($data) || isset($draw_empty) && $draw_empty}
    {strip}<div{if isset($id) && strlen($id)>0} id="{$id}"{/if} class="tree-container" data-toggle="nabu-tree"
            {if is_string($api_url)} data-api="{$api_url}"{/if}
            {if is_string($editor_url)} data-editor="{$editor_url}" data-editor-mode="{$editor_mode}"
                {if $editor_mode==="ajax" && isset($editor_container) && strlen($editor_container)>0} data-editor-container="{$editor_container}"{/if}
            {/if}
            {if isset($edit_button)} data-edit-button="{$edit_button}"{/if}
    >{/strip}
        {if $toolbar}
            <div class="tree-toolbar btn-toolbar">
                {if isset($search) && $search}
                    <div class="btn-group pull-right tree-search">
                        <div class="input-group input-group-sm">
                            <input type="search" class="form-control">
                            <span class="input-group-btn"><button type="button" class="btn btn-default btn-search" data-apply="all" title="{if $translations && array_key_exists('search_button', $translations)}{$translations.search_button}{else}Search{/if}"><i class="fa fa-search"></i></button></span>
                        </div>
                    </div>
                {/if}
                {if array_key_exists('groups', $toolbar) && count($toolbar.groups) > 0}
                    {foreach from=$toolbar.groups item=group}
                        {if is_array($group) && array_key_exists('buttons', $group) && count($group.buttons) > 0}
                            <div class="btn-group{if array_key_exists('align', $group) && strlen($group.align)>0} pull-{$group.align}{/if}">
                                {foreach from=$group.buttons key=action item=button}
                                    {if !array_key_exists('modal', $button) || strlen($button.modal) === 0}
                                        {strip}
                                            <button class="btn btn-sm{if array_key_exists('type', $button) && strlen($button.type)>0} btn-{$button.type}{/if}" data-action="{$action}"
                                                    {if array_key_exists('apply', $button)} data-apply="{$button.apply}"{/if} type="button">
                                                {if array_key_exists('icon', $button) && strlen($button.icon)>0}<i class="{$button.icon}"></i>{/if}
                                                {if array_key_exists('name', $button) && strlen($button.name)>0}{$button.name}{/if}
                                            </button>
                                        {/strip}
                                    {else}
                                        {strip}
                                            {if !array_key_exists('type', $button)}{assign var=type value=null}{else}{assign var=type value=$button.type}{/if}
                                            {if array_key_exists('icon', $button) && strlen($button.icon)>0}{assign var=anchor value="<i class=\"{$button.icon}\"></i>"}{/if}
                                            {if array_key_exists('apply', $button) && strlen($button.apply)>0}{assign var=apply value=$button.apply}{else}{assign var=apply value=null}{/if}
                                            {nabu_open_modal mode=button type=$type size=sm target=$button.modal anchor_text=$anchor action=$action apply=$apply}
                                        {/strip}
                                    {/if}
                                {/foreach}
                            </div>
                        {/if}
                    {/foreach}
                {/if}
            </div>
        {else}
            {if (isset($search) && $search) || (isset($column_selector) && $column_selector)}
                <div class="tree-controls form-inline">
                    {if isset($search)}
                        <div class="input-group tree-search">
                            <input type="search" class="form-control">
                            <span class="input-group-btn"><button type="button" class="btn btn-default btn-search">Search</button></span>
                        </div>
                    {/if}
                </div>
            {/if}
        {/if}

        <div class="tree{if isset($bordered)} tree-bordered{/if}{if isset($hover)} tree-hover{/if}{if isset($scrolled)} tree-scrolled{/if}" data-toggle="nabu-drag-and-drop">
            <div class="tree-inner dad-inner"{if isset($languages) && is_array($languages)} data-toggle="toggable-lang"{/if}>
                {include file="tree-child.tpl" data=$data}
            </div>
        </div>
    </div>
{/if}
