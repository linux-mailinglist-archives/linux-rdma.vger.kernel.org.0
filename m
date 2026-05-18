Return-Path: <linux-rdma+bounces-20878-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OEcCHwS9Cmrb7AQAu9opvQ
	(envelope-from <linux-rdma+bounces-20878-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2026 09:17:24 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F3F44567501
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2026 09:17:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A2AC1304742F
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2026 07:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61B4F3C455B;
	Mon, 18 May 2026 07:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OpG5z303"
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010005.outbound.protection.outlook.com [52.101.201.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B9D835DA79;
	Mon, 18 May 2026 07:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779088532; cv=fail; b=HiIfTFrWt6WQEmXA+0+ZkPqe5NHAPJMQqmtksNo+sO1AQewxSS05OxnnIjBf5Idh26J28ea4XmOmuxHIySso3C+5yBFV1uDjn/ANovHFQqxRQhLPuVJLTPuZjovJdU3ZJ0n5VLt0y4SyCMv0fPuxeRExxJInI1s7igKAH75/09E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779088532; c=relaxed/simple;
	bh=uMSa6v6KCJnauu8chuF0rqXp5svz+R1SKSUVoGuE8ck=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M+V4YE+rRtQ5MlwGpWx23LV+oGLN7pSlJx2/lnlCte9GcnS6jbUqLLBBiHNTD6DmypsOz+5G6N0jjqijL6YyXdmM5W0nm7nfndmyrchHeDPbk05F0C987Axd9e33YdPHePOjdr+1wI3jyysUzn8Wd+0Z2XjN6k7zT9ZkjECx8NQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OpG5z303; arc=fail smtp.client-ip=52.101.201.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OoIJwWo5qmTuPkAvZUlLxnzC+OwejeWZV/JhdC0B6djNOs44pDt9JOftGidbs4uYcwjwIuYHecO8faqU08vNnAUMejkarXA5WH456pB5c0IUv5iJwy+lQ40r55bgFYVHba4CcG0Dtz6YP+cpOpvleI99T1LqnykQlAss/iBscG+vdbAXFfBcW0hX4dZUCkV+iHd6JKXQ60daxLX4TOoEYoJWM3X2bhD8TOiuo0y//bQuIVMWyD1fitqKGREwvY8WMo65Bw0ce1Q3XxIIEQQH3sQC78wIuO1hLaW/rt/DIQg+lNu3ZAcXpZZzTLuCAxeercsd0RQIcFZIHaZeWvyBYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GGtL7v3Amhec8vwPah1lYQHcBidu0Ft9Mvklm1kHF4o=;
 b=J1Wwqng2h1WFP/xkfSUjUobXmID+5uUI5n4OPS32Fx08A9zpsVqhC0MTDVUwlNKRs8+bF1SR4OLX8XOfHn0u8qEr4ygMbEfghZVykGCahwxOZ2szeNKkI9cZKWL3JmrVZ0UaeqFAuLl2keTxj/Ml3zo7Bbdiqj5mlPM7yhZfwNUXCYmA0GKLuUK1QkRiZMuO6WHcfgT7HTkqT0IEVMYbQilC2TCPGQR2RLLP63u53zu2XJxC5n82zQ2M9pfGa60pXLUYCTxjEryplXDOLaOzITdjWIcPEKsc/RD1nkb1hjdBAxVuD6jWtu6MOHMLw4BVbpMKHEMp4FqgSdUBXHR2aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GGtL7v3Amhec8vwPah1lYQHcBidu0Ft9Mvklm1kHF4o=;
 b=OpG5z303iZOjC/djdv6NkTDm0Kn/Jp0T8rWM07A0svBN1rEN1KV7424o0Jadt2HAVMNMemMAbrNORIevYIcX7OPJCNa15Pn09o1cq0y0HiH4tkmJ3lrSUsWdYi1T2QTnIh1O2Kd+hnGHWHW05NJEgtcKRq5qZz2NT9fQeG1GvmKcesgmSeKOOaZb5zw/vWqlTNKMNldsd2DjutqyjhQHako9XiB1Pgt/YU2vWnVNmOSRdFBt3wLIpH3DOCHxdnQ1YoSUJzbYL4sHgo+Evq+R27N9Brvp11/SkEQkxmLMRLzWRhmxgEjN7/vQzQVPMTABb/wFSRgBGgq+9in4ceUEoQ==
Received: from DS7PR03CA0011.namprd03.prod.outlook.com (2603:10b6:5:3b8::16)
 by MN2PR12MB4064.namprd12.prod.outlook.com (2603:10b6:208:1d3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Mon, 18 May
 2026 07:15:24 +0000
Received: from DS2PEPF00003442.namprd04.prod.outlook.com
 (2603:10b6:5:3b8:cafe::af) by DS7PR03CA0011.outlook.office365.com
 (2603:10b6:5:3b8::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9913.12 via Frontend Transport; Mon,
 18 May 2026 07:15:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DS2PEPF00003442.mail.protection.outlook.com (10.167.17.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Mon, 18 May 2026 07:15:23 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 18 May
 2026 00:15:05 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 18 May 2026 00:15:04 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 18 May 2026 00:15:00 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, "Moshe
 Shemesh" <moshe@nvidia.com>, Akiva Goldberger <agoldberger@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>, Simon Horman <horms@kernel.org>
Subject: [PATCH net-next V2 1/8] net/mlx5: Use helper to parse host PF info
Date: Mon, 18 May 2026 10:13:49 +0300
Message-ID: <20260518071356.345723-2-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260518071356.345723-1-tariqt@nvidia.com>
References: <20260518071356.345723-1-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003442:EE_|MN2PR12MB4064:EE_
X-MS-Office365-Filtering-Correlation-Id: 9407d770-14dd-4674-c9b8-08deb4ad3a8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|36860700016|1800799024|3023799003|11063799003|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	BDOpx5K3EXclyx7puify2ep3zVi0S8krGV58N5jhNpIgZOL8qgk152OADXhWLD/tRFABNYPXXkYE/K2tYFfs16bqfg8QFYk9l7dr6kQH6CbCklMb7+Zep2Nx0wX1KFqMkUdYo+xCD+vfrcjk1TD+oCUF4MVAL0W7lUXD4J1XzWl4zUOjINLqM8vyuUb+EC3OwL6uAXb710EdpqtihIQsOdT48hNEYbBjySBDK4uC4BVgx1r1H8kHOV8Tmlfsxs6zOebiyHBWTIQSoXjjBUl+uGXnnH5TALNrPbcTo8oKcXJGmNDn3ObDE1oaDD2+vad0B/4FO5v1jIivNqftHOt/9RIQLu1r8pGqe+uImOgJZI6HZdS7PktOwpY1P6rC7eLB0uq2ZCd/PZIYNZRmUVZdLos3Cj2iXMccThoGf5iBpcp1U09ucIaUJNbpv9aAPUctU3b91vWaYRP+cKZ2zsrQsUDRBak9wwHFDypc7iSu9YQx5wtzi7xkIbe4zSPKy/urlACDhEYIjjzdpz6iScwUDFvUZ9ktiAql5k5k5zi871r2YjMn2aOvAO3WX+5CnghkEEyG5gKCEZhnrwRfF8USJzWY+/CoI9v2UlaI5KQqeqpwSxHOiNWlUeAOLO0v2wKWiJHiA1rPYQ9Bz/uzEmmGYCTB+zZWJklkYjawRb+bkhpm9vMUYdhXN8bUB6UVGDXWp2eTYvZfPwgsyKuHwrNK9cGKzRKxok9/ovtUf8WGUYs=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(36860700016)(1800799024)(3023799003)(11063799003)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	qkIbfv9C0+8hBFKAhiYua9dFMNFl1qHvxA/CcbZj9mcCmxVsWVhk810FK1WAmeTQ2nHDBmFacSAOxZh02JxJiyCBfK/+UMy3dQSy7Mkziro80Mog2KQmFACrva00yZWpOAnw+GC2O7sa8Nx8uewlO31JpzWx0JmPxqkyZDfW+ryFnNDb4VaCAnyPIKDUqc1DbQPmQv2WsMhdpbEin5dtw3Wob/9KhaZVaxr0QzkBQKIEXmoUQrweztDUWEq7myHiOKZ4i+em//FtyQC5ClkcSKMx9TovHLYBu5MrlVJ8+dH4s5LttfPeicVrXE3GzC+RjzMe9dglpgvZk/kLjXu5lKduzBd+sQMfVuDQ53bXtq97IdYGdWqDHXa3zbOortddltmSMCIJwBHfBdBn8q2iRfoDthSEqs/ruIsAUWRa/Qa2Ih9rhNhWupNpcoyhkrd4
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 07:15:23.6552
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9407d770-14dd-4674-c9b8-08deb4ad3a8f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003442.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4064
X-Rspamd-Queue-Id: F3F44567501
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20878-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:email,nvidia.com:mid];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

From: Moshe Shemesh <moshe@nvidia.com>

Add a helper mlx5_esw_get_host_pf_info() to retrieve host PF data from
the query_esw_functions command output, so callers no longer need to
parse the layout to obtain the required information.

Convert all callers of mlx5_esw_query_functions() to use the new helper,
preparing for upcoming support of the new op_mod that returns data in
the network_function_params layout.

Signed-off-by: Moshe Shemesh <moshe@nvidia.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/eswitch.c | 43 ++++++++++++++-----
 .../net/ethernet/mellanox/mlx5/core/eswitch.h | 15 +++++++
 .../mellanox/mlx5/core/eswitch_offloads.c     | 34 ++++++---------
 .../net/ethernet/mellanox/mlx5/core/sriov.c   |  8 ++--
 4 files changed, 62 insertions(+), 38 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
index 43c40353b2d8..861e79ddb489 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
@@ -1083,10 +1083,36 @@ const u32 *mlx5_esw_query_functions(struct mlx5_core_dev *dev)
 	return ERR_PTR(err);
 }
 
+static struct mlx5_esw_pf_info
+mlx5_esw_host_pf_from_host_params(const void *entry)
+{
+	return (struct mlx5_esw_pf_info) {
+		.pf_not_exist = MLX5_GET(host_params_context, entry,
+					 host_pf_not_exist),
+		.pf_disabled = MLX5_GET(host_params_context, entry,
+					host_pf_disabled),
+		.num_of_vfs = MLX5_GET(host_params_context, entry,
+				       host_num_of_vfs),
+		.total_vfs = MLX5_GET(host_params_context, entry,
+				      host_total_vfs),
+		.host_number = MLX5_GET(host_params_context, entry,
+					host_number),
+	};
+}
+
+struct mlx5_esw_pf_info mlx5_esw_get_host_pf_info(const u32 *out)
+{
+	const void *entry;
+
+	entry = MLX5_ADDR_OF(query_esw_functions_out, out, net_function_params);
+
+	return mlx5_esw_host_pf_from_host_params(entry);
+}
+
 static int mlx5_esw_host_functions_enabled_query(struct mlx5_eswitch *esw)
 {
+	struct mlx5_esw_pf_info host_pf_info;
 	const u32 *query_host_out;
-	void *host_params;
 
 	if (!mlx5_core_is_ecpf_esw_manager(esw->dev))
 		return 0;
@@ -1095,11 +1121,8 @@ static int mlx5_esw_host_functions_enabled_query(struct mlx5_eswitch *esw)
 	if (IS_ERR(query_host_out))
 		return PTR_ERR(query_host_out);
 
-	host_params = MLX5_ADDR_OF(query_esw_functions_out,
-				   query_host_out, net_function_params);
-	esw->esw_funcs.host_funcs_disabled =
-		MLX5_GET(host_params_context, host_params,
-			 host_pf_not_exist);
+	host_pf_info = mlx5_esw_get_host_pf_info(query_host_out);
+	esw->esw_funcs.host_funcs_disabled = host_pf_info.pf_not_exist;
 
 	kvfree(query_host_out);
 	return 0;
@@ -1523,7 +1546,7 @@ static void mlx5_eswitch_get_devlink_param(struct mlx5_eswitch *esw)
 static void
 mlx5_eswitch_update_num_of_vfs(struct mlx5_eswitch *esw, int num_vfs)
 {
-	void *host_params;
+	struct mlx5_esw_pf_info host_pf_info;
 	const u32 *out;
 
 	if (num_vfs < 0)
@@ -1538,10 +1561,8 @@ mlx5_eswitch_update_num_of_vfs(struct mlx5_eswitch *esw, int num_vfs)
 	if (IS_ERR(out))
 		return;
 
-	host_params = MLX5_ADDR_OF(query_esw_functions_out, out,
-				   net_function_params);
-	esw->esw_funcs.num_vfs = MLX5_GET(host_params_context, host_params,
-					  host_num_of_vfs);
+	host_pf_info = mlx5_esw_get_host_pf_info(out);
+	esw->esw_funcs.num_vfs = host_pf_info.num_of_vfs;
 	if (mlx5_core_ec_sriov_enabled(esw->dev))
 		esw->esw_funcs.num_ec_vfs = num_vfs;
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
index 291271afa96c..cfaae59a6e7c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
@@ -71,6 +71,14 @@ struct mlx5_mapped_obj {
 	};
 };
 
+struct mlx5_esw_pf_info {
+	bool pf_not_exist;
+	bool pf_disabled;
+	u16 num_of_vfs;
+	u16 total_vfs;
+	u16 host_number;
+};
+
 #ifdef CONFIG_MLX5_ESWITCH
 
 #define ESW_OFFLOADS_DEFAULT_NUM_GROUPS 15
@@ -649,6 +657,7 @@ bool mlx5_esw_multipath_prereq(struct mlx5_core_dev *dev0,
 			       struct mlx5_core_dev *dev1);
 
 const u32 *mlx5_esw_query_functions(struct mlx5_core_dev *dev);
+struct mlx5_esw_pf_info mlx5_esw_get_host_pf_info(const u32 *out);
 int mlx5_esw_host_pf_enable_hca(struct mlx5_core_dev *dev);
 int mlx5_esw_host_pf_disable_hca(struct mlx5_core_dev *dev);
 
@@ -976,6 +985,12 @@ static inline const u32 *mlx5_esw_query_functions(struct mlx5_core_dev *dev)
 	return ERR_PTR(-EOPNOTSUPP);
 }
 
+static inline struct mlx5_esw_pf_info
+mlx5_esw_get_host_pf_info(const u32 *out)
+{
+	return (struct mlx5_esw_pf_info) {};
+}
+
 static inline struct mlx5_flow_handle *
 esw_add_restore_rule(struct mlx5_eswitch *esw, u32 tag)
 {
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
index d95af87a4f5f..217c2fe6b690 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
@@ -3708,8 +3708,7 @@ static void esw_offloads_steering_cleanup(struct mlx5_eswitch *esw)
 
 static void esw_vfs_changed_event_handler(struct mlx5_eswitch *esw)
 {
-	bool host_pf_disabled;
-	void *host_params;
+	struct mlx5_esw_pf_info host_pf_info;
 	u16 new_num_vfs;
 	const u32 *out;
 
@@ -3717,14 +3716,10 @@ static void esw_vfs_changed_event_handler(struct mlx5_eswitch *esw)
 	if (IS_ERR(out))
 		return;
 
-	host_params = MLX5_ADDR_OF(query_esw_functions_out, out,
-				   net_function_params);
-	new_num_vfs = MLX5_GET(host_params_context, host_params,
-			       host_num_of_vfs);
-	host_pf_disabled = MLX5_GET(host_params_context, host_params,
-				    host_pf_disabled);
+	host_pf_info = mlx5_esw_get_host_pf_info(out);
+	new_num_vfs = host_pf_info.num_of_vfs;
 
-	if (new_num_vfs == esw->esw_funcs.num_vfs || host_pf_disabled)
+	if (new_num_vfs == esw->esw_funcs.num_vfs || host_pf_info.pf_disabled)
 		goto free;
 
 	mlx5_esw_reps_block(esw);
@@ -3826,8 +3821,8 @@ int mlx5_esw_funcs_changed_handler(struct notifier_block *nb,
 
 static int mlx5_esw_host_number_init(struct mlx5_eswitch *esw)
 {
+	struct mlx5_esw_pf_info host_pf_info;
 	const u32 *query_host_out;
-	void *host_params;
 
 	if (!mlx5_core_is_ecpf_esw_manager(esw->dev))
 		return 0;
@@ -3837,10 +3832,8 @@ static int mlx5_esw_host_number_init(struct mlx5_eswitch *esw)
 		return PTR_ERR(query_host_out);
 
 	/* Mark non local controller with non zero controller number. */
-	host_params = MLX5_ADDR_OF(query_esw_functions_out,
-				   query_host_out, net_function_params);
-	esw->offloads.host_number = MLX5_GET(host_params_context,
-					     host_params, host_number);
+	host_pf_info = mlx5_esw_get_host_pf_info(query_host_out);
+	esw->offloads.host_number = host_pf_info.host_number;
 	kvfree(query_host_out);
 	return 0;
 }
@@ -4980,9 +4973,8 @@ int mlx5_devlink_pf_port_fn_state_get(struct devlink_port *port,
 				      struct netlink_ext_ack *extack)
 {
 	struct mlx5_vport *vport = mlx5_devlink_port_vport_get(port);
+	struct mlx5_esw_pf_info host_pf_info;
 	const u32 *query_out;
-	void *host_params;
-	bool pf_disabled;
 
 	if (vport->vport != MLX5_VPORT_HOST_PF) {
 		NL_SET_ERR_MSG_MOD(extack, "State get is not supported for VF");
@@ -4996,13 +4988,11 @@ int mlx5_devlink_pf_port_fn_state_get(struct devlink_port *port,
 	if (IS_ERR(query_out))
 		return PTR_ERR(query_out);
 
-	host_params = MLX5_ADDR_OF(query_esw_functions_out, query_out,
-				   net_function_params);
-	pf_disabled = MLX5_GET(host_params_context, host_params,
-			       host_pf_disabled);
+	host_pf_info = mlx5_esw_get_host_pf_info(query_out);
 
-	*opstate = pf_disabled ? DEVLINK_PORT_FN_OPSTATE_DETACHED :
-				 DEVLINK_PORT_FN_OPSTATE_ATTACHED;
+	*opstate = host_pf_info.pf_disabled ?
+			DEVLINK_PORT_FN_OPSTATE_DETACHED :
+			DEVLINK_PORT_FN_OPSTATE_ATTACHED;
 
 	kvfree(query_out);
 	return 0;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/sriov.c b/drivers/net/ethernet/mellanox/mlx5/core/sriov.c
index 6eb6026eadd6..79f76c456d72 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/sriov.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/sriov.c
@@ -273,8 +273,8 @@ void mlx5_sriov_detach(struct mlx5_core_dev *dev)
 
 static u16 mlx5_get_max_vfs(struct mlx5_core_dev *dev)
 {
+	struct mlx5_esw_pf_info host_pf_info;
 	u16 host_total_vfs;
-	void *host_params;
 	const u32 *out;
 
 	if (mlx5_core_is_ecpf_esw_manager(dev)) {
@@ -285,10 +285,8 @@ static u16 mlx5_get_max_vfs(struct mlx5_core_dev *dev)
 		 */
 		if (IS_ERR(out))
 			goto done;
-		host_params = MLX5_ADDR_OF(query_esw_functions_out, out,
-					   net_function_params);
-		host_total_vfs = MLX5_GET(host_params_context, host_params,
-					  host_total_vfs);
+		host_pf_info = mlx5_esw_get_host_pf_info(out);
+		host_total_vfs = host_pf_info.total_vfs;
 		kvfree(out);
 		return host_total_vfs;
 	}
-- 
2.44.0


