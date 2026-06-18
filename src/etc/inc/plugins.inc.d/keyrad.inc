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

function keyrad_enabled()
{
    $cnf = \OPNsense\Core\Config::getInstance()->object();
    if (isset($cnf->OPNsense->Keyrad->general->enabled)) {
        return (string)$cnf->OPNsense->Keyrad->general->enabled === '1';
    }

    return false;
}

function keyrad_services()
{
    $services = [];

    if (keyrad_enabled()) {
        $services[] = [
            'description' => gettext('keyrad RADIUS Server'),
            'configd' => [
                'restart' => ['keyrad restart'],
                'start' => ['keyrad start'],
                'stop' => ['keyrad stop'],
            ],
            'name' => 'keyrad',
            'pidfile' => '/var/run/keyrad.pid',
        ];
    }

    return $services;
}

function keyrad_syslog()
{
    $logfacilities = [];
    $logfacilities['keyrad'] = ['facility' => ['keyrad']];

    return $logfacilities;
}
