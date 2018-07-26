let moment = require('moment');


// purpose:
// get today as formatted string
// get all weekdays as formatted strings, monday-sunday


// define vars "today"(string) and "myDays"( array of strings):
let myDays = new Array();
moment.locale('de');
let today = moment();
let jumper = 1 + (-1 * today.day());
for(let i = 0; i < 7; i++) {
    myDays[i] = moment().add(jumper + i, 'days');
}


// test output:
console.log("|------------------------------|");
console.log("| Today: " + today.format('dddd, DD.MM.YYYY'));
console.log("|------------------------------|");
for( let i = 0; i < myDays.length; i++) {
    console.log("| " + myDays[i].format('dddd, DD.MM.YYYY'));
}
console.log("|------------------------------|");


// INFO:
// mkdir mytest
// cd mytest
// npm init -y
// npm i -S moment
// touch my-moment.js
// ...copy code
// node my-moment.js
//
// EOF
