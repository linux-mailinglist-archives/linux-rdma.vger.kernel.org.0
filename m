Return-Path: <linux-rdma+bounces-12034-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2FC8B0047D
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Jul 2025 15:59:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2697E1C8146E
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Jul 2025 13:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A78B4271A6D;
	Thu, 10 Jul 2025 13:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NzMYzKol"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2086.outbound.protection.outlook.com [40.107.244.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09A126E15D;
	Thu, 10 Jul 2025 13:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752155693; cv=fail; b=qkH+oYmH9eN603rjiiNR3izKM+1PelibtZCH9wLK1bTyThJHYPBHl08J+Ss8l5UzSRCnzfUVNCcp7UgfS5JehQqzd/1RRuNWvdmv6UpcOoVVuHR3jQ1jZ67DzfBca9vthyXQE8c1CoCLgehvOPe/UpQxZl6kChKYqarau1hKZ24=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752155693; c=relaxed/simple;
	bh=rw7bZ4RtPwqy531/dH2G/uGknPi0GvfapB9zfwQQmZc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tRa/TYWIa58INS35/AY7jiCCs+ERq+SLJJr0vyPkuvjKuvwwHPW06hcqFZiiSr26U36lJlROHfB5C+PK+ZbV3epWMN0MTYj/Eksp/tfiYRkKPGcv0epIGY6TPqaI75j8uDG/HIgmV9CvfDVkj3ZTGocTGess3j7dl66zARB/ADY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NzMYzKol; arc=fail smtp.client-ip=40.107.244.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XThAg9TrGs/lZMVv9oHOgnD/H37ZH+rQHKmxlvW66LvxPhj35WibpeN6/qtz9Qktb6+5ng742Zfl/rra8ePswW4fEAkWPrnOH2ieRdpRql/h3PKBV6YwOju9CdYQSB9YziLWRstr+xSfxvMPfVuaO4PXsGdD8ic+xgS6dNbL5Yd8vJ9HP+U+JfpNkY3Mp2wSJM5Y9n4NwDhu+0SA4103/YRycnHMZCAfUtIOtLCPDf3GsujieBHxTiuNJo+WWRFZMH7JyyMVgt8M8XptRuEBQCMWUFaarIu5hM/WKH27c643wh72H7ZFZ3fb9CTFALeTWiBOoapQLj1sOrNrVllyeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J8d5lG8zVLhclAuYsXXBTgQ2pXgOBylZL96nzGvFkak=;
 b=tn1LZKj5RGgUbAZ4uFxNG2T7Qbg5enILVUl5gYKCPWuKa9UPjVNvx1dMJCCIny6TGhQfzTe31MvuPE6akqrM4mXIxZZZw8OxEQ5GeW4pxlNslSf+lV6mZEoe3msOydswim9fXmzOahmDkkP2Y7GEbe/eafoawsmOVjhWRaNsSqps6ImCDWTIfkSF3sZyTt0EVAOfTAdFh/AIUSoB4JYaZo8PAqVs+ptPnxWg8MkctlPGMYy5ApJcvkCCfsuBA4fK1klA246xbfbBZMhIC5WbuIYiSkOlrCYYuAsNcBPLki8RMSUBp8uIOO+I8+7qpCaDmcckm7enJV98BPUcVh9b8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J8d5lG8zVLhclAuYsXXBTgQ2pXgOBylZL96nzGvFkak=;
 b=NzMYzKolvgfGOab/GzcqSyZHb0v8aqzjtxFqy2SfWFWH7oUxMmZUD/Be1mc4Cs10tGaPKvG8VSnc/uB+8HzrXjO+9UnyDjsX6pwE3D1+tWkUZ6PunJBb69Y543EW93JPFXB3nUZhjhicW6HKQG0KV4po6VqEEhrVeN0vJ+Q+X/iNxv9TqA021hn/1x43+8wLefqN8xWkM/m2knr3qcSc3HsAMPlVtY6xLfIZDKFSTj42i17UmPhjNGqvG9Q+Dz3H84f46nWiEXh7Y38MKvf1z4X6GBJAfzdLF1WTDAwKdZzo4WERhzM7jcsztZx9EMSpfGuJofbaDU6FlM8AbqIL+Q==
Received: from DM6PR07CA0075.namprd07.prod.outlook.com (2603:10b6:5:337::8) by
 DS7PR12MB8250.namprd12.prod.outlook.com (2603:10b6:8:db::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8880.17; Thu, 10 Jul 2025 13:54:49 +0000
Received: from DS2PEPF00003446.namprd04.prod.outlook.com
 (2603:10b6:5:337:cafe::bc) by DM6PR07CA0075.outlook.office365.com
 (2603:10b6:5:337::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.23 via Frontend Transport; Thu,
 10 Jul 2025 13:54:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DS2PEPF00003446.mail.protection.outlook.com (10.167.17.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.22 via Frontend Transport; Thu, 10 Jul 2025 13:54:49 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 10 Jul
 2025 06:54:39 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 10 Jul 2025 06:54:39 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Thu, 10 Jul 2025 06:54:35 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeed@kernel.org>, Gal Pressman <gal@nvidia.com>, "Leon
 Romanovsky" <leon@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, "Tariq
 Toukan" <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Carolina Jubran <cjubran@nvidia.com>
Subject: [PATCH net 1/3] net/mlx5: Reset bw_share field when changing a node's parent
Date: Thu, 10 Jul 2025 16:53:42 +0300
Message-ID: <1752155624-24095-2-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1752155624-24095-1-git-send-email-tariqt@nvidia.com>
References: <1752155624-24095-1-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003446:EE_|DS7PR12MB8250:EE_
X-MS-Office365-Filtering-Correlation-Id: f3143a0b-0e16-47bd-7ab9-08ddbfb95648
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YIaSLAdslh40cIlrBa60QGioXSS+0oFJBf9hhuKA2z7ZrssGVZlP2JpcoZxk?=
 =?us-ascii?Q?GXVj3iGNvNbB4+A2AI1RePZ0nj/dz1BedfqWik6bAWifrcly18IaA6XhW+FQ?=
 =?us-ascii?Q?CkUKtl8puLTsxphhxVA7hZ92SJcJn0rtW4tlx0hCwuWRX87SGGUnfmOWAcLs?=
 =?us-ascii?Q?xZxXom7E9+mHnja/tL/cbLRtv1JKVZuagLsMGPrgIbep3QULqX2buWRPRcb6?=
 =?us-ascii?Q?OHYIZ0xaNUKdO6QCtz5GxjRiu4mWDYxETsBiwnCBHtWERRu03P4fqHSuh+n7?=
 =?us-ascii?Q?B7Wa2oitweWM0luPTfhPCAPeelqov6MJ9AP/KJ9ICgzoCkZqkrZMYp9VyLlm?=
 =?us-ascii?Q?tRfZ4XfWnkFn366ZswOxgGEwl+5eGnf0mKUYdc4tBsSFXQZBR0OySreryjdn?=
 =?us-ascii?Q?0WkY2sP0knDebN+8Usfq3HMoFh786gZddkSKdI62fYxaboeHhjH1L7A3EejF?=
 =?us-ascii?Q?qJ32bcGC7M8cQHF/uHNXI8CcUFYm2PYzkuzKWLba/mxrLqefwbshIO/GhJth?=
 =?us-ascii?Q?1yNmNawMh7CGmIDnBwMH4jsn5Y42YdoMC465kTDDuwkaxTN8y345A3eiaJ+J?=
 =?us-ascii?Q?GQ6p+fQ9KZBGeEq5wFGq1lTRIgr+dy975HdvLXxkNnv53ZdPvJzRxU+FlC2j?=
 =?us-ascii?Q?lvA+PiDsFPoqVh/IdFqITp0VMoJMVR8+BWWhnkstm3KlXLWQBT7GDyneisCP?=
 =?us-ascii?Q?SyebGs+t5d2EN51pUH8ZauXW2/738RrqfyLvvl29FLKCdLDEq8NbsbqQoGCp?=
 =?us-ascii?Q?TI/AKpU0NNOH0vzADljrb6U8M0EOW582lyK75b1rkgubs5idrepz3Wbm1ceX?=
 =?us-ascii?Q?LMCyEQxv1danezTvaXCZyAtlhTgWpanKF0UcGVYgq/B0jUPpDlFLXEZH3/Ab?=
 =?us-ascii?Q?vSL3qGOIFoWpGTENKgTBSMzN+sg8k3dfQBbGr+BBXuChlsdv5wZo6DtYOtQH?=
 =?us-ascii?Q?+zNrQ0rzHpVniOrAQYOCwPg6qfHFzzbTKGwXxW2mtj3gQfWXPjKtGwWFezlz?=
 =?us-ascii?Q?4ibnB8qkvNvHc18BvYcRHDHajxUkHqjMX+o7D5OZNGWEmCd4/acDADijbX8u?=
 =?us-ascii?Q?9+Saa2IM3v7jFtzrQkO3on6LLzpIVvKuLUDhJUA4gmZcZD0PvO75PUgnT+TI?=
 =?us-ascii?Q?pTwhpxuiihQdUry7w3e6jpY/6JHNMntpf207mJxl1m5HnuUafGgkB58JXxJS?=
 =?us-ascii?Q?hdQw+egdgr8U5maaNM6NyYBbPbz9/Lt7lo/LfmE4K8WBWxF6pFThgrQfO6cc?=
 =?us-ascii?Q?WOj30OPn9TGv2Uy7C/X/r9vOSV5Rjl6vwE24O2zvl+r1T6/u4xQ+zYDTFVpF?=
 =?us-ascii?Q?wmVDeCvI8jmoOL7cv3vLZE0/tSj4ow5d1EzIJQwEdErjROGg3CTlgsKFFOOS?=
 =?us-ascii?Q?qTwwoQ/54wdnFNbluqo74VwDvHzKIj08dOyfAOJAR+moyTPXhNZsUvnOGamn?=
 =?us-ascii?Q?tavwFs8ZfO3GBH/ByL98YdJIrbcZ1KZd1uvGpXhvrvb+kl4WSaesrFaxClte?=
 =?us-ascii?Q?kQLZSNA5ci4gPDJFyOAW9GZLksGfCNVFphGn?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 13:54:49.2577
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f3143a0b-0e16-47bd-7ab9-08ddbfb95648
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003446.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8250

From: Carolina Jubran <cjubran@nvidia.com>

When changing a node's parent, its scheduling element is destroyed and
re-created with bw_share 0. However, the node's bw_share field was not
updated accordingly.

Set the node's bw_share to 0 after re-creation to keep the software
state in sync with the firmware configuration.

Fixes: 9c7bbf4c3304 ("net/mlx5: Add support for setting parent of nodes")
Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
index b6ae384396b3..ad9f6fca9b6a 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
@@ -1076,6 +1076,7 @@ static int esw_qos_vports_node_update_parent(struct mlx5_esw_sched_node *node,
 		return err;
 	}
 	esw_qos_node_set_parent(node, parent);
+	node->bw_share = 0;
 
 	return 0;
 }
-- 
2.31.1


