Return-Path: <linux-rdma+bounces-6445-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88B749ECD86
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Dec 2024 14:45:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C727282B17
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Dec 2024 13:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 779512368F3;
	Wed, 11 Dec 2024 13:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gYSS/Bfo"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2071.outbound.protection.outlook.com [40.107.92.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F962336BD;
	Wed, 11 Dec 2024 13:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733924675; cv=fail; b=DRIVNbpCaZ5/ZYqRR7qfD4S8N3DL9xa3LizNH2ZR2twDX3o7IA6i7E+Q1a8WEUDwhB4202lnNlDL3SIWsqglZmCaZfj7q8aSx5/0nYn3v8DU8cluMhivjflAerAfFPoH+uKZZoQJ58FeDzBpdkjcE3lcOGIGhafFHUH40BlPaNg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733924675; c=relaxed/simple;
	bh=ps4aCLxSgG5gNBdJnaJL7F+ga9XiU0M6OIa9skgp9NA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NL9972OMIa+A710QAwdJmCGDLeez1kZQkt0Vh4HWgpJF7ZWUXTWfTOpTxCXj/Egn6TpT/Gai/gdyv4gE1IqfTVSThX599pd/0xI28O1WaHCiFTYsM8WY4+KymsEMMftzDiKVUrXQ+ZmyrSbk0696kd/JmG5yQW6iTIlmCSQxBPg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gYSS/Bfo; arc=fail smtp.client-ip=40.107.92.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oD1Rv6AINRLMeyt6WdtvYDOj0+nLkMyJiEXPB8EV/+r7ELBQlANLrahBbM2BwigituYSHKId+5WSmuc2g120cHYvR7djwrWeixgo3jlO49GqT0SQogkyjiSDFdEB7KTKwPXie5062lIsAI82dTuc43nbSrataQMiHAABHP4/R/l/LvX6hn8xr6NfbRYABhgWdR5ZlVx7TsSOr777syBMzLP8d4wC5W2zlZpWzu83J9dlflI+k0ZtH9q9/2VdEq/FoJUjsVnWxr/DFXnoOGPUC7Bcivb8tHye/fd3iYQSq8BR+ZDC1W8BqX9nf4r9Qix0ZoGT3GOLbGcvkZ99SQqcpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sL6q/HkGem98gpiHQNeoIIMrYQlj61TLN/sCBIkgQek=;
 b=fnkTWHcJcBIqMAZAgAmpH3aYvVK0AScvZm2YS/MVKFrsrh7mShlZMzQn0PZKEkAz3K1y3Y6+lEODKfJCMgqU6RpL9H+xuk29oP7yKAJD8UMb9gtdowgpY6HwX+gCxs3YOJi68x3TK2aSucuOa61iSxllWaxvTUXhWLNZ9+i2beOCjtr0WGEd4zG4cPWh13HIxaGT/87b9O5s+V38Xnbp7b4UQ0Y+23JCICd/1vVmZFu6aA8joB4htZCewSfBToN2rkOQNkCLp6OcNyOeGu0JGBbSPhQoei816UTCUXFIybUT6E1tEa1TlbIC/B8/dhR4zlTzZ76hwx9xOi1nUqv29w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sL6q/HkGem98gpiHQNeoIIMrYQlj61TLN/sCBIkgQek=;
 b=gYSS/Bfolwrwkak3ZxH1vRX2hKdmrcVb8YsNW21dSDxXk08FO0caRQuJUCROTxWD/zCm1pVUhGzMnAknuCZbdEncS9viID6PgsE8hw2OGDyAc+2q3AwfhDbeR8LcLxJYKjApgGhRysweMIZhTy3aoyawlfrwqfLfz81d5Ce8KBDLt7oCrx9WEmYvs23PSYOXs0treFcSlQHIBG4wJJNCClbdvb2Fvm+p2Y3F9u3hqNuN0Vw1da/hrGrt4Tcs9SscytFNtUW4WfNWEdVRcXevLAbl7a5KVHz/g7W7o0fdXIYgVmyL2x8eZ2WO8fCM1ElovrAGTMI6hBllK1tbIlLoig==
Received: from DS7P220CA0070.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:224::33) by
 CH3PR12MB9023.namprd12.prod.outlook.com (2603:10b6:610:17b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.22; Wed, 11 Dec
 2024 13:44:24 +0000
Received: from DS2PEPF00003442.namprd04.prod.outlook.com
 (2603:10b6:8:224:cafe::65) by DS7P220CA0070.outlook.office365.com
 (2603:10b6:8:224::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.15 via Frontend Transport; Wed,
 11 Dec 2024 13:44:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS2PEPF00003442.mail.protection.outlook.com (10.167.17.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.15 via Frontend Transport; Wed, 11 Dec 2024 13:44:23 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 11 Dec
 2024 05:44:07 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 11 Dec
 2024 05:44:06 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Wed, 11 Dec
 2024 05:44:03 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, Leon Romanovsky <leonro@nvidia.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, <linux-rdma@vger.kernel.org>, Yevgeny Kliteynik
	<kliteyn@nvidia.com>, Itamar Gozlan <igozlan@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next 08/12] net/mlx5: HWS, do not initialize native API queues
Date: Wed, 11 Dec 2024 15:42:19 +0200
Message-ID: <20241211134223.389616-9-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003442:EE_|CH3PR12MB9023:EE_
X-MS-Office365-Filtering-Correlation-Id: eeb5a238-7b12-4078-fa95-08dd19e9ec1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ttN0xuuFT7/gNhCmwXhHPStzG2u1vDybgjb/Y3moN8TAaUQsP7k0dzncyXTu?=
 =?us-ascii?Q?CpNegqbywdrAjLdBazDGG0nKQXKGCoqbB+36jkqVOrOS/3dGQ8R1Pgy97Cgl?=
 =?us-ascii?Q?tuDXMf+aO1UBm3rHdZh3irHSQg4c2DOuwUDpUVIojip9/JVqTeLcScKrguPe?=
 =?us-ascii?Q?jDrveYZBB5p0pKbTqKZpTTAXudfRCljpVRqhkhriAv8ene6QKUUjy0fBEkGI?=
 =?us-ascii?Q?yH1n43b8q+yLpCZqIAGGLhAhfteu5uQ7F9uavVlbZCKiXfNAMxP8hLFcswx4?=
 =?us-ascii?Q?eyspGbLIGFE/JSP5ngOlATdi+erw7P10B8nnAm2pJHu3SXvMa/b7UElTK4Dl?=
 =?us-ascii?Q?jIvqP0HYBN+5b6FXUKlthTD1GwmlUElXlJUCAxtDUiKpWtDL/+po4fpOw0Gx?=
 =?us-ascii?Q?pIPeRLtxFX6aklpexKDPjbzRux1bP2HRkizhksx7vA4MldEzA/kS6FOVziqi?=
 =?us-ascii?Q?ZREN1L5cAcC+uCW5WE6P8qJVJnwPe4KxuyRMUwQevnTThLL12XazLXvRklEW?=
 =?us-ascii?Q?VkZlxwh6pKcNuhiQ7D+bQmncV5VZO11Ubv12f578KsPxt6DPkoAksR+S71nS?=
 =?us-ascii?Q?ypQo43Bp+YQRFjUEmrsnbuM5Ybjq0jUHdHY4KDCdu/nJMwVaSMlSPMpdYq4S?=
 =?us-ascii?Q?91IBF2TB9v+lmltUqlfy9m/r9sUA33NCCe5TL7aJiwSajCW4vWTXe9XnDOfu?=
 =?us-ascii?Q?huHUzYFL1GB78nPu/9R4Vf/hinmlvM5Elv70VizU+A137scXWqh3iNonYwrs?=
 =?us-ascii?Q?62cAdPO7QjrLQUh26r2kKkWBAEmyW8d+i7qMJFh5Vkd0bX+J12FqBMsumrOw?=
 =?us-ascii?Q?bXNw+clDV8JiBq5NPpmP70ZrbYq1IrjMjOUho60zJiIVY24Cp97hRF5JfjLL?=
 =?us-ascii?Q?TJLfT5BytcfA6i9pxrcCM3RINBOoHDGBzGLDriGF8RUnqikZJtM2OgHfJfKu?=
 =?us-ascii?Q?k+zxIL/DSNUDNpAjWjv0W9o2BdEqgwZ8QMiMNGeU1cdUMbMxUfavDTXFgKXU?=
 =?us-ascii?Q?/OR33O1CXGJC9aN7Ekrubiy5ijAYkYv1HTeJkc/HZbsKON1AKEAJm2PUME02?=
 =?us-ascii?Q?Kb5TcCHGAcyHd9kNI1mvwUbIVG6EAyVSiwPFZ1TT5jo7NlDGbi7ysYK954Nn?=
 =?us-ascii?Q?0i5TOJT0rPmCA7jjIlmzHakyoS0t+WQc43Vs2agO7NQmb7Cpiyt4lDnaMVwl?=
 =?us-ascii?Q?2xPfCJg5rQ+r2IjbSU30K/XWGxh8cw78PnnRXtGXtIPJWLCyxlGWypFtMtOW?=
 =?us-ascii?Q?GZeidB5EYifmdkTui+4OLV5dZtsYnc1oy/8N0rjiYF7OqjycEDVk8jXDI47v?=
 =?us-ascii?Q?mWi4+tsNVb6TLGoJ8/UYeK84uRvzKumMMLspHhWffjw+d3v62Cj9jUoUWFaj?=
 =?us-ascii?Q?fmRIupdSGyxp5FNUX0waz7bXeNa0T2H2DXBeAIuvX7IpI+zzssmiNhu9w6/E?=
 =?us-ascii?Q?+o9Bsv7hFWqHYFrrgb9tO8P3tHUVwVZN?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 13:44:23.4337
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eeb5a238-7b12-4078-fa95-08dd19e9ec1a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003442.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9023

From: Yevgeny Kliteynik <kliteyn@nvidia.com>

HWS has two types of APIs:
 - Native: fastest and slimmest, async API.
   The user of this API is required to manage rule handles memory,
   and to poll for completion for each rule.
 - BWC: backward compatible API, similar semantics to SWS API.
   This layer is implemented above native API and it does all
   the work for the user, so that it is easy to switch between
   SWS and HWS.

Right now the existing users of HWS require only BWC API.
Therefore, in order to not waste resources, this patch disables
send queues allocation for native API.

If in the future support for faster HWS rule insertion will be required
(such as for Connection Tracking), native queues can be enabled.

Signed-off-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
Reviewed-by: Itamar Gozlan <igozlan@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../mellanox/mlx5/core/steering/hws/bwc.h     |  6 ++-
 .../mellanox/mlx5/core/steering/hws/context.c |  6 ++-
 .../mellanox/mlx5/core/steering/hws/context.h |  6 +++
 .../mellanox/mlx5/core/steering/hws/mlx5hws.h |  1 -
 .../mellanox/mlx5/core/steering/hws/send.c    | 38 ++++++++++++++-----
 5 files changed, 43 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.h b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.h
index 0b745968e21e..3d4965213b01 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.h
@@ -60,9 +60,11 @@ void mlx5hws_bwc_rule_fill_attr(struct mlx5hws_bwc_matcher *bwc_matcher,
 static inline u16 mlx5hws_bwc_queues(struct mlx5hws_context *ctx)
 {
 	/* Besides the control queue, half of the queues are
-	 * reguler HWS queues, and the other half are BWC queues.
+	 * regular HWS queues, and the other half are BWC queues.
 	 */
-	return (ctx->queues - 1) / 2;
+	if (mlx5hws_context_bwc_supported(ctx))
+		return (ctx->queues - 1) / 2;
+	return 0;
 }
 
 static inline u16 mlx5hws_bwc_get_queue_id(struct mlx5hws_context *ctx, u16 idx)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/context.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/context.c
index fd48b05e91e0..4a8928f33bb9 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/context.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/context.c
@@ -161,8 +161,10 @@ static int hws_context_init_hws(struct mlx5hws_context *ctx,
 	if (ret)
 		goto uninit_pd;
 
-	if (attr->bwc)
-		ctx->flags |= MLX5HWS_CONTEXT_FLAG_BWC_SUPPORT;
+	/* Context has support for backward compatible API,
+	 * and does not have support for native HWS API.
+	 */
+	ctx->flags |= MLX5HWS_CONTEXT_FLAG_BWC_SUPPORT;
 
 	ret = mlx5hws_send_queues_open(ctx, attr->queues, attr->queue_size);
 	if (ret)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/context.h b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/context.h
index 47f5cc8de73f..1c9cc4fba083 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/context.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/context.h
@@ -8,6 +8,7 @@ enum mlx5hws_context_flags {
 	MLX5HWS_CONTEXT_FLAG_HWS_SUPPORT = 1 << 0,
 	MLX5HWS_CONTEXT_FLAG_PRIVATE_PD = 1 << 1,
 	MLX5HWS_CONTEXT_FLAG_BWC_SUPPORT = 1 << 2,
+	MLX5HWS_CONTEXT_FLAG_NATIVE_SUPPORT = 1 << 3,
 };
 
 enum mlx5hws_context_shared_stc_type {
@@ -58,6 +59,11 @@ static inline bool mlx5hws_context_bwc_supported(struct mlx5hws_context *ctx)
 	return ctx->flags & MLX5HWS_CONTEXT_FLAG_BWC_SUPPORT;
 }
 
+static inline bool mlx5hws_context_native_supported(struct mlx5hws_context *ctx)
+{
+	return ctx->flags & MLX5HWS_CONTEXT_FLAG_NATIVE_SUPPORT;
+}
+
 bool mlx5hws_context_cap_dynamic_reparse(struct mlx5hws_context *ctx);
 
 u8 mlx5hws_context_get_reparse_mode(struct mlx5hws_context *ctx);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws.h b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws.h
index f39d636ff39a..5121951f2778 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws.h
@@ -70,7 +70,6 @@ enum mlx5hws_send_queue_actions {
 struct mlx5hws_context_attr {
 	u16 queues;
 	u16 queue_size;
-	bool bwc; /* add support for backward compatible API*/
 };
 
 struct mlx5hws_table_attr {
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/send.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/send.c
index a93da4f71646..e3d621f013f6 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/send.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/send.c
@@ -898,6 +898,9 @@ static int mlx5hws_send_ring_open(struct mlx5hws_context *ctx,
 
 static void hws_send_queue_close(struct mlx5hws_send_engine *queue)
 {
+	if (!queue->num_entries)
+		return; /* this queue wasn't initialized */
+
 	hws_send_ring_close(queue);
 	kfree(queue->completed.entries);
 }
@@ -1000,12 +1003,33 @@ static int hws_bwc_send_queues_init(struct mlx5hws_context *ctx)
 	return -ENOMEM;
 }
 
+static int hws_send_queues_open(struct mlx5hws_context *ctx, u16 queue_size)
+{
+	int err = 0;
+	u32 i = 0;
+
+	/* If native API isn't supported, skip the unused native queues:
+	 * initialize BWC queues and control queue only.
+	 */
+	if (!mlx5hws_context_native_supported(ctx))
+		i = mlx5hws_bwc_get_queue_id(ctx, 0);
+
+	for (; i < ctx->queues; i++) {
+		err = hws_send_queue_open(ctx, &ctx->send_queue[i], queue_size);
+		if (err) {
+			__hws_send_queues_close(ctx, i);
+			return err;
+		}
+	}
+
+	return 0;
+}
+
 int mlx5hws_send_queues_open(struct mlx5hws_context *ctx,
 			     u16 queues,
 			     u16 queue_size)
 {
 	int err = 0;
-	u32 i;
 
 	/* Open one extra queue for control path */
 	ctx->queues = queues + 1;
@@ -1021,17 +1045,13 @@ int mlx5hws_send_queues_open(struct mlx5hws_context *ctx,
 		goto free_bwc_locks;
 	}
 
-	for (i = 0; i < ctx->queues; i++) {
-		err = hws_send_queue_open(ctx, &ctx->send_queue[i], queue_size);
-		if (err)
-			goto close_send_queues;
-	}
+	err = hws_send_queues_open(ctx, queue_size);
+	if (err)
+		goto free_queues;
 
 	return 0;
 
-close_send_queues:
-	 __hws_send_queues_close(ctx, i);
-
+free_queues:
 	kfree(ctx->send_queue);
 
 free_bwc_locks:
-- 
2.44.0


