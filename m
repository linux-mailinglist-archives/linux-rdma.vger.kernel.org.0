Return-Path: <linux-rdma+bounces-22164-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id KNA/AgTxK2q2IAQAu9opvQ
	(envelope-from <linux-rdma+bounces-22164-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Jun 2026 13:44:04 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FE576790C8
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Jun 2026 13:44:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=UI3wtFfb;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22164-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22164-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8F7ED3487416
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Jun 2026 11:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4640A3A1688;
	Fri, 12 Jun 2026 11:40:26 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012010.outbound.protection.outlook.com [52.101.43.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85D33D666A;
	Fri, 12 Jun 2026 11:40:24 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781264426; cv=fail; b=eSHCqAFcgvKcesO8eHuUxZgRC4m6PFFhzPVhXeMhR4i70fVVMpvKSnD9VK/f/P08IJ+tVqit2sSzwRv8BirETAD+C6+3H3Ux0d/zimjOqYfj8Q2GAhHFh5ZrhnHrM9QuQa7aXOjfxgdNesidF1tpi+/ptpHBsRBEI05/k6Bv/hs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781264426; c=relaxed/simple;
	bh=9MUi4BUxsOhwi4EFX6sBpdoBVDYSfTVUByetGH7G9+0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WBmWpZnkuGfiMy3OHOroQlSwp2H/5j2wayiRkFfNbhiY992okeK9ZGdtgOdbyO/6h3AT7lu0LSX8ydM83KMBhwdElAHD2Elo2bOj5VqmS0qSXWhKnqyfjiOxq8rAEjDXwtiScwke8IosG17Q52kIF2cIqS27DE7LnMjekQkvqSw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UI3wtFfb; arc=fail smtp.client-ip=52.101.43.10
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ped8Sd27mBRxl6xy47pT9hzVMX7xM7BDRjvPhdCy4/KRtXjhlvTZD03gDM6Au/WAJuJkcAiAaoGIurnKYRsdAG87nFKArgXwh+gyA8IqUfVix/BQMpmi8JAuyL2z96UlcGOHCCJTH2TN3T/ZW3ysOKekXv49u+mCCgFPdEW60m3NH4tTSjvQu5z/NMQL9Beo0dRhq1bh+tS3QXpJ7RzhOR/Ex0yRUkJjlsdtrQii2VG7nNfsje1dL6vVaRnRsppBAnSbk9JfYFoeLIN6H7A+dmZ4fVI1UKo9udLOztSJEZ05jRquYnUjc3qaRQ8bmggMBrNhEdPw6XaA7csOtKBq0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fi7zvX1deVoder/OLZRX9mMPy0MUL64qDx+BCLRilHk=;
 b=PNm5xgygPPYXr/ULdfRhLOkbCjrqC6NIINl9GPt1Mv48XPKAisbwJx5R9Sqiq/jm6sqU0o7wcqxjPWyi0p71Z8uuK8q4ZW7YBUCtTuHRKV0SS/z0wvvhiAwRmntIBRCf1Q7xlz5WYwTe0Hhx83JRd+rvM7ARdCZReEFGeSEdjzpXrkVQY2z4F3OO889Rafdd9TT8A7kIsE4coThJ/pn2JHrfpz/FDdZ61LwEVbW3HFfX3vXl2/6X1eEzad7T0j4np5ZGjjWs4Z6+u4rfd1OkWWPDvBvOeX7FOKfVai8f1uX/mqGHbUQMTXTPMJS9Hk6evoR8/AuSzo0HtTi8GBOTdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fi7zvX1deVoder/OLZRX9mMPy0MUL64qDx+BCLRilHk=;
 b=UI3wtFfbV1AZUtwbQ3ZD/Y68iONQd1bNNAzZZ9gd07CGPVSI7XPPs/4xxj+9LL+f4Puy4PQfLbtvVj3+ZkUzU7uKiAU6XZaBYeCEKaubROL0VUWjpMIbyzCBYwh+ccDSwU6eVTVlZdd1gp9JjMHmbHCPK/AVnDLpYHKTwOSIHGJt14Y2FU7+aH6HyQBopRXlS+1rx3VBvpiGAmThaV5VlMneSGImf1hfqBsyqOPXqoqmzKmukDL1Zdf9PDl7hn599NpZOW5/syer50p0/xfkfQUAF9XMqOhoQi8KK/3SnLzXEmyRIkR9JAtoZCLIvIgRSj+oZzWhjop2325lWnNY9g==
Received: from PH7PR02CA0003.namprd02.prod.outlook.com (2603:10b6:510:33d::31)
 by PH8PR12MB7158.namprd12.prod.outlook.com (2603:10b6:510:22a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.13; Fri, 12 Jun
 2026 11:40:17 +0000
Received: from SN1PEPF000397AF.namprd05.prod.outlook.com
 (2603:10b6:510:33d:cafe::79) by PH7PR02CA0003.outlook.office365.com
 (2603:10b6:510:33d::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.13 via Frontend Transport; Fri,
 12 Jun 2026 11:40:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF000397AF.mail.protection.outlook.com (10.167.248.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Fri, 12 Jun 2026 11:40:17 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 12 Jun
 2026 04:40:03 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 12 Jun
 2026 04:40:02 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Fri, 12
 Jun 2026 04:39:56 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Shay Drory
	<shayd@nvidia.com>, Or Har-Toov <ohartoov@nvidia.com>, Edward Srouji
	<edwards@nvidia.com>, Maher Sanalla <msanalla@nvidia.com>, Simon Horman
	<horms@kernel.org>, Gerd Bayer <gbayer@linux.ibm.com>, Kees Cook
	<kees@kernel.org>, Moshe Shemesh <moshe@nvidia.com>, Parav Pandit
	<parav@nvidia.com>, Patrisious Haddad <phaddad@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>
Subject: [PATCH net-next V3 06/15] net/mlx5: SD, expend vport metadata for SD secondary devices
Date: Fri, 12 Jun 2026 14:38:55 +0300
Message-ID: <20260612113904.537595-7-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260612113904.537595-1-tariqt@nvidia.com>
References: <20260612113904.537595-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397AF:EE_|PH8PR12MB7158:EE_
X-MS-Office365-Filtering-Correlation-Id: 54005520-ba71-4aa9-434b-08dec8776062
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|7416014|376014|36860700016|82310400026|18002099003|22082099003|11063799006|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info:
	+JEBhiAZZf6AtSy0W13KE4X2u9nrqRQ40kivmtQoZAjDDrv58meC9tH36lYBSGJu9AfiA6hScApvk0ou0KvaHwOcel2Vg0myRg9Rt+XRhDFRMMhg7H+mi6Lr4O124mBvDK2WhoqCHK8zOCxfGnrGePIOgEvDiSM+3wX6rK/5WAO4czaa8odBd2aO+sv/xXxnM0qoAbz/NRK2PHWkH/B2+56W5u7fO/CrNZQcQmqXU0Mc6j4z24r+oM4hgSVO+E6LPfXovuPua13p2vc4UvR+Wlh8bwF+bKKyGIsuOIBX1pX4pqfS4bKbaB/TwxQQwIL4zckKQAwmQc3UjEdcoQiOg0+FvB45hRmyNNzdk/k1ZgzsjUg0dYTNBmlfa8tq6FadKVkV2CFLFYhyuwYvHx27YaccVeqCTnYNlyqRxpgkJA3U4y+U8BSLbQcv8djRnpn0bmE+2Ca2vAYtxrql7ZNmft0TQ9wC7XXtNC3Dot1q0yZIpRTfAZS1isHxCFx3ig+8QNwnZH01nvxtFiMAHrBdCa6ibYydOp8AQ9JMiguivC5Eq1/9nP4ww/kjFon1uXnzn/Qd/L4O2pzXGi0zntFJZzU1eKqSE52C51E7ACav3f/dVob0QqiNwWjAtw3PmEWP5MDPnrVkpXwzRVoS08SfQMDQ0SEDcVkJLNzu37RjyTq1K5QrLS13sEvMQxPr48Dyfc+yC86VpgxxZBZKQaLf1Ea3MEQpzWqVVy45qlHJGNk=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(7416014)(376014)(36860700016)(82310400026)(18002099003)(22082099003)(11063799006)(6133799003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	WSMgEe8Eza1RbzQHsrViNdg6eWo4kZHZi4i+BGQdvYFS7aHDmVDbvnu+JLsSC0KBwkJfpBPBk8O50AQAjXjHjFwcxFnITmuJ+BSa5+q8QjxU3jfx8dazcsXNreqca0L12msPTEUQ/KKrIQaUX84ZpIC63tFKkzfN3P0zUhUpihNUbMfyR+ggrq4x+oKcjkaTZQ/srqJDv/GObYOx4KpLhueyLwVUgEeGJ7wDCXmztzAnFKluVGpMLsAUgYu8WjWZw44a4JtIYbhCubzo/x9zt9GdBYBDyGnlIm0umVE3dCqZLOmMxTxDXIv56nKeuQB61c/3QAj0pjoMFg7mM4XvNuDQkSG01jMndSYUbGQwXply2/J3BUPoEi9/5LOK4av6PBb5GIe8hZo2XIBt8h3qeWZ1HboE9m7NBw47Q8JKatWLYHUeImihXf+KxuFtiTBD
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 11:40:17.5375
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 54005520-ba71-4aa9-434b-08dec8776062
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397AF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7158
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.16 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[23];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22164-lists,linux-rdma=lfdr.de];
	FORGED_SENDER(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:saeedm@nvidia.com,m:leon@kernel.org,m:tariqt@nvidia.com,m:mbloch@nvidia.com,m:shayd@nvidia.com,m:ohartoov@nvidia.com,m:edwards@nvidia.com,m:msanalla@nvidia.com,m:horms@kernel.org,m:gbayer@linux.ibm.com,m:kees@kernel.org,m:moshe@nvidia.com,m:parav@nvidia.com,m:phaddad@nvidia.com,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:gal@nvidia.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nvidia.com:email,nvidia.com:mid,nvidia.com:from_mime,vger.kernel.org:from_smtp];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3FE576790C8

From: Shay Drory <shayd@nvidia.com>

In Socket Direct configurations the primary and secondary PFs share the
same native_port_num. The eswitch vport metadata encodes pf_num in its
upper bits to distinguish vports across PFs. Without SD-awareness, both
PFs generate identical metadata, causing FDB rules to steer traffic to
the wrong representor.

Add mlx5_sd_pf_num_get() which remaps the pf_num for SD devices.
Use it so each PF in an SD group produces unique vport metadata.

Signed-off-by: Shay Drory <shayd@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../mellanox/mlx5/core/eswitch_offloads.c     |  6 +++---
 .../net/ethernet/mellanox/mlx5/core/lib/sd.c  | 21 +++++++++++++++++++
 .../net/ethernet/mellanox/mlx5/core/lib/sd.h  |  1 +
 3 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
index 12805e80ce57..366531d8ef02 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
@@ -3472,12 +3472,12 @@ u32 mlx5_esw_match_metadata_alloc(struct mlx5_eswitch *esw)
 	u32 vport_end_ida = (1 << ESW_VPORT_BITS) - 1;
 	/* Reserve 0xf for internal port offload */
 	u32 max_pf_num = (1 << ESW_PFNUM_BITS) - 2;
-	u32 pf_num;
+	int pf_num;
 	int id;
 
 	/* Only 4 bits of pf_num */
-	pf_num = mlx5_get_dev_index(esw->dev);
-	if (pf_num > max_pf_num)
+	pf_num = mlx5_sd_pf_num_get(esw->dev);
+	if (pf_num < 0 || pf_num > max_pf_num)
 		return 0;
 
 	/* Metadata is 4 bits of PFNUM and 12 bits of unique id */
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
index 6b007b038f8b..c670ed1dd63c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
@@ -85,6 +85,27 @@ bool mlx5_sd_is_primary(struct mlx5_core_dev *dev)
 	return sd->primary;
 }
 
+int mlx5_sd_pf_num_get(struct mlx5_core_dev *dev)
+{
+	struct mlx5_sd *sd = mlx5_get_sd(dev);
+	int pf_num = mlx5_get_dev_index(dev);
+	struct mlx5_core_dev *pos;
+	int i;
+
+	if (!sd)
+		return pf_num;
+
+	mlx5_devcom_comp_assert_locked(sd->devcom);
+	if (!mlx5_devcom_comp_is_ready(sd->devcom))
+		return -ENODEV;
+
+	mlx5_sd_for_each_dev(i, mlx5_sd_get_primary(dev), pos)
+		if (pos == dev)
+			break;
+
+	return pf_num * sd->host_buses + i;
+}
+
 struct mlx5_core_dev *
 mlx5_sd_primary_get_peer(struct mlx5_core_dev *primary, int idx)
 {
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.h b/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.h
index 011702ff6f02..7a41adbcee71 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.h
@@ -12,6 +12,7 @@ struct mlx5_sd;
 
 struct mlx5_core_dev *mlx5_sd_get_primary(struct mlx5_core_dev *dev);
 bool mlx5_sd_is_primary(struct mlx5_core_dev *dev);
+int mlx5_sd_pf_num_get(struct mlx5_core_dev *dev);
 struct mlx5_core_dev *mlx5_sd_primary_get_peer(struct mlx5_core_dev *primary, int idx);
 int mlx5_sd_ch_ix_get_dev_ix(struct mlx5_core_dev *dev, int ch_ix);
 int mlx5_sd_ch_ix_get_vec_ix(struct mlx5_core_dev *dev, int ch_ix);
-- 
2.44.0


