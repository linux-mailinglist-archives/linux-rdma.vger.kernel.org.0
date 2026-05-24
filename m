Return-Path: <linux-rdma+bounces-21202-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IEgBAJMbE2oE7wYAu9opvQ
	(envelope-from <linux-rdma+bounces-21202-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 24 May 2026 17:38:59 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 958FA5C2EB5
	for <lists+linux-rdma@lfdr.de>; Sun, 24 May 2026 17:38:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CF0D3300362A
	for <lists+linux-rdma@lfdr.de>; Sun, 24 May 2026 15:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2BA3397347;
	Sun, 24 May 2026 15:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ECxnHbqK"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013038.outbound.protection.outlook.com [40.107.201.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50FEA9443;
	Sun, 24 May 2026 15:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779637133; cv=fail; b=LUlhHBAIUyeWK4CFe51qXEYot8tQCH3Lk8Cg+t7IbgBCSqVjkH9QqF+L3kXthOkLMOo4wk7A3dKib4N1qUL3rlSzEzcRQoVdtM3wFdqojyRjiPeFTLQD9MmA8qrNt+u4mNOg/BZcS0C9m9D/QI3qN8WqHPLS786ndped5sqPHqw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779637133; c=relaxed/simple;
	bh=wVOOCwRJ3Cpgeb0XYrP/pEiBSVpBxZUmpasryEOz0ns=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=FkfAtOJbvUMNe+UWcSxzqDjy1zqAp2WB74DVaER5WM+F1KbFu5FNR7NxXE6WVE0dW9ugdj2PMG1fbNWXtb2OsALMpWpKw3uB2j014rwUvs9YhVYo04CUfguZOGp6viDSEnLzSm0RYw/gvgkZstIOYWs322Dpa3gHfhokjj90ZmY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ECxnHbqK; arc=fail smtp.client-ip=40.107.201.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fFqFqISZkvfkrkz4DmvYAYFS9Kbw59lHt64F3zJx7bbw8M84as48YAcVUyjf6IyNohg2iNlwse3jdmaRTCiTDsRuG4hvtf8NenuXJ7pWwFWEAraP2GWJeN+uBPjiOd0GKtRuMSTGGURKjfvfss3+tTkxzhescO37TA2uSxq0v1kYJQ5UurAK6DTulAEbuMwl+Ww9r5LTpaghAwlI0YL6ZO9m5HDVEZ6LundhDH+vkr1ihSiWXsqg6YPmtfIPWfvPzjgJgcQjUDUecb4DF6C7/f+wBL26ql2E3n2zODE196775t49m5Y56Y6kgKXg4jvhreygLEAfNsxG8+5u0qRRzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s9iK83qXclqZw/pgHIwP4fXgYuiD96Vzni5+Ug1qn/s=;
 b=kEA6wNlimb9X9n5BobVIF2ljdzy37CujoX7syG7w+V2V8rViqCbYLLksmckO17wyPO7ygle2QEOF/vFkIxtYDgBUNxbmVWAClyR1I8pmVEg04NJsZNYiHxXxApoB4Gcn07aFrjWG4Y3EHCWAbSjZyL4BiLzPhBlNJ2Q751NBLe1EgkbbzVgfeNMEMmlyt8Z+6Pluh2vX8Vl8Csf16ZFIzZ75SJ6Uw9tXR7LI3ZJEBVa11FqSOJ+MVXOyqvbKNFapSkUPeHVHbIOynLnMnXYGlXT/hXvEZ+JkVAATUhSsUZe6KJ1YsPN2ysWKR6FGQPxz/3F3bqi8riNC3m8xTcXXeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s9iK83qXclqZw/pgHIwP4fXgYuiD96Vzni5+Ug1qn/s=;
 b=ECxnHbqKtIVnzGejCrP533oWST8IYQ6qVY7kMpg5kOnE6QbercghxnssfEWaYPNE6lWyELsH7NmKsdOSxOJCsA9RibbnX0URFGOLZbvGIiFvtlx5TmPtseG4CvBjnEC5BivLDfJLErkjXUetvEMjnCaOg2N9mmqQT1Frdfn/L95BcH5uM3hnQlUnxlDETn2WDTrIAUlWN9uWZVqEZk2iK0+Rjlsn3V3AiIjpwRz15kYqx4T+pJpj/oObJOkh56zkSrQjAgFJfqJpPODnjL2YG7MFsRGC0WNEY/TfNbvXvY6/jDKqxI4pzm7INbUaDuebvqPjOqq9K1FyZD0/qM7mzg==
Received: from CH2PR14CA0057.namprd14.prod.outlook.com (2603:10b6:610:56::37)
 by SJ2PR12MB7799.namprd12.prod.outlook.com (2603:10b6:a03:4d3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Sun, 24 May
 2026 15:38:48 +0000
Received: from CH2PEPF0000009D.namprd02.prod.outlook.com
 (2603:10b6:610:56:cafe::a7) by CH2PR14CA0057.outlook.office365.com
 (2603:10b6:610:56::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.19 via Frontend Transport; Sun, 24
 May 2026 15:38:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CH2PEPF0000009D.mail.protection.outlook.com (10.167.244.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Sun, 24 May 2026 15:38:47 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 24 May
 2026 08:38:41 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sun, 24 May 2026 08:38:40 -0700
Received: from [10.135.59.1] (10.127.8.10) by mail.nvidia.com (10.126.190.182)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Sun, 24
 May 2026 08:38:37 -0700
From: Edward Srouji <edwards@nvidia.com>
Date: Sun, 24 May 2026 18:38:02 +0300
Subject: [PATCH rdma-next 1/8] net/mlx5: Add UD and UC packet pacing caps
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260524-packet-pacing-v1-1-3d79439f8d08@nvidia.com>
References: <20260524-packet-pacing-v1-0-3d79439f8d08@nvidia.com>
In-Reply-To: <20260524-packet-pacing-v1-0-3d79439f8d08@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, "Jason
 Gunthorpe" <jgg@ziepe.ca>, Selvin Xavier <selvin.xavier@broadcom.com>,
	"Kalesh AP" <kalesh-anakkur.purayil@broadcom.com>, Abhijit Gangurde
	<abhijit.gangurde@amd.com>, Allen Hubbe <allen.hubbe@amd.com>
CC: <linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Edward Srouji <edwards@nvidia.com>, "Maher
 Sanalla" <msanalla@nvidia.com>, Michael Guralnik <michaelgur@nvidia.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779637112; l=1383;
 i=edwards@nvidia.com; s=20251029; h=from:subject:message-id;
 bh=6CYix448lmWSRs/frlV0MqXh9K5fGAi80dSuDfoZRa0=;
 b=bdSkZdrLMAYg0fBs3m0zlE+9TTc8itGC9/4hrP/S9DpGJWmJY4W+oxtxr/2qT4DCeZIK6fE1b
 SG6DOkFnSuOAu6tEQX8JNJvLn14yJi3bRmBvQDASGpUYXGRVCU0i3gT
X-Developer-Key: i=edwards@nvidia.com; a=ed25519;
 pk=VME+d2WbMZT5AY+AolKh2XIdrnXWUwwzz/XLQ3jXgDM=
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009D:EE_|SJ2PR12MB7799:EE_
X-MS-Office365-Filtering-Correlation-Id: c0cee074-3016-4fe3-727f-08deb9aa8c19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|1800799024|376014|22082099003|18002099003|56012099003|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info:
	sLvEVdBRvtWnsnwfj9oJ5wdOVrQ+4TxjHP8NCcP1yJlzwtYn30X8GG84yIZpTqioyngRCBuGj3hRZGGEfic24zmsqT04xnEg82obw5Gduou2EHEr2TiurzME7n73pIWSS/V7cbKIqpl92beN52tIZpXHwg5uuO2fYD8UNfDaN3EV0OCuu/yeXJZKE2SBAzEtJE61k3m//RFTuIUTi5R2HTyGBzRWGdbdcvDr+dNv0g7or7bQ3YHqg4NNkRsvjY+zqIdvKlxy0UNz8ZMbFcs5mXE/RruIo+al1nZDdmgDkLDTOwOShPGD+gNEDLFV8DdcLBhFkYAVrKt55AwFuasTlfTF6CuWi7eSWPdJKi0LhMEwZgYkPQpGT/TLVXa8k3Q6RAty+EOTdzACcPKHBgFuhA2VG/b1PDjAcirVCJzu6sTqv55W/H3tr3p1MFSn2S2Bb0oRhjeJppS/RkuJ1J51tw6dtqH6/9aok7JZHAnkLTGz9o8qpm9/vZFQXUggmPjsUN0CBb6fW4siBzD/2oOmdkgi6m9gpeFYAQO8NkpzCvpsr4u+T0rOe3pHARIAmvTgMibclo85j7Ciy2ULinwvRxB0rhVFW7yA3G1S7LoRfbB+rtGcZfvnI0WvC/T8XuwCBud144ds8Bsduq6khjYCZOef0InhmJQx6cMA5SOvO8MA2Wy3BJ4ZHBlAsjPQSOuy9YkMlw9XUwxm7c3fbTB9NgZ6gTany4eEMvp9dK8uYY8=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(22082099003)(18002099003)(56012099003)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Ur8UOhtnrQ7XntTaALmwm2Gbdv7mB4sAgdv6AXMjYsjdh8OYDZLpyP84PY1Cp0s2ERgHU+eytSJmVCahnDutokAlClnPIeGGF9Czm6sDfc4UjZeqSOMbG0HQPkj22jHQaw5NJ2GVDt9C3EC1JA5FW+iltCNIS43TtMWL9Fhk/AycZ0BVEg8ogO2cpMZhzXuSmXazsbSQX6PrfCojEEj3i8BDorgF8EIDV4TK6bK7pcdD2eQe6aQfTcX8EAFZ1+4ws3IuOkudkRD17kmm54W9L1x6ZO6oCqD1ucotJYydmD7Ps6suTsW5iEK1ZqPcqiaQCG66+P5DYIjvjHjIHpZ/Dpv9vz1JKQlYFj3gXb5ie9N608dZ8z2mImnyiX4eixwJPC4vbUPQywAQEuOhrNKTaYoT3i67vcaFzvCPpy96dn5DGpqkQZlU/0qRTKv53P6U
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2026 15:38:47.7673
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c0cee074-3016-4fe3-727f-08deb9aa8c19
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7799
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21202-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,nvidia.com:mid,nvidia.com:email];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edwards@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 958FA5C2EB5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Maher Sanalla <msanalla@nvidia.com>

Add the needed capabilities in mlx5_ifc to support packet pacing for UC
and UD QPs.

Signed-off-by: Maher Sanalla <msanalla@nvidia.com>
Reviewed-by: Michael Guralnik <michaelgur@nvidia.com>
Signed-off-by: Edward Srouji <edwards@nvidia.com>
---
 include/linux/mlx5/mlx5_ifc.h | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/include/linux/mlx5/mlx5_ifc.h b/include/linux/mlx5/mlx5_ifc.h
index 49f3ad4b1a7c548e57da0004a7a7c1e0e03f3534..f56de77cde3aa015c00d13e32402e9ccb8ef9468 100644
--- a/include/linux/mlx5/mlx5_ifc.h
+++ b/include/linux/mlx5/mlx5_ifc.h
@@ -1116,7 +1116,10 @@ struct mlx5_ifc_qos_cap_bits {
 	u8         log_esw_max_sched_depth[0x4];
 	u8         reserved_at_10[0x10];
 
-	u8         reserved_at_20[0x9];
+	u8         reserved_at_20[0x2];
+	u8         packet_pacing_req_ud[0x1];
+	u8         packet_pacing_req_uc[0x1];
+	u8         reserved_at_24[0x5];
 	u8         esw_cross_esw_sched[0x1];
 	u8         reserved_at_2a[0x1];
 	u8         log_max_qos_nic_queue_group[0x5];
@@ -3707,7 +3710,8 @@ struct mlx5_ifc_qpc_bits {
 	u8         cur_retry_count[0x3];
 	u8         reserved_at_39b[0x5];
 
-	u8         reserved_at_3a0[0x20];
+	u8         reserved_at_3a0[0x10];
+	u8         packet_pacing_rate_limit_index[0x10];
 
 	u8         reserved_at_3c0[0x8];
 	u8         next_send_psn[0x18];

-- 
2.49.0


