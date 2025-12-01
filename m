Return-Path: <linux-rdma+bounces-14846-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F155DC97FEA
	for <lists+linux-rdma@lfdr.de>; Mon, 01 Dec 2025 16:15:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C9B194E2061
	for <lists+linux-rdma@lfdr.de>; Mon,  1 Dec 2025 15:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19F76320CD1;
	Mon,  1 Dec 2025 15:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DLjRWFrg"
X-Original-To: linux-rdma@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012042.outbound.protection.outlook.com [52.101.48.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ADAE31ED98;
	Mon,  1 Dec 2025 15:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764602075; cv=fail; b=ssNNzSgtfiVBngwCKU1chM4796wxjWvdryW3dPkzW1zAyx3+ZcPM4EBkAMoDS0V6UWny1t9kFBuNlJybz/9zIHn5Vye5oFnRswSP9UtdLrjvQ6sFo01mKq6Ajzk9gsGo0nFDVrQMnkMVYeoaks9GFcT7s/6TAS469Pob5IY3Lss=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764602075; c=relaxed/simple;
	bh=fdF+u1ecmMCvzQDZ/OPzTL0l8VEvIFHqSqkKJjRhTbQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B1tjWOfDV5dqc2Sh8TPj9WQCyuZMs8Ss3GdpAKdTXZtQjDH8i0PPhuPDrKwZ+OunSwCZsTShixb/hFYxacgL3Y8i+JPOTIMIqLqfUf79VsnB7dZhvcHTRhocOcy/R9RZunYVoAr5u3HEMdXPlIi65ZHQ/cWpWlG0L+HR8B6Ehpw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DLjRWFrg; arc=fail smtp.client-ip=52.101.48.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jmhO26c8f86AUfahxTrJUG5v2KaDupTq4b/4ssqAZFFN9m9LezFcJQ/1PUjx2WjUGDr63uY/YJJ02TudCwyDqCpRRkqjazaz/nynEUhCeCyTRpxWWaPdX0DYfUMlJZxWV5+uzilPK9ralBmNcC6BBZGfyjRyCs0yxGRWwdjz1mxvAuWFZ3fnsaIfR85KVCSQwV/WopyK+7XXuCqknpgeAUomGUA6FDSawLEDAg5SoEw7u5D9G/i5ZJH4BV583Uu3c/EEXlUeWkZlsxuQv409CCL3M6+fmz/0BWz8hXjs6Kxq2d/yS8DxT+UMQpldZ9SW/oKsZ+3RKWCn9muCJTxvGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HXlnxrmn2gNRxiQGxOaU/+AOYWRBmGmZwtGL+WK0qk8=;
 b=n/clIjddQ7FgMzQmnq6VzugXp3LsuUbrjuLMQFlsOzM+jmvOPP4vw5I/7ym74b7efLOc/LZM6DSGAHddTOjsmxAwhI8T4twzoL2p7RajM8+kpRWrrLzBhNBWjM1gfc9Q/GdQRBXCuLdH4DBGL1BqTVpuf77cPZqWlEKFIn4HOKXItdEezq3vCfIaBmjEBG3mXCeSpTJ57xf6gz5Uggq85xLijR7eQUc4RH6MdND12Zf2wnES8j32pRVKhVgqeHzNB7noeDb36Gdio3k8l4GnyhZe4o4u9Wu9DInEbhhRvq9KZ84pq2Tvj98RXxtb13oY6KTzrg7oFnMs0RMPHAJ75A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HXlnxrmn2gNRxiQGxOaU/+AOYWRBmGmZwtGL+WK0qk8=;
 b=DLjRWFrg1H/HtA4MAEHvH6hwW8aNp7V8VITrRbAfufAeZllM59zy7a2pGXt+ea0JiAqfPMPTNwel4oq+oldBupppUS9QHLC+3ZAxBw1w5y1QXtajMrXyrLypO+q6OhOx2nOooVPy6pBx3OwwLmvE02hqIzjjbAXICuRsM8Yx0BVUzIcUOzRR4zo9gO/PrDJH8m78BhoExWfSEQVbJi+P1xe2pZzievRMVVxxhP9q8C7Y32yIj+sWiW+cRBLB64oUeIYVfoSmVUExa/HqS1XmAipn4uI33wGeUK4aQkrHhNNn8jb+9XNGOdhptrV9rAkcMm2wHlIMswJiZIegHlJ/+w==
Received: from CH0PR03CA0414.namprd03.prod.outlook.com (2603:10b6:610:11b::32)
 by DM4PR12MB6302.namprd12.prod.outlook.com (2603:10b6:8:a4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Mon, 1 Dec
 2025 15:14:26 +0000
Received: from CH2PEPF0000009B.namprd02.prod.outlook.com
 (2603:10b6:610:11b:cafe::30) by CH0PR03CA0414.outlook.office365.com
 (2603:10b6:610:11b::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.17 via Frontend Transport; Mon,
 1 Dec 2025 15:13:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF0000009B.mail.protection.outlook.com (10.167.244.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Mon, 1 Dec 2025 15:14:26 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 1 Dec
 2025 07:14:01 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 1 Dec
 2025 07:14:01 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 1 Dec
 2025 07:13:57 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
	"Mark Bloch" <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>
Subject: [PATCH net 1/2] net/mlx5: make enable_mpesw idempotent
Date: Mon, 1 Dec 2025 17:13:27 +0200
Message-ID: <1764602008-1334866-2-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1764602008-1334866-1-git-send-email-tariqt@nvidia.com>
References: <1764602008-1334866-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009B:EE_|DM4PR12MB6302:EE_
X-MS-Office365-Filtering-Correlation-Id: 166e4633-1709-4ab1-8ddb-08de30ec515b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hR5WzAMUHOFjvnEl5AG+ZLCjZaUx0e1LhQeV8/IwNttEK17CLay9DXlGvhk5?=
 =?us-ascii?Q?vZ1QNkqolpdZ0CZqrCq0XU4JWlXXhMeEeaxr3J6GXMYnRZi+kpPOd25opHkc?=
 =?us-ascii?Q?VyH2TQEjlBpdqfOhSpWhnMZrkM5VQXBWTHxserETaF3ldEixLcBBjxKMTy7I?=
 =?us-ascii?Q?FT7M/aaNzCemsZXAktj4GuvEWEhMJMdOHmwX/o1XI1pwLz0gHJV430PeovCO?=
 =?us-ascii?Q?0TFe616fGbferRhLtvOv0bTUq2fRdIWyPeBYExqVrZtQkgs+VrRQOHM0Z4Ak?=
 =?us-ascii?Q?34s2a0FIameMZBzMb8hEtxj3ISFhTocyMWX8s5dlAPo5YyhGWkOlwv3WUpFP?=
 =?us-ascii?Q?JKKNmOzkGHGkLANpHN82IbensA2A309i08EksB9Ky3H+KKHeA4qcpClXGMh3?=
 =?us-ascii?Q?hsRx/vNH6yt/ZgoD/rnJjtZ6PIM310glqf+Hnna6/A8pXZUR/AqQ8Ou2d67C?=
 =?us-ascii?Q?5s35FRNuQgu9neIBcZlXqXaSKTPTXQBpg54nAHToGr7CHsrFpa7oP6ZqxyaY?=
 =?us-ascii?Q?TWg/KFhyLKuuMxrdwTdF80Nibrm6yXO7OaYMPkLZ8lgJoCc+NuUdPKlxDVkO?=
 =?us-ascii?Q?MxduNNvJKoAb/4bz3ZWiB6dExCA0TmcqtXNV4t3BzYum2cCEKF8hp2wWhAzs?=
 =?us-ascii?Q?pLyatfKZp689WQr7u1hSAhu+AF0aIyJHaUv6FVbfdqcAldcT2SX++E7sB79B?=
 =?us-ascii?Q?BjbchCy3rOoISXoZvmtIrTHlNnMiMGkmY1ktdD0bZ01jHfL7FvC+E5731As1?=
 =?us-ascii?Q?K1p2Q0mhvvkmTyD6TQy9p/afezoMtyyi4DY/UZPlrJ2UJ/2GGjLhJdWIsDVG?=
 =?us-ascii?Q?fvBkfbVHslWCKU0+fUr9Gys8dC8xj9g7hMraLuvhCb75vTThTw+9Ijymu2AZ?=
 =?us-ascii?Q?/028c3ScEA4vPcudmuS48a3pyWFsyvWA2VIVC5l1yVaDxxeR7itbavouKavP?=
 =?us-ascii?Q?9UNaWVZrVp+7T/DMgJH1bEPwBQ1ygXXY2jpKmCjHyeyjzxL93rfcgO6DkycD?=
 =?us-ascii?Q?WmATtA99e45n9kNvL9mBWkrmSm+xl3CNNTHzTxMAf8J2ikT0x+2qZZ9Q0aqo?=
 =?us-ascii?Q?DMKMRPp/Zf85bPNH19oJuE0vOotaQClvxj4fOUs03WtORPTd2yyM6rJ5up5c?=
 =?us-ascii?Q?hIpydQafdFaiFz6lCzC1qhjKiUyt84CeUgDwrqa38HOK1gI1fK3hsUSc5Byi?=
 =?us-ascii?Q?eDTSG2kEQUh0qGxrwhuGfvd8/SkUP0tce7cj763RsDk4dl4XrfEniHS2V2rt?=
 =?us-ascii?Q?0qtJZDY4caeoQYxGOrSYoqfduS4A6A7uKPlh9u4DAr967CJ4RR/Oq/8wv3QS?=
 =?us-ascii?Q?uvJF5DOSDLwdKwzGk3njJM52dHF8QaxTdRugpKymXAgX6NkwrJ39mzWBADa2?=
 =?us-ascii?Q?9rnlIVgU3C9kl2mZf8WQn+k3PxN4PEgqsTv4RbdF2e9GaQeGjpPii3LogFyu?=
 =?us-ascii?Q?QH26doGqPh7Y8MLBs98TDFbMTuGp7jGdbrhoPzWeSVhJUlqGYuU4JGLO0E09?=
 =?us-ascii?Q?KC/MRFAa9lxzmr4nIK+i6wtojVd6PjoIpG2pTMfD3+crMDU7X+rxS0k699g3?=
 =?us-ascii?Q?/GFrmAqkxPkflla/tVA=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2025 15:14:26.6902
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 166e4633-1709-4ab1-8ddb-08de30ec515b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6302

From: Moshe Shemesh <moshe@nvidia.com>

The enable_mpesw() function returns -EINVAL if ldev->mode is not
MLX5_LAG_MODE_NONE. This means attempting to enable MPESW mode when it's
already enabled will fail. In contrast, disable_mpesw() properly checks
if the mode is MLX5_LAG_MODE_MPESW before proceeding, making it
naturally idempotent and safe to call multiple times.

Fix enable_mpesw() to return success if mpesw is already enabled.

Fixes: a32327a3a02c ("net/mlx5: Lag, Control MultiPort E-Switch single FDB mode")
Signed-off-by: Moshe Shemesh <moshe@nvidia.com>
Reviewed-by: Shay Drori <shayd@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/lag/mpesw.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/mpesw.c b/drivers/net/ethernet/mellanox/mlx5/core/lag/mpesw.c
index aad52d3a90e6..2d86af8f0d9b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lag/mpesw.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/mpesw.c
@@ -67,12 +67,19 @@ static int mlx5_mpesw_metadata_set(struct mlx5_lag *ldev)
 
 static int enable_mpesw(struct mlx5_lag *ldev)
 {
-	int idx = mlx5_lag_get_dev_index_by_seq(ldev, MLX5_LAG_P1);
 	struct mlx5_core_dev *dev0;
 	int err;
+	int idx;
 	int i;
 
-	if (idx < 0 || ldev->mode != MLX5_LAG_MODE_NONE)
+	if (ldev->mode == MLX5_LAG_MODE_MPESW)
+		return 0;
+
+	if (ldev->mode != MLX5_LAG_MODE_NONE)
+		return -EINVAL;
+
+	idx = mlx5_lag_get_dev_index_by_seq(ldev, MLX5_LAG_P1);
+	if (idx < 0)
 		return -EINVAL;
 
 	dev0 = ldev->pf[idx].dev;
-- 
2.31.1


