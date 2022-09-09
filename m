Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FA045B3CD0
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Sep 2022 18:17:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbiIIQRZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 9 Sep 2022 12:17:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbiIIQRY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 9 Sep 2022 12:17:24 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2060.outbound.protection.outlook.com [40.107.212.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6611C129C46;
        Fri,  9 Sep 2022 09:17:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U3xlshPziAWB+Cca6cMTDkPO9wyRzvZeQsJUqaosOudt/kXKdaDtyRGP4v/Ow6x6l+ecfYHC3n0izwUNz3niOhFMeO55UCh+gD62azJHnk8pY6OE20ICB8kGZJWxETNIMkMxPWq0zwNRiDX0VTlcVQbV3Q4+QXiv9DkR9NNbI17SYVdIPHWLkSynqwUp231mXlL2hHOpDqOplRZU9Gr7XZw8wp+4IL/8OsdvZEcQrMLolgQACSGb67fq+Rj9rHgqwE2syNzQ04BMKodoZQMibL389Ybmv3qT2WJqxRse430hhjEIT+XMxUDVGb5+zYJSfS05X6YazhmUx1nBd2eNSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3nNveRijasp2Pc8u5JKnafgQ0U0m3oxUDforTb785XY=;
 b=EPj4RNatUtcD4prEJ7l+CFMnxoLY9TpyRfFsviXwoL0qLwnRwjPYDxH+NYZIglpMa9EurLOVpdGG94megrIpcQsTpLXg1B8yCOAgA2gC5h8vJ0hcAfLpRm3D4F/OcyjChQUoBrTman7mD6qdRGDQOYh0E8a5U4Py/bEP4XpgJIbxjVjBhNvXMMRbRGftstrvcGZvwgw9U8lkss40IhDTsGWn2wva3u7junSP5fM1QKFkG1tj3Aa9+1D2ydZ++DnNWPSz+xD+WIcZLBjEwJtm6tLTbwuP8QEFYSCm+9DoAwmE76AODnds/kMSsL1Kxede5aQwHZUwNhMO+rUWXIA8wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3nNveRijasp2Pc8u5JKnafgQ0U0m3oxUDforTb785XY=;
 b=G4Jh3KQ9hM2/RYwHWMmnLD3Bb8YfljXiZudPG7rzAz4RBkVY+MZtWZQX2/nPgJi7tYyK4jwU8vK7iuAeMB842VD6eo1YtSBt7tBFcg/amahJlK5g1gQpcW+n+OSF1EbPpolmF5oBVSbyRDeaJZjJPqnLu4NPay3R4HV8L6YKcJMo81bKF7YNBh4BIuZRho0ViwM6BTdYfNL9bTQRDLAKnypPPWXwdHKJjQ2OJdgqIERIqDDigCjtjPHcND7YRA3VTNBd30CkBfIvIVi6b99xcFL7xGDE0FYK38hZF4md4rwJPMJApBs+C/G3t+I/7G15M2m5EqcrTSGqQrZE/jqpiw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by BL1PR12MB5125.namprd12.prod.outlook.com (2603:10b6:208:309::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12; Fri, 9 Sep
 2022 16:17:20 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5%7]) with mapi id 15.20.5612.019; Fri, 9 Sep 2022
 16:17:20 +0000
Date:   Fri, 9 Sep 2022 13:17:19 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Leon Romanovsky <leonro@nvidia.com>
Subject: [GIT PULL] Please pull RDMA subsystem changes
Message-ID: <YxtnD/fPifXhPxc/@nvidia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="8fM1q9bom9MbGzKe"
Content-Disposition: inline
X-ClientProxiedBy: MN2PR10CA0026.namprd10.prod.outlook.com
 (2603:10b6:208:120::39) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4192:EE_|BL1PR12MB5125:EE_
X-MS-Office365-Filtering-Correlation-Id: a0c85b9b-570f-44a5-46a8-08da927ec5b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UtRDafKxKUFPZWgfSiYQ35RdRw5G/vIW1s5FeW7nBcIRXRK94JpJHJ0WaBpRL66Q4p8VE5QyW/6lAEshmkUaxJWcmH4HFmPw303RRLnCmjLfloz8Wjot0lg61cem/+cTpvgSoP7+hw2aabC/6k7o7dP2KYIbxHiSy8CQfY8M/ZVZ2AryufTkXZvg7IzkNKWpD/i6ofRt11UmlVNEDBNtFP7TbQG/Q0c7gYMx96t6s6IMsb7ZdDnO/wtAf3hxrCf+BNUBh2QqL8sikQfD395xLMXcgaXczS+eWxBqbo3P43yHXQnYY+B3aELoR6VLYB1FFcyNUL0WVqAreSS3/8hNdB1aLFX6ONb+uI2sLsFix1lfuE1ZWZhlDIYXvw/qOCuxL6J11GSohFVZwrUq+bGfJwqDn/WX+Sdc5S7ZMQ/5lL39HlWRPoRFEaHfbttYIxlyMsvdsPTyusdA/w1Q2QG4Y29rOFkg1xca+5ZLwikSx695nbzcAN4/TAHAvm6TsWAjYL33fuU3nOy4JOtOzEFA9RSTu99xjeHna/X2B1F/xsq69/5ySSAUXk3SlBBkisBo/7+5FqkbmOkN2giXeTWH522mfOLr1LO/e1m0dJuqshV6oXuWR+vgwvTfcQswM8pQtwGfwV78nVzbgxKvZycEFpEx9pTq+1oB/qExGCemLbbN3KgmJE1T0QJb7Vddh78gVRkXaGiHEfO8fvEjk3SNDKCQpHtAU73ajUbUguWukuKOf8iXcxCJNQL6rjYAYlB480DUKQawLAylJ5rzyTQU9A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(376002)(136003)(366004)(39860400002)(396003)(4326008)(316002)(66946007)(66556008)(66476007)(8676002)(38100700002)(6916009)(2616005)(2906002)(5660300002)(8936002)(107886003)(186003)(83380400001)(21480400003)(6486002)(478600001)(44144004)(6512007)(41300700001)(26005)(6506007)(86362001)(36756003)(2700100001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TeoWKdmZEC2COTiLPAnObwt/jEL+tRY9soSpToExS/fe8r9KlnIyC2z/G26G?=
 =?us-ascii?Q?ld5ZpyVlozBu929TXS9EFChyl71ZD0pRwFdEpUbp7u4vYzom2RIIjwCYQmZc?=
 =?us-ascii?Q?4fcjZmqoh9JcSk6doDgUVk1GdsiqJ+e7iTbktRVr+/QADILRgUQ1wL1Jq+1T?=
 =?us-ascii?Q?Gai67MtJk+dlbqLdcFQ/GjRr33jcymnxjk+vdbrd55jkhVDTSPKjS/j1PMGm?=
 =?us-ascii?Q?Dx+WqleVcy2k6UVkVUYdp6R2eikPhDiRi9U0ShSFyrOAY3cRdLEVwoJ9IywC?=
 =?us-ascii?Q?hKM1jCxCzXTlYmcppBMgM6hajq8Ou0R78pzncdQinmYQO7ZPkyHsJZ4v6TUf?=
 =?us-ascii?Q?VVmoMFWl3Ww2RAdkUpcFJZOsxxrs9jQlNDzM8fTySqsIT/01c4R6tqtYFY0w?=
 =?us-ascii?Q?QediPZZmcjYClkqPc6BS1PmJoU4hIxi+YmrsehWqlX/GK6Fq+i+54N7m6Rn8?=
 =?us-ascii?Q?WjG75g4jSZluc8RGMO6Ua08JVB/cENAdI16i4xG4sKOKTMeS+kKj7KJGfI8/?=
 =?us-ascii?Q?chaHrRb8qC+fQcfMLVKS12qkxHl1Q5dtgFv1sl5P+uBqlaXOn3Rv6G6tnQX4?=
 =?us-ascii?Q?UuPPiTR4mnv3tvrDWKZTUbF2pLCtBfJ0IPnbxLVimuN/gC//OO/8imv9Ktv4?=
 =?us-ascii?Q?dl59TLz/2iE3NA+BWHYvJQBUtgQhYFzEp9Btg0SKsEvaJ+f4WDTumYATTpqK?=
 =?us-ascii?Q?ZSWbaPB6/0dqrwXgDtkVpfddOEVHlgNBIe3opGuAG8N3zAjI0mgE6I7qJZf4?=
 =?us-ascii?Q?oAfYHx3F/osxxhrSEoG1WHSJC9Renz0HuWa5MjRT4yvyKixDfrkYqrCjA1e9?=
 =?us-ascii?Q?yzQGV/P7ilGLLTJPOcfCaKbLlZ8DDiSC3r7FVuPsj39nDsJzt21gEo6C/4Ly?=
 =?us-ascii?Q?FXtZ49mHjXnZKBMr8gxHmsUGU9TGSTv5MTjA1qP62ocPVNrVzlcxyiCykIVe?=
 =?us-ascii?Q?5aOX7mjA2HxsWYkzG4cHCKvnf0bCWPKBruBuJS4t/opswEITLDvQi++t7yhI?=
 =?us-ascii?Q?d9oyPw8/WnDXUJTZdSk2TXuifrDf85RRczPeErk/d30DRKAxTgKSzY8G5QMd?=
 =?us-ascii?Q?YI6y9Y2e8zdReVtwrT/neEZTO0xlaS6BOeRNlgAVMp3g4wgCdkVsQmGQlmBl?=
 =?us-ascii?Q?ZeJxKm25iKtFRZVx9y4bTV4xNH6z212Fe3JPD5WOZbJ+mvvg6IhSgBHellpo?=
 =?us-ascii?Q?uhPhWRHzPJY9ui25HrhWv6LSh6RYl8DQhTUzpe215Px96JS/y6HEvL4+pXZx?=
 =?us-ascii?Q?bDYD1ZdgkAibuv7naP+Gw18lEx2TpPW2/Pfkpid3SOojacSHlkzn4niqyMMy?=
 =?us-ascii?Q?4QmEOOUTRy3E9HHaPa6CQyfufb47ZxHRRXmhGZN8SSN8T95NJHR68NsmaXyH?=
 =?us-ascii?Q?SCzQx53/TC5pE2q57FrbUH6xqSDGCyc6F8BoPgKrom48v1HEWAeDGKBdjKzY?=
 =?us-ascii?Q?ZXnrAJmW0ojrIwMFKNEMxBt+X0xiUpRf/k2oTX7oek2DuFWxuNYQsyDykskK?=
 =?us-ascii?Q?9SNT62L7qdS2nJ+PSXFCJRyp0+R5NSONXe9Tg23mKnjpa27qzvhxHGBR6SaF?=
 =?us-ascii?Q?0QSZ/EuiyPWC6hXVpOPoWgmQfbovojnZaUMbzEMA?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0c85b9b-570f-44a5-46a8-08da927ec5b2
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2022 16:17:20.7768
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8TO8Y3f9Kvtvn6XBDgxR9bxzQwvascSxuJvTWP+oX6m0c1oWLL1/dBkzjwQVF3Oj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5125
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--8fM1q9bom9MbGzKe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

This seems unusually big for the second pull request from RDMA. irdma
is the usual new driver fixes, but the rest seems to just be people
testing into obscure corners.

The out-of-subsystem change to fork.c is to export mmput_async() as we
can't do the synchronous put due to held locks and interaction with
mmu notifiers.

Thanks,
Jason

The following changes since commit b16de8b9e7d1aae169d059c3a0dd9a881a3c0d1d:

  RDMA: Handle the return code from dma_resv_wait_timeout() properly (2022-08-16 17:13:23 +0300)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

for you to fetch changes up to a261786fdc0a5bed2e5f994dcc0ffeeeb0d662c7:

  RDMA/irdma: Report RNR NAK generation in device caps (2022-09-07 11:22:18 +0300)

----------------------------------------------------------------
v6.0 second rc pull request

Many bug fixes in several drivers:

- Fix misuse of the DMA API in rtrs

- Several irdma issues: hung task due to SQ flushing, incorrect capability
  reporting to userspace, improper error handling for MW corners, touching
  an uninitialized SGL for during invalidation.

- hns was using the wrong page size limits for the HW, an incorrect
  calculation of wqe_shift causing WQE corruption, and mis computed
  a timer id.

- Fix a crash in SRP triggered by blktests

- Fix compiler errors by calling virt_to_page() with the proper type in
  siw

- Userspace triggerable deadlock in ODP

- mlx5 could use the wrong profile due to some driver loading races,
  counters were not working in some device configurations, and a crash on
  error unwind.

----------------------------------------------------------------
Chengchang Tang (1):
      RDMA/hns: Fix supported page size

Chris Mi (1):
      RDMA/mlx5: Set local port to one when accessing counters

Jack Wang (2):
      RDMA/rtrs-clt: Use the right sg_cnt after ib_dma_map_sg
      RDMA/rtrs-srv: Pass the correct number of entries for dma mapped SGL

Linus Walleij (1):
      RDMA/siw: Pass a pointer to virt_to_page()

Maher Sanalla (1):
      RDMA/mlx5: Rely on RoCE fw cap instead of devlink when setting profile

Maor Gottlieb (1):
      RDMA/mlx5: Fix UMR cleanup on error flow of driver init

Michael Guralnik (1):
      RDMA/cma: Fix arguments order in net device validation

Shiraz Saleem (1):
      RDMA/irdma: Fix drain SQ hang with no completion

Sindhu-Devale (5):
      RDMA/irdma: Report the correct max cqes from query device
      RDMA/irdma: Return error on MR deregister CQP failure
      RDMA/irdma: Return correct WC error for bind operation failure
      RDMA/irdma: Use s/g array in post send only when its valid
      RDMA/irdma: Report RNR NAK generation in device caps

Wenpeng Liang (2):
      RDMA/hns: Fix wrong fixed value of qp->rq.wqe_shift
      MAINTAINERS: Update maintainers of HiSilicon RoCE

Yishai Hadas (1):
      IB/core: Fix a nested dead lock as part of ODP flow

Yixing Liu (1):
      RDMA/hns: Remove the num_qpc_timer variable

yangx.jy@fujitsu.com (1):
      RDMA/srp: Set scmnd->result only when scmnd is not NULL

 MAINTAINERS                                    |  2 +-
 drivers/infiniband/core/cma.c                  |  4 ++--
 drivers/infiniband/core/umem_odp.c             |  2 +-
 drivers/infiniband/hw/hns/hns_roce_device.h    |  1 -
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c     |  3 +--
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h     |  4 ++--
 drivers/infiniband/hw/hns/hns_roce_main.c      |  2 +-
 drivers/infiniband/hw/hns/hns_roce_qp.c        |  7 ++-----
 drivers/infiniband/hw/irdma/uk.c               |  7 +++++--
 drivers/infiniband/hw/irdma/utils.c            | 15 +++++++++------
 drivers/infiniband/hw/irdma/verbs.c            | 13 ++++++++++---
 drivers/infiniband/hw/mlx5/mad.c               |  6 ++++++
 drivers/infiniband/hw/mlx5/main.c              |  2 +-
 drivers/infiniband/hw/mlx5/mlx5_ib.h           |  1 +
 drivers/infiniband/hw/mlx5/umr.c               |  3 +++
 drivers/infiniband/sw/siw/siw_qp_tx.c          | 18 ++++++++++++++----
 drivers/infiniband/ulp/rtrs/rtrs-clt.c         |  9 +++++----
 drivers/infiniband/ulp/rtrs/rtrs-srv.c         | 14 +++++++-------
 drivers/infiniband/ulp/srp/ib_srp.c            |  3 ++-
 drivers/net/ethernet/mellanox/mlx5/core/main.c | 23 +++++++++++++++++++++--
 include/linux/mlx5/driver.h                    | 19 ++++++++++---------
 kernel/fork.c                                  |  1 +
 22 files changed, 105 insertions(+), 54 deletions(-)

--8fM1q9bom9MbGzKe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRRRCHOFoQz/8F5bUaFwuHvBreFYQUCYxtnDgAKCRCFwuHvBreF
YRAEAQD3jkvnM+tjlCoPYJZBX+cSk5jDzTsJMK426BxEdzVKMgD/dJGsWy8E2Bhr
dbP28pzoHYGvScktIA6F3o26AT2WMQ8=
=GSqm
-----END PGP SIGNATURE-----

--8fM1q9bom9MbGzKe--
