Return-Path: <linux-rdma+bounces-15446-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2426BD11751
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Jan 2026 10:19:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C03A7309FD06
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Jan 2026 09:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BDB3345722;
	Mon, 12 Jan 2026 09:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Wa1vEpDB"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010052.outbound.protection.outlook.com [52.101.56.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 666A1339855;
	Mon, 12 Jan 2026 09:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768209482; cv=fail; b=pUx+jAFf7K7Be9Vg5Hc0X7jI9RU7xXsjh3YPn/PZUfuIVj9Ufk3BvbrDdnlyThk/vwo5eG+zgFO7QqtWmFbkQRtDSOtV0LDPxCbwEVzSr2CkJ/zTzm7ls+4wao/W8orqulxztoANiIMuTyXNWVSYTqNDkf+VnKAGvJpQGDkQbKQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768209482; c=relaxed/simple;
	bh=eFPhaPUK124apg02FdJaZTUIx0psMyiYF47np6imuoA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OY6FDSPeUhK5ic6gG89AxgnEy9GOVFPRMGvXAUvpFvECgZNbRMESQO54PLBPPd5oDXBd5Yt5aIhow8SoNSxoTrOku33cn4/vyCGGqi557P4jR2OLQLADyQBaGntflI61a5b5swADuVIVL6gKVE1u8vkq3dUyNypMY5NEQd6f28Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Wa1vEpDB; arc=fail smtp.client-ip=52.101.56.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aPGJ6pOVCe8KJHvJJHKSqw14Ewbqnreqj+OslWpzOoSJwKfAsQ+hPTZvjOEBRtnmiWiu30mIsNRLZX/7MRWiXp3QHAsqt6M6JbvUY0gpCHrCzL/OsSzdn/8dvUdPgtqcRdyRTbs/qStqOj+BsXvEzabblSQrOpzX/c7IdQ9ySqEqAkGGLDJuqOeYz4wQVRk8t7oFwy3vh6XEqpz/TvhEeKbGMjHfSEObQ15xHlsOs+HyncwjHLFnGWyR7ce51wgu9Ym1UziYUvWg8FxjY/3lTCCiMCTTG4XbjkojLQKJLoV2UPFyT9ugVrqAi3C8PaZqKeGAVOTy8RKqaN4YQACGdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VhYHZjCuCclo7JEjkVbKOq3KSoKZ/VbGkAY5JgtEE98=;
 b=J5hQg0NJLznipiaQ4DdAyfprv0l2c6gX7pBLRhUsFSpAeAvpX+C2xpnyPftFcTiIN4L2PYftVlPXR6XxUNIfad0fZeVFzOmRXP4O3hjjt40yLwLeT4t+5ktWe3/iTnbSgaHxF8CJhvGmtxyD8syufJm1LVZqfW9cTRAQx6f0cNS4whTArgexXQXgqWYT72ATfoYanvDrhah5Fg6z030v1NM4dCbS8ibtrF2uiA4khJu+QdHeK4zwJrhDUsiTwxXch70d+hQHbx09szfZmCP6D3xcdL1Y6cHrdwYC/f4Jeoz4dCXFj/q5x8P9VOeGoC4Dtwp5jo70TH+iNyA3PWITVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VhYHZjCuCclo7JEjkVbKOq3KSoKZ/VbGkAY5JgtEE98=;
 b=Wa1vEpDBwb0UouSfOQmjskEnUOMCzPu9yd5d9w+4j3C0zPH9Zm8Mq9jpk/httCh0MqKOakvVCYwOwB06mcFphRk4NZRhPInQAf/ruZKyOwCepUjIQUf/APLq3PYT9Z/FtvBgNmUU3bDtLSm6/ZNRiMO1RtAxWyVH4vNygfK8Wk05j60RBpP0Z8W3nYZr2j6AWQUffAx0efTGwE+2Rt8DQGWnNfyyiy9BkEgOqq4Q8lCA91LxsXpfS5E2l6DqfBUXUgDTsZoLMu4RNNXlwSqJPsdYIGhNROLbCzpEQDqh7qLWUfSUYKX2pVlD+OEFWaHbpxFEa3ofSIomP9ctirl0Pw==
Received: from MN2PR05CA0035.namprd05.prod.outlook.com (2603:10b6:208:c0::48)
 by MW4PR12MB7119.namprd12.prod.outlook.com (2603:10b6:303:220::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Mon, 12 Jan
 2026 09:17:55 +0000
Received: from BN2PEPF000044A5.namprd04.prod.outlook.com
 (2603:10b6:208:c0:cafe::1a) by MN2PR05CA0035.outlook.office365.com
 (2603:10b6:208:c0::48) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.4 via Frontend Transport; Mon,
 12 Jan 2026 09:17:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF000044A5.mail.protection.outlook.com (10.167.243.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Mon, 12 Jan 2026 09:17:54 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 12 Jan
 2026 01:17:42 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 12 Jan
 2026 01:17:42 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 12
 Jan 2026 01:17:37 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Jian Shen <shenjian15@huawei.com>, Salil Mehta <salil.mehta@huawei.com>,
	Jijie Shao <shaojijie@huawei.com>, Saeed Mahameed <saeedm@nvidia.com>, "Tariq
 Toukan" <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Leon Romanovsky
	<leon@kernel.org>, <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Shahar Shitrit <shshitrit@nvidia.com>, Yael Chemla
	<ychemla@nvidia.com>, Jamal Hadi Salim <jhs@mojatatu.com>
Subject: [PATCH net-next V2 2/3] net: hns3: Use netif_xmit_timeout_ms() helper
Date: Mon, 12 Jan 2026 11:16:22 +0200
Message-ID: <1768209383-1546791-3-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1768209383-1546791-1-git-send-email-tariqt@nvidia.com>
References: <1768209383-1546791-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A5:EE_|MW4PR12MB7119:EE_
X-MS-Office365-Filtering-Correlation-Id: beb35bd9-96d7-46af-2fdf-08de51bb77e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MtnAGlEwSQzFnB10engxBR9CqrDMjv8sPZKasX9bivf4NoWBp6BQjQeIn0IN?=
 =?us-ascii?Q?1BuRLX9w40YAH1n/iVJedNcaFUPZ/G/J3qfUNw1z8qAwRWjvF7WKNgoWe4Pw?=
 =?us-ascii?Q?zmRNA7D9clCIj0CMZG+4NivHYD0rWtLiGFWmCicqfM/hPSx20MgCs0dUUpAy?=
 =?us-ascii?Q?Gokpb4CfxO0ioI4NhXANZCSWJE2f/kpwqW8FFCxUv3uj7Rw76wppKegL5umc?=
 =?us-ascii?Q?ezfWUDhovoYffViBWuBg8RZh9pfc8N9wbSsCgTSddpS9FE7qZ5d5rnJ9r9Oq?=
 =?us-ascii?Q?FdGpJY1DVdZv0hEmbBqEhMiUDfO9WTC/kI6mAHyZfsJlXuZFAqv+DOiRArxy?=
 =?us-ascii?Q?1Pul1lR+rdE112VFqcKwRsnzUUVvExWPFqkH7et1I6vGHM7lsWVI2pB+VnCc?=
 =?us-ascii?Q?tRuR4nujjdO2wWJMqsjP8wol8Yyvoy7De/GB8fjypxqEFYvOHcL7aJiUhmuO?=
 =?us-ascii?Q?3uwu382/+CJ3cZy3gVmoKzsmD/xfgbSkNlHoHDnKdkn+7e1bWbe+RIW3N8sY?=
 =?us-ascii?Q?7p/+X5Wf12zxDNt61FJ9YF3EhsyrLUGnbAJXUo5BCdJv2OdBXKQzayiSLiYP?=
 =?us-ascii?Q?ealbw4erGczo34xQSEJ43g9uIETMYaM42oyokFBbx/AdfAaIIn4080TIGLJH?=
 =?us-ascii?Q?EJUjKLkyEXg5SLFjs7b0caATfu3jlZmsMU7Ln68dmf04aTsEZcrQNgy0KB82?=
 =?us-ascii?Q?KGD+cKPPV9LMzbxRDECpyBZjJqvDG0B5NBJGZjLhkbD1Q5yP8C9tShTcF5Xw?=
 =?us-ascii?Q?YESw0Xx29axiXYKoRO+QPfVsMBCRdkg8T9vmV0BMtz4IG/wFCzuXeBgSCoCT?=
 =?us-ascii?Q?cSM3RVpx1uTmmjtm0/WuPL3gItYSrAG/H3stmCkNEC7lE+hVL0ODOfR8a4as?=
 =?us-ascii?Q?kZnVYcrcG7nw52Z53uH0Wml1B1SRqso816bpMJn3pLQf4IQekpOIFwmE8Ov0?=
 =?us-ascii?Q?4vlYb6TmWnvR5o1E5bf02+7OnLLu2kYU44bRNE4dPfTSDzXLOxJjjVBIe9vM?=
 =?us-ascii?Q?tgsKCvrSAHgUzt5NotdrIuhtdhBiTtu8D4oBOlaWHQLdWIHJ3QEPf9HMcDAD?=
 =?us-ascii?Q?QTkyJ756gRE/xvLAIyFUOhBiMT0vfpQ+r0sddNV1Br138KpiCWwHsJWUJHyl?=
 =?us-ascii?Q?f4zV+aPT7wv2PV7px4Z0cZ71VC2dSZIU8dtzusExVqi8klH+t8wbKwwz7p86?=
 =?us-ascii?Q?GSO1LYUlehoNEGWP79N8OYXPKj+NEr/NicAJCDrVt+CK+W2O6dD3hdDv1+f2?=
 =?us-ascii?Q?BX7GLf5XWA/zMIxrHhn09SG83b1IUVvkFAgpAyBYW2LN8HnRbeOO2Rti6NAL?=
 =?us-ascii?Q?lHMzltHCgTxev942JmUnXuD3mvYcNDU6C+GVCHEKEa83drxFpasJVDyC8lUW?=
 =?us-ascii?Q?IzrqjdgIsCPL7Fhp7HUwV9qYGSMqy4NhbN1DPKkQ0lJv4Ar7NtGltOfTDjhG?=
 =?us-ascii?Q?6VrZOSrdn1UG0K9vCAdBYlpzL5AH/F+dQUKo4g6GTpcUWO2DvW9Zgs0U/9mK?=
 =?us-ascii?Q?PqSAVdsbhu4RRN16DNkOx4gWtba6ve+iHvoF7xoFZ8AIoeHB2ykFMlZqJl5d?=
 =?us-ascii?Q?4mkoVTBgsKbZaDlrliw=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2026 09:17:54.3830
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: beb35bd9-96d7-46af-2fdf-08de51bb77e8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7119

From: Shahar Shitrit <shshitrit@nvidia.com>

Replace the open-coded TX queue timeout check
in hns3_get_timeout_queue() with a call to
netif_xmit_timeout_ms() helper.

Signed-off-by: Shahar Shitrit <shshitrit@nvidia.com>
Reviewed-by: Yael Chemla <ychemla@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index 7a0654e2d3dd..7b9269f6fdfc 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -25,6 +25,7 @@
 #include <net/tcp.h>
 #include <net/vxlan.h>
 #include <net/geneve.h>
+#include <net/netdev_queues.h>
 
 #include "hnae3.h"
 #include "hns3_enet.h"
@@ -2807,14 +2808,12 @@ static int hns3_get_timeout_queue(struct net_device *ndev)
 
 	/* Find the stopped queue the same way the stack does */
 	for (i = 0; i < ndev->num_tx_queues; i++) {
+		unsigned int timedout_ms;
 		struct netdev_queue *q;
-		unsigned long trans_start;
 
 		q = netdev_get_tx_queue(ndev, i);
-		trans_start = READ_ONCE(q->trans_start);
-		if (netif_xmit_stopped(q) &&
-		    time_after(jiffies,
-			       (trans_start + ndev->watchdog_timeo))) {
+		timedout_ms = netif_xmit_timeout_ms(q);
+		if (timedout_ms) {
 #ifdef CONFIG_BQL
 			struct dql *dql = &q->dql;
 
@@ -2823,8 +2822,7 @@ static int hns3_get_timeout_queue(struct net_device *ndev)
 				    dql->adj_limit, dql->num_completed);
 #endif
 			netdev_info(ndev, "queue state: 0x%lx, delta msecs: %u\n",
-				    q->state,
-				    jiffies_to_msecs(jiffies - trans_start));
+				    q->state, timedout_ms);
 			break;
 		}
 	}
-- 
2.31.1


