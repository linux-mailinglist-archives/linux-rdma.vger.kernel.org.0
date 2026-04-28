Return-Path: <linux-rdma+bounces-19634-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aNJ2EgVJ8GmIRAEAu9opvQ
	(envelope-from <linux-rdma+bounces-19634-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Apr 2026 07:43:33 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9503147DBE2
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Apr 2026 07:43:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6B92330A77E5
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Apr 2026 05:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BAAF341062;
	Tue, 28 Apr 2026 05:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BWIIHsur"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011038.outbound.protection.outlook.com [40.93.194.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD3131F996;
	Tue, 28 Apr 2026 05:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777354838; cv=fail; b=p+x1Q+dofudJJoBnIAciFWfDL3eseensFBfMt35SyNNvf9uYQLh2iIUDdyWkdT6wPU7A//BBEZSox7NtA8FhZjBreKWyKr6sRGE19d07va5jaZ0UxpS72zj+J4ythgy5FUddgNK4ZqL5sj/Fbkr6GajVLscfIwu32CxL13dPxIo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777354838; c=relaxed/simple;
	bh=vyKv5I0EyxgjKZHX1Tga/r99a9wtP2kP6/X1fZ+GtRQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TwCFTlgOAiZxlSp95t7aQH+s+fFSDq/jHqEBfhB4krkDawtWaTgg5V8wr1f44u04FaF5MREApET70ridJLU1OViBCArIr+H/SaD9VQ4S+LRMW/I/XGuUrho9xKgoeAI3hz4vDbiknVh32ifQvYTAZJINy9DOxr0VmFbRh6U+8os=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BWIIHsur; arc=fail smtp.client-ip=40.93.194.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=em8+ujj8L5gaRMrbLKq+cTikyAsWre8XpesyrmADUCyeEMxuvKG27jpBHkXzlnZttjCslXWF0gbjukgrxgKtkr02hknaNegjV1HzLQUs7bZCLE6W0jZ92BNYmo7RU5KKZA0rWH96XalbgIOfEomUhjzhxACddLifQGgTYx9gz+gqxZuHKL4TKcQ+TNMJCJg2MKs8iM9SznbP4zG7xMV8Xi4PfoeVxg7xTEVJP2gqZW37JWoG3KhsMpxttWtGxnmLk9cWgNgL6gWeYJeKsLKg7gLlftrNSK3boF1yuWqpvMHctpab4LlNlS3iQJnlij1Sq69TKArgidcBMYeBJHazVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=62Jx9mJjcHXT4rS95U1J6bhS0lweZd5bGKuBw3SWp1o=;
 b=J3L1Q5pMOoCcMqoeIPy5959jmuxhC0CKdmhamqKMM9xmAsHhuQX+5oZoJ009h1VraSSrJ7pvgzk2jYSjRdi8USnticC7aQDOHDoqowduiuQfuqER+sEpu3wW6NCry5+5jGsLXBmTyPEn0JZ3OkIgAc0Vln+bxMr7yW4RCyZU6qaBQWDhyeEI3Z4iK33JZCiz63vFKnEjO4vgcZIdN/nuJ5Ur3Ql6soytHPhK+X1oH8wZ07ka2immCD2s4Kk9YIMgBG6ulMDJ75ywhCw9Z68qCNGNps3yr/cqa+uynfqoXySqoKPTD1LdFueXPyLA4AptQUPoSKKh1UjjLrdyqTpM8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=62Jx9mJjcHXT4rS95U1J6bhS0lweZd5bGKuBw3SWp1o=;
 b=BWIIHsurSThUnAI0MEx5KFa8MeTFjtdfdmzmjNSB1e1Ly1p4Qk2VHkOf5b/qJGPHFvGT2P+sichXG4quEkoodaaWBeNTP3KKG1wMjdBtBIdxv5KuT0rWa3AO6aLJ1kG9D7VadzeTvX6mf+/utqC/rctR3Y28ygpKhxcJVn8Gr0SosOQLo01VP8+MBTY/saOab3QXtkrefrhvPsoFelGHTLTJKX4i5bD3eZgjjAd7FAdW/sponvfZC2DVJqVFAXnYvf0YCwHC72wah3hkUCgT/W557UPc/yzRIxTIpbBeovXv/TrX4vvOBcxOPEmS/TSeKfxlC7VF9/KynyYWpO5sDQ==
Received: from CH3P221CA0003.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1e7::14)
 by PH8PR12MB7422.namprd12.prod.outlook.com (2603:10b6:510:22a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.20; Tue, 28 Apr
 2026 05:40:25 +0000
Received: from CH3PEPF0000000B.namprd04.prod.outlook.com
 (2603:10b6:610:1e7:cafe::f1) by CH3P221CA0003.outlook.office365.com
 (2603:10b6:610:1e7::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.26 via Frontend Transport; Tue,
 28 Apr 2026 05:40:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH3PEPF0000000B.mail.protection.outlook.com (10.167.244.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Tue, 28 Apr 2026 05:40:24 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 27 Apr
 2026 22:40:06 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 27 Apr
 2026 22:40:05 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 27
 Apr 2026 22:39:59 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, "Saeed
 Mahameed" <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
CC: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Mark Bloch <mbloch@nvidia.com>, "Moshe
 Shemesh" <moshe@nvidia.com>, Parav Pandit <parav@nvidia.com>, Shay Drori
	<shayd@nvidia.com>, Kees Cook <kees@kernel.org>, Daniel Jurgens
	<danielj@nvidia.com>, Or Har-Toov <ohartoov@nvidia.com>, Simon Horman
	<horms@kernel.org>, Jiri Pirko <jiri@resnulli.us>, Adithya Jayachandran
	<ajayachandra@nvidia.com>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>, Gal Pressman
	<gal@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>
Subject: [PATCH mlx5-next 4/4] net/mlx5: Extend query_esw_functions output for multi-function support
Date: Tue, 28 Apr 2026 08:38:51 +0300
Message-ID: <20260428053851.220089-5-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260428053851.220089-1-tariqt@nvidia.com>
References: <20260428053851.220089-1-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000B:EE_|PH8PR12MB7422:EE_
X-MS-Office365-Filtering-Correlation-Id: 9297ca3c-eab3-4d54-66e8-08dea4e8a595
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700016|7416014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	bbUP7i2oc4N9LnLcFcODlffrNOQFTnG7S9XcWhPFCyx+Evr9jlUEjSe5HQYKXd9uiTqhWVs1DeDzG95iwWMk/frzeXb+DYWvXXmBXINzMBSXYb2eLRoZNBUGeK/CY+eY7HT+T7/XIP2Zm4/FPPPTn3IMX1pty3Rb6dfZf2OLfFyBzmIVJpt9lfYJ7B5/OIkXO+PBI3+4Cf6LnrC0UMV8iBcW89cSYslOOEGTOSflJXBggAv1z8fKmXIu3n+GPAggB/DitI7XyxB3+srQjHIFIAc6zm1+TB2O/0hjc+qwxXJWh1s858gyyxEoCoPn2S5n6MV97tR4WHVD57F1YPO5APfo5kYxvdnNp7hcE/EHRAdWuAQev9T9j0P7TtnRIDdItvdX84xwYSdMRbh1KafFvYNCgRmXp8aHGIQkWWRkX7XzJXzE8KRLBNnTNZiunClvP7Zb7+2p4/NNXyaGMn/Vyet9uUBLrWEus7nWGDYII+G0FHApsvq/s/wdENGZ5k/urMiLPMzXqJW5ixZpXJAogqUZHk1FH+Xjv2bEUAQs70uOhzyar03YfazhTdhl8ehpuvZpRL2y6DnmD32M0prT2px+aF5r/Ltn2+nr5FRG2LgmRXBC+pHK5iguWXwwOhB7O98qjxK8/k7zs35cAPQ9DnOu49oDAkW4KW0eRu7Ql4aKdjy/p3GXgWAPTWH/ZFXpdWN0aV2IPNcbt1UqYiPlwxWJAo3oBK6g7+r3S5foSRLvxU3XY0XN7VS35IieHAmdBhuI+KtcH+hz16nR+dNx7Q==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(7416014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Ey9GAaBCxbUUidyVPhROJXxSJWKp7sV8MrqMobVo1tYqR/9j9u+UPSpd4I5A9eUGw3PCHV+dTQRos1xBzA7UTFbq/i2h0pCdsb6w39ulP30fjLKGqcsUPp+83FllauzIaGX3ZHzxkEtlkT+UoFruFIvu7wd87ku5iH6CscjmcQb47eUK4QTpTA4KsDV/8IcBMf2z4t8Fm2e9cWu6OsSFbKeSBsWBHldjloiOye+wN89rkCEUGmuzgWQqHi3E1njgeC3gNlPkib8u/gKaOw1xdgkIVi8nOljv2bakxL86pMNXE6IMAiXsPJPxvrN1M06WBN61OxRMdJvkMrREcV49rP/0bdF4dZsXtg43gfp8eGzW2oygTBuONPfak4IB+dBxGv+wtJMgG2oSO3RDFB1C+AXIbYUPs5cJU/0W0bLat9zFQbkDQEOe8ekVNtZqmG8O
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 05:40:24.8865
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9297ca3c-eab3-4d54-66e8-08dea4e8a595
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7422
X-Rspamd-Queue-Id: 9503147DBE2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-19634-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	URIBL_MULTI_FAIL(0.00)[sea.lore.kernel.org:server fail,Nvidia.com:server fail,nvidia.com:server fail];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]

From: Moshe Shemesh <moshe@nvidia.com>

Update the query_esw_functions command to support a new response layout
that can report data for multiple network functions. Setting bit 14 of
the op_mod field selects the v1 layout with network_function_params
entries instead of the legacy host_params_context.

The query_host_net_function_v1 read-only capability indicates firmware
support for layout version 1, and query_host_net_function_num_max
advertises the maximum number of network function entries.

Define a new network_function_params layout and a net_function_params
union that groups host_params_context and network_function_params.
Rework the query_esw_functions output to use a flexible array of this
union, and adjust existing driver callers to use it.

Signed-off-by: Moshe Shemesh <moshe@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/eswitch.c | 14 ++--
 .../mellanox/mlx5/core/eswitch_offloads.c     | 25 +++++---
 .../mlx5/core/sf/mlx5_ifc_vhca_event.h        |  8 ---
 .../net/ethernet/mellanox/mlx5/core/sriov.c   |  7 +-
 include/linux/mlx5/mlx5_ifc.h                 | 64 +++++++++++++++++--
 5 files changed, 91 insertions(+), 27 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
index 80ba360347e7..408f729d8914 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
@@ -1045,6 +1045,7 @@ const u32 *mlx5_esw_query_functions(struct mlx5_core_dev *dev)
 static int mlx5_esw_host_functions_enabled_query(struct mlx5_eswitch *esw)
 {
 	const u32 *query_host_out;
+	void *host_params;
 
 	if (!mlx5_core_is_ecpf_esw_manager(esw->dev))
 		return 0;
@@ -1053,9 +1054,11 @@ static int mlx5_esw_host_functions_enabled_query(struct mlx5_eswitch *esw)
 	if (IS_ERR(query_host_out))
 		return PTR_ERR(query_host_out);
 
+	host_params = MLX5_ADDR_OF(query_esw_functions_out,
+				   query_host_out, net_function_params);
 	esw->esw_funcs.host_funcs_disabled =
-		MLX5_GET(query_esw_functions_out, query_host_out,
-			 host_params_context.host_pf_not_exist);
+		MLX5_GET(host_params_context, host_params,
+			 host_pf_not_exist);
 
 	kvfree(query_host_out);
 	return 0;
@@ -1475,6 +1478,7 @@ static void mlx5_eswitch_get_devlink_param(struct mlx5_eswitch *esw)
 static void
 mlx5_eswitch_update_num_of_vfs(struct mlx5_eswitch *esw, int num_vfs)
 {
+	void *host_params;
 	const u32 *out;
 
 	if (num_vfs < 0)
@@ -1489,8 +1493,10 @@ mlx5_eswitch_update_num_of_vfs(struct mlx5_eswitch *esw, int num_vfs)
 	if (IS_ERR(out))
 		return;
 
-	esw->esw_funcs.num_vfs = MLX5_GET(query_esw_functions_out, out,
-					  host_params_context.host_num_of_vfs);
+	host_params = MLX5_ADDR_OF(query_esw_functions_out, out,
+				   net_function_params);
+	esw->esw_funcs.num_vfs = MLX5_GET(host_params_context, host_params,
+					  host_num_of_vfs);
 	if (mlx5_core_ec_sriov_enabled(esw->dev))
 		esw->esw_funcs.num_ec_vfs = num_vfs;
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
index c32335df6b64..b859aa5062ca 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
@@ -3664,6 +3664,7 @@ esw_vfs_changed_event_handler(struct mlx5_eswitch *esw, int work_gen,
 {
 	struct devlink *devlink;
 	bool host_pf_disabled;
+	void *host_params;
 	u16 new_num_vfs;
 
 	devlink = priv_to_devlink(esw->dev);
@@ -3673,10 +3674,12 @@ esw_vfs_changed_event_handler(struct mlx5_eswitch *esw, int work_gen,
 	if (work_gen != atomic_read(&esw->esw_funcs.generation))
 		goto unlock;
 
-	new_num_vfs = MLX5_GET(query_esw_functions_out, out,
-			       host_params_context.host_num_of_vfs);
-	host_pf_disabled = MLX5_GET(query_esw_functions_out, out,
-				    host_params_context.host_pf_disabled);
+	host_params = MLX5_ADDR_OF(query_esw_functions_out, out,
+				   net_function_params);
+	new_num_vfs = MLX5_GET(host_params_context, host_params,
+			       host_num_of_vfs);
+	host_pf_disabled = MLX5_GET(host_params_context, host_params,
+				    host_pf_disabled);
 
 	if (new_num_vfs == esw->esw_funcs.num_vfs || host_pf_disabled)
 		goto unlock;
@@ -3743,6 +3746,7 @@ int mlx5_esw_funcs_changed_handler(struct notifier_block *nb, unsigned long type
 static int mlx5_esw_host_number_init(struct mlx5_eswitch *esw)
 {
 	const u32 *query_host_out;
+	void *host_params;
 
 	if (!mlx5_core_is_ecpf_esw_manager(esw->dev))
 		return 0;
@@ -3752,8 +3756,10 @@ static int mlx5_esw_host_number_init(struct mlx5_eswitch *esw)
 		return PTR_ERR(query_host_out);
 
 	/* Mark non local controller with non zero controller number. */
-	esw->offloads.host_number = MLX5_GET(query_esw_functions_out, query_host_out,
-					     host_params_context.host_number);
+	host_params = MLX5_ADDR_OF(query_esw_functions_out,
+				   query_host_out, net_function_params);
+	esw->offloads.host_number = MLX5_GET(host_params_context,
+					     host_params, host_number);
 	kvfree(query_host_out);
 	return 0;
 }
@@ -4792,6 +4798,7 @@ int mlx5_devlink_pf_port_fn_state_get(struct devlink_port *port,
 {
 	struct mlx5_vport *vport = mlx5_devlink_port_vport_get(port);
 	const u32 *query_out;
+	void *host_params;
 	bool pf_disabled;
 
 	if (vport->vport != MLX5_VPORT_HOST_PF) {
@@ -4806,8 +4813,10 @@ int mlx5_devlink_pf_port_fn_state_get(struct devlink_port *port,
 	if (IS_ERR(query_out))
 		return PTR_ERR(query_out);
 
-	pf_disabled = MLX5_GET(query_esw_functions_out, query_out,
-			       host_params_context.host_pf_disabled);
+	host_params = MLX5_ADDR_OF(query_esw_functions_out, query_out,
+				   net_function_params);
+	pf_disabled = MLX5_GET(host_params_context, host_params,
+			       host_pf_disabled);
 
 	*opstate = pf_disabled ? DEVLINK_PORT_FN_OPSTATE_DETACHED :
 				 DEVLINK_PORT_FN_OPSTATE_ATTACHED;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/sf/mlx5_ifc_vhca_event.h b/drivers/net/ethernet/mellanox/mlx5/core/sf/mlx5_ifc_vhca_event.h
index 4fc870140d71..487c94b56203 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/sf/mlx5_ifc_vhca_event.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/sf/mlx5_ifc_vhca_event.h
@@ -4,14 +4,6 @@
 #ifndef __MLX5_IFC_VHCA_EVENT_H__
 #define __MLX5_IFC_VHCA_EVENT_H__
 
-enum mlx5_ifc_vhca_state {
-	MLX5_VHCA_STATE_INVALID = 0x0,
-	MLX5_VHCA_STATE_ALLOCATED = 0x1,
-	MLX5_VHCA_STATE_ACTIVE = 0x2,
-	MLX5_VHCA_STATE_IN_USE = 0x3,
-	MLX5_VHCA_STATE_TEARDOWN_REQUEST = 0x4,
-};
-
 struct mlx5_ifc_vhca_state_context_bits {
 	u8         arm_change_event[0x1];
 	u8         reserved_at_1[0xb];
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/sriov.c b/drivers/net/ethernet/mellanox/mlx5/core/sriov.c
index bf6f631cf2ce..6eb6026eadd6 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/sriov.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/sriov.c
@@ -274,6 +274,7 @@ void mlx5_sriov_detach(struct mlx5_core_dev *dev)
 static u16 mlx5_get_max_vfs(struct mlx5_core_dev *dev)
 {
 	u16 host_total_vfs;
+	void *host_params;
 	const u32 *out;
 
 	if (mlx5_core_is_ecpf_esw_manager(dev)) {
@@ -284,8 +285,10 @@ static u16 mlx5_get_max_vfs(struct mlx5_core_dev *dev)
 		 */
 		if (IS_ERR(out))
 			goto done;
-		host_total_vfs = MLX5_GET(query_esw_functions_out, out,
-					  host_params_context.host_total_vfs);
+		host_params = MLX5_ADDR_OF(query_esw_functions_out, out,
+					   net_function_params);
+		host_total_vfs = MLX5_GET(host_params_context, host_params,
+					  host_total_vfs);
 		kvfree(out);
 		return host_total_vfs;
 	}
diff --git a/include/linux/mlx5/mlx5_ifc.h b/include/linux/mlx5/mlx5_ifc.h
index 02b57b2286da..6a675f918c40 100644
--- a/include/linux/mlx5/mlx5_ifc.h
+++ b/include/linux/mlx5/mlx5_ifc.h
@@ -1935,7 +1935,8 @@ struct mlx5_ifc_cmd_hca_cap_bits {
 	u8         max_flow_counter_31_16[0x10];
 	u8         max_wqe_sz_sq_dc[0x10];
 
-	u8         reserved_at_2e0[0x7];
+	u8         query_host_net_function_num_max[0x5];
+	u8         reserved_at_2e5[0x2];
 	u8         max_qp_mcg[0x19];
 
 	u8         reserved_at_300[0x10];
@@ -2027,7 +2028,7 @@ struct mlx5_ifc_cmd_hca_cap_bits {
 	u8         log_max_current_mc_list[0x5];
 	u8         reserved_at_3f8[0x1];
 	u8         silent_mode_query[0x1];
-	u8         reserved_at_3fa[0x1];
+	u8         query_host_net_function_v1[0x1];
 	u8         log_max_current_uc_list[0x5];
 
 	u8         general_obj_types[0x40];
@@ -12704,6 +12705,54 @@ struct mlx5_ifc_host_params_context_bits {
 	u8         reserved_at_80[0x180];
 };
 
+enum mlx5_ifc_vhca_state {
+	MLX5_VHCA_STATE_INVALID = 0x0,
+	MLX5_VHCA_STATE_ALLOCATED = 0x1,
+	MLX5_VHCA_STATE_ACTIVE = 0x2,
+	MLX5_VHCA_STATE_IN_USE = 0x3,
+	MLX5_VHCA_STATE_TEARDOWN_REQUEST = 0x4,
+};
+
+enum {
+	MLX5_PCI_PF_TYPE_EXTERNAL_HOST_PF = 0x0,
+	MLX5_PCI_PF_TYPE_SATELLITE_PF = 0x1,
+};
+
+struct mlx5_ifc_network_function_params_bits {
+	u8         host_number[0x8];
+	u8         pci_pf_type[0x4];
+	u8         reserved_at_c[0x4];
+	u8         pci_num_vfs[0x10];
+
+	u8         pci_total_vfs[0x10];
+	u8         pci_bus[0x8];
+	u8         pci_device_function[0x8];
+
+	u8         vhca_id[0x10];
+	u8         vhca_state[0x4];
+	u8         reserved_at_54[0xc];
+
+	u8         reserved_at_60[0xa];
+	u8         esw_vport_manual[0x1];
+	u8         pci_bus_assigned[0x1];
+	u8         pci_vf_info_valid[0x1];
+	u8         reserved_at_6d[0x13];
+
+	u8         pci_vf_stride[0x10];
+	u8         pci_first_vf_offset[0x10];
+
+	u8         reserved_at_a0[0x160];
+};
+
+union mlx5_ifc_net_function_params_bits {
+	struct mlx5_ifc_host_params_context_bits host_params_context;
+	struct mlx5_ifc_network_function_params_bits network_function_params;
+};
+
+enum {
+	MLX5_QUERY_ESW_FUNC_OP_MOD_LAYOUT_V1 = BIT(14),
+};
+
 struct mlx5_ifc_query_esw_functions_in_bits {
 	u8         opcode[0x10];
 	u8         reserved_at_10[0x10];
@@ -12720,11 +12769,16 @@ struct mlx5_ifc_query_esw_functions_out_bits {
 
 	u8         syndrome[0x20];
 
-	u8         reserved_at_40[0x40];
+	u8         reserved_at_40[0x20];
 
-	struct mlx5_ifc_host_params_context_bits host_params_context;
+	u8         net_function_num[0x8];
+	u8         reserved_at_68[0x18];
 
-	u8         reserved_at_280[0x180];
+	union {
+		u8 reserved_at_80[0x380];
+		DECLARE_FLEX_ARRAY(union mlx5_ifc_net_function_params_bits,
+				   net_function_params);
+	};
 };
 
 struct mlx5_ifc_sf_partition_bits {
-- 
2.44.0


