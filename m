Return-Path: <linux-rdma+bounces-21095-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QJ0UDsjpDmqwDAYAu9opvQ
	(envelope-from <linux-rdma+bounces-21095-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 21 May 2026 13:17:28 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 97D6C5A3DAD
	for <lists+linux-rdma@lfdr.de>; Thu, 21 May 2026 13:17:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AE51F3073777
	for <lists+linux-rdma@lfdr.de>; Thu, 21 May 2026 11:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BD2F3BE16E;
	Thu, 21 May 2026 11:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XVQHHl+b"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013059.outbound.protection.outlook.com [40.107.201.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D8752DB789;
	Thu, 21 May 2026 11:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779361921; cv=fail; b=AG6D1SykpXjdO4VN6ujO9EsHIoo94/u+7swfkxNkaD0e5xbO6qrcJvVjOcRs7j9Bf8xcrSNLUkSwrEN5BxrWB4bbDXVXkHlk2/ITMYZKXO4gb69gRyLl3hoi+DB98uIyFKl5fMB6vgPMxVLq7uj7UwmgmV4VT7dUIBPybWKdeUo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779361921; c=relaxed/simple;
	bh=lWcTO57wi5WiLMpKPPoZpl25Jb+IJWC8eZpHezMj/fo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RLMIDB0E1AmpIePXNWUwvYInue9lO5t6iXh5HhMHwKSNtsrzfIzptiunxvD6dPR9q+xF22KYg8ih/S0m5+qgodPRdiN9hygJHlRGf/XSJE1xMXfmlOP0TH4QPzUmmM64oj1ZN+NRivat55u7MphQ+6fGlAhc3plRKqyFKm+eKZo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XVQHHl+b; arc=fail smtp.client-ip=40.107.201.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aKIBwFSgtgI5YPJd9r/MVfY9D+Kjjua5ZXp4pzB/IOzOIYPJbPEiynQHb2gKO8Ks/KfuXOCyBXa+MUqGZnv2lHCZCttXzG995BHmGH3DAVRy7Q6KFT7jUc4QSsgvXdSg+KzmR9wpdvXz+GCO8lDLuyQhza53EG9Zxlc+dcCTQDesMRaKstCYoGXR0pzaryXNAbc6XRv5M9V1pY4cXquGH8KtozjdmddbDOH0JMw4yqxpXDlWSQbnzJzjzRmKa4MLBHroE3oUBn+jazJdnuZN4v3YVvs5DBkXOB0Ox0BbZ+M5TTaHH10g3ISsP/pXycY1gehC2vPgb79jGNxahJ8BDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8fxRvhMJDsmqH4tILMyHxGuiICZXX1NQ8ctQ1i2Qiv0=;
 b=kvX47Omss8a6apH3TPwW+CD+oFCb1BNCKIR0ZqWbMcRHKwg+8epSeBMTbxOYWI/887LRGuhrQ7jkWrcyxp4lxZeT8wtAwcMSL3vqTKKZrh5E9nFvbXDT9R4QhNTl0OdYW3QFyKcRDkeLY3eXdBTZmFrf9jKgkdaXon4NhTIg8coEWMcG2AK0AFv8M3lYTipZjTQcVyqEO4htV5FYye+KhfFqtjXZuLCdJpurEW5nAWLzDAW3PcFMyn5G1efnjwyqcwyZCSC0HO5cyLLe6tr2LPw/+hIxv6TfLIUCo//RImxzceSmHYR1nre9cOzU6FY/Vn1+6yE5PHlEExlVjs0I2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8fxRvhMJDsmqH4tILMyHxGuiICZXX1NQ8ctQ1i2Qiv0=;
 b=XVQHHl+bqOywX+zs3f/4CU3N3LnjX5b+u0OOCBMsBGfDxijUyJha6HjXAUbRscFyaNrR/Utwu5FZA9xu2G0qz3juSJYDiEzbpllCm0BRxdJtr6rGkwbKMpZfnHsDFvEwcpC0pBQt1UXoKWOBMXg1+vts0qNbb41kegae3SCBe5Mql61uqZ6bZ/uy72RJishc6RMe7SHHYaNFOhBLigVLUHOlY+6Pu7AWyn7BxGKSOPsG3e9Dzrl3CYNSqAizXMaDjnUxp8bMB9Apv7pvlRvMgZ6bCziJ1bT4gEIH3zPCG74op5+v8m8TY6pPoWoSftDI7h3P1vziJCQ/FfTdXGNXNg==
Received: from CH2PR14CA0008.namprd14.prod.outlook.com (2603:10b6:610:60::18)
 by IA0PR12MB8745.namprd12.prod.outlook.com (2603:10b6:208:48d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Thu, 21 May
 2026 11:11:45 +0000
Received: from CH1PEPF0000AD78.namprd04.prod.outlook.com
 (2603:10b6:610:60:cafe::22) by CH2PR14CA0008.outlook.office365.com
 (2603:10b6:610:60::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.17 via Frontend Transport; Thu, 21
 May 2026 11:11:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH1PEPF0000AD78.mail.protection.outlook.com (10.167.244.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Thu, 21 May 2026 11:11:45 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 21 May
 2026 04:11:30 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 21 May
 2026 04:11:29 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Thu, 21
 May 2026 04:11:24 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, "Simon
 Horman" <horms@kernel.org>, Adithya Jayachandran <ajayachandra@nvidia.com>,
	Jiri Pirko <jiri@resnulli.us>, Moshe Shemesh <moshe@nvidia.com>, Or Har-Toov
	<ohartoov@nvidia.com>, Shay Drori <shayd@nvidia.com>, Parav Pandit
	<parav@nvidia.com>, Daniel Jurgens <danielj@nvidia.com>, Kees Cook
	<kees@kernel.org>, Cosmin Ratiu <cratiu@nvidia.com>, Carolina Jubran
	<cjubran@nvidia.com>, <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>
Subject: [PATCH net-next 02/12] net/mlx5: Introduce generic helper for PF SFs info
Date: Thu, 21 May 2026 14:08:33 +0300
Message-ID: <20260521110843.367329-3-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260521110843.367329-1-tariqt@nvidia.com>
References: <20260521110843.367329-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD78:EE_|IA0PR12MB8745:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b3403fc-9d11-4d11-0b52-08deb729bec2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|7416014|376014|22082099003|18002099003|56012099003|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info:
	wQpVNgmpUAI4KopYMzL8ABtHOXmal5lOOb2tkn70i9/QaaQTSGGz0KId1pn1J2YJ6u3qajGr25FL5UXysQAjpk1LNiyP1WMNcAWV43JZygCQRGYm8jGy8HoHmj2CxH9OFDeq+gC/3THqe+G5lpei223OyQYZrXTHotgIA+tqcqMNBaUON4LrFbvqt8knBu6BH66952K3E3kbEuCrDVnkt4aQTxS2KbqxaVpdM+j1R7iU7QBqJ74yPxx43BHypv9Zz/IEicuO2ZqZyzch5c9MhNST3vt8L9lx4ddWaJ2lOklMgiIOLaZbiuszhMw4C6mZ5sj6notSJkwAtruEooMYcuZtnz/AqibUQzqmy5tVj8EQ/rG6Xi+9tF/rTRNiNIk1cMJeKZYskDm9q8vIY5g4yTKKM7xllPt0XB2rz/TOnv5y2an3lE2GNj+r3fvDr5YJpi3wMXcRTfZYzUZkqC0Gkn497ZJU5n6VKaYM65RvNhT72E9AdwSM9D2/RB/7Gh9ICu02ediigmsFDi6i/SHDT5k1tn08jivY4uagCLHtS2g6W2Nk9DjDw9db8NmCk/aGOyht4I2Q1OEig55hYjqkaPeBQImP/4ogikKgXhExrJ466xs79bfJMIPynqzPQZK+UmIQsppf5xJ6iUsmYjIKY/Hx4SNzPl8r8qAPCcKtbKZtCnMCUfQ4/vfbo087Y/s09d+abto9pE5EgkuCZYhhRyO0ymP8lfr9WfWY6Yf7hKc=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(7416014)(376014)(22082099003)(18002099003)(56012099003)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	s26AMDPCKX6SDILXkq+Va+sRmvvHq25FQUH7DVJRNrFjPUbhJZPGrTgl18yqw4siEih/RrR3BK2xNDVPgx+QKKhfyJpnJz3WHtqkOVWs2gkGk4bc7qSXwHkbF0cqGjchdwdDXZjnAOLXtfDWKPy+og7wvRCx74UsYs1XdNXaI+n/FBIEIoSJA0a6kSb03gUZqmyP2VOcXrH73GxaU4/YGEpikzNMDA0zdIZL5pVJWgSBB9D7vJn3OH3QUfFLdA89Mzo+WKq18GAJuzm7/O6MYdqtcAXzJzf5RZURrLXWTms6zvHkSJvGftuOvpPUdJUKMHuENfdYwqyIVGH+aESFxdim3GW91urAF+h6w4LSDdQHfc+0i5ADVVWKSW3lbBLOw8U22LBI2RT7kKLIIN5Lu+u7AYigazCJ6cbh3d7ZZ80ND5soDy0Vd2GP4Ey4MLnc
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 11:11:45.3505
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b3403fc-9d11-4d11-0b52-08deb729bec2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD78.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8745
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
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21095-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 97D6C5A3DAD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Moshe Shemesh <moshe@nvidia.com>

Introduce mlx5_esw_sf_max_pf_functions() that queries a PF's max_num_sf
and sf_base_id using mlx5_vport_get_other_func_general_cap(), which
supports both function_id and vhca_id based addressing.

Refactor mlx5_esw_sf_max_hpf_functions() into a thin wrapper that adds
the host PF precondition checks and calls the new generic helper. Remove
mlx5_query_hca_cap_host_pf() as it is not used anymore.

This prepares for querying SFs info of Satellite PFs.

Signed-off-by: Moshe Shemesh <moshe@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/eswitch.c | 38 +++++++++----------
 1 file changed, 17 insertions(+), 21 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
index e75925a99852..815538ba754f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
@@ -2023,37 +2023,20 @@ void mlx5_eswitch_disable(struct mlx5_eswitch *esw)
 	mlx5_lag_enable_change(esw->dev);
 }
 
-static int mlx5_query_hca_cap_host_pf(struct mlx5_core_dev *dev, void *out)
-{
-	u16 opmod = (MLX5_CAP_GENERAL << 1) | (HCA_CAP_OPMOD_GET_MAX & 0x01);
-	u8 in[MLX5_ST_SZ_BYTES(query_hca_cap_in)] = {};
-
-	MLX5_SET(query_hca_cap_in, in, opcode, MLX5_CMD_OP_QUERY_HCA_CAP);
-	MLX5_SET(query_hca_cap_in, in, op_mod, opmod);
-	MLX5_SET(query_hca_cap_in, in, function_id, MLX5_VPORT_HOST_PF);
-	MLX5_SET(query_hca_cap_in, in, other_function, true);
-	return mlx5_cmd_exec_inout(dev, query_hca_cap, in, out);
-}
-
-int mlx5_esw_sf_max_hpf_functions(struct mlx5_core_dev *dev, u16 *max_sfs, u16 *sf_base_id)
-
+static int mlx5_esw_sf_max_pf_functions(struct mlx5_core_dev *dev,
+					u16 vport_num, u16 *max_sfs,
+					u16 *sf_base_id)
 {
 	int query_out_sz = MLX5_ST_SZ_BYTES(query_hca_cap_out);
 	void *query_ctx;
 	void *hca_caps;
 	int err;
 
-	if (!mlx5_core_is_ecpf(dev) ||
-	    !mlx5_esw_host_functions_enabled(dev)) {
-		*max_sfs = 0;
-		return 0;
-	}
-
 	query_ctx = kzalloc(query_out_sz, GFP_KERNEL);
 	if (!query_ctx)
 		return -ENOMEM;
 
-	err = mlx5_query_hca_cap_host_pf(dev, query_ctx);
+	err = mlx5_vport_get_other_func_general_cap(dev, vport_num, query_ctx);
 	if (err)
 		goto out_free;
 
@@ -2066,6 +2049,19 @@ int mlx5_esw_sf_max_hpf_functions(struct mlx5_core_dev *dev, u16 *max_sfs, u16 *
 	return err;
 }
 
+int mlx5_esw_sf_max_hpf_functions(struct mlx5_core_dev *dev, u16 *max_sfs,
+				  u16 *sf_base_id)
+{
+	if (!mlx5_core_is_ecpf(dev) ||
+	    !mlx5_esw_host_functions_enabled(dev)) {
+		*max_sfs = 0;
+		return 0;
+	}
+
+	return mlx5_esw_sf_max_pf_functions(dev, MLX5_VPORT_HOST_PF, max_sfs,
+					    sf_base_id);
+}
+
 int mlx5_esw_vport_alloc(struct mlx5_eswitch *esw, int index, u16 vport_num)
 {
 	struct mlx5_vport *vport;
-- 
2.44.0


