Return-Path: <linux-rdma+bounces-19776-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yI1eFM708mnNvwEAu9opvQ
	(envelope-from <linux-rdma+bounces-19776-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Apr 2026 08:21:02 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C0B1749E050
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Apr 2026 08:21:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 40520300B752
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Apr 2026 06:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B3DB375F63;
	Thu, 30 Apr 2026 06:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bl4mO5/1"
X-Original-To: linux-rdma@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010065.outbound.protection.outlook.com [52.101.61.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60421E98FF;
	Thu, 30 Apr 2026 06:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777530046; cv=fail; b=nppYAg4BXve8GTq1oUOVkbdUOtboqr4xcOhKWeNDIxdd4aRL/jPQjJI8wVq2cH7EK0xy3sscDjvAazOMVJ5Txv+SuQ89qPEabIVe036NqRt8TvJ9uvrvCCI5yJFFbur3f1cD+H1iK7sLx4F8PosYxm7rPrQCP77npumxapNVQqY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777530046; c=relaxed/simple;
	bh=C35IVqfOv4BS5Tk7GiN1MgIP6UY6NjDsnXc52LR/RkY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rQ2O/Xw6zirRuTFPO+57hGef+p84rk9AZ2VQvPEo9ZX3DbOx2wY5rI/tDowKRd9kGQZSxK2PQMt3kvmi5QmSz2rPcOTMA68r5YyFBqQLDH766PQsqXsmHTzr8+VrZcBrhM+aaJnHijvw0btTEs+t6XKrXDFUfF9rYtSO6nvjVSU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bl4mO5/1; arc=fail smtp.client-ip=52.101.61.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lXfuWyX9oN6y8rwCDp8BKKsBnyAkHD1Hl09GKChS40lH4HwQDoOPTkq9Li7MfBX35cOeMnxY2kQdMTgHYqeEudm0xBG+EbkAU+En85LJzJnINFegbL25ZqH9aNLlyBkfUhXdnoKAB+KIsd7eWi4UuYbvuI3rgu6AcRSFMd09R2+i4cw9ZU994jAcC9Xl14CJdLl86Hodf05xvkDWMgXJPKnIhLA7esJk9Ni+sJPBNt+ZYbPt4lUEC77QwLVDDfBRRK1TpHB9Iidf/6LtFKx3MDAyieAPbzLKvZhpnBbbeUJksG2kaxPodxBcAEHLj6g4Pie7wYNpnIlHeUdr49cXUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Piov9iyKJFv9+mz+NbxnbdRQimtGU/CxS06Rl6bgH7I=;
 b=M5dsBI/68u3S5k4kjUL/XKIB37CMO4sO1eKI285hVm4GdLscOHatHG7O2vDjPm5MLDSo8MBHxjIbDXYFRPmFPe9IlAz9nkGdbUyYqIXqwyfkJnmNeSEVYJbcyunnyFbmWDxHFH0il8ecbZKbQvf3epq4oNTX3+RIu/K0dyaZ3feS7b9yPzgOe43xJ05pQQNWZD4kvXUm8VVSkFxom9kpTXOLvvdI6aV5gsQiPXoXPrwsDKRqKsetmVx0jaVKkRgw6ZZvCGmwmPdUUSa1jf2lzLPC3rqCr3x2PETkrTzLnAKVdZK8QvJoZFbd+HYUYGeITf6sC03AtA1mNvnXzn8p+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Piov9iyKJFv9+mz+NbxnbdRQimtGU/CxS06Rl6bgH7I=;
 b=bl4mO5/1/5RTjHIkduvcVGEuE7fmFb3nnpGHdudRAojMpzSvy94D8oKnQDcQHnnUxWnOjhGhOu/nlfONlNLekzN2/j2S2efdMhrcvCwWgWosS3vGxkngCjBbXcc0Rcg3IrYLDotvRkH4ZiiyaMi0iWI/2kNslQeetruEOMnlkunzpwNgRCuvoBbIVWhS+V4tuGpqr19sinvVaH9df5dpSmHFS0Kmoi/NUB+sXsb4AYmipzCjuWmHUOcFKA2xEx44eejKuafsJjE2cXsjF3GM0z/D1X38sPCroXh3lEvkkozGXVS0qW1qO+fu99u12Iyl990riiFvvayBJvX9nsFf8w==
Received: from BYAPR11CA0071.namprd11.prod.outlook.com (2603:10b6:a03:80::48)
 by DM4PR12MB6496.namprd12.prod.outlook.com (2603:10b6:8:bd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Thu, 30 Apr
 2026 06:20:34 +0000
Received: from SJ1PEPF000023D6.namprd21.prod.outlook.com
 (2603:10b6:a03:80:cafe::90) by BYAPR11CA0071.outlook.office365.com
 (2603:10b6:a03:80::48) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.30 via Frontend Transport; Thu,
 30 Apr 2026 06:20:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ1PEPF000023D6.mail.protection.outlook.com (10.167.244.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.0 via Frontend Transport; Thu, 30 Apr 2026 06:20:34 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 29 Apr
 2026 23:20:21 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 29 Apr 2026 23:20:21 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 29 Apr 2026 23:20:17 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, "Patrisious
 Haddad" <phaddad@nvidia.com>, Jianbo Liu <jianbol@nvidia.com>, Kees Cook
	<kees@kernel.org>, Dragos Tatulea <dtatulea@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, "Leon
 Romanovsky" <leonro@nvidia.com>
Subject: [PATCH net-next] net/mlx5: Add vhca_id_type support to IPsec alias creation
Date: Thu, 30 Apr 2026 09:19:58 +0300
Message-ID: <20260430061958.225245-1-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D6:EE_|DM4PR12MB6496:EE_
X-MS-Office365-Filtering-Correlation-Id: 63a8b1b5-9f91-424b-0128-08dea680964a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|7416014|82310400026|1800799024|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	/7q8sdh/CwgkQT4tDbYVPSo7Jpi1KMHIC3CiBA9f463+ZJzE+ZG4EpQ4RRRAbfINn7jTPk6emlqowoZQsJDVQajnju+pwFM2pGLXBmgnis6k6iAkxyyfW1t6L/2QbFDqK7ebo/whT7rjlTAzbVbXhjRHNJ79nNUP4Ny9YYpeWPIHNhf2mBkZMy0tTCn467B6KA19SThfbycxTufX6IvB2l/pfwOhMXHTIq3mfaMm+UH2hZP8juS6g0+7KlXzFMKdDskD6t77rcjygelOperx/Fs3+DQ85mSgh0ksarreKjoXaCHLtSPHdt9TU02cTz5+zWUA2skWPFSPbLtkHqZKK2RqCzvhbXkluVtOKifeHB/DW5PabFDlFHW8AcxF9mScHUc93Kx9U+eTqmygTtk/oybmXoUMIhu5quDR53471otR8ISnatqDaX5PK/IOpuPPiAQlJflPglwGGpR9x7h+MAk4VL0yus5rvGKwC7a8suCFutIG1h3DVlzO5e5M25Jk/HT4lCpCnz9laW6eN+myGmT+mt61xiBsLBBu32accxUOxSblRHjg5uBU3p4L4AtCtBphuuEdpL9Wc4/yvJBoQXIEGF8v+FF8Ytsp/ePN7eEh5m3ulxcfwA9Qoqo9YPFPo2JDzPD0s5lUcVKaD4/pGUo5ZttXd3jYwApSm1dnZI/YqxLvBUjDm4JqFlAY1EP/bPZrpeojSw9rCaZpnlDKX02hSzpWQVC2vjyFwJtof1A=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(376014)(7416014)(82310400026)(1800799024)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	l1yGCHMGHRrTC/WEk3g2emzDIBwBE0NZOnuuhXySi8KCoI62Xb1BbX9wjOQWHTAmDExjigpTsgjQYbLxxci1By4zc22QKEUnnVQDsig2GjFVdrI3wTqlc7GUw22e4MWibnyglYFLkjpMshJ46OkkXFlQvdpWGnZIHG8qihww56DJSUSslZrFWURbqAaU36puXAjYJaK2N7xTTrz0pH6V+EuvV1iEwGbFU31BF1MZh7kPkyvbkGzTS/ltvzInaFrK/WOOsaDA5UlLI01oOCw0kRXy5jHAwNCKuUzBnZBAgh2JXWZbemFRwYPLF+u59YtZg/s4+PMQ2ZkAh8lWBHcsIDa3wFDh9jcuS6a04l5kfyolL0t6XL6S0mAy+42ma2ZJ85WLLqWGmp0wnk4kpKUhNfFNL0NwkunjNmqKBFcTm1CeqGeFOSuvAnaU4kB/HpV/
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 06:20:34.0356
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 63a8b1b5-9f91-424b-0128-08dea680964a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D6.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6496
X-Rspamd-Queue-Id: C0B1749E050
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
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
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-19776-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]

From: Patrisious Haddad <phaddad@nvidia.com>

When creating an alias FT for MPV IPsec, if alias creation with
sw_vhca_id is supported use it instead of using the hw_vhca_id.

This in turn allows IPsec to work properly after live migration,
in case a VF was live migrated and his hw_vhca_id changed due to
migration which can happen if you migrate to a VF with a different index
than yours, IPsec would fail to start post migration, this patch
resolves the issue by using sw_vhca_id instead which doesn't change post
migration.

Signed-off-by: Patrisious Haddad <phaddad@nvidia.com>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/cmd.c          |  1 +
 .../ethernet/mellanox/mlx5/core/lib/ipsec_fs_roce.c    | 10 ++++++++++
 drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h    |  1 +
 3 files changed, 12 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/cmd.c b/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
index c89417c1a1f9..b5c8fbfb0eed 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
@@ -2306,6 +2306,7 @@ int mlx5_cmd_alias_obj_create(struct mlx5_core_dev *dev,
 
 	attr = MLX5_ADDR_OF(create_alias_obj_in, in, alias_ctx);
 	MLX5_SET(alias_context, attr, vhca_id_to_be_accessed, alias_attr->vhca_id);
+	MLX5_SET(alias_context, attr, vhca_id_type, alias_attr->vhca_id_type);
 	MLX5_SET(alias_context, attr, object_id_to_be_accessed, alias_attr->obj_id);
 
 	key = MLX5_ADDR_OF(alias_context, attr, access_key);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/ipsec_fs_roce.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/ipsec_fs_roce.c
index 28cb670ba33e..9aadb20b8b8e 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/ipsec_fs_roce.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/ipsec_fs_roce.c
@@ -116,6 +116,16 @@ static int ipsec_fs_create_aliased_ft(struct mlx5_core_dev *ibv_owner,
 	memcpy(alias_attr.access_key, alias_key, ACCESS_KEY_LEN);
 	alias_attr.obj_id = aliased_object_id;
 	alias_attr.obj_type = MLX5_GENERAL_OBJECT_TYPES_FLOW_TABLE_ALIAS;
+	if (MLX5_CAP_GEN_2(ibv_owner, sw_vhca_id_valid) &&
+	    MLX5_CAP_GEN(ibv_allowed, ft_alias_sw_vhca_id)) {
+		vhca_id_to_be_accessed = MLX5_CAP_GEN_2(ibv_owner, sw_vhca_id);
+		alias_attr.vhca_id_type = VHCA_ID_TYPE_SW;
+	} else {
+		vhca_id_to_be_accessed = MLX5_CAP_GEN(ibv_owner, vhca_id);
+		alias_attr.vhca_id_type = VHCA_ID_TYPE_HW;
+		if (MLX5_CAP_GEN_2(ibv_owner, sw_vhca_id_valid))
+			mlx5_core_warn(ibv_owner, "IPsec with migration isn't supported, if migration is required update FW.\n");
+	}
 	alias_attr.vhca_id = vhca_id_to_be_accessed;
 	ret = mlx5_cmd_alias_obj_create(ibv_allowed, &alias_attr, obj_id);
 	if (ret) {
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h b/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h
index 1507e881d962..8730cabbb5a8 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h
@@ -110,6 +110,7 @@ struct mlx5_cmd_allow_other_vhca_access_attr {
 struct mlx5_cmd_alias_obj_create_attr {
 	u32 obj_id;
 	u16 vhca_id;
+	u8 vhca_id_type;
 	u16 obj_type;
 	u8 access_key[ACCESS_KEY_LEN];
 };

base-commit: 09942ddedcb960f9e78fd817ec33f501d1040c5b
-- 
2.44.0


