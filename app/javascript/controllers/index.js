// This file is auto-generated by ./bin/rails stimulus:manifest:update
// Run that command whenever you add a new controller or create them with
// ./bin/rails generate stimulus controllerName

import { application } from "./application"

import AlgoController from "./algo_controller"
application.register("algo", AlgoController)

import AssignmentsController from "./assignments_controller"
application.register("assignments", AssignmentsController)

import AutocompleteController from "./autocomplete_controller"
application.register("autocomplete", AutocompleteController)

import FetchAssignmentsController from "./fetch_assignments_controller"
application.register("fetch-assignments", FetchAssignmentsController)

import SortDashboardController from "./sort_dashboard_controller"
application.register("sort-dashboard", SortDashboardController)
