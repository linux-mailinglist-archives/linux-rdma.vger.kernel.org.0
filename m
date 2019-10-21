Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5FC6DF4DC
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Oct 2019 20:09:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730036AbfJUSIq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 21 Oct 2019 14:08:46 -0400
Received: from mail-eopbgr130053.outbound.protection.outlook.com ([40.107.13.53]:26606
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728353AbfJUSIq (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 21 Oct 2019 14:08:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UnYaSc7JUgt7wlAc/1KwuK4URy+635FaSFExcGC3Sz1XhdNPsN20b6fcDvb0oJuqBN1Lgbx9FtdfG0gmK6XaNbdHeV1d0lG7qPFp9p9z6FdgSulhQDhKywxDxV93J0blNjcQNl1KXBnFnhigMxSwPPD0FQsU0VXBnX+ZWGSiIklTpTke8fWEbDARhwOM1e8bqVyYVr2IkD/eG3r80s6yP6fR18mxCZeNjWH5O8Hb7XqgRGwdnic+0fcPPB585fRSm0nd5CCjjdJ839rqZ2PmA/E3Yo4neYHOacTRtrbHyHArAJQVs5seyLxpbbWKWQHzrYk6+x7uso+OuD/FeW5/XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TCS44TzEuNTUdRkC3s+Dv1/s/9sssrrdahGMrPPYGM8=;
 b=UymJcEryiD88+B7DudafTfEt+5wkE//IK7uYW4NeEzmUbzLNt7XGpUtN9BxIQu9rgCJLeFccB5KsibNskL+wjBavf1BRGDefGSwn8/bSDcIkgZMcm0foygsKtzr1qDx8NJMfW8VVaJc+IeeYs+eoynI+N7dUtfyUJE2rg//7W7sMR319AdmsMDsgdEi5CiS3c5COF5AGPZOpf6S60dlVZHCvq9wHj8rmguKNsRp1qvZ4Xb140qDam3e3q+Khj/28yhJjET/63ynCOJfmi7wQzGMw8S5lx0Lcoj3r4bNQ6/jKOOYYpwwDFlMLmj448EWBJWjbk/Ytv5M6curyxFNasQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TCS44TzEuNTUdRkC3s+Dv1/s/9sssrrdahGMrPPYGM8=;
 b=TVZosprgrQWECeR5H+0IF+juaEUmwI4ATfUajYkkeGwOjBGqTc775Lc3PrhjVkahxwA5n0v5T8dnOQ5ph5LZMt+vUJE/gna/tGaw+5J+LQA9XKgbXzOM1UBNIpt/hqE/IgfmwmpIjr+aSTKFAewlRTAUHj+u+t3moifLxge/ZnE=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (52.133.14.15) by
 VI1PR05MB5631.eurprd05.prod.outlook.com (20.178.120.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.18; Mon, 21 Oct 2019 18:08:41 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::75ae:b00b:69d8:3db0]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::75ae:b00b:69d8:3db0%7]) with mapi id 15.20.2347.029; Mon, 21 Oct 2019
 18:08:41 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Ralph Campbell <rcampbell@nvidia.com>
CC:     Jerome Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH v2 2/3] mm/hmm: allow snapshot of the special zero page
Thread-Topic: [PATCH v2 2/3] mm/hmm: allow snapshot of the special zero page
Thread-Index: AQHVg5noYFRN6Uol1kOCsSoXbSSn1KdlbekA
Date:   Mon, 21 Oct 2019 18:08:40 +0000
Message-ID: <20191021180836.GE6285@mellanox.com>
References: <20191015204814.30099-1-rcampbell@nvidia.com>
 <20191015204814.30099-3-rcampbell@nvidia.com>
In-Reply-To: <20191015204814.30099-3-rcampbell@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BN7PR10CA0031.namprd10.prod.outlook.com
 (2603:10b6:406:bc::44) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:44::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [142.162.113.180]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4512248a-6055-48d6-71f2-08d75651b3d2
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: VI1PR05MB5631:
x-microsoft-antispam-prvs: <VI1PR05MB563186E7714F11B399A575E6CF690@VI1PR05MB5631.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0197AFBD92
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(346002)(396003)(136003)(376002)(366004)(199004)(189003)(1076003)(66946007)(66556008)(316002)(64756008)(66476007)(33656002)(8936002)(71200400001)(256004)(14444005)(5660300002)(54906003)(66446008)(71190400001)(66574012)(86362001)(25786009)(3846002)(36756003)(486006)(2906002)(8676002)(6486002)(102836004)(26005)(6116002)(476003)(81166006)(6512007)(52116002)(76176011)(81156014)(6916009)(6246003)(478600001)(66066001)(11346002)(14454004)(446003)(186003)(7736002)(305945005)(386003)(6506007)(6436002)(4326008)(99286004)(229853002)(2616005);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB5631;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xfMxah0kfQhGYyzxzzg7V1yme0MEpJe9wBMgH0/RJtViqwcZunAZRrLWJJAuodLmLDA2rnxWJgWhohjNA47+c5ZgJjg/Trrjc4n3IDSez1pGyfvoSVYjPy8Radw7BGp6zYD++zB1wzMCr4s67PG9QtCAqVQiAcLoz0EuoW5G4cPrL/tTH2NaHhEXKpEySkrK41aabqTuGDrtS1ZYNc1KCbSP4btS8j6ZfuzkcFYlkawoHLRpgG3Uoq5jPtxmfNpQKYaov5BdzxC3OUaoyH1m2fhN3Osxy/G1QPaAljtSVztrq1e3j+JkS2AuNWR5V2WWGW73xl9SLg1mXI8AMJikQoWROysmH5xVFdst2hzUhP7Sti1ioaD1ShHOy5Cr3usbmbFJORuvQzjy0aocq/KAhxbeuJx8LgtD0gF7pw23Ef0=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <68C2F239C011E24CBC4AAB274EE267B9@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4512248a-6055-48d6-71f2-08d75651b3d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2019 18:08:40.9095
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xr+IFJrxx9S49yDwrMNdxVZAPjloR0SC1Raz/qcA//Kd+22wcY+vrGt8PozOjZuHJAh5JfMpTW+L9HIFkAFVwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB5631
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

T24gVHVlLCBPY3QgMTUsIDIwMTkgYXQgMDE6NDg6MTNQTSAtMDcwMCwgUmFscGggQ2FtcGJlbGwg
d3JvdGU6DQo+IEFsbG93IGhtbV9yYW5nZV9mYXVsdCgpIHRvIHJldHVybiBzdWNjZXNzICgwKSB3
aGVuIHRoZSBDUFUgcGFnZXRhYmxlDQo+IGVudHJ5IHBvaW50cyB0byB0aGUgc3BlY2lhbCBzaGFy
ZWQgemVybyBwYWdlLg0KPiBUaGUgY2FsbGVyIGNhbiB0aGVuIGhhbmRsZSB0aGUgemVybyBwYWdl
IGJ5IHBvc3NpYmx5IGNsZWFyaW5nIGRldmljZQ0KPiBwcml2YXRlIG1lbW9yeSBpbnN0ZWFkIG9m
IERNQWluZyBhIHplcm8gcGFnZS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFJhbHBoIENhbXBiZWxs
IDxyY2FtcGJlbGxAbnZpZGlhLmNvbT4NCj4gUmV2aWV3ZWQtYnk6IENocmlzdG9waCBIZWxsd2ln
IDxoY2hAbHN0LmRlPg0KPiBDYzogIkrDqXLDtG1lIEdsaXNzZSIgPGpnbGlzc2VAcmVkaGF0LmNv
bT4NCj4gQ2M6IEphc29uIEd1bnRob3JwZSA8amdnQG1lbGxhbm94LmNvbT4NCj4gIG1tL2htbS5j
IHwgNCArKystDQo+ICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9u
KC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvbW0vaG1tLmMgYi9tbS9obW0uYw0KPiBpbmRleCA1ZGYw
ZGJmNzdlODkuLmY2MmIxMTk3MjJhMyAxMDA2NDQNCj4gKysrIGIvbW0vaG1tLmMNCj4gQEAgLTUz
MCw3ICs1MzAsOSBAQCBzdGF0aWMgaW50IGhtbV92bWFfaGFuZGxlX3B0ZShzdHJ1Y3QgbW1fd2Fs
ayAqd2FsaywgdW5zaWduZWQgbG9uZyBhZGRyLA0KPiAgCQkJcmV0dXJuIC1FQlVTWTsNCj4gIAl9
IGVsc2UgaWYgKElTX0VOQUJMRUQoQ09ORklHX0FSQ0hfSEFTX1BURV9TUEVDSUFMKSAmJiBwdGVf
c3BlY2lhbChwdGUpKSB7DQo+ICAJCSpwZm4gPSByYW5nZS0+dmFsdWVzW0hNTV9QRk5fU1BFQ0lB
TF07DQo+IC0JCXJldHVybiAtRUZBVUxUOw0KPiArCQlpZiAoIWlzX3plcm9fcGZuKHB0ZV9wZm4o
cHRlKSkpDQo+ICsJCQlyZXR1cm4gLUVGQVVMVDsNCj4gKwkJcmV0dXJuIDA7DQoNCkRvZXMgaXQg
bWFrZSBzZW5zZSB0byByZXR1cm4gSE1NX1BGTl9TUEVDSUFMIGluIHRoaXMgY2FzZT8gRG9lcyB0
aGUNCnplcm8gcGZuIGhhdmUgYSBzdHJ1Y3QgcGFnZT8gRG9lcyBpdCBuZWVkIG1hbmRhdG9yeSBz
cGVjaWFsIHRyZWF0bWVudD8NCg0KaWUgdGhlIGJhc2UgYmVoYXZpb3Igd2l0aG91dCBhbnkgZHJp
dmVyIGNvZGUgc2hvdWxkIGJlIHRvIGRtYSBmcm9tIHRoZQ0KemVybyBtZW1vcnkuIEEgZmFuY3kg
ZHJpdmVyIHNob3VsZCBiZSBhYmxlIHRvIGRldGVjdCB0aGUgemVybyBhbmQgZG8NCnNvbWV0aGlu
ZyBlbHNlLg0KDQpJJ20gbm90IGNsZWFyIHdoYXQgdGhlIHR3byBleGlzdGluZyB1c2VycyBkbyB3
aXRoIFBGTl9TUEVDSUFMPyBOb3V2ZWF1DQpsb29rcyBsaWtlIGl0IGlzIHRoZSBzYW1lIHZhbHVl
IGFzIGVycm9yLCBjYW4ndCBndWVzcyB3aGF0IGFtZGdwdSBkb2VzDQp3aXRoIGl0cyBtYWdpYyBj
b25zdGFudA0KDQpKYXNvbg0K
