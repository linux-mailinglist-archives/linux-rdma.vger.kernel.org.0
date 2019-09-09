Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30948AD807
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Sep 2019 13:38:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730838AbfIILiP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 9 Sep 2019 07:38:15 -0400
Received: from mail-eopbgr50086.outbound.protection.outlook.com ([40.107.5.86]:58437
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730796AbfIILiO (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 9 Sep 2019 07:38:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XNmNiexCHq+nEBPB7L9kMtn5LsXwCOoONhnLY8dNIongT/OFHF+l4wDBaEXDltr+c8Iz21f4xbsMNXYeYMfGanXrHDXHlFYZr0UsfpcWPR6wu7zbLtRw9DKz5vlrVGyG4Z7ynxAEb5LCL0suBnGatH7R+dTS2ku0ozRLKGM9qDKl23r/RhnOE+m7nG0dyEBvyP4+x8aOtQ9+EcdpTweSeA3vpmNs5P2y2wEdo+zbSrqLIuYSlUOuUmVeIgv7JHsPirHPolkXiRNy5P1IhjaZJqZTvPZlU7oAc0CeNUQROjQk14CxciDyYqymCKhumOkAM/bDo65Gb/lqJNySq5Cw8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vQgADyeu/cxXvlCaNe19EqEjnXZlJWnK7zKkIpCRYws=;
 b=iWcdmuwtwk1x7IIys7ZMpFR6fo2RaRiDQRRL+ENSfzUYanrWFWJmW8fYjeOSkPFW1pzOLVrOpOkPN9KaWabwQejp8MrtM3gMPdP2Wjm8yPn+TiF5OdF2ORfKEC8hnnzE/hAKNiiLfBBFokaRYCwOrxzWXcbSRUpC+acyO6d55OLCR3EwGvdy4Z1YyPBX7LzN3Jphkbo6vQsEy6qb00YUPHCB/YFrOFGp6MEbUccqCegv9pwSmLXyNSrvg3oX7d9R2gB4jr9LZCvYoWnvnhbiMSLAJXqlQ2zGBmI6axTznlDpyFeUamRjn1NNCTk3hqoszy9xjVjX+o1GMnWgqJpeyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vQgADyeu/cxXvlCaNe19EqEjnXZlJWnK7zKkIpCRYws=;
 b=HcHAWEasH4PUX75v3ioTKnw7bVkepsbM+/4cR72sKUHM2FOpbt5MiWYZ5U/pg0mzg2HB+zaukXiwW9CW6TbsWU7iPV8A4UKnbctoRyYV79Hyhf2MWpPFam68SG5hSy6r218FALihyrh9uF8NUzGl9CjcAhN4NJHlXyUQcIiEkBw=
Received: from AM4PR05MB3137.eurprd05.prod.outlook.com (10.171.188.155) by
 AM4PR05MB3188.eurprd05.prod.outlook.com (10.171.186.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.20; Mon, 9 Sep 2019 11:38:05 +0000
Received: from AM4PR05MB3137.eurprd05.prod.outlook.com
 ([fe80::e826:7a52:5488:2b6f]) by AM4PR05MB3137.eurprd05.prod.outlook.com
 ([fe80::e826:7a52:5488:2b6f%7]) with mapi id 15.20.2199.027; Mon, 9 Sep 2019
 11:38:05 +0000
From:   Leon Romanovsky <leonro@mellanox.com>
To:     Noa Osherovich <noaos@mellanox.com>
CC:     Jason Gunthorpe <jgg@mellanox.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-core 03/14] build: Add pyverbs-based test to the
 build
Thread-Topic: [PATCH rdma-core 03/14] build: Add pyverbs-based test to the
 build
Thread-Index: AQHVVluKJrnh28/IoUO3a7bpLCEySqcCfWOAgAGEcwCAA1vkAIAACaEAgA9+4wCADGAOgIAAAsYAgAANFQCAAAD+gIAAAjiA
Date:   Mon, 9 Sep 2019 11:38:05 +0000
Message-ID: <20190909113803.GI6601@unreal>
References: <20190819065827.26921-4-noaos@mellanox.com>
 <20190819135019.GF5080@mellanox.com>
 <2ac30209-2c89-15ef-3907-98d3cd552f4d@mellanox.com>
 <20190822161813.GI29433@mtr-leonro.mtl.com>
 <20190822165247.GB8325@mellanox.com>
 <88435e1e-676b-f948-1c34-22cd471af4c9@mellanox.com>
 <20190909102949.GF6601@unreal>
 <4caab234-7f8f-781c-68c6-672f961d9fd9@mellanox.com>
 <20190909112634.GG6601@unreal>
 <b606a8c3-0e98-dc08-8bae-9d430c9755fe@mellanox.com>
In-Reply-To: <b606a8c3-0e98-dc08-8bae-9d430c9755fe@mellanox.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: PR2PR09CA0009.eurprd09.prod.outlook.com
 (2603:10a6:101:16::21) To AM4PR05MB3137.eurprd05.prod.outlook.com
 (2603:10a6:205:8::27)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonro@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [148.69.85.38]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8d63bf26-a605-43d2-ac89-08d7351a2e11
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM4PR05MB3188;
x-ms-traffictypediagnostic: AM4PR05MB3188:|AM4PR05MB3188:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM4PR05MB31889363CC65E79A7FAEA975B0B70@AM4PR05MB3188.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 01559F388D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(4636009)(346002)(366004)(136003)(376002)(396003)(39860400002)(189003)(199004)(446003)(4326008)(14444005)(256004)(8676002)(5660300002)(476003)(6862004)(2906002)(11346002)(52116002)(1076003)(6512007)(9686003)(66946007)(66476007)(6246003)(486006)(6436002)(25786009)(71200400001)(66446008)(66556008)(64756008)(8936002)(71190400001)(81166006)(81156014)(53936002)(186003)(54906003)(86362001)(76176011)(66066001)(478600001)(99286004)(33656002)(316002)(386003)(26005)(6636002)(53546011)(102836004)(33716001)(6116002)(229853002)(305945005)(6486002)(3846002)(14454004)(7736002)(6506007);DIR:OUT;SFP:1101;SCL:1;SRVR:AM4PR05MB3188;H:AM4PR05MB3137.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: NaRN6bB5UYaWDF1dEEW/cGqH+WU9Cwld+ENsGvX8vMpW7J8kDqNOnzaioGqQ/7IR5T0/9esVBwYK24dfyZdivMJUSGm21k7Yk54BGYIcT0IEcxKpr0kheUGss6mkXY5guKk2UwHTzWXAOlbXys/3jEHZCYUMW/JMHF2jIYR5gO99nGL4cfemP1IRdctkXeglD0kA9aeeZbYLpklOk7aTGSPSUMHvjvayqORpvfxhfeIq+kOk2N/6cH/3e2IbmdUS1jmnaYHNmi9mp2Cky/P2KfBWMpgt5iUOBlHgaylTcsaHIGgNgfYWAX/hCaeaQnc3G0KrPTt/Zj3OO87xQn6xgs7psrEq9J5uZS8JWiZqbhYufCG9kaRNoBDFwcjC5G6okpWTPugg515soLUSjWlI3hbKxfg0xviig34hWceLi3Y=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0AB03A6D2DBDBB43824B4F0DC82C3F30@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d63bf26-a605-43d2-ac89-08d7351a2e11
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2019 11:38:05.5965
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5CyS+h4XV7DSss2CA9HMdgg5IVPDK4BsAO+SSm2VhKkhiDZ1fHMB0cGqY0nSw1nc5nPQdTB3E/dgy91nYidM+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR05MB3188
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

T24gTW9uLCBTZXAgMDksIDIwMTkgYXQgMTE6MzA6MDdBTSArMDAwMCwgTm9hIE9zaGVyb3ZpY2gg
d3JvdGU6DQo+DQo+IE9uIDkvOS8yMDE5IDI6MjYgUE0sIExlb24gUm9tYW5vdnNreSB3cm90ZToN
Cj4gPiBPbiBNb24sIFNlcCAwOSwgMjAxOSBhdCAxMDozOTo0NEFNICswMDAwLCBOb2EgT3NoZXJv
dmljaCB3cm90ZToNCj4gPj4gT24gOS85LzIwMTkgMToyOSBQTSwgTGVvbiBSb21hbm92c2t5IHdy
b3RlOg0KPiA+Pj4gT24gU3VuLCBTZXAgMDEsIDIwMTkgYXQgMDE6MzA6NTZQTSArMDAwMCwgTm9h
IE9zaGVyb3ZpY2ggd3JvdGU6DQo+ID4+Pj4gT24gOC8yMi8yMDE5IDc6NTIgUE0sIEphc29uIEd1
bnRob3JwZSB3cm90ZToNCj4gPj4+Pg0KPiA+Pj4+PiBPbiBUaHUsIEF1ZyAyMiwgMjAxOSBhdCAw
MToxODoyNFBNIC0wMzAwLCBMZW9uIFJvbWFub3Zza3kgd3JvdGU6DQo+ID4+Pj4+PiBPbiBUdWUs
IEF1ZyAyMCwgMjAxOSBhdCAwMTowMDo0N1BNICswMDAwLCBOb2EgT3NoZXJvdmljaCB3cm90ZToN
Cj4gPj4+Pj4+PiBPbiA4LzE5LzIwMTkgNDo1MCBQTSwgSmFzb24gR3VudGhvcnBlIHdyb3RlOg0K
PiA+Pj4+Pj4+DQo+ID4+Pj4+Pj4+IEknZCBwcmVmZXIgcnVuX3Rlc3RzIHRvIGJlIGluIHRoZSB0
ZXN0cyBkaXJlY3RvcnkuLg0KPiA+Pj4+Pj4+Pg0KPiA+Pj4+Pj4+PiBKYXNvbg0KPiA+Pj4+Pj4+
IFBSIHdhcyB1cGRhdGVkDQo+ID4+Pj4+PiAxLg0KPiA+Pj4+Pj4gSU1ITywgcnVuX3Rlc3RzLnB5
IHNob3VsZCBiZSBwbGFjZWQgaW5zaWRlIHRlc3RzIGRpcmVjdG9yeSB0b28gYW5kIG5vdA0KPiA+
Pj4+Pj4gb25seSBpbnN0YWxsZWQgaW50byB0ZXN0cy8uDQo+ID4+Pj4+IFllcywgdGhpcyBpcyB3
aGF0IEkgbWVudC4gVGhlIGZpbGUgc2hvdWxkIGJlIGluIHRlc3RzLyBhbmQgaXQgc2hvdWxkDQo+
ID4+Pj4+IGJlIGJ1aWx0IGludG8gYnVpbGQvYmluLCBhbmQgaW5zdGFsbGVkIGludG8gdGhlIGV4
YW1wbGVzDQo+ID4+Pj4+PiAyLg0KPiA+Pj4+Pj4gRXhlY3V0aW9uIG9mIHJ1bl90ZXN0cy5weSBw
cm9kdWNlcyBhIGxvdCBvZiB1bnRyYWNrZWQgZmlsZWQNCj4gPj4+Pj4+IOKenCAgcmRtYS1jb3Jl
IGdpdDoobm9hb3MtcHItdGVzdHMpIOKclyBnaXQgc3QNCj4gPj4+Pj4+IE9uIGJyYW5jaCBub2Fv
cy1wci10ZXN0cw0KPiA+Pj4+Pj4gVW50cmFja2VkIGZpbGVzOg0KPiA+Pj4+Pj4gICAodXNlICJn
aXQgYWRkIDxmaWxlPi4uLiIgdG8gaW5jbHVkZSBpbiB3aGF0IHdpbGwgYmUgY29tbWl0dGVkKQ0K
PiA+Pj4+Pj4NCj4gPj4+Pj4+IAlweXZlcmJzL19faW5pdF9fLnB5Yw0KPiA+Pj4+Pj4gCXB5dmVy
YnMvcHl2ZXJic19lcnJvci5weWMNCj4gPj4+Pj4+IAl0ZXN0cy9fX2luaXRfXy5weWMNCj4gPj4+
Pj4+IAl0ZXN0cy9iYXNlLnB5Yw0KPiA+Pj4+Pj4gCXRlc3RzL3Rlc3RfYWRkci5weWMNCj4gPj4+
Pj4+IAl0ZXN0cy90ZXN0X2NxLnB5Yw0KPiA+Pj4+Pj4gCXRlc3RzL3Rlc3RfZGV2aWNlLnB5Yw0K
PiA+Pj4+Pj4gCXRlc3RzL3Rlc3RfbXIucHljDQo+ID4+Pj4+PiAJdGVzdHMvdGVzdF9vZHAucHlj
DQo+ID4+Pj4+PiAJdGVzdHMvdGVzdF9wZC5weWMNCj4gPj4+Pj4+IAl0ZXN0cy90ZXN0X3FwLnB5
Yw0KPiA+Pj4+PiAqLnB5YyB3aWxsIGhhdmUgdG8gYmUgYWRkZWQgdG8gdGhlIC5naXRpZ25vcmUN
Cj4gPj4+Pj4+IDMuIHJ1bl90ZXN0cy5weSBsYWNrcyBvZiBweXRob24zIHNoZWJhbmcNCj4gPj4+
Pj4gT3JpZ2luYWxseSBpdCB3YXMgbm90IGluc3RhbGxlZCwgc28gdGhpcyB3YXMgZmluZSwgYXMg
dGhlIGJ1aWxkL2Jpbg0KPiA+Pj4+PiBzY3JpcHQgZG9lcyBhbGwgdGhlIHJlcXVpcmVkIHNldHVw
LCBob3dldmVyIG5vdyB0aGF0IGl0IGlzIHRvIGJlDQo+ID4+Pj4+IGluc3RhbGxlZCBpdCBzaG91
bGQgaGF2ZSB0aGUgIyEgLSBhbmQgaXQgc2hvdWxkIGFsc28gd29yayB3aXRob3V0IGFueQ0KPiA+
Pj4+PiB0cm91YmxlIGZyb20gaXQncyBleGFtcGxlIGxvY2F0aW9uLg0KPiA+Pj4+Pg0KPiA+Pj4+
PiBKYXNvbg0KPiA+Pj4+IFBSIHdhcyB1cGRhdGVkLg0KPiA+Pj4gSSB0cmllZCBpdCBub3cgYW5k
IGdvdCB2ZXJ5IGNvbmZ1c2luZyByZXN1bHRzLg0KPiA+Pj4NCj4gPj4+IE9uIG15IG1hY2hpbmUg
dGhlcmUgYXJlIG5vIGliX2RldmljZXMsIGFuZCBJIGV4cGVjdGVkIHRvIHNlZSBBTEwgdGVzdHMN
Cj4gPj4+IG1hcmtlZCBhcyBza2lwcGVkLCBidXQgZ290IHR3byBza2lwcGVkIG9ubHksIGlzIGl0
IGV4cGVjdGVkIGJlaGF2aW91cj8NCj4gPj4gWWVzLiBJZiB5b3UgcmVjYWxsLCBvdXIgcHJldmlv
dXMgdW5pdHRlc3RzIHdvcmtlZCBkaWZmZXJlbnRseSB0aGFuIHRoZSBuZXcgb25lczsgZWFjaA0K
PiA+PiB0ZXN0IHdvdWxkIGl0ZXJhdGUgb3ZlciBhbiBhcnJheSBvZiBhbGwgYXZhaWxhYmxlIGRl
dmljZXMgYW5kIHdvdWxkIHJ1biBvbiBlYWNoIGRldmljZS4NCj4gPj4gVGhlIGFycmF5IGNhbiBi
ZSBvZiBsZW5ndGggMC4gSWYgbm8gZmFpbHVyZSB3YXMgZm91bmQsIHRoZXkncmUgbWFya2VkIGFz
IHBhc3NlZC4NCj4gPj4gVGhlIG5ldyB0ZXN0cyBza2lwICh0aGUgcmVwb3J0ZWQgJ3MnIHlvdSBz
YXcpIGluIGNhc2UgYSBjb21iaW5hdGlvbiBvZiBkZXZpY2UvcG9ydC9HSUQNCj4gPj4gaW5kZXgg
d2Fzbid0IGZvdW5kLg0KPiA+IGFycmF5IGxlbmd0aCAwIHNob3VsZCByZXR1cm4gInNraXBwZWQi
IGFuZCBub3QgInBhc3NlZCIuDQo+ID4NCj4gPiBUaGFua3MNCj4NCj4gTGVvbiwgdGhlc2UgYXJl
IG9sZGVyIHRlc3RzLCBub3QgcmVsYXRlZCB0byB0aGUgY3VycmVudCBQUi4NCj4gSSBjYW4gdXBk
YXRlIHRoZWlyIGJlaGF2aW9yLCBidXQgbGV0J3Mgc2VwYXJhdGUgaXQgZnJvbSB0aGUgUFIuDQoN
CkdyZWF0LCBwbGVhc2UgdXBkYXRlLg0KDQpUaGFua3MNCg0KPg0KPiBUaGFua3MsDQo+IE5vYQ0K
Pg0KPiA+PiBUaGFua3MsDQo+ID4+IE5vYQ0KPiA+Pg0KPiA+Pj4gXyAgcmRtYS1jb3JlIGdpdDoo
bm9hb3MtcHItdGVzdHMpIC4vYnVpbGQvYmluL3J1bl90ZXN0cy5weQ0KPiA+Pj4gLi4uLi4uLi4u
Li4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uc3MuLi4uLi4uLi4uLi4uLi4NCj4gPj4+
IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0NCj4gPj4+IFJhbiA1OSB0ZXN0cyBpbiAwLjAwNHMNCj4gPj4+DQo+ID4+
PiBPSyAoc2tpcHBlZD0yKQ0KPiA+Pj4NCj4gPj4+IFRoYW5rcw0KPiA+Pj4NCj4gPj4+PiBUaGFu
a3MsDQo+ID4+Pj4NCj4gPj4+PiBOb2ENCj4gPj4+Pg0K
