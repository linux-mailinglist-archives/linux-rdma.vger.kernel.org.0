Return-Path: <linux-rdma+bounces-18807-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GA6LEg7SymnZAQYAu9opvQ
	(envelope-from <linux-rdma+bounces-18807-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Mar 2026 21:42:06 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DAEBD360911
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Mar 2026 21:42:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B18F63035888
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Mar 2026 19:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D63437EFE3;
	Mon, 30 Mar 2026 19:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Dqf32xEq"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011002.outbound.protection.outlook.com [52.101.57.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1696D39B48D;
	Mon, 30 Mar 2026 19:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774899686; cv=fail; b=NO6G1d5fbMW4F7s7IDA1jVmbX+PCYsDhmhnQNRAEswm7qInJA4UEfYo89fpYrmOKDrSm6Iy/lsyeCISNyLoME0ju2HjtIPPZQIdOS2IrQ4ebV3491YAInXtYAgPHV32Ueh469GHmW3IjVxwkdafQdVlsGccoNa9kLrK6gI5GTRo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774899686; c=relaxed/simple;
	bh=LvENoU/m62D43LouEiVn+nopERqmFX7VLIlTMpNBDJY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NTyb27L0RzjCdG5fEDmJKR+na2lLC5WJwxrXcihzU3RxcXldQf5Krqs/5kfchCuA6a37U+j9LlW7Md95bNnD44ucRpLPHqBCMXYJ3npblSiyiEipIr24GjuIjSmYenC9VgQh3Mv6Sponfc+nGH53kcvNsbbtdef09sWirWMm264=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Dqf32xEq; arc=fail smtp.client-ip=52.101.57.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qn0isgcvsisoUyQfMY9uvgq+VRzOLOuOrPpPAz3qx1nq62GEQeU1cNB0wE0jaWBBkvpL1LYOguX1AkKOEMdaGXToDgxXLv0PAw1vJsvI+u55wswan/T3Z/TVPsM03F8LVcUo5z3Vu/mQWbHDZ3CwrYqm4xgARetC2xsnGzJxVuIBvcMQBeEnpAOPT4NZ19sxQcdYdsLsuEUk+6a1bCwNDFyE760p32N+ba/ndXpDPi5LIx+5yy45sdfHHYp0KcPNhdUDOj0F3atvFSdBPXnrgM8q2vIlzEpv1+Dtvqpzpnkj01v5rfaHdWvAVH71rWOCiaXSv8zE6D6BdYtHJKE+yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GK24S9mWOzyO6nRc/XSOQRnezgigEpil6WXqbRVSTp8=;
 b=T/snDtC2ro3SowDAybEH26TkPT29UyUbLoMWL6ep792e+gv3qeypFZHskgXxBXuQV8de+uKLRh841run9m9qnKMZWWw5gn7K0Pua3OWCyNK+iTHTD2iFtCYrXJH192xN7OiYM7m8zBoce3/Vlzad2Gn83klcHIGh+DPegUVlTCQbrf3DkB5CoMV34+ismQ2HIJOoAHqLF2GpqvaGzCC5lT8M3JO4lOM/tbags2DnuCE1xL/ReDoTMDwyQWvEqEcdPYdIacyN/UxV2K7sm3aAB5lJV4R4ql/hF1XWEQxi4DojeynzD5nbS9EuJbpgFal2OEsum3CE/8Kqz51Aks4f+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GK24S9mWOzyO6nRc/XSOQRnezgigEpil6WXqbRVSTp8=;
 b=Dqf32xEq6lWIZvPq1ogwKzYoiiiK9b+ax+OikQZ7lQlyOqWISiXHLQeEcghgNPKkcVEC5duBuuVwDjhn864UDqAkEoLN53zF97J6dzP4qFKUowtshC2o+jHteyXBegglu5X7gqwG7ehfKhnifMTjNv5u9XWankM4qeOuwhMH8B5kbtKDhKxIZULMsp/pHN0MujR2KNxPGZ+Bh/YprvmWwCY8tyADI1cYjb31wG3z/kURXQNzCo/em6en4vSglfMEeY+Tt4F2tRJbVp/hfCxpiS+hJYW63fHc8SQXJpqdNQGOGLuiFRv3TmxciuPUivk4zlQSK6MIVvv2wR5PosHh0w==
Received: from MN2PR05CA0046.namprd05.prod.outlook.com (2603:10b6:208:236::15)
 by CH3PR12MB7497.namprd12.prod.outlook.com (2603:10b6:610:153::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Mon, 30 Mar
 2026 19:41:19 +0000
Received: from BL02EPF00029927.namprd02.prod.outlook.com
 (2603:10b6:208:236:cafe::8c) by MN2PR05CA0046.outlook.office365.com
 (2603:10b6:208:236::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.28 via Frontend Transport; Mon,
 30 Mar 2026 19:41:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BL02EPF00029927.mail.protection.outlook.com (10.167.249.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Mon, 30 Mar 2026 19:41:17 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 30 Mar
 2026 12:41:02 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 30 Mar 2026 12:41:01 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 30 Mar 2026 12:40:57 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Shay Drory
	<shayd@nvidia.com>, Shay Agroskin <shayag@mellanox.com>, Saeed Mahameed
	<saeedm@mellanox.com>, Jianbo Liu <jianbol@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>
Subject: [PATCH net 1/3] net/mlx5: lag: Check for LAG device before creating debugfs
Date: Mon, 30 Mar 2026 22:40:13 +0300
Message-ID: <20260330194015.53585-2-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260330194015.53585-1-tariqt@nvidia.com>
References: <20260330194015.53585-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00029927:EE_|CH3PR12MB7497:EE_
X-MS-Office365-Filtering-Correlation-Id: 065c18ae-0520-4749-6a9d-08de8e944fd4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	O1j9qjly/vIxLOp1ZtoNbLeNbHbtRGQgE+OlxG9wiOfjYboQg0Q6PkBnHE1SrChoGIv6OybYgr04gLD1uCKSXrNGSRt74iF6iHd2gNVRkjOtcIC8bLJMICwtw4hdQqYkrWfVO8/57uLq3mhCO7nty7+CmGzYkAzQhqfW6Zyw6U/tZ76dIlKQE9Wb87SjDxlYNEZoqWAs8YHI2wbvjBIwwgCCGOR5OuNIjWca9gSp0cCGwE7l6xeZsKR9Ez2C+boUACHeVuZQ/w/EIOaBFr9pcnMHuKIezzzvoQTWZYWaSYC6u3ncfR8wYr2pAwf4I7PBZZ7q/SFYZNVxk7XKVwiiqUC2zOCH5V9Dv6bQVfJ5G5WWxHK+quWmp2uEe7S7na7tJZXQkPcMl9b+Z3A/4H6lXTpsFXvj0OE9Qr62OAqmBXIqSMB5jJmQf2D1569jtgQwNnuws83gZY4lCZsjBCq/oM17HEeubIq05Mi70SfOByvkUWKlfMKF73x9bqdI/P27R1rQ6Wyj45X7m4xboHKQ+ROjloGPn/5k8rgbE2xpGMH62K5ukRuQtRm8RcatHSqp1Bxo9xtew28UUj2rpGHDqxDp8rGetOm0sADKTx4TQPh0SvkBZiBKvARJORVwvWSTd3fySdj0fOvpMpGEzxGlOSAHDzhlWfb8lUw5xdrBfpZ5DPYYJY6DIYs0ZWAblKY5zsXY+z9lhcU/ykNt8qFp1rQiATPuHeFInXD+EcBDH5z9S3xqpyNtLzn+tmIiuxTNnyxexCawsShPc4Evles1yA==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	lZwcqUf3gm86DSlS883SvDBZZV04kJPaPzBvi2co+hOJgYorZjJsbZglk1K/fS5Jf2Ac5keMqB1CFGw4/4MLtbzqcmtTQv3CC7H4GxURXLJQ8pHCD+SAvEi6z/fliv8XoFJCJZddaDzKos+7wIxq1/ARskB/yLmSnqpXpZB7EKZWcXOcm7WYnmypBU1B1KRyyv23oxgZw3VwfE0wMUgyJzu0bYCY6BnR37gKM4kz6ZxzQrTQc+vT61T2euhIldG00aw8FD5VsIfO5I+v4xoMhkAaRKM/z94eT1mXv6LROR0wvJPLozbLXpo2r326An9t4GeVauVjG4nSSjGUNAq/Ds324KVfaPoYfXh771Nw9OofI+K7Ii6B6UlVrEK8yt1bdOXFzhaEiXQpAug6Sw5g9gXDEyUO277vbnUODjRO8GG+utt4y8O87U3nVD3ndM9s
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 19:41:17.6887
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 065c18ae-0520-4749-6a9d-08de8e944fd4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00029927.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7497
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-18807-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:email,nvidia.com:mid];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: DAEBD360911
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Shay Drory <shayd@nvidia.com>

__mlx5_lag_dev_add_mdev() may return 0 (success) even when an error
occurs that is handled gracefully. Consequently, the initialization
flow proceeds to call mlx5_ldev_add_debugfs() even when there is no
valid LAG context.

mlx5_ldev_add_debugfs() blindly created the debugfs directory and
attributes. This exposed interfaces (like the members file) that rely on
a valid ldev pointer, leading to potential NULL pointer dereferences if
accessed when ldev is NULL.

Add a check to verify that mlx5_lag_dev(dev) returns a valid pointer
before attempting to create the debugfs entries.

Fixes: 7f46a0b7327a ("net/mlx5: Lag, add debugfs to query hardware lag state")
Signed-off-by: Shay Drory <shayd@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/lag/debugfs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/debugfs.c b/drivers/net/ethernet/mellanox/mlx5/core/lag/debugfs.c
index 62b6faa4276a..b8d5f6a44d26 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lag/debugfs.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/debugfs.c
@@ -160,8 +160,11 @@ DEFINE_SHOW_ATTRIBUTE(members);
 
 void mlx5_ldev_add_debugfs(struct mlx5_core_dev *dev)
 {
+	struct mlx5_lag *ldev = mlx5_lag_dev(dev);
 	struct dentry *dbg;
 
+	if (!ldev)
+		return;
 	dbg = debugfs_create_dir("lag", mlx5_debugfs_get_dev_root(dev));
 	dev->priv.dbg.lag_debugfs = dbg;
 
-- 
2.44.0


