Return-Path: <linux-rdma+bounces-12714-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B82A5B24C09
	for <lists+linux-rdma@lfdr.de>; Wed, 13 Aug 2025 16:36:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D57088392D
	for <lists+linux-rdma@lfdr.de>; Wed, 13 Aug 2025 14:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5F782FAC04;
	Wed, 13 Aug 2025 14:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XzHkgja2"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2069.outbound.protection.outlook.com [40.107.93.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF4E2F49EF;
	Wed, 13 Aug 2025 14:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755095533; cv=fail; b=i6+w43fG6ZeQ11hlJtHVKOA81iNHrv185DFKIPyCtWEAkb+APm8rfXWuZ53oa79trRpK/CPpmNvJd2sa7fXs2qaqPoI5MVPO8CAsWhoyktkvBLIadXz8nOAcXXXeiGir1jR8lP51udbeQdXIqOzzK16GjItPzyuo/aa4nYQBlDs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755095533; c=relaxed/simple;
	bh=PtbRRw2C2HoinmwVI6t7kMnwEy8D2AuiZzlT8FtvzM0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FhPf870wVBfhQtxxPcrrWmrqjtlmwM8nWHAeuf9ZVmqHvQD6esf9caUb0ziwj9COguPkIwtYtxIyngj4/FXnBtLSB0Y7G34WlAu7RZ444sC/fGn+BbwtQBUD4MCi8DVWI/1pMVVkmE/8CZHrwRlRXN4V8jXI0hfrDKu5/kYfMr8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XzHkgja2; arc=fail smtp.client-ip=40.107.93.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dNRLclS2jRUSnwB1LYhrKSRS/blrjgfdtChJepuoImEb04UH11JdPqZt2Jnyqpu2uGgcoGnD5f5e2NIHjIMm0CSr9KWQHZR4updfAXnrVgFGiZy+zCxjxoJKm0Z7o9VRAMnuy49vQ7UnHYATA0szvdkYQ4ywokSteJOPYWHZX6sMzas1YWicQvbnNlpShqQm2A2qijFS6SOcND2+ZXbndL8Z/EbZf3TUDQOg5pGLn80LQ+qW44ZlSOs/NCa5H0snO+da0ymViWrCZZGp6PuxGb0HVUofIvG6PrSMTi1S2fLXjBikFcYN37EQVyZbfJAim3eG2gCXsH6Qv2XxwEjMXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g8xtoniXDLN6EaU1hL9d0pN8jBkQE73KaWN8OH8PiGg=;
 b=ebcY0NVGVsGPekLApA8i8Y1Cq+Ao8C1X4P48W79/VwuPxeQvp41FmJQ8CNKT4FCMiIyS4NDcTYYHZF6k2Ppua57Iv4dxILqD2qRHhttjy0ZZEy2ORoJGC2jtwaZYHFYsPV/6LUCZnawys/t1h8HyYiE/fahMEF0jhj1E/jU2iLWbCcMyJydWu+DOfFdxvVo6kya+Elafy7PC71Q6/+YnerP8jqmO303zLnuUd5qG/DfOHHOSsmnu+AJDXS6NnP/nbUn9CIQhTPjeAoKz3VGwcsCufQeo7xT916EnyYpQD2lWYhVgIaoXvE5s4BxCX2lUmBVweVqioP8rwpOXGEMQOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g8xtoniXDLN6EaU1hL9d0pN8jBkQE73KaWN8OH8PiGg=;
 b=XzHkgja2jH8A+I+CNaKY+bM+PVTsBkwnmrp/+gZP0E3molk/PJFnqwraVtlGRZ2+b4t64aJuQKFCsnBB1pn1/6sDbNPs24CfVmEsERyH20zaXE0XpPHJi/G+pFyq1VZ0ZyWBbcPHNRjFetmEtzQztVycmouN7xjMtLTkgSOQW844xI4hHoognlcMhvE92/chmIGO/s5Uaqji7KA+fFYKTARafaksG1hMFJVdpkWsY6UdWlqldt0xH9e0j0pRvmuAEEsxNEdRPtLWWEzy1I8jpHj0zOADliPC2yI5BlQ+6b4PuXYWfwGU9/nX+en+VwuppZMrAd9YmXy3C8VkOfONyA==
Received: from SA0PR11CA0038.namprd11.prod.outlook.com (2603:10b6:806:d0::13)
 by DS0PR12MB9398.namprd12.prod.outlook.com (2603:10b6:8:1b3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Wed, 13 Aug
 2025 14:32:09 +0000
Received: from SN1PEPF00026369.namprd02.prod.outlook.com
 (2603:10b6:806:d0:cafe::a1) by SA0PR11CA0038.outlook.office365.com
 (2603:10b6:806:d0::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.15 via Frontend Transport; Wed,
 13 Aug 2025 14:32:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SN1PEPF00026369.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.11 via Frontend Transport; Wed, 13 Aug 2025 14:32:09 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 13 Aug
 2025 07:31:52 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 13 Aug 2025 07:31:51 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Wed, 13 Aug 2025 07:31:48 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>
Subject: [PATCH net 3/6] net/mlx5: Restore missing scheduling node cleanup on vport enable failure
Date: Wed, 13 Aug 2025 17:31:13 +0300
Message-ID: <1755095476-414026-4-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1755095476-414026-1-git-send-email-tariqt@nvidia.com>
References: <1755095476-414026-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00026369:EE_|DS0PR12MB9398:EE_
X-MS-Office365-Filtering-Correlation-Id: 163b0d40-ce37-4cb6-6341-08ddda762f69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sn8WQgNFTkART1zhZirDTQLb2j7/pKWxf6e6VyAQ5C+HvuDJcq9/WmuyZRAK?=
 =?us-ascii?Q?kibmmPUKIbcrICQlWtRmbrEJUpVAVfc1j+BQtjybLjopp2O1dwveiJz9nA0R?=
 =?us-ascii?Q?UG/kBTtov+EqbkDA+qMbLBzHgCdTC57jjLXj+C6qlnRYlS56Ceuf2z7IMX+A?=
 =?us-ascii?Q?ZYiBX5MEvxpP6HoCjLxWp4ZYXBbOx1V0Op3RW2PeEZK14b/GMx6cQnQNu1kT?=
 =?us-ascii?Q?FdOG7MCSQnvXAZbgKghAJpbVg8YZugbBrq8kgdpBy9EGB+MMYX5ZeNVoQbAK?=
 =?us-ascii?Q?psm+OAHwp0zrMOuM0s4ydU9TfOBkY7G5TOx6KeBmiPaJ0nJihGn1ypJ+XpyS?=
 =?us-ascii?Q?Cy9CCdWAyLu5dkyoquROSktMcfjq+Zfh6WsK5udvGU7GAtYukcU7l22pPNK9?=
 =?us-ascii?Q?jXOrUS9iNp9ChZbR27DGcFjjnMk4EQpvc1i0WzA5EQ6Obj9nDu7YYthcnL0r?=
 =?us-ascii?Q?bB0fLa9bEWIF5QBXVOpyS3zaUOOmvVlCB2rzwftl4+pHmGaOXM4XIHa8txUz?=
 =?us-ascii?Q?NGyv/hv4shf9zXxgyDlOYDAouzXYo5aBQX1enCK5UA69cKHAJduzYW8DiNZd?=
 =?us-ascii?Q?UmbW5WkmSR5Xg/PauOcV9uQ+TTg5Fz0Y3I75AVBOLagWKMzLvGzSdt6AQsIk?=
 =?us-ascii?Q?qOTssQ6k0jVnHE6N1rg0/uMyWTw1jhPHcQoHyfgzHZla0oMLvFD7Z5K13lx0?=
 =?us-ascii?Q?dOq6/8UiZDtzPxVWlkSv1wBvRQrflp3Ddx1nqrWqsTc2FlS8CwPKdrz6yECX?=
 =?us-ascii?Q?3byxkZyPc8IpFszcfJNIQmyfQWrHlEoo5y53oRtGBZFqMqnE2duF8381aOnp?=
 =?us-ascii?Q?wKIi3Svy/JiYdkgRTRevSP8BHjQ44GsBUM55gclnRSL4na9PsXM+emdBdrmx?=
 =?us-ascii?Q?DKkEgS8OdnOowoHNW8rFTN3cggPTMo9f3uTAbSwK+LD2jd/sENoDwOthXTHQ?=
 =?us-ascii?Q?vKjH+Mg1Lql6LoFrwlQAGJFl4xuTGAzDpdSm0unSRh2O3eNUpI7/f7z4SYxk?=
 =?us-ascii?Q?NgVGgm4hoqR0iXH721lMgAedXPTwZr0N11PLFDxB6hvFGvs+s9h8wbc1W5Id?=
 =?us-ascii?Q?+6laLtRz7FznHIr5K/39mSpjM0LNwqShQWjfIOQh4pldNsdRjanzLp+cHxZX?=
 =?us-ascii?Q?hD0BibenkcA5RM58f7eJxn/MFQ8vEkWSwEpbZMXPi0uJq5x+fgxkv2CU6FIB?=
 =?us-ascii?Q?FqP2wbO4vkR/E1SglsrwFFvrSP4I2RS0lGj+q9v6PhVZyU4NCtjNWfBq3mTM?=
 =?us-ascii?Q?db/02YKZ2VyhWbQMxmzJ8bnCGqLwN04zy0PDO/L6AsEvi4WxrSvII2ntKOZ4?=
 =?us-ascii?Q?blGetUgAP85q08IIYz496MaIuUWJ56i/L2H53XU/OXtLA49CWDc9fKi9OgoH?=
 =?us-ascii?Q?Vz8x+FVAwWwQSrgAYD25QYb9n72GL3rHoUbtZLd0bvmkb55P9Hnqm9gehP71?=
 =?us-ascii?Q?V7ryUAAG+BKxow+G7XyzfoNjnmEi6CW3f5jmNVhvr6t3J09qW34UqCb8YopL?=
 =?us-ascii?Q?eUMoxIg6IjcHe11rk7SO7/Et+jTL9pS1iBwE?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 14:32:09.1627
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 163b0d40-ce37-4cb6-6341-08ddda762f69
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00026369.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9398

From: Carolina Jubran <cjubran@nvidia.com>

Restore the __esw_qos_free_node() call removed by the offending commit.

Fixes: 97733d1e00a0 ("net/mlx5: Add traffic class scheduling support for vport QoS")
Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
index 79d6add402d7..1dc98e4065af 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
@@ -1152,6 +1152,7 @@ static int mlx5_esw_qos_vport_enable(struct mlx5_vport *vport, enum sched_node_t
 	vport->qos.sched_node = sched_node;
 	err = esw_qos_vport_enable(vport, type, parent, extack);
 	if (err) {
+		__esw_qos_free_node(sched_node);
 		esw_qos_put(esw);
 		vport->qos.sched_node = NULL;
 	}
-- 
2.31.1


