Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CBC0C396A4
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Jun 2019 22:18:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729577AbfFGUSM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 7 Jun 2019 16:18:12 -0400
Received: from mail-eopbgr00086.outbound.protection.outlook.com ([40.107.0.86]:2531
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730540AbfFGUSM (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 7 Jun 2019 16:18:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EfOW6MxFlgOP2IoaXppWhgUiV/k9wE03PsaZZ7nif3I=;
 b=bbd/L9PiC/i40SKFjQDeGwLH6jo9ICV8yAJlX9s/3pVdXi8HMw+gGIdcu41F2dki7c1w8Bf8DopHwVIbXR1VsYael17wHsim6r5zxHYCWnd7JXtnCojOTh+ETcdwYxtGr14VxsUkyx+VEn6/JyN91P/mNHiY3KO/oDIBnjVzX7Y=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB3471.eurprd05.prod.outlook.com (10.170.239.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1943.22; Fri, 7 Jun 2019 20:18:07 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::c16d:129:4a40:9ba1]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::c16d:129:4a40:9ba1%6]) with mapi id 15.20.1965.011; Fri, 7 Jun 2019
 20:18:07 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Souptick Joarder <jrdr.linux@gmail.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Jerome Glisse <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>
Subject: Re: [RFC PATCH 10/11] mm/hmm: Poison hmm_range during unregister
Thread-Topic: [RFC PATCH 10/11] mm/hmm: Poison hmm_range during unregister
Thread-Index: AQHVEX0NOAfbT0QZp0y92ZaDTEeOTqaQt+IAgAABWgA=
Date:   Fri, 7 Jun 2019 20:18:06 +0000
Message-ID: <20190607201802.GG14771@mellanox.com>
References: <20190523153436.19102-1-jgg@ziepe.ca>
 <20190523153436.19102-11-jgg@ziepe.ca>
 <CAFqt6zatjZdCzd=cg-kZiajsSwF6Jr+d-rL_vQ9kMtHjcDx8uQ@mail.gmail.com>
In-Reply-To: <CAFqt6zatjZdCzd=cg-kZiajsSwF6Jr+d-rL_vQ9kMtHjcDx8uQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: YT1PR01CA0020.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::33)
 To VI1PR05MB4141.eurprd05.prod.outlook.com (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [156.34.55.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2493f491-ba02-44cc-9bea-08d6eb8540a0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR05MB3471;
x-ms-traffictypediagnostic: VI1PR05MB3471:
x-microsoft-antispam-prvs: <VI1PR05MB347105F508A6FD11177E603DCF100@VI1PR05MB3471.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0061C35778
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(376002)(396003)(39860400002)(346002)(199004)(189003)(6436002)(6246003)(66574012)(53546011)(6506007)(386003)(6486002)(6916009)(52116002)(66066001)(81156014)(7736002)(229853002)(54906003)(6512007)(53936002)(8676002)(186003)(5660300002)(478600001)(68736007)(71200400001)(102836004)(71190400001)(1076003)(76176011)(86362001)(486006)(8936002)(14454004)(4326008)(2906002)(2616005)(36756003)(26005)(3846002)(11346002)(6116002)(25786009)(33656002)(476003)(316002)(66476007)(66946007)(64756008)(66446008)(81166006)(66556008)(73956011)(99286004)(446003)(256004)(14444005)(305945005);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB3471;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: GD2PVITk4L3SF30EZfKuHGdDlHJHCBEx8dQBKF9+NsZx7CXZ4DSPYs2DMYnVnhWX+iu3QehE9FPbdw0ZJ0RxKy4emM1Xmg0YX+CjiUkgBTWuYVaa12xntlXwfBWf7lIDWfs5ctTti63SOShavlsTwN7MgAzkLW+/Pye/3Y92vAxjoBVwC1Xt/dMpdMwD1tVE57M+hDES2J+PF+5DgrmyFununC90UI/mWJQKtTpGIyGIS8aJIAy2M7vSACXIfhyZsUepp0Dqbe2WSOMGv3TwAlgLPT2615D30sWCmL8xmJF47RqRlJtTecNNEEUBsV67MEgnQX/49j6q4q7TLxDquwuBL3Xn18ZLcHQS6b4iTSC+uL1AVMLw2hsvLAfF3mXPHU8q8lHaXAcYWvB40jR33z+vENsBR0v3Wnuac3KCZYA=
Content-Type: text/plain; charset="utf-8"
Content-ID: <222DC9B37D68DD4085C32BEBE19EDA02@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2493f491-ba02-44cc-9bea-08d6eb8540a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2019 20:18:06.9557
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jgg@mellanox.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB3471
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

T24gU2F0LCBKdW4gMDgsIDIwMTkgYXQgMDE6NDM6MTJBTSArMDUzMCwgU291cHRpY2sgSm9hcmRl
ciB3cm90ZToNCj4gT24gVGh1LCBNYXkgMjMsIDIwMTkgYXQgOTowNSBQTSBKYXNvbiBHdW50aG9y
cGUgPGpnZ0B6aWVwZS5jYT4gd3JvdGU6DQo+ID4NCj4gPiBGcm9tOiBKYXNvbiBHdW50aG9ycGUg
PGpnZ0BtZWxsYW5veC5jb20+DQo+ID4NCj4gPiBUcnlpbmcgdG8gbWlzdXNlIGEgcmFuZ2Ugb3V0
c2lkZSBpdHMgbGlmZXRpbWUgaXMgYSBrZXJuZWwgYnVnLiBVc2UgV0FSTl9PTg0KPiA+IGFuZCBw
b2lzb24gYnl0ZXMgdG8gZGV0ZWN0IHRoaXMgY29uZGl0aW9uLg0KPiA+DQo+ID4gU2lnbmVkLW9m
Zi1ieTogSmFzb24gR3VudGhvcnBlIDxqZ2dAbWVsbGFub3guY29tPg0KPiANCj4gQWNrZWQtYnk6
IFNvdXB0aWNrIEpvYXJkZXIgPGpyZHIubGludXhAZ21haWwuY29tPg0KPiANCj4gPiAgbW0vaG1t
LmMgfCAxMSArKysrKysrLS0tLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCsp
LCA0IGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL21tL2htbS5jIGIvbW0vaG1t
LmMNCj4gPiBpbmRleCA2YzNiNzM5ODY3MmMyOS4uMDI3NTJkM2VmMmVkOTIgMTAwNjQ0DQo+ID4g
KysrIGIvbW0vaG1tLmMNCj4gPiBAQCAtOTM2LDggKzkzNiw3IEBAIEVYUE9SVF9TWU1CT0woaG1t
X3JhbmdlX3JlZ2lzdGVyKTsNCj4gPiAgICovDQo+ID4gIHZvaWQgaG1tX3JhbmdlX3VucmVnaXN0
ZXIoc3RydWN0IGhtbV9yYW5nZSAqcmFuZ2UpDQo+ID4gIHsNCj4gPiAtICAgICAgIC8qIFNhbml0
eSBjaGVjayB0aGlzIHJlYWxseSBzaG91bGQgbm90IGhhcHBlbi4gKi8NCj4gPiAtICAgICAgIGlm
IChyYW5nZS0+aG1tID09IE5VTEwgfHwgcmFuZ2UtPmVuZCA8PSByYW5nZS0+c3RhcnQpDQo+ID4g
KyAgICAgICBpZiAoV0FSTl9PTihyYW5nZS0+ZW5kIDw9IHJhbmdlLT5zdGFydCkpDQo+ID4gICAg
ICAgICAgICAgICAgIHJldHVybjsNCj4gDQo+IERvZXMgaXQgbWFrZSBhbnkgc2Vuc2UgdG8gc2Fu
aXR5IGNoZWNrIGZvciByYW5nZSA9PSBOVUxMIGFzIHdlbGwgPw0KDQpUaGUgcHVycG9zZSBvZiB0
aGUgc2FuaXR5IGNoZWNrIGlzIHRvIG1ha2UgQVBJIG1pc3VzZSBpbnRvIGEgcmVsaWFibGUNCmNy
YXNoLCBzbyBpZiByYW5nZSBpcyBOVUxMIHRoZW4gaXQgd2lsbCBhbHJlYWR5IHJlbGlhYmx5IGNy
YXNoIGR1ZSB0bw0KbmV4dCBsaW5lcy4gDQoNClRoaXMgYXBwcm9hY2ggaXMgdG8gaGVscCBkcml2
ZXIgYXV0aG9ycyB1c2UgdGhlIEFQSSBwcm9wZXJseS4NCg0KSG93ZXZlciwgbG9va2luZyBjbG9z
ZXIsIHRoaXMgd2lsbCBhbHJlYWR5IGNyYXNoIHJlbGlhYmx5IGlmIHdlIGRvdWJsZQ0KdW5yZWdp
c3RlciBhcyByYW5nZS0+aG1tLT5sb2NrIHdpbGwgaW5zdGFudGx5IGNyYXNoIGR1ZSB0aGUgcG9p
c29uLA0KYW5kIHRoZSB0ZXN0IG5vIGxvbmdlciB3b3JrcyByaWdodCBhbnlob3cgc2luY2UgdjIg
ZHJvcHBlZCB0aGUgc2V0IG9mDQp0aGUgc3RhcnQvZW5kIHZhbHVlcy4gSSd2ZSBkZWxldGVkIHRo
ZSBjaGVjayBmb3IgdjM6DQoNClRoYW5rcywNCkphc29uDQoNCkZyb20gNDYxZDg4MGQxZTg5OGRj
OGU5ZmY2MjM2YjE3MzBhNTk5NmRmODczOCBNb24gU2VwIDE3IDAwOjAwOjAwIDIwMDENCkZyb206
IEphc29uIEd1bnRob3JwZSA8amdnQG1lbGxhbm94LmNvbT4NCkRhdGU6IFRodSwgMjMgTWF5IDIw
MTkgMTE6NDA6MjQgLTAzMDANClN1YmplY3Q6IFtQQVRDSF0gbW0vaG1tOiBQb2lzb24gaG1tX3Jh
bmdlIGR1cmluZyB1bnJlZ2lzdGVyDQpNSU1FLVZlcnNpb246IDEuMA0KQ29udGVudC1UeXBlOiB0
ZXh0L3BsYWluOyBjaGFyc2V0PVVURi04DQpDb250ZW50LVRyYW5zZmVyLUVuY29kaW5nOiA4Yml0
DQoNClRyeWluZyB0byBtaXN1c2UgYSByYW5nZSBvdXRzaWRlIGl0cyBsaWZldGltZSBpcyBhIGtl
cm5lbCBidWcuIFVzZSBwb2lzb24NCmJ5dGVzIHRvIGhlbHAgZGV0ZWN0IHRoaXMgY29uZGl0aW9u
LiBEb3VibGUgdW5yZWdpc3RlciB3aWxsIHJlbGlhYmx5IGNyYXNoLg0KDQpTaWduZWQtb2ZmLWJ5
OiBKYXNvbiBHdW50aG9ycGUgPGpnZ0BtZWxsYW5veC5jb20+DQpSZXZpZXdlZC1ieTogSsOpcsO0
bWUgR2xpc3NlIDxqZ2xpc3NlQHJlZGhhdC5jb20+DQpSZXZpZXdlZC1ieTogSm9obiBIdWJiYXJk
IDxqaHViYmFyZEBudmlkaWEuY29tPg0KLS0tDQp2Mg0KLSBLZWVwIHJhbmdlIHN0YXJ0L2VuZCB2
YWxpZCBhZnRlciB1bnJlZ2lzdHJhdGlvbiAoSmVyb21lKQ0KdjMNCi0gUmV2aXNlIHNvbWUgY29t
bWVudHMgKEpvaG4pDQotIFJlbW92ZSBzdGFydC9lbmQgV0FSTl9PTiAoU291cHRpY2spDQotLS0N
CiBtbS9obW0uYyB8IDEzICsrKysrKysrLS0tLS0NCiAxIGZpbGUgY2hhbmdlZCwgOCBpbnNlcnRp
b25zKCspLCA1IGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvbW0vaG1tLmMgYi9tbS9obW0u
Yw0KaW5kZXggZDRhYzE3OWM4OTljNGUuLjI4OGZjZDFmZmNhNWI1IDEwMDY0NA0KLS0tIGEvbW0v
aG1tLmMNCisrKyBiL21tL2htbS5jDQpAQCAtOTI1LDEwICs5MjUsNiBAQCB2b2lkIGhtbV9yYW5n
ZV91bnJlZ2lzdGVyKHN0cnVjdCBobW1fcmFuZ2UgKnJhbmdlKQ0KIHsNCiAJc3RydWN0IGhtbSAq
aG1tID0gcmFuZ2UtPmhtbTsNCiANCi0JLyogU2FuaXR5IGNoZWNrIHRoaXMgcmVhbGx5IHNob3Vs
ZCBub3QgaGFwcGVuLiAqLw0KLQlpZiAoaG1tID09IE5VTEwgfHwgcmFuZ2UtPmVuZCA8PSByYW5n
ZS0+c3RhcnQpDQotCQlyZXR1cm47DQotDQogCW11dGV4X2xvY2soJmhtbS0+bG9jayk7DQogCWxp
c3RfZGVsX3JjdSgmcmFuZ2UtPmxpc3QpOw0KIAltdXRleF91bmxvY2soJmhtbS0+bG9jayk7DQpA
QCAtOTM3LDcgKzkzMywxNCBAQCB2b2lkIGhtbV9yYW5nZV91bnJlZ2lzdGVyKHN0cnVjdCBobW1f
cmFuZ2UgKnJhbmdlKQ0KIAlyYW5nZS0+dmFsaWQgPSBmYWxzZTsNCiAJbW1wdXQoaG1tLT5tbSk7
DQogCWhtbV9wdXQoaG1tKTsNCi0JcmFuZ2UtPmhtbSA9IE5VTEw7DQorDQorCS8qDQorCSAqIFRo
ZSByYW5nZSBpcyBub3cgaW52YWxpZCBhbmQgdGhlIHJlZiBvbiB0aGUgaG1tIGlzIGRyb3BwZWQs
IHNvDQorICAgICAgICAgKiBwb2lzb24gdGhlIHBvaW50ZXIuICBMZWF2ZSBvdGhlciBmaWVsZHMg
aW4gcGxhY2UsIGZvciB0aGUgY2FsbGVyJ3MNCisgICAgICAgICAqIHVzZS4NCisgICAgICAgICAq
Lw0KKwlyYW5nZS0+dmFsaWQgPSBmYWxzZTsNCisJbWVtc2V0KCZyYW5nZS0+aG1tLCBQT0lTT05f
SU5VU0UsIHNpemVvZihyYW5nZS0+aG1tKSk7DQogfQ0KIEVYUE9SVF9TWU1CT0woaG1tX3Jhbmdl
X3VucmVnaXN0ZXIpOw0KIA0KLS0gDQoyLjIxLjANCg0K
