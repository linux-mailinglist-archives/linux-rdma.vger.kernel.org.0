Return-Path: <linux-rdma+bounces-13548-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15B78B8F3BC
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Sep 2025 09:12:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA993189E19E
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Sep 2025 07:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D2FC2F3C11;
	Mon, 22 Sep 2025 07:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fKqyuP6U"
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011015.outbound.protection.outlook.com [40.107.208.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F0662F1FE5;
	Mon, 22 Sep 2025 07:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758525135; cv=fail; b=j5QteS18rLdN8Y0zhbgmbLSyUIWnx84hS01QP1Yszg+PyB3tYCq4E4hcSqoJWOdgove6QgJ4pE2JWZEJznbp3dG4fWUJiYx09UAU+6QeLI0ZaYE09PmQvDqBDjN1MsMCCKsds67yovKwLI0SfS69RrF8elRa1p0aZoqte5Cu6zc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758525135; c=relaxed/simple;
	bh=FLE8RpHQpVnVNYpPLvd6wDrMaPZ+U6Zr6NitA9UV9OQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TUCYXnU47WARX9mnXgKSPgKekYypWgejCp1at3Ysb9aXPIZ2OFeVBn8VNzJYbdB9glzdDiZoLFiTmRScyFU6+6oMod3Z1vN3Yhd72YZSM5xorbvOesEAyDrqfwAWNcnSrOYhTz1i1nVYcl8dZmKs6ayL0y97DWM0ttmQW1j76V8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fKqyuP6U; arc=fail smtp.client-ip=40.107.208.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XlGLpWmVJdyi3miFSRCWLn9lfFyebAl8SWvx0KOhIt08vvaP9OjbNaTr0s9xB4U9cLJLqUkTZNS6IBmmD7u3FThaQ+6CTcxz+Qw9JBlDzfWk+IwXEkFj4RQjErkzPNgHbYsoICJoH/qrp87407UqGmikI/+CkHXAJwJRH7trax+9JWq3K5+TNuxHUocRvvNxF6epraIMNPZ3YKQPWwTDdhb6l0eBk2R0hht7uHxcXmHMu3upW+lT26u9rxxO6h2GFdorj92Lyeni5sWpQGyuFwTEPfnz7T6bkrKWgEU/phGwmZ+Lqrv3BV2xMO1Zzw/Cljz6cGduEaoILoakajLsUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EkBAJgkbwmUcoaxVHnFzsfNqFQjZZRa0SozveyBzVaE=;
 b=DHI4m+33Lmmv6XuGsU8aWbG49mpcQ85C5xhDDX1mS689BTPW+/u3HsYJ/wkQLj7jA6FXUJbRt2cX/obY5DMuDZWGN9FgMB0HwVs0iXkvyQs653vvApdgpbWoYmB6btP7kMQquMPD3o8BoCXZOcsaKd2U2ls2Drr32pu68/V9qVFu7ggOGG8Tp62chRy+vX5h4Uym8leZgOIxI5FJ9Ca9p8HZONTlSTLrKdSxh1TaPJ25fNs3JINQMA044nOPblMoLkl6vCjSAaKbzeDbM54DnclgM6dK3BeD1i4jTqKfUe2CZCzDmcN/lAMCKuYCgKH9CurH3Pn8u3nawT8zUKntSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EkBAJgkbwmUcoaxVHnFzsfNqFQjZZRa0SozveyBzVaE=;
 b=fKqyuP6UWAEqJpFTW/cZlrnDKQNzQvdDEjhWVZMR4h4ejyJxCCQCV3IjRZjk0XJ/1K9VAGOb08jX1aP5cVLrf80g92c0msFW04jK65J5kVW3QbfzGCHk/JZUo0S5bBjT7jSdsxmMeYMx3UQNprWDf82EvurwDoYKhOzrXG80LoYBFUUwvUA+WcEC7FSvuomEqk98ienuHnLwAuGER02K9OGtUzSORQnpjfFm5EnjjzW9E1key6c3RiweeokGnoTipcVCsT30J/LRXVG/J2ZRRnpsPwzQYSnLhkySWsmPUJvJhLOa4dY/NDgZP6N/NxSXLA89CqZ/VL5Fd9A1YbdCBQ==
Received: from MN0P222CA0003.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:531::13)
 by DS0PR12MB7534.namprd12.prod.outlook.com (2603:10b6:8:139::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.16; Mon, 22 Sep
 2025 07:12:07 +0000
Received: from BL02EPF0001A0FD.namprd03.prod.outlook.com
 (2603:10b6:208:531:cafe::c3) by MN0P222CA0003.outlook.office365.com
 (2603:10b6:208:531::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.20 via Frontend Transport; Mon,
 22 Sep 2025 07:12:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0001A0FD.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Mon, 22 Sep 2025 07:12:07 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 22 Sep
 2025 00:11:53 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 22 Sep
 2025 00:11:52 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Mon, 22
 Sep 2025 00:11:47 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
	"Mark Bloch" <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>
Subject: [PATCH net 1/3] net/mlx5: fs, fix UAF in flow counter release
Date: Mon, 22 Sep 2025 10:11:32 +0300
Message-ID: <1758525094-816583-2-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1758525094-816583-1-git-send-email-tariqt@nvidia.com>
References: <1758525094-816583-1-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FD:EE_|DS0PR12MB7534:EE_
X-MS-Office365-Filtering-Correlation-Id: b0e3340a-4fab-490d-f910-08ddf9a75776
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jhZfefc/R2ar/NLDXrEuaecla95xgbLncd79JVIVqz4UJz6HlPKGJE3KYnD8?=
 =?us-ascii?Q?yRPos1Zx16C9l5im6YBaIo+1qPmbsm8i05DqK1g6zkihjO6FNFraCiPI443R?=
 =?us-ascii?Q?GTsSfL8HdVr+KBky3Z0uYJb68IRvqKzleUHr40oj1GARph3gLAcfQZzW91rs?=
 =?us-ascii?Q?epBSozOKjD1kDWbLe39OwEI15NckHsNNGQrn0Pqr8pwoAFckTnTKgH26rloK?=
 =?us-ascii?Q?YvpBJNXTlD8uCO1JtOrk5hWmU8SrRRfsFgug3sPPFkf24BqcQszVTGyDV4NM?=
 =?us-ascii?Q?6FcTZxffqXfF+OmSqkC7nBacFMXfJOy0UMVztb+2jy35eTcgYcFzbgXJ8KAV?=
 =?us-ascii?Q?0CL6mjNi8ya4ZS0gZCLmZnM6T30q3dpg8Xa3EIjqbz3C76tsvkslKvLLSNhp?=
 =?us-ascii?Q?LNRcX//gcPt/k+buBtMa747h6kuD2e1UbRqrkHYrePZhZvsoM6zerOpqWuij?=
 =?us-ascii?Q?odb9kmw22bULvFC3zIx4J4cNuTiDtRLb7ykv+8WJvAW9kZvW/QIyrYGhzJvG?=
 =?us-ascii?Q?vNxXxintMIOSr+cT+Ecb927szkM24FYsnTOi1pd0GL99BqJ7LzfWUBC1tlNw?=
 =?us-ascii?Q?B+UVWr2mK4ZypdTM+8m/O/sIGuI4yOlshJJASwjpPf0XFhla1+miT5BAZ1GW?=
 =?us-ascii?Q?kcbPcsstVHXaXx8G6EdtDCJlxOVYDQHd+n54NudsT4eSJPMIAnHBgs9k2eea?=
 =?us-ascii?Q?LBYDoODl/l5ZehVipCgDmf6KPZcEx4cgoU5x6yG84juPU2ECNRk/5pJZo+jE?=
 =?us-ascii?Q?DGdnLnfSAUv1kKamZgtE2GtACdRRAcuCqzMfVTNiOjOqXnlTE804Ft3UJ1ZD?=
 =?us-ascii?Q?V8060R4E4WuKI1/ELE4Dv/fCjPxWquQqtni10oP42vbTm0AWWQv4NGm83gtD?=
 =?us-ascii?Q?omaGRLToLZyxKB5x9/64f+jM7lfHvNWk0ZdevezOhsvCCLbkXocvVt/h491A?=
 =?us-ascii?Q?XXGUxAYXmS+VOHuTIALoE4ecqMnzL2sItbpdX8FJitf3HnouXi+KyDOJ1jhl?=
 =?us-ascii?Q?PfhT/xGhVvL/OEuvBJaARBaN7VYcZjUfWX15LK7+0jmEPkcnnslBsoXXZv68?=
 =?us-ascii?Q?k81/T+2Qw/beeODsl1/uI4TEPttUBw2uRJfvMNxG0VZ1I1jmb1mB0vEbR4Uq?=
 =?us-ascii?Q?7+dIa/dh6ODJhFrbalumxjKVGhs4dxTqgTR8hW6nJRxc6/LfIhdKs2keExVM?=
 =?us-ascii?Q?sg6aQhzOS49KifG8sTHOlPMCx+sePMZ+8wFr0CI7xWXM/JMzbqJ9l1UZYMf5?=
 =?us-ascii?Q?WuZKofGpgmyyW4RVx+yuzZFa1u4qFw9E1QeH8GMdJWfgS5QhchkZ6/yQgXAj?=
 =?us-ascii?Q?ktu9yhH5IrTDtrXhZVov18pRbee7ZnHLmF9+pMJqw6LuWo/JSY9u+p8viuSF?=
 =?us-ascii?Q?mSCph+a67PbIjdd30YSGStxVgZ/4008gRbqm/glVCXSO6RlYEVGK3CckjzEG?=
 =?us-ascii?Q?QKoM4HrZQV++gFRo1FO6hsSBloSzl+WHQr9gHjvZEln7jVy4PdLIupKo1cir?=
 =?us-ascii?Q?mS+uuGUEJecVt34wdr7hosbSjp7mNJpmrrEr?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2025 07:12:07.6881
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b0e3340a-4fab-490d-f910-08ddf9a75776
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7534

From: Moshe Shemesh <moshe@nvidia.com>

Fix a kernel trace [1] caused by releasing an HWS action of a local flow
counter in mlx5_cmd_hws_delete_fte(), where the HWS action refcount and
mutex were not initialized and the counter struct could already be freed
when deleting the rule.

Fix it by adding the missing initializations and adding refcount for the
local flow counter struct.

[1] Kernel log:
 Call Trace:
  <TASK>
  dump_stack_lvl+0x34/0x48
  mlx5_fs_put_hws_action.part.0.cold+0x21/0x94 [mlx5_core]
  mlx5_fc_put_hws_action+0x96/0xad [mlx5_core]
  mlx5_fs_destroy_fs_actions+0x8b/0x152 [mlx5_core]
  mlx5_cmd_hws_delete_fte+0x5a/0xa0 [mlx5_core]
  del_hw_fte+0x1ce/0x260 [mlx5_core]
  mlx5_del_flow_rules+0x12d/0x240 [mlx5_core]
  ? ttwu_queue_wakelist+0xf4/0x110
  mlx5_ib_destroy_flow+0x103/0x1b0 [mlx5_ib]
  uverbs_free_flow+0x20/0x50 [ib_uverbs]
  destroy_hw_idr_uobject+0x1b/0x50 [ib_uverbs]
  uverbs_destroy_uobject+0x34/0x1a0 [ib_uverbs]
  uobj_destroy+0x3c/0x80 [ib_uverbs]
  ib_uverbs_run_method+0x23e/0x360 [ib_uverbs]
  ? uverbs_finalize_object+0x60/0x60 [ib_uverbs]
  ib_uverbs_cmd_verbs+0x14f/0x2c0 [ib_uverbs]
  ? do_tty_write+0x1a9/0x270
  ? file_tty_write.constprop.0+0x98/0xc0
  ? new_sync_write+0xfc/0x190
  ib_uverbs_ioctl+0xd7/0x160 [ib_uverbs]
  __x64_sys_ioctl+0x87/0xc0
  do_syscall_64+0x59/0x90

Fixes: b581f4266928 ("net/mlx5: fs, manage flow counters HWS action sharing by refcount")
Signed-off-by: Moshe Shemesh <moshe@nvidia.com>
Reviewed-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/fs_core.c |  2 +-
 .../net/ethernet/mellanox/mlx5/core/fs_core.h |  1 +
 .../ethernet/mellanox/mlx5/core/fs_counters.c | 25 ++++++++++++++++---
 .../mlx5/core/steering/hws/fs_hws_pools.c     |  8 +++++-
 include/linux/mlx5/fs.h                       |  2 ++
 5 files changed, 33 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
index db552c012b4f..80245c38dbad 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
@@ -663,7 +663,7 @@ static void del_sw_hw_rule(struct fs_node *node)
 			BIT(MLX5_SET_FTE_MODIFY_ENABLE_MASK_ACTION) |
 			BIT(MLX5_SET_FTE_MODIFY_ENABLE_MASK_FLOW_COUNTERS);
 		fte->act_dests.action.action &= ~MLX5_FLOW_CONTEXT_ACTION_COUNT;
-		mlx5_fc_local_destroy(rule->dest_attr.counter);
+		mlx5_fc_local_put(rule->dest_attr.counter);
 		goto out;
 	}
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.h b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.h
index 500826229b0b..e6a95b310b55 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.h
@@ -343,6 +343,7 @@ struct mlx5_fc {
 	enum mlx5_fc_type type;
 	struct mlx5_fc_bulk *bulk;
 	struct mlx5_fc_cache cache;
+	refcount_t fc_local_refcount;
 	/* last{packets,bytes} are used for calculating deltas since last reading. */
 	u64 lastpackets;
 	u64 lastbytes;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_counters.c b/drivers/net/ethernet/mellanox/mlx5/core/fs_counters.c
index 492775d3d193..83001eda3884 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fs_counters.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_counters.c
@@ -562,17 +562,36 @@ mlx5_fc_local_create(u32 counter_id, u32 offset, u32 bulk_size)
 	counter->id = counter_id;
 	fc_bulk->base_id = counter_id - offset;
 	fc_bulk->fs_bulk.bulk_len = bulk_size;
+	refcount_set(&fc_bulk->hws_data.hws_action_refcount, 0);
+	mutex_init(&fc_bulk->hws_data.lock);
 	counter->bulk = fc_bulk;
+	refcount_set(&counter->fc_local_refcount, 1);
 	return counter;
 }
 EXPORT_SYMBOL(mlx5_fc_local_create);
 
 void mlx5_fc_local_destroy(struct mlx5_fc *counter)
 {
-	if (!counter || counter->type != MLX5_FC_TYPE_LOCAL)
-		return;
-
 	kfree(counter->bulk);
 	kfree(counter);
 }
 EXPORT_SYMBOL(mlx5_fc_local_destroy);
+
+void mlx5_fc_local_get(struct mlx5_fc *counter)
+{
+	if (!counter || counter->type != MLX5_FC_TYPE_LOCAL)
+		return;
+
+	refcount_inc(&counter->fc_local_refcount);
+}
+
+void mlx5_fc_local_put(struct mlx5_fc *counter)
+{
+	if (!counter || counter->type != MLX5_FC_TYPE_LOCAL)
+		return;
+
+	if (!refcount_dec_and_test(&counter->fc_local_refcount))
+		return;
+
+	mlx5_fc_local_destroy(counter);
+}
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws_pools.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws_pools.c
index f1ecdba74e1f..839d71bd4216 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws_pools.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws_pools.c
@@ -407,15 +407,21 @@ struct mlx5hws_action *mlx5_fc_get_hws_action(struct mlx5hws_context *ctx,
 {
 	struct mlx5_fs_hws_create_action_ctx create_ctx;
 	struct mlx5_fc_bulk *fc_bulk = counter->bulk;
+	struct mlx5hws_action *hws_action;
 
 	create_ctx.hws_ctx = ctx;
 	create_ctx.id = fc_bulk->base_id;
 	create_ctx.actions_type = MLX5HWS_ACTION_TYP_CTR;
 
-	return mlx5_fs_get_hws_action(&fc_bulk->hws_data, &create_ctx);
+	mlx5_fc_local_get(counter);
+	hws_action = mlx5_fs_get_hws_action(&fc_bulk->hws_data, &create_ctx);
+	if (!hws_action)
+		mlx5_fc_local_put(counter);
+	return hws_action;
 }
 
 void mlx5_fc_put_hws_action(struct mlx5_fc *counter)
 {
 	mlx5_fs_put_hws_action(&counter->bulk->hws_data);
+	mlx5_fc_local_put(counter);
 }
diff --git a/include/linux/mlx5/fs.h b/include/linux/mlx5/fs.h
index 86055d55836d..6ac76a0c3827 100644
--- a/include/linux/mlx5/fs.h
+++ b/include/linux/mlx5/fs.h
@@ -308,6 +308,8 @@ struct mlx5_fc *mlx5_fc_create(struct mlx5_core_dev *dev, bool aging);
 void mlx5_fc_destroy(struct mlx5_core_dev *dev, struct mlx5_fc *counter);
 struct mlx5_fc *mlx5_fc_local_create(u32 counter_id, u32 offset, u32 bulk_size);
 void mlx5_fc_local_destroy(struct mlx5_fc *counter);
+void mlx5_fc_local_get(struct mlx5_fc *counter);
+void mlx5_fc_local_put(struct mlx5_fc *counter);
 u64 mlx5_fc_query_lastuse(struct mlx5_fc *counter);
 void mlx5_fc_query_cached(struct mlx5_fc *counter,
 			  u64 *bytes, u64 *packets, u64 *lastuse);
-- 
2.31.1


