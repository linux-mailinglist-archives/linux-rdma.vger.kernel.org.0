Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE275AD7DC
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Sep 2019 13:26:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404033AbfIIL0n (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 9 Sep 2019 07:26:43 -0400
Received: from mail-eopbgr00078.outbound.protection.outlook.com ([40.107.0.78]:12099
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2404031AbfIIL0n (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 9 Sep 2019 07:26:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bhpdSAV+CzSvMGMgxv7EQYbOV/PAy9uW4WngpxRojcc2U9l4sqXbUtA5dTOwguXthpFGFdWwNLV6nsksq0VO1jalhQzMMzOMDMHBye+fJ/TBxbYp8/AYZfYPA1ZTgjovadJxvPXd6qc5JFkwNhV2h1Uvdjexyz5zVGrKiFwP/3zs05bNmSOCoh5/IsVPFrtEqAdzbJPiTF9c5wdiMSuvB2lmnkTBvNhjzvqs6moi83cNzEqKCed777g2kU3LaphAMbKKa5LRVvUCmg9VatEGANfXO5yrpkQBZc67xt9QIONJnwWCLfpWPF3m4J+3phDqZUCpocQ01M/Wli1h0OXLpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uNqwwB2XXV5pyACPZWEjs6dL4uz4vL9ZvM9hu7u9o3I=;
 b=MA+VdHfJi7bSWmTTKdVp8AkH7pXbvIyXFlswcBROS0l2hfFGQV5St0LF4eRDHwc5B4+ziVTd/v2ps12WtL5hoeTeTrk1huR6rYfEES6KtR+QS5IYt8p1V0AMoxkBqz5kywWXltYSw6oXpjDwrZfH8E14Us9F71q/GyyTlsE1v5NQH+rxQrhqibPMblRORb5jBHM9v7ahYRP58EO0KOQc+4f/Z6ColOR5EYdFzxM3/2ICDrHS0kQG7qVoUfEKPXXrVuWn9eqzX/QBJQgpRuOqmkh1WKaZw30Anys38Ux7F7+bhyI8AqI+2re0A8R/LiWppj2kSmhFMOReOTVzWcDPhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uNqwwB2XXV5pyACPZWEjs6dL4uz4vL9ZvM9hu7u9o3I=;
 b=Lv6W/6fse2TaPDuvd1cbCsTg/XayskR3DDjLHpXgYnl8LafJLlhHRCq/ScOe1shCUwtiaHwRFPHQb6XUf0Rbyxm/Ju8oIpQ3RVtaVPgaHyk7FGeKPp0xAJ3kzhG5HDpbXYXGh0LYaApRoyil6BeJ67yEaCzL8s1cFxFzhB66P3I=
Received: from AM4PR05MB3137.eurprd05.prod.outlook.com (10.171.188.155) by
 AM4PR05MB3444.eurprd05.prod.outlook.com (10.171.187.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.21; Mon, 9 Sep 2019 11:26:36 +0000
Received: from AM4PR05MB3137.eurprd05.prod.outlook.com
 ([fe80::e826:7a52:5488:2b6f]) by AM4PR05MB3137.eurprd05.prod.outlook.com
 ([fe80::e826:7a52:5488:2b6f%7]) with mapi id 15.20.2199.027; Mon, 9 Sep 2019
 11:26:36 +0000
From:   Leon Romanovsky <leonro@mellanox.com>
To:     Noa Osherovich <noaos@mellanox.com>
CC:     Jason Gunthorpe <jgg@mellanox.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-core 03/14] build: Add pyverbs-based test to the
 build
Thread-Topic: [PATCH rdma-core 03/14] build: Add pyverbs-based test to the
 build
Thread-Index: AQHVVluKJrnh28/IoUO3a7bpLCEySqcCfWOAgAGEcwCAA1vkAIAACaEAgA9+4wCADGAOgIAAAsYAgAANFQA=
Date:   Mon, 9 Sep 2019 11:26:35 +0000
Message-ID: <20190909112634.GG6601@unreal>
References: <20190819065827.26921-1-noaos@mellanox.com>
 <20190819065827.26921-4-noaos@mellanox.com>
 <20190819135019.GF5080@mellanox.com>
 <2ac30209-2c89-15ef-3907-98d3cd552f4d@mellanox.com>
 <20190822161813.GI29433@mtr-leonro.mtl.com>
 <20190822165247.GB8325@mellanox.com>
 <88435e1e-676b-f948-1c34-22cd471af4c9@mellanox.com>
 <20190909102949.GF6601@unreal>
 <4caab234-7f8f-781c-68c6-672f961d9fd9@mellanox.com>
In-Reply-To: <4caab234-7f8f-781c-68c6-672f961d9fd9@mellanox.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MR2P264CA0007.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:1::19) To AM4PR05MB3137.eurprd05.prod.outlook.com
 (2603:10a6:205:8::27)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonro@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [148.69.85.38]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 96db9e17-605f-4aa1-b98e-08d735189302
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM4PR05MB3444;
x-ms-traffictypediagnostic: AM4PR05MB3444:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM4PR05MB3444B3BE6BBF5231DE453DD3B0B70@AM4PR05MB3444.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 01559F388D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(7916004)(346002)(366004)(376002)(39860400002)(396003)(136003)(189003)(199004)(6246003)(81166006)(81156014)(52116002)(5660300002)(53546011)(229853002)(11346002)(386003)(71200400001)(71190400001)(7736002)(66066001)(6506007)(6862004)(446003)(76176011)(4326008)(25786009)(8676002)(1076003)(8936002)(26005)(33656002)(14454004)(53936002)(3846002)(6116002)(54906003)(186003)(6636002)(478600001)(102836004)(66946007)(6436002)(86362001)(33716001)(6486002)(476003)(2906002)(486006)(6512007)(99286004)(316002)(305945005)(14444005)(256004)(66446008)(9686003)(66476007)(66556008)(64756008);DIR:OUT;SFP:1101;SCL:1;SRVR:AM4PR05MB3444;H:AM4PR05MB3137.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: HxvrfFCUl7Rx/FJb+sphjor9eBbqpAhoIOG/UD3qe1M6cGX7+ZgHxT0X3/djlHKdQthoCEQKXQV0TlZA38vSynWxXfbMc3MZ76vAJ4VOrBYfUsp7pipkS5e8OL+RMYSpuX3/Wpu+/yEudHtwMB/CIcD8Y2wXZvBdawIKz27Ex68/uWuP+Za8LPZgQIwpPDjj54KvM6CIYgZgVUEKUxa1gkgcL0Ww9lIBejmBlFl02Ey0OvwkRNMJeVhYVElcF65KuKE6QzryeJlV4NIE5VBhycNcGrszNHRmNjHzzjOMD28eFFPM7SMFtLplHBCOWTnt+Ns1bMgvKhkEluS4DXoyIuK91kjwObENjo2FuEAbvKLFYvyK33SbO14M/0rt7RoDlc1n8FBeua71S6DniXBrpTl5U7ebTBJesgEAEyxfwR0=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E7C410E651F8CD42B7D2C2F3DE4D4CB3@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96db9e17-605f-4aa1-b98e-08d735189302
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2019 11:26:36.1139
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IO/pq0Mfuc0ux+VmC2EVj+gy8FvkkggXxSs8C4CL/vu1DyncQsWJuT/M3PCBlW4XRNRejRpdtsdJInm2DUDIPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR05MB3444
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

T24gTW9uLCBTZXAgMDksIDIwMTkgYXQgMTA6Mzk6NDRBTSArMDAwMCwgTm9hIE9zaGVyb3ZpY2gg
d3JvdGU6DQo+DQo+IE9uIDkvOS8yMDE5IDE6MjkgUE0sIExlb24gUm9tYW5vdnNreSB3cm90ZToN
Cj4gPiBPbiBTdW4sIFNlcCAwMSwgMjAxOSBhdCAwMTozMDo1NlBNICswMDAwLCBOb2EgT3NoZXJv
dmljaCB3cm90ZToNCj4gPj4gT24gOC8yMi8yMDE5IDc6NTIgUE0sIEphc29uIEd1bnRob3JwZSB3
cm90ZToNCj4gPj4NCj4gPj4+IE9uIFRodSwgQXVnIDIyLCAyMDE5IGF0IDAxOjE4OjI0UE0gLTAz
MDAsIExlb24gUm9tYW5vdnNreSB3cm90ZToNCj4gPj4+PiBPbiBUdWUsIEF1ZyAyMCwgMjAxOSBh
dCAwMTowMDo0N1BNICswMDAwLCBOb2EgT3NoZXJvdmljaCB3cm90ZToNCj4gPj4+Pj4gT24gOC8x
OS8yMDE5IDQ6NTAgUE0sIEphc29uIEd1bnRob3JwZSB3cm90ZToNCj4gPj4+Pj4NCj4gPj4+Pj4+
IEknZCBwcmVmZXIgcnVuX3Rlc3RzIHRvIGJlIGluIHRoZSB0ZXN0cyBkaXJlY3RvcnkuLg0KPiA+
Pj4+Pj4NCj4gPj4+Pj4+IEphc29uDQo+ID4+Pj4+IFBSIHdhcyB1cGRhdGVkDQo+ID4+Pj4gMS4N
Cj4gPj4+PiBJTUhPLCBydW5fdGVzdHMucHkgc2hvdWxkIGJlIHBsYWNlZCBpbnNpZGUgdGVzdHMg
ZGlyZWN0b3J5IHRvbyBhbmQgbm90DQo+ID4+Pj4gb25seSBpbnN0YWxsZWQgaW50byB0ZXN0cy8u
DQo+ID4+PiBZZXMsIHRoaXMgaXMgd2hhdCBJIG1lbnQuIFRoZSBmaWxlIHNob3VsZCBiZSBpbiB0
ZXN0cy8gYW5kIGl0IHNob3VsZA0KPiA+Pj4gYmUgYnVpbHQgaW50byBidWlsZC9iaW4sIGFuZCBp
bnN0YWxsZWQgaW50byB0aGUgZXhhbXBsZXMNCj4gPj4+PiAyLg0KPiA+Pj4+IEV4ZWN1dGlvbiBv
ZiBydW5fdGVzdHMucHkgcHJvZHVjZXMgYSBsb3Qgb2YgdW50cmFja2VkIGZpbGVkDQo+ID4+Pj4g
4p6cICByZG1hLWNvcmUgZ2l0Oihub2Fvcy1wci10ZXN0cykg4pyXIGdpdCBzdA0KPiA+Pj4+IE9u
IGJyYW5jaCBub2Fvcy1wci10ZXN0cw0KPiA+Pj4+IFVudHJhY2tlZCBmaWxlczoNCj4gPj4+PiAg
ICh1c2UgImdpdCBhZGQgPGZpbGU+Li4uIiB0byBpbmNsdWRlIGluIHdoYXQgd2lsbCBiZSBjb21t
aXR0ZWQpDQo+ID4+Pj4NCj4gPj4+PiAJcHl2ZXJicy9fX2luaXRfXy5weWMNCj4gPj4+PiAJcHl2
ZXJicy9weXZlcmJzX2Vycm9yLnB5Yw0KPiA+Pj4+IAl0ZXN0cy9fX2luaXRfXy5weWMNCj4gPj4+
PiAJdGVzdHMvYmFzZS5weWMNCj4gPj4+PiAJdGVzdHMvdGVzdF9hZGRyLnB5Yw0KPiA+Pj4+IAl0
ZXN0cy90ZXN0X2NxLnB5Yw0KPiA+Pj4+IAl0ZXN0cy90ZXN0X2RldmljZS5weWMNCj4gPj4+PiAJ
dGVzdHMvdGVzdF9tci5weWMNCj4gPj4+PiAJdGVzdHMvdGVzdF9vZHAucHljDQo+ID4+Pj4gCXRl
c3RzL3Rlc3RfcGQucHljDQo+ID4+Pj4gCXRlc3RzL3Rlc3RfcXAucHljDQo+ID4+PiAqLnB5YyB3
aWxsIGhhdmUgdG8gYmUgYWRkZWQgdG8gdGhlIC5naXRpZ25vcmUNCj4gPj4+PiAzLiBydW5fdGVz
dHMucHkgbGFja3Mgb2YgcHl0aG9uMyBzaGViYW5nDQo+ID4+PiBPcmlnaW5hbGx5IGl0IHdhcyBu
b3QgaW5zdGFsbGVkLCBzbyB0aGlzIHdhcyBmaW5lLCBhcyB0aGUgYnVpbGQvYmluDQo+ID4+PiBz
Y3JpcHQgZG9lcyBhbGwgdGhlIHJlcXVpcmVkIHNldHVwLCBob3dldmVyIG5vdyB0aGF0IGl0IGlz
IHRvIGJlDQo+ID4+PiBpbnN0YWxsZWQgaXQgc2hvdWxkIGhhdmUgdGhlICMhIC0gYW5kIGl0IHNo
b3VsZCBhbHNvIHdvcmsgd2l0aG91dCBhbnkNCj4gPj4+IHRyb3VibGUgZnJvbSBpdCdzIGV4YW1w
bGUgbG9jYXRpb24uDQo+ID4+Pg0KPiA+Pj4gSmFzb24NCj4gPj4gUFIgd2FzIHVwZGF0ZWQuDQo+
ID4gSSB0cmllZCBpdCBub3cgYW5kIGdvdCB2ZXJ5IGNvbmZ1c2luZyByZXN1bHRzLg0KPiA+DQo+
ID4gT24gbXkgbWFjaGluZSB0aGVyZSBhcmUgbm8gaWJfZGV2aWNlcywgYW5kIEkgZXhwZWN0ZWQg
dG8gc2VlIEFMTCB0ZXN0cw0KPiA+IG1hcmtlZCBhcyBza2lwcGVkLCBidXQgZ290IHR3byBza2lw
cGVkIG9ubHksIGlzIGl0IGV4cGVjdGVkIGJlaGF2aW91cj8NCj4NCj4gWWVzLiBJZiB5b3UgcmVj
YWxsLCBvdXIgcHJldmlvdXMgdW5pdHRlc3RzIHdvcmtlZCBkaWZmZXJlbnRseSB0aGFuIHRoZSBu
ZXcgb25lczsgZWFjaA0KPiB0ZXN0IHdvdWxkIGl0ZXJhdGUgb3ZlciBhbiBhcnJheSBvZiBhbGwg
YXZhaWxhYmxlIGRldmljZXMgYW5kIHdvdWxkIHJ1biBvbiBlYWNoIGRldmljZS4NCj4gVGhlIGFy
cmF5IGNhbiBiZSBvZiBsZW5ndGggMC4gSWYgbm8gZmFpbHVyZSB3YXMgZm91bmQsIHRoZXkncmUg
bWFya2VkIGFzIHBhc3NlZC4NCj4gVGhlIG5ldyB0ZXN0cyBza2lwICh0aGUgcmVwb3J0ZWQgJ3Mn
IHlvdSBzYXcpIGluIGNhc2UgYSBjb21iaW5hdGlvbiBvZiBkZXZpY2UvcG9ydC9HSUQNCj4gaW5k
ZXggd2Fzbid0IGZvdW5kLg0KDQphcnJheSBsZW5ndGggMCBzaG91bGQgcmV0dXJuICJza2lwcGVk
IiBhbmQgbm90ICJwYXNzZWQiLg0KDQpUaGFua3MNCg0KPg0KPiBUaGFua3MsDQo+IE5vYQ0KPg0K
PiA+DQo+ID4gXyAgcmRtYS1jb3JlIGdpdDoobm9hb3MtcHItdGVzdHMpIC4vYnVpbGQvYmluL3J1
bl90ZXN0cy5weQ0KPiA+IC4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4u
LnNzLi4uLi4uLi4uLi4uLi4uDQo+ID4gLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiA+IFJhbiA1OSB0ZXN0cyBp
biAwLjAwNHMNCj4gPg0KPiA+IE9LIChza2lwcGVkPTIpDQo+ID4NCj4gPiBUaGFua3MNCj4gPg0K
PiA+PiBUaGFua3MsDQo+ID4+DQo+ID4+IE5vYQ0KPiA+Pg0K
