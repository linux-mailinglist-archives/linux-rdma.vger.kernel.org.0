Return-Path: <linux-rdma+bounces-7921-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D500EA3E6E4
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Feb 2025 22:44:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 364CF7024E5
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Feb 2025 21:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D56DD2641F8;
	Thu, 20 Feb 2025 21:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="i6d/Dps4"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2055.outbound.protection.outlook.com [40.107.237.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9718268FDA;
	Thu, 20 Feb 2025 21:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740087694; cv=fail; b=Nxk9STaQ/av10RAz4By8g0+sr/UkBUaSBm2YFwLRs1IPLOrzGGvCex9ccXpXgKIVjsxfppvWV0hScHXqz67UhhVsXuJ7NOIM2yj2Ot/QqWIYzc6Z5Qq2FvGuGpxRR1D3vjawaFRb/aRyDVDFj5uh4xtLicoiZ+SjQ+xn8uS7/KE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740087694; c=relaxed/simple;
	bh=6i7h83kp6WTUIE77LtRFqL3IpVs0+dSt+94JokTJ9do=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BBI2Kpp0tKyLWuph9Q3cEYIk3WzaWR1nDoNBEP+/U1ZqVTzL9PHEYlpIIZsTomGWmOI6uAOgPZP3sMY9Zh7cvw8sJW/Ff2gFhQhQR7e4E+tEj9+12JOQNq+FmVMgxGB3aO5OO2XPYmdc+bFgAFlFnlw/dbo/76cn2HF9m8nyHOs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=i6d/Dps4; arc=fail smtp.client-ip=40.107.237.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K4hul8ddw5wAnqYdRWT2wfbzAqv4APhW/N8/OCXurLPPeE7iuAPwNXwEOcpt06onGFL8eB3qukjQtUgWSsHasc4g9tPMTM8Rd5Fc2KZuEATN7QExyXEwt5XA7KO/tj3oOuw61U5pWYQaz3wzJNZisJWRj89wJZaRrKYJ7GxFuLayeoRCnU0gbMvqFfF62PBM6KTGBFw8e4QPtT8Ru6gX6pf+N1i+sIMJYBi1sULrPHwQ38QuBZoX+ktWj6VmlqSelPUzt8jWLcGw3mbN3B0hYm7F6Z+/WpnUO8XfOBu4YujFvZsYwTDs8uDF4P+SxB8LTWZ1GU1igAzMQ0trYxaUfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IYXmslkJKvzcnPI8xGD6iggeJRw/HbzJZy/WyASVFso=;
 b=LrgDd7r+nv/g06tXr7mFL6M/T/Iff3lPXLsArOD3ON8MxM5xP1W4S1ik9qNMS+XohY01uEAF01zueUQQKNxmw7QlHdmuv6DubA95U6Z4cbUixCQVBcWY+TZEf0po4odoK2lAgz3TSAqOT/K3K4ntPrOWbOnB7ExwglKx8OYJ1xHyqmYHbvede3iHDL+EfHEEe/i+zKqKFZOY6tdnli1qZ/UmPzPgmuXJ2pO4TZN92xguqDBGgACVpU+/5g3uiESD+Jf/YwoWE2djb4IJSb11O4UE+ytXW6YGbfNy1XVuDdEV+2VfDRThZY/VULg2cGNqz3cTt8OSQEzuHb79owLVNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IYXmslkJKvzcnPI8xGD6iggeJRw/HbzJZy/WyASVFso=;
 b=i6d/Dps4yDutQDa3B/qJND5sGdFjPuFbVdAlpkB8GKwsTEdPfQC0IqejS6+qKR6/VrCDA87Tc74Ohw5FGe9m3LwCjOc5iyOTN5tIof8EwIInzo3aIoAd7etrjxE8DViXAkAUVqyXuaWp0E/TqAvSWgWbe8W4tgZNsa0sK5OjBs9iPP9FiaRvMh0yqzYayEKNAUS3vANtfsIAZE25Wj3Fx8CV7IiGKnflOCCAZE1bN6OIpAmeD1TJDVHWBpYsxw98JHI9e3gUaNJd/9dInrZa7lmPbP5kmww75rPoJ3QAYg/QXNy7nYhE7+fwVriGxmJbY3e+tCD0+J+Et8GYBt9FNg==
Received: from SN4PR0501CA0012.namprd05.prod.outlook.com
 (2603:10b6:803:40::25) by PH7PR12MB6810.namprd12.prod.outlook.com
 (2603:10b6:510:1b4::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Thu, 20 Feb
 2025 21:41:27 +0000
Received: from SA2PEPF000015C9.namprd03.prod.outlook.com
 (2603:10b6:803:40:cafe::1e) by SN4PR0501CA0012.outlook.office365.com
 (2603:10b6:803:40::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.15 via Frontend Transport; Thu,
 20 Feb 2025 21:41:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SA2PEPF000015C9.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.11 via Frontend Transport; Thu, 20 Feb 2025 21:41:26 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 20 Feb
 2025 13:41:09 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 20 Feb 2025 13:41:09 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Thu, 20 Feb 2025 13:41:05 -0800
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
Subject: [PATCH net-next 7/8] net/mlx5e: Add pass flow group for IPSec RX status table
Date: Thu, 20 Feb 2025 23:39:57 +0200
Message-ID: <20250220213959.504304-8-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C9:EE_|PH7PR12MB6810:EE_
X-MS-Office365-Filtering-Correlation-Id: fa35dd46-73ce-4651-f36d-08dd51f7544e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DKXyg+5TtpIZyXoLletWDm8KDGQewW8pHFg+++dTVRnAvgLEl2R0hSK9tBVa?=
 =?us-ascii?Q?3qDSo0ejGxkqpXwN2APdeWodYzbqtbBRvbN8VLoTywuPNcGKxV+vHnACEf//?=
 =?us-ascii?Q?1y5fCawTZZoBNq9wssyvb/9QUf73pKet+uAohf3imXtMmFy0H36arXsjUfa+?=
 =?us-ascii?Q?Xyw2dJNHnbdeBoo4Y5ww+XepykWUk15KWbScdkjLcz00HJKiagCfCCJDLvt7?=
 =?us-ascii?Q?PvCbBknTh+GpJ9hO7sbxGK5aNjUD+d+tiWkrBshN8MEYlsnN6xQx6hFfywwC?=
 =?us-ascii?Q?3b+/W/7/IvyfO+MayIwYmzrsVnB7Y4w8d7xH/og44GQjp4dTWg6lrYcvf51J?=
 =?us-ascii?Q?Qc0kBdFiaRMafD5Ti0PcQP0pYsJquOl0YaEAsRz3W0WFgyzkhVzagfaoSFeA?=
 =?us-ascii?Q?UehTmnbuSqPGuTNm3J7zYBHWu1kkK7WZJ9OI2U+leFVwBbuY7JQPzS4VE07H?=
 =?us-ascii?Q?ip4AaTlzWq1nQZSWvTNZ4FWzIHdZfLJS2vQhTCdbu7tE2zJB+F+htfnivDGi?=
 =?us-ascii?Q?TtN+Gdy0HnvYhX9sb6prTXsS2oH8osCuCgv2lSkhP9JXKH7gyRvj3cbxMt9x?=
 =?us-ascii?Q?lXPdkoZCQQcmJ9A2PeSkO8Fi2xU79DdkqUSMWLSrTuq+mLnm5y5NmjCoTWA+?=
 =?us-ascii?Q?uvclhkRHPE4Jc3diH+J2u+S9FM8ibgfSgd0seexfQrpT7jd04HBxb+AI7iJa?=
 =?us-ascii?Q?mJelm7YNTeARzhAVrc2Cw+OC+8QI3tRRc7p6Jx6lYn/yfqvaGxLLcq4GtHE7?=
 =?us-ascii?Q?HvrZJFBZsh2+IQ7LyWxIcVtLGY+O/D7gX4Q3Zh2x1pD0XFXKiDhE27RF3Wln?=
 =?us-ascii?Q?MgzqX0LixDlu5DLE4Axw+klPvkHDviindA3x8bCdgq76Zkg8/eTORk7HqPEE?=
 =?us-ascii?Q?ZsZwX4YGHdFDa8K0aKm/8LSNDc3chN42D3ar7DbRVsTUKn7N+9glVarmBItl?=
 =?us-ascii?Q?F+UEU+J1dSC+D+h5vGFWz8UhtQY4DO9ZXrFnu/9T+xt7nUz3Uky3gJ+QrIu7?=
 =?us-ascii?Q?1rsejFRxyo04GJwHaW6lU+f6s3ws3SMwZBY/h1LE/su9S80FnvJyl5EF8E17?=
 =?us-ascii?Q?TZnWabSnDceI9wKLxMBbmwGFOJcGGQYFQudkWuxsjC5DTZWb0CnL3lfH4cR6?=
 =?us-ascii?Q?u4QFs++0hOpD9zGjS+s0e7MXdbWZgoEqrRa6qUl+GSZO0OuX6bRmoAiFHxe/?=
 =?us-ascii?Q?5xNl1oN+rpe3rhHWS8mIniwegTvNhVmk5al3/zgJwb5Sdv6utVKEajUmbd6A?=
 =?us-ascii?Q?RzNyZxRZAY5/hBd+JIo+JvN4oLb/77wsM27rG+IO5waXVjn2jforrasaJPHP?=
 =?us-ascii?Q?HYCJiL//U/AdamIeUsHSyV/Cseb74Tiu+rev9ZCiKpV1J11iKaKV1kaa2MSS?=
 =?us-ascii?Q?44HSdguocX3E8nrdEKGtN0uOVvwx0SIQcQgdBcY46EerJjuh9YcBW3qde6Z1?=
 =?us-ascii?Q?8ZoR6r10JVyZSQzILHjYz7RCNdnub1yWmaul0rhEHAp/uu9VJP9rwlDyLdKV?=
 =?us-ascii?Q?61DZvwz8oPxfMZA=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 21:41:26.8460
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa35dd46-73ce-4651-f36d-08dd51f7544e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015C9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6810

From: Jianbo Liu <jianbol@nvidia.com>

This flow group is added for the pass rules for both crypto offload
and packet offload. It is placed at the end of the table, and right
before the miss group. There are two entries, and the default pass
rules for both offloads are added in this group.

Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
Reviewed-by: Patrisious Haddad <phaddad@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../mellanox/mlx5/core/en_accel/ipsec_fs.c    | 51 ++++++++++++++++++-
 1 file changed, 50 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c
index 2ee4c7bfd7e6..840d9e0514d3 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c
@@ -41,6 +41,7 @@ struct mlx5e_ipsec_tx {
 };
 
 struct mlx5e_ipsec_status_checks {
+	struct mlx5_flow_group *pass_group;
 	struct mlx5_flow_handle *packet_offload_pass_rule;
 	struct mlx5_flow_handle *crypto_offload_pass_rule;
 	struct mlx5_flow_group *drop_all_group;
@@ -397,6 +398,47 @@ static int ipsec_rx_status_drop_all_create(struct mlx5e_ipsec *ipsec,
 	return err;
 }
 
+static int ipsec_rx_status_pass_group_create(struct mlx5e_ipsec *ipsec,
+					     struct mlx5e_ipsec_rx *rx)
+{
+	int inlen = MLX5_ST_SZ_BYTES(create_flow_group_in);
+	struct mlx5_flow_table *ft = rx->ft.status;
+	struct mlx5_flow_group *fg;
+	void *match_criteria;
+	u32 *flow_group_in;
+	int err = 0;
+
+	flow_group_in = kvzalloc(inlen, GFP_KERNEL);
+	if (!flow_group_in)
+		return -ENOMEM;
+
+	MLX5_SET(create_flow_group_in, flow_group_in, match_criteria_enable,
+		 MLX5_MATCH_MISC_PARAMETERS_2);
+	match_criteria = MLX5_ADDR_OF(create_flow_group_in, flow_group_in,
+				      match_criteria);
+	MLX5_SET_TO_ONES(fte_match_param, match_criteria,
+			 misc_parameters_2.ipsec_syndrome);
+	MLX5_SET_TO_ONES(fte_match_param, match_criteria,
+			 misc_parameters_2.metadata_reg_c_4);
+
+	MLX5_SET(create_flow_group_in, flow_group_in,
+		 start_flow_index, ft->max_fte - 3);
+	MLX5_SET(create_flow_group_in, flow_group_in,
+		 end_flow_index, ft->max_fte - 2);
+
+	fg = mlx5_create_flow_group(ft, flow_group_in);
+	if (IS_ERR(fg)) {
+		err = PTR_ERR(fg);
+		mlx5_core_warn(ipsec->mdev,
+			       "Failed to create rx status pass flow group, err=%d\n",
+			       err);
+	}
+	rx->status_checks.pass_group = fg;
+
+	kvfree(flow_group_in);
+	return err;
+}
+
 static struct mlx5_flow_handle *
 ipsec_rx_status_pass_create(struct mlx5e_ipsec *ipsec,
 			    struct mlx5e_ipsec_rx *rx,
@@ -446,6 +488,7 @@ static void mlx5_ipsec_rx_status_destroy(struct mlx5e_ipsec *ipsec,
 					 struct mlx5e_ipsec_rx *rx)
 {
 	ipsec_rx_status_pass_destroy(ipsec, rx);
+	mlx5_destroy_flow_group(rx->status_checks.pass_group);
 	ipsec_rx_status_drop_destroy(ipsec, rx);
 }
 
@@ -461,6 +504,10 @@ static int mlx5_ipsec_rx_status_create(struct mlx5e_ipsec *ipsec,
 	if (err)
 		return err;
 
+	err = ipsec_rx_status_pass_group_create(ipsec, rx);
+	if (err)
+		goto err_pass_group_create;
+
 	rule = ipsec_rx_status_pass_create(ipsec, rx, dest,
 					   MLX5_IPSEC_ASO_SW_CRYPTO_OFFLOAD);
 	if (IS_ERR(rule)) {
@@ -485,6 +532,8 @@ static int mlx5_ipsec_rx_status_create(struct mlx5e_ipsec *ipsec,
 err_packet_offload_pass_create:
 	mlx5_del_flow_rules(rx->status_checks.crypto_offload_pass_rule);
 err_crypto_offload_pass_create:
+	mlx5_destroy_flow_group(rx->status_checks.pass_group);
+err_pass_group_create:
 	ipsec_rx_status_drop_destroy(ipsec, rx);
 	return err;
 }
@@ -858,7 +907,7 @@ static int rx_create(struct mlx5_core_dev *mdev, struct mlx5e_ipsec *ipsec,
 	if (err)
 		return err;
 
-	ft = ipsec_ft_create(attr.ns, attr.status_level, attr.prio, 1, 3, 0);
+	ft = ipsec_ft_create(attr.ns, attr.status_level, attr.prio, 3, 3, 0);
 	if (IS_ERR(ft)) {
 		err = PTR_ERR(ft);
 		goto err_fs_ft_status;
-- 
2.45.0


