const exec = require('cordova/exec');
const CDVLocalWWW = {
    showProgress :function (options){
        exec(null, null, 'CDVLocalWWW','showProgress',[options]);
    },
    setProgress : function (options){
        exec(null, null, 'CDVLocalWWW','setProgress',[options]);
    },
    hideProgress : function (){
        exec(null, null, 'CDVLocalWWW','hideProgress',[]);
    },
    goSetting : function (){
        exec(null, null, 'CDVLocalWWW','goSetting',[]);
    },
    goURL : function (success,options){
        exec(success, null, 'CDVLocalWWW','goURL',[options]);
    }
};
module.exports = CDVLocalWWW;
