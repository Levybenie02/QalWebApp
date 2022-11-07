<?php
/*
This call sends a message to one recipient.
*/
require 'vendor/autoload.php';
use \Mailjet\Resources;
//$mj = new \Mailjet\Client(getenv(MJ_APIKEY_PUBLIC), getenv(MJ_APIKEY_PRIVATE),true,['version' => 'v3.1']);
$mj = new \Mailjet\Client('6968b6e3b0a9052ec4343015ce2e4924','fc0f53cd43aca77337d047e1a3b4d0d1',true,['version' => 'v3.1']);

$body = [
    'Messages' => [
        [
            'From' => [
                'Email' => "achilleaikpe@adjemin.com",
                'Name' => "AIKPE ACHILE"
            ],
            'To' => [
                [
                    'Email' => "levybenie1@gmail.com",
                    'Name'  => "Levy Bénie"
                ]
            ],
            'Subject' => "Mail jet succes 005",
            'TextPart' => "Dear passenger 1, welcome to Mailjet! May the delivery force be with you!",
            'HTMLPart' => "<h3>Dear passenger 1, welcome to <a href=\"https://www.mailjet.com/\">Mailjet</a>!</h3><br />May the delivery force be with you!"
        ]
    ]
];  
$response = $mj->post(Resources::$Email, ['body' => $body]);
var_dump($response);
$response->success() && var_dump($response->getData());
