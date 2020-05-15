Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 780791D59BA
	for <lists+linux-rdma@lfdr.de>; Fri, 15 May 2020 21:14:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726168AbgEOTOD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 15 May 2020 15:14:03 -0400
Received: from mail-eopbgr130079.outbound.protection.outlook.com ([40.107.13.79]:26719
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726144AbgEOTOD (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 15 May 2020 15:14:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aFNo6flXH/yTwHsjTXxwEsld6Xwa4ua6WYJZ2jMsSeoz1ywFkpu98ZAkya5gCqQlO02Pff7XkSN63gxmo2OwMAwe4blPApupZ2eBQlOd72X2sLDu95Q1bXWddRQ2O8jDoqf4VGsRk6GK5JCw3dcFM/izEJ8Ych4m5SGo6n2YneW4D+v5vkDssi49Hq9vFA4/lpnaJ89QiOb/hxaBVKMJQVJGhPmoipZ2xiNGrPjp1wYA5en6n6J3V0IYItEqKtkox7JX0Yom+pRAb6y4ZSjwTP0BSD4KIDhOv9cY3iGCSwOGieea9O+2xEVR+rmAiMp19pct72Dr0PnauwxIrAF9qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=koYz9jOoshTDIO1GsrhbV5blvjrY1w2kxxK0mGdIsSA=;
 b=I4QgShHQ2TXsGcGA8w3SH+xKdyU/0yr32UUHKjX/SfLn7h/bQAyTCigP66rkD9xid2eFfP5wOj+WFssDwujRMJ8W5MPv0f1g1ZHzTA+ziUTIj5xdmOwHTDWbdqncKi3RUPB/P0OGSItZIO064IMM57vJiVHenKZTS52AlNc+oW6TqarKF9pjTS9090F9PZpUa7XotIUfib78X2rCPGZvlqVMy+3Y2XTTM1ZF3mK/Za86injclKHQK0gJfT92MdaRMiV8PYjUGEE0wOx3MKps6c8zNyAa521RW/BFNo2442qOxo70JH2ZbxgdUqIFogmNLqKIlcO+leMrhpd8fYiXrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=koYz9jOoshTDIO1GsrhbV5blvjrY1w2kxxK0mGdIsSA=;
 b=rbHhXo4HO9+RPed+BrOnoOx9m77V4W6h79j259jwcgAbXMjNGSf41bg1dqsxPsrcDe4dhODMPUtfHoRHqIpb/msXovCmmQmRNqkZVRx/yRqVLAZO0N88JSZUlOYECVPpYthPj1u30UGR/2s7RBCmlUBaty45A5BFkusucSbWQFs=
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=mellanox.com;
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (2603:10a6:803:44::15)
 by VI1PR05MB7150.eurprd05.prod.outlook.com (2603:10a6:800:178::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.25; Fri, 15 May
 2020 19:13:58 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::848b:fcd0:efe3:189e]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::848b:fcd0:efe3:189e%7]) with mapi id 15.20.3000.022; Fri, 15 May 2020
 19:13:58 +0000
Date:   Fri, 15 May 2020 16:13:54 -0300
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Doug Ledford <dledford@redhat.com>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Please pull RDMA subsystem changes
Message-ID: <20200515191354.GA17053@ziepe.ca>
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jI8keyz6grp/JLjh"
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MN2PR13CA0007.namprd13.prod.outlook.com
 (2603:10b6:208:160::20) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:44::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR13CA0007.namprd13.prod.outlook.com (2603:10b6:208:160::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.10 via Frontend Transport; Fri, 15 May 2020 19:13:57 +0000
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)     (envelope-from <jgg@mellanox.com>)      id 1jZfmM-0004TR-Fa; Fri, 15 May 2020 16:13:54 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4f3fa883-6a15-4fab-8528-08d7f9041e21
X-MS-TrafficTypeDiagnostic: VI1PR05MB7150:
X-Microsoft-Antispam-PRVS: <VI1PR05MB7150770BB1579D09C6028E0DCFBD0@VI1PR05MB7150.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:758;
X-Forefront-PRVS: 04041A2886
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: biSwnT+hVTKicQtv8V22TENVDv77HeX8GQghQPR+mgu0m888EqhQ2QU9YsuOWc2ju0av0KE74wCJVprzXHhMc1fZkyUsoJBKzrmPglLil6/QYep2su0M5QRd7x/LbbZDDT9bTvgMnosf+nQHjJma8RTeIMLwwHY1OV7+aAlxdhuW9/CMNLkuM1iphjGQcQ4ZePlSv7bVpGBvB7YDiRgqA91yjfGqu9se5xD8b1cs8ODGDF9huqjDOR/DUqw+BSWjMucGqFreIcodWHqJBwBctnyZyMyoRRJSiOa22Yd2yVvq5kGH1akTC292k+LC7/Valn9OWmVQdSjTR+pcdEw7eizk8eR92d/UbeaB8r87F+1j0UCwCq+artPBOv4nNZiGWOUayqRRnUioeeiPomBgYLZA4oKZqWbPnI/KVU2k3Kgi9yw3y5LaXo2Y1Qxh1v+9W1Hl1NtGfnMBh2QZtTHOos7+0Ayg0cdGs7Yi73rvL8F863L+BVFHhCQxKeWGVDqf7OVrPoUVdBmZl/fh1AZS/g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR05MB4141.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(39860400002)(346002)(366004)(396003)(136003)(44144004)(9686003)(1076003)(26005)(478600001)(8676002)(8936002)(52116002)(110136005)(186003)(33656002)(9746002)(316002)(9786002)(21480400003)(5660300002)(66476007)(66946007)(66556008)(36756003)(86362001)(4326008)(2906002)(24400500001)(2700100001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: QskU8oWAyzC27LvghmJbdTl1lG1YGi7guKQX3az5I1QS7WXmNBKAfkJYSEq7aAmUXXePVuyaBZ2mBc9grxEpCrOQUbhCXl4a0wxh4a4pxaOWPMhEbEQV20OLeY3zzIblePOOAwsm/GyQ5CpekftyOEsUs+klRSXGwpjDKMhIyr4794BsRFz8QyR6Hvor5vgNA8m1lL4q5FgInfsa3p/BvdExkTq53pkFwuT3zRIMZERz8buw4a5Zeqwgfxv0C2uTFoeZWJGmhx/33rfAa/6BWCz4uB5mWv6Wnz8hfECNfqP+623r4Ara9UwdMjmxsgpLtGMOuWWJzNL5Jggset+pcHVYOf8kP/S9BdoFst2p3JU/WetfQfAs1adF4xXvNcmIDjPGst0cuk5SUA5X/+cFZPxQW79nV9z4dRp1faXQwmjpaHt9M1rQPjfATfXuBbJXRjzdDS8u7w9sSQbXHVUz2GQIYZwZjX/cAY7OBGqftdQ=
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f3fa883-6a15-4fab-8528-08d7f9041e21
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2020 19:13:58.2729
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xm0yqxykr0jpNLlWqX3bmfoUuzcDbWHqRpmUUXqojgEByMARYaxzAAYuzcHgXKxFyqoyE9HQVSpE2UjixLVveg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB7150
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--jI8keyz6grp/JLjh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Second rc pull request

One regression, some syzkaller crashers and other long standing bugs for RDMA.

Thanks,
Jason

The following changes since commit 0e698dfa282211e414076f9dc7e83c1c288314fd:

  Linux 5.7-rc4 (2020-05-03 14:56:04 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

for you to fetch changes up to ccfdbaa5cf4601b9b71601893029dcc9245c002b:

  RDMA/uverbs: Move IB_EVENT_DEVICE_FATAL to destroy_uobj (2020-05-12 17:02:25 -0300)

----------------------------------------------------------------
Second RDMA 5.7 rc pull request

A few minor bug fixes for user visible defects, and one regression:

- Various bugs from static checkers and syzkaller

- Add missing error checking in mlx4

- Prevent RTNL lock recursion in i40iw

- Fix segfault in cxgb4 in peer abort cases

- Fix a regression added in 5.7 where the IB_EVENT_DEVICE_FATAL could be
  lost, and wasn't delivered to all the FDs

----------------------------------------------------------------
Dan Carpenter (1):
      i40iw: Fix error handling in i40iw_manage_arp_cache()

Denis V. Lunev (1):
      IB/i40iw: Remove bogus call to netdev_master_upper_dev_get()

Jack Morgenstein (2):
      IB/mlx4: Test return value of calls to ib_get_cached_pkey
      IB/core: Fix potential NULL pointer dereference in pkey cache

Jason Gunthorpe (2):
      RDMA/uverbs: Do not discard the IB_EVENT_DEVICE_FATAL event
      RDMA/uverbs: Move IB_EVENT_DEVICE_FATAL to destroy_uobj

Maor Gottlieb (1):
      RDMA/core: Fix double put of resource

Mike Marciniszyn (1):
      IB/hfi1: Fix another case where pq is left on waitlist

Potnuri Bharat Teja (1):
      RDMA/iw_cxgb4: Fix incorrect function parameters

Sudip Mukherjee (1):
      RDMA/rxe: Always return ERR_PTR from rxe_create_mmap_info()

 drivers/infiniband/core/cache.c                    |  7 +++--
 drivers/infiniband/core/nldev.c                    |  3 +--
 drivers/infiniband/core/rdma_core.c                |  3 ++-
 drivers/infiniband/core/uverbs.h                   |  4 +++
 drivers/infiniband/core/uverbs_main.c              | 12 +++------
 .../infiniband/core/uverbs_std_types_async_fd.c    | 30 +++++++++++++++++++++-
 drivers/infiniband/hw/cxgb4/cm.c                   |  7 +++--
 drivers/infiniband/hw/hfi1/user_sdma.c             |  4 ---
 drivers/infiniband/hw/i40iw/i40iw_cm.c             |  8 ------
 drivers/infiniband/hw/i40iw/i40iw_hw.c             |  2 +-
 drivers/infiniband/hw/mlx4/qp.c                    | 14 +++++++---
 drivers/infiniband/sw/rxe/rxe_mmap.c               |  2 +-
 drivers/infiniband/sw/rxe/rxe_queue.c              | 11 +++++---
 13 files changed, 68 insertions(+), 39 deletions(-)

--jI8keyz6grp/JLjh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfB7FMLh+8QxL+6i3OG33FX4gmxoFAl6+6fAACgkQOG33FX4g
mxq5rw//WMmFFrYdArHlWydTg/EPBEQzUNPg+C7idphBai0qbDDDdXo4ysyPsp3/
spgKItRzWFxs06rq6rsvc/bWoqtyYijK5liLeUSs0ymZhx48BuIS4XNkloP8lnYb
3YqAZcYQ+EylmoyMJguJZ39AVOQKSW2LagLznR4+NgUhkdJ69RcrvxK+7WkfyfRU
Ukdb1Uq3D6d9aNJsJNFDoLZiyMSPQlLoinXpRG+Wkz0mFYetprYBlD3eltDIAyF8
P3iUoK6Ak5cJBcHFe0a8twcz6nfI978PTFJkdajJuqnuWfhpJ9qb8aOgzXCoknQx
DVXosWfuEoIWdJ8BIPlb7ffViv1pfoaJb163EhjcB2yZrRf2I4kuWWcSSLQFLEDk
1FxoSAydn2IyzAYXyNeRru5jL2m8jgl/mgHVi5pSnpkruzlAb4QwBZF5ScHr24FL
oLLVK+fnWwBdJwQ32R/LKQpwtDZrKmZ/ca+NE7G4kT7+0rORu2wUN4yTwzclMqbI
vAxrt1eG/kwRL3SPLX166mbCGdiU8uUlLh0ZN3qolLxowHtLOnWx7HLmonaxFtVB
M2EaxZIz44EZKpdXniEtSibhz441DHPBzEfHSNQqITGmq92Dz483obKgm+EE22ef
ukHT4w9FCYXZmQmSL4RvtYhJ30jU6E+lYfQMZzNeAEtbRpPbgVo=
=Jo3t
-----END PGP SIGNATURE-----

--jI8keyz6grp/JLjh--
