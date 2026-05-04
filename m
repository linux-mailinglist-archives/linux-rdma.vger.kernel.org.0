Return-Path: <linux-rdma+bounces-19937-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +N+/K4vf+GmU2gIAu9opvQ
	(envelope-from <linux-rdma+bounces-19937-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 04 May 2026 20:03:55 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DB694C24A7
	for <lists+linux-rdma@lfdr.de>; Mon, 04 May 2026 20:03:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CA9243013AB9
	for <lists+linux-rdma@lfdr.de>; Mon,  4 May 2026 18:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C077A3E51E1;
	Mon,  4 May 2026 18:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="L/mkY6TU"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012013.outbound.protection.outlook.com [40.93.195.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE213E4C7B;
	Mon,  4 May 2026 18:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777917790; cv=fail; b=MAfHsyzvFU3vTF09ygYxt9IGvk0jOj+EI0ZXnAZ5g/l2WQgTF3atAT6jEXDONTMREjDTTmwxdt/nP8mHBKGpm91cO63NocfFG+fpfXJLVNCJc1VGpHNtmdhWHK7ekIH7tUdmWIbhjg0l95rFVjXeOm0noM0XSKakCKXTakKfy7M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777917790; c=relaxed/simple;
	bh=W99691pNrNfJAECKaazm42uAAPNHH8SZdPYXuGmYIRM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oRgQzrNWJwZ8gh8Yd3EyCk2exy0QIVV11lxZhKxO6cmSkvm838ICEx+xLrslgW9WkUtXyCjI/TfVppMx35rUMz2ebvxHl2jxJLrNpb9BSr16XjSTMvBV8b/u+XYHKPjxud4EHQ6rNMKs7WZtjzpR2yyTm0dXhDNJnlWpgC2TbmA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=L/mkY6TU; arc=fail smtp.client-ip=40.93.195.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fxn9oalEttVq4z2H85XjkgVsJrUkdHeCWI+HsenxYkABbJgSWPESt/hIP4ULnmFzH/i6N55wk6j4I4lZGpauQ74nP8fTXAsoG3TurZVm03JxESoGpcyQdULm5DBJ7Xpr+fDtA7aGg1l5XMsX3pZLEZojQLqrhCBWddt4MDyR24yKFWBRSbaA3Ev8iEezdtwAeL7OATgbKqK6cLuNvkJM2IqKmHAcV8xxcCjkhU/XD2DoXT8pdjZh82NHU6G8Fr97gWFo2KwqbIY8nWxlZyTBIeN9K2g8STCB4MlLa+AmtsfYuaSdAFxDuzMc5Z3Z9v7mPrA+zQOXlq72ymCZ3UyEcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gwmf3YI0CP7+SpIhW/18JVqoMNSkII1BrwB+Em6FvpM=;
 b=DpCv7FDYF5ZTpTSoBRr2Vb+CeBtIBI9puqnRkLBjErBMfjCh4rLPK6Kh2e5lyfSgiBbv8w6n9Jqv1dz87a+KyFzrKzINSnS0qXXc7QlUoFz1Mi2nAIwxzXbfvntp6Q1JrtkpeYBIU1cpN0vKSTXN7Le0OYPVMLAaiYs3FAKtFFtsh8YRi4nTAkFZZxBOaTvqr0JgpzJVdGMBJeN244T38casxZPEoyPjwif2fSCEHpS58ZsU018o8tZrHHAZK+XY+vipY73WpyYkplMkawEqmQlWqXKPJyleK6/tnBBd3j2iQO0rVrcTIdKuQUuCWQKZjm38Y9OwCboCq2ilD+lMdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gwmf3YI0CP7+SpIhW/18JVqoMNSkII1BrwB+Em6FvpM=;
 b=L/mkY6TUb+ses0HV9UWXl7FmeFcVIizYg42fAQDgxjTSIPnCYm4SzYom001NoLmlf5+VmWrQBbTX7NBdu59aZ1Lpkh1te7VaWfi2nIr2dzbSbAr8z6GalXY/u5kdcMb0obUeoeTvkFsXy1SaXwgBY/yW+WQ9eliBTo5dAuawIFa5Cq3ByUBD3ty4dNjveknXPD8arnz1fArT22EON3TMyMQgimmHiky8QfGitOleIpZ0tdnwg5ZVCJEhta/D7MRATzukVQ2v/sHuYJo8cHOaM0B7oS1VDKiQpECgk/yVjGYXqaBD3CJg5smJYgLmQYp81aIillJ96wuDO+ZaX+9oHw==
Received: from DS7PR03CA0281.namprd03.prod.outlook.com (2603:10b6:5:3ad::16)
 by DS7PR12MB5934.namprd12.prod.outlook.com (2603:10b6:8:7d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 4 May
 2026 18:03:01 +0000
Received: from DS1PEPF0001708E.namprd03.prod.outlook.com
 (2603:10b6:5:3ad:cafe::67) by DS7PR03CA0281.outlook.office365.com
 (2603:10b6:5:3ad::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.25 via Frontend Transport; Mon,
 4 May 2026 18:03:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS1PEPF0001708E.mail.protection.outlook.com (10.167.17.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Mon, 4 May 2026 18:03:01 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 4 May
 2026 11:02:31 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 4 May
 2026 11:02:30 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 4 May
 2026 11:02:25 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
	"Mark Bloch" <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Shay
 Drory <shayd@nvidia.com>, Simon Horman <horms@kernel.org>, Patrisious Haddad
	<phaddad@nvidia.com>, Parav Pandit <parav@nvidia.com>, Kees Cook
	<kees@kernel.org>, Gal Pressman <gal@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Dragos Tatulea
	<dtatulea@nvidia.com>
Subject: [PATCH net V5 1/4] net/mlx5: SD: Serialize init/cleanup
Date: Mon, 4 May 2026 21:02:03 +0300
Message-ID: <20260504180206.268568-2-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260504180206.268568-1-tariqt@nvidia.com>
References: <20260504180206.268568-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF0001708E:EE_|DS7PR12MB5934:EE_
X-MS-Office365-Filtering-Correlation-Id: 82ed2748-88eb-4352-c0b3-08deaa0761ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|36860700016|82310400026|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	z+I+lfEmP9QLdopyY2R3Dzca9xB2rIocEzIl6if2DnkK4JU4C9eyei56z4amskB3ngHTmj5wWAzcqwKB8gnivJ1CPiXQW0P9jXzSKgbDmyoLSdIuJ351e7x/CbtBhKdFnd+uUqu2cfMERaM6P2uUhKE5Dfli+AcPGEAoV+oUKA3FGlNYe+7HKPFYHovz9nw7pPvsZ8xVL2+LMFpE+kKhCRp0mEz4Z6jhu0qLmCLniv6kStVw/GHwIAQS5/TSq+9cZYi0Ws0Z9e4P6ePaAaaig7EQM5fs1qK9EULAa7pLF3VcmxNbO+71DZj7GPpin4UfrKxZgWHyrEck1eSJz7k8aJ+Z50OGn3lw8viZmLGEg32tlLj6jEbDhvD6aSTJWwHqL3PBkUSjsBqAsgh8kDNNHJaS2E9yctq6Z5KcJ3QoQO2lD3tgfPFKXTJhZKvdbN6sAZ7nEKy91hdN8MsRi07zXcL9W0Eo2+4twiOAFhzaQEE5REfakKNh60WOxyYGRNj4rQecc17XmixfNKSo5GaxCv7/TuFkW0S9NZb2d2aYmZ2DzwsFrPa9MaWtGFh9cM4NYnAck53sSAd1V69Kns6csLTzXRI5zHVF2MUqaum8FAh0F/QdDGzq8mjQfIzve59hu4BCs3iGvSXZiH2w4YZR/hL5MkZ6NIRuH2IWkXD6ALzE3mZHyDGUwxc8KMg4yyxZRkqznHNCMyQm6hLR/8ahAyQiSK7tRdZHkOJPpTmyLy0=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(36860700016)(82310400026)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	5qVYQfU8DYhzkJVEt+OjkgFi8uJ3sKnt3T2QgTCkFO6szFer/DtMSRq/GUIAFT7ZxLpY/PP1/CSxBPPmz4UNjJb7h+IsQ9WdPch1QjK5ortJlCT3v1LtXxlAJZdbJ4sbmoMl4r7L5UkRYfQPNCDdYmIJ3AvfAKoeoPberTlJ+thwPvwtdmQX7B/pkCTLGeupKwHztIFvkXmY1FVat8Xq8ev+33bQUY5IWwDyKMGlDuPyFmqR1mUG2dYjQN1go9qjyYus3e9FUOTwrCx6JkWZgqeOvbN7wFlEpjpZrWYx+dzU/BtXyvkJhB1SZm+9i/SzmAH6dPIKBSR/IyK0I2Ur9nfjlu3GCHUa7yGQUFfx/6WWRpty+nvvo4j+nCV5iYi3x6RojYYAvpbKL8GTZgTt5T0GzWzOJD0FF0b/gginzBOC/r5qgOXcuw64dlU7BZpo
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2026 18:03:01.1329
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 82ed2748-88eb-4352-c0b3-08deaa0761ad
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001708E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5934
X-Rspamd-Queue-Id: 9DB694C24A7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-19937-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.997];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]

From: Shay Drory <shayd@nvidia.com>

mlx5_sd_init() / mlx5_sd_cleanup() may run from multiple PFs in the same
Socket-Direct group. This can cause the SD bring-up/tear-down sequence
to be executed more than once or interleaved across PFs.

Protect SD init/cleanup with mlx5_devcom_comp_lock() and track the SD
group state on the primary device. Skip init if the primary is already
UP, and skip cleanup unless the primary is UP.

The state check on cleanup is needed because sd_register() drops the
devcom comp lock between marking the comp ready and assigning
primary_dev on each peer. A concurrent cleanup that acquires the lock
in this window would observe devcom_is_ready==true while primary_dev
is still NULL (causing mlx5_sd_get_primary() to return NULL) or while
the FW alias setup performed by mlx5_sd_init()'s body has not yet run
(causing sd_cmd_unset_primary() to dereference a NULL tx_ft). Gate the
cleanup body on primary_sd->state == MLX5_SD_STATE_UP, which is set
only at the very end of mlx5_sd_init() under the same comp lock - so
observing UP guarantees primary_dev, secondaries[], tx_ft, and dfs are
all populated. Also bail explicitly if mlx5_sd_get_primary() returns
NULL, in case state is checked on a peer whose primary_dev hasn't been
assigned yet.

In addition, move mlx5_devcom_comp_set_ready(false) from sd_unregister()
into the cleanup's locked section, including the !primary and
state != UP early-exit paths, so the device cannot unregister and free
its struct mlx5_sd while devcom is still marked ready. A concurrent
init acquiring the devcom lock will now observe devcom is no longer
ready and bail out immediately.

Fixes: 381978d28317 ("net/mlx5e: Create single netdev per SD group")
Signed-off-by: Shay Drory <shayd@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/lib/sd.c  | 56 +++++++++++++++++--
 1 file changed, 50 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
index 762c783156b4..ec42685bdece 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
@@ -18,6 +18,7 @@ struct mlx5_sd {
 	u8 host_buses;
 	struct mlx5_devcom_comp_dev *devcom;
 	struct dentry *dfs;
+	u8 state;
 	bool primary;
 	union {
 		struct { /* primary */
@@ -31,6 +32,11 @@ struct mlx5_sd {
 	};
 };
 
+enum mlx5_sd_state {
+	MLX5_SD_STATE_DOWN = 0,
+	MLX5_SD_STATE_UP,
+};
+
 static int mlx5_sd_get_host_buses(struct mlx5_core_dev *dev)
 {
 	struct mlx5_sd *sd = mlx5_get_sd(dev);
@@ -270,9 +276,6 @@ static void sd_unregister(struct mlx5_core_dev *dev)
 {
 	struct mlx5_sd *sd = mlx5_get_sd(dev);
 
-	mlx5_devcom_comp_lock(sd->devcom);
-	mlx5_devcom_comp_set_ready(sd->devcom, false);
-	mlx5_devcom_comp_unlock(sd->devcom);
 	mlx5_devcom_unregister_component(sd->devcom);
 }
 
@@ -426,6 +429,7 @@ int mlx5_sd_init(struct mlx5_core_dev *dev)
 	struct mlx5_core_dev *primary, *pos, *to;
 	struct mlx5_sd *sd = mlx5_get_sd(dev);
 	u8 alias_key[ACCESS_KEY_LEN];
+	struct mlx5_sd *primary_sd;
 	int err, i;
 
 	err = sd_init(dev);
@@ -440,10 +444,17 @@ int mlx5_sd_init(struct mlx5_core_dev *dev)
 	if (err)
 		goto err_sd_cleanup;
 
+	mlx5_devcom_comp_lock(sd->devcom);
 	if (!mlx5_devcom_comp_is_ready(sd->devcom))
-		return 0;
+		goto out;
 
 	primary = mlx5_sd_get_primary(dev);
+	if (!primary)
+		goto out;
+
+	primary_sd = mlx5_get_sd(primary);
+	if (primary_sd->state != MLX5_SD_STATE_DOWN)
+		goto out;
 
 	for (i = 0; i < ACCESS_KEY_LEN; i++)
 		alias_key[i] = get_random_u8();
@@ -472,6 +483,9 @@ int mlx5_sd_init(struct mlx5_core_dev *dev)
 		sd->group_id, mlx5_devcom_comp_get_size(sd->devcom));
 	sd_print_group(primary);
 
+	primary_sd->state = MLX5_SD_STATE_UP;
+out:
+	mlx5_devcom_comp_unlock(sd->devcom);
 	return 0;
 
 err_unset_secondaries:
@@ -481,6 +495,15 @@ int mlx5_sd_init(struct mlx5_core_dev *dev)
 	sd_cmd_unset_primary(primary);
 	debugfs_remove_recursive(sd->dfs);
 err_sd_unregister:
+	mlx5_sd_for_each_secondary(i, primary, pos) {
+		struct mlx5_sd *peer_sd = mlx5_get_sd(pos);
+
+		primary_sd->secondaries[i - 1] = NULL;
+		peer_sd->primary_dev = NULL;
+	}
+	primary_sd->primary = false;
+	mlx5_devcom_comp_set_ready(sd->devcom, false);
+	mlx5_devcom_comp_unlock(sd->devcom);
 	sd_unregister(dev);
 err_sd_cleanup:
 	sd_cleanup(dev);
@@ -491,22 +514,43 @@ void mlx5_sd_cleanup(struct mlx5_core_dev *dev)
 {
 	struct mlx5_sd *sd = mlx5_get_sd(dev);
 	struct mlx5_core_dev *primary, *pos;
+	struct mlx5_sd *primary_sd;
 	int i;
 
 	if (!sd)
 		return;
 
+	mlx5_devcom_comp_lock(sd->devcom);
 	if (!mlx5_devcom_comp_is_ready(sd->devcom))
-		goto out;
+		goto out_unlock;
 
 	primary = mlx5_sd_get_primary(dev);
+	if (!primary)
+		goto out_ready_false;
+
+	primary_sd = mlx5_get_sd(primary);
+	if (primary_sd->state != MLX5_SD_STATE_UP)
+		goto out_clear_peers;
+
 	mlx5_sd_for_each_secondary(i, primary, pos)
 		sd_cmd_unset_secondary(pos);
 	sd_cmd_unset_primary(primary);
 	debugfs_remove_recursive(sd->dfs);
 
 	sd_info(primary, "group id %#x, uncombined\n", sd->group_id);
-out:
+	primary_sd->state = MLX5_SD_STATE_DOWN;
+out_clear_peers:
+	mlx5_sd_for_each_secondary(i, primary, pos) {
+		struct mlx5_sd *peer_sd = mlx5_get_sd(pos);
+
+		primary_sd->secondaries[i - 1] = NULL;
+		peer_sd->primary_dev = NULL;
+	}
+	primary_sd->primary = false;
+out_ready_false:
+	mlx5_devcom_comp_set_ready(sd->devcom, false);
+out_unlock:
+	mlx5_devcom_comp_unlock(sd->devcom);
 	sd_unregister(dev);
 	sd_cleanup(dev);
 }
-- 
2.44.0


