Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B460391A3
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Jun 2019 18:09:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729797AbfFGQJg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 7 Jun 2019 12:09:36 -0400
Received: from mail-eopbgr130052.outbound.protection.outlook.com ([40.107.13.52]:38624
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729325AbfFGQJg (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 7 Jun 2019 12:09:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Ibi9Yq7Jw3rXHNXkIHEh1C+CTujCzpRhxetU21Zq5E=;
 b=Du1ZX4ZdQH4c71fR9YjdUl0mHVdjp+KuhWO2t/mGyDzgGIMnnb72TxGw5Ya8xIT2381OtKbVTyFSz86cr+rsb4p1yP8cHA6V+eM7MuXpUTDfZD1iuDOB/T7ZOQX6Pg9IiHa3GTwIePGJOZd0l2S3iJLja5JVMl9vMX+xw6jkSLQ=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB3263.eurprd05.prod.outlook.com (10.170.238.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1965.15; Fri, 7 Jun 2019 16:09:31 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::c16d:129:4a40:9ba1]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::c16d:129:4a40:9ba1%6]) with mapi id 15.20.1965.011; Fri, 7 Jun 2019
 16:09:31 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Max Gurtovoy <maxg@mellanox.com>
CC:     Sagi Grimberg <sagi@grimberg.me>,
        Leon Romanovsky <leonro@mellanox.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "hch@lst.de" <hch@lst.de>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        Israel Rukshin <israelr@mellanox.com>,
        Idan Burstein <idanb@mellanox.com>,
        Oren Duer <oren@mellanox.com>,
        Vladimir Koushnir <vladimirk@mellanox.com>,
        Shlomi Nimrodi <shlomin@mellanox.com>
Subject: Re: [PATCH 15/20] RDMA/core: Validate signature handover device cap
Thread-Topic: [PATCH 15/20] RDMA/core: Validate signature handover device cap
Thread-Index: AQHVFutI8IXfz1d/vEebKEIJceO0iKaNfvAAgAAALwCAACi6AIACwRCA
Date:   Fri, 7 Jun 2019 16:09:30 +0000
Message-ID: <20190607160925.GD14771@mellanox.com>
References: <1559222731-16715-1-git-send-email-maxg@mellanox.com>
 <1559222731-16715-16-git-send-email-maxg@mellanox.com>
 <4780f87f-98ba-9432-2de9-352bdf8bf5a0@grimberg.me>
 <a69a134b-d0a5-3144-142e-2050ce935037@grimberg.me>
 <45f75d84-0616-8516-c482-65cbab7b8557@mellanox.com>
In-Reply-To: <45f75d84-0616-8516-c482-65cbab7b8557@mellanox.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: YQBPR0101CA0012.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00::25) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [156.34.55.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3efb4310-7e44-4a2c-9655-08d6eb6285dc
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR05MB3263;
x-ms-traffictypediagnostic: VI1PR05MB3263:
x-microsoft-antispam-prvs: <VI1PR05MB3263829C0F96E5B2270B5F61CF100@VI1PR05MB3263.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2958;
x-forefront-prvs: 0061C35778
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(39860400002)(366004)(136003)(346002)(396003)(189003)(199004)(5660300002)(71190400001)(52116002)(71200400001)(6486002)(229853002)(486006)(25786009)(446003)(7736002)(6246003)(11346002)(53936002)(8676002)(53546011)(6512007)(316002)(6436002)(14454004)(1076003)(81156014)(99286004)(256004)(386003)(6506007)(81166006)(66066001)(66446008)(6116002)(76176011)(186003)(86362001)(68736007)(3846002)(66476007)(107886003)(478600001)(66946007)(66556008)(64756008)(102836004)(73956011)(26005)(476003)(2616005)(6636002)(4326008)(37006003)(36756003)(2906002)(54906003)(33656002)(6862004)(305945005)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB3263;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: MPVwDH6tth+I8jN3t3VjS1jkfGn+SIkPls3afpM4SnAAUmVLXx3/TmSseBKUBmY3OaGfZZsTIL0IYS5ZzP6DXQ9ZPpoY0ysIKCC+zXQabnAuZitI0VoJDLVgkFrcBvoxhgUzFejVlAI7TpcjPYmY2jdlWLYNKFV6laqrafb8Aca5PNjgO3l8Ke9L80TVXkZ824lbUTGHFiDaPYSvv7pPsgX7nOTrA83I2qVqEmDW68bGNKqvXiBQEgFrAp80333+js2TE274VNjiRiO9RhWvswIc2jeKEZBEf+yDT2MQJ8x4QQv+Hg8C1TZ/iL8ZYb33icw2IMDkumn40/EGeW3ukxo9EHm69URX3I56fabvVJqkeSSzGzeGZgwsHZEkbIfUYh/N8HGgH8Gi3wbql8gdrgtwZqOwKhWfiFK6VHOksPg=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C71EE9D99E223546B1B9BB78EFF39448@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3efb4310-7e44-4a2c-9655-08d6eb6285dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2019 16:09:31.0479
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jgg@mellanox.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB3263
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

T24gVGh1LCBKdW4gMDYsIDIwMTkgYXQgMDE6MDU6NTRBTSArMDMwMCwgTWF4IEd1cnRvdm95IHdy
b3RlOg0KPiANCj4gT24gNi81LzIwMTkgMTA6NDAgUE0sIFNhZ2kgR3JpbWJlcmcgd3JvdGU6DQo+
ID4gDQo+ID4gPiA+IC3CoMKgwqAgaWYgKHFwX2luaXRfYXR0ci0+cndxX2luZF90YmwgJiYNCj4g
PiA+ID4gLcKgwqDCoMKgwqDCoMKgIChxcF9pbml0X2F0dHItPnJlY3ZfY3EgfHwNCj4gPiA+ID4g
LcKgwqDCoMKgwqDCoMKgIHFwX2luaXRfYXR0ci0+c3JxIHx8IHFwX2luaXRfYXR0ci0+Y2FwLm1h
eF9yZWN2X3dyIHx8DQo+ID4gPiA+IC3CoMKgwqDCoMKgwqDCoCBxcF9pbml0X2F0dHItPmNhcC5t
YXhfcmVjdl9zZ2UpKQ0KPiA+ID4gPiArwqDCoMKgIGlmICgocXBfaW5pdF9hdHRyLT5yd3FfaW5k
X3RibCAmJg0KPiA+ID4gPiArwqDCoMKgwqDCoMKgwqDCoCAocXBfaW5pdF9hdHRyLT5yZWN2X2Nx
IHx8DQo+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqAgcXBfaW5pdF9hdHRyLT5zcnEgfHwgcXBf
aW5pdF9hdHRyLT5jYXAubWF4X3JlY3Zfd3IgfHwNCj4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDC
oCBxcF9pbml0X2F0dHItPmNhcC5tYXhfcmVjdl9zZ2UpKSB8fA0KPiA+ID4gPiArwqDCoMKgwqDC
oMKgwqAgKChxcF9pbml0X2F0dHItPmNyZWF0ZV9mbGFncyAmIElCX1FQX0NSRUFURV9TSUdOQVRV
UkVfRU4pICYmDQo+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgICEoZGV2aWNlLT5hdHRycy5kZXZp
Y2VfY2FwX2ZsYWdzICYNCj4gPiA+ID4gSUJfREVWSUNFX1NJR05BVFVSRV9IQU5ET1ZFUikpKQ0K
PiA+ID4gDQo+ID4gPiBXb3VsZG4ndCBpdCBtYWtlIHNlbnNlIHRvIGFsc28gY2hhbmdlIHRoZSBx
cCBjcmVhdGUgZmxhZyBhbmQgdGhlIGRldmljZQ0KPiA+ID4gY2FwIHRvIGJlIFBJX0VOL1BJX0hB
TkRPVkVSIHdoaWxlIHdlJ3JlIGF0IGl0Pw0KPiANCj4gV2UncmUgYWxyZWFkeSBzdGFuZGluZyBv
biAyMCBwYXRjaGVzIGluIHRoaXMgc2VyaWVzLCBzbyBpZiBKYXNvbiB3aWxsIGFncmVlDQo+IEkn
bGwgZG8gdGhpcyByZW5hbWluZyBpbiBhIHNlcGFyYXRlIGNvbW1pdCBvciB3ZSBjYW4gc3RheSB3
aXRoIHRoZSBjdXJyZW50DQo+IG5hbWluZy4NCg0KR2l2ZW4gdGhlIENIIGFuZCBTYWdpIGhhdmUg
ZG9uZSB0aGUgaGFyZCB3b3JrIHRvIHJldmlldyB0aGUgbGFyZ2UNCnNlcmllcywgSSBhbSBmaW5l
IHRvIHRha2UgMnggcGF0Y2hlcyBpZiB0aGV5IGFyZSBmaW5lIHRvIHJldmlldyBpdA0KDQpKYXNv
bg0K
