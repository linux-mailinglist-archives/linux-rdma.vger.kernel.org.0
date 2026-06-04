Return-Path: <linux-rdma+bounces-21779-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9ptsItyHIWruIAEAu9opvQ
	(envelope-from <linux-rdma+bounces-21779-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 04 Jun 2026 16:12:44 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 82909640B88
	for <lists+linux-rdma@lfdr.de>; Thu, 04 Jun 2026 16:12:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=DPC69VB5;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21779-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21779-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F232630526E5
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Jun 2026 13:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B68744219EA;
	Thu,  4 Jun 2026 13:52:04 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012039.outbound.protection.outlook.com [40.107.209.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43FAD47ECD4;
	Thu,  4 Jun 2026 13:52:03 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780581124; cv=fail; b=Mu5UIJuvaM/5oKEXghThBPhuaBVH3kSk43BO1Q0pp2fP2Ut1JHM9Xply62ZY2u1HewAF8BFtGNFytez71MnOc2XPJ8dY2+H977lsu3WsNfG/P03CPGj0TuVmC0Xn6S5pRjSDyiz8WAgSOl6gbWiDTQD5tpTf/wMQ+iT41sqPNXw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780581124; c=relaxed/simple;
	bh=JfH7eC2xir5DBHqDXIG+9CPUaPIG27tBCjW+tcXmhWY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ONEZINX4Lw9C2v6clKvsV/hcRwHw8mZ9sixvwzmOfG4cDM+bQXaPkFWz+lQZUFYaPuLC6DMxfFzPKF3I0uRBfOiFgJesKYCiECjU+ScQpxX/gNMMWDUoPOnXYxnVUvZCkikTCd8u53cak/+xDe93Qqi3xPcx3Hxx1PwMUXG72ek=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DPC69VB5; arc=fail smtp.client-ip=40.107.209.39
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rKpViOUgCh0Dx9/29QjJFcg/tsprqguFrsdRfkVew3tnicSZ2PcMaCq5yvmJ7WOySX4tbxhR+cNNpXH+QphHloQbKL4qmJoNdcYioAw5rS14nvODQTLx4p1JxtClgDvf5DXHQZvw6iHEFeus4IfzoevtqHQr1l7USfC7U+q6txdQHvq0omgycujdE4GOkdDt/O7Dx2zBwY3nANYdcW+VGtvKwBRf7airgaU8d/+/nLCkPiU6YhfdEp6tT4+AJeSvOLwqpd69f6GF+rdbmMgDPYYYn/ojzPW2hlpfqtJ+NuCUZMIQcnQmGfX5CuTKbHaVXCr2FOb/M5zSv80KkzmTvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PITvRE9bCzSQhcb5Q+awJpCDPK9jgj5CL5MlHF/hwRs=;
 b=Itnjr1iIm+aG13nwlZnLKs3+5qu3AjKwcsVXWTRjqp8gkJ4C/5QmY+TBxeBXWQr4keXY2k+RE9P843awG8sOb6U8PdL+9WKiJgDP9EzkIR+TG7G1wm6tc/T/ZIfibkLf1uY+03EuWK4Ii9qd2BsgFFCVHmMKJtBsh62ZItCWxFtwP0UyHWj8gCLCH4I4ZXdzfpLbOnytzfbOux7XGCSROOo1GxSsgoGP7m+GXchOsk+j79tgtW6p/LZ4PMuogtTFtSxC1joPTofrQ2Uyp9AJybjcgKgbQfrTwm6hHlpXELF4WFiNpDhmyVPUraoSctAVnOV6egKmuq8G60dGY0guQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PITvRE9bCzSQhcb5Q+awJpCDPK9jgj5CL5MlHF/hwRs=;
 b=DPC69VB5DjoyhaRBnkMEeGT4IYtpiBL5n6+TMOM8qXmbHGUbXw4DLHEhkUyAAKJk4V/pAQ/Xii38V+1yfrpYwY2vtXKLlrc1We+nGnp4uvA5hg8zbM60dIL9i6jjE0VBlGyBb6KGEKu3Svp4LYtv2UktPlpioqmJXEBbJUh4x9kQl/+93gJkwoyt0ycDhXLqht2qc9qknpHUG17fMbbc+9MyyLjvpXBFLGvEu82ixG0ybKeYX+IrYdMIJCRZrTuJUV1DLPOv3tDQDr6tt+P+wPrJR/E7pwhkqHJMkJNBaok6TfQlXxGdKLmvFRLsGuqi697gpultwDXUrY4J0JYBsA==
Received: from PH8PR07CA0045.namprd07.prod.outlook.com (2603:10b6:510:2cf::14)
 by PH7PR12MB6953.namprd12.prod.outlook.com (2603:10b6:510:1ac::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Thu, 4 Jun 2026
 13:51:53 +0000
Received: from SN1PEPF00036F3D.namprd05.prod.outlook.com
 (2603:10b6:510:2cf:cafe::a2) by PH8PR07CA0045.outlook.office365.com
 (2603:10b6:510:2cf::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.8 via Frontend Transport; Thu, 4
 Jun 2026 13:51:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF00036F3D.mail.protection.outlook.com (10.167.248.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Thu, 4 Jun 2026 13:51:53 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 4 Jun
 2026 06:51:35 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 4 Jun
 2026 06:51:34 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Thu, 4 Jun
 2026 06:51:28 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, "Eran Ben
 Elisha" <eranbe@nvidia.com>, Feng Liu <feliu@nvidia.com>, Cosmin Ratiu
	<cratiu@nvidia.com>, Gal Pressman <gal@nvidia.com>, Simon Horman
	<horms@kernel.org>, Alexei Lazar <alazar@nvidia.com>, Nimrod Oren
	<noren@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>, Kees Cook
	<kees@kernel.org>, Lama Kayal <lkayal@nvidia.com>, Eran Ben Elisha
	<eranbe@mellanox.com>, Saeed Mahameed <saeedm@mellanox.com>, Haiyang Zhang
	<haiyangz@microsoft.com>, Joe Damato <joe@dama.to>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH net 1/4] net/mlx5e: Fix HV VHCA stats zero-sized buffer allocation
Date: Thu, 4 Jun 2026 16:50:38 +0300
Message-ID: <20260604135041.455754-2-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260604135041.455754-1-tariqt@nvidia.com>
References: <20260604135041.455754-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3D:EE_|PH7PR12MB6953:EE_
X-MS-Office365-Filtering-Correlation-Id: ed5924d6-d902-4607-f9f5-08dec2406f4f
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|82310400026|376014|36860700016|56012099006|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	wGmNmjjwv34j8ZavyhAxvJXjwiAeZoJ/Phh6Svnf+YYBws5Kn2Z5DBlkQQ6OJwLOCc4qZCR9dQoVuF0N6DqcK8lU6G5thc6JaYe6kxtX/6b7bLDRlAgZPn7/oH0HiMa4eaL6DPmz765zVGrI+eLcC/jhIPukNnjYI54KwM03Nq2ojvq0Kf5Z9y0jUeBV2r7tNSy/1yHilAE117DgXw0t2Pzz4jGxe0602zGkOdpL0q0ifGZB2QMR1aU3umJdGxCd00XDNzaektgTAKZnAAh+m4YAAqskhiM97dQtSFwxVN6x6CYg88hdqCb0z12Cd6nRV98bXXuBy7QfeytD+RwAdSrAWJAr1KDSYTSybCKb7IYo7hrxW1r/X8U8RI16+vuQa2llbn0Ztm2gfJgmKIDPI6jK93v0y6TmiXKwgkmZKg9RLd5/HZOZnUbSC0FwjIpcHQXmFL9VRAG/n5ZGalJPgct346+68ciLKWm5cNMb3TSLiWh7rgJg5jGeoX/wmsg/xBVlHnDZY2+SAeaN/56pv6/pYYLS60rv31n4/X89SEbju/1MDjDd/wRFdrL2FW/yyawJJRmClMTacZb86yq2voLv0VQshCQfUdGkly2TSYZdhMk/xInxV91qDDh8vokV2UvTdOz1nbSFb1QfE49ENk7qTd3DbhB4U2arCv5GvKYXbjCo/hWe7SXHBlFfbXaXeSNzIpwCSfKX50foGOP8auhs85o0S2RB0j95o3jul5k=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(82310400026)(376014)(36860700016)(56012099006)(22082099003)(18002099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	sv52emaWWIzzrB7lnry97scBVI6+92smeLu1909IuUq5ONlthodaA4cvo/zh3zIzG/0s7jF3KbshGLDdvW35zs66PRgWSjWoPfYHQf1cgaeaw1lvamaPiz0phWE43RiHH+dPxcQ0ijABh/oK96zxzDa6ascnzdnCeaD+KY16RJD6Oilh76d9oR++PVY3Oj/W/re0S6vNtmkMggJDE6MK3VbAvV5VRGZGRJ3dnQK+7x8gTK9N1FrEjXJZQWyFao7i3MybxfvL3AUwJrfHUGiHlxjsKHnusRwmGKZd2QiTrD15HUZIOqz1UraqC4/MkhIj4xXvUa8xc391Q0rBhGZSdqqVrcqBxYgaBdxUvAMFpWSS88FY7G8vZH1fNkxFl9vCBH5Ye0cC9rCc4nRCPm8lrOxS0KlmOxKUry6Ez0H2/0gs+dI/NEeIVR8+OB5Kc5lO
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 13:51:53.3288
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed5924d6-d902-4607-f9f5-08dec2406f4f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F3D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6953
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[26];
	TAGGED_FROM(0.00)[bounces-21779-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:saeedm@nvidia.com,m:leon@kernel.org,m:tariqt@nvidia.com,m:mbloch@nvidia.com,m:eranbe@nvidia.com,m:feliu@nvidia.com,m:cratiu@nvidia.com,m:gal@nvidia.com,m:horms@kernel.org,m:alazar@nvidia.com,m:noren@nvidia.com,m:cjubran@nvidia.com,m:kees@kernel.org,m:lkayal@nvidia.com,m:eranbe@mellanox.com,m:saeedm@mellanox.com,m:haiyangz@microsoft.com,m:joe@dama.to,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp,Nvidia.com:dkim,nvidia.com:mid,nvidia.com:from_mime,nvidia.com:email];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 82909640B88

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


