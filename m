Return-Path: <linux-rdma+bounces-10272-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E42EAAB2A8A
	for <lists+linux-rdma@lfdr.de>; Sun, 11 May 2025 21:39:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 340CF7A8619
	for <lists+linux-rdma@lfdr.de>; Sun, 11 May 2025 19:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A9FC25F968;
	Sun, 11 May 2025 19:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pSwP52E8"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2058.outbound.protection.outlook.com [40.107.212.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D3E2571AC;
	Sun, 11 May 2025 19:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746992365; cv=fail; b=p1Ny6cie15mlZX70fX/wtKElOLdcHJp8Chd3NJCZzYoYHumWhZdUL763a+Kr4o9QRS2fAXGM2gwa4VrwIYqf7lnDBhyJBatKglpe9hEwaZgFj/aCT7Dnt1iRzqYwT2b5HtmFP2t+cGF5Ne41qdgoMefl1groS1OkXNt73Yj27mM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746992365; c=relaxed/simple;
	bh=knYbJZAPqb9qUTuLSCdnivionW3Br/d9X/ok0xaAiXg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eZYBKKMeg+BXsThsd47UeZQEa+XwdsI7z3Ivr8RwP7bEaWDHsbUAAieTvmxNseT66pzb949BrYvUSvgVoewN/2N8gkp+MmxXRUDo/LICf2bwyIwiUjRXJ5HDvoNIssbEb3cSpM1z/8Ahs+efDwVedrYxwCsEPhBQJEbDyhp4pTg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pSwP52E8; arc=fail smtp.client-ip=40.107.212.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H+3IIyylGn5DWu6tweJ5c3C8igyAT+m9ETKrr3aaBguWHgfnq5tyEyc0dNGlINEV5s4+Q39kH7dlEhQh+2GQ3fJT4V4LeIZivT2bSnekwoJbL+ntlGTeOGydZhb6iHEc0VWDrmyX1ZMvBPoRWNiIuj4DHOlXBEXpqW9CUP3YLjmetF5CluZja7Zr637nFKe7DiKSWy3ro3kZsaXsreK8J9uWwCyY2O6Ok4WdwO5WY+XFBQAvKKMNCheLpbW8SwYXxWJAa12pFc0PqMg4tFzmxV5GWqr97kliNciuzMq38EHulFCMYU3irtGzkpEbi/WtfMbH8GkPl0CaI29myJiowg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qRuJRjs7zER++mImjOAf237YYxdtrcAbyY050JIaasY=;
 b=e0foDZLBOuU9t7eMDaM+y+eZPoWHxDfEqDMRnceEVM7MyWS+zWXCjMTEzxsjltuG3UFP/Or6cUY0e+NkZ+r7Zq3VhEjBKmVTjQGvsDh9Ww25IKLNxU7eE44pQ3P+NcIganBlGToAAQ+rwoRGKXGe1szbK2jRMZRrfC2WOqhYF6jBGDRSMbrnrVFRbB1pfDdhkpJiHCcfeOEqI0+viEB2DQFm3RBD76hwmQ+ke5FVd/R29hB2KjE/+vHqm8HCqxEu1B8dDwHpN7sJp7Us0ajE0UbSrs1LeG4dQhfii9wXu9SMyRGTP84yroutdmNQf8Cp7NFqzYvHg4sF5GiFK7NrUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qRuJRjs7zER++mImjOAf237YYxdtrcAbyY050JIaasY=;
 b=pSwP52E8Xq+adIP021NwO+kXB7n8ZffoHyf3w9CEc1U31jkun36DHxsbP1IwfnOhPFBQgjys1UVKj6r11y24EsAHzP5xD/8uiMrO8Bu0dI3WjqXAaBkN6oQYTCm2AY2HwfD6ZQpgjIhPQY7V4xxYYB+H80mtkcLdcKBDXAW/A8bfZhjLzoiwPZSmDQAH5hSvQx/9AgO2+YjqCB88OTwx8XxuiWKzJUwWiKzK6OMLMiNLhvzGNGHOSQ88xEKwqUdBqlEcFg3YBGtpczs9iBGchJ3Fo3KFT6eXk9Qu8l/fBJJfs0z27Sq6Iu6GYPrqijPBaPj5NY+0o9B8BlGFxIlfRw==
Received: from MW4P223CA0022.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::27)
 by CH3PR12MB8726.namprd12.prod.outlook.com (2603:10b6:610:17b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.23; Sun, 11 May
 2025 19:39:19 +0000
Received: from SJ5PEPF000001D0.namprd05.prod.outlook.com
 (2603:10b6:303:80:cafe::52) by MW4P223CA0022.outlook.office365.com
 (2603:10b6:303:80::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.20 via Frontend Transport; Sun,
 11 May 2025 19:39:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF000001D0.mail.protection.outlook.com (10.167.242.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.18 via Frontend Transport; Sun, 11 May 2025 19:39:18 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 11 May
 2025 12:39:05 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 11 May
 2025 12:39:05 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Sun, 11
 May 2025 12:39:01 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Moshe Shemesh
	<moshe@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Vlad Dogaru
	<vdogaru@nvidia.com>, Yevgeny Kliteynik <kliteyn@nvidia.com>, Gal Pressman
	<gal@nvidia.com>
Subject: [PATCH net-next 01/10] net/mlx5: HWS, expose function mlx5hws_table_ft_set_next_ft in header
Date: Sun, 11 May 2025 22:38:01 +0300
Message-ID: <1746992290-568936-2-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1746992290-568936-1-git-send-email-tariqt@nvidia.com>
References: <1746992290-568936-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D0:EE_|CH3PR12MB8726:EE_
X-MS-Office365-Filtering-Correlation-Id: 116541d7-3283-4928-94bd-08dd90c3859e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?V3YkSFtx7Wrho2Xq+NnGPOluZuxldaK+0Cu4kphfexKCMKr5jkPIJ0YLomPN?=
 =?us-ascii?Q?d/oQkNR/DHD92uG6HTR7Iq1BKbUKuJ1MzQaxABHh2b1hJ4w2mKNNURKlDHJd?=
 =?us-ascii?Q?T0L/a+c51vYK70NN87As6X6UjGFeVcN6oJNg5VXFcprdPRDCEXvlE8VN36Rb?=
 =?us-ascii?Q?4JBFCW45uu4e182aBLPueKXbBDoQOqZF2JTUAaoaBDeUX3iTH3zNon3CG3yk?=
 =?us-ascii?Q?pGQ32iHLkPz8XbANOCf8SpOwOO5nEAhCvVhw16KkQHx659QhrUWODvbj90kL?=
 =?us-ascii?Q?gN9Z/+NGruA5YKZMvoqtcNvH866gD6yqrkrL23+cb1USUE8wqRgsqx835Wqh?=
 =?us-ascii?Q?FTMVlz6XFF9J4bLZo2BjFnQZ5wEoa31B3lHZ7uaJbjNv4/x17b6GsxlXr0i7?=
 =?us-ascii?Q?xLqzbHrP8q3r+cwLKu5qspU0ALsIYoEyGdQPyzy5Z42df3DSUMTSBku4jLxE?=
 =?us-ascii?Q?Tqu1H9gzTs5emoQ+JOWuSKY355Xl8GYjy95XSP1+DFDf4cBfph0hZ2C/E0+u?=
 =?us-ascii?Q?8v5A0sCj6iCah+wIfd6JMRB7diUgqOfc588JXrCa45ZA1tluIS0eqz1gmdGi?=
 =?us-ascii?Q?X3/MTWPnqPU1UHclj39kPOWp/eu4jvgnnM/lPqhnogL894Wd1x+0EOXHCbCB?=
 =?us-ascii?Q?/4WbMoliL/vp8XyhSqxrwaAgYsea1s0Oec1uT2nxuAB37bLLDVpcI50Ag3Ly?=
 =?us-ascii?Q?bi514a27nXjCsSHqQ3J7+afirH4w4zlq9O8ZDCNtBautZeS3A7vOMCQmV+eP?=
 =?us-ascii?Q?aoYTcHeOxuWvb5ffJhsUA5e9wSqeV8hLBR5iU6Bibvmt7BGEteM4ipHaUoh7?=
 =?us-ascii?Q?IWB043bN4cBGwJfMbbQAvk/WvacvXQ5az7xiSHbdDYwBJ/g++tTqWepWCSpb?=
 =?us-ascii?Q?WP2dTESpKk3+w+65Lfc6W1IVQvKVN6JI65i25V+kF8/c5L0J0e75lOnT/xxd?=
 =?us-ascii?Q?Q/opxZFWTAHHA9eoc1adBtnuIVPJqUvRpLRTXYAysQltqHNDbSN+qU4MyI/Z?=
 =?us-ascii?Q?moXmb1cSm2BE9lHTyHCCbkrSQg/grHh1FFZeLe2aplWldSyfJdXRe5IIPa7Z?=
 =?us-ascii?Q?XnUWj4+gtUOqTVESlzB+o4mXlwVRRa7KU+F49bSCSNN/BYgIbH4G3scHaR9F?=
 =?us-ascii?Q?vIMtlNPVXQTcQSOA0i5EQUXhz+7sI87N83LZ7BqEv5CH4iBzu3pFUmGSPw1P?=
 =?us-ascii?Q?d7lBlFpKzcZ1r4C6w8Y0W9O3ItY9UX26UKJflMYue5qMeKrR9c8PJaHPiG9b?=
 =?us-ascii?Q?2RarJ9wZdrm8oPxp7dqZ4oqb+gLZwCDkwO+oXkoOkfbIAbwgYRgLTUneaDQr?=
 =?us-ascii?Q?Ah5gU1+tRz2xceTC/0jS58GTrfG6eQIJ9z+tf8FmpnqELbmQEW/aRq1NFB6j?=
 =?us-ascii?Q?oMky7qWwC1c09TvF3/j7iz1roLkneMYIp9vny46deS5ut0P573DKseL4iLV9?=
 =?us-ascii?Q?p7Alnjta8NVEwhDd+NNVREYDOA/OpKxtOGkpGQN8iA7usXD0RdeY5CgRSwbR?=
 =?us-ascii?Q?qY5dHdcBy50rWMqC52UEZPLzAS6qH0V6fLwU?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2025 19:39:18.9832
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 116541d7-3283-4928-94bd-08dd90c3859e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8726

From: Yevgeny Kliteynik <kliteyn@nvidia.com>

In preparation for complex matcher support, make function
mlx5hws_table_ft_set_next_ft() non-static and expose it in header.

Signed-off-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
Reviewed-by: Vlad Dogaru <vdogaru@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../mellanox/mlx5/core/steering/hws/table.c      | 16 ++++++++--------
 .../mellanox/mlx5/core/steering/hws/table.h      |  5 +++++
 2 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/table.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/table.c
index ab1297531232..568f691733f3 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/table.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/table.c
@@ -342,10 +342,10 @@ int mlx5hws_table_ft_set_next_rtc(struct mlx5hws_context *ctx,
 	return mlx5hws_cmd_flow_table_modify(ctx->mdev, &ft_attr, ft_id);
 }
 
-static int hws_table_ft_set_next_ft(struct mlx5hws_context *ctx,
-				    u32 ft_id,
-				    u32 fw_ft_type,
-				    u32 next_ft_id)
+int mlx5hws_table_ft_set_next_ft(struct mlx5hws_context *ctx,
+				 u32 ft_id,
+				 u32 fw_ft_type,
+				 u32 next_ft_id)
 {
 	struct mlx5hws_cmd_ft_modify_attr ft_attr = {0};
 
@@ -389,10 +389,10 @@ int mlx5hws_table_connect_to_miss_table(struct mlx5hws_table *src_tbl,
 	if (dst_tbl) {
 		if (list_empty(&dst_tbl->matchers_list)) {
 			/* Connect src_tbl last_ft to dst_tbl start anchor */
-			ret = hws_table_ft_set_next_ft(src_tbl->ctx,
-						       last_ft_id,
-						       src_tbl->fw_ft_type,
-						       dst_tbl->ft_id);
+			ret = mlx5hws_table_ft_set_next_ft(src_tbl->ctx,
+							   last_ft_id,
+							   src_tbl->fw_ft_type,
+							   dst_tbl->ft_id);
 			if (ret)
 				return ret;
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/table.h b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/table.h
index dd50420eec9e..0400cce0c317 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/table.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/table.h
@@ -65,4 +65,9 @@ int mlx5hws_table_ft_set_next_rtc(struct mlx5hws_context *ctx,
 				  u32 rtc_0_id,
 				  u32 rtc_1_id);
 
+int mlx5hws_table_ft_set_next_ft(struct mlx5hws_context *ctx,
+				 u32 ft_id,
+				 u32 fw_ft_type,
+				 u32 next_ft_id);
+
 #endif /* MLX5HWS_TABLE_H_ */
-- 
2.31.1


