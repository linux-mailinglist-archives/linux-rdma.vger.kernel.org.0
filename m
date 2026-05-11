Return-Path: <linux-rdma+bounces-20403-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AP+bKA0TAmrangEAu9opvQ
	(envelope-from <linux-rdma+bounces-20403-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2026 19:34:05 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D0535138FB
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2026 19:34:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0806330A0891
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2026 17:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0682B450906;
	Mon, 11 May 2026 17:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IHofl7XY"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010012.outbound.protection.outlook.com [52.101.193.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A6544DB9D;
	Mon, 11 May 2026 17:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778520509; cv=fail; b=EIEqo2zSFOFND/FaqChVrfD5kh2hLUztHy8b+gSMDwSd3e4KEo+U4BVry/omAekNahjcgNQPAvl5u6dZ2+EGqIiqT19IMK8EOVqDsuzi5Rkm7EwSWP5Xtb2tdvFhZFmlZnzsl/Ai5g9s9FdaSK4EyUw1IWBKYBpOm/SDuC2xsXY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778520509; c=relaxed/simple;
	bh=IKSmwJyYms1bnF+7tW/wZNKcD9IxdJGtd+Hw3bTnQDY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MQK7WmtgqNgoLDnt0V3ct3VPFQPYMiKuKjS7b2fh8KfhBjNo5Qi3ECn36wWF4sfcwq0e+9oymzstELrFeG035snbGMPuqeKQ57RTsBW2Y06OTgludS1MMH8FvcY+/uOiIc4X615pyG1vHXQlRwsJpeLrBsUeIi/mIubIT2jucEo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IHofl7XY; arc=fail smtp.client-ip=52.101.193.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SoRQpqCizH69u8r1j8WjXLWAvkAgKuhMYPp5EqQpLXvT/UYiU5Zd/AgKM7IjariQ3CwsDxRQiK/r6lE6kX0k91vVK0CkiBc/Ei6Gc6sPrZZQcIuI/Rdt90pON7Ye4m8DTZo9kdBPZ9s5mdw0YsNPq6daQhzIDZK00AWxGQBjd0KGzr+nLhqp8U/UaR6exM6sN0ijHq9ZxktfPAkRCCgU4nxomzLrAe+7zwrY2z1F5BgQNK/BQBoQfCvMBsTSzJF1gksUX2fMoQ8Q+2qpAj+gJfwxRmDmDBb7oeigJ8a5RjO33d3Dhw/a+8ynmd+AcsRxlSPSMwJwC5uzFG4XcpRh8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0WE0X34nfjhCtoPVfgmCEfCTd+OyrXvk9zrgxozkSvs=;
 b=IPU/uVHlACZ1smhkdWT1McDODrc5e0xeEZD3QdLt/g99k71yqWHZoKT41xXtjhGrXoMSA0CmYhcyL8dCXNolnQ4M97Wj15dmRPwrATwLefxZT/MLQXsACHcbHrTOpXtCZbersl/eIMXbbElF1ToeutsBcIULj/7kJ4J6kGjP4ICB4FGzm2y7Al+7GAjmDhYJkjfj7WVksEjj88KYscEA8Qs/yqqpqIdjqjouD+bQjsu6plrBYEV/0aeO3kmWtIqIvQqeOAdDVtlBiIJhmC1en/CYVwDU0SMGhA0e5yFx7ik68PPdaLXlqWWAuzURTkBwhpEhzj9h0KyNd7IyuQ2ORA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0WE0X34nfjhCtoPVfgmCEfCTd+OyrXvk9zrgxozkSvs=;
 b=IHofl7XYmiKfrRDoSoEfbeISO4bhfLvqYuuduukl73zsvk9wsGO6C56ia/RDwoE/ysineV2GOXCKgSQV4nk8G4y4v+MsfPy5iBqO9Ozxb0vdQN/ikS7X4tKIU35UShUU0ckDJW8dCHH+pCtACGriPdFfv1TumZu/EIAXhlkLaDQAmhvLx60m5cG+p7Nl/5qpVdOKPaHPtzNQ2a7ZZjtn+Q9416rz/YZYbwLfl5FxRECaFf4NsDD1hqa1ljvlpYaQv6+XlRWD3knpJ5Jf/dQJJXE/D3iboCSutVwFO2/GOi5EuzPij4l0QSsO2ogcs7yHUnB1SDihRszgzM8VGVB6LQ==
Received: from SN7PR04CA0073.namprd04.prod.outlook.com (2603:10b6:806:121::18)
 by DS7PR12MB9474.namprd12.prod.outlook.com (2603:10b6:8:252::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.20; Mon, 11 May
 2026 17:28:18 +0000
Received: from SA2PEPF000015CA.namprd03.prod.outlook.com
 (2603:10b6:806:121:cafe::1) by SN7PR04CA0073.outlook.office365.com
 (2603:10b6:806:121::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.23 via Frontend Transport; Mon,
 11 May 2026 17:28:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF000015CA.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Mon, 11 May 2026 17:28:18 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 11 May
 2026 10:27:55 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 11 May
 2026 10:27:54 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 11
 May 2026 10:27:49 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Nimrod Oren
	<noren@nvidia.com>, Yael Chemla <ychemla@nvidia.com>, Carolina Jubran
	<cjubran@nvidia.com>, Simon Horman <horms@kernel.org>, Gal Pressman
	<gal@nvidia.com>, Kees Cook <kees@kernel.org>, Dragos Tatulea
	<dtatulea@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next 3/5] net/mlx5e: resize non-default RSS indirection tables on channel change
Date: Mon, 11 May 2026 20:27:17 +0300
Message-ID: <20260511172719.330490-4-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260511172719.330490-1-tariqt@nvidia.com>
References: <20260511172719.330490-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CA:EE_|DS7PR12MB9474:EE_
X-MS-Office365-Filtering-Correlation-Id: 352fcfbc-ee04-4a96-0534-08deaf82b0fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|7416014|376014|22082099003|56012099003|18002099003|11063799003;
X-Microsoft-Antispam-Message-Info:
	pRz5jsJD0x3mu1/bXqdgypwSjHx85A2guWbQI0NHrFmZtZ5CZTT2aQHCFRpUEEQYjjy3BiCot6WcqQKYENDnzlcAPc/vL8pJZINY7AyHfzLk/ju3B5O2i/65gljVNzKFrOo223FNyiLQo5TOxpwmvLBd7oyvyYJzF9hXIkYcgzPB6Y89880zyk/Pi4JVe9eapkKgt9NC2ADeGWtFHj+3wtyF64EU9DoWgMvNtOQ6krOBwGpz5MrM3a9cLtztTPcX8JFG39gNTFAFdLlGC5Q9EXgm9xNW9JmXCow3rEaBT7K9CfJDrAVUMw5SBYdRWskdIzwNlIQ7nGCBByPwn/yj+fXE/GwEinjBG2Q/Ge4bgp86Fw/DR7+00CHbw+cBdhX0CuIBJihrp3gKJzhUdwklI//o65LBtwyveorXw9YA6+0dv4reK79NpqHdBl6WpVWgH7FAmidDGThAts92nK9aNqpc77sbmAHaVqYzTjqlvh3bp/r2bvH35kEY47OZs7YV0dbvA1e8vWgmm/IsycvXRFmMx0Ju51wp/ajMsiFeV5EeUGFSk9CKI7DzfpInqQjyODCyjLnjBHxS7iRFQerIYiq1G1gy3ZHhHY49gxPy3BFG/QyWnKACFxKWrbGG2cCgActoT4GCxMd8cu2frWb0Zms6KYtrwCKPtYTmnPFwvdLrmSIPLXtFkbVpWlR94tffoCYs2SQUo9O91tgGx6RUBPS85VilkpfAa7021rXLFAY=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(7416014)(376014)(22082099003)(56012099003)(18002099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Wqf7nWjEMahbQ0H+9vSbJbT2hiJdZ/tCYkDIIER2kCe6DCfiEniy0crvh3I5QQrEMMTOXqYRW3lSQsgTzwfXoAY6ZrYGDuXliMBV7AQs7uoCuCVV/VP8V9ATIvELrKp68Nt74cilRsP4lXCbHtKNEzJckGylkOgf6iqHtcHKPDJLJIsYiluQdD2PhWjX/z1jtFzK4JJ4ruPgPASc8zdH2sIR3sXuuoRaw+CxPoMCgNnyZHuyEv82tiA94OsM/8lQyAuYzYhOOpfRHDTpxw3KWfVfMDPcGucq6GGHqv+IoJ+5AiHGMzM/mkpnlKTzDROMGGDbkVsErJfRmVLm5uQ8mgg+elpr5Q1rroCeddvOF2ff/Qh2nEPsIN7tP1NLxMSzaBn/PIf7A4otic1t21DCx2odKC7chWhNueegMXYIuJc88uGTKz/dDsadLTY+IhI9
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 17:28:18.1759
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 352fcfbc-ee04-4a96-0534-08deaf82b0fc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015CA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9474
X-Rspamd-Queue-Id: 1D0535138FB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20403-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:email,nvidia.com:mid];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

From: Yael Chemla <ychemla@nvidia.com>

When the channel count changes and the RQT size changes with it, a
problem arise for non-default RSS contexts. The driver-side indirection
table grows actual_table_size without filling the new entries; stale
entries from a prior larger configuration may be re-exposed, causing
mlx5e_calc_indir_rqns() to WARN on an out-of-range index.

Replace mlx5e_rss_params_indir_modify_actual_size() with
mlx5e_rss_ctx_resize(), which fills new entries by replicating
the existing pattern, matching what ethtool_rxfh_ctxs_resize() does
for the same case. And restrict the loop to non-default contexts.

Call ethtool_rxfh_ctxs_can_resize() before acquiring state_lock to
validate that all non-default contexts can be resized, and
ethtool_rxfh_ctxs_resize() after releasing it to fold or unfold their
indirection tables. Both functions acquire rss_lock internally and
cannot be called under state_lock. RTNL, held by all set_channels
callers, serialises context creation and deletion making the pre-lock
check safe.

Guard both ethtool calls on mlx5e_rx_res_rss_cnt() > 1: skip the
validation and resize when no non-default contexts exist. This
naturally covers representors and IPoIB, which share
mlx5e_ethtool_set_channels() but cannot have non-default RSS contexts.

Signed-off-by: Yael Chemla <ychemla@nvidia.com>
Reviewed-by: Nimrod Oren <noren@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/en/rss.c  | 16 +++++++--
 .../net/ethernet/mellanox/mlx5/core/en/rss.h  |  3 +-
 .../ethernet/mellanox/mlx5/core/en/rx_res.c   | 15 ++++++--
 .../ethernet/mellanox/mlx5/core/en_ethtool.c  | 35 +++++++++++++++++--
 4 files changed, 60 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/rss.c b/drivers/net/ethernet/mellanox/mlx5/core/en/rss.c
index a2ec67a122d9..992a78580a40 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/rss.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/rss.c
@@ -85,9 +85,21 @@ bool mlx5e_rss_get_inner_ft_support(struct mlx5e_rss *rss)
 	return rss->params.inner_ft_support;
 }
 
-void mlx5e_rss_params_indir_modify_actual_size(struct mlx5e_rss *rss, u32 num_channels)
+void mlx5e_rss_set_indir_actual_size(struct mlx5e_rss *rss, u32 size)
 {
-	rss->indir.actual_table_size = mlx5e_rqt_size(rss->mdev, num_channels);
+	rss->indir.actual_table_size = size;
+}
+
+/* Handles non-default contexts, replicate existing pattern into new entries,
+ * matching what ethtool_rxfh_ctxs_resize() does.
+ */
+void mlx5e_rss_ctx_resize(struct mlx5e_rss *rss, u32 new_size)
+{
+	u32 old_size = rss->indir.actual_table_size;
+	u32 i;
+
+	for (i = old_size; i < new_size; i++)
+		rss->indir.table[i] = rss->indir.table[i % old_size];
 }
 
 int mlx5e_rss_params_indir_init(struct mlx5e_rss_params_indir *indir,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/rss.h b/drivers/net/ethernet/mellanox/mlx5/core/en/rss.h
index 17664757a561..e48070e02979 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/rss.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/rss.h
@@ -34,7 +34,7 @@ struct mlx5e_rss;
 int mlx5e_rss_params_indir_init(struct mlx5e_rss_params_indir *indir,
 				u32 actual_table_size, u32 max_table_size);
 void mlx5e_rss_params_indir_cleanup(struct mlx5e_rss_params_indir *indir);
-void mlx5e_rss_params_indir_modify_actual_size(struct mlx5e_rss *rss, u32 num_channels);
+void mlx5e_rss_ctx_resize(struct mlx5e_rss *rss, u32 new_size);
 struct mlx5e_rss *
 mlx5e_rss_init(struct mlx5_core_dev *mdev,
 	       const struct mlx5e_rss_params *params,
@@ -46,6 +46,7 @@ void mlx5e_rss_refcnt_dec(struct mlx5e_rss *rss);
 unsigned int mlx5e_rss_refcnt_read(struct mlx5e_rss *rss);
 
 bool mlx5e_rss_get_inner_ft_support(struct mlx5e_rss *rss);
+void mlx5e_rss_set_indir_actual_size(struct mlx5e_rss *rss, u32 size);
 u32 mlx5e_rss_get_tirn(struct mlx5e_rss *rss, enum mlx5_traffic_types tt,
 		       bool inner);
 bool mlx5e_rss_valid_tir(struct mlx5e_rss *rss, enum mlx5_traffic_types tt, bool inner);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/rx_res.c b/drivers/net/ethernet/mellanox/mlx5/core/en/rx_res.c
index 92974b11ec75..d81a91eb7664 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/rx_res.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/rx_res.c
@@ -42,11 +42,20 @@ static u32 *get_vhca_ids(struct mlx5e_rx_res *res, int offset)
 
 void mlx5e_rx_res_rss_update_num_channels(struct mlx5e_rx_res *res, u32 nch)
 {
+	u32 new_size = mlx5e_rqt_size(res->mdev, nch);
 	int i;
 
-	for (i = 0; i < MLX5E_MAX_NUM_RSS; i++) {
-		if (res->rss[i])
-			mlx5e_rss_params_indir_modify_actual_size(res->rss[i], nch);
+	WARN_ON_ONCE(res->rss_active);
+
+	/* Default context */
+	mlx5e_rss_set_indir_actual_size(res->rss[0], new_size);
+
+	/* Non-default contexts */
+	for (i = 1; i < MLX5E_MAX_NUM_RSS; i++) {
+		if (res->rss[i]) {
+			mlx5e_rss_ctx_resize(res->rss[i], new_size);
+			mlx5e_rss_set_indir_actual_size(res->rss[i], new_size);
+		}
 	}
 }
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
index c483008e33e9..4462cf29e977 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
@@ -499,11 +499,15 @@ int mlx5e_ethtool_set_channels(struct mlx5e_priv *priv,
 {
 	struct mlx5e_params *cur_params = &priv->channels.params;
 	unsigned int count = ch->combined_count;
+	int new_rqt_size, cur_rqt_size;
 	struct mlx5e_params new_params;
 	bool arfs_enabled;
+	bool has_rss_ctxs;
 	bool opened;
 	int err = 0;
 
+	ASSERT_RTNL();
+
 	if (!count) {
 		netdev_info(priv->netdev, "%s: combined_count=0 not supported\n",
 			    __func__);
@@ -513,16 +517,33 @@ int mlx5e_ethtool_set_channels(struct mlx5e_priv *priv,
 	if (cur_params->num_channels == count)
 		return 0;
 
+	new_rqt_size = mlx5e_rqt_size(priv->mdev, count);
+	/* Validate that all non-default RSS contexts can be resized before
+	 * committing to the channel count change.
+	 * ethtool_rxfh_ctxs_can_resize() acquires rss_lock internally and
+	 * cannot be called under state_lock (rss_lock -> state_lock ordering).
+	 */
+	has_rss_ctxs = priv->rx_res && mlx5e_rx_res_rss_cnt(priv->rx_res) > 1;
+	if (has_rss_ctxs) {
+		err = ethtool_rxfh_ctxs_can_resize(priv->netdev, new_rqt_size);
+		if (err)
+			return err;
+	}
+
 	mutex_lock(&priv->state_lock);
 
+	if (!priv->rx_res) {
+		err = -EINVAL;
+		goto out;
+	}
+
+	cur_rqt_size = mlx5e_rqt_size(priv->mdev, cur_params->num_channels);
+
 	/* If RXFH is configured, changing the channels number is allowed only if
 	 * it does not require resizing the RSS table. This is because the previous
 	 * configuration may no longer be compatible with the new RSS table.
 	 */
 	if (netif_is_rxfh_configured(priv->netdev)) {
-		int cur_rqt_size = mlx5e_rqt_size(priv->mdev, cur_params->num_channels);
-		int new_rqt_size = mlx5e_rqt_size(priv->mdev, count);
-
 		if (new_rqt_size != cur_rqt_size) {
 			err = -EINVAL;
 			netdev_err(priv->netdev,
@@ -577,6 +598,14 @@ int mlx5e_ethtool_set_channels(struct mlx5e_priv *priv,
 out:
 	mutex_unlock(&priv->state_lock);
 
+	/* After a successful channel count change that altered the RQT size,
+	 * fold or unfold the indirection tables of all non-default RSS
+	 * contexts. Must run after state_lock is released because
+	 * ethtool_rxfh_ctxs_resize() acquires rss_lock internally.
+	 */
+	if (!err && cur_rqt_size != new_rqt_size && has_rss_ctxs)
+		ethtool_rxfh_ctxs_resize(priv->netdev, new_rqt_size);
+
 	return err;
 }
 
-- 
2.44.0


