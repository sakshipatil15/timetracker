Ext.define('Netresearch.store.Projects', {
    extend: 'Ext.data.Store',
    storeId: 'projectStore',

    requires: [
           'Netresearch.model.Project'
       ],

    autoDestroy: true,
    autoLoad: false,
    currentCustomer: null,
    model: 'Netresearch.model.Project',
    proxy: {
        type: 'memory',
        reader: {
            type: 'json',
            record: 'projects'
        }
    },

    /* Read data from json var in html source code */
    load: function(options) {
        return this.loadData(projectsData, null, null, false);
    },
    /* Read data from json var in html source code */
    loadData: function(data, customer, ticket, onlyActive) {

        // Check if we are valid already
        if (this.currentCustomer && (this.currentCustomer == parseInt(customer)))
            return;

        var projects = findProjects(customer, ticket)
        if (!projects)
            projects = new Array();

        // merge empty prefix projects, if any
        if ((null !== ticket) && (undefined !== ticket) && (ticket.length > 0)) {
            projects2 = findProjects(customer, "");
            if (projects2) {
                // console.log("Merged " + projects2.length + " projects with empty prefixes");
                projects = projects.concat(projects2);
            }
        }

        this.currentCustomer = parseInt(customer);

        if (! projects.length) {
            this.removeAll();
            return;
        }

        this.callParent(projects, false);
    }
});
