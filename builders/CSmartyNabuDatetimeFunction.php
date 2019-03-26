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

namespace providers\smarty\smarty\builders;

use \providers\smarty\smarty\builders\base\CSmartyAbstractFunction;
use \Smarty;

/**
 * This class represents an URI request.
 * @author Rafael Gutierrez <rgutierrez@nabu-3.com>
 * @since 0.0.9
 * @version 0.1.1
 * @package \providers\smarty\smarty\builders
 */
class CSmartyNabuDatetimeFunction extends CSmartyAbstractFunction
{
    public function execute($content = null, &$repeat = false)
    {
        $time = array_key_exists('time', $this->params) ? $this->params['time'] : time();
        $format = array_key_exists('format', $this->params) ? $this->params['format'] : false;
        $default = array_key_exists('default', $this->params) && strlen($this->params['default']) > 0 ? $this->params['default'] : false;
        $var = array_key_exists('var', $this->params) ? $this->params['var'] : false;

        $final = false;

        if ($format && strlen($format) > 0) {
            $nb_language = $this->template->getVariable('nb_language')->value;
            $nb_site = $this->template->getVariable('nb_site')->value;

            if (is_array($nb_language) &&
                is_array($nb_site) &&
                array_key_exists('translations', $nb_site) &&
                array_key_exists('id', $nb_language) &&
                array_key_exists($nb_language['id'], $nb_site['translations']))
            {
                $lang_descriptor = $nb_site['translations'][$nb_language['id']];
                $field = $format.'_format';
                if (array_key_exists($field, $lang_descriptor)) {
                    $final = strlen($lang_descriptor[$field]) === 0 ? $default : $lang_descriptor[$field];
                } else {
                    $final = $default;
                }
            } else {
                $final = $default;
            }
        } else if ($default && strlen($default) > 0) {
            $final = $default;
        }

        if (!$final || strlen($final) === 0) {
            $formatted = $time;
        } else {
            $formatted = strftime($final, is_numeric($time) ? $time : strtotime($time));
        }

        if ($var && strlen($var) > 0) {
            $this->template->assign($var, $formatted);
            $retval = '';
        } else {
            $retval = $formatted;
        }

        return $retval;
    }
}
