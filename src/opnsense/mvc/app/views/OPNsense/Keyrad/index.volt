{#
 # Copyright (C) 2026 Marco Moenig <marco@sec73.io>
 #
 # Licensed under the Apache License, Version 2.0 (the "License");
 # you may not use this file except in compliance with the License.
 # You may obtain a copy of the License at
 #
 #     http://www.apache.org/licenses/LICENSE-2.0
 #
 # Unless required by applicable law or agreed to in writing, software
 # distributed under the License is distributed on an "AS IS" BASIS,
 # WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 #}

<script>
    $(document).ready(function() {
        $("#grid-clients").UIBootgrid({
            search: '/api/keyrad/clients/search_item',
            get:    '/api/keyrad/clients/get_item/',
            set:    '/api/keyrad/clients/set_item/',
            add:    '/api/keyrad/clients/add_item/',
            del:    '/api/keyrad/clients/del_item/',
            toggle: '/api/keyrad/clients/toggle_item/'
        });

        $("#grid-mappings").UIBootgrid({
            search: '/api/keyrad/mappings/search_item',
            get:    '/api/keyrad/mappings/get_item/',
            set:    '/api/keyrad/mappings/set_item/',
            add:    '/api/keyrad/mappings/add_item/',
            del:    '/api/keyrad/mappings/del_item/',
            toggle: '/api/keyrad/mappings/toggle_item/'
        });

        let data_get_map = {'frm_settings': "/api/keyrad/settings/get"};
        mapDataToFormUI(data_get_map).done(function() {
            formatTokenizersUI();
            $('.selectpicker').selectpicker('refresh');
            updateServiceControlUI('keyrad');
        });

        $("#reconfigureAct").SimpleActionButton({
            onPreAction: function() {
                const dfObj = new $.Deferred();
                saveFormToEndpoint("/api/keyrad/settings/set", 'frm_settings', function() {
                    dfObj.resolve();
                });
                return dfObj;
            },
            onAction: function(data, status) {
                updateServiceControlUI('keyrad');
            }
        });
    });
</script>

<ul class="nav nav-tabs" data-tabs="tabs" id="maintabs">
    <li class="active"><a data-toggle="tab" href="#settings">{{ lang._('General') }}</a></li>
    <li><a data-toggle="tab" href="#tab_clients">{{ lang._('Clients') }}</a></li>
    <li><a data-toggle="tab" href="#tab_mappings">{{ lang._('Attribute mappings') }}</a></li>
</ul>
<div class="tab-content content-box">
    <div id="settings" class="tab-pane fade in active">
        {{ partial("layout_partials/base_form", ['fields': formSettings, 'id': 'frm_settings']) }}
    </div>

    <div id="tab_clients" class="tab-pane fade in">
        <table id="grid-clients" class="table table-condensed table-hover table-striped table-responsive" data-editDialog="DialogClient" data-editAlert="keyradChangeMessage">
            <thead>
                <tr>
                    <th data-column-id="uuid" data-type="string" data-identifier="true" data-visible="false">{{ lang._('ID') }}</th>
                    <th data-column-id="enabled" data-width="6em" data-type="string" data-formatter="rowtoggle">{{ lang._('Enabled') }}</th>
                    <th data-column-id="network" data-type="string">{{ lang._('Client address') }}</th>
                    <th data-column-id="shortname" data-type="string">{{ lang._('Shortname') }}</th>
                    <th data-column-id="description" data-type="string">{{ lang._('Description') }}</th>
                    <th data-column-id="commands" data-width="7em" data-formatter="commands" data-sortable="false">{{ lang._('Commands') }}</th>
                </tr>
            </thead>
            <tbody></tbody>
            <tfoot>
                <tr>
                    <td></td>
                    <td>
                        <button data-action="add" type="button" class="btn btn-xs btn-primary"><span class="fa fa-fw fa-plus"></span></button>
                        <button data-action="deleteSelected" type="button" class="btn btn-xs btn-default"><span class="fa fa-fw fa-trash-o"></span></button>
                    </td>
                </tr>
            </tfoot>
        </table>
    </div>

    <div id="tab_mappings" class="tab-pane fade in">
        <table id="grid-mappings" class="table table-condensed table-hover table-striped table-responsive" data-editDialog="DialogMapping" data-editAlert="keyradChangeMessage">
            <thead>
                <tr>
                    <th data-column-id="uuid" data-type="string" data-identifier="true" data-visible="false">{{ lang._('ID') }}</th>
                    <th data-column-id="enabled" data-width="6em" data-type="string" data-formatter="rowtoggle">{{ lang._('Enabled') }}</th>
                    <th data-column-id="scope" data-type="string">{{ lang._('Scope / role / group') }}</th>
                    <th data-column-id="vendor" data-type="string">{{ lang._('Vendor') }}</th>
                    <th data-column-id="attribute" data-type="string">{{ lang._('Attribute') }}</th>
                    <th data-column-id="value" data-type="string">{{ lang._('Value') }}</th>
                    <th data-column-id="value_type" data-type="string">{{ lang._('Type') }}</th>
                    <th data-column-id="description" data-type="string">{{ lang._('Description') }}</th>
                    <th data-column-id="commands" data-width="7em" data-formatter="commands" data-sortable="false">{{ lang._('Commands') }}</th>
                </tr>
            </thead>
            <tbody></tbody>
            <tfoot>
                <tr>
                    <td></td>
                    <td>
                        <button data-action="add" type="button" class="btn btn-xs btn-primary"><span class="fa fa-fw fa-plus"></span></button>
                        <button data-action="deleteSelected" type="button" class="btn btn-xs btn-default"><span class="fa fa-fw fa-trash-o"></span></button>
                    </td>
                </tr>
            </tfoot>
        </table>
    </div>
</div>

<section class="page-content-main">
    <div class="content-box">
        <div class="col-md-12">
            <br/>
            <div id="keyradChangeMessage" class="alert alert-info" style="display: none" role="alert">
                {{ lang._('After changing settings, please remember to apply them with the button below') }}
            </div>
            <button class="btn btn-primary" id="reconfigureAct"
                    data-endpoint='/api/keyrad/service/reconfigure'
                    data-label="{{ lang._('Apply') }}"
                    data-service-widget="keyrad"
                    data-error-title="{{ lang._('Error reconfiguring keyrad') }}"
                    type="button"
            ></button>
            <br/><br/>
        </div>
    </div>
</section>

{# include dialogs #}
{{ partial("layout_partials/base_dialog", ['fields': formDialogClient, 'id': 'DialogClient', 'label': lang._('Edit RADIUS client')]) }}
{{ partial("layout_partials/base_dialog", ['fields': formDialogMapping, 'id': 'DialogMapping', 'label': lang._('Edit attribute mapping')]) }}
