Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D87663561
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Jul 2019 14:06:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725989AbfGIMGO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 9 Jul 2019 08:06:14 -0400
Received: from mail-eopbgr00074.outbound.protection.outlook.com ([40.107.0.74]:24900
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726010AbfGIMGO (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 9 Jul 2019 08:06:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lYpMn9zMVNKjcRUvFBYXHqNsnyS6OvVilverloQc1T0=;
 b=otrU3XAYGB9sgVJ8m/446iOx6CxWj0sY3nwKRUZBv3Ytm0JLTsEZLyLoWb4QryfnyWg/VyOyQ/wvMfcMls6Fr7kyQnLP8vBDl3Qr6tj0CeIxcn66xwjRRH0DQnjPvIWXAIKAGBbj1H0CQiVWHHmeg9nkqfPimPLmz52WGhsb1HE=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB4718.eurprd05.prod.outlook.com (20.176.4.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.18; Tue, 9 Jul 2019 12:06:09 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::f5d8:df9:731:682e]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::f5d8:df9:731:682e%5]) with mapi id 15.20.2052.020; Tue, 9 Jul 2019
 12:06:09 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Jinpu Wang <jinpuwang@gmail.com>
CC:     Leon Romanovsky <leon@kernel.org>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "dledford@redhat.com" <dledford@redhat.com>,
        Roman Pen <r.peniaev@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jinpu Wang <jinpu.wang@cloud.ionos.com>
Subject: Re: [PATCH v4 00/25] InfiniBand Transport (IBTRS) and Network Block
 Device (IBNBD)
Thread-Topic: [PATCH v4 00/25] InfiniBand Transport (IBTRS) and Network Block
 Device (IBNBD)
Thread-Index: AQHVJ3lZV9PpgZHYIUmJKGJeUubTI6bCKc+AgAASUACAAApagIAAB/MA
Date:   Tue, 9 Jul 2019 12:06:09 +0000
Message-ID: <20190709120606.GB3436@mellanox.com>
References: <20190620150337.7847-1-jinpuwang@gmail.com>
 <CAHg0HuzUaKs-ACHah-VdNHbot0_usx4ErMesVAw8+DFR63FFqw@mail.gmail.com>
 <20190709110036.GQ7034@mtr-leonro.mtl.com>
 <CAD9gYJL=fo4Oa2hmU4WZgQrzypRbzoPrrFjNQKP2EZFXYxYNCA@mail.gmail.com>
In-Reply-To: <CAD9gYJL=fo4Oa2hmU4WZgQrzypRbzoPrrFjNQKP2EZFXYxYNCA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MN2PR13CA0025.namprd13.prod.outlook.com
 (2603:10b6:208:160::38) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [156.34.55.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4d8b72c4-5174-4044-483c-08d70465d44f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR05MB4718;
x-ms-traffictypediagnostic: VI1PR05MB4718:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <VI1PR05MB47189E55B6A7133104631C71CFF10@VI1PR05MB4718.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-forefront-prvs: 0093C80C01
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(366004)(396003)(346002)(136003)(39860400002)(189003)(199004)(71200400001)(64756008)(66556008)(14444005)(33656002)(66476007)(66446008)(71190400001)(66946007)(73956011)(36756003)(66066001)(86362001)(81156014)(6512007)(1411001)(6306002)(6916009)(1076003)(386003)(7416002)(6486002)(3846002)(446003)(478600001)(486006)(305945005)(11346002)(966005)(6116002)(68736007)(6436002)(53936002)(476003)(2616005)(8936002)(81166006)(25786009)(229853002)(8676002)(102836004)(14454004)(6506007)(4326008)(54906003)(26005)(5660300002)(2906002)(256004)(76176011)(99286004)(52116002)(7736002)(316002)(6246003)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB4718;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 8Avz5cD+K2J4MQiiD96aBA8vST6L5tRs0Zfiu0AD1I7vrlCZuEhoBkD6BUAzccpsvLdmrf4QsPkZ/c9WrZE0mbXEynw61sXI65l2rhUJm3rDLfvQ6Xv7qljcQZsuKTUoT2D9euRLWAgCbCPX2OOscr2pBpOJn3guGqGMVCT4+9d29OEF/YFuZ6sIjhSaaMNQrxZMCwb7sjt56LG7aFsKlgYYcgANSOlyHplv/q2njBDOAXSgvxRJ0r2TwnMeQLIbQvUDYvvegrkpa066FDR2G7/VO5bY2uA9CPU4aWnR1UrjyEX75bS6S/t5Evp+aYC/dMwlZgDd9H/7Tx+CCESqSfskvM3ZoDdifYU9VD8TsZPT/t9wZLyfDotNMHA7+PmKvTIJu+grUPe/vR6yEKvtatViSEodGTZjpahlcpMg1Co=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2762FE148836FA4FAF36EEEBF5B835A7@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d8b72c4-5174-4044-483c-08d70465d44f
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2019 12:06:09.7787
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jgg@mellanox.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB4718
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

T24gVHVlLCBKdWwgMDksIDIwMTkgYXQgMDE6Mzc6MzlQTSArMDIwMCwgSmlucHUgV2FuZyB3cm90
ZToNCj4gTGVvbiBSb21hbm92c2t5IDxsZW9uQGtlcm5lbC5vcmc+IOS6jjIwMTnlubQ35pyIOeaX
peWRqOS6jCDkuIvljYgxOjAw5YaZ6YGT77yaDQo+ID4NCj4gPiBPbiBUdWUsIEp1bCAwOSwgMjAx
OSBhdCAxMTo1NTowM0FNICswMjAwLCBEYW5pbCBLaXBuaXMgd3JvdGU6DQo+ID4gPiBIYWxsbyBE
b3VnLCBIYWxsbyBKYXNvbiwgSGFsbG8gSmVucywgSGFsbG8gR3JlZywNCj4gPiA+DQo+ID4gPiBD
b3VsZCB5b3UgcGxlYXNlIHByb3ZpZGUgc29tZSBmZWVkYmFjayB0byB0aGUgSUJOQkQgZHJpdmVy
IGFuZCB0aGUNCj4gPiA+IElCVFJTIGxpYnJhcnk/DQo+ID4gPiBTbyBmYXIgd2UgYWRkcmVzc2Vk
IGFsbCB0aGUgcmVxdWVzdHMgcHJvdmlkZWQgYnkgdGhlIGNvbW11bml0eSBhbmQNCj4gPiA+IGNv
bnRpbnVlIHRvIG1haW50YWluIG91ciBjb2RlIHVwLXRvLWRhdGUgd2l0aCB0aGUgdXBzdHJlYW0g
a2VybmVsDQo+ID4gPiB3aGlsZSBoYXZpbmcgYW4gZXh0cmEgY29tcGF0aWJpbGl0eSBsYXllciBm
b3Igb2xkZXIga2VybmVscyBpbiBvdXINCj4gPiA+IG91dC1vZi10cmVlIHJlcG9zaXRvcnkuDQo+
ID4gPiBJIHVuZGVyc3RhbmQgdGhhdCBTUlAgYW5kIE5WTUVvRiB3aGljaCBhcmUgaW4gdGhlIGtl
cm5lbCBhbHJlYWR5IGRvDQo+ID4gPiBwcm92aWRlIGVxdWl2YWxlbnQgZnVuY3Rpb25hbGl0eSBm
b3IgdGhlIG1ham9yaXR5IG9mIHRoZSB1c2UgY2FzZXMuDQo+ID4gPiBJQk5CRCBvbiB0aGUgb3Ro
ZXIgaGFuZCBpcyBzaG93aW5nIGhpZ2hlciBwZXJmb3JtYW5jZSBhbmQgbW9yZQ0KPiA+ID4gaW1w
b3J0YW50bHkgaW5jbHVkZXMgdGhlIElCVFJTIC0gYSBnZW5lcmFsIHB1cnBvc2UgbGlicmFyeSB0
bw0KPiA+ID4gZXN0YWJsaXNoIGNvbm5lY3Rpb25zIGFuZCB0cmFuc3BvcnQgQklPLWxpa2UgcmVh
ZC93cml0ZSBzZy1saXN0cyBvdmVyDQo+ID4gPiBSRE1BLCB3aGlsZSBTUlAgaXMgdGFyZ2V0aW5n
IFNDU0kgYW5kIE5WTUVvRiBpcyBhZGRyZXNzaW5nIE5WTUUuIFdoaWxlDQo+ID4gPiBJIGJlbGll
dmUgSUJOQkQgZG9lcyBtZWV0IHRoZSBrZXJuZWwgY29kaW5nIHN0YW5kYXJkcywgaXQgZG9lc24n
dCBoYXZlDQo+ID4gPiBhIGxvdCBvZiB1c2Vycywgd2hpbGUgU1JQIGFuZCBOVk1Fb0YgYXJlIHdp
ZGVseSBhY2NlcHRlZC4gRG8geW91IHRoaW5rDQo+ID4gPiBpdCB3b3VsZCBtYWtlIHNlbnNlIGZv
ciB1cyB0byByZXdvcmsgb3VyIHBhdGNoc2V0IGFuZCB0cnkgcHVzaGluZyBpdA0KPiA+ID4gZm9y
IHN0YWdpbmcgdHJlZSBmaXJzdCwgc28gdGhhdCB3ZSBjYW4gcHJvb2YgSUJOQkQgaXMgd2VsbCBt
YWludGFpbmVkLA0KPiA+ID4gYmVuZWZpY2lhbCBmb3IgdGhlIGVjby1zeXN0ZW0sIGZpbmQgYSBw
cm9wZXIgbG9jYXRpb24gZm9yIGl0IHdpdGhpbg0KPiA+ID4gYmxvY2svcmRtYSBzdWJzeXN0ZW1z
PyBUaGlzIHdvdWxkIG1ha2UgaXQgZWFzaWVyIGZvciBwZW9wbGUgdG8gdHJ5IGl0DQo+ID4gPiBv
dXQgYW5kIHdvdWxkIGFsc28gYmUgYSBodWdlIHN0ZXAgZm9yIHVzIGluIHRlcm1zIG9mIG1haW50
ZW5hbmNlDQo+ID4gPiBlZmZvcnQuDQo+ID4gPiBUaGUgbmFtZXMgSUJOQkQgYW5kIElCVFJTIGFy
ZSBpbiBmYWN0IG1pc2xlYWRpbmcuIElCVFJTIHNpdHMgb24gdG9wIG9mDQo+ID4gPiBSRE1BIGFu
ZCBpcyBub3QgYm91bmQgdG8gSUIgKFdlIHdpbGwgZXZhbHVhdGUgSUJUUlMgd2l0aCBST0NFIGlu
IHRoZQ0KPiA+ID4gbmVhciBmdXR1cmUpLiBEbyB5b3UgdGhpbmsgaXQgd291bGQgbWFrZSBzZW5z
ZSB0byByZW5hbWUgdGhlIGRyaXZlciB0bw0KPiA+ID4gUk5CRC9SVFJTPw0KPiA+DQo+ID4gSXQg
aXMgYmV0dGVyIHRvIGF2b2lkICJzdGFnaW5nIiB0cmVlLCBiZWNhdXNlIGl0IHdpbGwgbGFjayBh
dHRlbnRpb24gb2YNCj4gPiByZWxldmFudCBwZW9wbGUgYW5kIHlvdXIgZWZmb3J0cyB3aWxsIGJl
IGxvc3Qgb25jZSB5b3Ugd2lsbCB0cnkgdG8gbW92ZQ0KPiA+IG91dCBvZiBzdGFnaW5nLiBXZSBh
cmUgYWxsIHJlbWVtYmVyaW5nIEx1c3RyZSBhbmQgZG9uJ3Qgd2FudCB0byBzZWUgaXQNCj4gPiBh
Z2Fpbi4NCj4gPg0KPiA+IEJhY2sgdGhlbiwgeW91IHdhcyBhc2tlZCB0byBwcm92aWRlIHN1cHBv
cnQgZm9yIHBlcmZvcm1hbmNlIHN1cGVyaW9yaXR5Lg0KPiA+IENhbiB5b3UgcGxlYXNlIHNoYXJl
IGFueSBudW1iZXJzIHdpdGggdXM/DQo+IEhpIExlb24sDQo+IA0KPiBUaGFua3MgZm9yIHlvdSBm
ZWVkYmFjay4NCj4gDQo+IEZvciBwZXJmb3JtYW5jZSBudW1iZXJzLCAgRGFuaWwgZGlkIGludGVu
c2l2ZSBiZW5jaG1hcmssIGFuZCBjcmVhdGUNCj4gc29tZSBQREYgd2l0aCBncmFwaGVzIGhlcmU6
DQo+IGh0dHBzOi8vZ2l0aHViLmNvbS9pb25vcy1lbnRlcnByaXNlL2libmJkL3RyZWUvbWFzdGVy
L3BlcmZvcm1hbmNlL3Y0LXY1LjItcmMzDQo+IA0KPiBJdCBpbmNsdWRlcyBib3RoIHNpbmdsZSBw
YXRoIHJlc3VsdHMgYWxzbyBkaWZmZXJlbnQgbXVsdGlwYXRoIHBvbGljeSByZXN1bHRzLg0KPiAN
Cj4gSWYgeW91IGhhdmUgYW55IHF1ZXN0aW9uIHJlZ2FyZGluZyB0aGUgcmVzdWx0cywgcGxlYXNl
IGxldCB1cyBrbm93Lg0KDQpJIGtpbmQgb2YgcmVjYWxsIHRoYXQgbGFzdCB0aW1lIHRoZSBwZXJm
IG51bWJlcnMgd2VyZSBza2V3ZWQgdG93YXJkDQpJQk5CRCBiZWNhdXNlIHRoZSBpbnZhbGlkYXRp
b24gbW9kZWwgZm9yIE1SIHdhcyB3cm9uZyAtIGRpZCB0aGlzIGdldA0KZml4ZWQ/DQoNCkphc29u
DQo=
