Return-Path: <linux-rdma+bounces-12256-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33FADB08C73
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Jul 2025 14:06:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72FE758801A
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Jul 2025 12:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65AD429DB76;
	Thu, 17 Jul 2025 12:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qAZi0m+v"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2052.outbound.protection.outlook.com [40.107.92.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA24627AC41;
	Thu, 17 Jul 2025 12:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752754002; cv=fail; b=XH4H51GIQx3H/6SOmGHxbXqL+q3b06+olXu+PnfZ3ztv1X4xAA8KZIXyrJ6UaUGoMcdRsDbqHFjo5m0El4LW5j7/29tkl8J4efGEO3r5jZcE6HFfHSSzGgu6X1FZuP+XBmipGKNF3Pz+zoktmW46T6H+wM9PHECNXVliAbxjKk0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752754002; c=relaxed/simple;
	bh=RIc3HgzunQf24ymqF5kpKHeYk4rHiSi/sH/6vZR6I3I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BcDQGCHBxUXm0H73vxWAOdqVEkKjp3rDxvtdiKqKSIEjVZ6AE0wSHmh0OG/StyPn0P2d+DjyQcri8vl3i9VZi3B+fUOiOph3emfUZykjwgciIKkZt1q9S3sESvJjhjECgRIVqlgVfHLLJ+odSDcdf2YVfngTr/xRRvqus0iyxoM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qAZi0m+v; arc=fail smtp.client-ip=40.107.92.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HEO3bAYMPxL7T5PNm9H1Xxj2YYe6a7nAZlGFeo1CL2IjObMaaq0t5SVAdMmNvJe9w8EwyioGrxIYmrZjQ3gGgGuliuEP93iumJW371g6VCxCsw2SIPFe+xwPRPPVEgO4rUhpTFsXRSaqeVKmIqLt+WPv4P5dDwmqshS8gEpA2tQ/QQ0unXR47OqhePYRuvfzS/w3uhhI6Oh+rEXeY0qCsLeQKjwg5fHIXcOHW9ePOlr0dVWlSOivbdIH3OwzfIpmiSd+TNtWT2XhYe/HZ/UNq0gcFY3OjpwyKVt9Z0jRSL8gQU8evJk1hqzSFnhA0RVS6zwAZZlOcRT0Vs1C6S7sPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ersXS8hFGaQ/V2rrMvXGe9NHQCy5xah96lGfjQhCjrU=;
 b=tqeTQYI7+lcutNv7IHmpZjyf+Egn3gNavaZOYihn2358feZTAHsIDtj0wv6dpgLCIWVU2fk51n1t0kyQHoXO/eBWEOhhHC3WGNOu6TqxVaNlmanjM00VR7XMBMntx00mtnPQlakOKH2HVS83EoJUx4oDdqqfPL/dzPT1bNX6yWA9HLYNGQh6NsinEeEc69J8ISKBnPd/iRUHQKFxomilSbmuCj9/Or2iohI9I2KQqqMpDAZmBoQurfShsmkZ+9IPmk5vrMIVUjZlMenu/7Lvl9FiR8hVOIM4ln/HdavB35mYNv5oLfkbX/Yts3SvYHotCE4j9frBNliC3p2p7U+Vfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ersXS8hFGaQ/V2rrMvXGe9NHQCy5xah96lGfjQhCjrU=;
 b=qAZi0m+vCNMnyudMiXwsCOt5prgfrlIxzvywE5on691XwWWzC80jeSO4Gz6Y59xQSETArph4AVQ/SjVrsRfrMIMkl+SyVSsYF5NgQ7wxyiMW6JNDLVHfXzA6tFiUR2jQhHYfQlPrtkZzEegDbVochztfqbG2UycQv6pKGuVvunqXjtJj7Y/K+lWuQspHaxWq4lOkX98RaC33z6RgTJ4RcTxvvFzBblXqGPwyP6MBB47nMUZlCnnXIF4/CflczQwEB2o18JBGJyU/MBmdzIk2QqpfMa44CqidtYgiRUNi3uN0zRX65K4z86KHiGgYwkV7hDZeYrQcwxnRKucSxWVm0A==
Received: from BY3PR05CA0005.namprd05.prod.outlook.com (2603:10b6:a03:254::10)
 by IA0PR12MB8325.namprd12.prod.outlook.com (2603:10b6:208:407::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Thu, 17 Jul
 2025 12:06:37 +0000
Received: from SJ5PEPF000001F6.namprd05.prod.outlook.com
 (2603:10b6:a03:254:cafe::4a) by BY3PR05CA0005.outlook.office365.com
 (2603:10b6:a03:254::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.17 via Frontend Transport; Thu,
 17 Jul 2025 12:06:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ5PEPF000001F6.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8943.21 via Frontend Transport; Thu, 17 Jul 2025 12:06:37 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 17 Jul
 2025 05:06:32 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 17 Jul 2025 05:06:31 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Thu, 17 Jul 2025 05:06:28 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeed@kernel.org>, Gal Pressman <gal@nvidia.com>, "Leon
 Romanovsky" <leon@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, "Tariq
 Toukan" <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Chiara Meiohas <cmeiohas@nvidia.com>, "Vlad
 Dumitrescu" <vdumitrescu@nvidia.com>
Subject: [PATCH net 1/2] net/mlx5: Fix memory leak in cmd_exec()
Date: Thu, 17 Jul 2025 15:06:09 +0300
Message-ID: <1752753970-261832-2-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1752753970-261832-1-git-send-email-tariqt@nvidia.com>
References: <1752753970-261832-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F6:EE_|IA0PR12MB8325:EE_
X-MS-Office365-Filtering-Correlation-Id: 793f280f-b3bb-43d8-a9b7-08ddc52a616e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AFRFUBt1pUGQ7v+J87k9sDmAHEWLnQ9N7IJKtSd/JxRPNAthLpN5FuV1SMFq?=
 =?us-ascii?Q?9eM93heVwt8dALkdP+jgqp5uVBTP2txQfnQo5IxEIU3tI2LsULtKM/cObgro?=
 =?us-ascii?Q?oKTuMCQVZuumeUnRoVZ5bwfuP/+0aFcFC13Y+4CWZ7j8eRXjPgbUjw0TrDIj?=
 =?us-ascii?Q?3b3LDsh0z9VAmuNsjUj4Srwu7w+mTiLKKs+1KuYsAnXt56bp0KZ3lk95hd4E?=
 =?us-ascii?Q?rdVRdngE8q6GhewwzENCV7MTCkD3ANwDTIUATbGBbo7AWDI6goX/9OpeubFn?=
 =?us-ascii?Q?QuG9kVNVnuZ+4k/Fas3AlZRZijnjijVkYYz6RiNeoOJ0FXKF9h++U802w/+O?=
 =?us-ascii?Q?MHhCEYl3OFWhxAi5W2shbybhYgOduHwZ2kcPK3h3Az7jYEvJ8jbxumqvEln9?=
 =?us-ascii?Q?+Iyd96NwgGE3AYNITSt2r+YMzMec2IV/1KSILI6FyzK71yM+VJgfNPxIHDUp?=
 =?us-ascii?Q?trWDsxfRgSWUiwT6HER3eXrOb5u6l18X3KAqJh1vXlRVnq9YO2aXyQqhMtam?=
 =?us-ascii?Q?oB0vQywjMCcmCNBHRuvxTgM2piBeDd/gZNwNVJ0uJie/y18e/KJ8U/rVPFLz?=
 =?us-ascii?Q?1OWbDEzmDrymg52cL7RkWJutr1Bfe7Kqb0uFKmxouVogKU4tYXKTPi3iutDe?=
 =?us-ascii?Q?0LBUOiGW117xvxlF6/X7vYrL1iYrCtO8YFXrFS7gEnQrGY/4ujD04GJXWmGP?=
 =?us-ascii?Q?45vuZFS0MMFKIFKPrdDiD7krEjf7iexbr8e6KM4k5fMTNRzqRkZhLaBGfUc7?=
 =?us-ascii?Q?P2zHG672m4PdZXOsl68yb/LcpJ5FICk5ETKn2vMyJP2zPOvOfeFISG5i3Lyp?=
 =?us-ascii?Q?5LY7PoNs4cjUb6arB1hy0gTJ8rt7q4W4wR+T16LMQwQIra+C2Mb7Hj8geNV3?=
 =?us-ascii?Q?hTmxr+gn7ejF7rNY225wcnkx0GNuAKbCoymxcQujffHMZwyT4O/RmPMBHWJy?=
 =?us-ascii?Q?9pinRKUOa7H5uB57BY11RVyF/AiZ0J4wdOAHsMXzzejArk2F8OFVqDnKfIHl?=
 =?us-ascii?Q?6T4B9xbv68aU9Bt8G/fpRgmhQU/TO0+dxr4rWSaeqWjxfRlGF6V4PL83MUyU?=
 =?us-ascii?Q?Ql8Pap4Fv/DFa3PFMbZUDIHpPYIciCJzI8uICRRzcHZafYVk2nhDiezqOlGo?=
 =?us-ascii?Q?L1DNTkzKkvUZyxg8Dct16YUYQMngtnx4D5HoRCLDc+B2MdbkMuaoNCIOa2pJ?=
 =?us-ascii?Q?4Jk9UeKOwyFanva9/7gt8bBf/RSSzFmGRz4F+Uers7f9uSekiS8OdW3hrFJ8?=
 =?us-ascii?Q?qZYwtE/Ijsyo8VQmxXbSZxLDVJaHz9udTQkA7aCcZQIzO+Q1MuoBIfSG3/+g?=
 =?us-ascii?Q?qGZjH2+jZWjKd/Lj6Gd6hqVFJK0uSE8Q0c6ieYVe7/XI47TE5byVxULasBsz?=
 =?us-ascii?Q?KU8OSAx7zWrUzzVl81kcNjXF08YkOGLOSDUPW2Ajv50wWb0gcdS4ZX3gActh?=
 =?us-ascii?Q?fUJpoCwU1W7oXxQA+kpe0ecppt6teU889+mKTvjBYbSNupcKnbPM/HkEbOKX?=
 =?us-ascii?Q?DtsOcdkcaI+d2G7xXeJWXwjGw4FMbaBbVkvm?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2025 12:06:37.0217
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 793f280f-b3bb-43d8-a9b7-08ddc52a616e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8325

From: Chiara Meiohas <cmeiohas@nvidia.com>

If cmd_exec() is called with callback and mlx5_cmd_invoke() returns an
error, resources allocated in cmd_exec() will not be freed.

Fix the code to release the resources if mlx5_cmd_invoke() returns an
error.

Fixes: f086470122d5 ("net/mlx5: cmdif, Return value improvements")
Reported-by: Alex Tereshkin <atereshkin@nvidia.com>
Signed-off-by: Chiara Meiohas <cmeiohas@nvidia.com>
Reviewed-by: Moshe Shemesh <moshe@nvidia.com>
Signed-off-by: Vlad Dumitrescu <vdumitrescu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/cmd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/cmd.c b/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
index b1aeea7c4a91..e395ef5f356e 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
@@ -1947,8 +1947,8 @@ static int cmd_exec(struct mlx5_core_dev *dev, void *in, int in_size, void *out,
 
 	err = mlx5_cmd_invoke(dev, inb, outb, out, out_size, callback, context,
 			      pages_queue, token, force_polling);
-	if (callback)
-		return err;
+	if (callback && !err)
+		return 0;
 
 	if (err > 0) /* Failed in FW, command didn't execute */
 		err = deliv_status_to_err(err);
-- 
2.31.1


