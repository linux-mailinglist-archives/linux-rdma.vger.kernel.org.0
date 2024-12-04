Return-Path: <linux-rdma+bounces-6246-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 63F589E4796
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Dec 2024 23:12:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57737169423
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Dec 2024 22:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D9BA1F5402;
	Wed,  4 Dec 2024 22:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Fqqu36y8"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2041.outbound.protection.outlook.com [40.107.237.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AECE1BBBE0;
	Wed,  4 Dec 2024 22:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733350304; cv=fail; b=AApKLxqmvUafv4IymNbZyfD8CmC16qagpTYfKtb3EOdHWcQcUC1qO6GxGI3Rc6OhKDlufscC8YBhgHyWtpqctr7U5PXQ/669dmep+p9h1HLADtsv+zraW58gVStVfQlxztczjaPhdvQ/LxASEMga+kJanpSGZajtjawEoZ7la8k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733350304; c=relaxed/simple;
	bh=58hw4nZl1mQmhDedbbLKowV4upMBJ3iMauLTCB0OWqk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dycFHqa+GauGymjLe7WF+OuhIjConIYwZiQvfXj9UonR22WtxNCMtOsYekdS5LmDHkl/xWITQqM9sUicGAItUB9AvtmRK24bDy+XkwRxXH3atkRS/lC4H+FI+kQD12zvwH21UZC7rhOFJW0VW1fdOhdeAPaZt+Aidu/mQ5Dd0c0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Fqqu36y8; arc=fail smtp.client-ip=40.107.237.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n22244f+cfiHDj2p5IriiokekTYS8J7DPtgYavljthwzlYXN2a4JxGZQV8JgBTT+lwI+caV8wydqPkIAWiQ8HrWxWN00KzaOlffVlBVdyV+v1ZL68itDKHk+3DH4XoUyS4K/5+tMWXhAIcPO3ca+Y7XFM4wpXUQje9gnLQYC5TBPiUT+ggv0xQqolIqRqWuAdS3vWrHutyjNailvS/wFRp/BlbTTbF/yRAgFPnb0SHXGKS9CAXbwMBWYkp1JjADgEFX51mYezJjHNLMEn08WnMapgp7h7riynFb5viKHKDYR2clvDb+QNj8mJqbsvvRyOT8Q1EarRCCABR4U2oNrKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=48ODyl+gnmxsnZ3y+s4Sfga1soenzCmUIvVs88Iv2z8=;
 b=f14VAjO3TJRJlUic84yT1/u0iAQWxR7uXWLYP5CgQM0/FOyW9//vS7K/WeSPV25qhosOu7BodVykb6kHz1TnL5j5BB6Vyrc037eAI0J4SBeImOTEUxXBigRG+mV8Nwur9ipjbsG0UJq1n42+5TzoeQmt1PkJRGMS0hU9zR/7c0MPxdmpRvx1iY4AC7U3lOCr8xhB/QPTen1bGuEeUvB6M0FNgn8zlZwOsC6NZQ9efRM/4aBTre+EGA9tJXuNhSZeJmtKIHSEV9t2XSCKlq6123zAsV+6Uvm593nmQJJUG//Akhy6mg5U9cnHvb1WtMK43lPAuie0LhydbA7HQNGpfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=48ODyl+gnmxsnZ3y+s4Sfga1soenzCmUIvVs88Iv2z8=;
 b=Fqqu36y8CpMoRdenAyhK9nyBQs7s5y4zgi0BQ/5t9i94maAfllL9bEFgsv4R5kKxjKGHdlSvgnFbmngElmmw3R7AlX9TydHNqg2HihoCtBwPoaheTAhEhutzmu6Oo6OXpeFv7qBXpSB0SuhsZLoL4Jmve3mi+6AeQSo050SUeWBCOBI5mLCjXCKFSg34Mr/Dj/RPBQ/6U++L5A7U1YTsK4PUixVxuYyQOIGQOS+iSUosUjBF78zetL9aPWBeWJq+/1MihxrZbdKOZs3DSDZnr/B5IlQscDoT1xz9jb0h8sq/5ugTxhli2ijGhqZWWmQKZOVNYqnVdlenQdiEfkXVEA==
Received: from BN9PR03CA0359.namprd03.prod.outlook.com (2603:10b6:408:f6::34)
 by IA0PR12MB7724.namprd12.prod.outlook.com (2603:10b6:208:430::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Wed, 4 Dec
 2024 22:11:38 +0000
Received: from BL02EPF0002992A.namprd02.prod.outlook.com
 (2603:10b6:408:f6:cafe::5a) by BN9PR03CA0359.outlook.office365.com
 (2603:10b6:408:f6::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.18 via Frontend Transport; Wed,
 4 Dec 2024 22:11:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF0002992A.mail.protection.outlook.com (10.167.249.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8230.7 via Frontend Transport; Wed, 4 Dec 2024 22:11:37 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 4 Dec 2024
 14:11:14 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 4 Dec 2024
 14:11:13 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Wed, 4 Dec
 2024 14:11:11 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, Leon Romanovsky <leonro@nvidia.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, <linux-rdma@vger.kernel.org>, Yevgeny Kliteynik
	<kliteyn@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH mlx5-next V5 02/11] net/mlx5: Add ConnectX-8 device to ifc
Date: Thu, 5 Dec 2024 00:09:22 +0200
Message-ID: <20241204220931.254964-3-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241204220931.254964-1-tariqt@nvidia.com>
References: <20241204220931.254964-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0002992A:EE_|IA0PR12MB7724:EE_
X-MS-Office365-Filtering-Correlation-Id: 9dd5466f-aa65-4706-4aeb-08dd14b09f41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dAIxYI2gPhuIr1HOoK5R5q1++BDdP2LLq+592jXMPXk1cGGfIb4BISReKs0f?=
 =?us-ascii?Q?pTNosacU/hsD4zU9dUfP9A2zjdCV72y6+LJ/Ds1Dz7gvgYgKsihn0Mb5qw5s?=
 =?us-ascii?Q?/OUdkO8WIOp6OS//Az7HucUDsKU1NHCisJ1jQ2vUP6CSGLmcj9CxNK6CpyDx?=
 =?us-ascii?Q?S88JcVKLO1XU7/ROHzqhIeeD2kNo4Z9mzQfRBTWyhRHcEKR+X4J3k//1aFp1?=
 =?us-ascii?Q?Ag5Mjyw+k7NjmrMLULPbKA8RBOXbPJE9rhvo9G2oRzWBH5SMv+SOlzZwGKmh?=
 =?us-ascii?Q?Jbv4x5dUNgnnMZt3o0zvJmaBGKgucGXtBwtmgfvCcGudwBrUmUiBTAfGwMAM?=
 =?us-ascii?Q?vB3lXRA2mvknmT3NtJVUUvl4fjvPs2Lscl6bGpgAipaKLk9fzWvsWEaXtYEQ?=
 =?us-ascii?Q?yHql3QkjGjAiABqOlMrslgEQ3bE1qz9BsjAW0L8/u9dHViIXewL4Vd1dZRA6?=
 =?us-ascii?Q?PV2fS5yaiCwLtNfRl713W8L9XbLjWfV1sKZy8MbpEGixUb1QUqkm11EvFsBC?=
 =?us-ascii?Q?N+Iw1GTW8IIuiwNVY2Slo1XISuVOEG86IoHxLDYlmP4I2/YqWXyJt6LolfTy?=
 =?us-ascii?Q?KqRFqfGRMJNyPKtUUcLCefFYtWmspFGK36hH9DHGi9Ck5wNJ05DMGiMPlgF5?=
 =?us-ascii?Q?9jBzKALr1SrP7lqbf2WneLBqayGuy/fnMvZvu/MiG6qJdeDZRs50yMunUYIC?=
 =?us-ascii?Q?KaHbEffScuk1z92Pub5+eSv20L2E0/dusM4Pr1+o7AUbhQzRQhx0sI/HK0pI?=
 =?us-ascii?Q?GgYNBXoH4BVC7H+8p30dFwnaQNNT5wzIBgYQ+0VRNyvEqWZR71HD1qYnl/F5?=
 =?us-ascii?Q?eMNsJPEza9SqLkCiLAVk/VWfC6TBaWoz2PZklX/cKVoybiJ17IgxFxJ9WzQM?=
 =?us-ascii?Q?MZ7LMT6gfmMLQ+gHs+TdroXBD7nMcJ6Yhql/owvd/YAYnQScf0VhV+86FEyi?=
 =?us-ascii?Q?O/VYWT5wo8pVmrAM/pbWnJp/nGnVnX/f4z0ALG2YMbFuPHZf048Kfup6AtKc?=
 =?us-ascii?Q?w/qJvo0XANbffbDsFDyoHWJW0Akv69oYtg0IiYEaXct2lV0iN+UnG7coCWM7?=
 =?us-ascii?Q?PbbKtCcNXBOa3lmJyvXtGjsCvsRdrP3V03Es+UGEtNNGq11FzMGDzoAh3vgr?=
 =?us-ascii?Q?++1OfQuMam41tFwQr7XQrnnnSaaPC6ixt4o0hoOzrKHXCeveHnuGBk9s++AM?=
 =?us-ascii?Q?+WOx+B2gIf859OIih3yccduyZ57xzpjPnI5LzYg0RbbQSTLUHLD2e2eMjOVp?=
 =?us-ascii?Q?jB3A0Gq10DnVuRbBvbN8zPbqcHIkDLLA22kGR4ctB9ZxnNwRI8QD8Fj0Q3AH?=
 =?us-ascii?Q?114EVP7YAkt3pG5fm+DD9MVr5GNWi4uTeXO+Z1X0ajCQJj3e7VuYGmPw28o1?=
 =?us-ascii?Q?amU7jrmcRBYnoaDJn6MClNWUUq52yHnUX2BFlw0jbl9pkORTkjpx6QTWadA2?=
 =?us-ascii?Q?M5ghxBZFQyq4/ucKi7aqcCEQ0ZQVHRCa?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2024 22:11:37.3259
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dd5466f-aa65-4706-4aeb-08dd14b09f41
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0002992A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7724

From: Yevgeny Kliteynik <kliteyn@nvidia.com>

In preparation for ConnectX-8 SWS support, add enum for the new device
type.

Signed-off-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 include/linux/mlx5/mlx5_ifc.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/mlx5/mlx5_ifc.h b/include/linux/mlx5/mlx5_ifc.h
index f3650f989e68..bd9b1833408e 100644
--- a/include/linux/mlx5/mlx5_ifc.h
+++ b/include/linux/mlx5/mlx5_ifc.h
@@ -1590,6 +1590,7 @@ enum {
 	MLX5_STEERING_FORMAT_CONNECTX_5   = 0,
 	MLX5_STEERING_FORMAT_CONNECTX_6DX = 1,
 	MLX5_STEERING_FORMAT_CONNECTX_7   = 2,
+	MLX5_STEERING_FORMAT_CONNECTX_8   = 3,
 };
 
 struct mlx5_ifc_cmd_hca_cap_bits {
-- 
2.44.0


