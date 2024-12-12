Return-Path: <linux-rdma+bounces-6491-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD1389EFF15
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Dec 2024 23:15:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2E17188E8EF
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Dec 2024 22:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E57871DE3AC;
	Thu, 12 Dec 2024 22:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YqwL52ep"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2082.outbound.protection.outlook.com [40.107.236.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1824F1DC07D;
	Thu, 12 Dec 2024 22:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734041720; cv=fail; b=A9mGorlVIcdZpZ/oITXqHGiHtcd9TH0tj5OZVphN/KOogf7GmXut8yetTS49rKPTeD0BnQiQHvvgcjOvFAwqWHuJiXe3FMvnvr+Vs12sclDeg636+yXmrc8S+gdNjS9Ahxf8rAV31dPJyQxSOc3uLNl6LtgKtT/Kl2dOUVi78Jo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734041720; c=relaxed/simple;
	bh=QuoaFYSGaFbtkbSHfNXC9MD0DVuUxHraYNoTFCl31Cc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rNFDcpy1Zb7y3t6f6Vh6Dr88ovND0tHMB26enqk1H+jq46FlzPKve4Ytz5XNYG+BbRs1sdfbjU53fYI3NgpNzwGJpz+a2pS/r3qnXlzWP6IoomIPzbq063KRRBFTX2ZkRi24Tu0sxPP1xlWeH9wMPwO8tvKdzQan/hqIfabM3kM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YqwL52ep; arc=fail smtp.client-ip=40.107.236.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nneNzzc5pQcQJsJndMA/yoPh9OY2S3jvyZ/Oj1a/cafOUDMDWWuapdzQA4cZgoL3WYmMKNWAsfv+uvxu9qt6vMN+DMGtFCBa6a4Q4HLlTQjb5xnsVexbknbCXdG+VxHwVw3wdDT2m8jWAoD6Y9czwFnx2KL4x0kigSsXb6YPTEdPzmd/4t5nd1ncwsTtx2/4M03b5TADGY6Ta6v6RYRfk3pCbcJ7gc5yHB4Hi3eOG3SuccMQv3PShxI32yf9JYIxpnWe4MhHH4YZ7QPc1sdc1Zdaj/Yw6KY2sR/JcaLY4rkPRpT1Rp5dhsXnrOcnjRTbqdSWqX/KjWFJZClVoQZo4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vIV64SPZ1OK5vUCGkRIiKnwnmyfhpRfNolt3sdDCQFg=;
 b=rT8vbpHhCi5gRpvfTBA6qUhOC6Pq+VkwUrgLa6IK4g/yDdjkPVZCPqEiMq6+ZrZnFcjhajDcDfMtClyf5DlVv0pXt+qR/LnK9e9etmZdM85/iwgpwz2b5ULJeEfikHPibda7jfrzPmGj2GeUab9SJQ1OrkxqLTgUuesK6q9JhrTL83ov4fxzr40VdrLgz0YZNAAz3uEzrtnf/vF2MyyKg0igiAuL/UxLv1Ku9eGsgPLvqaVUPu7JbHdaZZUBquIE7xzq2Ntfi54J11S8olsVST6l4/q92K6k59jbGYtssb1nioHJSGJG3wi2K2EsTyl27e1HYhqN7s/1+HHebN+tvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vIV64SPZ1OK5vUCGkRIiKnwnmyfhpRfNolt3sdDCQFg=;
 b=YqwL52epcelNUuMZQS38uwJWGtUByIs19AG64izzsKCZjyo9zGjZQokZnZ8LNmUCzUjwClh2YHzeQngTHGADci1cgSbpxg7boDnWAH5OaT6keFGghA+Hw2tIHSDv5m8eL6s0N4vfpvOxi7CfgChldQpf9FMGEY7osj/aewWrs4Zd6Kt3OMWMAuhBFpTVlvrTMAYx6RceHeIKQ3Od7dYE5kZ+WZfx9h0jtAfyqy6OccRMS+I5eGt36Sp4604xwlIpNmRcJQQertuzSltA48BHNcUXxV8pXttf/yh4zcVW3KbbQjXliVnbwiIwrMwtP5x5SHndY/OfeVDVTzZ/sAu0gA==
Received: from BL1PR13CA0137.namprd13.prod.outlook.com (2603:10b6:208:2bb::22)
 by DS0PR12MB9424.namprd12.prod.outlook.com (2603:10b6:8:1b4::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Thu, 12 Dec
 2024 22:15:11 +0000
Received: from BL02EPF0002992D.namprd02.prod.outlook.com
 (2603:10b6:208:2bb:cafe::5f) by BL1PR13CA0137.outlook.office365.com
 (2603:10b6:208:2bb::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.15 via Frontend Transport; Thu,
 12 Dec 2024 22:15:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL02EPF0002992D.mail.protection.outlook.com (10.167.249.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.15 via Frontend Transport; Thu, 12 Dec 2024 22:15:11 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 12 Dec
 2024 14:14:59 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 12 Dec 2024 14:14:58 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 12 Dec 2024 14:14:55 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, Leon Romanovsky <leonro@nvidia.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, <linux-rdma@vger.kernel.org>, Mark Bloch
	<mbloch@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next V2 04/10] net/mlx5: fs, retry insertion to hash table on EBUSY
Date: Fri, 13 Dec 2024 00:13:23 +0200
Message-ID: <20241212221329.961628-5-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241212221329.961628-1-tariqt@nvidia.com>
References: <20241212221329.961628-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0002992D:EE_|DS0PR12MB9424:EE_
X-MS-Office365-Filtering-Correlation-Id: 8337408f-e3c5-4d67-577b-08dd1afa71ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jyZZKVSx5iaS0ECQpbSU+dGQvsyV34y7lwoonk+e8o4u/IKrT0uNWO9v2ZS1?=
 =?us-ascii?Q?Rb/qVR+lXo3MbA91/YetNYtlJ/f8D0F7tIdxDNlV6OWgIoSUeFeTthlSqtv0?=
 =?us-ascii?Q?nTv45wkQFhGogBwfMug3g3aa7bL4XOHhvK9rnnBU7oXgEPsBbntkn/hPTYjE?=
 =?us-ascii?Q?KyV6j6nbwwN9ICAeRAKeu2hDqDY+i5UdxaEa1TZ9feUmwGCW9hrFqWU111fV?=
 =?us-ascii?Q?ykeqk1qJ6USWO8gfuO9R7oezp2HxESYx7FtQBL4H1lCtmylyWLKcHpF9PfAQ?=
 =?us-ascii?Q?r3HUdqoWIiusc/hAJE7Q/ElPSLl+l3MZN6FJUDWLbFUudqleXlgyIP9Ckf4P?=
 =?us-ascii?Q?OFDCLoLFvFp7GI5ru4TNpQRAK11382AszdfgKED/LgfY2ZPh527NsnV96jtA?=
 =?us-ascii?Q?q38pcZ6WdILfwo2X6xraDkezgajeIZJmDUZXoD5ZVCb22cgJDwNMCoVELQYl?=
 =?us-ascii?Q?AvLzlxU7JIolgvHZcLS7ppfW4KIJT3PJYuftTeYymQUzpnWkjSmiOWPx1vWG?=
 =?us-ascii?Q?GNqlt2LkFJw/U0BfWn8jWqs2Qj57yYykSdUSNyNvNmwgdDbbv3Rf5yT/oNPf?=
 =?us-ascii?Q?N8ABQprCRXMU7zs3GqdkNEm2FLySlDJ62G5BGkyu5YIMIOoWYST4hBTmMZjU?=
 =?us-ascii?Q?xccv2lHNs5TraO/cvgfDfCvj5kgwPhZAxFoAgaeUmjP+LzWDN/WuSUhXqXUW?=
 =?us-ascii?Q?z97Fys2qVAIn9LN0laCRY1ToIMJxurWM/kfe8ZvpCdtFqWAxZNsDFoH35lej?=
 =?us-ascii?Q?Z11dtZzSS/1SObhwT2bWBRuJ+W43kyrj6Icurk+O0c4H7D1iqBCIjGndP9vZ?=
 =?us-ascii?Q?rOdwjfPvS493yLAQvPXR953CFIcA9W9Fzseq1PgjX5IxwQ0tM6MJCj/xw2Ba?=
 =?us-ascii?Q?7KCLAK3ikdyo/CxQQV87r8v/MotozxJVLs62I5t/4w9qvv/PAJTAj23SHv+c?=
 =?us-ascii?Q?fd4tmR7wSnntFR7Hc/pBU+b4K53SYDyj3dYLB3aONJPKBZmanMkQBVHEyv1C?=
 =?us-ascii?Q?QehcCqy8ZN2EPHD/gArRMdLmdYevzQBEw1WEq7Fm1MWVLtBnWFW+dyTWa3OR?=
 =?us-ascii?Q?jeNc3Gh8ldMDDldp6bgJ6NaC/jdQ+dhc7Osm3GyBFzBQ9kJDp8fep05EgmlO?=
 =?us-ascii?Q?qWwXWH4IPRCjxiMYfdzkKBn+L7V37Ix6tFhTmGi2rQuvZZzdmsy2dc1PvPjN?=
 =?us-ascii?Q?qqUDZYdDm/5rkaxHuxc9DJh2x21Vep6yrd+TCeFK/3f1/esb9PxLaN4cgS8G?=
 =?us-ascii?Q?YeilCzDS7QuoAsfUASCjqmwyWryGLEV7XmP9X5B+H9595BDZ35oZx/BmkfGv?=
 =?us-ascii?Q?wfterXsGPqR60yVHt+RLP1jYpob7m5Xw2OBPhVJONOpopVOO4c09TrJsadMZ?=
 =?us-ascii?Q?9ZY1tRKRrScYEOKqsXyp9FGKxWriZTLXu8+2lYd+eHDQvq02/N8EFIDPD0Qu?=
 =?us-ascii?Q?ADGXRoyWjKP04YCbUsbW365fNoH5Gv6I?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2024 22:15:11.0063
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8337408f-e3c5-4d67-577b-08dd1afa71ec
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0002992D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9424

From: Mark Bloch <mbloch@nvidia.com>

When inserting into an rhashtable faster than it can grow, an -EBUSY error
may be encountered. Modify the insertion logic to retry on -EBUSY until
either a successful insertion or a genuine error is returned.

Signed-off-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
index 2eabfcc247c6..1eb2c5ff367d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
@@ -820,11 +820,17 @@ static int insert_fte(struct mlx5_flow_group *fg, struct fs_fte *fte)
 		return index;
 
 	fte->index = index + fg->start_index;
+retry_insert:
 	ret = rhashtable_insert_fast(&fg->ftes_hash,
 				     &fte->hash,
 				     rhash_fte);
-	if (ret)
+	if (ret) {
+		if (ret == -EBUSY) {
+			cond_resched();
+			goto retry_insert;
+		}
 		goto err_ida_remove;
+	}
 
 	tree_add_node(&fte->node, &fg->node);
 	list_add_tail(&fte->node.list, &fg->node.children);
-- 
2.44.0


