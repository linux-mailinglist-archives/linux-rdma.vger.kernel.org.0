Return-Path: <linux-rdma+bounces-8060-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE3BAA43620
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Feb 2025 08:28:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3911017C076
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Feb 2025 07:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C21925A2C8;
	Tue, 25 Feb 2025 07:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oh1wrGyY"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2062.outbound.protection.outlook.com [40.107.223.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E2425B687;
	Tue, 25 Feb 2025 07:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740468450; cv=fail; b=ber9wsUALfI2TP9jPwul+unub/XsvO/+A7fsnnCHPoQtMaysPGQCxfUbesRe25vQWbrgetphpPBGpDw6oT1AI7n6Q2LeT531HszRpHFeY0XR+n/kkYe2wraHDHM9Cmefl3IuoVY7RbrPgJarKF5/uNCownVxH6MEIUDpup9A1OI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740468450; c=relaxed/simple;
	bh=XN/gsiRm1+4xsz0+UcNnYxbmK6EH2/WnedpaDYp0j8U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kkZqJLfdw8FziAzJ1gJ22vzXqB7ZjC+5LYByUW9SbgsSu1gOCoxf1PKDAcWRmILX7U+VA3SVl6YurD775qJHyBE/lp9+jPE//Nu7uje118p5ikm3CoQGn/hfVqty3UJc3XWdmMbFobG9QUQZQHinruHJvh/O2Du9t9ynH1EWvMQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oh1wrGyY; arc=fail smtp.client-ip=40.107.223.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WGCY8xfxcqoxiA7WvlPambyPaJQHcZ3Xnzl28ii0ECODnF9037KErjAgWfrC1SdXbXz9QdOHK6HS8I0UrEbiYambvKac5Ngv7ZyNDQm0+t+/dLWs+RAz1aQV6ktkS3bK4nx584fVxmeAk86IM8Ksn4WG+sXOVm1lVFsSeKpeF0UjM2LQslT+Ev7QJEU+OUy3GUMOsrYo4zy7MsvvnfY7L3GiFhv4AsNdi4dh2rFp0dDeyYPG2UK8+JEDSHrEFyBIKe2lv+cheSfiGMbUqNkTOw6GlETwzKwXVGD3kPxJQoAczEhKl+74Fl3V1E+L0qDdnHMRDJwlXbsKbkWsVnjH9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kqlEDE/Dx/7yQ8JuROZJkO568Vsl3m48qQGmsglR9+A=;
 b=PP1eggkM+mFjc0CoYg91+nLzwstVAdsar7lSq2bpV84NXEizL+sVgmc99FaJZgZDUz0DeO6H44qE9RcjKdjB6UMLC1YMYlSknX0WCdcGFqocS7zhV/hD9VTOXAWg3lhtrABkfNJqZC/u5qLae5CbqFteowwJxIKaJ2vBTnxZNlMUtLk66+F3P6Xt7ckoIYYWU7dJJBW34C00g+eUBKNH+k+sENNK+Vn8chiUzE1pMJ9in9gwVEASD9CPBk+SmZ+71gkgeZxcU3cSYt9vH9QnUeT8XSnRTlUXB8ewOaaVwGSXza7k/XGOvv2N7ORHwUc8EG9J/pIiyV7OyLXxOi5RFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kqlEDE/Dx/7yQ8JuROZJkO568Vsl3m48qQGmsglR9+A=;
 b=oh1wrGyYdlVi1O+eyhkneBKRE8jROiK2XewB5ePelVuhyssBBpA45YuYHpa3Ny77tFapGx3yEOCXtjpj7AOUqel5ZB3yNTvEcfbUDClwwc5yPxbq7r5m1bBojmD93is8Zjn2khCA4vNAGxuZyfG5xe4P/57CZ603a1OuGlGFPOh+6K9oi1FumbjdtT3kA9S6HLMqRF9p5ZcaDNkxIj1goXXldqsanEIhkgRIyLHeIeVWGtbjkK+fottHn3l0kGcHwv8pWDaeOWYrFYufFF8Xr94XxfxDx5Q50v52ghGhIF7hhGBxp+e3nTia4luqjmtQVwuvhHyD0tZ6QbbCh/qS7w==
Received: from SJ0PR13CA0082.namprd13.prod.outlook.com (2603:10b6:a03:2c4::27)
 by SN7PR12MB6742.namprd12.prod.outlook.com (2603:10b6:806:26e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Tue, 25 Feb
 2025 07:27:22 +0000
Received: from CO1PEPF000066EB.namprd05.prod.outlook.com
 (2603:10b6:a03:2c4:cafe::de) by SJ0PR13CA0082.outlook.office365.com
 (2603:10b6:a03:2c4::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.16 via Frontend Transport; Tue,
 25 Feb 2025 07:27:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000066EB.mail.protection.outlook.com (10.167.249.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.16 via Frontend Transport; Tue, 25 Feb 2025 07:27:21 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 24 Feb
 2025 23:27:05 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 24 Feb
 2025 23:27:05 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Mon, 24
 Feb 2025 23:27:01 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: Gal Pressman <gal@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, "Saeed
 Mahameed" <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Tariq
 Toukan <tariqt@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>, Carolina Jubran
	<cjubran@nvidia.com>, Shay Drory <shayd@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Dragos Tatulea <dtatulea@nvidia.com>
Subject: [PATCH net 2/3] net/mlx5: Restore missing trace event when enabling vport QoS
Date: Tue, 25 Feb 2025 09:26:07 +0200
Message-ID: <20250225072608.526866-3-tariqt@nvidia.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250225072608.526866-1-tariqt@nvidia.com>
References: <20250225072608.526866-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000066EB:EE_|SN7PR12MB6742:EE_
X-MS-Office365-Filtering-Correlation-Id: dff08f9a-e865-466e-8853-08dd556dd7ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EZ6NkjbmQdPrEFJk5JHK6Uoqa9S9FrTuqksu0pQDNKaEb+x238HR9YQAtfv3?=
 =?us-ascii?Q?637CY+ov0xxTEO/26Ex0a1C8Q2MNWDWR24fKHX88pIqubOlPgsNWQvBfNd6+?=
 =?us-ascii?Q?cpJwvErqnjFck1YqnNQYx9ykc8BfZLxISKDPTziMi3vqXTkQZ6/nSaJIIeoe?=
 =?us-ascii?Q?a8vYbVlNKUxP4LRnhSHU4kwir9MAy4+wQtqshJ5K9Ro1qF8+YTsEuDoyDXDx?=
 =?us-ascii?Q?DYxyUaXPzmb9iuDHQFkJ17iW1mfQREjRahdmtjOnS6VySeG/wd1MAznhmduK?=
 =?us-ascii?Q?fWeTcJuUL/ItmSQPfaRNmMEaf7Iiy92MT1BGfaqmb5otJr5S2cpZkx728p7V?=
 =?us-ascii?Q?QjkozkpqOUo6Y0xtAshtdR1PfHdW63b260ZmXHCMG+wSrSEgFBykprzVdLg/?=
 =?us-ascii?Q?Dv0GBcEAvStyQRaZp/c5mHOAB5vn2QUO0zBDXb5VkzNiSew8g7EeN+JcZVN3?=
 =?us-ascii?Q?1ZC4kWYG82WDugDgtERa9ILBJTi/ieGo/Qqay74ATE7RRtWl9HrEoDpNl/Pv?=
 =?us-ascii?Q?XdAMZuE8FyT+yX4yLfHU7+ID2/H/9UbR/w2ByYNrhWrwoAc/xfuJnC7fUBRp?=
 =?us-ascii?Q?W+7P3nVsP+4LGitY5Lzzts7RRpWOpGAzkvEsFG8pN9S+1U1nb3mlf3qLcq+Q?=
 =?us-ascii?Q?cwanpHlG+1pD90K/Q7btmcx4Px4W06bz4dNOORd53L39V3fA7AyUihDWVsEF?=
 =?us-ascii?Q?jKI/SDdQrzDjLs3vojGbrhm38bUmIphQ4JI5ME7hjKdAZjvIU66xHqj+DPd7?=
 =?us-ascii?Q?S5BdVaioRbUIlJXe38eWoPTN565StZKB3eH0JQnTWsYlna3fmtNBnp8o8ZGF?=
 =?us-ascii?Q?myTIuXjqlnmTX7JkGa3Z61Acq43VM95wiXJ/DQj+bukOSvaTxfatkTfFpoWm?=
 =?us-ascii?Q?iAr4Es45zyctQg6eXrOCW7rvZDTCsotoHeCYb6qtR/icBaei6XYs8rji+mAm?=
 =?us-ascii?Q?EUBgYg7yaHU0vn8AoEg49PT9rFEkpBPJb9TgGAHw3wNVdrol82fqCRnYL/xZ?=
 =?us-ascii?Q?Yn9QeDlN1hiUNM40LPAIYWuQQRYRWf1JJj/atWOtZNfCwfuznsLV3sKGa453?=
 =?us-ascii?Q?gvjVZx2gz+vBb5DbOmvtFpbM/RRdErteudn6GNyv0HiW9povQUjZGNHd67EL?=
 =?us-ascii?Q?V6tVqZl/+pC9zkjrPT3NLrwFiO43N8Ufps7eJ8uCVW4ihl4Q246jVtmIxrYB?=
 =?us-ascii?Q?hNzNA6he5Ldg1ot8++WNjYkgZwczJsCDjLrt1pzxdVRMCjepRii+DHeMceDl?=
 =?us-ascii?Q?a2JJU1T+rbnnhrYWZKMDuVHuYmq8uhGR/k4+Jp2hOuV4hMgyjdP0AlcVx04G?=
 =?us-ascii?Q?3MX1tBZS8llCpbczklvNTf5Mgg+wQ4qchuirHq6Vpo9Nkr6bit4J0P+1tqL9?=
 =?us-ascii?Q?wQ3EwuKhcnN9ArM1gGfF+sZslWFjJyZRcYS5CHY8nnzw+kbsbggNgbRG4oAr?=
 =?us-ascii?Q?pQtdhs1gFimvMmIa3APaUGtsP2m8QaS2WuxhgQI1xnK7qvPQYBsqjnKdaG1B?=
 =?us-ascii?Q?1xzZgAj60ox/3yQ=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 07:27:21.5192
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dff08f9a-e865-466e-8853-08dd556dd7ce
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066EB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6742

From: Carolina Jubran <cjubran@nvidia.com>

Restore the `trace_mlx5_esw_vport_qos_create` event when creating
the vport scheduling element. This trace event was lost during
refactoring.

Fixes: be034baba83e ("net/mlx5: Make vport QoS enablement more flexible for future extensions")
Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
index 07a28073a49e..823c1ba456cd 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
@@ -564,6 +564,9 @@ static int esw_qos_vport_enable(struct mlx5_vport *vport, struct mlx5_esw_sched_
 		return err;
 
 	esw_qos_normalize_min_rate(parent->esw, parent, extack);
+	trace_mlx5_esw_vport_qos_create(vport->dev, vport,
+					vport->qos.sched_node->max_rate,
+					vport->qos.sched_node->bw_share);
 
 	return 0;
 }
-- 
2.45.0


