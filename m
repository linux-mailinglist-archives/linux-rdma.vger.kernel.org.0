Return-Path: <linux-rdma+bounces-6493-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 700B79EFF18
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Dec 2024 23:15:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C524287E02
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Dec 2024 22:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC4641DE4EA;
	Thu, 12 Dec 2024 22:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kaZWPKsx"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2069.outbound.protection.outlook.com [40.107.220.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D708A1DDC14;
	Thu, 12 Dec 2024 22:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734041721; cv=fail; b=JAfKikphmsPeYiGkf0qBfPWoByEM9yGhNSHC6inxoeveXO6apwL4uD1/6aLZCRjczQ7vDdXRdWpEtAZ+Fw0GaTUyHQebSrM1UONL60Y4TqYUygNgj4Ns2J31UrF2xNukYcITMuEWRcIvu0bdPUwX1XvtDAngZj4BRMsGsYqH5n4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734041721; c=relaxed/simple;
	bh=ps4aCLxSgG5gNBdJnaJL7F+ga9XiU0M6OIa9skgp9NA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BdRhQ0ZUjEuXaHrli3U2hoYhhbA/yZBxoHeMpfqQy0L15lLXawr1dELNgE222MCo/IcIJZWbxdAVvFR01WM17zswYOxQy0Wqc4m7v2x7DqjGD60PQSJgfYnCEsjxX3XHFAks1q3LrNLYJAE2pJLLrdwjDIikRClxvPZDEa5XF7g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kaZWPKsx; arc=fail smtp.client-ip=40.107.220.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SIzzoWSpysXNGwX9UgQJliknblLqQ9HyPBGn9zV6fcntWcxfFndk+Ohq5nfdkrRgTwftws3cStGzk4XE50Ye3N4v5POPIp/WVMG2WwIrx5Vba5Deh3mxWpZ7KeFWpLzIf80ArdYplz6HCCLw8kEyXehmqBbZ+cIYTlFMKAclAyCkSPqNYpIY8p9G4lCpJID4wrokgZU/jU33iNUHXw5jsGIEUjSY5gyzj9eb0MzWVwU37/tDHsWtBxj8zDlSuAFpHvf/l/U4LaCDbAfqj90LtF0uy0jVKZp12ZwGPbRTnrVPJTbA1xBNRH1g8W+4pUyFMe/gbrmkKKgOJo+bS6ToFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sL6q/HkGem98gpiHQNeoIIMrYQlj61TLN/sCBIkgQek=;
 b=oGV70beRr17cNXdVP0Un3kmA+GGjZ2VIYAsgKGP7hPV7yw2ee2O8hDXtdEya3rah0Wi1FWKHykdXrWPi1jqF4wlqv1zH8JqbmXxGOqkGfv3DWQ2QP97NivvAasjAOahfpjvCtGQ5vft0Ku1qnNCYR6gH4tlG7QZcS178h2KDZzO4U9o9KRyv2K84qHPSgb4YOGabs2bpbR7dEI5HpthEmmaaC8mqNqMiEutSXnqn9O2yX0CQPceL2wFIIzaAZ9BtruLYZo333Qgye+Ggeo5T8mPlVABBtX135m0QOKid5Th1ZgqyFCAhDwadPylI1zCl13aGI9Luv8Ljv5vqwxh8sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sL6q/HkGem98gpiHQNeoIIMrYQlj61TLN/sCBIkgQek=;
 b=kaZWPKsxMGxqvpYwgxNaElBVXSUzb/LVYCCL72ZakGYuys7fPQh/0mLTP0FengHSyVXrBkH+BTkGZdGuww3BDIYRUDZykI17d4r3ZkQ9mS5eKtBnxoMJPrVIvoRQsr7s4ejNlVURVcwLyauKigoZsKt3cWSOqx34/K1m+j4BWK8C3SMLa8XyxzXX2hcYyi4q+XV4t4hrzozk1cetxPpQ2edk9LqohmauUHK8A1Xh0JCpr2JhB7/EEc9dlyMkIFg16xFtAjYDlJGoU3UlzmUSs5xdMqSbbcDje9/jnEZba0cVgeAD2NKxEUnCoh0CmeDL05eVI2i+bN++yVKf6rJ76g==
Received: from SJ2PR07CA0007.namprd07.prod.outlook.com (2603:10b6:a03:505::12)
 by SN7PR12MB6864.namprd12.prod.outlook.com (2603:10b6:806:263::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.23; Thu, 12 Dec
 2024 22:15:17 +0000
Received: from SJ5PEPF000001C8.namprd05.prod.outlook.com
 (2603:10b6:a03:505:cafe::20) by SJ2PR07CA0007.outlook.office365.com
 (2603:10b6:a03:505::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.15 via Frontend Transport; Thu,
 12 Dec 2024 22:15:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ5PEPF000001C8.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.15 via Frontend Transport; Thu, 12 Dec 2024 22:15:16 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 12 Dec
 2024 14:15:06 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 12 Dec 2024 14:15:05 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 12 Dec 2024 14:15:02 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, Leon Romanovsky <leonro@nvidia.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, <linux-rdma@vger.kernel.org>, Yevgeny Kliteynik
	<kliteyn@nvidia.com>, Itamar Gozlan <igozlan@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next V2 06/10] net/mlx5: HWS, do not initialize native API queues
Date: Fri, 13 Dec 2024 00:13:25 +0200
Message-ID: <20241212221329.961628-7-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001C8:EE_|SN7PR12MB6864:EE_
X-MS-Office365-Filtering-Correlation-Id: ea5560b0-4c85-4bbd-0860-08dd1afa7529
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VLepaG9YTzx9IqQ7HtCuhyc1mCSyi79IPPWj6dDABn5WzKbiP+eMfRy3jd12?=
 =?us-ascii?Q?RW/iNj/I55bOYTbAimco699rIXpc+hKIB0WUJTryfos4NFGNwxBKZqmdHk5L?=
 =?us-ascii?Q?PhyAcTjTw7ki0+2y2tP3Dbv7jBE8g3odr+XMRG7qutguunWqGgJ10KwlI4Ha?=
 =?us-ascii?Q?c5Mz0Ia/L1dru0h7WTqRHYdfbdUQlshahri6KtIX81hF21IIOA9WNCL665IN?=
 =?us-ascii?Q?fUkGjHTQ2WPjEXMheqpefApflcxSiSyUJ41jCq5zG31xM3ch7svB2En/r44r?=
 =?us-ascii?Q?S72K/JrIrEC1EFrTcqLYg+nAD4a+qkYnjEBU5ARcn3KyH1Bv0QXdAO55wrin?=
 =?us-ascii?Q?joSHmAWBb1CDwcpFRe/FABzNycdlyubcUJlOQo8FUPlzm1A/UY6ywZWX45NK?=
 =?us-ascii?Q?yFTmSvwzSQbQ6+vdkPpDlVLu4T8YDb79KTvFz0hZYv/jNea2KYnWz4IyUkEe?=
 =?us-ascii?Q?huW3eklfZBDHP9QbIPO/NIbrgzSuWPP5ZqGjcCYnQCXWq1uAl+LS1juort7/?=
 =?us-ascii?Q?pCcmYLnkPnZQUjRfaV3DlT3Ol2Cak0dr/H3NVcxcZ5kZOpSzbApGKTLSdgrK?=
 =?us-ascii?Q?IhyZUZAwM06HbAYSD6/zBf2sE2tiESoO2A5U42Cwmig0xjgKcLJgRTYc6L8u?=
 =?us-ascii?Q?U3BQht5beNB/SVJQoyPDiHzLHgOJ0J+3a7bIa7YkoFRjvj8z/JVmO1DsIMJs?=
 =?us-ascii?Q?1y7rY4kh/99/IYEi1M8+Y8U2od5iK07JBiCvRbwnH6oXZSqYBq6Z0+a64l8I?=
 =?us-ascii?Q?m02qzmU2cMkk6bukojL93LJKtuYSHMRsdTFV4koD7PulexT+8tclfA3EoHRE?=
 =?us-ascii?Q?kH0ptYNIeKVKIB/BwHczejsbJQdU54Gt/ZJsaPdcQ59rMt5+0ekZpG1G3S6E?=
 =?us-ascii?Q?DpVC7C6pufC+A8Hz5JwNq1zxBnPOt4gyPgYEuoz7vHkHunve04qq0iQGIgoD?=
 =?us-ascii?Q?7KFcH1lYGdVM76kxgnDZXIamYMOWel4HnYiKV5fI/b3hl/sKOUTMTPg07vYn?=
 =?us-ascii?Q?1q3WV4DAyWBPQcZveGzMrstCHRPQdEDNNQT3EE+gQACLgmwrcNnQgFM+0mgX?=
 =?us-ascii?Q?esbeu1NcqJJIwnvbiWLWDl8GfGVt6v5Od0WWC9DBrrg3xLUYFS/FB5NGtXwv?=
 =?us-ascii?Q?WLn9vzpKZmPOg4G4PzVgjTgH5CjuMDGwlB+QG1L5Mrcud3IeFlye81bzCezM?=
 =?us-ascii?Q?h1yIDx+u4m2AE3bvD+nbwdYQCKbCUl0bQDhT7lPa+A4u/PfAY4Okb3jdWpDs?=
 =?us-ascii?Q?s62zB21OCbTbWbpC18OFg2mmopKZgx4LIxoJHLz244pNDZAwbSPtXEDrAAmG?=
 =?us-ascii?Q?bkDos3RmomihX/1P7gfODEchvlT98jGs71D5hMsayhtGnHwJ0cpHN0TGYD2M?=
 =?us-ascii?Q?c07Th+hZhnV/y1O4LC23FsIFjkBDeYI5cqSIvSRSW7PEMYii4C/fnAK33oHK?=
 =?us-ascii?Q?OOnKdgYshB/meagbCz+z1NhJ+F/qCGWw?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2024 22:15:16.6091
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea5560b0-4c85-4bbd-0860-08dd1afa7529
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001C8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6864

From: Yevgeny Kliteynik <kliteyn@nvidia.com>

HWS has two types of APIs:
 - Native: fastest and slimmest, async API.
   The user of this API is required to manage rule handles memory,
   and to poll for completion for each rule.
 - BWC: backward compatible API, similar semantics to SWS API.
   This layer is implemented above native API and it does all
   the work for the user, so that it is easy to switch between
   SWS and HWS.

Right now the existing users of HWS require only BWC API.
Therefore, in order to not waste resources, this patch disables
send queues allocation for native API.

If in the future support for faster HWS rule insertion will be required
(such as for Connection Tracking), native queues can be enabled.

Signed-off-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
Reviewed-by: Itamar Gozlan <igozlan@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../mellanox/mlx5/core/steering/hws/bwc.h     |  6 ++-
 .../mellanox/mlx5/core/steering/hws/context.c |  6 ++-
 .../mellanox/mlx5/core/steering/hws/context.h |  6 +++
 .../mellanox/mlx5/core/steering/hws/mlx5hws.h |  1 -
 .../mellanox/mlx5/core/steering/hws/send.c    | 38 ++++++++++++++-----
 5 files changed, 43 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.h b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.h
index 0b745968e21e..3d4965213b01 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.h
@@ -60,9 +60,11 @@ void mlx5hws_bwc_rule_fill_attr(struct mlx5hws_bwc_matcher *bwc_matcher,
 static inline u16 mlx5hws_bwc_queues(struct mlx5hws_context *ctx)
 {
 	/* Besides the control queue, half of the queues are
-	 * reguler HWS queues, and the other half are BWC queues.
+	 * regular HWS queues, and the other half are BWC queues.
 	 */
-	return (ctx->queues - 1) / 2;
+	if (mlx5hws_context_bwc_supported(ctx))
+		return (ctx->queues - 1) / 2;
+	return 0;
 }
 
 static inline u16 mlx5hws_bwc_get_queue_id(struct mlx5hws_context *ctx, u16 idx)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/context.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/context.c
index fd48b05e91e0..4a8928f33bb9 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/context.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/context.c
@@ -161,8 +161,10 @@ static int hws_context_init_hws(struct mlx5hws_context *ctx,
 	if (ret)
 		goto uninit_pd;
 
-	if (attr->bwc)
-		ctx->flags |= MLX5HWS_CONTEXT_FLAG_BWC_SUPPORT;
+	/* Context has support for backward compatible API,
+	 * and does not have support for native HWS API.
+	 */
+	ctx->flags |= MLX5HWS_CONTEXT_FLAG_BWC_SUPPORT;
 
 	ret = mlx5hws_send_queues_open(ctx, attr->queues, attr->queue_size);
 	if (ret)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/context.h b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/context.h
index 47f5cc8de73f..1c9cc4fba083 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/context.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/context.h
@@ -8,6 +8,7 @@ enum mlx5hws_context_flags {
 	MLX5HWS_CONTEXT_FLAG_HWS_SUPPORT = 1 << 0,
 	MLX5HWS_CONTEXT_FLAG_PRIVATE_PD = 1 << 1,
 	MLX5HWS_CONTEXT_FLAG_BWC_SUPPORT = 1 << 2,
+	MLX5HWS_CONTEXT_FLAG_NATIVE_SUPPORT = 1 << 3,
 };
 
 enum mlx5hws_context_shared_stc_type {
@@ -58,6 +59,11 @@ static inline bool mlx5hws_context_bwc_supported(struct mlx5hws_context *ctx)
 	return ctx->flags & MLX5HWS_CONTEXT_FLAG_BWC_SUPPORT;
 }
 
+static inline bool mlx5hws_context_native_supported(struct mlx5hws_context *ctx)
+{
+	return ctx->flags & MLX5HWS_CONTEXT_FLAG_NATIVE_SUPPORT;
+}
+
 bool mlx5hws_context_cap_dynamic_reparse(struct mlx5hws_context *ctx);
 
 u8 mlx5hws_context_get_reparse_mode(struct mlx5hws_context *ctx);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws.h b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws.h
index f39d636ff39a..5121951f2778 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws.h
@@ -70,7 +70,6 @@ enum mlx5hws_send_queue_actions {
 struct mlx5hws_context_attr {
 	u16 queues;
 	u16 queue_size;
-	bool bwc; /* add support for backward compatible API*/
 };
 
 struct mlx5hws_table_attr {
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/send.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/send.c
index a93da4f71646..e3d621f013f6 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/send.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/send.c
@@ -898,6 +898,9 @@ static int mlx5hws_send_ring_open(struct mlx5hws_context *ctx,
 
 static void hws_send_queue_close(struct mlx5hws_send_engine *queue)
 {
+	if (!queue->num_entries)
+		return; /* this queue wasn't initialized */
+
 	hws_send_ring_close(queue);
 	kfree(queue->completed.entries);
 }
@@ -1000,12 +1003,33 @@ static int hws_bwc_send_queues_init(struct mlx5hws_context *ctx)
 	return -ENOMEM;
 }
 
+static int hws_send_queues_open(struct mlx5hws_context *ctx, u16 queue_size)
+{
+	int err = 0;
+	u32 i = 0;
+
+	/* If native API isn't supported, skip the unused native queues:
+	 * initialize BWC queues and control queue only.
+	 */
+	if (!mlx5hws_context_native_supported(ctx))
+		i = mlx5hws_bwc_get_queue_id(ctx, 0);
+
+	for (; i < ctx->queues; i++) {
+		err = hws_send_queue_open(ctx, &ctx->send_queue[i], queue_size);
+		if (err) {
+			__hws_send_queues_close(ctx, i);
+			return err;
+		}
+	}
+
+	return 0;
+}
+
 int mlx5hws_send_queues_open(struct mlx5hws_context *ctx,
 			     u16 queues,
 			     u16 queue_size)
 {
 	int err = 0;
-	u32 i;
 
 	/* Open one extra queue for control path */
 	ctx->queues = queues + 1;
@@ -1021,17 +1045,13 @@ int mlx5hws_send_queues_open(struct mlx5hws_context *ctx,
 		goto free_bwc_locks;
 	}
 
-	for (i = 0; i < ctx->queues; i++) {
-		err = hws_send_queue_open(ctx, &ctx->send_queue[i], queue_size);
-		if (err)
-			goto close_send_queues;
-	}
+	err = hws_send_queues_open(ctx, queue_size);
+	if (err)
+		goto free_queues;
 
 	return 0;
 
-close_send_queues:
-	 __hws_send_queues_close(ctx, i);
-
+free_queues:
 	kfree(ctx->send_queue);
 
 free_bwc_locks:
-- 
2.44.0


