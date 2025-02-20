Return-Path: <linux-rdma+bounces-7918-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 798BBA3E6D5
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Feb 2025 22:42:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3DB119C471E
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Feb 2025 21:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6219E267715;
	Thu, 20 Feb 2025 21:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Kn4rR1RJ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2046.outbound.protection.outlook.com [40.107.92.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6608426563A;
	Thu, 20 Feb 2025 21:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740087686; cv=fail; b=tgVMGz0Lv9qhdwoDgEbwTKpCqfWObfqweegKEmIkjPhfrUG5GvTq+mLE0i3HoK4G0EwGZ7htloknG17UAgp35X16rCiPrU96iEun7qXqOV+tMbaG7mEwA7ycPUFsAl8GYSwxCQiO1FQEbH4QIbK93001bmHgBbiwSA09ScK6d2A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740087686; c=relaxed/simple;
	bh=erM8CNbM16ycYctp/oRcO9uSbJrwN0zxEcxiqzld5a0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mG3t4z4gKPbQR83XCT77VnmgsWpQ8O7x84wj//DykKyj5fgav/AJYFsNhJcw+TmMEgnKZXrUAswn4C9Bm+0UCqqlCFw8D/YNThZjz3IJVirtQ1FElKZFAdua9MTYc3oVVlkxI4Tl1q03kVuZyhgx17wcv40LbSybb0hUKvrNQO0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Kn4rR1RJ; arc=fail smtp.client-ip=40.107.92.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oaQ6/Tmg8eT6KvKXPnRjxy6b+teffCKnzgmX8s1o71ZeZwLFUrMGG7hGh22sQMMj6eBssWIjgh7hpLV1rKzPeJ/8cArN2wBn5+RG6ayL4bCDo0f8G02puyNUN1uCdxXTidfbj3Og7qO95d0pu5SX+/7ZLhqbRIF47mmRKEuQtuCE7bCYVbOfwIBmdc13OKnJFPq+q8TbYXOyhUk/sAZ4W5gbRfoUiEsu990QO4rHQv7nAUlRLPHAqU5n/y0WQQv0sAr2zsZLv0yGR7xqZdznRUJUGJeyzy2EuJ2sXWQQPih2sLB2NVXo3cUOrZW+ynTDSSiCz+Q8y+qLG+IVxK5s6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iJNX69m5adtbcsPQIdOzgJJPAFaEUx/D2C6hJnDShTQ=;
 b=u0TLmQXrKs+JoAB8TKuV5N33Fyj0bDEhrPeBIEWc3UsSDdSHAxYsHul7urJ3lyh7niQ/nG9xLmy/amuFNZ2jPbjIVGJqr+ZkhWGvrieWYAyh/FHqpkfaPwnMvqMfh51MjlW7UAg9iS5tSh26DG0lhieW3a2T7Jldf20YDOOkMZpTGzV0JbYjkd97OLPiLUoeZ+JP6m8E0XXmU61NZTLdx4gYhHa62xbvHK8aq16gkdYDXZbaqAgKZKrLau46lhp0h4G9nnz8tsQtracuIfUxiChQsSVq1IISSJx5cV9YyywkwiCH86ex0OPCOEqQBPznpVBtq0bBNUjD2cd8G81ybw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iJNX69m5adtbcsPQIdOzgJJPAFaEUx/D2C6hJnDShTQ=;
 b=Kn4rR1RJ5oDijRlttxmTRH6TCfZlZQU6376uC/UZU1vep5OhKQR23e+8+eiuLQEAV29tmGEe4B1qA7d+S8aLlpVu+Le50P2TuX+fAmagFQC6R73djcQL7FJETuCCSLwkAUXSrHG+mhpAJJ1k+CPLF30LQ7ermRNo2fcbl+zjD11skvAV7TtMr0DAv34VuHKDf5K0mPo5KbubgvsioksC6yf+nBzOrdVjON29bBsEC6r6sCf51bHWtuuvkuXKvFhshfAtHpTewOtFXr0jyvLpA20sk+u7+S7xlfi5m/ZHwKGpKjdMgtl+Ny+2ZIIngafxXAsq5qAplXb+sYAkQT80Cg==
Received: from SA1P222CA0047.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:2d0::20)
 by DM6PR12MB4252.namprd12.prod.outlook.com (2603:10b6:5:211::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Thu, 20 Feb
 2025 21:41:12 +0000
Received: from SN1PEPF0002636D.namprd02.prod.outlook.com
 (2603:10b6:806:2d0:cafe::d0) by SA1P222CA0047.outlook.office365.com
 (2603:10b6:806:2d0::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.14 via Frontend Transport; Thu,
 20 Feb 2025 21:41:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SN1PEPF0002636D.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.11 via Frontend Transport; Thu, 20 Feb 2025 21:41:11 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 20 Feb
 2025 13:40:54 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 20 Feb 2025 13:40:53 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Thu, 20 Feb 2025 13:40:50 -0800
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
Subject: [PATCH net-next 3/8] net/mlx5e: Add correct match to check IPSec syndromes for switchdev mode
Date: Thu, 20 Feb 2025 23:39:53 +0200
Message-ID: <20250220213959.504304-4-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636D:EE_|DM6PR12MB4252:EE_
X-MS-Office365-Filtering-Correlation-Id: 34724b51-f1fc-4d65-60e1-08dd51f74b0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SHMwmAWPSBRWkRSvu05Hn9fgJ2e0Dx6z3DQ6Zs/CYi5VXmqvlztAoYW1WaBm?=
 =?us-ascii?Q?JiGPgD2jg+xN6yOP5hquhaCCXwjgzN7643DimCAIzS7uTEaJ/bOUAfXYM4Or?=
 =?us-ascii?Q?cVPQqnBmPy/cJES7vP8GW2kqs4JLplzTfjDUKT5IsN56UUVHsMBu3Gu2J8ko?=
 =?us-ascii?Q?Ifht5+uQPP6rT6Qwce3OvEuEF4YFO1PneqVaHkHgGaUKQn/yFNuhzZyYbA97?=
 =?us-ascii?Q?ICe3j9U8yjGrBIDbug2o45E8gmVwLdiH8Za0mCtDTOqE2eT7905MVEBuF8uB?=
 =?us-ascii?Q?2LweJuKJu4Fr8wUnLZ0eMslhZm+aDnA3T60sHEkiKGRASHKJ/8+kT6ugVhXC?=
 =?us-ascii?Q?KaFt0WA+gRH0/1v5Czg9nVRGsM7nBbYOHh838ag3obiiGf9CnCgvvgkmIQZm?=
 =?us-ascii?Q?CIDGIlDNylfbU40Ki7mgXc2hmZBaB1WFPngqgrXhJx45KRvTLPQk65HPPLlO?=
 =?us-ascii?Q?sgE4cVAdY5QoRod41eWoR6//MlNRp83I1+tS+3LT9k8SKEU00C1zXbnmgoxn?=
 =?us-ascii?Q?ar9KbPRUO4FDjOPKyC0QSvbLkR4MB/jUZ+VSTMnyWwg8tiurbYNFsklqy+sX?=
 =?us-ascii?Q?JXUOssn40S40JO1TzfVwPvBgGB5T+FLzRNJWnz/DRUDc4fPxQwJwkrQd7de1?=
 =?us-ascii?Q?7qxhpvcQ3c+IUIYrBge3QY+5kF7/FKsDYIL2s/QzuTXeXBIRhYscnjgz7ngb?=
 =?us-ascii?Q?lfJvEzFFdYtbmBUaQ9GAk86/Ksq2LozW6wTItQGwNAe1f+2lNAVyCY97D/YT?=
 =?us-ascii?Q?uxxaSzhSs2J80nYjA6SIQSty8eK7tS4f58O3SBcJi+BPU+PfPxO+5jTFmnRF?=
 =?us-ascii?Q?OGSyYc72MN1GEQtQaL9AXbLA5up8CJOulSIbsFt0C1FxD+DKSqTQXH/MOlBt?=
 =?us-ascii?Q?/0HWzGY1njseA3k85dakJlbsR0ihdMCHQJFAYl9gsNVKEiPshzZ8o3cr212F?=
 =?us-ascii?Q?QkUpKU89OOmZR2siAS5hJ62Jiyl6MKvNZBaJQ+JSXfsDXM0IB6Sck6BTFvx1?=
 =?us-ascii?Q?q+hzuN7fY1/yuNOP1oGtN6PKEiM4ED/uDL9NJUMFeKqBbGDG8VARpmXwlXSE?=
 =?us-ascii?Q?j98Ik5zpBZ+GG7KBEJQN61WuL3/V701c5vmkmaRoSs6roGsICQhTm35yDc1U?=
 =?us-ascii?Q?dTcM7kB5v7WvqCsH9O/yK33EvV/3BmOlHWRY8Nz8PP1bOC+cpMc3m4R7MwEh?=
 =?us-ascii?Q?Xvhw0BERmUc0VFAvv/j1YlzltH2a1VFVqgTyTQXZCNB+rPPlOL6s8QCIURF4?=
 =?us-ascii?Q?09R8K04FA7pBqkgerUztUw0d8uQYILmDIqqptiagENYN6WMpepbgKmTmhrf1?=
 =?us-ascii?Q?BR9qVgM2pd4Op9fs1NxD1sSlMVS5HYZ9ixU0KOd35rmmhOBgmMhDgUJcyJ29?=
 =?us-ascii?Q?MkMnl0DQDtEzyFLo9SSWEqveMz2sswEfZ30RZusi3/mcvjhFgwlwhRs2owk0?=
 =?us-ascii?Q?SUosVJE5dbQjcQB8ymHGndQfYYnSlYKxiCu8+rqZHr0ILZf9yZtMwEr0O4hQ?=
 =?us-ascii?Q?Ec5g0uhcuYBb5cQ=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 21:41:11.2765
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 34724b51-f1fc-4d65-60e1-08dd51f74b0e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4252

From: Jianbo Liu <jianbol@nvidia.com>

In commit dddb49b63d86 ("net/mlx5e: Add IPsec and ASO syndromes check
in HW"), IPSec and ASO syndromes checks after decryption for the
specified ASO object were added. But they are correct only for eswith
in legacy mode. For switchdev mode, metadata register c1 is used to
save the mapped id (not ASO object id). So, need to change the match
accordingly for the check rules in status table.

Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
Reviewed-by: Patrisious Haddad <phaddad@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../mellanox/mlx5/core/en_accel/ipsec_fs.c    | 28 ++++++++++++++-----
 .../mellanox/mlx5/core/esw/ipsec_fs.c         | 13 +++++++++
 .../mellanox/mlx5/core/esw/ipsec_fs.h         |  5 ++++
 include/linux/mlx5/eswitch.h                  |  2 ++
 4 files changed, 41 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c
index 7c9fdea21366..e1b518aedee8 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c
@@ -165,6 +165,25 @@ static void ipsec_rx_status_pass_destroy(struct mlx5e_ipsec *ipsec,
 #endif
 }
 
+static void ipsec_rx_rule_add_match_obj(struct mlx5e_ipsec_sa_entry *sa_entry,
+					struct mlx5e_ipsec_rx *rx,
+					struct mlx5_flow_spec *spec)
+{
+	struct mlx5e_ipsec *ipsec = sa_entry->ipsec;
+
+	if (rx == ipsec->rx_esw) {
+		mlx5_esw_ipsec_rx_rule_add_match_obj(sa_entry, spec);
+	} else {
+		MLX5_SET_TO_ONES(fte_match_param, spec->match_criteria,
+				 misc_parameters_2.metadata_reg_c_2);
+		MLX5_SET(fte_match_param, spec->match_value,
+			 misc_parameters_2.metadata_reg_c_2,
+			 sa_entry->ipsec_obj_id | BIT(31));
+
+		spec->match_criteria_enable |= MLX5_MATCH_MISC_PARAMETERS_2;
+	}
+}
+
 static int rx_add_rule_drop_auth_trailer(struct mlx5e_ipsec_sa_entry *sa_entry,
 					 struct mlx5e_ipsec_rx *rx)
 {
@@ -200,11 +219,8 @@ static int rx_add_rule_drop_auth_trailer(struct mlx5e_ipsec_sa_entry *sa_entry,
 
 	MLX5_SET_TO_ONES(fte_match_param, spec->match_criteria, misc_parameters_2.ipsec_syndrome);
 	MLX5_SET(fte_match_param, spec->match_value, misc_parameters_2.ipsec_syndrome, 1);
-	MLX5_SET_TO_ONES(fte_match_param, spec->match_criteria, misc_parameters_2.metadata_reg_c_2);
-	MLX5_SET(fte_match_param, spec->match_value,
-		 misc_parameters_2.metadata_reg_c_2,
-		 sa_entry->ipsec_obj_id | BIT(31));
 	spec->match_criteria_enable = MLX5_MATCH_MISC_PARAMETERS_2;
+	ipsec_rx_rule_add_match_obj(sa_entry, rx, spec);
 	rule = mlx5_add_flow_rules(ft, spec, &flow_act, &dest, 1);
 	if (IS_ERR(rule)) {
 		err = PTR_ERR(rule);
@@ -281,10 +297,8 @@ static int rx_add_rule_drop_replay(struct mlx5e_ipsec_sa_entry *sa_entry, struct
 
 	MLX5_SET_TO_ONES(fte_match_param, spec->match_criteria, misc_parameters_2.metadata_reg_c_4);
 	MLX5_SET(fte_match_param, spec->match_value, misc_parameters_2.metadata_reg_c_4, 1);
-	MLX5_SET_TO_ONES(fte_match_param, spec->match_criteria, misc_parameters_2.metadata_reg_c_2);
-	MLX5_SET(fte_match_param, spec->match_value,  misc_parameters_2.metadata_reg_c_2,
-		 sa_entry->ipsec_obj_id | BIT(31));
 	spec->match_criteria_enable = MLX5_MATCH_MISC_PARAMETERS_2;
+	ipsec_rx_rule_add_match_obj(sa_entry, rx, spec);
 	rule = mlx5_add_flow_rules(ft, spec, &flow_act, &dest, 1);
 	if (IS_ERR(rule)) {
 		err = PTR_ERR(rule);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/ipsec_fs.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/ipsec_fs.c
index ed977ae75fab..4bba2884c1c0 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/ipsec_fs.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/ipsec_fs.c
@@ -85,6 +85,19 @@ int mlx5_esw_ipsec_rx_setup_modify_header(struct mlx5e_ipsec_sa_entry *sa_entry,
 	return err;
 }
 
+void mlx5_esw_ipsec_rx_rule_add_match_obj(struct mlx5e_ipsec_sa_entry *sa_entry,
+					  struct mlx5_flow_spec *spec)
+{
+	MLX5_SET(fte_match_param, spec->match_criteria,
+		 misc_parameters_2.metadata_reg_c_1,
+		 ESW_IPSEC_RX_MAPPED_ID_MATCH_MASK);
+	MLX5_SET(fte_match_param, spec->match_value,
+		 misc_parameters_2.metadata_reg_c_1,
+		 sa_entry->rx_mapped_id << ESW_ZONE_ID_BITS);
+
+	spec->match_criteria_enable |= MLX5_MATCH_MISC_PARAMETERS_2;
+}
+
 void mlx5_esw_ipsec_rx_id_mapping_remove(struct mlx5e_ipsec_sa_entry *sa_entry)
 {
 	struct mlx5e_ipsec *ipsec = sa_entry->ipsec;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/ipsec_fs.h b/drivers/net/ethernet/mellanox/mlx5/core/esw/ipsec_fs.h
index ac9c65b89166..514c15258b1d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/ipsec_fs.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/ipsec_fs.h
@@ -20,6 +20,8 @@ int mlx5_esw_ipsec_rx_ipsec_obj_id_search(struct mlx5e_priv *priv, u32 id,
 void mlx5_esw_ipsec_tx_create_attr_set(struct mlx5e_ipsec *ipsec,
 				       struct mlx5e_ipsec_tx_create_attr *attr);
 void mlx5_esw_ipsec_restore_dest_uplink(struct mlx5_core_dev *mdev);
+void mlx5_esw_ipsec_rx_rule_add_match_obj(struct mlx5e_ipsec_sa_entry *sa_entry,
+					  struct mlx5_flow_spec *spec);
 #else
 static inline void mlx5_esw_ipsec_rx_create_attr_set(struct mlx5e_ipsec *ipsec,
 						     struct mlx5e_ipsec_rx_create_attr *attr) {}
@@ -48,5 +50,8 @@ static inline void mlx5_esw_ipsec_tx_create_attr_set(struct mlx5e_ipsec *ipsec,
 						     struct mlx5e_ipsec_tx_create_attr *attr) {}
 
 static inline void mlx5_esw_ipsec_restore_dest_uplink(struct mlx5_core_dev *mdev) {}
+static inline void
+mlx5_esw_ipsec_rx_rule_add_match_obj(struct mlx5e_ipsec_sa_entry *sa_entry,
+				     struct mlx5_flow_spec *spec) {}
 #endif /* CONFIG_MLX5_ESWITCH */
 #endif /* __MLX5_ESW_IPSEC_FS_H__ */
diff --git a/include/linux/mlx5/eswitch.h b/include/linux/mlx5/eswitch.h
index df73a2ccc9af..67256e776566 100644
--- a/include/linux/mlx5/eswitch.h
+++ b/include/linux/mlx5/eswitch.h
@@ -147,6 +147,8 @@ u32 mlx5_eswitch_get_vport_metadata_for_set(struct mlx5_eswitch *esw,
 
 /* reuse tun_opts for the mapped ipsec obj id when tun_id is 0 (invalid) */
 #define ESW_IPSEC_RX_MAPPED_ID_MASK GENMASK(ESW_TUN_OPTS_BITS - 1, 0)
+#define ESW_IPSEC_RX_MAPPED_ID_MATCH_MASK \
+	GENMASK(31 - ESW_RESERVED_BITS, ESW_ZONE_ID_BITS)
 
 u8 mlx5_eswitch_mode(const struct mlx5_core_dev *dev);
 u16 mlx5_eswitch_get_total_vports(const struct mlx5_core_dev *dev);
-- 
2.45.0


