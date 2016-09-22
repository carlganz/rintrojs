// Copyright (C) 2016 Carl Ganz
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU Affero General Public License as
// published by the Free Software Foundation, either version 3 of the
// License, or (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU Affero General Public License for more details.
//
// You should have received a copy of the GNU Affero General Public License
// along with this program.  If not, see <http://www.gnu.org/licenses/>.

Shiny.addCustomMessageHandler('introjs',function(options) {
  introJs().setOptions(options.options).oncomplete(function() {
    options.events.hasOwnProperty("oncomplete") && eval(options.events.oncomplete[0]);
    }).onexit(function() {
      options.events.hasOwnProperty("onexit") && eval(options.events.onexit[0]);
      }).onchange(function(targetElement) {
        options.events.hasOwnProperty("onchange") && eval(options.events.onchange[0]);
        }).onbeforechange(function(targetElement) {
          options.events.hasOwnProperty("onbeforechange") && eval(options.events.onbeforechange[0]);
          }).onafterchange(function(targetElement) {
            options.events.hasOwnProperty("onafterchange") && eval(options.events.onafterchange[0]);
            }).start();
});

Shiny.addCustomMessageHandler('hintjs',function(options) {
  introJs().setOptions(options.options).onhintclick(function() {
    options.events.hasOwnProperty("onhintclick") && eval(options.events.onhintclick[0]);
    }).onhintsadded(function() {
      options.events.hasOwnProperty("onhintsadded") && eval(options.events.onhintsadded[0]);
      }).onhintclose(function() {
        options.events.hasOwnProperty("onhintclose") && eval(options.events.onhintclose[0]);
        }).addHints();
});