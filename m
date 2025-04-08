Return-Path: <linux-rdma+bounces-9257-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 185E2A80D5C
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Apr 2025 16:10:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DC321685C4
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Apr 2025 14:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F523226D11;
	Tue,  8 Apr 2025 14:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pUn8VPeT"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2084.outbound.protection.outlook.com [40.107.101.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 542C722686B;
	Tue,  8 Apr 2025 14:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744120994; cv=fail; b=MmFMnoyxVnPWTXeAGBo3igdsvsEOK85qra+lTeiIeLdSqYFUe+KRUgqHzgwlf3MoVUQzyRBUUMmAwX+zPvJwtuJwfs4KEDGMyM0BmzIZuiyZbmvj6Ngc+v4Zz5r4yO7xCul3qrRrp172dmi2zB00k/I+fBizKFLRmqOZd5KAfF8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744120994; c=relaxed/simple;
	bh=2yRrZTwKDI838RRAhOeEU9QVOsJTqD7VqgvjtNCDZeE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hAduDSY3cLZFgdV9bSgKo1r0upkfgAiCs7nUz0XZ938oV95gPHVNQvL32Di6+KghxRTuKbGI43YQ9rVUb+Xw6cP+XSIJbz5OFdikI9XBgEqQJW547tzbAIZeOEG+e2WUUKzUV5VGlcgp60+YXo9ygL42nj0ZNQWe2XQ5Fs4bkWc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pUn8VPeT; arc=fail smtp.client-ip=40.107.101.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X+jFFUI7OvymLKe+mQQC3zZLbUf06QConS/gkBNVCHA0NPTy2rDvFpto66w4TxwPq0vL/usUDTxmQrgw2Egr5TET4smtG2Qrm/aR5GM6YA9met7oXaUuiApSz9W0TjteTNYG+55IoY/yCc8wDoLIhgSGz7DZYOfb4nTlC33os6Ix3Ci2Dv+e8uaD2M8///owJL3nT0b9s9mHNjgf6eIX5QmiPQRmh5F4za11gJQNpc3/VbF0ryfBlkicOYq91OLoPIm8wV1xTfRQPOJMSssjZkkAQcYT4Uhm8xFuNjOvfbhHRKk544AnAnmICmSjppRZkbSuMR5e//PupUH8jTxBjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o7rOyOL53YXIVAvcV3T1bcOVP+wi42Rzd2lGp0HroAs=;
 b=x3smSeI8xykBdZ+193yXRp9zPkD3qvZwGhA9LZFQZbdE567c9G/6wfvtuNa8vnNzs2YHourwhoeTj1Ic+lDvlll6IyqyiWaT9CN7LfRrMHZ89wA9EjnWsj4wjvonA/1V5W0uPVQHSKkY4F0YwtQ03IR7fY3zioxaCrQikDy0juslVrhJ2XRr7xZYNBxNiBF6/brSMxbQ/6UQygL/qjEUjpABi4dDFQ+m6UEGNkp9pJwfP6cLcpNz+EdUSrvfJxdGs2pKPNij+Y2h4aJU13asA2QeXbZRTCnhgRlz431O9Is6ExASyCoyDx7zkW/AOom0pr4FQcDC1kZFQAJzc0Xhsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o7rOyOL53YXIVAvcV3T1bcOVP+wi42Rzd2lGp0HroAs=;
 b=pUn8VPeTUQy0L+a3xNSKMhJdtHX+IxTvEt+YXhdN1q/NPJnndZHQLUvPc7pqqR9zHLSn9ezIRIC+waCQEr23tgrAkT77bDjUfZchzJx45E2yNwaDO0XNJTvMZPUDn/6TxTNNYZ0HRPZu3us1h3ciXi4V0UU+v+2QDWMNSCARcCza7POffMGSN+u859YrKiqp1zwJnyuulyDusSg3Hn8g8Edgxu3qHy0B0ZAtSH/xjojgdb0nAxLDReuCDRgf/NDNTE3jUe685ZsuMRpw3abSLLj8CzQ6EIJmEWb9yJbSKDO/WY13dKlr9wRoVPdm0nwiUQOJ/G9pAMTAFlhfuEcSeg==
Received: from SA0PR11CA0053.namprd11.prod.outlook.com (2603:10b6:806:d0::28)
 by CH3PR12MB8935.namprd12.prod.outlook.com (2603:10b6:610:169::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.27; Tue, 8 Apr
 2025 14:03:08 +0000
Received: from SA2PEPF00003F64.namprd04.prod.outlook.com
 (2603:10b6:806:d0:cafe::27) by SA0PR11CA0053.outlook.office365.com
 (2603:10b6:806:d0::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8606.27 via Frontend Transport; Tue,
 8 Apr 2025 14:03:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF00003F64.mail.protection.outlook.com (10.167.248.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8606.22 via Frontend Transport; Tue, 8 Apr 2025 14:03:06 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 8 Apr 2025
 07:02:44 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 8 Apr
 2025 07:02:43 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Tue, 8 Apr
 2025 07:02:39 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: Gal Pressman <gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, "Saeed
 Mahameed" <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Tariq
 Toukan <tariqt@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Moshe Shemesh
	<moshe@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Vlad Dogaru
	<vdogaru@nvidia.com>, Yevgeny Kliteynik <kliteyn@nvidia.com>
Subject: [PATCH net-next 09/12] net/mlx5: HWS, Use the new action STE pool
Date: Tue, 8 Apr 2025 17:00:53 +0300
Message-ID: <1744120856-341328-10-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1744120856-341328-1-git-send-email-tariqt@nvidia.com>
References: <1744120856-341328-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F64:EE_|CH3PR12MB8935:EE_
X-MS-Office365-Filtering-Correlation-Id: 46067b73-c151-4d6f-7ab3-08dd76a61651
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Inp1OrVQW9pT9EfcpC8x6KEo6VQWF0vAoGguu2QaQUO7iHtSCZDQOquEav8l?=
 =?us-ascii?Q?0t3wP9ZVb6yPxv4eFNrJFV0Y7SXzIjf2Q09Hk+SFR8/4ViswfHljSIVjWNoQ?=
 =?us-ascii?Q?HO5r3v28yV0Fj/pCvxFMFBbxf/dLG8iPL2I4LULb5S2ktcQiV2iekgYf9Tor?=
 =?us-ascii?Q?YgRPBc3q2zoiLzLzfgvMs0SadHaM4Ank0o6LYH7gr64AXBqr53evNlYSfoAc?=
 =?us-ascii?Q?vvqpHlxelntz23fp+uONPLu4D+vu1a47xAELzOpn5fme6uut7kVPWciWbxuN?=
 =?us-ascii?Q?CntJi+1pCkkbsHOlbzWp19dua2UAbEsgBXuM41zFtn4IvUqa7HmWX4Wy0cIm?=
 =?us-ascii?Q?EI4HWG2iQcmsRJeWzDCmBC4cDb4mEgz7GmP2JLqJ0P3ozFwem1U+GqUKWhX0?=
 =?us-ascii?Q?E+AbmbiufJhLKtyyyQfeeObVuga4A87EiYPBlRFCzf3rfY30vn1WSsfA0gZR?=
 =?us-ascii?Q?Bpa7KrHNlORhffei1pxJ0etTSFYiNq7n1i8smaUY/nCwTDnEeRG6Tx4Os2BH?=
 =?us-ascii?Q?WfXHYhxnBcOtM0RUvQbSzNdtUuY08U+G3/vqdEyANLPszJDGvPr+vcnPMDy2?=
 =?us-ascii?Q?evWTsQiZGGZsv/bNOgcxuiy6FGh7DgTedNYVfGPYszNKNetLF7fUInWA18c2?=
 =?us-ascii?Q?0wEhBTHJ94jdUSlOaXNFMbhPZZt4VYOxeDj9eTEMfzBASYtaQ8LIf+wYnVJk?=
 =?us-ascii?Q?JPkk0upj0i3NQkPAK/2xtxBE+z3/WwmhIPrT0yk6yhcutQY9rMQ2eYtqA1hf?=
 =?us-ascii?Q?gj9fxfrr5ijGr4DyUS/bT95sCf0g0MkxWhiVtpHA5PI86T7368a/pUbjIHUR?=
 =?us-ascii?Q?zg3sRSqeDBryiDkJxSK+c5I/84bLePivKb5OcGLAAcV5eKTtleNQP9eTmgod?=
 =?us-ascii?Q?d39OidImazZA4dGZUOVit6ECGA0caiDfF3nebSqGQ7w6WWhhPFn92M+ZCP91?=
 =?us-ascii?Q?mVbK0uaiDKD4DczOhRKjT8YlELrpi9WBbvbxMjeUuoJ6h/Imkh/XEcFT8YQo?=
 =?us-ascii?Q?v6ttPs4nP/7OzuRitJD1+xRMFXwSKlbf/lvcMu8h2m4G+w6ShYXc4VpyQRJv?=
 =?us-ascii?Q?Vc9b5q6QqK8s7HgY8d2rrlh8C7F/b7knoAZhlJ2qqYEz3zKSiW8GYBamzjFV?=
 =?us-ascii?Q?juV1fBe80cg4oqs2663YaCvQMb5kVV126zZXJ0v8Hnx0/BlNiH+ZvvoiOBe4?=
 =?us-ascii?Q?Wn/vbNeS8KcipTP37B6FbbdJloGw2Ao84M4L2RbomWzkzx3xqD8nWQePaI4F?=
 =?us-ascii?Q?V+8NOv9EbY88OmiWrIrk7c2+jhOdLRt4N83Cug30I3lefGUpHxgEX343GtR9?=
 =?us-ascii?Q?pBpXenGlkV2neaINIX5LCR5hi4wnzdJtSKyr/Bg9em9uqNUyUJuHf3F1yYCe?=
 =?us-ascii?Q?c314JPyu0ZoHB2+BTNsRSl0FnIjB2gmF/OTSy8oD9cx4CH2Ue4haaceLURuO?=
 =?us-ascii?Q?naGAKLFzgDKmcC2lmJQJIPeLlkei6l3CTS0t8HxSEFH3mTbwfwRCIJlu6AlN?=
 =?us-ascii?Q?/CVyhMr0UYU/S4k=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2025 14:03:06.6003
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 46067b73-c151-4d6f-7ab3-08dd76a61651
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F64.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8935

From: Vlad Dogaru <vdogaru@nvidia.com>

Use the central action STE pool when creating / updating rules.

Signed-off-by: Vlad Dogaru <vdogaru@nvidia.com>
Reviewed-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../mellanox/mlx5/core/steering/hws/rule.c    | 69 ++++++++-----------
 .../mellanox/mlx5/core/steering/hws/rule.h    | 12 +---
 2 files changed, 30 insertions(+), 51 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/rule.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/rule.c
index a27a2d5ffc7b..5b758467ed03 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/rule.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/rule.c
@@ -195,44 +195,30 @@ hws_rule_load_delete_info(struct mlx5hws_rule *rule,
 	}
 }
 
-static int hws_rule_alloc_action_ste(struct mlx5hws_rule *rule)
+static int mlx5hws_rule_alloc_action_ste(struct mlx5hws_rule *rule,
+					 u16 queue_id, bool skip_rx,
+					 bool skip_tx)
 {
 	struct mlx5hws_matcher *matcher = rule->matcher;
-	struct mlx5hws_matcher_action_ste *action_ste;
-	struct mlx5hws_pool_chunk ste = {0};
-	int ret;
-
-	action_ste = &matcher->action_ste;
-	ste.order = ilog2(roundup_pow_of_two(action_ste->max_stes));
-	ret = mlx5hws_pool_chunk_alloc(action_ste->pool, &ste);
-	if (unlikely(ret)) {
-		mlx5hws_err(matcher->tbl->ctx,
-			    "Failed to allocate STE for rule actions");
-		return ret;
-	}
-
-	rule->action_ste.pool = matcher->action_ste.pool;
-	rule->action_ste.num_stes = matcher->action_ste.max_stes;
-	rule->action_ste.index = ste.offset;
+	struct mlx5hws_context *ctx = matcher->tbl->ctx;
 
-	return 0;
+	rule->action_ste.ste.order =
+		ilog2(roundup_pow_of_two(matcher->action_ste.max_stes));
+	return mlx5hws_action_ste_chunk_alloc(&ctx->action_ste_pool[queue_id],
+					      skip_rx, skip_tx,
+					      &rule->action_ste);
 }
 
-void mlx5hws_rule_free_action_ste(struct mlx5hws_rule_action_ste_info *action_ste)
+void mlx5hws_rule_free_action_ste(struct mlx5hws_action_ste_chunk *action_ste)
 {
-	struct mlx5hws_pool_chunk ste = {0};
-
-	if (!action_ste->num_stes)
+	if (!action_ste->action_tbl)
 		return;
 
-	ste.order = ilog2(roundup_pow_of_two(action_ste->num_stes));
-	ste.offset = action_ste->index;
-
 	/* This release is safe only when the rule match STE was deleted
 	 * (when the rule is being deleted) or replaced with the new STE that
 	 * isn't pointing to old action STEs (when the rule is being updated).
 	 */
-	mlx5hws_pool_chunk_free(action_ste->pool, &ste);
+	mlx5hws_action_ste_chunk_free(action_ste);
 }
 
 static void hws_rule_create_init(struct mlx5hws_rule *rule,
@@ -250,22 +236,15 @@ static void hws_rule_create_init(struct mlx5hws_rule *rule,
 		rule->rtc_0 = 0;
 		rule->rtc_1 = 0;
 
-		rule->action_ste.pool = NULL;
-		rule->action_ste.num_stes = 0;
-		rule->action_ste.index = -1;
-
 		rule->status = MLX5HWS_RULE_STATUS_CREATING;
 	} else {
 		rule->status = MLX5HWS_RULE_STATUS_UPDATING;
+		/* Save the old action STE info so we can free it after writing
+		 * new action STEs and a corresponding match STE.
+		 */
+		rule->old_action_ste = rule->action_ste;
 	}
 
-	/* Initialize the old action STE info - shallow-copy action_ste.
-	 * In create flow this will set old_action_ste fields to initial values.
-	 * In update flow this will save the existing action STE info,
-	 * so that we will later use it to free old STEs.
-	 */
-	rule->old_action_ste = rule->action_ste;
-
 	rule->pending_wqes = 0;
 
 	/* Init default send STE attributes */
@@ -277,7 +256,6 @@ static void hws_rule_create_init(struct mlx5hws_rule *rule,
 	/* Init default action apply */
 	apply->tbl_type = tbl->type;
 	apply->common_res = &ctx->common_res;
-	apply->jump_to_action_stc = matcher->action_ste.stc.offset;
 	apply->require_dep = 0;
 }
 
@@ -353,17 +331,24 @@ static int hws_rule_create_hws(struct mlx5hws_rule *rule,
 
 	if (action_stes) {
 		/* Allocate action STEs for rules that need more than match STE */
-		ret = hws_rule_alloc_action_ste(rule);
+		ret = mlx5hws_rule_alloc_action_ste(rule, attr->queue_id,
+						    !!ste_attr.rtc_0,
+						    !!ste_attr.rtc_1);
 		if (ret) {
 			mlx5hws_err(ctx, "Failed to allocate action memory %d", ret);
 			mlx5hws_send_abort_new_dep_wqe(queue);
 			return ret;
 		}
+		apply.jump_to_action_stc =
+			rule->action_ste.action_tbl->stc.offset;
 		/* Skip RX/TX based on the dep_wqe init */
-		ste_attr.rtc_0 = dep_wqe->rtc_0 ? matcher->action_ste.rtc_0_id : 0;
-		ste_attr.rtc_1 = dep_wqe->rtc_1 ? matcher->action_ste.rtc_1_id : 0;
+		ste_attr.rtc_0 = dep_wqe->rtc_0 ?
+				 rule->action_ste.action_tbl->rtc_0_id : 0;
+		ste_attr.rtc_1 = dep_wqe->rtc_1 ?
+				 rule->action_ste.action_tbl->rtc_1_id : 0;
 		/* Action STEs are written to a specific index last to first */
-		ste_attr.direct_index = rule->action_ste.index + action_stes;
+		ste_attr.direct_index =
+			rule->action_ste.ste.offset + action_stes;
 		apply.next_direct_idx = ste_attr.direct_index;
 	} else {
 		apply.next_direct_idx = 0;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/rule.h b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/rule.h
index b5ee94ac449b..1c47a9c11572 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/rule.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/rule.h
@@ -43,12 +43,6 @@ struct mlx5hws_rule_match_tag {
 	};
 };
 
-struct mlx5hws_rule_action_ste_info {
-	struct mlx5hws_pool *pool;
-	int index; /* STE array index */
-	u8 num_stes;
-};
-
 struct mlx5hws_rule_resize_info {
 	u32 rtc_0;
 	u32 rtc_1;
@@ -64,8 +58,8 @@ struct mlx5hws_rule {
 		struct mlx5hws_rule_match_tag tag;
 		struct mlx5hws_rule_resize_info *resize_info;
 	};
-	struct mlx5hws_rule_action_ste_info action_ste;
-	struct mlx5hws_rule_action_ste_info old_action_ste;
+	struct mlx5hws_action_ste_chunk action_ste;
+	struct mlx5hws_action_ste_chunk old_action_ste;
 	u32 rtc_0; /* The RTC into which the STE was inserted */
 	u32 rtc_1; /* The RTC into which the STE was inserted */
 	u8 status; /* enum mlx5hws_rule_status */
@@ -75,7 +69,7 @@ struct mlx5hws_rule {
 			   */
 };
 
-void mlx5hws_rule_free_action_ste(struct mlx5hws_rule_action_ste_info *action_ste);
+void mlx5hws_rule_free_action_ste(struct mlx5hws_action_ste_chunk *action_ste);
 
 int mlx5hws_rule_move_hws_remove(struct mlx5hws_rule *rule,
 				 void *queue, void *user_data);
-- 
2.31.1


