$(function(){
    labelPlugin = document.getElementById("pluginStatus");
    labelTs3 = document.getElementById("Ts3State");
    labelMic = document.getElementById("microfono");

    colorStatusOk = "#00ff00";
    colorStatusBad = "#ff0000";

    window.addEventListener('message', function(event) {
        if(event.data.action == 'setWindow'){
            if(event.data.value){
                setWindow(true);
            } else {
                setWindow(false);
            }
        }

        if(event.data.action == 'updateValues'){
            if(event.data.statusType == "isPluginActiveStatus"){
                if(event.data.value){
                    labelPlugin.innerHTML = "CONNECTED";
                    labelPlugin.style.color = colorStatusOk;
                } else{
                    labelPlugin.innerHTML = "NOT CONNECTED";
                    labelPlugin.style.color = colorStatusBad;
                }
            } else if(event.data.statusType == "isMicEnabledStatus"){
                if(event.data.value){
                    labelTs3.innerHTML = "CONNECTED";
                    labelTs3.style.color = colorStatusOk;
                } else{
                    labelTs3.innerHTML = "NOT CONNECTED";
                    labelTs3.style.color = colorStatusBad;
                }
            } else if(event.data.statusType == "isMicActiveStatus"){
                if(event.data.value){
                    labelMic.innerHTML = "ACTIVE";
                    labelMic.style.color = colorStatusOk;
                } else{
                    labelMic.innerHTML = "NOT ACTIVE";
                    labelMic.style.color = colorStatusBad;
                }
            }
        }
    });
});

function setWindow(status){
    document.getElementById('pluginScreen').style.display = (status) ? 'block' : 'none';
}
