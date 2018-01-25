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
{if isset($data) || (isset($draw_empty) && $draw_empty)}
    {strip}<div{if isset($id) && strlen($id)>0} id="{$id}"{/if} class="table-container" data-toggle="nabu-table"
            {if isset($pager) && $pager} data-table-pager="true"{if isset($size)} data-table-size="{$size}"{/if}{/if}
            {if is_string($api_url)} data-api="{$api_url}"{/if}
            {if is_string($editor_url)} data-editor="{$editor_url}" data-editor-mode="{$editor_mode}"
                {if $editor_mode==="ajax" && isset($editor_container) && strlen($editor_container)>0} data-editor-container="{$editor_container}"{/if}
            {/if}
            {if isset($editor_create_reload) && $editor_create_reload} data-editor-create-reload="true"{/if}
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
        <table{if isset($languages) && is_array($languages)} data-toggle="toggable-lang"{/if} class="table{if isset($striped)} table-striped{/if}{if isset($bordered)} table-bordered{/if}{if isset($hover)} table-hover{/if}{if isset($condensed)} table-condensed{/if}{if isset($scrolled)} table-scrolled{/if}">
            {assign var=field_id value=false}
            {if $fields && count($fields) > 0}
                <thead>
                    <tr>
                        {if $selectable}<th class="col-selectable" data-toggle="table-selectable"><input type="checkbox"></th>{/if}
                        {foreach from=$fields key=kfield item=field}{strip}
                            {if array_key_exists('field', $field) && is_string($field.field) && strlen($field.field)>0}
                                {assign var=kalias value=$kfield}
                                {assign var=kfield value=$field.field}
                            {else}
                                {assign var=kalias value=false}
                            {/if}
                            {if array_key_exists('order', $field)}
                                {assign var=ordered value=$field.order}
                            {else}
                                {assign var=ordered value=false}
                            {/if}
                            {if array_key_exists('id', $field) && $field.id===true}
                                {assign var=field_id value=$kfield}
                            {/if}
                            {if array_key_exists('align', $field)}
                                {assign var=align value=$field.align}
                            {else}
                                {assign var=align value=false}
                            {/if}
                            {if array_key_exists('lookup', $field)}
                                {capture assign=data_lookup}{strip}
                                    {ldelim}
                                        {foreach from=$field.lookup key=lkey item=litem}
                                            {if is_scalar($litem)}
                                                "{$lkey}": {if is_string($litem)}"{$litem}"{else}{$litem}{/if}
                                            {elseif is_array($litem)}
                                                {if array_key_exists('lookup_field_name', $field) && is_string($field.lookup_field_name) && strlen($field.lookup_field_name)>0}
                                                    {assign var=lookup_field_name value=$field['lookup_field_name']}
                                                    {if array_key_exists($lookup_field_name, $litem)}
                                                        {if is_scalar($litem[$lookup_field_name])}
                                                            "{$lkey}": {if is_string($litem[$lookup_field_name])}"{$litem[$lookup_field_name]}"{else}{$litem[$lookup_field_name]}{/if}
                                                        {elseif $litem[$lookup_field_name]===null}
                                                            "{$lkey}": null
                                                        {/if}
                                                    {elseif array_key_exists('translation', $litem) && is_array($litem.translation) && array_key_exists($lookup_field_name, $litem.translation)}
                                                        {if is_scalar($litem.translation[$lookup_field_name])}
                                                            "{$lkey}": {if is_string($litem.translation[$lookup_field_name])}"{$litem.translation[$lookup_field_name]}"{else}{$litem.translation[$lookup_field_name]}{/if}
                                                        {elseif $litem.translation[$lookup_field_name]===null}
                                                            "{$lkey}": null
                                                        {/if}
                                                    {else}
                                                        "nofield": ""
                                                    {/if}
                                                {else}
                                                    "nofield_name": ""
                                                {/if}
                                            {else}
                                                "crash": ""
                                            {/if}
                                            {if !$litem@last},{/if}
                                        {/foreach}
                                    {rdelim}
                                {/strip}{/capture}
                            {else}
                                {assign var=data_lookup value=false}
                            {/if}
                            <th data-name="{$kfield}"
                                {if isset($kalias) && is_string($kalias)} data-alias="{$kalias}"{/if}
                                {if array_key_exists('id', $field) && $field.id} data-is-id="true"{/if}
                                {if $align} data-align="{if $field.align==='right'}text-right{elseif $field.align==='center'}text-center{/if}"{/if}
                                {if $ordered} data-order="{$field.order}"{/if}
                                {if is_string($data_lookup) && strlen($data_lookup)>0} data-lookup="{$data_lookup|escape:html}"{/if}
                            >{$field.title}{if $ordered}<button class="btn btn-xs btn-order pull-right"><i class="fa fa-sort"></i></button>{/if}</th>
                        {/strip}{/foreach}
                        {if isset($edit_button) && $edit_button==='button'}<th width="*"></th>{/if}
                    </tr>
                </thead>
            {/if}
            <tbody>
                {if isset($draw_empty) && $draw_empty && is_array($translations) && array_key_exists('empty_message', $translations) && is_string($translations.empty_message)}
                    <tr class="table-empty-row{if is_array($data) && count($data)>0} hide{/if}" data-type="empty"><td colspan="{if isset($selectable) && $selectable}{count($fields)+1}{else}{count($fields)}{/if}">{$translations.empty_message}</td></tr>
                {/if}
                {foreach from=$data item=row}
                    <tr data-type="row"{if is_string($field_id) && array_key_exists($field_id, $row)} data-id="{$row[$field_id]}"{/if}{if (isset($edit_button) && $edit_button==='line') || (isset($pager) && $pager && isset($size) && $size<$row@iteration)} class="{if isset($edit_button) && $edit_button==='line'}btn-edit-line{/if}{if isset($pager) && $pager && isset($size) && $size<$row@iteration} hide{/if}"{/if}>
                        {if $selectable}<td class="col-selectable" data-toggle="table-selectable"><input type="checkbox" value="T"></td>{/if}
                        {foreach from=$fields key=kfield item=meta}
                            {if array_key_exists('field', $meta) && is_string($meta.field) && strlen($meta.field)>0}
                                {assign var=kfield value=$meta.field}
                            {/if}
                            <td data-name="{$kfield}"{if array_key_exists('align', $meta)} class="{if $meta.align==='right'}text-right{elseif $meta.align==='center'}text-center{/if}"{/if}>
                                {strip}
                                    {if array_key_exists($kfield, $row)}
                                        {assign var=img_url value=false}
                                        {assign var=img_class value=false}
                                        {if array_key_exists('lookup', $meta)}
                                            {assign var=kid value=$row[$kfield]}
                                            {assign var=content value='<label class="label label-danger">Invalid lookup value</label>'}
                                            {if is_array($meta.lookup) && array_key_exists($kid, $meta.lookup)}
                                                {if is_array($meta.lookup[$kid])}
                                                    {if array_key_exists('lookup_field_name', $meta) && is_string($meta.lookup_field_name) && strlen($meta.lookup_field_name)>0}
                                                        {if array_key_exists($meta.lookup_field_name, $meta.lookup[$kid])}
                                                            {assign var=content value=$meta.lookup[$kid][$meta.lookup_field_name]}
                                                        {elseif array_key_exists('translation', $meta.lookup[$kid]) && is_array($meta.lookup[$kid].translation) && array_key_exists($meta.lookup_field_name, $meta.lookup[$kid].translation)}
                                                            {assign var=content value=$meta.lookup[$kid].translation[$meta.lookup_field_name]}
                                                        {/if}
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
                                        {if $img_url}<span{if $img_class} class="{$img_class}"{/if}><img src="{$img_url}"></span>{/if}<span class="text">{$content}</span>
                                    {elseif isset($languages) && is_array($languages) && array_key_exists('translation', $row) && is_array($row.translation) && array_key_exists($kfield, $row.translation)}
                                        {foreach from=$languages key=lang_id item=language}
                                            <span lang="{$language.default_country_code}">
                                                <span class="flag">
                                                    {if $language.type==='C' && strlen($language.flag_url)>0}
                                                        <img src="{$language.flag_url}">
                                                    {else}
                                                        {$language.default_country_code}
                                                    {/if}
                                                </span>
                                                {if array_key_exists($lang_id, $row.translations)}
                                                    <span class="translation">{$row.translations[$lang_id][$kfield]}</span>{if !$language@last}<br>{/if}
                                                {else}
                                                    <span class="translation label label-danger">{if is_array($translations) && array_key_exists('translation_not_available', $translations) && strlen($translations.translation_not_available)>0}{$translations.translation_not_available}{else}Translation not available{/if}</span>
                                                {/if}
                                            </span>
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
        {*if isset($pager) && $pager}
            <div class="table-pager">
                <nav aria-label="Page navigation">
                    <ul class="pagination">
                        <li><a href="#" aria-label="Previous"><span aria-hidden="true">&laquo;</span></a></li>
                        <li><a href="#">1</a></li>
                        <li><a href="#">2</a></li>
                        <li><a href="#">3</a></li>
                        <li><a href="#">4</a></li>
                        <li><a href="#">5</a></li>
                        <li><a href="#" aria-label="Next"><span aria-hidden="true">&raquo;</span></a></li>
                    </ul>
                </nav>
            </div>
        {/if*}
    </div>
{/if}
