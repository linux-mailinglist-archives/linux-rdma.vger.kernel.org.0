Return-Path: <linux-rdma+bounces-21358-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4BaRJ6vrFmruvgcAu9opvQ
	(envelope-from <linux-rdma+bounces-21358-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 27 May 2026 15:03:39 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D7F865E48F6
	for <lists+linux-rdma@lfdr.de>; Wed, 27 May 2026 15:03:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2370F305157C
	for <lists+linux-rdma@lfdr.de>; Wed, 27 May 2026 12:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7212405C41;
	Wed, 27 May 2026 12:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lzv1gNA6"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012024.outbound.protection.outlook.com [40.107.200.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399073F39E3;
	Wed, 27 May 2026 12:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779886567; cv=fail; b=qHgqJYKXVSJk+AJwJdkTyLw5DbBe2tX+r//SJSZPKgVepqexeEHChTDknfMwpUGWrAguxWqYJFpDde6OJxt/6V8a18gcNgkco1jH+RXxuNrpFeB0lNnZ9hW0RIuIXa7Yu+4FL+PdG8cphPKeQRv4i2o8sKGRu5phpQaCfsejIxc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779886567; c=relaxed/simple;
	bh=MPb4EZ4cVLLwa0o0mpMqCCLeX5l3pd+5+2wEnfZqhj8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uBej4aVMtI3i+Mf+cg32lKGAehtDFX0bh/UJR7+muRxFXUJQzrb5xOVz8W5Ye/eas/R+e68V9TzUPzL+yhuWzKtoARWE0TfRyrwqlr1cw+sbUwfCSfvukOtJDYBAtzspXPkcMlfv+W0rrcIT4ULX3mJm7m++FLMhAqaEnGueeL0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lzv1gNA6; arc=fail smtp.client-ip=40.107.200.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CP6P/3ESNhcMAZ0mrKCaUXATfEllhcRsMUFdZGtSoHjnt8cHPRHYSwZDJpzodr06hRIggiWLyTrnyK9oA98uRrzG7AZgEiAhrEbeiADpP9sXMtyAd2uQEe+hUmwvFzJahFH+uCQ+zaBGeO/uKiekUpgCEi8AX5f0Yb907uE4rVtMrZnfQGqlM+dV8fn+IUoXAd+/ahy+8LyaQIvnY12TpC5T8SVHBbi4yTsPopFnIeNwLEP+2t18//pcMObXCy0gGdJD7ab0SPkGtcjAtsvXqoMxK1ZQu9eQLv0pzxoPJrkMf+NA1wHJYVmPngtWrwypstHAiFnAGozWumHAH1r+5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jiV8zS/IvAghqxk1dFGCb/zgebRpQBQu2mjlpCVBrb4=;
 b=WKAOwdnJbDf1k0oRcaRAfSUvw0FweqQnGxdG2SHrbTeZ6X8YkGGgnIc+DNYecEVYjNOJuQ0rwz97Sfj/OjQ52GBl6HereYbnDy3dee69GBSc/ikV6WkSd64KhglNHHGwCmH/ouaQeFdi8TNZi388K/Pa6LH7LmouVpi1HLKaLtm7pD3zyKIkRxdnU8HPHcYEiBHiRCx1+DweAnLyIn4AgcUa8wAYcyMQZfFINUSpN230er8X9tWcLn/JfoK2u6DA3FR23btR6iicUokWBIa6DRmUmZs8WsN1czzCeZBUE6xln24gLRy8cNdB7vf7MenDdZQ6SbiPu8/ZB5JbfHIGXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jiV8zS/IvAghqxk1dFGCb/zgebRpQBQu2mjlpCVBrb4=;
 b=lzv1gNA6GPrPDnfgA8jx61ZXamw3j7xVzAmYR6R4iTEY9cpR2upkkNIZoYUFwJGOvVeHjH2R+W/fWdnQQmes1A/syWcLf62ZcJXs1D4JJ1Rh5usnulzqsKsboHacWuhjBkmOWS5jdd0GWLA3LBj4KEDJo06wV/hup8uBO2+/ojtswinPLY+QhUMg7Xathv8H6s5aI8CvlRPmN1ODnAHhU97QTRJP28WClkiWMDTIlA10Xdq2jQEU2F/qDne3eDhzpXXt+A/snEw9xzA5NSRyO8dW2viDUfu/GdlxVZEVfsPt1q+nzlFd2RMug33LUpBYJkn2xCfbP1fIlPhwTqU+Ow==
Received: from BLAPR03CA0039.namprd03.prod.outlook.com (2603:10b6:208:32d::14)
 by CY8PR12MB7491.namprd12.prod.outlook.com (2603:10b6:930:92::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Wed, 27 May
 2026 12:55:55 +0000
Received: from BL6PEPF0001AB73.namprd02.prod.outlook.com
 (2603:10b6:208:32d:cafe::23) by BLAPR03CA0039.outlook.office365.com
 (2603:10b6:208:32d::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.12 via Frontend Transport; Wed, 27
 May 2026 12:55:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL6PEPF0001AB73.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Wed, 27 May 2026 12:55:54 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 27 May
 2026 05:55:41 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 27 May 2026 05:55:40 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 27 May 2026 05:55:35 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Nimrod Oren
	<noren@nvidia.com>, Yael Chemla <ychemla@nvidia.com>, Shay Drory
	<shayd@nvidia.com>, Or Har-Toov <ohartoov@nvidia.com>, Edward Srouji
	<edwards@nvidia.com>, Maher Sanalla <msanalla@nvidia.com>, Simon Horman
	<horms@kernel.org>, Parav Pandit <parav@nvidia.com>, Patrisious Haddad
	<phaddad@nvidia.com>, Kees Cook <kees@kernel.org>, Moshe Shemesh
	<moshe@nvidia.com>, <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, Gal Pressman <gal@nvidia.com>
Subject: [PATCH net-next 06/13] net/mlx5: LAG, extend shared FDB API with group_id filter
Date: Wed, 27 May 2026 15:54:20 +0300
Message-ID: <20260527125427.385976-7-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260527125427.385976-1-tariqt@nvidia.com>
References: <20260527125427.385976-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB73:EE_|CY8PR12MB7491:EE_
X-MS-Office365-Filtering-Correlation-Id: e8c72a3e-92fa-454b-eb79-08debbef4a19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|7416014|376014|1800799024|11063799006|56012099006|6133799003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	2HpjEIzDEfqIrnC5jfW+BIcYQcwdv9XoongoPXAP1FUwdeFyCeWiIfjOQIq0wk5zG5wOfHauTSFbsW+LVAsolsKEltFt52awqi8jAVvviAHexdskD8D4QdcIxRnb0was5nHz+ikWdCPrtjo3DK8RnCwREwsHEHy0e4IFiTNDh6Dr9fHsEzpnX+a8o9icD5Jshky0W112jHGcZ1DCnbgtQdkZ+RotwrZoFdjRjhoWr21BfEbY7aHDMmPluKat/4Mx1lLtdkTYbjLD+eoBh4g/YYURFsLXKrk1GYhFrOHTrzA0t4ZFtAqYgl8h6ZciJNW0L+LCtRclEOVn3EJoIsODFawVW2TdCwBk65hT36bzjqFBsZT8SpMQ7CorFMqU9qdLw/Z1kdUfVFzI+maE5miySHiGw7jGVIgj0FTSVhQ15mxVT3kAhemeK9KPAEQrwW1prRr/40uw1oslxzHQtg7PstPIER7hLBGySOWRjzJ9wXXcpSezo0/W9nCmEWUn7NKnovQMNRYSHJu8cMXiC1hQEK2DTFhZx9Z9D0G/tOQ6fxlv1eBvib97dODYNHqjPVOeu4P5HMGTki3Ain1WStwy9U+C2zlWjw1vI7/lWBGCGqPv4fnqiGHkJogQZqmsXmgH9FplerBqdlmlXE3HcGqGN/zKjjmgBLCrTs2IOU3YfjeuFHP5qld6zoqvYXdKonUuuzdpXJM2GAlro+DO5DIkwas+Jkt6YzDQCw4si6/Y680=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(7416014)(376014)(1800799024)(11063799006)(56012099006)(6133799003)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	dKZP5IWS+koCHu8i2kHA8y+sYgYNv+LEqyBkjX902D0Mwf4WtoTvJkNuDoOAA/HyUn9EYykDhFi4u/6myxJnP5a9kRs25n3wN7yTOSRHgsYnbcPKPqBnPKLViNNL3LChIWbWcWeEuBWD2wiKXm3n+vhqMtn6IIn/qsPFVeGHbXF/zHgzFLtmXR7PYl1TT2RKZzpPd+KiAZU734uWnKY14fb6Hszvib1BNh1NtpHTMErTQImmffMF5U/IMQ/MN6B+R82Ac2tt5xc6kFYa9rNC90F4qW1PcsfJ1bauWk/Ob42wCP9iaYItQCbF0UVueFKcNi8aV8Vussy0LFHrQmzEuNs0FPhrj7ZvhwkD9KEBjr3P0uuLinXIJttfhYBv1lT/Y0iRby05BI69gzlcFWhl2SfYj25WLMT7DZOAOM2LcpyKVEnQ+E5MSmuhZGhIdw7q
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 12:55:54.5999
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e8c72a3e-92fa-454b-eb79-08debbef4a19
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB73.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7491
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21358-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.996];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: D7F865E48F6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Shay Drory <shayd@nvidia.com>

Add a group_id parameter to mlx5_lag_shared_fdb_create() and
mlx5_lag_shared_fdb_destroy() to scope shared FDB operations to a
specific SD group.

When group_id is U32_MAX, the functions operate on all LAG devices. When
group_id is non-zero, they operate only on devices in that SD group
without issuing FW LAG commands, since SD LAG is a pure software
construct.

Signed-off-by: Shay Drory <shayd@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/lag/lag.c | 195 ++++++++++++++----
 .../net/ethernet/mellanox/mlx5/core/lag/lag.h |  32 ++-
 .../ethernet/mellanox/mlx5/core/lag/mpesw.c   |   7 +-
 .../mellanox/mlx5/core/lag/shared_fdb.c       | 151 +++++++++++---
 .../net/ethernet/mellanox/mlx5/core/lib/sd.c  |  10 +
 .../net/ethernet/mellanox/mlx5/core/lib/sd.h  |  10 +
 6 files changed, 322 insertions(+), 83 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
index 03cb02c7000d..3decb49e9f19 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
@@ -370,6 +370,22 @@ int mlx5_lag_get_dev_index_by_seq(struct mlx5_lag *ldev, int seq)
 	return -ENOENT;
 }
 
+/* Return the appropriate iterator filter for a device in LAG:
+ * - SD shared FDB active: iterate only the device's SD group
+ * - SD group exists but shared FDB not active: iterate all devices
+ * - No SD: iterate ports only
+ */
+static u32 mlx5_lag_get_filter(struct mlx5_lag *ldev, struct mlx5_core_dev *dev)
+{
+	struct lag_func *pf = mlx5_lag_pf_by_dev(ldev, dev);
+
+	if (pf && pf->sd_fdb_active)
+		return pf->group_id;
+	if (pf && pf->group_id)
+		return MLX5_LAG_FILTER_ALL;
+	return MLX5_LAG_FILTER_PORTS;
+}
+
 /* Reverse of mlx5_lag_get_dev_index_by_seq: given a device, return its
  * sequence number in the LAG. Master is always 0, others numbered
  * sequentially starting from 1.
@@ -379,11 +395,13 @@ int mlx5_lag_get_dev_seq(struct mlx5_core_dev *dev)
 	struct mlx5_lag *ldev = mlx5_lag_dev(dev);
 	int master_idx, i, num = 1;
 	struct lag_func *pf;
+	u32 filter;
 
 	if (!ldev)
 		return -ENOENT;
 
-	master_idx = mlx5_lag_get_master_idx(ldev);
+	filter = mlx5_lag_get_filter(ldev, dev);
+	master_idx = mlx5_lag_get_dev_index_by_seq_filter(ldev, 0, filter);
 	if (master_idx < 0)
 		return -ENOENT;
 
@@ -391,7 +409,7 @@ int mlx5_lag_get_dev_seq(struct mlx5_core_dev *dev)
 	if (pf && pf->dev == dev)
 		return 0;
 
-	mlx5_lag_for_each(i, 0, ldev, MLX5_LAG_FILTER_ALL) {
+	mlx5_lag_for_each(i, 0, ldev, filter) {
 		if (i == master_idx)
 			continue;
 		pf = mlx5_lag_pf(ldev, i);
@@ -403,6 +421,69 @@ int mlx5_lag_get_dev_seq(struct mlx5_core_dev *dev)
 }
 EXPORT_SYMBOL(mlx5_lag_get_dev_seq);
 
+/* seq 0 = master, then all remaining devices */
+static int mlx5_lag_get_dev_index_by_seq_all(struct mlx5_lag *ldev, int seq)
+{
+	int master_idx, i, num = 0;
+
+	master_idx = mlx5_lag_get_master_idx(ldev);
+
+	if (master_idx >= 0) {
+		if (seq == 0)
+			return master_idx;
+		num++;
+	}
+
+	mlx5_lag_for_each(i, 0, ldev, MLX5_LAG_FILTER_ALL) {
+		if (i == master_idx)
+			continue;
+		if (num == seq)
+			return i;
+		num++;
+	}
+	return -ENOENT;
+}
+
+/* From group POV, port-marked entry is the lag master */
+static int mlx5_lag_get_dev_index_by_seq_group(struct mlx5_lag *ldev, int seq,
+					       u32 group_id)
+{
+	int i, num = 0;
+
+	mlx5_lag_for_each(i, 0, ldev, group_id) {
+		if (xa_get_mark(&ldev->pfs, i, MLX5_LAG_XA_MARK_PORT)) {
+			if (seq == 0)
+				return i;
+			num++;
+			break;
+		}
+	}
+
+	mlx5_lag_for_each(i, 0, ldev, group_id) {
+		if (xa_get_mark(&ldev->pfs, i, MLX5_LAG_XA_MARK_PORT))
+			continue;
+		if (num == seq)
+			return i;
+		num++;
+	}
+	return -ENOENT;
+}
+
+int mlx5_lag_get_dev_index_by_seq_filter(struct mlx5_lag *ldev, int seq,
+					 u32 filter)
+{
+	if (!ldev)
+		return -ENOENT;
+
+	if (!filter || filter == MLX5_LAG_FILTER_PORTS)
+		return mlx5_lag_get_dev_index_by_seq(ldev, seq);
+
+	if (filter == MLX5_LAG_FILTER_ALL)
+		return mlx5_lag_get_dev_index_by_seq_all(ldev, seq);
+
+	return mlx5_lag_get_dev_index_by_seq_group(ldev, seq, filter);
+}
+
 /* Devcom events for LAG master marking */
 #define LAG_DEVCOM_PAIR		(0)
 #define LAG_DEVCOM_UNPAIR	(1)
@@ -512,6 +593,14 @@ static bool __mlx5_lag_is_sriov(struct mlx5_lag *ldev)
 	return ldev->mode == MLX5_LAG_MODE_SRIOV;
 }
 
+static bool __mlx5_lag_is_sd_active(struct mlx5_lag *ldev,
+				    struct mlx5_core_dev *dev)
+{
+	struct lag_func *pf = mlx5_lag_pf_by_dev(ldev, dev);
+
+	return pf && pf->sd_fdb_active;
+}
+
 /* Create a mapping between steering slots and active ports.
  * As we have ldev->buckets slots per port first assume the native
  * mapping should be used.
@@ -927,27 +1016,19 @@ int mlx5_deactivate_lag(struct mlx5_lag *ldev)
 	u32 in[MLX5_ST_SZ_DW(destroy_lag_in)] = {};
 	bool roce_lag = __mlx5_lag_is_roce(ldev);
 	unsigned long flags = ldev->mode_flags;
-	struct mlx5_eswitch *master_esw;
 	struct mlx5_core_dev *dev0;
 	int err;
-	int i;
 
 	if (master_idx < 0)
 		return -EINVAL;
 
 	dev0 = mlx5_lag_pf(ldev, master_idx)->dev;
-	master_esw = dev0->priv.eswitch;
 	ldev->mode = MLX5_LAG_MODE_NONE;
 	ldev->mode_flags = 0;
 	mlx5_lag_mp_reset(ldev);
 
 	if (test_bit(MLX5_LAG_MODE_FLAG_SHARED_FDB, &flags)) {
-		mlx5_ldev_for_each(i, 0, ldev) {
-			if (i == master_idx)
-				continue;
-			mlx5_eswitch_offloads_single_fdb_del_one(master_esw,
-								 mlx5_lag_pf(ldev, i)->dev->priv.eswitch);
-		}
+		mlx5_lag_destroy_single_fdb(ldev);
 		clear_bit(MLX5_LAG_MODE_FLAG_SHARED_FDB, &flags);
 	}
 
@@ -1026,7 +1107,7 @@ bool mlx5_lag_check_prereq(struct mlx5_lag *ldev)
 	return true;
 }
 
-static void mlx5_lag_assert_locked_transition(struct mlx5_lag *ldev)
+static void mlx5_lag_assert_locked_transition(struct mlx5_lag *ldev, u32 filter)
 {
 	struct mlx5_devcom_comp_dev *devcom = NULL;
 	struct lag_func *pf;
@@ -1034,17 +1115,21 @@ static void mlx5_lag_assert_locked_transition(struct mlx5_lag *ldev)
 
 	lockdep_assert_held(&ldev->lock);
 
-	i = mlx5_get_next_lag_func(ldev, 0, MLX5_LAG_FILTER_PORTS);
+	i = mlx5_get_next_lag_func(ldev, 0, filter);
 	if (i < MLX5_MAX_PORTS) {
 		pf = mlx5_lag_pf(ldev, i);
-		devcom = pf->dev->priv.hca_devcom_comp;
+		if (filter == MLX5_LAG_FILTER_PORTS ||
+		    filter == MLX5_LAG_FILTER_ALL)
+			devcom = pf->dev->priv.hca_devcom_comp;
+		else
+			devcom = mlx5_sd_get_devcom(pf->dev);
 	}
 	mlx5_devcom_comp_assert_locked(devcom);
 }
 
-static void mlx5_lag_drop_lock_for_reps(struct mlx5_lag *ldev)
+static void mlx5_lag_drop_lock_for_reps(struct mlx5_lag *ldev, u32 filter)
 {
-	mlx5_lag_assert_locked_transition(ldev);
+	mlx5_lag_assert_locked_transition(ldev, filter);
 
 	/* Keep PF membership stable while ldev->lock is dropped. Device add
 	 * and remove paths observe mode_changes_in_progress and retry.
@@ -1075,21 +1160,22 @@ void mlx5_lag_rescan_dev_locked(struct mlx5_lag *ldev,
 	 * callbacks and take reps_lock. Drop ldev->lock so the only ordering
 	 * remains reps_lock -> ldev->lock from representor callbacks.
 	 */
-	mlx5_lag_drop_lock_for_reps(ldev);
+	mlx5_lag_drop_lock_for_reps(ldev, mlx5_lag_get_filter(ldev, dev));
 	mlx5_rescan_drivers_locked(dev);
 	mlx5_lag_retake_lock_after_reps(ldev);
 }
 
-static void mlx5_lag_rescan_devices_locked(struct mlx5_lag *ldev, bool enable)
+static void mlx5_lag_rescan_devices_locked_filter(struct mlx5_lag *ldev,
+						  bool enable, u32 filter)
 {
 	struct mlx5_core_dev *devs[MLX5_MAX_PORTS];
 	struct lag_func *pf;
 	int num_devs = 0;
 	int i;
 
-	mlx5_lag_assert_locked_transition(ldev);
+	mlx5_lag_assert_locked_transition(ldev, filter);
 
-	mlx5_ldev_for_each(i, 0, ldev) {
+	mlx5_lag_for_each(i, 0, ldev, filter) {
 		pf = mlx5_lag_pf(ldev, i);
 		if (pf->dev->priv.flags & MLX5_PRIV_FLAGS_DISABLE_ALL_ADEV)
 			continue;
@@ -1101,30 +1187,40 @@ static void mlx5_lag_rescan_devices_locked(struct mlx5_lag *ldev, bool enable)
 		devs[num_devs++] = pf->dev;
 	}
 
-	mlx5_lag_drop_lock_for_reps(ldev);
+	mlx5_lag_drop_lock_for_reps(ldev, filter);
 	for (i = 0; i < num_devs; i++)
 		mlx5_rescan_drivers_locked(devs[i]);
 	mlx5_lag_retake_lock_after_reps(ldev);
 }
 
+void mlx5_lag_add_devices_filter(struct mlx5_lag *ldev, u32 filter)
+{
+	mlx5_lag_rescan_devices_locked_filter(ldev, true, filter);
+}
+
 void mlx5_lag_add_devices(struct mlx5_lag *ldev)
 {
-	mlx5_lag_rescan_devices_locked(ldev, true);
+	mlx5_lag_add_devices_filter(ldev, MLX5_LAG_FILTER_PORTS);
+}
+
+void mlx5_lag_remove_devices_filter(struct mlx5_lag *ldev, u32 filter)
+{
+	mlx5_lag_rescan_devices_locked_filter(ldev, false, filter);
 }
 
 void mlx5_lag_remove_devices(struct mlx5_lag *ldev)
 {
-	mlx5_lag_rescan_devices_locked(ldev, false);
+	mlx5_lag_remove_devices_filter(ldev, MLX5_LAG_FILTER_PORTS);
 }
 
 static int mlx5_lag_reload_ib_reps_unlocked(struct mlx5_lag *ldev, u32 flags,
-					    bool cont_on_fail)
+					    u32 filter, bool cont_on_fail)
 {
 	struct lag_func *pf;
 	int ret;
 	int i;
 
-	mlx5_ldev_for_each(i, 0, ldev) {
+	mlx5_lag_for_each(i, 0, ldev, filter) {
 		pf = mlx5_lag_pf(ldev, i);
 		if (!(pf->dev->priv.flags & flags)) {
 			struct mlx5_eswitch *esw;
@@ -1142,7 +1238,7 @@ static int mlx5_lag_reload_ib_reps_unlocked(struct mlx5_lag *ldev, u32 flags,
 }
 
 static int mlx5_lag_reload_ib_reps(struct mlx5_lag *ldev, u32 flags,
-				   bool cont_on_fail)
+				   u32 filter, bool cont_on_fail)
 {
 	int ret;
 
@@ -1152,21 +1248,18 @@ static int mlx5_lag_reload_ib_reps(struct mlx5_lag *ldev, u32 flags,
 	 * load/unload callbacks can re-enter LAG netdev add/remove and take
 	 * ldev->lock. Keep the ordering reps_lock -> ldev->lock.
 	 */
-	mlx5_lag_drop_lock_for_reps(ldev);
-	ret = mlx5_lag_reload_ib_reps_unlocked(ldev, flags, cont_on_fail);
+	mlx5_lag_drop_lock_for_reps(ldev, filter);
+	ret = mlx5_lag_reload_ib_reps_unlocked(ldev, flags, filter,
+					       cont_on_fail);
 	mlx5_lag_retake_lock_after_reps(ldev);
 
 	return ret;
 }
 
 int mlx5_lag_reload_ib_reps_from_locked(struct mlx5_lag *ldev, u32 flags,
-					bool cont_on_fail)
+					u32 filter, bool cont_on_fail)
 {
-	int ret;
-
-	ret = mlx5_lag_reload_ib_reps(ldev, flags, cont_on_fail);
-
-	return ret;
+	return mlx5_lag_reload_ib_reps(ldev, flags, filter, cont_on_fail);
 }
 
 void mlx5_disable_lag(struct mlx5_lag *ldev)
@@ -1182,7 +1275,7 @@ void mlx5_disable_lag(struct mlx5_lag *ldev)
 		return;
 
 	if (shared_fdb) {
-		mlx5_lag_shared_fdb_destroy(ldev);
+		mlx5_lag_shared_fdb_destroy(ldev, 0);
 		return;
 	}
 
@@ -1420,7 +1513,8 @@ static void mlx5_do_bond(struct mlx5_lag *ldev)
 
 		if (shared_fdb) {
 			err = mlx5_lag_shared_fdb_create(ldev, &tracker,
-							 MLX5_LAG_MODE_SRIOV);
+							 MLX5_LAG_MODE_SRIOV,
+							 0);
 			if (err)
 				return;
 		} else {
@@ -2261,7 +2355,8 @@ bool mlx5_lag_is_active(struct mlx5_core_dev *dev)
 
 	spin_lock_irqsave(&lag_lock, flags);
 	ldev = mlx5_lag_dev(dev);
-	res  = ldev && __mlx5_lag_is_active(ldev);
+	res  = ldev && (__mlx5_lag_is_active(ldev) ||
+			__mlx5_lag_is_sd_active(ldev, dev));
 	spin_unlock_irqrestore(&lag_lock, flags);
 
 	return res;
@@ -2294,10 +2389,17 @@ bool mlx5_lag_is_master(struct mlx5_core_dev *dev)
 
 	spin_lock_irqsave(&lag_lock, flags);
 	ldev = mlx5_lag_dev(dev);
-	idx = mlx5_lag_get_dev_index_by_seq(ldev, MLX5_LAG_P1);
-	if (ldev && __mlx5_lag_is_active(ldev) && idx >= 0) {
-		pf = mlx5_lag_pf(ldev, idx);
-		res = pf && dev == pf->dev;
+	if (ldev) {
+		u32 filter;
+
+		filter = mlx5_lag_get_filter(ldev, dev);
+		idx = mlx5_lag_get_dev_index_by_seq_filter(ldev, MLX5_LAG_P1,
+							   filter);
+		if ((__mlx5_lag_is_active(ldev) ||
+		     __mlx5_lag_is_sd_active(ldev, dev)) && idx >= 0) {
+			pf = mlx5_lag_pf(ldev, idx);
+			res = pf && dev == pf->dev;
+		}
 	}
 	spin_unlock_irqrestore(&lag_lock, flags);
 
@@ -2324,11 +2426,16 @@ bool mlx5_lag_is_shared_fdb(struct mlx5_core_dev *dev)
 {
 	struct mlx5_lag *ldev;
 	unsigned long flags;
-	bool res;
+	bool res = false;
 
 	spin_lock_irqsave(&lag_lock, flags);
 	ldev = mlx5_lag_dev(dev);
-	res = ldev && test_bit(MLX5_LAG_MODE_FLAG_SHARED_FDB, &ldev->mode_flags);
+	if (ldev) {
+		res = test_bit(MLX5_LAG_MODE_FLAG_SHARED_FDB,
+			       &ldev->mode_flags);
+		if (__mlx5_lag_is_sd(ldev, dev) && !__mlx5_lag_is_active(ldev))
+			res = __mlx5_lag_is_sd_active(ldev, dev);
+	}
 	spin_unlock_irqrestore(&lag_lock, flags);
 
 	return res;
@@ -2429,7 +2536,7 @@ struct mlx5_core_dev *mlx5_lag_get_next_peer_mdev(struct mlx5_core_dev *dev, int
 
 	if (*i == MLX5_MAX_PORTS)
 		goto unlock;
-	mlx5_ldev_for_each(idx, *i, ldev) {
+	mlx5_lag_for_each(idx, *i, ldev, mlx5_lag_get_filter(ldev, dev)) {
 		pf = mlx5_lag_pf(ldev, idx);
 		if (pf->dev != dev)
 			break;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.h b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.h
index 70baa7997364..cbe201529661 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.h
@@ -148,6 +148,14 @@ mlx5_lag_pf_by_dev(struct mlx5_lag *ldev, struct mlx5_core_dev *dev)
 	return NULL;
 }
 
+static inline bool
+__mlx5_lag_is_sd(struct mlx5_lag *ldev, struct mlx5_core_dev *dev)
+{
+	struct lag_func *pf = mlx5_lag_pf_by_dev(ldev, dev);
+
+	return pf && pf->group_id != 0;
+}
+
 static inline bool
 __mlx5_lag_is_active(struct mlx5_lag *ldev)
 {
@@ -163,25 +171,31 @@ mlx5_lag_is_ready(struct mlx5_lag *ldev)
 #ifdef CONFIG_MLX5_ESWITCH
 int mlx5_lag_shared_fdb_create(struct mlx5_lag *ldev,
 			       struct lag_tracker *tracker,
-			       enum mlx5_lag_mode mode);
-void mlx5_lag_shared_fdb_destroy(struct mlx5_lag *ldev);
+			       enum mlx5_lag_mode mode,
+			       u32 group_id);
+void mlx5_lag_shared_fdb_destroy(struct mlx5_lag *ldev, u32 group_id);
 int mlx5_lag_create_single_fdb(struct mlx5_lag *ldev);
+void mlx5_lag_destroy_single_fdb(struct mlx5_lag *ldev);
 bool mlx5_lag_shared_fdb_supported(struct mlx5_lag *ldev);
+bool mlx5_lag_shared_fdb_supported_filter(struct mlx5_lag *ldev, u32 filter);
 #else
 static inline int mlx5_lag_shared_fdb_create(struct mlx5_lag *ldev,
 					     struct lag_tracker *tracker,
-					     enum mlx5_lag_mode mode)
+					     enum mlx5_lag_mode mode,
+					     u32 group_id)
 {
 	return -EOPNOTSUPP;
 }
 
-static inline void mlx5_lag_shared_fdb_destroy(struct mlx5_lag *ldev) {}
+static inline void mlx5_lag_shared_fdb_destroy(struct mlx5_lag *ldev,
+					       u32 group_id) {}
 
 static inline int mlx5_lag_create_single_fdb(struct mlx5_lag *ldev)
 {
 	return -EOPNOTSUPP;
 }
 
+static inline void mlx5_lag_destroy_single_fdb(struct mlx5_lag *ldev) {}
 static inline bool mlx5_lag_shared_fdb_supported(struct mlx5_lag *ldev)
 {
 	return false;
@@ -211,11 +225,13 @@ void mlx5_ldev_add_debugfs(struct mlx5_core_dev *dev);
 void mlx5_ldev_remove_debugfs(struct dentry *dbg);
 void mlx5_disable_lag(struct mlx5_lag *ldev);
 void mlx5_lag_remove_devices(struct mlx5_lag *ldev);
+void mlx5_lag_remove_devices_filter(struct mlx5_lag *ldev, u32 filter);
 int mlx5_deactivate_lag(struct mlx5_lag *ldev);
 void mlx5_lag_add_devices(struct mlx5_lag *ldev);
 void mlx5_lag_rescan_dev_locked(struct mlx5_lag *ldev,
 				struct mlx5_core_dev *dev,
 				bool enable);
+void mlx5_lag_add_devices_filter(struct mlx5_lag *ldev, u32 filter);
 struct mlx5_devcom_comp_dev *mlx5_lag_get_devcom_comp(struct mlx5_lag *ldev);
 
 #ifdef CONFIG_MLX5_ESWITCH
@@ -238,8 +254,8 @@ static inline bool mlx5_lag_is_supported(struct mlx5_core_dev *dev)
 }
 
 /* Iterator filter constants for mlx5_lag_for_each() */
-#define MLX5_LAG_FILTER_ALL   0        /* iterate ALL devices */
-#define MLX5_LAG_FILTER_PORTS U32_MAX  /* iterate ports only (XA_MARK_PORT) */
+#define MLX5_LAG_FILTER_PORTS 0        /* iterate ports only (XA_MARK_PORT) */
+#define MLX5_LAG_FILTER_ALL   U32_MAX  /* iterate ALL devices */
 /* any other value = iterate devices with that specific group_id */
 
 #define mlx5_lag_for_each(i, start_index, ldev, filter) \
@@ -264,10 +280,12 @@ int mlx5_get_pre_lag_func(struct mlx5_lag *ldev, int start_idx, int end_idx,
 			  u32 filter);
 int mlx5_get_next_lag_func(struct mlx5_lag *ldev, int start_idx, u32 filter);
 int mlx5_lag_get_dev_index_by_seq(struct mlx5_lag *ldev, int seq);
+int mlx5_lag_get_dev_index_by_seq_filter(struct mlx5_lag *ldev, int seq,
+					 u32 filter);
 int mlx5_lag_num_devs(struct mlx5_lag *ldev);
 int mlx5_lag_num_netdevs(struct mlx5_lag *ldev);
 int mlx5_lag_reload_ib_reps_from_locked(struct mlx5_lag *ldev, u32 flags,
-					bool cont_on_fail);
+					u32 filter, bool cont_on_fail);
 int mlx5_ldev_add_mdev(struct mlx5_lag *ldev, struct mlx5_core_dev *dev,
 		       u32 group_id);
 void mlx5_ldev_remove_mdev(struct mlx5_lag *ldev, struct mlx5_core_dev *dev);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/mpesw.c b/drivers/net/ethernet/mellanox/mlx5/core/lag/mpesw.c
index 64e2d1dd5308..2cb44084e239 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lag/mpesw.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/mpesw.c
@@ -85,14 +85,15 @@ static int mlx5_lag_enable_mpesw(struct mlx5_lag *ldev)
 	    !MLX5_CAP_PORT_SELECTION(dev0, port_select_flow_table) ||
 	    !MLX5_CAP_GEN(dev0, create_lag_when_not_master_up) ||
 	    !mlx5_lag_check_prereq(ldev) ||
-	    !mlx5_lag_shared_fdb_supported(ldev))
+	    !mlx5_lag_shared_fdb_supported_filter(ldev, MLX5_LAG_FILTER_ALL))
 		return -EOPNOTSUPP;
 
 	err = mlx5_mpesw_metadata_set(ldev);
 	if (err)
 		return err;
 
-	err = mlx5_lag_shared_fdb_create(ldev, NULL, MLX5_LAG_MODE_MPESW);
+	err = mlx5_lag_shared_fdb_create(ldev, NULL, MLX5_LAG_MODE_MPESW,
+					 MLX5_LAG_FILTER_ALL);
 	if (err) {
 		mlx5_core_warn(dev0, "Failed to create LAG in MPESW mode (%d)\n", err);
 		mlx5_mpesw_metadata_cleanup(ldev);
@@ -106,7 +107,7 @@ void mlx5_lag_disable_mpesw(struct mlx5_lag *ldev)
 {
 	if (ldev->mode == MLX5_LAG_MODE_MPESW) {
 		mlx5_mpesw_metadata_cleanup(ldev);
-		mlx5_lag_shared_fdb_destroy(ldev);
+		mlx5_lag_shared_fdb_destroy(ldev, MLX5_LAG_FILTER_ALL);
 	}
 }
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/shared_fdb.c b/drivers/net/ethernet/mellanox/mlx5/core/lag/shared_fdb.c
index b5cbe3409720..74d17664f54c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lag/shared_fdb.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/shared_fdb.c
@@ -8,19 +8,19 @@
 #include "lag.h"
 #include "eswitch.h"
 
-bool mlx5_lag_shared_fdb_supported(struct mlx5_lag *ldev)
+bool mlx5_lag_shared_fdb_supported_filter(struct mlx5_lag *ldev, u32 filter)
 {
+	int idx = mlx5_lag_get_dev_index_by_seq_filter(ldev, MLX5_LAG_P1,
+						       filter);
 	struct mlx5_core_dev *dev0, *dev;
 	bool ret = false;
-	int idx;
 	int i;
 
-	idx = mlx5_lag_get_dev_index_by_seq(ldev, MLX5_LAG_P1);
 	if (idx < 0)
 		return false;
 
 	dev0 = mlx5_lag_pf(ldev, idx)->dev;
-	mlx5_ldev_for_each(i, 0, ldev) {
+	mlx5_lag_for_each(i, 0, ldev, filter) {
 		if (i == idx)
 			continue;
 		dev = mlx5_lag_pf(ldev, i)->dev;
@@ -42,9 +42,16 @@ bool mlx5_lag_shared_fdb_supported(struct mlx5_lag *ldev)
 	return ret;
 }
 
-int mlx5_lag_create_single_fdb(struct mlx5_lag *ldev)
+bool mlx5_lag_shared_fdb_supported(struct mlx5_lag *ldev)
 {
-	int master_idx = mlx5_lag_get_dev_index_by_seq(ldev, MLX5_LAG_P1);
+	return mlx5_lag_shared_fdb_supported_filter(ldev,
+						    MLX5_LAG_FILTER_PORTS);
+}
+
+static int mlx5_lag_create_single_fdb_filter(struct mlx5_lag *ldev, u32 filter)
+{
+	int master_idx = mlx5_lag_get_dev_index_by_seq_filter(ldev, MLX5_LAG_P1,
+							     filter);
 	struct mlx5_eswitch *master_esw;
 	struct mlx5_core_dev *dev0;
 	int i, j;
@@ -55,7 +62,7 @@ int mlx5_lag_create_single_fdb(struct mlx5_lag *ldev)
 
 	dev0 = mlx5_lag_pf(ldev, master_idx)->dev;
 	master_esw = dev0->priv.eswitch;
-	mlx5_ldev_for_each(i, 0, ldev) {
+	mlx5_lag_for_each(i, 0, ldev, filter) {
 		struct mlx5_eswitch *slave_esw;
 
 		if (i == master_idx)
@@ -71,7 +78,7 @@ int mlx5_lag_create_single_fdb(struct mlx5_lag *ldev)
 	}
 	return 0;
 err:
-	mlx5_ldev_for_each_reverse(j, i, 0, ldev) {
+	mlx5_lag_for_each_reverse(j, i, 0, ldev, filter) {
 		struct mlx5_eswitch *slave_esw;
 
 		if (j == master_idx)
@@ -82,59 +89,145 @@ int mlx5_lag_create_single_fdb(struct mlx5_lag *ldev)
 	return err;
 }
 
+static void mlx5_lag_destroy_single_fdb_filter(struct mlx5_lag *ldev,
+					       u32 filter)
+{
+	int master_idx = mlx5_lag_get_dev_index_by_seq_filter(ldev, MLX5_LAG_P1,
+							     filter);
+	struct mlx5_eswitch *master_esw;
+	struct mlx5_eswitch *peer_esw;
+	int i;
+
+	if (master_idx < 0)
+		return;
+
+	master_esw = mlx5_lag_pf(ldev, master_idx)->dev->priv.eswitch;
+	mlx5_lag_for_each(i, 0, ldev, filter) {
+		if (i == master_idx)
+			continue;
+
+		peer_esw = mlx5_lag_pf(ldev, i)->dev->priv.eswitch;
+		mlx5_eswitch_offloads_single_fdb_del_one(master_esw, peer_esw);
+	}
+}
+
+int mlx5_lag_create_single_fdb(struct mlx5_lag *ldev)
+{
+	return mlx5_lag_create_single_fdb_filter(ldev, MLX5_LAG_FILTER_ALL);
+}
+
+void mlx5_lag_destroy_single_fdb(struct mlx5_lag *ldev)
+{
+	mlx5_lag_destroy_single_fdb_filter(ldev, MLX5_LAG_FILTER_ALL);
+}
+
+/**
+ * mlx5_lag_shared_fdb_create - Create shared FDB LAG
+ * @ldev: LAG device
+ * @tracker: LAG tracker (NULL for SD)
+ * @mode: LAG mode (unused for SD)
+ * @group_id: SD group ID; 0 (MLX5_LAG_FILTER_PORTS) for ports LAG;
+ *            MLX5_LAG_FILTER_ALL for all-device (mpesw) LAG
+ *
+ * When group_id is 0 (MLX5_LAG_FILTER_PORTS) or MLX5_LAG_FILTER_ALL,
+ * activates a FW LAG with shared FDB.
+ * When group_id is a specific SD group ID, creates a software-only shared
+ * FDB scoped to that group (no FW LAG commands).
+ */
 int mlx5_lag_shared_fdb_create(struct mlx5_lag *ldev,
 			       struct lag_tracker *tracker,
-			       enum mlx5_lag_mode mode)
+			       enum mlx5_lag_mode mode,
+			       u32 group_id)
 {
-	int idx = mlx5_lag_get_dev_index_by_seq(ldev, MLX5_LAG_P1);
+	u32 filter = group_id ? group_id : MLX5_LAG_FILTER_PORTS;
+	int idx = mlx5_lag_get_dev_index_by_seq_filter(ldev, MLX5_LAG_P1,
+						       filter);
 	struct mlx5_core_dev *dev0;
+	struct lag_func *pf;
 	int err;
+	int i;
 
 	if (idx < 0)
 		return -EINVAL;
 
 	dev0 = mlx5_lag_pf(ldev, idx)->dev;
 
-	mlx5_lag_remove_devices(ldev);
-
-	err = mlx5_activate_lag(ldev, tracker, mode, true);
-	if (err) {
-		mlx5_core_warn(dev0, "Failed to create LAG in shared FDB mode (%d)\n",
-			       err);
-		goto err_add_devices;
+	mlx5_lag_remove_devices_filter(ldev, filter);
+
+	if (filter == MLX5_LAG_FILTER_PORTS || filter == MLX5_LAG_FILTER_ALL) {
+		err = mlx5_activate_lag(ldev, tracker, mode, true);
+		if (err) {
+			mlx5_core_warn(dev0,
+				       "Failed to create LAG in shared FDB mode (%d)\n",
+				       err);
+			goto err_add_devices;
+		}
+	} else {
+		err = mlx5_lag_create_single_fdb_filter(ldev, group_id);
+		if (err) {
+			mlx5_core_warn(dev0,
+				       "Failed to create SD shared FDB (%d)\n",
+				       err);
+			goto err_add_devices;
+		}
+		mlx5_lag_for_each(i, 0, ldev, filter) {
+			pf = mlx5_lag_pf(ldev, i);
+			pf->sd_fdb_active = true;
+		}
+		BLOCKING_INIT_NOTIFIER_HEAD(&dev0->priv.lag_nh);
 	}
 
 	mlx5_lag_rescan_dev_locked(ldev, dev0, true);
-	err = mlx5_lag_reload_ib_reps_from_locked(ldev, 0, false);
+	err = mlx5_lag_reload_ib_reps_from_locked(ldev, 0, filter, false);
 	if (err) {
 		mlx5_core_err(dev0, "Failed to enable lag\n");
 		goto err_rescan_drivers;
 	}
 
-	mlx5_lag_set_vports_agg_speed(ldev);
+	if (filter == MLX5_LAG_FILTER_PORTS || filter == MLX5_LAG_FILTER_ALL)
+		mlx5_lag_set_vports_agg_speed(ldev);
 	return 0;
 
 err_rescan_drivers:
 	mlx5_lag_rescan_dev_locked(ldev, dev0, false);
-	mlx5_deactivate_lag(ldev);
+	if (filter == MLX5_LAG_FILTER_PORTS || filter == MLX5_LAG_FILTER_ALL) {
+		mlx5_deactivate_lag(ldev);
+	} else {
+		mlx5_lag_for_each(i, 0, ldev, filter) {
+			pf = mlx5_lag_pf(ldev, i);
+			pf->sd_fdb_active = false;
+		}
+		mlx5_lag_destroy_single_fdb_filter(ldev, group_id);
+	}
 err_add_devices:
-	mlx5_lag_add_devices(ldev);
-	mlx5_lag_reload_ib_reps_from_locked(ldev, 0, true);
+	mlx5_lag_add_devices_filter(ldev, filter);
+	mlx5_lag_reload_ib_reps_from_locked(ldev, 0, filter, true);
 	return err;
 }
 
-void mlx5_lag_shared_fdb_destroy(struct mlx5_lag *ldev)
+void mlx5_lag_shared_fdb_destroy(struct mlx5_lag *ldev, u32 group_id)
 {
+	u32 filter = group_id ? group_id : MLX5_LAG_FILTER_PORTS;
+	struct lag_func *pf;
 	int err;
+	int i;
 
-	mlx5_lag_remove_devices(ldev);
+	mlx5_lag_remove_devices_filter(ldev, filter);
 
-	err = mlx5_deactivate_lag(ldev);
-	if (err)
-		return;
+	if (filter == MLX5_LAG_FILTER_PORTS || filter == MLX5_LAG_FILTER_ALL) {
+		err = mlx5_deactivate_lag(ldev);
+		if (err)
+			return;
+	} else {
+		mlx5_lag_for_each(i, 0, ldev, filter) {
+			pf = mlx5_lag_pf(ldev, i);
+			pf->sd_fdb_active = false;
+		}
+		mlx5_lag_destroy_single_fdb_filter(ldev, group_id);
+	}
 
-	mlx5_lag_add_devices(ldev);
+	mlx5_lag_add_devices_filter(ldev, filter);
 	mlx5_lag_reload_ib_reps_from_locked(ldev,
 					    MLX5_PRIV_FLAGS_DISABLE_ALL_ADEV,
-					    true);
+					    filter, true);
 }
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
index 6e199161b008..bbd77ae11e84 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
@@ -57,6 +57,16 @@ static struct mlx5_core_dev *mlx5_sd_get_primary(struct mlx5_core_dev *dev)
 	return sd->primary ? dev : sd->primary_dev;
 }
 
+struct mlx5_devcom_comp_dev *mlx5_sd_get_devcom(struct mlx5_core_dev *dev)
+{
+	struct mlx5_sd *sd = mlx5_get_sd(dev);
+
+	if (!sd)
+		return NULL;
+
+	return sd->devcom;
+}
+
 struct mlx5_core_dev *
 mlx5_sd_primary_get_peer(struct mlx5_core_dev *primary, int idx)
 {
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.h b/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.h
index 9bfd5b9756b5..2ab259095d7e 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.h
@@ -21,6 +21,16 @@ void mlx5_sd_put_adev(struct auxiliary_device *actual_adev,
 int mlx5_sd_init(struct mlx5_core_dev *dev);
 void mlx5_sd_cleanup(struct mlx5_core_dev *dev);
 
+#ifdef CONFIG_MLX5_CORE_EN
+struct mlx5_devcom_comp_dev *mlx5_sd_get_devcom(struct mlx5_core_dev *dev);
+#else
+static inline struct mlx5_devcom_comp_dev *
+mlx5_sd_get_devcom(struct mlx5_core_dev *dev)
+{
+	return NULL;
+}
+#endif
+
 #define mlx5_sd_for_each_dev_from_to(i, primary, ix_from, to, pos)	\
 	for (i = ix_from;							\
 	     (pos = mlx5_sd_primary_get_peer(primary, i)) && pos != (to); i++)
-- 
2.44.0


