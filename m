Return-Path: <linux-rdma+bounces-17530-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EBvACq+UqWmKAQEAu9opvQ
	(envelope-from <linux-rdma+bounces-17530-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 05 Mar 2026 15:35:27 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1350B21390A
	for <lists+linux-rdma@lfdr.de>; Thu, 05 Mar 2026 15:35:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A1D243085ED9
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Mar 2026 14:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CAB43A7853;
	Thu,  5 Mar 2026 14:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WW01azkw"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013068.outbound.protection.outlook.com [40.93.201.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED9D3A7837;
	Thu,  5 Mar 2026 14:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772720868; cv=fail; b=goaxFrkQHg6moc0yon5y9NaVkbm1+Rpug4QxONKRn/0GI1CeWzSVoCiVWo0oqWLMc6ZzKjYgyGVuaXNIzYgcCfQYS/g4sJnn0UBPncWVrCJPepzFrDtzMaUAPk8NSnXDMvrql/2ZwjmYScaebEo9DDsFKoeCIosDIQ5rUaaEuBY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772720868; c=relaxed/simple;
	bh=bqtfwG6CZxp1T3f/HKPL7NN1fo3UuGgz/CYhq5nvXu0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IvG+wLLz1l1AgVA2YaarnmrhbDTMERCARgAgrt3K8y+s1HAITVeEQFMPdqQT2Ss+tU9CUpphldjm7JcyUkg3PyXedROsVgmCMkYPc5H+2uZT5ysmW+TyMZMUa2GzTJbUxrOQTQulwpBxPx7T2rbBF8oMSOmpIJCatr9Wym+4acQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WW01azkw; arc=fail smtp.client-ip=40.93.201.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UJ7Y1mtkDNz9h8szeu8/193uRGMuSiRR4bc47c7OWnTaMP8Duk7DHqE5LMy1wcukI11++o5hPl45aD2i7QD8vwhifu2/+4Lppr5jylJZ65FI2es563O/AGCzEoTGY3p5bgNrrvdQRbmNDSMeY5UNc6uJxCxjERar2fshMbAbGrRUolIre/0MMgqq/sF/wa3kmyG0pQMtot+p0NZLUEIu6H1LsoGXfKUVY98X9+7IrBoDHPPzslgr40IpKgxaJnMCeFxHc0HsqJfAx50UiR/d6ef96v/pAFXGFYhXVVgH7h1tlgN2sAvjjqf0ajy7danDO+rb1ogkrvEmPOSjGzZfjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1bW9ofcL27JPFTUdjoUkc3CqmTzV5m7fJUM8IOW4b40=;
 b=vQwTvuSi6eEm4/HidLsNyjx0OkY2Ha2zt+paRj4ISsjRUSF7/PA9y//2kvcB7QHfHE9YIXJMOX/jGqL52mCKTh480wMGTa5s9iOHSQoqIKs5Y29dG/xUdD/zoXvwCohqcguRvqOQz9Fa9uElJGLCxrw4EOikwdVsgB65aji5xoVecfUFsB4xTITWK3dTO/YJgxEdumxdd5qYRwH+Woj+fF8Aa3DxS5njgEAnoA7GW1G4n0mPr0cKl+8METg2gPHo8Xr1cNTGl/cnIVCkD1vkAhWKlkjw+sp7gjUuCxE6vlPsnX8L0T/PUvKQDBcLV83iu+yvTrbGaeso4hkVG5X7dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1bW9ofcL27JPFTUdjoUkc3CqmTzV5m7fJUM8IOW4b40=;
 b=WW01azkwCmBaetrwaO+Iayq1J2bj5uwF7KEjebdbbVwllWovZF9ZxOVn1d6ZRELc/Nb0iQOq/Bvkn4V9+7KNQw8GqzXj4K8wKIuindWIV09MygyVsd29Q/q/P52AkApcVVh4XLevYNC6e2+Zl6zNx9eXXE0qfn9ROgiJf1A25UmDhRSRcM3kXzjqtO4zF1kvkMklp74hlw7CTFD1uMd45u93aoxng2u5LtdlGeNqNfMxw7lQqMeGT0U7kobB3LfgcesPkHbwb8+5DWFLC4iP6m2lk92zJzSVN6D+g+mqqXph1Kij7cQ/ZzIkvGrwzAUjmuvx3inh1Wo7zYKSvboUmg==
Received: from BN9PR03CA0853.namprd03.prod.outlook.com (2603:10b6:408:13d::18)
 by MN2PR12MB4206.namprd12.prod.outlook.com (2603:10b6:208:1d5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Thu, 5 Mar
 2026 14:27:37 +0000
Received: from BN1PEPF00004688.namprd05.prod.outlook.com
 (2603:10b6:408:13d:cafe::cd) by BN9PR03CA0853.outlook.office365.com
 (2603:10b6:408:13d::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.21 via Frontend Transport; Thu,
 5 Mar 2026 14:27:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN1PEPF00004688.mail.protection.outlook.com (10.167.243.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Thu, 5 Mar 2026 14:27:36 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 5 Mar
 2026 06:27:22 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 5 Mar 2026 06:27:21 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 5 Mar 2026 06:27:16 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, "Alexei
 Starovoitov" <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
	"Jesper Dangaard Brouer" <hawk@kernel.org>, John Fastabend
	<john.fastabend@gmail.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<bpf@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, Amery Hung
	<ameryhung@gmail.com>
Subject: [PATCH net 5/5] net/mlx5e: RX, Fix XDP multi-buf frag counting for legacy RQ
Date: Thu, 5 Mar 2026 16:26:34 +0200
Message-ID: <20260305142634.1813208-6-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260305142634.1813208-1-tariqt@nvidia.com>
References: <20260305142634.1813208-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004688:EE_|MN2PR12MB4206:EE_
X-MS-Office365-Filtering-Correlation-Id: 55b0761b-d05c-497a-8ea6-08de7ac35959
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|36860700016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	Cyvdhhn3k7/BK4DuP/dMbqR+GSLlgSXwvJk3kiQJ83XbdYlTTZTJ/FSv2nLshOs8spnDGZSfd1kG/e+R4BWOFE/JQ/e6wy+xzRbwMW1CPaiaT4qFwbAifCMGcrgB917UsqEVeZs72PMrStcHNcNXKGv0JxqEdofW1TIgpPYm2jXcrqju1/WmSYUAT9HJIlQlonrkE4PUdeCGAjublR88LqCMhRr88lWGuZu5ld6HSXhofNM4Rf2caEOPNZXMCRppeDkmk9z28m3htkMO0lcVZKsVZzZFxNJwnnojSVauutXrOchSP8wjT2Kjc4PeiHeDJ1f02dWTOG0VBU6Ry7sbJcXvHsSdGiI0xQUwNOUfFNeJUHaIiMxwiZkjpHvqxVCkkXB3tGRuSdK7p0QewLY9ocJKk3PADIB1AEWKCmZPCJSDDstbk/IYQqfCZcYOGCLOeGXmwPsS2SUq5IUveZxmpAksalIm7/DoriFo4dqIillrUFHNCXviF91NtcoSnYvnc9AhVY313HStJEkfZHvFqadPwC3fGClorEiPpN655pydgpmJM6e4Veo06uumc0oUiME2bXdxL4HhgDpp1SF/DnBGORs9S4T/tIpCvnbESYNbowpWND4amURZMD6icrAMHuXWEx9sDXpTf+79LCtdY74olQj89WViSws1Tyc/yODysBS0FojcmSC4hENVQg6AW7YVJFFNUz3psFmhE72FioxtpspapZ3u5QrAL1NJk28F9FTJF5n5w5RkQEOZzodE721+Mlo1WIA+q0i8mrEfUw==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(36860700016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ojnIonvhGsoY2li5v46nKc9ekCXtLDyXkDXN3XmgYTT3qIILLjP3RciraLaUN2xtJ0vWAU0m7EpgIdkjoSJCb2VTBFYAbmS4oH8Ostp9cgzdarAL7VIovpQ6rq17URrCeq3CFim1K/zNoRADTn+6dGApYBwur3ddK8AOwXAd+F93A6G/NRsbbnw8gcTAvM2cyPgRKWn5DbIX77aA0rXV2+A7GKa+e2RDaST+CfS4c1/ygQTuduG66piKxtIoe2957AouTwBwh0F9RXI9XxGRkCmsGdShXF6Av7ecS5SYFnqDpzEkntWo8OeIg18a2k9q6qRSEAJFS/HGcWVZUwDN7/LYvAHlinwdUuMXN0oWGDU0Jw7nW0mP4iZVxUa3BXcKYvhpjaR9bdo3YNGqQMy0qD/lL4qPaSsCtfyHHRvles6kM+B+03LBX8ljQYJeZx1X
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2026 14:27:36.7549
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 55b0761b-d05c-497a-8ea6-08de7ac35959
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004688.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4206
X-Rspamd-Queue-Id: 1350B21390A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17530-lists,linux-rdma=lfdr.de];
	FREEMAIL_CC(0.00)[nvidia.com,kernel.org,iogearbox.net,gmail.com,vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

From: Dragos Tatulea <dtatulea@nvidia.com>

XDP multi-buf programs can modify the layout of the XDP buffer when the
program calls bpf_xdp_pull_data() or bpf_xdp_adjust_tail(). The
referenced commit in the fixes tag corrected the assumption in the mlx5
driver that the XDP buffer layout doesn't change during a program
execution. However, this fix introduced another issue: the dropped
fragments still need to be counted on the driver side to avoid page
fragment reference counting issues.

Such issue can be observed with the
test_xdp_native_adjst_tail_shrnk_data selftest when using a payload of
3600 and shrinking by 256 bytes (an upcoming selftest patch): the last
fragment gets released by the XDP code but doesn't get tracked by the
driver. This results in a negative pp_ref_count during page release and
the following splat:

  WARNING: include/net/page_pool/helpers.h:297 at mlx5e_page_release_fragmented.isra.0+0x4a/0x50 [mlx5_core], CPU#12: ip/3137
  Modules linked in: [...]
  CPU: 12 UID: 0 PID: 3137 Comm: ip Not tainted 6.19.0-rc3+ #12 NONE
  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
  RIP: 0010:mlx5e_page_release_fragmented.isra.0+0x4a/0x50 [mlx5_core]
  [...]
  Call Trace:
   <TASK>
   mlx5e_dealloc_rx_wqe+0xcb/0x1a0 [mlx5_core]
   mlx5e_free_rx_descs+0x7f/0x110 [mlx5_core]
   mlx5e_close_rq+0x50/0x60 [mlx5_core]
   mlx5e_close_queues+0x36/0x2c0 [mlx5_core]
   mlx5e_close_channel+0x1c/0x50 [mlx5_core]
   mlx5e_close_channels+0x45/0x80 [mlx5_core]
   mlx5e_safe_switch_params+0x1a5/0x230 [mlx5_core]
   mlx5e_change_mtu+0xf3/0x2f0 [mlx5_core]
   netif_set_mtu_ext+0xf1/0x230
   do_setlink.isra.0+0x219/0x1180
   rtnl_newlink+0x79f/0xb60
   rtnetlink_rcv_msg+0x213/0x3a0
   netlink_rcv_skb+0x48/0xf0
   netlink_unicast+0x24a/0x350
   netlink_sendmsg+0x1ee/0x410
   __sock_sendmsg+0x38/0x60
   ____sys_sendmsg+0x232/0x280
   ___sys_sendmsg+0x78/0xb0
   __sys_sendmsg+0x5f/0xb0
   [...]
   do_syscall_64+0x57/0xc50

This patch fixes the issue by doing page frag counting on all the
original XDP buffer fragments for all relevant XDP actions (XDP_TX ,
XDP_REDIRECT and XDP_PASS). This is basically reverting to the original
counting before the commit in the fixes tag.

As frag_page is still pointing to the original tail, the nr_frags
parameter to xdp_update_skb_frags_info() needs to be calculated
in a different way to reflect the new nr_frags.

Fixes: afd5ba577c10 ("net/mlx5e: RX, Fix generating skb from non-linear xdp_buff for legacy RQ")
Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Cc: Amery Hung <ameryhung@gmail.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
index 40e53a612989..268e20884757 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -1589,6 +1589,7 @@ mlx5e_skb_from_cqe_nonlinear(struct mlx5e_rq *rq, struct mlx5e_wqe_frag_info *wi
 	struct skb_shared_info *sinfo;
 	u32 frag_consumed_bytes;
 	struct bpf_prog *prog;
+	u8 nr_frags_free = 0;
 	struct sk_buff *skb;
 	dma_addr_t addr;
 	u32 truesize;
@@ -1631,15 +1632,13 @@ mlx5e_skb_from_cqe_nonlinear(struct mlx5e_rq *rq, struct mlx5e_wqe_frag_info *wi
 
 	prog = rcu_dereference(rq->xdp_prog);
 	if (prog) {
-		u8 nr_frags_free, old_nr_frags = sinfo->nr_frags;
+		u8 old_nr_frags = sinfo->nr_frags;
 
 		if (mlx5e_xdp_handle(rq, prog, mxbuf)) {
 			if (__test_and_clear_bit(MLX5E_RQ_FLAG_XDP_XMIT,
 						 rq->flags)) {
 				struct mlx5e_wqe_frag_info *pwi;
 
-				wi -= old_nr_frags - sinfo->nr_frags;
-
 				for (pwi = head_wi; pwi < wi; pwi++)
 					pwi->frag_page->frags++;
 			}
@@ -1647,10 +1646,8 @@ mlx5e_skb_from_cqe_nonlinear(struct mlx5e_rq *rq, struct mlx5e_wqe_frag_info *wi
 		}
 
 		nr_frags_free = old_nr_frags - sinfo->nr_frags;
-		if (unlikely(nr_frags_free)) {
-			wi -= nr_frags_free;
+		if (unlikely(nr_frags_free))
 			truesize -= nr_frags_free * frag_info->frag_stride;
-		}
 	}
 
 	skb = mlx5e_build_linear_skb(
@@ -1666,7 +1663,7 @@ mlx5e_skb_from_cqe_nonlinear(struct mlx5e_rq *rq, struct mlx5e_wqe_frag_info *wi
 
 	if (xdp_buff_has_frags(&mxbuf->xdp)) {
 		/* sinfo->nr_frags is reset by build_skb, calculate again. */
-		xdp_update_skb_frags_info(skb, wi - head_wi - 1,
+		xdp_update_skb_frags_info(skb, wi - head_wi - nr_frags_free - 1,
 					  sinfo->xdp_frags_size, truesize,
 					  xdp_buff_get_skb_flags(&mxbuf->xdp));
 
-- 
2.44.0


