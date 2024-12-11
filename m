Return-Path: <linux-rdma+bounces-6444-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 323C59ECD88
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Dec 2024 14:45:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 730BD188AFE9
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Dec 2024 13:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFD6C2368E1;
	Wed, 11 Dec 2024 13:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EknisLg5"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2062.outbound.protection.outlook.com [40.107.237.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC8719F12A;
	Wed, 11 Dec 2024 13:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733924664; cv=fail; b=bdwVEZ7IwjUbSqytdOW6z44giR57hZk25ASrrj5gHRZ/7nhIjW9H+212CU3rwVc0RVuuVNWevnLNagEwLeCf1oy296QuuLYup1gX9GcBEeRlu9gnTICAmc09jaebQXpCsTBBGs9tj66gSu9zsObYsq0RevtpBDkQ8qmTgSiCZAQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733924664; c=relaxed/simple;
	bh=2LpWy9qn4uW5YI5WK39NwzFb5eQxxie9ms2nCar+biY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gLzNHApOKbFd0fAWdmthfFqWvK6SdbeCppyzaDiRXv57U6NaQfw5bpwuoinf3g8C1AijCJlqb1U+0JSqbOVXJksHEQPsknwhuCmPbXncPsh+kkYnZNQyiMWsqVPw6idvDPoMTEIDWxhYfzrBDLt2tZH+ArzXFWJKqmyeMZGDXUw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EknisLg5; arc=fail smtp.client-ip=40.107.237.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CTaHVEJHwG99R5XcWDJYPjhaLwoJbS3fq0+atANSM/bNAJsde7i+QcIdBGK7z9QuzvXQzYu0crRZhskIUqTsO9xTEJ0Gb9MpkFRy4aNTESEAr8QwXKY1CPBA3hps060PHdUarNa3RswQt4TKmn43ihjdyKS8eTJlqeATHB7AafCtKMATylQ1M282/qlq1xSE8ndC6trJnmO5riP4witrKAdkfcLSDf0woo405DXDGPoKjKUObcAILMQVa3HwJdTrZ15OS1mx1uzMkIWIvKnuUMKoChSmJk5qmmZJtKwOe6X5kKmlSaI/60U/uaA721pKaB5tIgL90pMjlk8Vs4NI2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EO4tnkbD8WI62s1KECvHKqg44Q4JsEJDsXpIi9+BCV4=;
 b=rrv0d0f/DolHUzh5573hw8aN/25q4HKCWwOi2m6fauzqk/yDwBgB6dmS2Gn/y2ko8oZtdhr13SAT2oFXnDJCBY+yJ8iFZnbFQ9PerwxfsDfVWOjLfwZCkLYsjQtS/WkDQTsJt00kk9JZn/tpvnMR5YeihLP1StNWfBQ2arpvbA+/U6R8IJSKyozv8VLShWx/OyEvkNLEomTB7UawH4QlSVai6f1+gf+1D756uJyFM1wMDrP8+GW2Dpu7IgUiA3hikDKCdLLc342fG4ug1GbxEQqvKmKINTjztkI8KBsgVl02PVe0iYBEATMKlDUeM5PRopUJraI/dy8EwQPZJ/CkdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EO4tnkbD8WI62s1KECvHKqg44Q4JsEJDsXpIi9+BCV4=;
 b=EknisLg58pPP15/8dvF/xMVlGKNLzgOdMVahRWa1DbYcAx+TKMJm8KumHB1VhJ3pCZraAsyprSGQeAASlgD4dHXEy++5vK+7nSUhz6HZBEDZurec5MFJyEc6NxS4Ao41ejlbE1G/4YheiMUwkOV/xsONA2rGF0N8NTQp3NMBcmltnQyQIMKJfldVlcUmwfXj//WebSIeVBWt+L3Ka2dJc3/v0lFyTrSt2MsZQmaSOOWz7pQmhoMA0BC+3xYAtC2fRRhHY4EIC/8o4uwfJmboGAOA8U5T+SIOYi2GPcaYAGJv00YI3FF99OOX+LFeAPTq6SncDqftrH4yOcCoYAfLiA==
Received: from DS0PR17CA0017.namprd17.prod.outlook.com (2603:10b6:8:191::28)
 by DS0PR12MB6438.namprd12.prod.outlook.com (2603:10b6:8:ca::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Wed, 11 Dec
 2024 13:44:18 +0000
Received: from DS2PEPF00003443.namprd04.prod.outlook.com
 (2603:10b6:8:191:cafe::9f) by DS0PR17CA0017.outlook.office365.com
 (2603:10b6:8:191::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.18 via Frontend Transport; Wed,
 11 Dec 2024 13:44:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS2PEPF00003443.mail.protection.outlook.com (10.167.17.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.15 via Frontend Transport; Wed, 11 Dec 2024 13:44:17 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 11 Dec
 2024 05:44:03 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 11 Dec
 2024 05:44:03 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Wed, 11 Dec
 2024 05:43:59 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, Leon Romanovsky <leonro@nvidia.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, <linux-rdma@vger.kernel.org>, Yevgeny Kliteynik
	<kliteyn@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Itamar Gozlan
	<igozlan@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next 07/12] net/mlx5: HWS, no need to expose mlx5hws_send_queues_open/close
Date: Wed, 11 Dec 2024 15:42:18 +0200
Message-ID: <20241211134223.389616-8-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241211134223.389616-1-tariqt@nvidia.com>
References: <20241211134223.389616-1-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003443:EE_|DS0PR12MB6438:EE_
X-MS-Office365-Filtering-Correlation-Id: e8d4e5e1-055a-4bae-e03f-08dd19e9e8a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xIa6Vq1fANRglA9apXG2anJAnfit/6dI3WqvmAc3d7OUjg9SyIJtmae7c/A7?=
 =?us-ascii?Q?1RRJagVHRsoAoQM96lCWovkfKbYkEwOFEZexEYddU44Qqania2qMul75t7is?=
 =?us-ascii?Q?NsegMhZyUX5+S7b7moOM0KUU0eSMVbWAyo3aa8+3TawLeb+qaFl9+4yy2Ah7?=
 =?us-ascii?Q?yftVy5ZNIZxfKyaWO85OA425luAwRwpfAcAGStfn3bx1ZLVXzh4x6EJ9XrhS?=
 =?us-ascii?Q?b5pAeAmXaX4Dmem6wd3A8Pk/r7o4jSab5ehKlyBofX/VkHsEHM1dEtK6htvC?=
 =?us-ascii?Q?2g4GhUqYGu8sqkzZEFTxq/eyOfuUG1/tTZF7u/jvBp+LJD75WOiSRZMgVPj2?=
 =?us-ascii?Q?FCMVLUT5xKTpUtLHHgJqjKtY/spSuRfJ/9INczZI+CElz6rJlThOP57dNGe2?=
 =?us-ascii?Q?trZ1jFFm6K7DIowBcw4Fpk3Eaw4Ifw8xEqaqQWysAPImGU1Nl5mGhjQwPt0J?=
 =?us-ascii?Q?P53XVLb79Li0/gfrd30Q8cubphII9agVcD9Yv5G63FQWmkgQz8L+YVGmG+OS?=
 =?us-ascii?Q?NWQCcm9g48meNjK2qk46BciOL2qaiNUVipraumxe04Ya2a1O/1IFyyJCtvJA?=
 =?us-ascii?Q?pxgCL5XntkGXs8C/g0iOlinBoImVGC8tLRfuQW6ggup3a2EqOE+dWkRpwjvN?=
 =?us-ascii?Q?Sed1gvZWfsllLEciaIDyeWT4spJr5P6B9v5C5Rwo9wtJ+l/bv/O8LtuDr1Vo?=
 =?us-ascii?Q?4wdBn54cyu+yzC2BqOyRebUoSxnfRB0iPtDtRRGuXgsZn3AVjxJ5Hdp4mH6U?=
 =?us-ascii?Q?hB7k0RiIJ74c8Z5lL7XaQjeyk360f/ZnnH9IxI1NhecRhzPN4OReIeacL9A0?=
 =?us-ascii?Q?tJG+W1mKAmFKhkTioOXtr5lap76onvFpka18xzz1y+a5qTH24y0CehWxetmI?=
 =?us-ascii?Q?+6C1LWS010uWd+00wo93XKTlMbhvlGPlfptGAXDb/EL8zQ79Ge6miRHiP8TL?=
 =?us-ascii?Q?3p6f+JbkUnQW0Gd6bDBhpPmXAq1Efz/Ei7i3hcZU1wqmDbPgVlwUZLHn4QtI?=
 =?us-ascii?Q?TckP6FZuoVLr2ax/ItoHgX/Tx+9rpHIVZHoVKRPBZ7SsAjIt+0tJ7KVK5EOZ?=
 =?us-ascii?Q?BcK0lqKVZmUMBUxhadQuHLuXtc2jLRoPNllvbapIQQoSMxyLxc/kVq/oMhe5?=
 =?us-ascii?Q?8Ed+nkwayu46MHi8KtNf3T9otvUaQjZKIhEIiEnbB2YjfV92NZJujAMKYQye?=
 =?us-ascii?Q?BU1KVDYE/m7MG7gQtFd9uwwVKW1v+XDp3OpyrRegMnoolCBihngfp60ac8En?=
 =?us-ascii?Q?96K4mL4ymwk40gOCUWxw3ftH0Q5D/vtw46L2Ihb1agUQ6zLRYGFDZa97ASQf?=
 =?us-ascii?Q?0raaoIEAVSQMtzlI3xTXMVedfaKA9lrIdHPhP/6ZuvsAsqn9Sh+GYPUxGoxv?=
 =?us-ascii?Q?fFTP8Tie0l7O0FPDJG7MC196zhLyPxSiyrLcCKhHkUUTT0ux7wfaiCtzmcZ4?=
 =?us-ascii?Q?L+/GeAWklTAd2B3TRm02MtEtt/CMZQSE?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 13:44:17.5978
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e8d4e5e1-055a-4bae-e03f-08dd19e9e8a2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003443.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6438

From: Yevgeny Kliteynik <kliteyn@nvidia.com>

No need to have mlx5hws_send_queues_open/close in header.
Make them static and remove from header.

Signed-off-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Reviewed-by: Itamar Gozlan <igozlan@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../ethernet/mellanox/mlx5/core/steering/hws/send.c  | 12 ++++++------
 .../ethernet/mellanox/mlx5/core/steering/hws/send.h  |  6 ------
 2 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/send.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/send.c
index 883b4ed30892..a93da4f71646 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/send.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/send.c
@@ -896,15 +896,15 @@ static int mlx5hws_send_ring_open(struct mlx5hws_context *ctx,
 	return err;
 }
 
-void mlx5hws_send_queue_close(struct mlx5hws_send_engine *queue)
+static void hws_send_queue_close(struct mlx5hws_send_engine *queue)
 {
 	hws_send_ring_close(queue);
 	kfree(queue->completed.entries);
 }
 
-int mlx5hws_send_queue_open(struct mlx5hws_context *ctx,
-			    struct mlx5hws_send_engine *queue,
-			    u16 queue_size)
+static int hws_send_queue_open(struct mlx5hws_context *ctx,
+			       struct mlx5hws_send_engine *queue,
+			       u16 queue_size)
 {
 	int err;
 
@@ -936,7 +936,7 @@ int mlx5hws_send_queue_open(struct mlx5hws_context *ctx,
 static void __hws_send_queues_close(struct mlx5hws_context *ctx, u16 queues)
 {
 	while (queues--)
-		mlx5hws_send_queue_close(&ctx->send_queue[queues]);
+		hws_send_queue_close(&ctx->send_queue[queues]);
 }
 
 static void hws_send_queues_bwc_locks_destroy(struct mlx5hws_context *ctx)
@@ -1022,7 +1022,7 @@ int mlx5hws_send_queues_open(struct mlx5hws_context *ctx,
 	}
 
 	for (i = 0; i < ctx->queues; i++) {
-		err = mlx5hws_send_queue_open(ctx, &ctx->send_queue[i], queue_size);
+		err = hws_send_queue_open(ctx, &ctx->send_queue[i], queue_size);
 		if (err)
 			goto close_send_queues;
 	}
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/send.h b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/send.h
index b50825d6dc53..f833092235c1 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/send.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/send.h
@@ -189,12 +189,6 @@ void mlx5hws_send_abort_new_dep_wqe(struct mlx5hws_send_engine *queue);
 
 void mlx5hws_send_all_dep_wqe(struct mlx5hws_send_engine *queue);
 
-void mlx5hws_send_queue_close(struct mlx5hws_send_engine *queue);
-
-int mlx5hws_send_queue_open(struct mlx5hws_context *ctx,
-			    struct mlx5hws_send_engine *queue,
-			    u16 queue_size);
-
 void mlx5hws_send_queues_close(struct mlx5hws_context *ctx);
 
 int mlx5hws_send_queues_open(struct mlx5hws_context *ctx,
-- 
2.44.0


