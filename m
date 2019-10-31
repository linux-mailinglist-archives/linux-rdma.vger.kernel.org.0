Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD9B1EAF21
	for <lists+linux-rdma@lfdr.de>; Thu, 31 Oct 2019 12:48:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbfJaLsW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 31 Oct 2019 07:48:22 -0400
Received: from mail-eopbgr10051.outbound.protection.outlook.com ([40.107.1.51]:32521
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726540AbfJaLsW (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 31 Oct 2019 07:48:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cuogtu1X1M5bpnweXRKfT8WD1z5NamF825KYE8v1BTjnqqTKMJ83v5Vmssx1jW6Rhyq5LDVDykRGdmlvcTkUbEkYf8QHXk1Ei52DeaiqJtyyM4cRt4bJyF779ozAQPZgvbnAbLkfN5d0eSdIehS80/TFc7bTKJD0uGhyoVyvYjZJt3Uf5ZTiRyR1Uq4bOYLzZkpByHEBN2CHH+S53c2mdayWp+fyhgL9t6gOT4j3tjrxAT41+DIoAw9xBx/ll2DbyOZV6tG9vqiIeKdR74ezsfTtg8xuTb8iKmTE5HPYE28/gJx9pfjQFmxJLAwnVFzdp1k9l9/F37+pnC42MwuGhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rV9AprcVVDLR9p9U9e0tiOYBq23+YkP4tbyTc4ylf7A=;
 b=Q5yw7qddxUYYQYDuOowAzSezBfi8zjQ73dfNXRscjUzZkG7tPAAboq+axyznUPjLSLsG9ezN/s9hpsbJAEzTEfjTPp4ODL+oHVrIdYDgkNPKImeV/a2MfbKxDONTUiM304VT73zDTss+Reo9H4K0A+vV7sfoUyrvsgeofVj8DB7zzlQrFqMS9KxsJVscibv+toH+Q3XQsLVmTR55B+tOGzwjXcrayhpk/Af0s+7aYvsdSAokiLEV7MRwtFYHDocjUp2a6+vd/HibXpYZLSmxnNkdPF3dJmAntvcvfM7SdFJWhHztnHn4by+ff00eHYWzY1fuzTZqutmyY0zqNzC4MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rV9AprcVVDLR9p9U9e0tiOYBq23+YkP4tbyTc4ylf7A=;
 b=LSkgxTPZMIBKVk1uqI9mxVNZ/R09cAKa2y4fGLx3/L+T0qLncKodXIgcpGQt094KcwjIT4QIUDjLXIfUgTW/yRwzRRPYwkyou/kd5MPRrmWSlrjII8pjhaowltukY5wgZ0EZ3JEEjdbx15Ud/xRsB/deUeyJLC93cFP6ZHaCI9Q=
Received: from AM0PR05MB4755.eurprd05.prod.outlook.com (52.133.59.16) by
 AM0PR05MB6259.eurprd05.prod.outlook.com (20.177.40.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.25; Thu, 31 Oct 2019 11:48:17 +0000
Received: from AM0PR05MB4755.eurprd05.prod.outlook.com
 ([fe80::bc4c:b617:2dfc:da06]) by AM0PR05MB4755.eurprd05.prod.outlook.com
 ([fe80::bc4c:b617:2dfc:da06%7]) with mapi id 15.20.2387.028; Thu, 31 Oct 2019
 11:48:17 +0000
From:   Yevgeny Kliteynik <kliteyn@mellanox.com>
To:     Mark Bloch <markb@mellanox.com>, Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
CC:     RDMA mailing list <linux-rdma@vger.kernel.org>,
        Leon Romanovsky <leonro@mellanox.com>
Subject: RE: [PATCH rdma-next v1] IB/mlx5: Support flow counters offset for
 bulk counters
Thread-Topic: [PATCH rdma-next v1] IB/mlx5: Support flow counters offset for
 bulk counters
Thread-Index: AQHVjnCYQDS+a9vpREGrFWyQm18SuKdx1/EAgAK1MvA=
Date:   Thu, 31 Oct 2019 11:48:17 +0000
Message-ID: <AM0PR05MB47557C25439CB6AD9F8C5DBCCD630@AM0PR05MB4755.eurprd05.prod.outlook.com>
References: <20191029155020.20792-1-leon@kernel.org>
 <a14d4cce-3837-5a1c-d6bd-5e9d5156b179@mellanox.com>
In-Reply-To: <a14d4cce-3837-5a1c-d6bd-5e9d5156b179@mellanox.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=kliteyn@mellanox.com; 
x-originating-ip: [193.47.165.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: aeaeb5dd-a25c-425b-b4cc-08d75df83889
x-ms-traffictypediagnostic: AM0PR05MB6259:|AM0PR05MB6259:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR05MB6259D1156E3ED62FBEA663E5CD630@AM0PR05MB6259.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2150;
x-forefront-prvs: 02070414A1
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(346002)(366004)(376002)(136003)(39860400002)(189003)(199004)(54534003)(486006)(86362001)(11346002)(229853002)(446003)(6116002)(81166006)(81156014)(8676002)(6306002)(476003)(305945005)(9686003)(52536014)(74316002)(7736002)(6636002)(25786009)(5660300002)(2906002)(33656002)(26005)(55016002)(76176011)(6506007)(7696005)(102836004)(53546011)(4326008)(966005)(64756008)(6436002)(3846002)(256004)(316002)(8936002)(14444005)(99286004)(66946007)(76116006)(66066001)(66556008)(66476007)(186003)(66446008)(14454004)(107886003)(71200400001)(54906003)(478600001)(6246003)(71190400001)(110136005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR05MB6259;H:AM0PR05MB4755.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GA2K6XKi8PY3CVtb6WS2S9UGG7mrn7MMJMMd86kMtUrc8GuUhYYLT/I6KvWRNpoEudqEItlZw/uGt+Hbewaeg3xYSABNKSmyPsO6CVriAdJTS8yqK7drvBZ1XDqd8O7ynQnRbbjMhbAkW3gKLvqIDaGHWj/KCxnS95VlzCuxHS1mRTdvWek8Lz7XojV32LQf2Avct6uh+XFqgdjKvvY9NEfzOI7l87D1YNieS1aHEf6I878enKbVRp2DxefWmi7ljzzPR5UFabxQLo1j06xHpdk1aiSwC9Wgwi5SkFX8ldVeBYRI/OhgjLB1Ph41EgytWIMTKPtYl4kbExyWFcqiTfCp/8NOspux/aJnn7EfLlP/ubVi+gf5AhMSNcvEEkafkwfYjRLcJI6DaZnPooYi0paKn3DaDtyLMAfogmFJ2L3caDSkn1EotDSY2u8bswZUZDS6UZuodyCUcNjfuI8FncSse3n1zk33Tg/HRKesr1g=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aeaeb5dd-a25c-425b-b4cc-08d75df83889
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2019 11:48:17.7046
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dv2TjuW6+89LBKpPgUPWs77IS5lji1xlSXe7tzFrcUkoZc14/0yKxQzycpjCzUodDwOeXdDqLowcvgtHjtajfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB6259
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

SGkgTWFyaywNCg0KPiBGcm9tOiBNYXJrIEJsb2NoIDxtYXJrYkBtZWxsYW5veC5jb20+DQo+IFNl
bnQ6IFR1ZXNkYXksIE9jdG9iZXIgMjksIDIwMTkgMTk6MDENCj4gDQo+IE9uIDEwLzI5LzE5IDg6
NTAgQU0sIExlb24gUm9tYW5vdnNreSB3cm90ZToNCj4gPiBGcm9tOiBZZXZnZW55IEtsaXRleW5p
ayA8a2xpdGV5bkBtZWxsYW5veC5jb20+DQo+ID4NCj4gPiBBZGQgc3VwcG9ydCBmb3IgZmxvdyBz
dGVlcmluZyBjb3VudGVycyBhY3Rpb24gd2l0aCBhIG5vbi1iYXNlIGNvdW50ZXINCj4gPiBJRCAo
b2Zmc2V0KSBmb3IgYnVsayBjb3VudGVycy4NCj4gPg0KPiA+IFdoZW4gY3JlYXRpbmcgYSBmbG93
IGNvdW50ZXIgb2JqZWN0LCBzYXZlIHRoZSBidWxrIHZhbHVlLg0KPiA+IFRoaXMgdmFsdWUgaXMg
dXNlZCB3aGVuIGEgZmxvdyBhY3Rpb24gd2l0aCBhIG5vbi1iYXNlIGNvdW50ZXIgSUQgaXMNCj4g
PiByZXF1ZXN0ZWQgLSB0byB2YWxpZGF0ZSB0aGF0IHRoZSByZXF1aXJlZCBvZmZzZXQgaXMgaW4g
dGhlIHJhbmdlIG9mDQo+ID4gdGhlIGFsbG9jYXRlZCBidWxrLg0KPiA+DQo+ID4gU2lnbmVkLW9m
Zi1ieTogWWV2Z2VueSBLbGl0ZXluaWsgPGtsaXRleW5AbWVsbGFub3guY29tPg0KPiA+IFNpZ25l
ZC1vZmYtYnk6IExlb24gUm9tYW5vdnNreSA8bGVvbnJvQG1lbGxhbm94LmNvbT4NCj4gPiAtLS0N
Cj4gPiBDaGFuZ2Vsb2c6DQo+ID4gIHYwIC0+IHYxOg0KPiA+IGh0dHBzOi8vbG9yZS5rZXJuZWwu
b3JnL2xpbnV4LXJkbWEvMjAxOTEwMjkwNTU5MTYuNzMyMi0xLWxlb25Aa2VybmVsLm8NCj4gPiBy
Zw0KPiA+ICAqIENoYW5nZSBmZnMgdG8gbXVsdGlwbHkgYml0Zm1hcA0KPiA+ICAqIENoYW5nZWQg
dWludDMyX3QgdG8gYmUgdTMyDQo+ID4gICogQWRkZWQgb2Zmc2V0IHRvIG1seDVfaWJfZGV2eF9p
c19mbG93X2NvdW50ZXIoKQ0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL2luZmluaWJhbmQvaHcvbWx4
NS9kZXZ4LmMgICAgICAgIHwgMTUgKysrKysrKysrKystDQo+ID4gIGRyaXZlcnMvaW5maW5pYmFu
ZC9ody9tbHg1L2Zsb3cuYyAgICAgICAgfCAzMCArKysrKysrKysrKysrKysrKysrKystLS0NCj4g
PiAgZHJpdmVycy9pbmZpbmliYW5kL2h3L21seDUvbWx4NV9pYi5oICAgICB8ICAyICstDQo+ID4g
IGluY2x1ZGUvdWFwaS9yZG1hL21seDVfdXNlcl9pb2N0bF9jbWRzLmggfCAgMSArDQo+ID4gIDQg
ZmlsZXMgY2hhbmdlZCwgNDMgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkNCj4gPg0KPiA+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL2luZmluaWJhbmQvaHcvbWx4NS9kZXZ4LmMNCj4gPiBiL2Ry
aXZlcnMvaW5maW5pYmFuZC9ody9tbHg1L2RldnguYw0KPiA+IGluZGV4IDZiMWZjYTkxZDdkMy4u
YWI3ZDIwMWM5MWM5IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvaW5maW5pYmFuZC9ody9tbHg1
L2RldnguYw0KPiA+ICsrKyBiL2RyaXZlcnMvaW5maW5pYmFuZC9ody9tbHg1L2RldnguYw0KPiA+
IEBAIC0xMDAsNiArMTAwLDcgQEAgc3RydWN0IGRldnhfb2JqIHsNCj4gPiAgCQlzdHJ1Y3QgbWx4
NV9pYl9kZXZ4X21yCWRldnhfbXI7DQo+ID4gIAkJc3RydWN0IG1seDVfY29yZV9kY3QJY29yZV9k
Y3Q7DQo+ID4gIAkJc3RydWN0IG1seDVfY29yZV9jcQljb3JlX2NxOw0KPiA+ICsJCXUzMgkJCWZs
b3dfY291bnRlcl9idWxrX3NpemU7DQo+ID4gIAl9Ow0KPiA+ICAJc3RydWN0IGxpc3RfaGVhZCBl
dmVudF9zdWI7IC8qIGhvbGRzIGRldnhfZXZlbnRfc3Vic2NyaXB0aW9uIGVudHJpZXMNCj4gPiAq
LyAgfTsgQEAgLTE5MiwxNSArMTkzLDIwIEBAIGJvb2wgbWx4NV9pYl9kZXZ4X2lzX2Zsb3dfZGVz
dCh2b2lkICpvYmosDQo+ID4gaW50ICpkZXN0X2lkLCBpbnQgKmRlc3RfdHlwZSkNCj4gPiAgCX0N
Cj4gPiAgfQ0KPiA+DQo+ID4gLWJvb2wgbWx4NV9pYl9kZXZ4X2lzX2Zsb3dfY291bnRlcih2b2lk
ICpvYmosIHUzMiAqY291bnRlcl9pZCkNCj4gPiArYm9vbCBtbHg1X2liX2RldnhfaXNfZmxvd19j
b3VudGVyKHZvaWQgKm9iaiwgdTMyIG9mZnNldCwgdTMyDQo+ID4gKypjb3VudGVyX2lkKQ0KPiA+
ICB7DQo+ID4gIAlzdHJ1Y3QgZGV2eF9vYmogKmRldnhfb2JqID0gb2JqOw0KPiA+ICAJdTE2IG9w
Y29kZSA9IE1MWDVfR0VUKGdlbmVyYWxfb2JqX2luX2NtZF9oZHIsIGRldnhfb2JqLT5kaW5ib3gs
DQo+ID4gb3Bjb2RlKTsNCj4gPg0KPiA+ICAJaWYgKG9wY29kZSA9PSBNTFg1X0NNRF9PUF9ERUFM
TE9DX0ZMT1dfQ09VTlRFUikgew0KPiA+ICsNCj4gPiArCQlpZiAob2Zmc2V0ICYmIG9mZnNldCA+
PSBkZXZ4X29iai0+Zmxvd19jb3VudGVyX2J1bGtfc2l6ZSkNCj4gPiArCQkJcmV0dXJuIGZhbHNl
Ow0KPiA+ICsNCj4gPiAgCQkqY291bnRlcl9pZCA9IE1MWDVfR0VUKGRlYWxsb2NfZmxvd19jb3Vu
dGVyX2luLA0KPiA+ICAJCQkJICAgICAgIGRldnhfb2JqLT5kaW5ib3gsDQo+ID4gIAkJCQkgICAg
ICAgZmxvd19jb3VudGVyX2lkKTsNCj4gPiArCQkqY291bnRlcl9pZCArPSBvZmZzZXQ7DQo+ID4g
IAkJcmV0dXJuIHRydWU7DQo+ID4gIAl9DQo+ID4NCj4gPiBAQCAtMTQ2Myw2ICsxNDY5LDEzIEBA
IHN0YXRpYyBpbnQNCj4gVVZFUkJTX0hBTkRMRVIoTUxYNV9JQl9NRVRIT0RfREVWWF9PQkpfQ1JF
QVRFKSgNCj4gPiAgCWlmIChlcnIpDQo+ID4gIAkJZ290byBvYmpfZnJlZTsNCj4gPg0KPiA+ICsJ
aWYgKG9wY29kZSA9PSBNTFg1X0NNRF9PUF9BTExPQ19GTE9XX0NPVU5URVIpIHsNCj4gPiArCQl1
OCBidWxrID0gTUxYNV9HRVQoYWxsb2NfZmxvd19jb3VudGVyX2luLA0KPiA+ICsJCQkJICAgY21k
X2luLA0KPiA+ICsJCQkJICAgZmxvd19jb3VudGVyX2J1bGspOw0KPiA+ICsJCW9iai0+Zmxvd19j
b3VudGVyX2J1bGtfc2l6ZSA9IDEyOCAqIGJ1bGs7DQo+ID4gKwl9DQo+ID4gKw0KPiA+ICAJdW9i
ai0+b2JqZWN0ID0gb2JqOw0KPiA+ICAJSU5JVF9MSVNUX0hFQUQoJm9iai0+ZXZlbnRfc3ViKTsN
Cj4gPiAgCW9iai0+aWJfZGV2ID0gZGV2Ow0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2luZmlu
aWJhbmQvaHcvbWx4NS9mbG93LmMNCj4gPiBiL2RyaXZlcnMvaW5maW5pYmFuZC9ody9tbHg1L2Zs
b3cuYw0KPiA+IGluZGV4IGIxOThmZjEwY2RlOS4uOTg1YmUwOTI3OTE4IDEwMDY0NA0KPiA+IC0t
LSBhL2RyaXZlcnMvaW5maW5pYmFuZC9ody9tbHg1L2Zsb3cuYw0KPiA+ICsrKyBiL2RyaXZlcnMv
aW5maW5pYmFuZC9ody9tbHg1L2Zsb3cuYw0KPiA+IEBAIC04NSw2ICs4NSw3IEBAIHN0YXRpYyBp
bnQNCj4gVVZFUkJTX0hBTkRMRVIoTUxYNV9JQl9NRVRIT0RfQ1JFQVRFX0ZMT1cpKA0KPiA+ICAJ
c3RydWN0IG1seDVfaWJfZGV2ICpkZXYgPSBtbHg1X3VkYXRhX3RvX21kZXYoJmF0dHJzLT5kcml2
ZXJfdWRhdGEpOw0KPiA+ICAJaW50IGxlbiwgcmV0LCBpOw0KPiA+ICAJdTMyIGNvdW50ZXJfaWQg
PSAwOw0KPiA+ICsJdTMyICpvZmZzZXQ7DQo+ID4NCj4gPiAgCWlmICghY2FwYWJsZShDQVBfTkVU
X1JBVykpDQo+ID4gIAkJcmV0dXJuIC1FUEVSTTsNCj4gPiBAQCAtMTUxLDggKzE1MiwyNyBAQCBz
dGF0aWMgaW50DQo+IFVWRVJCU19IQU5ETEVSKE1MWDVfSUJfTUVUSE9EX0NSRUFURV9GTE9XKSgN
Cj4gPiAgCWlmIChsZW4pIHsNCj4gPiAgCQlkZXZ4X29iaiA9IGFycl9mbG93X2FjdGlvbnNbMF0t
Pm9iamVjdDsNCj4gPg0KPiA+IC0JCWlmICghbWx4NV9pYl9kZXZ4X2lzX2Zsb3dfY291bnRlcihk
ZXZ4X29iaiwgJmNvdW50ZXJfaWQpKQ0KPiA+IC0JCQlyZXR1cm4gLUVJTlZBTDsNCj4gPiArCQlp
ZiAodXZlcmJzX2F0dHJfaXNfdmFsaWQoDQo+ID4gKwkJCSAgICBhdHRycywNCj4gPiArDQo+IE1M
WDVfSUJfQVRUUl9DUkVBVEVfRkxPV19BUlJfQ09VTlRFUlNfREVWWF9PRkZTRVQpKSB7DQo+ID4g
KwkJCWludCBudW1fb2Zmc2V0cyA9IHV2ZXJic19hdHRyX3B0cl9nZXRfYXJyYXlfc2l6ZSgNCj4g
PiArCQkJCWF0dHJzLA0KPiA+ICsNCj4gCU1MWDVfSUJfQVRUUl9DUkVBVEVfRkxPV19BUlJfQ09V
TlRFUlNfREVWWF9PRkZTRVQsDQo+ID4gKwkJCQlzaXplb2YodTMyKSk7DQo+ID4gKw0KPiA+ICsJ
CQlpZiAobnVtX29mZnNldHMgIT0gMSkNCj4gPiArCQkJCXJldHVybiAtRUlOVkFMOw0KPiA+ICsN
Cj4gPiArCQkJb2Zmc2V0ID0gdXZlcmJzX2F0dHJfZ2V0X2FsbG9jZWRfcHRyKA0KPiA+ICsJCQkJ
YXR0cnMsDQo+ID4gKw0KPiAJTUxYNV9JQl9BVFRSX0NSRUFURV9GTE9XX0FSUl9DT1VOVEVSU19E
RVZYX09GRlNFVCk7DQo+ID4gKw0KPiA+ICsJCQlpZiAoIW1seDVfaWJfZGV2eF9pc19mbG93X2Nv
dW50ZXIoZGV2eF9vYmosDQo+ID4gKwkJCQkJCQkgICpvZmZzZXQsDQo+ID4gKwkJCQkJCQkgICZj
b3VudGVyX2lkKSkNCj4gPiArCQkJCXJldHVybiAtRUlOVkFMOw0KPiA+ICsJCX0NCj4gDQo+IEhh
dmUgeW91IHRlc3RlZCB0aGlzIHBhdGNoIHdpdGhvdXQgcGFzc2luZyBvZmZzZXQ/IGJlY2F1c2Ug
bm93IHRoZQ0KPiBtbHg1X2liX2RldnhfaXNfZmxvd19jb3VudGVyKCkgaXMgZG9uZSBvbmx5IGlm
DQo+IE1MWDVfSUJfQVRUUl9DUkVBVEVfRkxPV19BUlJfQ09VTlRFUlNfREVWWF9PRkZTRVQNCj4g
aXMgcGFzc2VkLg0KDQpJbmRlZWQuIFRoYW5rcywgdjIgaXMgb24gaXRzIHdheS4uLg0KDQotLSBZ
Sw0KDQogDQo+IE1hcmsNCj4gDQo=
