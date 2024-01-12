Return-Path: <linux-rdma+bounces-608-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E03282B8F3
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Jan 2024 02:07:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 279341C2446F
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Jan 2024 01:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E2CEA51;
	Fri, 12 Jan 2024 01:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eIJ0xvTz"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2088.outbound.protection.outlook.com [40.107.243.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED8D4A21;
	Fri, 12 Jan 2024 01:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RS7eLg1D4KA3Vy34MPsFCxz+R3dxgahAYh9/AmABPBEJcBBn4jhi3YG3k5P2/b3bcAFn/OeLjrbB4JNDFWp5LB/qUQo3Z79n+XZG4ENLQsIwthzXeVDftVnQamurbwoO96saixTNWbGxMclS/VOUHZ9yXD8qCMzGHGAooxU0hv7mDsQa3LRExM3deIgomkH9G7WbfSkdObndsuGAtacImyWbRy1vx6wiiDyCtcRZIyiFJxxmlZzYlDhT+6UNi1yIPX0zzk9+/G4uD7/gfjaNv/DSj0GpX2b6JZEPxqsRA2OLLz6zvbr9zvpbH2XeN0TjoUANG2FyX6ltlOzHKqfDZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L9V+dxlUElpsNi6LW4ObAx2Vjop21wI8dca5klDbHCQ=;
 b=XZYv+pfnQMJM8+VUsx/pLCMFFOLmdkGOfXHhr8qODiVdBdK+9yOGdmgTqPeSZJt90CmO27NnXU7+36v0zMeXzsWgQ2eXr5j/yQ6zJOxrpWiBZ0h3w1bG4iYlBFRTus/yy8AKVxqrL9qmxUMc1JalfzXHZ9pQwPQphKrgnTW4SdchmokqgaQwYqifX3D6jS8y4m+l7QF8X/ccETWM1ryDyH2x6dN0lk+z3dVQGXlBosYSzd3ysK0BZegP6CL+vODG8WWEosqf4/aRc+eklYG9+zcqoiYweH7uzNL9dpjsdhdKe9FaVa5IUEdjEZws8K6xLsFgVKclIHOgJB2FNLuudg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L9V+dxlUElpsNi6LW4ObAx2Vjop21wI8dca5klDbHCQ=;
 b=eIJ0xvTzd639lAAHeD67cEnSVtXBxhOaZmEbKn5wSp9hqJUZMdS3IeVfI681gSbC94o24p2uCEOWN0NYbLIVhyOFcwKPQCiua8nTuCxPCaLIad+XtHI+awzqHTXNJvUqvnVV9UQJ/6g7R0PhccoQSBqE0MZH0QwPoh/SqKV2pjlo5R5PRtF1fFt6vFt5lXcikbXZ9yAkpewdw9fszav/0hFjInv6kF5De+nIqxhZXu8Ev/xEeqzQUNnkuevowSUEgIPyljSspn3Aiv6wAIKHRSt/tfo1i24139LCRL3g/Tgde5L3DF1UIFgS3usYN0ouWH9w14vrs6wohXosQlXtmg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DS7PR12MB5911.namprd12.prod.outlook.com (2603:10b6:8:7c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.19; Fri, 12 Jan
 2024 01:06:52 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.7159.020; Fri, 12 Jan 2024
 01:06:51 +0000
Date: Thu, 11 Jan 2024 21:06:50 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	Leon Romanovsky <leonro@nvidia.com>
Subject: [GIT PULL] Please pull RDMA subsystem changes
Message-ID: <20240112010650.GA782780@nvidia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="zEE7RN6zSlE6Vgzh"
Content-Disposition: inline
X-ClientProxiedBy: SN1PR12CA0067.namprd12.prod.outlook.com
 (2603:10b6:802:20::38) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DS7PR12MB5911:EE_
X-MS-Office365-Filtering-Correlation-Id: 03766802-3228-40a6-6e6f-08dc130ac2b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	gQnWFcbj88wyuS9COo5nC93kzpVLgiEBAGhTSr10S3uQ3UnUTpPwOm4lK7EJImaSHTvpeO9Ov+7PudzzaZOxTOZB/KQvm9jKf0YDrWLHJ24kMOpSsEyuc9smIPaKh5FJc/cMZngNC6mNiB/2L/Dk+NhoMedlFlqSYA20OHXRR/RzG9tBIW0Zrs7x6A+iuWoote1whoWr40mGUukLKiEuPFWljftaJalS6ire+Am228RrTN3eOFXAnfAlB2od8WsR2kaUiVLmv9uh6A468fYvTSSoV1J9Pq2cbROKgwqG9G9huHPpUXaLx9oYrKfl9jcfQEYV4sJq5TAWW+87gGEtNKe9kiDzIUwhZwl7o56YsRvNSYBCb8yBprjgDU2/GOb3vluxE8UDXBoyVB4fyO+HX5EBFlIeDqbNsmfDLSLBiEDCd/fFevWkWITA4sxPEP7O/jg3s8LOBvuneO/OB8pysKbF+0j/9bN2nPc/9krGF5Ns9o+vw8BYcCEXfczzjVz5HG192ygTpMX/lPQm8OLKJuoK1ncKSt0bjQ9Y3dUHs6MCVsGqBvffiLImfLU8tws7hmqyhYm25O1n1IKa/4kdLDhhY8rjLHl3c4/lCzzzIQXNsHsbo60jlr/xEsiJKowemFMTnAwDkZbJfIZFJtFY7P8LjXqMTYWzVZeSllKQ3hdCeaKJT4wZwzwaDx7TDMIk
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(39860400002)(366004)(376002)(346002)(230922051799003)(230273577357003)(230173577357003)(186009)(64100799003)(451199024)(1800799012)(83380400001)(316002)(41300700001)(36756003)(33656002)(86362001)(66946007)(38100700002)(6506007)(107886003)(21480400003)(1076003)(26005)(2616005)(6512007)(6486002)(478600001)(4001150100001)(2906002)(66556008)(66476007)(6916009)(44144004)(5660300002)(4326008)(45080400002)(8936002)(8676002)(27376004)(2700100001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+lD1r3b/xqUgOd/gr/JyRwgA3g1l2v7k4YgArKcRx5WXy544nL1DlU0Oh1UP?=
 =?us-ascii?Q?yEFRZkkHRP7SyTLVCAMAEZMY8lSODZbCec6fnIeRXlKl1//4wIn5oIKKfrTW?=
 =?us-ascii?Q?dPRaY/3BW78OSpmn9f1b7C7uNNVl5Lbvd9gNwPPwKrjCZmJd92/jEIwENFPV?=
 =?us-ascii?Q?4qy+EWwXE0neAgt98udUqo5GSAjsatlfLQ5uDds6jSF0rbtijMPHylLOwdQp?=
 =?us-ascii?Q?lzTw3E/qaWoRSh5sN2Jj6pxVo+Gxz9n0JS3Q32vG//DzArLrHp0ngHcs0zfc?=
 =?us-ascii?Q?X5kXn3BBau7wEyN//PiJ1yPhR5wfqgCsu3TQsDQlFMaSqGrRyFrUldeINy7j?=
 =?us-ascii?Q?s3PKSQlQWqdF/9mqzvGAfiLslS8Kfn0P2iJFKjdKO7k7J3L1+vMgn9Q5H5vd?=
 =?us-ascii?Q?67FHtnt9aE1FLPxvRMgDc1sLgMlwLOC6r+Bo3awv/yV/uFon8hNqkLjSXkfA?=
 =?us-ascii?Q?Z4Wbl/dwcD74YX/ngp69+lYgNiBQl5jFVU1MYRk+MPScVEUXiyZEL1yikqp/?=
 =?us-ascii?Q?1o2jvEC6n9o943GbFiWy1gQqKI1H/9mxZ8hXYuVsSPgfxA/94m4UnUVY4JQ/?=
 =?us-ascii?Q?rrB21XU74zveLxNs+KQORHNSpGEhDiZE3I02EfvzYLYt26Xe/FsN0MCyeurX?=
 =?us-ascii?Q?RYZhisEQhKDyh+8Kwfyl+MkhxYNXryBe4Cbyisy1mHQFaZlFnBJBZjk68j3d?=
 =?us-ascii?Q?gaOiC/Deg4Ah6QUehjBI7YgG74G6NrHKGaF2T36uafJOUeB5V9+YnPjT4aMk?=
 =?us-ascii?Q?8BhZwgsh1sVXo5YMWs+q+pWbRv3EUc8nLgXlQ2YT8LKLo3SpNfV+Yr6Bfmy3?=
 =?us-ascii?Q?fFHoxAfUbn1mNjLJEszmgyZ7TAkEjXq/csSEu+K6CffmLSDOHNni4C5FOMnt?=
 =?us-ascii?Q?SyQoNMThXExPhJnHx4YTdE04gyK5gl4Uy8w8nxmyhGJvoFjfUpCqAAokSXY+?=
 =?us-ascii?Q?TRHcPQ5k+MqAe8kHQY0ne31f8eHqUD2/T4ni9fSESMlwHsCpvonS4Afb3kX0?=
 =?us-ascii?Q?mdazVnxi9rZ7sxionYz/YeXoAfpmPLmE2TSLSsmumidvYkiNMnGnbJk6vicg?=
 =?us-ascii?Q?J+y4Pbyh6c05wNSEb+OBaD7a89H722tn2P4rPc4/kL63SqEokgJJORw+Gpi+?=
 =?us-ascii?Q?Yvjgvci9suiuDB5/LiGXo0vaaG+OBO3XMxa1+IFkYfKNTlgfr3hTBcxsmgM6?=
 =?us-ascii?Q?TV/Ws9aqUC7OWy09Q226+HnWtyyk/3dRJEZe00JGQEANuO6yuLVcGF7qlL3M?=
 =?us-ascii?Q?d6MEm54Fdsos8bshIX9RREi3mix40HSyz037Al9xS840ux7kqfgcF7wHVJyC?=
 =?us-ascii?Q?sI20urwcGP9rmYPC+4qZPLpcY6Y+9U+jQRLf5SY2fMUvrMU3CX+EU/kjzbrb?=
 =?us-ascii?Q?Z8i279CIL+6O0GosP7ttlhYg9p5vsbfd9/qc/zp/Ueq+yVV0yTHC7nKrsmck?=
 =?us-ascii?Q?n2by7Y08nOQbLME7AXAi5r2O4GnxSZHeGqJkQT/uGoEyJiYKMfphdMiTT77J?=
 =?us-ascii?Q?kNpa4lOL9pwTiNZOS26KMzBskbcYGlTaL5JGAdi2jqhSQuTTd4+/7yIorCCF?=
 =?us-ascii?Q?rgUZ8e5xD8Sjel3xWr0=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03766802-3228-40a6-6e6f-08dc130ac2b4
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2024 01:06:51.9329
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yjd0XUiIwRUhdFh6D1qYgpAz9xWkPmb+qx7nUlQ/eElLX8T/GQRCg/jdKB6hupTN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5911

--zEE7RN6zSlE6Vgzh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

A ordinary pull request for the new year. I think many were off over
December.

Thanks,
Jason

The following changes since commit a39b6ac3781d46ba18193c9dbb2110f31e9bffe9:

  Linux 6.7-rc5 (2023-12-10 14:33:40 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

for you to fetch changes up to d24b923f1d696ddacb09f0f2d1b1f4f045cfe65e:

  RDMA/bnxt_re: Fix error code in bnxt_re_create_cq() (2024-01-08 11:41:49 +0200)

----------------------------------------------------------------
RDMA v6.8 merge window

Small cycle, with some typical driver updates

 - General code tidying in siw, hfi1, idrdma, usnic, hns rtrs and bnxt_re

 - Many small siw cleanups without an overeaching theme

 - Debugfs stats for hns

 - Fix a TX queue timeout in IPoIB and missed locking of the mcast list

 - Support more features of P7 devices in bnxt_re including a new work
   submission protocol

 - CQ interrupts for MANA

 - netlink stats for erdma

 - EFA multipath PCI support

 - Fix Incorrect MR invalidation in iser

----------------------------------------------------------------
Bernard Metzler (1):
      RDMA/siw: Use ib_umem_get() to pin user pages

Chandramohan Akula (2):
      RDMA/bnxt_re: Refactor the queue index update
      RDMA/bnxt_re: Remove roundup_pow_of_two depth for all hardware queue resources

Cheng Xu (2):
      RDMA/erdma: Introduce dma pool for hardware responses of CMDQ requests
      RDMA/erdma: Add hardware statistics support

Chengchang Tang (3):
      RDMA/hns: Rename the interrupts
      RDMA/hns: Remove unnecessary checks for NULL in mtr_alloc_bufs()
      RDMA/hns: Fix memory leak in free_mr_init()

Dan Carpenter (1):
      RDMA/bnxt_re: Fix error code in bnxt_re_create_cq()

Daniel Vacek (1):
      IB/ipoib: Fix mcast list locking

Eric Biggers (2):
      RDMA/siw: Use crypto_shash_digest() in siw_qp_prepare_tx()
      RDMA/irdma: Use crypto_shash_digest() in irdma_ieq_check_mpacrc()

Guoqing Jiang (21):
      RDMA/siw: Introduce siw_get_page
      RDMA/siw: Introduce siw_update_skb_rcvd
      RDMA/siw: Use iov.iov_len in kernel_sendmsg
      RDMA/siw: Remove goto lable in siw_mmap
      RDMA/siw: Remove rcu from siw_qp
      RDMA/siw: No need to check term_info.valid before call siw_send_terminate
      RDMA/siw: Factor out siw_rx_data helper
      RDMA/siw: Introduce SIW_STAG_MAX_INDEX
      RDMA/siw: Add one parameter to siw_destroy_cpulist
      RDMA/siw: Introduce siw_cep_set_free_and_put
      RDMA/siw: Introduce siw_free_cm_id
      RDMA/siw: Cleanup siw_accept
      RDMA/siw: Remove siw_sk_save_upcalls
      RDMA/siw: Fix typo
      RDMA/siw: Only check attrs->cap.max_send_wr in siw_create_qp
      RDMA/siw: Introduce siw_destroy_cep_sock
      RDMA/siw: Update comments for siw_qp_sq_process
      RDMA/siw: Move tx_cpu ahead
      RDMA/siw: Reduce memory usage of struct siw_rx_stream
      RDMA/siw: Set qp_state in siw_query_qp
      RDMA/siw: Call orq_get_current if possible

Jack Wang (2):
      RDMA/IPoIB: Fix error code return in ipoib_mcast_join
      RDMA/IPoIB: Add tx timeout work to recover queue stop situation

Junxian Huang (5):
      RDMA/hns: Fix inappropriate err code for unsupported operations
      RDMA/hns: Add debugfs to hns RoCE
      RDMA/hns: Support SW stats with debugfs
      RDMA/hns: Response dmac to userspace
      RDMA/hns: Add a max length of gid table

Leon Romanovsky (2):
      RDMA/usnic: Silence uninitialized symbol smatch warnings
      Expose c0 and SW encap ICM for RDMA

Long Li (3):
      RDMA/mana_ib: register RDMA device with GDMA
      RDMA/mana_ib: query device capabilities
      RDMA/mana_ib: Add CQ interrupt support for RAW QP

Mark Bloch (2):
      net/mlx5: E-Switch, expose eswitch manager vport
      RDMA/mlx5: Expose register c0 for RDMA device

Md Haris Iqbal (1):
      RDMA/rtrs-clt: Add warning logs for RDMA events

Michael Margolin (1):
      RDMA/efa: Add EFA query MR support

Philipp Stanner (1):
      RDMA/hfi1: Copy userspace arrays safely

Randy Dunlap (1):
      IB/iser: iscsi_iser.h: fix kernel-doc warning and spellos

Selvin Xavier (10):
      RDMA/bnxt_re: Support new 5760X P7 devices
      RDMA/bnxt_re: Update the BAR offsets
      RDMA/bnxt_re: Update the HW interface definitions
      RDMA/bnxt_re: Get the toggle bits from CQ completions
      RDMA/bnxt_re: Doorbell changes
      RDMA/bnxt_re: Adds MSN table capability for Gen P7 adapters
      RDMA/bnxt_re: Add UAPI to share a page with user space
      RDMA/bnxt_re: Share a page to expose per CQ info with userspace
      RDMA/bnxt_re: Fix the offset for GenP7 adapters for user applications
      RDMA/bnxt_re: Fix the sparse warnings

Sergey Gorenko (1):
      IB/iser: Prevent invalidating wrong MR

Shun Hao (3):
      net/mlx5: Introduce indirect-sw-encap ICM properties
      RDMA/mlx5: Support handling of SW encap ICM area
      net/mlx5: Manage ICM type of SW encap

Supriti Singh (2):
      RDMA/rtrs-clt: Use %pe to print errors
      RDMA/rtrs: Use %pe to print errors

 drivers/infiniband/hw/bnxt_re/bnxt_re.h           |   3 +
 drivers/infiniband/hw/bnxt_re/hw_counters.c       |   4 +-
 drivers/infiniband/hw/bnxt_re/ib_verbs.c          | 233 +++++++++++++++++++---
 drivers/infiniband/hw/bnxt_re/ib_verbs.h          |  10 +
 drivers/infiniband/hw/bnxt_re/main.c              |  47 +++--
 drivers/infiniband/hw/bnxt_re/qplib_fp.c          | 215 +++++++++++++-------
 drivers/infiniband/hw/bnxt_re/qplib_fp.h          |  35 +++-
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.c        |  21 +-
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.h        |   4 +-
 drivers/infiniband/hw/bnxt_re/qplib_res.c         |   4 +-
 drivers/infiniband/hw/bnxt_re/qplib_res.h         | 117 ++++++++---
 drivers/infiniband/hw/bnxt_re/qplib_sp.c          |  11 +-
 drivers/infiniband/hw/bnxt_re/roce_hsi.h          |  67 ++++++-
 drivers/infiniband/hw/efa/efa.h                   |  12 +-
 drivers/infiniband/hw/efa/efa_admin_cmds_defs.h   |  33 ++-
 drivers/infiniband/hw/efa/efa_com_cmd.c           |  11 +-
 drivers/infiniband/hw/efa/efa_com_cmd.h           |  12 +-
 drivers/infiniband/hw/efa/efa_main.c              |   7 +-
 drivers/infiniband/hw/efa/efa_verbs.c             |  71 ++++++-
 drivers/infiniband/hw/erdma/erdma.h               |   2 +
 drivers/infiniband/hw/erdma/erdma_hw.h            |  39 ++++
 drivers/infiniband/hw/erdma/erdma_main.c          |  26 ++-
 drivers/infiniband/hw/erdma/erdma_verbs.c         |  90 +++++++++
 drivers/infiniband/hw/erdma/erdma_verbs.h         |   4 +
 drivers/infiniband/hw/hfi1/user_exp_rcv.c         |   4 +-
 drivers/infiniband/hw/hfi1/user_sdma.c            |   4 +-
 drivers/infiniband/hw/hns/Makefile                |   3 +-
 drivers/infiniband/hw/hns/hns_roce_ah.c           |  13 +-
 drivers/infiniband/hw/hns/hns_roce_cmd.c          |  19 +-
 drivers/infiniband/hw/hns/hns_roce_cq.c           |  17 +-
 drivers/infiniband/hw/hns/hns_roce_debugfs.c      | 110 ++++++++++
 drivers/infiniband/hw/hns/hns_roce_debugfs.h      |  33 +++
 drivers/infiniband/hw/hns/hns_roce_device.h       |  26 +++
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c        |  71 +++++--
 drivers/infiniband/hw/hns/hns_roce_main.c         |  48 ++++-
 drivers/infiniband/hw/hns/hns_roce_mr.c           |  28 ++-
 drivers/infiniband/hw/hns/hns_roce_pd.c           |  12 +-
 drivers/infiniband/hw/hns/hns_roce_qp.c           |   8 +-
 drivers/infiniband/hw/hns/hns_roce_srq.c          |   6 +-
 drivers/infiniband/hw/irdma/utils.c               |  11 +-
 drivers/infiniband/hw/mana/cq.c                   |  34 +++-
 drivers/infiniband/hw/mana/device.c               |  31 ++-
 drivers/infiniband/hw/mana/main.c                 |  69 +++++--
 drivers/infiniband/hw/mana/mana_ib.h              |  53 +++++
 drivers/infiniband/hw/mana/qp.c                   |  91 +++++++--
 drivers/infiniband/hw/mlx5/dm.c                   |   5 +
 drivers/infiniband/hw/mlx5/main.c                 |  24 +++
 drivers/infiniband/hw/mlx5/mr.c                   |   1 +
 drivers/infiniband/hw/mthca/mthca_cmd.c           |   4 +-
 drivers/infiniband/hw/mthca/mthca_main.c          |   2 +-
 drivers/infiniband/sw/siw/siw.h                   |  14 +-
 drivers/infiniband/sw/siw/siw_cm.c                | 145 ++++++--------
 drivers/infiniband/sw/siw/siw_main.c              |  30 ++-
 drivers/infiniband/sw/siw/siw_mem.c               | 121 +++++------
 drivers/infiniband/sw/siw/siw_mem.h               |   5 +-
 drivers/infiniband/sw/siw/siw_qp.c                |   2 +-
 drivers/infiniband/sw/siw/siw_qp_rx.c             |  84 +++-----
 drivers/infiniband/sw/siw/siw_qp_tx.c             |  51 ++---
 drivers/infiniband/sw/siw/siw_verbs.c             |  52 ++---
 drivers/infiniband/ulp/ipoib/ipoib.h              |   4 +
 drivers/infiniband/ulp/ipoib/ipoib_ib.c           |  26 ++-
 drivers/infiniband/ulp/ipoib/ipoib_main.c         |  33 ++-
 drivers/infiniband/ulp/ipoib/ipoib_multicast.c    |   7 +-
 drivers/infiniband/ulp/iser/iscsi_iser.h          |   7 +-
 drivers/infiniband/ulp/iser/iser_initiator.c      |   5 +-
 drivers/infiniband/ulp/iser/iser_memory.c         |   8 +-
 drivers/infiniband/ulp/iser/iser_verbs.c          |   1 -
 drivers/infiniband/ulp/rtrs/rtrs-clt.c            |  12 +-
 drivers/infiniband/ulp/rtrs/rtrs.c                |   4 +-
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.h |   7 -
 drivers/net/ethernet/mellanox/mlx5/core/lib/dm.c  |  38 +++-
 drivers/net/ethernet/microsoft/mana/gdma_main.c   |   5 +
 include/linux/mlx5/driver.h                       |   1 +
 include/linux/mlx5/eswitch.h                      |   8 +
 include/linux/mlx5/mlx5_ifc.h                     |   9 +-
 include/net/mana/gdma.h                           |   5 +
 include/uapi/rdma/bnxt_re-abi.h                   |  41 ++++
 include/uapi/rdma/efa-abi.h                       |  21 +-
 include/uapi/rdma/hns-abi.h                       |   5 +
 include/uapi/rdma/mlx5-abi.h                      |   2 +
 include/uapi/rdma/mlx5_user_ioctl_verbs.h         |   1 +
 81 files changed, 1921 insertions(+), 638 deletions(-)
 create mode 100644 drivers/infiniband/hw/hns/hns_roce_debugfs.c
 create mode 100644 drivers/infiniband/hw/hns/hns_roce_debugfs.h

--zEE7RN6zSlE6Vgzh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRRRCHOFoQz/8F5bUaFwuHvBreFYQUCZaCQpwAKCRCFwuHvBreF
YZxhAQCIXQPVte80YlVRHf0gFcTtb5eCa05CW+Ep7QAC04rZVQD+M1wFFhZt7hOY
qWxR/4XyhIEjdEFEPaGprdLRRSD0Qgk=
=Dsvp
-----END PGP SIGNATURE-----

--zEE7RN6zSlE6Vgzh--

