Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5019963625
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Jul 2019 14:46:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726260AbfGIMql (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 9 Jul 2019 08:46:41 -0400
Received: from mail-eopbgr150047.outbound.protection.outlook.com ([40.107.15.47]:16353
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726025AbfGIMql (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 9 Jul 2019 08:46:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4/N5PJixRF/pzBsNfOzO9seIwSzPAxNM9h76EGIig/Q=;
 b=Y5Kdx6o4j2kPdk2Ud3AqxFSbO57IML2hrgvE2cOEs5QpEPTrlvfYpV30Z+erh63MlhLxRcv0GavbbmlQSTCH1+tx0UuED4XXNa7hEY8kdqvzDh/nT6bX3DuZpXx1bg6xiE5ID9COCc408H2SgSmEOgtmBWvzUz8H7/GOnchDuwU=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB3488.eurprd05.prod.outlook.com (10.170.239.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.19; Tue, 9 Jul 2019 12:46:35 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::f5d8:df9:731:682e]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::f5d8:df9:731:682e%5]) with mapi id 15.20.2052.020; Tue, 9 Jul 2019
 12:46:35 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Leon Romanovsky <leonro@mellanox.com>
CC:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Doug Ledford <dledford@redhat.com>,
        Mark Zhang <markz@mellanox.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Majd Dibbiny <majd@mellanox.com>,
        asahiro Yamada <yamada.masahiro@socionext.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the rdma tree
Thread-Topic: linux-next: build failure after merge of the rdma tree
Thread-Index: AQHVNgammxAPVHu9ZUGmGGyqfZIntqbB3P0AgAAD1gCAAFvJgA==
Date:   Tue, 9 Jul 2019 12:46:34 +0000
Message-ID: <20190709124631.GG3436@mellanox.com>
References: <20190709133019.25a8cd27@canb.auug.org.au>
 <ba1dd3e2-3091-816c-c308-2f9dd4385596@mellanox.com>
 <20190709071758.GI7034@mtr-leonro.mtl.com>
In-Reply-To: <20190709071758.GI7034@mtr-leonro.mtl.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BL0PR05CA0010.namprd05.prod.outlook.com
 (2603:10b6:208:91::20) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [156.34.55.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cbf098bc-1611-42c0-b5ab-08d7046b79d6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR05MB3488;
x-ms-traffictypediagnostic: VI1PR05MB3488:
x-microsoft-antispam-prvs: <VI1PR05MB34880B3AA105A8D17848F79ECFF10@VI1PR05MB3488.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 0093C80C01
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(346002)(136003)(376002)(39860400002)(396003)(189003)(199004)(476003)(229853002)(4326008)(5660300002)(25786009)(486006)(64756008)(73956011)(66446008)(2906002)(66476007)(33656002)(66556008)(11346002)(2616005)(446003)(66946007)(6862004)(256004)(316002)(6636002)(66066001)(52116002)(6436002)(6116002)(478600001)(8936002)(3846002)(6512007)(102836004)(6246003)(99286004)(305945005)(86362001)(6486002)(76176011)(71190400001)(71200400001)(1076003)(81156014)(37006003)(14454004)(54906003)(26005)(186003)(68736007)(7736002)(53546011)(6506007)(386003)(53936002)(36756003)(8676002)(81166006);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB3488;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Q0UqfFoLS3o2pYajh3rlfdUaJbBtTDK6D216rdolM2MLlCWQBk4QpVwZJEn89oa+KCgmpmzk1Wcp832iVcTaRcYLVTNDbWZgKqa3MJfSvU+4VX7syUPGpADHiYcj6uqvi7PXTV0vwDLU3KOt75mNpsmCravOQb2VDNRGczd1w86wMLoBviN4jVLY5RUawIpneN6bATl3SaPvMghTK5cFLSzlUWRIjN4osDKDgmNdgKTV1OTnIeq6gZuqFoHHiWy3TpxyA+IJZKE4S2ZWt9CGSjWR10ZjrN1yt6OLhWSH8QTFtc0D7O3LjWa45T12OL4XvuAiYJvZi3rgSFZ0vyXpDuX9SGvzBoz2cHIwU0f+n8FnTJCnFD8syvCGi+vZ4fKD3l265b6hq+i1dVQFR672Pb9H/NW7IHZWAFqkHcQU8BQ=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D0FB6701F9C8824F8CE3DC494613D3C9@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbf098bc-1611-42c0-b5ab-08d7046b79d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2019 12:46:35.0069
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jgg@mellanox.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB3488
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jul 09, 2019 at 04:18:00AM -0300, Leon Romanovsky wrote:
> On Tue, Jul 09, 2019 at 10:04:16AM +0300, Mark Zhang wrote:
> > Hi Stephen,
>=20
> Stephen,
>=20
> For some reason, I wasn't in initial email report, can you please check w=
hy?
>=20
> I need to be aware of any issues related to patches with my name on it
> for tracking and improving internal submission flows/checks.
>=20
> >
> > Can you please try the patch below, thank you.
>=20
> Jason, Doug,
>=20
> Can you please take this patch?

It isn't quite enough to make the header compile stand alone, I'm
adding this instead.

From 37c1e072276b03b080eb24ff24c39080aeaf49ef Mon Sep 17 00:00:00 2001
From: Jason Gunthorpe <jgg@mellanox.com>
Date: Tue, 9 Jul 2019 09:44:47 -0300
Subject: [PATCH] RDMA/counters: Make rdma_counter.h compile stand alone

5.4-rc1 will have new compile time debugging to test that headers can be
compiled stand alone. Many rdma headers are already broken and excluded
from the mechanism, however to avoid compile failures during the merge
window fix enough so that the newly added header compiles clean.

Fixes: 413d3347503b ("RDMA/counter: Add set/clear per-port auto mode suppor=
t")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Mark Zhang <markz@mellanox.com>
---
 include/rdma/rdma_counter.h | 2 +-
 include/rdma/restrack.h     | 5 +++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/rdma/rdma_counter.h b/include/rdma/rdma_counter.h
index 68827700ba957e..eb99856e8b3078 100644
--- a/include/rdma/rdma_counter.h
+++ b/include/rdma/rdma_counter.h
@@ -9,10 +9,10 @@
 #include <linux/mutex.h>
 #include <linux/pid_namespace.h>
=20
-#include <rdma/ib_verbs.h>
 #include <rdma/restrack.h>
 #include <rdma/rdma_netlink.h>
=20
+struct ib_device;
 struct ib_qp;
=20
 struct auto_mode_param {
diff --git a/include/rdma/restrack.h b/include/rdma/restrack.h
index 4041a4d96524b4..b0fc6b26bdf531 100644
--- a/include/rdma/restrack.h
+++ b/include/rdma/restrack.h
@@ -14,6 +14,9 @@
 #include <uapi/rdma/rdma_netlink.h>
 #include <linux/xarray.h>
=20
+struct ib_device;
+struct sk_buff;
+
 /**
  * enum rdma_restrack_type - HW objects to track
  */
@@ -52,8 +55,6 @@ enum rdma_restrack_type {
 	RDMA_RESTRACK_MAX
 };
=20
-struct ib_device;
-
 /**
  * struct rdma_restrack_entry - metadata per-entry
  */
--=20
2.21.0

