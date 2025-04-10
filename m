Return-Path: <linux-rdma+bounces-9346-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A0A9A84CC2
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Apr 2025 21:20:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 916641BA5081
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Apr 2025 19:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACA21290095;
	Thu, 10 Apr 2025 19:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="er2WfbwD"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2080.outbound.protection.outlook.com [40.107.243.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E5AE28FFC7;
	Thu, 10 Apr 2025 19:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744312730; cv=fail; b=CuSRADbCWQaBETHDrRTIRTn4DA6KELTewDrfJTl6sMxL9ejgdx95eO+1o3v7ztQcdqa5tMAQKlM+FT8NGJpLVzqcDSI4bn8CJZ9Sv8Uwa84/bbCYyXxzLMuz7oxGOvwlVZTXM7P++5JAO2V4Pp4qsFA+yGEMs8fm7s4cqxvJ5So=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744312730; c=relaxed/simple;
	bh=8w0+Xv7/WTuvCpAdRVeFys0M/X6XAZGwhaYZRi1C6dU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ps3N3XE9WFnCedrpiUWC4i3xebpSB1yA/Gu03fZ9V/mOlln+54C+WU6sDBKjMXZah2oPritVsdkQt4swQQD+ODIMIGfvb16Izuwfo2bDk9WTccVZwgdzOwly34lLxYFSx3QsJ+SzEQK9RPNvsY7nAQllh0Y6FDK0h9aw4vIvI40=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=er2WfbwD; arc=fail smtp.client-ip=40.107.243.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xsMWcnsnfpmEpCdjqrNCMmKZ5Rq06K22mbA1/eEne6ylrpXUEzC2OjX1smYLKw2bLeQITuqZ3hq4SpifI+GLYXaIfzvLUMm7jE1/gD65RuKuqLtlK1neEPeUSDboqb9eLE1cAynyfGqxjkKjOYIU5+kY4rO2Ec8OaEhX1tIOMT/Wa1HuvVdvIzdUz2sLtGQSEMsEuulMetGOMCQSemeVIwRtb0d+860qcL2wLchbP0yS3zXBoZlDxohCtM9kv71MG3BUyyaFIoMc2bL3Pn02vG8EWybQ6ZXgR2nBy3KvMxWtXFA15D5vjxduRfXOqYQLpW+1m0lDkfE3ZmbUcfIMJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wVZa8s/kL7QIFI4+TmDP4rn9PLee2T2AoX35lh5dT8o=;
 b=PH4HGaCvtCVOQipWgMISssjFM5YqC36GCiYE7kR/5Ek0SCI4Coo2U1yZbLTQP0V+zTbyMjIZPuk84LnURnqmrfnwsWXTfGeJww6ErC8mjqgf3aKrDq2qXlZ+4g70apFhE9fIP3ULKY/BATnLWROWrpt0FSqQPs5o7gy+h7dSwRsjykIfWlsqFLs8p6gf/S0Ym7beIgxm+ALIGeqoTiVYksFYw/xwJTbadS+Pt52ezAJQ6tbU7N6fRR7C3DesqraKUQu2J2zoopH7pMafpByJgw/jvucCwfKPdRl3MTbmD8z/xjEgWNUEny16wjiR+QV3FO9GX4YQucvH4NEp4hqtPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wVZa8s/kL7QIFI4+TmDP4rn9PLee2T2AoX35lh5dT8o=;
 b=er2WfbwDwShSqfcE2QmVN5biBHaNhT8/zZBDTxn2xzBJX16coCP/mxw3Pxg5UtgbSVD7tbpDbCU7y0rorsgInfmCLOvqIKwFRrCWtFqSdU1ROo+Hl1bgV2g/sPNycRzwO8qYIn588UfU5Alg7998WvHmgNJWgTb2i7qi6Q1qkwFshDpp0ELsYKB2j/GW6xyzRNs3sKoMp98BSbGZmGrGeiv0OoAad4gxOCrfX0B2/lOwkq7rH9tF69XwXAMOdDjgFt5TYHnSclYOT9oq3GitXLjAmclrZCYNlRcyBm6ezl3xlo6xCCDzTIicKNf1xLSxnNyHjlBuiUJ68lITF06BxA==
Received: from BL1PR13CA0312.namprd13.prod.outlook.com (2603:10b6:208:2c1::17)
 by MW6PR12MB8900.namprd12.prod.outlook.com (2603:10b6:303:244::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Thu, 10 Apr
 2025 19:18:37 +0000
Received: from BN1PEPF00004680.namprd03.prod.outlook.com
 (2603:10b6:208:2c1:cafe::65) by BL1PR13CA0312.outlook.office365.com
 (2603:10b6:208:2c1::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.8 via Frontend Transport; Thu,
 10 Apr 2025 19:18:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN1PEPF00004680.mail.protection.outlook.com (10.167.243.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8632.13 via Frontend Transport; Thu, 10 Apr 2025 19:18:36 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 10 Apr
 2025 12:18:25 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 10 Apr 2025 12:18:24 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Thu, 10 Apr 2025 12:18:20 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: Gal Pressman <gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, "Saeed
 Mahameed" <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Tariq
 Toukan <tariqt@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Moshe Shemesh
	<moshe@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Vlad Dogaru
	<vdogaru@nvidia.com>, Yevgeny Kliteynik <kliteyn@nvidia.com>, Michal Kubiak
	<michal.kubiak@intel.com>
Subject: [PATCH net-next V2 03/12] net/mlx5: HWS, Make pool single resource
Date: Thu, 10 Apr 2025 22:17:33 +0300
Message-ID: <1744312662-356571-4-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1744312662-356571-1-git-send-email-tariqt@nvidia.com>
References: <1744312662-356571-1-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004680:EE_|MW6PR12MB8900:EE_
X-MS-Office365-Filtering-Correlation-Id: 924dbad9-d8a4-46e9-f6a1-08dd78647e58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xTiRcgxr3Q7/kWL3R8kJuVNgMlrWxaLC5ucDWZ0R9zLs6xKZQtQGRW3u3Ijx?=
 =?us-ascii?Q?2f0negdWQVgzDDRkex2r6MiT0FOkwxnb6WeA0ii/8P2vCrBA8ZXNk+fHeQFL?=
 =?us-ascii?Q?LeHZfWOHvbvqNw9AmlcmEPKocoaw0i/DkHfH9Bqn/jWIPFdy0DxmQ8OD2k6d?=
 =?us-ascii?Q?VUciSlXbkPz241GZVbVL/y0MZuTL2WV0Pwx/HsD2nstVYSP/Nd5KPBepCnBq?=
 =?us-ascii?Q?tmjuzPKMhLenOzr3wq/ZwIgqvYHuoAclkC4b3jdAWYqtNjWYNFsoI5U2Myx9?=
 =?us-ascii?Q?4ZQvEkshNTrToh7Fm7sZNJJKy4GnuV7Pl4ChGAQIjGRVtgiWFqwU/j+sen2i?=
 =?us-ascii?Q?5QA8Y+aOeGRb+fjTYgbN5gwwirf7N5pRTZ8WuXiyMSjXIHEkBcTKNyyyjU3q?=
 =?us-ascii?Q?K2ivAQlBWWWHoV0kdXOHUByc6frNSUaQOi8bbMHJhlArzNRA8yt42GTdInZK?=
 =?us-ascii?Q?0F9SSK1xmawNlM5LICL8rLymS5CAgW499eJgrlnsRcvO4vSkX5V83IRBnpln?=
 =?us-ascii?Q?1joqD1ZZSJX6BVb3MSi4dxn0J945vIkkdfF04MNur0RO63HAgFMFnz2lmvAg?=
 =?us-ascii?Q?inAmH/fi16IHLFBadGY846VCEz84YSn8ZK5gz3ccd+fcz3+HmA4a34oxMPNz?=
 =?us-ascii?Q?7age/0xWDvR0kiwQLTbpjh5+bzNQrXubSjum8eClTZUDzScGjICBZPLNtnrc?=
 =?us-ascii?Q?tKUoKyfFGT7ZN1k5RnRTssJwfwN1eKogHbDxKjt8/whKSitD/nF/X6Yhf9nO?=
 =?us-ascii?Q?fmp+qWpxAbSwIZN2SbG2yQwnttB8TNJysOLHPgkPWfDEOVlXbZKSJWsQSKKM?=
 =?us-ascii?Q?mxa9TS/skrzCdggYnM1UHM7cqdw2RvmH1KjFFo4McsYGMfI90jsgQQW1oBKy?=
 =?us-ascii?Q?IBBnFAPIpod+Emdt7he4Lma3J+2PCFjurFz9qcVq0dIPceAFPY9jsnRe7Q/l?=
 =?us-ascii?Q?aL+SQynyB0G+PaokPCn2HEfLJAbCNuzLbd96yHBCMj0rC1/gUsROiuSwKELj?=
 =?us-ascii?Q?D4hG1lhZJasPjC7Wa5KrE8Bxw5R01wAQlL896TZyvbWuxZCdSVRFX91vO3Ro?=
 =?us-ascii?Q?s+WJzdo/1MvKRv+pImUa8EP4jtFagPvkZfvGe5BZbCA8kHLA4QJ3GqdaWlwc?=
 =?us-ascii?Q?lJ40rDpBeGorxGf28xRzL/EFjj82JG2QUCMSzx60dly6CIVFWIMw8gHR0n7f?=
 =?us-ascii?Q?zQcstXutZSkRPGUKY/xkZF6BbB5yaxHv8sG094N1LFqJikP34rLHgUpos5lZ?=
 =?us-ascii?Q?Fis3DmWkWGlJjxPVGDhCtKTuzDie+cldkWiWdeWr1prhepRNX15/+MeKuGUa?=
 =?us-ascii?Q?fwF1JE1RYRDa68uFuas6YCEyV9MpQU3/4i775+yvzwXixi9Tk5EUY0Zs+xEN?=
 =?us-ascii?Q?ZeXeWcMKufKQ181ob49L+D9Suy9oXxsLOrQiLQBL2nP7MpEoACtRnlztxDJk?=
 =?us-ascii?Q?i4KuvPWJ9PfA/Sz+LKEnqDrbmhzk2eKoFaGSvDXC7gNx5NzyfqBYztvLvHl9?=
 =?us-ascii?Q?nQ11dhj0cBt/U8g=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2025 19:18:36.6425
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 924dbad9-d8a4-46e9-f6a1-08dd78647e58
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004680.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8900

From: Vlad Dogaru <vdogaru@nvidia.com>

The pool implementation claimed to support multiple resources, but this
does not really make sense in context. Callers always allocate a single
STC or STE chunk of exactly the size provided.

The code that handled multiple resources was unused (and likely buggy)
due to the combination of flags passed by callers.

Simplify the pool by having it handle a single resource. As a result of
this simplification, chunks no longer contain a resource offset (there
is now only one resource per pool), and the get_base_id functions no
longer take a chunk parameter.

Signed-off-by: Vlad Dogaru <vdogaru@nvidia.com>
Reviewed-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Reviewed-by: Michal Kubiak <michal.kubiak@intel.com>
---
 .../mellanox/mlx5/core/steering/hws/action.c  |  27 ++-
 .../mellanox/mlx5/core/steering/hws/debug.c   |  22 +--
 .../mellanox/mlx5/core/steering/hws/matcher.c |  10 +-
 .../mellanox/mlx5/core/steering/hws/pool.c    | 182 ++++++------------
 .../mellanox/mlx5/core/steering/hws/pool.h    |  28 +--
 5 files changed, 91 insertions(+), 178 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/action.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/action.c
index b5332c54d4fb..781ba8c4f733 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/action.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/action.c
@@ -238,6 +238,7 @@ hws_action_fixup_stc_attr(struct mlx5hws_context *ctx,
 			  enum mlx5hws_table_type table_type,
 			  bool is_mirror)
 {
+	struct mlx5hws_pool *pool;
 	bool use_fixup = false;
 	u32 fw_tbl_type;
 	u32 base_id;
@@ -253,13 +254,11 @@ hws_action_fixup_stc_attr(struct mlx5hws_context *ctx,
 			use_fixup = true;
 			break;
 		}
+		pool = stc_attr->ste_table.ste_pool;
 		if (!is_mirror)
-			base_id = mlx5hws_pool_chunk_get_base_id(stc_attr->ste_table.ste_pool,
-								 &stc_attr->ste_table.ste);
+			base_id = mlx5hws_pool_get_base_id(pool);
 		else
-			base_id =
-				mlx5hws_pool_chunk_get_base_mirror_id(stc_attr->ste_table.ste_pool,
-								      &stc_attr->ste_table.ste);
+			base_id = mlx5hws_pool_get_base_mirror_id(pool);
 
 		*fixup_stc_attr = *stc_attr;
 		fixup_stc_attr->ste_table.ste_obj_id = base_id;
@@ -337,7 +336,7 @@ __must_hold(&ctx->ctrl_lock)
 	if (!mlx5hws_context_cap_dynamic_reparse(ctx))
 		stc_attr->reparse_mode = MLX5_IFC_STC_REPARSE_IGNORE;
 
-	obj_0_id = mlx5hws_pool_chunk_get_base_id(stc_pool, stc);
+	obj_0_id = mlx5hws_pool_get_base_id(stc_pool);
 
 	/* According to table/action limitation change the stc_attr */
 	use_fixup = hws_action_fixup_stc_attr(ctx, stc_attr, &fixup_stc_attr, table_type, false);
@@ -353,7 +352,7 @@ __must_hold(&ctx->ctrl_lock)
 	if (table_type == MLX5HWS_TABLE_TYPE_FDB) {
 		u32 obj_1_id;
 
-		obj_1_id = mlx5hws_pool_chunk_get_base_mirror_id(stc_pool, stc);
+		obj_1_id = mlx5hws_pool_get_base_mirror_id(stc_pool);
 
 		use_fixup = hws_action_fixup_stc_attr(ctx, stc_attr,
 						      &fixup_stc_attr,
@@ -393,11 +392,11 @@ __must_hold(&ctx->ctrl_lock)
 	stc_attr.action_type = MLX5_IFC_STC_ACTION_TYPE_DROP;
 	stc_attr.action_offset = MLX5HWS_ACTION_OFFSET_HIT;
 	stc_attr.stc_offset = stc->offset;
-	obj_id = mlx5hws_pool_chunk_get_base_id(stc_pool, stc);
+	obj_id = mlx5hws_pool_get_base_id(stc_pool);
 	mlx5hws_cmd_stc_modify(ctx->mdev, obj_id, &stc_attr);
 
 	if (table_type == MLX5HWS_TABLE_TYPE_FDB) {
-		obj_id = mlx5hws_pool_chunk_get_base_mirror_id(stc_pool, stc);
+		obj_id = mlx5hws_pool_get_base_mirror_id(stc_pool);
 		mlx5hws_cmd_stc_modify(ctx->mdev, obj_id, &stc_attr);
 	}
 
@@ -1581,7 +1580,6 @@ hws_action_create_dest_match_range_table(struct mlx5hws_context *ctx,
 					 u32 miss_ft_id)
 {
 	struct mlx5hws_cmd_rtc_create_attr rtc_attr = {0};
-	struct mlx5hws_action_default_stc *default_stc;
 	struct mlx5hws_matcher_action_ste *table_ste;
 	struct mlx5hws_pool_attr pool_attr = {0};
 	struct mlx5hws_pool *ste_pool, *stc_pool;
@@ -1629,7 +1627,7 @@ hws_action_create_dest_match_range_table(struct mlx5hws_context *ctx,
 	rtc_attr.fw_gen_wqe = true;
 	rtc_attr.is_scnd_range = true;
 
-	obj_id = mlx5hws_pool_chunk_get_base_id(ste_pool, ste);
+	obj_id = mlx5hws_pool_get_base_id(ste_pool);
 
 	rtc_attr.pd = ctx->pd_num;
 	rtc_attr.ste_base = obj_id;
@@ -1639,8 +1637,7 @@ hws_action_create_dest_match_range_table(struct mlx5hws_context *ctx,
 
 	/* STC is a single resource (obj_id), use any STC for the ID */
 	stc_pool = ctx->stc_pool;
-	default_stc = ctx->common_res.default_stc;
-	obj_id = mlx5hws_pool_chunk_get_base_id(stc_pool, &default_stc->default_hit);
+	obj_id = mlx5hws_pool_get_base_id(stc_pool);
 	rtc_attr.stc_base = obj_id;
 
 	ret = mlx5hws_cmd_rtc_create(ctx->mdev, &rtc_attr, rtc_0_id);
@@ -1650,11 +1647,11 @@ hws_action_create_dest_match_range_table(struct mlx5hws_context *ctx,
 	}
 
 	/* Create mirror RTC */
-	obj_id = mlx5hws_pool_chunk_get_base_mirror_id(ste_pool, ste);
+	obj_id = mlx5hws_pool_get_base_mirror_id(ste_pool);
 	rtc_attr.ste_base = obj_id;
 	rtc_attr.table_type = mlx5hws_table_get_res_fw_ft_type(MLX5HWS_TABLE_TYPE_FDB, true);
 
-	obj_id = mlx5hws_pool_chunk_get_base_mirror_id(stc_pool, &default_stc->default_hit);
+	obj_id = mlx5hws_pool_get_base_mirror_id(stc_pool);
 	rtc_attr.stc_base = obj_id;
 
 	ret = mlx5hws_cmd_rtc_create(ctx->mdev, &rtc_attr, rtc_1_id);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/debug.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/debug.c
index 696275fd0ce2..3491408c5d84 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/debug.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/debug.c
@@ -118,7 +118,6 @@ static int hws_debug_dump_matcher(struct seq_file *f, struct mlx5hws_matcher *ma
 {
 	enum mlx5hws_table_type tbl_type = matcher->tbl->type;
 	struct mlx5hws_cmd_ft_query_attr ft_attr = {0};
-	struct mlx5hws_pool_chunk *ste;
 	struct mlx5hws_pool *ste_pool;
 	u64 icm_addr_0 = 0;
 	u64 icm_addr_1 = 0;
@@ -134,12 +133,11 @@ static int hws_debug_dump_matcher(struct seq_file *f, struct mlx5hws_matcher *ma
 		   matcher->end_ft_id,
 		   matcher->col_matcher ? HWS_PTR_TO_ID(matcher->col_matcher) : 0);
 
-	ste = &matcher->match_ste.ste;
 	ste_pool = matcher->match_ste.pool;
 	if (ste_pool) {
-		ste_0_id = mlx5hws_pool_chunk_get_base_id(ste_pool, ste);
+		ste_0_id = mlx5hws_pool_get_base_id(ste_pool);
 		if (tbl_type == MLX5HWS_TABLE_TYPE_FDB)
-			ste_1_id = mlx5hws_pool_chunk_get_base_mirror_id(ste_pool, ste);
+			ste_1_id = mlx5hws_pool_get_base_mirror_id(ste_pool);
 	}
 
 	seq_printf(f, ",%d,%d,%d,%d",
@@ -148,12 +146,11 @@ static int hws_debug_dump_matcher(struct seq_file *f, struct mlx5hws_matcher *ma
 		   matcher->match_ste.rtc_1_id,
 		   (int)ste_1_id);
 
-	ste = &matcher->action_ste.ste;
 	ste_pool = matcher->action_ste.pool;
 	if (ste_pool) {
-		ste_0_id = mlx5hws_pool_chunk_get_base_id(ste_pool, ste);
+		ste_0_id = mlx5hws_pool_get_base_id(ste_pool);
 		if (tbl_type == MLX5HWS_TABLE_TYPE_FDB)
-			ste_1_id = mlx5hws_pool_chunk_get_base_mirror_id(ste_pool, ste);
+			ste_1_id = mlx5hws_pool_get_base_mirror_id(ste_pool);
 		else
 			ste_1_id = -1;
 	} else {
@@ -387,14 +384,17 @@ static int hws_debug_dump_context_stc(struct seq_file *f, struct mlx5hws_context
 	if (!stc_pool)
 		return 0;
 
-	if (stc_pool->resource[0]) {
-		ret = hws_debug_dump_context_stc_resource(f, ctx, stc_pool->resource[0]);
+	if (stc_pool->resource) {
+		ret = hws_debug_dump_context_stc_resource(f, ctx,
+							  stc_pool->resource);
 		if (ret)
 			return ret;
 	}
 
-	if (stc_pool->mirror_resource[0]) {
-		ret = hws_debug_dump_context_stc_resource(f, ctx, stc_pool->mirror_resource[0]);
+	if (stc_pool->mirror_resource) {
+		struct mlx5hws_pool_resource *res = stc_pool->mirror_resource;
+
+		ret = hws_debug_dump_context_stc_resource(f, ctx, res);
 		if (ret)
 			return ret;
 	}
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/matcher.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/matcher.c
index 37a4497048a6..59b14db427b4 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/matcher.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/matcher.c
@@ -223,7 +223,6 @@ static int hws_matcher_create_rtc(struct mlx5hws_matcher *matcher,
 	struct mlx5hws_cmd_rtc_create_attr rtc_attr = {0};
 	struct mlx5hws_match_template *mt = matcher->mt;
 	struct mlx5hws_context *ctx = matcher->tbl->ctx;
-	struct mlx5hws_action_default_stc *default_stc;
 	struct mlx5hws_matcher_action_ste *action_ste;
 	struct mlx5hws_table *tbl = matcher->tbl;
 	struct mlx5hws_pool *ste_pool, *stc_pool;
@@ -305,7 +304,7 @@ static int hws_matcher_create_rtc(struct mlx5hws_matcher *matcher,
 		return -EINVAL;
 	}
 
-	obj_id = mlx5hws_pool_chunk_get_base_id(ste_pool, ste);
+	obj_id = mlx5hws_pool_get_base_id(ste_pool);
 
 	rtc_attr.pd = ctx->pd_num;
 	rtc_attr.ste_base = obj_id;
@@ -316,8 +315,7 @@ static int hws_matcher_create_rtc(struct mlx5hws_matcher *matcher,
 
 	/* STC is a single resource (obj_id), use any STC for the ID */
 	stc_pool = ctx->stc_pool;
-	default_stc = ctx->common_res.default_stc;
-	obj_id = mlx5hws_pool_chunk_get_base_id(stc_pool, &default_stc->default_hit);
+	obj_id = mlx5hws_pool_get_base_id(stc_pool);
 	rtc_attr.stc_base = obj_id;
 
 	ret = mlx5hws_cmd_rtc_create(ctx->mdev, &rtc_attr, rtc_0_id);
@@ -328,11 +326,11 @@ static int hws_matcher_create_rtc(struct mlx5hws_matcher *matcher,
 	}
 
 	if (tbl->type == MLX5HWS_TABLE_TYPE_FDB) {
-		obj_id = mlx5hws_pool_chunk_get_base_mirror_id(ste_pool, ste);
+		obj_id = mlx5hws_pool_get_base_mirror_id(ste_pool);
 		rtc_attr.ste_base = obj_id;
 		rtc_attr.table_type = mlx5hws_table_get_res_fw_ft_type(tbl->type, true);
 
-		obj_id = mlx5hws_pool_chunk_get_base_mirror_id(stc_pool, &default_stc->default_hit);
+		obj_id = mlx5hws_pool_get_base_mirror_id(stc_pool);
 		rtc_attr.stc_base = obj_id;
 		hws_matcher_set_rtc_attr_sz(matcher, &rtc_attr, rtc_type, true);
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/pool.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/pool.c
index 35ed9bee06a6..0de03e17624c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/pool.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/pool.c
@@ -20,15 +20,14 @@ static void hws_pool_free_one_resource(struct mlx5hws_pool_resource *resource)
 	kfree(resource);
 }
 
-static void hws_pool_resource_free(struct mlx5hws_pool *pool,
-				   int resource_idx)
+static void hws_pool_resource_free(struct mlx5hws_pool *pool)
 {
-	hws_pool_free_one_resource(pool->resource[resource_idx]);
-	pool->resource[resource_idx] = NULL;
+	hws_pool_free_one_resource(pool->resource);
+	pool->resource = NULL;
 
 	if (pool->tbl_type == MLX5HWS_TABLE_TYPE_FDB) {
-		hws_pool_free_one_resource(pool->mirror_resource[resource_idx]);
-		pool->mirror_resource[resource_idx] = NULL;
+		hws_pool_free_one_resource(pool->mirror_resource);
+		pool->mirror_resource = NULL;
 	}
 }
 
@@ -78,7 +77,7 @@ hws_pool_create_one_resource(struct mlx5hws_pool *pool, u32 log_range,
 }
 
 static int
-hws_pool_resource_alloc(struct mlx5hws_pool *pool, u32 log_range, int idx)
+hws_pool_resource_alloc(struct mlx5hws_pool *pool, u32 log_range)
 {
 	struct mlx5hws_pool_resource *resource;
 	u32 fw_ft_type, opt_log_range;
@@ -91,7 +90,7 @@ hws_pool_resource_alloc(struct mlx5hws_pool *pool, u32 log_range, int idx)
 		return -EINVAL;
 	}
 
-	pool->resource[idx] = resource;
+	pool->resource = resource;
 
 	if (pool->tbl_type == MLX5HWS_TABLE_TYPE_FDB) {
 		struct mlx5hws_pool_resource *mirror_resource;
@@ -102,10 +101,10 @@ hws_pool_resource_alloc(struct mlx5hws_pool *pool, u32 log_range, int idx)
 		if (!mirror_resource) {
 			mlx5hws_err(pool->ctx, "Failed allocating mirrored resource\n");
 			hws_pool_free_one_resource(resource);
-			pool->resource[idx] = NULL;
+			pool->resource = NULL;
 			return -EINVAL;
 		}
-		pool->mirror_resource[idx] = mirror_resource;
+		pool->mirror_resource = mirror_resource;
 	}
 
 	return 0;
@@ -129,9 +128,9 @@ static void hws_pool_buddy_db_put_chunk(struct mlx5hws_pool *pool,
 {
 	struct mlx5hws_buddy_mem *buddy;
 
-	buddy = pool->db.buddy_manager->buddies[chunk->resource_idx];
+	buddy = pool->db.buddy;
 	if (!buddy) {
-		mlx5hws_err(pool->ctx, "No such buddy (%d)\n", chunk->resource_idx);
+		mlx5hws_err(pool->ctx, "Bad buddy state\n");
 		return;
 	}
 
@@ -139,86 +138,50 @@ static void hws_pool_buddy_db_put_chunk(struct mlx5hws_pool *pool,
 }
 
 static struct mlx5hws_buddy_mem *
-hws_pool_buddy_get_next_buddy(struct mlx5hws_pool *pool, int idx,
-			      u32 order, bool *is_new_buddy)
+hws_pool_buddy_get_buddy(struct mlx5hws_pool *pool, u32 order)
 {
 	static struct mlx5hws_buddy_mem *buddy;
 	u32 new_buddy_size;
 
-	buddy = pool->db.buddy_manager->buddies[idx];
+	buddy = pool->db.buddy;
 	if (buddy)
 		return buddy;
 
 	new_buddy_size = max(pool->alloc_log_sz, order);
-	*is_new_buddy = true;
 	buddy = mlx5hws_buddy_create(new_buddy_size);
 	if (!buddy) {
-		mlx5hws_err(pool->ctx, "Failed to create buddy order: %d index: %d\n",
-			    new_buddy_size, idx);
+		mlx5hws_err(pool->ctx, "Failed to create buddy order: %d\n",
+			    new_buddy_size);
 		return NULL;
 	}
 
-	if (hws_pool_resource_alloc(pool, new_buddy_size, idx) != 0) {
-		mlx5hws_err(pool->ctx, "Failed to create resource type: %d: size %d index: %d\n",
-			    pool->type, new_buddy_size, idx);
+	if (hws_pool_resource_alloc(pool, new_buddy_size) != 0) {
+		mlx5hws_err(pool->ctx, "Failed to create resource type: %d: size %d\n",
+			    pool->type, new_buddy_size);
 		mlx5hws_buddy_cleanup(buddy);
 		return NULL;
 	}
 
-	pool->db.buddy_manager->buddies[idx] = buddy;
+	pool->db.buddy = buddy;
 
 	return buddy;
 }
 
 static int hws_pool_buddy_get_mem_chunk(struct mlx5hws_pool *pool,
 					int order,
-					u32 *buddy_idx,
 					int *seg)
 {
 	struct mlx5hws_buddy_mem *buddy;
-	bool new_mem = false;
-	int ret = 0;
-	int i;
-
-	*seg = -1;
-
-	/* Find the next free place from the buddy array */
-	while (*seg < 0) {
-		for (i = 0; i < MLX5HWS_POOL_RESOURCE_ARR_SZ; i++) {
-			buddy = hws_pool_buddy_get_next_buddy(pool, i,
-							      order,
-							      &new_mem);
-			if (!buddy) {
-				ret = -ENOMEM;
-				goto out;
-			}
-
-			*seg = mlx5hws_buddy_alloc_mem(buddy, order);
-			if (*seg >= 0)
-				goto found;
-
-			if (pool->flags & MLX5HWS_POOL_FLAGS_ONE_RESOURCE) {
-				mlx5hws_err(pool->ctx,
-					    "Fail to allocate seg for one resource pool\n");
-				ret = -ENOMEM;
-				goto out;
-			}
-
-			if (new_mem) {
-				/* We have new memory pool, should be place for us */
-				mlx5hws_err(pool->ctx,
-					    "No memory for order: %d with buddy no: %d\n",
-					    order, i);
-				ret = -ENOMEM;
-				goto out;
-			}
-		}
-	}
 
-found:
-	*buddy_idx = i;
-out:
-	return ret;
+	buddy = hws_pool_buddy_get_buddy(pool, order);
+	if (!buddy)
+		return -ENOMEM;
+
+	*seg = mlx5hws_buddy_alloc_mem(buddy, order);
+	if (*seg >= 0)
+		return 0;
+
+	return -ENOMEM;
 }
 
 static int hws_pool_buddy_db_get_chunk(struct mlx5hws_pool *pool,
@@ -226,9 +189,7 @@ static int hws_pool_buddy_db_get_chunk(struct mlx5hws_pool *pool,
 {
 	int ret = 0;
 
-	/* Go over the buddies and find next free slot */
 	ret = hws_pool_buddy_get_mem_chunk(pool, chunk->order,
-					   &chunk->resource_idx,
 					   &chunk->offset);
 	if (ret)
 		mlx5hws_err(pool->ctx, "Failed to get free slot for chunk with order: %d\n",
@@ -240,33 +201,21 @@ static int hws_pool_buddy_db_get_chunk(struct mlx5hws_pool *pool,
 static void hws_pool_buddy_db_uninit(struct mlx5hws_pool *pool)
 {
 	struct mlx5hws_buddy_mem *buddy;
-	int i;
-
-	for (i = 0; i < MLX5HWS_POOL_RESOURCE_ARR_SZ; i++) {
-		buddy = pool->db.buddy_manager->buddies[i];
-		if (buddy) {
-			mlx5hws_buddy_cleanup(buddy);
-			kfree(buddy);
-			pool->db.buddy_manager->buddies[i] = NULL;
-		}
-	}
 
-	kfree(pool->db.buddy_manager);
+	buddy = pool->db.buddy;
+	if (buddy) {
+		mlx5hws_buddy_cleanup(buddy);
+		kfree(buddy);
+		pool->db.buddy = NULL;
+	}
 }
 
 static int hws_pool_buddy_db_init(struct mlx5hws_pool *pool, u32 log_range)
 {
-	pool->db.buddy_manager = kzalloc(sizeof(*pool->db.buddy_manager), GFP_KERNEL);
-	if (!pool->db.buddy_manager)
-		return -ENOMEM;
-
 	if (pool->flags & MLX5HWS_POOL_FLAGS_ALLOC_MEM_ON_CREATE) {
-		bool new_buddy;
-
-		if (!hws_pool_buddy_get_next_buddy(pool, 0, log_range, &new_buddy)) {
+		if (!hws_pool_buddy_get_buddy(pool, log_range)) {
 			mlx5hws_err(pool->ctx,
 				    "Failed allocating memory on create log_sz: %d\n", log_range);
-			kfree(pool->db.buddy_manager);
 			return -ENOMEM;
 		}
 	}
@@ -278,14 +227,13 @@ static int hws_pool_buddy_db_init(struct mlx5hws_pool *pool, u32 log_range)
 	return 0;
 }
 
-static int hws_pool_create_resource_on_index(struct mlx5hws_pool *pool,
-					     u32 alloc_size, int idx)
+static int hws_pool_create_resource(struct mlx5hws_pool *pool, u32 alloc_size)
 {
-	int ret = hws_pool_resource_alloc(pool, alloc_size, idx);
+	int ret = hws_pool_resource_alloc(pool, alloc_size);
 
 	if (ret) {
-		mlx5hws_err(pool->ctx, "Failed to create resource type: %d: size %d index: %d\n",
-			    pool->type, alloc_size, idx);
+		mlx5hws_err(pool->ctx, "Failed to create resource type: %d: size %d\n",
+			    pool->type, alloc_size);
 		return ret;
 	}
 
@@ -319,7 +267,7 @@ hws_pool_element_create_new_elem(struct mlx5hws_pool *pool, u32 order)
 		elem->log_size = alloc_size - order;
 	}
 
-	if (hws_pool_create_resource_on_index(pool, alloc_size, 0)) {
+	if (hws_pool_create_resource(pool, alloc_size)) {
 		mlx5hws_err(pool->ctx, "Failed to create resource type: %d: size %d\n",
 			    pool->type, alloc_size);
 		goto free_db;
@@ -355,7 +303,7 @@ static int hws_pool_element_find_seg(struct mlx5hws_pool_elements *elem, int *se
 
 static int
 hws_pool_onesize_element_get_mem_chunk(struct mlx5hws_pool *pool, u32 order,
-				       u32 *idx, int *seg)
+				       int *seg)
 {
 	struct mlx5hws_pool_elements *elem;
 
@@ -370,7 +318,6 @@ hws_pool_onesize_element_get_mem_chunk(struct mlx5hws_pool *pool, u32 order,
 		return -ENOMEM;
 	}
 
-	*idx = 0;
 	elem->num_of_elements++;
 	return 0;
 
@@ -379,21 +326,17 @@ hws_pool_onesize_element_get_mem_chunk(struct mlx5hws_pool *pool, u32 order,
 	return -ENOMEM;
 }
 
-static int
-hws_pool_general_element_get_mem_chunk(struct mlx5hws_pool *pool, u32 order,
-				       u32 *idx, int *seg)
+static int hws_pool_general_element_get_mem_chunk(struct mlx5hws_pool *pool,
+						  u32 order, int *seg)
 {
-	int ret, i;
-
-	for (i = 0; i < MLX5HWS_POOL_RESOURCE_ARR_SZ; i++) {
-		if (!pool->resource[i]) {
-			ret = hws_pool_create_resource_on_index(pool, order, i);
-			if (ret)
-				goto err_no_res;
-			*idx = i;
-			*seg = 0; /* One memory slot in that element */
-			return 0;
-		}
+	int ret;
+
+	if (!pool->resource) {
+		ret = hws_pool_create_resource(pool, order);
+		if (ret)
+			goto err_no_res;
+		*seg = 0; /* One memory slot in that element */
+		return 0;
 	}
 
 	mlx5hws_err(pool->ctx, "No more resources (last request order: %d)\n", order);
@@ -409,9 +352,7 @@ static int hws_pool_general_element_db_get_chunk(struct mlx5hws_pool *pool,
 {
 	int ret;
 
-	/* Go over all memory elements and find/allocate free slot */
 	ret = hws_pool_general_element_get_mem_chunk(pool, chunk->order,
-						     &chunk->resource_idx,
 						     &chunk->offset);
 	if (ret)
 		mlx5hws_err(pool->ctx, "Failed to get free slot for chunk with order: %d\n",
@@ -423,11 +364,8 @@ static int hws_pool_general_element_db_get_chunk(struct mlx5hws_pool *pool,
 static void hws_pool_general_element_db_put_chunk(struct mlx5hws_pool *pool,
 						  struct mlx5hws_pool_chunk *chunk)
 {
-	if (unlikely(!pool->resource[chunk->resource_idx]))
-		pr_warn("HWS: invalid resource with index %d\n", chunk->resource_idx);
-
 	if (pool->flags & MLX5HWS_POOL_FLAGS_RELEASE_FREE_RESOURCE)
-		hws_pool_resource_free(pool, chunk->resource_idx);
+		hws_pool_resource_free(pool);
 }
 
 static void hws_pool_general_element_db_uninit(struct mlx5hws_pool *pool)
@@ -455,7 +393,7 @@ static void
 hws_onesize_element_db_destroy_element(struct mlx5hws_pool *pool,
 				       struct mlx5hws_pool_elements *elem)
 {
-	hws_pool_resource_free(pool, 0);
+	hws_pool_resource_free(pool);
 	bitmap_free(elem->bitmap);
 	kfree(elem);
 	pool->db.element = NULL;
@@ -466,12 +404,9 @@ static void hws_onesize_element_db_put_chunk(struct mlx5hws_pool *pool,
 {
 	struct mlx5hws_pool_elements *elem;
 
-	if (unlikely(chunk->resource_idx))
-		pr_warn("HWS: invalid resource with index %d\n", chunk->resource_idx);
-
 	elem = pool->db.element;
 	if (!elem) {
-		mlx5hws_err(pool->ctx, "No such element (%d)\n", chunk->resource_idx);
+		mlx5hws_err(pool->ctx, "Pool element was not allocated\n");
 		return;
 	}
 
@@ -489,9 +424,7 @@ static int hws_onesize_element_db_get_chunk(struct mlx5hws_pool *pool,
 {
 	int ret = 0;
 
-	/* Go over all memory elements and find/allocate free slot */
 	ret = hws_pool_onesize_element_get_mem_chunk(pool, chunk->order,
-						     &chunk->resource_idx,
 						     &chunk->offset);
 	if (ret)
 		mlx5hws_err(pool->ctx, "Failed to get free slot for chunk with order: %d\n",
@@ -614,13 +547,10 @@ mlx5hws_pool_create(struct mlx5hws_context *ctx, struct mlx5hws_pool_attr *pool_
 
 int mlx5hws_pool_destroy(struct mlx5hws_pool *pool)
 {
-	int i;
-
 	mutex_destroy(&pool->lock);
 
-	for (i = 0; i < MLX5HWS_POOL_RESOURCE_ARR_SZ; i++)
-		if (pool->resource[i])
-			hws_pool_resource_free(pool, i);
+	if (pool->resource)
+		hws_pool_resource_free(pool);
 
 	hws_pool_db_unint(pool);
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/pool.h b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/pool.h
index f4258f83fdbf..112a61cd2997 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/pool.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/pool.h
@@ -6,16 +6,12 @@
 
 #define MLX5HWS_POOL_STC_LOG_SZ 15
 
-#define MLX5HWS_POOL_RESOURCE_ARR_SZ 100
-
 enum mlx5hws_pool_type {
 	MLX5HWS_POOL_TYPE_STE,
 	MLX5HWS_POOL_TYPE_STC,
 };
 
 struct mlx5hws_pool_chunk {
-	u32 resource_idx;
-	/* Internal offset, relative to base index */
 	int offset;
 	int order;
 };
@@ -72,14 +68,10 @@ enum mlx5hws_db_type {
 	MLX5HWS_POOL_DB_TYPE_GENERAL_SIZE,
 	/* One resource only, all the elements are with same one size */
 	MLX5HWS_POOL_DB_TYPE_ONE_SIZE_RESOURCE,
-	/* Many resources, the memory allocated with buddy mechanism */
+	/* Entries are managed using a buddy mechanism. */
 	MLX5HWS_POOL_DB_TYPE_BUDDY,
 };
 
-struct mlx5hws_buddy_manager {
-	struct mlx5hws_buddy_mem *buddies[MLX5HWS_POOL_RESOURCE_ARR_SZ];
-};
-
 struct mlx5hws_pool_elements {
 	u32 num_of_elements;
 	unsigned long *bitmap;
@@ -91,7 +83,7 @@ struct mlx5hws_pool_db {
 	enum mlx5hws_db_type type;
 	union {
 		struct mlx5hws_pool_elements *element;
-		struct mlx5hws_buddy_manager *buddy_manager;
+		struct mlx5hws_buddy_mem *buddy;
 	};
 };
 
@@ -109,8 +101,8 @@ struct mlx5hws_pool {
 	size_t alloc_log_sz;
 	enum mlx5hws_table_type tbl_type;
 	enum mlx5hws_pool_optimize opt_type;
-	struct mlx5hws_pool_resource *resource[MLX5HWS_POOL_RESOURCE_ARR_SZ];
-	struct mlx5hws_pool_resource *mirror_resource[MLX5HWS_POOL_RESOURCE_ARR_SZ];
+	struct mlx5hws_pool_resource *resource;
+	struct mlx5hws_pool_resource *mirror_resource;
 	/* DB */
 	struct mlx5hws_pool_db db;
 	/* Functions */
@@ -131,17 +123,13 @@ int mlx5hws_pool_chunk_alloc(struct mlx5hws_pool *pool,
 void mlx5hws_pool_chunk_free(struct mlx5hws_pool *pool,
 			     struct mlx5hws_pool_chunk *chunk);
 
-static inline u32
-mlx5hws_pool_chunk_get_base_id(struct mlx5hws_pool *pool,
-			       struct mlx5hws_pool_chunk *chunk)
+static inline u32 mlx5hws_pool_get_base_id(struct mlx5hws_pool *pool)
 {
-	return pool->resource[chunk->resource_idx]->base_id;
+	return pool->resource->base_id;
 }
 
-static inline u32
-mlx5hws_pool_chunk_get_base_mirror_id(struct mlx5hws_pool *pool,
-				      struct mlx5hws_pool_chunk *chunk)
+static inline u32 mlx5hws_pool_get_base_mirror_id(struct mlx5hws_pool *pool)
 {
-	return pool->mirror_resource[chunk->resource_idx]->base_id;
+	return pool->mirror_resource->base_id;
 }
 #endif /* MLX5HWS_POOL_H_ */
-- 
2.31.1


