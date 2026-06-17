Return-Path: <linux-rdma+bounces-22318-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Ag4eJPWpMmqj3QUAu9opvQ
	(envelope-from <linux-rdma+bounces-22318-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Jun 2026 16:06:45 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0622169A688
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Jun 2026 16:06:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=rXT3fJ9L;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22318-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22318-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0B39431AD607
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Jun 2026 14:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D0B6421A08;
	Wed, 17 Jun 2026 14:02:46 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012057.outbound.protection.outlook.com [40.107.209.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FDC63DD85A;
	Wed, 17 Jun 2026 14:02:44 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781704966; cv=fail; b=ZQQYIUE8Ycq4DWNw1TL5cIz1cmx2O+QlY+BBadzNK8opKtogjiGZgEMqEQ04K3F+xJz/8OMU69bTCN79roB9EQ4NwkIgeeqFn6KBnfbagVscD6I6nWztRhlzee9HuTmBYLQkfHm2gEMSp9IAgisTP5fkVEC2De4M8gr4kdRHzJs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781704966; c=relaxed/simple;
	bh=JfH7eC2xir5DBHqDXIG+9CPUaPIG27tBCjW+tcXmhWY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IXVsdbhptocCf1CeINmrA3x+wLdw7OZwSEcVqe1Te45XNsL+FZ+99saeEwn3cyTtjlHQQWyQnOqCG8P+1/W8gOOes43cKAdJ0QAQAiTJ0CvA3VzkwUW3x3X2CQuXIc+M6gZoSnWIBlvdDVKDSzRlB9ofxhEzhCRebYdd5hAkxaY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rXT3fJ9L; arc=fail smtp.client-ip=40.107.209.57
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ayp4QvOLjrip9jxiqrO7OtpVSw5gRqncGWSbds2CxpZD/4AJ3nuXtx6IRDofklIG2T5FP5roOZUhFB1a9CuoCgVjXIZ2MatNqGsWdz31EqBRzM8Sn55501107mrcSqqWs9iVE6vXA3i7QgPCaG7IfqkkhDUeYJIYoCOpgP7qHx8flG7irOAwrZ57uinTgcasf2eY5bcCCGWn5ZzD5QutEmFelUUf6yxtFLxGs0RA7DagxOrXssKjuMgMXzSdVArG/rg++yb/Z2t8c7Cp6xvWFleSsE3Brh3Yx2Zm69gozNmkqr92b6FirZC6XQSBkm4/AGviNu1cBG49aHzSKh0qWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PITvRE9bCzSQhcb5Q+awJpCDPK9jgj5CL5MlHF/hwRs=;
 b=j1FM2xf65HUcsS9Too2+yaL42SLga1flb9DXqjCXNVuMRwTO2toS+l+Gbp+rsAibdwu7XtpiblVBK4FGW1iaLKZA5ijQpyVCg/q9mouZlROScRas59G/8tRd/qthL7w3wesA5w33G30FnNJfHumrxWZkp+eQJpc2QQJSX/vhGvHh5N6QKiHwu3ekDSII4Y5ndVCZ5wGq+Ecm6cJcAU7nbq+2MKVUh5xTc/cRqAYCyobxKS4aFn9wmOchZ/RjfaR/BtLBm28V4DFog4zzZ6fNuFoJJa8TA9vVgdOT9qCB0mdCdIjltaxIrDPQCwibqHXt7pkt40pfkvW/eV1kc+e97Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=lunn.ch smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PITvRE9bCzSQhcb5Q+awJpCDPK9jgj5CL5MlHF/hwRs=;
 b=rXT3fJ9L8+cRWecaMUgp8K7V9eat+Ia/iei7dL/ClbynRhVlLR0u8zOHZo6hhAlv0eo1vjtDfPw1jeBrRQ4yeuQY5K6H75nZg3jb/7LELF7kfZj/scS4fZnQhnWnp+v1YBkjrTWU5PRFSdqg33aLqhV3jAseni4NRcjsTJQw9e21RAAtcE4NJbKoR0LcL++YEzkDh75aFfzL1Mhoe4vS1B0p5qBq6ZPLDfadxrwLsBZpYRkmknVDm3ND+eUIZ7whJycLEqseC/tPBwlGORGySDR5ahfL7KU2nvpgJtQktjK0/V9/zDm7O2ed8qw3nkksDsWwffJRYg4uEvRYmUTRLw==
Received: from CH2PR17CA0010.namprd17.prod.outlook.com (2603:10b6:610:53::20)
 by DM6PR12MB4156.namprd12.prod.outlook.com (2603:10b6:5:218::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Wed, 17 Jun
 2026 14:02:34 +0000
Received: from CH1PEPF0000AD80.namprd04.prod.outlook.com
 (2603:10b6:610:53:cafe::76) by CH2PR17CA0010.outlook.office365.com
 (2603:10b6:610:53::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.11 via Frontend Transport; Wed,
 17 Jun 2026 14:02:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH1PEPF0000AD80.mail.protection.outlook.com (10.167.244.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Wed, 17 Jun 2026 14:02:32 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 17 Jun
 2026 07:02:06 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 17 Jun
 2026 07:02:06 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Wed, 17
 Jun 2026 07:02:01 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, <netdev@vger.kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: Cosmin Ratiu <cratiu@nvidia.com>, Eran Ben Elisha <eranbe@nvidia.com>,
	Feng Liu <feliu@nvidia.com>, Haiyang Zhang <haiyangz@microsoft.com>, "Lama
 Kayal" <lkayal@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-rdma@vger.kernel.org>, Mark Bloch
	<mbloch@nvidia.com>, Nimrod Oren <noren@nvidia.com>, Saeed Mahameed
	<saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net V2 1/3] net/mlx5e: Fix HV VHCA stats zero-sized buffer allocation
Date: Wed, 17 Jun 2026 17:01:25 +0300
Message-ID: <20260617140127.573117-2-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260617140127.573117-1-tariqt@nvidia.com>
References: <20260617140127.573117-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD80:EE_|DM6PR12MB4156:EE_
X-MS-Office365-Filtering-Correlation-Id: b33f653c-619f-41d1-eae1-08decc7913f8
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|23010399003|36860700016|1800799024|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	FC7OCC7hM37a3DKX+FAGljVzHBlyI5mW80yicWNyzL1/wmxzcH8Ms/v/Pl9Vnefh7QWYUSqMs0980HAuUJ919LGIs5ng9rmHE2pddJL8DHVy2D1LQUFCTVhZFY1uAtILOKeAsdwY8eZuhvZ6on8dJHejYLgRNy8Bxrsatc5CFeIjW7MMpOGSlZelvG1OVTm6qctchw8MZBEVykS81V45caWt+NUZlmVXYBWwvy+b5QzTWtBPMDQSeHSDw9UE+bc2m1BL5mKxp6eytcl96Nd8i270Lkjs3zIVKyjVVcsAIdBI1BSOJ7ObSqWbZfStBpiKd6Ey3lT9sun/Y4S9uFnCFwTZdmfIqtHkFc2i/wYXr7hTuvbVlk00dk6Ff2BFSN/9ePxEeuHvJxzF/PiprtF15BAf0qh95wmIzgv8MlYNDYA4ECOwIVumC4deCl8L33Tx9H2D+1zQ40UJDRBRMloePIaZNmmsCN2epkOgGF8m6Kfg/DRXYx97wUP9Xkdw/5yTkqLSdIWw4r5G83lChJQrCJiM6LHFC6S9uL7QE65utLnzixgaHCA5bLdHHcvnnLR/v4yEk52B6vXr8ToXFgEbBixDQyUE3GZAf/mHc7wpjHBaStJlnjJJO8e9YB10/pYjeoQTLaTKxsdyzZ8Pj321/PH99zPaTlWgMPM+I6lhn5Ic4zFrV2rlffb8RrIFVHk7hAUfjX/7gOZ+7KLOf/jYJMGE1ZFiiFvVHgnHHjTA/v0=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(23010399003)(36860700016)(1800799024)(18002099003)(22082099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	1ZslJi8gh6YKpwOQvyeSibfIAXEfFz4n55FPLLGirK0W3jB9htiUe9VEQGoRq5WhTC8n8jtjzrV5R7j1PvostPRo7FzNGXnder6NudmvHldylkohmemwLnaz6mLTRKmtHrrHhYXoR+J6APafuAHgDf0ustpJ4cfcH73UXE0/f2ANV2O0fEskiNKscN9OjUMavXpRPIV/quEcr6mPW2DqnqrbigUA0nLpoXFfkkhzDlq97jK/V9zSODaP08zi1vAAq8clm1ulqHRNLeM3Mg5S6Ph8y9IzT1T3rNCD1fCwOxFccgcSW0cPhHa7VD1c9CgQWuwNg8wT3nbS02HRhq9wNLe/7el+asR2vdloUWeKAr4TVCtT5Yd2Ml0NGyQez4dbJD/5BxqvBmUB5HhE/iUhA+umHLIhsLpEH7d9rGjsTbD+xobLuBJuzT/3qu4Ext1x
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 14:02:32.9830
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b33f653c-619f-41d1-eae1-08decc7913f8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD80.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4156
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
	RCPT_COUNT_TWELVE(0.00)[18];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22318-lists,linux-rdma=lfdr.de];
	FORGED_SENDER(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:cratiu@nvidia.com,m:eranbe@nvidia.com,m:feliu@nvidia.com,m:haiyangz@microsoft.com,m:lkayal@nvidia.com,m:leon@kernel.org,m:linux-kernel@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:mbloch@nvidia.com,m:noren@nvidia.com,m:saeedm@nvidia.com,m:tariqt@nvidia.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,nvidia.com:mid,nvidia.com:from_mime,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,Nvidia.com:dkim];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0622169A688

From: Feng Liu <feliu@nvidia.com>

mlx5e_hv_vhca_stats_create() is called from mlx5e_nic_enable(),
before mlx5e_open(). At that point priv->stats_nch is still zero,
because it is only ever incremented in mlx5e_channel_stats_alloc(),
which is reached only from mlx5e_open_channel().

mlx5e_hv_vhca_stats_buf_size() therefore returns 0, and
kvzalloc(0, GFP_KERNEL) returns ZERO_SIZE_PTR ((void *)16) rather
than NULL. The "if (!buf)" guard does not catch this, and
mlx5e_hv_vhca_stats_create() completes "successfully" with
priv->stats_agent.buf set to ZERO_SIZE_PTR.

Once channels are opened (priv->stats_nch > 0) and the hypervisor
enables stats reporting, mlx5e_hv_vhca_stats_work() recomputes
buf_len using the new non-zero stats_nch and calls
memset(buf, 0, buf_len) on ZERO_SIZE_PTR, faulting at address 0x10.

Allocate the buffer based on priv->max_nch, which is set in
mlx5e_priv_init() and is the upper bound on stats_nch:

  - Add a separate helper mlx5e_hv_vhca_stats_buf_max_size() that
    returns sizeof(per_ring_stats) * max(max_nch, stats_nch), and
    use it for the kvzalloc() in mlx5e_hv_vhca_stats_create().
  - Keep mlx5e_hv_vhca_stats_buf_size() (which returns based on
    stats_nch) for the worker's active payload size, so the wire
    format (block->rings = stats_nch) and the amount of data filled
    by mlx5e_hv_vhca_fill_stats() are unchanged.

The max(max_nch, stats_nch) guard handles the rare case where
mlx5e_attach_netdev() recomputes max_nch downward across a
detach/resume cycle while priv->stats_nch persists (mlx5e_detach_netdev
does not call mlx5e_priv_cleanup, so stats_nch is only reset when
the netdev is destroyed). Without the guard, the worker could compute
buf_len from stats_nch and overrun the smaller buffer allocated based
on the reduced max_nch.

This mirrors the existing mlx5e pattern of preallocating arrays of
size max_nch (e.g. priv->channel_stats) and lazily populating
entries up to stats_nch on demand.

Fixes: fa691d0c9c08 ("net/mlx5e: Allocate per-channel stats dynamically at first usage")
Signed-off-by: Feng Liu <feliu@nvidia.com>
Reviewed-by: Eran Ben Elisha <eranbe@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/en/hv_vhca_stats.c    | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/hv_vhca_stats.c b/drivers/net/ethernet/mellanox/mlx5/core/en/hv_vhca_stats.c
index 195863b2c013..06cbd49d4e98 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/hv_vhca_stats.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/hv_vhca_stats.c
@@ -54,6 +54,12 @@ static int mlx5e_hv_vhca_stats_buf_size(struct mlx5e_priv *priv)
 		priv->stats_nch);
 }
 
+static int mlx5e_hv_vhca_stats_buf_max_size(struct mlx5e_priv *priv)
+{
+	return (sizeof(struct mlx5e_hv_vhca_per_ring_stats) *
+		max(priv->max_nch, priv->stats_nch));
+}
+
 static void mlx5e_hv_vhca_stats_work(struct work_struct *work)
 {
 	struct mlx5e_hv_vhca_stats_agent *sagent;
@@ -122,7 +128,7 @@ static void mlx5e_hv_vhca_stats_cleanup(struct mlx5_hv_vhca_agent *agent)
 
 void mlx5e_hv_vhca_stats_create(struct mlx5e_priv *priv)
 {
-	int buf_len = mlx5e_hv_vhca_stats_buf_size(priv);
+	int buf_len = mlx5e_hv_vhca_stats_buf_max_size(priv);
 	struct mlx5_hv_vhca_agent *agent;
 
 	priv->stats_agent.buf = kvzalloc(buf_len, GFP_KERNEL);
-- 
2.44.0


