function initHome() {
    // in order to have dynamic choosing of optional products or validity periods
    document.getElementById("sp").addEventListener("change", ev => {
        let id_sp = parseInt(document.getElementById("sp").value);
        console.log("clicked on " + id_sp)
        getServicePackages(id_sp, generateBoxesHome);
    });
    getServicePackages(parseInt(document.getElementById("sp").value), generateBoxesHome);

    // to set the minimum date as today
    var today = new Date();

    var dd = today.getDate();
    var mm = today.getMonth() + 1; //January is 0!
    var yyyy = today.getFullYear();

    if (dd < 10) {
        dd = '0' + dd;
    }

    if (mm < 10) {
        mm = '0' + mm;
    }

    document.getElementById("start_date_subscription").setAttribute("min", yyyy + '-' + mm + '-' + dd)
    document.getElementById("start_date_subscription").setAttribute("value", yyyy + '-' + mm + '-' + dd)
}

function getServicePackages(id_service_package, func_parseServicePackage) {
    r = new XMLHttpRequest();
    r.onreadystatechange = (function () {
        if (r.readyState === XMLHttpRequest.DONE) {
            switch (r.status) {
                case 200:
                    console.log("service package obtained! " + r.responseText);
                    sessionStorage.setItem("service_package", r.responseText)
                    let sp = JSON.parse(r.responseText);
                    func_parseServicePackage(sp);
                    break;
                default:
                    console.log("service package not obtained!");
                    break;
            }
        }
    });

    r.open("POST", "/TelcoServiceEJB_war_exploded/GetServicePackages");
    r.setRequestHeader('Content-type', 'application/x-www-form-urlencoded');
    r.send("id_service_package=" + id_service_package);
    console.log("requesting service package...");
}

function generateBoxesHome(sp) {
    console.log("GENERATING BOXES FOR sp=", sp["name"]);
    changeValidityPeriodOptions(sp);
    changeOptionalProductsOptions(sp);
    $(".select-multiple").selectpicker();
    $('.select-multiple').selectpicker('refresh');
    $(".selectpicker").selectpicker();
    $('.selectpicker').selectpicker('refresh');
}

function changeValidityPeriodOptions(sp) {
    // sp["validityPeriods"][i].id,months,fee
    document.getElementById("vp").innerText = "";
    for (let i = 0; i < sp["validityPeriods"].length; i++) {
        let option = document.createElement("option");
        option.setAttribute("value", sp["validityPeriods"][i].id);
        option.setAttribute("text", sp["validityPeriods"][i].months + "months / " + sp["validityPeriods"][i].fee + " euros");
        option.appendChild(document.createTextNode(sp["validityPeriods"][i].months + " months / " + sp["validityPeriods"][i].fee + " euros"));
        document.getElementById("vp").appendChild(option);
        console.log("appended child vp");
    }
}

function changeOptionalProductsOptions(sp) {
    // sp["optionalProducts"][i].id,name,monthlyFee
    document.getElementById("ops").innerText = "";
    for (let i = 0; i < sp["optionalProducts"].length; i++) {
        let option = document.createElement("option");

        option.setAttribute("value", sp["optionalProducts"][i].id);
        option.setAttribute("text", sp["optionalProducts"][i].name + "(" + sp["optionalProducts"][i].monthlyFee + " euros)");
        option.appendChild(document.createTextNode(sp["optionalProducts"][i].name + "(" + sp["optionalProducts"][i].monthlyFee + " euros)"));
        document.getElementById("ops").appendChild(option);
        console.log("appended child ops");
    }
}