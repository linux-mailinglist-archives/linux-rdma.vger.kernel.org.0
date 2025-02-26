Return-Path: <linux-rdma+bounces-8139-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52D53A45EF3
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Feb 2025 13:28:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A0F916500D
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Feb 2025 12:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D8042206BA;
	Wed, 26 Feb 2025 12:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jxMrZl06"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2047.outbound.protection.outlook.com [40.107.94.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1A71DF990;
	Wed, 26 Feb 2025 12:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740572819; cv=fail; b=ocnSILg3O6K3413M9yciZr+8bLZ9IJtpJKAZc/Y5dZSaxb6qFML9XLGY0x65U2lLq9obpi/MSTDSim/amevGIk+GQ0Q/eydCxBS6OHVVppZRYHDWgktz1JS1F7WDjttZnlLAyaiZBOjHzYVmKl59sRTt47SEYE74j554oEgjutE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740572819; c=relaxed/simple;
	bh=9Lz+ApN5fnMXNogXCrvKMmY2mNKJA9gsI1XmqQychwM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VDQZrCQtXCQjI6UWiaMpbFZN1Ss5laaesHT9vZjx1J7raR7Lz1Xbc2gYi/e29O326WCWZLjlQkoAOnKfdMf2J/EmQBxMdreVZ4WlKFoU/veL9ilBJQkdvCGisVbcT6dAk0vK3r9HsJVr8HP7PEtomTTuwpK8awlG1KfcR+PjwhM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jxMrZl06; arc=fail smtp.client-ip=40.107.94.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PDYWXNXboWlF4DPCVkptG9bPQVOLjHbsrwTflCU8GuEdvuqq89Dk+C/tsGo98fVR16+fRQ/UQQBsvYGHoV875OjnX0EHFeS6nMRvpkH60Z03K/BFGvRMnbC2apvfnKMIpOi73r7Hhsy7qBURVLOR/by97AfSvY8uC5wgyK0TcUoyLzGo7Szuq8W3QRRNVzoho4EV+DDiNVR+uJ1aMhDEfCnDEA086/gvUPhfkvOaUJE+tUxpZccRmu+Jchei3p5/w2krWu+wj5Zf/VahVUo51UHf9cZpYgpbogOSJQrUfXLgWf+d/FCXC4ZVNppdrW66c+U3BQh4yg4RXMgSm1tu4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZlpiU/fFnaXwabi/mDKGM/p+l8Y7ZAiSa3gYfh22CN8=;
 b=Snmz1h1u1uIVXWMry9UYnOppjcZi3p0KIbkMUKa6v3fhdFg24MM87mNdsuT/F/lUJ7cuZDHoCncd7N/RDnamQ2HJiAJ86S8GPCJPoJzHPwf2afIWHOj8ItRVgbnzzj/xg+bJmBsvZu6c0sjvATodR4sActwK9DhXVCD9quS+B+TEDHmQFtEbC04zo7NTIojEDJU2955s2QntSGEogcz1vj4tvNMDW5yvAEzgSxLMkFLG/ppJ/B+UpkYbcOnOsoChkGYQuQZDu+IsYtLLMiB5Ik6hzA7xsjesGLblryyV1auM4f3dMbd1Is7zGzsxGtWIgb4S/WAy2FGWRkHpyOzi+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZlpiU/fFnaXwabi/mDKGM/p+l8Y7ZAiSa3gYfh22CN8=;
 b=jxMrZl06+E/SmtRXWsLbgf/fklmjr6j0wgg7iFbJZX8lxn7ATTBDj4MuFcxhf0xwEuC1xeQq7+08YYWwDUCz8/ln96hC0yhDBQDSPHTXgG+tNIIea0o/GHSBoBY6qBYx30rGd48GxbvOdQEpSqQlfr640kaeYOVxSP1QnjQL3BLti22otssZzvzPDif8A4uNNH2DjLEYnCx3hSKmAEhHr1yfehjr8zPRukwBUXx/NdFYfsz3ZQrM6CT+u19wso+Ml52w/I5P14nfEMHLGbdZ1jsuC7cqZ+yFbTeY+jGFGhErZkn3uak1/x01b3qx3QH4tRCgmSTzpf66opQ0XbD0Dg==
Received: from CH0PR04CA0113.namprd04.prod.outlook.com (2603:10b6:610:75::28)
 by PH7PR12MB8123.namprd12.prod.outlook.com (2603:10b6:510:2bb::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Wed, 26 Feb
 2025 12:26:54 +0000
Received: from CH1PEPF0000A346.namprd04.prod.outlook.com
 (2603:10b6:610:75:cafe::15) by CH0PR04CA0113.outlook.office365.com
 (2603:10b6:610:75::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.19 via Frontend Transport; Wed,
 26 Feb 2025 12:26:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CH1PEPF0000A346.mail.protection.outlook.com (10.167.244.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.16 via Frontend Transport; Wed, 26 Feb 2025 12:26:53 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 26 Feb
 2025 04:26:50 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 26 Feb 2025 04:26:49 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Wed, 26 Feb 2025 04:26:46 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman <gal@nvidia.com>, "Leon
 Romanovsky" <leonro@nvidia.com>, Leon Romanovsky <leon@kernel.org>, "Tariq
 Toukan" <tariqt@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Shahar Shitrit
	<shshitrit@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>
Subject: [PATCH net-next 4/4] net/mlx5: Add trust lockdown error to health syndrome print function
Date: Wed, 26 Feb 2025 14:25:43 +0200
Message-ID: <20250226122543.147594-5-tariqt@nvidia.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250226122543.147594-1-tariqt@nvidia.com>
References: <20250226122543.147594-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A346:EE_|PH7PR12MB8123:EE_
X-MS-Office365-Filtering-Correlation-Id: 928192b0-84aa-4c97-00cc-08dd5660da80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?J8l4giUrdnD8HGiNObwkYksJr07KAJkZt6QhQnl8XuB3KDQohcQ9ToOy3iLE?=
 =?us-ascii?Q?xtSnwyfGGxnUlRt7O4B6QIfgNgSw3JHzPOtzWgzOOLTHVF+u3r0DiLarWlGl?=
 =?us-ascii?Q?Pki2vVoMG8H6WgVOLXbJZKR9LZuLTJ2td6AR7Oq7qtqpGxfurFeJlMjCBnFk?=
 =?us-ascii?Q?Uo9DE7ZfUuQ3rjdGqe2WJhx4GnOZDsgjtWM4pbug3GVqZ2TVj0Hqo6RvW8Xj?=
 =?us-ascii?Q?6D6exotDdZx2eiRQs+Ss8xOsjTC+WIdgzXtFuw6s3fdigVV3zT+nT+2BkEGf?=
 =?us-ascii?Q?fnbq3U63l5tczUlmsg5jcpZBZkyj1xTkqlwFmuZSlGZbqih5zwaYPYiJSfLT?=
 =?us-ascii?Q?0Ow9kiwxzRxiD9M2AxpO15hr3mv2wSgyXnG/QHMYB8/0xIye9B1EbU/1ggzi?=
 =?us-ascii?Q?9tICZVEBqim58kbkCwgdT8oUmhBqVbFHk8qLcgjU8gtJUZDc1S6AMCExh4Ed?=
 =?us-ascii?Q?vRJImskCiBjTIFSDm7FNQBpS3VchBnEr5a0wAhNyJL7Qx8FmGjZwfULkauLd?=
 =?us-ascii?Q?Xm/bF6yFT/0POxlCufIbxgSh0s+3kh8O4JXmqdrii2FNzbShuOHv00lET2Ui?=
 =?us-ascii?Q?/nRUqgxuXZB82cdPn9MbsCtQIDiiEOTk/6tDp3uATxKVZ3sjfIB8DZDaD9OB?=
 =?us-ascii?Q?hcq4vOWQmzCvPz7T/VL5qG8a89zE3AOvsoqV5U8H+aG7xTXCQkK+hfP8eQ6Z?=
 =?us-ascii?Q?94vwYngKx276kxSLhcGoMutuBzMsWQ8Fu/80OMbOFwQFV/SBWPW04lJpYgk4?=
 =?us-ascii?Q?j9HyX4ebCyNOP5VFN8bbVktXiOXVGBHdcu9UFE8TKT0qKkQLW3iYVKuml7PY?=
 =?us-ascii?Q?J+947Vsu0sQ3+wWWQtsPYmhq9LbNZM3H0EmqLJZIMAGVsrRXgUiYscNpI5og?=
 =?us-ascii?Q?sN76+b2FFc8IMeo2+BNxBjAAQJScTdRO3eET9IVpCLG0qCOV+WxqhSfgoJZb?=
 =?us-ascii?Q?hR3itiO0repLj9jDPyzEZvblT/J8XO5xq4HfgZLC82xs5F8hW8e487UL4NiJ?=
 =?us-ascii?Q?tP54HU/AB4vjuWgqXvV8cl5nakQcr9wuaOjKoweWcZ1I1UO2MStW69deCBay?=
 =?us-ascii?Q?MFlhzGw2Ror0Z1vQ/LP/rDhHbNtKkV9QpbLQmdkDIN2yx0OmVFKznn9cQ3qu?=
 =?us-ascii?Q?gwATKSy5jVnKzawIoyeOn4NjDPDywZXGb1r77TttXwEH9AOM4iipvtskj1rn?=
 =?us-ascii?Q?oMOLAdWEiOL2AUvvsRsxP3ZsW4wCBwpII38atCwzRv/G7xOplPbfbEe5VT7U?=
 =?us-ascii?Q?hLCZn3WudPx9/Mduc19GxFkWXeFw7icUsTY6UJFiGb1uMhzKzmm9+DY5uNfw?=
 =?us-ascii?Q?HzpnCDW5+c97nEfZYumbSbKxH25m3d7jxXBCraRK9GtnCZAg7jWUZnn5xpTh?=
 =?us-ascii?Q?jj3LVT1qnE6TQyG27WWiXfe6YLw4b9xdLD9GDkE4umlOLaCrf1nSbKiGM1Vf?=
 =?us-ascii?Q?iPwAEuBf+OGrtijsr98RyjLru6Pad5zTYU0rNvPdrwE3RO1Rol3ZcONVdCeR?=
 =?us-ascii?Q?JvjTGCHFiy73Noo=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 12:26:53.7743
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 928192b0-84aa-4c97-00cc-08dd5660da80
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A346.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8123

From: Shahar Shitrit <shshitrit@nvidia.com>

Add the new health syndrome value to hsynd_str() function
to indicate that the device got a trust lockdown fault.

Signed-off-by: Shahar Shitrit <shshitrit@nvidia.com>
Reviewed-by: Moshe Shemesh <moshe@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/health.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/health.c b/drivers/net/ethernet/mellanox/mlx5/core/health.c
index c7ff646e0865..91613d5a36cd 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/health.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/health.c
@@ -380,6 +380,8 @@ static const char *hsynd_str(u8 synd)
 		return "High temperature";
 	case MLX5_INITIAL_SEG_HEALTH_SYNDROME_ICM_PCI_POISONED_ERR:
 		return "ICM fetch PCI data poisoned error";
+	case MLX5_INITIAL_SEG_HEALTH_SYNDROME_TRUST_LOCKDOWN_ERR:
+		return "Trust lockdown error";
 	default:
 		return "unrecognized error";
 	}
-- 
2.45.0


