// This file is auto-generated by ./bin/rails stimulus:manifest:update
// Run that command whenever you add a new controller or create them with
// ./bin/rails generate stimulus controllerName

import { application } from "./application"

import AssignmentsController from "./assignments_controller"
application.register("assignments", AssignmentsController)

import AutocompleteController from "./autocomplete_controller"
application.register("autocomplete", AutocompleteController)

import FetchAssignmentsController from "./fetch_assignments_controller"
application.register("fetch-assignments", FetchAssignmentsController)

import SortDashboardController from "./sort_dashboard_controller"
application.register("sort-dashboard", SortDashboardController)

import MyNestedFormController from "./my_nested_form_controller"
application.register("my-nested-form", MyNestedFormController)

/* import FlatpickrController from "./flatpickr_controller"
application.register("flatpickr", FlatpickrController)
 */
