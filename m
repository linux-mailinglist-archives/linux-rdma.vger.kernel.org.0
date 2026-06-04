Return-Path: <linux-rdma+bounces-21753-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XSa0J4BmIWo+FwEAu9opvQ
	(envelope-from <linux-rdma+bounces-21753-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 04 Jun 2026 13:50:24 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C1BA63F935
	for <lists+linux-rdma@lfdr.de>; Thu, 04 Jun 2026 13:50:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=Ahb1sxkA;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21753-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21753-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EAF3C30000A1
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Jun 2026 11:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55CD043C05C;
	Thu,  4 Jun 2026 11:46:28 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010021.outbound.protection.outlook.com [40.93.198.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B21D43C047;
	Thu,  4 Jun 2026 11:46:26 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780573588; cv=fail; b=Z7bcNgLVPrilrAPiD17+pdWq/JTqv8UhDULkpuCFYjcjSzDULMAKWWH0MDT0XzWmxiWb0Tk/OFdDbISfEzjr6YrGBhuOhPB5uoMihY7jJ1cEF9oWvV9cm7R7ofLTVTA58KDQe5oJIigxPr42l/xhu7SyG05XvloFHpp7wWpAL88=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780573588; c=relaxed/simple;
	bh=/4KQREmESTXZZNQueMt0B5NozdAiCQjALwVXuro5jy4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C4CNr+oahZFS0ekHeg6NmlQFh9dlXtU8KIPoFlTPr5MmRmKiU3N3YnW6hXaq1TZyGA6p3xwVeCkkX9Vk8UuMpXwYrWK0TXunJmzNzBoQlOR17bCT6FDu/PD1JJtx/I+IUk+acvdqlE8nBWjQuNsN95mmJ8xoIhrWAzm+rAq0OJE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ahb1sxkA; arc=fail smtp.client-ip=40.93.198.21
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=doZhKXNTUMj2HSrPutQHBJw3ju1KKh4QKBeQEA/u7hdJTv2U+RiloEWnZczztezfUwR3+eH4a4Nt/+vOF2TRYfP/F9/C/mW9PUU6rYfwFrxJiKDp1OCeFsj6Xw7ixdJXasSC6MlqT+8z8TS+1a2dY8E5Ggp0r1sEfAzujPtv8P5XT+qI7VRVtVy5K8CfXGjdpv5r7fx2yd8tnaQ+G6qedEDLcunRnQJ+rftRrVfu3V7uFNxZ10XDEJqlSx6TC3VhOGx2XyHSW5lZZN+OP2xkG6WAVIZnRPEr2gw657dyTYOjbUoY1Tv15b5xYHKFqNHIzKFaelDHoKfVEjLogghaYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dzZKw2JSIeOk3imSb7wlwFmcoW2+9VKshKE62/BHAtE=;
 b=y0kHeejyaHgN1g9K4h0Gmn+2g3eld5COIrpwZhqzaRmbQECFdcqrdaEjl2YNjKy1BnkW1mD19TaUvsvrtt7ISXUd26ZhN9+/98CmkycZ/KqgXoIRJ5cXIcDAEH0JBb0+3m5T3tVayb7RBSpg44e/t3RmXyM2Dq8TD42MwNqir1S3vvGFctg/m4TpihkcdHE1rUIkvWJC4jIyFkXAlAgiLZpLLsVRqjW4SqBAFrVmUq+MTm5YHwo3Mf5PBc0Zg0TpVHPvTFZosNLPWlNydR+c+q1Oi5VnRG7zAkJsP4t5QrFfgo0tmcdZnYvSFNMYv/w2HF8mottgwR4OLh1YnQFktA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dzZKw2JSIeOk3imSb7wlwFmcoW2+9VKshKE62/BHAtE=;
 b=Ahb1sxkAKzPf5ZZWCjjhSmomP9xq3Y9VIqgYagOi57pD1g+lHTqiCPK8mxY6GxXdMyeaVLhPYzZt9cur6Iw6527TH7SEnIjK8G75ZQSiRj0uFOxHogDe6KcE4d8toZKrCA5drY0fG++weV/6NbcGcTLSOBtr8EsR8YatjsAY99R0tWU0rheZfZ8hM75T9k0JMtlUppIjtkcH/U7BmKK+IPPZFP4i9M30/efbXOn/uCrVI4B5SeN3RNqiMSANACfexPXqw1GzDZKU9AWbBfCkswiouRwb/X4biEhsuGf1XIV87CW6jVTwAGj6SLfNiYLIw3adMNNpy1lm2HRRcPg8eg==
Received: from BN9PR03CA0474.namprd03.prod.outlook.com (2603:10b6:408:139::29)
 by MN0PR12MB5764.namprd12.prod.outlook.com (2603:10b6:208:377::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Thu, 4 Jun 2026
 11:46:19 +0000
Received: from BN2PEPF0000449E.namprd02.prod.outlook.com
 (2603:10b6:408:139:cafe::1f) by BN9PR03CA0474.outlook.office365.com
 (2603:10b6:408:139::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.7 via Frontend Transport; Thu, 4
 Jun 2026 11:46:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN2PEPF0000449E.mail.protection.outlook.com (10.167.243.149) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Thu, 4 Jun 2026 11:46:19 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 4 Jun
 2026 04:46:08 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 4 Jun 2026 04:46:07 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 4 Jun 2026 04:46:02 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Shay Drory
	<shayd@nvidia.com>, Or Har-Toov <ohartoov@nvidia.com>, Edward Srouji
	<edwards@nvidia.com>, Simon Horman <horms@kernel.org>, Maher Sanalla
	<msanalla@nvidia.com>, Parav Pandit <parav@nvidia.com>, Kees Cook
	<kees@kernel.org>, Moshe Shemesh <moshe@nvidia.com>, Patrisious Haddad
	<phaddad@nvidia.com>, <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>
Subject: [PATCH net-next 07/15] net/mlx5: SD, support switchdev mode transition with shared FDB
Date: Thu, 4 Jun 2026 14:44:47 +0300
Message-ID: <20260604114455.434711-8-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260604114455.434711-1-tariqt@nvidia.com>
References: <20260604114455.434711-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449E:EE_|MN0PR12MB5764:EE_
X-MS-Office365-Filtering-Correlation-Id: 52b74c99-196c-4560-8bac-08dec22ee4a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|7416014|376014|82310400026|1800799024|22082099003|18002099003|56012099006|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info:
	fLHfvTKDDz1/bFv9hBf8gWZBkPkFD6qxEyBtomKGQ04YQx4/uvn7OQbcwm8BuQsds5955F/W0bbZPhIVohinrqkqoG8D0pRXx07lFNdimWe+FTzbge4x9hu1EvxiooO6zXkdkpOkFJt0VUUwSDOes2zn4oYr5OPrgugWtNC5xo6otQzeLH8e7bv0RFWO9BhyqZ8u3VIU+H6ZhpEEBW4to6+fKos1XrwTtMKvqntwMW5viWgCmdtS/ZbkLF33KfW1rx5ztYESX9BVxtRxAITwCxwYIochf8IYTiWHRfeMWRofF26KytQs2um4abqyR2hnitnIZuZT9Yo9Dz9u6uIgh72/JOHFo1XbJ+inQ8JZ5EpqKepmQgDuGoJJlUjdOf8yy9+L9kszCA2JuOYj/F9ddPl1QghfK1zQ18egP764EIAsyLULl905hDipTsX0GZVKFft0NTeiSP+xdpFwwmqS9KQzHG4bp3Fmnbh+Q/WO/tYOfL+IlJmdT7hIy3Xon3HnOGAqEqgJIO2v45wnOAToTo4IgOMeCEJOLMExar4qeIN8cqChgxkAVPCDuSxE+fRAg2uiI6M3UR44rBrFSx/ckXrJDdiph4WBbVfztNSAG3ezczjVtGhFqaTCglv5AXaV2rpta0nTxYjWGN+YIrrJ2auxzm8ZogNxNFspzrDQefC27/+9431iOojOBzgRMHSbO7DqLlnStYMWk6/7CppWsNyNFw5nesN/xi5U9jVxhMw=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(7416014)(376014)(82310400026)(1800799024)(22082099003)(18002099003)(56012099006)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	HEZ9j3Z4tE8LwG0Tp6tIR+XzkRFWmDPSaLbcA/dFtWMtZ3FvVBl4DDYovtQJQ3xWfQjjKTd9SgA4Rcrnzao5hHpTQmwUrr786wzhN5dA3FJbU6CZFASSW4HbfzQs9Gmtgm5iVq/LGqzh1NduwgAMz9e+RZvQUY9y+nAEY+uUfycKoSRcRFIzSpuT3XleV51efLNDCALaHX7YecvBKwxGEhqcuJypa7tAGR55ELvQUCASrFR/zG21Ads/29I/Wdke84emmZK17F55bXRtwTkFG0zyAPpj7+YWQ5j0BlTPaNwgme8c3LvTKbYIdY84v6e//UA2YoguSzuN+LkPrwjI529J2Qh0LV/zcsij5jMowHgR81pHCKHhdAbak460dxWMKNao9CT1YKpFDjxFsWLdSUmDtz08WSO8DX8SaysRCQbx2acG1V4aeO7A/ZF7z8ed
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 11:46:19.1204
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 52b74c99-196c-4560-8bac-08dec22ee4a0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000449E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5764
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[22];
	TAGGED_FROM(0.00)[bounces-21753-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:saeedm@nvidia.com,m:leon@kernel.org,m:tariqt@nvidia.com,m:mbloch@nvidia.com,m:shayd@nvidia.com,m:ohartoov@nvidia.com,m:edwards@nvidia.com,m:horms@kernel.org,m:msanalla@nvidia.com,m:parav@nvidia.com,m:kees@kernel.org,m:moshe@nvidia.com,m:phaddad@nvidia.com,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:gal@nvidia.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:mid,nvidia.com:from_mime,nvidia.com:email,vger.kernel.org:from_smtp];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7C1BA63F935

From: Shay Drory <shayd@nvidia.com>

When the eswitch transitions, propagate the change to SD: secondaries
get their TX flow table root reconfigured for the new mode, and when
all group devices move to switchdev, the per-group shared FDB is
activated.

Shared FDB activation is best-effort - failure does not block the
eswitch transition; the next transition retries.

Note: the existing mlx5_get_sd() guard that blocks switchdev for SD
devices is intentionally retained. It will be removed once all
supporting patches are in place.

Signed-off-by: Shay Drory <shayd@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../mellanox/mlx5/core/eswitch_offloads.c     |  24 +++-
 .../net/ethernet/mellanox/mlx5/core/lib/sd.c  | 133 +++++++++++++++++-
 .../net/ethernet/mellanox/mlx5/core/lib/sd.h  |   7 +
 3 files changed, 156 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
index 366531d8ef02..1133267a53fb 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
@@ -46,6 +46,7 @@
 #include "fs_core.h"
 #include "lib/mlx5.h"
 #include "lib/devcom.h"
+#include "lib/sd.h"
 #include "lib/eq.h"
 #include "lib/fs_chains.h"
 #include "en_tc.h"
@@ -3164,6 +3165,9 @@ static void esw_unset_master_egress_rule(struct mlx5_core_dev *dev,
 	vport = mlx5_eswitch_get_vport(dev->priv.eswitch,
 				       dev->priv.eswitch->manager_vport);
 
+	if (!vport->egress.acl)
+		return;
+
 	esw_acl_egress_ofld_bounce_rule_destroy(vport, MLX5_CAP_GEN(slave_dev, vhca_id));
 
 	if (xa_empty(&vport->egress.offloads.bounce_rules)) {
@@ -3182,6 +3186,9 @@ int mlx5_eswitch_offloads_single_fdb_add_one(struct mlx5_eswitch *master_esw,
 	if (err)
 		return err;
 
+	if (!mlx5_sd_is_primary(slave_esw->dev))
+		return 0;
+
 	err = esw_set_master_egress_rule(master_esw->dev,
 					 slave_esw->dev, max_slaves);
 	if (err)
@@ -3401,7 +3408,7 @@ void mlx5_esw_offloads_devcom_init(struct mlx5_eswitch *esw,
 		return;
 
 	if ((MLX5_VPORT_MANAGER(esw->dev) || mlx5_core_is_ecpf_esw_manager(esw->dev)) &&
-	    !mlx5_lag_is_supported(esw->dev))
+	    (!mlx5_lag_is_supported(esw->dev) && !mlx5_get_sd(esw->dev)))
 		return;
 
 	xa_init(&esw->paired);
@@ -4219,11 +4226,6 @@ int mlx5_devlink_eswitch_mode_set(struct devlink *devlink, u16 mode,
 	if (IS_ERR(esw))
 		return PTR_ERR(esw);
 
-	if (mlx5_fw_reset_in_progress(esw->dev)) {
-		NL_SET_ERR_MSG_MOD(extack, "Can't change eswitch mode during firmware reset");
-		return -EBUSY;
-	}
-
 	if (esw_mode_from_devlink(mode, &mlx5_mode))
 		return -EINVAL;
 
@@ -4233,11 +4235,18 @@ int mlx5_devlink_eswitch_mode_set(struct devlink *devlink, u16 mode,
 		return -EPERM;
 	}
 
+	if (mlx5_fw_reset_in_progress(esw->dev)) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Can't change eswitch mode during firmware reset");
+		return -EBUSY;
+	}
+
 	/* Avoid try_lock, active/inactive mode change is not restricted */
 	if (mlx5_devlink_switchdev_active_mode_change(esw, mode))
 		return 0;
 
 	mlx5_lag_disable_change(esw->dev);
+
 	err = mlx5_esw_try_lock(esw);
 	if (err < 0) {
 		NL_SET_ERR_MSG_MOD(extack, "Can't change mode, E-Switch is busy");
@@ -4304,6 +4313,9 @@ int mlx5_devlink_eswitch_mode_set(struct devlink *devlink, u16 mode,
 	esw->eswitch_operation_in_progress = false;
 unlock:
 	mlx5_esw_unlock(esw);
+	/* Shared FDB activation is creating LAG which is changing reps. */
+	if (!err)
+		mlx5_sd_eswitch_mode_set(esw->dev, mlx5_mode);
 enable_lag:
 	mlx5_lag_enable_change(esw->dev);
 	return err;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
index 8b1f3a25d80d..d2ed156ed1c6 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
@@ -5,6 +5,8 @@
 #include "../lag/lag.h"
 #include "mlx5_core.h"
 #include "lib/mlx5.h"
+#include "devlink.h"
+#include "eswitch.h"
 #include "fs_cmd.h"
 #include <linux/mlx5/eswitch.h>
 #include <linux/mlx5/vport.h>
@@ -33,6 +35,8 @@ struct mlx5_sd {
 		struct { /* secondary */
 			struct mlx5_core_dev *primary_dev;
 			u32 alias_obj_id;
+			/* TX flow table root in switchdev (silent) config */
+			bool tx_root_silent;
 		};
 	};
 };
@@ -669,6 +673,29 @@ static void sd_secondary_destroy_alias_ft(struct mlx5_core_dev *secondary)
 				   MLX5_GENERAL_OBJECT_TYPES_FLOW_TABLE_ALIAS);
 }
 
+static int mlx5_sd_secondary_conf_tx_root(struct mlx5_core_dev *secondary,
+					  bool disconnect)
+{
+	struct mlx5_sd *sd = mlx5_get_sd(secondary);
+	int err;
+
+	/* Idempotent: skip if TX root is already in the requested state. */
+	if (sd->tx_root_silent == disconnect)
+		return 0;
+
+	if (disconnect)
+		err = mlx5_fs_cmd_set_tx_flow_table_root(secondary, 0, true);
+	else
+		err = mlx5_fs_cmd_set_tx_flow_table_root(secondary,
+							 sd->alias_obj_id,
+							 false);
+	if (err)
+		return err;
+
+	sd->tx_root_silent = disconnect;
+	return 0;
+}
+
 static int sd_cmd_set_secondary(struct mlx5_core_dev *secondary,
 				struct mlx5_core_dev *primary,
 				u8 *alias_key)
@@ -688,7 +715,8 @@ static int sd_cmd_set_secondary(struct mlx5_core_dev *secondary,
 	if (err)
 		goto err_unset_silent;
 
-	err = mlx5_fs_cmd_set_tx_flow_table_root(secondary, sd->alias_obj_id, false);
+	err = mlx5_fs_cmd_set_tx_flow_table_root(secondary, sd->alias_obj_id,
+						 false);
 	if (err)
 		goto err_destroy_alias_ft;
 
@@ -707,7 +735,7 @@ static void sd_cmd_unset_secondary(struct mlx5_core_dev *secondary)
 	struct mlx5_sd *primary_sd;
 
 	primary_sd = mlx5_get_sd(mlx5_sd_get_primary(secondary));
-	mlx5_fs_cmd_set_tx_flow_table_root(secondary, 0, true);
+	mlx5_sd_secondary_conf_tx_root(secondary, true);
 	sd_secondary_destroy_alias_ft(secondary);
 	if (!primary_sd->fw_silents_secondaries)
 		mlx5_fs_cmd_set_l2table_entry_silent(secondary, 0);
@@ -936,6 +964,107 @@ struct auxiliary_device *mlx5_sd_get_adev(struct mlx5_core_dev *dev,
 	return &primary_adev->adev;
 }
 
+#ifdef CONFIG_MLX5_ESWITCH
+/* All SD members must have completed esw_offloads_enable (i.e., reached
+ * mlx5_esw_offloads_devcom_init) and become eswitch-peers of the primary.
+ * Until then, mlx5_eswitch_is_peer() returns false for the not-yet-paired
+ * member and shared_fdb_supported_filter would reject. When all PFs transition
+ * in parallel, only the last one to finish satisfies this gate; the earlier
+ * ones return 0 silently here.
+ */
+static bool mlx5_sd_all_paired(struct mlx5_core_dev *primary)
+{
+	struct mlx5_eswitch *primary_esw = primary->priv.eswitch;
+	struct mlx5_core_dev *pos;
+	int i;
+
+	mlx5_sd_for_each_secondary(i, primary, pos) {
+		if (!mlx5_eswitch_is_peer(primary_esw, pos->priv.eswitch))
+			return false;
+	}
+	return true;
+}
+
+static void mlx5_sd_activate_shared_fdb(struct mlx5_core_dev *primary)
+{
+	struct mlx5_sd *sd = mlx5_get_sd(primary);
+	struct mlx5_lag *ldev;
+	struct lag_func *pf;
+	int err;
+	int i;
+
+	if (!mlx5_sd_all_paired(primary))
+		return;
+
+	ldev = mlx5_lag_dev(primary);
+	if (!ldev) {
+		sd_warn(primary, "Shared FDB MUST have ldev\n");
+		return;
+	}
+
+	mutex_lock(&ldev->lock);
+	/* Check if SD FDB is already active for this group */
+	mlx5_lag_for_each(i, 0, ldev, sd->group_id) {
+		pf = mlx5_lag_pf(ldev, i);
+		if (pf->sd_fdb_active)
+			goto unlock;
+		break;
+	}
+
+	if (!mlx5_lag_shared_fdb_supported_filter(ldev, sd->group_id)) {
+		sd_warn(primary, "Shared FDB not supported\n");
+		goto unlock;
+	}
+
+	err = mlx5_lag_shared_fdb_create(ldev, NULL, 0, sd->group_id);
+	if (err)
+		sd_warn(primary, "Failed to create shared FDB: %d\n", err);
+	else
+		sd_info(primary, "Shared FDB created\n");
+
+unlock:
+	mutex_unlock(&ldev->lock);
+}
+
+void mlx5_sd_eswitch_mode_set(struct mlx5_core_dev *dev, u16 mlx5_mode)
+{
+	struct mlx5_core_dev *primary;
+	struct mlx5_sd *sd;
+	int err;
+
+	sd = mlx5_get_sd(dev);
+	if (!sd || !mlx5_devcom_comp_is_ready(sd->devcom))
+		return;
+
+	mlx5_devcom_comp_lock(sd->devcom);
+	if (!mlx5_devcom_comp_is_ready(sd->devcom))
+		goto unlock;
+
+	primary = mlx5_sd_get_primary(dev);
+
+	/* Secondary devices need TX root reconfiguration */
+	if (dev != primary) {
+		bool disconnect = (mlx5_mode == MLX5_ESWITCH_OFFLOADS);
+
+		err = mlx5_sd_secondary_conf_tx_root(dev, disconnect);
+		if (err) {
+			sd_warn(dev, "Failed to set TX root: %d\n", err);
+			goto unlock;
+		}
+	}
+
+	/* Try to activate shared FDB when all devices are in switchdev.
+	 * Shared FDB is optional - failure here doesn't fail the transition.
+	 */
+	if (mlx5_mode == MLX5_ESWITCH_OFFLOADS)
+		mlx5_sd_activate_shared_fdb(primary);
+
+unlock:
+	mlx5_devcom_comp_unlock(sd->devcom);
+}
+
+#endif /* CONFIG_MLX5_ESWITCH */
+
 void mlx5_sd_put_adev(struct auxiliary_device *actual_adev,
 		      struct auxiliary_device *adev)
 {
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.h b/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.h
index 7a41adbcee71..cb88bf34079a 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.h
@@ -45,6 +45,13 @@ mlx5_sd_get_devcom(struct mlx5_core_dev *dev)
 }
 #endif
 
+#ifdef CONFIG_MLX5_ESWITCH
+void mlx5_sd_eswitch_mode_set(struct mlx5_core_dev *dev, u16 mlx5_mode);
+#else
+static inline void
+mlx5_sd_eswitch_mode_set(struct mlx5_core_dev *dev, u16 mlx5_mode) { return; }
+#endif
+
 #define mlx5_sd_for_each_dev_from_to(i, primary, ix_from, to, pos)	\
 	for (i = ix_from;							\
 	     (pos = mlx5_sd_primary_get_peer(primary, i)) && pos != (to); i++)
-- 
2.44.0


