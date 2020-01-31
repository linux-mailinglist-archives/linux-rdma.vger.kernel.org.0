Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D493A14F0F2
	for <lists+linux-rdma@lfdr.de>; Fri, 31 Jan 2020 17:56:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726590AbgAaQ4O (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 31 Jan 2020 11:56:14 -0500
Received: from mail-eopbgr150059.outbound.protection.outlook.com ([40.107.15.59]:19534
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726322AbgAaQ4O (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 31 Jan 2020 11:56:14 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=STU0X4RAu7nMEvAWx8T7JKDfuZr/T/c2U7wJgAMHpkZaImgg1/gAc++bnE1UZD5fcIHHlpMo2Ja4i2hg7edufKtT+G9p/SN6ZeCuNO6PkiVeQPNvoZ7YauLC8G1/KBrhGLP7mBQo3bj188iPa6R6ONptHzQ8LCvR37Wg/eMC5fscMsnbo6AwSzYuCRqWk8D16auPNz2CrV+Z1TBLmQFhhE/3jgr8hlxsvslP20cKUMnJzB/JbWXg0B2YxwkFOouUbTMKonZ58bafebKyGTF884M7/xRgNPr68IiWDgVeldcrhl/1Nr/XVZCkChJA0oRbT9MQ2aQXpOOyLb8iNQR+cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dFQaQd6uoTxZA043mj10IG4RToLu0lj/ltk/2uynpw0=;
 b=ml6WvaMU/KzhUCfJQj1Zjd8YEfsvsSlIcV3cKZMbN9ArTQp6V6xRXuVNF++PDar767EN8dUqj+hcb0hVp1VjFHuYnsz6qhDwtkEMNALK1QAYSem20vO+3O2NXSac2kVPlzHx/IwZflfm43l0TFmrOCr2JmAeDWqvwqNYEySvtQMDNhIRZkZEUS4vYYzy+PwhXUDk0CR0yjyCPeCFJmYGm5q+qU3hn748QQHHGA8NrdGg1L+7EpJboMtju6zudhEGoSE0TB8tuAsbIe1eNOzC8Ti8wv7pyUhP0LRNiSHlICic4aKoLLStzutIzM2EMVmAhzoYGaVkbywEOvZi4HQ7Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dFQaQd6uoTxZA043mj10IG4RToLu0lj/ltk/2uynpw0=;
 b=pg//SoG1tyIzpwM57NYPImE8uQ7PDZLeh1Jt1W7kDiJP+w8GBO2Ijusz9qbwrXRNio+8wKUFB2rgVK/UQEMTlg/Q2oGHCglIDYUnQ22dDrO2qDz0Sy3xbh3fr79sImVCX/a57oH9Ak3pmXxkL7mJngGXGsqybs76u1XfO8folfA=
Received: from AM0PR05MB4866.eurprd05.prod.outlook.com (20.176.214.160) by
 AM0PR05MB4194.eurprd05.prod.outlook.com (52.134.90.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.22; Fri, 31 Jan 2020 16:56:10 +0000
Received: from AM0PR05MB4866.eurprd05.prod.outlook.com
 ([fe80::445c:4a14:1020:2346]) by AM0PR05MB4866.eurprd05.prod.outlook.com
 ([fe80::445c:4a14:1020:2346%7]) with mapi id 15.20.2686.028; Fri, 31 Jan 2020
 16:56:09 +0000
From:   Parav Pandit <parav@mellanox.com>
To:     Devesh Sharma <devesh.sharma@broadcom.com>
CC:     linux-rdma <linux-rdma@vger.kernel.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        "leon@kernel.org" <leon@kernel.org>
Subject: RE: [PATCH] rdma-core/libibverbs: display gid type in ibv_devinfo
Thread-Topic: [PATCH] rdma-core/libibverbs: display gid type in ibv_devinfo
Thread-Index: AQHV2CHWPXYjVLViAU+bvTcZR5Jhp6gEl8KwgABRkICAAAOOgIAAESeg
Date:   Fri, 31 Jan 2020 16:56:09 +0000
Message-ID: <AM0PR05MB4866823B98F614533BB49CA0D1070@AM0PR05MB4866.eurprd05.prod.outlook.com>
References: <1580466773-24342-1-git-send-email-devesh.sharma@broadcom.com>
 <AM0PR05MB48663242B41CEB51D3535AF9D1070@AM0PR05MB4866.eurprd05.prod.outlook.com>
 <CANjDDBgtVSLK7sBLLSr3-RBt7W+TeJeSo=Df+wDMS6mhowudgA@mail.gmail.com>
 <CANjDDBiZaSPhZk=G4wC4dvP6oULOXaqKLq2gWJWm-jk0xyp=mQ@mail.gmail.com>
In-Reply-To: <CANjDDBiZaSPhZk=G4wC4dvP6oULOXaqKLq2gWJWm-jk0xyp=mQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=parav@mellanox.com; 
x-originating-ip: [106.51.31.117]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a8a2c94c-9e13-450e-55fd-08d7a66e78ce
x-ms-traffictypediagnostic: AM0PR05MB4194:|AM0PR05MB4194:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR05MB4194D3AB672764538A4251F9D1070@AM0PR05MB4194.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 029976C540
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(136003)(396003)(376002)(366004)(346002)(199004)(189003)(8936002)(81166006)(316002)(5660300002)(8676002)(81156014)(478600001)(66476007)(66946007)(64756008)(52536014)(66556008)(54906003)(66446008)(86362001)(76116006)(6916009)(71200400001)(186003)(7696005)(26005)(55236004)(33656002)(4326008)(6506007)(53546011)(55016002)(2906002)(9686003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR05MB4194;H:AM0PR05MB4866.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5+vpyEUTAMtAEbnz9Nt4OLDvvnAUQL1z6e+8t/cXfnqJDk0mwEDblss0hY0Eirbwwz8uqMrraKD7WhhOU5glG3c2aGncY/9Kfvq5+6KXVHB1ZuYj0VFmOKDJXmEFF4qwixtmHSZIwe7iuidoMY5YrPinZMi/GYlCOSzN7LqYH3tiRGd1jxYGdC3y6bsv0a7P9MU9oV6VHEyp6hGCgcN9DSE0GO/fdP5iZKGyHU7GJHyTLXr35D4xSOXsTDmmdNE8apEv0ehDqYpHidrWh7opQVljmfGCVO4yH96QRvJsvJZEXtxQcSbaaSd2mxm2uTFzr3X7VnaI21hIKi6eBIYIW4TyY/vVaoEtrKGUrf2S1A7AWrZQ49qTUYUI12db9Hp40heWvO51SX/UYqhw5BOB4BLGeRStRoBikOrg02MOEPHV9WsnxGU3BRoQ9W15OOL8
x-ms-exchange-antispam-messagedata: vtUQME2xAaZ5UzM7fgk6Qftd/vjuN6CI1ehXu2R6FWYoRX/5e0qd/jCtzjxhW5xBaBeXHTbNX1Lj55VKv/L6McOuIIY43wK1Rvu72cxv6PYx3oVVrG47lIIml2wOs3S9iJ7VL3gDaKbSLra/PlRcmQ==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8a2c94c-9e13-450e-55fd-08d7a66e78ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2020 16:56:09.8556
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e69CQL6kiGgv5tgASEVMDmpr1guEdAmenNrKZUKaP2vAW/Wqr0I86oh7Xbh4O7E/HrAWjs7tcL/SDcob1gO93w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB4194
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCj4gRnJvbTogRGV2ZXNoIFNoYXJtYSA8ZGV2ZXNoLnNoYXJtYUBicm9hZGNvbS5jb20+DQo+
IFNlbnQ6IEZyaWRheSwgSmFudWFyeSAzMSwgMjAyMCA5OjIzIFBNDQo+IFRvOiBQYXJhdiBQYW5k
aXQgPHBhcmF2QG1lbGxhbm94LmNvbT4NCj4gQ2M6IGxpbnV4LXJkbWEgPGxpbnV4LXJkbWFAdmdl
ci5rZXJuZWwub3JnPjsgSmFzb24gR3VudGhvcnBlDQo+IDxqZ2dAbWVsbGFub3guY29tPjsgbGVv
bkBrZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIHJkbWEtY29yZS9saWJpYnZlcmJz
OiBkaXNwbGF5IGdpZCB0eXBlIGluIGlidl9kZXZpbmZvDQo+IA0KPiBPbiBGcmksIEphbiAzMSwg
MjAyMCBhdCA5OjEwIFBNIERldmVzaCBTaGFybWENCj4gPGRldmVzaC5zaGFybWFAYnJvYWRjb20u
Y29tPiB3cm90ZToNCj4gPg0KPiA+IE9uIEZyaSwgSmFuIDMxLCAyMDIwLCAxNjozMCBQYXJhdiBQ
YW5kaXQgPHBhcmF2QG1lbGxhbm94LmNvbT4gd3JvdGU6DQo+ID4gPg0KPiA+ID4gSGkgRGV2ZXNo
LA0KPiA+ID4NCj4gPiA+ID4gRnJvbTogbGludXgtcmRtYS1vd25lckB2Z2VyLmtlcm5lbC5vcmcg
PGxpbnV4LXJkbWEtDQo+ID4gPiA+IG93bmVyQHZnZXIua2VybmVsLm9yZz4gT24gQmVoYWxmIE9m
IERldmVzaCBTaGFybWENCj4gPiA+DQo+ID4gPg0KPiA+ID4gWy4uXQ0KPiA+ID4NCj4gPiA+ID4g
IHN0YXRpYyBpbnQgcHJpbnRfYWxsX3BvcnRfZ2lkcyhzdHJ1Y3QgaWJ2X2NvbnRleHQgKmN0eCwg
dWludDhfdA0KPiA+ID4gPiBwb3J0X251bSwgaW50DQo+ID4gPiA+IHRibF9sZW4pICB7DQo+ID4g
PiA+ICsgICAgIGVudW0gaWJ2X2dpZF90eXBlIHR5cGU7DQo+ID4gPiA+ICAgICAgIHVuaW9uIGli
dl9naWQgZ2lkOw0KPiA+ID4gPiAgICAgICBpbnQgcmMgPSAwOw0KPiA+ID4gPiAgICAgICBpbnQg
aTsNCj4gPiA+ID4gQEAgLTE3NSw4ICsxODUsMTYgQEAgc3RhdGljIGludCBwcmludF9hbGxfcG9y
dF9naWRzKHN0cnVjdA0KPiA+ID4gPiBpYnZfY29udGV4dCAqY3R4LCB1aW50OF90IHBvcnRfbnVt
LCBpbnQgdGINCj4gPiA+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICBwb3J0X251bSwg
aSk7DQo+ID4gPiA+ICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gcmM7DQo+ID4gPiA+ICAg
ICAgICAgICAgICAgfQ0KPiA+ID4gPiArDQo+ID4gPiA+ICsgICAgICAgICAgICAgcmMgPSBpYnZf
cXVlcnlfZ2lkX3R5cGUoY3R4LCBwb3J0X251bSwgaSwgJnR5cGUpOw0KPiA+ID4gPiArICAgICAg
ICAgICAgIGlmIChyYykgew0KPiA+ID4gPiArICAgICAgICAgICAgICAgICAgICAgZnByaW50Zihz
dGRlcnIsICJGYWlsZWQgdG8gcXVlcnkgZ2lkIHR5cGUgdG8NCj4gPiA+ID4gKyBwb3J0ICVkLA0K
PiA+ID4gPiBpbmRleCAlZFxuIiwNCj4gPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgcG9ydF9udW0sIGkpOw0KPiA+ID4gPiArICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIHJj
Ow0KPiA+ID4gR0lEIHRhYmxlIGNhbiBoYXZlIGhvbGVzIGRlcGVuZGluZyBvbiBob3cgSVAgYWRk
cmVzc2VzLCB2bGFuDQo+IGNvbmZpZ3VyZWQvcmVtb3ZlZC4NCj4gPiA+IGlidl9xdWVyeV9naWRf
dHlwZSgpIGlzIG1hc2tpbmcgdGhlIEVJTlZBTCBlcnJvciB3aXRoIFJvQ0V2MSB0eXBlIHNvIGhl
cmUNCj4gcmV0dXJuIGlzIG9rLg0KPiA+ID4gQnV0IGFzIGdvb2QgcHJhY3RpY2UsIGluc3RlYWQg
b2YgYmFpbGluZyBvdXQgdGhlIGxvb3AsIGlmIGl0IHJldHVybnMgZmFpbHVyZSwNCj4gc2tpcCB0
aGUgcGFydGljdWxhciBHSUQgZW50cnkgcHJpbnQuDQo+ID4gPiBUaGlzIHdheSByZXN0IG9mIHZh
bGlkIGVudHJpZXMgY2FuIGJlIHN0aWxsIHByaW50ZWQuDQo+ID4NCj4gPiBPa2F5LCB3aWxsIHNl
bmQgVjIgc2hvcnRseS4NCj4gDQo+IElzIHRoaXMgd2hhdCB5b3Ugd2FudDoNCj4gaWYgKHJjKSB7
DQo+ICAgIHByaW50IG1zZzsNCj4gICAgc2F2ZSByYyBpbiB0bXAgdmFyOw0KPiAgICBjb250aW51
ZTsNCj4gfQ0KPiANCkJpdCBzaW1wbGVyIHRoYW4gdGhhdCB0byBqdXN0IGlnbm9yZSB0aGUgZXJy
b3IgKGZvciBhbiBpbnZhbGlkIGdpZCBlbnRyeSkuDQoNCnJjID0gaWJ2X3F1ZXJ5X2dpZF90eXBl
KGN0eCwgcG9ydF9udW0sIGksICZ0eXBlKTsNCmlmIChyYykgew0KCXJjID0gMDsNCgljb250aW51
ZTsNCn0NCg0KPiBpbiB0aGUgZW5kIGFmdGVyIGxvb3Agb3Zlcg0KPiByZXR1cm4gc2F2ZWQtcmMt
dG1wLXZhcjsNCj4gQWx0ZXIgc2F2ZWQtcmMtdG1wLXZhciBhY2NvcmRpbmdseSBmb3IgZ29vZCBj
YXNlcy4NCg==
