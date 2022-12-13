Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0374B64BE31
	for <lists+linux-rdma@lfdr.de>; Tue, 13 Dec 2022 22:05:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235574AbiLMVFx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 13 Dec 2022 16:05:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235771AbiLMVFx (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 13 Dec 2022 16:05:53 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2057.outbound.protection.outlook.com [40.107.100.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D50202181A;
        Tue, 13 Dec 2022 13:05:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MMuKw5bY4jSit9YLp5pyexbnAfhkt4jepR4c7Km6j0g7FiPD/WuhRJpmIapx2lfjZ1nXA0+ySpPu98fO4T3RdJN+VjmKxEUUSpBIa/FAxH692oTufNGYHaPna2vWqho5lP1pTymWLK/NpUUvXJEq1XoDVjawLMk+9AgICHDpXMHzTMpSKtmX8gx/QLTyGGmzoF58htUeHLlenI6740B9XFtW3tc+qvNyUu7NSBlR/DXtBGL+VFJBGBv0vHRTQ020utP/OtIYotZfpeYaqjXk187yQMf21eRo+qD6WtvC+4gZkevQU0fSUoxZ7cyVUrhVvR9ZiAqiK+AhhxYMyAsm8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e8MZLe0HfT6SpO/UEjjA6DEpcuDN1bUrcgSa4Ye+MmU=;
 b=lXpTdkTpOukUb8ovsmnChntXasJOoS91AjS4mxNgLAUixS+ecCL3jN7YbbARpexZQ3rvHvbm0qDlpaN+eNtR1g454Kcr0VSSJxYADqBT2o5ApH/ii/OuMNhFByAKGigxFqeuyZ5eHkWnNTYSNColcijvl9JcAYmnkoePkdcai0pAhwtN67ZSN58N4vRxYL0lyLM+/Z0pbPUR7Qih0BvJ3DrjDfJUPhD+Lw7bW31MTUHFQWsvXEnbttweLSIzGMP/bfrdjzWo1mQjg8dVrqRMXRv+ohAp9UH0EyekYoD46FetadrhTl77eE/b0GpJVVk212Ts+SCnCONpX0Zt2stUng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e8MZLe0HfT6SpO/UEjjA6DEpcuDN1bUrcgSa4Ye+MmU=;
 b=qV6J0icoRo8F9YMp25NC5CosLPj7lW3vR83vh90cX6WfDD+M47guZZ/Kzrfv4EBeA9gIqdhI9nSNZgnms/XYsPfZBYO5d9OMSdAtuCkOgInkk3BG9U8X9NCQu6ZOf0UQrVU+ZyPnKPQBKIkMIrOIeibTzE1/cdt3+1iJnC1c6n/08su24vgSCdAqy7rHoiENn/vFrGkclPJ1T+kxOJP+YV9rHcdMCoJ0PUt2elmJi8QLGWfL/eTIDPdZfkF0G8/nienUQcJoES0V3FR4bVjJqpxMS4GjaymeiwNsMZE5sqkZj9qLvkFFQw8Mw6OISWD82D2vzTakxwbWTFT3KUAPLw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CY5PR12MB6106.namprd12.prod.outlook.com (2603:10b6:930:29::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Tue, 13 Dec
 2022 21:05:48 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%8]) with mapi id 15.20.5880.019; Tue, 13 Dec 2022
 21:05:48 +0000
Date:   Tue, 13 Dec 2022 17:05:46 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Leon Romanovsky <leonro@nvidia.com>
Subject: [GIT PULL] Please pull RDMA subsystem changes
Message-ID: <Y5jpKmpwhTAf+r8B@nvidia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Aa7/F1QGVEnI16cV"
Content-Disposition: inline
X-ClientProxiedBy: MN2PR10CA0005.namprd10.prod.outlook.com
 (2603:10b6:208:120::18) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CY5PR12MB6106:EE_
X-MS-Office365-Filtering-Correlation-Id: d2b126b4-c193-4eb9-22bf-08dadd4dced5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u21ZqC3AZ9OJLzPEAGGxU9VzRD79zz/WGjxEbOEaKmSumM6DLDIZs/0CNgcGeytkdBKayUxsoEgUY7A6p5m1JFqMHYKe4ammz5p8zDB2QSw8os9/MK+aYWdgrjBybKH7r4f4Lm/KhtX4YNmULT3jTGvXvxDZH+fxIQKOHRz2uqmRDGk2DBtBAf1fRcVrxg6VV2WxfeYGfLiT1kiKdWW8q0+Nl233L1GzuG6MplOTBua/8A9cfiRwnyGQ1/z9vaHMQshWpjHehXTfaCZxdDrvplt46yt8GzDIqxHg9gIy5Jr2QJgG2U8iM0OLxAHKRXPBFKieBhC4gvczw6bI6z5VKW5N3YLoEmJ2yPUNjxq2QcaCfbt5+kjTZ4oeSbQTbiUr5alaI9oXccGEu7kCBSO5QixPM+fcVcanR0Iuo81GNt2D/xaRf4XGbjutbO4DAvxG48fx/lVnioQP7D/KGog+/nALGV8iuFGM3GK6s2U6eXDKkI7hsswKZYrAQ7BjHf4JUq/BqqLezrNjzWhiXDoT/9mgBK2Ial2qGJojH8vEX2ysrFOWWkCv3jnfX9dyWy9lT7m3IYBmAno/ooVrHEQCYbGhyLo7dhXGFvPnQMs5G29UK4xkh1SqhHkUJdy/TXbPSoyT42tabr8Lxd3mOhTDNehlq+dmIdjzTntgjAaMkbbO/F7dx8UdqOEJivyqHQbe3iJWOfbTAdHyWg9t2x7zc599N2QhRhs2SUYEwfIHA0JDtMZPRwYwpcyx+IHTWcuUBeiw7eMCvipB0w+dCcOih7W2hN+YMN5ja7xMmrndlzj3f3CCXCjcFXUSTKuEo/vm
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(376002)(366004)(39860400002)(346002)(451199015)(4001150100001)(8676002)(966005)(66556008)(36756003)(66946007)(38100700002)(5660300002)(66476007)(4326008)(6916009)(86362001)(21480400003)(8936002)(30864003)(316002)(41300700001)(6506007)(44144004)(107886003)(186003)(6512007)(2906002)(26005)(478600001)(2616005)(6486002)(45080400002)(83380400001)(21314003)(2700100001)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pxu7rhDyARx/9Be7cJf+EEjJE8fJiEK16m9mGWNGa82/koYAVX81xvITEG7I?=
 =?us-ascii?Q?G5+BCYPBsGQRhyhG7TKI12ntBa8tlzWx75uTJk0BpFayXF0cCj/BEuhQoZgD?=
 =?us-ascii?Q?+D0SOPhP/9Nk/tE7pe7SImeaD6ATKRx12ciQEAK7/FrU7c90onSni8+El20P?=
 =?us-ascii?Q?crELVVhgoS3SkVpBEpRu9d6SXgMOV1DuFaBlz/YETRM1g8W+OUN3OIBkB+3x?=
 =?us-ascii?Q?wpsk+s0+OBIFQKgoO6kWu7a7VpKNWoQTVVL3XpyytndvurXHwZ7je6O5g7uC?=
 =?us-ascii?Q?TXZU905LHvIH0djTSleObWqcZn5emv1wgA+eRj3DSEaP9X2YTdIbNsls6sxP?=
 =?us-ascii?Q?DnWodsskweVO2eAuUCbkHazMRpmyE2tWt3A9Nv9LAiqSfCEb7Fugof+/pc1i?=
 =?us-ascii?Q?kuqg9srn1moL/Ad2CGfAApt1qqMIk6XXY0Y2YRMYS3x0nyeIK19HiC/Eb+KM?=
 =?us-ascii?Q?nFsBCzTNRvjEad+2ZlfjvnSDEXKhDys43sEqd7ibY0oWUFKGGOrFJSjDQ/qB?=
 =?us-ascii?Q?gKDosDJWovMbtU5YhIdBSu5cfIn/SZkxSjp8uVAVAEt9hW9pnQa7SjGl2XnS?=
 =?us-ascii?Q?eSbtqQ4B4oipD1rSEhlsG29IkSPdS6OPwui6ImiHNksWW4ur3zvcmjeVqJ80?=
 =?us-ascii?Q?ml8RdpLRR60hfRjiTKe2HeDuv2YqKKi2Yh22QuX5mOzL6SKZY6pf4z7laZqG?=
 =?us-ascii?Q?f2me9WA1tV3ivZ4UAaIpJFAEEmzLeg6SXzhFZ30hDbFW9fHcxiM0vBhAU/yZ?=
 =?us-ascii?Q?pLoM6DcZHXqCcvKdreWpnlr56fVLZ2gcketZ7Q+legDKYfB1ySRE5P5UlLO9?=
 =?us-ascii?Q?rG5hQgGlP4i18IifJ0y1BJ1/QIKJU9U5HdpYumVT9qzbXmAVGlJ9xrA7CPOo?=
 =?us-ascii?Q?FniLfSbGrPcx+WG+EzG+JRQNzG5mhlWmTkHswsGaNpJ2gfSpfKKsF3JJIEPA?=
 =?us-ascii?Q?8PUUThUTmbMyOnJJoDU+s92fDQrAajZwNZhYVFrhJciQHaPqxz7QynSMTGXE?=
 =?us-ascii?Q?J74U2UwUyTNVUj7dhqczFXvpOfgS0kPYg3wNDKeegkQRpuSoAAnwJXfZQGxA?=
 =?us-ascii?Q?0q+/BfmHt1Of3DdM5iuJCoyXZKCJn/xYaAnCFIxIOC60iybcXhsWSbvQT4a1?=
 =?us-ascii?Q?wYH6SFPKf6MM9YkPcmeeQaxDlsk5r8hbz4yOxhgbDTYS+v0tFr2vyou21ITl?=
 =?us-ascii?Q?RFfawJ/SMGNBv9heA0v+rIsmJcooNN7D+PZvNOi6r4Ght61FEBOu+C9nSLF3?=
 =?us-ascii?Q?pN05892Lx79uARM26PZVtwLkTscxJzO5g9TMhyy5TObqnvUsZrkX6lD8iY19?=
 =?us-ascii?Q?lNyTQtRvO3jOYfv7gN5so/FLqD4+gDrp6KOJMI1kyfEJm6K8RVkZuwWKmydc?=
 =?us-ascii?Q?J+Ua26mC45/Qw7WlO2VyqwBO112rlL+0axO9fyT5zYQ0nJqKlQLeL2ZI3Qi9?=
 =?us-ascii?Q?6ediHNjhQI8hKGpiuCKhPZQowZWvu7dqYo//QrDKmTwPGUpm+GxM6cxZ8gE8?=
 =?us-ascii?Q?/PoFjL6bs9yOVV/QG9HceBpZi5EnkHmJj21xEcPSlk+GjdAhDPZWulK0OCWx?=
 =?us-ascii?Q?NpAfn00nCwDa8NOevHFIDcDT4oyMq3Zyxn1unHWn?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2b126b4-c193-4eb9-22bf-08dadd4dced5
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2022 21:05:48.0515
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mI++FMYO+8OqPNtCqKk/ui2ENNdOWIXKX009/YM6IhROpZMkRc3MTVLUs/Ttb7uz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6106
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--Aa7/F1QGVEnI16cV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

This cycle saw a new driver called MANA get merged and more fixing to
the other recently merged drivers. rxe continues to see a lot of
interest and fixing. Lots more rxe patches already in the works for
the next cycle.

Thanks,
Jason

The following changes since commit 76dcd734eca23168cb008912c0f69ff408905235:

  Linux 6.1-rc8 (2022-12-04 14:48:12 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

for you to fetch changes up to dbc94a0fb81771a38733c0e8f2ea8c4fa6934dc1:

  IB/IPoIB: Fix queue count inconsistency for PKEY child interfaces (2022-12-11 11:04:19 +0200)

----------------------------------------------------------------
v6.2 merge window  pull request

Usual size of updates, a new driver a most of the bulk focusing on rxe:

- Usual typos, style, and language updates

- Driver updates for mlx5, irdma, siw, rts, srp, hfi1, hns, erdma, mlx4, srp

- Lots of RXE updates
  * Improve reply error handling for bad MR operations
  * Code tidying
  * Debug printing uses common loggers
  * Remove half implemented RD related stuff
  * Support IBA's recently defined Atomic Write and Flush operations

- erdma support for atomic operations

- New driver "mana" for Ethernet HW available in Azure VMs. This driver
  only supports DPDK

----------------------------------------------------------------
Ajay Sharma (3):
      net: mana: Set the DMA device max segment size
      net: mana: Define and process GDMA response code GDMA_STATUS_MORE_ENTRIES
      net: mana: Define data structures for protection domain and memory registration

Arumugam Kolappan (1):
      RDMA/mlx5: Change debug log level for remote access error syndromes

Bernard Metzler (2):
      RDMA/siw: Fix immediate work request flush to completion queue
      RDMA/siw: Set defined status for work completion with undefined status

Bob Pearson (23):
      RDMA/rxe: Remove redundant header files
      RDMA/rxe: Remove init of task locks from rxe_qp.c
      RDMA/rxe: Removed unused name from rxe_task struct
      RDMA/rxe: Split rxe_run_task() into two subroutines
      RDMA/rxe: Make rxe_do_task static
      RDMA/rxe: Rename task->state_lock to task->lock
      RDMA/rxe: Add ibdev_dbg macros for rxe
      RDMA/rxe: Replace pr_xxx by rxe_dbg_xxx in rxe_comp.c
      RDMA/rxe: Replace pr_xxx by rxe_dbg_xxx in rxe_cq.c
      RDMA/rxe: Replace pr_xxx by rxe_dbg_xxx in rxe_mr.c
      RDMA/rxe: Replace pr_xxx by rxe_dbg_xxx in rxe_mw.c
      RDMA/rxe: Replace pr_xxx by rxe_dbg_xxx in rxe_net.c
      RDMA/rxe: Replace pr_xxx by rxe_dbg_xxx in rxe_qp.c
      RDMA/rxe: Replace pr_xxx by rxe_dbg_xxx in rxe_req.c
      RDMA/rxe: Replace pr_xxx by rxe_dbg_xxx in rxe_resp.c
      RDMA/rxe: Replace pr_xxx by rxe_dbg_xxx in rxe_srq.c
      RDMA/rxe: Replace pr_xxx by rxe_dbg_xxx in rxe_verbs.c
      RDMA/rxe: Replace pr_xxx by rxe_dbg_xxx in rxe_av.c
      RDMA/rxe: Replace pr_xxx by rxe_dbg_xxx in rxe_task.c
      RDMA/rxe: Replace pr_xxx by rxe_dbg_xxx in rxe.c
      RDMA/rxe: Replace pr_xxx by rxe_dbg_xxx in rxe_icrc.c
      RDMA/rxe: Replace pr_xxx by rxe_dbg_xxx in rxe_mmap.c
      RDMA/rxe: Fix incorrect responder length checking

Chao Leng (1):
      RDMA/cma: Change RoCE packet life time from 18 to 16

Cheng Xu (7):
      RDMA/erdma: Extend access right field of FRMR and REG MR to support atomic
      RDMA/erdma: Report atomic capacity when hardware supports atomic feature
      RDMA/erdma: Implement atomic operations support
      RDMA/erdma: Fix a typo in annotation
      RDMA/erdma: Add a workqueue for WRs reflushing
      RDMA/erdma: Implement the lifecycle of reflushing work for each QP
      RDMA/erdma: Notify the latest PI to FW for reflushing when necessary

Chengchang Tang (5):
      RDMA/hns: Fix AH attr queried by query_qp
      RDMA/hns: Fix PBL page MTR find
      RDMA/hns: Fix page size cap from firmware
      RDMA/hns: Fix error code of CMD
      RDMA/hns: Fix XRC caps on HIP08

Colin Ian King (2):
      RDMA/qib: Remove not-used variable n
      RDMA/qib: Remove not-used variable freeze_cnt

Daisuke Matsuda (4):
      RDMA/rxe: Make responder handle RDMA Read failures
      RDMA/rxe: Handle remote errors in the midst of a Read reply sequence
      RDMA/rxe: Implement packet length validation on responder
      RDMA/rxe: Fix oops with zero length reads

Deming Wang (1):
      IB/uverbs: fix the typo of optional

Dragos Tatulea (1):
      IB/IPoIB: Fix queue count inconsistency for PKEY child interfaces

Guoqing Jiang (8):
      RDMA/rtrs-srv: Refactor rtrs_srv_rdma_cm_handler
      RDMA/rtrs-srv: Refactor the handling of failure case in map_cont_bufs
      RDMA/rtrs-srv: Correct the checking of ib_map_mr_sg
      RDMA/rtrs-clt: Correct the checking of ib_map_mr_sg
      RDMA/rtrs-srv: Remove outdated comments from create_con
      RDMA/rtrs: Clean up rtrs_rdma_dev_pd_ops
      RDMA/rtrs-srv: Fix several issues in rtrs_srv_destroy_path_files
      RDMA/rtrs-srv: Remove kobject_del from rtrs_srv_destroy_once_sysfs_root_folders

Jason Gunthorpe (4):
      RDMA/rxe: Do not NULL deref on debugging failure path
      RDMA: Add netdevice_tracker to ib_device_set_netdev()
      Merge tag 'v6.1-rc8' into rdma.git for-next
      RDMA: Add missed netdev_put() for the netdevice_tracker

Jiangshan Yi (1):
      RDMA/opa_vnic: fix spelling typo in comment

Kees Cook (1):
      IB/hfi1: Replace 1-element array with singleton

Leon Romanovsky (3):
      RDMA/core: Fix order of nldev_exit call
      Merge branch 'mana-shared-6.2' of https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma
      RDMA/mana: Remove redefinition of basic u64 type

Leonid Ravich (1):
      IB/mad: Don't call to function that might sleep while in atomic context

Li Zhijian (15):
      RDMA/core: return -EOPNOSUPP for ODP unsupported device
      RDMA/rxe: Remove unnecessary mr testing
      RDMA/rxe: Make sure requested access is a subset of {mr,mw}->access
      RDMA/rxe: Fix mr->map double free
      RDMA/mlx5: no need to kfree NULL pointer
      RDMA: Extend RDMA user ABI to support flush
      RDMA: Extend RDMA kernel verbs ABI to support flush
      RDMA/rxe: Extend rxe user ABI to support flush
      RDMA/rxe: Allow registering persistent flag for pmem MR only
      RDMA/rxe: Extend rxe packet format to support flush
      RDMA/rxe: Implement RC RDMA FLUSH service in requester side
      RDMA/rxe: Implement flush execution in responder side
      RDMA/rxe: Implement flush completion
      RDMA/cm: Make QP FLUSHABLE for supported device
      RDMA/rxe: Enable RDMA FLUSH capability for rxe device

Long Li (9):
      net: mana: Add support for auxiliary device
      net: mana: Record the physical address for doorbell page region
      net: mana: Handle vport sharing between devices
      net: mana: Export Work Queue functions for use by RDMA driver
      net: mana: Record port number in netdev
      net: mana: Move header files to a common location
      net: mana: Define max values for SGL entries
      net: mana: Define data structures for allocating doorbell page from GDMA
      RDMA/mana_ib: Add a driver for Microsoft Azure Network Adapter

Luoyouming (2):
      RDMA/hns: Fix ext_sge num error when post send
      RDMA/hns: Fix incorrect sge nums calculation

Mark Zhang (4):
      RDMA/restrack: Release MR restrack when delete
      RDMA/core: Make sure "ib_port" is valid when access sysfs node
      RDMA/nldev: Return "-EAGAIN" if the cm_id isn't from expected port
      RDMA/nldev: Fix failure to send large messages

Maurizio Lombardi (1):
      IB/isert: use the ISCSI_LOGIN_CURRENT_STAGE macro

Max Gurtovoy (2):
      IB/iser: add safety checks for state_mutex lock
      IB/iser: open code iser_disconnected_handler

Mustafa Ismail (4):
      RDMA/irdma: Fix inline for multiple SGE's
      RDMA/irdma: Fix RQ completion opcode
      RDMA/irdma: Do not request 2-level PBLEs for CQ alloc
      RDMA/irdma: Initialize net_type before checking it

Or Har-Toov (1):
      RDMA/nldev: Add NULL check to silence false warnings

Randy Dunlap (1):
      RDMA: Disable IB HW for UML

Sergey Gorenko (1):
      IB/iser: open code iser_conn_state_comp_exch

Shiraz Saleem (1):
      RDMA/irdma: Report the correct link speed

Wang Yufen (2):
      RDMA/hfi1: Fix error return code in parse_platform_config()
      RDMA/srp: Fix error return code in srp_parse_options()

Xiao Yang (9):
      RDMA/rxe: Remove the duplicate assignment of mr->map_shift
      RDMA: Extend RDMA user ABI to support atomic write
      RDMA: Extend RDMA kernel ABI to support atomic write
      RDMA/rxe: Extend rxe user ABI to support atomic write
      RDMA/rxe: Extend rxe packet format to support atomic write
      RDMA/rxe: Make requester support atomic write on RC service
      RDMA/rxe: Make responder support atomic write on RC service
      RDMA/rxe: Implement atomic write completion
      RDMA/rxe: Enable atomic write capability for rxe device

Xiongfeng Wang (1):
      RDMA/hfi: Decrease PCI device reference count in error path

Yang Yang (1):
      IB/hfi1: Switch to netif_napi_add()

Yixing Liu (1):
      RDMA/hns: Fix the gid problem caused by free mr

Yuan Can (1):
      RDMA/nldev: Add checks for nla_nest_start() in fill_stat_counter_qps()

Yunsheng Lin (1):
      RDMA/rxe: cleanup some error handling in rxe_verbs.c

Zhang Xiaoxu (1):
      RDMA/rxe: Fix NULL-ptr-deref in rxe_qp_do_cleanup() when socket create failed

Zhengchao Shao (1):
      RDMA/hns: fix memory leak in hns_roce_alloc_mr()

Zhu Yanjun (2):
      RDMA/rxe: Remove reliable datagram support
      RDMA/mlx5: Remove not-used IB_FLOW_SPEC_IB define

wangjianli (3):
      RDMA/qib: fix repeated words in comments
      RDMA/core: fix repeated words in comments
      RDMA/qedr: fix repeated words in comments

yangx.jy@fujitsu.com (1):
      RDMA/rxe: Remove the member 'type' of struct rxe_mr

ye xingchen (1):
      RDMA/hfi1: use sysfs_emit() to instead of scnprintf()

zhang songyi (1):
      RDMA/mlx4: Remove NULL check before dev_{put, hold}

 MAINTAINERS                                        |  10 +
 drivers/infiniband/Kconfig                         |   3 +
 drivers/infiniband/core/cache.c                    |   2 +-
 drivers/infiniband/core/cm.c                       |  13 +-
 drivers/infiniband/core/cma.c                      |   2 +-
 drivers/infiniband/core/device.c                   |  10 +-
 drivers/infiniband/core/mad.c                      |   5 -
 drivers/infiniband/core/nldev.c                    |  50 +-
 drivers/infiniband/core/restrack.c                 |   2 -
 drivers/infiniband/core/sysfs.c                    |  17 +-
 drivers/infiniband/core/uverbs_std_types_qp.c      |   2 +-
 drivers/infiniband/hw/Makefile                     |   1 +
 drivers/infiniband/hw/erdma/erdma.h                |   4 +-
 drivers/infiniband/hw/erdma/erdma_cq.c             |   2 +
 drivers/infiniband/hw/erdma/erdma_hw.h             |  37 +-
 drivers/infiniband/hw/erdma/erdma_main.c           |  15 +-
 drivers/infiniband/hw/erdma/erdma_qp.c             |  73 ++-
 drivers/infiniband/hw/erdma/erdma_verbs.c          |  25 +-
 drivers/infiniband/hw/erdma/erdma_verbs.h          |  19 +-
 drivers/infiniband/hw/hfi1/affinity.c              |   2 +
 drivers/infiniband/hw/hfi1/driver.c                |   2 +-
 drivers/infiniband/hw/hfi1/firmware.c              |   6 +
 drivers/infiniband/hw/hfi1/mad.c                   |  22 +-
 drivers/infiniband/hw/hfi1/netdev_rx.c             |   2 +-
 drivers/infiniband/hw/hns/hns_roce_device.h        |   3 +
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c         | 217 +++++++--
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h         |  13 +-
 drivers/infiniband/hw/hns/hns_roce_main.c          |  18 +-
 drivers/infiniband/hw/hns/hns_roce_mr.c            |   4 +-
 drivers/infiniband/hw/hns/hns_roce_qp.c            | 107 ++++-
 drivers/infiniband/hw/irdma/uk.c                   | 170 ++++---
 drivers/infiniband/hw/irdma/user.h                 |  20 +-
 drivers/infiniband/hw/irdma/utils.c                |   2 +
 drivers/infiniband/hw/irdma/verbs.c                | 145 ++----
 drivers/infiniband/hw/irdma/verbs.h                |  53 +++
 drivers/infiniband/hw/mana/Kconfig                 |  10 +
 drivers/infiniband/hw/mana/Makefile                |   4 +
 drivers/infiniband/hw/mana/cq.c                    |  79 ++++
 drivers/infiniband/hw/mana/device.c                | 117 +++++
 drivers/infiniband/hw/mana/main.c                  | 521 +++++++++++++++++++++
 drivers/infiniband/hw/mana/mana_ib.h               | 162 +++++++
 drivers/infiniband/hw/mana/mr.c                    | 197 ++++++++
 drivers/infiniband/hw/mana/qp.c                    | 506 ++++++++++++++++++++
 drivers/infiniband/hw/mana/wq.c                    | 115 +++++
 drivers/infiniband/hw/mlx4/main.c                  |  12 +-
 drivers/infiniband/hw/mlx5/cq.c                    |  27 +-
 drivers/infiniband/hw/mlx5/fs.c                    |   1 -
 drivers/infiniband/hw/mlx5/mlx5_ib.h               |   4 +
 drivers/infiniband/hw/mlx5/mr.c                    |   6 +-
 drivers/infiniband/hw/qedr/main.c                  |   2 +-
 drivers/infiniband/hw/qib/qib_iba6120.c            |   7 +-
 drivers/infiniband/hw/qib/qib_tx.c                 |   5 +-
 drivers/infiniband/hw/qib/qib_user_sdma.c          |   2 +-
 drivers/infiniband/sw/rxe/rxe.c                    |   4 +-
 drivers/infiniband/sw/rxe/rxe.h                    |  19 +
 drivers/infiniband/sw/rxe/rxe_av.c                 |  43 +-
 drivers/infiniband/sw/rxe/rxe_comp.c               |  47 +-
 drivers/infiniband/sw/rxe/rxe_cq.c                 |   8 +-
 drivers/infiniband/sw/rxe/rxe_hdr.h                |  48 +-
 drivers/infiniband/sw/rxe/rxe_icrc.c               |   4 +-
 drivers/infiniband/sw/rxe/rxe_loc.h                |   9 +-
 drivers/infiniband/sw/rxe/rxe_mmap.c               |   6 +-
 drivers/infiniband/sw/rxe/rxe_mr.c                 | 122 +++--
 drivers/infiniband/sw/rxe/rxe_mw.c                 |  23 +-
 drivers/infiniband/sw/rxe/rxe_net.c                |  42 +-
 drivers/infiniband/sw/rxe/rxe_opcode.c             |  35 ++
 drivers/infiniband/sw/rxe/rxe_opcode.h             |  17 +-
 drivers/infiniband/sw/rxe/rxe_param.h              |   7 +
 drivers/infiniband/sw/rxe/rxe_qp.c                 |  98 ++--
 drivers/infiniband/sw/rxe/rxe_req.c                |  50 +-
 drivers/infiniband/sw/rxe/rxe_resp.c               | 329 +++++++++++--
 drivers/infiniband/sw/rxe/rxe_srq.c                |  20 +-
 drivers/infiniband/sw/rxe/rxe_task.c               |  52 +-
 drivers/infiniband/sw/rxe/rxe_task.h               |  19 +-
 drivers/infiniband/sw/rxe/rxe_verbs.c              | 106 ++---
 drivers/infiniband/sw/rxe/rxe_verbs.h              |   7 +-
 drivers/infiniband/sw/siw/siw_cq.c                 |  24 +-
 drivers/infiniband/sw/siw/siw_verbs.c              |  40 +-
 drivers/infiniband/ulp/ipoib/ipoib_netlink.c       |   7 +
 drivers/infiniband/ulp/iser/iser_verbs.c           |  67 ++-
 drivers/infiniband/ulp/isert/ib_isert.c            |   5 +-
 drivers/infiniband/ulp/rtrs/rtrs-clt.c             |   6 +-
 drivers/infiniband/ulp/rtrs/rtrs-pri.h             |   3 -
 drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c       |  13 +-
 drivers/infiniband/ulp/rtrs/rtrs-srv.c             |  72 ++-
 drivers/infiniband/ulp/rtrs/rtrs.c                 |  22 +-
 drivers/infiniband/ulp/srp/ib_srp.c                |  96 +++-
 drivers/net/ethernet/microsoft/Kconfig             |   1 +
 drivers/net/ethernet/microsoft/mana/gdma_main.c    |  39 +-
 drivers/net/ethernet/microsoft/mana/hw_channel.c   |   6 +-
 drivers/net/ethernet/microsoft/mana/mana_bpf.c     |   2 +-
 drivers/net/ethernet/microsoft/mana/mana_en.c      | 175 ++++++-
 drivers/net/ethernet/microsoft/mana/mana_ethtool.c |   2 +-
 drivers/net/ethernet/microsoft/mana/shm_channel.c  |   2 +-
 .../ethernet/microsoft => include/net}/mana/gdma.h | 153 +++++-
 .../microsoft => include/net}/mana/hw_channel.h    |   0
 .../ethernet/microsoft => include/net}/mana/mana.h |  23 +-
 include/net/mana/mana_auxiliary.h                  |  10 +
 .../microsoft => include/net}/mana/shm_channel.h   |   0
 include/rdma/ib_pack.h                             |   5 +
 include/rdma/ib_verbs.h                            |  24 +-
 include/rdma/opa_vnic.h                            |   2 +-
 include/trace/events/ib_mad.h                      |  13 +-
 include/uapi/rdma/hns-abi.h                        |  15 +
 include/uapi/rdma/ib_user_ioctl_verbs.h            |   3 +
 include/uapi/rdma/ib_user_verbs.h                  |  21 +
 include/uapi/rdma/mana-abi.h                       |  66 +++
 include/uapi/rdma/rdma_user_rxe.h                  |   8 +
 108 files changed, 3973 insertions(+), 922 deletions(-)
 create mode 100644 drivers/infiniband/hw/mana/Kconfig
 create mode 100644 drivers/infiniband/hw/mana/Makefile
 create mode 100644 drivers/infiniband/hw/mana/cq.c
 create mode 100644 drivers/infiniband/hw/mana/device.c
 create mode 100644 drivers/infiniband/hw/mana/main.c
 create mode 100644 drivers/infiniband/hw/mana/mana_ib.h
 create mode 100644 drivers/infiniband/hw/mana/mr.c
 create mode 100644 drivers/infiniband/hw/mana/qp.c
 create mode 100644 drivers/infiniband/hw/mana/wq.c
 rename {drivers/net/ethernet/microsoft => include/net}/mana/gdma.h (82%)
 rename {drivers/net/ethernet/microsoft => include/net}/mana/hw_channel.h (100%)
 rename {drivers/net/ethernet/microsoft => include/net}/mana/mana.h (95%)
 create mode 100644 include/net/mana/mana_auxiliary.h
 rename {drivers/net/ethernet/microsoft => include/net}/mana/shm_channel.h (100%)
 create mode 100644 include/uapi/rdma/mana-abi.h

--Aa7/F1QGVEnI16cV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRRRCHOFoQz/8F5bUaFwuHvBreFYQUCY5jpKQAKCRCFwuHvBreF
YV9UAQDiOH+tKKeAOEPCcakQhlo0qJdl25cb+ppBFUS11OLw7AD/QYSoRDCvgocn
eYCTbiDhraTynnvcex2uw5r5tSA9dQM=
=J8+L
-----END PGP SIGNATURE-----

--Aa7/F1QGVEnI16cV--
