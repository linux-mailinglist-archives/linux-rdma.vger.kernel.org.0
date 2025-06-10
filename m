Return-Path: <linux-rdma+bounces-11157-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD161AD3CAC
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Jun 2025 17:21:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C4C3178BAE
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Jun 2025 15:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51375242D96;
	Tue, 10 Jun 2025 15:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZaZSEnxh"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2070.outbound.protection.outlook.com [40.107.236.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85AD8242D89;
	Tue, 10 Jun 2025 15:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749568595; cv=fail; b=M9jOfEWFma6fG1Lc7NTtk9Or0E/DrMmfCDqT9/dyCrx3lailq4C22O+od4+jU68CLXOuGSs7hfo6w5SQMiSZ0e1IXgU3HD8ja60iv9G1UOBQPe6LgTcj9wctiExFK5SxRxJUzyqSxJugy74QzEeul+B5icSnLOv/4FAMtK+8IlA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749568595; c=relaxed/simple;
	bh=zazunoPr+20uX3Nn76oMGyt3LPRi8JTNOTXr4r0t+H8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D9N9hdmYfBu/W5RvmesfBSwgOFhqIxd9K65CwQqroDOoJdIcgMrhUXN6U5YJ6J4czjESlEpsMjCDmvHuGePXWxF38GBhkY3l9TaHN8kpP9ndU3QB852eRIKPxO6ymC6LDufuBtj9AgYUN9+Z3gbVfNEEKu8aUeK5NwhvZWBa2wA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZaZSEnxh; arc=fail smtp.client-ip=40.107.236.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D2WWurGlkxhU3+a8Swed88GxkGn5+NGgiVOX1hGkWDkrvNh7wf1lor6dGEMupg0PVasncWK4mpKcgR1BMTPcmJ2AUeCziv3NhqFAhQaP4qf3JAIFD1ZxsodzbspV6vC+eK2rDJrgQJ6EPxq0iDznDVTFaT+scjacgqa2j7fNE/9Oi1m3+FQMDda/VWckBJiV6IwhPBi2usSq7l2VhPxD395qDaCXkvD1/ezKDNBltHSNZiUfb5zv3B4b9KIUWvs/ZUobiJi50/eTVhbqB6QQUQ+CR2xT16ddMwE3rlFlrOsEJKMplhUNxHxC28J4qVQWbJfscvlBOUbY44v3xWhr8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JXqfNzb8S5GNSR4yvjkeEbUu4wz6LeALzMsuVTRqJng=;
 b=GwbibpO1LBSYVcbcTWQzF4HVEYKAMc9q8Lu0NqDScDtQ0ZuPTI10aCSxhGy/pxg5BQO2oxQe5sGi522bhmyk98I04OPxI2GQu17H8REiy2AE5MTqpdkFYBFzh2k6ijWfB/zUqzyQ6p8kxDgI9iYwu73cwtY01/FI/UsC08scSoDG1gO/HJPpbe9QKTaRgjjgTy0u2U5ZSC9PW6duloRKBgjhVG9+L+BIMs6nnx1MhF45sDzyku1Rcit7+YRyAt4BOeJaKbFp/kNGGSkeTu6TM5Yv/HeLNQHFPaK9ZOqiNdkt+vDeZezHltPUqXlfH/GZGkP6ucbU71gUp9kTQdf5Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JXqfNzb8S5GNSR4yvjkeEbUu4wz6LeALzMsuVTRqJng=;
 b=ZaZSEnxhWGyDbh4YfJqPYz6QIX4VeMorENEhcuVatyMpaLKPtByEvZfI7xNHc024u/AN+blx/ew5WMNl5k+5RIOUJIosJEyIz38QpOlw1qxekviG9HFjyBpxe+QDM5NZR5HNcnMJvv7jrTN9XWOv9u2Ns4Jm7jzo2XA0JWdfFE66yotURUKLkMK9XbAqYl25QDKjNPYfCe3I1QtXYNr9C9T7QoBrbNnmgnYVVk/IbiYhu7zgGtPvD4a5p4ugVBP8JTQXVOiVb2cYyrYxK0tE1QQKzMon9dJmsZTJyiwxhCJEe3DX1WsZhwgTWcLHyolSJrWXPJp16YbC7sNjscsApw==
Received: from BYAPR07CA0017.namprd07.prod.outlook.com (2603:10b6:a02:bc::30)
 by PH7PR12MB8777.namprd12.prod.outlook.com (2603:10b6:510:26b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.41; Tue, 10 Jun
 2025 15:16:27 +0000
Received: from CO1PEPF000066ED.namprd05.prod.outlook.com
 (2603:10b6:a02:bc:cafe::6d) by BYAPR07CA0017.outlook.office365.com
 (2603:10b6:a02:bc::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.19 via Frontend Transport; Tue,
 10 Jun 2025 15:16:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000066ED.mail.protection.outlook.com (10.167.249.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Tue, 10 Jun 2025 15:16:27 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 10 Jun
 2025 08:16:05 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 10 Jun
 2025 08:16:05 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Tue, 10
 Jun 2025 08:16:01 -0700
From: Mark Bloch <mbloch@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, Simon Horman <horms@kernel.org>
CC: <saeedm@nvidia.com>, <gal@nvidia.com>, <leonro@nvidia.com>,
	<tariqt@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Mark Bloch <mbloch@nvidia.com>
Subject: [PATCH net 7/9] net/mlx5e: Properly access RCU protected qdisc_sleeping variable
Date: Tue, 10 Jun 2025 18:15:12 +0300
Message-ID: <20250610151514.1094735-8-mbloch@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250610151514.1094735-1-mbloch@nvidia.com>
References: <20250610151514.1094735-1-mbloch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000066ED:EE_|PH7PR12MB8777:EE_
X-MS-Office365-Filtering-Correlation-Id: ed7bbf60-678f-4bce-6412-08dda831c574
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?c96DQtPM2ohJnYBt++9ouYPbksquCe3Zz+Xk42IuJtAk1BAiQ2095kqCT4Uw?=
 =?us-ascii?Q?CrGp1B7Zp1jejqBMWST8ygXSDN5qkZ/1eYWpGX30bSQ2MSeD8vyZc6Mn9sz5?=
 =?us-ascii?Q?a6LuxPyuRYLYON6/y6Xthn3VTd1crsPRRL9eUnBxiESuC5IfkJVRCxKVtJjM?=
 =?us-ascii?Q?Af+tZ2MFyTlwBu10Di7C/GY9uhDlTtin7oJ1mON7rhL/bQD0DRcSxagGVyt8?=
 =?us-ascii?Q?HNItW5GkLLbBb+FlWHck+DB+2kxNOnH67tB9QWj8y49HAo0FeIcc2/qk9DhM?=
 =?us-ascii?Q?C/Dxat0FTTgBuDJmUqHGglOhGdyc54zAsuTG1XKqnSjHTEPuNeEJopottsft?=
 =?us-ascii?Q?gZOC9DuejWz+R7x6ZyKX0vlxKwTnEwo1GtW3J67P/Lax2FonNOUaLl8xY2CI?=
 =?us-ascii?Q?V5D7VZDkPGB90RckKc6rLFvKZojuXk5qSM50b3q88CebkOOfXXFHAMtMQmKT?=
 =?us-ascii?Q?gemXdRvQw+hGiqXHCMJN8Yh8zqpZladYl/KrpzHn/dVjfvE40AbAEOVaeKm+?=
 =?us-ascii?Q?UapKRYrBZarEYgWU15GDJX6M0Hz1AS0Gxv4IghLgI8noaYZSNnqvKxullf6s?=
 =?us-ascii?Q?5BZmGxs0PMNfNF5IPLfGrI+m6IpbZloaoNCZSr0XhtWwkWF4PPbnuiUy7mkl?=
 =?us-ascii?Q?WSlicnhQJZXjai/NLJvDgI4u/4/LYDij+J1GcA2cu9dGEikzS286dkg2gXg+?=
 =?us-ascii?Q?7NozKdqPukyPUrEauYmEVdYdnL9tgyIL2sfZ4vfmnBEiEG3Jiv5eVwqiDC/T?=
 =?us-ascii?Q?sIs8S5IUeT3b/yphYiLUckFRfqERrb1rWUt9Oj00jLLOQRxhRltN6Rw3W6IE?=
 =?us-ascii?Q?4MOMRHqKH3IXyN09p5cZMXNgTLUoreieibkKPIyB4NlZPsjn6p1Cg/DjFI2Y?=
 =?us-ascii?Q?690haj/RVR07nDMIzWdENf3jfp8SfhEbxAm2LmXitxZCiUa9s+q69beTHKmV?=
 =?us-ascii?Q?dPau5+EpsYdgrrkUJdNT5McamoN0vaLar0LZbJcMgSFSX8RygkcoLD+tHIY3?=
 =?us-ascii?Q?y8rzQnQHcaJPO8Njio++afh7wjfd5Tre+VrrzpeVHbWD+XfjBj0ksgkcg0SI?=
 =?us-ascii?Q?CLXVbWURK3+Ki0HwIIJZCAOEr/8orE07x16HgMsmseB1iDRNnTyopNoHmR+w?=
 =?us-ascii?Q?f5GX+4MkVreOQLd5QqDqUUIKbF4Xiel5uXoH8vmNlvnIe8+m3SU/O8SXZff+?=
 =?us-ascii?Q?rFgT7qjTu1Cn/9ZlZec4X3nEhW/C0KiXSJEYwmESz4fYzTBiXFxGeZwnoCE2?=
 =?us-ascii?Q?hsHQ+CHcMstuticGUt99rfMKqK6QnT/cP9R24JyyyQ4+S7Ize9Gma+Kt6Ggu?=
 =?us-ascii?Q?10plYq+RGIdfZMvd20j45XeGONyP/N7GSK0E/blEt25nqPLNIykgdYucU9H0?=
 =?us-ascii?Q?NKDPgY95BWICvehBqFcjAwNiTmtjQUOqJ3c5HLAD9unKoJqrMNDVwmi3ZEc1?=
 =?us-ascii?Q?9/yLwIOoG4p+gznehirGHAO2I9dDLKG2YZGdQ5/gMCgAIas3gpJmrJprcSXa?=
 =?us-ascii?Q?iwXdR+6Ls2Z6p85hEGPVg4yiP3EtLwxd66GD?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 15:16:27.4681
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed7bbf60-678f-4bce-6412-08dda831c574
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066ED.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8777

From: Leon Romanovsky <leonro@nvidia.com>

qdisc_sleeping variable is declared as "struct Qdisc __rcu" and
as such needs proper annotation while accessing it.

Without rtnl_dereference(), the following error is generated by smatch:

drivers/net/ethernet/mellanox/mlx5/core/en/qos.c:377:40: warning:
  incorrect type in initializer (different address spaces)
drivers/net/ethernet/mellanox/mlx5/core/en/qos.c:377:40:    expected
  struct Qdisc *qdisc
drivers/net/ethernet/mellanox/mlx5/core/en/qos.c:377:40:    got struct
  Qdisc [noderef] __rcu *qdisc_sleeping

Fixes: 214baf22870c ("net/mlx5e: Support HTB offload")
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Signed-off-by: Mark Bloch <mbloch@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en/qos.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/qos.c b/drivers/net/ethernet/mellanox/mlx5/core/en/qos.c
index f0744a45db92..2f32111210f8 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/qos.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/qos.c
@@ -374,7 +374,9 @@ void mlx5e_reactivate_qos_sq(struct mlx5e_priv *priv, u16 qid, struct netdev_que
 void mlx5e_reset_qdisc(struct net_device *dev, u16 qid)
 {
 	struct netdev_queue *dev_queue = netdev_get_tx_queue(dev, qid);
-	struct Qdisc *qdisc = dev_queue->qdisc_sleeping;
+	struct Qdisc *qdisc;
+
+	qdisc = rtnl_dereference(dev_queue->qdisc_sleeping);
 
 	if (!qdisc)
 		return;
-- 
2.34.1


