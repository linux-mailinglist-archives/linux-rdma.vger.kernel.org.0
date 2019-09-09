Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8D84AD6DC
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Sep 2019 12:30:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730536AbfIIKaF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 9 Sep 2019 06:30:05 -0400
Received: from mail-eopbgr140050.outbound.protection.outlook.com ([40.107.14.50]:5186
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730369AbfIIKaF (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 9 Sep 2019 06:30:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UVBMSVuR1DEPFt0nUDPH/8Ff7ibtb8twEeAYaS2OkoSwa2x9EE1sWlwY4Cw2G6qCVIPXCO1nXBqv9sHDYTTZUFap9TYEiTVeStoqUnXNnl1NoqNkXrBOW3AIpZq5dcTVvMAlH/oB31oFCnUFVRBiltLtugEFRa0Zy/jc5oV+ZG3Yr3TfxPv/RJumtmXsu8oZUsWaIF9NmrNlj2Ajz1oZ9r61Lz7dHaA3iuNX7AW0JlmTGYYcWmhq3/MAEtXfBouFFg5JESvU1DF5q3/d3QyeM4vPtU7r8X2ZQBtMfIiUP/0PEK+55QDH1JcNHJkIj//0dZmPFcGlEnOuO+tWZCMdqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ORMNQVr70rmMV4qloGXSOCrLp6wLVQSGSmFc18rN2n8=;
 b=cey4Orw39v+AGijFuwHO4V5AJT0LCJsPw+8NmqOYqB1ZM3q3OTs7U0E99btjS971dD/X48SY76lCNezOUAtjiQyhoPLjZMPM38Fhw0+99YblUPT6Q65+yaUx7uhaE9X7PE2gbuIZLaYA1VST+FTAjrlPotDm2oFP6quNGtD7HsYMGfDp2CxwUQouQbN5K6IFuQdCg7yaqeNp2Hz8fC/Gknqoa9NCmXpV1HI9QP+i0a9G0Pka3kL/XPGQbXenlY3L1EUwju+n8vfEWZZlXNFv/gRsdNS89tLtEbYzcgEdrjQFnEf+OrtLiz9K/jnaSKjNrhHScxK36LV3GKajrj3usw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ORMNQVr70rmMV4qloGXSOCrLp6wLVQSGSmFc18rN2n8=;
 b=mWhQgiXJ3tN6WB+vtOLqTepwpFZjScvag6Y7W5A2bgWi6zA01PojMVHjJ2+RzQd8MMklBdGtXHo+XfHQRq3NuxXkMrXwmKV/mHe0NKdWMvZE8sNtk4apMVUuX9rHddzb/mVKhuykM6RxdkIAwKHTudcjXCctulZ2h9KdCt01yDM=
Received: from AM4PR05MB3137.eurprd05.prod.outlook.com (10.171.188.155) by
 AM4PR05MB3346.eurprd05.prod.outlook.com (10.171.189.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.21; Mon, 9 Sep 2019 10:29:56 +0000
Received: from AM4PR05MB3137.eurprd05.prod.outlook.com
 ([fe80::e826:7a52:5488:2b6f]) by AM4PR05MB3137.eurprd05.prod.outlook.com
 ([fe80::e826:7a52:5488:2b6f%7]) with mapi id 15.20.2199.027; Mon, 9 Sep 2019
 10:29:55 +0000
From:   Leon Romanovsky <leonro@mellanox.com>
To:     Noa Osherovich <noaos@mellanox.com>
CC:     Jason Gunthorpe <jgg@mellanox.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-core 03/14] build: Add pyverbs-based test to the
 build
Thread-Topic: [PATCH rdma-core 03/14] build: Add pyverbs-based test to the
 build
Thread-Index: AQHVVluKJrnh28/IoUO3a7bpLCEySqcCfWOAgAGEcwCAA1vkAIAACaEAgA9+4wCADGAOgA==
Date:   Mon, 9 Sep 2019 10:29:53 +0000
Message-ID: <20190909102949.GF6601@unreal>
References: <20190819065827.26921-1-noaos@mellanox.com>
 <20190819065827.26921-4-noaos@mellanox.com>
 <20190819135019.GF5080@mellanox.com>
 <2ac30209-2c89-15ef-3907-98d3cd552f4d@mellanox.com>
 <20190822161813.GI29433@mtr-leonro.mtl.com>
 <20190822165247.GB8325@mellanox.com>
 <88435e1e-676b-f948-1c34-22cd471af4c9@mellanox.com>
In-Reply-To: <88435e1e-676b-f948-1c34-22cd471af4c9@mellanox.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: PR0P264CA0074.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:18::14) To AM4PR05MB3137.eurprd05.prod.outlook.com
 (2603:10a6:205:8::27)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonro@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [148.69.85.38]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 80c21d34-d206-407e-add5-08d73510a6da
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM4PR05MB3346;
x-ms-traffictypediagnostic: AM4PR05MB3346:|AM4PR05MB3346:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM4PR05MB3346841F5EC1CE85F0D799F9B0B70@AM4PR05MB3346.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 01559F388D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(4636009)(136003)(366004)(376002)(39860400002)(346002)(396003)(189003)(199004)(81166006)(66446008)(71200400001)(66556008)(81156014)(5660300002)(4326008)(8936002)(7736002)(66066001)(1076003)(6436002)(86362001)(33656002)(229853002)(6636002)(3846002)(6116002)(6862004)(53936002)(66476007)(186003)(76176011)(6486002)(6246003)(256004)(54906003)(8676002)(66946007)(26005)(33716001)(102836004)(99286004)(9686003)(14454004)(6512007)(478600001)(486006)(71190400001)(386003)(53546011)(446003)(316002)(476003)(25786009)(64756008)(11346002)(6506007)(305945005)(2906002)(52116002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM4PR05MB3346;H:AM4PR05MB3137.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Jron1hy1hLOPEKJgWUUTc7qPdJ5e0RXLNrwiFt4ZrOXG+kW+rAfPUu5C6+zLaRyHx4LuCVRCW1zvrGo8t7uANIz98uvylbooKuNpKHPWu6bU31PunPwEksluuNRO9mndUreXPzViQWQQrmX0Gcf0tLJm1e42g2gjmT2nBDmkVw+zSmM6lhGq/83CkOAryqvpRpxhxdw6KwegWWgynpkAK0SDbk4YGFT9uyNnNIQpKD/5boOhr2EXtXMFDHiywGXzrAFvin6KIMP5xJVpG59+X+yVHgo+Tut5ILajU8wVZj6JICbTY6uwl2XKg5nTNjn5mFj6Uta7GwglcBPTRNqD3sZs8SO/OKps1bbc/X9jTTf1pmgRwYxoSf2Uqg8E9st7IkqufS2uemXKiVebvuimRllyqpHQ8UNOxsbRBmgPS4Y=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DF6044C3B2C8AD47814012E2C4194FF5@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80c21d34-d206-407e-add5-08d73510a6da
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2019 10:29:54.9312
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fpZIqs1+F0tvoSIQ8MqCuKj8vqRRmzoogCi/k1LuJn2K//MnCwrKGiKuvNZbARdnEzMw8x7r+JUZnJ7zCJIcwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR05MB3346
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

T24gU3VuLCBTZXAgMDEsIDIwMTkgYXQgMDE6MzA6NTZQTSArMDAwMCwgTm9hIE9zaGVyb3ZpY2gg
d3JvdGU6DQo+IE9uIDgvMjIvMjAxOSA3OjUyIFBNLCBKYXNvbiBHdW50aG9ycGUgd3JvdGU6DQo+
DQo+ID4gT24gVGh1LCBBdWcgMjIsIDIwMTkgYXQgMDE6MTg6MjRQTSAtMDMwMCwgTGVvbiBSb21h
bm92c2t5IHdyb3RlOg0KPiA+PiBPbiBUdWUsIEF1ZyAyMCwgMjAxOSBhdCAwMTowMDo0N1BNICsw
MDAwLCBOb2EgT3NoZXJvdmljaCB3cm90ZToNCj4gPj4+IE9uIDgvMTkvMjAxOSA0OjUwIFBNLCBK
YXNvbiBHdW50aG9ycGUgd3JvdGU6DQo+ID4+Pg0KPiA+Pj4+IEknZCBwcmVmZXIgcnVuX3Rlc3Rz
IHRvIGJlIGluIHRoZSB0ZXN0cyBkaXJlY3RvcnkuLg0KPiA+Pj4+DQo+ID4+Pj4gSmFzb24NCj4g
Pj4+IFBSIHdhcyB1cGRhdGVkDQo+ID4+IDEuDQo+ID4+IElNSE8sIHJ1bl90ZXN0cy5weSBzaG91
bGQgYmUgcGxhY2VkIGluc2lkZSB0ZXN0cyBkaXJlY3RvcnkgdG9vIGFuZCBub3QNCj4gPj4gb25s
eSBpbnN0YWxsZWQgaW50byB0ZXN0cy8uDQo+ID4gWWVzLCB0aGlzIGlzIHdoYXQgSSBtZW50LiBU
aGUgZmlsZSBzaG91bGQgYmUgaW4gdGVzdHMvIGFuZCBpdCBzaG91bGQNCj4gPiBiZSBidWlsdCBp
bnRvIGJ1aWxkL2JpbiwgYW5kIGluc3RhbGxlZCBpbnRvIHRoZSBleGFtcGxlcw0KPiA+PiAyLg0K
PiA+PiBFeGVjdXRpb24gb2YgcnVuX3Rlc3RzLnB5IHByb2R1Y2VzIGEgbG90IG9mIHVudHJhY2tl
ZCBmaWxlZA0KPiA+PiDinpwgIHJkbWEtY29yZSBnaXQ6KG5vYW9zLXByLXRlc3RzKSDinJcgZ2l0
IHN0DQo+ID4+IE9uIGJyYW5jaCBub2Fvcy1wci10ZXN0cw0KPiA+PiBVbnRyYWNrZWQgZmlsZXM6
DQo+ID4+ICAgKHVzZSAiZ2l0IGFkZCA8ZmlsZT4uLi4iIHRvIGluY2x1ZGUgaW4gd2hhdCB3aWxs
IGJlIGNvbW1pdHRlZCkNCj4gPj4NCj4gPj4gCXB5dmVyYnMvX19pbml0X18ucHljDQo+ID4+IAlw
eXZlcmJzL3B5dmVyYnNfZXJyb3IucHljDQo+ID4+IAl0ZXN0cy9fX2luaXRfXy5weWMNCj4gPj4g
CXRlc3RzL2Jhc2UucHljDQo+ID4+IAl0ZXN0cy90ZXN0X2FkZHIucHljDQo+ID4+IAl0ZXN0cy90
ZXN0X2NxLnB5Yw0KPiA+PiAJdGVzdHMvdGVzdF9kZXZpY2UucHljDQo+ID4+IAl0ZXN0cy90ZXN0
X21yLnB5Yw0KPiA+PiAJdGVzdHMvdGVzdF9vZHAucHljDQo+ID4+IAl0ZXN0cy90ZXN0X3BkLnB5
Yw0KPiA+PiAJdGVzdHMvdGVzdF9xcC5weWMNCj4gPiAqLnB5YyB3aWxsIGhhdmUgdG8gYmUgYWRk
ZWQgdG8gdGhlIC5naXRpZ25vcmUNCj4gPj4gMy4gcnVuX3Rlc3RzLnB5IGxhY2tzIG9mIHB5dGhv
bjMgc2hlYmFuZw0KPiA+IE9yaWdpbmFsbHkgaXQgd2FzIG5vdCBpbnN0YWxsZWQsIHNvIHRoaXMg
d2FzIGZpbmUsIGFzIHRoZSBidWlsZC9iaW4NCj4gPiBzY3JpcHQgZG9lcyBhbGwgdGhlIHJlcXVp
cmVkIHNldHVwLCBob3dldmVyIG5vdyB0aGF0IGl0IGlzIHRvIGJlDQo+ID4gaW5zdGFsbGVkIGl0
IHNob3VsZCBoYXZlIHRoZSAjISAtIGFuZCBpdCBzaG91bGQgYWxzbyB3b3JrIHdpdGhvdXQgYW55
DQo+ID4gdHJvdWJsZSBmcm9tIGl0J3MgZXhhbXBsZSBsb2NhdGlvbi4NCj4gPg0KPiA+IEphc29u
DQo+DQo+IFBSIHdhcyB1cGRhdGVkLg0KDQpJIHRyaWVkIGl0IG5vdyBhbmQgZ290IHZlcnkgY29u
ZnVzaW5nIHJlc3VsdHMuDQoNCk9uIG15IG1hY2hpbmUgdGhlcmUgYXJlIG5vIGliX2RldmljZXMs
IGFuZCBJIGV4cGVjdGVkIHRvIHNlZSBBTEwgdGVzdHMNCm1hcmtlZCBhcyBza2lwcGVkLCBidXQg
Z290IHR3byBza2lwcGVkIG9ubHksIGlzIGl0IGV4cGVjdGVkIGJlaGF2aW91cj8NCg0KXyAgcmRt
YS1jb3JlIGdpdDoobm9hb3MtcHItdGVzdHMpIC4vYnVpbGQvYmluL3J1bl90ZXN0cy5weQ0KLi4u
Li4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uc3MuLi4uLi4uLi4uLi4uLi4N
Ci0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0NClJhbiA1OSB0ZXN0cyBpbiAwLjAwNHMNCg0KT0sgKHNraXBwZWQ9MikN
Cg0KVGhhbmtzDQoNCj4NCj4gVGhhbmtzLA0KPg0KPiBOb2ENCj4NCg==
