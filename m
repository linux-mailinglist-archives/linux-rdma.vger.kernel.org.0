Return-Path: <linux-rdma+bounces-14338-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2213EC43B61
	for <lists+linux-rdma@lfdr.de>; Sun, 09 Nov 2025 10:50:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0449418864A5
	for <lists+linux-rdma@lfdr.de>; Sun,  9 Nov 2025 09:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCA482D9ED1;
	Sun,  9 Nov 2025 09:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="S8BneHqc"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012045.outbound.protection.outlook.com [52.101.43.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C1F2D94BB;
	Sun,  9 Nov 2025 09:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762681791; cv=fail; b=N9E6eYJALL2XKzZ9k6W51mkCp0V+deRdETzTCqKMcF2GPzOGiFqR9IGF2Ye+gIUj1MFhQ6fbyVYIzxyH0289k6kuWDIxs4EniJIgnFfPVwLVwod0o5Heb2aaZaRgygVG1B5c3bS3EtOKvS8Gyaj5T9X1/S4F/0qaz0c4OzXl+IM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762681791; c=relaxed/simple;
	bh=yOQlo/BjDB4li6i0Vs0ljMLmQdlo/nLkV2aAUCCyZBY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nmolchd/r/qQmW68vdFxkOXTnmR09hxivlWRO1QbMTfR5KjJ2a/F59Vst8VinwyuyTWHSvSNfkBas2LlKWfpCTghJ3kgB6Wj1vamGC3sUNDsBHsVo0doUoIun+SX1Tw5z8Ur2zNwpNGSXPNqjstjZ1DTeTOdniiTMQeMNgkF56E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=S8BneHqc; arc=fail smtp.client-ip=52.101.43.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uQL1NV8FJ+WzTwBxPj3HEBN4/Un/TQpi066/uRpGE2aJcM1vZGfROHpBr6FANkkp7GGGBkyXODxtU66bjO4iipEN5v+P4hixAzmH/UyErWvgY3pk+nzp75RgvkOGiH3RZIJHtZ/jg8hmi5wFMiL4ZMJhvOt/Owe1slalUwMxKwRgjjZg1tI+VH2ZI3S2aaSCArmz4tCewsVsFlHKpA7F0cWfkhSxrfmJaALN3NNHjbovsb0ZfvKz2vajmTcOgv5cirCFD3J4JXWclCaUsrv72d1r/pkiflVJ4s/aw8yzI+LJmDxTuJT8Lh2lm7ePoWNgwPkEOun34kouso2ahFd+2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=80AOg1iBgSL9LwgosPVpQZJ6fvxKjwvkAEmtY+iaSRY=;
 b=i98SntCoGxXT9ziWO5vKf9il/ZiZgctPs+UEgvXKUJvnVsY3IJezveOcJnT86fDeRgDq8x++Q+zBAmUmVzfSyW9+399O8BWeP4a5pXVo+B/kGd0j6K3xRkavfHI/yE8zGDmQFbzVkfXaZ9ePRE7u33MlzAmZgoTYrcBXjCRCCkHSuNVHEOia18GTDIqzRMcFAXLP7lxJX3TPrHGojkZNiDlaUxdACzbxjWNxURjCeBVvBZC1ZsKcNdhi3Ac40NAqjfVBzJE4zCt3fAYRmVogQy7zFo6KrUrvSqRSnLUzc3qx0UP7OUTKKOUXx04v5IBUi3B6NpYySSOk3C3TNH2F3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=80AOg1iBgSL9LwgosPVpQZJ6fvxKjwvkAEmtY+iaSRY=;
 b=S8BneHqcV5Bk9S1Vvyk624pcusRhYqzTVrr++KBHmlpHW4n4DMYFPN6FbxvcPm57jXb41eNWi8XErrQY4D70wVak5B9oMjz4PApaoA0iO06ophca4TXW/+2IWUtGbKCNHy918bthSVpKDhvUvWSMtYNwPfb3js9bHErpcNbzj3nyo7aoZuFikMyzwXbK8a+k1CjB2t/Ybjj4wjKxfHhqitRE7VmpzPcZP6ui8iptSrlz6lX/gZNlyIl1uOoCA/06e4SwnDA0/x42oQTkg5fZCf/H0WUwVDv7M8e1efiS3YQqbQB8iZ4fMScSMXkY3Efg4d1lKdXS+uHRioUoJWCQkA==
Received: from CH0PR03CA0356.namprd03.prod.outlook.com (2603:10b6:610:11a::34)
 by SA5PPFE494AA682.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8e7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Sun, 9 Nov
 2025 09:49:44 +0000
Received: from DS2PEPF0000343D.namprd02.prod.outlook.com
 (2603:10b6:610:11a:cafe::82) by CH0PR03CA0356.outlook.office365.com
 (2603:10b6:610:11a::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.16 via Frontend Transport; Sun,
 9 Nov 2025 09:49:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DS2PEPF0000343D.mail.protection.outlook.com (10.167.18.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Sun, 9 Nov 2025 09:49:43 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 9 Nov
 2025 01:49:41 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sun, 9 Nov 2025 01:49:40 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Sun, 9 Nov 2025 01:49:35 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, "Saeed
 Mahameed" <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>, "Michael S.
 Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <virtualization@lists.linux.dev>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Edward Srouji
	<edwards@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, Akiva Goldberger
	<agoldberger@nvidia.com>
Subject: [PATCH net] mlx5: Fix default values in create CQ
Date: Sun, 9 Nov 2025 11:49:03 +0200
Message-ID: <1762681743-1084694-1-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
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
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343D:EE_|SA5PPFE494AA682:EE_
X-MS-Office365-Filtering-Correlation-Id: dce17594-8af9-43ea-c39c-08de1f754f6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?m1cEZQaKMaulNaDvwCzPRw7suL4ueafSUVqffwISX+rWwZ7xlRUOhXqcRCEo?=
 =?us-ascii?Q?izEJyFuj6lRtOcdNqVY27ApZIKbl/mB9R4U/pGRyNrKgGaH0E0BrTcK/UU1C?=
 =?us-ascii?Q?FVKg18LE0ZpMUHiSn6Q+8Q1g3oc5Su3FMivZnYhK3taPRqFRuv/sqNU9/Pj4?=
 =?us-ascii?Q?rV6oFlqxXzvlb0LJpx24dMU6ZTuEopMo7VstGNjViyiK/FxxzzqKRkQMHnk/?=
 =?us-ascii?Q?w3SoAa6cC0FDUlbrH3tEwol6QGl8pACbct1XL/McCRRviHn69sf4LZDDCU+o?=
 =?us-ascii?Q?d4Xy3ttwH+sEH8iEFXuAVT2wFj9HMO2JsDbPmo8iDQD0icjycK7hWVdBfjNt?=
 =?us-ascii?Q?5rAyLvLThZ9IYbWzRdHE+5EBGClpLJQikFP36JFyjZc3cP7H03D+hwCsX1am?=
 =?us-ascii?Q?sdmB67PmbxnzPnDfwUKUTmV9caAnd0SApjy6ymvVRQ6LvI3HTy9hSd62P4fa?=
 =?us-ascii?Q?7vqXTaHujZNi9yUaR95qwUeLBlpmgRyokYf7gohkGw5B1wMxQ6CmqtCxMS9l?=
 =?us-ascii?Q?A0i37cE36KxITmfm3WMbBzNm+pBIB4IgjBkF2Z+vPZQdJxflIgUYiA/fXko4?=
 =?us-ascii?Q?QCLCtzx+HxabZ5lHzdbp09HpdgSXh+757QqcsJK6rEs/7D2wAIO0zuNGW4uL?=
 =?us-ascii?Q?s3YjoN28B7ZLh4llGqD+93ZqV0tQkcjiI/B2Lc63RJOGji801QbuRqIEzWnQ?=
 =?us-ascii?Q?JWo/4oIvMXEa5kQtCKnf0DPmOt8RP8G9aOu6Ya0/SMZQcZPu1N+Ved8DmB4N?=
 =?us-ascii?Q?JQPs041ZQNIXzuuUxFSCcdDLrqyOGSBeYx/+P883n8Fk+ls5PIsPVe4spOwx?=
 =?us-ascii?Q?Sz7gw8As4TE8Hcy7VN1Nae4fUk/ws4n+nybIa4VEPvRRpsBGYcOqD/BS+Vib?=
 =?us-ascii?Q?R1geE7/pSIa0+C6qS46jUwQrEUlRvLT0lSxfa3vCEGQQ9amgTvlkIcD223oU?=
 =?us-ascii?Q?yT/zBC/G9EQOYcPXk75X0b+kwaHd8AhHUvLYeYtb5fWbF6XhAdbybC/5DgJ2?=
 =?us-ascii?Q?ep2lEw7rxSPc/yi1M+w9d07dOzXUBscaqU1q0fc1FzBtj5oYibcq3Hq/HYIY?=
 =?us-ascii?Q?yXJIhHWJk9KoF5fcB4BGSeZQyMb/EA5oGH7aBeDm9+zDrbLUbZzf+5DK1ydv?=
 =?us-ascii?Q?PBCOP6WXOr6jwsA3GE7uX63401uuBHnnTF3ZJ1zZkn25d8H7UIvkHgABEHf9?=
 =?us-ascii?Q?TfbFdgfVv4/1ObBPwidm1GfCfftbdncR8F1eXtR0loAHWPm/fRLGNMh57Xpb?=
 =?us-ascii?Q?PE0IUT39dyeOgih6dHj+rHvK6P4nSfvdhtNf6Pw+JSRoAy6l0ONmi2pwKEv7?=
 =?us-ascii?Q?M5I9+3EVxPuw8PVebPeZa9pxFQWgwcJ/xpWP+ZHdvRuZVAu7wB6YJ2VMRdv5?=
 =?us-ascii?Q?MYfetNfYLTkEvoAga4NQx/1CL+ZnkDVqdVYE81+AAhG05AErR6CwvtSEjG54?=
 =?us-ascii?Q?ATL8pnnlNPkd60nDjzUAI7BzftEL3eu9j11O7rRPG3oz3RHqXgisiGhBfOUm?=
 =?us-ascii?Q?GajMOO/w/FjqFXF0G+JcjawzeSA8nlUQorWgOfiWd84R1j501ebFWqZANqtZ?=
 =?us-ascii?Q?uvw/8lFx770Z3efBtrQ=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2025 09:49:43.6022
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dce17594-8af9-43ea-c39c-08de1f754f6b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF0000343D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFE494AA682

From: Akiva Goldberger <agoldberger@nvidia.com>

Currently, CQs without a completion function are assigned the
mlx5_add_cq_to_tasklet function by default. This is problematic since
only user CQs created through the mlx5_ib driver are intended to use
this function.

Additionally, all CQs that will use doorbells instead of polling for
completions must call mlx5_cq_arm. However, the default CQ creation flow
leaves a valid value in the CQ's arm_db field, allowing FW to send
interrupts to polling-only CQs in certain corner cases.

These two factors would allow a polling-only kernel CQ to be triggered
by an EQ interrupt and call a completion function intended only for user
CQs, causing a null pointer exception.

Some areas in the driver have prevented this issue with one-off fixes
but did not address the root cause.

This patch fixes the described issue by adding defaults to the create CQ
flow. It adds a default dummy completion function to protect against
null pointer exceptions, and it sets an invalid command sequence number
by default in kernel CQs to prevent the FW from sending an interrupt to
the CQ until it is armed. User CQs are responsible for their own
initialization values.

Callers of mlx5_core_create_cq are responsible for changing the
completion function and arming the CQ per their needs.

Fixes: cdd04f4d4d71 ("net/mlx5: Add support to create SQ and CQ for ASO")
Signed-off-by: Akiva Goldberger <agoldberger@nvidia.com>
Reviewed-by: Moshe Shemesh <moshe@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/infiniband/hw/mlx5/cq.c               | 11 +++++---
 drivers/net/ethernet/mellanox/mlx5/core/cq.c  | 23 +++++++++++++--
 .../net/ethernet/mellanox/mlx5/core/en_main.c |  1 -
 .../ethernet/mellanox/mlx5/core/fpga/conn.c   | 15 +++++-----
 .../mellanox/mlx5/core/steering/hws/send.c    |  7 -----
 .../mellanox/mlx5/core/steering/sws/dr_send.c | 28 +++++--------------
 drivers/vdpa/mlx5/net/mlx5_vnet.c             |  6 ++--
 include/linux/mlx5/cq.h                       |  1 +
 8 files changed, 44 insertions(+), 48 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/cq.c b/drivers/infiniband/hw/mlx5/cq.c
index a23b364e24ff..651d76bca114 100644
--- a/drivers/infiniband/hw/mlx5/cq.c
+++ b/drivers/infiniband/hw/mlx5/cq.c
@@ -1020,15 +1020,18 @@ int mlx5_ib_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 	if (cq->create_flags & IB_UVERBS_CQ_FLAGS_IGNORE_OVERRUN)
 		MLX5_SET(cqc, cqc, oi, 1);
 
+	if (udata) {
+		cq->mcq.comp = mlx5_add_cq_to_tasklet;
+		cq->mcq.tasklet_ctx.comp = mlx5_ib_cq_comp;
+	} else {
+		cq->mcq.comp  = mlx5_ib_cq_comp;
+	}
+
 	err = mlx5_core_create_cq(dev->mdev, &cq->mcq, cqb, inlen, out, sizeof(out));
 	if (err)
 		goto err_cqb;
 
 	mlx5_ib_dbg(dev, "cqn 0x%x\n", cq->mcq.cqn);
-	if (udata)
-		cq->mcq.tasklet_ctx.comp = mlx5_ib_cq_comp;
-	else
-		cq->mcq.comp  = mlx5_ib_cq_comp;
 	cq->mcq.event = mlx5_ib_cq_event;
 
 	INIT_LIST_HEAD(&cq->wc_list);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/cq.c b/drivers/net/ethernet/mellanox/mlx5/core/cq.c
index e9f319a9bdd6..60f7ab1d72e7 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/cq.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/cq.c
@@ -66,8 +66,8 @@ void mlx5_cq_tasklet_cb(struct tasklet_struct *t)
 		tasklet_schedule(&ctx->task);
 }
 
-static void mlx5_add_cq_to_tasklet(struct mlx5_core_cq *cq,
-				   struct mlx5_eqe *eqe)
+void mlx5_add_cq_to_tasklet(struct mlx5_core_cq *cq,
+			    struct mlx5_eqe *eqe)
 {
 	unsigned long flags;
 	struct mlx5_eq_tasklet *tasklet_ctx = cq->tasklet_ctx.priv;
@@ -95,7 +95,15 @@ static void mlx5_add_cq_to_tasklet(struct mlx5_core_cq *cq,
 	if (schedule_tasklet)
 		tasklet_schedule(&tasklet_ctx->task);
 }
+EXPORT_SYMBOL(mlx5_add_cq_to_tasklet);
 
+static void mlx5_core_cq_dummy_cb(struct mlx5_core_cq *cq, struct mlx5_eqe *eqe)
+{
+	mlx5_core_err(cq->eq->core.dev,
+		      "CQ default completion callback, CQ #%u\n", cq->cqn);
+}
+
+#define MLX5_CQ_INIT_CMD_SN cpu_to_be32(2 << 28)
 /* Callers must verify outbox status in case of err */
 int mlx5_create_cq(struct mlx5_core_dev *dev, struct mlx5_core_cq *cq,
 		   u32 *in, int inlen, u32 *out, int outlen)
@@ -121,10 +129,19 @@ int mlx5_create_cq(struct mlx5_core_dev *dev, struct mlx5_core_cq *cq,
 	cq->arm_sn     = 0;
 	cq->eq         = eq;
 	cq->uid = MLX5_GET(create_cq_in, in, uid);
+
+	/* Kernel CQs must set the arm_db address prior to calling
+	 * this function, allowing for the proper value to be
+	 * initialized. User CQs are responsible for their own
+	 * initialization since they do not use the arm_db field.
+	 */
+	if (cq->arm_db)
+		*cq->arm_db = MLX5_CQ_INIT_CMD_SN;
+
 	refcount_set(&cq->refcount, 1);
 	init_completion(&cq->free);
 	if (!cq->comp)
-		cq->comp = mlx5_add_cq_to_tasklet;
+		cq->comp = mlx5_core_cq_dummy_cb;
 	/* assuming CQ will be deleted before the EQ */
 	cq->tasklet_ctx.priv = &eq->tasklet_ctx;
 	INIT_LIST_HEAD(&cq->tasklet_ctx.list);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 6023bbbf3f39..5e17eae81f4b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -2219,7 +2219,6 @@ static int mlx5e_alloc_cq_common(struct mlx5_core_dev *mdev,
 	mcq->set_ci_db  = cq->wq_ctrl.db.db;
 	mcq->arm_db     = cq->wq_ctrl.db.db + 1;
 	*mcq->set_ci_db = 0;
-	*mcq->arm_db    = 0;
 	mcq->vector     = param->eq_ix;
 	mcq->comp       = mlx5e_completion_event;
 	mcq->event      = mlx5e_cq_error_event;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fpga/conn.c b/drivers/net/ethernet/mellanox/mlx5/core/fpga/conn.c
index cb1319974f83..ccef64fb40b6 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fpga/conn.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fpga/conn.c
@@ -421,6 +421,13 @@ static int mlx5_fpga_conn_create_cq(struct mlx5_fpga_conn *conn, int cq_size)
 	__be64 *pas;
 	u32 i;
 
+	conn->cq.mcq.cqe_sz     = 64;
+	conn->cq.mcq.set_ci_db  = conn->cq.wq_ctrl.db.db;
+	conn->cq.mcq.arm_db     = conn->cq.wq_ctrl.db.db + 1;
+	*conn->cq.mcq.set_ci_db = 0;
+	conn->cq.mcq.vector     = 0;
+	conn->cq.mcq.comp       = mlx5_fpga_conn_cq_complete;
+
 	cq_size = roundup_pow_of_two(cq_size);
 	MLX5_SET(cqc, temp_cqc, log_cq_size, ilog2(cq_size));
 
@@ -468,15 +475,7 @@ static int mlx5_fpga_conn_create_cq(struct mlx5_fpga_conn *conn, int cq_size)
 	if (err)
 		goto err_cqwq;
 
-	conn->cq.mcq.cqe_sz     = 64;
-	conn->cq.mcq.set_ci_db  = conn->cq.wq_ctrl.db.db;
-	conn->cq.mcq.arm_db     = conn->cq.wq_ctrl.db.db + 1;
-	*conn->cq.mcq.set_ci_db = 0;
-	*conn->cq.mcq.arm_db    = 0;
-	conn->cq.mcq.vector     = 0;
-	conn->cq.mcq.comp       = mlx5_fpga_conn_cq_complete;
 	tasklet_setup(&conn->cq.tasklet, mlx5_fpga_conn_cq_tasklet);
-
 	mlx5_fpga_dbg(fdev, "Created CQ #0x%x\n", conn->cq.mcq.cqn);
 
 	goto out;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/send.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/send.c
index 24ef7d66fa8a..7510c46e58a5 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/send.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/send.c
@@ -873,12 +873,6 @@ static int hws_send_ring_open_sq(struct mlx5hws_context *ctx,
 	return err;
 }
 
-static void hws_cq_complete(struct mlx5_core_cq *mcq,
-			    struct mlx5_eqe *eqe)
-{
-	pr_err("CQ completion CQ: #%u\n", mcq->cqn);
-}
-
 static int hws_send_ring_alloc_cq(struct mlx5_core_dev *mdev,
 				  int numa_node,
 				  struct mlx5hws_send_engine *queue,
@@ -901,7 +895,6 @@ static int hws_send_ring_alloc_cq(struct mlx5_core_dev *mdev,
 	mcq->cqe_sz = 64;
 	mcq->set_ci_db = cq->wq_ctrl.db.db;
 	mcq->arm_db = cq->wq_ctrl.db.db + 1;
-	mcq->comp = hws_cq_complete;
 
 	for (i = 0; i < mlx5_cqwq_get_size(&cq->wq); i++) {
 		cqe = mlx5_cqwq_get_wqe(&cq->wq, i);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_send.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_send.c
index 077a77fde670..d034372fa047 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_send.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_send.c
@@ -1049,12 +1049,6 @@ static int dr_prepare_qp_to_rts(struct mlx5dr_domain *dmn)
 	return 0;
 }
 
-static void dr_cq_complete(struct mlx5_core_cq *mcq,
-			   struct mlx5_eqe *eqe)
-{
-	pr_err("CQ completion CQ: #%u\n", mcq->cqn);
-}
-
 static struct mlx5dr_cq *dr_create_cq(struct mlx5_core_dev *mdev,
 				      struct mlx5_uars_page *uar,
 				      size_t ncqe)
@@ -1089,6 +1083,13 @@ static struct mlx5dr_cq *dr_create_cq(struct mlx5_core_dev *mdev,
 		cqe->op_own = MLX5_CQE_INVALID << 4 | MLX5_CQE_OWNER_MASK;
 	}
 
+	cq->mcq.cqe_sz = 64;
+	cq->mcq.set_ci_db = cq->wq_ctrl.db.db;
+	cq->mcq.arm_db = cq->wq_ctrl.db.db + 1;
+	*cq->mcq.set_ci_db = 0;
+	cq->mcq.vector = 0;
+	cq->mdev = mdev;
+
 	inlen = MLX5_ST_SZ_BYTES(create_cq_in) +
 		sizeof(u64) * cq->wq_ctrl.buf.npages;
 	in = kvzalloc(inlen, GFP_KERNEL);
@@ -1112,27 +1113,12 @@ static struct mlx5dr_cq *dr_create_cq(struct mlx5_core_dev *mdev,
 	pas = (__be64 *)MLX5_ADDR_OF(create_cq_in, in, pas);
 	mlx5_fill_page_frag_array(&cq->wq_ctrl.buf, pas);
 
-	cq->mcq.comp  = dr_cq_complete;
-
 	err = mlx5_core_create_cq(mdev, &cq->mcq, in, inlen, out, sizeof(out));
 	kvfree(in);
 
 	if (err)
 		goto err_cqwq;
 
-	cq->mcq.cqe_sz = 64;
-	cq->mcq.set_ci_db = cq->wq_ctrl.db.db;
-	cq->mcq.arm_db = cq->wq_ctrl.db.db + 1;
-	*cq->mcq.set_ci_db = 0;
-
-	/* set no-zero value, in order to avoid the HW to run db-recovery on
-	 * CQ that used in polling mode.
-	 */
-	*cq->mcq.arm_db = cpu_to_be32(2 << 28);
-
-	cq->mcq.vector = 0;
-	cq->mdev = mdev;
-
 	return cq;
 
 err_cqwq:
diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index 82034efb74fc..a7936bd1aabe 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -573,6 +573,8 @@ static int cq_create(struct mlx5_vdpa_net *ndev, u16 idx, u32 num_ent)
 	vcq->mcq.set_ci_db = vcq->db.db;
 	vcq->mcq.arm_db = vcq->db.db + 1;
 	vcq->mcq.cqe_sz = 64;
+	vcq->mcq.comp = mlx5_vdpa_cq_comp;
+	vcq->cqe = num_ent;
 
 	err = cq_frag_buf_alloc(ndev, &vcq->buf, num_ent);
 	if (err)
@@ -612,10 +614,6 @@ static int cq_create(struct mlx5_vdpa_net *ndev, u16 idx, u32 num_ent)
 	if (err)
 		goto err_vec;
 
-	vcq->mcq.comp = mlx5_vdpa_cq_comp;
-	vcq->cqe = num_ent;
-	vcq->mcq.set_ci_db = vcq->db.db;
-	vcq->mcq.arm_db = vcq->db.db + 1;
 	mlx5_cq_arm(&mvq->cq.mcq, MLX5_CQ_DB_REQ_NOT, uar_page, mvq->cq.mcq.cons_index);
 	kfree(in);
 	return 0;
diff --git a/include/linux/mlx5/cq.h b/include/linux/mlx5/cq.h
index 7ef2c7c7d803..9d47cdc727ad 100644
--- a/include/linux/mlx5/cq.h
+++ b/include/linux/mlx5/cq.h
@@ -183,6 +183,7 @@ static inline void mlx5_cq_put(struct mlx5_core_cq *cq)
 		complete(&cq->free);
 }
 
+void mlx5_add_cq_to_tasklet(struct mlx5_core_cq *cq, struct mlx5_eqe *eqe);
 int mlx5_create_cq(struct mlx5_core_dev *dev, struct mlx5_core_cq *cq,
 		   u32 *in, int inlen, u32 *out, int outlen);
 int mlx5_core_create_cq(struct mlx5_core_dev *dev, struct mlx5_core_cq *cq,

base-commit: 96a9178a29a6b84bb632ebeb4e84cf61191c73d5
-- 
2.31.1


