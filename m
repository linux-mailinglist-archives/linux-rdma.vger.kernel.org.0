Return-Path: <linux-rdma+bounces-11154-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 505EEAD3C97
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Jun 2025 17:19:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A004B163E65
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Jun 2025 15:18:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0AB4238C20;
	Tue, 10 Jun 2025 15:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cnS4B0RN"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2056.outbound.protection.outlook.com [40.107.244.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39813236A88;
	Tue, 10 Jun 2025 15:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749568580; cv=fail; b=spWP9tfRmC5cpr01ZQ5T8kwpvkB88qAQF+a2ZRH2EmA2lyz87aVD1gvVCrfZVzSp67Mv8wDRA30k5Xp5FV8K61Zv2wVkeJhMB1nUTv87SbPQM/Gxyuk6hw697ZF4WW5y80G0CSM2fdLIUuQtxFh50/055wjg5qX30FMHj1MiV34=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749568580; c=relaxed/simple;
	bh=zsv2DLANkUPzkyHVDrYMcw4w+tsTZe9HjkO6CUj+4u4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ss/1ktj7M9yJIgsLr48ctQcFKA5DUQNq8OcJ1bgsTaSpUJqvH9Mg5sBqlbkbFOhz+7jPr/RIp6BC4RcT1kxMfw0m0EWeC0YTjxnAGYe4w9kMxsN3Gg69AYe0GWoJJvW5LS4MWmLM3tKlO8qCTRBCK2lTUGB2ESqLuGaKZ2o6c+s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cnS4B0RN; arc=fail smtp.client-ip=40.107.244.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rYEvydFljqpyEoQeP/JwCq7ENugdWm0FZ9mD4zQHEox46Oj3YLOnMMxwp/COqg5/RgnVqnGq2nHpyGqpK9mzffRQICXsXubaNEzCwN7WrJRstw/xztKOqrXpUn/g+9AOC+uWRw5t8fnGIq5VbmyBXo5Sa8vftYBOchQU+r9ohDPbV48zSfAHPob9louDKubxGbyYOZFmMl8p7T2KkcCWf2slxylWepAQbqBECAJcP88nlJcpR4TfIeJhhSQsRrJnopwXEoBlcUcTX1mJQ2YYh4BpFbMKNMYb1ZBuGpQl6EW2hBHjM9kXiuk4iecis7/iTRC3Qsgk+mGSOGiMDHTNwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/aS3N2bviCvyn6l0KmefJnmron8mNqEu/E839fvwTQU=;
 b=RQBm4HaulpYnILvGUV9TgVN5c5aCETTXE/eKh8PAiw5xbEHHvfX39tznnP/z3Co3+RTYopDnWf50pgs3FQ3z808hX0BLkJYvPDCQRbSEU/4U/E6s7PHXwhm89AKXDTysAtm1O2y7xzLfpUm3OVqJdKmWY1C9TnX3KWGNZA02Tff+DiOeJHuoGz/FRkGt5CW9nU3BV8qeeZA7XHNyFs/1lC7ZKd5T5V95Wi19ik+RB50w1dEhzYFh3oAtrcI8+HMdxEz4MftQ9VoD0/eVykgRa/i3M0p0S6jmYmHkIOP691I4VZV1nzcFOgqZ3S9TLpOr5iKxmxly/OKGgI8LkWWmIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/aS3N2bviCvyn6l0KmefJnmron8mNqEu/E839fvwTQU=;
 b=cnS4B0RN2fZh2c2SHiqdErD3S1W0JloMd//ejE3Hv2zGiCb9u+q9/C66Hthu6pab3WKgZdB6+bG8TYehz1UlZlxNFhEQ9hH7YV6EeWWWapVaslIZyLkCsIqZAHLNSBnmIYCHW/1osZx5+MBL1owskosrcowDsNqsIBCXMoaLTIO8fmLIuWQRXDBXT0G1IXQP2lybcFJN7UREAXVCLTzxJ5zL2w+R1sF7Iqz5xtn1Ax2fKe55m4YGcGKy5Xa85jyyvPZS6iXbLGmQMD9fIiD+T7X3Y/NYKgTYvNV1orqnE5en4BtPfezfQoPF2jK4LzhxtEg30DmfrX/HZt0t8XdODA==
Received: from MW4PR04CA0119.namprd04.prod.outlook.com (2603:10b6:303:83::34)
 by IA1PR12MB7565.namprd12.prod.outlook.com (2603:10b6:208:42f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.35; Tue, 10 Jun
 2025 15:16:16 +0000
Received: from MWH0EPF000971E8.namprd02.prod.outlook.com
 (2603:10b6:303:83:cafe::a1) by MW4PR04CA0119.outlook.office365.com
 (2603:10b6:303:83::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.19 via Frontend Transport; Tue,
 10 Jun 2025 15:16:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000971E8.mail.protection.outlook.com (10.167.243.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Tue, 10 Jun 2025 15:16:15 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 10 Jun
 2025 08:15:49 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 10 Jun
 2025 08:15:49 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Tue, 10
 Jun 2025 08:15:45 -0700
From: Mark Bloch <mbloch@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, Simon Horman <horms@kernel.org>
CC: <saeedm@nvidia.com>, <gal@nvidia.com>, <leonro@nvidia.com>,
	<tariqt@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Vlad Dogaru <vdogaru@nvidia.com>, "Yevgeny
 Kliteynik" <kliteyn@nvidia.com>, Mark Bloch <mbloch@nvidia.com>
Subject: [PATCH net 4/9] net/mlx5: HWS, Init mutex on the correct path
Date: Tue, 10 Jun 2025 18:15:09 +0300
Message-ID: <20250610151514.1094735-5-mbloch@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250610151514.1094735-1-mbloch@nvidia.com>
References: <20250610151514.1094735-1-mbloch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E8:EE_|IA1PR12MB7565:EE_
X-MS-Office365-Filtering-Correlation-Id: 633d8c20-6419-4c81-a3b7-08dda831be91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6FYZaYDObpMVJaU5oPAEhUswR8J8Wk8mEvrn1wXsh97H5rAMAtPHmm1BknlG?=
 =?us-ascii?Q?oJ/UoV0os/ZysFrKEmV4lrSpO+NKcywGM0R53b1ISNKLatiPugkRZhHizL0A?=
 =?us-ascii?Q?XMitIx+oRxsqCbaqZI860/pB3kE9YOr5LNqvPxX1NHyI/oIfmivXKBThLkN8?=
 =?us-ascii?Q?YgIgiVS7Z+0BpWluEkG7pVa5gZxxt1zJFr4CkH1jyv7kl2f91Mfm3MALrKoX?=
 =?us-ascii?Q?SpE0xL7GixSuYxMU5Z9JxAPTBSXI2q3jcrffbRRwFzz+rTGw+Mq3wNg8MGkh?=
 =?us-ascii?Q?+RSCFUbGD9nD2tfePB4kHIsa/9wJoIvUllFNdU5g5BWAVXYdL2WC7iRVVER9?=
 =?us-ascii?Q?4BGwBKhydSK4AF+tisB0pPdnS/NuZpCUz6zTgEzuC84t2jqmTgCFLav9ehcK?=
 =?us-ascii?Q?LkUaBpSJ4k0ShXeJJbF7sffbu3hz4IEED/ZeSLb2Xbjt95cHIxDGpo9BHU3c?=
 =?us-ascii?Q?YS4icXq0MSIeHcEJA89HOtPCth5NljSdRMkr8zRrAZN083A8NO5YFAFlIS0J?=
 =?us-ascii?Q?b8eKvBM3w7mzCHToQfHp+iVwcRSSd2nrJ5b+CqtFzEgGj2ngGnpvB5UUcEKn?=
 =?us-ascii?Q?5YOmun40E7/KsmwbeFuR4KKqOn6w79CBZdBUcfeOdjhD/gg2Pcy3gfS3GgiQ?=
 =?us-ascii?Q?s1nkzl5TDFaW6ldiPJhN4zgCfvleH2uA+nUG4u8ffWK0LeOjgD9v9EQYVJ/3?=
 =?us-ascii?Q?q/jF2Ywhm5GbossxLrHB7kaHzMDVmyptQNfBlYYEglzdLCV3uH1aKEycjdtc?=
 =?us-ascii?Q?ehLABXSd1VcotIZdnkP0cwy4gYthIsfc1p8HUVJ17qhiEBmJm4Di8ax1rRLW?=
 =?us-ascii?Q?/KRdPfUW4k2iUCnUYVEvhtbCP6q7Mkw1j5RO8cpWDkb+sz0z+lElpnSDqxcs?=
 =?us-ascii?Q?gTcQv+Iv5UK4U/X8v8T90UaNHqZ+wEsGpsrPZpYt9Q6LSZgiyE5FsDucd+Tn?=
 =?us-ascii?Q?Lsl/dSqQFhUvUb2pMuvx/bmfvvBUpnKXwfv3xv2EXvnmhpm4l3w1p/Kh4K7E?=
 =?us-ascii?Q?CbnKw1R933GZmNS3Dk9oJL1tyU8Fq4X5Quc3vuhy7M5zS+5S2Ce34OQU9M/S?=
 =?us-ascii?Q?jP8UoQZi4Z9GH+SyqFEKE/1h3UuaDX6Yz7OqPmHmdDhC0fRcPWT6iFcIDiTH?=
 =?us-ascii?Q?udADgVGatzqwHyBlkUoJyXBnw+pyIsXXZ7DbxCZQ3vLJPd9/8xF3zf4bvHNz?=
 =?us-ascii?Q?1+E2DN+dRXggo+R0LdPWT29jOC4otoB4mS4dXMSJCySYVIHxEL4lFFc/QvAe?=
 =?us-ascii?Q?Dq/LPjVY3lzsfgbxQ/qoDC+M1MSAMgDyT+AZ62c4adoI3lq7cRqQ9UOlK7l4?=
 =?us-ascii?Q?c4gdnXfsVc6A/5gihrblFELVOEDuSATo8iYqoOJv38Ey6RNHlBP97t7dRIx9?=
 =?us-ascii?Q?HrNZes5HZOK52076XjgPhIzhn6PZxiy1XViKABCeJHBJP7fX3h161LMzj6zA?=
 =?us-ascii?Q?R8AHp4X3oW/aHqtnRC75/lzeM+FljBNazjHoGVt543MT608CXtmkLcDJxWaz?=
 =?us-ascii?Q?dFnvN1yYHTqazwnJefNqBnX48IiKHMP1nFQ4?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 15:16:15.9631
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 633d8c20-6419-4c81-a3b7-08dda831be91
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7565

From: Vlad Dogaru <vdogaru@nvidia.com>

The newly introduced mutex is only used for reformat actions, but it was
initialized for modify header instead.

The struct that contains the mutex is zero-initialized and an all-zero
mutex is valid, so the issue only shows up with CONFIG_DEBUG_MUTEXES.

Fixes: b206d9ec19df ("net/mlx5: HWS, register reformat actions with fw")
Signed-off-by: Vlad Dogaru <vdogaru@nvidia.com>
Reviewed-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
Signed-off-by: Mark Bloch <mbloch@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.c
index 9d1c0e4b224a..372e2be90706 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.c
@@ -1357,6 +1357,7 @@ mlx5_cmd_hws_packet_reformat_alloc(struct mlx5_flow_root_namespace *ns,
 		pkt_reformat->fs_hws_action.pr_data = pr_data;
 	}
 
+	mutex_init(&pkt_reformat->fs_hws_action.lock);
 	pkt_reformat->owner = MLX5_FLOW_RESOURCE_OWNER_HWS;
 	pkt_reformat->fs_hws_action.hws_action = hws_action;
 	return 0;
@@ -1503,7 +1504,6 @@ static int mlx5_cmd_hws_modify_header_alloc(struct mlx5_flow_root_namespace *ns,
 		err = -ENOMEM;
 		goto release_mh;
 	}
-	mutex_init(&modify_hdr->fs_hws_action.lock);
 	modify_hdr->fs_hws_action.mh_data = mh_data;
 	modify_hdr->fs_hws_action.fs_pool = pool;
 	modify_hdr->owner = MLX5_FLOW_RESOURCE_OWNER_SW;
-- 
2.34.1


