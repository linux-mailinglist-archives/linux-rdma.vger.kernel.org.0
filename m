Return-Path: <linux-rdma+bounces-20685-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wGfmCgquBWrkZgIAu9opvQ
	(envelope-from <linux-rdma+bounces-20685-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 13:12:10 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 862B1540D68
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 13:12:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4FC9C3059F86
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 11:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 337FC3BFE5D;
	Thu, 14 May 2026 11:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="T9phRE7/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013051.outbound.protection.outlook.com [40.107.201.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C1D3BFAD4;
	Thu, 14 May 2026 11:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778757083; cv=fail; b=KqjtUG+3OrfDDdLXi0pUFEdupxJxVm5s+HGj4uYA7zwAclmZwrp6zj6vfQbAxBzJxEgJtqNGq4JhA1daepH77hL3tR2H1n/iyMHTpN/QaqOec+Q/5qRVQ7gnARBIH6oMCDvaGl4ao3Z3xvg0plcyF4OpjZnSrByyk+0zezr7Ofo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778757083; c=relaxed/simple;
	bh=Pyv2hSIfSXSGrJf3bMkCD6gUBJNhaje98zLlx4O9Q0Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=orBcHvgTRUGA8j2Eroq/smLb5aloEkXCt0ma0djC/QHDOHRz5RFpnRnvniADK0F0Djx95lhJ1FG/hWIuCfBfldg+vPC22cB8l/4xxpEFARAz1u8UM14QmtraqGih6hLjtmNjQs/5nslZpaeW4XKpd1S+UaYFMSjWg8jzXGUN/jc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=T9phRE7/; arc=fail smtp.client-ip=40.107.201.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hJR2RNYimI1DZknYkQvrzNpHgC1ScYVpTwR1eBic5+m9BnDgEvj1mbWgxD2u/eIlwKqzeIVD8KU6tY4HW9NQ3CKu2qxF4la1UW9M2LwW5zrvMwjwv95pOFw0HUVzYAURbYxNgsRPqSVyojtlvWDxoQYVs5rbO+zO0JX+W1uYSx1Sm2FGkwF5ZufYaRVMuEiCGyEzUb+T7s99B4hEKwi+TsbO6I4DJT1UGQhflzVHj3NQSuA/J7GJ2nBfca2enbc1lWv4FCpQLA7LR35uqJiE+qUIlaIkYfBL6ScUsIbclODwevKh6fAqVkJvdrFNvoVX1suDEqkgfNki75AslDKAig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2NSR7H/XK1wrrt6Zuc08i0cIXz/+Z3zLPZwT6pOIm2g=;
 b=KGQrHLJF4LCqRUQJ9DRs7Ur3pl4uC6CP+lJAb2z4nTsg+scArqqlXZat0l8eZpWniO8hX2RP9tLqh+FEGNSpWDftZoybWmiGiWw9KaE8T127xmP33MdnvmCthBcCeIYTUc7P0npWM/adkUShYBwGWJTbyKCnBabwa5UVwY9snXP2rtx3IFreQsgG6FAqTpFTJUNO39Gc0KzjqkdHqPZE8I+zbatJ14LUjX7ERynG5W+ej38s266G8vNO0OC8fpSfFnuk9RImaM9NJKWt73Z5lhTizfZH3yQlIDhApb9+1LArqohIzBwg+kRuQ6zl0OHxL+NIxPh5Ol86gyQ1QklrYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2NSR7H/XK1wrrt6Zuc08i0cIXz/+Z3zLPZwT6pOIm2g=;
 b=T9phRE7/eNSRrbZcW7g7FNlVqDzVV+JK4bP4iaH4IPuhcrirF6HblRkCelPcgaz+eXa5xLZuJwEfpassWvPEV2WtsYcueC7s5lBHViMoTsR4MkaOtaed2Pz0Lkj84k54PIWc4bNEtZ2FjdcelJQKDtQEGRxR7TQ7LVTOkYT6NpZZ2E2WPf2uiso2gOB7uCJLBdt9KC+7dNbaoWTIW66MIUxXup7IN8s7GesxssAvSxK3kPCE+2Eny6ntxg7eHkhJcs6qEqX8ASgWxCGOM5b+PNnufBvNvWD7qugnnD36ykRszTf57oe+3WG/41YYtFg5vL3caVm2+iDHZg4RLQ/vKA==
Received: from PH2PEPF00003847.namprd17.prod.outlook.com (2603:10b6:518:1::64)
 by DS0PR12MB7827.namprd12.prod.outlook.com (2603:10b6:8:146::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.18; Thu, 14 May
 2026 11:11:15 +0000
Received: from SJ1PEPF000023D6.namprd21.prod.outlook.com
 (2a01:111:f403:c902::13) by PH2PEPF00003847.outlook.office365.com
 (2603:1036:903:48::3) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.23 via Frontend Transport; Thu,
 14 May 2026 11:11:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ1PEPF000023D6.mail.protection.outlook.com (10.167.244.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.3 via Frontend Transport; Thu, 14 May 2026 11:11:14 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 14 May
 2026 04:11:04 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 14 May 2026 04:11:03 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 14 May 2026 04:10:57 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Boris Pismenny <borisp@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, "Mark
 Bloch" <mbloch@nvidia.com>, Alexei Starovoitov <ast@kernel.org>, "Daniel
 Borkmann" <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev
	<sdf@fomichev.me>, Shahar Shitrit <shshitrit@nvidia.com>, William Tu
	<witu@nvidia.com>, Kuniyuki Iwashima <kuniyu@google.com>, Dragos Tatulea
	<dtatulea@nvidia.com>, Sabrina Dubroca <sd@queasysnail.net>, Kees Cook
	<kees@kernel.org>, <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>, Gal Pressman
	<gal@nvidia.com>
Subject: [PATCH net-next 1/2] net/mlx5e: Reduce branches in napi poll
Date: Thu, 14 May 2026 14:10:37 +0300
Message-ID: <20260514111038.338251-2-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260514111038.338251-1-tariqt@nvidia.com>
References: <20260514111038.338251-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D6:EE_|DS0PR12MB7827:EE_
X-MS-Office365-Filtering-Correlation-Id: fe1f7f8f-34d5-4051-994c-08deb1a98345
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|376014|7416014|18002099003|22082099003|56012099003|11063799003;
X-Microsoft-Antispam-Message-Info:
	wO6sPvbbk3H589AAhChTB2+GAhWw101awWIqJaM5mYrBeIyX1PAKIiHzxV1FUNs9rlnNe6gtqcK0JpyCSDzu5QTOeqz/1SY5SIqWq4IHF03BLtLVs7H+YeYnYuxNn1YLXizkUHXosSrIXWBzhDuQ+zbYbGunvjj1WkAYk/iIxaWYLRSiqHITjNaiSQYjoVWiOR1eyOH5hgvNM5VyLtatwtoSxshk7VanMTfchhCJSo+BLsJ0EGqfwmdcMuhBq/YBRjN8aNeg8kbooK5nKY2Ju3qJolN29cmgapGvy7uQnfuKpfU+wh1GmLD0Uyk3/4vubrXb0Ny+KyssDXfGwZZi/UXTvBpyNf4fkDzTP81NuOOTBoxo87dzrs0QjCoDs3/W/gWU5kcuKeE7YhPTw6wDje3JB1cVZdTatDPCXp3F3HwrLq4a5V/zgVefi2WPIwoLdMLRlpiXGCA3ypUId0WgzzWg1r7V4GB/i5MzQQ1M51PFQbRO0i9/Ih7cDhMtKnvJbEYiuqGu4PtvcXbaDyyiVukjjlG16fwkAOM4/CuqfwVvndWlGl9bbMWtlOPN2dJdQmBlXWNRUBUWEhaYSvaveVI08RsKN+bUSMyoGx7VD/7gwWC/JAESH0/MHS0sSHJgiMCxWY/O0SPzXJ4t1q+bB1jFW0o6FK2rrt4bOHGAooWHe/NOdOauPR22jq7cwaq4+8ExyG4+McOAlJ/0tDeEbqn6e+tfGYJ458+cFWtRsaQ=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(7416014)(18002099003)(22082099003)(56012099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	1iKc/WrgS24OcGznZFVlWx1Zd+qxELtpLvWxpZDeLFIFFhsJGGwwFso+FwUr8QKKCTzZopgW40F5hHNEr9+R6ciFU9maFfOE14x+KZhvYjERA5reC2XY+qnIg1oeKPLH5SjoMQgmAsIJ/5DUnDMYDK47g6xeoQRukrlyGlAr4zvRj2fy/ZEHS0r0rRUPHpfauP9a5lVg57U3ImCpHxTfpb6DUEaCJYhCS0U/1ibu0H96TcFnXQND6MfLZ05wVcaD0l7Atk7lCw32yeCbxRFYkxZE8thoA8g+7GRZNYpwFFrLNSt8NypcXhcK38Y+6+1WuyTl6rcRb3D02SDjebRkLTAnnPQqC38KtEniPSxK1yBDmbLqJ79PKw4p6LZbOrZLikItUKACyjgSqKmoDFxChmtWUctmAB3oTRiDwh3nEiA/rNpMPDep+aw1+nZ71Xca
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2026 11:11:14.2812
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe1f7f8f-34d5-4051-994c-08deb1a98345
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D6.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7827
X-Rspamd-Queue-Id: 862B1540D68
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[nvidia.com,kernel.org,iogearbox.net,gmail.com,fomichev.me,google.com,queasysnail.net,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[26];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20685-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:email,nvidia.com:mid];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

Reduce the number of branches in napi poll, based on the following list
of dependencies:

1. xsk_open=t only if c->xdp and c->async_icosq.
2. c->xdpsq only if c->xdp.
3. c->xdp implies c->async_icosq.
4. ktls_rx_was_enabled implies c->async_icosq.

Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/en_txrx.c | 30 +++++++++----------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c
index b31f689fe271..8df5bc5d0537 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c
@@ -166,14 +166,13 @@ int mlx5e_napi_poll(struct napi_struct *napi, int budget)
 	if (unlikely(!budget))
 		goto out;
 
-	if (c->xdpsq)
-		busy |= mlx5e_poll_xdpsq_cq(&c->xdpsq->cq);
-
-	if (c->xdp)
+	if (c->xdp) {
+		if (c->xdpsq)
+			busy |= mlx5e_poll_xdpsq_cq(&c->xdpsq->cq);
 		busy |= mlx5e_poll_xdpsq_cq(&c->rq_xdpsq.cq);
-
-	if (xsk_open)
-		work_done = mlx5e_poll_rx_cq(&xskrq->cq, budget);
+		if (xsk_open)
+			work_done += mlx5e_poll_rx_cq(&xskrq->cq, budget);
+	}
 
 	if (likely(budget - work_done))
 		work_done += mlx5e_poll_rx_cq(&rq->cq, budget - work_done);
@@ -192,18 +191,19 @@ int mlx5e_napi_poll(struct napi_struct *napi, int budget)
 		/* Keep after async ICOSQ CQ poll */
 		if (unlikely(mlx5e_ktls_rx_pending_resync_list(c, budget)))
 			busy |= mlx5e_ktls_rx_handle_resync_list(c, budget);
+
+		if (xsk_open) {
+			busy |= mlx5e_poll_xdpsq_cq(&xsksq->cq);
+			busy_xsk |= mlx5e_napi_xsk_post(xsksq, xskrq);
+
+			busy |= busy_xsk;
+		}
 	}
 
 	busy |= INDIRECT_CALL_2(rq->post_wqes,
 				mlx5e_post_rx_mpwqes,
 				mlx5e_post_rx_wqes,
 				rq);
-	if (xsk_open) {
-		busy |= mlx5e_poll_xdpsq_cq(&xsksq->cq);
-		busy_xsk |= mlx5e_napi_xsk_post(xsksq, xskrq);
-	}
-
-	busy |= busy_xsk;
 
 	if (busy) {
 		if (likely(mlx5e_channel_no_affinity_change(c))) {
@@ -247,9 +247,9 @@ int mlx5e_napi_poll(struct napi_struct *napi, int budget)
 			mlx5e_cq_arm(&xsksq->cq);
 			mlx5e_cq_arm(&xskrq->cq);
 		}
+		if (c->xdpsq)
+			mlx5e_cq_arm(&c->xdpsq->cq);
 	}
-	if (c->xdpsq)
-		mlx5e_cq_arm(&c->xdpsq->cq);
 
 	if (unlikely(aff_change && busy_xsk)) {
 		mlx5e_trigger_irq(&c->icosq);
-- 
2.44.0


