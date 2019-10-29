Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03822E8E10
	for <lists+linux-rdma@lfdr.de>; Tue, 29 Oct 2019 18:27:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726347AbfJ2R1j (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 29 Oct 2019 13:27:39 -0400
Received: from mail-eopbgr70071.outbound.protection.outlook.com ([40.107.7.71]:62407
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726416AbfJ2R1j (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 29 Oct 2019 13:27:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F4T0e6H6qyuC0d/Le7AHWFLQ4w8UNYpkiV9ckfPk91MIomR0UUYeJU49xFXVpvdqwlaGSPBm3zuagwsmT1kvsKxsBvCH4cs+LVv9LlPy1J5B/4RplrHFrnizGXyl+V9MEBfa+64XS8+l3jvm9YEET+jBMY+JFofeyYx7bra3uFFfhg1PZuQkmZXDjqZulo1x2ak6l7b6ewqu5CCm2/PBET2fBq2/TuFZFu1EojlDhYBMSMGawC90+adLg8pceDUYCj1PJ0xRjBTAznliIiObXS8t8z1WeNJ7EZdeS4lxU+VT0UdrMppjsKOTkhj0UeYoVtsZG0ICdPCdj27xw3+wZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p5Qb+4cwg/f15sXDTRjqBJ/epuV94mpkrUvNH07YW0I=;
 b=d2NSmM/yI+fZNQMAPNU8HI1JQELrnOElsqAn8o6qN0L1LpyhqeTnl925yQ/7IZa8/FU/C7OxO9+lV8P2cAK325Ev6WJ3dOyk82vDbjBvUw7zH473I3WleIoOfcOWkTu0nCZXIo76ZFgwfcRD1wC5O1HzJwPTI2hZkzbFk+5zvxc5YXyw0z7TtjKXpqQmj3suxbKdKp7qlz4aPozVVvw2raBJw2mOCeaVawAdX+m/ZZp61vlel33KV2th7PhyhldTWcBFKz9Q2AmhlSWgLKnc5PJ25dZYlvHylewWIDlOF4gZjCfAhBRfJ3YP/xc80d5j7hjWOn3nvyFTEQ/npN9euA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p5Qb+4cwg/f15sXDTRjqBJ/epuV94mpkrUvNH07YW0I=;
 b=LSak3ekG2s2ctzqrC0AqhAU65af5PATFS6kUphuiwsOps2Tzd+Qhs47FG5/lVP41CPRMfatkybLHFZu+rzC+XIzqEQsx/My+gbn/wMlsdH4uDpHMIfO9hEOY7PMdwKm7AoMSBPrDWKkty/q6B7cBuiWxjS5rF6hGXw4Sh+VsUhU=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (52.133.14.15) by
 VI1PR05MB5005.eurprd05.prod.outlook.com (20.177.49.202) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.20; Tue, 29 Oct 2019 17:27:35 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::b179:e8bf:22d4:bf8d]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::b179:e8bf:22d4:bf8d%5]) with mapi id 15.20.2387.027; Tue, 29 Oct 2019
 17:27:35 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Ralph Campbell <rcampbell@nvidia.com>
CC:     Jerome Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/3] mm/hmm: allow snapshot of the special zero page
Thread-Topic: [PATCH v3 2/3] mm/hmm: allow snapshot of the special zero page
Thread-Index: AQHVidvPmt4WdHuYiki7I7aLobydcKdx6I+A
Date:   Tue, 29 Oct 2019 17:27:35 +0000
Message-ID: <20191029172729.GQ22766@mellanox.com>
References: <20191023195515.13168-1-rcampbell@nvidia.com>
 <20191023195515.13168-3-rcampbell@nvidia.com>
In-Reply-To: <20191023195515.13168-3-rcampbell@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN6PR04CA0084.namprd04.prod.outlook.com
 (2603:10b6:805:f2::25) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:44::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [142.162.113.180]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 247fc102-9398-4302-f252-08d75c9549b1
x-ms-traffictypediagnostic: VI1PR05MB5005:
x-microsoft-antispam-prvs: <VI1PR05MB50055E2C2BE8BD2A5E592B59CF610@VI1PR05MB5005.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-forefront-prvs: 0205EDCD76
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(396003)(376002)(136003)(366004)(39860400002)(199004)(189003)(66556008)(66946007)(446003)(66476007)(6506007)(26005)(386003)(76176011)(478600001)(66066001)(52116002)(102836004)(36756003)(66446008)(64756008)(7736002)(305945005)(25786009)(14454004)(86362001)(6916009)(99286004)(8936002)(71190400001)(2906002)(4326008)(476003)(8676002)(71200400001)(11346002)(486006)(2616005)(6116002)(3846002)(81166006)(81156014)(256004)(6512007)(229853002)(4744005)(186003)(6436002)(54906003)(6246003)(33656002)(5660300002)(66574012)(14444005)(316002)(1076003)(6486002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB5005;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: e14Y3VezDHmbSfr9aXub/wifOfJ7U+ZhxjpfcS+5ZCNa6W0r4rrQzjsPInSqjfUfWJdV64AB+IeiE2vCZGvS0D+tburuB2SG6yWj4UafFicNDRWjBghGuLo0FGwHKQJW9DfxtrzTlSzhIDsX6E2W3XF/EHFrvQKlsokiKSAQDZMT2iTRV+o+pLZw0uq1hYMc0gChhg0KSEz0Hi7LU1TnaBaItxZvX/HrqfHsmymqq8UDQ19lQNGj8PzQb+eVAvQ4FUKqRYh+COyHrbK+Is+HZT4YzLq66f2Fq1GllRz6utyOpiMQjI1zCkVQ+Xhx1K13toQjlbsDyVcWi2Ns0AK0unmzOSyop7RfGHUqacfuAZglNAqgSXMvqMDHrbSqjnW4MivlRolCbmB6rs6yQqCnV1wb3qmZYYNkYnStH9LNGy92ybmsaNkhcj9iewC9VJ20
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <3EF4476E613D4F4CB004978E1F29EE59@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 247fc102-9398-4302-f252-08d75c9549b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2019 17:27:35.4074
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QY20XFBNTWfiqUnuMoRxSDJmsGiOEbqipYfieFTTsxPGj2g0C6QHFOGIb4Q0WGGsVo64PmOkJERcKvj2DsaIYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB5005
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

T24gV2VkLCBPY3QgMjMsIDIwMTkgYXQgMTI6NTU6MTRQTSAtMDcwMCwgUmFscGggQ2FtcGJlbGwg
d3JvdGU6DQo+IElmIGEgZGV2aWNlIGRyaXZlciBsaWtlIG5vdXZlYXUgdHJpZXMgdG8gdXNlIGht
bV9yYW5nZV9mYXVsdCgpIHRvIGFjY2Vzcw0KPiB0aGUgc3BlY2lhbCBzaGFyZWQgemVybyBwYWdl
IGluIHN5c3RlbSBtZW1vcnksIGhtbV9yYW5nZV9mYXVsdCgpIHdpbGwNCj4gcmV0dXJuIC1FRkFV
TFQgYW5kIGtpbGwgdGhlIHByb2Nlc3MuDQo+IEFsbG93IGhtbV9yYW5nZV9mYXVsdCgpIHRvIHJl
dHVybiBzdWNjZXNzICgwKSB3aGVuIHRoZSBDUFUgcGFnZXRhYmxlDQo+IGVudHJ5IHBvaW50cyB0
byB0aGUgc3BlY2lhbCBzaGFyZWQgemVybyBwYWdlLg0KPiBwYWdlX3RvX3BmbigpIGFuZCBwZm5f
dG9fcGFnZSgpIGFyZSBkZWZpbmVkIG9uIHRoZSB6ZXJvIHBhZ2Ugc28ganVzdA0KPiBoYW5kbGUg
aXQgbGlrZSBhbnkgb3RoZXIgcGFnZS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFJhbHBoIENhbXBi
ZWxsIDxyY2FtcGJlbGxAbnZpZGlhLmNvbT4NCj4gQ2M6IENocmlzdG9waCBIZWxsd2lnIDxoY2hA
bHN0LmRlPg0KPiBDYzogIkrDqXLDtG1lIEdsaXNzZSIgPGpnbGlzc2VAcmVkaGF0LmNvbT4NCj4g
Q2M6IEphc29uIEd1bnRob3JwZSA8amdnQG1lbGxhbm94LmNvbT4NCj4gLS0tDQo+ICBtbS9obW0u
YyB8IDEwICsrKysrKysrLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKyksIDIg
ZGVsZXRpb25zKC0pDQoNCkFwcGxpZWQgdG8gaG1tLmdpdA0KDQpUaGFua3MsDQpKYXNvbg0K
