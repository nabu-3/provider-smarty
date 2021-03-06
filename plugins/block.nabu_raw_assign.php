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

use providers\smarty\smarty\builders\CSmartyNabuRawAssignBlock;

/**
 * This function is a wrapper to call CSmartyNabuRawAssignBlock that implements all functionalities.
 * @author Rafael Gutierrez <rgutierrez@nabu-3.com>
 * @since 0.0.1
 * @version 0.1.1
 * @package \providers\smarty\smarty\builders
 */
function smarty_block_nabu_raw_assign($params, $content, Smarty_Internal_Template $template, &$repeat)
{
    $render = new CSmartyNabuRawAssignBlock($params, $template);

    return $render->execute($content, $repeat);
}
