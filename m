Return-Path: <linux-rdma+bounces-13556-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8792AB8FAEE
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Sep 2025 11:03:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D3FE2A1A37
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Sep 2025 09:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8F2D28850E;
	Mon, 22 Sep 2025 09:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DaqFr6XY"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012068.outbound.protection.outlook.com [52.101.53.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D1F2877F1;
	Mon, 22 Sep 2025 09:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758531732; cv=fail; b=J7rDzhfEOpF4B/qwIlu9b5wpUf1SXgsSs3i3VZqSNWI7vKvoUNj0+xKJjpdLUiZ1kx6bDwCIZmGsZ7ijCMJf91XKUSbSVh2RhSP9CDanIMWTDMnAnaCp+Zbjw8AQ33fGsxLGT1e/PsuKIsZgcJC8s4Whb7UQzB94u/tN3Z9bp1M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758531732; c=relaxed/simple;
	bh=i1/kKG84oyD7pQvPlFrdrAIiboOui0dHrCGwCDRL+mg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q9LP4Ts8N4q4KB3eYNqEksQ99P+X2/E0i7EejpIACWEPE+0IpKLujf5P57uABVdB4WFBdKCiGrh3J4i33xHKFbOPKDAuwvUUeoqUOgtAVbWrhU7LMuhTJ3DNvmqURB8SlHJPowW4VaHhdrZjsZvv/29qLkpi9EwTucbSzhRqwog=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DaqFr6XY; arc=fail smtp.client-ip=52.101.53.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qkMeCUF+3Axt/kON++CWGOYMpEFInO2iqHLfLIgeUHaFuVQiaL4iQ8cG+Vt6EEUztwWaKKF/hK7KpIrcU+fYNEboiV4hSghX1HamBOTUd83WVty/UOlh32UKZULTZYSMHw9W8AM2npwD3sRw+SHtDopyqVvX6C+dwckOL16cS3yq+l1YWQDeloGfM69WLRFjIi1s43EjmOa8CnHbbbqM17RoDrQhNbkgPuPXqD5lRq8Tec6+ZxePHa5ApIRr8gnkc0nxl6JCDHJk8oYhrlf1N7OpCeUBQXRWuX7v1MQVY69nHC0LMmdyYHaQmFF7SvsHDkxSDnXvY9v/A/rIrTwKuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GM69raJHfI8YRvDHf2v8aYmmSASj1xpJZyoX2RaAa4M=;
 b=CvZTEZatmGB70xd4PPcbk9TI0gqPfbak/AeHcvRTOtCuI5oo1ObnfE2U8iwfmeqP6Nc2A8Me1Omnp06TKkCLtiBXeJPEwRsnR3eM5nr0TS/ofH3rd4/5K2iLBbBbvSj5D5ynm0B/+bODq18jrdBYl15DZnf+lDmgRL+5dZNaWIri90VDkWyGmTxcgQr1DyJa6PZLQMxxrRQLdJPFQavQDJlIpSvHGwGFhvtesGNY1lFDa54eC4djOSPlCsqd04YYwcSM6YPERw1vWC9cKRPHgw4SXb54n2STvWLFrJ3gNL6FM9VhdRIqrZ1Vx+zIn3vaoNErrAIMub+EqANG73N9gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GM69raJHfI8YRvDHf2v8aYmmSASj1xpJZyoX2RaAa4M=;
 b=DaqFr6XYmyW5vuYft/xA4WeDiKxTkoKWPTDKwHWa4RXKQXlUWXqrjUpe8S8BxGrP13RzrG9ESWobraVtYvRlZ7QxweK+CYnWp+shWYAazZa9kHoSvDU7dMR9w2KFS+4bIT1pXJXAAJnBycoRSab0VLF5IoDGZXZu2p1YWNBQf1p++xOlMVt9Vzyie9qkhwSsFGPLES/nEpDFPLJh8mDdes/f8G/kKs146+ijct4wu+fxsJMo0ye7rEqG3ErxA/75p301S5bwegrJr1C0lt+k5cRSZCfreuyzDCqIemdPrwRkn36msC+An8Jh1K2aQZXJJfi/my+hDEkdFHdytitdAg==
Received: from CH2PR18CA0005.namprd18.prod.outlook.com (2603:10b6:610:4f::15)
 by LV2PR12MB5917.namprd12.prod.outlook.com (2603:10b6:408:175::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Mon, 22 Sep
 2025 09:02:05 +0000
Received: from CH2PEPF00000145.namprd02.prod.outlook.com
 (2603:10b6:610:4f:cafe::dc) by CH2PR18CA0005.outlook.office365.com
 (2603:10b6:610:4f::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.20 via Frontend Transport; Mon,
 22 Sep 2025 09:02:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CH2PEPF00000145.mail.protection.outlook.com (10.167.244.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Mon, 22 Sep 2025 09:02:05 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 22 Sep
 2025 02:01:54 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 22 Sep 2025 02:01:54 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 22 Sep 2025 02:01:50 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>
Subject: [PATCH net-next 3/7] net/mlx5: Improve QoS error messages with actual depth values
Date: Mon, 22 Sep 2025 12:01:07 +0300
Message-ID: <1758531671-819655-4-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1758531671-819655-1-git-send-email-tariqt@nvidia.com>
References: <1758531671-819655-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000145:EE_|LV2PR12MB5917:EE_
X-MS-Office365-Filtering-Correlation-Id: e7691fb7-2b89-4d29-db86-08ddf9b6b3e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Zr0E50UtNCiwBNAKGup+td9aZ4IPshRYAmxEyGW+beMJvi/rRM7woL2j65V7?=
 =?us-ascii?Q?HD/PD6IBw9hVle+3g/XsMElqYl+9mYRQ6HBok2cfEvf/0H1JyR2atX4rnTLl?=
 =?us-ascii?Q?zS31IVtmkRX2A4a6rgsa7n9CehYPJF+SMx6Jm0vuYVzr6CA+JL7NpaZ7BWsJ?=
 =?us-ascii?Q?hWM7y6H8a/nOmpc5dgUFlZZEBph9ERok/6hdqFpJWCev7aAzLxHJ1hhfTKvT?=
 =?us-ascii?Q?+zcU6/2oxPIZUp9HrOql8+3uNF67flBehXt6M5r0GFWGHhyRFLFrXZg59/60?=
 =?us-ascii?Q?0mPp/iKl6pn6ebgHW/CA9MJko/jci8BsvaBszCz+y2NeshyRhROJjHyueI6L?=
 =?us-ascii?Q?/J7YewRpo2L8Aix0nUixLtL7uGDF/t9RrRkyJ6rAFV84/CDyx1QP1Srp5eI1?=
 =?us-ascii?Q?IZqjCP/df1Yv7GwMfe+JgItrBjL4wKXqGNW6Kfae744CxJeD+hFyhc/qLBnj?=
 =?us-ascii?Q?cCMzLdiwWOD7q9VGOcjQLLzDUm2LDb3DMv3RUA9P5DFISXKAdTtI3+1wWBIb?=
 =?us-ascii?Q?LdJcniidY5xFns0f1tnuj8iNF38kRcx66+yoZK7ICZ/NuPcPffezLEN6VL5B?=
 =?us-ascii?Q?TcR2Ovf3b0WbrWBQIR6qmdZpFPWvU4j+I/LtW4ILD5TWfDmMR1nrIovg7L4c?=
 =?us-ascii?Q?ltmLMvKpZX6bwXvAlbIancuNeaBnOkbk1HZ+vLhhLV9NK9C+EaBk9VXMvApc?=
 =?us-ascii?Q?/gbMfxonj1KhXqAXmZPyKj1rWfX3LQTPfX7TOM2ymhTQp9Yy9bWl5tu3gUlK?=
 =?us-ascii?Q?Ka5Xfh0C7IktnHbg+LWyTfW2jtV7K2z7tJUKewIor5YuUvKXHZ4AUdFv+6Zq?=
 =?us-ascii?Q?1RYd2ttiva1rnwm4ejJmSfJEgnMb6mzj1mpbu8yJK9gPvV+209gI50wjod27?=
 =?us-ascii?Q?nvk2L/ju9Frucc3zwbfASz4y9Q+xFtMFp62BAG0sgAU9XvHPsMPJHCy53l/w?=
 =?us-ascii?Q?gGfbfTgpzc6P2MqIvVaM2Vp+rBXC5b9bHMmmdtg9mnRO3UcUMqSrRaxOfvBM?=
 =?us-ascii?Q?vT1rJba/wrzLAjLcmnHYBhL2oplP0QP0hfoKU2s/S5asy9Q8iaCWKgNUiZ+2?=
 =?us-ascii?Q?3/BBHblCjj5tMgpnDz7/2YuukfX1yOBy/54E2kexgOIIlifE2u1jASgvpuTl?=
 =?us-ascii?Q?9OXVVSI3+E5jg+rw7N9/1QYehZqbmpU+0IjW8TU7XbtRgcXc7t1/nF6jSjwh?=
 =?us-ascii?Q?/Ff/SxKCGLXSqXbn3WlE0Xd98V5+JhWSNZjdL2DO+0AFJ+lxpS+NAQ5Y95si?=
 =?us-ascii?Q?WOp3+hrm0D9bzL3DLn43auWhD91t1f/IW9sFHii+a77cnHdBpFcNKrgQ8iDG?=
 =?us-ascii?Q?LBxGHDD8P5Dwg6ccK1T9FTOSV+YEc17h5NazCGWQ7V7ZsccYu0ef4CRQ01H5?=
 =?us-ascii?Q?HEpRdSCQdWaQg5hmq8FuRF46y6895sTJBp0rGE8rD6iyKJcKq6N1YLVjky3A?=
 =?us-ascii?Q?r0D9KKIKCg4LROx5PAqv/20eR8h3GGXVODCe1D6FPwoanIcJpXKQByuUOuxg?=
 =?us-ascii?Q?N+ZBlJ6Zaiyo7VFTQupNbjIz0k2TaPvj0m+A?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2025 09:02:05.2629
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e7691fb7-2b89-4d29-db86-08ddf9b6b3e8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000145.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5917

From: Carolina Jubran <cjubran@nvidia.com>

Enhance error messages in MLX5 QoS scheduling depth validation by
including the actual values that caused the validation to fail.

Suggested-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
index 5f2d6c35f1ad..8574eb96f606 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
@@ -971,8 +971,9 @@ esw_qos_vport_tc_enable(struct mlx5_vport *vport, enum sched_node_type type,
 		max_level = 1 << MLX5_CAP_QOS(vport_node->esw->dev,
 					      log_esw_max_sched_depth);
 		if (new_level > max_level) {
-			NL_SET_ERR_MSG_MOD(extack,
-					   "TC arbitration on leafs is not supported beyond max scheduling depth");
+			NL_SET_ERR_MSG_FMT_MOD(extack,
+					       "TC arbitration on leafs is not supported beyond max scheduling depth %d",
+					       max_level);
 			return -EOPNOTSUPP;
 		}
 	}
@@ -1444,8 +1445,9 @@ static int esw_qos_node_enable_tc_arbitration(struct mlx5_esw_sched_node *node,
 	new_level = node->level + 1;
 	max_level = 1 << MLX5_CAP_QOS(node->esw->dev, log_esw_max_sched_depth);
 	if (new_level > max_level) {
-		NL_SET_ERR_MSG_MOD(extack,
-				   "TC arbitration on nodes is not supported beyond max scheduling depth");
+		NL_SET_ERR_MSG_FMT_MOD(extack,
+				       "TC arbitration on nodes is not supported beyond max scheduling depth %d",
+				       max_level);
 		return -EOPNOTSUPP;
 	}
 
@@ -1997,8 +1999,9 @@ mlx5_esw_qos_node_validate_set_parent(struct mlx5_esw_sched_node *node,
 
 	max_level = 1 << MLX5_CAP_QOS(node->esw->dev, log_esw_max_sched_depth);
 	if (new_level > max_level) {
-		NL_SET_ERR_MSG_MOD(extack,
-				   "Node hierarchy depth exceeds the maximum supported level");
+		NL_SET_ERR_MSG_FMT_MOD(extack,
+				       "Node hierarchy depth %d exceeds the maximum supported level %d",
+				       new_level, max_level);
 		return -EOPNOTSUPP;
 	}
 
-- 
2.31.1


