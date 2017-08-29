{nabu_model model="bootstrap-3.3.7"}
{if is_array($data) && count($data) > 0}
    <ul class="tree-level drop-container"{if isset($draggable) && $draggable===true} data-toggle="drop-container" data-drop-id="tree-child"{/if}>
        {foreach from=$data item=li}
            {if isset($field_childs) && array_key_exists($field_childs, $li) && is_array($li[$field_childs]) && count($li[$field_childs]) > 0}
                {assign var=childs value=$li[$field_childs]}
            {else}
                {assign var=childs value=false}
            {/if}
            {strip}
                <li{if isset($draggable) && $draggable===true} data-toggle="drag-item" data-drop-ids="tree-child" draggable="true"{/if}
                   class="drag-itemp{if $childs} expanded{/if}"
                >
                    <div class="tree-item drag-caret{if (isset($edit_button) && $edit_button==='line')} btn-edit-line{/if}"
                         {if isset($field_id) && array_key_exists($field_id, $li)} data-id="{$li[$field_id]}"{/if}
                    >
                        <div class="tree-item-toolbar">
                            {if $childs}<button class="btn btn-flat btn-expand"><i class="fa fa-minus-square-o"></i><i class="fa fa-plus-square-o"></i></button>{/if}
                        </div>
                        {assign var=final_content value='&lt;Nonamed&gt;'}
                        {if isset($template) && strlen($template)>0}
                            {capture name=li assign=final_content}{include file=$template node=$li}{/capture}
                        {elseif isset($field_name) && array_key_exists($field_name, $li)}
                            {assign var=final_content value=$data[$field_name]}
                        {elseif array_key_exists('translation', $li) && is_array($li.translation) && array_key_exists($field_name, $li.translation)}
                            {assign var=final_content value=$li.translation[$field_name]}
                        {/if}
                        <div class="tree-item-content">{$final_content}</div>
                        <div class="tree-item-flags"></div>
                    </div>
                    {if $childs}
                        {include file="tree-child.tpl" data=$childs}
                    {/if}
                </li>
            {/strip}
        {/foreach}
    </ul>
{/if}
