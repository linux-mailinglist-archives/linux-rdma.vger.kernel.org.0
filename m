Return-Path: <linux-rdma+bounces-12210-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79988B06E69
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Jul 2025 09:02:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6356D3AA38F
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Jul 2025 07:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEA4928A713;
	Wed, 16 Jul 2025 07:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LwWbsqX2"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2050.outbound.protection.outlook.com [40.107.96.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84CF288C25;
	Wed, 16 Jul 2025 07:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752649285; cv=fail; b=Fmw9zAfWpnBbelD8ghvcCOYuY4Ggd9+mdq6Kadl/L5HKnxShjbRMgAdP4mzLOABo3RcllNdNeAX71xNxePmdck1PEoGhlPk5RelUSjObQJQ+UkN4uZfWZ9GzwUryyJuIrtTcNJUuZ8QZB7DSy3yIqFh/SaaVLQ5htkiS08nQdrs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752649285; c=relaxed/simple;
	bh=+TdH+atfzRZokrCFeBjN8zDkALvPHDLqU26j4TES1Fc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Z0qeEv6r0+Z9SvGsMjjTA7OqWIGhUUcS3D1kvB3VLISJ/1lzou9kiyY3dzUhLWxAtJ8iBKEWHNerzgr64Zljh8VppVVCEwXe7WpJz4Ey4VSPCWdo08QUseppS0Lv3DTMj6f5Lz8O/EHPbAc65goZOcebx1Kjr6VVUlgYU426Jf0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LwWbsqX2; arc=fail smtp.client-ip=40.107.96.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GVyeLPZXwMkFCM3DC3E5WjCeC6Xix8Z8GgCWcnCo/43g3kFtWVBLsNk91khzEXBZVf3DU+7+8Ora2+HCKsLpT9PFi1+MBGiphnUmUbzoNODIXqsY70lWKJ4ki9ATOc5SzS8BwBMjwZV6aLOou3MnwDze9eHP/kE8C4He38ul/mJUxNsuDQFQAdzoqGE9BcrGb8zZif19up/ZSAiuQuuLruWtP1M2L+XkgBhaP4pUySZKmuC37llLIehp3OIyWfXO4XfGE0ZqXEs1022V7VQocmyqwPT2FMDUCVIVmIGGfD+RPgflt0OoCqlOJpL4VSIStpBETe+Zo6Yp8QRbrGL0hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tW+qyEUccbzWwuEo0OyaRggn5cAixNth7oUOGYi1NBg=;
 b=cvxvgUMWfvfDE9yqfkDHo6eOEvVclYt5qcFv1EUDPTPm7APFlPjNyyv4+Dm5VAPqDmFuOMH92ZORpRt1wKmlq7RpFz4EJokIIKZjG6PDOf7en7JTfeYgau9QZy9RZGMChX8Q4SHG+mlQDriC/1hkKWDSxNgYUjfyHDGzJaMdb2PVtnpUE6bE24h/Nsz+Ztqmk6H9kuuN76QwyPkGowL7+Ea8c4M4CoIqyHWHzFpvrecs+DtcjrGctKa2fTzHBAG4KNdYeWFX9QC3KmEv7Wn09TXlhrV8GRx7zHnRbqici6I7oVVMD88FSXiEFHnCAqEw2gRbWBrAkPvQBp6a7D+GFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tW+qyEUccbzWwuEo0OyaRggn5cAixNth7oUOGYi1NBg=;
 b=LwWbsqX2nfX31FVbRi/pbW1Ih3TQL4kA4VaN4Jkl2MvX0w4Zv223XGhY3t5ZvR4mmKo8vRKQdrC9wmlTgVaiK5uXa8dsh2Q86U2JsUN96MTaxl7rUwE+gudwnL7SuOZNaoXcHe9I/bD+QVT2ukSyhj8UEhrytU3XFqVtn8fAZg9DOp9ymBuJ08jugCavwbqd50Dw5BVaKFXLMJRQbKimkhmOMGRABj44H0j1Wg98lw1SbpAhK5iLHvB2f5DzGw0L9KlBuE8/666toKd1IoMsGF+Hl+Fs2U/N3/PiacaKhBk9TnIYDA7oQ5eUjXBZ/YQ6pRkH+TuTBMQiZJ6p7G+LDA==
Received: from SA9PR13CA0038.namprd13.prod.outlook.com (2603:10b6:806:22::13)
 by MN0PR12MB5906.namprd12.prod.outlook.com (2603:10b6:208:37a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Wed, 16 Jul
 2025 07:01:18 +0000
Received: from SA2PEPF00001506.namprd04.prod.outlook.com
 (2603:10b6:806:22:cafe::be) by SA9PR13CA0038.outlook.office365.com
 (2603:10b6:806:22::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.17 via Frontend Transport; Wed,
 16 Jul 2025 07:01:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SA2PEPF00001506.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.22 via Frontend Transport; Wed, 16 Jul 2025 07:01:17 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 16 Jul
 2025 00:01:05 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 16 Jul 2025 00:01:04 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Wed, 16 Jul 2025 00:01:01 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Dragos Tatulea <dtatulea@nvidia.com>, "Mina
 Almasry" <almasrymina@google.com>
Subject: [PATCH net-next] net/mlx5e: TX, Fix dma unmapping for devmem tx
Date: Wed, 16 Jul 2025 10:00:42 +0300
Message-ID: <1752649242-147678-1-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001506:EE_|MN0PR12MB5906:EE_
X-MS-Office365-Filtering-Correlation-Id: 42bed958-00a1-411b-a9b3-08ddc4368fe5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013|7416014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?x49Gl1r2owF2OsMeWI+PhmU+4JLn1qQwU6WGYEl0b0zO8Kf4CRXZs753a7wD?=
 =?us-ascii?Q?o7SxorZurP+vmXpqpSdMaeYw9tt0Tp3R/Nnjgt9G5QXvH07CD2vTm6kePPPl?=
 =?us-ascii?Q?ykEgoASINOlkhWRMyvU0XASr9waqOeodS2ndacuOTlAEvWOXqtlOcibwwxJl?=
 =?us-ascii?Q?SzYl7r45wljT3WR4Fn4cjBCFm62j3Fw54EtwtRe21GE1BzwHnD4xbGYDdaxx?=
 =?us-ascii?Q?hnc2EqSBE5gP9vl/f7TLEu3y4baCraMYrnlloLxyNhDQLfNklGBzQJ0eA2Bn?=
 =?us-ascii?Q?DRzC7iqL15kYQXyI4U/zYps0mtVdQkuxDtpvPxYgo6ywulsqB4KQqywsVZ4P?=
 =?us-ascii?Q?wG+ESDiBch7vNhNLd38CLeruYi3jRND24RdYFUY76TX54aupByQysFFCkMZ2?=
 =?us-ascii?Q?5/QCdmCQFAUpXB5SUvpsysDPCBPz9SbqpJhVkmNL9sJnuzjpbP0e59zuXvBp?=
 =?us-ascii?Q?FDEqdoat7lOvt07mioDc0+pNpupmHlJDQCJ6mGDj/m1CSRp+4kvJPTYXVfo1?=
 =?us-ascii?Q?+KQayhUEisrMtwBGByPxnMZtDcTW5RkD/OQtY+W8jSkzwiBc6Je9y7RiDHqp?=
 =?us-ascii?Q?peUrg9QVpqP2v4Wb3OflW0Z8TrIMu5iqp8mUTLA/qh6gTFwYixMhFbmy558a?=
 =?us-ascii?Q?HvQjlVn+SfG9ruHp1LOGKDyYL/wR6L80xPuUsgwvrwNaVrjLZrXsWQUzMAVb?=
 =?us-ascii?Q?VbQwTyZ1RMMuJrGyGJ0HPyeqfL0kx7ys6iJuWC6v96fXcPyL3pdBL3OA9Hbp?=
 =?us-ascii?Q?aeLr/gYw5uvx9fbDFcE+nTobfGNySzNpJMX5wG1Yao0saR9navhxTEFLnEgW?=
 =?us-ascii?Q?MaMeQ6b/v33wZUnbsf110+nJx/5wIsboLN39iLA0NnWDGlav/qw1KA8OGQDi?=
 =?us-ascii?Q?sx38JikTEul7FhJfqM1pUFHVZNu/LnAjpcJ4+Em1B/4QtKkdskxIYITI43M8?=
 =?us-ascii?Q?TeiOITdXoE70r7LBsDFrg6ILq3aZxYPNpfPv5rgLQLHEF9bjP331PuDWmZYd?=
 =?us-ascii?Q?j8f9WFxx42j21X9IMf1BZUosJJHm46c9wOvqex6FOUe22wB6jeaf9yz3Q575?=
 =?us-ascii?Q?dxVjHUoi4n2mKXXh6ZbWhl9uczJkJZHVj2qtXIrjuYQFDtE2kVYKYkpqYgTJ?=
 =?us-ascii?Q?X68FGm+saXG2/8DoUQWfbBNAg1Ko8TFvZFHzg0IzdZPbjqVHB6vNrXR01M/5?=
 =?us-ascii?Q?fqFeXglcnoO/mvl6gECIZqtk22lzBWd1ZaXyjdq7ZE8nf18xtWUQTav1Rnvd?=
 =?us-ascii?Q?NUlM20WyWEIZ0Ucfv0nXkmQmc3KkBjWUwbEIJcg3Eql6Ett65DvzN9ZB+ZIR?=
 =?us-ascii?Q?Wq430GN7uyNmH24raNg+vJgO613oJFJNqjzVvtkYLMzw0MrTbNYUPlWtTBmW?=
 =?us-ascii?Q?8v4GIsbD+imlNvDqlIJ65X6tS1naZPUr4OF/qrf9gjlNm4HiJsBPNJZtjtSx?=
 =?us-ascii?Q?Aqu7lVDkOjOUwvd91XXME30ktCylNjCql6Hb75xLU112HczPfPUhq2cjMOBm?=
 =?us-ascii?Q?cBGNHnRBOxdHdn6Y12zfVJ8370LldGMr3ACdONstyPafK6v1YX4duT93TA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013)(7416014)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 07:01:17.6555
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 42bed958-00a1-411b-a9b3-08ddc4368fe5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001506.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5906

From: Dragos Tatulea <dtatulea@nvidia.com>

net_iovs should have the dma address set to 0 so that
netmem_dma_unmap_page_attrs() correctly skips the unmap. This was
not done in mlx5 when support for devmem tx was added and resulted
in the splat below when the platform iommu was enabled.

This patch addresses the issue by using netmem_dma_unmap_addr_set()
which handles the net_iov case when setting the dma address. A small
refactoring of mlx5e_dma_push() was required to be able to use this API.
The function was split in two versions and each version called
accordingly. Note that netmem_dma_unmap_addr_set() introduces an
additional if case.

Splat:
  WARNING: CPU: 14 PID: 2587 at drivers/iommu/dma-iommu.c:1228 iommu_dma_unmap_page+0x7d/0x90
  Modules linked in: [...]
  Unloaded tainted modules: i10nm_edac(E):1 fjes(E):1
  CPU: 14 UID: 0 PID: 2587 Comm: ncdevmem Tainted: G S          E       6.15.0+ #3 PREEMPT(voluntary)
  Tainted: [S]=CPU_OUT_OF_SPEC, [E]=UNSIGNED_MODULE
  Hardware name: HPE ProLiant DL380 Gen10 Plus/ProLiant DL380 Gen10 Plus, BIOS U46 06/01/2022
  RIP: 0010:iommu_dma_unmap_page+0x7d/0x90
  Code: [...]
  RSP: 0000:ff6b1e3ea0b2fc58 EFLAGS: 00010246
  RAX: 0000000000000000 RBX: ff46ef2d0a2340c8 RCX: 0000000000000000
  RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000001
  RBP: 0000000000000001 R08: 0000000000000000 R09: ffffffff8827a120
  R10: 0000000000000000 R11: 0000000000000000 R12: 00000000d8000000
  R13: 0000000000000008 R14: 0000000000000001 R15: 0000000000000000
  FS:  00007feb69adf740(0000) GS:ff46ef2c779f1000(0000) knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: 00007feb69cca000 CR3: 0000000154b97006 CR4: 0000000000773ef0
  DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
  DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
  PKRU: 55555554
  Call Trace:
   <TASK>
   dma_unmap_page_attrs+0x227/0x250
   mlx5e_poll_tx_cq+0x163/0x510 [mlx5_core]
   mlx5e_napi_poll+0x94/0x720 [mlx5_core]
   __napi_poll+0x28/0x1f0
   net_rx_action+0x33a/0x420
   ? mlx5e_completion_event+0x3d/0x40 [mlx5_core]
   handle_softirqs+0xe8/0x2f0
   __irq_exit_rcu+0xcd/0xf0
   common_interrupt+0x47/0xa0
   asm_common_interrupt+0x26/0x40
  RIP: 0033:0x7feb69cd08ec
  Code: [...]
  RSP: 002b:00007ffc01b8c880 EFLAGS: 00000246
  RAX: 00000000c3a60cf7 RBX: 0000000000045e12 RCX: 000000000000000e
  RDX: 00000000000035b4 RSI: 0000000000000000 RDI: 00007ffc01b8c8c0
  RBP: 00007ffc01b8c8b0 R08: 0000000000000000 R09: 0000000000000064
  R10: 00007ffc01b8c8c0 R11: 0000000000000000 R12: 00007feb69cca000
  R13: 00007ffc01b90e48 R14: 0000000000427e18 R15: 00007feb69d07000
   </TASK>

Cc: Mina Almasry <almasrymina@google.com>
Reported-by: Stanislav Fomichev <stfomichev@gmail.com>
Closes: https://lore.kernel.org/all/aFM6r9kFHeTdj-25@mini-arch/
Fixes: 5a842c288cfa ("net/mlx5e: Add TX support for netmems")
Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/en/txrx.h    | 16 +++++++++++++---
 .../mellanox/mlx5/core/en_accel/ktls_tx.c        |  2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_tx.c  |  6 +++---
 3 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h b/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
index 6501252359b0..5dc04bbfc71b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
@@ -322,14 +322,24 @@ mlx5e_dma_get(struct mlx5e_txqsq *sq, u32 i)
 }
 
 static inline void
-mlx5e_dma_push(struct mlx5e_txqsq *sq, dma_addr_t addr, u32 size,
-	       enum mlx5e_dma_map_type map_type)
+mlx5e_dma_push_single(struct mlx5e_txqsq *sq, dma_addr_t addr, u32 size)
 {
 	struct mlx5e_sq_dma *dma = mlx5e_dma_get(sq, sq->dma_fifo_pc++);
 
 	dma->addr = addr;
 	dma->size = size;
-	dma->type = map_type;
+	dma->type = MLX5E_DMA_MAP_SINGLE;
+}
+
+static inline void
+mlx5e_dma_push_netmem(struct mlx5e_txqsq *sq, netmem_ref netmem,
+		      dma_addr_t addr, u32 size)
+{
+	struct mlx5e_sq_dma *dma = mlx5e_dma_get(sq, sq->dma_fifo_pc++);
+
+	netmem_dma_unmap_addr_set(netmem, dma, addr, addr);
+	dma->size = size;
+	dma->type = MLX5E_DMA_MAP_PAGE;
 }
 
 static inline
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_tx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_tx.c
index 3db31cc10719..08f06984407b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_tx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_tx.c
@@ -744,7 +744,7 @@ tx_post_resync_dump(struct mlx5e_txqsq *sq, skb_frag_t *frag, u32 tisn)
 	dseg->addr       = cpu_to_be64(dma_addr);
 	dseg->lkey       = sq->mkey_be;
 	dseg->byte_count = cpu_to_be32(fsz);
-	mlx5e_dma_push(sq, dma_addr, fsz, MLX5E_DMA_MAP_PAGE);
+	mlx5e_dma_push_netmem(sq, skb_frag_netmem(frag), dma_addr, fsz);
 
 	tx_fill_wi(sq, pi, MLX5E_KTLS_DUMP_WQEBBS, fsz, skb_frag_page(frag));
 	sq->pc += MLX5E_KTLS_DUMP_WQEBBS;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
index e6a301ba3254..319061d31602 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
@@ -196,7 +196,7 @@ mlx5e_txwqe_build_dsegs(struct mlx5e_txqsq *sq, struct sk_buff *skb,
 		dseg->lkey       = sq->mkey_be;
 		dseg->byte_count = cpu_to_be32(headlen);
 
-		mlx5e_dma_push(sq, dma_addr, headlen, MLX5E_DMA_MAP_SINGLE);
+		mlx5e_dma_push_single(sq, dma_addr, headlen);
 		num_dma++;
 		dseg++;
 	}
@@ -214,7 +214,7 @@ mlx5e_txwqe_build_dsegs(struct mlx5e_txqsq *sq, struct sk_buff *skb,
 		dseg->lkey       = sq->mkey_be;
 		dseg->byte_count = cpu_to_be32(fsz);
 
-		mlx5e_dma_push(sq, dma_addr, fsz, MLX5E_DMA_MAP_PAGE);
+		mlx5e_dma_push_netmem(sq, skb_frag_netmem(frag), dma_addr, fsz);
 		num_dma++;
 		dseg++;
 	}
@@ -616,7 +616,7 @@ mlx5e_sq_xmit_mpwqe(struct mlx5e_txqsq *sq, struct sk_buff *skb,
 
 	sq->stats->xmit_more += xmit_more;
 
-	mlx5e_dma_push(sq, txd.dma_addr, txd.len, MLX5E_DMA_MAP_SINGLE);
+	mlx5e_dma_push_single(sq, txd.dma_addr, txd.len);
 	mlx5e_skb_fifo_push(&sq->db.skb_fifo, skb);
 	mlx5e_tx_mpwqe_add_dseg(sq, &txd);
 	mlx5e_tx_skb_update_ts_flags(skb);

base-commit: c3886ccaadf8fdc2c91bfbdcdca36ccdc6ef8f70
-- 
2.31.1


