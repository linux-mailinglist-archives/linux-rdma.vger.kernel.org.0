Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C343A6F1BA5
	for <lists+linux-rdma@lfdr.de>; Fri, 28 Apr 2023 17:35:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346454AbjD1PfI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 28 Apr 2023 11:35:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346456AbjD1Pev (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 28 Apr 2023 11:34:51 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2082.outbound.protection.outlook.com [40.107.244.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9391F26BA;
        Fri, 28 Apr 2023 08:34:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lLfsvSoGnstNITgmSlzWG9uDQJLqqmldDqSeWnJhFxwnc31L9QNVvVp1GYMFHTBFqFHvccwmDJ62GQuqm6k1oCH5izA9TFIclIak8DsZRK4halALWfN+A7lhcRqjZnGy/yFDjUDOKmfwSuXqoRKFUffwxpt1CQGp7/7PW2aZo3P28CcVY6KrT5y/oAJN9pJPiF3IF1wOttCcUAgasJc9ixPX78D3lxVJLTOVRpDziS4IGzpPSki+hFnV7ZSiTXGsgRUlZA0WvXL5RoRFlwYy/N757wq9TCe8N+XwuTXkQ3210WRfoLxL4ncYT34PoyRY1E0+ZukTnb/1HzEW2KosQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7f5/SH6zFLEKM4+luIvq0kOCOqU2QpCwu4JmmTIQ2gA=;
 b=ImrQnJAgZ2YUak3+EPt3qqro3D78Vl59eNNe64VU+8rTj2v1S3jzn0EZL9kfpw4Gvgav6AyhHUm9sw4HJZpYKnNc4CssoTKvjedi8Uxncdrzht4ZBHXFNgyynDmouR9EU/g2p3wO72Cw/Nov4g8Tdi4ePpEIoI83w++Qyl/88ruj8Nh6hkWmfK5CQIaiYetcZKbWxBBIEuI7fft9FIMhlS4qnrTzqAWZtmCWeZjb1L8NcqY+QihxA8gqhFpGxCaAQYgjIaS4CigdtsQd92uemDHKcOCUozj9EgoVXFLtnsjzJ2PNfG6sP4bMu6aBmo7Itfx9dteZY+LmjzWqIe3ovg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7f5/SH6zFLEKM4+luIvq0kOCOqU2QpCwu4JmmTIQ2gA=;
 b=XcsPHC5Sx1sF+t6OBSAM51fW50+eZ5YFVWezn9CRurUQl/c/f6qqP2f+O2636Q6qZDv32c8IJJF+XCPLHR4olQFxaUnCWB85UIfOhdtmmbKwBSLAcSQ3XXplmwNpS1db183WpRSOW2MFqB4DZduTNMd7Z3z8dciXwLNfcOUngOdD7Pwt55t1X0JaL2XtQ4t8XK9N/I0177EydpdB32OIrO3K0IqoA/NFycpFQTKJqt93DiI6/FBYxqlUuoNLKjl3trzH80SqkUX0zxYg/esX9As8c3GaBWiwegu7CmWR4Np8b3IPX3a96itjsAYWjtwtmHsBqgxDuwvsCp+yThBaBw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BL1PR12MB5127.namprd12.prod.outlook.com (2603:10b6:208:31b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.24; Fri, 28 Apr
 2023 15:34:46 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6340.024; Fri, 28 Apr 2023
 15:34:46 +0000
Date:   Fri, 28 Apr 2023 12:34:45 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Leon Romanovsky <leonro@nvidia.com>
Subject: [GIT PULL] Please pull RDMA subsystem changes
Message-ID: <ZEvnlQSpLI/4qnEp@nvidia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="yabkmyej/iNegr+A"
Content-Disposition: inline
X-ClientProxiedBy: MN2PR10CA0001.namprd10.prod.outlook.com
 (2603:10b6:208:120::14) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BL1PR12MB5127:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a3e68f2-9239-4484-49d0-08db47fe1863
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fWGX+X5uJbEmBnlqgvSmP3mEMdhbic89OedmuyTfdfXEGSceS6XChn5CU0pRRNaPvpZZOtxOqAJ5EU2q1dKdAc5Su7/tJIZ98uaLZgTEacXGkkOMyjL4Ie0v0mTC4T1aTITM88QtMV1egfcgXNTEj6fbQl+T3qEGqSnOw7A3X/rzwpO5da2EGvXZ1+gllVp1h45Q6JK0gaj4zlOmcMA7cT86DHkoeWimxLTp/Cd13QOvditQbSLAKx1dLdq8ai4rhb3WAXoRheGTXKyfQfYQnkZc1O0iH749cLtHBLE/9pKrEOqvaOrS3VykRvHSpgsBzszO5AA4Zwm+pe72W9dceC5BZTJ35yrCwCqvmrjYMoHGb70F0f+4+Hh6jh2j5odnpQdmm9PPNi5DfeEKPdUT85w0sA9DIn1c/+esrmGLyx3oHavVJw6Ld06WXY57hw7GoxJHD4GYB9ec//ir2/A/IdxvrkqkgoC7bWFmjx3h5LSgEdfr+Cx6RXokphXwmg2HmuIjmsTHNPsr4BDGr6H2TMFhD/Sxh5fWbCXAfmQvKb6fyYWC/bR8R9jm5p7ioWJv48JG40IH2RUdnPczFRpqdVypTCxE2ZvgYXJ8mJnhnwhugZd3DJ3JMxAcAFEcNojS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(396003)(136003)(366004)(346002)(451199021)(66556008)(6916009)(4326008)(66476007)(66946007)(478600001)(8676002)(8936002)(316002)(38100700002)(41300700001)(5660300002)(2616005)(21480400003)(186003)(83380400001)(6486002)(44144004)(107886003)(6506007)(26005)(6512007)(86362001)(36756003)(30864003)(2906002)(2700100001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yIZfXc83lzP3/xX6D51nsmAa/HfCyRUM1f61GqskTgGuP32xfyR6sEpmBCxu?=
 =?us-ascii?Q?6j9rpwx7yQ+L298xDIBacefX8yrY2nVS5ysXFcNFFKtG0Ul+V6lgCL3+FAvI?=
 =?us-ascii?Q?MTgyG+7euxpxpJK3CvwlPHCx4bCy6wK+q1Ovx1IUIcAJDYeyLt+ZbApS+kWD?=
 =?us-ascii?Q?+5tv0I8T0u4X3pjSaQcU1xcrlmP7W+TQQDLwV0258bLGWGtgBVJ8iv7/FNtb?=
 =?us-ascii?Q?LIaKwc3JOS8gyCWC9H+xWqnL0RZ3uacAhEfRMH4aGmoBe6aANu5i4sOeax5/?=
 =?us-ascii?Q?qMzzd67n5Mwa/tMnpU6zJ4kXvJ/4f6AlJixsAx5mKRqAsDQFQJQcPVnAhTi4?=
 =?us-ascii?Q?vHJrT2/unrjyvy/L1yLup4FdQAhrxQwAzGfTCe+btzvZipRkX0vmivrNb2HO?=
 =?us-ascii?Q?zCZ8oZxdqr+3jCR7bKHw9ryr+Oar2gzf752r/NQehM3IyslH2GI0C12FRPnj?=
 =?us-ascii?Q?OAw/gn8kRWR/waDtlvsIhNZIZkAldCBB0g10QqbfoXSlCY5g7uGMVDhpJtwa?=
 =?us-ascii?Q?Wvg+cZfptbKE3QiskOpcv/xaSMr6TU4/7U/vyT7gxSM1ohNB1V00cI+mteWy?=
 =?us-ascii?Q?5JigDhSzd6cbMz2WR1eniJ+V/e9dHsU5K+PV3HvmPsR4skRPgJzblB5HJ2ol?=
 =?us-ascii?Q?NyRr2iEuKgq3lcCUHVaXnzjXPCPNgHh9oI7ypgyv3vYyg17elEZCybZU07oR?=
 =?us-ascii?Q?/153B1jcgy0ZKACkfnsvbOyqgrA2deiZf2YIY4kcP+pTQlRimRPXL7PUYJ4m?=
 =?us-ascii?Q?FqL+w+Mv+CuMDcUvtedNsumF+U2b3wGOq+50WOXOUqQ29obVppghuxfrULDI?=
 =?us-ascii?Q?x+PkMfiJx9dM0bHP5fSHilZvsgt4F99SFdwffcpudYlVQuMAN9s1KSI5ASVX?=
 =?us-ascii?Q?ngZjiW2O6WUIFC8FdYmI7ARSmE/IPE/e8qy+MV4opM05mR61aI0FTTFa4kWR?=
 =?us-ascii?Q?asAdkJk+945C7XdZ4uXxIw6gRqWQ13t/BbQzfTa+a7/aCbP2GhYXl9qFYNXZ?=
 =?us-ascii?Q?Djh115b3Gpb65epcxvAyrAEDktxIYnESL2nHllq3dnNim721fvCnyfPrrFsF?=
 =?us-ascii?Q?dXGmVjoPLAL7sbqZX8P/MqM3DoXnDQpvGqIqEXQCOf5dz5OhJCyc8eDf8Vbv?=
 =?us-ascii?Q?s6nW06oNw+6HlD3tRS9SoOyLa+qYxx5y4Q8iY+rA8/Ikk9XMu163xDWA/Xx5?=
 =?us-ascii?Q?7tAIJrrvHtPgSU/YHMigYOKsf05xUwWT4f8qtAJfTGOtI5PmbS1/u5BOUX4B?=
 =?us-ascii?Q?Asjk5uZFYOoH7rp3mPdgbPsTYjBYTFTlNmTZrS3amDxwJztEVvRretQ2sJI7?=
 =?us-ascii?Q?G0KiD0s9M87OZJVd/+zaneixca49oOXqShJEzzwCN0JQrXMjAkbONsuN5v0A?=
 =?us-ascii?Q?0GHzrd9OUruPKI1ahXu7UdBwjDFNpQOi4ncGx2mQvPb79en6aGkouRgYL9W5?=
 =?us-ascii?Q?R11Y0+2tsfexHSjhhgXEZVOuTYYX8HK4iMEORPO8mNbdlhUDvjs9cMkhax7a?=
 =?us-ascii?Q?N7gk8SsbjKiv2nQEQh6ukPDOh9x703QoRER5+V6ljXUJbDLVmk5w/bWQrj+V?=
 =?us-ascii?Q?7Ad+jDpvrYY2cINk1MX/AEsUm78wWJ87eLbwPyeI?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a3e68f2-9239-4484-49d0-08db47fe1863
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2023 15:34:46.1970
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KBFiHmRxdq8vIKk9mnnXWcalFktrW+H8plKQuWvWZutAqtLMMryvuCQGqqKg4V3R
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5127
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

--yabkmyej/iNegr+A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Here is the RDMA pull request for 6.3 - as is now typical this is
mostly a whole range of unrelated changes in drivers. The few notable
series are highlighted in the tag.

Thanks,
Jason

The following changes since commit e8d018dd0257f744ca50a729e3d042cf2ec9da65:

  Linux 6.3-rc3 (2023-03-19 13:27:55 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

for you to fetch changes up to 531094dc7164718d28ebb581d729807d7e846363:

  RDMA/efa: Add rdma write capability to device caps (2023-04-21 19:18:58 -0300)

----------------------------------------------------------------
v6.4 merge window RDMA pull request

Usual wide collection of unrelated items in drivers:

- Driver bug fixes and treewide cleanups in hfi1, siw, qib, mlx5, rxe,
  usnic, usnic, bnxt_re, ocrdma, iser
   * Unnecessary NULL checks
   * kmap obsolescence
   * pci_enable_pcie_error_reporting() obsolescence
   * Unused variables and macros
   * trace event related warnings
   * casting warnings

- Code cleanups for irdm and erdma

- EFA reporting of 128 byte PCIe TLP support

- mlx5 more agressively uses the out of order HW feature

- Big rework of how state machines and tasks work in rxe

- Fix a syzkaller found crash netdev refcount leak in siw

- bnxt_re revises their HW description header

- Congestion control for bnxt_re

- Use mmu_notifiers more safely in hfi1

- mlx5 gets better support for PCIe relaxed ordering inside VMs

----------------------------------------------------------------
Avihai Horon (4):
      RDMA/mlx5: Remove pcie_relaxed_ordering_enabled() check for RO write
      RDMA/mlx5: Check pcie_relaxed_ordering_enabled() in UMR
      net/mlx5: Update relaxed ordering read HCA capabilities
      RDMA/mlx5: Allow relaxed ordering read in VFs and VMs

Bjorn Helgaas (2):
      IB/hfi1: Drop redundant pci_enable_pcie_error_reporting()
      IB/qib: Drop redundant pci_enable_pcie_error_reporting()

Bob Pearson (18):
      RDMA/rxe: Replace exists by rxe in rxe.c
      RDMA/rxe: Change rxe_dbg to rxe_dbg_dev
      RDMA/rxe: Extend dbg log messages to err and info
      RDMA/rxe: Add error messages
      RDMA/rxe: Convert tasklet args to queue pairs
      RDMA/rxe: Cleanup reset state handling in rxe_resp.c
      RDMA/rxe: Cleanup error state handling in rxe_comp.c
      RDMA/rxe: Remove qp reference counting in tasks
      RDMA/rxe: Remove __rxe_do_task()
      RDMA/rxe: Make tasks schedule each other
      RDMA/rxe: Rewrite rxe_task.c
      RDMA/rxe: Remove tasklet call from rxe_cq.c
      RDMA/rxe: Fix incorrect TASKLET_STATE_SCHED check in rxe_task.c
      RDMA/rxe: Remove qp->resp.state
      RDMA/rxe: Remove qp->comp.state
      RDMA/rxe: Remove qp->req.state
      RDMA/rxe: Move code to check if drained to subroutine
      RDMA/rxe: Protect QP state with qp->state_lock

Cai Huoqing (1):
      RDMA/usnic: Remove redundant pci_clear_master

Cheng Xu (4):
      RDMA/erdma: Unify byte ordering APIs usage
      RDMA/erdma: Eliminate unnecessary casting of EQ doorbells
      RDMA/erdma: Minor refactor of device init flow
      RDMA/erdma: Use fixed hardware page size

Christophe JAILLET (1):
      RDMA/irdma: Slightly optimize irdma_form_ah_cm_frame()

Daisuke Matsuda (1):
      RDMA/rxe: Fix spinlock recursion deadlock on requester

Dan Carpenter (1):
      RDMA/mlx4: Prevent shift wrapping in set_user_sq_size()

Daniil Dulov (1):
      RDMA/siw: Fix potential page_array out of range access

Dean Luick (1):
      IB/hfi1: Remove trace newlines

Ehab Ababneh (1):
      IB/hfi1: Suppress useless compiler warnings

Gustavo A. R. Silva (1):
      RDMA/core: Fix multiple -Warray-bounds warnings

Ira Weiny (1):
      RDMA/qib: Remove deprecated kmap() call

Jason Gunthorpe (1):
      RDMA: Add ib_virt_dma_to_page()

Kang Chen (1):
      IB/hifi1: add a null check of kzalloc_node in hfi1_ipoib_txreq_init

Kees Cook (1):
      IB/rdmavt: Fix target union member for rvt_post_one_wr()

Krzysztof Czurylo (1):
      RDMA/irdma: Refactor HW statistics

Leon Romanovsky (3):
      Enable IB out-of-order by default in mlx5
      Merge branch 'mlx5-next' into wip/leon-for-next
      RDMA/rxe: Clean kzalloc failure paths

Mark Bloch (1):
      RDMA/mlx5: Fix flow counter query via DEVX

Mark Zhang (2):
      RDMA/cm: Trace icm_send_rej event before the cm state is reset
      RDMA/mlx5: Use correct device num_ports when modify DC

Max Gurtovoy (3):
      IB/iser: remove unused macros
      IB/iser: centralize setting desc type and done callback
      IB/iser: remove redundant new line

Michal Swiatkowski (1):
      RDMA/irdma: Change name of interrupts

Natalia Petrova (1):
      RDMA/rdmavt: Delete unnecessary NULL check

Or Har-Toov (3):
      net/mlx5: Expose bits for enabling out-of-order by default
      RDMA/mlx5: Disable out-of-order in integrity enabled QPs
      net/mlx5: Set out of order (ooo) by default

Patrick Kelsey (3):
      IB/hfi1: Fix SDMA mmu_rb_node not being evicted in LRU order
      IB/hfi1: Fix bugs with non-PAGE_SIZE-end multi-iovec user SDMA requests
      IB/hfi1: Place struct mmu_rb_handler on cache line start

Patrisious Haddad (2):
      net/mlx5: Introduce other vport query for Q-counters
      RDMA/mlx5: Expand switchdev Q-counters to expose representor statistics

Rohit Chavan (1):
      RDMA/mlx5: Coding style fix reported by checkpatch

Saravanan Vajravel (1):
      RDMA/srpt: Add a check for valid 'mad_agent' pointer

Selvin Xavier (8):
      RDMA/bnxt_re: Add resize_cq support
      RDMA/bnxt_re: Update HW interface headers
      RDMA/bnxt_re: Remove HW queue mapping from RoCE Driver
      RDMA/bnxt_re: Convert RCFW_CMD_PREP macro to static inline function
      RDMA/bnxt_re: Reduce number of argumets to control path command APIs
      RDMA/bnxt_re: RoCE slow path TLV support
      RDAM/bnxt_re: Use tlv apis while processing the slow path commands
      RDMA/bnxt_re: Enable congestion control by default

Sindhu Devale (1):
      RDMA/irdma: Refactor PBLE functions

Tatyana Nikolova (1):
      RDMA/irdma: Remove a redundant irdma_arp_table() call

Tejun Heo (1):
      RDMA/irdma: Drop spurious WQ_UNBOUND from alloc_ordered_workqueue() call

Tetsuo Handa (1):
      RDMA/siw: Remove namespace check from siw_netdev_event()

Tom Rix (4):
      RDMA/bnxt_re: remove unused num_srqne_processed and num_cqne_processed variables
      RDMA/ocrdma: remove unused discard_cnt variable
      RDMA/mlx5: Remove unused num_alloc_xa_entries variable
      IB/qib: Remove unused cnt variable

Yang Li (1):
      RDMA/cma: Remove NULL check before dev_{put, hold}

Yixing Liu (1):
      RDMA/hns: Add new command to support query vf caps

Yonatan Nachum (2):
      RDMA/efa: Add data polling capability feature bit
      RDMA/efa: Add rdma write capability to device caps

Zhu Yanjun (1):
      RDMA/rxe: Fix the error "trying to register non-static key in rxe_cleanup_task"

 drivers/infiniband/core/cm.c                       |    3 +-
 drivers/infiniband/core/cma.c                      |    6 +-
 drivers/infiniband/core/user_mad.c                 |   23 +-
 drivers/infiniband/hw/bnxt_re/ib_verbs.c           |  109 +
 drivers/infiniband/hw/bnxt_re/ib_verbs.h           |    3 +
 drivers/infiniband/hw/bnxt_re/main.c               |  103 +-
 drivers/infiniband/hw/bnxt_re/qplib_fp.c           |  211 +-
 drivers/infiniband/hw/bnxt_re/qplib_fp.h           |    5 +
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.c         |   97 +-
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.h         |   66 +-
 drivers/infiniband/hw/bnxt_re/qplib_sp.c           |  337 +-
 drivers/infiniband/hw/bnxt_re/qplib_sp.h           |   68 +-
 drivers/infiniband/hw/bnxt_re/qplib_tlv.h          |  162 +
 drivers/infiniband/hw/bnxt_re/roce_hsi.h           | 7423 ++++++++++++--------
 drivers/infiniband/hw/efa/efa_admin_cmds_defs.h    |   17 +-
 drivers/infiniband/hw/efa/efa_io_defs.h            |   42 +-
 drivers/infiniband/hw/efa/efa_verbs.c              |   11 +-
 drivers/infiniband/hw/erdma/erdma.h                |    2 +-
 drivers/infiniband/hw/erdma/erdma_cm.h             |   10 +-
 drivers/infiniband/hw/erdma/erdma_cmdq.c           |   42 +-
 drivers/infiniband/hw/erdma/erdma_cq.c             |    2 +-
 drivers/infiniband/hw/erdma/erdma_eq.c             |    9 +-
 drivers/infiniband/hw/erdma/erdma_hw.h             |    4 +
 drivers/infiniband/hw/erdma/erdma_main.c           |   39 +-
 drivers/infiniband/hw/erdma/erdma_verbs.c          |   17 +-
 drivers/infiniband/hw/hfi1/chip.c                  |   18 +-
 drivers/infiniband/hw/hfi1/driver.c                |    2 +-
 drivers/infiniband/hw/hfi1/file_ops.c              |    2 +-
 drivers/infiniband/hw/hfi1/init.c                  |   12 +-
 drivers/infiniband/hw/hfi1/ipoib_tx.c              |    6 +-
 drivers/infiniband/hw/hfi1/mmu_rb.c                |   84 +-
 drivers/infiniband/hw/hfi1/mmu_rb.h                |   22 +-
 drivers/infiniband/hw/hfi1/pcie.c                  |    2 -
 drivers/infiniband/hw/hfi1/pio.c                   |    2 +-
 drivers/infiniband/hw/hfi1/sdma.c                  |   21 +-
 drivers/infiniband/hw/hfi1/sdma.h                  |   16 +-
 drivers/infiniband/hw/hfi1/sdma_txreq.h            |    1 +
 drivers/infiniband/hw/hfi1/trace_dbg.h             |    7 +
 drivers/infiniband/hw/hfi1/trace_mmu.h             |    4 -
 drivers/infiniband/hw/hfi1/user_sdma.c             |  600 +-
 drivers/infiniband/hw/hfi1/user_sdma.h             |    5 -
 drivers/infiniband/hw/hfi1/verbs.c                 |    4 +-
 drivers/infiniband/hw/hfi1/vnic_sdma.c             |    1 +
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c         |  189 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h         |   31 +-
 drivers/infiniband/hw/irdma/cm.c                   |    2 +-
 drivers/infiniband/hw/irdma/ctrl.c                 |  324 +-
 drivers/infiniband/hw/irdma/defs.h                 |    9 +-
 drivers/infiniband/hw/irdma/hw.c                   |   17 +-
 drivers/infiniband/hw/irdma/i40iw_hw.c             |   60 +-
 drivers/infiniband/hw/irdma/icrdma_hw.c            |   51 +
 drivers/infiniband/hw/irdma/irdma.h                |    1 +
 drivers/infiniband/hw/irdma/main.h                 |    3 +
 drivers/infiniband/hw/irdma/pble.c                 |   16 +-
 drivers/infiniband/hw/irdma/pble.h                 |    2 +-
 drivers/infiniband/hw/irdma/protos.h               |    8 +-
 drivers/infiniband/hw/irdma/type.h                 |  166 +-
 drivers/infiniband/hw/irdma/utils.c                |  172 +-
 drivers/infiniband/hw/irdma/verbs.c                |  200 +-
 drivers/infiniband/hw/mlx4/qp.c                    |    8 +-
 drivers/infiniband/hw/mlx5/counters.c              |  171 +-
 drivers/infiniband/hw/mlx5/devx.c                  |   33 +-
 drivers/infiniband/hw/mlx5/mr.c                    |   12 +-
 drivers/infiniband/hw/mlx5/qp.c                    |   19 +-
 drivers/infiniband/hw/mlx5/umr.c                   |    7 +-
 drivers/infiniband/hw/mlx5/umr.h                   |    3 +-
 drivers/infiniband/hw/ocrdma/ocrdma_verbs.c        |    2 -
 drivers/infiniband/hw/qib/qib_file_ops.c           |    9 +-
 drivers/infiniband/hw/qib/qib_pcie.c               |    8 -
 drivers/infiniband/hw/qib/qib_user_sdma.c          |   11 +-
 drivers/infiniband/hw/usnic/usnic_ib_main.c        |    2 -
 drivers/infiniband/sw/rdmavt/qp.c                  |    4 +-
 drivers/infiniband/sw/rxe/rxe.c                    |   16 +-
 drivers/infiniband/sw/rxe/rxe.h                    |   46 +-
 drivers/infiniband/sw/rxe/rxe_comp.c               |  161 +-
 drivers/infiniband/sw/rxe/rxe_cq.c                 |   39 +-
 drivers/infiniband/sw/rxe/rxe_icrc.c               |    4 +-
 drivers/infiniband/sw/rxe/rxe_loc.h                |    7 +-
 drivers/infiniband/sw/rxe/rxe_mmap.c               |    6 +-
 drivers/infiniband/sw/rxe/rxe_mr.c                 |   29 +-
 drivers/infiniband/sw/rxe/rxe_net.c                |   11 +-
 drivers/infiniband/sw/rxe/rxe_qp.c                 |  263 +-
 drivers/infiniband/sw/rxe/rxe_queue.c              |    5 +-
 drivers/infiniband/sw/rxe/rxe_recv.c               |   15 +-
 drivers/infiniband/sw/rxe/rxe_req.c                |  104 +-
 drivers/infiniband/sw/rxe/rxe_resp.c               |  126 +-
 drivers/infiniband/sw/rxe/rxe_srq.c                |    6 +-
 drivers/infiniband/sw/rxe/rxe_task.c               |  268 +-
 drivers/infiniband/sw/rxe/rxe_task.h               |   23 +-
 drivers/infiniband/sw/rxe/rxe_verbs.c              |  983 ++-
 drivers/infiniband/sw/rxe/rxe_verbs.h              |   14 -
 drivers/infiniband/sw/siw/siw_main.c               |    3 -
 drivers/infiniband/sw/siw/siw_qp_rx.c              |    6 +-
 drivers/infiniband/sw/siw/siw_qp_tx.c              |   21 +-
 drivers/infiniband/sw/siw/siw_verbs.c              |    4 +-
 drivers/infiniband/ulp/iser/iser_initiator.c       |   17 +-
 drivers/infiniband/ulp/iser/iser_verbs.c           |    6 -
 drivers/infiniband/ulp/srpt/ib_srpt.c              |   23 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_hsi.h      |   81 +
 .../net/ethernet/mellanox/mlx5/core/en/params.c    |    3 +-
 .../net/ethernet/mellanox/mlx5/core/en_common.c    |    9 +-
 drivers/net/ethernet/mellanox/mlx5/core/main.c     |    3 +
 include/linux/mlx5/mlx5_ifc.h                      |   31 +-
 include/rdma/ib_verbs.h                            |   25 +
 include/uapi/rdma/bnxt_re-abi.h                    |    4 +
 include/uapi/rdma/efa-abi.h                        |    4 +-
 106 files changed, 8007 insertions(+), 5519 deletions(-)
 create mode 100644 drivers/infiniband/hw/bnxt_re/qplib_tlv.h

--yabkmyej/iNegr+A
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRRRCHOFoQz/8F5bUaFwuHvBreFYQUCZEvnkwAKCRCFwuHvBreF
YUk+AQDfIB6MLT2dl+7tOreWrLlILTVUGOBJjm2trPfPrrALAQD/c0A2F78WOBnh
4Zf7eKqKYDs+Uikkvne84TA2iMGKzA4=
=Fzt3
-----END PGP SIGNATURE-----

--yabkmyej/iNegr+A--
