Return-Path: <linux-rdma+bounces-6443-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D53809ECD87
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Dec 2024 14:45:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7039C1886302
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Dec 2024 13:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E757236938;
	Wed, 11 Dec 2024 13:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UGPRUHVP"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2060.outbound.protection.outlook.com [40.107.236.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B9DB236919;
	Wed, 11 Dec 2024 13:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733924659; cv=fail; b=Q3WLmth+SgRS0Xs2+VwEjmL2VPQVUrji+ZwAmLYd2DzYRPm3ti6/dog0eDErlF5i/Zbfj9lC/8OuOR3Fu5DUZ0eA3v+AF4MIh0CxOBqj4vM4PTRTmQMPInAGsjezksbNeOGiaIbkIpJmERzMwmCZPyK+cBuHBa09W4ZeqibDEWM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733924659; c=relaxed/simple;
	bh=9TqtDDSuwZoD0ajKjfMwirEClLWwUSqltu9nBnRSPiA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Yb16JjfmRo0BDG+Dmh2wDxn8AL1hk6K8yGjuRk6RJH/2wa0P7t7aedwPJc0kcearOTSUaMvQzk1WMdM4rmgAf8v/PuwA20aWWtgQV4WDhsPrZ7CRK8jCvypDv8/cd9lnI+rduw62xuPEssqmjKv0Cs2CG2dlv4PdeP7CSBV7ty8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UGPRUHVP; arc=fail smtp.client-ip=40.107.236.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vQdT93D8AEOChkV4GUVt5yOYc+lyqCeTT5BrvTKhrYyu7g+mbh8baYpJ56imlLl0hbnZ0+qQahuKSZH5Uj8CLCfRRqyjIH1fx9SIXmN6bGUD9+jokSPlnSk8jNGrd6TurgSH4xZjWBr9KOX239JzsaTUgb7aiQUnRWUiMhCHN4c2ZQKohez+rsS1ftmOmBGtaYOBjEhylVXKXZOGS1VX5HSwOcSXFSNzlYx0BC1Tr+O5/Ei18R5TcPBDxidw/MdSr6zahlOiG1vSu6mWEk5FSA4EPUETzaIYorlWxbETQortZW+ZCQQAzMWwqazEoh30l1COij3yz9Qz7q/ob7DGPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=whOv7GQNtKRd46sVFdr1KkLJUj0Mbt2EyfhsNPjVLFE=;
 b=VYpKoqKOFnOo9rkRMA6gpmr2w2lncdaGGVG2PuvADRv7HeUqFGdwNT/AmuL4knn+hdw2BLqoEvvF8FqGJ3b23quFD+GsAn6iexqHJ/rf1BaH6/rmjLbl3su+aWu4a5NjDZsP/wPrFzILaHqv6bOyrLKw5Te/htLPCz+L6aqeYDVMHBlLfiKKMX8x2o0SJY/lfo7pbwOsKSDvqCYz4+8EW+lNeJHgeF8hFwF00QXsKadViK6aXhBA75IAXLo2vHJlm/nzOXAhx8VFviSVk74jvOjtmYy9xBYjHkBc7ob1QCuG98oeRnZVV+o8GRNvp09dzA2vt41/zex9yGim4En/Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=whOv7GQNtKRd46sVFdr1KkLJUj0Mbt2EyfhsNPjVLFE=;
 b=UGPRUHVPcx0wOjK3tngQlOmSfqxlAZGs8KCDNDUv+4VECjCcDnQobQPmSu4l/BB/Hu8KrVpgcaLCPdBqmQuy3dcVakkQOTLh0YRk0tqHXEaYjj2OmRbgsGYB00qS0n+wqHahuKxroCaIOhoUmDklDDZWyincTe52LtCddjAIS/H/2kqbNZAC+zgO/ekTETUrXWTIqDAtKRpqIEzUedJ1WvgUbsW1nKrlVTuIQo5RPSVWu5J0gnFZwwnVW6EVuBEkfm4Qd3f6kckGe/FFudJto3zQoZ1Xi87rOUWZ+LKsFBdFD0A5Bbw8yOMqYBNsRihEgJ+of+uMl9sUUqukggG5bg==
Received: from CH0PR13CA0022.namprd13.prod.outlook.com (2603:10b6:610:b1::27)
 by CH2PR12MB4149.namprd12.prod.outlook.com (2603:10b6:610:7c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.12; Wed, 11 Dec
 2024 13:44:14 +0000
Received: from DS2PEPF00003441.namprd04.prod.outlook.com
 (2603:10b6:610:b1:cafe::91) by CH0PR13CA0022.outlook.office365.com
 (2603:10b6:610:b1::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.11 via Frontend Transport; Wed,
 11 Dec 2024 13:44:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS2PEPF00003441.mail.protection.outlook.com (10.167.17.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.15 via Frontend Transport; Wed, 11 Dec 2024 13:44:13 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 11 Dec
 2024 05:43:59 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 11 Dec
 2024 05:43:59 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Wed, 11 Dec
 2024 05:43:56 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, Leon Romanovsky <leonro@nvidia.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, <linux-rdma@vger.kernel.org>, Mark Bloch
	<mbloch@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next 06/12] net/mlx5: fs, retry insertion to hash table on EBUSY
Date: Wed, 11 Dec 2024 15:42:17 +0200
Message-ID: <20241211134223.389616-7-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241211134223.389616-1-tariqt@nvidia.com>
References: <20241211134223.389616-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003441:EE_|CH2PR12MB4149:EE_
X-MS-Office365-Filtering-Correlation-Id: 22bb4869-76de-4a73-12d8-08dd19e9e665
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pB46T3sG2neamG6JuqNN5gPiBqrZ+PUVm9/VyMOn8u74vnl8VQL3LVSnEi1S?=
 =?us-ascii?Q?E0JDh8prXMNpQit+/ufQNPKapl522tK60ja7Nzlp4kcX6yBgQNeftR70Y0A6?=
 =?us-ascii?Q?Lzo8j8aDmeNYnPzeBrhHGqWDqdEnbPOByNlQ4F5EI2Olj3dt7wX2H1fQe/My?=
 =?us-ascii?Q?AJ+rk5c1XXSXJZ8rP8e2Sc8JIgL6xdYGqiWG1V6i5Z2JCXcKs0/6ViBFsS4U?=
 =?us-ascii?Q?QeKKeXRFMPNX6RGS+OkJ9mv3df75UNop+5+UGQnwyy5BwS2KMJppmPvSwUlK?=
 =?us-ascii?Q?9F9NStdXzCV/nNX4pH9BY1LfMXaHF9b+4fmjsJeNsh/g2lsD69Q1m85tmQ9h?=
 =?us-ascii?Q?OclOlaPe9x41K9qtkQxh93kEbL7F2euYnMUEadYJW86d26xKkU8kaDkOmMmJ?=
 =?us-ascii?Q?qrnuodjZ73+dSzrIS6dzr4xvXlF2yaKy1Xb0T5BZiFMZvJZBkBFCaRGPMqhS?=
 =?us-ascii?Q?3vsgD0hAm9pujDJscgX5wmmjavi3RvN4MECA84j+WkLrkuGEDeYVQgqkylWd?=
 =?us-ascii?Q?54Ud/zqmEE9jmkaDcZEG+UjIfAPVj+KDHM5jkk5ptgyTH0HKZSEi3wDxbnz1?=
 =?us-ascii?Q?KiNbtuEUz4DJADp8mSj86fld3Rqhv5EiCBapu/XDxU+/Tw8PhNbdprev8FI0?=
 =?us-ascii?Q?iz26O+4S7hivnCQjjCK8yQ8lOvbzyW2QhcuUCI9a8YRYUgp+KAdBrOnW/mfe?=
 =?us-ascii?Q?lu2i98Jy6+RjsH6cr4Ew86FFsW0Vw64IsIOC4fdNU7VCiAeiYQMnCU1L1WY3?=
 =?us-ascii?Q?n2ZoBUah18ysotexMxsx/nLvjqAtibR6DzEX59Q2Gf2zhgIJt6bIyFWi1gO+?=
 =?us-ascii?Q?2BGUUHNZ4lFRWcDFBYsPVnBJOzzbmPEEC2YuGWpKxUI2Gh/sc4H7yNSMctcn?=
 =?us-ascii?Q?6KicXTp5ynGT+msb/C5oWTzm6Qh11XSgRkaXgw7tayDARAZ5GZnr1pLBarVN?=
 =?us-ascii?Q?af1iDM9kBuYkWd9EYFtnlo3pgluxNHcJnl9NUEeskj6hCX1dOboYYlvAZ7Gc?=
 =?us-ascii?Q?ASwynv8NpeslSV21j04aErTR7/H4Ezy+S7mXq8uQ8Wn3WjnPrssS7JB26qAK?=
 =?us-ascii?Q?NvHBVupAfGQrnffYz8FMCchoQzOT/iMWwWb4taR0E1qItZ5t+ruUG7bZbzmX?=
 =?us-ascii?Q?1azGWEAEoeDpmpoZQdGz7+1L/iOVxPbFEFfQqcn8pq4h8UBsZ+MUfJ1wgD+z?=
 =?us-ascii?Q?bMDHFRE2L6vSS8Eqrj1y+7upGUQIVQBO0Ie9XsCv/iyqnsv4MYIfXyYc8c66?=
 =?us-ascii?Q?Iy1k/XjVV9gR+MRF1YHNjWJE7//waGSu+XGm7dJFL1mTSuWj16XxPfFPycad?=
 =?us-ascii?Q?jJYq8xDHzpf3ocnfxv2Ft7iWXUOzuITLEaB8jTezxtkMo650RY4Ou1QKMghx?=
 =?us-ascii?Q?DHH1WxQ4fmSL/78zYq8XugEJw/K6q0rZ9aTY16d6jDBXDy0L7AnwjyiSLm/f?=
 =?us-ascii?Q?L+w5B0Dt/eu3h3COyFFvTXOzdNP5JMiB?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 13:44:13.8530
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 22bb4869-76de-4a73-12d8-08dd19e9e665
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003441.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4149

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
index f781f8f169b9..ae1a5705b26d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
@@ -821,11 +821,17 @@ static int insert_fte(struct mlx5_flow_group *fg, struct fs_fte *fte)
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


