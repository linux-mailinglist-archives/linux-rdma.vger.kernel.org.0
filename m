Return-Path: <linux-rdma+bounces-8547-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 22719A5A69F
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Mar 2025 23:03:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9ECBA189223E
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Mar 2025 22:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 000D91E47C9;
	Mon, 10 Mar 2025 22:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lVe8wg2h"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2055.outbound.protection.outlook.com [40.107.220.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015801D8DF6;
	Mon, 10 Mar 2025 22:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741644178; cv=fail; b=daiOE6ImoF/QdVoAgZRBRVbY0T0rjw92uPorV2024KBxccUQFvYjavWmqEfKwcCYbckZFFtfvwiBXxUPHMnfLQdQ/gbHqRATEsT+XyZcW19UY6iC5A2B1DeWf9YBFlBNo8EeCQm8mCcdNVT4v4XfmK1/fwjQmLNKdAptTKwe5yY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741644178; c=relaxed/simple;
	bh=KLSrgqVeZjrI+NomjMZVc/fkSJs4FnvIJZl27OMCVpU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UyedF6P78rjWgKxZgurkZi0ypEDRCfo8k2WFsyu+S1ih2PWNbwumzdn1B87cTtrPV44k8X2OC4NMr3DZoS8zF5CWwXoNmAfO1M7atgxR1vqej5Izh3KzKJqyXTtIojj0ehC6N8sq6y7EbNkvs8l1/0DECiSSteilGmfKCn5aNos=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lVe8wg2h; arc=fail smtp.client-ip=40.107.220.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r8hStYzUshO5J6DBgcxHi0XFsKCZCQxGeC89LjSX1dX/3G8SijjREPIep1uWfL2y0sAvD2ALJqt1fU1glh/LiuYEREqjx/e0XAZYm65KbASTWiiNhwe7KMYLTPpQ5KuJybsVhIoKC8ltP3eH0ZyZ2uvhFQDuHvXFm7n4dT0ALJYqNSwQTm0EWMoF5LBHpOOhkbvix8p943BtIo8gY0Hfqx8HlKt+1sxUlrAeeku2oiY4NBr5OMeSRCjEidfKBYzeTaqp+ycT6g9+knPiF+VlQcpXe/d89MtXktEWWHWFJaMEFOV+wyg6NL0J384bZnAyOXFHQOOMIC6PJn4o+zNF4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ALVgO+iOnpJPrqfdCDx+znnp0MLftOF5M7dv/Cphv7s=;
 b=i5zfHyfvvcYYA7uWPDtvKAr/IIqiMoKB2iuJpec2+7nlkVrZXeYKnZapiyKpMX0gYKGrEFZnkFBlRBHiRxRT5r0cDe3FSS2jgmzHMDZMbgRjD68M/8lbT5QzZ69LYYYsJoff0jPQ0AL+h1HfIpqRYcFbZHnahWeqg7NX2H2Wr2e5M6Sz4NfbT0+fJurL7GMGJjQeOFABMvLzvuOBH6W1SbZl7ZwB6yQsmU1DmTNRjEtLabJVWy3V6+KEUwXTRmzmx4jyhFv3iDH5zkrZaFXQ4z9k07JTLKjXJTlcKRCiEhuqH1JcEas4hCjYO/++ixOxSY8XUF+4tlHWg5DdLTjN3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ALVgO+iOnpJPrqfdCDx+znnp0MLftOF5M7dv/Cphv7s=;
 b=lVe8wg2h45DV4BiNwGIWWoaUl8XuKbMb5AyxzASBpkvZqX65pwNhivmxobqwNGv0VwUqux1AVoo+dW1a1G9ZxyKfxhd2Xoi0rXF2eR3mL3mgqMkYsx2EQdeVnUfIbHznv1Ii32ri/tVd4bI5lZgcckVmhnUFQl4cAhKO1Ts0JspxWcvkmpx8HSa3/I7zSKtpmLt916PPQJEc6gTaj13cQM203ehJpEIYEt9KkAVQkvMnu3P9+vtKZGfpswmpAgnTH9vxTveiDJW7CB0IOoCQw0Yx9wdBiGqvuRZTDGHuC/gGBwONUq/oGmKuA58hQOzJd/vFMeqtI5X8G0uf0GCo0g==
Received: from SA0PR11CA0099.namprd11.prod.outlook.com (2603:10b6:806:d1::14)
 by DM3PR12MB9351.namprd12.prod.outlook.com (2603:10b6:8:1ac::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Mon, 10 Mar
 2025 22:02:51 +0000
Received: from SA2PEPF00003AE9.namprd02.prod.outlook.com
 (2603:10b6:806:d1:cafe::64) by SA0PR11CA0099.outlook.office365.com
 (2603:10b6:806:d1::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.26 via Frontend Transport; Mon,
 10 Mar 2025 22:02:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SA2PEPF00003AE9.mail.protection.outlook.com (10.167.248.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Mon, 10 Mar 2025 22:02:50 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 10 Mar
 2025 15:02:45 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 10 Mar 2025 15:02:45 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Mon, 10 Mar 2025 15:02:41 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>
CC: Gal Pressman <gal@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, "Moshe
 Shemesh" <moshe@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>, "Leon
 Romanovsky" <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Yevgeny Kliteynik <kliteyn@nvidia.com>
Subject: [PATCH net 1/6] net/mlx5: DR, use the right action structs for STEv3
Date: Tue, 11 Mar 2025 00:01:39 +0200
Message-ID: <1741644104-97767-2-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1741644104-97767-1-git-send-email-tariqt@nvidia.com>
References: <1741644104-97767-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE9:EE_|DM3PR12MB9351:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cc9a558-930a-4938-990b-08dd601f4cc8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QBlR2BKYknq/cx1ctVBOFy3EhI5Bmaaeu7Aap0XUm3eW4NxwrWsTuNshSZ3v?=
 =?us-ascii?Q?HClfEwFZglaoGI8fmpgO0m+38V8evaMeH3jq4D3aWKwzsJutiywCVk4fioAR?=
 =?us-ascii?Q?autpRnzmVyLQRzaeeq5ohmrBJCcbyU/bh33Y7ALmg0G7BjO5MDLMaWdestBc?=
 =?us-ascii?Q?/DDi4tYP+0fXiSPd+Q/lZy0ZxQlO4gVLNEY2PMQFJ/dzwLQaUukaNAl7ofck?=
 =?us-ascii?Q?JxqirRCTFHO6FfbvmId8u6LZHQGfMQoYKvVXp7YeJ6UEN1thtd1Z3K6ftD9N?=
 =?us-ascii?Q?dzYm9cFjlT33vjvm/LZa3Frz0ZYvVAVc762mAgNacEMfgU2eabXfQABty4ha?=
 =?us-ascii?Q?caolEfCSeOGpCf7WilzSON9xFthvE/pQol2kSYLTyvKt7Jzcs54jd3aSlyJK?=
 =?us-ascii?Q?EU1Egsq4rduHgFTUtIWBD1akAZv9NYvRZh0O+eJ5fitFxRZAJmlL9scl9qJ7?=
 =?us-ascii?Q?61KvbROhMlCdropDW3xC2Y6++ZUYVJkm6wVUnPAwzDWspDEy3JAL/ePXf9WM?=
 =?us-ascii?Q?gwS49iMRs3HQPN+4afZ15IpMqskldc7EfIf3DIJpIpqzFxsCaf2JHgeFnPvP?=
 =?us-ascii?Q?oyf4hX93bcnQKLt3DBVFmaUvUTk0a5GZcBwhw6MC9DdIgup04nKXckDtQenC?=
 =?us-ascii?Q?oYghO3mgCaqVaLlLtOdhnGE8mFIKmoI6IEaX51JVnAeN19INjlYsm7uqgoyE?=
 =?us-ascii?Q?8R2LGjww3UfmM65x8+kR7Cs1S91mqz4HUsMLIK09A98tXYe8vShYAvn30xY9?=
 =?us-ascii?Q?DAb3FZPY1WrWI4yiPfwj5zl7Zgd9aq0L/gxXonw/BJsYkomspM5Mv+A8AqDL?=
 =?us-ascii?Q?xgT2MMcYRbrNZl2glt+TjVskblCKh+vGP8CaSHEgvEowhF+CM0ufRb/8uFfr?=
 =?us-ascii?Q?oPsVpkPhJlpAxZND4QfcmENkUf4mZa8EpSEESeSLL2epuP1f1v7+dKL8E+bp?=
 =?us-ascii?Q?O3MRyaykrPrI/aIYBvARyUaHGnGeTT+obpnmupNOGZbYVYsl1svvXaYVNfQY?=
 =?us-ascii?Q?Be4AJT1/WDHdso+iXpCuvkgzBZ576TDZcBYFrWzupqaEEu3jtkTa9IxRYjtS?=
 =?us-ascii?Q?B+XXp6E3FVeja+5REfkDgRq/TxdyePph6o+vfB2yaq8jxVl9B5sZ7VX4wl8Z?=
 =?us-ascii?Q?iSGYe2knPMv4YDQNrCO4VS9LCB5rWofOwo6owEAcWr0ajR6xWzAK1kUUaVnp?=
 =?us-ascii?Q?LH0VZULAAJRaSORF6G2HGXB3VkP3DQQo14sNfE04DxZ5v1Z1dTdjuoSrvnDq?=
 =?us-ascii?Q?+sX6MO9VJFgcOJCEWAhCgMtd9z1WnkXNEAEexF5x81mTittf66uWZLUfQ/D9?=
 =?us-ascii?Q?gvkjgYTrjlr5dTMIvA0FdXDwSQACNh0hi1+86qkpoUxh24W0MvXpaRx7l4gk?=
 =?us-ascii?Q?E1dwSSEsmbXWVDKeNdfgOxXegOCAm9LXyz8geaG9Eyub6GXM9JHtABT7OSqw?=
 =?us-ascii?Q?bFnodqKJcmTpahVtin1QnLayLXLSa8Qg4HlR3Ab5WbLEOEbCeR+DVQdgYZq4?=
 =?us-ascii?Q?+PCmK0eK9kzVOD0=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 22:02:50.4008
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cc9a558-930a-4938-990b-08dd601f4cc8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AE9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9351

From: Yevgeny Kliteynik <kliteyn@nvidia.com>

Some actions in ConnectX-8 (STEv3) have different structure,
and they are handled separately in ste_ctx_v3.
This separate handling was missing two actions: INSERT_HDR
and REMOVE_HDR, which broke SWS for Linux Bridge.
This patch resolves the issue by introducing dedicated
callbacks for the insert and remove header functions,
with version-specific implementations for each STE variant.

Fixes: 4d617b57574f ("net/mlx5: DR, add support for ConnectX-8 steering")
Signed-off-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
Reviewed-by: Itamar Gozlan <igozlan@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../mellanox/mlx5/core/steering/sws/dr_ste.h  |  4 ++
 .../mlx5/core/steering/sws/dr_ste_v1.c        | 52 ++++++++++---------
 .../mlx5/core/steering/sws/dr_ste_v1.h        |  4 ++
 .../mlx5/core/steering/sws/dr_ste_v2.c        |  2 +
 .../mlx5/core/steering/sws/dr_ste_v3.c        | 42 +++++++++++++++
 5 files changed, 79 insertions(+), 25 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_ste.h b/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_ste.h
index 5f409dc30aca..3d5afc832fa5 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_ste.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_ste.h
@@ -210,6 +210,10 @@ struct mlx5dr_ste_ctx {
 	void (*set_encap_l3)(u8 *hw_ste_p, u8 *frst_s_action,
 			     u8 *scnd_d_action, u32 reformat_id,
 			     int size);
+	void (*set_insert_hdr)(u8 *hw_ste_p, u8 *d_action, u32 reformat_id,
+			       u8 anchor, u8 offset, int size);
+	void (*set_remove_hdr)(u8 *hw_ste_p, u8 *s_action, u8 anchor,
+			       u8 offset, int size);
 	/* Send */
 	void (*prepare_for_postsend)(u8 *hw_ste_p, u32 ste_size);
 };
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_ste_v1.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_ste_v1.c
index 7f83d77c43ef..6447efbae00d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_ste_v1.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_ste_v1.c
@@ -266,10 +266,10 @@ void dr_ste_v1_set_encap(u8 *hw_ste_p, u8 *d_action, u32 reformat_id, int size)
 	dr_ste_v1_set_reparse(hw_ste_p);
 }
 
-static void dr_ste_v1_set_insert_hdr(u8 *hw_ste_p, u8 *d_action,
-				     u32 reformat_id,
-				     u8 anchor, u8 offset,
-				     int size)
+void dr_ste_v1_set_insert_hdr(u8 *hw_ste_p, u8 *d_action,
+			      u32 reformat_id,
+			      u8 anchor, u8 offset,
+			      int size)
 {
 	MLX5_SET(ste_double_action_insert_with_ptr_v1, d_action,
 		 action_id, DR_STE_V1_ACTION_ID_INSERT_POINTER);
@@ -286,9 +286,9 @@ static void dr_ste_v1_set_insert_hdr(u8 *hw_ste_p, u8 *d_action,
 	dr_ste_v1_set_reparse(hw_ste_p);
 }
 
-static void dr_ste_v1_set_remove_hdr(u8 *hw_ste_p, u8 *s_action,
-				     u8 anchor, u8 offset,
-				     int size)
+void dr_ste_v1_set_remove_hdr(u8 *hw_ste_p, u8 *s_action,
+			      u8 anchor, u8 offset,
+			      int size)
 {
 	MLX5_SET(ste_single_action_remove_header_size_v1, s_action,
 		 action_id, DR_STE_V1_ACTION_ID_REMOVE_BY_SIZE);
@@ -584,11 +584,11 @@ void dr_ste_v1_set_actions_tx(struct mlx5dr_ste_ctx *ste_ctx,
 			action = MLX5_ADDR_OF(ste_mask_and_match_v1, last_ste, action);
 			action_sz = DR_STE_ACTION_TRIPLE_SZ;
 		}
-		dr_ste_v1_set_insert_hdr(last_ste, action,
-					 attr->reformat.id,
-					 attr->reformat.param_0,
-					 attr->reformat.param_1,
-					 attr->reformat.size);
+		ste_ctx->set_insert_hdr(last_ste, action,
+					attr->reformat.id,
+					attr->reformat.param_0,
+					attr->reformat.param_1,
+					attr->reformat.size);
 		action_sz -= DR_STE_ACTION_DOUBLE_SZ;
 		action += DR_STE_ACTION_DOUBLE_SZ;
 	} else if (action_type_set[DR_ACTION_TYP_REMOVE_HDR]) {
@@ -597,10 +597,10 @@ void dr_ste_v1_set_actions_tx(struct mlx5dr_ste_ctx *ste_ctx,
 			action = MLX5_ADDR_OF(ste_mask_and_match_v1, last_ste, action);
 			action_sz = DR_STE_ACTION_TRIPLE_SZ;
 		}
-		dr_ste_v1_set_remove_hdr(last_ste, action,
-					 attr->reformat.param_0,
-					 attr->reformat.param_1,
-					 attr->reformat.size);
+		ste_ctx->set_remove_hdr(last_ste, action,
+					attr->reformat.param_0,
+					attr->reformat.param_1,
+					attr->reformat.size);
 		action_sz -= DR_STE_ACTION_SINGLE_SZ;
 		action += DR_STE_ACTION_SINGLE_SZ;
 	}
@@ -792,11 +792,11 @@ void dr_ste_v1_set_actions_rx(struct mlx5dr_ste_ctx *ste_ctx,
 			action = MLX5_ADDR_OF(ste_mask_and_match_v1, last_ste, action);
 			action_sz = DR_STE_ACTION_TRIPLE_SZ;
 		}
-		dr_ste_v1_set_insert_hdr(last_ste, action,
-					 attr->reformat.id,
-					 attr->reformat.param_0,
-					 attr->reformat.param_1,
-					 attr->reformat.size);
+		ste_ctx->set_insert_hdr(last_ste, action,
+					attr->reformat.id,
+					attr->reformat.param_0,
+					attr->reformat.param_1,
+					attr->reformat.size);
 		action_sz -= DR_STE_ACTION_DOUBLE_SZ;
 		action += DR_STE_ACTION_DOUBLE_SZ;
 		allow_modify_hdr = false;
@@ -808,10 +808,10 @@ void dr_ste_v1_set_actions_rx(struct mlx5dr_ste_ctx *ste_ctx,
 			allow_modify_hdr = true;
 			allow_ctr = true;
 		}
-		dr_ste_v1_set_remove_hdr(last_ste, action,
-					 attr->reformat.param_0,
-					 attr->reformat.param_1,
-					 attr->reformat.size);
+		ste_ctx->set_remove_hdr(last_ste, action,
+					attr->reformat.param_0,
+					attr->reformat.param_1,
+					attr->reformat.size);
 		action_sz -= DR_STE_ACTION_SINGLE_SZ;
 		action += DR_STE_ACTION_SINGLE_SZ;
 	}
@@ -2200,6 +2200,8 @@ static struct mlx5dr_ste_ctx ste_ctx_v1 = {
 	.set_pop_vlan			= &dr_ste_v1_set_pop_vlan,
 	.set_rx_decap			= &dr_ste_v1_set_rx_decap,
 	.set_encap_l3			= &dr_ste_v1_set_encap_l3,
+	.set_insert_hdr			= &dr_ste_v1_set_insert_hdr,
+	.set_remove_hdr			= &dr_ste_v1_set_remove_hdr,
 	/* Send */
 	.prepare_for_postsend		= &dr_ste_v1_prepare_for_postsend,
 };
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_ste_v1.h b/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_ste_v1.h
index a8d9e308d339..591c20c95a6a 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_ste_v1.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_ste_v1.h
@@ -156,6 +156,10 @@ void dr_ste_v1_set_pop_vlan(u8 *hw_ste_p, u8 *s_action, u8 vlans_num);
 void dr_ste_v1_set_encap_l3(u8 *hw_ste_p, u8 *frst_s_action, u8 *scnd_d_action,
 			    u32 reformat_id, int size);
 void dr_ste_v1_set_rx_decap(u8 *hw_ste_p, u8 *s_action);
+void dr_ste_v1_set_insert_hdr(u8 *hw_ste_p, u8 *d_action, u32 reformat_id,
+			      u8 anchor, u8 offset, int size);
+void dr_ste_v1_set_remove_hdr(u8 *hw_ste_p, u8 *s_action, u8 anchor,
+			      u8 offset, int size);
 void dr_ste_v1_set_actions_tx(struct mlx5dr_ste_ctx *ste_ctx, struct mlx5dr_domain *dmn,
 			      u8 *action_type_set, u32 actions_caps, u8 *last_ste,
 			      struct mlx5dr_ste_actions_attr *attr, u32 *added_stes);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_ste_v2.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_ste_v2.c
index 0882dba0f64b..d0ebaf820d42 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_ste_v2.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_ste_v2.c
@@ -69,6 +69,8 @@ static struct mlx5dr_ste_ctx ste_ctx_v2 = {
 	.set_pop_vlan			= &dr_ste_v1_set_pop_vlan,
 	.set_rx_decap			= &dr_ste_v1_set_rx_decap,
 	.set_encap_l3			= &dr_ste_v1_set_encap_l3,
+	.set_insert_hdr			= &dr_ste_v1_set_insert_hdr,
+	.set_remove_hdr			= &dr_ste_v1_set_remove_hdr,
 	/* Send */
 	.prepare_for_postsend		= &dr_ste_v1_prepare_for_postsend,
 };
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_ste_v3.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_ste_v3.c
index cc60ce1d274e..e468a9ae44e8 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_ste_v3.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_ste_v3.c
@@ -79,6 +79,46 @@ static void dr_ste_v3_set_rx_decap(u8 *hw_ste_p, u8 *s_action)
 	dr_ste_v1_set_reparse(hw_ste_p);
 }
 
+static void dr_ste_v3_set_insert_hdr(u8 *hw_ste_p, u8 *d_action,
+				     u32 reformat_id, u8 anchor,
+				     u8 offset, int size)
+{
+	MLX5_SET(ste_double_action_insert_with_ptr_v3, d_action,
+		 action_id, DR_STE_V1_ACTION_ID_INSERT_POINTER);
+	MLX5_SET(ste_double_action_insert_with_ptr_v3, d_action,
+		 start_anchor, anchor);
+
+	/* The hardware expects here size and offset in words (2 byte) */
+	MLX5_SET(ste_double_action_insert_with_ptr_v3, d_action,
+		 size, size / 2);
+	MLX5_SET(ste_double_action_insert_with_ptr_v3, d_action,
+		 start_offset, offset / 2);
+
+	MLX5_SET(ste_double_action_insert_with_ptr_v3, d_action,
+		 pointer, reformat_id);
+	MLX5_SET(ste_double_action_insert_with_ptr_v3, d_action,
+		 attributes, DR_STE_V1_ACTION_INSERT_PTR_ATTR_NONE);
+
+	dr_ste_v1_set_reparse(hw_ste_p);
+}
+
+static void dr_ste_v3_set_remove_hdr(u8 *hw_ste_p, u8 *s_action,
+				     u8 anchor, u8 offset, int size)
+{
+	MLX5_SET(ste_single_action_remove_header_size_v3, s_action,
+		 action_id, DR_STE_V1_ACTION_ID_REMOVE_BY_SIZE);
+	MLX5_SET(ste_single_action_remove_header_size_v3, s_action,
+		 start_anchor, anchor);
+
+	/* The hardware expects here size and offset in words (2 byte) */
+	MLX5_SET(ste_single_action_remove_header_size_v3, s_action,
+		 remove_size, size / 2);
+	MLX5_SET(ste_single_action_remove_header_size_v3, s_action,
+		 start_offset, offset / 2);
+
+	dr_ste_v1_set_reparse(hw_ste_p);
+}
+
 static int
 dr_ste_v3_set_action_decap_l3_list(void *data, u32 data_sz,
 				   u8 *hw_action, u32 hw_action_sz,
@@ -211,6 +251,8 @@ static struct mlx5dr_ste_ctx ste_ctx_v3 = {
 	.set_pop_vlan			= &dr_ste_v3_set_pop_vlan,
 	.set_rx_decap			= &dr_ste_v3_set_rx_decap,
 	.set_encap_l3			= &dr_ste_v3_set_encap_l3,
+	.set_insert_hdr			= &dr_ste_v3_set_insert_hdr,
+	.set_remove_hdr			= &dr_ste_v3_set_remove_hdr,
 	/* Send */
 	.prepare_for_postsend		= &dr_ste_v1_prepare_for_postsend,
 };
-- 
2.31.1


