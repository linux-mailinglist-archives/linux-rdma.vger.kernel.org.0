Return-Path: <linux-rdma+bounces-14570-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A16AC66516
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Nov 2025 22:43:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 1C96C24282
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Nov 2025 21:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E789F34CFDE;
	Mon, 17 Nov 2025 21:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="n2QfTi/B"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012032.outbound.protection.outlook.com [40.107.200.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C476034B68A;
	Mon, 17 Nov 2025 21:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763415793; cv=fail; b=QT/FDHXv5RNVlqduHcT4Ey1N/HucucOS4NKn/ubRShQb+uVy/VWMkxnK9KJ1b0S3nXslnfDCYiF6BtuPfqqCvvu21aBmLIFsEo3tqKgeOz9zLxC9o8HF5mMv0PGTpc89LToA+mhUbuLDBIcFDlV485LmETeg3+COzz5wDKzNuww=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763415793; c=relaxed/simple;
	bh=1ZCnOinGwlXlElnb6vK6LnlfZQYB53g66XMHPkEVCCc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eSCo4dUGh8r/3cxjClyUQQqIqhAYk4LTesVHz8pnJ5r/bMKzNbhlcQR7MSK455thyKhozSGPvuifXyeYHRSFPkDAj3otdW+KEqbOujAip4kYRDRVlZk3qj72sw9haYmOQ1qT0WwYNQaEnyDYkR4IRIsXUzbQK14NgwhWKUgqMCQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=n2QfTi/B; arc=fail smtp.client-ip=40.107.200.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N5d3ZP3qESFIoqQjdSGjRMlFPAHpkilyfeARhoL0AF49ku09kLLEba1VAUba0/E/H3aFVZviUQ1bBAthkl5e7Ru0H1TgzPjvcsMjtmNOJFBBXqWIxqX+lsjAdaY46UOZ8ABRKK3gJ5NYRU3S3QJd6IDYlHah5WcVOlSbyNJuqaLUYLNwngmbGhY14fFGT6Y4d0vlzhPN1JSZjTJ7M843PrIaQlyCHq0n0VT0D26/eRoZ8/fxUGYFchK1FE8PgjoZzvJoa/hiL37Pj3/wu3TAn54p1Hks09CrjBkR2tdD9EtMNA5bNIUiM9aZCjfIPMktMgDahM4NmkqK5yKtTuOSiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TbLKW+WYkENtZXUccWCyj6pVheQXZQpppf7a0kIsoz8=;
 b=DINyOLiqNYKVZDdBvnn2R4kLIl3nFvi+osUOgITPGCme3U5GkJ2Am3moIxlCueW1d3F2k4uKRcUOH7rU7Oy9NfoM+C3YWKdbZvAadLThCshs6AswBMN2vzCov1ynJMsysiwYpulgnr+DwCqG9489yxKEQRdLqlyGGGD/UkCCbvG1/GqfE6dvUfSb0D/Ot3PGETXj7jRhi9f84ah01/T3Uph+u4Z00jn0YqGolzY6bBenQwUflrGm044sn0UwG9gcKjAD1aco2NDwcw0rP8KsnY6XsXXq47cWbDrsdtqzznJV2tL20WcCetCJ/ddm0A8ALDAhzCzd9BLD0X9+w0JxtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TbLKW+WYkENtZXUccWCyj6pVheQXZQpppf7a0kIsoz8=;
 b=n2QfTi/B9GETvLmNcAi7VheZzvvTzw/kcIU1ddDut+JpX428B0yHh+5WAsJEPuEsZQ5v0baTvCvR+TYvszUQiZiL1xpl1FA/+mvPe0iYxi1Nk22b2yN5yi1CTG8jraMYzNJYbAOQIyNYTqifIYVX1vHcwJNAJP3NwBT14ZKjQi0YpGYM+D/74xcb6DRC8eeAkPxbQ2Fn2kKFvuzzevmwXB8U418dHAogFg8xpvIpvms9IhMvGdtj0CGsJTQtL2MBknWm+zzmkMjBFvna+OW21wOhQ0l/LOcVudO2OMGyxL7kHRPuwzwOBnN/sFxQAy+fmohZGQgpuiB5YSY4B1G+7A==
Received: from CH0PR03CA0406.namprd03.prod.outlook.com (2603:10b6:610:11b::14)
 by MW4PR12MB7285.namprd12.prod.outlook.com (2603:10b6:303:22e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.22; Mon, 17 Nov
 2025 21:43:04 +0000
Received: from CH2PEPF0000013B.namprd02.prod.outlook.com
 (2603:10b6:610:11b:cafe::2e) by CH0PR03CA0406.outlook.office365.com
 (2603:10b6:610:11b::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.22 via Frontend Transport; Mon,
 17 Nov 2025 21:42:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF0000013B.mail.protection.outlook.com (10.167.244.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Mon, 17 Nov 2025 21:43:04 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 17 Nov
 2025 13:42:46 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 17 Nov
 2025 13:42:45 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 17
 Nov 2025 13:42:41 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, "Richard
 Cochran" <richardcochran@gmail.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gal Pressman
	<gal@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>
Subject: [PATCH net-next 3/5] net/mlx5: Remove redundant bw_share minimal value assignment
Date: Mon, 17 Nov 2025 23:42:07 +0200
Message-ID: <1763415729-1238421-4-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1763415729-1238421-1-git-send-email-tariqt@nvidia.com>
References: <1763415729-1238421-1-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013B:EE_|MW4PR12MB7285:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d735b3c-7a76-459f-3444-08de26224a2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?P3j/N+8YyH/Kw8d+M1ci5fOd9zIlgKYCoXmb+xTy2YwijI+/rwK9AgRtq41z?=
 =?us-ascii?Q?2YeZRR4nMusx0e7WbkpQ16XbSZlJUGlYzrV1oLxNPDQ5DYUKkzkLVMkKvkct?=
 =?us-ascii?Q?9h3SXaXUv0ZQP0bpP0XckDRhDAl1Ibu6ZbCMexEgqZK9BsUVZ8B7bAnvpm8E?=
 =?us-ascii?Q?wV7XsLhd3J3E5YuuJmDTL6Df+IEjjuzeaz5VjLUVNOrvZyXeuxtnP475Z2Nx?=
 =?us-ascii?Q?qPKd48A8gXhZfvHd1WOhJSxn/jfym8SBouTzhGrVC2qNf4KaeXWCqYoyTmMz?=
 =?us-ascii?Q?/gmS9yyN0U/fzABicCoPmrHNSMh1gUsowGq4q6kk1qseqrDt8jDjU/BXaQfl?=
 =?us-ascii?Q?krtfmYXkOhlvGNg3UDfUj6ZQuMSEA+zqf7QdIIlR3Jem412NKidJvosk369S?=
 =?us-ascii?Q?5boxKwoUTQ662nJOHbI/EhHTOyR+OiVjUu/WBCl6YNKesMzLBWjFs5bI+qIy?=
 =?us-ascii?Q?h1I4TarcPB0XZPbUbLOwfQCZarXKJ6L3eEJ212cXEBMeuiXwdDDvCxWbn3Rx?=
 =?us-ascii?Q?KUx0F3Q6cfkq6wtmTn6Hru2nAH7+IHuwLKr55+v/vmafkMVLIrrZ+xujFX6H?=
 =?us-ascii?Q?I2s0Kh8OlUBRtpcHLsK8DhmiY4v8lDzTMN5PlmuuBQK1Y1HAZlK52QGsh8bM?=
 =?us-ascii?Q?i7uxdLwq2kv5NfpAa7nG9gYWBzHDx6HZgI0CYgdHX0+m+UY+jIxD2vF/O5NK?=
 =?us-ascii?Q?oMddLMPdPh/84M0xneRVmUpY7Cf0S0YJW7/LimQMPqaptaq69qCZO9UzOVIM?=
 =?us-ascii?Q?MWUcTq3jKplCD0FkRXeEmQmBcm69mIYaSnOoxxLZc4mgen12QHYsX2GZ8Tbg?=
 =?us-ascii?Q?w8UWGy0IGkP87MU+wBNlk/Kytq0PIAJ94rrpHHxnEEBA0pKytowvEwV3ByMJ?=
 =?us-ascii?Q?Uih5B43Gs8e8Kfm2JA53rc600wfNKJO+KJinhbVROSmK1dS9UJ4Qu9+OZfI3?=
 =?us-ascii?Q?nGOx3Ev122TyqA7yvBy8wSxCprmKtwY4puhHabdUWKQxtUkFuuE3oXWIJJyR?=
 =?us-ascii?Q?ORHBpeBL5b112/to+6vrAyPyuulKIjizT8tv3pO91Ml2d8xgtZxesHEf7Cq+?=
 =?us-ascii?Q?2YpgxdhnXdcSV0zHig1pIs58nDb/eGBUHGdWA5uaTbhWAVhXedGFIwF3Zpql?=
 =?us-ascii?Q?lX5dMiv/1Us4dKhzV3c0c0strUQ9ZecMlDPHLPQplwHtzghjLIC/0d7NuX2v?=
 =?us-ascii?Q?rsWcjfhS6nG2IpZIPEMHcsu7cbMfUKU+83q+S5vNJ/jsMqxiQtj9/1tn8U4s?=
 =?us-ascii?Q?CJc6XIXbWHSwFjuX01atfSePDJLSYz8S8IziTmfxIODu9zsU9KI/8MLZofHl?=
 =?us-ascii?Q?ymaT6IB82S4vlrxfBeZW0hTzCipSVeVTV805cvyoGN0WYKTni/LtqbQ7Dtmg?=
 =?us-ascii?Q?W9Jy1YBLYBCihtfWxB2F975WZyiN7/kWb0tsFzglAVFvw2a3c+pQedRYUybo?=
 =?us-ascii?Q?jpzTNLmzNpZ6NUyIMqAeVDlVJDGN+BxVv3Rd3iH9tiV2raUAw0sXchey+7rc?=
 =?us-ascii?Q?zd3X3DzQdSIQ8g/m+RvKa0YpNbFLLLKxTHzmoTuoEzJrIaL6lbpB/20wgum0?=
 =?us-ascii?Q?IzjtWXq0D3rnFw/mP9w=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 21:43:04.6793
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d735b3c-7a76-459f-3444-08de26224a2d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000013B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7285

From: Carolina Jubran <cjubran@nvidia.com>

Remove unnecessary logic that sets bw_share to minimal value, when
parent has bw_share configured but nodes don't have min_rate.

This check is redundant because the parent bandwidth acts as the upper
bound regardless, and the firmware always enforces the topmost
bandwidth constraint.

Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
index 56e6f54b1e2e..4278bcb04c72 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
@@ -341,13 +341,6 @@ static u32 esw_qos_calculate_min_rate_divider(struct mlx5_eswitch *esw,
 	if (max_guarantee)
 		return max_t(u32, max_guarantee / fw_max_bw_share, 1);
 
-	/* If nodes max min_rate divider is 0 but their parent has bw_share
-	 * configured, then set bw_share for nodes to minimal value.
-	 */
-
-	if (parent && parent->bw_share)
-		return 1;
-
 	/* If the node nodes has min_rate configured, a divider of 0 sets all
 	 * nodes' bw_share to 0, effectively disabling min guarantees.
 	 */
-- 
2.31.1


