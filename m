Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3CEADAD7EC
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Sep 2019 13:30:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730405AbfIILaL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 9 Sep 2019 07:30:11 -0400
Received: from mail-eopbgr00061.outbound.protection.outlook.com ([40.107.0.61]:7470
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730180AbfIILaL (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 9 Sep 2019 07:30:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J+Xw8LTO1bJQLjyYo7mBPcRQhoRT34QJa7BgAKjuETkuKeLbf0LZBYZ1owjRkU+Y8zo1HvLQGHWUBBHmzlyUhro44vJasSw8wHkG9RWa4fBOe9fOBV3cJrPjb3Fw5aCbdPojVYmtvmNoqf2tXq82m0dH7WMYukB5BYEt+ICvgztlbwoX1pLHAZAj/psyH2A4k7Ga1e1rRZAdWkU4YzhSlOLPZWqT8sCiz3qx2kNcEtqfmA6F9te7f7qpNSEStj0QRibPWwd7bmAq6XsTvrwniGbKl1SfAxw0xIwnz63sr+k4uNP/mUQv5ScsdpTgC7Qa9erMChWQ4P6vU0t3sXVPQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gIZ6jPE1WF7opWuO7Tegz7qrRGLx/VZotnzJgxqjGv0=;
 b=BrQ/oVI130R5y5MMS1ugi4UFDDKMDo/76Aqv3PPmV3/T7iTYxi6UF4vBX5bn1HKdcclxblvdY06LXhZQHy35OptDeN9oMB5bW80x4Zx7FDOg8jXpDQHz6tlRQD3ROI4zXf7HG7zXHxSQKsd22llvUO+i3qWyzglrJqs0giihXUHRpfFvko2RGBl4RZN6LX4OeqZh/sJNzK4iV01v8Qdf/Rx3uu5I381o9cKmVXdrKLXq0LqKe95Pt1uOQYsS38eGzPz2ToCGFUwmGMCUqxF6esYVuVxoBjCacqYDpOeh6Z6RhI0JVOl+Iy+SqrTQzqNcgCPKzHMX2CytpMF7VTlY4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gIZ6jPE1WF7opWuO7Tegz7qrRGLx/VZotnzJgxqjGv0=;
 b=WVB2Fc7CsJmC2sI9lSjlp75f7bJj5yb1GhTH0LYHg7Jf1LdiLdAsZp60GcMm42lsA3cLCXdfarigQrjLMexLhVWp4pQsZj5iBy2GkIfg6jZKPmReTw8Ga/yll73g421T2MiXr6i0i+n2vqj0aV0k9hz8ib1u4+tDNHj9TqvEaic=
Received: from AM6PR05MB4968.eurprd05.prod.outlook.com (20.177.33.17) by
 AM6PR05MB6519.eurprd05.prod.outlook.com (20.179.6.80) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.19; Mon, 9 Sep 2019 11:30:07 +0000
Received: from AM6PR05MB4968.eurprd05.prod.outlook.com
 ([fe80::f536:b35c:7fe4:4908]) by AM6PR05MB4968.eurprd05.prod.outlook.com
 ([fe80::f536:b35c:7fe4:4908%5]) with mapi id 15.20.2241.018; Mon, 9 Sep 2019
 11:30:07 +0000
From:   Noa Osherovich <noaos@mellanox.com>
To:     Leon Romanovsky <leonro@mellanox.com>
CC:     Jason Gunthorpe <jgg@mellanox.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-core 03/14] build: Add pyverbs-based test to the
 build
Thread-Topic: [PATCH rdma-core 03/14] build: Add pyverbs-based test to the
 build
Thread-Index: AQHVVluKi/1wMEsI4UWSJliEROGNkacCfWOAgAGEcwCAA1vkAIAACaEAgA9+4wCADGATgIAANQiA///a0ICAAAD5AA==
Date:   Mon, 9 Sep 2019 11:30:07 +0000
Message-ID: <b606a8c3-0e98-dc08-8bae-9d430c9755fe@mellanox.com>
References: <20190819065827.26921-1-noaos@mellanox.com>
 <20190819065827.26921-4-noaos@mellanox.com>
 <20190819135019.GF5080@mellanox.com>
 <2ac30209-2c89-15ef-3907-98d3cd552f4d@mellanox.com>
 <20190822161813.GI29433@mtr-leonro.mtl.com>
 <20190822165247.GB8325@mellanox.com>
 <88435e1e-676b-f948-1c34-22cd471af4c9@mellanox.com>
 <20190909102949.GF6601@unreal>
 <4caab234-7f8f-781c-68c6-672f961d9fd9@mellanox.com>
 <20190909112634.GG6601@unreal>
In-Reply-To: <20190909112634.GG6601@unreal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM0PR05CA0092.eurprd05.prod.outlook.com
 (2603:10a6:208:136::32) To AM6PR05MB4968.eurprd05.prod.outlook.com
 (2603:10a6:20b:4::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=noaos@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [193.47.165.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0a44af44-50d3-4229-0a22-08d7351910dd
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM6PR05MB6519;
x-ms-traffictypediagnostic: AM6PR05MB6519:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR05MB65197D1F4E3981D9EE76D52DD9B70@AM6PR05MB6519.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 01559F388D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(346002)(376002)(396003)(39860400002)(366004)(189003)(199004)(102836004)(14444005)(256004)(476003)(14454004)(71190400001)(486006)(71200400001)(6436002)(6636002)(31686004)(81156014)(66066001)(76176011)(81166006)(8676002)(52116002)(11346002)(36756003)(446003)(4326008)(25786009)(2616005)(8936002)(6512007)(66446008)(64756008)(66556008)(66476007)(66946007)(53546011)(6246003)(386003)(99286004)(37006003)(6506007)(305945005)(186003)(6862004)(316002)(2906002)(229853002)(53936002)(3846002)(26005)(7736002)(31696002)(5660300002)(6116002)(54906003)(6486002)(86362001)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR05MB6519;H:AM6PR05MB4968.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: sKQwYyXyIS9hVVOqfNVL2nLiRarQctIo6DEN/Blh65v0ZOz5tmlnK0Lsqz7lndbynG2taEuIerR4aU+kEQAYOy+Kiq9KvGsEIfMqBeihCJZWXHBkIux21/l/7RkaYSkORtdTh16/kuY+OGaYYh9MQI0vtGoBLF8A+xFoC3ci5usbY/RgQLq6fscMaG2Bu4cscYVlVaZ66Cfjly+EdpGz3FjQrTr3KXuvp4BkuIuGR3XwESKGs0SWiR2dlT649unXZ3BOcgeiB6flgk2sFqO6ahRrf3wlSeqXn0BLCDRWbJ9m8LtE82n4pnEHb4D1XhbeSKDxjGksDDeiO78bBj+QM+HX1zO/jIeCy7tTDGpxsYBm7PA7PcY7a6NeHW+t7xeIDbTAKAhiz2DunXrv0ux7YRLX3c9BTbGWSqspMWxyuRU=
Content-Type: text/plain; charset="utf-8"
Content-ID: <86E31A46DEE3E14D89B49866F177D143@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a44af44-50d3-4229-0a22-08d7351910dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2019 11:30:07.1099
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TeweWlGbI6mkmQJ75ixP5vLsvb05tyPq6j8AGzzvEIxTDHvB/PeHyo2HCFQHwvmWPAKznfzloum/lUdqeOvhrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB6519
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQpPbiA5LzkvMjAxOSAyOjI2IFBNLCBMZW9uIFJvbWFub3Zza3kgd3JvdGU6DQo+IE9uIE1vbiwg
U2VwIDA5LCAyMDE5IGF0IDEwOjM5OjQ0QU0gKzAwMDAsIE5vYSBPc2hlcm92aWNoIHdyb3RlOg0K
Pj4gT24gOS85LzIwMTkgMToyOSBQTSwgTGVvbiBSb21hbm92c2t5IHdyb3RlOg0KPj4+IE9uIFN1
biwgU2VwIDAxLCAyMDE5IGF0IDAxOjMwOjU2UE0gKzAwMDAsIE5vYSBPc2hlcm92aWNoIHdyb3Rl
Og0KPj4+PiBPbiA4LzIyLzIwMTkgNzo1MiBQTSwgSmFzb24gR3VudGhvcnBlIHdyb3RlOg0KPj4+
Pg0KPj4+Pj4gT24gVGh1LCBBdWcgMjIsIDIwMTkgYXQgMDE6MTg6MjRQTSAtMDMwMCwgTGVvbiBS
b21hbm92c2t5IHdyb3RlOg0KPj4+Pj4+IE9uIFR1ZSwgQXVnIDIwLCAyMDE5IGF0IDAxOjAwOjQ3
UE0gKzAwMDAsIE5vYSBPc2hlcm92aWNoIHdyb3RlOg0KPj4+Pj4+PiBPbiA4LzE5LzIwMTkgNDo1
MCBQTSwgSmFzb24gR3VudGhvcnBlIHdyb3RlOg0KPj4+Pj4+Pg0KPj4+Pj4+Pj4gSSdkIHByZWZl
ciBydW5fdGVzdHMgdG8gYmUgaW4gdGhlIHRlc3RzIGRpcmVjdG9yeS4uDQo+Pj4+Pj4+Pg0KPj4+
Pj4+Pj4gSmFzb24NCj4+Pj4+Pj4gUFIgd2FzIHVwZGF0ZWQNCj4+Pj4+PiAxLg0KPj4+Pj4+IElN
SE8sIHJ1bl90ZXN0cy5weSBzaG91bGQgYmUgcGxhY2VkIGluc2lkZSB0ZXN0cyBkaXJlY3Rvcnkg
dG9vIGFuZCBub3QNCj4+Pj4+PiBvbmx5IGluc3RhbGxlZCBpbnRvIHRlc3RzLy4NCj4+Pj4+IFll
cywgdGhpcyBpcyB3aGF0IEkgbWVudC4gVGhlIGZpbGUgc2hvdWxkIGJlIGluIHRlc3RzLyBhbmQg
aXQgc2hvdWxkDQo+Pj4+PiBiZSBidWlsdCBpbnRvIGJ1aWxkL2JpbiwgYW5kIGluc3RhbGxlZCBp
bnRvIHRoZSBleGFtcGxlcw0KPj4+Pj4+IDIuDQo+Pj4+Pj4gRXhlY3V0aW9uIG9mIHJ1bl90ZXN0
cy5weSBwcm9kdWNlcyBhIGxvdCBvZiB1bnRyYWNrZWQgZmlsZWQNCj4+Pj4+PiDinpwgIHJkbWEt
Y29yZSBnaXQ6KG5vYW9zLXByLXRlc3RzKSDinJcgZ2l0IHN0DQo+Pj4+Pj4gT24gYnJhbmNoIG5v
YW9zLXByLXRlc3RzDQo+Pj4+Pj4gVW50cmFja2VkIGZpbGVzOg0KPj4+Pj4+ICAgKHVzZSAiZ2l0
IGFkZCA8ZmlsZT4uLi4iIHRvIGluY2x1ZGUgaW4gd2hhdCB3aWxsIGJlIGNvbW1pdHRlZCkNCj4+
Pj4+Pg0KPj4+Pj4+IAlweXZlcmJzL19faW5pdF9fLnB5Yw0KPj4+Pj4+IAlweXZlcmJzL3B5dmVy
YnNfZXJyb3IucHljDQo+Pj4+Pj4gCXRlc3RzL19faW5pdF9fLnB5Yw0KPj4+Pj4+IAl0ZXN0cy9i
YXNlLnB5Yw0KPj4+Pj4+IAl0ZXN0cy90ZXN0X2FkZHIucHljDQo+Pj4+Pj4gCXRlc3RzL3Rlc3Rf
Y3EucHljDQo+Pj4+Pj4gCXRlc3RzL3Rlc3RfZGV2aWNlLnB5Yw0KPj4+Pj4+IAl0ZXN0cy90ZXN0
X21yLnB5Yw0KPj4+Pj4+IAl0ZXN0cy90ZXN0X29kcC5weWMNCj4+Pj4+PiAJdGVzdHMvdGVzdF9w
ZC5weWMNCj4+Pj4+PiAJdGVzdHMvdGVzdF9xcC5weWMNCj4+Pj4+ICoucHljIHdpbGwgaGF2ZSB0
byBiZSBhZGRlZCB0byB0aGUgLmdpdGlnbm9yZQ0KPj4+Pj4+IDMuIHJ1bl90ZXN0cy5weSBsYWNr
cyBvZiBweXRob24zIHNoZWJhbmcNCj4+Pj4+IE9yaWdpbmFsbHkgaXQgd2FzIG5vdCBpbnN0YWxs
ZWQsIHNvIHRoaXMgd2FzIGZpbmUsIGFzIHRoZSBidWlsZC9iaW4NCj4+Pj4+IHNjcmlwdCBkb2Vz
IGFsbCB0aGUgcmVxdWlyZWQgc2V0dXAsIGhvd2V2ZXIgbm93IHRoYXQgaXQgaXMgdG8gYmUNCj4+
Pj4+IGluc3RhbGxlZCBpdCBzaG91bGQgaGF2ZSB0aGUgIyEgLSBhbmQgaXQgc2hvdWxkIGFsc28g
d29yayB3aXRob3V0IGFueQ0KPj4+Pj4gdHJvdWJsZSBmcm9tIGl0J3MgZXhhbXBsZSBsb2NhdGlv
bi4NCj4+Pj4+DQo+Pj4+PiBKYXNvbg0KPj4+PiBQUiB3YXMgdXBkYXRlZC4NCj4+PiBJIHRyaWVk
IGl0IG5vdyBhbmQgZ290IHZlcnkgY29uZnVzaW5nIHJlc3VsdHMuDQo+Pj4NCj4+PiBPbiBteSBt
YWNoaW5lIHRoZXJlIGFyZSBubyBpYl9kZXZpY2VzLCBhbmQgSSBleHBlY3RlZCB0byBzZWUgQUxM
IHRlc3RzDQo+Pj4gbWFya2VkIGFzIHNraXBwZWQsIGJ1dCBnb3QgdHdvIHNraXBwZWQgb25seSwg
aXMgaXQgZXhwZWN0ZWQgYmVoYXZpb3VyPw0KPj4gWWVzLiBJZiB5b3UgcmVjYWxsLCBvdXIgcHJl
dmlvdXMgdW5pdHRlc3RzIHdvcmtlZCBkaWZmZXJlbnRseSB0aGFuIHRoZSBuZXcgb25lczsgZWFj
aA0KPj4gdGVzdCB3b3VsZCBpdGVyYXRlIG92ZXIgYW4gYXJyYXkgb2YgYWxsIGF2YWlsYWJsZSBk
ZXZpY2VzIGFuZCB3b3VsZCBydW4gb24gZWFjaCBkZXZpY2UuDQo+PiBUaGUgYXJyYXkgY2FuIGJl
IG9mIGxlbmd0aCAwLiBJZiBubyBmYWlsdXJlIHdhcyBmb3VuZCwgdGhleSdyZSBtYXJrZWQgYXMg
cGFzc2VkLg0KPj4gVGhlIG5ldyB0ZXN0cyBza2lwICh0aGUgcmVwb3J0ZWQgJ3MnIHlvdSBzYXcp
IGluIGNhc2UgYSBjb21iaW5hdGlvbiBvZiBkZXZpY2UvcG9ydC9HSUQNCj4+IGluZGV4IHdhc24n
dCBmb3VuZC4NCj4gYXJyYXkgbGVuZ3RoIDAgc2hvdWxkIHJldHVybiAic2tpcHBlZCIgYW5kIG5v
dCAicGFzc2VkIi4NCj4NCj4gVGhhbmtzDQoNCkxlb24sIHRoZXNlIGFyZSBvbGRlciB0ZXN0cywg
bm90IHJlbGF0ZWQgdG8gdGhlIGN1cnJlbnQgUFIuDQpJIGNhbiB1cGRhdGUgdGhlaXIgYmVoYXZp
b3IsIGJ1dCBsZXQncyBzZXBhcmF0ZSBpdCBmcm9tIHRoZSBQUi4NCg0KVGhhbmtzLA0KTm9hDQoN
Cj4+IFRoYW5rcywNCj4+IE5vYQ0KPj4NCj4+PiBfICByZG1hLWNvcmUgZ2l0Oihub2Fvcy1wci10
ZXN0cykgLi9idWlsZC9iaW4vcnVuX3Rlc3RzLnB5DQo+Pj4gLi4uLi4uLi4uLi4uLi4uLi4uLi4u
Li4uLi4uLi4uLi4uLi4uLi4uLi4uc3MuLi4uLi4uLi4uLi4uLi4NCj4+PiAtLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
DQo+Pj4gUmFuIDU5IHRlc3RzIGluIDAuMDA0cw0KPj4+DQo+Pj4gT0sgKHNraXBwZWQ9MikNCj4+
Pg0KPj4+IFRoYW5rcw0KPj4+DQo+Pj4+IFRoYW5rcywNCj4+Pj4NCj4+Pj4gTm9hDQo+Pj4+DQo=
