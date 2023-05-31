Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8967E7187E2
	for <lists+linux-rdma@lfdr.de>; Wed, 31 May 2023 18:58:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbjEaQ6Z (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 31 May 2023 12:58:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjEaQ6Z (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 31 May 2023 12:58:25 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2068.outbound.protection.outlook.com [40.107.94.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66E9011D;
        Wed, 31 May 2023 09:58:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b9ShEV4UnWlQh6hYpZQwGFzxAlook+bG7Y2sgCV9AXHrrYETDWBF2D9cjkLqljZ4uKBeerFXcpuzx1bzwC2n3n555PwNcqcyr9WQM2XuG8ZbjtPgm1yxrHluIRnIGGLmiDJDajiC5nNQZ9K0mT5+yEcpw1Epfsf/y6zw4h/xdCT3NJ+vjBO1U7dyssLrjFraDc77ys/tlc8pEGJNk8ZY3eSzZaPraLmhzrCYrEV6P4dsaSCmQKQoEHx5IaNUhyrdPzRW/q3hpwhoQ2/kaEACg1OUzu56lRFE2YW6G/zxI1G56yGGlLtnfVZn4sP2/9KJwhi9UNTOZCM8jndtgSF8GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qrrsbz5WgxuDvv2uwCzNewpl/IdorxzBBISQ5RvSCww=;
 b=AmpfiEzHhPeXITfArPKcqmPhtrgDmgVXhB0juk+cBJ9wO2DYe0U77dtksuh9fmLJ2rM76rpuI5J4tKAhW3ue3Uty/4g8Be3JlFcBGaQn7EN+K/24+vRffO2m87+mOJSOLhlSKe0VJS16IZI+Itm+F9dVAu7qaPap31yPMUwwZ7q/8Yk0VdndDOFf63Qoh7udE01H+341MINr4MkKWzXYRjn/8SO6cIt6xc6H/0GEK7NU0Qzkq5PI3ZsWYQcTsynW3vpxAbYl6aodV4RMKnfYJEqBs4oBVPQYJXwVz5ZEGHlp/VQRLbdP9YYrUIFWHTSwPuESTQ7UByUtvWEq2wSRkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qrrsbz5WgxuDvv2uwCzNewpl/IdorxzBBISQ5RvSCww=;
 b=V0wTl3baCyGpBx0kjpQ816gToKCvb+HlPG6TIyTWaUI7hUkvOypsd9tlHoJAClyRhcIhtTWgwn+h3FrDXPhk/U1L13AMaj+I5fH2RUQU42aYUoE28PxcV3EO5UBGV+BXkYgsErCtZWoDxnckAgQha7ZbchzUe4AkuEa251GYwfUMtGo1jKEzVsTpQX9ag6Dt0EW4wPTKxGHxeRaApQe7pXkxANpSILv82TwgUPzr/o3PC3wOHDPhCDvZlgEdZ3I1fCO7b3j0FsfaO2j0P9fS+baeFDtlMAzxC5UyxDRjFAJ7jXP5QOLfkMpzvFQ7FemKLnlXgolXX6fQmtiB/DsIuA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM8PR12MB5478.namprd12.prod.outlook.com (2603:10b6:8:29::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.22; Wed, 31 May
 2023 16:58:21 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6433.024; Wed, 31 May 2023
 16:58:21 +0000
Date:   Wed, 31 May 2023 13:58:17 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Leon Romanovsky <leonro@nvidia.com>
Subject: [GIT PULL] Please pull RDMA subsystem changes
Message-ID: <ZHd8qRfFribp26D6@nvidia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="M4JHMffLfuuv6yjD"
Content-Disposition: inline
X-ClientProxiedBy: SJ0PR03CA0335.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::10) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM8PR12MB5478:EE_
X-MS-Office365-Filtering-Correlation-Id: 549b7f15-6d69-4976-48cf-08db61f83d21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PW+wd3fYtjz9N+uqCMxcTd8SRG9yanbdGS2xanVzEtyc/lWsoRwScnPyZGWFxjdWgPkwSF3wurdj35QV13/Cy91k+z5mxssBA2y6mUWj8Ne00Z6K6Vx8L8sdtkpoFEkbxhsStTw9rdUYnSVJ5VPKF+2YoyFHrs7EpM6zUYoB+3MgKd9vUGv64BgqppKxc9KbSbpAjhruuM6t5/2XATjPyVpKwZjOoFzLVd/5iTm2lNmxat1g3tpjpXvAlIVZhlM8VaBjLgifu22DhoQ2IvM+9DD+fjxp0roGsBSAzgnk/FIUbeycdbhvRnze3xtUHTWH3DdLZmTezVDkjVbx9NZfQHOc5gcUcpm6T6+F0hv/x/jZz1hj/mhlmpsX9fmzH6ebo6BLiUxax3S/1IQcQibXMPxG36mB2Vmy9fvNct7F6Qcsz+VQccqLF9Y9EeZFi0KZaXpie4chqkhN2gtGJ07LQNzGgJ8efsMl0LR3Fvr/V8phMI9vrL6YO8rxvBjCCBHB30+h4Pc4Anl+zcQkHORqf49OaxLBUmlr47BhSOHCzG/ENpQv2d2arPrdn66NGKNh0Gpjxa9r8bOerSwaWI91uzWlbqRWA1dwvc2VtjjrMSk7mxfKOI12bA1A8RZki/pC
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(376002)(366004)(39860400002)(346002)(451199021)(36756003)(38100700002)(86362001)(8676002)(41300700001)(8936002)(107886003)(26005)(6506007)(6512007)(5660300002)(21480400003)(2906002)(44144004)(186003)(2616005)(83380400001)(6666004)(316002)(66476007)(66946007)(6486002)(66556008)(478600001)(6916009)(4326008)(2700100001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HkBt8pqSxs3z5DNTiMT2m6uypj/uI8ug8j7qj4wxwp746pflWW8KVQVXzpyI?=
 =?us-ascii?Q?sQE8e+3qmy+ZliAYn9A6BbiteHQq+/TZdvJXd08MwQr9BQWs1Lkc9K/ZOEGB?=
 =?us-ascii?Q?a0Y54W1mA53gqP7rdUVrAiL1KM56mOg1gdaxod1fWc0l/y8QH6j2VCzqRh+o?=
 =?us-ascii?Q?ObgdyAdxiwKKaZOm+BtZoX+YCZQm466SjQfD9H9cQ7j5Z0ORuGTkI7qUPOQ6?=
 =?us-ascii?Q?cz1d/wSogN+vJk9uUhBmGTy5o/EX7ZgFudkxxl15IWlR49/Cmu/CLFCnP5CV?=
 =?us-ascii?Q?tRDTsLSUlXE5BaB5zqEJ1RN3RuxPnFB4QvT5Zhj+Z58/4IkNt2ELv12dyRJ9?=
 =?us-ascii?Q?NjtW6ixUswg5VGV1ou3e661q8erAmOuQn5I8G51YGLg0Q2AJMWuuKSPgVWqK?=
 =?us-ascii?Q?OAPPvTm5PxOWRLtqf1zQ8Wagy/yX2H2gvRUJcZvDDh7uJFTh4h7YVjNM27Tj?=
 =?us-ascii?Q?4zMWNJFA/JKZiEm+Or+SDPE2BKBTFVa6W2Ahfa3yZrQT1Va4FtX4jwJYXzJU?=
 =?us-ascii?Q?6gZKvJbQOwCHHxqy0axyiK1kOp8TbSGr4p2OCJ4BDedE6mx1tfCFujdjJEtG?=
 =?us-ascii?Q?1tes7MoQBoD3Q9c6yfduDT6UCRWVej4510KvO6BmTebJLygXOILQMXD3tDbD?=
 =?us-ascii?Q?+57iIyl10qzB08Vww5cfRPEMYk/Mhjxm0vmdSBGu8/d7/w+UUQFFcuMMkDZ/?=
 =?us-ascii?Q?53fn/UNTtZ2LCKj4DeDEqALjR9mbmhryrwK0jHat24A3HXFalObBcMIfGDsm?=
 =?us-ascii?Q?6Nd0uC7WK04pGTjynNSn+DpMfD5nLT4jJBmLGhFUsUGhK0f67Yz0YpN64gwd?=
 =?us-ascii?Q?ChxVHzN+S6SoJDqUEp96wvQGIIaj9hFHaG3iOeIoqSAarpHeO56YumVe2GNM?=
 =?us-ascii?Q?eGWTSNpvYyaac/Wp+RlkzXxr+FwVePp9bNL/fge5LsayTWAqLXzedQbAc7ub?=
 =?us-ascii?Q?BGRk6uilxmC611cgl0PZzPB/wjrca5XoDfGS6LyJOsHdRyaxSFby8+hC962f?=
 =?us-ascii?Q?psR1pufeDbnnN44f0TAHig/py8KA9OkrRYJ/IzCT5cM5kMTSrV6xxxJeEhw2?=
 =?us-ascii?Q?q7J9xkbTIkBTGHy5/fIp6JF6Ap1fdQtl6/GluKOcGEmVxDd87AoOpeiVUXLR?=
 =?us-ascii?Q?8dF25MZ/702eIyX7k9uZmEUEk72YTXxKvvJJ8gPKYdQZ4KQESe6L3dUeZJJE?=
 =?us-ascii?Q?QhP2R+mSCEI7kWzqu1w9EyP1bce6dRST1y32CttMHy7ltyQ4MrfH4tx277/M?=
 =?us-ascii?Q?ySnasG8JJPccG9fgqop2FnODjHnHgjd69mbjTid8m2p3ywEUzryHLH+EeK0I?=
 =?us-ascii?Q?GNnaPlsju2N+eirXT9nkB/TrCl04v/ddFPo6vpei0bICJcZsStRDsvcOyu9h?=
 =?us-ascii?Q?vefVYcIxLtNEpwVHObflElFhoMkvGnZZAlTS1/PV49YzgsrmrBwm/jdulHR+?=
 =?us-ascii?Q?NDQJ5GFpy6d9UpWJYqWaxV/W0Fvtw6F7odh8X+KGbB8d0BLVwaeciJnPOtVg?=
 =?us-ascii?Q?2p4IA/msj8Z9cWQEu/mzpX2hXVVjxKqZEe7KhJwZzEOaEv9eO/XQGEjmnSjI?=
 =?us-ascii?Q?tPkH6KUNNJPH8eS3FwoEcoKYEy+YhKupfxmD6tE1?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 549b7f15-6d69-4976-48cf-08db61f83d21
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2023 16:58:21.0671
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0rbh0RkRkASTn4B8imf5MuFmRXI+TsNt/9zGYp3++icpWGQl2CRRuv6z1CWgPwAm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5478
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--M4JHMffLfuuv6yjD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Usual collection of driver rc bug fixes, other than tha rxe stuff
which is a regression this cycle nothing much stands out.

Thanks,
Jason

The following changes since commit ac9a78681b921877518763ba0e89202254349d1b:

  Linux 6.4-rc1 (2023-05-07 13:34:35 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

for you to fetch changes up to 5842d1d9c1b0d17e0c29eae65ae1f245f83682dd:

  RDMA/irdma: Fix Local Invalidate fencing (2023-05-29 14:06:29 -0300)

----------------------------------------------------------------
v6.4 first rc RDMA pull request

Small rc bug fixes:

- Fix 64K ARM page size support in bnxt_re and efa

- bnxt_re fixes for a memory leak, incorrect error handling and a remove a
  bogus FW failure when running on a VF

- Update MAINTAINERS for hns and efa

- Fix two rxe regressions added this merge window in error unwind and
  incorrect spinlock primitives

- hns gets a better algorithm for allocating page tables to avoid running
  out of resources, and a timeout adjustment

- Fix a text case failure in hns

- Use after free in irdma and fix incorrect construction of a WQE causing
  mis-execution

----------------------------------------------------------------
Bob Pearson (1):
      RDMA/rxe: Fix double unlock in rxe_qp.c

Chengchang Tang (2):
      RDMA/hns: Fix timeout attr in query qp for HIP08
      RDMA/hns: Fix base address table allocation

Guoqing Jiang (1):
      RDMA/rxe: Convert spin_{lock_bh,unlock_bh} to spin_{lock_irqsave,unlock_irqrestore}

Haoyue Xu (1):
      MAINTAINERS: Update maintainers of HiSilicon RoCE

Kalesh AP (3):
      RDMA/bnxt_re: Fix a possible memory leak
      RDMA/bnxt_re: Fix return value of bnxt_re_process_raw_qp_pkt_rx
      RDMA/bnxt_re: Do not enable congestion control on VFs

Michael Margolin (1):
      MAINTAINERS: Update maintainer of Amazon EFA driver

Mustafa Ismail (2):
      RDMA/irdma: Prevent QP use after free
      RDMA/irdma: Fix Local Invalidate fencing

Selvin Xavier (1):
      RDMA/bnxt_re: Fix the page_size used during the MR creation

Yangyang Li (1):
      RDMA/hns: Modify the value of long message loopback slice

Yonatan Nachum (1):
      RDMA/efa: Fix unsupported page sizes in device

 MAINTAINERS                                |  5 ++--
 drivers/infiniband/hw/bnxt_re/ib_verbs.c   |  4 +--
 drivers/infiniband/hw/bnxt_re/main.c       |  4 +++
 drivers/infiniband/hw/bnxt_re/qplib_fp.c   | 11 ++++----
 drivers/infiniband/hw/bnxt_re/qplib_res.c  | 12 ++-------
 drivers/infiniband/hw/bnxt_re/qplib_sp.c   |  7 +++--
 drivers/infiniband/hw/efa/efa_verbs.c      |  2 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 25 +++++++++++------
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h |  2 ++
 drivers/infiniband/hw/hns/hns_roce_mr.c    | 43 ++++++++++++++++++++++++++++++
 drivers/infiniband/hw/irdma/verbs.c        | 12 +++++----
 drivers/infiniband/sw/rxe/rxe_comp.c       | 26 +++++++++++-------
 drivers/infiniband/sw/rxe/rxe_net.c        |  7 ++---
 drivers/infiniband/sw/rxe/rxe_qp.c         | 37 ++++++++++++++++---------
 drivers/infiniband/sw/rxe/rxe_recv.c       |  9 ++++---
 drivers/infiniband/sw/rxe/rxe_req.c        | 30 ++++++++++++---------
 drivers/infiniband/sw/rxe/rxe_resp.c       | 14 +++++-----
 drivers/infiniband/sw/rxe/rxe_verbs.c      | 25 ++++++++---------
 18 files changed, 176 insertions(+), 99 deletions(-)

--M4JHMffLfuuv6yjD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRRRCHOFoQz/8F5bUaFwuHvBreFYQUCZHd8pwAKCRCFwuHvBreF
YTK0AP9GAUDz9PwRd5aWE09p9C4MpwQlz0QV8QWrJb3QDo0H7AD/SMGreBditHLR
ybD12RMMwJ+tb4b7Vvx3DzSugUelOQM=
=S/zu
-----END PGP SIGNATURE-----

--M4JHMffLfuuv6yjD--
