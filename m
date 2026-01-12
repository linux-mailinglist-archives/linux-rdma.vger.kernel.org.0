Return-Path: <linux-rdma+bounces-15447-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C8AC9D1175A
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Jan 2026 10:20:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BAB95304EDB0
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Jan 2026 09:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6590134845C;
	Mon, 12 Jan 2026 09:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qEkBHTmS"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010006.outbound.protection.outlook.com [52.101.46.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8645E347FE2;
	Mon, 12 Jan 2026 09:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768209498; cv=fail; b=cbANDOtM6Dztgc00bgknwef97jPsb2a015zTfw4+96XOzMXJxpbDTefrhyvYHRmJCAyX8cnOQc/mdWxaaMi3lDOglm4hx+GTZxoxgrdkLngFQZl+vOOSZSaVzFG+4gB6QyPj1emADomYV8mDT2lSrhez6MGBzJRMuu39asz6kxk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768209498; c=relaxed/simple;
	bh=HQoU9xEBMxQ8G/RU8I43Mx22IsTHIbw47gfcNddH56c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n8okmMk0YsNm56AD+XU0Bim2arkZV9psMElvBNFE3TieHIk0Of+iEjrKp60756CdtWMnQBsbM91TENHEbAb6It83275BJy3R1r5MTnGAj4Cwr8KMIhdMBfeODW0KAzzgOhDRqKHxTTwDuU1Y3Xr2tQzX5uifIdFbhgO2kXn4A+M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qEkBHTmS; arc=fail smtp.client-ip=52.101.46.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FeSWcrs0dEW7Tu5VKY9jsN+eDfQ3NJYoqi11raIgEYsuIcslyw/lkginHMY6OsCjS46E6mMIf+1P4KGEKcDd01XJic0N2ktkrjnyBCS1fgCghwBYTA+tOndYSA3YA25emF7EhXS67bsCLk6PoCFPtPcT52yimw5RdCmPRM3amB2L1WEg1XrhxypWgCf6IkNCiQig++tfx13UsbtiS7MMO9VYzoTYGyg7v3QBz9XN58hi/59jXhZN8WQ9fgHkYEKBQHMqGesDlazsX44PyQ7KBDwZFwUtVTvKSNca5xRL7RMmvT0kXKpBzR6osc0bbfBzQXLIMm5VL+SRu7Or0zQfUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xf942PCStO7fjU9ge+o11HdVAcMvr+Fs7TshzeceW+I=;
 b=RgykmCRfC2NO6VhpKLGYsnJ1sEpzddnRjmn+m8dm2rSVJHHSFGVoKlVkvrEV1Uv3m7qQHt2301crwL+PUYsiwqXY0+/c9pSlvFKMtn65znSbRBSqJhfDByM+7EnUWX8Y+U8xMMr4wQHAFbt5zNOfKFUinNAWRkZDRnBtpO4AmFtWsJXZUoNcujHIzrNhSq2uhbMfRRIJ87UfXIyhSjqRSjc/XYdxGngZEdYVMh0vgRAQWd/X5nawuwhQdhX4GFgMkMDhgnDRUHseww0BS1fjE2wqsBrA0Km3CIXZk97yI353u8JpDnRpdp9J7XR39vF3lKkaF99kZPk9Pb3SK5zUzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xf942PCStO7fjU9ge+o11HdVAcMvr+Fs7TshzeceW+I=;
 b=qEkBHTmShUGSEzHMTx4zZnvDUmkQmAG7uR7A0/dPpf2xypY8dX8P6M6gGaz1y310spuJN1gDu/DoKjFiC5e90WNXt7Oni4xF1/e6Tyul37Gv4yvrkrE0QdUWnta7015bbFxODMqm45WzzJePCGMw227PifCUVgJ5M3fX7HgRMUKsbQxPHIZjkPN0pK9CFmMfS7L3Jv6T26J5ksxBbrYs5uWP3k3tPW1362cpmHTZKQvp3MN+rnSMY1l90/J0CCcEPW65Lcrz9sAbQqG8Ff5qxraRxCp+miqaYR+1OZ1bn+EJYnzZPQTnz95I2MJk3vRaETPm9lcwbKxNpYUd+vv9Dg==
Received: from BN9PR03CA0526.namprd03.prod.outlook.com (2603:10b6:408:131::21)
 by CY5PR12MB6132.namprd12.prod.outlook.com (2603:10b6:930:24::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Mon, 12 Jan
 2026 09:18:00 +0000
Received: from BN2PEPF000044AA.namprd04.prod.outlook.com
 (2603:10b6:408:131:cafe::e1) by BN9PR03CA0526.outlook.office365.com
 (2603:10b6:408:131::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.7 via Frontend Transport; Mon,
 12 Jan 2026 09:17:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF000044AA.mail.protection.outlook.com (10.167.243.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Mon, 12 Jan 2026 09:17:59 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 12 Jan
 2026 01:17:47 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 12 Jan
 2026 01:17:47 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 12
 Jan 2026 01:17:42 -0800
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
Subject: [PATCH net-next V2 3/3] net/mlx5e: Refine TX timeout handling to skip non-timed-out SQ
Date: Mon, 12 Jan 2026 11:16:23 +0200
Message-ID: <1768209383-1546791-4-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1768209383-1546791-1-git-send-email-tariqt@nvidia.com>
References: <1768209383-1546791-1-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AA:EE_|CY5PR12MB6132:EE_
X-MS-Office365-Filtering-Correlation-Id: ffc288bf-e7ee-41c3-a39f-08de51bb7b25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UnBlNWN4Y3hkTUdDUFZtUnhYL3p1MW4xWm9QbDEybmdXcWJLNVdYSDcrcDBG?=
 =?utf-8?B?Y2Z3NCtUWHZsSmdoNTZPQTlML1VabkJuK2EweDJsQy92YXkzcDdsNnB5S2hW?=
 =?utf-8?B?bjExR3pudVE5RTVuelcwYktkeWZmWm9yTW0yNzQ4ZjJ6cno2WDg3dzRaTkd3?=
 =?utf-8?B?eEt4YWlrOFVNTTh5eDZRVmF2RmNEaU9CZkFJOU1tTUNmZzVrWG84WlhpNDZU?=
 =?utf-8?B?L0NvTElqYzVrcCt5bjNDdGZHeTE5b0p0STFMVXRIODBjU0hjUzEwMXJoc1Bz?=
 =?utf-8?B?bXM4elVoY1B5TytJSHJ1eEpVZTBTeXA5YjFucFNDd2QxekJyaXRXTWNtYUth?=
 =?utf-8?B?cXdtWHVwQ3FDV2MzNkVtcXQ1a3NFQVhTK0Z4QzB6Z2VtdVFNR2g0U2lVQnFD?=
 =?utf-8?B?YzQwOXlibTlkWkpiMno1cUlSRVpyekwwWE16R25HWmxVUlZaRDNGVkhKZnNu?=
 =?utf-8?B?R2lRNloxNWdtczNaWHFHTlhDa2djNTVhK0pUWUVDNFM4SGQ1Rld3T2gyK3dZ?=
 =?utf-8?B?MVhGTkZrWmt2WlBKM1RyQjhiQnp6bFFFakVPcjBUTlJtN2dncFdTdHR0QTJ1?=
 =?utf-8?B?MDdITTFjTW5uQXdzNUVvRnhEUUxLQWJyb2tETGFqOFZ5OFIvNDV2ZkliYVNG?=
 =?utf-8?B?bWVuZGJaQUhxeE84dFdTaVlCS01jTHpiN3JwWFMyZEN4aUJLdjNTY1RKNmdj?=
 =?utf-8?B?QnlYRXdlQ25GWW4waDN6cUJDeUo4aGhXKzdGNGIrbS9CY2RjV1BEOWg1YXFs?=
 =?utf-8?B?M0orZndhMVdRaGsvWS8rRUZMQjFXUU9aRDd5N2lReDVod1lHdG5HSjJzaU9D?=
 =?utf-8?B?WitVUDB0UEwrZjlRWFhZRDJjSFgwMzV6cVpWeXhHMzJhazFkazBvT0V1NWxx?=
 =?utf-8?B?d01hazNreWlTMEpEdjJiUEQxSy9LYTg1ZUFZdTdwN0xLVVlVTjg1VG50L0tq?=
 =?utf-8?B?VERlaXQxS0RMVVg5M244KzNLZ1dlR280RTlDTlFRbGhCTGN6SWRqU0JOL1Zq?=
 =?utf-8?B?d0k3cFRUcWtZVHlBQ1A0WTZjaVJOOC9sdzcrVTlPK25qcUZ1RFJMV0MvZ0pY?=
 =?utf-8?B?eUFiam0ya0cxc0dpWmZiMEpzeXJ0dUozaElMdWtvakNhN2pEWWlCdThnTzM4?=
 =?utf-8?B?U05hTVpwYS9jSjh5TmcwN3VMZlhLTzErczF5WkpXK0pObHB3Wks1ME1zOENF?=
 =?utf-8?B?WTJ6OEpWNFFkbWtROENsMU1TTWJLb1hpZlRIdXdBOXZ4dlJUWlkxNXBSQzlJ?=
 =?utf-8?B?d201VjdtVTNCVmFIV05pN2JvaGhvSGJJWDB4ZUFrVkVRM0YzdW1NcFkrNTR5?=
 =?utf-8?B?N0lwS2ZyT25xQ3h5bFpYclhDa1hZS2wzeThmU2RnRDVVMkFPVnNtbGhLMEVM?=
 =?utf-8?B?TGhzR25DRXdneVBidGhzN2JFUjFjZnh6aDlPR3FySlg3ZmxTVWFaSmg5OEc5?=
 =?utf-8?B?ZTNZZExZdDdtUUF2S0FLWkJRTTAxOUxjblBON3g0UlNsRTh3MjBSMnA2c2FN?=
 =?utf-8?B?dVE5R01pcldTSTRiZFNCRWR5UGs1ekRwOTY5dHJVQTlWYWZCS1Ntc293REhW?=
 =?utf-8?B?R0lubUs2K0lxay8wMnQ2ejVBK3h0VytNYkJkdmdVaUZOT2dEYVJYRUlEVm52?=
 =?utf-8?B?MDRaa2MyVThYUTd6eFd4ZXpuM3orcy9QMTdJbm9sc0xTenN0dndNK3JqbXc4?=
 =?utf-8?B?WTlSWW5UYkFva01ScTRVU3lKamUyeHl1ZTM3eG5Xa1JvTkZrQ0llL2E1QmRU?=
 =?utf-8?B?RGZyS0JTbTFQelZPWUpRMXhxVjNBamRvd1JWTWRxcTJieGlsaEYydTIxQTZH?=
 =?utf-8?B?YWUxOC9WbFBDZEM3bUx3elprcUNaR05veFNhRGI2NEFESE5XRzV6dmZ6dUNt?=
 =?utf-8?B?Z0l4aHpjMXRtUndSR2NmZUVGa2cvL1hhVVgwWUxrS1J3UC9wWWdpVnlxUERm?=
 =?utf-8?B?OG5rMGh5REJSa0RGalpTU3MydTNqZG9jNTJncWQ4WkZrcVNPZVI3UGFIZ0px?=
 =?utf-8?B?czdQQVdDN0haanQzWUc4UVlCKzJJZ0tMdldxSFVDcmR2YkdnSHlsRklVMUxN?=
 =?utf-8?B?bWwydHpyRWlhY1FtMVh5dktXYVF5Tk1iRERTcUVjSWhCNkVrYlplOUx1Y0Vq?=
 =?utf-8?Q?vj3M=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2026 09:17:59.8054
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ffc288bf-e7ee-41c3-a39f-08de51bb7b25
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044AA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6132

From: Shahar Shitrit <shshitrit@nvidia.com>

mlx5e_tx_timeout_work() is invoked when the dev_watchdog reports a
timed-out TX queue. Currently, the recovery flow is triggered for all
stopped SQs, which is not always correct — some SQs may be temporarily
stopped without actually timing out. Attempting to recover such SQs
results in no EQE being polled (since no real timeout occurred), which
the driver misinterprets as a recovery failure, unnecessarily causing
channel reopening.

Improve the logic to initiate recovery only for SQs that are both
stopped and timed out. Utilize the helper introduced in the previous
patch to determine whether the netdevice watchdog timeout period has
elapsed since the SQ’s last transmit timestamp.

Signed-off-by: Shahar Shitrit <shshitrit@nvidia.com>
Reviewed-by: Yael Chemla <ychemla@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 3ac47df83ac8..7dbcf71404d8 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -5137,7 +5137,7 @@ static void mlx5e_tx_timeout_work(struct work_struct *work)
 			netdev_get_tx_queue(netdev, i);
 		struct mlx5e_txqsq *sq = priv->txq2sq[i];
 
-		if (!netif_xmit_stopped(dev_queue))
+		if (!netif_xmit_timeout_ms(dev_queue))
 			continue;
 
 		if (mlx5e_reporter_tx_timeout(sq))
-- 
2.31.1


