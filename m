Return-Path: <linux-rdma+bounces-12726-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7879AB253D5
	for <lists+linux-rdma@lfdr.de>; Wed, 13 Aug 2025 21:21:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43A73565DA0
	for <lists+linux-rdma@lfdr.de>; Wed, 13 Aug 2025 19:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 180F230E831;
	Wed, 13 Aug 2025 19:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oQnVAqNV"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2042.outbound.protection.outlook.com [40.107.212.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 639E730AADF;
	Wed, 13 Aug 2025 19:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755112848; cv=fail; b=Orek4KfkY/Fa3nhtaAGerAwUVqcWinBN+OKhWPeTVCs4nHIMjI33sCETOj+hIl9AINq4DkERUHaivNOt51S+cIdDu8N2Tu+7mPkiN0ieZH4TaD4KkHbw2g+QbKSMXx083SeVR/WFStf9fjYemEbLVTl97luyyOToZe4KPgcKoC0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755112848; c=relaxed/simple;
	bh=biorLH6a1FzGXdpdkUgVNYo6X2mGbcjGmhbTU2wD3cw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eIE5b4VUOGAiHjNOBTBkTlcO72VeYhvSlcQu9An6G20bLWxy+TnDRucS6lSj5yb0gzqRsJ7evJYrnEjMfr/TF0cQesDC3aSqZnPSta4JHifHKaKiPCzwUMjSFZf1PK7L/X8JBe+i8oXb0gNMjDGbh90SFzLcOpiFV3Bj8/auKvk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oQnVAqNV; arc=fail smtp.client-ip=40.107.212.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p5CDXV1Ag1H65CiN9o/SnfNxAKA8FAOEeSExP0LXIkud/UEfJyBWFi6Yca+H+VtGqWABdNocbt5/I69HeC1HKAW75XhXdFH4bj0a2pHyMG7Oa1aSMj09I39MRGMwGS5SAdR0uiE8cs047ZnQDAZjFOQHae/LU/YVrPcrs+9lz3tOKuEzP/SlOcYexHMPcpNVY/Xwog/SPUPpSDhSyJiPmZ0v6/vXsQO0YPrcQsR6hVKWsqFgPRWqfvpz3d9Qx/2fQ6zUaHHNhH2RtqWzPWiws81CjAvRl18q2TAJESmQg1HTyUoJe4T2efY2LVAbYSEUo+Lku/1n6voa+00TAiiIUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qk0axzKA8DyA/j2bKkGCJe22DTT72xY4k5fTAfEKTBM=;
 b=hnh4Q7K6xw0AtC/vf3flb7mFtO3Uya5ibchA5dohVz8Er+QNRuWJfT5UKhLmYVASrNCm/zodBzuL68/Z/wn5VMkTTVTuqPe9pu9mmwpgc/9+Rwds6HiQWlyJdQ/GM8poDg0beU7GkML8oY/swAFORi3el39rjEoIOxo4tkPM6W8fZ+NR69Iqrzz2TjgjNZgPA5OnfrdFA6h2PXtVHL6btxwZimnpFHAWuRNu7cMJ6PlY+RMgOkyoVS7qAFUDSLlAd65dzn7JSc47L6jasORSiMWM7iewEvt7BSmmM5/MaVXta9cxpJrvWt1CaP1GpwJqWv1sMoFrRvE48hX+6HrhVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qk0axzKA8DyA/j2bKkGCJe22DTT72xY4k5fTAfEKTBM=;
 b=oQnVAqNVmy1q+sIK5RrO79dsuoosGHjs9KuspDntiNGGI8yqCNePU6j54F7XNNusJtspxlPO2dyb4n4m7cdsxcQmmzQNcirjMsnAMiVA62jsdikcnzncbkxnH/nbE6zolyadZl3KsVluw/oR5OqlWHO6usUT4+Wl0ZL5Uh+EgWpMtz3UwilVoP+tGGGXQuVXu0VqD3rTh5KetAH1AMJm4VjqCdLqfo8LWtnEsWChhUrbVjfZATEKYGimcuouHni+AeMkGYFWtrGYZojJlk4eVnNB2EQMVy1inQ4+L3NHcDbs6ugh6L37PGxErWVOYhov/O2vkpcw6Smbi9oNyN52bw==
Received: from BY5PR17CA0056.namprd17.prod.outlook.com (2603:10b6:a03:167::33)
 by LV8PR12MB9452.namprd12.prod.outlook.com (2603:10b6:408:200::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.16; Wed, 13 Aug
 2025 19:20:44 +0000
Received: from CO1PEPF000044F9.namprd21.prod.outlook.com
 (2603:10b6:a03:167:cafe::2) by BY5PR17CA0056.outlook.office365.com
 (2603:10b6:a03:167::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.22 via Frontend Transport; Wed,
 13 Aug 2025 19:20:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000044F9.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.0 via Frontend Transport; Wed, 13 Aug 2025 19:20:44 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 13 Aug
 2025 12:20:21 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 13 Aug
 2025 12:20:20 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Wed, 13
 Aug 2025 12:20:17 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>, Daniel Jurgens <danielj@nvidia.com>, William Tu
	<witu@nvidia.com>
Subject: [PATCH net-next 1/2] net/mlx5: Query to see if host PF is disabled
Date: Wed, 13 Aug 2025 22:19:55 +0300
Message-ID: <1755112796-467444-2-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1755112796-467444-1-git-send-email-tariqt@nvidia.com>
References: <1755112796-467444-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F9:EE_|LV8PR12MB9452:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b055214-0ce6-472e-8a8f-08ddda9e7fe7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mKX2yXWQbC8qtHiucqVwosV7k7LLK2bUJ0eLGOOSo43f3OQC0nXRRepZcUGY?=
 =?us-ascii?Q?IP4LvFdfIxJF82TA2+hz6II0XZvE0uq2fh601I4Z/CyJZi+o/eisdJpqadbI?=
 =?us-ascii?Q?CKRzIGaypW6f3znlteUCHDTY3qHAK2i5WD2yeTySYw3AGeSV5Cl/sWVWHcWv?=
 =?us-ascii?Q?kXTYM27VDd9LdmGWU+RBa7hN7KOt0zqOgD7Sk/lAqkCHZE0hYF64KY6Ztnlz?=
 =?us-ascii?Q?4ucRVUvxj1hWTxfYjhHHmm4+1bHvY+kwpWcamA4MKotrH8cnrMGnZrfuPCsC?=
 =?us-ascii?Q?1ANT996RCL8zhvRFrMB2xVMtSVFpV3kFSV4Jxo/hvungUiwZxKrZuKztKgmN?=
 =?us-ascii?Q?GvB4zkSYhVBZ5ii2ChsKPKvkAqKLVdSA5QDNwOyMZlcqK9Ng4tx+3M6TY/pa?=
 =?us-ascii?Q?My/jNReb7nmVXAdtzV/l1+ZVbIG5nUuXhMD3KVLpu3mSUuwFe2SFVpHjmY9J?=
 =?us-ascii?Q?ipA3xpyX3ckzfbGczCvYhL/WzIx9KyHtDGIe2pqTGxSGvnVQXo/lRIPiq6az?=
 =?us-ascii?Q?NMJ1B5FN0bIBqIMipSgBya0kfiJlEVZFnrwxo9WWjyKtqRO6jOoO4xdIpCdE?=
 =?us-ascii?Q?praiYy8E4rTzV2aVnvoh6x3Fimv5cA8NRpDk1blsGLYeVQJSVmxeFcxZIUR6?=
 =?us-ascii?Q?R2pPNqVtnl8TeaUHlavGKJBMyDqkYP2jIUs73skFmyv8ElftgRoeewUvoHEJ?=
 =?us-ascii?Q?JbMfK2zzmFnGimTdVwjUzG9Y5RTOKweBq5UsQheuNa+9Hpl/n+qbtLJ/xAlf?=
 =?us-ascii?Q?eWFjm2uCZ1jWJKfk5PX8Wg2Wt/wdqR2YjYS54+DWUVw5+Y3soWQS04N9ulAf?=
 =?us-ascii?Q?FVVfd0h+cNDTFiF1MbmkP6VRPHnOZWs+k3Lyie6uAP0GMr3Fs9weiBzG+1FE?=
 =?us-ascii?Q?NV3HdrGYRwCRFmjCIjb0mh5Hf75Tcbw/Q3ENFipQQnKmKoeZdqFex7RTQV4e?=
 =?us-ascii?Q?88Hzw3EsUYtZOXwk7iAVg/R9gOwx6TDyD+eFhrHD8bchYdakD1RFS6YbDnFC?=
 =?us-ascii?Q?RTI90o7LxxfNU0aF6fhWcG6qieVeLSTdsQG/dqs+R3L4lGmYGn3ZwTI6eWZm?=
 =?us-ascii?Q?HSQSfGg927jHjDoVTlM3Jy1FIFQGOQpOnr+x0zOG2KiPS2ElLjOD++uMMpRL?=
 =?us-ascii?Q?rYPQGGQR/Ymm1GhJW/m3p6iYA6qgy0A3hKkgsoT0rKy/DkBL6q5cRSLAFn+Y?=
 =?us-ascii?Q?F8MajvtvPyAb21u0VQHxIZchjhYANb88RQevxjdei8h1GLJY8yQid9VN/4+w?=
 =?us-ascii?Q?T6EJObxd7cb3FRuCLIxE9ewvMvcpm9zwzzTt0TOpKkJ30Wmcdvr6z+Cg/MfA?=
 =?us-ascii?Q?hlqvSlBr6y0J06StzPeAQPHmCU4OBt2I62yvt8Wk3FYbxuv5c8VKbLS6vPQe?=
 =?us-ascii?Q?gd5y/LDue69pUP/4ND3BEaQLpVTz4dDizPTlVQZKvgiGH7URodgsF1W0eTn4?=
 =?us-ascii?Q?FliGmIUeyqs61yfpgFNuiSrlt5Pa7l93rLfQ6qjE0YH++MsKFRDxM4Wu0g+Z?=
 =?us-ascii?Q?LdsTuXvqwcOqkSdUQmyTX+tuw4vlYNvr/SIf?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 19:20:44.0811
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b055214-0ce6-472e-8a8f-08ddda9e7fe7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F9.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9452

From: Daniel Jurgens <danielj@nvidia.com>

The host PF can be disabled, query firmware to check if the host PF of
this function exists.

Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
Reviewed-by: William Tu <witu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/eswitch.c | 23 +++++++++++++++++++
 .../net/ethernet/mellanox/mlx5/core/eswitch.h |  1 +
 2 files changed, 24 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
index 4917d185d0c3..31059fff30ec 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
@@ -1038,6 +1038,25 @@ const u32 *mlx5_esw_query_functions(struct mlx5_core_dev *dev)
 	return ERR_PTR(err);
 }
 
+static int mlx5_esw_host_functions_enabled_query(struct mlx5_eswitch *esw)
+{
+	const u32 *query_host_out;
+
+	if (!mlx5_core_is_ecpf_esw_manager(esw->dev))
+		return 0;
+
+	query_host_out = mlx5_esw_query_functions(esw->dev);
+	if (IS_ERR(query_host_out))
+		return PTR_ERR(query_host_out);
+
+	esw->esw_funcs.host_funcs_disabled =
+		MLX5_GET(query_esw_functions_out, query_host_out,
+			 host_params_context.host_pf_not_exist);
+
+	kvfree(query_host_out);
+	return 0;
+}
+
 static void mlx5_eswitch_event_handler_register(struct mlx5_eswitch *esw)
 {
 	if (esw->mode == MLX5_ESWITCH_OFFLOADS && mlx5_eswitch_is_funcs_handler(esw->dev)) {
@@ -1874,6 +1893,10 @@ int mlx5_eswitch_init(struct mlx5_core_dev *dev)
 		goto abort;
 	}
 
+	err = mlx5_esw_host_functions_enabled_query(esw);
+	if (err)
+		goto abort;
+
 	err = mlx5_esw_vports_init(esw);
 	if (err)
 		goto abort;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
index b0b8ef3ec3c4..6d86db20f468 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
@@ -323,6 +323,7 @@ struct mlx5_host_work {
 
 struct mlx5_esw_functions {
 	struct mlx5_nb		nb;
+	bool			host_funcs_disabled;
 	u16			num_vfs;
 	u16			num_ec_vfs;
 };
-- 
2.31.1


