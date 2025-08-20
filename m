Return-Path: <linux-rdma+bounces-12836-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CCCD0B2DDEE
	for <lists+linux-rdma@lfdr.de>; Wed, 20 Aug 2025 15:36:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9ED5F5A7D58
	for <lists+linux-rdma@lfdr.de>; Wed, 20 Aug 2025 13:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 130BA322A0C;
	Wed, 20 Aug 2025 13:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nSypBJGg"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2057.outbound.protection.outlook.com [40.107.92.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D9A331158B;
	Wed, 20 Aug 2025 13:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755696802; cv=fail; b=I/0nE97D4SOYatGo1g6yHgwwXr25fstOJ21x9jP2IwAslaP8yS+tEcBO5ty98w7hVmE07hGsBg7Z5Cf7Zrpk4iRGr5MqePYMQGHllcOMQYBZK56putQ5Bb2HXFGxMo8hNrKJcAsVhbPyx0I4efJpg8ugdtqPvQ02yVppUKoBI64=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755696802; c=relaxed/simple;
	bh=1bfFGYIDu3yLE7i+w/4gdnDB36alxCHn8yJEQz3OPtg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FwWYxM/nfZkekzDYXM6sgwFRTkYbzgPjTilXRa7eziTlk0qFjW7ZAC4fmok5lbzu1pYaL64GKSgr9sWCIwpzEzYBXkMqJyIzl5GFqFp6FkNrTas61+94CQi3U1Jo3nLwaD+hsDKCuBBHyJxWxekensqzViw3IV0DJKYrOA3EWw4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nSypBJGg; arc=fail smtp.client-ip=40.107.92.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pKeRSF9595En9rsfhyoS9pdoRIbeaKck10Qf0dtr5QG+KbvY0CC3NJMFFp9LzfblcpJLzTlcm8eb6kpCi9BLLIcwtPETg8EEPNvlZvPILwlN+BdoyHoH8AEH+Xtbjo4g7PJyo8sFio38gQEB+l7s0Nfg4QzJ6MZJ/2afaZM0McuXdWf86BNAQtVj0072Z78T9Sr6CelMeekl351HUAAb5ayGxE/RqTqQXOq7z9u6MSiJaBeUh1eJ0bGt2y9MJySOnh46vN0/0+//EcekXw4p8kYcZcXzdPVaghp59q/+Lz+R+Dq739ilbrZEN1onZf0L1Xu4BndJdP2IK+GVn/9Pig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RXbgwpN+qDnF5HV/C2M2XsdQNwJSkRvz/XJUVttUpZM=;
 b=O+80JL84vYJS4C/lKzo5Rt2fgSL0Uxink3+QkL8Wh8enpBIJuTRs0Zk2SxzobHPUBznS1UojvJI0IUgqXG9xhfePuV53q7/QQZeET6eAIJda1VYAtzJOJFOLutO3Sjyke7J4YuddywtZZZSna8b/lF7Yj74/OcsGxBvWqde7FJBBi3t9V8El2FdaBdPvjIwPYxOUjB8bOPJWP3xHrJChZZMpJ58WhcW1LQIy0lTYQqKQseVGgTQNUaYCfLRrq6lr3zBGej4H/q2/zZUKB2AAgWn/M6NZUIRDwoQkWuttk+3O3Ntg0x9WdCMRAvX3C4RKNpt6KNUTfapxtKLM5cQqxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RXbgwpN+qDnF5HV/C2M2XsdQNwJSkRvz/XJUVttUpZM=;
 b=nSypBJGgCDwEwzwAUjYCkyEENw3LffqlP0rl1Zdw8Wf0atz5GkXP+Fd48rSpMJQzCQsXMq77QZXBvOsfeecsqIZG21+gCQI7Z6U1JZv7DAMQCtug9XU1ufbdinYAxIQ67v8CVfVkyPWAAqT+DKk8RXtastDq4mna0jKmEjKy+1KXgx3kXEH7e43LRFE37W53qSimFParK6a7h0jks8I5jK+L/dksoaBu4kAIlIXo/Do8ccEZu5Y9F45BQBpJjjaT45TWpDzHDD+7sbQPvYUh1g/ueol74dQBGyXyOBF6sbP+PE98CkMkBRSR4YE8zwp84YqXZ/bclcTnPrF/XvAs0A==
Received: from MW4P223CA0015.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::20)
 by DM4PR12MB5770.namprd12.prod.outlook.com (2603:10b6:8:61::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Wed, 20 Aug
 2025 13:33:16 +0000
Received: from SJ5PEPF000001CD.namprd05.prod.outlook.com
 (2603:10b6:303:80:cafe::21) by MW4P223CA0015.outlook.office365.com
 (2603:10b6:303:80::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.14 via Frontend Transport; Wed,
 20 Aug 2025 13:33:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF000001CD.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.8 via Frontend Transport; Wed, 20 Aug 2025 13:33:16 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 20 Aug
 2025 06:32:51 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 20 Aug
 2025 06:32:51 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Wed, 20
 Aug 2025 06:32:47 -0700
From: Mark Bloch <mbloch@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, <przemyslaw.kitszel@intel.com>
CC: Tariq Toukan <tariqt@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	"Saeed Mahameed" <saeedm@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gal Pressman
	<gal@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>, Cosmin Ratiu
	<cratiu@nvidia.com>, Mark Bloch <mbloch@nvidia.com>
Subject: [PATCH V2 net 6/8] net/mlx5: Restore missing scheduling node cleanup on vport enable failure
Date: Wed, 20 Aug 2025 16:32:07 +0300
Message-ID: <20250820133209.389065-7-mbloch@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250820133209.389065-1-mbloch@nvidia.com>
References: <20250820133209.389065-1-mbloch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CD:EE_|DM4PR12MB5770:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e483074-2a30-43b5-4882-08dddfee1ebd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JRP1tbo4k84Ihznh1fze8ypgtLTr9AST/siMqxKdod9JOBTAqzdv1O6zWI18?=
 =?us-ascii?Q?5+lxWBvydmln89xsHhwUOdBu47ycWacgtccQXd3ZsQsixiI3UHjTXpPVaOzv?=
 =?us-ascii?Q?4ho2i5lf92dmYgHXv982QJHT3azguZWmZQ8XHpshXvmX+VJrB0d8dGleWoAO?=
 =?us-ascii?Q?yLzXPnSTvGAs0D6yNRXkNedTTpDvluyEENEUSNNQBAX/zrpWz8gKNYuvn4Y3?=
 =?us-ascii?Q?6K914M6pGwrFizmL6MkcXgslGWeudN2HLgUudK7cBeBiRSrcmnyVlLI3dC/z?=
 =?us-ascii?Q?OhvoZczSf3DCOo4H9BOHMV/BvqFpHwku2cg8zzoVt4274yOPV+/T3P2Dxq5m?=
 =?us-ascii?Q?GPwsVDz0zNQqiawsZWhT5AnGUMZdSjrLB9X35OA8xVSJTnMxt7GCzuG0LaVn?=
 =?us-ascii?Q?bnzzZb6cpE6rUrd+vStZ4jgcFY6pbbvWZQ767qfKwfu7D9PyUqvnswDzZXVH?=
 =?us-ascii?Q?GMON4bLIAjRXzkfkG0vy4e+xntGrVuXPjJzb4yG4FY8U58l9AggOTzkcKh6V?=
 =?us-ascii?Q?UVXBTxXOKSdHSEfCyLhnCGWz+cKHRaVNH7eVP+4fYnA5KtlOQd+hKORV8LQ4?=
 =?us-ascii?Q?cqZ1AIiUyekt/X6OZVkARuXYEHqPjtAcZseRfkPrVCPFSx6mGkgTNun5Nznb?=
 =?us-ascii?Q?l6OzNshyOjs6nt4UUkbeYTg2k2htEBbuulDUR4Ir0E9lE0QmA+cK+kLaqIEF?=
 =?us-ascii?Q?FVpuUIfR7VhwdeWy9veyYDIHEwUdroD52+rO/7/ZCdSqrrY2xMEp85CkWMNq?=
 =?us-ascii?Q?ovZ/2k92omefGprrEa13NI/dENllzvT5LTx3BKMJxyn5AncfSkSIoN0bF2Io?=
 =?us-ascii?Q?MHQlmP209yEgZV8fmYdtR6YnEe98srmWb3zUngN8/ItzIOxMBLmK1v6B/pJO?=
 =?us-ascii?Q?f/VLMX8EI6OyWbilAzPpaztX/rHwzZmWAtwPD6CFEwIs3ulnFZLXNHhE9Alu?=
 =?us-ascii?Q?6qJEkWic6/Bb5JUIjjuCzVKOFjqua1LQXXLcmJpjOue8cX1Kc1KZPxvNnFq+?=
 =?us-ascii?Q?uGgNLi95+lWIQ55AbWw8g+uVbJRyISqHrr3H5pmCn7of3aJfR0BH8Nm4qiJV?=
 =?us-ascii?Q?pRcuMk1+GekTFCM8FclDqlbPblG/NwNkjV6CIJnDZdxKM3YeYadTlcZVUzgx?=
 =?us-ascii?Q?P2vADyH4q9/azTllChsRl6JsDuLsDlxVnHhZPJtS/biizv/58Ba8yMeplh/n?=
 =?us-ascii?Q?fqg645HEp4TpCMHOoj5nOXgyv/DvY1nP/ViRw5YvRNUPZRDzErmKmuIRXpFA?=
 =?us-ascii?Q?EUZcgczlwwMpl/zIE29bh22GK1mE7a7nEXBdVhJs2AG9ZGDlTUTbo4S/Atv1?=
 =?us-ascii?Q?/HRyrVrWvzGVVDqL6lGyJ36Ql9EkXDQWAhRP1jymYsuxqET3hKpEp/946XOM?=
 =?us-ascii?Q?rmmK3lmfYSl7AfVeq+kBg803dOfHGv+5Ln0IT4ylX1N7BNhgPzYQQ24VSpHB?=
 =?us-ascii?Q?Feg34iu5DjMhXRV/xVNdw0zXa0WsUnGB4iTPu+b7rPKRSA6Jp4gxEwOCJ9fX?=
 =?us-ascii?Q?97617Vv01MZrZwAKCJeOGIxIuiIBnHNw8ulW?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 13:33:16.6093
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e483074-2a30-43b5-4882-08dddfee1ebd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5770

From: Carolina Jubran <cjubran@nvidia.com>

Restore the __esw_qos_free_node() call removed by the offending commit.

Fixes: 97733d1e00a0 ("net/mlx5: Add traffic class scheduling support for vport QoS")
Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Mark Bloch <mbloch@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
index 41aec07bb6c2..8b4977650183 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
@@ -1122,6 +1122,7 @@ static int mlx5_esw_qos_vport_enable(struct mlx5_vport *vport, enum sched_node_t
 	vport->qos.sched_node = sched_node;
 	err = esw_qos_vport_enable(vport, type, parent, extack);
 	if (err) {
+		__esw_qos_free_node(sched_node);
 		esw_qos_put(esw);
 		vport->qos.sched_node = NULL;
 	}
-- 
2.34.1


