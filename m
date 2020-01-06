Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6FA40131442
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Jan 2020 16:01:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbgAFPB3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 Jan 2020 10:01:29 -0500
Received: from mail-eopbgr30083.outbound.protection.outlook.com ([40.107.3.83]:13558
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726296AbgAFPB3 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 6 Jan 2020 10:01:29 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jEOoHmtvWn7VFw1ROdM+P2tM5oecr218iLbIu5AgK2jw+jzVpkU7CU28FGssFgBAEyObKvMbBkavvNJxxvIscsXpBnZTTmGSoEl8uSt1IADLAaDlrQCcfbHbgMMXhJ2vErQ/1620gpOHt5mdZIovGTNSky6MA5ryhx4YyfXgrQ5URdFjs5uRz6tjKdoBID5orok48Ri0fm+8ouaGZlaO2nRPbjiohb+Jip6YoJlTiTRgOkJUZB7+uH4hPOI80WlIRerwt0UCMahQi5F2KxRzeA7hsKW2IRTJE6b7R95tVSff13W6+iIdQtBfTUcZ6d+4JW8VvIz0UL+0AFYgcfdB2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i4Ig2P4AJiDJcbspqjDeWWeSXizbIhtWvGW0C+Gr0qo=;
 b=J+1eyoTQrI+WlqSui72cbAfDctplFV8XIE7/uzRu67LyoUsgL6rLL5u0ktxSamCtNPqF6MKhv1bfrAr5OL+GPkXxJNTJOknDy9CS1ZONYB8jO/+qDwY2Y03uv+NZIAn57QxV3kjkqhn9FodOBW/q36VMBY92HRBtY9M1m1Zrmey4Ha6R2D09LupWNQB0AO9/dBpDd1VHzkcFQNcPiuvHONguHpBZ8weyH7aCcZeS5qKYbhPaxJ+2kuPEZvtSUQs4367xmXGqYOvuBwye+RD2B7b4MPeea8aCx2D+tgMybk8HrtBtCUnK49W3aNH3/BjGTejG5yc29kJCTjg9cuLOVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i4Ig2P4AJiDJcbspqjDeWWeSXizbIhtWvGW0C+Gr0qo=;
 b=iSIGmotQvIeYVxAIzNFNb2wbBnTxZQIMJ1/Cvg+dsVe+1hcvawpKlXaOjmYqdtvwV0kEo/WAQMWTg55vz7+BCrAkmyEgd9s6hHEUHkOOHZ+XHYN2ocn5lNQslyPEvGyeJ8wAguZFHeh2/kdilOWWdU1m9EQc6j1EvsJm+ifEC9I=
Received: from VI1PR0502MB3006.eurprd05.prod.outlook.com (10.175.21.136) by
 VI1PR0502MB2989.eurprd05.prod.outlook.com (10.175.21.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.12; Mon, 6 Jan 2020 15:01:26 +0000
Received: from VI1PR0502MB3006.eurprd05.prod.outlook.com
 ([fe80::b9ec:a465:4659:7427]) by VI1PR0502MB3006.eurprd05.prod.outlook.com
 ([fe80::b9ec:a465:4659:7427%5]) with mapi id 15.20.2602.015; Mon, 6 Jan 2020
 15:01:26 +0000
Received: from reg-l-vrt-059-007.mtl.labs.mlnx (94.188.199.18) by AM4PR07CA0007.eurprd07.prod.outlook.com (2603:10a6:205:1::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2623.4 via Frontend Transport; Mon, 6 Jan 2020 15:01:25 +0000
From:   Noa Osherovich <noaos@mellanox.com>
To:     "dledford@redhat.com" <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Noa Osherovich <noaos@mellanox.com>
Subject: [PATCH rdma-core 0/2] pyverbs: Support CQ events properly
Thread-Topic: [PATCH rdma-core 0/2] pyverbs: Support CQ events properly
Thread-Index: AQHVxKIrl8t+qB4cg0Cq7kGD9RLctQ==
Date:   Mon, 6 Jan 2020 15:01:26 +0000
Message-ID: <20200106150115.14746-1-noaos@mellanox.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.21.0
x-clientproxiedby: AM4PR07CA0007.eurprd07.prod.outlook.com
 (2603:10a6:205:1::20) To VI1PR0502MB3006.eurprd05.prod.outlook.com
 (2603:10a6:800:b2::8)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=noaos@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.188.199.18]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d08eb74d-2b40-45b7-0f69-08d792b94d83
x-ms-traffictypediagnostic: VI1PR0502MB2989:|VI1PR0502MB2989:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0502MB2989D47C84D719825FE8CD78D93C0@VI1PR0502MB2989.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0274272F87
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(39860400002)(376002)(396003)(136003)(366004)(199004)(189003)(52116002)(71200400001)(4744005)(6486002)(2906002)(2616005)(956004)(1076003)(66556008)(64756008)(66946007)(66476007)(26005)(81166006)(6636002)(186003)(16526019)(81156014)(66446008)(86362001)(8676002)(6506007)(8936002)(316002)(110136005)(54906003)(6512007)(478600001)(4326008)(107886003)(36756003)(5660300002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0502MB2989;H:VI1PR0502MB3006.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4rzez1bt7bWMuqOsWDvrcCxODhQbNyHsnwfFi8Uug+j1XL8pu7GGJgKgBmBkAqPOAZZiDJ+bCPqAKOwjJ/LOEnP6Xn5X8StB+XHdEpyIzCmaKTPXvYZIGsF2n2c77kdDFAdgNcIrurMGJiOm28pIEDZ7mdif5wJlx1B1xarNUhQgXz6Vg91SMnIK34FtlgXSbJqWe1+36RJNLy2Zd2dB08lYDI6dpCtTN16T3f5i7aIeVcqAUSEir9pLgB9uY/WYkoecpqC1DUvj5imvAJZMw/3kVuyNfskmj0wB3cuI9GFuvUKep5B/enRTdDXsVzdf9lC4v5/7wm3D/yZ5h3IU8V9+tBrMQYci2+YFYVj/wfOET9opDFXclbTMB+OEEASuxeYpPkytrJT44Q5bHHViqaoDvRvaaplsRB9lhWa6N45GuBZyAjUYvUDvUCqqMrZi
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d08eb74d-2b40-45b7-0f69-08d792b94d83
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jan 2020 15:01:26.6652
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 78uFklAMY4LinqcDyV3EaX9QtaGKfjEzHn7A1+qz2eqhsHm1oYs5/DcgHqZUz0oxA1B2mZ2/+EEGYpJ6eFN7EQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0502MB2989
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

CQ events have to be acked prior to CQ destruction. Otherwise, CQ
destruction will wait indefinitely for those events to be acked.
In Python it's possible for a simple syntax error to cause a runtime
error which leads to teardown of all objects. For CQ, this can mean
a destruction without acking CQ events.

To avoid that, keep track of the number of events and during teardown,
if there are events that weren't acked, do so implicitly.

The first patch adds this support. The second one adds a simple
traffic test that uses CQ events mechanism rather than poll.

Noa Osherovich (2):
  pyverbs: Handle CQ events properly
  tests: Add a test for completion events

 pyverbs/cq.pxd          |  2 ++
 pyverbs/cq.pyx          | 14 ++++++++++++-
 tests/CMakeLists.txt    |  1 +
 tests/test_cq_events.py | 45 +++++++++++++++++++++++++++++++++++++++++
 tests/utils.py          | 11 +++++++---
 5 files changed, 69 insertions(+), 4 deletions(-)
 create mode 100644 tests/test_cq_events.py

--=20
2.21.0

