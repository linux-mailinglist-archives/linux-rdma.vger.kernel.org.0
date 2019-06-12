Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46A7C429C4
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Jun 2019 16:47:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732490AbfFLOrZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 12 Jun 2019 10:47:25 -0400
Received: from mail-eopbgr20063.outbound.protection.outlook.com ([40.107.2.63]:52640
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728707AbfFLOrZ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 12 Jun 2019 10:47:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aS0omOLVNKpymr9SpImIhTN4qVbYPZhTUFNskDWKTsQ=;
 b=N7EYqU5Jk847bcJJh6/Mhl4j+rBEYC95IhYMQPAuReoGaA3MXOcwJKsjhtQceJMcHEuQ96RLZ+QCWEWWX8YiHVUlkyqz8NJGfnOms28SZ+HHBg55nu6P1bhNd33F8QKMycp//OFvM+6nU1woF3oS4aLEwiuikLhPhz+QcikoCbQ=
Received: from VI1PR05MB3229.eurprd05.prod.outlook.com (10.170.238.10) by
 VI1SPR01MB0360.eurprd05.prod.outlook.com (20.177.55.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.11; Wed, 12 Jun 2019 14:47:20 +0000
Received: from VI1PR05MB3229.eurprd05.prod.outlook.com
 ([fe80::a021:43b4:a6bd:ae97]) by VI1PR05MB3229.eurprd05.prod.outlook.com
 ([fe80::a021:43b4:a6bd:ae97%5]) with mapi id 15.20.1987.010; Wed, 12 Jun 2019
 14:47:20 +0000
From:   Mark Zhang <markz@mellanox.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Majd Dibbiny <majd@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>
Subject: Re: [PATCH rdma-next v3 09/17] IB/mlx5: Support statistic q counter
 configuration
Thread-Topic: [PATCH rdma-next v3 09/17] IB/mlx5: Support statistic q counter
 configuration
Thread-Index: AQHVHFYxeKuwT/WBVEuQY2VJiaJ976aWxLaAgAEvo4CAAAHxAIAAATyAgAAZxACAABF6gA==
Date:   Wed, 12 Jun 2019 14:47:20 +0000
Message-ID: <847457f6-e1df-2f4e-e86c-f53ec5879455@mellanox.com>
References: <20190606105345.8546-1-leon@kernel.org>
 <20190606105345.8546-10-leon@kernel.org> <20190611175419.GA19838@ziepe.ca>
 <285c454e-2a20-d9e0-56a4-7738dd375d17@mellanox.com>
 <20190612120802.GE3876@ziepe.ca> <20190612121227.GQ6369@mtr-leonro.mtl.com>
 <20190612134440.GF3876@ziepe.ca>
In-Reply-To: <20190612134440.GF3876@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6P194CA0025.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:209:90::38) To VI1PR05MB3229.eurprd05.prod.outlook.com
 (2603:10a6:802:1c::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=markz@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [115.195.217.69]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 47b07395-5e3e-4913-0551-08d6ef44df64
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1SPR01MB0360;
x-ms-traffictypediagnostic: VI1SPR01MB0360:
x-microsoft-antispam-prvs: <VI1SPR01MB03604BF6D2329BAC743644B3CAEC0@VI1SPR01MB0360.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-forefront-prvs: 0066D63CE6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(396003)(39860400002)(136003)(376002)(189003)(199004)(66946007)(73956011)(81166006)(6506007)(53546011)(64756008)(66476007)(66446008)(66556008)(31696002)(6436002)(25786009)(102836004)(54906003)(386003)(229853002)(110136005)(6486002)(99286004)(256004)(4326008)(8676002)(66066001)(6246003)(6512007)(81156014)(8936002)(26005)(478600001)(86362001)(305945005)(36756003)(2906002)(476003)(5660300002)(71190400001)(76176011)(53936002)(11346002)(2616005)(446003)(31686004)(52116002)(486006)(68736007)(186003)(316002)(71200400001)(14454004)(6116002)(107886003)(3846002)(7736002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1SPR01MB0360;H:VI1PR05MB3229.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Zt2yUsR5ffKqE1eO4e+zmx+/Qz0v/2b8D//CnO2rDPVYAKyyT/RNeDVMmG6PRDZEqxI8O+GLStPZAdUxQgGJxenOhMUQ9e9Dxi/1DjWfB9PlScozLZ1e2Pe7qhFHgxLNYB6zQBxrCEbAEShy8oV3r9Ku1UCzF7UCzWg0QI/tEWPekf3l/f1uy257qIdF+IhE+fPTpyxd6SZ5U6aQG5Af7iHv7BllBleXPgBAdfql2+hXc23fRr+btAiEM4JEx4gGwicEzIp6T533gGx1XPURrZMjgDCWOEAfCEGgLnm10bMaumOaWtSfyq8rQ/nyLHCbNbCObW8YbhdFmbLD57FcCz7GiqJkMx2Hbre5QG5NZ+C6TNqfqdt3LJ53F02l0TxOiaFJskTyFJ48b8lvAuBQ6fXFOJJWXUIDyvvOq2GolXc=
Content-Type: text/plain; charset="utf-8"
Content-ID: <25F94F976C4ABE40A6B6C8C164F86CB2@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47b07395-5e3e-4913-0551-08d6ef44df64
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2019 14:47:20.6631
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: markz@mellanox.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1SPR01MB0360
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

T24gNi8xMi8yMDE5IDk6NDQgUE0sIEphc29uIEd1bnRob3JwZSB3cm90ZToNCj4gT24gV2VkLCBK
dW4gMTIsIDIwMTkgYXQgMDM6MTI6MjdQTSArMDMwMCwgTGVvbiBSb21hbm92c2t5IHdyb3RlOg0K
Pj4gT24gV2VkLCBKdW4gMTIsIDIwMTkgYXQgMDk6MDg6MDJBTSAtMDMwMCwgSmFzb24gR3VudGhv
cnBlIHdyb3RlOg0KPj4+IE9uIFdlZCwgSnVuIDEyLCAyMDE5IGF0IDEyOjAxOjIzUE0gKzAwMDAs
IE1hcmsgWmhhbmcgd3JvdGU6DQo+Pj4+IE9uIDYvMTIvMjAxOSAxOjU0IEFNLCBKYXNvbiBHdW50
aG9ycGUgd3JvdGU6DQo+Pj4+PiBPbiBUaHUsIEp1biAwNiwgMjAxOSBhdCAwMTo1MzozN1BNICsw
MzAwLCBMZW9uIFJvbWFub3Zza3kgd3JvdGU6DQo+Pj4+Pj4gRnJvbTogTWFyayBaaGFuZyA8bWFy
a3pAbWVsbGFub3guY29tPg0KPj4+Pj4+DQo+Pj4+Pj4gQWRkIHN1cHBvcnQgZm9yIGliIGNhbGxi
YWNrcyBjb3VudGVyX2JpbmRfcXAoKSBhbmQgY291bnRlcl91bmJpbmRfcXAoKS4NCj4+Pj4+Pg0K
Pj4+Pj4+IFNpZ25lZC1vZmYtYnk6IE1hcmsgWmhhbmcgPG1hcmt6QG1lbGxhbm94LmNvbT4NCj4+
Pj4+PiBSZXZpZXdlZC1ieTogTWFqZCBEaWJiaW55IDxtYWpkQG1lbGxhbm94LmNvbT4NCj4+Pj4+
PiBTaWduZWQtb2ZmLWJ5OiBMZW9uIFJvbWFub3Zza3kgPGxlb25yb0BtZWxsYW5veC5jb20+DQo+
Pj4+Pj4gICAgZHJpdmVycy9pbmZpbmliYW5kL2h3L21seDUvbWFpbi5jIHwgNTMgKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKw0KPj4+Pj4+ICAgIDEgZmlsZSBjaGFuZ2VkLCA1MyBpbnNl
cnRpb25zKCspDQo+Pj4+Pj4NCj4+Pj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pbmZpbmliYW5k
L2h3L21seDUvbWFpbi5jIGIvZHJpdmVycy9pbmZpbmliYW5kL2h3L21seDUvbWFpbi5jDQo+Pj4+
Pj4gaW5kZXggOGI3YmNmOGY2OGZiLi42NmM5NGEwNjA3MTggMTAwNjQ0DQo+Pj4+Pj4gKysrIGIv
ZHJpdmVycy9pbmZpbmliYW5kL2h3L21seDUvbWFpbi5jDQo+Pj4+Pj4gQEAgLTU1MzMsNiArNTUz
Myw1NyBAQCBzdGF0aWMgaW50IG1seDVfaWJfZ2V0X2h3X3N0YXRzKHN0cnVjdCBpYl9kZXZpY2Ug
KmliZGV2LA0KPj4+Pj4+ICAgIAlyZXR1cm4gbnVtX2NvdW50ZXJzOw0KPj4+Pj4+ICAgIH0NCj4+
Pj4+Pg0KPj4+Pj4+ICtzdGF0aWMgaW50IG1seDVfaWJfY291bnRlcl9iaW5kX3FwKHN0cnVjdCBy
ZG1hX2NvdW50ZXIgKmNvdW50ZXIsDQo+Pj4+Pj4gKwkJCQkgICBzdHJ1Y3QgaWJfcXAgKnFwKQ0K
Pj4+Pj4+ICt7DQo+Pj4+Pj4gKwlzdHJ1Y3QgbWx4NV9pYl9kZXYgKmRldiA9IHRvX21kZXYocXAt
PmRldmljZSk7DQo+Pj4+Pj4gKwl1MTYgY250X3NldF9pZCA9IDA7DQo+Pj4+Pj4gKwlpbnQgZXJy
Ow0KPj4+Pj4+ICsNCj4+Pj4+PiArCWlmICghY291bnRlci0+aWQpIHsNCj4+Pj4+PiArCQllcnIg
PSBtbHg1X2NtZF9hbGxvY19xX2NvdW50ZXIoZGV2LT5tZGV2LA0KPj4+Pj4+ICsJCQkJCSAgICAg
ICAmY250X3NldF9pZCwNCj4+Pj4+PiArCQkJCQkgICAgICAgTUxYNV9TSEFSRURfUkVTT1VSQ0Vf
VUlEKTsNCj4+Pj4+PiArCQlpZiAoZXJyKQ0KPj4+Pj4+ICsJCQlyZXR1cm4gZXJyOw0KPj4+Pj4+
ICsJCWNvdW50ZXItPmlkID0gY250X3NldF9pZDsNCj4+Pj4+PiArCX0NCj4+Pj4+PiArDQo+Pj4+
Pj4gKwllcnIgPSBtbHg1X2liX3FwX3NldF9jb3VudGVyKHFwLCBjb3VudGVyKTsNCj4+Pj4+PiAr
CWlmIChlcnIpDQo+Pj4+Pj4gKwkJZ290byBmYWlsX3NldF9jb3VudGVyOw0KPj4+Pj4+ICsNCj4+
Pj4+PiArCXJldHVybiAwOw0KPj4+Pj4+ICsNCj4+Pj4+PiArZmFpbF9zZXRfY291bnRlcjoNCj4+
Pj4+PiArCW1seDVfY29yZV9kZWFsbG9jX3FfY291bnRlcihkZXYtPm1kZXYsIGNudF9zZXRfaWQp
Ow0KPj4+Pj4+ICsJY291bnRlci0+aWQgPSAwOw0KPj4+Pj4+ICsNCj4+Pj4+PiArCXJldHVybiBl
cnI7DQo+Pj4+Pj4gK30NCj4+Pj4+PiArDQo+Pj4+Pj4gK3N0YXRpYyBpbnQgbWx4NV9pYl9jb3Vu
dGVyX3VuYmluZF9xcChzdHJ1Y3QgaWJfcXAgKnFwLCBib29sIGZvcmNlKQ0KPj4+Pj4+ICt7DQo+
Pj4+Pj4gKwlzdHJ1Y3QgbWx4NV9pYl9kZXYgKmRldiA9IHRvX21kZXYocXAtPmRldmljZSk7DQo+
Pj4+Pj4gKwlzdHJ1Y3QgcmRtYV9jb3VudGVyICpjb3VudGVyID0gcXAtPmNvdW50ZXI7DQo+Pj4+
Pj4gKwlpbnQgZXJyOw0KPj4+Pj4+ICsNCj4+Pj4+PiArCWVyciA9IG1seDVfaWJfcXBfc2V0X2Nv
dW50ZXIocXAsIE5VTEwpOw0KPj4+Pj4+ICsJaWYgKGVyciAmJiAhZm9yY2UpDQo+Pj4+Pj4gKwkJ
cmV0dXJuIGVycjsNCj4+Pj4+PiArDQo+Pj4+Pj4gKwkvKg0KPj4+Pj4+ICsJICogRGVhbGxvY2F0
ZSB0aGUgY291bnRlciBpZiB0aGlzIGlzIHRoZSBsYXN0IFFQIGJvdW5kIG9uIGl0Ow0KPj4+Pj4+
ICsJICogSWYgQGZvcmNlIGlzIHNldCB0aGVuIHdlIHN0aWxsIGRlYWxsb2NhdGUgdGhlIHEgY291
bnRlcg0KPj4+Pj4+ICsJICogbm8gbWF0dGVyIGlmIHRoZXJlJ3MgYW55IGVycm9yIGluIHByZXZp
b3VzLiB1c2VkIGZvciBjYXNlcw0KPj4+Pj4+ICsJICogbGlrZSBxcCBkZXN0cm95Lg0KPj4+Pj4+
ICsJICovDQo+Pj4+Pj4gKwlpZiAoYXRvbWljX3JlYWQoJmNvdW50ZXItPnVzZWNudCkgPT0gMSkN
Cj4+Pj4+PiArCQlyZXR1cm4gbWx4NV9jb3JlX2RlYWxsb2NfcV9jb3VudGVyKGRldi0+bWRldiwg
Y291bnRlci0+aWQpOw0KPj4+Pj4NCj4+Pj4+IFRoaXMgbG9va3MgbGlrZSBhIG5vbnNlbnNlIHRo
aW5nIHRvIHdyaXRlLCB3aGF0IGl0IGlzIHRyeWluZyB0byBkbw0KPj4+Pj4gd2l0aCB0aGF0IGF0
b21pYz8NCj4+Pj4+DQo+Pj4+PiBJIHN0aWxsIGNhbid0IHNlZSB3aHkgdGhpcyBpc24ndCBhIG5v
cm1hbCBrcmVmLg0KPj4+Pj4NCj4+Pj4NCj4+Pj4gSGkgSmFzb24sDQo+Pj4+DQo+Pj4+IEhhdmUg
ZGlzY3Vzc2VkIHdpdGggTGVvbiwgdW5saWtlIG90aGVyIHJlc291cmNlcywgY291bnRlciBhbGxv
Yy9kZWFsbG9jDQo+Pj4+IGlzbid0IGNhbGxlZCBleHBsaWNpdGx5LiBTbyB3ZSBuZWVkIGEgcmVm
Y291bnQgdG8gcmVjb3JkIGhvdyBtYW55IFFQcw0KPj4+PiBhcmUgYm91bmQgb24gdGhpcyBjb3Vu
dGVyLCB3aGVuIGl0IGNvbWVzIHRvIDAgdGhlbiB0aGUgY291bnRlciBjYW4gYmUNCj4+Pj4gZGVh
bGxvY2F0ZWQuIFdoZXRoZXIgdG8gdXNlIGF0b21pYyBvciBrcmVmIHRoZSBjb2RlIGlzIHNpbWls
YXIsIGl0IGlzDQo+Pj4+IG5vdCBhYmxlIHRvIHRha2UgYWR2YW50YWdlIG9mIGtyZWYvY29tcGxl
dGlvbi4NCj4+Pg0KPj4+IFRoYXQgZG9lc24ndCBleHBsYWluIHRoZSBub25zZW5zZSAiYXRvbWlj
X3JlYWQoJmNvdW50ZXItPnVzZWNudCkgPT0gMSINCj4+PiB0ZXN0DQo+Pg0KPj4gSXQgbWVhbnMg
dGhhdCBhbGwgUVBzICJyZXR1cm5lZCIgdGhpcyBjb3VudGVyLg0KPiANCj4gSXQgZG9lc24ndCBt
YWtlIHNlbnNlIHRvIGRvIHNvbWV0aGluZyBsaWtlIHRoYXQgd2l0aCBhbiBhdG9taWMsIGVpdGhl
cg0KPiB5b3Uga25vdyB0aGVyZSBpcyBubyBwb3NzaWJsZSBhdG9taWNfaW5jL2RlYyBhdCB0aGlz
IHBvaW50ICh3aGljaCBiZWdzIHRoZQ0KPiBxdWVzdGlvbiB3aHkgdGVzdCBpdCksIG9yIGl0IGlz
IHJhY3kNCj4gDQoNCkhvdyBhYm91dCBhZGQgYSBuZXcgcGFyYW1ldGVyICJsYXN0X3FwIiwgaWYg
aXQgaXMgdHJ1ZSB0aGVuIGRlYWxsb2NhdGUgDQp0aGUgY291bnRlcj8gU28gdGhhdCB0aGUgImF0
b21pY19yZWFkKCkiIGNoZWNrIGNhbiBiZSBwZXJmb3JtZWQgaW4gY29yZSANCmxheWVyLg0KDQoN
Cj4gSmFzb24NCj4gDQoNCg==
