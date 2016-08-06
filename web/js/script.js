/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


$(function() {
    $( ".registration-form" ).hide();
    $( ".register-button " ).click(function() {
        $( ".registration-form" ).slideToggle( "slow", function() {
            // Animation complete.
        });
        $( ".login-form" ).slideToggle( "slow", function() {
            // Animation complete.
        });
    });
    $( ".login-button " ).click(function() {
        $( ".registration-form" ).slideToggle( "slow", function() {
            // Animation complete.
        });
        $( ".login-form" ).slideToggle( "slow", function() {
            // Animation complete.
        });
    });
});
