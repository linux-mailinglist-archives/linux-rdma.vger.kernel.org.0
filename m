Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F100636AC
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Jul 2019 15:19:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727013AbfGINTm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 9 Jul 2019 09:19:42 -0400
Received: from mail-eopbgr30045.outbound.protection.outlook.com ([40.107.3.45]:33155
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726047AbfGINTl (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 9 Jul 2019 09:19:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GSJBUsjNvMyCjPgGyAhQyRqJxFuezyYgbtS3fN5XY/Q=;
 b=lc6XPrxz9kJ/B4T0YnT9DlmUAi8ZNgybnsL1N7weDH2aKyap7bnOyzP0C5FYhJL9EYkcBeVUhNO3QwTjn5Yr8nxPGSQI92S7PHRROx9slqf6Xe8XMhWGSebY5r8fTYVcLcLcaCeDfaFtVZlQtIJGINiaxGl74ItzU21SsTF95pM=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB4829.eurprd05.prod.outlook.com (20.177.50.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.18; Tue, 9 Jul 2019 13:19:37 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::f5d8:df9:731:682e]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::f5d8:df9:731:682e%5]) with mapi id 15.20.2052.020; Tue, 9 Jul 2019
 13:19:37 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Jinpu Wang <jinpu.wang@cloud.ionos.com>
CC:     Jinpu Wang <jinpuwang@gmail.com>,
        Leon Romanovsky <leon@kernel.org>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "dledford@redhat.com" <dledford@redhat.com>,
        Roman Pen <r.peniaev@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v4 00/25] InfiniBand Transport (IBTRS) and Network Block
 Device (IBNBD)
Thread-Topic: [PATCH v4 00/25] InfiniBand Transport (IBTRS) and Network Block
 Device (IBNBD)
Thread-Index: AQHVJ3lZV9PpgZHYIUmJKGJeUubTI6bCKc+AgAASUACAAApagIAAB/MAgAATdwCAAAEOAA==
Date:   Tue, 9 Jul 2019 13:19:37 +0000
Message-ID: <20190709131932.GI3436@mellanox.com>
References: <20190620150337.7847-1-jinpuwang@gmail.com>
 <CAHg0HuzUaKs-ACHah-VdNHbot0_usx4ErMesVAw8+DFR63FFqw@mail.gmail.com>
 <20190709110036.GQ7034@mtr-leonro.mtl.com>
 <CAD9gYJL=fo4Oa2hmU4WZgQrzypRbzoPrrFjNQKP2EZFXYxYNCA@mail.gmail.com>
 <20190709120606.GB3436@mellanox.com>
 <CAMGffE=T+FVfVzV5cCtVrm_6ikdJ9pjpFsPgx+t0EUpegoZELQ@mail.gmail.com>
In-Reply-To: <CAMGffE=T+FVfVzV5cCtVrm_6ikdJ9pjpFsPgx+t0EUpegoZELQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BL0PR1501CA0011.namprd15.prod.outlook.com
 (2603:10b6:207:17::24) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [156.34.55.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: da14c60e-188e-4d28-32ea-08d704701782
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR05MB4829;
x-ms-traffictypediagnostic: VI1PR05MB4829:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <VI1PR05MB48297780C1D24A6DCBF36EA9CFF10@VI1PR05MB4829.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 0093C80C01
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(136003)(396003)(39860400002)(366004)(189003)(199004)(81166006)(14444005)(8676002)(54906003)(14454004)(229853002)(4326008)(102836004)(6436002)(446003)(11346002)(305945005)(2616005)(966005)(478600001)(25786009)(81156014)(6486002)(316002)(3846002)(6116002)(8936002)(68736007)(53936002)(7736002)(99286004)(386003)(76176011)(6246003)(486006)(53546011)(476003)(256004)(52116002)(6506007)(2906002)(26005)(36756003)(86362001)(33656002)(73956011)(66946007)(66476007)(66556008)(64756008)(66446008)(71190400001)(71200400001)(6916009)(7416002)(1076003)(6306002)(186003)(5660300002)(66066001)(6512007);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB4829;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ReeXtiynSSchcLY8dZzrpJNkvM3vI+qPoUG6thtxNXbh5AENXfpjE5uR29eO/jVOBotqXjLzKxMv+ItttZyvHXlbyEYBD0t4af/L/S5/w0H/RMNsCnKcSqVFP7hPRZ+qhKTN5V22Y6bW1GmqA8gUQV7+FnapnL3x1eGQvuBAljcjqsExC9JVllVoT257V1StHtKC7Tl64ZrALX4VGVyBZyfi5IeKBd+BDutSY9vF9a5TgQUDP/6Lnzhhq3a7neQssCvvYG0WD3LZUY0/SVZZJaLHxIz6y0LmqimnYiQcRkTf5ktcduYtGXW26ij/ipLRhD9dOmK7/8aIxKEM/gCa8xPWvCTXZxiAYrpe6iG0Ux4GsfLm1FHi8oPkYDONpcnIbMLZD7VUZgzEM/U/XPWUm4SW4TZP8YBDP9zHwjT+Qy8=
Content-Type: text/plain; charset="utf-8"
Content-ID: <760810B1D4E96444886A9E44C7BA22EB@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da14c60e-188e-4d28-32ea-08d704701782
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2019 13:19:37.5700
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jgg@mellanox.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB4829
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

T24gVHVlLCBKdWwgMDksIDIwMTkgYXQgMDM6MTU6NDZQTSArMDIwMCwgSmlucHUgV2FuZyB3cm90
ZToNCj4gT24gVHVlLCBKdWwgOSwgMjAxOSBhdCAyOjA2IFBNIEphc29uIEd1bnRob3JwZSA8amdn
QG1lbGxhbm94LmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBPbiBUdWUsIEp1bCAwOSwgMjAxOSBhdCAw
MTozNzozOVBNICswMjAwLCBKaW5wdSBXYW5nIHdyb3RlOg0KPiA+ID4gTGVvbiBSb21hbm92c2t5
IDxsZW9uQGtlcm5lbC5vcmc+IOS6jjIwMTnlubQ35pyIOeaXpeWRqOS6jCDkuIvljYgxOjAw5YaZ
6YGT77yaDQo+ID4gPiA+DQo+ID4gPiA+IE9uIFR1ZSwgSnVsIDA5LCAyMDE5IGF0IDExOjU1OjAz
QU0gKzAyMDAsIERhbmlsIEtpcG5pcyB3cm90ZToNCj4gPiA+ID4gPiBIYWxsbyBEb3VnLCBIYWxs
byBKYXNvbiwgSGFsbG8gSmVucywgSGFsbG8gR3JlZywNCj4gPiA+ID4gPg0KPiA+ID4gPiA+IENv
dWxkIHlvdSBwbGVhc2UgcHJvdmlkZSBzb21lIGZlZWRiYWNrIHRvIHRoZSBJQk5CRCBkcml2ZXIg
YW5kIHRoZQ0KPiA+ID4gPiA+IElCVFJTIGxpYnJhcnk/DQo+ID4gPiA+ID4gU28gZmFyIHdlIGFk
ZHJlc3NlZCBhbGwgdGhlIHJlcXVlc3RzIHByb3ZpZGVkIGJ5IHRoZSBjb21tdW5pdHkgYW5kDQo+
ID4gPiA+ID4gY29udGludWUgdG8gbWFpbnRhaW4gb3VyIGNvZGUgdXAtdG8tZGF0ZSB3aXRoIHRo
ZSB1cHN0cmVhbSBrZXJuZWwNCj4gPiA+ID4gPiB3aGlsZSBoYXZpbmcgYW4gZXh0cmEgY29tcGF0
aWJpbGl0eSBsYXllciBmb3Igb2xkZXIga2VybmVscyBpbiBvdXINCj4gPiA+ID4gPiBvdXQtb2Yt
dHJlZSByZXBvc2l0b3J5Lg0KPiA+ID4gPiA+IEkgdW5kZXJzdGFuZCB0aGF0IFNSUCBhbmQgTlZN
RW9GIHdoaWNoIGFyZSBpbiB0aGUga2VybmVsIGFscmVhZHkgZG8NCj4gPiA+ID4gPiBwcm92aWRl
IGVxdWl2YWxlbnQgZnVuY3Rpb25hbGl0eSBmb3IgdGhlIG1ham9yaXR5IG9mIHRoZSB1c2UgY2Fz
ZXMuDQo+ID4gPiA+ID4gSUJOQkQgb24gdGhlIG90aGVyIGhhbmQgaXMgc2hvd2luZyBoaWdoZXIg
cGVyZm9ybWFuY2UgYW5kIG1vcmUNCj4gPiA+ID4gPiBpbXBvcnRhbnRseSBpbmNsdWRlcyB0aGUg
SUJUUlMgLSBhIGdlbmVyYWwgcHVycG9zZSBsaWJyYXJ5IHRvDQo+ID4gPiA+ID4gZXN0YWJsaXNo
IGNvbm5lY3Rpb25zIGFuZCB0cmFuc3BvcnQgQklPLWxpa2UgcmVhZC93cml0ZSBzZy1saXN0cyBv
dmVyDQo+ID4gPiA+ID4gUkRNQSwgd2hpbGUgU1JQIGlzIHRhcmdldGluZyBTQ1NJIGFuZCBOVk1F
b0YgaXMgYWRkcmVzc2luZyBOVk1FLiBXaGlsZQ0KPiA+ID4gPiA+IEkgYmVsaWV2ZSBJQk5CRCBk
b2VzIG1lZXQgdGhlIGtlcm5lbCBjb2Rpbmcgc3RhbmRhcmRzLCBpdCBkb2Vzbid0IGhhdmUNCj4g
PiA+ID4gPiBhIGxvdCBvZiB1c2Vycywgd2hpbGUgU1JQIGFuZCBOVk1Fb0YgYXJlIHdpZGVseSBh
Y2NlcHRlZC4gRG8geW91IHRoaW5rDQo+ID4gPiA+ID4gaXQgd291bGQgbWFrZSBzZW5zZSBmb3Ig
dXMgdG8gcmV3b3JrIG91ciBwYXRjaHNldCBhbmQgdHJ5IHB1c2hpbmcgaXQNCj4gPiA+ID4gPiBm
b3Igc3RhZ2luZyB0cmVlIGZpcnN0LCBzbyB0aGF0IHdlIGNhbiBwcm9vZiBJQk5CRCBpcyB3ZWxs
IG1haW50YWluZWQsDQo+ID4gPiA+ID4gYmVuZWZpY2lhbCBmb3IgdGhlIGVjby1zeXN0ZW0sIGZp
bmQgYSBwcm9wZXIgbG9jYXRpb24gZm9yIGl0IHdpdGhpbg0KPiA+ID4gPiA+IGJsb2NrL3JkbWEg
c3Vic3lzdGVtcz8gVGhpcyB3b3VsZCBtYWtlIGl0IGVhc2llciBmb3IgcGVvcGxlIHRvIHRyeSBp
dA0KPiA+ID4gPiA+IG91dCBhbmQgd291bGQgYWxzbyBiZSBhIGh1Z2Ugc3RlcCBmb3IgdXMgaW4g
dGVybXMgb2YgbWFpbnRlbmFuY2UNCj4gPiA+ID4gPiBlZmZvcnQuDQo+ID4gPiA+ID4gVGhlIG5h
bWVzIElCTkJEIGFuZCBJQlRSUyBhcmUgaW4gZmFjdCBtaXNsZWFkaW5nLiBJQlRSUyBzaXRzIG9u
IHRvcCBvZg0KPiA+ID4gPiA+IFJETUEgYW5kIGlzIG5vdCBib3VuZCB0byBJQiAoV2Ugd2lsbCBl
dmFsdWF0ZSBJQlRSUyB3aXRoIFJPQ0UgaW4gdGhlDQo+ID4gPiA+ID4gbmVhciBmdXR1cmUpLiBE
byB5b3UgdGhpbmsgaXQgd291bGQgbWFrZSBzZW5zZSB0byByZW5hbWUgdGhlIGRyaXZlciB0bw0K
PiA+ID4gPiA+IFJOQkQvUlRSUz8NCj4gPiA+ID4NCj4gPiA+ID4gSXQgaXMgYmV0dGVyIHRvIGF2
b2lkICJzdGFnaW5nIiB0cmVlLCBiZWNhdXNlIGl0IHdpbGwgbGFjayBhdHRlbnRpb24gb2YNCj4g
PiA+ID4gcmVsZXZhbnQgcGVvcGxlIGFuZCB5b3VyIGVmZm9ydHMgd2lsbCBiZSBsb3N0IG9uY2Ug
eW91IHdpbGwgdHJ5IHRvIG1vdmUNCj4gPiA+ID4gb3V0IG9mIHN0YWdpbmcuIFdlIGFyZSBhbGwg
cmVtZW1iZXJpbmcgTHVzdHJlIGFuZCBkb24ndCB3YW50IHRvIHNlZSBpdA0KPiA+ID4gPiBhZ2Fp
bi4NCj4gPiA+ID4NCj4gPiA+ID4gQmFjayB0aGVuLCB5b3Ugd2FzIGFza2VkIHRvIHByb3ZpZGUg
c3VwcG9ydCBmb3IgcGVyZm9ybWFuY2Ugc3VwZXJpb3JpdHkuDQo+ID4gPiA+IENhbiB5b3UgcGxl
YXNlIHNoYXJlIGFueSBudW1iZXJzIHdpdGggdXM/DQo+ID4gPiBIaSBMZW9uLA0KPiA+ID4NCj4g
PiA+IFRoYW5rcyBmb3IgeW91IGZlZWRiYWNrLg0KPiA+ID4NCj4gPiA+IEZvciBwZXJmb3JtYW5j
ZSBudW1iZXJzLCAgRGFuaWwgZGlkIGludGVuc2l2ZSBiZW5jaG1hcmssIGFuZCBjcmVhdGUNCj4g
PiA+IHNvbWUgUERGIHdpdGggZ3JhcGhlcyBoZXJlOg0KPiA+ID4gaHR0cHM6Ly9naXRodWIuY29t
L2lvbm9zLWVudGVycHJpc2UvaWJuYmQvdHJlZS9tYXN0ZXIvcGVyZm9ybWFuY2UvdjQtdjUuMi1y
YzMNCj4gPiA+DQo+ID4gPiBJdCBpbmNsdWRlcyBib3RoIHNpbmdsZSBwYXRoIHJlc3VsdHMgYWxz
byBkaWZmZXJlbnQgbXVsdGlwYXRoIHBvbGljeSByZXN1bHRzLg0KPiA+ID4NCj4gPiA+IElmIHlv
dSBoYXZlIGFueSBxdWVzdGlvbiByZWdhcmRpbmcgdGhlIHJlc3VsdHMsIHBsZWFzZSBsZXQgdXMg
a25vdy4NCj4gPg0KPiA+IEkga2luZCBvZiByZWNhbGwgdGhhdCBsYXN0IHRpbWUgdGhlIHBlcmYg
bnVtYmVycyB3ZXJlIHNrZXdlZCB0b3dhcmQNCj4gPiBJQk5CRCBiZWNhdXNlIHRoZSBpbnZhbGlk
YXRpb24gbW9kZWwgZm9yIE1SIHdhcyB3cm9uZyAtIGRpZCB0aGlzIGdldA0KPiA+IGZpeGVkPw0K
PiA+DQo+ID4gSmFzb24NCj4gDQo+IFRoYW5rcyBKYXNvbiBmb3IgZmVlZGJhY2suDQo+IENhbiB5
b3UgYmUgIG1vcmUgc3BlY2lmaWMgYWJvdXQgICJ0aGUgaW52YWxpZGF0aW9uIG1vZGVsIGZvciBN
UiB3YXMgd3JvbmciDQoNCk1SJ3MgbXVzdCBiZSBpbnZhbGlkYXRlZCBiZWZvcmUgZGF0YSBpcyBo
YW5kZWQgb3ZlciB0byB0aGUgYmxvY2sNCmxheWVyLiBJdCBjYW4ndCBsZWF2ZSBNUnMgb3BlbiBm
b3IgYWNjZXNzIGFuZCB0aGVuIHRvdWNoIHRoZSBtZW1vcnkNCnRoZSBNUiBjb3ZlcnMuDQoNCklN
SE8gdGhpcyBpcyB0aGUgbW9zdCBsaWtlbHkgZXhwbGFuYXRpb24gZm9yIGFueSBwZXJmb3JtYW5j
ZSBkaWZmZXJlbmNlDQpmcm9tIG52bWUuLg0KDQo+IEkgY2hlY2tlZCBpbiB0aGUgaGlzdG9yeSBv
ZiB0aGUgZW1haWwgdGhyZWFkLCBvbmx5IGZvdW5kDQo+ICJJIHRoaW5rIGZyb20gdGhlIFJETUEg
c2lkZSwgYmVmb3JlIHdlIGFjY2VwdCBzb21ldGhpbmcgbGlrZSB0aGlzLCBJJ2QNCj4gbGlrZSB0
byBoZWFyIGZyb20gQ2hyaXN0b3BoLCBDaHVjayBvciBTYWdpIHRoYXQgdGhlIGRhdGFwbGFuZQ0K
PiBpbXBsZW1lbnRhdGlvbiBvZiB0aGlzIGlzIGNvcnJlY3QsIGVnIGl0IHVzZXMgdGhlIE1ScyBw
cm9wZXJseSBhbmQNCj4gaW52YWxpZGF0ZXMgYXQgdGhlIHJpZ2h0IHRpbWUsIHNlcXVlbmNlcyB3
aXRoIGRtYV9vcHMgYXMgcmVxdWlyZWQsDQo+IGV0Yy4NCj4gIg0KPiBBbmQgbm8gcmVwbHkgZnJv
bSBhbnkgb2YgeW91IHNpbmNlIHRoZW4uDQoNClRoaXMgdGFzayBzdGlsbCBuZWVkcyB0byBoYXBw
ZW4uLg0KDQpKYXNvbg0K
