@test
@booking

Feature: Booking feature verification along with update feature

@Fisdom_auto_TC01
Scenario Outline: verify booking feature
Given i create booking for "<firstname>" "<lastname>" "<totalprice>" "<depositpaid>" "<checkin>" "<checkout>" "<additionalneeds>"
And i am verifying new booking details using booking_payload and booking_response

Examples:
|firstname|lastname|totalprice|depositpaid|checkin   |checkout  |additionalneeds|
| Aaditya |mahajan | 10000    | true      |2020-05-23|2020-06-23|   dinner      |
| Aaditya |mahajan | -100     | true      |2020-05-23|2020-06-23|   dinner      |
| Fisdom  |Tech    | 100000   | false     |2020-05-23|2020-06-23|   dinner      |
| Fisdom  |QA      | 100000   | false     |2020-05-23|2020-07-23|   Lunch       |

@Fisdom_auto_TC02
Scenario Outline: verify booking update feature - complete update
Given i create booking for "<firstname>" "<lastname>" "<totalprice>" "<depositpaid>" "<checkin>" "<checkout>" "<additionalneeds>"
And i am verifying new booking details using booking_payload and booking_response
Then i am updating complete booking details with new details "<firstnameNew>" "<lastnameNew>" "<totalpriceNew>" "<depositpaidNew>" "<checkinNew>" "<checkoutNew>" "<additionalneedsNew>"
And i am verifying updated booking details with "complete" new details

Examples:
|firstname|lastname|totalprice|depositpaid|checkin   |checkout  |additionalneeds|firstnameNew|lastnameNew|totalpriceNew|depositpaidNew|checkinNew|checkoutNew|additionalneedsNew|
| Aaditya |mahajan | 10000    | true      |2020-05-23|2020-06-23|   dinner      |  Sunil     | Lulla     |  9999       | false        |2020-05-20|2020-05-23 |  Lunch           |
| Aaditya |mahajan | 10000    | true      |2020-05-23|2020-06-23|   dinner      | Fisdom     | Tests     |  19999      | false        |2020-05-10|2020-05-13 |  Brunch          |

@Fisdom_auto_TC03
Scenario Outline: verify booking update feature - partial update for 1 key value pair
Given i create booking for "<firstname>" "<lastname>" "<totalprice>" "<depositpaid>" "<checkin>" "<checkout>" "<additionalneeds>"
And i am verifying new booking details using booking_payload and booking_response
Then i want to update partial booking details with new details "<key>" "<value>"
And i am verifying updated booking details with "partial" new details

Examples:
|firstname|lastname|totalprice|depositpaid|checkin   |checkout  |additionalneeds|   key     | value    |
| Aaditya |mahajan | 10000    | true      |2020-05-23|2020-06-23|   dinner      |firstname  | Rahul    |
| Aaditya |mahajan | 10000    | true      |2020-05-23|2020-06-23|   dinner      |lastname   | Sam      |
| Aaditya |mahajan | 10000    | true      |2020-05-23|2020-06-23|   dinner      |totalprice | 100      |
| Aaditya |mahajan | 10000    | true      |2020-05-23|2020-06-23|   dinner      |depositpaid| false    |
| Aaditya |mahajan | 10000    | true      |2020-05-23|2020-06-23|   dinner      |checkin    |2020-05-05|
| Aaditya |mahajan | 10000    | true      |2020-05-23|2020-06-23|   dinner      |checkout   |2020-05-26|
| Aaditya |mahajan | 10000    | true      |2020-05-23|2020-06-23|   dinner      |additionalneeds|Breakfast|

@Fisdom_auto_TC04
Scenario Outline: verify booking update feature - partial update for more than 1 key value pair
Given i create booking for "<firstname>" "<lastname>" "<totalprice>" "<depositpaid>" "<checkin>" "<checkout>" "<additionalneeds>"
And i am verifying new booking details using booking_payload and booking_response
Then i want to update partial booking details with new details "<key1>" "<value1>"
Then i want to update partial booking details with new details "<key2>" "<value2>"
Then i am updating booking partially for more than one fields
And i am verifying updated booking details with "partial" new details

Examples:
|firstname|lastname|totalprice|depositpaid|checkin   |checkout  |additionalneeds|   key1        | value1     |   key2    | value2   |
| Aaditya |mahajan | 10000    | true      |2020-05-23|2020-06-23|   dinner      |firstname      | Rahul      |depositpaid| false    |
| Aaditya |mahajan | 10000    | true      |2020-05-23|2020-06-23|   dinner      |firstname      | Sam        | lastname  | Lalwani  |
| Aaditya |mahajan | 10000    | true      |2020-05-23|2020-06-23|   dinner      |totalprice     | 1          |depositpaid| false    |
| Aaditya |mahajan | 10000    | true      |2020-05-23|2020-06-23|   dinner      |checkin        |2020-05-02  |checkout   |2020-06-20|
| Aaditya |mahajan | 10000    | true      |2020-05-23|2020-06-23|   dinner      |additionalneeds|lunch,Dinner|totalprice | 102      |
