Return-Path: <linux-rdma+bounces-18804-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oHZEGALRymmsAQYAu9opvQ
	(envelope-from <linux-rdma+bounces-18804-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Mar 2026 21:37:38 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A3E33607C5
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Mar 2026 21:37:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 067383010822
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Mar 2026 19:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E6A739A7F2;
	Mon, 30 Mar 2026 19:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RFn7ghiY"
X-Original-To: linux-rdma@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011052.outbound.protection.outlook.com [52.101.62.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E01E9399354;
	Mon, 30 Mar 2026 19:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774899353; cv=fail; b=hUpBIp/ox681bEgcYHdkfq813cph/aCrJNMI+Tuc9E9+49QvHgE1p9zG5bMdGA+AefIXc7W+mOW5cRHo6STdeEQYpoZ/AeSI4wHDzcct4CE0LAXKjJZsCoXIkTMZ8wnBHCwGy4WpywfzfaMzafWN/cn0O7S3FtvXrS5neCe66FI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774899353; c=relaxed/simple;
	bh=zHog/Dt7kGiSDxAhHp9RrrOlz48hwIu1cA3L0+jqanI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t+nH/LgwxxbHAtyM8+PaR582P4BWIATxBKCcfgeQaiDJjL0P2whWC4g6dW7HnWAPRJBOAWZZ0JE+ILIauiml2WPFvINqsMN1FDWwaLqHHcXMkTAWyWMBZ9nOveefvucL4JQTsUwOeE5uqHq7jF3r42vCNjBQUpYSUTcFJ71zuRc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RFn7ghiY; arc=fail smtp.client-ip=52.101.62.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qkqxcLW+jB3MhmCUzrXA4bGyTJhxjE85I3hxr1EiJ8ms/4Rin90b56qZedcDqgdn1sNlsNXI17LVuVzsuBlpU+FJpJ4w+bSV15D+QCVf8uv7INtbH6b0VioUiHc9JUQrZ4XVjM4qBFHtQfC6A2wFLeYXEPNYF46GTwNfACk8tGNsuheQ4Gzage7GBxLyBZvn8ltbjBWpZnSwRPwqqEHq3tWu5LXCPyjJU0htS/cXvd9KYYhTdjCwcNHip1X0N0bSHDK4rsW6HR1OTvW2F9hC2LX2abzq90Hh4hpEqtmnv2WDYan48Cprp6hq0/GwBmS70C2l/X1614p6Kc3pkqufHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jzw98y/XbxlO4bUOO/5YM4Ov59ryTTXnsZbx2lY9LJk=;
 b=F94A0MWmQESziuXSJjTZl34We9A0dP22f6O0fBDGMUOrINfEhYnzbebqCx48x3d5c7VYxY+6Xu30Bdjsa8ubTtcJ08qBnTePfr+Cbt7kFVKD7kctnG1reke9m6XWQl2JSh2Xxfb2q83UeEdfpP4tLfEzjhNm1xkQV6CPlmb4m/tArGH6XwTh7Dm/muW7H9NI3IP+6rLY0AcOr4WG0gFOGWW3sznGefwtVlu4rYb6U0VkJDq08fGVlJfhlNK6hFFvMmBXWaQWRbFG/n2sHmUaYfNIa/J1dfbUMDItkuT6DYFm9N7hCRXQGIkdmVIO51zqZKtUy28C3ppIhOCAQntVfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jzw98y/XbxlO4bUOO/5YM4Ov59ryTTXnsZbx2lY9LJk=;
 b=RFn7ghiYhBOFzIJj1GXvHYuCCreFrznkFpka/dvTu0y1Nhd7B3njStJ8bMcj8joh5gDHpvhQnfU31ny9a+Nn6kpF+s5HKZDXEUJL9d35SigM292Wam1HDeX8zNy4SHhU6tg+iuGiONN/oO4JdB0bYzvE1o8voFJcG4F/8+RZLFm4/mqZlI1cacMpQNkQwkKHfW9OiuqHvmZ0n8+EBFQa/jT75FXHaOkVwL9kZIqZB1zoaZhDItJ+cSUyMPlv6ihtmlIFyP15whghk4aq2t1YGUqXRvi2hmMVPGfzz1tuVA8LhtvDVTvqvgj+w/1O+v8zSlCQKPfWloX2C+akvotfRg==
Received: from SJ0PR13CA0124.namprd13.prod.outlook.com (2603:10b6:a03:2c6::9)
 by DS0PR12MB9422.namprd12.prod.outlook.com (2603:10b6:8:1bb::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Mon, 30 Mar
 2026 19:35:42 +0000
Received: from SJ5PEPF000001D7.namprd05.prod.outlook.com
 (2603:10b6:a03:2c6:cafe::43) by SJ0PR13CA0124.outlook.office365.com
 (2603:10b6:a03:2c6::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.28 via Frontend Transport; Mon,
 30 Mar 2026 19:35:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF000001D7.mail.protection.outlook.com (10.167.242.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Mon, 30 Mar 2026 19:35:42 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 30 Mar
 2026 12:35:23 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 30 Mar
 2026 12:35:23 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 30
 Mar 2026 12:35:19 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
	"Mark Bloch" <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Shay
 Drory <shayd@nvidia.com>, Simon Horman <horms@kernel.org>, Kees Cook
	<kees@kernel.org>, Parav Pandit <parav@nvidia.com>, Patrisious Haddad
	<phaddad@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net 2/3] net/mlx5: SD, Keep multi-pf debugfs entries on primary
Date: Mon, 30 Mar 2026 22:34:11 +0300
Message-ID: <20260330193412.53408-3-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260330193412.53408-1-tariqt@nvidia.com>
References: <20260330193412.53408-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D7:EE_|DS0PR12MB9422:EE_
X-MS-Office365-Filtering-Correlation-Id: b28b38a6-e849-418e-65c4-08de8e9387dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|1800799024|376014|7416014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	FDtlGo7sUeol9kSTBgeWrhEgq4QK3DX3SvwgVwlTqm3a5dabGIKxA4Pt8plnH4tFJJqNN/Gd+1zQgkSvmybq0kOq9RP/P6dUADRw9e2q+naJMYmBbNukppQwQ785h4sSWq3do9N4oMKkb41/OUhq6OahxiaEAmh78JyA+Ekqs/BgRg+xbdFbLyOhCJ2CIrH12BF276g2+8Sl5DoYvue8OxV+xbDnpaUPEU3lajjqCWAgyMb/Dqhmb02/PUI1/6KtXSyf2rGCNWIIXel0nMrroY7fgLivrg8Q0vSFdVmLcaaEltmCZpl/5uh4OicdDC7ICgos6nplxaccxg3wC7yqJFilOzbnxUruj160Jq8Nm3x9mOIKpdwCRkiQ6WRTuM7eUYSgeRR5BysTjTDhGgMZM2HdqrN4CKdb2yZuyEAh14tRfBCKPNtkLai1S+LrofB++6yaKMLgmSpKb+DeHHe2vhD459HJE5zfP4KgIZz1PnI0oIn6FH+t5l4s/lQDZEqn9rF29WTqDIVaRDJyuwtnuw3jcA3DEKdIB6JUj4mvAHMl6kAOMx7UMQA/l//Dd4crBEmo0nq8E/3AvnpopR34l+gXJJcrZqC68JVUQsOG9Fscemwjj0l1V2o2zxy3sdF0SFLJjXvPgV90mtJvKJE3rN2pgxFHWnO7S4Xvjl3l+gA326/gcBNC8l5dBC6WpvVa8tyn5ZdTd6znewTa5Y7r7KX8Hi5SpxVeyf2wIyZZ3xJ7VsaW0RwlyHc5LCKQFic8WbFJNWpqFFAFF4zWjxi92Q==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(1800799024)(376014)(7416014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	XPCHncUDYs6gzT9HpSZY9BOWYuU7M6rORrQs6V0DNiIt2aXQ34GIkguCEZeQcZpco9FCFqUBYmkixXrmHsqMetVS25wMrdNq9Mv9EoYLtwqQlq4ryl2NwtHziZrGI/A8/22JHqpxOwwyW0ory9WsnhYV8el8QoDWFUD7oJDLyQAJrIl+9AaOv3NX+Zk1egZsM5sBC4asTfHZ9WF0oJxBn1jVNmqW1GcqUfrf+iGer8o5g2ynVw75d62j/Lnu/azyVe6cg4SnfsRMVGlwYT4DxclZAdFqtn0WZmqcfFKN3LyCMNWaMiEIXSehB1ELOu85P2lAZG+hHbFvhUKg1zBzD2kSwYgMMJhkzxTb8HeY61wwOjM5FjEyEeHnEl8BRoc1DpQHAv8xyhfES8krtYmmH5vusTQg3FriYrm49xXSPWZvx1Gg4D5a7kAd1QM9U9mQ
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 19:35:42.3460
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b28b38a6-e849-418e-65c4-08de8e9387dc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9422
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-18804-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:email,nvidia.com:mid];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 9A3E33607C5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Shay Drory <shayd@nvidia.com>

mlx5_sd_init() creates the "multi-pf" debugfs directory under the
primary device debugfs root, but stored the dentry in the calling
device's sd struct. When sd_cleanup() run on a different PF,
this leads to using the wrong sd->dfs for removing entries, which
results in memory leak and an error in when re-creating the SD.[1]

Fix it by explicitly storing the debugfs dentry in the primary
device sd struct and use it for all per-group files.

[1]
debugfs: 'multi-pf' already exists in '0000:08:00.1'

Fixes: 4375130bf527 ("net/mlx5: SD, Add debugfs")
Signed-off-by: Shay Drory <shayd@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/lib/sd.c  | 23 ++++++++++++++-----
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
index 060649645012..4c80b9d25283 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
@@ -426,6 +426,7 @@ int mlx5_sd_init(struct mlx5_core_dev *dev)
 	struct mlx5_core_dev *primary, *pos, *to;
 	struct mlx5_sd *sd = mlx5_get_sd(dev);
 	u8 alias_key[ACCESS_KEY_LEN];
+	struct mlx5_sd *primary_sd;
 	int err, i;
 
 	err = sd_init(dev);
@@ -444,6 +445,7 @@ int mlx5_sd_init(struct mlx5_core_dev *dev)
 		return 0;
 
 	primary = mlx5_sd_get_primary(dev);
+	primary_sd = mlx5_get_sd(primary);
 
 	for (i = 0; i < ACCESS_KEY_LEN; i++)
 		alias_key[i] = get_random_u8();
@@ -452,9 +454,13 @@ int mlx5_sd_init(struct mlx5_core_dev *dev)
 	if (err)
 		goto err_sd_unregister;
 
-	sd->dfs = debugfs_create_dir("multi-pf", mlx5_debugfs_get_dev_root(primary));
-	debugfs_create_x32("group_id", 0400, sd->dfs, &sd->group_id);
-	debugfs_create_file("primary", 0400, sd->dfs, primary, &dev_fops);
+	primary_sd->dfs =
+		debugfs_create_dir("multi-pf",
+				   mlx5_debugfs_get_dev_root(primary));
+	debugfs_create_x32("group_id", 0400, primary_sd->dfs,
+			   &primary_sd->group_id);
+	debugfs_create_file("primary", 0400, primary_sd->dfs, primary,
+			    &dev_fops);
 
 	mlx5_sd_for_each_secondary(i, primary, pos) {
 		char name[32];
@@ -464,7 +470,8 @@ int mlx5_sd_init(struct mlx5_core_dev *dev)
 			goto err_unset_secondaries;
 
 		snprintf(name, sizeof(name), "secondary_%d", i - 1);
-		debugfs_create_file(name, 0400, sd->dfs, pos, &dev_fops);
+		debugfs_create_file(name, 0400, primary_sd->dfs, pos,
+				    &dev_fops);
 
 	}
 
@@ -479,7 +486,8 @@ int mlx5_sd_init(struct mlx5_core_dev *dev)
 	mlx5_sd_for_each_secondary_to(i, primary, to, pos)
 		sd_cmd_unset_secondary(pos);
 	sd_cmd_unset_primary(primary);
-	debugfs_remove_recursive(sd->dfs);
+	debugfs_remove_recursive(primary_sd->dfs);
+	primary_sd->dfs = NULL;
 err_sd_unregister:
 	sd_unregister(dev);
 err_sd_cleanup:
@@ -491,6 +499,7 @@ void mlx5_sd_cleanup(struct mlx5_core_dev *dev)
 {
 	struct mlx5_sd *sd = mlx5_get_sd(dev);
 	struct mlx5_core_dev *primary, *pos;
+	struct mlx5_sd *primary_sd;
 	int i;
 
 	if (!sd)
@@ -500,10 +509,12 @@ void mlx5_sd_cleanup(struct mlx5_core_dev *dev)
 		goto out;
 
 	primary = mlx5_sd_get_primary(dev);
+	primary_sd = mlx5_get_sd(primary);
 	mlx5_sd_for_each_secondary(i, primary, pos)
 		sd_cmd_unset_secondary(pos);
 	sd_cmd_unset_primary(primary);
-	debugfs_remove_recursive(sd->dfs);
+	debugfs_remove_recursive(primary_sd->dfs);
+	primary_sd->dfs = NULL;
 
 	sd_info(primary, "group id %#x, uncombined\n", sd->group_id);
 out:
-- 
2.44.0


