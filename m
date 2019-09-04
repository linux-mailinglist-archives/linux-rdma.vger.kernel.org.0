Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 658CAA7819
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Sep 2019 03:39:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727374AbfIDBjZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 3 Sep 2019 21:39:25 -0400
Received: from mail-eopbgr00057.outbound.protection.outlook.com ([40.107.0.57]:29694
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726589AbfIDBjZ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 3 Sep 2019 21:39:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hgOpjNp15TLxaGp0IqwHSaJYZBJKDN72fAUmpamCit6SqGQw0H7n2WhsX3DKDhONrboW0b5yIza2QML4qHg8pUUk8uwLEIy7z9DyPrITYlFqCeQV9W7bhhjut3C7LD8RtSxlikVXayQTOsSZoYDBJm8DaPZ3cI3HwC5FIZRaYg8c7EzbNMcBnCBJDjTTvmlQKSpIMXlbuKrwFr3z1VI7uQmGfvW99cplUwN8DEIUUARMWvaHDi5wuxJ3BVquMzEljWVo0dlLcaO9M/sxdghTZ61/9OhxeEPWo8Z+bXDtnn9FguLj+95VHVHmR6eQImb5BAk/GG8OHdDolVc52ogSXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9RUXg6vWeprJCCQK1Aqd/hM/LeSg92l65X1HCpx8fy8=;
 b=emvg3+hyEVNQvd3YxZo84t8Sp7g/pZvVqysUXx5N4S64Eyh4dU61lcyYr8aF4oOHRNI7YJ1w5vbiG+o9eZSHg9ObwxiHW5b8zdsnnQkdVCLs78p6dlkFOSFtYtNCjQPWf4/8osSxrGpT/rnsevL/g1pC6R/Y1S3uzMTU7QGvXjcaCgI0NoFMFNLVxi7REQ0QCF9JgTKyOoOsax6Q6n79Cd04Gxzpf6vzYD4G8rxGO9JnMaM3kbPdfHQcSTblgmAazkzb63zzslIyBZnFus5O9xp95XgT8rgM19iZxoHP8atlcxT+PgAVyblVWGQQ1I9otgn3s8R4hsIZ+7tq1FmuwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9RUXg6vWeprJCCQK1Aqd/hM/LeSg92l65X1HCpx8fy8=;
 b=aqwcYUZAU5oGrPsZ2y+JVi93Y0+xpsQO9dAZ6Rg85yqntIDkUpNh982l/Oqdp/P0pA/Ro24MbRKISuwEwMirVg51g0b8PplHsZ65Tj+48Gu9pqMI6ZAS+0KvigP5tnouPPdRzRxUcY2tGqHQVCu30HWIflUHkyuGrRN0g/2w1j8=
Received: from VI1PR05MB3342.eurprd05.prod.outlook.com (10.170.238.143) by
 VI1PR05MB5887.eurprd05.prod.outlook.com (20.178.125.204) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.20; Wed, 4 Sep 2019 01:39:20 +0000
Received: from VI1PR05MB3342.eurprd05.prod.outlook.com
 ([fe80::4499:7719:a52f:a63a]) by VI1PR05MB3342.eurprd05.prod.outlook.com
 ([fe80::4499:7719:a52f:a63a%5]) with mapi id 15.20.2220.021; Wed, 4 Sep 2019
 01:39:20 +0000
From:   Mark Bloch <markb@mellanox.com>
To:     Sagi Grimberg <sagi@grimberg.me>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
CC:     Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH v2] iwcm: don't hold the irq disabled lock on iw_rem_ref
Thread-Topic: [PATCH v2] iwcm: don't hold the irq disabled lock on iw_rem_ref
Thread-Index: AQHVYr2L4wQYsofRBEyhwhmlspF2dqcavZKA
Date:   Wed, 4 Sep 2019 01:39:19 +0000
Message-ID: <43be4b64-94f1-9ee7-93f9-4e683bdfe89a@mellanox.com>
References: <20190904011020.12845-1-sagi@grimberg.me>
In-Reply-To: <20190904011020.12845-1-sagi@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR06CA0003.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::16) To VI1PR05MB3342.eurprd05.prod.outlook.com
 (2603:10a6:802:1d::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=markb@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [104.156.100.52]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7a7fbe63-7ed6-4c56-0b8a-08d730d8b48f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR05MB5887;
x-ms-traffictypediagnostic: VI1PR05MB5887:
x-microsoft-antispam-prvs: <VI1PR05MB58877E06E80D439A135FDB95D2B80@VI1PR05MB5887.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:188;
x-forefront-prvs: 0150F3F97D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(39860400002)(396003)(136003)(366004)(189003)(199004)(478600001)(6116002)(86362001)(14454004)(486006)(446003)(2501003)(31696002)(71190400001)(2616005)(11346002)(305945005)(256004)(71200400001)(476003)(14444005)(386003)(6506007)(53546011)(66066001)(6512007)(7736002)(2906002)(6436002)(31686004)(316002)(81166006)(66446008)(81156014)(66476007)(53936002)(66556008)(64756008)(6246003)(66946007)(4326008)(26005)(8936002)(102836004)(8676002)(110136005)(99286004)(52116002)(36756003)(229853002)(186003)(5660300002)(25786009)(6486002)(3846002)(76176011);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB5887;H:VI1PR05MB3342.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: VTcXErQk7HIhxy+Mk2bVdAxEIbH7vJlQp7Gd6uqB5Cq5uNDpyg9IJ2RpXIYhh1wtQqV2Ndxq7zBtMpe2fjer3grAQc3JG2ZqW47LP/4Xm8GdgEvwAAIT6+EGO4hOSnaKsUO7kYNFJh+VgmwkXtGWMsDYkzxcNqJvTp2P+n/QCBoVq/9WeA28LmTcZSSMriUCWVBnYGRHZjV4SyoUc2BbcBx1tyKhtNC5fc37vGRP0qzHt1KRCRNNlBDfQolj/VWBcJgjxpzDLV6PeV7lNby+Zkz2SQEMLXTAJ/RA3at60qZKVtWtsWMGkZF9K1MnrRJ5StfRtCndei8ic+jevyNYWbyFA1x26FMech6EW9AMtjA6r54Ml0Dxurc0VfcAddTI5V2ba88EXt3xF1cII3+RzKbnWHWcJJVszbR/PH1gKwg=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <5218145AD5B7F14781D70194EE30E56E@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a7fbe63-7ed6-4c56-0b8a-08d730d8b48f
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2019 01:39:19.9636
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6Pxv7b2tcNff1xe+Bna4Qqg/aKJ7d5nx7wyBVCQUqtkvA10odRjoJWnOQ2jj4d3ZWMeOY3J5XM8sCVxqg7zp5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB5887
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCk9uIDkvMy8yMDE5IDE4OjEwLCBTYWdpIEdyaW1iZXJnIHdyb3RlOg0KPiBUaGlzIG1heSBi
ZSB0aGUgZmluYWwgcHV0IG9uIGEgcXAgYW5kIHJlc3VsdCBpbiBmcmVlaW5nDQo+IHJlc291cmNl
c2FuZCBzaG91bGQgbm90IGJlIGRvbmUgd2l0aCBpbnRlcnJ1cHRzIGRpc2FibGVkLg0KPiANCj4g
UHJvZHVjZSB0aGUgZm9sbG93aW5nIHdhcm5pbmc6DQo+IC0tDQo+IFsgIDMxNy4wMjYwNDhdIFdB
Uk5JTkc6IENQVTogMSBQSUQ6IDQ0MyBhdCBrZXJuZWwvc21wLmM6NDI1IHNtcF9jYWxsX2Z1bmN0
aW9uX21hbnkrMHhhMC8weDI2MA0KPiBbICAzMTcuMDI2MTMxXSBDYWxsIFRyYWNlOg0KPiBbICAz
MTcuMDI2MTU5XSAgPyBsb2FkX25ld19tbV9jcjMrMHhlMC8weGUwDQo+IFsgIDMxNy4wMjYxNjFd
ICBvbl9lYWNoX2NwdSsweDI4LzB4NTANCj4gWyAgMzE3LjAyNjE4M10gIF9fcHVyZ2Vfdm1hcF9h
cmVhX2xhenkrMHg3Mi8weDE1MA0KPiBbICAzMTcuMDI2MjAwXSAgZnJlZV92bWFwX2FyZWFfbm9m
bHVzaCsweDdhLzB4OTANCj4gWyAgMzE3LjAyNjIwMl0gIHJlbW92ZV92bV9hcmVhKzB4NmYvMHg4
MA0KPiBbICAzMTcuMDI2MjAzXSAgX192dW5tYXArMHg3MS8weDIxMA0KPiBbICAzMTcuMDI2MjEx
XSAgc2l3X2ZyZWVfcXArMHg4ZC8weDEzMCBbc2l3XQ0KPiBbICAzMTcuMDI2MjE3XSAgZGVzdHJv
eV9jbV9pZCsweGMzLzB4MjAwIFtpd19jbV0NCj4gWyAgMzE3LjAyNjIyMl0gIHJkbWFfZGVzdHJv
eV9pZCsweDIyNC8weDJiMCBbcmRtYV9jbV0NCj4gWyAgMzE3LjAyNjIyNl0gIG52bWVfcmRtYV9y
ZXNldF9jdHJsX3dvcmsrMHgyYy8weDcwIFtudm1lX3JkbWFdDQo+IFsgIDMxNy4wMjYyMzVdICBw
cm9jZXNzX29uZV93b3JrKzB4MWY0LzB4M2UwDQo+IFsgIDMxNy4wMjYyNDldICB3b3JrZXJfdGhy
ZWFkKzB4MjIxLzB4M2UwDQo+IFsgIDMxNy4wMjYyNTJdICA/IHByb2Nlc3Nfb25lX3dvcmsrMHgz
ZTAvMHgzZTANCj4gWyAgMzE3LjAyNjI1Nl0gIGt0aHJlYWQrMHgxMTcvMHgxMzANCj4gWyAgMzE3
LjAyNjI2NF0gID8ga3RocmVhZF9jcmVhdGVfd29ya2VyX29uX2NwdSsweDcwLzB4NzANCj4gWyAg
MzE3LjAyNjI3NV0gIHJldF9mcm9tX2ZvcmsrMHgzNS8weDQwDQo+IC0tDQo+IA0KPiBTaWduZWQt
b2ZmLWJ5OiBTYWdpIEdyaW1iZXJnIDxzYWdpQGdyaW1iZXJnLm1lPg0KPiAtLS0NCj4gY2hhbmdl
cyBmcm9tIHYxOg0KPiAtIGRvbid0IHJlbGVhc2UgdGhlIGxvY2sgYmVmb3JlIHFwIHBvaW50ZXIg
aXMgY2xlYXJlZC4NCj4gDQo+ICBkcml2ZXJzL2luZmluaWJhbmQvY29yZS9pd2NtLmMgfCA0ICsr
Ky0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4g
DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2luZmluaWJhbmQvY29yZS9pd2NtLmMgYi9kcml2ZXJz
L2luZmluaWJhbmQvY29yZS9pd2NtLmMNCj4gaW5kZXggNzIxNDFjNWI3Yzk1Li5hZDZmZDUwMTky
ODUgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvaW5maW5pYmFuZC9jb3JlL2l3Y20uYw0KPiArKysg
Yi9kcml2ZXJzL2luZmluaWJhbmQvY29yZS9pd2NtLmMNCj4gQEAgLTQyNyw4ICs0MjcsMTAgQEAg
c3RhdGljIHZvaWQgZGVzdHJveV9jbV9pZChzdHJ1Y3QgaXdfY21faWQgKmNtX2lkKQ0KPiAgCQli
cmVhazsNCj4gIAl9DQo+ICAJaWYgKGNtX2lkX3ByaXYtPnFwKSB7DQo+IC0JCWNtX2lkX3ByaXYt
PmlkLmRldmljZS0+b3BzLml3X3JlbV9yZWYoY21faWRfcHJpdi0+cXApOw0KPiAgCQljbV9pZF9w
cml2LT5xcCA9IE5VTEw7DQo+ICsJCXNwaW5fdW5sb2NrX2lycXJlc3RvcmUoJmNtX2lkX3ByaXYt
PmxvY2ssIGZsYWdzKTsNCj4gKwkJY21faWRfcHJpdi0+aWQuZGV2aWNlLT5vcHMuaXdfcmVtX3Jl
ZihjbV9pZF9wcml2LT5xcCk7DQoNCllvdSBhcmUgY2FsbGluZyBpdCB3aXRoIE5VTEwgbm93IDop
DQoNCkkgd2FzIHRoaW5raW5nIG1vcmUgYWJvdXQgc29tZXRoaW5nIGxpa2UgdGhpczoNCg0KZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvaW5maW5pYmFuZC9jb3JlL2l3Y20uYyBiL2RyaXZlcnMvaW5maW5p
YmFuZC9jb3JlL2l3Y20uYw0KaW5kZXggNzIxNDFjNWI3Yzk1Li5jNWQ5YTFlYmFjZTYgMTAwNjQ0
DQotLS0gYS9kcml2ZXJzL2luZmluaWJhbmQvY29yZS9pd2NtLmMNCisrKyBiL2RyaXZlcnMvaW5m
aW5pYmFuZC9jb3JlL2l3Y20uYw0KQEAgLTM3Myw2ICszNzMsNyBAQCBzdGF0aWMgdm9pZCBkZXN0
cm95X2NtX2lkKHN0cnVjdCBpd19jbV9pZCAqY21faWQpDQogew0KICAgICAgICBzdHJ1Y3QgaXdj
bV9pZF9wcml2YXRlICpjbV9pZF9wcml2Ow0KICAgICAgICB1bnNpZ25lZCBsb25nIGZsYWdzOw0K
KyAgICAgICBzdHJ1Y3QgaWJfcXAgKnFwOw0KDQogICAgICAgIGNtX2lkX3ByaXYgPSBjb250YWlu
ZXJfb2YoY21faWQsIHN0cnVjdCBpd2NtX2lkX3ByaXZhdGUsIGlkKTsNCiAgICAgICAgLyoNCkBA
IC00MjYsMTIgKzQyNywxNCBAQCBzdGF0aWMgdm9pZCBkZXN0cm95X2NtX2lkKHN0cnVjdCBpd19j
bV9pZCAqY21faWQpDQogICAgICAgICAgICAgICAgQlVHKCk7DQogICAgICAgICAgICAgICAgYnJl
YWs7DQogICAgICAgIH0NCi0gICAgICAgaWYgKGNtX2lkX3ByaXYtPnFwKSB7DQotICAgICAgICAg
ICAgICAgY21faWRfcHJpdi0+aWQuZGV2aWNlLT5vcHMuaXdfcmVtX3JlZihjbV9pZF9wcml2LT5x
cCk7DQotICAgICAgICAgICAgICAgY21faWRfcHJpdi0+cXAgPSBOVUxMOw0KLSAgICAgICB9DQor
DQorICAgICAgIHFwID0gY21faWRfcHJpdi0+cXA7DQorICAgICAgIGNtX2lkX3ByaXYtPnFwID0g
TlVMTDsNCiAgICAgICAgc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmY21faWRfcHJpdi0+bG9jaywg
ZmxhZ3MpOw0KDQorICAgICAgIGlmIChxcCkNCisgICAgICAgICAgICAgICBjbV9pZF9wcml2LT5p
ZC5kZXZpY2UtPm9wcy5pd19yZW1fcmVmKHFwKTsNCisNCiAgICAgICAgaWYgKGNtX2lkLT5tYXBw
ZWQpIHsNCiAgICAgICAgICAgICAgICBpd3BtX3JlbW92ZV9tYXBpbmZvKCZjbV9pZC0+bG9jYWxf
YWRkciwgJmNtX2lkLT5tX2xvY2FsX2FkZHIpOw0KICAgICAgICAgICAgICAgIGl3cG1fcmVtb3Zl
X21hcHBpbmcoJmNtX2lkLT5sb2NhbF9hZGRyLCBSRE1BX05MX0lXQ00pOw0KDQoNCj4gKwkJc3Bp
bl9sb2NrX2lycXNhdmUoJmNtX2lkX3ByaXYtPmxvY2ssIGZsYWdzKTsNCj4gIAl9DQo+ICAJc3Bp
bl91bmxvY2tfaXJxcmVzdG9yZSgmY21faWRfcHJpdi0+bG9jaywgZmxhZ3MpOw0KPiAgDQo+IA0K
