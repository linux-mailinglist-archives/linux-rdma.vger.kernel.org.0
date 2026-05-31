Return-Path: <linux-rdma+bounces-21550-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WLCmN30fHGoRKAkAu9opvQ
	(envelope-from <linux-rdma+bounces-21550-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 31 May 2026 13:46:05 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 571DB615DA2
	for <lists+linux-rdma@lfdr.de>; Sun, 31 May 2026 13:46:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8AD60306E1A8
	for <lists+linux-rdma@lfdr.de>; Sun, 31 May 2026 11:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EF8F3839BC;
	Sun, 31 May 2026 11:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KP5OExUg"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013004.outbound.protection.outlook.com [40.93.201.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3CBF3845B7;
	Sun, 31 May 2026 11:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780227665; cv=fail; b=dIwGy5bEwHaIcWzUNijcraQU/8XYBaD1bS9VeAQJPw++4qiXpzYlGFf7UUxlPYKXxhVLS2Zlny25djVl6l6orj+Q00x5oxB7bpJ2MjjBB5YeLgBHCP+PN+sugOOJe1871KtQyuUDDb+u9O6Prbm9WKGfos6TsnogwxN715hga4o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780227665; c=relaxed/simple;
	bh=7IKg2SuLgLzvivHP6OICGGk3mG+sX1Nq1eMegn4epjk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I9jHaCEd0R1+AXzoauPoQUAt/QxidI4I6szmR1ttdhUDv98Cm23yy4pOArbFx6Z6/f7uyZqK8ZKJfl5lzzoUF+/0L7GdRTmpByZpALFGvhoOKXXmdRwJOjS1MMg9dBWW02AsXH+2ICddyUn0P7oOwkuODOxZzp5YoQ2v+J8pqRY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KP5OExUg; arc=fail smtp.client-ip=40.93.201.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jjdwHAmZzDdWUTwB9fNMerVqewg41TrgbboZC9qQUjM3OPvdUVLD+NmCXxRMgq4kzjN68oE0UTs55REwrChu7V3VjTX2A1LjjW+6rTmZzQGRfkuu4eRMk7tsD5xjG5jiweUVtC47/rR0IhtWL+7iyxxHsSU5d/tVR5G2V63RBq7dWNEWsg3e54Jtiz4F33BeUzqfqQB7s6uIe1vC33mxVmUChu6NhbqOnLZWPo9QgRkXXd8Pe+ZERtt6d6ik7XHemDJcnHSeGLnwRzNouM5kpy+KwSOh33/xioJYUPwqxVQCSRozyl7I5SYZ8Xv3WaBck37TvQCXml2XbGHpbv4amQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KcUtTy9QrEFxbeFWL0QOz3ouO2/iYJygqO/3m7DX20U=;
 b=MpQswzv4agME92zszg4zq1ZVdmv075I8t6MNoh7zmkoFPtDHOnKsZDtbrdahEiI25e07vngWbdQYHQBxwW9hnYC9mTa3jj7DKjy4nYekSbHcPZj/2eke4MOuTkY73bdV90yBMZO7oPAy/p8ldNUm9F6C1JKBiHLfHA2k6qeT9FkNKN1s55i/86sSys1yfC9893wSzX4ijld9YR4VmQJfN+Y/2ZQpcwwkxJOUomvGzIBr5Q0CQNfRpR0Pp4jD6IcwH+pWumM/idsuxYcFbeL4Qlw0X8+k/2xWZRR9CnKJ4J08Zo1vXy10aHW3LqLjo3QpXYdbFr4FmNYDFyjobpaXnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KcUtTy9QrEFxbeFWL0QOz3ouO2/iYJygqO/3m7DX20U=;
 b=KP5OExUgANR+B5n5sp4NcWNuS9m8orTIFvBrWK1DZ5KbbwAN5AJILbBudPJdtZk0Nhrr5DIyEle5N3Rg9qB64+0cz3D+j6FXpVTH5lobet7+n7+SGh6xJQiOHuRce6H4MM5rZ6cZFIlur1yz1T1P3hRRiU4WxyscXhQlJMEV/rJbpjuf3mIm9Ju9PXmzBKQQZ0DBtLdGuXtJOapeD4yc6kN2z3PNF4fPixH0XH0luNJl+Ch6uRAu9crj8UGqWgnZyTh9vGch6VXFpHtUQF48UxNH4XIwcJ77iOCYAg8hHQt0QxI0pkHZ5XNLbUjmsmfHYgzr8G3lvGqP+5BU8kpHrw==
Received: from CH0PR07CA0026.namprd07.prod.outlook.com (2603:10b6:610:32::31)
 by CY5PR12MB6646.namprd12.prod.outlook.com (2603:10b6:930:41::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Sun, 31 May
 2026 11:40:53 +0000
Received: from CH3PEPF00000016.namprd21.prod.outlook.com
 (2603:10b6:610:32:cafe::1e) by CH0PR07CA0026.outlook.office365.com
 (2603:10b6:610:32::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.16 via Frontend Transport; Sun, 31
 May 2026 11:40:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CH3PEPF00000016.mail.protection.outlook.com (10.167.244.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.0 via Frontend Transport; Sun, 31 May 2026 11:40:53 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 31 May
 2026 04:40:40 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sun, 31 May 2026 04:40:39 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Sun, 31 May 2026 04:40:34 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Nimrod Oren
	<noren@nvidia.com>, Yael Chemla <ychemla@nvidia.com>, Shay Drory
	<shayd@nvidia.com>, Or Har-Toov <ohartoov@nvidia.com>, Edward Srouji
	<edwards@nvidia.com>, Simon Horman <horms@kernel.org>, Maher Sanalla
	<msanalla@nvidia.com>, Parav Pandit <parav@nvidia.com>, Kees Cook
	<kees@kernel.org>, Patrisious Haddad <phaddad@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Jacob Keller
	<jacob.e.keller@intel.com>
Subject: [PATCH net-next V2 06/13] net/mlx5: LAG, extend shared FDB API with group_id filter
Date: Sun, 31 May 2026 14:39:46 +0300
Message-ID: <20260531113954.395443-7-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260531113954.395443-1-tariqt@nvidia.com>
References: <20260531113954.395443-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000016:EE_|CY5PR12MB6646:EE_
X-MS-Office365-Filtering-Correlation-Id: ee7cdc8d-c86b-4a48-ee1b-08debf0978af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|82310400026|376014|7416014|56012099006|18002099003|3023799007|11063799006|6133799003|22082099003;
X-Microsoft-Antispam-Message-Info:
	nns2CE/yEdFqd4LeCIr1Fl5YdH15zgK9+JTd03hdeID3WRjfbzOpl6Qh8B6tKlSaCnn2m/AkcrNY+pR9zetSmRmKqySZU5rYBbwCq3qkStSXG+q2eV9RQVflTbHC3VujjU9BNZYFuII8xgWOIK/zFAg5oUSuUvl6jEKF0UpjFCsH3fvXPI7k8o9wiWIHW/aFqWvr2ilbA0w0MaVsx09knQ/xsQ2cFgC8PtCTD07Md8anABHsyYpbOgKI8e28GiDxU6YGV5CDUWpFlBBZa3pEjbJSxUgwtpAbBnYqm0BjYSix3clPIktHKEE6eQhHLm44d4w0+dtMfr2OFF+nt5kCyErk3auSRXHn5KGi6qoaxSJ4j4SInC4x8aPQa2TTF20hH8mGceC1is0imv0jZqCNntKuOW+f0j6QyV3ljxjZddQUOM3JAfK6ufz9f4GXGUakuRT4pFvSeHfgb4FFsrX+zIOb4gqbZ8d81/UzNM/EXKDCiOG2q/DsXFzfrXELui2D5UVigDClINwk67EqRdgb6xN5kEgzZnfGPLUDOtu9KmU4+S+4i2NstQagHg124UX0kT5MgmUT0GtTN1aI5floyzlYk43MzSRU8abYcLwlFuoMWtZtddf0zwJx8HjA68Srzyr4xZBHUrbAwoeed5oky8821pvllJ+XE/aDrKW1A9bByChvqMGvXWovsYS4P0mj3LcSpZ0RUp5WEvqO0qIqy2swp4ymW0Kjn3kVI7enS+g=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(7416014)(56012099006)(18002099003)(3023799007)(11063799006)(6133799003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	cyRfEX5UramsoBEVAiSDOgysCEXZjrrPJfsE3Fh7GC0YXABU9cSgQU/iGXflvuVaJUkDccgzRPbzU25UBuQREGbm2Fp3m+QWo8HZAPjPsfFqZQu0OjyYNbIYFTVCf4cydJtjBnVegTZutblUtJXPC11HBRgJHDJA3fZMKhrtdkx4GtBVCJT9pDBEZimk9deQ6zbLaJzeYQQ7PMxjMHCiK2Lo7frriR+hNaM8aXE7obd6aKxW3QXsdzR+Xku+IMTdqpIk8L64JGidZZ4Y9jxRqcCXnIUU9AsBEThjEQt1h9++oe+rAbwXcXIT9az4YB3c4PWJivksYj5d/8WfXzuWELAmtbLWzOYsQb/H0Y4tUgPQCKUGTKe4urcFjaS2eknBiy0ueuOtR6aA0OCX7HixFCdPQxqdt+vrhSAAFuZhk1ICC+hKTOnH4mkQKTrhD/Ft
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2026 11:40:53.2059
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee7cdc8d-c86b-4a48-ee1b-08debf0978af
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000016.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6646
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21550-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,Nvidia.com:dkim];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 571DB615DA2
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
 .../mellanox/mlx5/core/lag/shared_fdb.c       | 153 +++++++++++---
 .../net/ethernet/mellanox/mlx5/core/lib/sd.c  |  10 +
 .../net/ethernet/mellanox/mlx5/core/lib/sd.h  |  10 +
 6 files changed, 324 insertions(+), 83 deletions(-)

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
index b5cbe3409720..1371e14c4c13 100644
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
@@ -82,59 +89,147 @@ int mlx5_lag_create_single_fdb(struct mlx5_lag *ldev)
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
+ *
+ * Return: 0 on success, negative error code on failure.
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


