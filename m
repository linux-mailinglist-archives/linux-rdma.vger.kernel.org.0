Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E096741D56
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Jun 2023 02:47:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbjF2Aq6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 28 Jun 2023 20:46:58 -0400
Received: from mail-dm6nam11on2089.outbound.protection.outlook.com ([40.107.223.89]:8384
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229621AbjF2Aq5 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 28 Jun 2023 20:46:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cf2gqSnNH7J2+XRU+7cbrCgPpNZXYIkN75N9EF54eOOBqeeONSOlInuURENmuQhChYpWQ8I1vN+rYNjuTO2EZ9N9kbkM5EMjJ54slQ7S+bmNrxgt1BDxB+FcNBw7X4DdO83q1Qd3f+GJAGSp5PkQKyGjDKtTY0M16zOFkm0OvEkf5tB5wKIgFpdhdnQNlbClIp1/7Ts3o8lLnXdplHM0UXMX6cHL3eOt2sxr8y7hUvbr0v9JxblrYeElNC38ZttF4QSkRl7gQucsclgcGMSJ49u0u5l5GowpGSFNkRHJTvRYTlYlNBSGPmuHk/BLIsKonTxVgX8aBxfT0i6OdS1vbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q7MJO2Foy8RITE55HpHMbZztqCNw77nzKHFpbVs2o3s=;
 b=eAaoObiFTGSwXFUmQsjpob+2fsyYUZ+0pzVFa62qcUZIQVSvuIBrb+MPihdIs7MiNMqweh99ajhl9goFgp5mA5sY9tQRo6TfFEhr342gL/Tdcdnr88vcpGa+WIXQi96+Iujy7eksyD1CDP7+7+ycGpVtcD9VnoiJYYDPdzZDH9isyHr9Y9zF3Un/wLFIEUpauy1j3n9ujL9HQdtla6DaA0sgdJMKn2X37RBpuDJJDNMup24wzBZp4/yxUyxZJ53WSqRtHV1Ko6HiPAzU8dzkRKmElFORoB5tPX1M5tm/I+ZeB2f3r1veYY3fn+qtN+VGqooXJb2bvDQV6crkGlXFQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q7MJO2Foy8RITE55HpHMbZztqCNw77nzKHFpbVs2o3s=;
 b=i4jDbO4KZLuBZZnv1/IipaXMynF0X4OM5q9oDpEgIQisfNkyU9m+i/ErK6YwJBR27vLYYS0IcL0XoLiIinBehdHZFuDWiFVhQbhNtB3phRNSvlF5VohKTQZw21a+hZz2ugXOsPDl9oQrFuApIL57ohPKy1rlFHqf0Ea6oC5XeGB3+ge6OXkLYNJqVD1wknFgLX0a1+wx6NxJFupwfPhKG46P0nzr4GtNU+2GlfYNHwE+4BldcI85obtHVxyD5bg7BlhMdVuBzNjxPCRMPOguj4U7oikqmxXy4scefsKNO3gXSZUuo3R5bQdPA5j+k4Hi9b/9rTOVQVdzMm0ZJIdUMg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DS7PR12MB8345.namprd12.prod.outlook.com (2603:10b6:8:e5::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6544.15; Thu, 29 Jun 2023 00:46:49 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%7]) with mapi id 15.20.6521.024; Thu, 29 Jun 2023
 00:46:49 +0000
Date:   Wed, 28 Jun 2023 21:46:48 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Leon Romanovsky <leonro@nvidia.com>
Subject: [GIT PULL] Please pull RDMA subsystem changes
Message-ID: <ZJzUeFT7lLqEjMJn@nvidia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="IOt70eyFN6Ufx8+s"
Content-Disposition: inline
X-ClientProxiedBy: BLAPR03CA0104.namprd03.prod.outlook.com
 (2603:10b6:208:32a::19) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DS7PR12MB8345:EE_
X-MS-Office365-Filtering-Correlation-Id: 3cf26df6-bfc2-4df0-6c40-08db783a528d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WNH0pLb7uok/P+kTh1kI8J9mR9Pmnb632k8YsP9S9jNy1J/BwsE5X/3X52CvKaPnQeJx2dXrHdFkVffAZZWD/PEQ64CWejS1TlTJRspYAVTd1xvc2Ec+ozCSkqgAq+aaaibcH+BUYrVTN7pXuAPeS2l376Y7ws6FG7Kfy+VH06I4AyrWVY0kEOqZrVORpfE1YzxEpZ2SStdrEat5YL8H0ujgnLW0kBmQt/YtgZNvwYhREViqFYdWOYh4Afzln6h1cjS+VVCJbwrZ+TLgVjqk2v4yAZ7HBDy1Zq35aCrEqTp23aAxf9rVKonc2YpKWiAlaMe+MQkI+1t63J47NAwVquGBfk0SJfn3PgTIfa5tmMW3XDNy9a8Ky8BTRn47TIMyrP3N6e7DrQqB+2pwjQnihIjtupsQaGbtKMWzE6hKy5fcSEsGZ2aKvc4wHdXjKnyRiLBLG4SNUph2N7e6YkBrAwR77IQaNj2rBIeIHSsMYTbxPQRMuWpiaj5QvxG1aby7qqXTgYHsbeF922d0FWXb1FOwFwJLTscwMBE1hELjJ/heJKsv1TvXBnaKkK3rnN2LHa5Y4ZHwxUS5ORh+xLaRK1iRPYzupYJKe2TZMKp/TEjDX3Ba6R7Y3lSmJmtl5qW4
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(366004)(376002)(346002)(396003)(451199021)(4326008)(2906002)(21480400003)(186003)(83380400001)(2616005)(316002)(6916009)(66946007)(44144004)(66476007)(66556008)(107886003)(45080400002)(6506007)(5660300002)(6512007)(26005)(8936002)(41300700001)(8676002)(6486002)(478600001)(38100700002)(86362001)(36756003)(2700100001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?J1ClT8x2xV2Hs7Eb2RCg+PTf6HyCtamnC4g0Wx3/P0MdXqh/aU3n8mfYmCLs?=
 =?us-ascii?Q?u3kO8PXQSn0p7rdWfBcyOxN+inGdxxkGhLEPUu3JCinf/h8C94q5mt3PQ2lD?=
 =?us-ascii?Q?5a76nji+iC9jAefDTrOu1BrMej3TaHCbFYKDlPZma5BizEyEn+dD5q/hMv3W?=
 =?us-ascii?Q?X39ODE+fKMsCL1hmlofAkeBO9hAwlHTgVoywMKHIrDF1HLIpLVnTNdEZyB5x?=
 =?us-ascii?Q?5nrTtaX/GMwIEqAioLWumabFr01tycmdstuu0W8MrydIJkrWEJwex6tCY/9U?=
 =?us-ascii?Q?2tC00RsFCq4Uf/CHMpJ0MkFakR5DXscYp4J3zHIB3BRENmRd2rCMjrB3PXUQ?=
 =?us-ascii?Q?TvUePw9xDVr/kEDUz4q8w1VIt6R9xMJZtd05MfE/ypddbzy8OyVAq+M3jXEU?=
 =?us-ascii?Q?vsA1hyTKPrIyqcXfSjZ2W7M2sSX3Wx4ufq7rkYU7hVQ5RkGz3qpU6pG4Ozj5?=
 =?us-ascii?Q?VCkRwsREc4uM/exVa5axSWx1WgfWj5XXUeShP8dSS+X6ZWl6zDJvDWh9YhXK?=
 =?us-ascii?Q?9rtOfq2QW7EhBU/tmTDk6q38JBV1o9UfnLroVw32WtVWSjhr/VTKh4Rkoz9D?=
 =?us-ascii?Q?Th9zJ1yxUKoX3IQ3ODX5lJixaOk/sF6mO7VThjN+smalNaekGMrJsSXIcNBP?=
 =?us-ascii?Q?YS1/pALhXu5gdeAJ47iFK0R6N12SWwZeGA0gjRkrNjAY9iO/Jjsm2r6ZJpuC?=
 =?us-ascii?Q?YTFGDxeVtVk8K2ILdJDtiaxID8TL2WxDZ4C/BTcnA5a46uPFIHqEaeaJBwYq?=
 =?us-ascii?Q?YFr8mU/qVIZa8rytNeVmwTx5O67LpcNPWY0OwXx/b2R1q3PK8W1/L79mUGWb?=
 =?us-ascii?Q?P7vSZullAT0a4c3ECIrsGhojW8vp14nlke64Y1qdWaDZUyr9pW1+xyzQd9jS?=
 =?us-ascii?Q?zaUSMClTiZ547ax0KEqW+TJfrgfS5Fshkuz6qTGDnc3XEVEXdRxkF2uR1hNK?=
 =?us-ascii?Q?oYOHbxh0k/r/S9YLXgkQdYr7o8WJECDBBiYpugVQiIjD8AXXCpeYmNL/yJ+I?=
 =?us-ascii?Q?AugBOJZ7cGWc6PkZxaAcJDi+IMSgQrW6YpsI6a6ZwKo1INEEo/bKS42mQRuq?=
 =?us-ascii?Q?tSHFSfTWzhzMggLfz9FDvIb3JTHsAXRbZ5GR5bKGMeXMc4PZlyOyYEPZWR/P?=
 =?us-ascii?Q?yEI7X7Keb6TUAszKlrTQbFClnWx5X+nnzZRKjXSEvT7pUbZy2rMoPfsYILHN?=
 =?us-ascii?Q?nbmLn5/QqiOB9fleUDoWzUrN++ad0K71uuA+fFTN3zD+8M+KWp3SWLcGU88G?=
 =?us-ascii?Q?yHUbNr1qofTkby/ToRUJC+jLgX7HH4FrXlYMioj21u+eXtb5yGrecJGlko/s?=
 =?us-ascii?Q?POV/9ejy4JaESdr9oZCe8LLu/i0DEoiT5gcRGDL7SBRWZopgWkXwdQt1OcRp?=
 =?us-ascii?Q?SJNUq+0/Xtr+ANdfn1OhPW4gRZjE6+cyI8fDs3n172SwCiTyPToAc2lgJwju?=
 =?us-ascii?Q?T76PbijP9+anGqY473Tf0vBAMuom9+KsmYOfCqGwp5mpE1+ENNPGsyRWUqX4?=
 =?us-ascii?Q?ZICpOjIfnPPbuv9mSrh7oLij2Mz077rNdL6JGZcRHrGZ9B/ECob+1Y67THS9?=
 =?us-ascii?Q?++D39gkyn0x7qpKm+UwbIDtAgecqlG6nXpfBMqQ6?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cf26df6-bfc2-4df0-6c40-08db783a528d
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2023 00:46:49.3195
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0l7nHCATB1urLN01LyTK7InmO9vXwjffKWWtWBuz1N2GwnDdk5vIjuvNW/N9JAns
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8345
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--IOt70eyFN6Ufx8+s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Here are the changes for RDMA for this cycle, there was a small rxe
conflict with v6.4 that I resolved in the usual way.

Thanks,
Jason

The following changes since commit 6995e2de6891c724bfeb2db33d7b87775f913ad1:

  Linux 6.4 (2023-06-25 16:29:58 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

for you to fetch changes up to 5f004bcaee4cb552cf1b46a505f18f08777db7e5:

  Merge tag 'v6.4' into rdma.git for-next (2023-06-27 14:06:29 -0300)

----------------------------------------------------------------
v6.5 merge window RDMA pull request

This cycle saw a focus on rxe and bnxt_re drivers:

- Code cleanups for irdma, rxe, rtrs, hns, vmw_pvrdma

- rxe uses workqueues instead of tasklets

- rxe has better compliance around access checks for MRs and rereg_mr

- mana supportst he 'v2' FW interface for RX coalescing

- hfi1 bug fix for stale cache entries in its MR cache

- mlx5 buf fix to handle FW failures when destroying QPs

- erdma HW has a new doorbell allocation mechanism for uverbs that is
  secure

- Lots of small cleanups and rework in bnxt_re
   * Use the common mmap functions
   * Support disassociation
   * Improve FW command flow

- bnxt_re support for "low latency push", this allows a packet

----------------------------------------------------------------
Arnd Bergmann (1):
      RDMA/irdma: avoid fortify-string warning in irdma_clr_wqes

Bob Pearson (10):
      RDMA/rxe: Add workqueue support for rxe tasks
      RDMA/rxe: Rename IB_ACCESS_REMOTE
      RDMA//rxe: Optimize send path in rxe_resp.c
      RDMA/rxe: Fix access checks in rxe_check_bind_mw
      RDMA/rxe: Introduce rxe access supported flags
      RDMA/rxe: Let rkey == lkey for local access
      RDMA/rxe: Implement rereg_user_mr
      RDMA/rxe: Send last wqe reached event on qp cleanup
      RDMA/rxe: Fixes mr access supported list
      RDMA/rxe: Simplify cq->notify code

Brendan Cunningham (3):
      IB/hfi1: Fix wrong mmu_node used for user SDMA packet after invalidate
      IB/hfi1: Add mmu_rb_node refcount to hfi1_mmu_rb_template tracepoints
      IB/hfi1: Remove unused struct mmu_rb_ops fields .insert, .invalidate

Bryan Tan (1):
      RDMA/vmw_pvrdma: Remove unnecessary check on wr->opcode

Cheng Xu (4):
      RDMA/erdma: Configure PAGE_SIZE to hardware
      RDMA/erdma: Allocate doorbell resources from hardware
      RDMA/erdma: Associate QPs/CQs with doorbells for authorization
      RDMA/erdma: Refactor the original doorbell allocation mechanism

Chengchang Tang (2):
      RDMA/hns: Fix hns_roce_table_get return value
      RDMA/hns: Add clear_hem return value to log

Colin Ian King (1):
      RDMA/bnxt_re: Fix spelling mistake "priviledged" -> "privileged"

Daisuke Matsuda (1):
      RDMA/rxe: Fix comments about removed tasklets

Dan Carpenter (1):
      RDMA/bnxt_re: Fix an IS_ERR() vs NULL check

Jason Gunthorpe (1):
      Merge tag 'v6.4' into rdma.git for-next

Junxian Huang (1):
      RDMA/hns: Remove unnecessary QP type checks

Kalesh AP (6):
      RDMA/bnxt_re: Fix to remove unnecessary return labels
      RDMA/bnxt_re: Use unique names while registering interrupts
      RDMA/bnxt_re: Remove a redundant check inside bnxt_re_update_gid
      RDMA/bnxt_re: Fix to remove an unnecessary log
      RDMA/bnxt_re: Return directly without goto jumps
      RDMA/bnxt_re: Remove unnecessary checks

Kamal Heib (3):
      RDMA/irdma: Return void from irdma_init_iw_device()
      RDMA/irdma: Return void from irdma_init_rdma_device()
      RDMA/irdma: Move iw device ops initialization

Kashyap Desai (19):
      RDMA/bnxt_re: wraparound mbox producer index
      RDMA/bnxt_re: Avoid calling wake_up threads from spin_lock context
      RDMA/bnxt_re: remove virt_func check while creating RoCE FW channel
      RDMA/bnxt_re: set fixed command queue depth
      RDMA/bnxt_re: Enhance the existing functions that wait for FW responses
      RDMA/bnxt_re: Avoid the command wait if firmware is inactive
      RDMA/bnxt_re: use shadow qd while posting non blocking rcfw command
      RDMA/bnxt_re: Simplify the function that sends the FW commands
      RDMA/bnxt_re: add helper function __poll_for_resp
      RDMA/bnxt_re: handle command completions after driver detect a timedout
      RDMA/bnxt_re: Add firmware stall check detection
      RDMA/bnxt_re: post destroy_ah for delayed completion of AH creation
      RDMA/bnxt_re: consider timeout of destroy ah as success.
      RDMA/bnxt_re: cancel all control path command waiters upon error
      RDMA/bnxt_re: use firmware provided max request timeout
      RDMA/bnxt_re: remove redundant cmdq_bitmap
      RDMA/bnxt_re: optimize the parameters passed to helper functions
      RDMA/bnxt_re: Remove incorrect return check from slow path
      RDMA/bnxt_re: Refactor code around bnxt_qplib_map_rc()

Leon Romanovsky (2):
      RDMA/mlx5: Reduce QP table exposure
      RDMA/bnxt_re: Initialize opcode while sending message

Li Zhijian (1):
      RDMA/rtrs: Remove duplicate cq_num assignment

Long Li (1):
      RDMA/mana_ib: Use v2 version of cfg_rx_steer_req to enable RX coalescing

Nicolas Morey (1):
      RDMA/rxe: Remove dangling declaration of rxe_cq_disable()

Patrisious Haddad (3):
      net/mlx5: Nullify qp->dbg pointer post destruction
      RDMA/mlx5: Handle DCT QP logic separately from low level QP interface
      RDMA/mlx5: Return the firmware result upon destroying QP/RQ

Selvin Xavier (8):
      RDMA/bnxt_re: Disable/kill tasklet only if it is enabled
      RDMA/bnxt_re: Use the common mmap helper functions
      RDMA/bnxt_re: Add disassociate ucontext support
      RDMA/bnxt_re: Optimize the bnxt_re_init_hwrm_hdr usage
      RDMA/bnxt_re: Query function capabilities from firmware
      RDMA/bnxt_re: Move the interface version to chip context structure
      RDMA/bnxt_re: Reorg the bar mapping
      RDMA/bnxt_re: Enable low latency push

Yang Li (2):
      RDMA/cma: Remove NULL check before dev_{put, hold}
      RDMA/bnxt_re: Remove duplicated include in bnxt_re/main.c

 drivers/infiniband/core/cma.c                     |   3 +-
 drivers/infiniband/hw/bnxt_re/bnxt_re.h           |   5 +
 drivers/infiniband/hw/bnxt_re/ib_verbs.c          | 292 +++++++++-
 drivers/infiniband/hw/bnxt_re/ib_verbs.h          |  19 +
 drivers/infiniband/hw/bnxt_re/main.c              | 192 +++++--
 drivers/infiniband/hw/bnxt_re/qplib_fp.c          | 104 ++--
 drivers/infiniband/hw/bnxt_re/qplib_fp.h          |   2 +-
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.c        | 664 +++++++++++++++++-----
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.h        |  52 +-
 drivers/infiniband/hw/bnxt_re/qplib_res.c         | 177 ++++--
 drivers/infiniband/hw/bnxt_re/qplib_res.h         |  34 +-
 drivers/infiniband/hw/bnxt_re/qplib_sp.c          |  19 +-
 drivers/infiniband/hw/bnxt_re/qplib_sp.h          |   5 +-
 drivers/infiniband/hw/erdma/erdma.h               |  16 +-
 drivers/infiniband/hw/erdma/erdma_hw.h            |  64 ++-
 drivers/infiniband/hw/erdma/erdma_main.c          |  53 +-
 drivers/infiniband/hw/erdma/erdma_verbs.c         | 178 +++---
 drivers/infiniband/hw/erdma/erdma_verbs.h         |  13 +-
 drivers/infiniband/hw/hfi1/ipoib_tx.c             |   4 +-
 drivers/infiniband/hw/hfi1/mmu_rb.c               | 108 ++--
 drivers/infiniband/hw/hfi1/mmu_rb.h               |  10 +-
 drivers/infiniband/hw/hfi1/sdma.c                 |  23 +-
 drivers/infiniband/hw/hfi1/sdma.h                 |  47 +-
 drivers/infiniband/hw/hfi1/sdma_txreq.h           |   2 +
 drivers/infiniband/hw/hfi1/trace_mmu.h            |  48 +-
 drivers/infiniband/hw/hfi1/user_sdma.c            | 137 ++---
 drivers/infiniband/hw/hfi1/user_sdma.h            |   1 -
 drivers/infiniband/hw/hfi1/vnic_sdma.c            |   4 +-
 drivers/infiniband/hw/hns/hns_roce_hem.c          |  51 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c        |  24 +-
 drivers/infiniband/hw/irdma/uk.c                  |  10 +-
 drivers/infiniband/hw/irdma/verbs.c               |  41 +-
 drivers/infiniband/hw/mana/qp.c                   |   5 +-
 drivers/infiniband/hw/mlx5/mlx5_ib.h              |   1 +
 drivers/infiniband/hw/mlx5/qp.h                   |  12 +-
 drivers/infiniband/hw/mlx5/qpc.c                  |  93 +--
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_qp.c      |   8 -
 drivers/infiniband/sw/rxe/rxe.c                   |   9 +-
 drivers/infiniband/sw/rxe/rxe_comp.c              |   2 +-
 drivers/infiniband/sw/rxe/rxe_cq.c                |   5 +-
 drivers/infiniband/sw/rxe/rxe_loc.h               |   2 -
 drivers/infiniband/sw/rxe/rxe_mr.c                |  21 +-
 drivers/infiniband/sw/rxe/rxe_mw.c                |  22 +-
 drivers/infiniband/sw/rxe/rxe_opcode.h            |   3 +
 drivers/infiniband/sw/rxe/rxe_param.h             |   2 +-
 drivers/infiniband/sw/rxe/rxe_qp.c                |   7 +
 drivers/infiniband/sw/rxe/rxe_req.c               |   2 +-
 drivers/infiniband/sw/rxe/rxe_resp.c              |  25 +-
 drivers/infiniband/sw/rxe/rxe_task.c              | 110 ++--
 drivers/infiniband/sw/rxe/rxe_task.h              |   6 +-
 drivers/infiniband/sw/rxe/rxe_verbs.c             |  45 +-
 drivers/infiniband/sw/rxe/rxe_verbs.h             |  21 +
 drivers/infiniband/ulp/rtrs/rtrs-clt.c            |   1 -
 drivers/net/ethernet/mellanox/mlx5/core/debugfs.c |   6 +-
 drivers/net/ethernet/microsoft/mana/mana_en.c     |   5 +-
 include/linux/mlx5/driver.h                       |  10 -
 include/net/mana/mana.h                           |   4 +-
 include/uapi/rdma/bnxt_re-abi.h                   |  27 +
 58 files changed, 1955 insertions(+), 901 deletions(-)

--IOt70eyFN6Ufx8+s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRRRCHOFoQz/8F5bUaFwuHvBreFYQUCZJzUdgAKCRCFwuHvBreF
Ya/2AP47zZnKrg1RhMjPOaNcg+uWrHi80Fv2LFpvwDRD0pQdwAD+P2CsCoTcJ6zn
H/bMGdRxN6M60Wa9qyJCp0kw3dWTsAU=
=nT2V
-----END PGP SIGNATURE-----

--IOt70eyFN6Ufx8+s--
