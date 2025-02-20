Return-Path: <linux-rdma+bounces-7920-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3105A3E6DD
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Feb 2025 22:43:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 003E7169348
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Feb 2025 21:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8D56268C75;
	Thu, 20 Feb 2025 21:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EpSYhbaO"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2058.outbound.protection.outlook.com [40.107.243.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90BD3267B8D;
	Thu, 20 Feb 2025 21:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740087691; cv=fail; b=JD3kqDqg5hY3d24aURKJU7r1yRV70BgVwt2UNMlP8k6lPW2bn0DAeovArJR/qpdNDMx01SNcrnkjp0uWhv2DItN6uc6OzAzn6BvaZzKqaU3h/8qw5rt291K2GJZ+MXKvnflhMUuQrfXlYfNk04ORBGsvZ9OwFFsDNlSKVFOWEP8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740087691; c=relaxed/simple;
	bh=fQRFQGlFgxzRgj1NLqBUr1WR2Mk0gQG1vX66/J9p+XM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qW9naM4U4kXGQ1PS9CXgUSYSnYrdMRiOHd3MJ+0E/Kzyb/fY0W7rc53N/ruEkoT9GV6J85WMnzaJgbEF8ORFL5t6dVHJGAtWNMc0+dOid3vEGBClyWjwELJ7FBFhvwjVKW/l9rdICSEajIo+NBbG406q9QYF8LE4bkG7q27u1mA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EpSYhbaO; arc=fail smtp.client-ip=40.107.243.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lkkR2QLU83M4W3lNgl2D+HeBbw9MWpFHNeBbfit2MyQ7TaK0XCLoTXFrscvflaqe51G5Y3pUaZUgNktIhse74zOVmLrGxHs9lULA0O0S1ZFqOE4Qjzd2NCD7jbu3NqMe01vQYTwm8zxEImZykNcDKAYv2Q+3S0+ig9XHRL2IeBSLa18PQKBRrLGxf/XwLs0P+jbM3K0s/YFCH0e/MeedokLifJr20YoZyLf4bLVlyolDaXmge0hDCSbYLEymTo2DlMO3fSngdI/EI5uuxH/1/cdulRVh6JC54hIUaljY5Dl9BCk4MVn4lnOSkfkXSpLmS47AKnwrBiUPWlpwoYQSug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PbrAGEgztVcxgS8g0kg8N4mPo35xvsMsOUvVg8qu2ZA=;
 b=h8M8UzDSMkhkRfUPsvErNLwwyeX61Ac+7sY+RoS/8n+yY/Mvnl0OXrMnEZDvGXyaatuVpyHCbLKa/KjI7s53QfTxBKa4Wszx6cZG1RodKwEZq4zNPtYuWLZFCxkLDclId5XQ8/WfBde7LmmXax/2eLfXx9L+5ZCMos80OK7NaBFTNcJQ3ELu79yuqSAcr2N4neLNBIC3CXFhAh16v60YHiOmLPJib57ZNaoOMZckVtQdUdcHVxKNkJLIKaWaFgXhWqyuUmLErZgGLPZsYipsh6hfeozLKiP2Jnf6o6TT+MWQEk7t1SEwc/hfxJcF/hNCdyZdvlpu4e4biGqnYqVztA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PbrAGEgztVcxgS8g0kg8N4mPo35xvsMsOUvVg8qu2ZA=;
 b=EpSYhbaOOr9ME4SFl1TIv8SGQHYpOCoXO31XLGe0HJUOuiIh5YjitZ3uWr+1nb+pgiuDZRNZkWMUmhccQ9wfbSANN5B5Rljpjo5jIj3By3FZxVx/OJQLJYEjtO8HqlBS3wzunH0PIHxj/zWMvv3WGnMaNRuXWcJJv5GD0WzLm+F99gBa9DigtaXvcXtZ0oV1WwXh+fqC3TWvNC0v/tGIWMOc/m4e0WvFZNI1zLtPpu0IeOs+dV9/Hg64L0LJs59J4bhpYwkZnRPiUE8VhV55FbsnfV12rhXGnvJ0Cnm973a14RKIFVZ8St0Lvs+/dIIgPaHxuWaEg5JyzJddvLac1g==
Received: from SA1P222CA0048.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:2d0::23)
 by CY8PR12MB7636.namprd12.prod.outlook.com (2603:10b6:930:9f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Thu, 20 Feb
 2025 21:41:16 +0000
Received: from SN1PEPF0002636D.namprd02.prod.outlook.com
 (2603:10b6:806:2d0:cafe::5f) by SA1P222CA0048.outlook.office365.com
 (2603:10b6:806:2d0::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.14 via Frontend Transport; Thu,
 20 Feb 2025 21:41:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SN1PEPF0002636D.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.11 via Frontend Transport; Thu, 20 Feb 2025 21:41:16 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 20 Feb
 2025 13:41:01 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 20 Feb 2025 13:41:01 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Thu, 20 Feb 2025 13:40:57 -0800
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
Subject: [PATCH net-next 5/8] net/mlx5e: Skip IPSec RX policy check for crypto offload
Date: Thu, 20 Feb 2025 23:39:55 +0200
Message-ID: <20250220213959.504304-6-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636D:EE_|CY8PR12MB7636:EE_
X-MS-Office365-Filtering-Correlation-Id: c6d01fe0-c915-4b9c-03ee-08dd51f74dfb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NM0lTgnSysIYAq+jmYA4+RN6EcA3eriJgsM1491nJ8rU5f537XHcfhhFd6cc?=
 =?us-ascii?Q?ftDaqS5nHYhObOVZ9GGsXy/8yx7PzlT+9aV4SqN+J8lrWAqcvYsN6HbOGt6f?=
 =?us-ascii?Q?PZBZQZE0oh/u3zFH1orc8gP2H7AEq8c2flzZZw8p/ctPjGPkccIG3OFJbBlO?=
 =?us-ascii?Q?6DDbACA6C+T33WFp8C3RjR0NRxPmJjjz+vdbBYaIXiQVtQ6O7Tm7zKlsXfhJ?=
 =?us-ascii?Q?BMQnsm/NJgK5gGVgSJ/yvSPa8rowzUtenrMbpydRiC3R1LeTNXiwealNnA5X?=
 =?us-ascii?Q?MwABbSYSE11nR6d64/ZwnaGC12O2/K6GXOpm/ZJmmbGE3D17HZZQGaZoeUsx?=
 =?us-ascii?Q?iy/j2CHCkyQI5hZuhgH3k81mbtCX0VatT3g9hhS0d69tQpZCBqq/3Nh3lXu3?=
 =?us-ascii?Q?cI/JQmfcBFZTSiLFomm/ceO/eO9LjBX0nK/yVXYZ56SZXylwIlEopX7IOqmP?=
 =?us-ascii?Q?0TAhIC2qRP+sBh9pd01upXsddkyhy7KPlaO7GtBlo4U5LGeLuz0DZv+RCzUH?=
 =?us-ascii?Q?w5b/KP2kKQby+Dm0umSBZxf3b63vBfpuQaiEWEyIesxkpPdFq5+P3Ox6TLzZ?=
 =?us-ascii?Q?VYkZVytrfpKdfM/Ko/3YjjrewP0XQ+YoKdL4CJmnn9RfeMLtlSZwPgE0FZif?=
 =?us-ascii?Q?TzqYapUvrj/JPt+epr9W9r1LITNIHAuo7zAWnrqgdqQozXEs0/nCsSCC/H8a?=
 =?us-ascii?Q?0pRnXZRT6iC/si95N8iMoEpNBtqIvyd7Yzng+NCxkUt27qBztyaob1SGjV1/?=
 =?us-ascii?Q?EgvkomgCzYzcBhvg6sB91DLb5S7vmw54h3FPwGyDbsXo8+9j/37bjpiX39e3?=
 =?us-ascii?Q?ORGhl2KUvrpiUsWBtgddjIyxQ7ejJ8i6v+13zVx3bztKYNc+GzntXtqBqeXJ?=
 =?us-ascii?Q?3vqwizwABYCxISVpKedO2M2L1/8NQb6Gok3Ali6zv1Egh2WQqsE8akwGf+Xn?=
 =?us-ascii?Q?qBCgUIGr5GAdHEV/w0p1CONY6SLuNTi9WNY0sLTBLpZ9tQuhOdeEziEboE4y?=
 =?us-ascii?Q?NG5hvudl1hrGVCMGReS4aneHfonRyrX+qoCj4Je5nxlak02Qd4o1POe7zMRJ?=
 =?us-ascii?Q?8o0pycQOrGjUoq7PY02jxU1KQagE/041bnwLXibG/sSBDgRBpXF/gyIPzB5o?=
 =?us-ascii?Q?uahP+RFcbIdHnSBj0WZ5UtL9QWnA0Q/NbExn3igGOO+HfBrcXqlb/bzeHedp?=
 =?us-ascii?Q?OcsOtMHpRNLtAvlkEeeK8pTOSJmdORPRO1ZDTbi9OHamEs7SWwSoOUBnN4HA?=
 =?us-ascii?Q?f8DzTbg0Ajgxhks/HfHMxiB5q+Vgt5RpGnmZQpJKtn1BitXaWOHKuIsVSO+q?=
 =?us-ascii?Q?qUYyNaXLbOSILhaqzClYHkYHI9yFdoojyiuMvARWS3mLIUPgPK9c3Vq43QZ8?=
 =?us-ascii?Q?0eKCAaCNotmtqBshdhmbyoZm86uJOa2LJ5TyyRRg9IeSAIG9IsFJe6f6JXiY?=
 =?us-ascii?Q?h36qDbrC5n514EpYtUG2ulZYfCYww8mah0TqKTlzhX8RCcQzA1CfMDGjzWbQ?=
 =?us-ascii?Q?VadhnEz2+SNFA1Y=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 21:41:16.2296
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c6d01fe0-c915-4b9c-03ee-08dd51f74dfb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7636

From: Jianbo Liu <jianbol@nvidia.com>

For crypto offload, there is no xfrm policy rule offloaded to
hardware, so no need to continue with policy check for it.

Previously, for crypto offload, the hardware metadata reg c4 is not
used and not changed, but set to ASO_OK(0) before decryption to avoid
garbage data. Then a default rule is added to check ipsec_syndrome and
this register. Packets are forwarded to policy table if succeed, or
drop if fails.

According to hardware document, this register value could be 0, 1.
So a special value (0xAA), which is not used by hardware, is chosen as
an indication for crypto offload. It is set to c4 before decryption.
Then a default rule, which matches on 0xAA (and ipsec_syndrome on 0),
is added, which means packets are done by crypto offload, and
sends them to kernel directly, thus skips the policy check.

Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
Reviewed-by: Patrisious Haddad <phaddad@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../mellanox/mlx5/core/en_accel/ipsec_fs.c    | 81 +++++++++++++------
 1 file changed, 56 insertions(+), 25 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c
index 3d9d7aa2a06a..e72b365f24be 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c
@@ -16,6 +16,14 @@
 #define MLX5_REFORMAT_TYPE_ADD_ESP_TRANSPORT_SIZE 16
 #define IPSEC_TUNNEL_DEFAULT_TTL 0x40
 
+enum {
+	MLX5_IPSEC_ASO_OK,
+	MLX5_IPSEC_ASO_BAD_REPLY,
+
+	/* For crypto offload, set by driver */
+	MLX5_IPSEC_ASO_SW_CRYPTO_OFFLOAD = 0xAA,
+};
+
 struct mlx5e_ipsec_fc {
 	struct mlx5_fc *cnt;
 	struct mlx5_fc *drop;
@@ -33,6 +41,8 @@ struct mlx5e_ipsec_tx {
 };
 
 struct mlx5e_ipsec_status_checks {
+	struct mlx5_flow_handle *packet_offload_pass_rule;
+	struct mlx5_flow_handle *crypto_offload_pass_rule;
 	struct mlx5_flow_group *drop_all_group;
 	struct mlx5e_ipsec_drop all;
 };
@@ -41,8 +51,7 @@ struct mlx5e_ipsec_rx {
 	struct mlx5e_ipsec_ft ft;
 	struct mlx5e_ipsec_miss pol;
 	struct mlx5e_ipsec_miss sa;
-	struct mlx5e_ipsec_rule status;
-	struct mlx5e_ipsec_status_checks status_drops;
+	struct mlx5e_ipsec_status_checks status_checks;
 	struct mlx5e_ipsec_fc *fc;
 	struct mlx5_fs_chains *chains;
 	struct mlx5_flow_table *pol_miss_ft;
@@ -149,15 +158,16 @@ static struct mlx5_flow_table *ipsec_ft_create(struct mlx5_flow_namespace *ns,
 static void ipsec_rx_status_drop_destroy(struct mlx5e_ipsec *ipsec,
 					 struct mlx5e_ipsec_rx *rx)
 {
-	mlx5_del_flow_rules(rx->status_drops.all.rule);
-	mlx5_fc_destroy(ipsec->mdev, rx->status_drops.all.fc);
-	mlx5_destroy_flow_group(rx->status_drops.drop_all_group);
+	mlx5_del_flow_rules(rx->status_checks.all.rule);
+	mlx5_fc_destroy(ipsec->mdev, rx->status_checks.all.fc);
+	mlx5_destroy_flow_group(rx->status_checks.drop_all_group);
 }
 
 static void ipsec_rx_status_pass_destroy(struct mlx5e_ipsec *ipsec,
 					 struct mlx5e_ipsec_rx *rx)
 {
-	mlx5_del_flow_rules(rx->status.rule);
+	mlx5_del_flow_rules(rx->status_checks.packet_offload_pass_rule);
+	mlx5_del_flow_rules(rx->status_checks.crypto_offload_pass_rule);
 }
 
 static void ipsec_rx_rule_add_match_obj(struct mlx5e_ipsec_sa_entry *sa_entry,
@@ -368,9 +378,9 @@ static int ipsec_rx_status_drop_all_create(struct mlx5e_ipsec *ipsec,
 		goto err_rule;
 	}
 
-	rx->status_drops.drop_all_group = g;
-	rx->status_drops.all.rule = rule;
-	rx->status_drops.all.fc = flow_counter;
+	rx->status_checks.drop_all_group = g;
+	rx->status_checks.all.rule = rule;
+	rx->status_checks.all.fc = flow_counter;
 
 	kvfree(flow_group_in);
 	kvfree(spec);
@@ -386,9 +396,11 @@ static int ipsec_rx_status_drop_all_create(struct mlx5e_ipsec *ipsec,
 	return err;
 }
 
-static int ipsec_rx_status_pass_create(struct mlx5e_ipsec *ipsec,
-				       struct mlx5e_ipsec_rx *rx,
-				       struct mlx5_flow_destination *dest)
+static struct mlx5_flow_handle *
+ipsec_rx_status_pass_create(struct mlx5e_ipsec *ipsec,
+			    struct mlx5e_ipsec_rx *rx,
+			    struct mlx5_flow_destination *dest,
+			    u8 aso_ok)
 {
 	struct mlx5_flow_act flow_act = {};
 	struct mlx5_flow_handle *rule;
@@ -397,7 +409,7 @@ static int ipsec_rx_status_pass_create(struct mlx5e_ipsec *ipsec,
 
 	spec = kvzalloc(sizeof(*spec), GFP_KERNEL);
 	if (!spec)
-		return -ENOMEM;
+		return ERR_PTR(-ENOMEM);
 
 	MLX5_SET_TO_ONES(fte_match_param, spec->match_criteria,
 			 misc_parameters_2.ipsec_syndrome);
@@ -406,7 +418,7 @@ static int ipsec_rx_status_pass_create(struct mlx5e_ipsec *ipsec,
 	MLX5_SET(fte_match_param, spec->match_value,
 		 misc_parameters_2.ipsec_syndrome, 0);
 	MLX5_SET(fte_match_param, spec->match_value,
-		 misc_parameters_2.metadata_reg_c_4, 0);
+		 misc_parameters_2.metadata_reg_c_4, aso_ok);
 	if (rx == ipsec->rx_esw)
 		spec->flow_context.flow_source = MLX5_FLOW_CONTEXT_FLOW_SOURCE_UPLINK;
 	spec->match_criteria_enable = MLX5_MATCH_MISC_PARAMETERS_2;
@@ -421,13 +433,12 @@ static int ipsec_rx_status_pass_create(struct mlx5e_ipsec *ipsec,
 		goto err_rule;
 	}
 
-	rx->status.rule = rule;
 	kvfree(spec);
-	return 0;
+	return rule;
 
 err_rule:
 	kvfree(spec);
-	return err;
+	return ERR_PTR(err);
 }
 
 static void mlx5_ipsec_rx_status_destroy(struct mlx5e_ipsec *ipsec,
@@ -441,19 +452,38 @@ static int mlx5_ipsec_rx_status_create(struct mlx5e_ipsec *ipsec,
 				       struct mlx5e_ipsec_rx *rx,
 				       struct mlx5_flow_destination *dest)
 {
+	struct mlx5_flow_destination pol_dest[2];
+	struct mlx5_flow_handle *rule;
 	int err;
 
 	err = ipsec_rx_status_drop_all_create(ipsec, rx);
 	if (err)
 		return err;
 
-	err = ipsec_rx_status_pass_create(ipsec, rx, dest);
-	if (err)
-		goto err_pass_create;
+	rule = ipsec_rx_status_pass_create(ipsec, rx, dest,
+					   MLX5_IPSEC_ASO_SW_CRYPTO_OFFLOAD);
+	if (IS_ERR(rule)) {
+		err = PTR_ERR(rule);
+		goto err_crypto_offload_pass_create;
+	}
+	rx->status_checks.crypto_offload_pass_rule = rule;
+
+	pol_dest[0].type = MLX5_FLOW_DESTINATION_TYPE_FLOW_TABLE;
+	pol_dest[0].ft = rx->ft.pol;
+	pol_dest[1] = dest[1];
+	rule = ipsec_rx_status_pass_create(ipsec, rx, pol_dest,
+					   MLX5_IPSEC_ASO_OK);
+	if (IS_ERR(rule)) {
+		err = PTR_ERR(rule);
+		goto err_packet_offload_pass_create;
+	}
+	rx->status_checks.packet_offload_pass_rule = rule;
 
 	return 0;
 
-err_pass_create:
+err_packet_offload_pass_create:
+	mlx5_del_flow_rules(rx->status_checks.crypto_offload_pass_rule);
+err_crypto_offload_pass_create:
 	ipsec_rx_status_drop_destroy(ipsec, rx);
 	return err;
 }
@@ -506,7 +536,9 @@ static void ipsec_rx_update_default_dest(struct mlx5e_ipsec_rx *rx,
 					 struct mlx5_flow_destination *old_dest,
 					 struct mlx5_flow_destination *new_dest)
 {
-	mlx5_modify_rule_destination(rx->status.rule, new_dest, old_dest);
+	mlx5_modify_rule_destination(rx->pol_miss_rule, new_dest, old_dest);
+	mlx5_modify_rule_destination(rx->status_checks.crypto_offload_pass_rule,
+				     new_dest, old_dest);
 }
 
 static void handle_ipsec_rx_bringup(struct mlx5e_ipsec *ipsec, u32 family)
@@ -853,8 +885,6 @@ static int rx_create(struct mlx5_core_dev *mdev, struct mlx5e_ipsec *ipsec,
 	if (err)
 		goto err_policy;
 
-	dest[0].type = MLX5_FLOW_DESTINATION_TYPE_FLOW_TABLE;
-	dest[0].ft = rx->ft.pol;
 	dest[1].type = MLX5_FLOW_DESTINATION_TYPE_COUNTER;
 	dest[1].counter = rx->fc->cnt;
 	err = mlx5_ipsec_rx_status_create(ipsec, rx, dest);
@@ -1464,7 +1494,8 @@ static int setup_modify_header(struct mlx5e_ipsec *ipsec, int type, u32 val, u8
 				 MLX5_ACTION_TYPE_SET);
 			MLX5_SET(set_action_in, action[2], field,
 				 MLX5_ACTION_IN_FIELD_METADATA_REG_C_4);
-			MLX5_SET(set_action_in, action[2], data, 0);
+			MLX5_SET(set_action_in, action[2], data,
+				 MLX5_IPSEC_ASO_SW_CRYPTO_OFFLOAD);
 			MLX5_SET(set_action_in, action[2], offset, 0);
 			MLX5_SET(set_action_in, action[2], length, 32);
 		}
-- 
2.45.0


