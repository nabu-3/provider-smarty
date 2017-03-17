{nabu_model model="bootstrap-3.3.7"}
{if isset($metadata) && is_array($metadata)}
    {if array_key_exists('fields', $metadata) && is_array($metadata.fields)}
        {assign var=fields value=$metadata.fields}
    {else}
        {assign var=fields value=false}
    {/if}
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
{else}
    {assign var=fields value=false}
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
    {strip}<div{if isset($id) && strlen($id)>0} id="{$id}"{/if} class="table-container" data-toggle="nabu-table"
            {if isset($size)} data-table-size="{$size}"{/if}
            {if is_string($api_url)} data-api="{$api_url}"{/if}
            {if is_string($editor_url)} data-editor="{$editor_url}" data-editor-mode="{$editor_mode}"
                {if $editor_mode==="ajax" && isset($editor_container) && strlen($editor_container)>0} data-editor-container="{$editor_container}"{/if}
            {/if}
            {if isset($edit_button)} data-edit-button="{$edit_button}"{/if}
    >{/strip}
        {if $toolbar}
            <div class="table-toolbar btn-toolbar">
                {if isset($column_selector) && fields && count($fields)>0}
                    {if $translations && array_key_exists('columns_button', $translations)}
                        {assign var=btn_name value=$translations.columns_button}
                    {else}
                        {assign var=btn_nme value="Columns"}
                    {/if}
                    <div class="btn-group pull-right table-columns-selector">
                        <button type="button" class="btn btn-sm btn-columns" data-toggle="dropdown" data-apply="all" aria-haspopup="true" aria-expanded="false" title="{$btn_name}"><i class="fa fa-columns"></i></button>
                        <button type="button" class="btn btn-sm btn-columns dropdown-toggle" data-toggle="dropdown" data-apply="all" aria-haspopup="true" aria-expanded="false" title="{$btn_name}">
                            <span class="caret"></span>
                            <span class="sr-only">{$btn_name}</span>
                        </button>
                        <ul class="dropdown-menu">
                            {foreach from=$metadata.fields item=field}
                                <li><a href="#"><i class="fa fa-square-o"></i>&nbsp;{$field.title}</a></li>
                            {/foreach}
                            <li role="separator" class="divider"></li>
                            <li><a href="#">{if $translations && array_key_exists('show_all_columns', $translations)}{$translations.show_all_columns}{else}Show all{/if}</a></li>
                            <li><a href="#">{if $translations && array_key_exists('hide_all_columns', $translations)}{$translations.hide_all_columns}{else}Hide all{/if}</a></li>
                        </ul>
                    </div>
                {/if}
                {if isset($search) && $search}
                    <div class="btn-group pull-right table-search">
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
                <div class="table-controls form-inline">
                    {if isset($search)}
                        <div class="input-group table-search">
                            <input type="search" class="form-control">
                            <span class="input-group-btn"><button type="button" class="btn btn-default btn-search">Search</button></span>
                        </div>
                    {/if}
                    {if isset($column_selector) && $fields && count($fields) > 0}
                        <div class="btn-group table-columns-selector">
                            <button type="button" class="btn btn-columns" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">Columns</button>
                            <button type="button" class="btn btn-columns dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                <span class="caret"></span>
                                <span class="sr-only">Toggle Dropdown</span>
                            </button>
                            <ul class="dropdown-menu">
                                {foreach from=$metadata['fields'] item=field}
                                    <li><a href="#"><i class="fa fa-square-o"></i>&nbsp;{$field.title}</a></li>
                                {/foreach}
                                <li role="separator" class="divider"></li>
                                <li><a href="#">Show all</a></li>
                                <li><a href="#">Hide all</a></li>
                            </ul>
                        </div>
                    {/if}
                </div>
            {/if}
        {/if}
        <table class="table{if isset($striped)} table-striped{/if}{if isset($bordered)} table-bordered{/if}{if isset($hover)} table-hover{/if}{if isset($condensed)} table-condensed{/if}">
            {assign var=field_id value=false}
            {if $fields && count($fields) > 0}
                <thead>
                    <tr>
                        {if $selectable}<th class="col-selectable" data-toggle="table-selectable"><input type="checkbox"></th>{/if}
                        {foreach from=$fields key=kfield item=field}
                            {if array_key_exists('order', $field)}
                                {assign var=ordered value=$field.order}
                            {else}
                                {assign var=ordered value=false}
                            {/if}
                            {if array_key_exists('id', $field) && $field.id===true}
                                {assign var=field_id value=$kfield}
                            {/if}
                            <th data-name="{$kfield}"{if $ordered} data-order="{$field.order}"{/if}>{$field.title}{if $ordered}<button class="btn btn-xs btn-order pull-right"><i class="fa fa-sort"></i></button>{/if}</th>
                        {/foreach}
                        {if isset($edit_button) && $edit_button==='button'}<th width="*"></th>{/if}
                    </tr>
                </thead>
            {/if}
            <tbody>
                {if isset($draw_empty) && $draw_empty && isset($empty_message) && strlen($empty_message)>0}<tr class="table-empty-row{if is_array($data) && count($data)>0} hide{/if}"><td colspan="{if isset($selectable) && $selectable}{count($fields)+1}{else}{count($fields)}{/if}">{$empty_message}</td></tr>{/if}
                {foreach from=$data item=row}
                    <tr{if is_string($field_id) && array_key_exists($field_id, $row)} data-id="{$row[$field_id]}"{/if}{if isset($edit_button) && $edit_button==='line'} class="btn-edit-line"{/if}>
                        {if $selectable}<th class="col-selectable" data-toggle="table-selectable"><input type="checkbox" value="T"></th>{/if}
                        {foreach from=$fields key=kfield item=meta}
                            <td data-name="{$kfield}"{if array_key_exists('align', $meta)} class="{if $meta.align==='right'}text-right{elseif $meta.align==='center'}center{/if}"{/if}>
                                {strip}
                                    {if array_key_exists($kfield, $row)}
                                        {assign var=img_url value=false}
                                        {assign var=img_class value=false}
                                        {if array_key_exists('lookup', $meta)}
                                            {assign var=kid value=$row[$kfield]}
                                            {assign var=content value='<label class="label label-danger">Invalid lookup value</label>'}
                                            {if is_array($meta.lookup) && array_key_exists($kid, $meta.lookup)}
                                                {if is_array($meta.lookup[$kid])}
                                                    {if array_key_exists('lookup_field_name', $meta) && is_string($meta.lookup_field_name) && array_key_exists($meta.lookup_field_name, $meta.lookup[$kid])}
                                                        {assign var=content value=$meta.lookup[$kid][$meta.lookup_field_name]}
                                                    {/if}
                                                    {if array_key_exists('lookup_field_image', $meta) && is_string($meta.lookup_field_image) && array_key_exists($meta.lookup_field_image, $meta.lookup[$kid])}
                                                        {assign var=img_url value=$meta.lookup[$kid][$meta.lookup_field_image]}
                                                    {/if}
                                                    {if array_key_exists('lookup_field_image_class', $meta) && is_string($meta.lookup_field_image_class)}
                                                        {assign var=img_class value=$meta.lookup_field_image_class}
                                                    {/if}
                                                {elseif is_string($meta.lookup[$kid])}
                                                    {assign var=content value=$meta.lookup[$kid]}
                                                {/if}
                                            {/if}
                                        {else}
                                            {assign var=content value=$row[$kfield]}
                                        {/if}
                                        {if $img_url}<span{if $img_class} class="{$img_class}"{/if}><img src="{$img_url}"></span><span class="text">{/if}{$content}{if $img_class}</span>{/if}
                                    {elseif array_key_exists('translation', $row) && is_array($row.translation) && array_key_exists($kfield, $row.translation)}
                                        {foreach from=$row.translations item=translation}
                                            {if array_key_exists($translation.language_id, $nb_site.languages)}
                                                {assign var=language value=$nb_site.languages[$translation.language_id]}
                                                <span class="flag" lang="{$language.default_country_code}">
                                                    {if $language.type==='C' && strlen($language.flag_url)>0}
                                                        <img src="{$language.flag_url}">
                                                    {else}
                                                        {$language.default_country_code}
                                                    {/if}
                                                </span>
                                                <span class="translation" lang="{$language.default_country_code}">{$translation[$kfield]}</span>{if !$translation@last}<br>{/if}
                                            {else}
                                                {$language.default_country_code}
                                            {/if}
                                        {/foreach}
                                    {/if}
                                {/strip}
                            </td>
                        {/foreach}
                        {if isset($edit_button) && $edit_button==='button'}<td><div class="btn-group" role="group"><button class="btn btn-editor btn-xs"><i class="fa fa-edit"></i></div></td>{/if}
                    </tr>
                {/foreach}
            </tbody>
        </table>
        {if isset($pager) && $pager}
            <div class="table-pager">
                <nav aria-label="Page navigation">
                    <ul class="pagination">
                        <li>
                            <a href="#" aria-label="Previous">
                            <span aria-hidden="true">&laquo;</span>
                            </a>
                        </li>
                        <li><a href="#">1</a></li>
                        <li><a href="#">2</a></li>
                        <li><a href="#">3</a></li>
                        <li><a href="#">4</a></li>
                        <li><a href="#">5</a></li>
                        <li>
                            <a href="#" aria-label="Next">
                            <span aria-hidden="true">&raquo;</span>
                            </a>
                        </li>
                    </ul>
                </nav>
            </div>
        {/if}
    </div>
{/if}
