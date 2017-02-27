<div class="panel{if isset($type)} panel-{$type}{/if}">
    {if isset($title)}
        {assign var=final_title value=false}
        {if is_array($title) && array_key_exists('translation', $title) && is_array($title.translation) && array_key_exists('title', $title.translation) && is_string($title.translation.title)}
            {assign var=final_title value=$title.translation.title}
        {elseif is_string($title)}
            {assign var=final_title value=$title}
        {/if}
        {if isset($final_title) && is_string($final_title)}<div class="panel-heading">{$final_title}</div>{/if}
    {/if}
    <div class="panel-body">
