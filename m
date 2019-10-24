Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6F0DE2A31
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Oct 2019 08:00:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437664AbfJXGAt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 24 Oct 2019 02:00:49 -0400
Received: from mail-eopbgr50068.outbound.protection.outlook.com ([40.107.5.68]:21413
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2437662AbfJXGAt (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 24 Oct 2019 02:00:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZRbwsH7ehywOZG8h7xinvgroR83wmmsIIoyOpi23RXC5pTL27AQpfXSYBMI+EvP1Zmsz/k746RID4x/+40pbiUYOfJpfD/jGR+EMyOiGfHKyQWAtGDyGaWSHASKeAttBmakR6PbAV5fE92AkT34gmSTQK6uD+BDu0Jc/kIO9zZ4s+48FSEKdqav8GpoS/KDoeqUuvycxR0EKpi4NXLeFUWElnPdlbi6+NSyqTAFBiHfIpyRhqNVXq9U6MA7EtcwQiT6bF2Fl8fO9zEju72Jk+aFdxHbb9aJdYyHRxclRVS7xtaQBexjm4pTZ15YK6emJgEg8WoRF9mbzWOBJB9imTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1cPlBwdKl3PQ/0oFaA9yaTRrWvkwe3YBS8lD+yasjV8=;
 b=lbalNLo2B1oNS7AA8xrVgvLN4zyZurgrNRlcMMJF0AR42td34kCoRcwsLckKQKJp88sxVGoP836uzGCCgYXZ/U80BNa8/yPbZDwQts/stRbEzDnDtl+tumkLC2qgtFEPFFQ6jJvxzaHLqZxkGcErNkGQaMzB3AUeEREKOnjFlMkHk5JBIAkUHzX9cK36vg1TyXtFWGQESzFAlkkYQnnIL0rQby4yWT2dQ6dYI0fUWwlIyTkksQ7MoxyxGAou1A6pKm/ICj1j8R0oBb7uf44/mDSWLrZwFuqsd6S1QkfG57Z9/GuzLMOMdBVSIpCNy+yvhEI4FWcPmxCefWYXwVA4Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1cPlBwdKl3PQ/0oFaA9yaTRrWvkwe3YBS8lD+yasjV8=;
 b=GpcMVyMPSmjsxcmKXpWWcuRN6r5H/9RsN5Hv3Ngkk/t7lLD0q+nSCuB0ebOTu6do3GJoaCGWB4dgX0KFAIUTvZpMi6zNPnYVyjvMlJ7w1EkNPWNiY1jXUCfOWTzHG8dZCRCi6eWse/cVYxnM9wuIXt3UEL7Gg6zNpU4V34wjvg8=
Received: from AM6PR05MB4968.eurprd05.prod.outlook.com (20.177.33.17) by
 AM6PR05MB4182.eurprd05.prod.outlook.com (52.135.164.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.21; Thu, 24 Oct 2019 06:00:46 +0000
Received: from AM6PR05MB4968.eurprd05.prod.outlook.com
 ([fe80::ecbd:11b3:e4e9:fa1a]) by AM6PR05MB4968.eurprd05.prod.outlook.com
 ([fe80::ecbd:11b3:e4e9:fa1a%5]) with mapi id 15.20.2347.029; Thu, 24 Oct 2019
 06:00:46 +0000
From:   Noa Osherovich <noaos@mellanox.com>
To:     "dledford@redhat.com" <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Noa Osherovich <noaos@mellanox.com>
Subject: [PATCH rdma-core 0/4] pyverbs: Introducing mlx5 DV support
Thread-Topic: [PATCH rdma-core 0/4] pyverbs: Introducing mlx5 DV support
Thread-Index: AQHVijBgBd8S03+xQEinEanFIgBkzg==
Date:   Thu, 24 Oct 2019 06:00:46 +0000
Message-ID: <20191024060027.8696-1-noaos@mellanox.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.21.0
x-clientproxiedby: AM0PR05CA0081.eurprd05.prod.outlook.com
 (2603:10a6:208:136::21) To AM6PR05MB4968.eurprd05.prod.outlook.com
 (2603:10a6:20b:4::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=noaos@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.188.199.18]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 562d6df4-405d-4cc8-a4d0-08d75847830d
x-ms-traffictypediagnostic: AM6PR05MB4182:|AM6PR05MB4182:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR05MB418296657B26B2A53F16E007D96A0@AM6PR05MB4182.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 0200DDA8BE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(39860400002)(376002)(366004)(346002)(396003)(199004)(189003)(478600001)(71200400001)(86362001)(486006)(71190400001)(2501003)(2616005)(52116002)(476003)(4326008)(110136005)(54906003)(66946007)(66476007)(66556008)(66446008)(64756008)(6636002)(14454004)(99286004)(19627235002)(107886003)(26005)(186003)(305945005)(7736002)(316002)(66066001)(6506007)(386003)(3846002)(36756003)(256004)(102836004)(8936002)(50226002)(1076003)(6116002)(2906002)(81156014)(81166006)(6436002)(6512007)(6486002)(5660300002)(25786009)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR05MB4182;H:AM6PR05MB4968.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: W/ta4A5Huo4Hw1Viw5RCpyrhpxx2GZipfvodd9HMrn9Kvucq+o4pv5q4ugNTrkr0Auoh1MKeB0Nrt6qGuc6SPfVI3aF1y2DywTR9aeHpT+M2csxcz8tE/RApDKVA+YgmOo/F0ujhTiagwE7Ui0e/W91yOpJ/wjO7NWzVVJd9RLqO8HFhk3PdKneTWdWDq8EsQeaOyYF7sAMB5rRfZigSexN9oAucGajQQ5a/QtXggabs+sh5ALY0auTxVpPRf2b5zgwL/L3JKRhW59vOwwOMf6owZiBiympJ8/4vvekj7oek1tPzpXzGc7VDM6eZ2Cyu4DT0cJi779WKrwP5KGrF2kGNb00Xs3xDC7ZVeilW0utbfxp4wiG5kX3Lcx+dwxAJKctyJVf30DXpukzhDAazlRjbypkDeVnItt91TNjF1NFIWWsVUVSy/6Pq3Lidfsg5
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 562d6df4-405d-4cc8-a4d0-08d75847830d
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2019 06:00:46.2735
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XNaJelpk7yVTY+32+s+4lpwHjwvDo6shILgXu0YYJbCXSYZv6usNM6pu6JnUEU655zeHQA5cuEysM4BIuodgwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB4182
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Direct verbs (DV) provide fast data path execution. This series
introduces the DV infrastructure to pyverbs:
Allow providers to open contexts rather than use ibv_open_device.
Add Mlx5Context and expose the mlx5dv_query_device.

Noa Osherovich (4):
  pyverbs: Add support for providers' context
  pyverbs/mlx5: Add support for driver-specific context
  pyverbs: Add providers to cmake build
  pyverbs/mlx5: Add query device capability

 buildlib/pyverbs_functions.cmake        |  11 +-
 pyverbs/CMakeLists.txt                  |   7 +-
 pyverbs/device.pxd                      |   1 +
 pyverbs/device.pyx                      |  17 +-
 pyverbs/providers/__init__.pxd          |   0
 pyverbs/providers/__init__.py           |   0
 pyverbs/providers/mlx5/CMakeLists.txt   |   7 +
 pyverbs/providers/mlx5/__init__.pxd     |   0
 pyverbs/providers/mlx5/__init__.py      |   0
 pyverbs/providers/mlx5/libmlx5.pxd      |  46 +++++
 pyverbs/providers/mlx5/mlx5_enums.pyx   |   1 +
 pyverbs/providers/mlx5/mlx5dv.pxd       |  17 ++
 pyverbs/providers/mlx5/mlx5dv.pyx       | 253 ++++++++++++++++++++++++
 pyverbs/providers/mlx5/mlx5dv_enums.pxd |  47 +++++
 pyverbs/qp.pyx                          |   2 +-
 15 files changed, 400 insertions(+), 9 deletions(-)
 create mode 100644 pyverbs/providers/__init__.pxd
 create mode 100644 pyverbs/providers/__init__.py
 create mode 100644 pyverbs/providers/mlx5/CMakeLists.txt
 create mode 100644 pyverbs/providers/mlx5/__init__.pxd
 create mode 100644 pyverbs/providers/mlx5/__init__.py
 create mode 100644 pyverbs/providers/mlx5/libmlx5.pxd
 create mode 120000 pyverbs/providers/mlx5/mlx5_enums.pyx
 create mode 100644 pyverbs/providers/mlx5/mlx5dv.pxd
 create mode 100644 pyverbs/providers/mlx5/mlx5dv.pyx
 create mode 100644 pyverbs/providers/mlx5/mlx5dv_enums.pxd

--=20
2.21.0

