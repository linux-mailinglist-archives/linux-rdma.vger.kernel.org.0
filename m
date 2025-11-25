Return-Path: <linux-rdma+bounces-14753-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CEB64C83AC5
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Nov 2025 08:16:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26B873B0602
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Nov 2025 07:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F04DD2F5A2B;
	Tue, 25 Nov 2025 07:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TgQxUVrt"
X-Original-To: linux-rdma@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010046.outbound.protection.outlook.com [52.101.61.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35EF62D73B8;
	Tue, 25 Nov 2025 07:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764054820; cv=fail; b=aypOoGSjzDAIZLBXLlTql91SBjMT5PZO06HCogBVIkZMCLEaArbnOcw33RGq3e1oKjXbDvIpZnhWSIfSJK8wRkxU3J1cmRVkckJsRx6hvb3mkJLqYZB3rOelPPM0UxoFByMRvqctleuRfQK6mWKaFEqpyvW3N57Q4N0lYlczxmU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764054820; c=relaxed/simple;
	bh=l8u31Na5de+pDFE4001ZwEuxhifRUsAOO1NV+ZzOqL4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Re4DABy9ukmbW+chSmp7rqIZEPrOFVPxJBu3DWdjLOcHiZQnyubaSuH+tMYadTYTUg9ClqA3WiVj5UWxIhj2PBP2Lpqi74dUH/TKCAmOtjnmltefI5KHimUxrMDoCiou7oCIP5k8rDYX6OISdygH+73K99DT2eurFIDFNrKAoM8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TgQxUVrt; arc=fail smtp.client-ip=52.101.61.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bROd8pRZQbzss5RwgXYXEOSoa9tQjVKI98LMKeJcWvsWRzY9h8q0CgDHxUzDxA9/u/0YQE6PWHWo7UK2Ft1EJkZ05JuvgNO2kg/4wYPCWwFwLZ2j4TFERpC1Yic/C5SgpHT7qbLxarzJVe8gIoVXvYqOb2a/LACmCumcIRcDHl93Xre0IKBknFnRMiib4XEucpcxBjAmRrbdWP5REyboljH6fSneGSZmAOUvsH2BXPUiOv5VUiZRTuZI2KkGwgl0W6SKhFUdDaPr18YzxDTRvPzflrpQHLuC+LZ9L0FQVqzrUdQPkmHVtBvytp5ngYJmi7ZuSFNal+ewouOKGTY5ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tNq7tXsckVGHlE6GV7bR47LnrGXHUm1k1LCKAAMRfBQ=;
 b=gsVJx7J5VS+3JrdSmTQ/eGy4olXCdnV/vRDX0fJG7lvmKdgvdBd3UrgFPGsWVIq9qXXbxz2lYXnrZPbpRwUNX01fTAwcxRPIT+Inl16ac53hTLdiNKIo6P6TxJ2w/KTnCMqWC0d+a2AthCrqKRIkvoCvyRbGBotM23AO1WSgYzUSAUkNniNw27YiOgx9VHuhk8pGxqK3mYwNkVMS5WlFImzjpHhfcn0oH4caNCkeDiRJHC+LHILZurgC+aYB4VvKQydddNTjtszzRDiO93K0aUBoWemU4cclClXLvb0ay6Kgr5xRP6Mm/1uBqqrqRyPOWCHz3G7Bo4e5aKB0XhYDQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tNq7tXsckVGHlE6GV7bR47LnrGXHUm1k1LCKAAMRfBQ=;
 b=TgQxUVrt21dKpgO3zjTMqnzMIo6XpbgM2pM/aLWhjAgKWzflSThUNoTKVtvRYofUmq87gHyvCtw0msF3zsdZxo+OHeerr7lHTx510y5mt1mx3Vko6R2Po5GRrZ3q+c5kFE04ChYNYdsvOxFm7FsBXt/RnCuB3Fi8QDad9jxDJDwfpmhmhkvXE9aucm1fGSwahx8K72GMYzSjgBPsOj0R70rPlBipvws69bnIYFMBwvq6d7Xt93WE+B39K4gm+vGtUGhNx2In35GqRrGZI4d4tEGezQUT16z5/RvoVd9m+/45ejtY/AhxV6WILwwKMtjF3dio9s3fTCptVWO2aySwMQ==
Received: from DM6PR03CA0044.namprd03.prod.outlook.com (2603:10b6:5:100::21)
 by CH3PR12MB9022.namprd12.prod.outlook.com (2603:10b6:610:171::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Tue, 25 Nov
 2025 07:13:35 +0000
Received: from DS1PEPF00017091.namprd03.prod.outlook.com
 (2603:10b6:5:100:cafe::38) by DM6PR03CA0044.outlook.office365.com
 (2603:10b6:5:100::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.11 via Frontend Transport; Tue,
 25 Nov 2025 07:13:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS1PEPF00017091.mail.protection.outlook.com (10.167.17.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Tue, 25 Nov 2025 07:13:34 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 24 Nov
 2025 23:13:23 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 24 Nov
 2025 23:13:23 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 24
 Nov 2025 23:13:17 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Jian Shen <shenjian15@huawei.com>, Salil Mehta <salil.mehta@huawei.com>,
	Jijie Shao <shaojijie@huawei.com>, Saeed Mahameed <saeedm@nvidia.com>, "Tariq
 Toukan" <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Leon Romanovsky
	<leon@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang
	<xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Yael Chemla <ychemla@nvidia.com>, Shahar Shitrit
	<shshitrit@nvidia.com>
Subject: [PATCH net-next 2/3] net: hns3: Use netif_xmit_timeout_ms() helper
Date: Tue, 25 Nov 2025 09:12:55 +0200
Message-ID: <1764054776-1308696-3-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1764054776-1308696-1-git-send-email-tariqt@nvidia.com>
References: <1764054776-1308696-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017091:EE_|CH3PR12MB9022:EE_
X-MS-Office365-Filtering-Correlation-Id: 40d00444-71db-47c2-9080-08de2bf225ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6L/4+i7ngRjfTLZv9pgtw7pDKxcJd5tBNlFFbJfu/tgHoeYRsQN3UAwtLiRp?=
 =?us-ascii?Q?h52UGGESpsC23CwgkqS4XU3s/cFpnJ44rKAu8JyrbPySk7hLFU+zjsDeI0k4?=
 =?us-ascii?Q?HosfXGvrOAY04RVZlO3FMMFeE+gNWZgIn1kUVuUNO/ByV77yiBsZe5C2c+1+?=
 =?us-ascii?Q?e2l6T7lMQV69HNauQuXrKpu9JDSqKejuk+p6FO34IEg//vQqDQvLfseOEW3k?=
 =?us-ascii?Q?HQACshIdR89DD6re7eBGPO+paZjdSDRZ2nEizDn84SO6fing6CGHZymoL+hK?=
 =?us-ascii?Q?9tQViFqHHQ1esbQFWcdieARUmpCBEgktNVLhUMcUWHNfO3KBEFpZ60myRv8X?=
 =?us-ascii?Q?lSWalZdeu4Gbk9ZCqSLqi8HUYEIEzewXu7lEWMpLcfm4LLhUO4bs03abZwd5?=
 =?us-ascii?Q?kfCYJQrx0XyDmzjoKpnOgeJ7hf9qAUkmrPRq9cMPNOMaBb7huYi7CedjR6SR?=
 =?us-ascii?Q?4HyA1A5Kz3YokvJfKrc57VbZcxyreWhly/KLFxzAuw0ipJT4fA3oMtsswbvI?=
 =?us-ascii?Q?Pz0y9NqEw418IFMo7sWwXxaC7z2T1nQnYAKe0GDUfuWj9FNDVKlRWGUIKB1h?=
 =?us-ascii?Q?EFj3q2ELpb5bzJ7UXdMztHbHx0X5Hb6iVY88sx7dMbxB6TxAmWYluC6Ohaj6?=
 =?us-ascii?Q?XoqCU243Bxl0ezGcrrVDqMziWRnkHHQVGS/ZfPxQqshbLKWOz79QEPoWX7Pm?=
 =?us-ascii?Q?wmdVS9qYwBdVvoHlkoI8tDqW1a4wmXharJnt+9Mt2fUxTvfABEQRiDnjnAT6?=
 =?us-ascii?Q?9FC/sU7KZ2UYlozpHx6Oh7rONnQNY3V5Z3A5dj53S3EW6+llWUjBSXvUVYRu?=
 =?us-ascii?Q?WdYc8+Hn94utW7RmwPGJLdvIQHZ79etbgagU4ER1/adEKg9Hl3A/ygc4x6bh?=
 =?us-ascii?Q?eoSOhE1cZJSnsGS8MGkAIdCe9te4GPH7BAlSYByK2HeRcvhXztoVYPvGsvdD?=
 =?us-ascii?Q?DRlxPqM22xrezw6eySrMbZ64MftvF3zztmYQk8RiAt4/OZyeRbFfz81EceHt?=
 =?us-ascii?Q?V3liqvuGbORDnY4gPNdDXwLtKqxP4QbwBJjd7TiEJqnpJIcECqjxYKOaKb74?=
 =?us-ascii?Q?m/tFCbnMXtS2TJxVVl96i95g4VprzYI0/11YgndhC4kQTqlSpkXFpe4N6Mij?=
 =?us-ascii?Q?RL7ECNYKdf/zi/UhdrtTw1+293bHF3YrQwJjQU8gz5JAQ4UMAp10NKdMWcuI?=
 =?us-ascii?Q?c6qLbpGjJqHWm3eZhOTYV7ztPMT4e1yWDrbIGqOXIMx+BHnzq7WbeXDEUyVi?=
 =?us-ascii?Q?AdAkE9E4QZ2LBXDR01M4JQuS2ahB31sWrx8VZeNMGQ9epFHokdLmOaGPAA/G?=
 =?us-ascii?Q?mkI7MRwnxv6gofZG/aPElZ4xrU0yj6PUkeJbNIdw1iUgq2n6Hjb8lBt9krKm?=
 =?us-ascii?Q?DMfUXF4FicNoTnEQl2Sbrn502qozmE7aIR1+FgOG9jRcmAhI41X7MQ27yTl+?=
 =?us-ascii?Q?Q7hAqj9p8wjE1F8OZSR+TE/VzmDJPF/IeCiTmFtGcmgCG7rRtEaPqdmjQzKE?=
 =?us-ascii?Q?Ds9WjHiYMo9mWaWYKzK39PMxpBeSwT+/lp0QeIM/yZLdXbUkVcK+/CKi9AiH?=
 =?us-ascii?Q?i5SmYprRNMDe3vwIuvo=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 07:13:34.9899
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40d00444-71db-47c2-9080-08de2bf225ea
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017091.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9022

From: Shahar Shitrit <shshitrit@nvidia.com>

Replace the open-coded TX queue timeout check in
hns3_get_timeout_queue() with a call to netif_xmit_timeout_ms() helper.

Signed-off-by: Shahar Shitrit <shshitrit@nvidia.com>
Reviewed-by: Yael Chemla <ychemla@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index 7a0654e2d3dd..3e8fe3b5d32b 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -2811,10 +2811,7 @@ static int hns3_get_timeout_queue(struct net_device *ndev)
 		unsigned long trans_start;
 
 		q = netdev_get_tx_queue(ndev, i);
-		trans_start = READ_ONCE(q->trans_start);
-		if (netif_xmit_stopped(q) &&
-		    time_after(jiffies,
-			       (trans_start + ndev->watchdog_timeo))) {
+		if (netif_xmit_timeout_ms(q, &trans_start)) {
 #ifdef CONFIG_BQL
 			struct dql *dql = &q->dql;
 
-- 
2.31.1


