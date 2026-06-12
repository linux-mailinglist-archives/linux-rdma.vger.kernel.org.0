Return-Path: <linux-rdma+bounces-22162-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id kJXsKrnwK2qhIAQAu9opvQ
	(envelope-from <linux-rdma+bounces-22162-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Jun 2026 13:42:49 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E5856790A9
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Jun 2026 13:42:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=EpmsqxMO;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22162-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22162-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 866D93432240
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Jun 2026 11:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACD3A3A1688;
	Fri, 12 Jun 2026 11:40:19 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010036.outbound.protection.outlook.com [52.101.46.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F0030F938;
	Fri, 12 Jun 2026 11:40:17 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781264419; cv=fail; b=b6t7TEBaxAmILdNU4e4/mI65ewVYhxm3Q9oL2QkBpC0+PTLq/UUhjB1/ZqKq12fUVGjsxgt+KdjRy+OHu/sr1x0A/2QP61+KWtbQ9WAwke6NNl7LkF9HuVMNlOE3fS7QpyM5boVlBvhn2a3wIJk8i/tCkIIKR7ohXi7/y1Sh9/U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781264419; c=relaxed/simple;
	bh=77qd9/2zCh0/4tVNtaXVrShlOwgX4awF00MmVlyQJ64=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ab+uK/TEHIAY4ljGqKNIgtUQIBvnt68GUhZbJ9WlQAVQc+z5vz9fFijywuYiL3nFupy5QK0SgRKsQ0qu9OEHTYpO4MSIZ24m5QddxQ1G+eSPc95eIxQz6PDjJfGBcGRPKyGul9IKEYNzKFIAQySdbmLDMcRfjTDVneyryelZMU0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EpmsqxMO; arc=fail smtp.client-ip=52.101.46.36
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jEXquuOnbTREyPyYTYbmru6bw0QYVKkP04sVe7praKnd0MRBPK8dUnRUJUClmDkoiLpWmfDwdTPPtLF69iw2FN/CVjobpBKIZ/cBAi1xI/xA2pAHf8PNbvFZL/MkSy265/sxmKww4KCVkctLRGGacefEbx3rBhkeHOZdpI1EpHs4GDppBemRWjJsyyWK313sCZYGlbga8FnDLja+y4LOYjA33myf/JIXCaObZRzYGb2azSGgA4tTvuETIX1IJwmjhQ5TqR0DgdBWM9oW+Dh8kYOvDQ0LYQEmG+o+lPzoGBuUfIQ32aeHibMFDUonmnJMwgfidywsIgZqK9nfrhaGJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ffeZsBsB3kqqX2D7sipN1jhOwLWKZUktzeGwIK3fqNc=;
 b=LUiN2vJ3R1gzOTRc7AO/ujIEpUObYReG7p/qsXRLI2YCVSkDqsBS1T6F+4/ubBCVaVom3mC840O2Ke/7U8rGOl9M9klKVZRRHhSOpRpdIXHOAQo78GyJNQYa9b6Ro3q9A6J+rIBwtOARrMGDpKIo0HfIYx9Zisq/Ac3iYFQ5FrhK0g5hCs0oJVvLWifuaTd+OtPaBdMGfcD/Zskmfm9MFHPeXoXa4FbY1ifgMYdBG0vBE6rwhMQjGJMSp/g161uNGLjJ3QuE2TgGPQxf4wHVDJPG8FQnEOscQw1WhrV7jPe01yTd1cykJ0IZ+Ay3ZLA5biXFFJr8nxklyzQl2DOPGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ffeZsBsB3kqqX2D7sipN1jhOwLWKZUktzeGwIK3fqNc=;
 b=EpmsqxMOOUD7kEcYJzf+LAbgTINnetTbRgAsb9Xc9hWIQ1wNVMGljHPayBIMZS3nZVPAg9IYmOhI3OtWPi5NTSLr2izhVFtjRbfkKKWV5VGWQjwpsNHRhPu1buHg0DxfiVw01YLSLxBLVkJOKtpuA+KpnwBRHQljNNdvDvZFbEsbjR1rIpS1vR2eahg7IT2DzKhwJlAe77Ys3OIjTt70JpzXKgtBPHctp3pHhD6H/nXIpUE0lKAg2X+l0Vs3U+GoA39KSjLQquQUniXIqkb7dBYJ5vAvDxoHjSMmPZzvriEDkNqtZ0Y0pxU3lJUVurhhDSfLQZT+Rrt5ZKoQ6+FoTA==
Received: from PH8PR07CA0033.namprd07.prod.outlook.com (2603:10b6:510:2cf::20)
 by DS0PR12MB7630.namprd12.prod.outlook.com (2603:10b6:8:11d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.14; Fri, 12 Jun
 2026 11:40:10 +0000
Received: from SN1PEPF000397B5.namprd05.prod.outlook.com
 (2603:10b6:510:2cf:cafe::42) by PH8PR07CA0033.outlook.office365.com
 (2603:10b6:510:2cf::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.15 via Frontend Transport; Fri,
 12 Jun 2026 11:40:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF000397B5.mail.protection.outlook.com (10.167.248.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Fri, 12 Jun 2026 11:40:09 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 12 Jun
 2026 04:39:50 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 12 Jun
 2026 04:39:49 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Fri, 12
 Jun 2026 04:39:43 -0700
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
Subject: [PATCH net-next V3 04/15] net/mlx5: SD, make primary/secondary role determination more robust
Date: Fri, 12 Jun 2026 14:38:53 +0300
Message-ID: <20260612113904.537595-5-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B5:EE_|DS0PR12MB7630:EE_
X-MS-Office365-Filtering-Correlation-Id: 643d7a8f-8001-4d70-2d14-08dec8775b51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|23010399003|376014|7416014|82310400026|22082099003|18002099003|56012099006|5023799004|11063799006;
X-Microsoft-Antispam-Message-Info:
	PLBa+vrYQV7wGX6QIBugdGO3H9L1I4S/F0kAYmAfFj4g0FC9jAOfF3jfDOEgax/MbvWZinz4B8CUdUs7HumMaRAybLkUPzIjqEgvm8Ee+4XKO7I9E75Y2IBvNx2ERE9Qd5CtXWmsKz4BmsSR5iN6SstupJ9zr9iSclzmKsn9tHzL0TQkKPaawOvYz487hMp2jO/bzoY+uNe3SMQMarXO18eVf6KsYs9qiilRA+D5PFZ+YG6MV0afFijnjdkxfuT8rqJ08EkBhrrIdPIfSr12a4Wfqw70OrktPCdx0Laibu/DwHlVMtOgwkJSyg1i0XrC+rS+Hzgeexcna+sbwujiIx+GA2DeZOMYDqS5EDysF7IPwVxPAn18DCOWUbM+MYH9En+Jl3cnVFW1eU9z+fDrHTto857CELaSmxHXu33HaBsf1n851a9APsQm4HfX/pyC6wA3SzPBfsoLB/2/kBTlbXVpHyru3+XvvM7hcixkLArR8Mhf2loV8lkNqb+3EVFweFbNpvTit6C41ZacWrpDnkAJcPPVy7xVieUnl11LiOMntPrlmbILTM4MWLgINMJFFTteHKoR2QThUtbnH3MIqUENWTXIKoNXuha0Jju8K6/7cqI3p+LF1InGYNHOePksEG5Zz814IvE026JXgFbmTvLZyqtBP5+NUvk0larUJbyi7wYbB9qBj+NR63X7rgAfWdvytyS/ulipo3FkkZLixjsXwML+iRZYptXQxh3ZSls=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(23010399003)(376014)(7416014)(82310400026)(22082099003)(18002099003)(56012099006)(5023799004)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	a8Fg6AS/8O3QepBTD4bZzu/FzAcSVmm+oNjPyHExkZbjjEvcQlBNIETtDMtzJSz0NQR0rRj5lxFB5162lpDqQGN6gyI59gBrHbkrnrUufQyQSJsWR9a4L/Mby7onMhzcXaSVcexyB1tkAckesPcvV5pDUR3BAWKzPOzhGDrXmkF8F2G0G22iAltwDv4vqwQNW+HFyDffjQIRYkfPo7mrSngmIINlcMkS+zls2DrYknOH79zyoWH6VghN+pgbAl3YWPIMgFxFMkNQ4VK8QgKszqK6TB0tHHOhS72EkYRzZbbPac4KAxN9yMT1Z1iy3oY1jYGlyehYszjpdIw44cHHPlDtuHUe7eVRHi8Ud+zjFOM8RKTddAfc+nh0YMSMgr7PGZN7rzwEeS0vFOYvDBuOrWRT2TeZD3I2H1WhmANMcu+CyadO539iUo2d7mS9+G+8
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 11:40:09.0467
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 643d7a8f-8001-4d70-2d14-08dec8775b51
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7630
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
	TAGGED_FROM(0.00)[bounces-22162-lists,linux-rdma=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,nvidia.com:mid,nvidia.com:from_mime,Nvidia.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3E5856790A9

From: Shay Drory <shayd@nvidia.com>

Refactor SD group registration to use devcom event-driven role
determination to ensure SD is marked as ready only after roles are fully
assigned and the group state is consistent, making outside accessors,
which will be added in downstream patches, safe to use without races.

The devcom events:
- SD_PRIMARY_SET event: each device compares bus numbers with peers
  to determine which should be primary
- SD_SECONDARIES_SET event: secondaries register themselves with the
  elected primary device

Signed-off-by: Shay Drory <shayd@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/lib/sd.c  | 138 +++++++++++++-----
 1 file changed, 104 insertions(+), 34 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
index 25286ecd724e..5209a27f82ed 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
@@ -26,6 +26,8 @@ struct mlx5_sd {
 		struct { /* primary */
 			struct mlx5_core_dev *secondaries[MLX5_SD_MAX_GROUP_SZ - 1];
 			struct mlx5_flow_table *tx_ft;
+			/* Next index for secondary registration */
+			u8 next_secondary_idx;
 		};
 		struct { /* secondary */
 			struct mlx5_core_dev *primary_dev;
@@ -374,62 +376,128 @@ static void sd_lag_cleanup(struct mlx5_core_dev *dev)
 	mutex_unlock(&ldev->lock);
 }
 
+enum {
+	SD_PRIMARY_SET,
+	SD_SECONDARIES_SET,
+};
+
+static void sd_handle_primary_set(struct mlx5_core_dev *dev,
+				  struct mlx5_core_dev *peer)
+{
+	struct mlx5_sd *peer_sd = mlx5_get_sd(peer);
+	struct mlx5_sd *sd = mlx5_get_sd(dev);
+	struct mlx5_core_dev *candidate;
+	struct mlx5_sd *candidate_sd;
+
+	/* Peer is the device that being sent to all the other devices in the
+	 * group. Hence, use peer to get the candidate device.
+	 */
+	candidate = peer_sd->primary ? peer : peer_sd->primary_dev;
+
+	if (dev->pdev->bus->number >= candidate->pdev->bus->number)
+		return;
+
+	candidate_sd = mlx5_get_sd(candidate);
+
+	sd->primary = true;
+	candidate_sd->primary = false;
+	candidate_sd->primary_dev = dev;
+	peer_sd->primary = false;
+	peer_sd->primary_dev = dev;
+}
+
+static void sd_handle_secondaries_set(struct mlx5_core_dev *dev,
+				      struct mlx5_core_dev *peer)
+{
+	struct mlx5_sd *peer_sd = mlx5_get_sd(peer);
+	struct mlx5_sd *sd = mlx5_get_sd(dev);
+	u8 idx;
+
+	/* Primary has nothing to register with itself. */
+	if (sd->primary)
+		return;
+
+	/* dev is a secondary device, peer is the primary device.
+	 * Secondary registers itself with the primary.
+	 */
+	idx = peer_sd->next_secondary_idx++;
+	peer_sd->secondaries[idx] = dev;
+	sd->primary_dev = peer;
+}
+
+static int mlx5_sd_devcom_event(int event, void *my_data, void *event_data)
+{
+	struct mlx5_core_dev *peer = event_data;
+	struct mlx5_core_dev *dev = my_data;
+
+	switch (event) {
+	case SD_PRIMARY_SET:
+		sd_handle_primary_set(dev, peer);
+		break;
+	case SD_SECONDARIES_SET:
+		sd_handle_secondaries_set(dev, peer);
+		break;
+	}
+
+	return 0;
+}
+
 static int sd_register(struct mlx5_core_dev *dev)
 {
-	struct mlx5_devcom_comp_dev *devcom, *pos;
 	struct mlx5_devcom_match_attr attr = {};
-	struct mlx5_core_dev *peer, *primary;
-	struct mlx5_sd *sd, *primary_sd;
-	int err, i;
+	struct mlx5_devcom_comp_dev *devcom;
+	struct mlx5_core_dev *primary;
+	struct mlx5_sd *primary_sd;
+	struct mlx5_sd *sd;
+	int err;
 
 	sd = mlx5_get_sd(dev);
 	attr.key.val = sd->group_id;
 	attr.flags = MLX5_DEVCOM_MATCH_FLAGS_NS;
 	attr.net = mlx5_core_net(dev);
-	devcom = mlx5_devcom_register_component(dev->priv.devc, MLX5_DEVCOM_SD_GROUP,
-						&attr, NULL, dev);
+	devcom = mlx5_devcom_register_component(dev->priv.devc,
+						MLX5_DEVCOM_SD_GROUP,
+						&attr, mlx5_sd_devcom_event,
+						dev);
 	if (!devcom)
 		return -EINVAL;
 
 	sd->devcom = devcom;
 
-	if (mlx5_devcom_comp_get_size(devcom) != sd->host_buses)
-		return 0;
-
 	mlx5_devcom_comp_lock(devcom);
-	mlx5_devcom_comp_set_ready(devcom, true);
-	mlx5_devcom_comp_unlock(devcom);
+	if (mlx5_devcom_comp_get_size(devcom) != sd->host_buses ||
+	    mlx5_devcom_comp_is_ready(devcom))
+		goto out;
 
-	if (!mlx5_devcom_for_each_peer_begin(devcom)) {
-		err = -ENODEV;
+	/* Send SD_PRIMARY_SET event with this device.
+	 * All peers will receive this event and compare to this device.
+	 * The one with lowest bus number will be marked as primary.
+	 */
+	sd->primary = true;
+	err = mlx5_devcom_locked_send_event(devcom, SD_PRIMARY_SET,
+					    SD_PRIMARY_SET, dev);
+	if (err)
 		goto err_devcom_unreg;
-	}
 
-	primary = dev;
-	mlx5_devcom_for_each_peer_entry(devcom, peer, pos)
-		if (peer->pdev->bus->number < primary->pdev->bus->number)
-			primary = peer;
+	/* Broadcast SD_SECONDARIES_SET. Each non-sender peer's handler runs;
+	 * the primary's handler returns early so only secondaries register.
+	 */
+	primary = sd->primary ? dev : sd->primary_dev;
+	if (!sd->primary)
+		sd_handle_secondaries_set(dev, primary);
+	mlx5_devcom_locked_send_event(devcom, SD_SECONDARIES_SET,
+				      DEVCOM_CANT_FAIL, primary);
 
 	primary_sd = mlx5_get_sd(primary);
-	primary_sd->primary = true;
-	i = 0;
-	/* loop the secondaries */
-	mlx5_devcom_for_each_peer_entry(primary_sd->devcom, peer, pos) {
-		struct mlx5_sd *peer_sd = mlx5_get_sd(peer);
-
-		primary_sd->secondaries[i++] = peer;
-		peer_sd->primary = false;
-		peer_sd->primary_dev = primary;
-	}
-
-	mlx5_devcom_for_each_peer_end(devcom);
+	if (primary_sd->next_secondary_idx + 1 == sd->host_buses)
+		mlx5_devcom_comp_set_ready(devcom, true);
+out:
+	mlx5_devcom_comp_unlock(devcom);
 	return 0;
 
 err_devcom_unreg:
-	mlx5_devcom_comp_lock(sd->devcom);
-	mlx5_devcom_comp_set_ready(sd->devcom, false);
-	mlx5_devcom_comp_unlock(sd->devcom);
-	mlx5_devcom_unregister_component(sd->devcom);
+	mlx5_devcom_comp_unlock(devcom);
+	mlx5_devcom_unregister_component(devcom);
 	return err;
 }
 
@@ -672,6 +740,7 @@ int mlx5_sd_init(struct mlx5_core_dev *dev)
 		peer_sd->primary_dev = NULL;
 	}
 	primary_sd->primary = false;
+	primary_sd->next_secondary_idx = 0;
 	mlx5_devcom_comp_set_ready(sd->devcom, false);
 	mlx5_devcom_comp_unlock(sd->devcom);
 	sd_unregister(dev);
@@ -719,6 +788,7 @@ void mlx5_sd_cleanup(struct mlx5_core_dev *dev)
 		peer_sd->primary_dev = NULL;
 	}
 	primary_sd->primary = false;
+	primary_sd->next_secondary_idx = 0;
 out_ready_false:
 	mlx5_devcom_comp_set_ready(sd->devcom, false);
 out_unlock:
-- 
2.44.0


