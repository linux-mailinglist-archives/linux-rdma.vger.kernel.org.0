Return-Path: <linux-rdma+bounces-21564-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oN9UCGwkHWq6VwkAu9opvQ
	(envelope-from <linux-rdma+bounces-21564-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 01 Jun 2026 08:19:24 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FDD361A0DE
	for <lists+linux-rdma@lfdr.de>; Mon, 01 Jun 2026 08:19:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7AA473010DC6
	for <lists+linux-rdma@lfdr.de>; Mon,  1 Jun 2026 06:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79C2A3546D7;
	Mon,  1 Jun 2026 06:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CHkTmMkQ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011069.outbound.protection.outlook.com [40.107.208.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB28351C27;
	Mon,  1 Jun 2026 06:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780294561; cv=fail; b=F/amL6+gEzfhwV//T9a9EyGcf7O+0xF73yuc3Gd3qwuRNmMne96fOSLpS/iAUwAs5fnHRseuYdgxOJdIfuXNR3cP3kDg6ZYrjpAg4gHAMUIDqT5ZdPzM2oefOzBYIBYBiI2INaVuy5w/sqTyIOnDH5o0GBYb3EunuAL7o8dK8cg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780294561; c=relaxed/simple;
	bh=jg6gUK5dsxBJbLY1DLlkQSv/NFCIZcNdlj9/q7Mm0m4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CLMTUjVRbVceYp3kEIalck53Wqe8RfsWol7lKyXos8819O1WsGF4rrwQQunVeytgpOFzw0TgWvlCT52cbzo8e5KCP8RP4hOUwO6m82mtxQGj9lq7BPDmpXbebHdwcM3bBJZHWQGbPP4CX9pU26t5szTKT0NP3uJ3pn/unkoIriU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CHkTmMkQ; arc=fail smtp.client-ip=40.107.208.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FW5IBVsfJR3RefVFBT9f2x72tSQ+KolbVBMIPoySYxCF+pjAE8P42vPBxSQ+lKLZUEqUmaEBs0GcrjFEApXkcR+XYqJ8C9VdRZJGfrGR+W475MTslUe4zknkQSPd+Mr7hbD5QTzIUz968hhyIppiMjF/l+HSngwf8/wAAmGG5KJtvJDSiM47jcUCrgoAL/92Ro8Oc60wIidqSxPSPKBBTvRd7ugEMFmxGpdx/xpsjpKM/xfhA7iAK2r3Ol1vR3c/vnBp590nZyg2FIayCi9X+AZLhCBXIPuPOctk2I2/3AT97FXsOZtrv5pwbS5EH+7BMhm8orCUuN8aJLKk0R3HxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LR3nhB4DLqBG79O7N6p+487SY+rWqOYxi/Hx7druYcA=;
 b=c53KepF771yj+hrFYE5VWT8Rb+a4u/sRJhUGUkSqbyd2eWomtsgYQ7pwxlnaWriOTp4CobBmQLjeYyGOYdgiahaeyH7Ll7VgWvF2laPlAqFcRGA7RIIA6OlpD9tUghhFaSoeJVogJk/z6JJrxVocTk7S/RW3/K/bU8C/Z9LG3zTmZJp4wPMypV+dtOl5O8QbrjRdq5/MLrFE8pw2wy3lFR5EzbshUWlBc+skcyybGVrnyt0cLMuHMC/WTCgsJpi5IkGroa7Vx4jj0gSCtzBmDxHr1HttLVjqdjrFIURt1/o8wUTl/Q9dWCvn9O6wWl/ZrxMBhFVqc3f571OwgtKz6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LR3nhB4DLqBG79O7N6p+487SY+rWqOYxi/Hx7druYcA=;
 b=CHkTmMkQ/XYehcmFu8+oyBY6zNegYJbY0ieOqC2ygzq5zZ88aKTWuT7C0U5oLDFJdeBAQy28AkKIPpuTzgu/c3Z6Ly/6TCQdCNssJ8Bn/khqiPI1dxklh2OCjPKOgicZ4Q1ndARrLYco9CHPNjEH+8JSqnUimhzRWaHPSCO/4e6TgR9uW206fz57oBb85YKX40nCcAEGtyQMTm9EO89aXBX9Up+b5a/PaIrVOiBOB/iYcYU+xVjv16wM3wc9/ZYGdRAqv1vb5U+Y6MIPCRsLPSrWBYxarHJy9AQY9fFRLgqvaRl89bhNtXFNTHg8rOcoP6ITJ3C2gCyXZ6lVkJw0Bw==
Received: from CY5P221CA0153.NAMP221.PROD.OUTLOOK.COM (2603:10b6:930:6a::23)
 by DS7PR12MB8323.namprd12.prod.outlook.com (2603:10b6:8:da::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.16; Mon, 1 Jun 2026 06:15:54 +0000
Received: from CH1PEPF0000AD7C.namprd04.prod.outlook.com
 (2603:10b6:930:6a:cafe::31) by CY5P221CA0153.outlook.office365.com
 (2603:10b6:930:6a::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.17 via Frontend Transport; Mon, 1
 Jun 2026 06:15:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CH1PEPF0000AD7C.mail.protection.outlook.com (10.167.244.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Mon, 1 Jun 2026 06:15:54 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 31 May
 2026 23:15:44 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sun, 31 May 2026 23:15:44 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Sun, 31 May 2026 23:15:40 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
	"Mark Bloch" <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Amery Hung
	<ameryhung@gmail.com>, David Laight <david.laight.linux@gmail.com>,
	"Christoph Paasch" <cpaasch@openai.com>, Dragos Tatulea <dtatulea@nvidia.com>
Subject: [PATCH net-next V7 1/2] net/mlx5e: DMA-sync earlier in mlx5e_skb_from_cqe_mpwrq_nonlinear
Date: Mon, 1 Jun 2026 09:15:21 +0300
Message-ID: <20260601061522.398044-2-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260601061522.398044-1-tariqt@nvidia.com>
References: <20260601061522.398044-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7C:EE_|DS7PR12MB8323:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ede5343-64a4-46a3-f4ff-08debfa53cc0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|36860700016|82310400026|22082099003|18002099003|3023799007|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	uO/rwEi9RviSuqQw8MC7xxiW3Q54HzRY8DDhioZltAC0kmzjsjnLXZLk5rz7+JmFgHYucj2MLsJq7c7nOUPhs56dZQg/jteHAu96m+f8QC06AkseM/tz1svb3iYSVWe2mgoz3CHLlvi8VZr5QdCaNCiGXGaewV/ljyJ6RXfgvE8XA3f8xwDHFbC0KNngG5mbtw9aUSW6fVUBpeprJEnr5Wvkk1CXAl4fZZSM2wRHxTKFy69vxui3mlLp4ehbHu0jbtiZH2CS1ufhc6A7cpFAx7k+oCG5RIdrTaCdngxFFuSdQt8m4hFZeigkomuC+rvvBtdhda7vuGj7IwLNCWoywK+PFTqTTJ/0FMEPlhZbTWGfFNZHbFUYGoKDyVGYUgj70uTvAWTK0Bem8inJKRRAN0LtCRbh4JwRDcfdgQeDqyvPziE67p2SZatJE/QFfFgOT1zEEeNZf5I7eAvPRnK20Pu/BsZdXR1OffmTAZGILeAjJk/mSh4D4d66etEQ+8WNkfaN35VhptB7BxPXdF6s9BfAMMdiJTfSbsNAa+HLhcvewbQxUF37dvyNNvEokgBO0/20/0J9At+UmxL+cwSZvddHihHybiAWtCKUzHaOFo6Zf+XpcvO6y0IKGyHaf6hh1TkPmQUBzeo3EvV8ICPDziCp13VyBM8iDz1OGnqCtw6jpOT1Gru1BZAqJzR81Dp8XC+sXVKf3JY8QEp3QxlIYdM9V8jF/PfY07MzkRaxBAg=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(36860700016)(82310400026)(22082099003)(18002099003)(3023799007)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ZWs5uM70wCnZ71WRR810FHAEVIfqMJysDp/7QC7lVrJj697LC2TmFifr2pOi1cR5ZhbFJ02VAG2/m43CrAeY8OLta08fMPrAtMCN+FLLF2qWtoFC0mRGI9ePaCUKbsxyiqbfrTDVdqgu3Pg8nMUCn3VMcZbMUbSKpS54qcHWw/gq0paY2P7Sv2HFOlXPik6ahjQtymzCyUdWtclYMHMk6HfDFfkASl3eJBSpqJo7OO5lAFA0F0iB6EC5eFsxN2YYDG2DM8N6XtejOcIqwpxwfzRgiFwP9kAiIHfI8ZDIce1KjcU+MCX4+RNolQSsx5zS7rrvlzPZez5CfDP9Vy+HyisujG7JaHmJEhGkppQ0Elvy66voM90KL4CpxzM2blRO/JDxXbAVPWjqGs8qxiJpRlTbqPhbSGoEasb0muR0RW5PXc2u0nIjQSqbyh7MX2iN
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 06:15:54.1535
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ede5343-64a4-46a3-f4ff-08debfa53cc0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD7C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8323
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[nvidia.com,kernel.org,vger.kernel.org,gmail.com,openai.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21564-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[openai.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 1FDD361A0DE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Christoph Paasch <cpaasch@openai.com>

Doing the call to dma_sync_single_for_cpu() earlier will allow us to
adjust headlen based on the actual size of the protocol headers.

Doing this earlier means that we don't need to call
mlx5e_copy_skb_header() anymore and rather can call
skb_copy_to_linear_data() directly.

Reviewed-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Saeed Mahameed <saeedm@nvidia.com>
Signed-off-by: Christoph Paasch <cpaasch@openai.com>
Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/en_rx.c   | 22 +++++++++++++------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
index 5b60aa47c75b..75ccf40a7f17 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -1923,11 +1923,11 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *w
 	unsigned int truesize = 0;
 	u32 pg_consumed_bytes;
 	struct bpf_prog *prog;
+	void *va, *head_addr;
 	struct sk_buff *skb;
 	u32 linear_frame_sz;
 	u16 linear_data_len;
 	u16 linear_hr;
-	void *va;
 
 	if (unlikely(cqe_bcnt > rq->hw_mtu)) {
 		u8 lro_num_seg = get_cqe_lro_num_seg(cqe);
@@ -1940,9 +1940,11 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *w
 
 	prog = rcu_dereference(rq->xdp_prog);
 
+	head_addr = netmem_address(head_page->netmem) + head_offset;
+
 	if (prog) {
 		/* area for bpf_xdp_[store|load]_bytes */
-		net_prefetchw(netmem_address(frag_page->netmem) + frag_offset);
+		net_prefetchw(head_addr);
 
 		va = mlx5e_mpwqe_get_linear_page_frag(rq);
 		if (!va) {
@@ -1956,6 +1958,8 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *w
 		linear_frame_sz = MLX5_SKB_FRAG_SZ(linear_hr + MLX5E_RX_MAX_HEAD);
 		linear_page = &rq->mpwqe.linear_info->frag_page;
 	} else {
+		dma_addr_t addr;
+
 		skb = napi_alloc_skb(rq->cq.napi,
 				     ALIGN(MLX5E_RX_MAX_HEAD, sizeof(long)));
 		if (unlikely(!skb)) {
@@ -1967,6 +1971,11 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *w
 		net_prefetchw(va); /* xdp_frame data area */
 		net_prefetchw(skb->data);
 
+		addr = page_pool_get_dma_addr_netmem(head_page->netmem);
+		dma_sync_single_for_cpu(rq->pdev, addr + head_offset,
+					ALIGN(headlen, sizeof(long)),
+					rq->buff.map_dir);
+
 		frag_offset += headlen;
 		byte_cnt -= headlen;
 		linear_hr = skb_headroom(skb);
@@ -2056,8 +2065,6 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *w
 			__pskb_pull_tail(skb, headlen);
 		}
 	} else {
-		dma_addr_t addr;
-
 		if (xdp_buff_has_frags(&mxbuf->xdp)) {
 			struct mlx5e_frag_page *pagep;
 
@@ -2071,10 +2078,11 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *w
 				pagep->frags++;
 			while (++pagep < frag_page);
 		}
+
 		/* copy header */
-		addr = page_pool_get_dma_addr_netmem(head_page->netmem);
-		mlx5e_copy_skb_header(rq, skb, head_page->netmem, addr,
-				      head_offset, head_offset, headlen);
+		skb_copy_to_linear_data(skb, head_addr,
+					ALIGN(headlen, sizeof(long)));
+
 		/* skb linear part was allocated with headlen and aligned to long */
 		skb->tail += headlen;
 		skb->len  += headlen;
-- 
2.44.0


