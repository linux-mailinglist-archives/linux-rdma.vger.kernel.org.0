Return-Path: <linux-rdma+bounces-18387-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AL8QOhWsu2ngmQIAu9opvQ
	(envelope-from <linux-rdma+bounces-18387-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Mar 2026 08:56:05 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 919A02C78DA
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Mar 2026 08:56:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C3CE331FF237
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Mar 2026 07:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3F713A4F58;
	Thu, 19 Mar 2026 07:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jt3+hl9m"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011028.outbound.protection.outlook.com [40.93.194.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC2A23EAB3;
	Thu, 19 Mar 2026 07:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773906749; cv=fail; b=d/CtfcDSRh3TUE3Qen6jMdDZhnsxVi59haqnOO4z0nXM3jh9g98RRG/egKab8nYEPPBkVerImuMa6WFoDpMGSbj/JscXE8zLaTv9jrYYHVbSDN7hIge6IP8sGEmZ/l6R9ePn9toRTy77GZsVp1EoQisR4LB4rOfqPU9+w0YPhIQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773906749; c=relaxed/simple;
	bh=DiDHpdTHm/BYrHf6Cj51NhcuRjO8KXsvHnP4vYV/ej4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sNpA7ZofiR+J27Tc957C/ef1snRQa0n1R+sQ7LMmUWkbqhlWf2SPfJU3nvH19tSnJQcLDd404NTrI2erBhC9nF2N9KKZwleVxOG+30se1aGzRuYHoQUoDBI9AgzQoG0O4GGhrgZtcw/f83zbgR0jgKqadzbB2yr2sqZrYQICunQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jt3+hl9m; arc=fail smtp.client-ip=40.93.194.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L89D52aXKgs2z307rbyzsm3YgHdBlSAyPsrsG5beEGHU/RvXz+fNdRX75m8x91QRz8ugWB/wVGaT/NoDWINrtj4oOayh8QTKgWbZOMdD7ZHf1dvNzbzVucP/nAH2Fvt+BzJxGEHOTZL1zpz69gMWs6VOs1HnqsjAo/nmOtgGvw+tMO9pHZn32VTqGI3Wm8Ji+58uISVvqgz611Z4+m5G4p02w0DFJZhh0mNT2hcHrSmaJol6FVQo1/xuDLAxoSwKWZtkbZ13EI2iG0VUcivvq0IYRA6k6pyNo3lCsBH85DpRdAKZCNi/B69gepJPQp0TvlqTS3qYXzBVtFHzf3WwvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CjPQOkDPNFinRoafb4bbU9OO4pI5RQDua91dDrBRxLY=;
 b=zGTITIdlP/cNdJnMAyrewY84vAU0fZGh0S6CxYxBcWl1JiQSOwYWRbyQ8bQU0DXRo20gbtyrO0KgkR2oOGqWUpykgLrtfYJl5kus3yLhLoTQm0/YLMjjEyAXrElcDB27/JYwHyin6CcDQmJx1lT1PRJ6+TIhBU+V/olIIPOoKAfGPI9zW0LH/jhnwmQIUJiOsSCVk/OO3rCq12dEI3EgLiyvmz0Qotatyi1DSo/yT35ZQ/BRE4YkSOdNTO6Ubgm7XNReAB+VTYkCAXGkQ5PneRPl6M91a1TNtcrAsXoj+ZJdFZM0Cj4/PwqkVcyGMNasdWud5U1ysgOGPxaOMwtlLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CjPQOkDPNFinRoafb4bbU9OO4pI5RQDua91dDrBRxLY=;
 b=jt3+hl9mPImVdMt8m6MsB9+T0rqVm31iVObumYrGVpAoMFUpHrr1zGCbJkOqw27CokWot5lDaI3zFa6ifyMgfS/XyzQ4CcSHNvbZAbf9caRhd2xRquuH/rBd9wp7wNO5rIXVz/hVQcyxvUOzvxbKpQKSjKenaeHAVFhDLOdulnMMXr6gbxkKt0YfuyMNctwfyG9WEc2Orc5FjQn+XWmAzqE8rKLDb+22n37zA97mUiKwrLO4lcBhPcVn8CMmSOZCYApijWrgfJo7no1+PbcgT8s7NxnzBeBjoSwg6vKeUMN1OmGaZwWqi+JYMsU84i6submtllCoXVSMladySQgF0w==
Received: from SJ0PR03CA0241.namprd03.prod.outlook.com (2603:10b6:a03:3a0::6)
 by DM4PR12MB5937.namprd12.prod.outlook.com (2603:10b6:8:68::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Thu, 19 Mar
 2026 07:52:23 +0000
Received: from SJ1PEPF00002312.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0:cafe::a0) by SJ0PR03CA0241.outlook.office365.com
 (2603:10b6:a03:3a0::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.27 via Frontend Transport; Thu,
 19 Mar 2026 07:52:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00002312.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Thu, 19 Mar 2026 07:52:22 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 19 Mar
 2026 00:52:01 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 19 Mar
 2026 00:52:00 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Thu, 19
 Mar 2026 00:51:55 -0700
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
	<bpf@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>, Carolina Jubran
	<cjubran@nvidia.com>
Subject: [PATCH net-next 3/5] net/mlx5e: XDP, Remove stride size limitation
Date: Thu, 19 Mar 2026 09:50:34 +0200
Message-ID: <20260319075036.24734-4-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260319075036.24734-1-tariqt@nvidia.com>
References: <20260319075036.24734-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002312:EE_|DM4PR12MB5937:EE_
X-MS-Office365-Filtering-Correlation-Id: 436cdd47-4d09-4f12-94b4-08de858c747e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|82310400026|36860700016|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	xMNVUx1m9hhkyv/8ly0v3vqMO6bH6xgu172v2yKxUrFckH0IzW8kB7I5hna6VQvPDotpL+oTvyqQo73UhyvntjCnaK40zXO2GEYWoh9judCwy5G5Sivqz5X9YSs0JEPbLEvtcBka/eyXc/79+UypaIDaxqoXwl/TwfIDLITwGJQSTyzYn+DiurPJFDh7aLeGs5WIm5/qtY7OO9tzlsPQ7brcbxNPnPucVyHEg307YXSl1dpK5HZam0J9coZ4xArRjDDkgVlCewrhWEP9QbOsq2PmttpVR86tJqQPqBG4as8V2LPGrMM4dVKknWZ0Tvn0z6IqKjM8SA5W/I1ga+2fEVdEm8LhUn4cyOxclJmDfEXUTOLSaK0Awc/ZPmsykv42XEowG8C+4CCYRPLCNQsJ2LKP1EJ64Lt1drFxRamM33aoSq0nwevaRwl8dQgGFgFKHkn6r2YvxZXar/lcQ3heKXm9X1b28CEtMY7HT02m874v8dUbeLQuVvnzd5getC4yK0x0dJAyJiTMPa+JsF2F5qBS4dQ53i1Nap5tDR6d/qQBa3Z10mo/c7M7vNDakfCF6ATV7mWEhO46g539CReQv+tuA0UQS/AE9s5wZJTVmpem/uCPCqOY6tXoJ4wRCK9w3GIx/36nUO/rKcctjSiKbzfNeZ9HqJqU1XWy7gT3XUTTZr+XwyW/dDnQlbM0ANAOdXlpMY7AnwRpXauowwz5JG4MGm9hXG1SPDWt5QgJmSln/1S/AdQzH1fjviVQ2gLptfrBT+OfSJupgJhxW8/5+g==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(82310400026)(36860700016)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	/ZKROWaT1y/ZZrYrVdTyZjVYBcv6B/1K6fgTssUfX/gv3MUURGv8EaDjxeCpdyoM+T0r4SNCOeyzatTg+1sUmxqG/Q6glwHtPUxtUdjUU2mqbH50eH90DCoZ/ZDpMsgnFBGVAoPgeWFgw1OQo1qdN9c3DZxdOkgc7khh2+W0W0sjsQr9nrP8i0G9Gno6pd+IStx2O7931MmSAVEedLdOBOqLyzgplewSHRrn50VBIylN+T5n0OLq5IV0B8SfMtO3EmO09+PwfilxBr7fqg9dXDJTdAxoYq1F1Ijlc29jHJBZRmtp8Qcjm8i4ldX61a0lmWR2iync2oJCiF0fg/pJYmeNzJndq9ZFdaw56af8NgKtQZ2IZ1wn0ylXN8SjZ9WUPrif5EU/Pq1t4NDpVIsX4Ls2bdfxWXQFNrd2yNFHecOEpf3gzwvCj6YNw6AG1h06
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 07:52:22.8140
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 436cdd47-4d09-4f12-94b4-08de858c747e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002312.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5937
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[nvidia.com,kernel.org,iogearbox.net,gmail.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-18387-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email,nvidia.com:mid];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.935];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 919A02C78DA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Dragos Tatulea <dtatulea@nvidia.com>

Currently XDP mode always uses PAGE_SIZE strides. This limitation
existed because page fragment counting was not implemented when XDP was
added. Furthermore, due to this limitation there were other issues as
well on system with larger pages (e.g. 64K):

- XDP for Striding RQ was effectively disabled on such systems.

- Legacy RQ allows the configuration but uses a fixed scheme of one XDP
  buffer per page which is inefficient.

As fragment counting was added during the driver conversion to
page_pool and the support for XDP multi-buffer, it is now possible
to remove this stride size limitation. This patch does just that.

Now it is possible to use XDP on systems with higher page sizes (e.g.
64K):

- For Striding RQ, loading the program is no longer blocked.
  Although a 64K page can fit any packet, MTUs that result in
  stride > 8K will still make the RQ in non-linear mode. That's
  because the HW doesn't support a higher than 8K stride.

- For Legacy RQ, the stride size was PAGE_SIZE which was very
  inefficient. Now the stride size will be calculated relative to MTU.
  Legacy RQ will always be in linear mode for larger system pages.

  This can be observed with an XDP_DROP test [1] when running
  in Legacy RQ mode on a ARM Neoverse-N1 system with a 64K
  page size:
  +-----------------------------------------------+
  | MTU  | baseline   | this change | improvement |
  |------+------------+-------------+-------------|
  | 1500 | 15.55 Mpps | 18.99 Mpps  | 22.0 %      |
  | 9000 | 15.53 Mpps | 18.24 Mpps  | 17.5 %      |
  +-----------------------------------------------+

There are performance benefits for Striding RQ mode as well:

- Striding RQ non-linear mode now uses 256B strides, just like
  non-XDP mode.

- Striding RQ linear mode can now fit a number of XDP buffers per page
  that is relative to the MTU size. That means that on 4K page systems
  and a small enough MTU, 2 XDP buffers can fit in one page.

The above benefits for Striding RQ can be observed with an
XDP_DROP test [1] when running on a 4K page x86_64 system
(Intel Xeon Platinum 8580):
  +-----------------------------------------------+
  | MTU  | baseline   | this change | improvement |
  |------+------------+-------------+-------------|
  | 1000 | 28.36 Mpps | 33.98 Mpps  | 19.82 %     |
  | 9000 | 20.76 Mpps | 26.30 Mpps  | 26.70 %     |
  +-----------------------------------------------+

[1] Test description:
- xdp-bench with XDP_DROP
- RX: single queue
- TX: sends 64B packets to saturate CPU on RX side

Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en/params.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/params.c b/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
index 26bb31c56e45..1f4a547917ba 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
@@ -298,12 +298,9 @@ static u32 mlx5e_rx_get_linear_stride_sz(struct mlx5_core_dev *mdev,
 	 * no_head_tail_room should be set in the case of XDP with Striding RQ
 	 * when SKB is not linear. This is because another page is allocated for the linear part.
 	 */
-	sz = roundup_pow_of_two(mlx5e_rx_get_linear_sz_skb(params, no_head_tail_room));
+	sz = mlx5e_rx_get_linear_sz_skb(params, no_head_tail_room);
 
-	/* XDP in mlx5e doesn't support multiple packets per page.
-	 * Do not assume sz <= PAGE_SIZE if params->xdp_prog is set.
-	 */
-	return params->xdp_prog && sz < PAGE_SIZE ? PAGE_SIZE : sz;
+	return roundup_pow_of_two(sz);
 }
 
 static u8 mlx5e_mpwqe_log_pkts_per_wqe(struct mlx5_core_dev *mdev,
@@ -453,10 +450,6 @@ u8 mlx5e_mpwqe_get_log_stride_size(struct mlx5_core_dev *mdev,
 		return order_base_2(mlx5e_rx_get_linear_stride_sz(mdev, params,
 								  rqo, true));
 
-	/* XDP in mlx5e doesn't support multiple packets per page. */
-	if (params->xdp_prog)
-		return PAGE_SHIFT;
-
 	return MLX5_MPWRQ_DEF_LOG_STRIDE_SZ(mdev);
 }
 
-- 
2.44.0


