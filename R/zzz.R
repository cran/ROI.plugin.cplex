make_MIQCP_signatures <- function() {
    ROI_plugin_make_signature( objective = c("L", "Q"),
                        constraints = c("X", "L", "Q"),
                        types = c("C", "I", "B", "CI", "CB", "IB", "CIB"),
                        bounds = c("X", "V"),
                        cones = c("X"),
                        maximum = c(TRUE, FALSE) )
}

.onLoad <- function( libname, pkgname ) {
    ## Solver plugin name (based on package name)
    if( ! pkgname %in% ROI_registered_solvers() ){
        ## Register solver methods here.
        ## One can assign several signatures a single solver method
        solver <- ROI_plugin_get_solver_name( pkgname )
        ROI_plugin_register_solver_method( signatures = make_MIQCP_signatures(),
                                            solver = solver,
                                            method =
            getFunction( "solve_OP", where = getNamespace(pkgname)) )
        ## For status code canonicalization add status codes to data base
        .add_status_codes()
        ## Finally, for control argument canonicalization add controls to data base
        .add_controls()
    }
}
