Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B97F9AD7FC
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Sep 2019 13:34:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404103AbfIILeo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 9 Sep 2019 07:34:44 -0400
Received: from mail-eopbgr50047.outbound.protection.outlook.com ([40.107.5.47]:45697
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2404125AbfIILen (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 9 Sep 2019 07:34:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j8FSfJIoOGKxvkF02HxE9XtYgNczdBpyIbljFD/Z94kZDxBEqvA1iHoTm9W/3vKZaDbCywGMnn+hq1YgXSjA6svIhk/Ybxnmw5eRdoeflC0ciV2Ukw42SSh/pvXtKbuCy1xdgwpFCNhdOC5EIv4r8Z63laDEBiODM+iac/Yb9f3TpezCyViFCBLg66Usn+vg5MNDucn5AGae+TQuGgQ3cB8JVv+bFKoptim8lPX7KOjwt6kZIKv1HOWpU2ESMEZdfyfbBghvtayL0iFGixOBgScxYtKuaIqiBgHE4m46UZhAo+KRkyv0K3PR3KHZMan+P/hWFpGDHqJBO9B81bZn2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bqWxCube4PIE3Teu1ykw5DpXepQI95q+ZKcOlur4eGs=;
 b=je7NHcaKRjPZWSaMr2bOUXk5czRhu15M4uRM4/VcU6a96Fo3h/IKtR4XSun6Ya8xHwUI6XWW2gW4IKIL9+D25bPYzgozjTkqjFNgSCkMS8Iluk43Y2oNVRGPSEH1JpmDeZHuCHutGNA6Dsgb84iAz9P59N410yudBXI3u5dh9oC3oAoPNZg9jwKHUB9wP7Kal50cxLBEC9IVGDx4BBU3QbVXEBCnVS6gBTG5zizFAp3CYKAf/yq49p1Vzt+liVdqYi0FA9xGUQt6DwJiQQ45EenayIwgmgD7uOjS9CqqLMFWdPUhhMbHywNzPZKeANoHWUDDv+mZGElypcrLyXWlAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bqWxCube4PIE3Teu1ykw5DpXepQI95q+ZKcOlur4eGs=;
 b=CtipywjCuk780WoJZwI67Xm6WJe/P84HQ/Cf6BsVS7FPNoSEYIfo9RUslT4T8LeGtKKNZRjbpZDCW1a6thP7exrPKVF8shG46jXMsAiYZ82RkRwWRFrkLHSJCjDMbqTPUbhF9Zyz7fvPmOQPpOTmzZAcrUHk0GyJEcZmdDfioiA=
Received: from AM4PR05MB3137.eurprd05.prod.outlook.com (10.171.188.155) by
 AM4PR05MB3444.eurprd05.prod.outlook.com (10.171.187.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.21; Mon, 9 Sep 2019 11:34:38 +0000
Received: from AM4PR05MB3137.eurprd05.prod.outlook.com
 ([fe80::e826:7a52:5488:2b6f]) by AM4PR05MB3137.eurprd05.prod.outlook.com
 ([fe80::e826:7a52:5488:2b6f%7]) with mapi id 15.20.2199.027; Mon, 9 Sep 2019
 11:34:38 +0000
From:   Leon Romanovsky <leonro@mellanox.com>
To:     Noa Osherovich <noaos@mellanox.com>
CC:     Jason Gunthorpe <jgg@mellanox.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-core 03/14] build: Add pyverbs-based test to the
 build
Thread-Topic: [PATCH rdma-core 03/14] build: Add pyverbs-based test to the
 build
Thread-Index: AQHVVluKJrnh28/IoUO3a7bpLCEySqcCfWOAgAGEcwCAA1vkAIAACaEAgA9+4wCADGAOgIAAAsYAgAANFQCAAAI+gA==
Date:   Mon, 9 Sep 2019 11:34:37 +0000
Message-ID: <20190909113435.GH6601@unreal>
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
x-clientproxiedby: PR0P264CA0158.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:1b::26) To AM4PR05MB3137.eurprd05.prod.outlook.com
 (2603:10a6:205:8::27)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonro@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [148.69.85.38]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1850edb1-30e3-4198-639f-08d73519b24a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM4PR05MB3444;
x-ms-traffictypediagnostic: AM4PR05MB3444:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM4PR05MB34441D3F9AB1A91D742FC4C0B0B70@AM4PR05MB3444.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 01559F388D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(4636009)(136003)(396003)(39860400002)(366004)(376002)(346002)(199004)(189003)(54906003)(6116002)(186003)(3846002)(33656002)(53936002)(14454004)(478600001)(6636002)(26005)(6512007)(486006)(99286004)(316002)(66556008)(66476007)(9686003)(64756008)(14444005)(305945005)(66446008)(256004)(66946007)(102836004)(6436002)(2906002)(33716001)(86362001)(476003)(6486002)(11346002)(229853002)(386003)(53546011)(6506007)(66066001)(446003)(6862004)(7736002)(71190400001)(71200400001)(52116002)(81166006)(6246003)(81156014)(5660300002)(8936002)(1076003)(8676002)(4326008)(76176011)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:AM4PR05MB3444;H:AM4PR05MB3137.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Qvy5m622z5IbSyG/eF+WT8FfJnOm7/g4MTRHZ6HtLiiFAfq3yTKMS7FxbfPU2kEbZ66VCWXRHMuO/UX5Bk+HvphIVLCOhC4ul8zy8jzQ8I3RBteKApa92FhD0H+rgqFj1TY3MHsozEymQrCNcfm1fivJogll5mhvfkrkSS/J5fLR2C6zFrvLCZ2bJxDPJyB2zsd7ZDbJlV93bJtZNamBL/2azfxtZl5L8arV3PWdbs6hOVgEm8jiS9b2V0c9mwfT1WB5ABo28pggQ0cAIqubd01PT9LcEwsQ3KHnKuPUCpzDnuZDInfXt+Og5q14SeRvgRdUOPzeqIgicmLc4GA6gvQ25sdLLkAT8PfO2mxhCAr/ehGPBl/+W2E+5n1ncr9waoqVrQfuQx4sE6XyzCarAa1O8XcCaxW5Q09N1Z1wEmo=
Content-Type: text/plain; charset="utf-8"
Content-ID: <69DCFDE6616CC84D99B6BB5D3E7EE20C@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1850edb1-30e3-4198-639f-08d73519b24a
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2019 11:34:37.9327
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XdG+qHO5LxRn6gmBnu7sOJV3oVCZzpQC5HfdwqeaAwW84R5MZ2eCniuY8kmV16FSwU0Bc+mL1Q6wTOkplmv6kQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR05MB3444
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

T24gTW9uLCBTZXAgMDksIDIwMTkgYXQgMTE6MjY6MzVBTSArMDAwMCwgTGVvbiBSb21hbm92c2t5
IHdyb3RlOg0KPiBPbiBNb24sIFNlcCAwOSwgMjAxOSBhdCAxMDozOTo0NEFNICswMDAwLCBOb2Eg
T3NoZXJvdmljaCB3cm90ZToNCj4gPg0KPiA+IE9uIDkvOS8yMDE5IDE6MjkgUE0sIExlb24gUm9t
YW5vdnNreSB3cm90ZToNCj4gPiA+IE9uIFN1biwgU2VwIDAxLCAyMDE5IGF0IDAxOjMwOjU2UE0g
KzAwMDAsIE5vYSBPc2hlcm92aWNoIHdyb3RlOg0KPiA+ID4+IE9uIDgvMjIvMjAxOSA3OjUyIFBN
LCBKYXNvbiBHdW50aG9ycGUgd3JvdGU6DQo+ID4gPj4NCj4gPiA+Pj4gT24gVGh1LCBBdWcgMjIs
IDIwMTkgYXQgMDE6MTg6MjRQTSAtMDMwMCwgTGVvbiBSb21hbm92c2t5IHdyb3RlOg0KPiA+ID4+
Pj4gT24gVHVlLCBBdWcgMjAsIDIwMTkgYXQgMDE6MDA6NDdQTSArMDAwMCwgTm9hIE9zaGVyb3Zp
Y2ggd3JvdGU6DQo+ID4gPj4+Pj4gT24gOC8xOS8yMDE5IDQ6NTAgUE0sIEphc29uIEd1bnRob3Jw
ZSB3cm90ZToNCj4gPiA+Pj4+Pg0KPiA+ID4+Pj4+PiBJJ2QgcHJlZmVyIHJ1bl90ZXN0cyB0byBi
ZSBpbiB0aGUgdGVzdHMgZGlyZWN0b3J5Li4NCj4gPiA+Pj4+Pj4NCj4gPiA+Pj4+Pj4gSmFzb24N
Cj4gPiA+Pj4+PiBQUiB3YXMgdXBkYXRlZA0KPiA+ID4+Pj4gMS4NCj4gPiA+Pj4+IElNSE8sIHJ1
bl90ZXN0cy5weSBzaG91bGQgYmUgcGxhY2VkIGluc2lkZSB0ZXN0cyBkaXJlY3RvcnkgdG9vIGFu
ZCBub3QNCj4gPiA+Pj4+IG9ubHkgaW5zdGFsbGVkIGludG8gdGVzdHMvLg0KPiA+ID4+PiBZZXMs
IHRoaXMgaXMgd2hhdCBJIG1lbnQuIFRoZSBmaWxlIHNob3VsZCBiZSBpbiB0ZXN0cy8gYW5kIGl0
IHNob3VsZA0KPiA+ID4+PiBiZSBidWlsdCBpbnRvIGJ1aWxkL2JpbiwgYW5kIGluc3RhbGxlZCBp
bnRvIHRoZSBleGFtcGxlcw0KPiA+ID4+Pj4gMi4NCj4gPiA+Pj4+IEV4ZWN1dGlvbiBvZiBydW5f
dGVzdHMucHkgcHJvZHVjZXMgYSBsb3Qgb2YgdW50cmFja2VkIGZpbGVkDQo+ID4gPj4+PiDinpwg
IHJkbWEtY29yZSBnaXQ6KG5vYW9zLXByLXRlc3RzKSDinJcgZ2l0IHN0DQo+ID4gPj4+PiBPbiBi
cmFuY2ggbm9hb3MtcHItdGVzdHMNCj4gPiA+Pj4+IFVudHJhY2tlZCBmaWxlczoNCj4gPiA+Pj4+
ICAgKHVzZSAiZ2l0IGFkZCA8ZmlsZT4uLi4iIHRvIGluY2x1ZGUgaW4gd2hhdCB3aWxsIGJlIGNv
bW1pdHRlZCkNCj4gPiA+Pj4+DQo+ID4gPj4+PiAJcHl2ZXJicy9fX2luaXRfXy5weWMNCj4gPiA+
Pj4+IAlweXZlcmJzL3B5dmVyYnNfZXJyb3IucHljDQo+ID4gPj4+PiAJdGVzdHMvX19pbml0X18u
cHljDQo+ID4gPj4+PiAJdGVzdHMvYmFzZS5weWMNCj4gPiA+Pj4+IAl0ZXN0cy90ZXN0X2FkZHIu
cHljDQo+ID4gPj4+PiAJdGVzdHMvdGVzdF9jcS5weWMNCj4gPiA+Pj4+IAl0ZXN0cy90ZXN0X2Rl
dmljZS5weWMNCj4gPiA+Pj4+IAl0ZXN0cy90ZXN0X21yLnB5Yw0KPiA+ID4+Pj4gCXRlc3RzL3Rl
c3Rfb2RwLnB5Yw0KPiA+ID4+Pj4gCXRlc3RzL3Rlc3RfcGQucHljDQo+ID4gPj4+PiAJdGVzdHMv
dGVzdF9xcC5weWMNCj4gPiA+Pj4gKi5weWMgd2lsbCBoYXZlIHRvIGJlIGFkZGVkIHRvIHRoZSAu
Z2l0aWdub3JlDQo+ID4gPj4+PiAzLiBydW5fdGVzdHMucHkgbGFja3Mgb2YgcHl0aG9uMyBzaGVi
YW5nDQo+ID4gPj4+IE9yaWdpbmFsbHkgaXQgd2FzIG5vdCBpbnN0YWxsZWQsIHNvIHRoaXMgd2Fz
IGZpbmUsIGFzIHRoZSBidWlsZC9iaW4NCj4gPiA+Pj4gc2NyaXB0IGRvZXMgYWxsIHRoZSByZXF1
aXJlZCBzZXR1cCwgaG93ZXZlciBub3cgdGhhdCBpdCBpcyB0byBiZQ0KPiA+ID4+PiBpbnN0YWxs
ZWQgaXQgc2hvdWxkIGhhdmUgdGhlICMhIC0gYW5kIGl0IHNob3VsZCBhbHNvIHdvcmsgd2l0aG91
dCBhbnkNCj4gPiA+Pj4gdHJvdWJsZSBmcm9tIGl0J3MgZXhhbXBsZSBsb2NhdGlvbi4NCj4gPiA+
Pj4NCj4gPiA+Pj4gSmFzb24NCj4gPiA+PiBQUiB3YXMgdXBkYXRlZC4NCj4gPiA+IEkgdHJpZWQg
aXQgbm93IGFuZCBnb3QgdmVyeSBjb25mdXNpbmcgcmVzdWx0cy4NCj4gPiA+DQo+ID4gPiBPbiBt
eSBtYWNoaW5lIHRoZXJlIGFyZSBubyBpYl9kZXZpY2VzLCBhbmQgSSBleHBlY3RlZCB0byBzZWUg
QUxMIHRlc3RzDQo+ID4gPiBtYXJrZWQgYXMgc2tpcHBlZCwgYnV0IGdvdCB0d28gc2tpcHBlZCBv
bmx5LCBpcyBpdCBleHBlY3RlZCBiZWhhdmlvdXI/DQo+ID4NCj4gPiBZZXMuIElmIHlvdSByZWNh
bGwsIG91ciBwcmV2aW91cyB1bml0dGVzdHMgd29ya2VkIGRpZmZlcmVudGx5IHRoYW4gdGhlIG5l
dyBvbmVzOyBlYWNoDQo+ID4gdGVzdCB3b3VsZCBpdGVyYXRlIG92ZXIgYW4gYXJyYXkgb2YgYWxs
IGF2YWlsYWJsZSBkZXZpY2VzIGFuZCB3b3VsZCBydW4gb24gZWFjaCBkZXZpY2UuDQo+ID4gVGhl
IGFycmF5IGNhbiBiZSBvZiBsZW5ndGggMC4gSWYgbm8gZmFpbHVyZSB3YXMgZm91bmQsIHRoZXkn
cmUgbWFya2VkIGFzIHBhc3NlZC4NCj4gPiBUaGUgbmV3IHRlc3RzIHNraXAgKHRoZSByZXBvcnRl
ZCAncycgeW91IHNhdykgaW4gY2FzZSBhIGNvbWJpbmF0aW9uIG9mIGRldmljZS9wb3J0L0dJRA0K
PiA+IGluZGV4IHdhc24ndCBmb3VuZC4NCj4NCj4gYXJyYXkgbGVuZ3RoIDAgc2hvdWxkIHJldHVy
biAic2tpcHBlZCIgYW5kIG5vdCAicGFzc2VkIi4NCg0KSSBydW4gb3ZlciBJQiBkZXZpY2Ugb3Zl
ciByZG1hLW5leHQgYW5kIGdldCB2ZXJ5IGV4Y2l0aW5nIHNwbGF0Lg0KDQpbbGVvbnJvQHNlcnZl
ciB+XSQNCi9pbWFnZXMvbGVvbnJvL3NyYy9yZG1hLWNvcmUvYnVpbGQvYmluL3J1bl90ZXN0cy5w
eQ0KLi4uLi5FRkUuLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uc3MuLi4uLi4uLi4u
Li4uLi4NCj09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT0NCkVSUk9SOiB0ZXN0X2NyZWF0ZV9jcV9leCAodGVzdF9jcS5D
UUVYVGVzdCkNCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NClRyYWNlYmFjayAobW9zdCByZWNlbnQgY2FsbCBsYXN0
KToNCiAgRmlsZSAiL2ltYWdlcy9sZW9ucm8vc3JjL3JkbWEtY29yZS90ZXN0cy90ZXN0X2NxLnB5
IiwgbGluZSAxMTgsIGluIHRlc3RfY3JlYXRlX2NxX2V4DQogICAgICB3aXRoIENRRVgoY3R4LCBn
ZXRfYXR0cnNfZXgoYXR0ciwgYXR0cl9leCkpOg0KICBGaWxlICJjcS5weXgiLCBsaW5lIDI2NCwg
aW4gcHl2ZXJicy5jcS5DUUVYLl9fY2luaXRfXw0KcHl2ZXJicy5weXZlcmJzX2Vycm9yLlB5dmVy
YnNSRE1BRXJyb3I6IEZhaWxlZCB0byBjcmVhdGUgZXh0ZW5kZWQgQ1EuIEVycm5vOiA5NSwgT3Bl
cmF0aW9uIG5vdCBzdXBwb3J0ZWQNCg0KYW5kIG1hbnkgbW9yZS4NCg0KPg0KPiBUaGFua3MNCj4N
Cj4gPg0KPiA+IFRoYW5rcywNCj4gPiBOb2ENCj4gPg0KPiA+ID4NCj4gPiA+IF8gIHJkbWEtY29y
ZSBnaXQ6KG5vYW9zLXByLXRlc3RzKSAuL2J1aWxkL2Jpbi9ydW5fdGVzdHMucHkNCj4gPiA+IC4u
Li4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLnNzLi4uLi4uLi4uLi4uLi4u
DQo+ID4gPiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+ID4gPiBSYW4gNTkgdGVzdHMgaW4gMC4wMDRzDQo+ID4g
Pg0KPiA+ID4gT0sgKHNraXBwZWQ9MikNCj4gPiA+DQo+ID4gPiBUaGFua3MNCj4gPiA+DQo+ID4g
Pj4gVGhhbmtzLA0KPiA+ID4+DQo+ID4gPj4gTm9hDQo+ID4gPj4NCg==
