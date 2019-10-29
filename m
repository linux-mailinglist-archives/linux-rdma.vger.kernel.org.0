Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71F1EE8E72
	for <lists+linux-rdma@lfdr.de>; Tue, 29 Oct 2019 18:40:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725905AbfJ2Rkn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 29 Oct 2019 13:40:43 -0400
Received: from mail-eopbgr00046.outbound.protection.outlook.com ([40.107.0.46]:3814
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727518AbfJ2Rkn (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 29 Oct 2019 13:40:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WUPH9F32xG8Q4grHq3ln92WrKKyNuFdL3jFPDp//7ZkWb/yOGg45+t0lTIS/D/qvAhHNLfNI2E4w5vSSzzLDawvIZwIiMOtp68eHAaphNqMlKlC5KJ6/d6H2df0kQBh27n4IHLyC/UfyWl71V4NeJhlzSlVFV3xQ285xI9ECjX8EfHVM9hPRzm6+zQKh9GWrGawP1JVmJXuzZoZvToz6mpmDkktXZg30AdOXSQxrJzGRKu/mho6lgT4cwoh7KwF95HtgA+B2+cKCZotHdKYcc+HNBchbW7ZbblWR48M4ev3TYajlL1zwWobtFK6TiaHOkpbBV+Xtc2Kcp7ktbmCqHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T5G5m7LpgytKX3nmEc3O9CVDwVeKycrTz9gPuQSFOfQ=;
 b=dDZW6rYBXPLi/p3HNozECazmS5I26mi0HpWi2TRLFLKbVIqZlx/LuM8scs65jgaRrfS9zlyru5LdTyuT38jiAP2hn2A0xKaHFmicrAFmD489Yy2roY65MaLWpW4VQZFcZa5pM+Yk5lBuguvKaF++YG3qXa8UP6H/qr2ut9nbBZLFuPYS8UfuElMbZnjMdxxmLMPCQKqzyoxJ6T0QkaVPA9xETzmmp0yYs4fJtfUcBClyp/bnVF8JMo2SzbkocGoo2Q/9pKzSclBTf9CFl/jlb/0qqiWnH5YpmrPNaysk70FhgADBhU4R8Y3auflWqiF1BZhk0kezhEMos2VKXWMHrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T5G5m7LpgytKX3nmEc3O9CVDwVeKycrTz9gPuQSFOfQ=;
 b=XGvC7h/UDq33Hlf+6rsbWxlmEXiPCRJY1Lwqh0TErziavI+C/TU0PbbMad3rSfn2CYMw2WJghcIXqCAcBGkEdkdLrI+HUAdpxZxOiAxbWo7WqsVmrSy+jH4khzOmPhmhu6ABXAhgIefCITKyfdTbZC5y0THr5NI+hQDPkK3vr7g=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (52.133.14.15) by
 VI1PR05MB5183.eurprd05.prod.outlook.com (20.178.9.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.22; Tue, 29 Oct 2019 17:40:39 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::b179:e8bf:22d4:bf8d]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::b179:e8bf:22d4:bf8d%5]) with mapi id 15.20.2387.027; Tue, 29 Oct 2019
 17:40:39 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Ralph Campbell <rcampbell@nvidia.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Christoph Hellwig <hch@lst.de>
CC:     John Hubbard <jhubbard@nvidia.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/3] mm/hmm: make full use of walk_page_range()
Thread-Topic: [PATCH v3 1/3] mm/hmm: make full use of walk_page_range()
Thread-Index: AQHVidvQNc+e+9eo5ka32bzGBwuw3qdx7DkA
Date:   Tue, 29 Oct 2019 17:40:39 +0000
Message-ID: <20191029174036.GR22766@mellanox.com>
References: <20191023195515.13168-1-rcampbell@nvidia.com>
 <20191023195515.13168-2-rcampbell@nvidia.com>
In-Reply-To: <20191023195515.13168-2-rcampbell@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MN2PR02CA0003.namprd02.prod.outlook.com
 (2603:10b6:208:fc::16) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:44::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [142.162.113.180]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: bcb05ac0-f770-494a-82b4-08d75c971d03
x-ms-traffictypediagnostic: VI1PR05MB5183:
x-microsoft-antispam-prvs: <VI1PR05MB5183A7F8AD19BC473DB03EDACF610@VI1PR05MB5183.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0205EDCD76
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(136003)(366004)(346002)(39860400002)(376002)(189003)(199004)(486006)(66476007)(5660300002)(11346002)(2616005)(446003)(476003)(2906002)(66946007)(14444005)(64756008)(66556008)(3846002)(6116002)(86362001)(6506007)(26005)(186003)(102836004)(386003)(71190400001)(8936002)(66446008)(33656002)(71200400001)(54906003)(6436002)(305945005)(110136005)(99286004)(316002)(7736002)(76176011)(6246003)(81156014)(52116002)(14454004)(256004)(6512007)(478600001)(1076003)(66574012)(6486002)(4326008)(25786009)(36756003)(81166006)(66066001)(8676002)(229853002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB5183;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5uqbelTWpl2zlSSi/IT+IR6sBGou0Acv7BXFRndT6XZGZ/IzU16X49grdtZKqsMbr4VXstZpvZq79X3my4whlzNvNcLaNHyxwYwktOr4N/3/6Bo5MWe4QMRQKdGE8A3ft23XRMB4JuKRhdzEKgVjjjADFrkbhjaeqL4Fj8OFjrGHKyhBTbNjxkNEw6acP6KzXfp0e74KkFeGNdNGlj++PDs+cp0cisTuUDW5fJU0QsbKOxgfLqKMzfW62An6XziHY0OAFlToZ2pp8Ie6QypzqG1UT9wnmDzHB7T1DUaSQtIDQBRfq8w5WZNMv2kezhus+WGpadLxBQ3F8wWnnsKwLlWb0ubqvpfVsUO0Skfpnz8b4YZeccLf5PxrDQXazAjLUA5ef7kxbLjkTG7UgyHS1rZIMxXhRkLgxlzXy5eH0gZvfcOgzXQ+YR1A/b/GoQUY
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <8F71407F39E42F409A92850DDBE5B983@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcb05ac0-f770-494a-82b4-08d75c971d03
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2019 17:40:39.4360
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ve4A1od5xs+cR1YlLaMi8WFRoMA2xRrTr8p4w4uPqHAem+tvIblyG8Bc8V7mL2VLbeavhxmTyVqX6mM4+Ea2vA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB5183
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

T24gV2VkLCBPY3QgMjMsIDIwMTkgYXQgMTI6NTU6MTNQTSAtMDcwMCwgUmFscGggQ2FtcGJlbGwg
d3JvdGU6DQo+IGhtbV9yYW5nZV9mYXVsdCgpIGNhbGxzIGZpbmRfdm1hKCkgYW5kIHdhbGtfcGFn
ZV9yYW5nZSgpIGluIGEgbG9vcC4NCj4gVGhpcyBpcyB1bm5lY2Vzc2FyeSBkdXBsaWNhdGlvbiBz
aW5jZSB3YWxrX3BhZ2VfcmFuZ2UoKSBjYWxscyBmaW5kX3ZtYSgpDQo+IGluIGEgbG9vcCBhbHJl
YWR5Lg0KPiBTaW1wbGlmeSBobW1fcmFuZ2VfZmF1bHQoKSBieSBkZWZpbmluZyBhIHdhbGtfdGVz
dCgpIGNhbGxiYWNrIGZ1bmN0aW9uDQo+IHRvIGZpbHRlciB1bmhhbmRsZWQgdm1hcy4NCj4gVGhp
cyBhbHNvIGZpeGVzIGEgYnVnIHdoZXJlIGhtbV9yYW5nZV9mYXVsdCgpIHdhcyBub3QgY2hlY2tp
bmcNCj4gc3RhcnQgPj0gdm1hLT52bV9zdGFydCBiZWZvcmUgY2hlY2tpbmcgdm1hLT52bV9mbGFn
cyBzbyBobW1fcmFuZ2VfZmF1bHQoKQ0KPiBjb3VsZCByZXR1cm4gYW4gZXJyb3IgYmFzZWQgb24g
dGhlIHdyb25nIHZtYSBmb3IgdGhlIHJlcXVlc3RlZCByYW5nZS4NCj4gSXQgYWxzbyBmaXhlcyBh
IGJ1ZyB3aGVuIHRoZSB2bWEgaGFzIG5vIHJlYWQgYWNjZXNzIGFuZCB0aGUgY2FsbGVyIGRpZA0K
PiBub3QgcmVxdWVzdCBhIGZhdWx0LCB0aGVyZSBzaG91bGRuJ3QgYmUgYW55IGVycm9yIHJldHVy
biBjb2RlLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogUmFscGggQ2FtcGJlbGwgPHJjYW1wYmVsbEBu
dmlkaWEuY29tPg0KPiBDYzogIkrDqXLDtG1lIEdsaXNzZSIgPGpnbGlzc2VAcmVkaGF0LmNvbT4N
Cj4gQ2M6IEphc29uIEd1bnRob3JwZSA8amdnQG1lbGxhbm94LmNvbT4NCj4gQ2M6IENocmlzdG9w
aCBIZWxsd2lnIDxoY2hAbHN0LmRlPg0KPiAgbW0vaG1tLmMgfCAxMjYgKysrKysrKysrKysrKysr
KysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiAgMSBmaWxlIGNoYW5n
ZWQsIDYzIGluc2VydGlvbnMoKyksIDYzIGRlbGV0aW9ucygtKQ0KDQpUaGlzIGlzIGxvb2tpbmcg
T0ssIGNhbiB3ZSBnZXQgYW4gYWNrIGZyb20gSmVyb21lPyBDaHJpc3RvcGg/DQoNCkkgcmVjYWxs
IG15IGZpcnN0IHdvcnJ5IHdhcyB0aGF0IHdhbGstPnZtYSBjb3VsZCBub3cgYmUgbnVsbCwgYXMN
Cm9wcy0+cHRlX2hvbGUgaXMgc2V0LiBCdXQgaXQgbG9va3MgbGlrZSB0aGF0IGlzIGFsbCBoYW5k
bGVkIG5vdz8NCg0KVGhhbmtzLA0KSmFzb24NCg==
