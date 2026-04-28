Return-Path: <linux-rdma+bounces-19636-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KAT1GphN8GncRQEAu9opvQ
	(envelope-from <linux-rdma+bounces-19636-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Apr 2026 08:03:04 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B509D47DDA5
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Apr 2026 08:03:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C5C1E301081C
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Apr 2026 06:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 152F43290C2;
	Tue, 28 Apr 2026 06:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jK0HuUHk"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010067.outbound.protection.outlook.com [52.101.46.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA2722A4E9;
	Tue, 28 Apr 2026 06:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777356156; cv=fail; b=lrmXSy2LICEo91KsxFZ4TZwouUiefQawsyhxpzfAiHT/Pylit7UFEZva/KgzVK58vlehasjusf9SUSs79GVJF/wVl3R4x84HP4HKDc23kpRnusrJlwUg0WrYK9pdC+8AmP7b3cTMZiRN0uiTmlMXsVWrBbYSvKg7S7HLHudIDvg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777356156; c=relaxed/simple;
	bh=9XqgLBBM1/8NaJ5Jr9uTANTBc44CJaLeT5tErtB6sKQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E/iU2X7L49mizB82277M0ugCrX/3rTZeTw2WI7AuFLYD+fbuo39rXRQzvEWWpX7slkOlw9oLaIjy7+/lZj1LxkhW/Aa7TPfCaqLsIoYdz2UVllKQh9W7nWL5/wWLEHcb9hMcE5bWfUYa51sDRZ4fPZEP/h/2xAlR+9efN8Y1IDY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jK0HuUHk; arc=fail smtp.client-ip=52.101.46.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qgN4BxvlEQzxo2DFoIJFCV9wJbcC1NPtmFoNvCRORN4f27+P1m3U2WLaON7Mma4D7XjGPC1vzHAn2Nlvq2wKuomJFofj9b7aaaA0gBpsKWut6DtodIbD1M6E+NprS3gdwR+zXy856a5YuzE5zWfEcBmqvldOpdtPGstzSeihDD7rZ+2dAwxhKCLiR5gQ2J1DJ1L5aOAx9dWTsWaXBolGh5aVUYLfEf4QbQqZ+Mo5Gczy59ES0cVLv9I+Xr3HYLozDYxpgrj5ESLgxmCIsxE2lsFMjY6VwZJDNE4WJ6uZHhzmfelb+Pj8izymY7sVDhmMJ/eu0wSGjTZnKzwxfvTzCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0MXJDa4uKVaCRvJ9ePRuiFIC1rzNqcjVt4Q+/nK5hMI=;
 b=Hkri2URQDbPblVoo9SlOUjkEoMvKzFVflvwWBg26uYP6CqmmRSVUJwuDnPk8LihiIFxPcZxFVqpY1d6ztcyWmk9jVhnzZR7itCfq1d61C4B3g5tEn+bZ+4xJBSfXNzt14D0TAdY0dc2jsmlODrEO/K9+Kks6mhlRHCkdaKAr6vN59kAPnWqMKXLoGmhN2FYyMkmCtXS7c3TUCZgrTcn2/Evytab/UG+tVK51hYeTZOVMNSHSCBtAKfRpxuLh9gcJanGR8ll9+z0iUY/vrqjJR1+y2VJB2rHnhI1nqRUM/zWHgG/J/RT0/IFJoh/PcAraPZDk9LVZmDqQ3rl6miDoMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0MXJDa4uKVaCRvJ9ePRuiFIC1rzNqcjVt4Q+/nK5hMI=;
 b=jK0HuUHk8q7J5/O2LStFFNsifFKOGu42e2YZeHqI9p0DbXCU4akrjBrq9mjj+Mcj49+EsVKsrcCCLB2rYSiXul5EmARW79I1MdVXdbStPKRslyQ/0MTlwc+14wRZsrt3N48h4hc8u237ntKu1MxZH+gib74OtU8QFqy2NsVdEEXsg3hvV8Qzwwd/0zhDuVgWc1vbOIuUAnoOPME6f/QOdgTLDhQy4qU3KP7zu0IoA26JOicbWWmFsj8uEqHZC1gtPZUj/GHayaTJpbUjsqJOzRjZu/HIGhue0AUL64JJowNcms4lVG7QMXY4ONHhFY1dorHfwFzfiAZotQgg1PgS5A==
Received: from MW4PR04CA0100.namprd04.prod.outlook.com (2603:10b6:303:83::15)
 by DS0PR12MB9059.namprd12.prod.outlook.com (2603:10b6:8:c5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.16; Tue, 28 Apr
 2026 06:02:28 +0000
Received: from CO1PEPF000066E8.namprd05.prod.outlook.com
 (2603:10b6:303:83:cafe::13) by MW4PR04CA0100.outlook.office365.com
 (2603:10b6:303:83::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.26 via Frontend Transport; Tue,
 28 Apr 2026 06:02:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000066E8.mail.protection.outlook.com (10.167.249.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Tue, 28 Apr 2026 06:02:28 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 27 Apr
 2026 23:02:06 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 27 Apr
 2026 23:02:06 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 27
 Apr 2026 23:02:01 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
	"Mark Bloch" <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Shay
 Drory <shayd@nvidia.com>, Simon Horman <horms@kernel.org>, Patrisious Haddad
	<phaddad@nvidia.com>, Kees Cook <kees@kernel.org>, Parav Pandit
	<parav@nvidia.com>, Gal Pressman <gal@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Dragos Tatulea
	<dtatulea@nvidia.com>
Subject: [PATCH net V4 1/4] net/mlx5: SD: Serialize init/cleanup
Date: Tue, 28 Apr 2026 09:01:08 +0300
Message-ID: <20260428060111.221086-2-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260428060111.221086-1-tariqt@nvidia.com>
References: <20260428060111.221086-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E8:EE_|DS0PR12MB9059:EE_
X-MS-Office365-Filtering-Correlation-Id: ddbe3d09-3a09-41e5-61fd-08dea4ebba5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|82310400026|36860700016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	c0gubyPRF8QJ/ygt0vh9KBu96UxH5nIQZ5SWUiG5O9CsRsutxyUjMcoJ0rqhm5mqUbkvqfvEMqDo4IBaf6FOZ0rKfmdRUPqmGX3WHGsu6Yw5LE//gU10ThRYrxkHJ5JlaqSxrZZJUqi9GoJXUuEPpr7nuvAC69hhRoGbhSWREgreLTrEHT+vSnlzPd/rw3j2/qjDoJcHfKsaVbsSP2cPClU2kAa5QAdda5FyWqrdezGSEMpsXlZJ8caepe4CcZ0xS3SNzPY0cvaOEpExdLR3GIT79UroXfEfbS9nmejgA8Wv2U2RAm2Gm+xfDWWJEbjOY4jRmaAitMvsYKjWeJ0SWT/aVZxxwJDwy4ZH76M3d1zQwgeN02puhMjGAvXZ9H3eeUL4zTFFrmRY2rxXz+uCwVeDEPNKsbCt+rjgFjzR8mGFOfPRUCmff9YSxlXTlYERNC//cjb+I6uFiH1Bf2+CO0PwYElzaLGjXOznyi5C3ViY72IwaB02P8H/3JAR1brzHFeYCqLVWTy33zr1KvhxYX1o6QsN7fNY3/yMoDOyk8LeAchS+W1ANmEV4nV83tcrXZn0JF2QnFiABI+fhplCNM+lQnBazMSgnj/peicVnbjOYXcMfzTU5cK2cSOc7rrSkgsdTAevISmxNnDIN5f5EqOmxasnktPOcFyYlxlcxiyNqZaKeq2frA0ZxHxeba4WaRQsLBdnRGgSXfM+AAp5cp+coSNa52PY1XGBAubUdLsyBHGSMoypW7J9nLD2psUY8/3sYjAvJ53SeSzuJEq+UQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(82310400026)(36860700016)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	i68AqDzJU/IFv6/8Zb6vdT1Z4rqLIExJVciQq+Sm2EFUbTExnjAsu0sQ62pW6VoseODqXj4n09nWjbIzGuk73IaKqrBhpmpHTGIaD15i7IcZGx/142O2CgMZ7ZK2QxQVBm7tYbahYbgJISLf4T0Y2Tjbqfgei3iJU2GtWWJcDuql393nE8Dia1sJ5q5X8NpkFvb3bWAdauF7uQzyOzH6eSCSGE1Ej5gAkzONjPzkNDs3p+rIvooxdfM42wBZccqH1oPhjirhrPciiY+dOeHpF0LPdPwtgF5/RH8L9q9IvZGsfWQ+yMDg4pxQaEL9KeLBk2gPPl4GEXThtYGu10AUqrMdWm+RI2bMs1hTSMBOP6vuMvzBxeuxvNoWnxGKVKh6f36OZK5K4bON6EaJlFCDn22lvkQPjEKW7EwSsRoRciQP+5xaUW6nt3K5keXy8faV
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 06:02:28.2570
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ddbe3d09-3a09-41e5-61fd-08dea4ebba5b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066E8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9059
X-Rspamd-Queue-Id: B509D47DDA5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
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
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-19636-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
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
into the cleanup's locked section. A concurrent init acquiring the
devcom lock will now observe devcom is no longer ready and bail out
immediately.

Fixes: 381978d28317 ("net/mlx5e: Create single netdev per SD group")
Signed-off-by: Shay Drory <shayd@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/lib/sd.c  | 40 ++++++++++++++++---
 1 file changed, 34 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
index 762c783156b4..d42c283cbb38 100644
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
@@ -481,6 +495,8 @@ int mlx5_sd_init(struct mlx5_core_dev *dev)
 	sd_cmd_unset_primary(primary);
 	debugfs_remove_recursive(sd->dfs);
 err_sd_unregister:
+	mlx5_devcom_comp_set_ready(sd->devcom, false);
+	mlx5_devcom_comp_unlock(sd->devcom);
 	sd_unregister(dev);
 err_sd_cleanup:
 	sd_cleanup(dev);
@@ -491,22 +507,34 @@ void mlx5_sd_cleanup(struct mlx5_core_dev *dev)
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
+		goto out_unlock;
+
+	primary_sd = mlx5_get_sd(primary);
+	if (primary_sd->state != MLX5_SD_STATE_UP)
+		goto out_unlock;
+
 	mlx5_sd_for_each_secondary(i, primary, pos)
 		sd_cmd_unset_secondary(pos);
 	sd_cmd_unset_primary(primary);
 	debugfs_remove_recursive(sd->dfs);
 
 	sd_info(primary, "group id %#x, uncombined\n", sd->group_id);
-out:
+	primary_sd->state = MLX5_SD_STATE_DOWN;
+	mlx5_devcom_comp_set_ready(sd->devcom, false);
+out_unlock:
+	mlx5_devcom_comp_unlock(sd->devcom);
 	sd_unregister(dev);
 	sd_cleanup(dev);
 }
-- 
2.44.0


