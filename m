Return-Path: <linux-rdma+bounces-16143-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6IEmC9L0eWn71AEAu9opvQ
	(envelope-from <linux-rdma+bounces-16143-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Jan 2026 12:36:50 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CD14A08CA
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Jan 2026 12:36:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B8E1A304E6BF
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Jan 2026 11:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FA6D352C57;
	Wed, 28 Jan 2026 11:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="b2Aj4SSc"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010064.outbound.protection.outlook.com [52.101.85.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0010434FF6E;
	Wed, 28 Jan 2026 11:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769599720; cv=fail; b=RS0WwVHc7vgHWQI3CdrN8Ss+14rz4jj3Me3rvTeSIKUXmLj6NrpHiNtvR+bA0jxfSLHf01Jcz+eqmrHiQ5zPo3NvKTcGkyazsse5JRnSvugW+nZNuDiSicXObUVq8ISgfZAY9+ev5yat4SOPtlpTevNzpykbryBifjvf7OFOlqE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769599720; c=relaxed/simple;
	bh=4X6OkJyt+De/hVz8lRlvSbUTEnGp07r1/E4Ydj77YHc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fzxwq3XzLnRnLjMc+xV5KqoyKCTh/wFnTDUzQtNBk+I7wECu2EZivteLIu1pIrdAEf2bobr6+H99lZIfcDwDQctrTJcPjn4SoTauId5nt+zu9QLFa6iebYsRuC8xtKNGRkkxbPHIVUpLzgZj2QDMVkgfP0b8untBXcDGC3fL9oE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=b2Aj4SSc; arc=fail smtp.client-ip=52.101.85.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DWQCOO0aB15Q5dkqxuo9mEIyifraDf82m5lOGripSpFxPvpXVilB7mbZZKb8bMS3TvYjkLlwtrmtn1WB6qv0vz2+FMqFPw8g0mpOOc1oz/I69qxUGEhrVISuyOBtHUvZqMQtospB7E4qX9gZ9EaaiEUluhXgUEQ4KDpODbCurZPiJD/O9xr3snpLHIjG67yQlrJvZSX5b2kUSGzvEtSJCpQeaT4KL+jM8+9pWaQLnJpKTP0PQsLrA7kQkFhVJQQAS3KiEeTzpqKUnrpNXmpsLN9ru0zz0RkNotM5iL/5UQa6Xu3g6jw9rpLEK30SIr1VrtsJqP5Yfp2sEdsaLT/Frg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nzYnVCMchYKOXWRsLJpQwZ7oAnHawQ3pC1zQfBKWudQ=;
 b=k3mxUH5QVN1kCU+UpgUtbrTeDkPrR263oPkPOEuFj7DUFjJejMSnNfWwzY85jryFOKMJ8i29V/sFQLgf9WATvcz0xXZTMJf5AeOSsVUrnSVLr+L0nDCCwEcz2mxxBlBvMGou85mAFoUeMcSjy34llFvrL2LP9j17mx56ZdqjqFreho0hEabyucT86XeUhR6Hn6v6q5O6G76eOYZYxfNzY5srHA5IyW6mX2m/AkpA08aufLar/IvWSfKmooJ8AhbvDfChFIhqLgI6k6idR084BDleQ5/RHoIREcy/Gu+PzKs6F4SL4bOocJiI79zWH9COWob/iyHHtToHd7pskf6/mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nzYnVCMchYKOXWRsLJpQwZ7oAnHawQ3pC1zQfBKWudQ=;
 b=b2Aj4SSc/IrZ+t4HHrrsZ4/PeMl3PdPTxEkc6K9PBTJkL/rrK1W5Ts/364b620+3/fV8up+TWmIpIOSg9gjv/IZNAqhWn5m1iEP5RBhfOialAS01KX4CZ+M77Jf5fRQgev7fHgXEyQWhrJ4uZHemb39rZEcvejmVXY5uf5bx4gK6k6G4G/woC4FJn3heCkygUiQYh0hgZrbBWC2L4sVaU3BcK1sPXGAW8sOn8vD3ejxkDMvW8BqrkO+ENiZr+TO0PnqkWBPV2L/VJZ0bzI5PRc9YR/YCfLaI8BXc343mvZ45u9YrrrgKGWLTz5U25puntNyKRrUim/+IV4V5IqeaVQ==
Received: from PH8P221CA0062.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:349::14)
 by BY5PR12MB4179.namprd12.prod.outlook.com (2603:10b6:a03:211::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Wed, 28 Jan
 2026 11:28:30 +0000
Received: from SN1PEPF0002BA4C.namprd03.prod.outlook.com
 (2603:10b6:510:349:cafe::cf) by PH8P221CA0062.outlook.office365.com
 (2603:10b6:510:349::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.8 via Frontend Transport; Wed,
 28 Jan 2026 11:28:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF0002BA4C.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Wed, 28 Jan 2026 11:28:29 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 28 Jan
 2026 03:28:18 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 28 Jan
 2026 03:28:18 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Wed, 28
 Jan 2026 03:28:12 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Donald Hunter <donald.hunter@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	Jonathan Corbet <corbet@lwn.net>, Saeed Mahameed <saeedm@nvidia.com>, "Leon
 Romanovsky" <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>, Cosmin Ratiu
	<cratiu@nvidia.com>, Jiri Pirko <jiri@nvidia.com>, Randy Dunlap
	<rdunlap@infradead.org>, Simon Horman <horms@kernel.org>, Krzysztof Kozlowski
	<krzk@kernel.org>
Subject: [PATCH net-next V7 09/14] devlink: Allow rate node parents from other devlinks
Date: Wed, 28 Jan 2026 13:25:39 +0200
Message-ID: <20260128112544.1661250-10-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260128112544.1661250-1-tariqt@nvidia.com>
References: <20260128112544.1661250-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4C:EE_|BY5PR12MB4179:EE_
X-MS-Office365-Filtering-Correlation-Id: 560eea3b-052e-4680-36f2-08de5e605cbe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CIYVOVugLh3OvM5XdViP2YHdAERNH9wGDtslcgkGtXq5Pjt6dC5vCscgQTOF?=
 =?us-ascii?Q?fChjBlyugjjsPBp0DPoXiP9/h/R6LvtfF6Wfq1QAgnapNv9fT4izptHfBoq+?=
 =?us-ascii?Q?RGyYzG5XMY3Mzva3NqNKyWe0D6o8U0jXKE8LI3ACai6Tn+voLtxMq97DYDUw?=
 =?us-ascii?Q?NMnaEsVa3IC/OgS2XsTzfuUiGkLi6qfYi2Nplew0l04XIBb540lxgwgM2IgV?=
 =?us-ascii?Q?RwMKenPxBjkbzyvEQKmJo+cIUr1opqyHr+7UgI/cN6l5mbOfd44e4QhuMo+n?=
 =?us-ascii?Q?xUMVHrgPFglrdO0ZSvWFKb0Y1Ev/ldid6rkP62K7emCviCppf2YHemzx4t3L?=
 =?us-ascii?Q?JTRICoaJxzTSBZz3cnGX70XvYybzw39OeUQ9EPCyDgJeQAgg9dYvFhiu/YV0?=
 =?us-ascii?Q?bmUXZ6gBrcWEzheRTCg0K7nE8br6klhM+mbCgyjYW7qm+Y8qDBeeaGPTS5h6?=
 =?us-ascii?Q?Yi+z3hO88GnSzFNxGm5Uf4e1aNy38Xoc8xOPRlp93MF75A/rDnqptI/31GKa?=
 =?us-ascii?Q?qPKKIVo1pK8N7wT/sUO/CfcM7dxtdBrDqM8V6zqxapUQ7i63sMbOecrF5SLE?=
 =?us-ascii?Q?PrGsCw+dOWhrmcaKfzaDXcx9qDaFqAkkYlDvjSZ6u8sFBB8L0gtPOh1Wun36?=
 =?us-ascii?Q?CFnwWrsuTrDVMeox1TWhHjw6VHYGW9hooUsrT3uDTecsLpL2AAKuaoxlXOum?=
 =?us-ascii?Q?gbzOQk6Ou3C4u/7qPeKoVNYats1XiqXYa8UUIc9KSpFxyZ8k3XyhrT28ESRF?=
 =?us-ascii?Q?JK7T5RGsTQ8l/qvtjGmaI+3FxBBPUjvwADphmXd9RP+oT6yaEx8qKQEJek82?=
 =?us-ascii?Q?qAMTBghLSQUnBqvMgJ630MoEfhefgLVbBEZ6T//EkPQjFT/yJRXtcseY6IT7?=
 =?us-ascii?Q?cDcG7H7tcE/2Oy8vf8PrZSJr/l4hx+Ngf6hVQrhSANd0pEEGvzH3h+djvm+1?=
 =?us-ascii?Q?1yFg2ljbuOdTlueNgIF8sq67znaw/4BLJRPMtzp8YprRJZ4ieS+lIZzpJm2Z?=
 =?us-ascii?Q?nC4VC7Ir89cGT/TSaWQqLuO0BtJJufCvdtVU0gOZLzWLgUl4x/Jm/600r7mo?=
 =?us-ascii?Q?yAV5OgUDxLZCNr+cgfRWLybxSeCfDEbpBFNOujHM+PDPT2Y6MOcUxm4TfuCP?=
 =?us-ascii?Q?TSRKQ09xzxqct5JQ3VzYTARz0Qwi+HvcuLVTD8XagfPakPqbBCdBSwwKtfn6?=
 =?us-ascii?Q?QvLvNfJUWBpO57YWeCNPb6gfizFFga7oaDwXpv/pBrFsHY3YuixUU24DJUrJ?=
 =?us-ascii?Q?MPxr4PxEswkBCdk/f9ocamBSmoQIOQMqxQhLB1oMSfxHaqzKCMas4E0Zacqb?=
 =?us-ascii?Q?mPAwyu89vUUIUVSpYD1y6vMMIcI0Bvgyc7PPayKayPCPMFDxZcPqiaE3cKNy?=
 =?us-ascii?Q?p98efWzKsqPMtEUTZS9QL1MVFmYlF/BgOiTYvWKCaTMyViSE/D9azthKxOF9?=
 =?us-ascii?Q?Lj3fZCtjzhtOOPx9PVimDL6xG+e3hV06V025HTAtjZpkRwnIuIgwknghOGxL?=
 =?us-ascii?Q?ekSx6Tuforl6YpG1Ff1eNO43yLT0Dzoa5gS86Djs3jtw8q5NeNKCjQmVTX1+?=
 =?us-ascii?Q?IC7kdmEEW0bCSY90PXAxIJytRxbJcHvnT0pq+QJhEe9UKfm1GXjTxZCauXZ5?=
 =?us-ascii?Q?xaxZFLvbgcugUySrLpYyc4dIQeENJ5UoEz/XLGp5Fsfk29nAB2RHOlmKpMhA?=
 =?us-ascii?Q?3zvHzQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 11:28:29.8040
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 560eea3b-052e-4680-36f2-08de5e605cbe
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4179
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16143-lists,linux-rdma=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,resnulli.us,lwn.net,nvidia.com,kernel.org,vger.kernel.org,infradead.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,Nvidia.com:dkim];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 8CD14A08CA
X-Rspamd-Action: no action

From: Cosmin Ratiu <cratiu@nvidia.com>

This commit makes use of the building blocks previously added to
implement cross-device rate nodes.

A new 'supported_cross_device_rate_nodes' bool is added to devlink_ops
which lets drivers advertise support for cross-device rate objects.
If enabled and if there is a common shared devlink instance, then:
- all rate objects will be stored in the top-most common nested instance
  and
- rate objects can have parents from other devices sharing the same
  common instance.

The parent devlink from info->user_ptr[1] is not locked, so none of its
mutable fields can be used. But parent setting only requires comparing
devlink pointer comparisons. Additionally, since the shared devlink is
locked, other rate operations cannot concurrently happen.

The rate lock/unlock functions are now exported, so that drivers
implementing this can protect against concurrent modifications on any
shared device structures.

Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../networking/devlink/devlink-port.rst       |  2 +
 include/net/devlink.h                         |  5 +
 net/devlink/rate.c                            | 91 +++++++++++++++++--
 3 files changed, 90 insertions(+), 8 deletions(-)

diff --git a/Documentation/networking/devlink/devlink-port.rst b/Documentation/networking/devlink/devlink-port.rst
index 5e397798a402..976bc5ca0962 100644
--- a/Documentation/networking/devlink/devlink-port.rst
+++ b/Documentation/networking/devlink/devlink-port.rst
@@ -417,6 +417,8 @@ API allows to configure following rate object's parameters:
   Parent node name. Parent node rate limits are considered as additional limits
   to all node children limits. ``tx_max`` is an upper limit for children.
   ``tx_share`` is a total bandwidth distributed among children.
+  If the device supports cross-function scheduling, the parent can be from a
+  different function of the same underlying device.
 
 ``tc_bw``
   Allow users to set the bandwidth allocation per traffic class on rate
diff --git a/include/net/devlink.h b/include/net/devlink.h
index fbb434185a67..1165dc1ae165 100644
--- a/include/net/devlink.h
+++ b/include/net/devlink.h
@@ -1585,6 +1585,11 @@ struct devlink_ops {
 				    struct devlink_rate *parent,
 				    void *priv_child, void *priv_parent,
 				    struct netlink_ext_ack *extack);
+	/* Indicates if cross-device rate nodes are supported.
+	 * This also requires a shared common ancestor object all devices that
+	 * could share rate nodes are nested in.
+	 */
+	bool supported_cross_device_rate_nodes;
 	/**
 	 * selftests_check() - queries if selftest is supported
 	 * @devlink: devlink instance
diff --git a/net/devlink/rate.c b/net/devlink/rate.c
index c062fd8a6c36..3d28a4c5bb5f 100644
--- a/net/devlink/rate.c
+++ b/net/devlink/rate.c
@@ -30,20 +30,56 @@ devlink_rate_leaf_get_from_info(struct devlink *devlink, struct genl_info *info)
 	return devlink_rate ?: ERR_PTR(-ENODEV);
 }
 
+/* Repeatedly locks the nested-in devlink instances while cross device rate
+ * nodes are supported. Returns the devlink instance where rates should be
+ * stored.
+ */
 struct devlink *devl_rate_lock(struct devlink *devlink)
 {
-	return devlink;
+	struct devlink *rate_devlink = devlink;
+
+	while (rate_devlink->ops &&
+	       rate_devlink->ops->supported_cross_device_rate_nodes) {
+		devlink = devlink_nested_in_get_lock(rate_devlink->rel);
+		if (!devlink)
+			break;
+		rate_devlink = devlink;
+	}
+	return rate_devlink;
 }
+EXPORT_SYMBOL_GPL(devl_rate_lock);
 
+/* Variant of the above for when the nested-in devlink instances are already
+ * locked.
+ */
 static struct devlink *
 devl_get_rate_node_instance_locked(struct devlink *devlink)
 {
-	return devlink;
+	struct devlink *rate_devlink = devlink;
+
+	while (rate_devlink->ops &&
+	       rate_devlink->ops->supported_cross_device_rate_nodes) {
+		devlink = devlink_nested_in_get_locked(rate_devlink->rel);
+		if (!devlink)
+			break;
+		rate_devlink = devlink;
+	}
+	return rate_devlink;
 }
 
+/* Repeatedly unlocks the nested-in devlink instances of 'devlink' while cross
+ * device nodes are supported.
+ */
 void devl_rate_unlock(struct devlink *devlink)
 {
+	if (!devlink || !devlink->ops ||
+	    !devlink->ops->supported_cross_device_rate_nodes)
+		return;
+
+	devl_rate_unlock(devlink_nested_in_get_locked(devlink->rel));
+	devlink_nested_in_put_unlock(devlink->rel);
 }
+EXPORT_SYMBOL_GPL(devl_rate_unlock);
 
 static struct devlink_rate *
 devlink_rate_node_get_by_name(struct devlink *devlink, const char *node_name)
@@ -120,6 +156,24 @@ static int devlink_rate_put_tc_bws(struct sk_buff *msg, u32 *tc_bw)
 	return -EMSGSIZE;
 }
 
+static int devlink_nl_rate_parent_fill(struct sk_buff *msg,
+				       struct devlink_rate *devlink_rate)
+{
+	struct devlink_rate *parent = devlink_rate->parent;
+	struct devlink *devlink = parent->devlink;
+
+	if (nla_put_string(msg, DEVLINK_ATTR_RATE_PARENT_NODE_NAME,
+			   parent->name))
+		return -EMSGSIZE;
+
+	if (devlink != devlink_rate->devlink &&
+	    devlink_nl_put_nested_handle(msg, devlink_net(devlink), devlink,
+					 DEVLINK_ATTR_PARENT_DEV))
+		return -EMSGSIZE;
+
+	return 0;
+}
+
 static int devlink_nl_rate_fill(struct sk_buff *msg,
 				struct devlink_rate *devlink_rate,
 				enum devlink_command cmd, u32 portid, u32 seq,
@@ -164,10 +218,9 @@ static int devlink_nl_rate_fill(struct sk_buff *msg,
 			devlink_rate->tx_weight))
 		goto nla_put_failure;
 
-	if (devlink_rate->parent)
-		if (nla_put_string(msg, DEVLINK_ATTR_RATE_PARENT_NODE_NAME,
-				   devlink_rate->parent->name))
-			goto nla_put_failure;
+	if (devlink_rate->parent &&
+	    devlink_nl_rate_parent_fill(msg, devlink_rate))
+		goto nla_put_failure;
 
 	if (devlink_rate_put_tc_bws(msg, devlink_rate->tc_bw))
 		goto nla_put_failure;
@@ -320,13 +373,14 @@ devlink_nl_rate_parent_node_set(struct devlink_rate *devlink_rate,
 				struct genl_info *info,
 				struct nlattr *nla_parent)
 {
-	struct devlink *devlink = devlink_rate->devlink;
+	struct devlink *devlink = devlink_rate->devlink, *parent_devlink;
 	const char *parent_name = nla_data(nla_parent);
 	const struct devlink_ops *ops = devlink->ops;
 	size_t len = strlen(parent_name);
 	struct devlink_rate *parent;
 	int err = -EOPNOTSUPP;
 
+	parent_devlink = info->user_ptr[1] ? : devlink;
 	parent = devlink_rate->parent;
 
 	if (parent && !len) {
@@ -344,7 +398,13 @@ devlink_nl_rate_parent_node_set(struct devlink_rate *devlink_rate,
 		refcount_dec(&parent->refcnt);
 		devlink_rate->parent = NULL;
 	} else if (len) {
-		parent = devlink_rate_node_get_by_name(devlink, parent_name);
+		/* parent_devlink (when different than devlink) isn't locked,
+		 * but the rate node devlink instance is, so nobody from the
+		 * same group of devices sharing rates could change the used
+		 * fields or unregister the parent.
+		 */
+		parent = devlink_rate_node_get_by_name(parent_devlink,
+						       parent_name);
 		if (IS_ERR(parent))
 			return -ENODEV;
 
@@ -644,6 +704,14 @@ int devlink_nl_rate_set_doit(struct sk_buff *skb, struct genl_info *info)
 		goto unlock;
 	}
 
+	if (info->user_ptr[1] && info->user_ptr[1] != devlink &&
+	    !ops->supported_cross_device_rate_nodes) {
+		NL_SET_ERR_MSG(info->extack,
+			       "Cross-device rate parents aren't supported");
+		err = -EOPNOTSUPP;
+		goto unlock;
+	}
+
 	err = devlink_nl_rate_set(devlink_rate, ops, info);
 
 	if (!err)
@@ -669,6 +737,13 @@ int devlink_nl_rate_new_doit(struct sk_buff *skb, struct genl_info *info)
 	if (!devlink_rate_set_ops_supported(ops, info, DEVLINK_RATE_TYPE_NODE))
 		return -EOPNOTSUPP;
 
+	if (info->user_ptr[1] && info->user_ptr[1] != devlink &&
+	    !ops->supported_cross_device_rate_nodes) {
+		NL_SET_ERR_MSG(info->extack,
+			       "Cross-device rate parents aren't supported");
+		return -EOPNOTSUPP;
+	}
+
 	rate_devlink = devl_rate_lock(devlink);
 	rate_node = devlink_rate_node_get_from_attrs(devlink, info->attrs);
 	if (!IS_ERR(rate_node)) {
-- 
2.44.0


