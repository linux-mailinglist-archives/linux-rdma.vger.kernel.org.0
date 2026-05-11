Return-Path: <linux-rdma+bounces-20404-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OH9xBAYSAmqIngEAu9opvQ
	(envelope-from <linux-rdma+bounces-20404-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2026 19:29:42 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EFC251372E
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2026 19:29:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A90DD301061D
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2026 17:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9409466B71;
	Mon, 11 May 2026 17:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eJxN0gtF"
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012049.outbound.protection.outlook.com [40.107.209.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E734611C2;
	Mon, 11 May 2026 17:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778520513; cv=fail; b=nKTs57J1l7q5mSqB7xb5ZeZxiERQWpOKw3fl9gYpF6+hBdUSnqJjxb0mO991r7RuLhOLpTES3MWIHMfPzUOR5LY5Fg4dE+XB5ZYW+GFGmpWunYd2zccRw5B3b0t8gLMH2NI60lvVa+HRLt/ZPftc1f9FXZjx0BmfxuTl9mGGmeg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778520513; c=relaxed/simple;
	bh=GGzG5cJKvJXOqx47YDc1OpJUnlPowRqjWiS4p0qD6xY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f6nHh51amgs13XSloWPqMyXe3oWVQL/MuvhkTHb2h/7KLnrZY/6DnoayVS2dkcWUM5mh5PcO1zlwQpWxwi6wQvoOQZv704bRFEcMzMRVxpFH63y5Ps7zSE2NylKmCxxj4GOUrertWpmf/9RRDCvCVkcmM5GgrgaGnwnYf7+W4l0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eJxN0gtF; arc=fail smtp.client-ip=40.107.209.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OJsR2D2PRlTP/j08Z3UYOaLevMGMoSjyHC8h15GDUUEeRzCNFhQGHHMpRI2UXXOWJGWl7PPV+fmzxSA2AAo7WizI3ZLXWsoq0RoSq+IE/rLwcANtFPvqGDmwN6kAV0nyJj99qLuMbCnzFWezRyCKigV/pG4oed8SRZI9tbqX+kHCn4lBJQ5159bwEYkcGAdph6mKuWBdUKW4JHMgNi55rJQ/W8rg1QnV1iMXza7J6O59GrWZFMNHSJBwfX9IpWk45TSjl6xi2MiJU6OipduUye8XhhLbAP0nTeCTEhGTr2FdUpnUIz2/fKRxZCYJSV+Ku7bo+d+mXqybEVECpCPJxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gULdTL08rewDspQOIAmh9wYc2Gt6w0+e2dg95SAr/Z0=;
 b=NZaHrpkC0NW46uFbgZnmZRV5TAoi2PTcXCjobt7OkRpOO3UUkQwgARLh1b6P8FLxX10FzIscPpN8CNA/MBGrTgGTkc+euBfRzfNnH3kHkLtfFaJ0QjzZpmpXAMvPfnyzkZP4oxkNdIH8VjyBoCzw3h54mOASEiKUQQJnewubk1xNPBjvXFdsCPOr63RhFuIwfnWRfzZXqExqpPUAJ2td9LnJtuonNlql4yw1k1Fcby0Kjv0GSKPc4EqiNvEoOaYlrLQnRudXRYwiYmFDzKPRp9ZolP5pi38INBeBcNKqr3JpV5iDahz16KTU9Jo43R0+Lfdyzdz0a6dDz2BTzp7p3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gULdTL08rewDspQOIAmh9wYc2Gt6w0+e2dg95SAr/Z0=;
 b=eJxN0gtFqZu5fAoHdttm3KWj/8owxFA7iMnvBHTxYlVgoeeBFQK3EgWiAwZAHHpWXow89laZ26fZyAUuWkRYlLBrGkd/etbCcsPPHnLj5pN22aca0bEr36ihpmT/+74rYyW49m0g8a2T4jj5CJtKl6sr41xwnXIRIhgmIdiE984Bfx3xqmfU1udBJQN4Uf3/we4a6B9ZKY3O+ocaE6reD1J1JOYV//WNbiQ3NgWFCKfAX5/k8tRKvdMAs5lCocGuKfIpKxUxZQp9rT5XvcIlJc0QyCBShNJ/LVfnT1S3hS26lNFMBCxu6VTIteND8IzKRijEArEIWXeHzhOK1cCFgQ==
Received: from BY1P220CA0042.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:59e::17)
 by DM6PR12MB4108.namprd12.prod.outlook.com (2603:10b6:5:220::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Mon, 11 May
 2026 17:28:24 +0000
Received: from SJ1PEPF00002323.namprd03.prod.outlook.com
 (2603:10b6:a03:59e:cafe::99) by BY1P220CA0042.outlook.office365.com
 (2603:10b6:a03:59e::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.23 via Frontend Transport; Mon,
 11 May 2026 17:28:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00002323.mail.protection.outlook.com (10.167.242.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Mon, 11 May 2026 17:28:24 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 11 May
 2026 10:28:00 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 11 May
 2026 10:27:59 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 11
 May 2026 10:27:55 -0700
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
Subject: [PATCH net-next 4/5] net/mlx5e: resize configured default RSS context table on channel change
Date: Mon, 11 May 2026 20:27:18 +0300
Message-ID: <20260511172719.330490-5-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002323:EE_|DM6PR12MB4108:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b73a113-4b45-4610-9b09-08deaf82b498
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700016|1800799024|82310400026|22082099003|18002099003|56012099003|11063799003;
X-Microsoft-Antispam-Message-Info:
	v+/8yMdJCTjglomwbfCZWCji1ljFSAfElNJEh/8iA3h9AmKkvu9pptOYzHrUpP1z1B8nq3Oo52scq0xYZJZ8ninDwmWOsg+Zg+gbnisdSNv03QVHIib1GcPlo933kABSbYucza1euevyMfNos7Og6M3x/ys4DiccBUZfZopuPER5dJcDPq0qCmhjA+K2eIAAthoo9cK3CFG29lCw9L3moGq6KiazRayt8xEnzoKjDAjBqLCXsJCkOqWUgea4xg03UTnsmh0Xa07jNext9KV8DfkU8X00tOBfNDVueAO4V2kRbyUcB/5U508PnZ7v+UzgM9ekznA4smSy2jRUWsDPLMEBNglsurtaARxcS5wOZmkaftiyQxWRwnM/EptIJUaUyVjdIvOcx4DEaOd/YaMlXNxwFMhsWNMZtBHzJq+7QW6Hw9/1t3zG0oCwfC9RaG78O8DpsSf4eaaSKnAynVSXeFL/geoWtZVz611cWj4/n7Haogzv4/Y+N6K0RfrKEMGnq2VcIXJHMCcrNGbOPOprF4/tO88keH+C7aH5U1Z6cbW7Uy9FKsOPexHgmqKJci+ECT5D/ITXd3QUuQcz2NpZuJlGFbjV3+VXHPXFIDUV8AvYO69zql9JwaK3qK3WXNsZSsUoxRqi9mGYWcty2ZDhraMmRCSaSGVigNdBbhf5WL5RqUiKGQpT7aE4r9GPA9H6laWX5xezyvUft9q+vAmqhEbUs1ut1A5NOwi1rxMvU4Q=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700016)(1800799024)(82310400026)(22082099003)(18002099003)(56012099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	/HHw8T6whY7+DhzH8G8c4iefVgQqtBSV6Ooncz7hSEOw1dHlQ87hJ5lNblmdhyBbRAH80wN1P9p55j+IWDBC+IRe376kb5np82gZewe4FnGXLhSe02Zk2fco6kiByA1f2ambS2tQ2tS4tf2ONUEmfXlxRCJh2x8Y+xBMyJrFC9RiKC8pT++qCfZoqLLeXX0KG9fGpQSOccadVnZmYpq+4nHoGiYP7zIFgepyJottVuaN9zMyZMQ603lJdtonH6AqR6cBv2mMvWZzsOQ8U9eizLSke0peJE2gyrxnWtLTnwL0/rbw8eTQSmqm/nhyOpCgaS9wKcVcDIfVYytm6uNBLlCKIMKBWZvzY/Ak5Ej5IFqzUAA/lYzha3Bu7kIf24qDsD8PFn0HY2kBMH/9mgX1eZjfDB037yIICesiFAFWji9R1XnXi5Pt7bEYqOjvklql
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 17:28:24.2418
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b73a113-4b45-4610-9b09-08deaf82b498
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002323.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4108
X-Rspamd-Queue-Id: 9EFC251372E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20404-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,nvidia.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,Nvidia.com:dkim];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

From: Yael Chemla <ychemla@nvidia.com>

mlx5e_ethtool_set_channels() rejected channel count changes that
required a different RQT size when the default context indirection
table was user-configured. This restriction was introduced by
commit ee3572409f74 ("net/mlx5e: RSS, Block changing channels number
when RXFH is configured").

Lift the restriction. Validate the resize upfront with
ethtool_rxfh_indir_can_resize(), then fold or unfold the table
in-place via ethtool_rxfh_indir_resize() inside state_lock, before
mlx5e_safe_switch_params(), so the preactivate callback sees the
correct table content when it programs the HW.

Signed-off-by: Yael Chemla <ychemla@nvidia.com>
Reviewed-by: Nimrod Oren <noren@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/en/rss.c  | 13 +++++++++
 .../net/ethernet/mellanox/mlx5/core/en/rss.h  |  3 +++
 .../ethernet/mellanox/mlx5/core/en/rx_res.c   | 27 ++++++++++++-------
 .../ethernet/mellanox/mlx5/core/en/rx_res.h   |  4 +--
 .../ethernet/mellanox/mlx5/core/en_ethtool.c  | 22 +++++++--------
 .../net/ethernet/mellanox/mlx5/core/en_main.c |  9 +++----
 6 files changed, 49 insertions(+), 29 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/rss.c b/drivers/net/ethernet/mellanox/mlx5/core/en/rss.c
index 992a78580a40..de435df7ca50 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/rss.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/rss.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
 // Copyright (c) 2021, NVIDIA CORPORATION & AFFILIATES.
 
+#include <linux/ethtool.h>
 #include "rss.h"
 
 #define mlx5e_rss_warn(__dev, format, ...)			\
@@ -85,6 +86,11 @@ bool mlx5e_rss_get_inner_ft_support(struct mlx5e_rss *rss)
 	return rss->params.inner_ft_support;
 }
 
+u32 *mlx5e_rss_get_indir_table(struct mlx5e_rss *rss)
+{
+	return rss->indir.table;
+}
+
 void mlx5e_rss_set_indir_actual_size(struct mlx5e_rss *rss, u32 size)
 {
 	rss->indir.actual_table_size = size;
@@ -102,6 +108,13 @@ void mlx5e_rss_ctx_resize(struct mlx5e_rss *rss, u32 new_size)
 		rss->indir.table[i] = rss->indir.table[i % old_size];
 }
 
+void mlx5e_rss_indir_resize(struct mlx5e_rss *rss, struct net_device *netdev,
+			    u32 new_size)
+{
+	ethtool_rxfh_indir_resize(netdev, rss->indir.table,
+				  rss->indir.actual_table_size, new_size);
+}
+
 int mlx5e_rss_params_indir_init(struct mlx5e_rss_params_indir *indir,
 				u32 actual_table_size, u32 max_table_size)
 {
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/rss.h b/drivers/net/ethernet/mellanox/mlx5/core/en/rss.h
index e48070e02979..1bb0434612a4 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/rss.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/rss.h
@@ -35,6 +35,8 @@ int mlx5e_rss_params_indir_init(struct mlx5e_rss_params_indir *indir,
 				u32 actual_table_size, u32 max_table_size);
 void mlx5e_rss_params_indir_cleanup(struct mlx5e_rss_params_indir *indir);
 void mlx5e_rss_ctx_resize(struct mlx5e_rss *rss, u32 new_size);
+void mlx5e_rss_indir_resize(struct mlx5e_rss *rss, struct net_device *netdev,
+			    u32 new_size);
 struct mlx5e_rss *
 mlx5e_rss_init(struct mlx5_core_dev *mdev,
 	       const struct mlx5e_rss_params *params,
@@ -46,6 +48,7 @@ void mlx5e_rss_refcnt_dec(struct mlx5e_rss *rss);
 unsigned int mlx5e_rss_refcnt_read(struct mlx5e_rss *rss);
 
 bool mlx5e_rss_get_inner_ft_support(struct mlx5e_rss *rss);
+u32 *mlx5e_rss_get_indir_table(struct mlx5e_rss *rss);
 void mlx5e_rss_set_indir_actual_size(struct mlx5e_rss *rss, u32 size);
 u32 mlx5e_rss_get_tirn(struct mlx5e_rss *rss, enum mlx5_traffic_types tt,
 		       bool inner);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/rx_res.c b/drivers/net/ethernet/mellanox/mlx5/core/en/rx_res.c
index d81a91eb7664..e940635f5dcb 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/rx_res.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/rx_res.c
@@ -40,15 +40,31 @@ static u32 *get_vhca_ids(struct mlx5e_rx_res *res, int offset)
 	return multi_vhca ? res->rss_vhca_ids + offset : NULL;
 }
 
-void mlx5e_rx_res_rss_update_num_channels(struct mlx5e_rx_res *res, u32 nch)
+/* Updates the indirection table SW shadow, does not update the HW resources yet
+ */
+void mlx5e_rx_res_rss_update_num_channels(struct mlx5e_rx_res *res, u32 nch,
+					  struct net_device *netdev)
 {
 	u32 new_size = mlx5e_rqt_size(res->mdev, nch);
 	int i;
 
 	WARN_ON_ONCE(res->rss_active);
 
-	/* Default context */
+	/* Default context: fold/unfold user-configured table, then update size
+	 * and reset to uniform when unconfigured.
+	 */
+	mlx5e_rss_indir_resize(res->rss[0], netdev, new_size);
+
+	/* mlx5e_rss_indir_resize() is a no-op when the table is not
+	 * user-configured. actual_table_size is updated after the resize
+	 * because ethtool_rxfh_indir_resize() uses it as the old size to
+	 * replicate the pattern; updating it first would make the grow a no-op.
+	 * It must be updated before mlx5e_rss_set_indir_uniform() so that
+	 * the uniform fill covers all new entries, not just the old ones.
+	 */
 	mlx5e_rss_set_indir_actual_size(res->rss[0], new_size);
+	if (!netif_is_rxfh_configured(netdev))
+		mlx5e_rss_set_indir_uniform(res->rss[0], nch);
 
 	/* Non-default contexts */
 	for (i = 1; i < MLX5E_MAX_NUM_RSS; i++) {
@@ -218,13 +234,6 @@ static void mlx5e_rx_res_rss_disable(struct mlx5e_rx_res *res)
 	}
 }
 
-/* Updates the indirection table SW shadow, does not update the HW resources yet */
-void mlx5e_rx_res_rss_set_indir_uniform(struct mlx5e_rx_res *res, unsigned int nch)
-{
-	WARN_ON_ONCE(res->rss_active);
-	mlx5e_rss_set_indir_uniform(res->rss[0], nch);
-}
-
 void mlx5e_rx_res_rss_get_rxfh(struct mlx5e_rx_res *res, u32 rss_idx,
 			       u32 *indir, u8 *key, u8 *hfunc, bool *symmetric)
 {
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/rx_res.h b/drivers/net/ethernet/mellanox/mlx5/core/en/rx_res.h
index 675780120a20..8fff18d64978 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/rx_res.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/rx_res.h
@@ -48,7 +48,6 @@ void mlx5e_rx_res_xsk_update(struct mlx5e_rx_res *res, struct mlx5e_channels *ch
 			     unsigned int ix, bool xsk);
 
 /* Configuration API */
-void mlx5e_rx_res_rss_set_indir_uniform(struct mlx5e_rx_res *res, unsigned int nch);
 void mlx5e_rx_res_rss_get_rxfh(struct mlx5e_rx_res *res, u32 rss_idx,
 			       u32 *indir, u8 *key, u8 *hfunc,
 			       bool *symmetric);
@@ -68,7 +67,8 @@ int mlx5e_rx_res_rss_destroy(struct mlx5e_rx_res *res, u32 rss_idx);
 int mlx5e_rx_res_rss_cnt(struct mlx5e_rx_res *res);
 int mlx5e_rx_res_rss_index(struct mlx5e_rx_res *res, struct mlx5e_rss *rss);
 struct mlx5e_rss *mlx5e_rx_res_rss_get(struct mlx5e_rx_res *res, u32 rss_idx);
-void mlx5e_rx_res_rss_update_num_channels(struct mlx5e_rx_res *res, u32 nch);
+void mlx5e_rx_res_rss_update_num_channels(struct mlx5e_rx_res *res, u32 nch,
+					  struct net_device *netdev);
 
 /* Workaround for hairpin */
 struct mlx5e_rss_params_hash mlx5e_rx_res_get_current_hash(struct mlx5e_rx_res *res);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
index 4462cf29e977..300d1cb2e070 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
@@ -501,6 +501,7 @@ int mlx5e_ethtool_set_channels(struct mlx5e_priv *priv,
 	unsigned int count = ch->combined_count;
 	int new_rqt_size, cur_rqt_size;
 	struct mlx5e_params new_params;
+	struct mlx5e_rss *rss0;
 	bool arfs_enabled;
 	bool has_rss_ctxs;
 	bool opened;
@@ -538,19 +539,16 @@ int mlx5e_ethtool_set_channels(struct mlx5e_priv *priv,
 	}
 
 	cur_rqt_size = mlx5e_rqt_size(priv->mdev, cur_params->num_channels);
+	rss0 = mlx5e_rx_res_rss_get(priv->rx_res, 0);
 
-	/* If RXFH is configured, changing the channels number is allowed only if
-	 * it does not require resizing the RSS table. This is because the previous
-	 * configuration may no longer be compatible with the new RSS table.
-	 */
-	if (netif_is_rxfh_configured(priv->netdev)) {
-		if (new_rqt_size != cur_rqt_size) {
-			err = -EINVAL;
-			netdev_err(priv->netdev,
-				   "%s: RXFH is configured, block changing channels number that affects RSS table size (new: %d, current: %d)\n",
-				   __func__, new_rqt_size, cur_rqt_size);
-			goto out;
-		}
+	if (!ethtool_rxfh_indir_can_resize(priv->netdev,
+					   mlx5e_rss_get_indir_table(rss0),
+					   cur_rqt_size, new_rqt_size)) {
+		netdev_err(priv->netdev,
+			   "%s: cannot resize RSS table (%u -> %u); reset indirection table to allow this change\n",
+			   __func__, cur_rqt_size, new_rqt_size);
+		err = -EINVAL;
+		goto out;
 	}
 
 	/* Don't allow changing the number of channels if HTB offload is active,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 85b1ccbd351f..a904e468c197 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -3296,12 +3296,9 @@ static int mlx5e_num_channels_changed(struct mlx5e_priv *priv)
 	}
 
 	/* This function may be called on attach, before priv->rx_res is created. */
-	if (priv->rx_res) {
-		mlx5e_rx_res_rss_update_num_channels(priv->rx_res, count);
-
-		if (!netif_is_rxfh_configured(priv->netdev))
-			mlx5e_rx_res_rss_set_indir_uniform(priv->rx_res, count);
-	}
+	if (priv->rx_res)
+		mlx5e_rx_res_rss_update_num_channels(priv->rx_res, count,
+						     netdev);
 
 	return 0;
 }
-- 
2.44.0


