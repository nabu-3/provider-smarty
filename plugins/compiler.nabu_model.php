<?php

/** @license
 *  Copyright 2009-2011 Rafael Gutierrez Martinez
 *  Copyright 2012-2013 Welma WEB MKT LABS, S.L.
 *  Copyright 2014-2016 Where Ideas Simply Come True, S.L.
 *  Copyright 2017 nabu-3 Group
 *
 *  Licensed under the Apache License, Version 2.0 (the "License");
 *  you may not use this file except in compliance with the License.
 *  You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 *  Unless required by applicable law or agreed to in writing, software
 *  distributed under the License is distributed on an "AS IS" BASIS,
 *  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *  See the License for the specific language governing permissions and
 *  limitations under the License.
 */

use nabu\core\CNabuEngine;
use nabu\http\app\base\CNabuHTTPApplication;
use providers\smarty\smarty\CSmartyManager;
use providers\smarty\smarty\builders\CSmartyNabuModelCompiler;

/**
 * This function is a wrapper to call CSmartyNabuModelCompiler that implements all functionalities.
 * @author Rafael Gutierrez <rgutierrez@nabu-3.com>
 * @since 0.0.1
 * @version 0.1.1
 */
function smarty_compiler_nabu_model($params, Smarty $smarty)
{
    $compiler = new CSmartyNabuModelCompiler($params, $smarty);

    return $compiler->execute();
}

function smarty_compiler_nabu_generic_model($params, Smarty $smarty, $fragment)
{
    $nb_engine = CNabuEngine::getEngine();
    $nb_application = $nb_engine->getApplication();
    if (($nb_application instanceof CNabuHTTPApplication) &&
        ($nb_smarty_manager = $nb_engine->getProviderManager(SMARTY_VENDOR_KEY, SMARTY_MODULE_KEY)) &&
        ($nb_smarty_manager instanceof CSmartyManager) &&
        ($nb_smarty_model = $nb_smarty_manager->getCurrentModel()) !== null &&
        ($nb_smarty_model->isValidFragment($fragment))
    ) {
        return $nb_smarty_model->buildFragment($fragment, $params, $smarty);
    } else {
        throw new \SmartyCompilerException("Model fragment [$fragment] cannot be accessed");
    }
}

function smarty_compiler_nabu_alert($params, Smarty $smarty)
{
    return smarty_compiler_nabu_generic_model($params, $smarty, 'alert');
}

function smarty_compiler_nabu_alertclose($params, Smarty $smarty)
{
    return smarty_compiler_nabu_generic_model($params, $smarty, 'alertclose');
}

function smarty_compiler_nabu_form($params, Smarty $smarty)
{
    return smarty_compiler_nabu_generic_model($params, $smarty, 'form');
}

function smarty_compiler_nabu_formclose($params, Smarty $smarty)
{
    return smarty_compiler_nabu_generic_model($params, $smarty, 'formclose');
}

function smarty_compiler_nabu_form_variable($params, Smarty $smarty)
{
    return smarty_compiler_nabu_generic_model($params, $smarty, 'form-variable');
}

function smarty_compiler_nabu_form_fieldset($params, Smarty $smarty)
{
    return smarty_compiler_nabu_generic_model($params, $smarty, 'form-fieldset');
}

function smarty_compiler_nabu_form_fieldsetclose($params, Smarty $smarty)
{
    return smarty_compiler_nabu_generic_model($params, $smarty, 'form-fieldsetclose');
}

function smarty_compiler_nabu_form_row($params, Smarty $smarty)
{
    return smarty_compiler_nabu_generic_model($params, $smarty, 'form-row');
}

function smarty_compiler_nabu_form_rowclose($params, Smarty $smarty)
{
    return smarty_compiler_nabu_generic_model($params, $smarty, 'form-rowclose');
}

function smarty_compiler_nabu_form_textbox($params, Smarty $smarty)
{
    return smarty_compiler_nabu_generic_model($params, $smarty, 'form-textbox');
}

function smarty_compiler_nabu_form_checkbox($params, Smarty $smarty)
{
    return smarty_compiler_nabu_generic_model($params, $smarty, 'form-checkbox');
}

function smarty_compiler_nabu_form_radiobox($params, Smarty $smarty)
{
    return smarty_compiler_nabu_generic_model($params, $smarty, 'form-radiobox');
}

function smarty_compiler_nabu_form_select($params, Smarty $smarty)
{
    return smarty_compiler_nabu_generic_model($params, $smarty, 'form-select');
}

function smarty_compiler_nabu_form_static($params, Smarty $smarty)
{
    return smarty_compiler_nabu_generic_model($params, $smarty, 'form-static');
}

function smarty_compiler_nabu_form_command($params, Smarty $smarty)
{
    return smarty_compiler_nabu_generic_model($params, $smarty, 'form-command');
}

function smarty_compiler_nabu_form_commands($params, Smarty $smarty)
{
    return smarty_compiler_nabu_generic_model($params, $smarty, 'form-commands');
}

function smarty_compiler_nabu_form_commandsclose($params, Smarty $smarty)
{
    return smarty_compiler_nabu_generic_model($params, $smarty, 'form-commandsclose');
}

function smarty_compiler_nabu_form_commands_group($params, Smarty $smarty)
{
    return smarty_compiler_nabu_generic_model($params, $smarty, 'form-commands-group');
}

function smarty_compiler_nabu_form_commands_groupclose($params, Smarty $smarty)
{
    return smarty_compiler_nabu_generic_model($params, $smarty, 'form-commands-groupclose');
}

function smarty_compiler_nabu_navbar($params, Smarty $smarty)
{
    return smarty_compiler_nabu_generic_model($params, $smarty, 'navbar');
}

function smarty_compiler_nabu_navbarclose($params, Smarty $smarty)
{
    return smarty_compiler_nabu_generic_model($params, $smarty, 'navbarclose');
}

function smarty_compiler_nabu_navigation($params, Smarty $smarty)
{
    return smarty_compiler_nabu_generic_model($params, $smarty, 'navigation');
}

function smarty_compiler_nabu_breadcrumb($params, Smarty $smarty)
{
    return smarty_compiler_nabu_generic_model($params, $smarty, 'breadcrumb');
}

function smarty_compiler_nabu_table($params, Smarty $smarty)
{
    return smarty_compiler_nabu_generic_model($params, $smarty, 'table');
}

function smarty_compiler_nabu_tree($params, Smarty $smarty)
{
    return smarty_compiler_nabu_generic_model($params, $smarty, 'tree');
}

function smarty_compiler_nabu_panel($params, Smarty $smarty)
{
    return smarty_compiler_nabu_generic_model($params, $smarty, 'panel');
}

function smarty_compiler_nabu_panelclose($params, Smarty $smarty)
{
    return smarty_compiler_nabu_generic_model($params, $smarty, 'panelclose');
}

function smarty_compiler_nabu_open_modal($params, Smarty $smarty)
{
    return smarty_compiler_nabu_generic_model($params, $smarty, 'open-modal');
}

function smarty_compiler_nabu_modal($params, Smarty $smarty)
{
    return smarty_compiler_nabu_generic_model($params, $smarty, 'modal');
}

function smarty_compiler_nabu_modalclose($params, Smarty $smarty)
{
    return smarty_compiler_nabu_generic_model($params, $smarty, 'modalclose');
}

function smarty_compiler_nabu_modal_header($params, Smarty $smarty)
{
    return smarty_compiler_nabu_generic_model($params, $smarty, 'modal-header');
}

function smarty_compiler_nabu_modal_headerclose($params, Smarty $smarty)
{
    return smarty_compiler_nabu_generic_model($params, $smarty, 'modal-headerclose');
}

function smarty_compiler_nabu_modal_body($params, Smarty $smarty)
{
    return smarty_compiler_nabu_generic_model($params, $smarty, 'modal-body');
}

function smarty_compiler_nabu_modal_bodyclose($params, Smarty $smarty)
{
    return smarty_compiler_nabu_generic_model($params, $smarty, 'modal-bodyclose');
}

function smarty_compiler_nabu_modal_footer($params, Smarty $smarty)
{
    return smarty_compiler_nabu_generic_model($params, $smarty, 'modal-footer');
}

function smarty_compiler_nabu_modal_footerclose($params, Smarty $smarty)
{
    return smarty_compiler_nabu_generic_model($params, $smarty, 'modal-footerclose');
}
