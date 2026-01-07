Return-Path: <linux-rdma+bounces-15341-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F357CFCE0E
	for <lists+linux-rdma@lfdr.de>; Wed, 07 Jan 2026 10:34:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0F49A3053F89
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Jan 2026 09:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82C562FFF94;
	Wed,  7 Jan 2026 09:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="G8zdGF+/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011059.outbound.protection.outlook.com [52.101.52.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9786A2FFDE3;
	Wed,  7 Jan 2026 09:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767777569; cv=fail; b=HUjVGkrU8/uSuNT/9Yh0tD3VIfzlGAi6lr/3h5+WqVkSkv/qVKftnNMf7Cgf6dp2BeDYbml0GW787d3mf16orXrcB/4bbQW6565TrBfPQjt2qqy5brWSnCldQVJeSc2cV01oaludveODBERIOd7DYlNVo4UiULlmM2Thjf3d0A8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767777569; c=relaxed/simple;
	bh=vEiA2RblQRPAmNdzhNiYnCAjTSA/GTfiW7Rdhon1pLs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TBKksf6ce35Qa4+JzFaay1sBsV6bFxDG05TdrdS2CIKFEXFHZgVKI6D5lY0iJI4woNsNtgQeL8QePe3NfN2a5LHBeYLwunJ2O5WjC+XIbc+R5AufK11TerzwtT+PPsamEJwd3zi0e5RiVFEJx+iUDRAUCJ82I+S22/+eN/qTnKE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=G8zdGF+/; arc=fail smtp.client-ip=52.101.52.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g2rgxraK7HF2OqQhCbqiujJIgpWHOn9IRd2eag3TSt3NpdE2Q3MgyHWsO0Dx/RpxbbyXp7QQAnc5bJxURMpE8nZEeWztqmqJcLR1vqYYmYc3axqRJmjx+BEL6U7WU6DCwv7gUqeRz3SPl9y9CDqLzHw7sXOHTg2Je7G0eM+poAR8aKxuYaTfegh2KntYdqCjo2P09zJqLjgzQpSxAYQwoPS8rwJSXGc9RUzeZKxN+B+12XrVIGfLpGAjWux+e5QjSQ7+ibVjQtD2KIqtPgHbuqV5/s0ZGNCkCisBikhK5Bf1eawqxyiqXT1nsYbRL6VpUHn3fx9wShAle9QDHcYciw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7De9wH+N3h17aDfpP8JSYtMnm42uxiCwZoE15nbnuQw=;
 b=GX1Br52ohBrm0jdstCAUMq7sPHifHHtXu/hmz04QpWSzIpRXdfznmDwLq9DcgD1IchGb10lE89Gb7AOLqGjeKN0kFRs5jN+AyCvgi5t1K7feLAIAMz8mGhE/eN84Y4F6qMn/OiD5SA6XZ2YeLN/50+stm6bzZrDbTcJhWJxItd4gwAxdHLt6SQC/mWLD7pLLbS+L+hgZ1XRS5NNo+nMdmDicJ5VaLpag7r8ET1GPrsrqN4z4Tbus7bSL3RjgwU+znfF+HY5XrxfHMk2bThhYiYvEYSmuCfMrof0FwC3K2KEC0M0ePQEZskq4wREw16PY3IIX4f+2lfeexBNwhPFWTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7De9wH+N3h17aDfpP8JSYtMnm42uxiCwZoE15nbnuQw=;
 b=G8zdGF+/zUyI8DyZbj5C1/4zPGryf9cArZbFv7ysp/pDlG1zWfITJ6Fsu9oy9POZtQ5y6zw2WvGMd4n1Fb9hg5Vb+yAbFW5H8LjAveZuoShjRfaCyiQlQMvuZsI/gMMG/AvEsHImylKEz0KbEe0cVKRCX+xQk0ZcYg3NjXP7M8hqtbbY87Xzm+aOFMGy90l01wK8S0QlZnaBOIW4n52jaZo93QW9YOGAU+kDKP9PaFyV48LXx78eGER5lPjY1RQgRRSRRCowNu8T87DmquiLDAtG7ihheB3xUbR3QCp8EUL4HCzpMqyuQ9Vt7sLolWhkiW/lI8TQf55FhTK+sVYHdg==
Received: from SJ0PR05CA0205.namprd05.prod.outlook.com (2603:10b6:a03:330::30)
 by DS0PR12MB9059.namprd12.prod.outlook.com (2603:10b6:8:c5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Wed, 7 Jan
 2026 09:19:23 +0000
Received: from CO1PEPF000042AD.namprd03.prod.outlook.com
 (2603:10b6:a03:330:cafe::c5) by SJ0PR05CA0205.outlook.office365.com
 (2603:10b6:a03:330::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.1 via Frontend Transport; Wed, 7
 Jan 2026 09:19:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CO1PEPF000042AD.mail.protection.outlook.com (10.167.243.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.1 via Frontend Transport; Wed, 7 Jan 2026 09:19:23 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 7 Jan
 2026 01:19:07 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 7 Jan 2026 01:19:06 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 7 Jan 2026 01:19:03 -0800
From: Mark Bloch <mbloch@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
	"Mark Bloch" <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>
Subject: [PATCH net-next 3/3] net/mlx5e: Remove GSO_PARTIAL for non _CSUM GRE
Date: Wed, 7 Jan 2026 11:18:48 +0200
Message-ID: <20260107091848.621884-4-mbloch@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260107091848.621884-1-mbloch@nvidia.com>
References: <20260107091848.621884-1-mbloch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AD:EE_|DS0PR12MB9059:EE_
X-MS-Office365-Filtering-Correlation-Id: 114b3f2f-0fa3-4741-cdcf-08de4dcdd8cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1iwh9KjIdUS7KKay7689m64pvXkWAyirRvSqoXqafh86cyMhyXrC9Hz4vxJH?=
 =?us-ascii?Q?wNzCFQDdzCFdjUZIA3XIIfljnAHay4eZyd5ig2UM48If4rKlc8YL1V7pHSLN?=
 =?us-ascii?Q?QcIPdAS+iX/H2FRRcDarssr8uiqA/5Arj5s0iya7xFLt8yx8FQJOUvsMNgju?=
 =?us-ascii?Q?xKREqi0oUpFdUUAZNj9HK8R43Hzcnr//fFXWewP+M0LKwnnwIvgrKCBPhW9X?=
 =?us-ascii?Q?2u/p02zQSiJz9siRlbWRsP3s/zu3XkDmTPHWsWJ8x9LFULuQyJkDwCUHlnWM?=
 =?us-ascii?Q?NSImysP+DXKnVzV7ThDyk4tkpXvIYWNMFFY5t+ymfhp1Zcsf9u9AeJwBxQkd?=
 =?us-ascii?Q?un6+/3kKHaG6k92y92zJK9Tv63kUiQxKA9dHR3bdFMVz5o4blkZ7/T8TcP+l?=
 =?us-ascii?Q?7ypw9cB54iN0C/RvOUYFumdQo9Zp0MFErs2tFtxZv6j9+o03uINQ+K7zuXdJ?=
 =?us-ascii?Q?+zES3eXgG5WmFG9MVL2VXMKscNsyG80yqDIwIVuWZJpZCVKubDS/TcrZg0xT?=
 =?us-ascii?Q?xLts/HQuwjXM1r1dMOCgSrMX3+3lJngn5cZO3XwaZRkR9zY0fsYEvQOiQeRB?=
 =?us-ascii?Q?DXeXFx9fqBeT5TUtGUC7y1K1JqJ86w7ey7xYWavxoaWAGsD/axfudHbLd1wG?=
 =?us-ascii?Q?/U+Jtr4cvt9OEa5TjcxwLfVI2SOt96kGSlR3IHqzF/y0hmhGzrm4R7SUvZbc?=
 =?us-ascii?Q?B0jyvL1Aw+Doe6Nlkg87PEFmU/DwvFYncwOGsAs/xmdYjGPxXvbr4zrvN65K?=
 =?us-ascii?Q?upsIlr1qnrb+om61haFalB+KtptE1OrpWitoV3dP05O8CH4qsOYxelPGhzcO?=
 =?us-ascii?Q?G/R37eU0bhuKuPbKIeYC5DrqukCb4BW5JUon9xDrY5vEIMEcDj7CbNoT1lIa?=
 =?us-ascii?Q?7XGuwaCol1uhSXlFJGRHqR0biQgxJ+vmf7YrnN78Brz/yJ0zwMg9N5AS1Jhj?=
 =?us-ascii?Q?CEMemo4ORJbZPdh+lTpxisM7rclhjXjK26ri6XIdvBYlgEVVCATOaoOnw9PO?=
 =?us-ascii?Q?wErIIaVRjeCfCPrQcv9o+zbuFJP+VKsrTsvSmKko2I1bHNZRlXeeemSrUlsD?=
 =?us-ascii?Q?vDqKDzG/qIIqL8kki4iyKh5Dn5zHw4lf1eXY15QphlyT/eCBMgfDxbLj3PxB?=
 =?us-ascii?Q?z5MyC/ipXCkt0g1phbcrklHbZnnPCeuN2KGVC6Wj4OCnaORy7BbBOAtRPAqQ?=
 =?us-ascii?Q?0MH7bITiL7NIilpm5vvuEbYFZYxL3OUNKpfl3vqj0R6SaBXN2U0Nhk9RHqLc?=
 =?us-ascii?Q?PM83OobOjVCJD5NkU3I0LqynAkVJ0FvGjoTSdeJN5xueliMq/Kpx9KMa3zH1?=
 =?us-ascii?Q?6o5NMERc9eUyjsnnlzNgMJe4yWB/PCH/BLUj1+8tKy6MvIX5VRKb+GrWN3Ib?=
 =?us-ascii?Q?iCuo+5jGGIxFGS+bn8+IcHJ0TVu7rx9hEisdmN9CgJipAwNH13L70nLspBDV?=
 =?us-ascii?Q?+kCzfAXBkIZNKCjsYQAdt+xE7RI3B9B73urIEYK2yvdZTiTBXl8yfkAih7Nl?=
 =?us-ascii?Q?6s7fQEiZIhdpUPXcKxbodTqd3phd/uzsskIIYUKRypkKQKl7FBNqg+O8n7BI?=
 =?us-ascii?Q?FRUqZv2yaffSk1xibwM=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2026 09:19:23.3183
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 114b3f2f-0fa3-4741-cdcf-08de4dcdd8cb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042AD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9059

From: Gal Pressman <gal@nvidia.com>

The hardware can do TSO for GRE packets without an outer checksum, it
doesn't need GSO_PARTIAL's help.

Signed-off-by: Gal Pressman <gal@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Mark Bloch <mbloch@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index ce71a03a9b71..3ac47df83ac8 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -5798,8 +5798,7 @@ static void mlx5e_build_nic_netdev(struct net_device *netdev)
 					   NETIF_F_GSO_GRE_CSUM;
 		netdev->hw_enc_features |= NETIF_F_GSO_GRE |
 					   NETIF_F_GSO_GRE_CSUM;
-		netdev->gso_partial_features |= NETIF_F_GSO_GRE |
-						NETIF_F_GSO_GRE_CSUM;
+		netdev->gso_partial_features |= NETIF_F_GSO_GRE_CSUM;
 		netdev->vlan_features |= NETIF_F_GSO_GRE | NETIF_F_GSO_GRE_CSUM;
 	}
 
-- 
2.34.1


