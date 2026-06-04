Return-Path: <linux-rdma+bounces-21751-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id QooeCYRnIWqbFwEAu9opvQ
	(envelope-from <linux-rdma+bounces-21751-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 04 Jun 2026 13:54:44 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DF3463F9C4
	for <lists+linux-rdma@lfdr.de>; Thu, 04 Jun 2026 13:54:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=D65igEqP;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21751-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21751-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C2DBE31571C4
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Jun 2026 11:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 590A1438FEF;
	Thu,  4 Jun 2026 11:46:16 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010049.outbound.protection.outlook.com [52.101.61.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B05425CD0;
	Thu,  4 Jun 2026 11:46:13 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780573576; cv=fail; b=qC9EsnVCBGMnwfeFNocIeePV8CXMCYe7OJDkg3R3g4EzwupNrsDcwaAWAcsBa2gnhSzI5ia8pfw9BkzQ0FUplu8+wzaXOobrL4PidwSQrz1O071dBK2NM148FcfS7O9AnSwjUTNMiAu8vvHLk3f5WIw21fhwcbZIjc+XMvl0rS4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780573576; c=relaxed/simple;
	bh=rQ22eNsSCZrbd/KzcTXg7qekydIYOrMDtp5ZoAHeGoE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q4v2xAbJ0PWQkW12roBfio1ATm8ugWFtRygJqNKDemnM0GqDsuvLFTl14vaMWazLfHvyFqltK8Il0AvH8CXNFg/1JhqNgljSx7uzj3OqUjFydBx1ODeffyXhcR259AFQOG5uAZuUu7SguMpTgY8r5ghNX6FOCXcaO4Z2BBt6p1M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=D65igEqP; arc=fail smtp.client-ip=52.101.61.49
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NGWTDu/DOSNeYDEFmNcGkdxbARj+1lbD55o4dAky+pivnQIc7JxJckcURYshcZYH3ke/Y8MrHIM8uj4Qsd9FPUCqL4jWVeL4zDkI4IOW5W6IFsdLEPf6T/2p3T8YetxIMPoAWcN4hRNXGpsDfLJHhAsgM2bstow0XQxJVznKHiLj2cgUWex+yTOi+it620e40xu3d5RKH2xzDmqJW0leayi9OdjS4F/vWGYg6I6fihZqUsWN5O0yWFkxx9sPDM5QJtUnrieZEcigfy5TUNem6O5Qb+gWyzZbol36sa17arx5YbYtkwlVOhob0u1u1vHEsbMMhlmBweS2DE1gEstnUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cQZcBLJCZHvW3Ntw1r3ypf69EVU9L+YsENmz6th/NdQ=;
 b=j8G3BN3P58z4JC9nXkM0dHNHSXYjKkffKo7vc8GIIJGYzNWN+uXI2s3OqAZn8ctQaN96uChcvKQXGb6B+2uSSsmdisKfMGMUQlePPwQYkwsvFa5jsZujRrjFVPLk0JSqJwmg0P2eW5cegRlxFsn45WI40O+Ftuy7mepPFWOyFdwP5392HHGeW+6b0qeyFVVvsei5uKIGNZc/zsIJ1zAFpibMhWP/caKN/CCBLiHBd1XeekK8zixu6QNcDCEFinKXIt7xL9naU8M1OZ3f6sYOz/nPsZhs8QGLjw7M3bDDGVEOPjIWWilmM+6PWZcOICYC7zzYIwB/kKm3mTs81zjwOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cQZcBLJCZHvW3Ntw1r3ypf69EVU9L+YsENmz6th/NdQ=;
 b=D65igEqPXsok7DYU8o/ScbdmyMQOKB8fo/YwDRxywzYwV0ojSRkQUhTHDXMONubsteC1RX5tdPniyi9pGSamOFelPghlHYAmoWY2PEGMWq5Iue4PwzUr2d00Ehv8uDUeWQfrg4mH2j9scAPTF7QcJ/JQtK/eZ4L4fv7tvOQHtRdscxJnH7pckHIgplbntBFKNKKY4uJQ0GJdvf84mI6ziFoAcyeazQ5EMPDX9r7jGPfxGZ+aac/IM3yPfUwb7w6snzk11Qh8EKtSXzQkc2iov8KZFqbOPakKa2YFW+bkpQcytEorWZzMILawwu8arSWUBSQxw9/bam+98Ut2Exjoog==
Received: from BN0PR04CA0176.namprd04.prod.outlook.com (2603:10b6:408:eb::31)
 by MW4PR12MB6998.namprd12.prod.outlook.com (2603:10b6:303:20a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Thu, 4 Jun 2026
 11:46:06 +0000
Received: from BN2PEPF000044A2.namprd02.prod.outlook.com
 (2603:10b6:408:eb:cafe::42) by BN0PR04CA0176.outlook.office365.com
 (2603:10b6:408:eb::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.7 via Frontend Transport; Thu, 4
 Jun 2026 11:46:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN2PEPF000044A2.mail.protection.outlook.com (10.167.243.153) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Thu, 4 Jun 2026 11:46:04 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 4 Jun
 2026 04:45:51 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 4 Jun 2026 04:45:51 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 4 Jun 2026 04:45:46 -0700
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
Subject: [PATCH net-next 04/15] net/mlx5: SD, make primary/secondary role determination more robust
Date: Thu, 4 Jun 2026 14:44:44 +0300
Message-ID: <20260604114455.434711-5-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A2:EE_|MW4PR12MB6998:EE_
X-MS-Office365-Filtering-Correlation-Id: a6b3e7fe-c907-486f-2cf4-08dec22edc22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|1800799024|36860700016|18002099003|22082099003|56012099006|5023799004|11063799006;
X-Microsoft-Antispam-Message-Info:
	VuekgTifV38ze24U1wcKUsX2mYYOgpxzJaYMUdwsCAHvqFNrEbuWxFvnZLn/eq4QZg80wXzKMiRq2O6V+a2Gh84OVC3vgKIKh6pljvUxl3cX5Zlf4DQxRW/IeSEbEqPNOQdDLEdYJ/oogQEkqNhMeUU/lmHpA3Nrmx7pcq72lbMHWsH5xKwIz2uohX849akRrcsDyZ/CwrgPXixw9o1ZoZubzaQ3IHC37IXydWSew4g7qTPrQUHPJy32OA+owFAePeN7oMD8CNfWkID4fE4gen+aHkWgSmxYPExt1ULaghN4vgcSu/S2Oty5NR4pNuqFDB5b/Lz8uPcMOp8MAn3rHogacqfq94YSbJJqwbUjSpAA17cetiUIimBiSGHse6E/Zi4atJTFqiOQlmzWmuTSO54tePZ4aRmVhfricrVR5u8ipHAVFzx1AmP0Y65nGAEJkH+vTBRCOSXaB/y9rUeMHBamyNpXktaNGG9F094/EeIDbNYSHdfFN3TvwJS/bedrP+NECvMOL3IYXBwCdOt/pBriqxKXml5OK+th+0b8z1Z/6TMCqokQNHfP7ahvP4cmCKtT2r0LPOWRy2ebOGpUjF8LK87P14g5Imd6P6jpOY/yozuTUuRJryVNsRHY2VPeZVSZBcqVDH5pv3UPkjec3UNcMZ7jPqnVFaDrMHWaHgiOBvlkTkw8IEmdOcWXeKpud9oRc30mnyPLIxxYaEYct0/F5rJfx483Z/tnn9rcYcw=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(1800799024)(36860700016)(18002099003)(22082099003)(56012099006)(5023799004)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ubMy+NQYOW3sXNC5g144K6IkGn0O/+Jsi/ekD0J+PJIfE/6j4s0CeqmJyn3BYjkcCONlawWEshlgjM6c9yw0EvTUngAj7wqGVt26VHS5YQ4QEFMTS5gz0zojnpJSFtoE/Xd+3Psuy8IBn+YCUJeoSUU3dPBbNfqzk6sYvS1gSGeMK7VlIiqTcxofXOtdfgzw4uPps+bHmkPrVRXKsSSis4k10PmIevlzmkuYq14dagVS/scgh5a8h3Poi5d4BqK5b1TqBQp0yRxBDZ7wiPSdunhV67HemA60ZptVhnkoa2CvcnI3PRETulBS7J8ViWt6w0jQrqdT0SgcxBCs9jtr+MwzTgpopyWBMYeEiBUyGgV9q4+glLwPALMQaxOc1f2MzVUYFu6XHcPm+HMBQLquE4nbLsF7lKrXYkMxenFNuhmlSX7FWcbernPBVYdgETu5
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 11:46:04.8811
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a6b3e7fe-c907-486f-2cf4-08dec22edc22
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6998
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[22];
	TAGGED_FROM(0.00)[bounces-21751-lists,linux-rdma=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,Nvidia.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:mid,nvidia.com:from_mime,nvidia.com:email];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6DF3463F9C4

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
 .../net/ethernet/mellanox/mlx5/core/lib/sd.c  | 137 +++++++++++++-----
 1 file changed, 102 insertions(+), 35 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
index 25286ecd724e..41979bf6a615 100644
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
@@ -374,62 +376,125 @@ static void sd_lag_cleanup(struct mlx5_core_dev *dev)
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
-
-	primary = dev;
-	mlx5_devcom_for_each_peer_entry(devcom, peer, pos)
-		if (peer->pdev->bus->number < primary->pdev->bus->number)
-			primary = peer;
 
-	primary_sd = mlx5_get_sd(primary);
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
+	/* Broadcast SD_SECONDARIES_SET. Each non-sender peer's handler runs;
+	 * the primary's handler returns early so only secondaries register.
+	 */
+	primary = sd->primary ? dev : sd->primary_dev;
+	if (!sd->primary)
+		sd_handle_secondaries_set(dev, primary);
+	mlx5_devcom_locked_send_event(devcom, SD_SECONDARIES_SET,
+				      DEVCOM_CANT_FAIL, primary);
 
-	mlx5_devcom_for_each_peer_end(devcom);
+	mlx5_devcom_comp_set_ready(devcom, true);
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
 
@@ -672,6 +737,7 @@ int mlx5_sd_init(struct mlx5_core_dev *dev)
 		peer_sd->primary_dev = NULL;
 	}
 	primary_sd->primary = false;
+	primary_sd->next_secondary_idx = 0;
 	mlx5_devcom_comp_set_ready(sd->devcom, false);
 	mlx5_devcom_comp_unlock(sd->devcom);
 	sd_unregister(dev);
@@ -719,6 +785,7 @@ void mlx5_sd_cleanup(struct mlx5_core_dev *dev)
 		peer_sd->primary_dev = NULL;
 	}
 	primary_sd->primary = false;
+	primary_sd->next_secondary_idx = 0;
 out_ready_false:
 	mlx5_devcom_comp_set_ready(sd->devcom, false);
 out_unlock:
-- 
2.44.0


