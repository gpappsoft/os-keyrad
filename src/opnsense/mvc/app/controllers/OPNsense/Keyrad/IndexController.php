<?php

/*
 * Copyright (C) 2026 Marco Moenig <marco@sec73.io>
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

namespace OPNsense\Keyrad;

/**
 * Class IndexController
 * @package OPNsense\Keyrad
 */
class IndexController extends \OPNsense\Base\IndexController
{
    public function indexAction()
    {
        // general settings form and grid edit dialogs
        $this->view->formSettings = $this->getForm("settings");
        $this->view->formDialogClient = $this->getForm("dialogClient");
        $this->view->formDialogMapping = $this->getForm("dialogMapping");
        // pick the template to render
        $this->view->pick('OPNsense/Keyrad/index');
    }
}
