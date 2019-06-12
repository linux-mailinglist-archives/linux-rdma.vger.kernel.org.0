Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 78310424F1
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Jun 2019 14:01:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436543AbfFLMBa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 12 Jun 2019 08:01:30 -0400
Received: from mail-eopbgr80083.outbound.protection.outlook.com ([40.107.8.83]:46215
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2405198AbfFLMB1 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 12 Jun 2019 08:01:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EO4Iycp3fsUgftd0Oyk0Y8Io9KQQjr5jsB51SudjDso=;
 b=sbACYzC1GJEbQQu0818GHsYKGsydQAFn2eJKBdgHzKdwDaU/LWTRsu822027JpZkt2WQS0XmB2mwNhvSf0mfYAb9XXQJQswVBXYeIlpUH5y/As3bvbKam1/squpmRM7H9rt5T2Sc4UzX5lPLHLTUs6IFar8mB6j6Dmo64WvF4yk=
Received: from VI1PR05MB3229.eurprd05.prod.outlook.com (10.170.238.10) by
 VI1PR05MB4190.eurprd05.prod.outlook.com (10.171.183.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.11; Wed, 12 Jun 2019 12:01:23 +0000
Received: from VI1PR05MB3229.eurprd05.prod.outlook.com
 ([fe80::a021:43b4:a6bd:ae97]) by VI1PR05MB3229.eurprd05.prod.outlook.com
 ([fe80::a021:43b4:a6bd:ae97%5]) with mapi id 15.20.1987.010; Wed, 12 Jun 2019
 12:01:23 +0000
From:   Mark Zhang <markz@mellanox.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Majd Dibbiny <majd@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>
Subject: Re: [PATCH rdma-next v3 09/17] IB/mlx5: Support statistic q counter
 configuration
Thread-Topic: [PATCH rdma-next v3 09/17] IB/mlx5: Support statistic q counter
 configuration
Thread-Index: AQHVHFYxeKuwT/WBVEuQY2VJiaJ976aWxLaAgAEvo4A=
Date:   Wed, 12 Jun 2019 12:01:23 +0000
Message-ID: <285c454e-2a20-d9e0-56a4-7738dd375d17@mellanox.com>
References: <20190606105345.8546-1-leon@kernel.org>
 <20190606105345.8546-10-leon@kernel.org> <20190611175419.GA19838@ziepe.ca>
In-Reply-To: <20190611175419.GA19838@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM5PR0202CA0001.eurprd02.prod.outlook.com
 (2603:10a6:203:69::11) To VI1PR05MB3229.eurprd05.prod.outlook.com
 (2603:10a6:802:1c::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=markz@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [115.195.217.69]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f009bf86-0299-418b-4f70-08d6ef2db068
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR05MB4190;
x-ms-traffictypediagnostic: VI1PR05MB4190:
x-microsoft-antispam-prvs: <VI1PR05MB41907E0503158A9A18B4DA6FCAEC0@VI1PR05MB4190.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-forefront-prvs: 0066D63CE6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(39860400002)(396003)(366004)(346002)(199004)(189003)(66476007)(25786009)(229853002)(8936002)(31696002)(86362001)(2906002)(478600001)(54906003)(316002)(110136005)(71190400001)(14454004)(6116002)(3846002)(107886003)(4326008)(6436002)(66946007)(73956011)(71200400001)(6486002)(5660300002)(6246003)(6512007)(66556008)(64756008)(66446008)(53936002)(36756003)(486006)(256004)(6506007)(476003)(386003)(2616005)(446003)(68736007)(305945005)(66066001)(76176011)(186003)(52116002)(11346002)(26005)(7736002)(102836004)(99286004)(53546011)(31686004)(81166006)(81156014)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB4190;H:VI1PR05MB3229.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: TgJ0cOpLnafQ4Gi1amrAXWBjw/cvGIlW9ZkLm/PvARF2kbMc/PaTFVfvEBGsllCo+InD+V4g+mRaixQdmoy8mUrWDhXz6ZpvF0v0rfoeIzDWfKE0fWKUV7uHmdEEKoYYOAPO5eqHuVwbUNg8hJ1FxzoeeVsIC1icHAKQY3W8x0bhI0L8XbWr+2a5FmnPHNTWUwoqBWeohEwb4rfUdbkdtUw4QQjo6SWNVIGl5BsR1JqtPduL0GdX/LDZvvAI9KdvhdTCoHA2GsW72x7619v+f8EUZf9icnjp3p0+YzeNuR85FFmqHYA79LCvjS3ahSYL8tCzzhoDHynePBVaXhDBQ5wxKf5EjrnQYfnBKMvi98WlJJrj+WbbR6Ofw5VyOBfxe1hiPi0yrBCZPgVcfyd5JoPdUqbzEszPyZlDUnY1ZMs=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AF652FE590347D47A90455B88D3F7CA1@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f009bf86-0299-418b-4f70-08d6ef2db068
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2019 12:01:23.4774
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: markz@mellanox.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB4190
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

T24gNi8xMi8yMDE5IDE6NTQgQU0sIEphc29uIEd1bnRob3JwZSB3cm90ZToNCj4gT24gVGh1LCBK
dW4gMDYsIDIwMTkgYXQgMDE6NTM6MzdQTSArMDMwMCwgTGVvbiBSb21hbm92c2t5IHdyb3RlOg0K
Pj4gRnJvbTogTWFyayBaaGFuZyA8bWFya3pAbWVsbGFub3guY29tPg0KPj4NCj4+IEFkZCBzdXBw
b3J0IGZvciBpYiBjYWxsYmFja3MgY291bnRlcl9iaW5kX3FwKCkgYW5kIGNvdW50ZXJfdW5iaW5k
X3FwKCkuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogTWFyayBaaGFuZyA8bWFya3pAbWVsbGFub3gu
Y29tPg0KPj4gUmV2aWV3ZWQtYnk6IE1hamQgRGliYmlueSA8bWFqZEBtZWxsYW5veC5jb20+DQo+
PiBTaWduZWQtb2ZmLWJ5OiBMZW9uIFJvbWFub3Zza3kgPGxlb25yb0BtZWxsYW5veC5jb20+DQo+
PiAgIGRyaXZlcnMvaW5maW5pYmFuZC9ody9tbHg1L21haW4uYyB8IDUzICsrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysNCj4+ICAgMSBmaWxlIGNoYW5nZWQsIDUzIGluc2VydGlvbnMoKykN
Cj4+DQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pbmZpbmliYW5kL2h3L21seDUvbWFpbi5jIGIv
ZHJpdmVycy9pbmZpbmliYW5kL2h3L21seDUvbWFpbi5jDQo+PiBpbmRleCA4YjdiY2Y4ZjY4ZmIu
LjY2Yzk0YTA2MDcxOCAxMDA2NDQNCj4+ICsrKyBiL2RyaXZlcnMvaW5maW5pYmFuZC9ody9tbHg1
L21haW4uYw0KPj4gQEAgLTU1MzMsNiArNTUzMyw1NyBAQCBzdGF0aWMgaW50IG1seDVfaWJfZ2V0
X2h3X3N0YXRzKHN0cnVjdCBpYl9kZXZpY2UgKmliZGV2LA0KPj4gICAJcmV0dXJuIG51bV9jb3Vu
dGVyczsNCj4+ICAgfQ0KPj4gICANCj4+ICtzdGF0aWMgaW50IG1seDVfaWJfY291bnRlcl9iaW5k
X3FwKHN0cnVjdCByZG1hX2NvdW50ZXIgKmNvdW50ZXIsDQo+PiArCQkJCSAgIHN0cnVjdCBpYl9x
cCAqcXApDQo+PiArew0KPj4gKwlzdHJ1Y3QgbWx4NV9pYl9kZXYgKmRldiA9IHRvX21kZXYocXAt
PmRldmljZSk7DQo+PiArCXUxNiBjbnRfc2V0X2lkID0gMDsNCj4+ICsJaW50IGVycjsNCj4+ICsN
Cj4+ICsJaWYgKCFjb3VudGVyLT5pZCkgew0KPj4gKwkJZXJyID0gbWx4NV9jbWRfYWxsb2NfcV9j
b3VudGVyKGRldi0+bWRldiwNCj4+ICsJCQkJCSAgICAgICAmY250X3NldF9pZCwNCj4+ICsJCQkJ
CSAgICAgICBNTFg1X1NIQVJFRF9SRVNPVVJDRV9VSUQpOw0KPj4gKwkJaWYgKGVycikNCj4+ICsJ
CQlyZXR1cm4gZXJyOw0KPj4gKwkJY291bnRlci0+aWQgPSBjbnRfc2V0X2lkOw0KPj4gKwl9DQo+
PiArDQo+PiArCWVyciA9IG1seDVfaWJfcXBfc2V0X2NvdW50ZXIocXAsIGNvdW50ZXIpOw0KPj4g
KwlpZiAoZXJyKQ0KPj4gKwkJZ290byBmYWlsX3NldF9jb3VudGVyOw0KPj4gKw0KPj4gKwlyZXR1
cm4gMDsNCj4+ICsNCj4+ICtmYWlsX3NldF9jb3VudGVyOg0KPj4gKwltbHg1X2NvcmVfZGVhbGxv
Y19xX2NvdW50ZXIoZGV2LT5tZGV2LCBjbnRfc2V0X2lkKTsNCj4+ICsJY291bnRlci0+aWQgPSAw
Ow0KPj4gKw0KPj4gKwlyZXR1cm4gZXJyOw0KPj4gK30NCj4+ICsNCj4+ICtzdGF0aWMgaW50IG1s
eDVfaWJfY291bnRlcl91bmJpbmRfcXAoc3RydWN0IGliX3FwICpxcCwgYm9vbCBmb3JjZSkNCj4+
ICt7DQo+PiArCXN0cnVjdCBtbHg1X2liX2RldiAqZGV2ID0gdG9fbWRldihxcC0+ZGV2aWNlKTsN
Cj4+ICsJc3RydWN0IHJkbWFfY291bnRlciAqY291bnRlciA9IHFwLT5jb3VudGVyOw0KPj4gKwlp
bnQgZXJyOw0KPj4gKw0KPj4gKwllcnIgPSBtbHg1X2liX3FwX3NldF9jb3VudGVyKHFwLCBOVUxM
KTsNCj4+ICsJaWYgKGVyciAmJiAhZm9yY2UpDQo+PiArCQlyZXR1cm4gZXJyOw0KPj4gKw0KPj4g
KwkvKg0KPj4gKwkgKiBEZWFsbG9jYXRlIHRoZSBjb3VudGVyIGlmIHRoaXMgaXMgdGhlIGxhc3Qg
UVAgYm91bmQgb24gaXQ7DQo+PiArCSAqIElmIEBmb3JjZSBpcyBzZXQgdGhlbiB3ZSBzdGlsbCBk
ZWFsbG9jYXRlIHRoZSBxIGNvdW50ZXINCj4+ICsJICogbm8gbWF0dGVyIGlmIHRoZXJlJ3MgYW55
IGVycm9yIGluIHByZXZpb3VzLiB1c2VkIGZvciBjYXNlcw0KPj4gKwkgKiBsaWtlIHFwIGRlc3Ry
b3kuDQo+PiArCSAqLw0KPj4gKwlpZiAoYXRvbWljX3JlYWQoJmNvdW50ZXItPnVzZWNudCkgPT0g
MSkNCj4+ICsJCXJldHVybiBtbHg1X2NvcmVfZGVhbGxvY19xX2NvdW50ZXIoZGV2LT5tZGV2LCBj
b3VudGVyLT5pZCk7DQo+IA0KPiBUaGlzIGxvb2tzIGxpa2UgYSBub25zZW5zZSB0aGluZyB0byB3
cml0ZSwgd2hhdCBpdCBpcyB0cnlpbmcgdG8gZG8NCj4gd2l0aCB0aGF0IGF0b21pYz8NCj4gDQo+
IEkgc3RpbGwgY2FuJ3Qgc2VlIHdoeSB0aGlzIGlzbid0IGEgbm9ybWFsIGtyZWYuDQo+IA0KDQpI
aSBKYXNvbiwNCg0KSGF2ZSBkaXNjdXNzZWQgd2l0aCBMZW9uLCB1bmxpa2Ugb3RoZXIgcmVzb3Vy
Y2VzLCBjb3VudGVyIGFsbG9jL2RlYWxsb2MgDQppc24ndCBjYWxsZWQgZXhwbGljaXRseS4gU28g
d2UgbmVlZCBhIHJlZmNvdW50IHRvIHJlY29yZCBob3cgbWFueSBRUHMgDQphcmUgYm91bmQgb24g
dGhpcyBjb3VudGVyLCB3aGVuIGl0IGNvbWVzIHRvIDAgdGhlbiB0aGUgY291bnRlciBjYW4gYmUg
DQpkZWFsbG9jYXRlZC4gV2hldGhlciB0byB1c2UgYXRvbWljIG9yIGtyZWYgdGhlIGNvZGUgaXMg
c2ltaWxhciwgaXQgaXMgDQpub3QgYWJsZSB0byB0YWtlIGFkdmFudGFnZSBvZiBrcmVmL2NvbXBs
ZXRpb24uDQoNCj4gSmFzb24NCj4gDQoNCg==
