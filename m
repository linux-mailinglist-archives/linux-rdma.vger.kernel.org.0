Return-Path: <linux-rdma+bounces-19192-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KBq2FuIM2Gm5WggAu9opvQ
	(envelope-from <linux-rdma+bounces-19192-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 09 Apr 2026 22:32:34 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AFA773CF85E
	for <lists+linux-rdma@lfdr.de>; Thu, 09 Apr 2026 22:32:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B1F9230432CF
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Apr 2026 20:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAF7233F374;
	Thu,  9 Apr 2026 20:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="V2xlIBzq"
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012021.outbound.protection.outlook.com [40.107.209.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE02330D43;
	Thu,  9 Apr 2026 20:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775766592; cv=fail; b=gitPKSeNZ4ONxpR7KrA7x0KqaO3PxGOCCgf4WppGRZHPnCO1GmTZOdh9htryUkr0/LvF6OmjfYdErVc+KVccxn7F9A9/rTsW8X4SyEzFhNYhynH5cFlNNs1ZNSABtDuWNuXYCWGKHFIjDHQVeGteVmRrlS9qDUdJwk5FVRPzKzI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775766592; c=relaxed/simple;
	bh=FCDy4Wpy9HhnxU6kizkgllKL08Xne+sVuIPwkRKvlJM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nlWbFPJ2E7SJRjflNUGEQfVV5n0ww2dEGCFYa9GP5Z6rsGHA6eizjHGIaOuq76boUTeVVB2KUfHifGh8WgMuZ/BaCGZJpxY81qpAgi+vyzSfA4bp5JWo9Nj3fdNF7EHS3PvRiURoSYf0zYCJpwNfE8V4ItwWYUj7ZYcqsnnDgR0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=V2xlIBzq; arc=fail smtp.client-ip=40.107.209.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TsNmc/p2aso7sGVNbkoOH6etOuJO2tYo4Fyum4pjwxN0o0MjKYqITQDOANjwEDr0LXfZYWByIPOtclwtpgb+9lwcw0uon0YeZNSovwK4YowFdhj7rfdFcqMIm+QziooNMuLkg4oLveKIt0RyXqMgSouQqCGXLhelYBNdkrgYFcv/T7+NNQokhJN8C29UehzO99l63GANB9F3eXK4bMyk/jZIsehxmQrQKn6dgd09yq3qQPmlJVF8THBOQzvRmKheGIakfNwtxkj6LfH/EFdVwP3mHNBSs3MxxXRFaVlcb/cpeo+j0bLx5r2lYWpcQtQx2UFE6B3vduaRzvqW3X/Myw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=etD7AJHQaVjPvRf8yRhzcnu9NkimP4Wtlwdem/WeqLY=;
 b=McyE1/TBURN04k20t2E7H6XxLI8WDOMd7fik7LKpJT4vp7i6E/ZE5AGn1Bkuj8kD0cD+CV7wnvRhwz7+mrhJvY8NIjIKb1PUdg/ZQlQpefMuFsK2GhKnSHNOGCOm3qU1y0EKXrxwoXQhU7DAToFgRbPBmCgk9OExhvYAX0tsrDAMDiWCEVK8iNLCQp5FZ/0vOWQctBq6hVo2cRgdnDaT/1FtXeZQRv5W3d6C8eVoH9eWCBML+WOYEjTdZhWJpwcQ8XPyXgMbfYIPILH1ZAqQABww9x77G/PGlfyevwAZKuOYhaAEuOyuWie0KKE8LC/vTVkJiTyj8kUiJPav1NyhOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=etD7AJHQaVjPvRf8yRhzcnu9NkimP4Wtlwdem/WeqLY=;
 b=V2xlIBzqPHN7SVOuf0R0Qhxa1KNYQ2WLFX/0HRAYV9qMczrUL0sWMhjzrf7evrDXe/bgW3JAJYkPuVrte/2EXrpwatN8AkHth2cfWshoHSyTFmt18M3VCTaJX6Mlfa+MPz+v74JbtM2hZxtCsEJLNdjSAWvTDhP6opzLO/vjFDdpxhos8W5P7/Fqc1buZx1NTE45ZbM6/w4s1/XwqXISZeYnu4J5VNEE/2/6DxRkkTr0hunDwhwlkYvkgKNesyZctu3b2pVdR/j5stYNCpMkGpPd/WvVKWbnUu9wdWKMIjRsqaYmAovoWgen5EpVpXad+e75sgnwFrPDlJQNWvEE7A==
Received: from BL1PR13CA0399.namprd13.prod.outlook.com (2603:10b6:208:2c2::14)
 by PH0PR12MB5607.namprd12.prod.outlook.com (2603:10b6:510:142::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Thu, 9 Apr
 2026 20:29:46 +0000
Received: from BL6PEPF0001AB52.namprd02.prod.outlook.com
 (2603:10b6:208:2c2:cafe::3c) by BL1PR13CA0399.outlook.office365.com
 (2603:10b6:208:2c2::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.37 via Frontend Transport; Thu,
 9 Apr 2026 20:29:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF0001AB52.mail.protection.outlook.com (10.167.241.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Thu, 9 Apr 2026 20:29:44 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 9 Apr
 2026 13:29:21 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 9 Apr
 2026 13:29:20 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Thu, 9 Apr
 2026 13:29:15 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Boris Pismenny <borisp@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, "Mark
 Bloch" <mbloch@nvidia.com>, Jianbo Liu <jianbol@nvidia.com>, Kees Cook
	<kees@kernel.org>, Lama Kayal <lkayal@nvidia.com>, Michal Swiatkowski
	<michal.swiatkowski@linux.intel.com>, Gal Pressman <gal@nvidia.com>, "Roy
 Novich" <royno@nvidia.com>, Roi Dayan <roid@nvidia.com>, Raed Salem
	<raeds@nvidia.com>, <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Dragos Tatulea <dtatulea@nvidia.com>
Subject: [PATCH net 2/2] net/mlx5e: IPsec, fix ASO poll timeout with read_poll_timeout_atomic()
Date: Thu, 9 Apr 2026 23:28:52 +0300
Message-ID: <20260409202852.158059-3-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260409202852.158059-1-tariqt@nvidia.com>
References: <20260409202852.158059-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB52:EE_|PH0PR12MB5607:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c619ead-4231-4018-25eb-08de9676bca2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|36860700016|30052699003|82310400026|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	ZkR2CSs1RZGmGBj3P6Fmnp2+TAe/yBWQ8hTwG5dvqOdtI7PNjApubah2arSReXOOouj0emhqh0bP8FHH9t9z//FHfU8frBH3dskyo1EVXJZmnE8546OyZOuZBJ7hKFWyXEqAOzulb1FHGmCA8Qih1BuRVo+iUOBr8QeC1uZ3K+kqIez/+H9wmUm5pcR6Zvrtjp1oiemj5fX68ftUy9oSIg6FDPQAc2tvZ8FJMPlsujAyVw5bQ+tajbqJPkWcBDX/dyakD72whhMTLlZiZBq1Cq/vqZuiE4JTW8F25HKIoPoWtyIZv8QM0J6ufQqkGwIrDCPLb3CxqkZjSgQ6s/iX7/KvAl4MPJl8pwb2O0jyQen/v1fDiKSyqM3kmqfRJRFKhPaIlXRtSedA3i64KYXXom1jpvZnvno5njKyVqE9FgF5HmLlMvLlGfObEhxykWx3LstOE63bt3OhL6DpKj6CU5ZHc15USRm47K26R5pyPoV41F0YQ/QjgqnHCRSzXGEkf27Mxw4XUQYrsk1Z+grnu+OKt/Befmz8YC2Dd9uAvzgXFyGLkKUi9YG1h+f3UO53kEWPKATnPRLI89cS8x4jlj4YwEj/1dv0NBS65Q2donmr0BMxaVpkDeHWaVS4NnycdxCec38d87kJ/inRrEzeRU9Rn6xsN1XMkh5fFdEou3N0zCwVSWPMoIbfu4B5fQmavFqpYMGEib9Yt+tltup2ixh7MNVVPH3m95EGala4+bTra6fxl0lLnHQkITE1Wg0ICbGf5AFrGdts+n8L1hgjKQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(36860700016)(30052699003)(82310400026)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	nJfzkN26K3t+OC1ODCerwNir2sRRRokJq1WzVvkQxgdiziBsS/+FU1yTa3MZQHJNe0gXYTvI5yGFzj6UZEjt1ulBOkX0CnKziT/GqduAFdCN3kxRuP6Wb2Wh1cW96GT7kmzjjVQuKmIqkAz/jLvHBwmViTw3k2b/UibhzyorDTVA0jrnBBN5Ggp5gE4bMnpfMxV+byhozOvwJQFK3Uk2lxWVqPbPKFe+JU7zkqOhKgx5I0Uki2hl38MhTHuVg+/4jnCzQ42dDm29J2Cl5opDhBExX88sNAYYi/9kHmyruBEzHm1Cxs0Svxxs+p5jb20dtVyUKAJuQqjRqMaEo647Ma0EGwB17FfMLehlZdxSvuyu11fAFAEGHlrzpPccP4X8PC2sLuwfCbc/PpZNtUsVEHk8Ta8qLBvTs4RqMbXDxaWVdeppKgjwEfyivBfLikCV
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 20:29:44.6173
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c619ead-4231-4018-25eb-08de9676bca2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB52.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5607
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
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-19192-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,nvidia.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,Nvidia.com:dkim];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: AFA773CF85E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Gal Pressman <gal@nvidia.com>

The do-while poll loop uses jiffies for its timeout:
  expires = jiffies + msecs_to_jiffies(10);

jiffies is sampled at an arbitrary point within the current tick, so the
first partial tick contributes anywhere from a full tick down to nearly
zero real time. For small msecs_to_jiffies() results this is
significant, the effective poll window can be much shorter than the
requested 10ms, and in the worst case the loop exits after a single
iteration (e.g., when HZ=100), well before the device has delivered the
CQE.

Replace the loop with read_poll_timeout_atomic(), which counts elapsed
time via udelay() accounting rather than jiffies, guaranteeing the full
poll window regardless of HZ.

Additionally, read_poll_timeout_atomic() executes the poll operation one
more time after the timeout has expired, giving the CQE a final chance
to be detected. The old do-while loop could exit without a final poll if
the timeout expired during the udelay() between iterations.

Fixes: 76e463f6508b ("net/mlx5e: Overcome slow response for first IPsec ASO WQE")
Signed-off-by: Gal Pressman <gal@nvidia.com>
Reviewed-by: Jianbo Liu <jianbol@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../mellanox/mlx5/core/en_accel/ipsec_offload.c      | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_offload.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_offload.c
index 05faad5083d9..145677ce9640 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_offload.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_offload.c
@@ -1,6 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
 /* Copyright (c) 2017, Mellanox Technologies inc. All rights reserved. */
 
+#include <linux/iopoll.h>
+
 #include "mlx5_core.h"
 #include "en.h"
 #include "ipsec.h"
@@ -592,7 +594,6 @@ int mlx5e_ipsec_aso_query(struct mlx5e_ipsec_sa_entry *sa_entry,
 	struct mlx5_wqe_aso_ctrl_seg *ctrl;
 	struct mlx5e_hw_objs *res;
 	struct mlx5_aso_wqe *wqe;
-	unsigned long expires;
 	u8 ds_cnt;
 	int ret;
 
@@ -614,13 +615,8 @@ int mlx5e_ipsec_aso_query(struct mlx5e_ipsec_sa_entry *sa_entry,
 	mlx5e_ipsec_aso_copy(ctrl, data);
 
 	mlx5_aso_post_wqe(aso->aso, false, &wqe->ctrl);
-	expires = jiffies + msecs_to_jiffies(10);
-	do {
-		ret = mlx5_aso_poll_cq(aso->aso, false);
-		if (ret)
-			/* We are in atomic context */
-			udelay(10);
-	} while (ret && time_is_after_jiffies(expires));
+	read_poll_timeout_atomic(mlx5_aso_poll_cq, ret, !ret, 10,
+				 10 * USEC_PER_MSEC, false, aso->aso, false);
 	if (!ret)
 		memcpy(sa_entry->ctx, aso->ctx, MLX5_ST_SZ_BYTES(ipsec_aso));
 	spin_unlock_bh(&aso->lock);
-- 
2.44.0


