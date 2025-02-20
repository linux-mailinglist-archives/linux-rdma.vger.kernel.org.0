Return-Path: <linux-rdma+bounces-7915-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C66BA3E6CC
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Feb 2025 22:41:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00CA8423860
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Feb 2025 21:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFD7A26461D;
	Thu, 20 Feb 2025 21:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BLT/0ViE"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2066.outbound.protection.outlook.com [40.107.95.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1372641F1;
	Thu, 20 Feb 2025 21:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740087679; cv=fail; b=KFYJbSERwsKcUuFvDXki4bVCaWnH+ZLz1llVLA2yuoxB1zvZPS7aiQRcYllt9iksa1LO4SDk11jITPr848LrFoRD+bU9rtzFQg3qSpn3UCswQGA+8+rsw6Aa1ly5iAuzYgxjiQ64iSqydKCndaCFGKqByIKyZdx7jayL/gi1KkQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740087679; c=relaxed/simple;
	bh=w5GXFvsEG+Xl6V/ot1j409M1a6O8qxo+HzOGkhryEUI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XAN21NI+KrTC1Hu3b36lpJmWwilY2ywI1st+mRvNWCi6OKKl/RpkqMVOaksZFlNvxXd//rzSqcK9OayIN0AbCfI98pMuaTrCbg9Qe5locFY8mD8kiipAN67M9tvrNO/XTHQiZw0JquEssvMKaIXXI1fcSCsdOQc4ouZ3/cZDt7Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BLT/0ViE; arc=fail smtp.client-ip=40.107.95.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pKwDS5dITkxlm+qdNjDp6kLgO8cVS5Vi2KVzKYqYcvZJllL3DxthzOmEmcYyrg5hBYq6BDyGlhMLQEZDaYJFiUiRgdvWCr5iWMvFojGJL1ldVa3t2op6XuqzFJy3aDEDNRbB4za2XwnrySiVHNQkDPafynD5E3pU+KwwJ17VDJjZRL3fqgJ4jhjg2317n0p5ZkR56/OouoNYXFrj4b49wyVFAmjbrMInMJOhVJenCFqfAhlwN9rcVy8LLft7PpWj7KI54I42xm5nAOFA9JuGcfgFdd8jcKqPCrPHmW4+S7oDq2PIC2MlyuUxQtFjBoTlJ+YHxMnbivxY4TzZD+LsVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+YAicW7d9TXKxSq+M00MoqCRgdl5YteRAJC/2K8OUkI=;
 b=rEc6ablhr8DQOUmRnG5XObGRgzZsvzalZSAnv5+Y/dVBK1/tdZ/YCgiv4bubrRtfHXgIhivpOIPJnOq0lxEvVWAP7YlWHkkb/vGIkLsldoPXSjc6c72tRTsnl0cPWfwlIIt+rtGYSNx7ymxj1LmjQJdM8J6UIxYdepWo9Yv7XV9J08mgni7gj/UqFfF7TPVTTt00w5iPh7Vy/DUzTml4g/hJ6ahAF5PbiQClqT4dvEgBEZbPPABsDpKb1eqJimsNkF4Tf9S7LxhLpH4SB9RdRYfSyTcHMEuYTz/gRSDAYcwcU6bwJmCMR9GGwFGONBEeBJa8rq8xBUEWp7qasgjoig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+YAicW7d9TXKxSq+M00MoqCRgdl5YteRAJC/2K8OUkI=;
 b=BLT/0ViE/LbpMSTYrItsuMiSvh2zzSBMjdlLd3jpm8qUepfUP3cqO7onav0baageD+Pp6Us31VMfX2LnPm4QtcgC3GBGVdo/SN0NV9PffaXsKsNRkMK0YZO9+c+fiInzdYi4yk1bn2oB4SlJXK5C5zn5gPBH8lvm+ww8wj4FTyyikgYa97N+CqVvkutqcK70Kp7sJVPPoIog/PaWxoM8eGCd7OdY/pFneWkO5pu5BoGh+k4P2gh/TQTTNxDHxYVXPyrdFL1RTZRQlxsCkCcHUU+71wgXUZ+TaXyxkSzxC3LrXyrEXcv/RuPTThMp1aO3QV6am5++sef7wKaY3nQZiw==
Received: from SN4PR0501CA0013.namprd05.prod.outlook.com
 (2603:10b6:803:40::26) by DM4PR12MB5844.namprd12.prod.outlook.com
 (2603:10b6:8:67::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Thu, 20 Feb
 2025 21:41:12 +0000
Received: from SA2PEPF000015C9.namprd03.prod.outlook.com
 (2603:10b6:803:40:cafe::cd) by SN4PR0501CA0013.outlook.office365.com
 (2603:10b6:803:40::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.16 via Frontend Transport; Thu,
 20 Feb 2025 21:41:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SA2PEPF000015C9.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.11 via Frontend Transport; Thu, 20 Feb 2025 21:41:11 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 20 Feb
 2025 13:40:50 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 20 Feb 2025 13:40:49 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Thu, 20 Feb 2025 13:40:46 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: Gal Pressman <gal@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, "Saeed
 Mahameed" <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Tariq
 Toukan <tariqt@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Jianbo Liu
	<jianbol@nvidia.com>, "Leon Romanovsky" <leonro@nvidia.com>, Patrisious
 Haddad <phaddad@nvidia.com>
Subject: [PATCH net-next 2/8] net/mlx5e: Change the destination of IPSec RX SA miss rule
Date: Thu, 20 Feb 2025 23:39:52 +0200
Message-ID: <20250220213959.504304-3-tariqt@nvidia.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250220213959.504304-1-tariqt@nvidia.com>
References: <20250220213959.504304-1-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C9:EE_|DM4PR12MB5844:EE_
X-MS-Office365-Filtering-Correlation-Id: 52af04de-1197-41cc-b8ec-08dd51f74b1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JLMrh5B+Tir6U5llH13kM1D7KMe4JkkTNw4f4aOfNaYiu53UyQjOZh25s0z9?=
 =?us-ascii?Q?K8AFxjNhI5PSzn5FsU5ueTpT/xb0tHBuPo+6AeNWi/Q6H+4UUZfNLY7NSVC4?=
 =?us-ascii?Q?wv6RfNq+8clvV2g2hbAppCryCOpnI0iDqwN2Aomoh0QfaTTRNwdZN6qhslpr?=
 =?us-ascii?Q?/UuZzuvqOl/SWyo9fM4rwU3ENjAGCHJKIJFeZDCeScuMeykLImQQbMabCv08?=
 =?us-ascii?Q?19ZZwHBloEz2EI5JIqOzfp45a6XprvisjY8W3sIryxsaBSRgQcRHsCGQGrdc?=
 =?us-ascii?Q?imrtO/zUBtlx1+EqnKDRoPrDOufBRtEaYa3iUf11GwnFU/0wBP4B9FQ7umBP?=
 =?us-ascii?Q?shRSmHJj1rWUqjsvbPRJaJzz3FfirMAnUy1xMmrnJHCt7TIVtMmxF8/+r6Pi?=
 =?us-ascii?Q?YtEkTWXjHrDXeV647zD+Pe7l9wnY3s6ceTxJCy9VcMf9Shs3tF0XPCYHLIaQ?=
 =?us-ascii?Q?Q3rAJunpNV85ctC+nWl4ahCSfeoE+HNBWTC8GTW+NyvmmwKq9ZIm9ApSjZj7?=
 =?us-ascii?Q?HWM8SIFg4a3E1RyQ7vmW2ZLWe7cEBYzFe/WKSHfIGHo+N5w6IYqFXpgQiEC5?=
 =?us-ascii?Q?7evwBR8K85XiGZSL/+yGKa1Os6GMFJjyPrcko0SyjLMXXcLhBijCVYomUcOx?=
 =?us-ascii?Q?FmUwd8nIilvghjZeTHvueNGN1lJKiuM+weP3CgcjrjV4m9wLkPjVFyAnkbDm?=
 =?us-ascii?Q?9zaET+4CrfrwS9gYe87gzYOJlIKSi5te4LqHeV/qXlQlxfmH6Zh84+pTKwt3?=
 =?us-ascii?Q?5id5ATZX/dssACmd5qmWo5UEasOxfB1Q9IzJxTKffOzCWOVV34E/RgePJGL2?=
 =?us-ascii?Q?CjONqTCT2yLSiTuj1wTK5RaYhcT7T89quWxzmjkpt/2h3+NTM1hUhn6obX0P?=
 =?us-ascii?Q?2H5Y+wDFOJOkXjwVKer1qh6XbzShlGA5P5FagiSquPPaWELMqbpvX5JN42Zg?=
 =?us-ascii?Q?KODKCuFrNWVvPiRFvPeHS+D/Xr+meVFjweXu/NOFR6y/gGlLRoFMPbhYwkTr?=
 =?us-ascii?Q?Nv1RCjq1yONG12fbGWqRC/kb4E17UPpkEKvyCi38ZvPqU+ReQvccYKFKd7xs?=
 =?us-ascii?Q?sm4o5pdIrWYeAZD5wLbEpzSlFjMKJR4vFaO31jB/AkD68mpbFsvTeLu3Mnsc?=
 =?us-ascii?Q?jD2DySWbTZMUhRXaInkzDMNGjA4Mt/K0uvomoNydY+wl9b0nz7NimP7pPdtd?=
 =?us-ascii?Q?2Ko53btzFDBmNBCd/bPnYz96obZowwAxWKODYdTXRzbf1nu5oMbdQxqQYJCP?=
 =?us-ascii?Q?/zn4YWcGskbbEH1o1N6jPq0zfl9IiFhdqi019kq+/c0UwXR0uncEq5ULkjql?=
 =?us-ascii?Q?HA6v//rgRlrYvNrVkfQCuhEZEvpOoOSLY2LTg1xgu3/24wmLPyG1hzN0mY0R?=
 =?us-ascii?Q?9cjQFnmqtrYdE0/kfXfuJBJlZiS6FPpBfzEOPvaYARgcCWvRGpuhkgNUOgJ+?=
 =?us-ascii?Q?JuEyAGkudvE8BFSEMRyTAiI5rPEn6Iio64kAKvnd0irVDnfhYe3pPede/9VP?=
 =?us-ascii?Q?zPn3k8TH6t8tLek=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 21:41:11.4395
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 52af04de-1197-41cc-b8ec-08dd51f74b1d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015C9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5844

From: Jianbo Liu <jianbol@nvidia.com>

For eswitch in legacy mode, the packets decrypted in RX SA table will
continue to be processed for RoCE. But this is not necessary for the
un-decrypted packets, which don't match any decryption rules but hit
the miss rule at the end of the table. So, change the destination of
miss rule to TTC default one and skip RoCE.

For eswitch in switchdev mode, the destination is unchanged.

Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
Reviewed-by: Patrisious Haddad <phaddad@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../mellanox/mlx5/core/en_accel/ipsec_fs.c    | 20 ++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c
index 7f82d530d3e1..7c9fdea21366 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c
@@ -498,7 +498,6 @@ static void ipsec_rx_update_default_dest(struct mlx5e_ipsec_rx *rx,
 					 struct mlx5_flow_destination *new_dest)
 {
 	mlx5_modify_rule_destination(rx->status.rule, new_dest, old_dest);
-	mlx5_modify_rule_destination(rx->sa.rule, new_dest, old_dest);
 }
 
 static void handle_ipsec_rx_bringup(struct mlx5e_ipsec *ipsec, u32 family)
@@ -658,6 +657,20 @@ static int ipsec_rx_status_pass_dest_get(struct mlx5e_ipsec *ipsec,
 	return 0;
 }
 
+static void ipsec_rx_sa_miss_dest_get(struct mlx5e_ipsec *ipsec,
+				      struct mlx5e_ipsec_rx *rx,
+				      struct mlx5e_ipsec_rx_create_attr *attr,
+				      struct mlx5_flow_destination *dest,
+				      struct mlx5_flow_destination *miss_dest)
+{
+	if (rx == ipsec->rx_esw)
+		*miss_dest = *dest;
+	else
+		*miss_dest =
+			mlx5_ttc_get_default_dest(attr->ttc,
+						  family2tt(attr->family));
+}
+
 static void ipsec_rx_ft_connect(struct mlx5e_ipsec *ipsec,
 				struct mlx5e_ipsec_rx *rx,
 				struct mlx5e_ipsec_rx_create_attr *attr)
@@ -672,8 +685,8 @@ static void ipsec_rx_ft_connect(struct mlx5e_ipsec *ipsec,
 static int rx_create(struct mlx5_core_dev *mdev, struct mlx5e_ipsec *ipsec,
 		     struct mlx5e_ipsec_rx *rx, u32 family)
 {
+	struct mlx5_flow_destination dest[2], miss_dest;
 	struct mlx5e_ipsec_rx_create_attr attr;
-	struct mlx5_flow_destination dest[2];
 	struct mlx5_flow_table *ft;
 	u32 flags = 0;
 	int err;
@@ -709,7 +722,8 @@ static int rx_create(struct mlx5_core_dev *mdev, struct mlx5e_ipsec *ipsec,
 	}
 	rx->ft.sa = ft;
 
-	err = ipsec_miss_create(mdev, rx->ft.sa, &rx->sa, dest);
+	ipsec_rx_sa_miss_dest_get(ipsec, rx, &attr, &dest[0], &miss_dest);
+	err = ipsec_miss_create(mdev, rx->ft.sa, &rx->sa, &miss_dest);
 	if (err)
 		goto err_fs;
 
-- 
2.45.0


