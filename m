Return-Path: <linux-rdma+bounces-16051-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KEGZOQZ+eGkFqQEAu9opvQ
	(envelope-from <linux-rdma+bounces-16051-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Jan 2026 09:57:42 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ACEE915DF
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Jan 2026 09:57:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2B513305BBDB
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Jan 2026 08:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4C32328611;
	Tue, 27 Jan 2026 08:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pbLybzvN"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012039.outbound.protection.outlook.com [52.101.43.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64232217723;
	Tue, 27 Jan 2026 08:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769504037; cv=fail; b=ckOSVrh501WvYdAOizffPUvPG/fAGQVy4tWwE53JrmanXJVjIuv0b1Qq+aTx5qw5o+ArA2NKKcr4aHPokht7w0DgYApTNG9ubF6NffySIvtPMaBB0bZBwEUw6Hm/a2InfpsmB8HZzmKyCLZ+3MQFt56J72urmfYIFH3avzYInPg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769504037; c=relaxed/simple;
	bh=Tb9ItUAEqT1vmiyoU2J9dBtmy+C6HLS2BOsXstuqr98=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JA2AEYZh7jTfvq8s+drNv1u2aoHKGUOXbaB/tPq3+M1G9O4XqrZr2m6C2hFY5azEQ6gfc7ctkh1m86LC+tTIXqB6qfPBKFqpbLU4R8IaK88D9Y3qzr/l50q2WPDyI3iLKOJ3t/mdO8dQ44QcIFw7ApplxkBrludF/q9VzstlfI0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pbLybzvN; arc=fail smtp.client-ip=52.101.43.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uFV2JAG/C+gytpC5OKkqlVWqJMEUqyV18IGpjOQEDQlvPkUs1shGXACfjCp6ZI8EZqVqxXrsZmYyxlreANQ9Q0SmjjJ0dc0NKrcCuLYmnNIXR8OkaMDab8yf7Cls1JFPucqlWl2Zmj5PV7RT1zTqRxiTItrIVSEa9ri9SbC1L7yJojFEGL5jbL3zeNKb9ap7VjvhuzLF1pkyH9EXfUFn64sKkVxzJRpSKeGUPZ9aTwCWfbLkPfnkTwllABZEOA9WHKq+RDNmmUvR665E6inemtgH5cOpn/WyvBHFXTf0/lE1ZV8+O4yCKnqDivOm4JifwKOcV3W7j7RWfEsrzq3exw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pl5vOh6XgP3jIyISGHKDPdQ1T1vClN/cAI6p4HWWpkI=;
 b=qCMIDPEurpUZ4SrIxuYAEP9vWO7N3WGT5nERMsr3LiXR4Jqa5uxb5nQP+oqiP7mxVrtvJVuNU+923OXk0AW+CgrCa0mNp2AMxqitstRfksOLX5uLVfzAiRTrfwtC7Kk2oW8qZkc0+ef72APHIaayFGj586pRgqAiYgcCa7ReA+v7LSiGP5QR+Xn69NoQWEiT1kNKbRezzSNwL9vBIUZEEOWVcXZzJHU7JP/7DP18zZDUIG2/TqOOvW66Bz5eCciAPo/LRbNdeLVknHTj2v4IGfycVKKDnp+xb+ftYFpOX73JYiKRTKQPWeXZz+Wb6C58CV/0M+4zldbJCj/rU4ArHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pl5vOh6XgP3jIyISGHKDPdQ1T1vClN/cAI6p4HWWpkI=;
 b=pbLybzvNgNxkPO16yhrKkBcZ620+9tx76y2SUannzoN1BiUlxN0IH3LHXf+YSIWydWa8TckOcJ6jyNA+IanmdqL6Qw5L8HfIAJ5RTn5I/8QaRMZmmuIl8PMVBYSJyOl2qP1HQOpi3Hd1n+o3WoREFSdzNYatradgdYJwxrETLTU2wayfHADpbJAZvxKZt9zUx9axan1mlGI/ak8r/ravPopT7r6HM5OLsOjDJehPkAA+z8piyFToA5sKpbWt6ZVPWiNrO/YZTeCpK8I8bdWpoGYGq6yvY8IXIx7x1NwDU0Ti/6UqJn3sArXxxUcL+y746usWXidDLo2CyjiggXKyZw==
Received: from CH3P221CA0006.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1e7::32)
 by SN7PR12MB8004.namprd12.prod.outlook.com (2603:10b6:806:341::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Tue, 27 Jan
 2026 08:53:50 +0000
Received: from CH1PEPF0000A348.namprd04.prod.outlook.com
 (2603:10b6:610:1e7:cafe::3c) by CH3P221CA0006.outlook.office365.com
 (2603:10b6:610:1e7::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.7 via Frontend Transport; Tue,
 27 Jan 2026 08:53:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH1PEPF0000A348.mail.protection.outlook.com (10.167.244.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Tue, 27 Jan 2026 08:53:50 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 27 Jan
 2026 00:53:30 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 27 Jan
 2026 00:53:28 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Tue, 27
 Jan 2026 00:53:24 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Simon Horman <horms@kernel.org>, Shay Drory
	<shayd@nvidia.com>
Subject: [PATCH net V2 1/4] net/mlx5: fs, Fix inverted cap check in tx flow table root disconnect
Date: Tue, 27 Jan 2026 10:52:38 +0200
Message-ID: <1769503961-124173-2-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1769503961-124173-1-git-send-email-tariqt@nvidia.com>
References: <1769503961-124173-1-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A348:EE_|SN7PR12MB8004:EE_
X-MS-Office365-Filtering-Correlation-Id: 53412a27-78a5-41a1-35dd-08de5d819750
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3Ww6RRif+zJ0aJ/rNjwIVxjfSdNnN/GhJmSTLDY1dM/x4jSRBGtWlJ6t8UOB?=
 =?us-ascii?Q?5INm+OP3JuQRDPzlC3nlWXGse3yXQhjMODESXbvPtRw966FgdQh1lo4unJAn?=
 =?us-ascii?Q?VZ4C0/FWb3YdRZ8j1pIXz0c58tHRsSyppxRbE8V3tjpGipzhFu9Q51/7BJAP?=
 =?us-ascii?Q?c2w3qf1QIhYJTCYCyVGQCojpQsh8FOQQShpnqD4V/fTZJmsacVq8eTIB6ltc?=
 =?us-ascii?Q?qc/7GU1ATFySXWCdhMHfDTHDPYWakjwadexshSb5gYbNwZNVJ2I1K/q5sA7A?=
 =?us-ascii?Q?5TeCkmc7xhVWYNM6fIrlfAv4zzNBfwYiH0X3/I88zK8bsDIQnnw067lWsRg2?=
 =?us-ascii?Q?ogk6ssVf63HnttO0trYmbq5P8gRWZoxg20x5v03ZK8gUsDRDRCzlJyMgRD/S?=
 =?us-ascii?Q?+sCGc9Sx1SfB/N71dksKPbOxz7zlL8Y61DbTt7fCExQDst/B9F0DMT7zlKae?=
 =?us-ascii?Q?N1sEA2RjAQc+0rIY/AWmhQaMl5BfS2MUfxiBV2BMekQtYwTptDaXqTmV/GTC?=
 =?us-ascii?Q?YLCXSRO/dIeEYmOLVtccOm8Qgt/ooFBqbzjpR8qTnwzeXRuci9ZJpWnnXvkn?=
 =?us-ascii?Q?zuxjv8zidp6oYoLjQ4dJMcosETt6ZI80/8RBGoYaHbOyUrooe3vnJnr3qEbH?=
 =?us-ascii?Q?uKfV3+IeICWnpZvp8eWZ2rviIKlyQ2mVGJiE7dCbmKEmAzER5rHkq29qC1j4?=
 =?us-ascii?Q?NZIJ6sG3ydmZltBq9sYAylUQQtxeGWz11RcwCt5MytFFJ38ZuGIVxZYGokFK?=
 =?us-ascii?Q?RZzKhclB6XmRGYXzip7gpwSes4Gvei9ZNfc6lGqbu8om518OUFAEyFDV1vPF?=
 =?us-ascii?Q?2apNDntoZiecfz5Rx+Ht8IegEWa/sVkvHSNvZ8og4kt8ygN5gi1JbqmOqNrJ?=
 =?us-ascii?Q?cFgH9LBhRG2vOxJz3IZLbL3DFyOfI2KyIrNa4x8A2C4CFq+URevA4pQWvI7x?=
 =?us-ascii?Q?uTBQexURv3wYYcKUCSe23EEIXLftSNh2UBIxYB1bkjQLfatdiVyinidyBxaK?=
 =?us-ascii?Q?ow2nIX+SqD3p1giYMfAezMqgU3rf6NKE/owfqbtRkw+MTGEVJU3qZtvdLNvj?=
 =?us-ascii?Q?vVnURiina/DkOTjXBMyD5BkLuQU8DvhyiNZXl3sIDPsihKuTRQUJ8TTzYpgU?=
 =?us-ascii?Q?9WKlOqEnaGaLNxRZEKmUxcuc21OPASuRn0sich6/kcAgTLbL36U24WQX7OSF?=
 =?us-ascii?Q?rPYY3CygzyKCUgnOhZZujog8suQQk73h4gn+xqaIzNI6uxBnSFM4PNfUqBNl?=
 =?us-ascii?Q?Gn5oI5DYkc3rLrW46BLg6674he13qpvd6MXPZjyaPomm5/ViTxjGyaJxZX/L?=
 =?us-ascii?Q?BJ3NRsdHw7N2WP+wQ6hw6N8HiYWipCswbGLP3/PTsja7/jfqb1nYX/o/Xo91?=
 =?us-ascii?Q?jfar5fVk83lncjstUdx4i6TDLUI1etm7QB2mRJNpCV+flhKQdeWVHWo8AhQs?=
 =?us-ascii?Q?t+EkWkbHsuAT9DmupRQWWz2Zkt3PG2VUfQkPAcWjACNqu4rckK3oJpq6naZd?=
 =?us-ascii?Q?VKwNBEamGQqgKbjcEowxwJwuI49yHX6P7rVQOzijHrBMAm9pGr7G90wM1KWT?=
 =?us-ascii?Q?eE5stiYR7NvMOXIftBJYiuI/Yx1SAgwGDvbQZZrAE04gg5H9zk+XJfT2gJ9y?=
 =?us-ascii?Q?bqQOUnJnhpGjiZO+LlPJp/GvrSTNX+rzG3f2lVAFgF7XL7EilicHApB/0Fzd?=
 =?us-ascii?Q?yD674w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2026 08:53:50.2641
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53412a27-78a5-41a1-35dd-08de5d819750
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A348.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8004
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-16051-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 4ACEE915DF
X-Rspamd-Action: no action

From: Shay Drory <shayd@nvidia.com>

The capability check for reset_root_to_default was inverted, causing
the function to return -EOPNOTSUPP when the capability IS supported,
rather than when it is NOT supported.

Fix the capability check condition.

Fixes: 3c9c34c32bc6 ("net/mlx5: fs, Command to control TX flow table root")
Signed-off-by: Shay Drory <shayd@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.c b/drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.c
index ced747bef641..c348ee62cd3a 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.c
@@ -1198,7 +1198,8 @@ int mlx5_fs_cmd_set_tx_flow_table_root(struct mlx5_core_dev *dev, u32 ft_id, boo
 	u32 out[MLX5_ST_SZ_DW(set_flow_table_root_out)] = {};
 	u32 in[MLX5_ST_SZ_DW(set_flow_table_root_in)] = {};
 
-	if (disconnect && MLX5_CAP_FLOWTABLE_NIC_TX(dev, reset_root_to_default))
+	if (disconnect &&
+	    !MLX5_CAP_FLOWTABLE_NIC_TX(dev, reset_root_to_default))
 		return -EOPNOTSUPP;
 
 	MLX5_SET(set_flow_table_root_in, in, opcode,
-- 
2.40.1


