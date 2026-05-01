Return-Path: <linux-rdma+bounces-19831-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OJV3M18v9GlM/AEAu9opvQ
	(envelope-from <linux-rdma+bounces-19831-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 01 May 2026 06:43:11 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B96C4AA5FE
	for <lists+linux-rdma@lfdr.de>; Fri, 01 May 2026 06:43:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B2A4B3015705
	for <lists+linux-rdma@lfdr.de>; Fri,  1 May 2026 04:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEA452F6931;
	Fri,  1 May 2026 04:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Yw72i8m2"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012018.outbound.protection.outlook.com [40.93.195.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389052E7F39;
	Fri,  1 May 2026 04:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777610554; cv=fail; b=DTrTqujCj+UlWEASBFYHGDmn41IAje044sNnwVXlkK+zJFrzrRNL00pJ1tzksmXDJwm1UehUayIawgrBJBblp6/+tN1b/n+4AY1neUfNI94iCmAqBsrCOYCUzYx4mXoBFkiX17v9nJQyP2YPaiJcgJj9a5I7qE+pD4fXWQ2N93E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777610554; c=relaxed/simple;
	bh=qRPLqSmTdL7RgFrpA39YtEfL8GmJqojniB9toq76cd4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dyh42qXwAfcYFSywiAsa4FPL64tU0jZfNyCFfrYG3WU/pub4m0vIpvCS/n01tok2CJ0Yywh7W4HMwu9i/D6fXiV/c5sbrDLPtkjjGQ+Wj7c5rYQfdmwjEeYTefqvoTy68l3sFhW4i6p4KRAsvxbh13qHGT8eKovaPyhRfeZLzzc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Yw72i8m2; arc=fail smtp.client-ip=40.93.195.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RsEAWnH7aSeRKwz0SJj5uzWYrWlRL/jcNemX9CxaHKaRVi6zD1ppaUmqE+NI8wVBGS9ABHzrs4fxuzodefkIYFk0e9QAuEtQNGMug4dLPaRdo4h+uY/ArpxjBdFpOiW+9HTBg8vdgml33+9PDVsagCEY9hb6IC18sPxIs76dF1d7jtqWb6pOQlftjtP+QFrMophcSn88Or0jSiUG9CJ+o3lppuFkE7w5z1wW1tlwTPogbO5bv51pysKSV+4D4bYk58rGuvheWa/OyLRtm1rzxLtYcmXFVZo8LG7v8vi7BwBdx91MywnZFn81Zy3KvLyhEzlv5ntOW/yOO/LlwbOt0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hKAm1Kw0m1lZImrfB9XzU16kod3fBCXGquKUYeNU6xA=;
 b=QXetdFe3mDPy634RRFdqJncM4JlJmaLVLQjDjU8iEJK0i0bYEvx5M4Gv7HyHm6JxYdV5ycWmMvHwfwru7ZkOpGCME+OCtzf7Wm2nmMvhXJ8+8rLIxpcVWFfqmGsQ0hxGUIo3DDzpP4LiVLTKBsaX3cQ6LAtPH36w7kl+HgauuErFOkUDzcTTkLMGtP/EZQoQcz2iIA4j/JDnldSAaRbLnZ965tm5/L7sknuDBp1bm/UrxJdAeyKJn7VmSoFNOFYFNYIwUSWDqSQ4LKEAa1Qa0HCM3XRwOO8+gwSGoyiuQiHCEfauRgXbjXcEGPiUFC4aVK0PJmtLK4jI1tdG0VeesQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hKAm1Kw0m1lZImrfB9XzU16kod3fBCXGquKUYeNU6xA=;
 b=Yw72i8m2zHURNn1lJLNmP2BcpjK68z41QQ75Zgx6WDf+X3gYwqoS/uykcHGd4T6HqC1f0Dmxi7vpfbNNU8j6fCa4MOq+z2vInnwT+tkAzqQaelJgSMbk9O1YN589Tq6Ad2vtAdK5s3O5QsquFJfY0EvsJxfpcMHb7FjrMrDVDKlyPDz7vQ0YUJaqGE1jIpCgvI228CMxuzuAZ/38sPjnaXuzm6B/hID+Eciy1CCHrmOX0b7dHk3J9ko3RLaKhVmg9Fa3AhNSpL6DzNY75i7EZN5lRHY/50IVDWeyX/qKGV1D2pnZ1mJhZPy9kdKSkyKUvp4TS266b608G3a0aAregw==
Received: from BN9PR03CA0240.namprd03.prod.outlook.com (2603:10b6:408:f8::35)
 by CH0PR12MB8580.namprd12.prod.outlook.com (2603:10b6:610:192::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.22; Fri, 1 May
 2026 04:42:25 +0000
Received: from BN3PEPF0000B074.namprd04.prod.outlook.com
 (2603:10b6:408:f8:cafe::d4) by BN9PR03CA0240.outlook.office365.com
 (2603:10b6:408:f8::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.21 via Frontend Transport; Fri,
 1 May 2026 04:42:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN3PEPF0000B074.mail.protection.outlook.com (10.167.243.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Fri, 1 May 2026 04:42:24 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 30 Apr
 2026 21:42:12 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 30 Apr
 2026 21:42:12 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Thu, 30
 Apr 2026 21:42:08 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, "Moshe
 Shemesh" <moshe@nvidia.com>, Akiva Goldberger <agoldberger@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>
Subject: [PATCH net-next 1/3] net/mlx5: Relax capability check for eswitch query paths
Date: Fri, 1 May 2026 07:41:54 +0300
Message-ID: <20260501044156.260875-2-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260501044156.260875-1-tariqt@nvidia.com>
References: <20260501044156.260875-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B074:EE_|CH0PR12MB8580:EE_
X-MS-Office365-Filtering-Correlation-Id: 9067e584-0504-427a-11e4-08dea73c0a82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700016|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	Rr71VDLh1e8hfKm803XMiiDw6FKfd6vOUJu7WWx4t9k3wYoLVddkWJovGAtgyu82e25FO9I7fL9KqUVesi2ewpiZE6O8GF5Nwv8SFvK/CZDrcD/lREQPyidAi8NzSxYaf4XQMTgDHLaj8Fayk7DQbdNh3tJ6/7+lrW/ZWOz2DtZd4FKHy2ASI+B6SBN4IiYsNmMBybBx7niwjMphpmiKHJZFgXAwOlu7Q8jm98w9Ez7+ohxN2l10MFAKlFdOIt+M+URJwL18C7AYRDS+pwmRI2zSwtYbg4RB13AQ2KpXUsrn6Tt/Uw9wnPsMw1DRI+4LwYfBW3e9BTY+kBfwztubf118AEufBVBxo8OcNva41lxowV9P9UOQrZegP+0AtlVgBRvbtNPXkzei5rWbFRICl50thGZKxBTuO35l4pq723nQook277mPFB0404Vs6JyVyAXrLbWjSngMcQbYWrmA0F3Bdd3ZXMdZ9Y1zL+wCTUnJss9wLIWhv52I/N8W7OEheFq7L0V08GVcLxO1cY3EJxSNlsKuHISHYRX+ASFeSW1glsuBpDmu1c6m7s9fXNd1HUB7ecl5U7V8VWq9iwabHnyUcgWQaSIrL5nWSUm8obgv0XM+375hrUAkJhDT/uuNpndaGDWgAHSnIfMDHRwA98T72wGNmutRXa6vg8r2Cds3SoBBy3bvuFeB4xhnWHSxQfUaBROyoRAGR6fycZ5q6d4JIskQP6E0c9sIAs8PnP0=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Uo6c/t4noq5ijHq++eCFiOz+fbmVvrp7GseW0VwgFbJlOVw9IXeCZmPL0Gh+rB6r+Qz7+w4Wl7qvd2ph/NTLq3UE9FMtgz7rTFK/VkSb51VSnnk9sCOSuX1BW45eIzPi0qK8GrIuMq18YmadUIT+KQtkppLXZxaPNC0WnQ1TJHxEyw2uR7o4cYz9DpxnimMQIzmwi0oAMAdyVcsajvUvufn05stiSdtyAZN7pU9dsGVc5WI5XFECl9nFPnXMBPtSaMpFoItsRNQlziMgJq66ysx3+eevbT5PG+C4r48DJKlyXaCNT1YKtHqzchv02aqymYhrSs9gQoD0iyuceo1ziKCmVkKXUEeLkCIBlf9eeWo0zB1d7m7MLqeiRvrc2mVtLStZ3EHHd9YlTPDn9CA8yyXF+W/AibD+bQtUtleH/Ojhi0GHDbz4pzR9KeKuwQLi
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2026 04:42:24.7565
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9067e584-0504-427a-11e4-08dea73c0a82
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B074.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8580
X-Rspamd-Queue-Id: 6B96C4AA5FE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-19831-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.994];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]

From: Moshe Shemesh <moshe@nvidia.com>

Several eswitch functions that only query other functions' HCA
capabilities or read cached vport state are guarded by the
vhca_resource_manager capability. This capability is required for
set_hca_cap operations but query_hca_cap of other functions only
requires the vport_group_manager capability.

Relax the capability check from vhca_resource_manager to
vport_group_manager in the following query-only paths:
- mlx5_esw_vport_caps_get() - queries other function general caps
- esw_ipsec_vf_query_generic() - queries other function ipsec cap
- mlx5_devlink_port_fn_migratable_get() - reads cached vport state
- mlx5_devlink_port_fn_roce_get() - reads cached vport state
- mlx5_devlink_port_fn_max_io_eqs_get() - queries other function caps
- mlx5_esw_vport_enable/disable() - vhca_id map/unmap

Functions that perform also set_hca_cap (migratable_set, roce_set,
max_io_eqs_set, esw_ipsec_vf_set_generic, esw_ipsec_vf_set_bytype)
retain the vhca_resource_manager requirement.

Signed-off-by: Moshe Shemesh <moshe@nvidia.com>
Reviewed-by: Akiva Goldberger <agoldberger@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/esw/ipsec.c    |  2 +-
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.c  |  6 +++---
 .../ethernet/mellanox/mlx5/core/eswitch_offloads.c | 14 ++++++++------
 3 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/ipsec.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/ipsec.c
index 8b12c3ae0cf7..4811b60ea430 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/ipsec.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/ipsec.c
@@ -12,7 +12,7 @@ static int esw_ipsec_vf_query_generic(struct mlx5_core_dev *dev, u16 vport_num,
 	void *hca_cap, *query_cap;
 	int err;
 
-	if (!MLX5_CAP_GEN(dev, vhca_resource_manager))
+	if (!MLX5_CAP_GEN(dev, vport_group_manager))
 		return -EOPNOTSUPP;
 
 	if (!mlx5_esw_ipsec_vf_offload_supported(dev)) {
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
index 66a773a99876..e0eafcf0c52a 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
@@ -806,7 +806,7 @@ static int mlx5_esw_vport_caps_get(struct mlx5_eswitch *esw, struct mlx5_vport *
 	void *hca_caps;
 	int err;
 
-	if (!MLX5_CAP_GEN(esw->dev, vhca_resource_manager))
+	if (!MLX5_CAP_GEN(esw->dev, vport_group_manager))
 		return 0;
 
 	query_ctx = kzalloc(query_out_sz, GFP_KERNEL);
@@ -938,7 +938,7 @@ int mlx5_esw_vport_enable(struct mlx5_eswitch *esw, struct mlx5_vport *vport,
 		vport->info.trusted = true;
 
 	if (!mlx5_esw_is_manager_vport(esw, vport_num) &&
-	    MLX5_CAP_GEN(esw->dev, vhca_resource_manager)) {
+	    MLX5_CAP_GEN(esw->dev, vport_group_manager)) {
 		ret = mlx5_esw_vport_vhca_id_map(esw, vport);
 		if (ret)
 			goto err_vhca_mapping;
@@ -976,7 +976,7 @@ void mlx5_esw_vport_disable(struct mlx5_eswitch *esw, struct mlx5_vport *vport)
 		arm_vport_context_events_cmd(esw->dev, vport_num, 0);
 
 	if (!mlx5_esw_is_manager_vport(esw, vport_num) &&
-	    MLX5_CAP_GEN(esw->dev, vhca_resource_manager))
+	    MLX5_CAP_GEN(esw->dev, vport_group_manager))
 		mlx5_esw_vport_vhca_id_unmap(esw, vport);
 
 	if (vport->vport != MLX5_VPORT_HOST_PF &&
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
index 69ddf56e2fc9..392d8f364db6 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
@@ -4677,8 +4677,9 @@ int mlx5_devlink_port_fn_migratable_get(struct devlink_port *port, bool *is_enab
 		return -EOPNOTSUPP;
 	}
 
-	if (!MLX5_CAP_GEN(esw->dev, vhca_resource_manager)) {
-		NL_SET_ERR_MSG_MOD(extack, "Device doesn't support VHCA management");
+	if (!MLX5_CAP_GEN(esw->dev, vport_group_manager)) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Device doesn't support vport group management");
 		return -EOPNOTSUPP;
 	}
 
@@ -4753,8 +4754,9 @@ int mlx5_devlink_port_fn_roce_get(struct devlink_port *port, bool *is_enabled,
 	struct mlx5_eswitch *esw = mlx5_devlink_eswitch_nocheck_get(port->devlink);
 	struct mlx5_vport *vport = mlx5_devlink_port_vport_get(port);
 
-	if (!MLX5_CAP_GEN(esw->dev, vhca_resource_manager)) {
-		NL_SET_ERR_MSG_MOD(extack, "Device doesn't support VHCA management");
+	if (!MLX5_CAP_GEN(esw->dev, vport_group_manager)) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Device doesn't support vport group management");
 		return -EOPNOTSUPP;
 	}
 
@@ -5076,9 +5078,9 @@ mlx5_devlink_port_fn_max_io_eqs_get(struct devlink_port *port, u32 *max_io_eqs,
 	int err;
 
 	esw = mlx5_devlink_eswitch_nocheck_get(port->devlink);
-	if (!MLX5_CAP_GEN(esw->dev, vhca_resource_manager)) {
+	if (!MLX5_CAP_GEN(esw->dev, vport_group_manager)) {
 		NL_SET_ERR_MSG_MOD(extack,
-				   "Device doesn't support VHCA management");
+				   "Device doesn't support vport group management");
 		return -EOPNOTSUPP;
 	}
 
-- 
2.44.0


