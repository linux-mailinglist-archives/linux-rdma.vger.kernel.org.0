Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E35E6A1499
	for <lists+linux-rdma@lfdr.de>; Fri, 24 Feb 2023 02:27:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbjBXB1p (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 23 Feb 2023 20:27:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbjBXB1o (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 23 Feb 2023 20:27:44 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2040.outbound.protection.outlook.com [40.107.223.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B0343B232;
        Thu, 23 Feb 2023 17:27:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kUWav4Z60r32ONmKlGOA4WNh32dSd1B2AMIyhCoopn0x3WL7QyZF7ij+WJI8osRnXXSaITb+NeC0Cou477o3Y5JAOtWPffsIvT6m1q6Ctk/vJstpPt96l7zJ8yh10y4A0cEc5dPYNHQFaaMA3UROxQ+l5oqdj7IW8hz4lpzffmWMx0AOnjvOY/6SuFFH6KTQK2j4QjzpV4Dc3lbHtdfOzMc/gA1mY2th2x+u8hFXjUIk+UW3cvrxDCl2K3WLA4cC6LDjVH0IDCk1fmfwrob557QUAk+9Bhc93Y9BABUAVMndvP8y2k99mnYGq6rTe4TutXGJy6V0MNhwcV0ssUk29Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LspmJ194A4OXG+SQ8UkDYo8aPe8XfS00ze3/Vl4vopQ=;
 b=JYuXUoLTw5xyE7sWPTSm1c3/CB7FJgV2GxZVbkzIaki+0Yb2dRrfIr2GCsthT7u5VeWmAVwurvLzioeC5CtsnsV0Cu9MkWrfBytMoNfKcdxKYF8JGN1Y6OrT6w03yvIc6cDYIxi6oSqywAfRZr9ek+mJphcsAt5jqVDEwTLEc8EkRxbif6/Sq0XN5BagCz56JNAAtpu85IaB06tLvZOXiZfrbfeKpPM7cENJKTpxEPpWtNX4bUPcLF0t36yR3dOT8EAUTkew2jAPVisDLD4v/t8xEV8U+DVadaNdlRUUMejhmgo06pk3Z+7uXpLvo9xpv+AA6ubE8mWOv2nGUDv4Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LspmJ194A4OXG+SQ8UkDYo8aPe8XfS00ze3/Vl4vopQ=;
 b=nTfp1Dj2EBx54n9c5x23MBbIH6qliNvpijCJ8ar56Myg6bzeyln++6vhiMBjgv5CusJGdYx6amF3ZzuVcqHG0k7FZiVp/hXrGWTVVjEeJH3LMwRnvpm9TKsaJRNZ7C8TmGVJNaUC2VXW8Igfyxox3yWjzpHjGwZnZThxKVMk/8KXD6vb5V94OqUns+nFLGMsrzI6vSYEv5OqTSqC4/wnrqvs/fSeOKftRVdt2B43GYnjcpm1mTSl/HjgChPylexkgDHSBfZVBofhC74ZeFtyl6cX4lx1BMkR2IwU+DLd73lJe7rRZEKT0gOyNv7njV8YZ9Innd3zrb6DSqWcEb4tsA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DS0PR12MB7994.namprd12.prod.outlook.com (2603:10b6:8:149::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.19; Fri, 24 Feb
 2023 01:27:40 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6134.021; Fri, 24 Feb 2023
 01:27:40 +0000
Date:   Thu, 23 Feb 2023 21:27:39 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Leon Romanovsky <leonro@nvidia.com>
Subject: [GIT PULL] Please pull RDMA subsystem changes
Message-ID: <Y/gSi52mNoJjI6dk@nvidia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2CeHMBYhY8E7+S+z"
Content-Disposition: inline
X-ClientProxiedBy: BL1PR13CA0302.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::7) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DS0PR12MB7994:EE_
X-MS-Office365-Filtering-Correlation-Id: a77f7427-d0df-4678-4817-08db160651c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Mh+8Nxu5RHhxbPvfgwFpomEwEXw4kpQqlUz+KuGy/8rUUhsJ0jThxFKp40TKlKgSQN7/sb25dbThpfcs/ug27fc0Csrws29wrBpXql3Pw+o0a5CRPQmf2xlPhQ2hXkzCAJWujd3lzkV9yzjHu9f2oQ2ny6yDAAdI8W9Jy/byBViCRIqkozrAtnuLl8KEw9EHuMqJ7fCYQPcPXhka/oL6WTWgKZk615SWYTEmby9syc1Q7HHnXBN4fGtTXbh9hheFlwoNx6Z+onISBSjIr27gfBv2C1taoB8SMWMkKw3JyY7U5iJFkbBbNMwLAdoiSOPLoGE2rFLlMd5lY7YdylrgM5G8SqAtCAZETU7nXk5BobvEvRCNz/fGLUQtIpjmdWsw0yGHiIELhiaGr6IUXDmH+xMnVUJGUNxExkrtOECyAPFcxLSAvO0YKhBOImzSjpfPNbPithB620q20tM83o+wJfuUiDlM4gm7JevqdmlWFtV1H3YIMkYHz2KluFvYioH7XJMAwG2rWTBu6gHa4gIdvfpygQf9rb2Ge8A2GcCFcRTC6IzZVI2JyBnD6U/4ezux2G7y+LK53n179b77en/oylga1svJwgcooQC+zxQ/oZRLhuyyg8LW8YrrPeJxHTHIxMB6QV789uRmAZyPZOrpXrec3WQbfpgaAazRjIxB5S1b1p+z8koRNu8BhlBxArae
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(39860400002)(136003)(346002)(396003)(376002)(451199018)(83380400001)(6916009)(38100700002)(8936002)(4326008)(316002)(66946007)(66476007)(478600001)(6506007)(44144004)(8676002)(186003)(6512007)(26005)(36756003)(86362001)(6486002)(5660300002)(21480400003)(2906002)(107886003)(66556008)(41300700001)(2616005)(2700100001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nop+aZP80yht0jXgT9HkrIH56/9FuCIARKdD4JMYzWyCk+Nzop0pgSCP/NsS?=
 =?us-ascii?Q?5L4BnuWN0FeMcGQ6VIlXCIY/plVA2Kyjgks7Amj8GcDQjY0JDvxQTd5rfI25?=
 =?us-ascii?Q?BS6ck+JiNPu9Xp+vkKSP8/zq48/vQllV7Rrt4Y7qjfx27Daxs6LRMMLCEKpe?=
 =?us-ascii?Q?imz0eIbCibsZYg/D1QotQ7Vb+vippe7ObZMBUYP6UnklPkLAFVUbx4gxn+WV?=
 =?us-ascii?Q?MZ2hB1hftwopEsm0+m+Hvmq76Wvzd7tzIVGe8lOZdekruqyNKLGCuFyc2e9A?=
 =?us-ascii?Q?KHTp/5fxUMKaYB66JFRrwCl2T7Z0/gto66x27pS8cYWv1tSXjOh1N5/Pya/8?=
 =?us-ascii?Q?C6fC2jljRHSbIe7hh5z41/4i6UYgn35ZN/TsNBlFrut8YzZ7UZOZrrNDWa8U?=
 =?us-ascii?Q?w72dIknsDCH/PYmo3vYErr2922YuCqA0StIHRCef+n5Xr8BxM+TKjF3MGCOH?=
 =?us-ascii?Q?sC4Pv8AU3PrRsYYxp3i8Z8+tvnhA38rzuJPl6h9nR6o7UrE/sW9ssKpBX/Do?=
 =?us-ascii?Q?2lIuqcUKQ6tgU2qcrRj0fL2GPE6x+/VC/Inqycn4Smnn8+Y9hthch+E9ZQax?=
 =?us-ascii?Q?9B0hc9O4deQ7zediJ83uQ96IvHmD5kw7+zipOZd7+cPlfFWBfd8dIUXje8WS?=
 =?us-ascii?Q?RP8OKzJpLVvliR2cQFDH7Lz0UQbyv16uFlZHg3tx+sgW3bX0d0l6+AEFrtDd?=
 =?us-ascii?Q?8WiYyMIz/O3bKarrTT73MFgoKq9b/07gf6FIrx81ZKnSKfphfmv7IKyOJvU+?=
 =?us-ascii?Q?tFaXBUXQget55SpLBxLHXXG/xwbuF+xSX9k/ta5fqIbfGZpktZO0pRSfk4N0?=
 =?us-ascii?Q?Uo3IUyO/u6oFfUEZXzrPYmp59UWZAnNSCZOv5b4goyN7QG7l7Q76QP5fzQKY?=
 =?us-ascii?Q?fR4DiRHOKXuJnQlsI0nMdLDNIjO+Jja3BIjyBshKMEmRJe/TmBsABQQ1QcOr?=
 =?us-ascii?Q?xZqtc3RKqWCeCdOXRCcBF7KipKrmBCX7osH8PFvES0ZL3+lyyA3nuEQ/xBm5?=
 =?us-ascii?Q?9trqnw7Go9tu2W/6lksCiNpa4r0Ol9+7NlXZ4jQiGQayT89wgoAgiBUStMZZ?=
 =?us-ascii?Q?5rG63qCwL2HuGbQcjxyBAXyB6Vm/dtuX8EuLxWDwxqi20DdzXrGwKof25Jmm?=
 =?us-ascii?Q?gyukOBJJ2vJ3eTnftUvpGqrgerKQr1ViHuxlLbbRFpjrKwD9HJhC0g0pigAK?=
 =?us-ascii?Q?GWkoX6Ssxa2JYdxnqQs6wXhd9VYS3dzn5y0ljwZQPSr7ycgfqFy9IAZ1jETG?=
 =?us-ascii?Q?2C0cIzZR+0IDWHBBs+gaM219TanDX+2KhCk3yD2xdgpNwPfV2jOM+1siudrT?=
 =?us-ascii?Q?U2cFVaL4b869M9tq5QcSbQN9bYlFWazsR4luntopwHq/iiCGhK04x+dDmv4h?=
 =?us-ascii?Q?6dfLS2mBQNP6C4KgoPK9aZAewn94JQimPtlD524k0XV0jyX+aSd54afefyTm?=
 =?us-ascii?Q?u5qe3XvoBEK8XngqDvbbb7FlyOjAv7i7X3QLXF8j7pJFxZGCMt6NjJ8jS8vY?=
 =?us-ascii?Q?hVaHxf3/buIWh2x16+wfCyvLTcQp8O0eafBBcOl99RCColW7/2STX/vFwQw0?=
 =?us-ascii?Q?cTLFR3p3JwTvetTV6r5JN1q1B76HfAStABsqvgIl?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a77f7427-d0df-4678-4817-08db160651c2
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2023 01:27:40.2076
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bWO3D8dtEask5aT3aA0UMfJqc4c/iDKbaO9MA3TeCVZQTndWA5puK9Lhk9Fx27ZJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7994
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--2CeHMBYhY8E7+S+z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Quite a small cycle this time, even with the rc8. I suppose everyone
went to sleep over xmas.

Thanks,
Jason

The following changes since commit 22551e77e5507a06114c0af2b92bbf1a66ec33c5:

  net/mlx5: Configure IPsec steering for egress RoCEv2 traffic (2023-02-15 11:30:07 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

for you to fetch changes up to 66fb1d5df6ace316a4a6e2c31e13fc123ea2b644:

  IB/mlx5: Extend debug control for CC parameters (2023-02-19 11:50:59 +0200)

----------------------------------------------------------------
v6.3 RDMA pull request

Small cycle this time:

- Minor driver updates for hfi1, cxgb4, erdma, hns, irdma, mlx5, siw, mana

- inline CQE support for hns

- Have mlx5 display device error codes

- Pinned DMABUF support for irdma

- Continued rxe cleanups, particularly converting the MRs to use xarray

- Improvements to what can be cached in the mlx5 mkey cache

----------------------------------------------------------------
Aharon Landau (2):
      RDMA/mlx5: Don't keep umrable 'page_shift' in cache entries
      RDMA/mlx5: Remove implicit ODP cache entry

Alexey Kodanev (1):
      RDMA/cxgb4: remove unnecessary NULL check in __c4iw_poll_cq_one()

Bernard Metzler (1):
      RDMA/siw: Fix user page pinning accounting

Bob Pearson (9):
      RDMA/rxe: Cleanup mr_check_range
      RDMA/rxe: Move rxe_map_mr_sg to rxe_mr.c
      RDMA-rxe: Isolate mr code from atomic_reply()
      RDMA-rxe: Isolate mr code from atomic_write_reply()
      RDMA/rxe: Cleanup page variables in rxe_mr.c
      RDMA/rxe: Replace rxe_map and rxe_phys_buf by xarray
      Subject: RDMA/rxe: Handle zero length rdma
      RDMA/rxe: Remove rxe_alloc()
      RDMA/rxe: Fix missing memory barriers in rxe_queue.h

Dan Carpenter (2):
      RDMA/mlx5: Check reg_create() create for errors
      iw_cxgb4: Fix potential NULL dereference in c4iw_fill_res_cm_id_entry()

Dean Luick (7):
      IB/hfi1: Remove redundant pageidx variable
      IB/hfi1: Assign npages earlier
      IB/hfi1: Consolidate the creation of user TIDs
      IB/hfi1: Improve TID validity checking
      IB/hfi1: Split IB counter allocation
      IB/hfi1: Update RMT size calculation
      IB/hfi1: Use dma_mmap_coherent for matching buffers

Deming Wang (1):
      RDMA/restrack: Correct spelling

Edward Srouji (1):
      IB/mlx5: Extend debug control for CC parameters

Gustavo A. R. Silva (1):
      RDMA/erdma: Replace zero-length arrays with flexible-array members

Jason Gunthorpe (3):
      RDMA/umem: Remove unused 'work' member from struct ib_umem
      RDMA/mlx5: Use rdma_umem_for_each_dma_block()
      Merge mlx5-next into rdma.git for-next

Kees Cook (2):
      RDMA/cxgb4: Replace 0-length arrays with flexible arrays
      RDMA/cma: Distinguish between sockaddr_in and sockaddr_in6 by size

Leon Romanovsky (3):
      Merge branch 'mlx5-next' into HEAD
      RDMA/mlx5: Fix MR cache debugfs error in IB representors mode
      RDMA/mlx5: Remove impossible check of mkey cache cleanup failure

Long Li (1):
      RDMA/mana_ib: Fix a bug when the PF indicates more entries for registering memory on first packet

Luoyouming (3):
      RDMA/hns: Remove rq inline in kernel
      RDMA/hns: Add compatibility handling for only support userspace rq inline
      RDMA/hns: Support cqe inline in user space

Mark Zhang (2):
      RDMA/cma: Refactor the inbound/outbound path records process flow
      RDMA/mlx: Calling qp event handler in workqueue context

Miaoqian Lin (3):
      RDMA/hfi1: Fix doc for hfi1_free_ctxt
      RDMA/erdma: Fix refcount leak in erdma_mmap
      RDMA/hns: Fix refcount leak in hns_roce_mmap

Michael Guralnik (4):
      RDMA/mlx5: Change the cache structure to an RB-tree
      RDMA/mlx5: Introduce mlx5r_cache_rb_key
      RDMA/mlx5: Cache all user cacheable mkeys on dereg MR flow
      RDMA/mlx5: Add work to remove temporary entries from the cache

Mustafa Ismail (1):
      RDMA/irdma: Cap MSIX used to online CPUs + 1

Nikita Zhandarovich (2):
      RDMA/cxgb4: add null-ptr-check after ip_dev_find()
      RDMA/cxgb4: Fix potential null-ptr-deref in pass_establish()

Or Har-Toov (4):
      net/mlx5: Expose bits for querying special mkeys
      net/mlx5: Change define name for 0x100 lkey value
      net/mlx5e: Use query_special_contexts for mkeys
      RDMA/mlx5: Use query_special_contexts for mkeys

Patrick Kelsey (2):
      IB/hfi1: Fix math bugs in hfi1_can_pin_pages()
      IB/hfi1: Fix sdma.h tx->num_descs off-by-one errors

Patrisious Haddad (2):
      RDMA/core: Refactor rdma_bind_addr
      RDMA/mlx5: Print error syndrome in case of fatal QP errors

Zhu Yanjun (6):
      RDMA/irdma: Remove extra ret variable in favor of existing err
      RDMA/irdma: Split MEM handler into irdma_reg_user_mr_type_mem
      RDMA/irdma: Split mr alloc and free into new functions
      RDMA/irdma: Split QP handler into irdma_reg_user_mr_type_qp
      RDMA/irdma: Split CQ handler into irdma_reg_user_mr_type_cq
      RDMA/irdma: Add support for dmabuf pin memory regions

 drivers/infiniband/core/cma.c                     | 300 ++++++-----
 drivers/infiniband/core/sa_query.c                | 171 ++----
 drivers/infiniband/hw/cxgb4/cm.c                  |   7 +
 drivers/infiniband/hw/cxgb4/cq.c                  |   2 +-
 drivers/infiniband/hw/cxgb4/restrack.c            |   2 +-
 drivers/infiniband/hw/cxgb4/t4fw_ri_api.h         |  26 +-
 drivers/infiniband/hw/erdma/erdma_hw.h            |   4 +-
 drivers/infiniband/hw/erdma/erdma_verbs.c         |   4 +-
 drivers/infiniband/hw/hfi1/chip.c                 |  59 ++-
 drivers/infiniband/hw/hfi1/exp_rcv.h              |   5 +-
 drivers/infiniband/hw/hfi1/file_ops.c             |  81 ++-
 drivers/infiniband/hw/hfi1/init.c                 |   2 +-
 drivers/infiniband/hw/hfi1/sdma.c                 |   4 +-
 drivers/infiniband/hw/hfi1/sdma.h                 |  15 +-
 drivers/infiniband/hw/hfi1/user_exp_rcv.c         |  46 +-
 drivers/infiniband/hw/hfi1/user_pages.c           |  61 ++-
 drivers/infiniband/hw/hfi1/verbs.c                |  81 ++-
 drivers/infiniband/hw/hns/hns_roce_device.h       |  19 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c        | 109 ++--
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h        |   3 +-
 drivers/infiniband/hw/hns/hns_roce_main.c         |  17 +-
 drivers/infiniband/hw/hns/hns_roce_qp.c           |  66 +--
 drivers/infiniband/hw/irdma/hw.c                  |   2 +
 drivers/infiniband/hw/irdma/verbs.c               | 313 +++++++----
 drivers/infiniband/hw/mana/main.c                 |  22 +-
 drivers/infiniband/hw/mlx4/main.c                 |   8 +
 drivers/infiniband/hw/mlx4/mlx4_ib.h              |   3 +
 drivers/infiniband/hw/mlx4/qp.c                   | 121 +++--
 drivers/infiniband/hw/mlx5/cmd.c                  |  45 +-
 drivers/infiniband/hw/mlx5/cmd.h                  |   3 +-
 drivers/infiniband/hw/mlx5/cong.c                 |  28 +-
 drivers/infiniband/hw/mlx5/main.c                 |  24 +-
 drivers/infiniband/hw/mlx5/mlx5_ib.h              |  51 +-
 drivers/infiniband/hw/mlx5/mr.c                   | 490 +++++++++++++----
 drivers/infiniband/hw/mlx5/odp.c                  |  67 +--
 drivers/infiniband/hw/mlx5/qp.c                   | 164 ++++--
 drivers/infiniband/hw/mlx5/qp.h                   |   4 +-
 drivers/infiniband/hw/mlx5/qpc.c                  |   7 +-
 drivers/infiniband/hw/mlx5/srq.c                  |   2 +-
 drivers/infiniband/hw/mlx5/umr.c                  |   4 +-
 drivers/infiniband/hw/mlx5/wr.c                   |   2 +-
 drivers/infiniband/sw/rxe/rxe.h                   |  38 ++
 drivers/infiniband/sw/rxe/rxe_loc.h               |  12 +-
 drivers/infiniband/sw/rxe/rxe_mr.c                | 606 ++++++++++++----------
 drivers/infiniband/sw/rxe/rxe_pool.c              |  46 --
 drivers/infiniband/sw/rxe/rxe_pool.h              |   3 -
 drivers/infiniband/sw/rxe/rxe_queue.h             | 108 ++--
 drivers/infiniband/sw/rxe/rxe_resp.c              | 202 +++-----
 drivers/infiniband/sw/rxe/rxe_verbs.c             | 115 ++--
 drivers/infiniband/sw/rxe/rxe_verbs.h             |  32 +-
 drivers/infiniband/sw/siw/siw_mem.c               |  23 +-
 drivers/infiniband/ulp/ipoib/ipoib_main.c         |   2 +-
 drivers/infiniband/ulp/srp/ib_srp.c               |   2 +-
 drivers/net/ethernet/mellanox/mlx4/qp.c           |  14 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c |  22 +-
 include/linux/mlx4/qp.h                           |   1 +
 include/linux/mlx5/driver.h                       |   1 -
 include/linux/mlx5/mlx5_ifc.h                     |  22 +-
 include/linux/mlx5/qp.h                           |   2 +-
 include/rdma/ib_sa.h                              |   2 +-
 include/rdma/ib_umem.h                            |   1 -
 include/rdma/ib_verbs.h                           |   2 +-
 include/rdma/rdma_cm.h                            |   1 -
 include/rdma/restrack.h                           |   4 +-
 include/uapi/rdma/hns-abi.h                       |   4 +
 65 files changed, 2112 insertions(+), 1597 deletions(-)
(diffstat from tag for-linus-merged)

--2CeHMBYhY8E7+S+z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRRRCHOFoQz/8F5bUaFwuHvBreFYQUCY/gSiQAKCRCFwuHvBreF
Ybq1AP4m8T+WUbM6F8buf+ymiF4Q0KFuyox78RGZsW6ag/3+1wEA+KRC5145/zJm
ecxyezMaXCuB4k0or5pW4oZaB6HXUA8=
=gSoM
-----END PGP SIGNATURE-----

--2CeHMBYhY8E7+S+z--
