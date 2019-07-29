Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23C8B79378
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Jul 2019 20:57:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbfG2S5f (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 29 Jul 2019 14:57:35 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:27602 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727036AbfG2S5f (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 29 Jul 2019 14:57:35 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x6TIpFnI032149;
        Mon, 29 Jul 2019 11:57:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=z5ndJxD6ksLvTYGG8nbU97I0JQUi8SBJRAknNhPY2kw=;
 b=Q44I1lFnRJ5cRYoQWWbw9JluhOjAHf0qWx83l/c++UClPN652wPsQi2VI/pTmsOW6joS
 qJPDK+9IjhIPlm4X1RyPJ77FHOKJmyrVOOEdJqms1/xQwI6FZv3tsCVRqrmdL6E6LREZ
 CIX/R1DrtJS/zXtVDG0szjNIHjK0YaPXVFx+i4mYYatneBRLA/Y4swUPRY3c0WfK2zq4
 L2ZybN3a5iBkCr77uX7MXw3iFhup66/7u7R2YYnY40RtVnrT2l6/qNrYXApCb5PW3B2T
 aNR0kk+mHZk/oy28NXcUHI3jTU9Rl+El7c62w20eNlss+SmWcDZBjIFyNHF5aVaHX0RL rw== 
Received: from sc-exch02.marvell.com ([199.233.58.182])
        by mx0b-0016f401.pphosted.com with ESMTP id 2u0p4m0ea4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 29 Jul 2019 11:57:30 -0700
Received: from SC-EXCH01.marvell.com (10.93.176.81) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Mon, 29 Jul
 2019 11:57:29 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.36.59) by
 SC-EXCH01.marvell.com (10.93.176.81) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Mon, 29 Jul 2019 11:57:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MkLZq8wwYDlQLc2JL5gvcVMLEVGt/fMAZjppSPow+QeEwx8VxIIMMXkSDb4Je2bEgWaT5H3HKFjqNj901DRpiZKlEwiy4Erv6B86AfJ8ocB9uohl9mj4/yu0GhHZUHX3zG2YIt7jxHdAeyYQ0WFXXVG8l0bcK1NqOdLxHqPZR3epLNw+WxFmmdR+OwdoH4KHHZgAOvdrw5rsIyvlWjU+O6JzMifmpdAWkaiYVkBxEkZckh0POL4eQRXkYKACiK5ZLWD6EnsYPS2igs8//5Y8/i/ZuxZXQSaxGq0ZbVHScerxQa0HQ2bIjhMBOJyJnuHzuzH8tcgRU3LsvcYSxeNxnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z5ndJxD6ksLvTYGG8nbU97I0JQUi8SBJRAknNhPY2kw=;
 b=n2+rgMe5Ze1xPuKkn8/n72mBhUfdZFP8GIs/JwN4U9xtGUnW0Ocs8m6+TQXdIHNKl+zZdQwXzZgdlWtPSwJ0L13zRNxNPa6iNnGq59KkJn9/aJiRwaUya61mbh21buzBVOuPQWqLtCnlGxqaTl3DXZSYjcI27mzbD4egRlWUbJrGJDwtJ12tFkyDEGE5F8AoTxxiOwtUIuIoOD5GUqSjY9Z63LWdJ2mBe/0W2iUYMhdaejLlH6CjIkn4/cl/0qJjn5j260gZTVbNZFoyTTH3YlVlykSckdKntgCSWDzEdiLeMIqbIrvobnQJGpTK++0kFViZ+uqa7/0lAD5Z9c6SzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=marvell.com;dmarc=pass action=none
 header.from=marvell.com;dkim=pass header.d=marvell.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z5ndJxD6ksLvTYGG8nbU97I0JQUi8SBJRAknNhPY2kw=;
 b=c5qnv/yQMoAQuVS+l1JKivUwjnOIkBf36CqhuRmafVfYg4v1YXJStSe6QQuT7cVhcwHkQSIzQjS62jLNo5BZIbcJkRNuQYhZ4XXzX7ldafFUS46yPX3fbZ5nxby+mInV0hUSjwTviZ4saq4ilH2k20S7pW8anjyMxBp9WU0N6wA=
Received: from MN2PR18MB3182.namprd18.prod.outlook.com (10.255.236.143) by
 MN2PR18MB2384.namprd18.prod.outlook.com (20.179.80.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.13; Mon, 29 Jul 2019 18:57:24 +0000
Received: from MN2PR18MB3182.namprd18.prod.outlook.com
 ([fe80::8cb3:f7d7:8bb2:c36e]) by MN2PR18MB3182.namprd18.prod.outlook.com
 ([fe80::8cb3:f7d7:8bb2:c36e%6]) with mapi id 15.20.2115.005; Mon, 29 Jul 2019
 18:57:24 +0000
From:   Michal Kalderon <mkalderon@marvell.com>
To:     Doug Ledford <dledford@redhat.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [EXT] Re: [PATCH rdma-rc] RDMA/qedr: Fix the hca_type and hca_rev
 returned in device attributes
Thread-Topic: [EXT] Re: [PATCH rdma-rc] RDMA/qedr: Fix the hca_type and
 hca_rev returned in device attributes
Thread-Index: AQHVRTXK0KC0mi2cu0SzFGeqvEsZTqbh2oIAgAAZdGA=
Date:   Mon, 29 Jul 2019 18:57:24 +0000
Message-ID: <MN2PR18MB3182453FD6E5E2C8D5F3C835A1DD0@MN2PR18MB3182.namprd18.prod.outlook.com>
References: <20190728111338.21930-1-michal.kalderon@marvell.com>
 <e6a930259f457a6d4dabfef0265545cff02ee427.camel@redhat.com>
In-Reply-To: <e6a930259f457a6d4dabfef0265545cff02ee427.camel@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [79.183.34.198]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c58b77ed-390c-4e58-893b-08d71456981f
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR18MB2384;
x-ms-traffictypediagnostic: MN2PR18MB2384:
x-microsoft-antispam-prvs: <MN2PR18MB23846D41E3777B51631D0646A1DD0@MN2PR18MB2384.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 01136D2D90
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(39860400002)(376002)(136003)(346002)(396003)(199004)(189003)(52314003)(8676002)(81156014)(81166006)(186003)(26005)(8936002)(2906002)(486006)(446003)(66066001)(76116006)(74316002)(256004)(305945005)(66476007)(66556008)(2501003)(86362001)(64756008)(66946007)(66446008)(7736002)(6506007)(71190400001)(11346002)(476003)(102836004)(316002)(68736007)(52536014)(7696005)(99286004)(33656002)(6436002)(3846002)(76176011)(71200400001)(6116002)(229853002)(478600001)(4744005)(55016002)(9686003)(6246003)(25786009)(110136005)(5660300002)(4326008)(14454004)(53936002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB2384;H:MN2PR18MB3182.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: pPXc9r2kYyYh/k5Dnj5Xw/cvMukCiWZAgMxAudt7LbK9LGDiHbIpEqx/NGndunGU/r1+QrRoUqGU+ti5v9jlvmo0WKH6nU8Nkgbs+6ZiCwjOsDy9BJr+/bjTDYas74cmbb6jVkRR/fMCGbeJcxLKplzKmqhGIpKjxgyXrspwr01SgjmJTxB9Foyz31BkNThVXG9aMuHWS18STFRkXchfGcLUfTYZcyjiow0u+Zdci5Kod60kfbirUPdzL52HT1C+skmHBdIJFCjrroHI6i6eK4Jdu0OioTv473SpLxqgbdXP76uUXChh2+IH6im/HaivqlxLAZCe9obUeh0E31r7NMMqrpx34AQaYQE7YAiYLhcCAw3FiP5F6Tu4MVfLY3PSajWciXsvY0numVEjYEko9guyzzXFgOG5CQ9B+pAfq90=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: c58b77ed-390c-4e58-893b-08d71456981f
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2019 18:57:24.5842
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mkalderon@marvell.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB2384
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:5.22.84,1.0.8
 definitions=2019-07-29_09:2019-07-29,2019-07-29 signatures=0
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

PiBGcm9tOiBEb3VnIExlZGZvcmQgPGRsZWRmb3JkQHJlZGhhdC5jb20+DQo+IFNlbnQ6IE1vbmRh
eSwgSnVseSAyOSwgMjAxOSA4OjI0IFBNDQo+IA0KPiBFeHRlcm5hbCBFbWFpbA0KPiANCj4gLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLQ0KPiBPbiBTdW4sIDIwMTktMDctMjggYXQgMTQ6MTMgKzAzMDAsIE1pY2hhbCBL
YWxkZXJvbiB3cm90ZToNCj4gPiBUaGVyZSB3YXMgYSBwbGFjZSBob2xkZXIgZm9yIGhjYV90eXBl
IGFuZCB2ZW5kb3Igd2FzIHJldHVybmVkIGluDQo+ID4gaGNhX3Jldi4gRml4IHRoZSBoY2FfcmV2
IHRvIHJldHVybiB0aGUgaHcgcmV2aXNpb24gYW5kIGZpeCB0aGUNCj4gPiBoY2FfdHlwZSB0byBy
ZXR1cm4gYW4gaW5mb3JtYXRpdmUgc3RyaW5nIHJlcHJlc2VudGluZyB0aGUgaGNhLg0KPiA+DQo+
ID4gU2lnbmVkLW9mZi1ieTogTWljaGFsIEthbGRlcm9uIDxtaWNoYWwua2FsZGVyb25AbWFydmVs
bC5jb20+DQo+IA0KPiBUaGlzIG9uZSB3YXMgcmVhbGx5IGtpbmQgb2YgYm9yZGVybGluZSBmb3Ig
YmVsb25naW5nIGluIHJjLiAgSW4gdGhlIGVuZCwgSSB0b29rIGl0DQo+IHRoZXJlIGJlY2F1c2Ug
eW91IHJlcXVlc3RlZCBpdCBpbiB5b3VyIHN1Ym1pc3Npb24sIGJ1dCBJIHRoaW5rIGl0IGNvdWxk
IGhhdmUNCj4gZWFzaWx5IHdhaXRlZCBpbiBmb3ItbmV4dCB0b28uICBBbnl3YXksIHRoYW5rcywg
YXBwbGllZC4NCg0KVGhhbmtzLiANCg0KPiANCj4gLS0NCj4gRG91ZyBMZWRmb3JkIDxkbGVkZm9y
ZEByZWRoYXQuY29tPg0KPiAgICAgR1BHIEtleUlEOiBCODI2QTMzMzBFNTcyRkREDQo+ICAgICBG
aW5nZXJwcmludCA9IEFFNkIgMUJEQSAxMjJCIDIzQjQgMjY1QiAgMTI3NCBCODI2IEEzMzMgMEU1
NyAyRkREDQo=
