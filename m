Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4D9C35054E
	for <lists+linux-rdma@lfdr.de>; Wed, 31 Mar 2021 19:19:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbhCaRTM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 31 Mar 2021 13:19:12 -0400
Received: from mail-bn8nam11on2047.outbound.protection.outlook.com ([40.107.236.47]:63937
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229615AbhCaRSe (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 31 Mar 2021 13:18:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aPIszknuXsi1sAKiIMOXpeYJ9hF412lQkEFlTL/38I8+Knx1RwBLSJjOFSoqtM//ouv/pbikJKa0dXTsJRxpgFBffqgId+l7LzcjORfsuasFaqhosvLDFxZNCaqxQKVVJMGzFmfHgxLquVRta0tl4NEL7U9rXuI7FMxlRonm8MFjKAh/npO+pOGR9Ze/0gAe92rvCa74op3ackXjIP3AAZ9p9YKkDQ/9P3tkVhGOCwAILeC+OJ4iX2LGIFy2uOSdhB3R9EpalVx6lFEYtpmSYK4SB+WTEKbHpiMLOVU5RMA8P+kdxPXKjBGr5z5QDlbuEhKr9WLfeRX33S14Tm/8Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I/DCE/CVUpQlX3nvpvvjJhXoClGUqvy8WHqrrth21ys=;
 b=Yql0SbnRMAAQdljG8mGrI1oqlX2STCV9TOY/ck2HW+qduujfbbWAptcE8tnVambyfnGuh8RBR1Og579/SxteMhPgmYUkO7RQDelLMTgtOvp0Myw2kiypP5rUNYOHFjZtgQwvBLM+34lm1YEWlvTOalbJmlqFCSGC+XO0+cGq6jUAg/a6jSJxZEslOQe6NSCChWqngf6wan2oHKPfoWAKzxDnWgVc3qN4yl0q+67dJjnr6bXUc7tipxX8t4BsEcnybz9d6yVSH4VvOsK/U1LEZbRnAmy6L3ktAeIVu+C9V9dJWIkWMcZonqGqa1/8k5aea7zBToU2h+kF09FqOxd2OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I/DCE/CVUpQlX3nvpvvjJhXoClGUqvy8WHqrrth21ys=;
 b=QEou8DqwboPZFRemF9siWG16W6VSAWIwFJL82zg5KaLSOFZ5db8laS1ZpGrZ7TtkgJ9LU3nUdG8zU7K2KAA37Ph1/MH41T2iEezSEgvm7B1b6Y/p5ltuWCaQT8HDhFArHRSPYpA689og7t2hp97ziVJ5KMN4EaK+xVEtpF+drdGRMAm+wzujZSa1XhV9eMytZyLMRzp7DapW86zFWEnNw5ZpvGoTWzrQt+fXkUZ+ouul/LUmH6KHfYZyTK7XnwmZ06qbfXVvyTa2YEBd4XH9zfBKtYYVZHXgF9458O5PTh3w1zVBLHYu1fD2wch7uAYtXftTZK45MobDHhHaR6/j+A==
Received: from BY5PR12MB4322.namprd12.prod.outlook.com (2603:10b6:a03:20a::20)
 by BY5PR12MB4066.namprd12.prod.outlook.com (2603:10b6:a03:207::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25; Wed, 31 Mar
 2021 17:18:32 +0000
Received: from BY5PR12MB4322.namprd12.prod.outlook.com
 ([fe80::7cec:a7fa:db2e:3073]) by BY5PR12MB4322.namprd12.prod.outlook.com
 ([fe80::7cec:a7fa:db2e:3073%8]) with mapi id 15.20.3977.033; Wed, 31 Mar 2021
 17:18:32 +0000
From:   Parav Pandit <parav@nvidia.com>
To:     =?utf-8?B?SMOla29uIEJ1Z2dl?= <haakon.bugge@oracle.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH for-next v2] IB/cma: Introduce rdma_set_min_rnr_timer()
Thread-Topic: [PATCH for-next v2] IB/cma: Introduce rdma_set_min_rnr_timer()
Thread-Index: AQHXJkhjZJlaSKG8ZU258Zop7I4yi6qeVZNw
Date:   Wed, 31 Mar 2021 17:18:32 +0000
Message-ID: <BY5PR12MB4322830D8217E920F98C7EF0DC7C9@BY5PR12MB4322.namprd12.prod.outlook.com>
References: <1617206973-1044-1-git-send-email-haakon.bugge@oracle.com>
In-Reply-To: <1617206973-1044-1-git-send-email-haakon.bugge@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=nvidia.com;
x-originating-ip: [136.185.184.152]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1af1d620-454f-49d6-3204-08d8f4690272
x-ms-traffictypediagnostic: BY5PR12MB4066:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB4066C544E6899EE60C3E3959DC7C9@BY5PR12MB4066.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: r3iEjf3R7KXefEss+pTH8olvd4TFaVkye7fPk+1LtFTj2WzVxcVWps6GXTeXhynLvGRQuoetvff0bZK9NKjWF9oNkAlBZyDMbhcZXGPxdEH+911aR1m0oq9BBNkZ0/Lo1kqLx7CoIQctltKECi/2R+lFqbZgEgC3cZcnOiH3jGCn4UjEC1xbGEMaU1pMw6xmKTyzsv4GwrYBOlHm6ZoBBHD4ydHObcO7wctjoDmbrijSDlc18NJiXFU9p2I9FmuL3jFZRTM9Qssh34/paA0L+zcYZpKK9nUgj4Jy1hxxP+UXBhsVH72jj+Juol2Tzjk2kVZmWgWH8POhkdpjHui61DTeb9UxY9jXWfGazYAtqAW9FJA6B4M3h/VSdretTc/bs8ag4JoPEU2qA0kcRdcfyYH7zWwMSgHPgZBei2rdunxALuW8XJ/xXix5Uw9hkufZOyj4h4j/ERmnVLsDSal7OyAZcTkdtHeI47tWkooLYFxvSgNitgNWagz3QkaH4plxKWo/EWV5ou53XKU0lv+AcpzVbM422S/rxvWBxbelV7nIXOXv5tYEylhMoeMcLK0L1Az3sWvioU9FdpXy/xWwTzT3/Ry+Ni8USCUigXDj8h+bIZ6MS6SI+baz5QA2xD/8Qx4BMFMQPsMxXkdrR3h6t1dVgw2v0ZZXd6gKOQdKXeg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4322.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(346002)(39860400002)(136003)(366004)(71200400001)(66476007)(66946007)(66446008)(2906002)(76116006)(52536014)(66574015)(186003)(66556008)(26005)(7696005)(64756008)(5660300002)(478600001)(55016002)(83380400001)(8676002)(8936002)(316002)(110136005)(6506007)(38100700001)(9686003)(86362001)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?OURQZ3JoWjk3b25GYVQwTmRKdHBBRTNwTmZHdEd3NVdZaWFGTEh5VFNTaEFx?=
 =?utf-8?B?VnA5YnFIT0JYU3hjMktlVi9kcG5JT3dCQ0VCM2xrUkZQN0JhUFIxRUVhbjRB?=
 =?utf-8?B?YjBDcWQraWo0RUxjMDY3OWZlSmJ4MU9xekZYLytBTDlENG1VM3Q0NmdseklW?=
 =?utf-8?B?NUdOeDVXUnFmWjJrTEZNblJqVS94NUlMeGNhTGVPLzFaRVJnOFhIOUZKNnd1?=
 =?utf-8?B?SHpsd1pKTk51VktLTG9VVnB4UUdTeW9MaFJVdlBpZnZwb3VONTA3dXBiNlk1?=
 =?utf-8?B?NEZUd1ZTSWtkN2U5V2xQVU1aM1liNmUrTE9vYzNCSm5IeS8xZWhETVB2NzFw?=
 =?utf-8?B?S1g4MzdaY3lYNmhPY3JjRkNUTmZtZ2FjNjA0UWs3a2FZYnllQzUrZFg2eVJB?=
 =?utf-8?B?c2ZqeDZwRDBnQmpNUmJuN3ZXSEphRks0eUNadzJTR0Z4M1dDODhsdWZuakFD?=
 =?utf-8?B?RUtoQ2VPanRicVl0cUJnckc5Ri9ubkVzL2VRbUdvSTY0NVYwdjl1NXl0STVL?=
 =?utf-8?B?ZFZHaW1VSXQzcUVSakRNVGEvblF2MnRmTHRjM0tqRVdPSnRzdFo5bWdEUU1o?=
 =?utf-8?B?WExnWTIvYWJYWTY2VlNlWnZpQndRMitRNkY5a2ZaNFYrQitYTWJSR29kbnl4?=
 =?utf-8?B?NFVYUE5zZEM5WkVCVndzaXZqd1JMY2ZMRE5sbjl0RXZVbVBFK2t1L3NPTzJQ?=
 =?utf-8?B?V2ZhbGZ3eW5zUjVCTnR2OGJVTW5YMFVTR0d6MWFvZ3VpUDZFVUw0Nk1oM0VD?=
 =?utf-8?B?b0xFTFZXZDRwNlh3a1RORWNjdEtBMEFtc0dOb0UrUG8yRmt2VEx0bWFPL3A5?=
 =?utf-8?B?b1Z3Z25vNUdYTC9HUkppQnZvYW5GL01VVnUxcHdqMXlvbm4yWHJaeUpMSEhj?=
 =?utf-8?B?MUNnUG4vaStmMEI1aGd0Vy9LNURoRVVySmQzZnFINmI4RU12Q2Z0RExFNkNX?=
 =?utf-8?B?dHBULzEyQTNmOTk3bE9HNXRnRGV4cTJyQmNhTXcyb2R3ekNNNEhWYlp3R0Z4?=
 =?utf-8?B?QXpXckhkU29nTDlhLysyM1pqTld2Mjd1dzBTOGVCc1BMaUdHNDJOZE9wa3hh?=
 =?utf-8?B?SmdJRVQ2R2RjelJtTkVydkJjbGRsdUU4WHYrcEhyeFc1blphZ0s1VDk3b2h6?=
 =?utf-8?B?dGtkbnRsdGtvbVNsQXVkSUZ4V1Y0b2tKdFhKS0kxNkRlUHArS1EzQkJiMy9F?=
 =?utf-8?B?eWJJNUJtdGRYajdjaHpGUHVpNVdYQWdCYWxrREpnOVlzSGx1bk1oQ01sL0FR?=
 =?utf-8?B?UUVXbFlDZUZiZUF1NVQ3T1lIYkhVZXhGaDFPRHlYSXhFN2UzTXJiN1grNnRq?=
 =?utf-8?B?QmczajYyT0dSdFZMTlI2TXVCZmlNaEg5czltOEdGTVVySWNQNmkvV1pZUGdq?=
 =?utf-8?B?Nlk1dFMzMFh2VmNHVzArV0p1dGlMNWZMMlhZK0JKMXBEazZsd1FvTVpoaWY5?=
 =?utf-8?B?YWxwL2dZVzk0NWNlQ1pZUFNMOEg2bzhRcFJFZkdHRGpsVkE5Q0pac0VIUUls?=
 =?utf-8?B?MUgyOEZXSE9aVCsvTzV6cnhoZm9iQ25CdENtZHBmNW1ZQytUTWN2dXZCMWF1?=
 =?utf-8?B?S2Z6VDFLWWtlQ1MxcXVDL2lSNnh6VlR3RCt6RjBLZTBzRXRuRUFxS3owMC9P?=
 =?utf-8?B?STZOZ21MaFJhbFBFNVoxNmMyTThrSVVDMVZuZGErV1VjUkduMlZMbE5iVXJj?=
 =?utf-8?B?TUNuamJnSFhOZmNvUTlvRUFqOE0ydVFMZzM0SGhSOHMyNnFJWk81STF4VGpv?=
 =?utf-8?Q?Cl9J0BP+vkpRxhJp9iA7tWfYbEx44zw5HQxE8hK?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4322.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1af1d620-454f-49d6-3204-08d8f4690272
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2021 17:18:32.2258
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q8F7mkO9z7r4+zYC4NVP9ulKQtipFkwFJGI7vY86QuleOV8M0v5/JsIJ+A0tEkDoEIVRhH6AcT2ovMb9pjBAuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4066
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCj4gRnJvbTogSMOla29uIEJ1Z2dlIDxoYWFrb24uYnVnZ2VAb3JhY2xlLmNvbT4NCj4gU2Vu
dDogV2VkbmVzZGF5LCBNYXJjaCAzMSwgMjAyMSA5OjQwIFBNDQo+IA0KPiBJbnRyb2R1Y2UgdGhl
IGFiaWxpdHkgZm9yIGtlcm5lbCBVTFBzIHRvIGFkanVzdCB0aGUgbWluaW11bSBSTlIgUmV0cnkg
dGltZXIuDQo+IFRoZSBJTklUIC0+IFJUUiB0cmFuc2l0aW9uIGV4ZWN1dGVkIGJ5IFJETUEgQ00g
d2lsbCBiZSB1c2VkIGZvciB0aGlzDQo+IGFkanVzdG1lbnQuIFRoaXMgYXZvaWRzIGFuIGFkZGl0
aW9uYWwgaWJfbW9kaWZ5X3FwKCkgY2FsbC4NCj4gDQo+IHJkbWFfc2V0X21pbl9ybnJfdGltZXIo
KSBtdXN0IGJlIGNhbGxlZCBiZWZvcmUgdGhlIGNhbGwgdG8NCj4gcmRtYV9jb25uZWN0KCkgb24g
dGhlIGFjdGl2ZSBzaWRlIGFuZCBiZWZvcmUgdGhlIGNhbGwgdG8gcmRtYV9hY2NlcHQoKSBvbg0K
PiB0aGUgcGFzc2l2ZSBzaWRlLg0KPiANCklmIHlvdSBhZGQgYSBsaW5lIG9yIHR3byB0byBleHBs
YWluIG9uIHdoZW4gYSBzcGVjaWZpYyB2YWx1ZSBpcyBzZXQsIGhvdyBpdCBpbXByb3ZlZCB0aGUg
cmVzcG9uc2UgdGltZSAob3IgbGVzcyByZXRyaWVzKSwgd2lsbCBiZSBhIGdvb2QgZm9yIGZ1dHVy
ZSB1c2Vycy4NCg0KPiBTaWduZWQtb2ZmLWJ5OiBIw6Vrb24gQnVnZ2UgPGhhYWtvbi5idWdnZUBv
cmFjbGUuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvaW5maW5pYmFuZC9jb3JlL2NtYS5jICAgICAg
fCAyMyArKysrKysrKysrKysrKysrKysrKysrKw0KPiAgZHJpdmVycy9pbmZpbmliYW5kL2NvcmUv
Y21hX3ByaXYuaCB8ICAyICsrDQo+ICBpbmNsdWRlL3JkbWEvcmRtYV9jbS5oICAgICAgICAgICAg
IHwgIDIgKysNCj4gIDMgZmlsZXMgY2hhbmdlZCwgMjcgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvaW5maW5pYmFuZC9jb3JlL2NtYS5jIGIvZHJpdmVycy9pbmZpbmli
YW5kL2NvcmUvY21hLmMNCj4gaW5kZXggOTQwOTY1MS4uZjUwZGMzMCAxMDA2NDQNCj4gLS0tIGEv
ZHJpdmVycy9pbmZpbmliYW5kL2NvcmUvY21hLmMNCj4gKysrIGIvZHJpdmVycy9pbmZpbmliYW5k
L2NvcmUvY21hLmMNCj4gQEAgLTg1Miw2ICs4NTIsNyBAQCBzdGF0aWMgdm9pZCBjbWFfaWRfcHV0
KHN0cnVjdCByZG1hX2lkX3ByaXZhdGUNCj4gKmlkX3ByaXYpDQo+ICAJaWRfcHJpdi0+aWQucXBf
dHlwZSA9IHFwX3R5cGU7DQo+ICAJaWRfcHJpdi0+dG9zX3NldCA9IGZhbHNlOw0KPiAgCWlkX3By
aXYtPnRpbWVvdXRfc2V0ID0gZmFsc2U7DQo+ICsJaWRfcHJpdi0+bWluX3Jucl90aW1lcl9zZXQg
PSBmYWxzZTsNCj4gIAlpZF9wcml2LT5naWRfdHlwZSA9IElCX0dJRF9UWVBFX0lCOw0KPiAgCXNw
aW5fbG9ja19pbml0KCZpZF9wcml2LT5sb2NrKTsNCj4gIAltdXRleF9pbml0KCZpZF9wcml2LT5x
cF9tdXRleCk7DQo+IEBAIC0xMTQxLDYgKzExNDIsOSBAQCBpbnQgcmRtYV9pbml0X3FwX2F0dHIo
c3RydWN0IHJkbWFfY21faWQgKmlkLA0KPiBzdHJ1Y3QgaWJfcXBfYXR0ciAqcXBfYXR0ciwNCj4g
IAlpZiAoKCpxcF9hdHRyX21hc2sgJiBJQl9RUF9USU1FT1VUKSAmJiBpZF9wcml2LT50aW1lb3V0
X3NldCkNCj4gIAkJcXBfYXR0ci0+dGltZW91dCA9IGlkX3ByaXYtPnRpbWVvdXQ7DQo+IA0KPiAr
CWlmICgoKnFwX2F0dHJfbWFzayAmIElCX1FQX01JTl9STlJfVElNRVIpICYmIGlkX3ByaXYtDQo+
ID5taW5fcm5yX3RpbWVyX3NldCkNCj4gKwkJcXBfYXR0ci0+bWluX3Jucl90aW1lciA9IGlkX3By
aXYtPm1pbl9ybnJfdGltZXI7DQo+ICsNCj4gIAlyZXR1cm4gcmV0Ow0KPiAgfQ0KPiAgRVhQT1JU
X1NZTUJPTChyZG1hX2luaXRfcXBfYXR0cik7DQo+IEBAIC0yNjE1LDYgKzI2MTksMjUgQEAgaW50
IHJkbWFfc2V0X2Fja190aW1lb3V0KHN0cnVjdCByZG1hX2NtX2lkDQo+ICppZCwgdTggdGltZW91
dCkgIH0gIEVYUE9SVF9TWU1CT0wocmRtYV9zZXRfYWNrX3RpbWVvdXQpOw0KDQpQbGVhc2UgYWRk
IHRoZSBrZG9jIHN0eWxlIGNvbW1lbnQgZm9yIHRoaXMgbmV3IEFQSS4gUmVmZXIgdG8gcmRtYV9z
ZXRfYWNrX3RpbWVvdXQoKSBhcyByZWZlcmVuY2UgZXhhbXBsZS4NCkFsc28gbWVudGlvbiB0aGF0
IG1pbl9ybnJfdGltZXIgZm9sbG93cyA1LWJpdCB2YWx1ZSBpcyBlbmNvZGVkIHZhbHVlIG9mIHRh
YmxlIDQ4IG9mIElCIHNwZWMgaW4gY29tbWVudCBzZWN0aW9uIGZvciB1c2Vycy4NCg0KPiANCj4g
K2ludCByZG1hX3NldF9taW5fcm5yX3RpbWVyKHN0cnVjdCByZG1hX2NtX2lkICppZCwgdTggbWlu
X3Jucl90aW1lcikgew0KPiArCXN0cnVjdCByZG1hX2lkX3ByaXZhdGUgKmlkX3ByaXY7DQo+ICsN
Cj4gKwkvKiBJdCBpcyBhIGZpdmUtYml0IHZhbHVlICovDQo+ICsJaWYgKG1pbl9ybnJfdGltZXIg
JiAweGUwKQ0KPiArCQlyZXR1cm4gLUVJTlZBTDsNCj4gKw0KPiArCWlmIChpZC0+cXBfdHlwZSAh
PSBJQl9RUFRfUkMgJiYgaWQtPnFwX3R5cGUgIT0gSUJfUVBUX1hSQ19UR1QpDQo+ICsJCXJldHVy
biAtRUlOVkFMOw0KPiArDQo+ICsJaWRfcHJpdiA9IGNvbnRhaW5lcl9vZihpZCwgc3RydWN0IHJk
bWFfaWRfcHJpdmF0ZSwgaWQpOw0KPiArCWlkX3ByaXYtPm1pbl9ybnJfdGltZXIgPSBtaW5fcm5y
X3RpbWVyOw0KPiArCWlkX3ByaXYtPm1pbl9ybnJfdGltZXJfc2V0ID0gdHJ1ZTsNCj4gKw0KPiAr
CXJldHVybiAwOw0KPiArfQ0KPiArRVhQT1JUX1NZTUJPTChyZG1hX3NldF9taW5fcm5yX3RpbWVy
KTsNCg==
