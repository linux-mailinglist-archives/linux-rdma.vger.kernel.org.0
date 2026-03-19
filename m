Return-Path: <linux-rdma+bounces-18382-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SKSHMdSpu2nHmQIAu9opvQ
	(envelope-from <linux-rdma+bounces-18382-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Mar 2026 08:46:28 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 70D482C7746
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Mar 2026 08:46:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 63DC73025D24
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Mar 2026 07:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEFD7399353;
	Thu, 19 Mar 2026 07:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pKB7ynxw"
X-Original-To: linux-rdma@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011025.outbound.protection.outlook.com [52.101.62.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3891D3A4523;
	Thu, 19 Mar 2026 07:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773906274; cv=fail; b=LubToNruCmTYB2bXokxKRnLVEUNa0KvSfTvxR+4T5UCvLaWaVkFDsY1jBuyvTFtAo4d/lQqXU/ewpR7KhssVLlgt1debUbZpjRL0Q3sTuEBKFY7t3Cuuy6IeTGwSGBh88X03FoPpVvzULD7TtSW7RPlHS4pFRmE9eKAIkwiQkgQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773906274; c=relaxed/simple;
	bh=VHTZXkAmw9sCXxDvCbbthQqj+YZAUvIaWm4gFm8FvnQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BGZb4YR0fkiQH6BWmsslpUrT8Wz/fSuve8lPyvQ6C5kK9ZwIbspp2xg50JjHLXXSzVWKJ3PSCutpWNU682prIvlGxTLMNm8MzNFhIYKaxJ9X81YouuuvE86fYOGz74lSlzKUzWCmGcntQTiA64/HuF05JTSynKFfhzs3Pls2Kc4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pKB7ynxw; arc=fail smtp.client-ip=52.101.62.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i6B+Ch2vCrfA+GIWrrnyZfJSTwn67gnRgwYbMO0BZIw1Epg52cG3UgWLrsKz5QhGJguSp70JpSt7thshe1BQ0uI7KEnLsBxQsFyAUmBUDR2OaVPSKuNnhILIkzger+oeqI2sGulspbFKUrOhzvFqkOiW2q+58iMOmpWDstDSrtAgjD004P2Etgx6lgBKGQ+7vF7sXX/i658x8Tb7LXYXm9M16MwDGozJHodeoV4fy2ypiSebZ+4q3ciPN2AZjRTntACjoTBKjzmcQHv4BedA1OCJga39LO/wfIBywQU4/Im5GbQhpn8TDtl60P3nB7oqrz7c8M1+QaDjYD0DWozi/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AcWC2gphApqm3OrSBbEG7f+XZCtfB/5g6T02vgBpPWQ=;
 b=XDl6i3sKTKovmaWcD8fZjEgQEDKmLJZ+msGKPPfmbjwXpne6TA45nTPxNB+uwz11RZNILC4L21GLor/vlupXO4VRGsM5URaNCle0LR1SCcUDUBMCE2GHMcaJvFR1IedS/Hpy28jAJoOKQdzl4UfWMRGv0dkEMgEQAGaKjzDqPMVkoTZk70ejMQQBbpYECC/o5FLIlqpZWfsgyoAZc8prGzKVdx99xGJcmfZq2HIONnJDCqbsmhj183KbKZ30uUe/jhaDiJqieeTt5ZfqYjnOVZklkq7taCXzGu7SfoD5T225D5PZNL4HtVNrZ+SwVD1FMHMbUi5ytYpfrJUAbl6U6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AcWC2gphApqm3OrSBbEG7f+XZCtfB/5g6T02vgBpPWQ=;
 b=pKB7ynxwXdjb/Da2ODPGfqpBFXGsV3AaaU2xWl/ihwTEDH8jkqX9GSwHWXXbcbIKF6VZz5kbp/XysSridkXplaYjqE0sR86uwT9cCrlDcaOvarg9QZcfDW0lAwFO9oPm83q5vvm+HSLzyEvVGzgy4voI0ADXxreZlYktgIRLmK8jRYiedXt4YkrOT2HPjcSLz4QP/lRJ6Pzil4s+ii3oexDtvat7f8uRrC+XaAznuG/blarbzQNbpqamszz1QpP5pVj4yeP2BcgMvgPSigmihfBBBw5FsH4H4k6Tki6W/jWDogTrb5LpIKB/MrxhDS4j8Ja+11gQVTFlwlT2icrHbQ==
Received: from CY8PR11CA0032.namprd11.prod.outlook.com (2603:10b6:930:4a::25)
 by BY5PR12MB4209.namprd12.prod.outlook.com (2603:10b6:a03:20d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.10; Thu, 19 Mar
 2026 07:44:28 +0000
Received: from CY4PEPF0000EE3D.namprd03.prod.outlook.com
 (2603:10b6:930:4a:cafe::1b) by CY8PR11CA0032.outlook.office365.com
 (2603:10b6:930:4a::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.27 via Frontend Transport; Thu,
 19 Mar 2026 07:44:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EE3D.mail.protection.outlook.com (10.167.242.15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Thu, 19 Mar 2026 07:44:28 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 19 Mar
 2026 00:44:13 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 19 Mar
 2026 00:44:12 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Thu, 19
 Mar 2026 00:44:08 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>
Subject: [PATCH net-next 2/3] net/mlx5e: RX, Pre-calculate pad value in MPWQE
Date: Thu, 19 Mar 2026 09:43:37 +0200
Message-ID: <20260319074338.24265-3-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260319074338.24265-1-tariqt@nvidia.com>
References: <20260319074338.24265-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3D:EE_|BY5PR12MB4209:EE_
X-MS-Office365-Filtering-Correlation-Id: 22b3746a-f5a0-4731-bbae-08de858b59b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|1800799024|82310400026|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	g/N6Cf/8zPfEFZv3xyZw/8QU1Cx1JU3XU2fz7/CmzPuW/wV/EJqMY4vQUc7+2qb2jloRfi5ESaP8Ms0aP9QDkXvHv9czU9PRNjwNPY7GddA1Z24ZNXr/RNJ1OMDSZd0CaaavSlKsvoBPZ+JVmAGSbcJx9aQKm/I4yaEMSadisZcw38tUnzN7ZGNMQQlJ7LbAVMvixuVuYlIJzOVuzQ8AS2ZfHT+TfRMHSZ2w8RVgdukyd6Oy4QP1+mALO2UlCb1nW+RBgZtFizpyobFzd1EjqsLV5b6bAt/kCIa5RMCOxkaf6pCfft0yut8jvdKCBaB+GSA9AP0PH8on9c/hMDWqZHv5krnXTIhMfGnt6pG8UOjs/2rnmKAC9s7cXY9BnvjXdkDti5RbW/er4GcXUhD9mRZqZFq+Ph6mKZC8sqDMGGBoBwuwm8RETtASxMCL0jIySuMHnP+Y/XrkxzRRlpTPHy7iWt5HjCYFk2asLtrYAiUZrTni3Co/sr7Mhi8fiVTBSXy0Y1owEwTge2TnDOf3cR9l0SGEOPss+rDpJBfH5gNsuwdNvXQS+mvaf3wOPwEKzflP2WXT2dDdmB7ReBNfq5h6K46odaIFCCzt3Fs20WW5IXxoMjgGtSVUDattTdI0kCW3P8CTd7X29focY69Yj7+rRpEty9id00/h2wIF/BS51z4bPZJTyKDKII21d6tFWbvY7O7GYrbW9vnEAzOSvgxalR6Tu8p/4bWnG/M+sVLEGnPxST/lZ/sM5WxswLEqQqf/sQONIeFIRE0EAXJK5g==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	4FgSBdi7X9B8nweefzLpdEuLBf84SOt/G6PXyM9D1t+aBnJzS06QT2+k6ieK5hCdY+O9b+BP1fIyg9zdEFw7HPFyorHsk2Re25MIGdvghPeTigj5cz2KNd6RvsXEBndhqpedqJrcJFn6dh7i6X7cAyO7gXk0Z1nofDzGEyLTcLrbpjYW2b1AOLnDQJMHMWPT4BoSKutoShOvdnrcuoAM+lvUBFvk0Ce8AnNuoj/pkh8Ikz76l5wXlTd6CRodEEJh3s1ntGWG09evofodqbq1ynVFo6/5YEiYyYxS9Km2EqiQK5E/Ps8Ltz7tzXJvlP9l+KdPelCjzl9HsaCKi1FXmsAGJxyw6/eTbOOJTB2nlD6sBixn5ab2kSI0JTwxBMW5rl6wgkk/ppPMkA/nMREgc4zri7ens97Kx7kRiM85pClIDCCOa+RCd8R/Zv4lIAI2
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 07:44:28.4070
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 22b3746a-f5a0-4731-bbae-08de858b59b8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4209
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
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-18382-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email,nvidia.com:mid,Nvidia.com:dkim];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.967];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 70D482C7746
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Introduce a dedicated function that calculates the needed entries
padding in a UMR WQE.
Use it to pre-calculate the padding value and save it on the RQ struct.

Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en.h      |  1 +
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c | 14 ++++++++++++++
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c   |  8 ++------
 3 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
index d90be82a9019..6c773a75b514 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
@@ -685,6 +685,7 @@ struct mlx5e_rq {
 			u8                     min_wqe_bulk;
 			u8                     page_shift;
 			u8                     pages_per_wqe;
+			u8                     entries_pad;
 			u8                     umr_wqebbs;
 			u8                     mtts_per_wqe;
 			u8                     umr_mode;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 20c24d829ee2..5a31c79cec06 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -307,6 +307,17 @@ static void mlx5e_disable_blocking_events(struct mlx5e_priv *priv)
 	mlx5_blocking_notifier_unregister(priv->mdev, &priv->blocking_events_nb);
 }
 
+static u8 mlx5e_mpwrq_umr_entries_pad(u32 entries,
+				      enum mlx5e_mpwrq_umr_mode umr_mode)
+{
+	u8 umr_entry_size = mlx5e_mpwrq_umr_entry_size(umr_mode);
+	u32 sz;
+
+	sz = entries * umr_entry_size;
+
+	return ALIGN(sz, MLX5_UMR_FLEX_ALIGNMENT) - sz;
+}
+
 static u16 mlx5e_mpwrq_umr_octowords(u32 entries, enum mlx5e_mpwrq_umr_mode umr_mode)
 {
 	u8 umr_entry_size = mlx5e_mpwrq_umr_entry_size(umr_mode);
@@ -904,6 +915,9 @@ static int mlx5e_alloc_rq(struct mlx5e_params *params,
 		rq->mpwqe.pages_per_wqe =
 			mlx5e_mpwrq_pages_per_wqe(mdev, rq->mpwqe.page_shift,
 						  rq->mpwqe.umr_mode);
+		rq->mpwqe.entries_pad =
+			mlx5e_mpwrq_umr_entries_pad(rq->mpwqe.pages_per_wqe,
+						    rq->mpwqe.umr_mode);
 		rq->mpwqe.umr_wqebbs =
 			mlx5e_mpwrq_umr_wqebbs(mdev, rq->mpwqe.page_shift,
 					       rq->mpwqe.umr_mode);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
index f5c0e2a0ada9..580bb51ad7ef 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -645,13 +645,9 @@ static int mlx5e_alloc_rx_mpwqe(struct mlx5e_rq *rq, u16 ix)
 	/* Pad if needed, in case the value set to ucseg->xlt_octowords
 	 * in mlx5e_build_umr_wqe() needed alignment.
 	 */
-	if (rq->mpwqe.pages_per_wqe & (MLX5_UMR_MTT_NUM_ENTRIES_ALIGNMENT - 1)) {
-		int pad = ALIGN(rq->mpwqe.pages_per_wqe, MLX5_UMR_MTT_NUM_ENTRIES_ALIGNMENT) -
-			rq->mpwqe.pages_per_wqe;
-
+	if (rq->mpwqe.entries_pad)
 		memset(&umr_wqe->inline_mtts[rq->mpwqe.pages_per_wqe], 0,
-		       sizeof(*umr_wqe->inline_mtts) * pad);
-	}
+		       rq->mpwqe.entries_pad);
 
 	bitmap_zero(wi->skip_release_bitmap, rq->mpwqe.pages_per_wqe);
 	wi->consumed_strides = 0;
-- 
2.44.0


