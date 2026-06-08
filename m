Return-Path: <linux-rdma+bounces-21963-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id esaFJv7LJmrbkgIAu9opvQ
	(envelope-from <linux-rdma+bounces-21963-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 08 Jun 2026 16:04:46 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2620C656E8F
	for <lists+linux-rdma@lfdr.de>; Mon, 08 Jun 2026 16:04:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=kjTs6K8g;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21963-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21963-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8BAB0303CD0F
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Jun 2026 13:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3113D3C5523;
	Mon,  8 Jun 2026 13:57:33 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010048.outbound.protection.outlook.com [52.101.85.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4923C3798;
	Mon,  8 Jun 2026 13:57:30 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780927053; cv=fail; b=ZtEQ3VPjyQNSSZjGUtL142QOV+LRKDG01KwmN6/UPaljSYI4swsONr1gmTMf/zGYAouO4vww1gAH9BogM/7Lg5uagMR2jfE122H1U2PHDXSEj1aBlX7HDdgcj6Ff6NbkCuXjcK6N/SYdvW73fdEWqieGlOm0u3aNWTOa51Eq6ys=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780927053; c=relaxed/simple;
	bh=gHj9tXS7zJoNIqhG83YMOZkG8ZNP4eN6YmXt1ES5MuE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ph77TgUESpDdPiQ+4bnUc+pOTDsfQpZUZJS3ZeVxtyjWdiz+xqN91ZfjlMvopI8WrgQ/9sjl3+rlB4I21KgEfKMUpMdAN+mfPek6kSo8UM8szLUgz+OhUuAa3UzCqMBxpSKFFaFzZYBzS13NYXUTRz13xvCEbt7WLzK4mU1dQgE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kjTs6K8g; arc=fail smtp.client-ip=52.101.85.48
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BXPeAj56nzKarp3G6ZqBckgzwrMQ/BCebqXCKf9EF7FHGTvhY8hg+mVF1sRupvFmuK7lRrEsn4MCOWpP8FpHGhnaWXU4Ueb10smr5ks8CUuy7xDXjzgvVRRwgobe97RKyHKprnfEjSfZnheT82dyzRI6vdEOmN5MFcCOBLAT7aMVaLHWslAgSMLp+fQ6sdW9yR21UhjLSryjsWW/isFP6TfFeA/IYQN3hzTxrpy+d50rqWE+rj7/yqi85WRgj9STUENIJWn+2R/ZWZhPNIWf4qv5JP0HcYR+lPhdL6AuuYPcDIBZG+BD5jyYl/Hm1+3ERWCN47qlafv2aWcJO/IzjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IOAVNpXMTyi+3tRn/5WYyakZRiJF90jGgkrGUz9ThOQ=;
 b=on0x6WeRSC4uXxIzWnap9TiBnpFf5YU1Qpjr/TlWvuBcLoxFRKc9zWjbZY3k93L0Ksz1UuMP0u9JYg032xR1mfwV9t0b0t2Z4MuqwF4im43oLFGyXiC9iDuYAg1uCVgnskUGZSSYzv+4WJ0wpsHjMQdVkYNiRx76Se9D8rt+x9lu7iy1XJXRTBSZabso4VM9f0zVdHBq3SMJR/H/I6rmRh5q+1/fKD0DXLhExMpLj774KQp/41dsRHzCO8OA1RffA3ptreWzG7SOJkrNBY4mJwRMTizqmU1YrIp3/7s3OgqX3xNVvllb5BQaURy66jktFm93fPOqb41YdZOwGoj3BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IOAVNpXMTyi+3tRn/5WYyakZRiJF90jGgkrGUz9ThOQ=;
 b=kjTs6K8grNvwD62DfYyjMYCN672RCkGI9FZiW/UsCHUQlvsPmrMjSVuDy8L4h2R+v4UjbuMQS1i5BBMd/UZt5WyAVZ3QMHRnkN5LZnQeZ7sqVya2N3pWjLtLBY5hUyRPaN3h0SnVSO7UOK5LEOUOcMZTkRg2/g0OwxwBitaxrF52aHAnZjfKUFMrxZZCp8iGIS6ANbwtJzv2M5SuLdoA+P0sIE64pgZF4N8XKu7sEuv/F/bBxRmRkWOmb8jxxaSUr+cDzxyvt4iVsIS2WzRzovTIYro3TC9YJoLdp1YIG2tSCl5p5qv0FsgbCIFzZuExLhpHnVEESNS+rvdyX+4XQw==
Received: from MN0PR03CA0017.namprd03.prod.outlook.com (2603:10b6:208:52f::11)
 by DM3PR12MB9326.namprd12.prod.outlook.com (2603:10b6:0:3d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Mon, 8 Jun 2026
 13:57:23 +0000
Received: from BN1PEPF0000468D.namprd05.prod.outlook.com
 (2603:10b6:208:52f:cafe::24) by MN0PR03CA0017.outlook.office365.com
 (2603:10b6:208:52f::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.13 via Frontend Transport; Mon, 8
 Jun 2026 13:57:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN1PEPF0000468D.mail.protection.outlook.com (10.167.243.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Mon, 8 Jun 2026 13:57:23 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 8 Jun
 2026 06:57:05 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 8 Jun 2026 06:57:05 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 8 Jun 2026 06:57:00 -0700
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
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>
Subject: [PATCH net-next V2 06/15] net/mlx5: SD, expend vport metadata for SD secondary devices
Date: Mon, 8 Jun 2026 16:55:38 +0300
Message-ID: <20260608135547.482825-7-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260608135547.482825-1-tariqt@nvidia.com>
References: <20260608135547.482825-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468D:EE_|DM3PR12MB9326:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e31ea36-5872-49ca-b6b5-08dec565ddda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|7416014|36860700016|6133799003|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	qlDZEcbr2BWBNazognkG9sIyiCkyYBFEZec5MzUUIATRndlL5IqXlXP8DvfMS5xACfIDbwy9WCk94Lz+MXiXZ/fHVdMHZohYyAlwoMdYcVOJccRzsMHVO0sgswvEg2ywQ/jDho1zhmcW0xPyL4TKZBmWLllu5rv19+oSqwnkzcoL0op2FqlwRXZwezpKlinB7FwK1Bz4K4lMPwf9xxZuL7+0a6FL50ELS/0RX1KbHLYp9T4yN+q79/WdlVRUxnDuNFOAU5Zli/pfdhRo7duONirD4TwtqEsMtEM/OeaOUfzGdUo5xmeehzPFl9PB12d7L1neD2d6GWCsdgQ4kM2HCwhbMMUsXauBWf97TIEBlBGVFGyQgPaai4DAHlX1m1Qs+fl9RCYredYZ6xl5tS7TWfejy9FHGxUg9inhv9wrs3jDLqeTYUDdnh9Zbtmh44EP3jzXBqBvg2i4KhN+fgcpixZYu7UAxamtzkGwUA63R4kKLm4edY1A3JkdUv/DXi4mYGHgC380xiDwh2OErgEoKtU2yeAK1TF+DAEwq8pc1IAsyDUJZ3Lbceu2rkwtf7VEO+hNlTwMtOkcpHSyLVSYv8EJhHymIJ+uKWCxSGIFJlj8jYwIz3cY88JiOikb79YQjPxpXUq/jaO+oC3oCAiSyN2A2LFiM6nB4mlB3BqJQNYT52CmNkIVoAXOP3s4lDVx+Fz5aC9tyDKeoZ6uq0ZreFtOSKjS39U9HHAptj8bwx0=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(7416014)(36860700016)(6133799003)(22082099003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	7yvVLiy0FbVkcmyRTpmagN6tW4gVK4FSC3IeTS+dWpYhvB0Yp4zN4952WaRLq5qZ5zP3PKTGu9WObghLB3m40oOyrSEt/aVYKCaurEyE269snubiTN2yT41wdw+HqNcZMnbzGjAIcR0w9Ai/8OtYrWczX340o58LcmtWJMu+3fNII6FbfRUQ6yK7pc6Jv6kfbOhFKeRg9iAsn2MiB4d38KZMvPBquhtpwQ0fJnXafTf++duhFcjeKjS8v9/RXPdE26WrPA6s3tkW/ONfKQWiDq2BqYGYMu0LxN16AO7gunAIVljpFO8P54/x40lH/k5cMZPJr292cH/iqV5n49SdDnrfCEyvQ+c9wobpKqp/vVR6Po0nrsQ+GWxEaDLqLFhsajGEPUiJN7zJARYvXo5Uqv/UnPC2qvf9Z7IS9yP3+pgXYGWGVOQPzJoSHs6jXVjg
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2026 13:57:23.5809
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e31ea36-5872-49ca-b6b5-08dec565ddda
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000468D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9326
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[23];
	TAGGED_FROM(0.00)[bounces-21963-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:saeedm@nvidia.com,m:leon@kernel.org,m:tariqt@nvidia.com,m:mbloch@nvidia.com,m:shayd@nvidia.com,m:ohartoov@nvidia.com,m:edwards@nvidia.com,m:horms@kernel.org,m:msanalla@nvidia.com,m:parav@nvidia.com,m:kees@kernel.org,m:moshe@nvidia.com,m:phaddad@nvidia.com,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:gal@nvidia.com,m:dtatulea@nvidia.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,nvidia.com:email,nvidia.com:mid,nvidia.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,Nvidia.com:dkim];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2620C656E8F

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
index afad05a1e3fe..8b1f3a25d80d 100644
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


