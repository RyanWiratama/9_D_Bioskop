// 1. Kelas Person
class Person{
  final String name;
  final String phone;
  final String picture;
  const Person(this.name, this.phone, this.picture);
}

// 2. Variabel List dengan nama people yang memiliki data bertipe object Person, yang merupakan 
// hasil mapping data list pada baris 14 kebawah
final List<Person> people = _people.map((e) => Person(
  e['name'] as String, 
  e['phone'] as String, 
  e['picture'] as String)).toList(growable: false);

final List<Map<String, Object>> _people = [
  {
    "_id": "640cab644856c6302804d578",
    "index": 0,
    "guid": "afaaef8f-94e6-4e97-9473-378a412e9df3",
    "isActive": true,
    "balance": "\$3,574.12",
    "picture": "http://placeholder.it/32x32",
    "age": 32,
    "eyeColor": "green",
    "name": "Blanche Pena",
    "gender": "female",
    "company": "ZEDALIS",
    "email": "blanchepena@zedalis.com",
    "phone": "+1 (969) 480-2481",
    "address": "917 Heyward Street, Hasty, Arizona, 7612",
    "about": "Deserunt non laboris sit qui voluptate excepteur pariatur sunt non sit. Commodo eu esse incididunt qui. Nisi ex est et officia velit magna.",
    "registered": "2022-04-03T03:14:34 -07:00"
  },

  {
    "_id": "66fb98880337560440d5c452",
    "index": 0,
    "guid": "6fc3c8d2-c77a-433a-bc14-94d69324551a",
    "isActive": true,
    "balance": "\$3,746.69",
    "picture": "http://placehold.it/32x32",
    "age": 34,
    "eyeColor": "brown",
    "name": "Macias Herman",
    "gender": "male",
    "company": "IDEGO",
    "email": "maciasherman@idego.com",
    "phone": "+1 (848) 570-2660",
    "address": "664 Willow Street, Hessville, Marshall Islands, 5156",
    "about": "Incididunt ut qui elit ullamco aliquip qui tempor in tempor. Labore exercitation elit ipsum ad ea. Laboris proident reprehenderit labore do cupidatat eu excepteur et occaecat qui eiusmod mollit. Consequat amet ex aliqua nisi voluptate irure. Lorem enim excepteur occaecat reprehenderit magna aute laborum minim ea ex exercitation. Duis laborum ipsum ullamco tempor nostrud excepteur velit veniam et commodo adipisicing eiusmod laboris occaecat. Voluptate ut ut aliquip nisi magna do fugiat.\r\n",
    "registered": "2023-11-21T12:35:36 -07:00",
    "latitude": 23.360306,
    "longitude": -127.892043,
    "tags": [
      "elit",
      "labore",
      "ad",
      "enim",
      "occaecat",
      "ea",
      "aute"
    ],
    "friends": [
      {
        "id": 0,
        "name": "Perez Cochran"
      },
      {
        "id": 1,
        "name": "Charlotte Lowery"
      },
      {
        "id": 2,
        "name": "Bray Marks"
      }
    ],
    "greeting": "Hello, Macias Herman! You have 7 unread messages.",
    "favoriteFruit": "apple"
  },
  {
    "_id": "66fb9888a37f0afcff9f2d99",
    "index": 1,
    "guid": "09d36378-742d-4b82-bbcd-fa875cb5167b",
    "isActive": true,
    "balance": "\$3,186.92",
    "picture": "http://placehold.it/32x32",
    "age": 25,
    "eyeColor": "green",
    "name": "Woodard Holcomb",
    "gender": "male",
    "company": "NETUR",
    "email": "woodardholcomb@netur.com",
    "phone": "+1 (881) 547-3282",
    "address": "287 Alice Court, Trinway, Alaska, 8610",
    "about": "Dolore ea sint enim sint nisi nostrud velit eu velit. Ut esse voluptate proident eiusmod sunt aute velit aute dolore non proident veniam proident adipisicing. Minim in consectetur excepteur commodo qui adipisicing incididunt sint sit sit id consectetur deserunt duis. Excepteur dolore mollit sit ut officia consectetur est proident aute non amet occaecat. Laborum eu sit sit deserunt consequat voluptate laboris proident nisi mollit consectetur id laborum.\r\n",
    "registered": "2018-08-20T03:15:30 -07:00",
    "latitude": -16.806384,
    "longitude": 139.428173,
    "tags": [
      "cillum",
      "tempor",
      "sit",
      "Lorem",
      "occaecat",
      "fugiat",
      "non"
    ],
    "friends": [
      {
        "id": 0,
        "name": "Justine Pate"
      },
      {
        "id": 1,
        "name": "Marks Glover"
      },
      {
        "id": 2,
        "name": "Blanchard Waller"
      }
    ],
    "greeting": "Hello, Woodard Holcomb! You have 3 unread messages.",
    "favoriteFruit": "apple"
  },
  {
    "_id": "66fb9888deeb1a21484018f1",
    "index": 2,
    "guid": "716335ee-fcc2-4c31-89ba-49c8a0e176bd",
    "isActive": true,
    "balance": "\$1,381.46",
    "picture": "http://placehold.it/32x32",
    "age": 33,
    "eyeColor": "blue",
    "name": "Faye Mitchell",
    "gender": "female",
    "company": "FOSSIEL",
    "email": "fayemitchell@fossiel.com",
    "phone": "+1 (881) 502-3564",
    "address": "223 Berkeley Place, Sims, Nevada, 9386",
    "about": "Esse est cupidatat fugiat sunt cillum sint ut ipsum culpa ea commodo quis. Eiusmod reprehenderit amet do sunt proident eiusmod. Sunt nostrud amet occaecat tempor magna incididunt. Ut dolore esse sit amet aute aute magna laboris veniam. Non deserunt proident aliquip nulla ad adipisicing ut Lorem quis est sit.\r\n",
    "registered": "2022-03-22T02:22:01 -07:00",
    "latitude": -67.71335,
    "longitude": -149.570182,
    "tags": [
      "consectetur",
      "ex",
      "deserunt",
      "esse",
      "ea",
      "cupidatat",
      "dolor"
    ],
    "friends": [
      {
        "id": 0,
        "name": "Kerri Hurst"
      },
      {
        "id": 1,
        "name": "Garner Knapp"
      },
      {
        "id": 2,
        "name": "Rivers Durham"
      }
    ],
    "greeting": "Hello, Faye Mitchell! You have 6 unread messages.",
    "favoriteFruit": "banana"
  },
  {
    "_id": "66fb98884de028a0c7467f4d",
    "index": 3,
    "guid": "570aaea9-49d3-4375-86a0-597ef52e6ddc",
    "isActive": true,
    "balance": "\$1,296.08",
    "picture": "http://placehold.it/32x32",
    "age": 40,
    "eyeColor": "green",
    "name": "Clayton Velazquez",
    "gender": "male",
    "company": "CENTREE",
    "email": "claytonvelazquez@centree.com",
    "phone": "+1 (861) 563-3079",
    "address": "793 Hornell Loop, Websterville, North Dakota, 2454",
    "about": "Esse non eu qui sunt laboris. Et irure pariatur incididunt ea minim nulla velit nisi reprehenderit eu do exercitation. Proident aliquip esse proident nisi minim cillum aute nostrud commodo amet fugiat dolore minim do. Elit amet veniam culpa sint id esse mollit tempor. Dolor reprehenderit ex anim magna duis aliquip consectetur. Labore officia mollit incididunt elit voluptate. Quis eiusmod sit deserunt eu et Lorem tempor nulla commodo ex nostrud fugiat dolor.\r\n",
    "registered": "2023-11-14T12:21:52 -07:00",
    "latitude": 88.148486,
    "longitude": 6.38557,
    "tags": [
      "non",
      "incididunt",
      "ea",
      "irure",
      "consectetur",
      "nostrud",
      "nisi"
    ],
    "friends": [
      {
        "id": 0,
        "name": "Lakeisha Rojas"
      },
      {
        "id": 1,
        "name": "Cain Eaton"
      },
      {
        "id": 2,
        "name": "Harmon Vance"
      }
    ],
    "greeting": "Hello, Clayton Velazquez! You have 1 unread messages.",
    "favoriteFruit": "strawberry"
  },
  {
    "_id": "66fb988847dcceb45d2e7a35",
    "index": 4,
    "guid": "76f581e7-bf9d-401c-be6f-80c17e1aba68",
    "isActive": false,
    "balance": "\$1,003.91",
    "picture": "http://placehold.it/32x32",
    "age": 20,
    "eyeColor": "blue",
    "name": "Donaldson Kennedy",
    "gender": "male",
    "company": "INTRADISK",
    "email": "donaldsonkennedy@intradisk.com",
    "phone": "+1 (933) 504-2518",
    "address": "314 Fane Court, Geyserville, Georgia, 4308",
    "about": "Ut fugiat do eu magna dolor magna pariatur eu aliqua culpa. Sint est reprehenderit laborum cillum amet reprehenderit consequat pariatur nulla. Nostrud non veniam ad eiusmod excepteur ipsum. Ad et minim ullamco nostrud et cillum. Sunt voluptate nulla nostrud ex ullamco exercitation elit velit fugiat nostrud est nostrud sit. Voluptate aute exercitation minim dolore. Nulla eiusmod esse incididunt ullamco laboris velit.\r\n",
    "registered": "2019-02-03T09:17:17 -07:00",
    "latitude": -7.591618,
    "longitude": -36.188476,
    "tags": [
      "duis",
      "ex",
      "labore",
      "duis",
      "enim",
      "amet",
      "enim"
    ],
    "friends": [
      {
        "id": 0,
        "name": "Sherrie Fuller"
      },
      {
        "id": 1,
        "name": "Sykes Manning"
      },
      {
        "id": 2,
        "name": "Nell Whitley"
      }
    ],
    "greeting": "Hello, Donaldson Kennedy! You have 8 unread messages.",
    "favoriteFruit": "apple"
  },
  {
    "_id": "66fb98880324084b77ac000a",
    "index": 5,
    "guid": "83928687-6820-4885-81b9-415896b147da",
    "isActive": false,
    "balance": "\$1,905.68",
    "picture": "http://placehold.it/32x32",
    "age": 40,
    "eyeColor": "green",
    "name": "Harding Lloyd",
    "gender": "male",
    "company": "GROK",
    "email": "hardinglloyd@grok.com",
    "phone": "+1 (995) 489-4000",
    "address": "776 Polhemus Place, Hardyville, Missouri, 7286",
    "about": "Labore amet eu sint commodo minim deserunt incididunt minim qui. Enim ut laboris voluptate amet. Commodo et incididunt fugiat laboris aute incididunt. Ullamco ullamco reprehenderit incididunt ut nulla non nulla reprehenderit Lorem et minim aliqua. Sit labore aliqua fugiat eiusmod nostrud. In eiusmod ad nisi Lorem nisi dolore excepteur dolor aliquip ipsum adipisicing aute reprehenderit consectetur. Et nulla non fugiat Lorem sunt incididunt id officia sit laborum.\r\n",
    "registered": "2014-09-27T05:20:55 -07:00",
    "latitude": -74.669619,
    "longitude": 177.192993,
    "tags": [
      "cupidatat",
      "cupidatat",
      "minim",
      "proident",
      "excepteur",
      "aute",
      "exercitation"
    ],
    "friends": [
      {
        "id": 0,
        "name": "Lyons Mueller"
      },
      {
        "id": 1,
        "name": "Marcy Branch"
      },
      {
        "id": 2,
        "name": "Mccarthy Meadows"
      }
    ],
    "greeting": "Hello, Harding Lloyd! You have 7 unread messages.",
    "favoriteFruit": "banana"
  },
  {
    "_id": "66fb988835c5d84cb9f89fb3",
    "index": 6,
    "guid": "d48c9827-0971-4bfd-a494-2b8cdcb5fb08",
    "isActive": false,
    "balance": "\$3,237.36",
    "picture": "http://placehold.it/32x32",
    "age": 34,
    "eyeColor": "green",
    "name": "Merrill Howell",
    "gender": "male",
    "company": "CODAX",
    "email": "merrillhowell@codax.com",
    "phone": "+1 (980) 505-3628",
    "address": "767 Hall Street, Marshall, Indiana, 8034",
    "about": "Eiusmod veniam ex et id proident in nisi cupidatat qui ad. Id elit irure deserunt ex. In culpa proident sint et labore sit aliqua irure. Eiusmod officia exercitation sint laboris dolore culpa do proident fugiat nulla ea duis voluptate. Nulla deserunt incididunt non veniam. Exercitation velit laboris sit occaecat sunt pariatur qui ullamco cillum. Dolore tempor cupidatat sint qui anim ad occaecat officia magna ad voluptate deserunt ea.\r\n",
    "registered": "2022-02-26T06:34:22 -07:00",
    "latitude": 6.083508,
    "longitude": -47.581398,
    "tags": [
      "dolor",
      "nulla",
      "commodo",
      "veniam",
      "esse",
      "Lorem",
      "elit"
    ],
    "friends": [
      {
        "id": 0,
        "name": "Duncan Dillard"
      },
      {
        "id": 1,
        "name": "Tessa Whitfield"
      },
      {
        "id": 2,
        "name": "Myrtle Valenzuela"
      }
    ],
    "greeting": "Hello, Merrill Howell! You have 4 unread messages.",
    "favoriteFruit": "strawberry"
  }

];
