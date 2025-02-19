Return-Path: <linux-rdma+bounces-7830-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77923A3BD36
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Feb 2025 12:44:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DF7E16FEDC
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Feb 2025 11:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E1601E231A;
	Wed, 19 Feb 2025 11:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GcJ/nzV2"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2044.outbound.protection.outlook.com [40.107.220.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E901E1A14;
	Wed, 19 Feb 2025 11:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739965385; cv=fail; b=Y8iCfLgApuKuzEXxzP7QRnPBa2V9dXKpVdB3NYlK/ZV5IE7wtNC1rh1G6pnaLcrSMjqqhql5CwJ5/ZDKEIHf62e+RnCC8Lso+YwUQYEoXPyd9zfmV6+Neuw5lvWkEy0grrkfFuMV9i8vO3r8bRN2ozctRcqlU6du5RgRG7xy8tk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739965385; c=relaxed/simple;
	bh=SJVHBjbCHmaZW2EPZ2BEL8l9uAf82QQ1W3M11oJf54k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZyY1S2JpNOgm+VNY66FNRQLdsiczwmdzzq9uakuGs/eQYemsj8vACwqwrqLXbBF3UGEsSgVmttoIxTXmu0tigR6+McbUp6FiFBkpO8jJS24P04tooMItdClff+mMaXyGaxMpVQsZ0Npu2GOGDwHJXkeGhdsTWnLyypm+NXoc3Ns=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GcJ/nzV2; arc=fail smtp.client-ip=40.107.220.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dsfxOLQGZ+Cv3qwpzM7KCSrobQlZtT8qTQlNTukLqJNlvTZF80QdR/5u/RVHoQhKMy+z+Lu7BiFvKjgn2TexJI8uLNnOx1eGzlpxQDPjvy/mq+B/PffPAU1Gzkn41tP5dlMkiQq/f9cFz/X6+S4Y7eiyn8Ppfe8OOLDK7CcmWIFpzT3KLUo6dQKv3z77w5yuqGXpdGm4/wWuiY+tDVOOrkfuoyX/9DfD3ii/ggQwyHdeJGT/lQzceopHlW84+b6UA1fpR4M8rqhqDuYGUav43J2MfAqkRQoSP+SxieMZ+R++8M5b4WZP+sEaBUr2tT4y/drPbPjesPwW/q/hyXIetA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LEdyI6RRkFCHrfsu+fGlMK7hNxoh5HfZyvST+DpxF2U=;
 b=wS+kpBCn4dYexZTTzelCdMZjrOJDOXHR+bYjBCUQDzhANl7nM24bROQ8vge6nRfk/tBcUw1KGxT5XNv8ZWV4i/jJdhOLAvdqGQLdN3JVFxc4VW0y37dAeAeC0RU59RSLcEnZVD4GFFSRDMVvN8bbq4TXQkej54CjBDzEZ7Zttx10ekY3RMy0UljJGlnciI3bQZbex5PGzXJx75pEVKAruGJNpq+lvM3SZfMcyh3m9hQ4kA1spZ7/pSVSuF7+/E7H9yLPU2Vh7mDVdbJZYaKVFlbLoUAVPji/hzoJdIwprckifGA+f0VTJ1n70t7y9bFOs00CO9zkZMlVBy25MXdL1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LEdyI6RRkFCHrfsu+fGlMK7hNxoh5HfZyvST+DpxF2U=;
 b=GcJ/nzV27AQ0XkBhUTCg1p4spL0WNXvT4tFztn9vh6PvILVHFvELSjbNNc6/RVPcAto68qjHtymMyPKziUOsBIcERNqr6Bo4IR5+OZA+oxhDjlA3Mw1iB4DJ28gwhEQuV6wOuzm9dxeKuQd5PGUESCQNXoAfKJmvmlcwq4n5U3aSOlRlEajwH9STU4vfwYDP7rmOBIPdyw856GbDjgPRnGpWc0+nnpRpmIL4hc8ySZfsoPxpI/Q7NQXvwnoNM4LkDOdTRlDb4Lhw46NmmsHEXy3+aUQwC3C2suqPyi9r7Ek+71c67auadC4BmZKdVtt/eFUyspTdBGojWOq7mpTinw==
Received: from MW4PR03CA0245.namprd03.prod.outlook.com (2603:10b6:303:b4::10)
 by CY8PR12MB7364.namprd12.prod.outlook.com (2603:10b6:930:50::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Wed, 19 Feb
 2025 11:43:01 +0000
Received: from SN1PEPF000397B2.namprd05.prod.outlook.com
 (2603:10b6:303:b4:cafe::e6) by MW4PR03CA0245.outlook.office365.com
 (2603:10b6:303:b4::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.19 via Frontend Transport; Wed,
 19 Feb 2025 11:43:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF000397B2.mail.protection.outlook.com (10.167.248.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.11 via Frontend Transport; Wed, 19 Feb 2025 11:43:00 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 19 Feb
 2025 03:42:46 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 19 Feb
 2025 03:42:46 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Wed, 19
 Feb 2025 03:42:42 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: Gal Pressman <gal@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, "Saeed
 Mahameed" <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Tariq
 Toukan <tariqt@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Shahar Shitrit
	<shshitrit@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>
Subject: [PATCH net-next 4/5] net/mlx5e: Change eth_proto parameter naming
Date: Wed, 19 Feb 2025 13:41:11 +0200
Message-ID: <20250219114112.403808-5-tariqt@nvidia.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250219114112.403808-1-tariqt@nvidia.com>
References: <20250219114112.403808-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B2:EE_|CY8PR12MB7364:EE_
X-MS-Office365-Filtering-Correlation-Id: e2a6b397-1ed6-4880-299e-08dd50da9000
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?I6ZbfCo+tXHr5VwnxhLCtysUaSw4xkFTL+VF8kfUBZTxCt5GPTwoKi8BLszf?=
 =?us-ascii?Q?Ia4O+2JqyHtldWrKNskoLoLjOnRdM+tl8MLme1Bup7PT4hHdt124IxYXYpvq?=
 =?us-ascii?Q?bvVpKWsvL8vQGHyQqKY1sR+plbGRwlwRj8xlynAaogLgryVhPLw1wJxIQRk8?=
 =?us-ascii?Q?5+omkFoQ+J7GF1gQEcYb10McuYVTp3UZWiVUEm3V8xpf4hj7eK+A9yrm8kw+?=
 =?us-ascii?Q?vE4/s8ywPT3UpKM7ozeGy6B8LnDVtIScONMYPAqYqh7m+0fFnKrT8dTEgVWs?=
 =?us-ascii?Q?vnx+mwda0a7DODK7MQYd2xANPAHL/YM7QxSwReI9HxYbcQxMZyQu547+cMJV?=
 =?us-ascii?Q?29ok9txDgTTawBHjsV79XYb11sw6+LqJTAgtmtBkMwCs/WRCW6SVnTRh3Tds?=
 =?us-ascii?Q?4KpKDQduPxooe4rUJi8eJ1essQ9r8CXZVPBat3FMkpyHDCNYkUEnGMa2ZKQr?=
 =?us-ascii?Q?eU5JM62hr5ubijbIGiRJnOHne3ZcATlRHUezqYFYNErqIuXJXdVx2m1U0W7O?=
 =?us-ascii?Q?2nwFhsuuq8YLeaFdWe7HAS7+9hT8OVWS78Gz0ayxmXU+N0Id9Toaz6rJhQ1r?=
 =?us-ascii?Q?IVuuRedKjOqQGMq29CVg4aRp4wEZsjKpVf+oB7HQvhcIRYTNPWcvPu8PBm1F?=
 =?us-ascii?Q?aT7nxU6oGrTA+bieMLaQmrITY9Huag6toyGEBpb6uKyuDm5NEqg4Msv1iyO6?=
 =?us-ascii?Q?4zgnZYEmV86uceJ5wMGtbzrjI7T0dXeJp2Mw+55uxJOX58y9PaepKppuBWFk?=
 =?us-ascii?Q?3i4ASTXUP5z6qXi5r6at+XsNM+uD3Dx0HdKUOeWR42t8RdCRXJ1Dl9WENedC?=
 =?us-ascii?Q?IqfJLRxTUO2gfm8A35V6IC1NQMnj3larrmIIgWGHlMHCNbLAySzXwRB2fn/R?=
 =?us-ascii?Q?9jXjQ4HKZCFR+vsZDHVMVoAfijbIRRc21W6adAjjaCJOSjKV6PIdzE9AmePI?=
 =?us-ascii?Q?D05h9ldDnOzT60XNU7A7p3RnuwpoEOht/NkxiuVAlNfvg8armNyVeAm7VSGr?=
 =?us-ascii?Q?jgh8QelgsZlMb7BghgXfdAwiyi1AvgRC+4L+nE7ShO7ja+4sAYhw0jMKWH4l?=
 =?us-ascii?Q?zQ0vtYVxBVxSJwsdqVHUxNRA/jm+MwpKTJnmW8N/hQbOKg2aelfp6LuROzlG?=
 =?us-ascii?Q?CDjQzl9VsgNlkLedlt0AdozQ/xBcZELj3dnPtyLpSZdPSOQM7+VWiddx+PzG?=
 =?us-ascii?Q?omviST7UO5owo8VvhLPHO4oitCe0QORlc6NpXol2iVWU0Mf7CpwL0PFvF99h?=
 =?us-ascii?Q?sudHOHuxduBY4JrIAEycotdO7YNuYImm806q1ki7KrPMUJ7omG6BuGPyQgP8?=
 =?us-ascii?Q?58riZwF6kkzw0J+fyFjJiLLn0vVf+7+8JemJkXS92AoCrvj5gKxEGZmCttTp?=
 =?us-ascii?Q?kAHPCRnCWVJnwnc0SyT9pmrUSYcQ2t56eOlvMJyX1iHGtBXGzlW93TgT1/jt?=
 =?us-ascii?Q?lX/jqkEn5RQIA5YKS7a9JWZCoWlwUicJxxvOxGSLI4bNacwTeJgz/aY/d4PY?=
 =?us-ascii?Q?5L80V5ge+HOiNRs=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 11:43:00.4094
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e2a6b397-1ed6-4880-299e-08dd50da9000
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7364

From: Shahar Shitrit <shshitrit@nvidia.com>

eth_proto_cap parameter represents the supported link modes,
while eth_proto_admin refers to the configured ones.

The function get_advertising() retrieves the configured link
modes, thus we update its parameter name to eth_proto_admin.

Signed-off-by: Shahar Shitrit <shshitrit@nvidia.com>
Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
index 6dab58ab50ac..712171dd07c7 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
@@ -1115,12 +1115,12 @@ static void get_supported(struct mlx5_core_dev *mdev, u32 eth_proto_cap,
 	ethtool_link_ksettings_add_link_mode(link_ksettings, supported, Pause);
 }
 
-static void get_advertising(u32 eth_proto_cap, u8 tx_pause, u8 rx_pause,
+static void get_advertising(u32 eth_proto_admin, u8 tx_pause, u8 rx_pause,
 			    struct ethtool_link_ksettings *link_ksettings,
 			    bool ext)
 {
 	unsigned long *advertising = link_ksettings->link_modes.advertising;
-	ptys2ethtool_process_link(eth_proto_cap, ext, true, advertising);
+	ptys2ethtool_process_link(eth_proto_admin, ext, true, advertising);
 	if (rx_pause)
 		ethtool_link_ksettings_add_link_mode(link_ksettings, advertising, Pause);
 	if (tx_pause ^ rx_pause)
-- 
2.45.0


