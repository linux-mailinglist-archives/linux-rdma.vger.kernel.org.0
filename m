Return-Path: <linux-rdma+bounces-12105-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5620B03621
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Jul 2025 07:42:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F7CB3B0693
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Jul 2025 05:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A907223328;
	Mon, 14 Jul 2025 05:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="G+j0zEBm"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2062.outbound.protection.outlook.com [40.107.236.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 632902063F3;
	Mon, 14 Jul 2025 05:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752471667; cv=fail; b=DJb+jcqvhK7XTMesJJs21Y5sEpKspf++EENOjGJcJv8yfrNJuaqCjYzbynPk9b2TOcQvmgka7BVLb4Fy1ePtqraDlXjRmgESFNY+RpOnZ13/Iy9dU6A7v1a6q8DtVx9Ab7Y0NbV5n7n604B+G8hmVX+cc3wn/bFdlNARrOPXb3c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752471667; c=relaxed/simple;
	bh=XbPozJdc9WXKGTY4IUaqpv925gDN7LRk75gW33GZU54=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MA/73mhzUMc1lQdaqi5jx/36FbXuwGRAxqVfnYD5BUVk0UIUoQ4YvaZe7nA4TR1JlMUOpcrg7YSJVyqKf/efWjfYc94ReTTjv/b4iIzh5EDrSsrUhdHd3RH3xx2/XwClVXtcQp7FozAmvihOmDputTYpcaw+UiLPj/RmNrvVTk4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=G+j0zEBm; arc=fail smtp.client-ip=40.107.236.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H313rURj/OV1iFfruerF5rr449+9ZDnwEXcA48PmRdvbO+pud6iAmKWrz8VflISmH6qoeD8tLlrkb9n11J0xS19zzPo3BS9g4XhFopDGJKtNeRtRISRbjg8Id26xuUAbSIkH4smxO1qsAJHre1k9CdGjSTbc0U8KPEx1TC7xRZj/rEiDBtUCIfjdUjpyN4molfwILjIBhi30e623gmLfpvfFs610crTPD5WhbkxdHgaoOTWCbF168bxqwYPy5aT8jZItfmWUvMGiTWNRKnetNjMnCDKYQfjZFxb81zqMi6L1TMgpQzRFl5ADTwz2ozdmm/IYzoQ0u3BiluhEvp4YVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9ZK7EMvQPVVxwj6dTJNwChEzIuxfbqx/J639/qEmUhw=;
 b=jlx7wzqOeZx1CTzVUnVEM942y6QK82nJkKifjFyDm6cAGJ8ECbiAhdZFBJCNSMCV95MKYyNKl2KKwx1uOviifAQ6nz1vrsXtYzvV6bIF7UlM27yx1oMV0DPYn5F4unnXIv+dqSmr0Bk5CZJ2tcc2YTc9WgaTbD7JIf8jqpPT9W9HpMUry7gGnMFfGmDqtV+EHqQAJaRvad9q2Ahn2di1ufr8h8Blxtli+ya8VG5sn9+rl//nTzGHN13NctXSq16buPwySqGVXq/l2d64kU9zKVMekdywWjUqx/6/HIiTkGGEjjceGpD7aF1CinT7TAVQFi+lVeHDzjVpTX4BMxYMYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ZK7EMvQPVVxwj6dTJNwChEzIuxfbqx/J639/qEmUhw=;
 b=G+j0zEBmBTC4KP+r+tIn2cU97WxiJOhyLyyjFkrPjLMb22sajuwcm1O1wVn2Oru5CU2KkX6XYPAg9icrNHrLYb/F1M5EiUkPa2e0MJdhYmPF37lLJUYu8cQiHZQfyvKwypWtsSsuOi/HTAzn9FdtjTCIABDpItprCnP9TO9WbpDHv+GQuT4bIXezNbVcrezUpZfM0geSbaEOvUjrk/+LQpLfhNPhb7vtKoeOsJ+5WMsNiIiZZZqv+JugcND+ktrVnQ3UxAMhOx/QdT5+b87wWMB4aXp8Fx4AlDTShX0fMo28/E3BIV6+Sb6j/echyvVoBBagNH5lqm6du3dTCkKAwA==
Received: from MW2PR2101CA0025.namprd21.prod.outlook.com (2603:10b6:302:1::38)
 by PH7PR12MB7018.namprd12.prod.outlook.com (2603:10b6:510:1b8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.28; Mon, 14 Jul
 2025 05:41:00 +0000
Received: from CY4PEPF0000E9D1.namprd03.prod.outlook.com
 (2603:10b6:302:1:cafe::3) by MW2PR2101CA0025.outlook.office365.com
 (2603:10b6:302:1::38) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.5 via Frontend Transport; Mon,
 14 Jul 2025 05:40:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CY4PEPF0000E9D1.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.22 via Frontend Transport; Mon, 14 Jul 2025 05:40:59 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 13 Jul
 2025 22:40:48 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Sun, 13 Jul 2025 22:40:47 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Sun, 13 Jul 2025 22:40:44 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeed@kernel.org>, Gal Pressman <gal@nvidia.com>, "Leon
 Romanovsky" <leon@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, "Tariq
 Toukan" <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Leon Romanovsky <leonro@nvidia.com>
Subject: [PATCH net-next 3/6] net/mlx5e: Properly access RCU protected qdisc_sleeping variable
Date: Mon, 14 Jul 2025 08:39:42 +0300
Message-ID: <1752471585-18053-4-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1752471585-18053-1-git-send-email-tariqt@nvidia.com>
References: <1752471585-18053-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D1:EE_|PH7PR12MB7018:EE_
X-MS-Office365-Filtering-Correlation-Id: ca583b6f-5e28-4674-5c23-08ddc2990348
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|7416014|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4ZsIa++olgvCF0Q4AjHio8AujycMeXCnUXF9lJnVTlRzMn4uAfWm+wQklhXY?=
 =?us-ascii?Q?P7DALbIc7ZneU1P0Ha5WR1iXCuGRcnr84KQJDbfdh3qz16XUDUuhYhFCgvug?=
 =?us-ascii?Q?frpaWss4zsv0Iczp31ZZmuaTknxaX85MzoQjxDdeIm+qmGN66EgKg3MGe1qk?=
 =?us-ascii?Q?xy5doHW/f4MU6Dfwv2+iJwSBbZVo2RKHIzo9ZenzeEejAf5ZKEqv9iRvo37h?=
 =?us-ascii?Q?qpLbe5z/wHK+ebhRF38U4VOMFiQxGgutaHNXnWdAtRVQr6EAwV4MKSiKi4X+?=
 =?us-ascii?Q?I6pya5JmG9l46xmzOtiSaqtNjmtW8jQL1VusKRFuplVXBn2sWZdK77p6HYtQ?=
 =?us-ascii?Q?6K1+tXjo2VxPRc6Sqcgq3NPTrs0nX7Sz9hbC3dzwfxSv5glBOH3WCd9CtwWG?=
 =?us-ascii?Q?2bV/FrSnhUJY4+Xx6f4sBkI4oAMcy5uCmavhQvrjhq/AIyzaGUseZBXWoVCP?=
 =?us-ascii?Q?OJopjhkC+kg1x2DIzWniSh5KWvVGgTooGSCWaB/I6Fn8uy+nrN24G/kwSTcO?=
 =?us-ascii?Q?wp7W69CZ0DZCc6HHWgDdu0kmaHzi2jeltEAgvv+LZqepBryZ5FS56hYJmGO8?=
 =?us-ascii?Q?brERntGhx7d5BN6Y4LdRIAKuhOVGx+8+20brDjoG/h/7KAmPNxSh9Dal0IRl?=
 =?us-ascii?Q?lTpkD6zgeQKy1adNDVzo3pBTsUuyQuk7mjZv4d84zaoZvSEc3cs1PrGN6A40?=
 =?us-ascii?Q?y6APLb03EMYBAXdD4sFrOifswVySAm7d9c8Xs9IJBYN2K+uF11ZZPDLoYsAY?=
 =?us-ascii?Q?vRZnDHlT+szTQyp5vLYgdWYbABwbjleMkXsfBShmYnnIUMb0/nIGP7vKeLS+?=
 =?us-ascii?Q?H26Rt2eh8KZVVqlYe/ADWRTFN2H6U017ivsAO0NDQrGxijBCSyAuW+3Eum6D?=
 =?us-ascii?Q?tWOwYjAzGBoONJTwGLsBLqfNO0HW17UVuv4sZm2XMBILCKrmHYgLzjLkAu3+?=
 =?us-ascii?Q?ryVrULUZRoQkPRX1WmH0OPXgfwUAuTKHNeVhh5zeoLd576iPLE30etCyQGOl?=
 =?us-ascii?Q?D3KasoT7cBIe+rEcdBE3hEwWMo01otpw9PcqqiSD9Kwn2Ly9arzBzoA90tMS?=
 =?us-ascii?Q?jBmrXcDdY7GXBXlOpcqNAs+8CLro/y54/Gi3MSlcPfwSMFc+5/snWgGQVuZ8?=
 =?us-ascii?Q?HFTEPoydv5INw851ED1UKwhRx/uF53vIKmjuKmy+aIb2yblhO9MJEFfmtK9C?=
 =?us-ascii?Q?hVMYtuo8mj9Nkx0pxLNFVcYAyI5LNPIZDTCWIpoM51cPMbGzg/47266UqVru?=
 =?us-ascii?Q?KPVYGD3dw0giOnrdS8go7IK1vyCgmgStsmSVXSLzFPjdgWFxA6ioDXeGqQYF?=
 =?us-ascii?Q?Q53qWboDGLPxYh9vajyUsSwf3SJtRkmHxec7EmyI2YpNaLFR+vuXnXvQGjId?=
 =?us-ascii?Q?8zkcFha/O+Yfhsdu0D05DFAuMyrzg9E/ktgEz0CMGiKS7OJKZNV8YFnAnV0Y?=
 =?us-ascii?Q?9YxGMm2QU/568b8r9DEz8PeTg+EpTVTlFM/ZD9MHdJC1EbpDzGLzH+MJhYyc?=
 =?us-ascii?Q?Fygdsg6fwS3vCkWxTUSnpj/A71SgRUR7E1bT?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2025 05:40:59.6317
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca583b6f-5e28-4674-5c23-08ddc2990348
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7018

From: Leon Romanovsky <leonro@nvidia.com>

qdisc_sleeping variable is declared as "struct Qdisc __rcu" and
as such needs proper annotation while accessing it.

Without rtnl_dereference(), the following error is generated by sparse:

drivers/net/ethernet/mellanox/mlx5/core/en/qos.c:377:40: warning:
  incorrect type in initializer (different address spaces)
drivers/net/ethernet/mellanox/mlx5/core/en/qos.c:377:40:    expected
  struct Qdisc *qdisc
drivers/net/ethernet/mellanox/mlx5/core/en/qos.c:377:40:    got struct
  Qdisc [noderef] __rcu *qdisc_sleeping

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en/qos.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/qos.c b/drivers/net/ethernet/mellanox/mlx5/core/en/qos.c
index f0744a45db92..4e461cb03b83 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/qos.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/qos.c
@@ -374,7 +374,7 @@ void mlx5e_reactivate_qos_sq(struct mlx5e_priv *priv, u16 qid, struct netdev_que
 void mlx5e_reset_qdisc(struct net_device *dev, u16 qid)
 {
 	struct netdev_queue *dev_queue = netdev_get_tx_queue(dev, qid);
-	struct Qdisc *qdisc = dev_queue->qdisc_sleeping;
+	struct Qdisc *qdisc = rtnl_dereference(dev_queue->qdisc_sleeping);
 
 	if (!qdisc)
 		return;
-- 
2.40.1


