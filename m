Return-Path: <linux-rdma+bounces-20126-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yAONELti/GkqPgAAu9opvQ
	(envelope-from <linux-rdma+bounces-20126-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 07 May 2026 12:00:27 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 973414E663F
	for <lists+linux-rdma@lfdr.de>; Thu, 07 May 2026 12:00:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 68916306FA4D
	for <lists+linux-rdma@lfdr.de>; Thu,  7 May 2026 09:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FA343CAE92;
	Thu,  7 May 2026 09:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eG2tyZN/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012032.outbound.protection.outlook.com [40.93.195.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4BBE3C9EEB;
	Thu,  7 May 2026 09:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778147672; cv=fail; b=KYQKBqDMLBcCyJkU0iVLGNLP2RNZGF+GlowRB9aLvej4uTJBZ6rW2F6HUYu5j1eirOwDZJJV3gKSMJ0RFTDVTraw4rj6sAxi/iyiDDjRiv1x9ua21/4Y002OQaKRKc5HVkSydrptmIccj7Se5ZrqRbLeh87BvNqFWd40wMIzB14=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778147672; c=relaxed/simple;
	bh=a8QhLbNpeuxAZgX/L6u6V1dLCg1xdO1PXfTFf6dxatY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eXXbdyVEbKopz9sV+X6vTukAC7eJxCJGUn83f2zr+yW0RwseFQjvzaVKPBmbdfa1UaCaPVA287tsWgjKPQQBnl+TkW3t6/luGBY+kUIrN8yE4pa5tKlH1k0fr3FyB2IiLHVBEQ1035cNpaKhxS+3WRCqza4kc1KUHWhRv8LDOXk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eG2tyZN/; arc=fail smtp.client-ip=40.93.195.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sxoNfW59oZLJYzd2oNnDxtR6U2cSkvoRk12wBG7FGf758NKaaAnBDb/r4NY5Hq7lfzQBi7i9KVCrdN8ukLFgq2uBQaYY5AnNXbpPsB5vkU++REm2860mv4dIWUGKEbvcODlHy5Q6hamkpeuo4jeSO0vO8c3Gc10Na1/4y/SJbY1nPT93PyhnMh+stQKe4ZIUGBoiGYDRWvIhoYbTqDVZ9JrOuGBjxMuxBrHDzYh9mPmcWT21y2MudO0k7aAyuxmt7U1X0YsqXUgOnbY2oTBO6nCvvBG2aNiQjo07s47AxWeB8FuF/oN2U5KNNWJRDg0Tg3nCOEZ2RPIdhwGtIMuWsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qb6TNQz0C4ZuLdp2sTGOAm+9TAnE8CS56zi+fzGJ0Bg=;
 b=aQE7o1gZM3c42WB6LzPSKdtQc3TL00hBT5TMIUCpakKiBpkMoPUhLIoH09Urlz1rGFO9mAceAsoZNeFXPt+rZURUGw7cHYe1S5e+wJHJKAmcworHn1A94wOUGe0BOv+lqtYh7Dn77HYKpc0biHpcqvYZd2V529Chl1iSAD1n6h+6+bd+CvgVQbQxc1CZCj5hdsYPMrsCTlph2iPO0ORyhIN7xuXaFGcEkGZmyn4NC3+DvXk4kEmdrn46qu1wb5TIiokUjIlHqauv9SyfL/Je8fb1q/5hKNuklH3O/2TYoVKVeBmzkQTzGY6uiSwfA+DB3+sFGhDA2pj7JOFDuivrOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=openai.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qb6TNQz0C4ZuLdp2sTGOAm+9TAnE8CS56zi+fzGJ0Bg=;
 b=eG2tyZN/uB0BVGrUeqcqyP2mp7+/tICT556R49dkuWCF+S0ICDpyLmnJlTOWKdzufuSMjysqRp2oCmwbil0fZUaVVrRCerErltVx1J23NW29Y87nT2s7zjI7aU8XAWnfNcolE/Y6I/3n8HUxH3ymeGsBHqApBcJhSvoebsnFNgORqiVxB2kESMclW7FPJB/dJvUWoNT7pQUYQ1XbdevFR5wD3wRyjS9g5L4TD7Je5VYzfCEB94Z1YgKxbA98+m2q4MusVfiKYcD1gAunLc7oc3lDv/mtFmrbvrgMogz+COldF0gK65zfTI6KKN3bcVRvdhVDsxMZpW0l+KRalbWuVg==
Received: from BLAPR03CA0166.namprd03.prod.outlook.com (2603:10b6:208:32f::18)
 by DM6PR12MB4314.namprd12.prod.outlook.com (2603:10b6:5:211::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.17; Thu, 7 May
 2026 09:54:25 +0000
Received: from BL02EPF0002992C.namprd02.prod.outlook.com
 (2603:10b6:208:32f:cafe::62) by BLAPR03CA0166.outlook.office365.com
 (2603:10b6:208:32f::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.17 via Frontend Transport; Thu,
 7 May 2026 09:54:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL02EPF0002992C.mail.protection.outlook.com (10.167.249.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Thu, 7 May 2026 09:54:24 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 7 May
 2026 02:54:11 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 7 May 2026 02:54:10 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 7 May 2026 02:54:06 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Christoph Paasch <cpaasch@openai.com>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
	"Mark Bloch" <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>, Daniel Borkmann <daniel@iogearbox.net>, "Jesper
 Dangaard Brouer" <hawk@kernel.org>, John Fastabend
	<john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, Amery Hung
	<ameryhung@gmail.com>, Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH net-next V6 2/3] net/mlx5e: Avoid copying payload to the skb's linear part
Date: Thu, 7 May 2026 12:53:29 +0300
Message-ID: <20260507095330.318892-3-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260507095330.318892-1-tariqt@nvidia.com>
References: <20260507095330.318892-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0002992C:EE_|DM6PR12MB4314:EE_
X-MS-Office365-Filtering-Correlation-Id: 29d5d685-1178-4fc3-09bb-08deac1e9ed1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|82310400026|376014|7416014|3023799003|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	nUPENdMX5Lr9lug8TZJpgyXUUAfQH0O6Lphnf3e/DBlhq75NAOS0+zkABrBIKkijld9TqapUSW2FAZnSA/5UN17a8bd+s5usc/Lgl/XjZjHt8JeNoHkn2ZZzTr5Y+TIjljaKQzgR1pE07jswWy4fYI7/IT0BdQYPQAYR6FYbIsiCeCysqZCJSgN14uK4vaOKG7Olux+cBDyySAGQ0ujaIguy59GFtqjWu4MgbqROfipoMg+UVXb1dyhuGB3CEjdgbULBJA78w8iPnktdsWrNklGhqKOhAm7FDFSEKe6RvgJ4gWZ75wIiSCaBNiDcSHaLKURNEUXcqZeZoLNNy+uqy23KeP9vfwgRom1mfMosreTqP4c7jiA7IQQE0q/qTbubZVz26OQmsZFWazwsjEtw/8QCBHCjuqvZSoymQrQzpEfZhC+P2lJiDAjkLL9KE28Mo1tiMFUW/JMvIkV7Et2fkkxmLkUpGUNdX4Wt/ugYHNCtWCRHlLRXLsQ+3PazhXF05cCPlCjT3WJTfCvpHr/R6xter/X4uBWELtMzTLmv+xStLhaurTPwBJDpaZR1ncH1KNvGrkt+kAK3v6LDfPBMYORUDeCJeys7ha7L1khmTOZq2j85sx9q6Ug9plAemvQG/PUXhQhY82T5Sg4rvH3wUiRTKy+UMNvirtmZ1L36U6IpPrjPJqm3zMoLxYeQoLAbOUqyDMN8KdiY0mtaIV2D9qx38Xs+MQkE+1Yx2rHEZ0E=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(7416014)(3023799003)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	H3O1knRjQZx3HH5vD2DpJ9fhAmKz3ya0PVkigCM08Ul9FLNyl6GUYv2vd+mSgsbSaTe+nb/a03Fan6eG04zLo0XlykFxiWmdnnnwnUTjTlhpNHjDRhaHRhoiEuN57x+sS5YBxF97X92CO+M7z30tjG/Sj0HxLwX+VEWQAK6ttBbserdo3T3Hly/IGEqT7utKxhaem23zLjjBBbO0bWIShkBgR34CO50hV4y3xO0veUWXSZuc54shBbM8ADgmKrTDNfn+aBfRgITjyrgfmW0ylrbqSF9mzv7uWXggPYE3ZKYaCNQTiu4o3DL63n7ySN9AzY1wf4oNMkGdof2ukjisdPGFHvDlp/v5bPXJfSWtfuW4hzyysgYKQ8mtUYvWxfcxzAbrVexP72cjmVQ6Xi0SfWzT5/jS6AeojjIyPt50AuRfQxgtzWwyV/0hs6BA/p2s
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 09:54:24.4708
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 29d5d685-1178-4fc3-09bb-08deac1e9ed1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0002992C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4314
X-Rspamd-Queue-Id: 973414E663F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[nvidia.com,kernel.org,vger.kernel.org,iogearbox.net,gmail.com,fomichev.me];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20126-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[openai.com:email,nvidia.com:email,nvidia.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,Nvidia.com:dkim];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.995];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

From: Christoph Paasch <cpaasch@openai.com>

mlx5e_skb_from_cqe_mpwrq_nonlinear() copies MLX5E_RX_MAX_HEAD (256)
bytes from the page-pool to the skb's linear part. Those 256 bytes
include part of the payload.

When attempting to do GRO in skb_gro_receive, if headlen > data_offset
(and skb->head_frag is not set), we end up aggregating packets in the
frag_list.

This is of course not good when we are CPU-limited. Also causes a worse
skb->len/truesize ratio,...

So, let's avoid copying parts of the payload to the linear part. We use
eth_get_headlen() to parse the headers and compute the length of the
protocol headers, which will be used to copy the relevant bits of the
skb's linear part.

We still allocate MLX5E_RX_MAX_HEAD for the skb so that if the networking
stack needs to call pskb_may_pull() later on, we don't need to reallocate
memory.

This gives a nice throughput increase (ARM Neoverse-V2 with CX-7 NIC and
LRO enabled):

BEFORE:
=======
(netserver pinned to core receiving interrupts)
$ netperf -H 10.221.81.118 -T 80,9 -P 0 -l 60 -- -m 256K -M 256K
 87380  16384 262144    60.01    32547.82

(netserver pinned to adjacent core receiving interrupts)
$ netperf -H 10.221.81.118 -T 80,10 -P 0 -l 60 -- -m 256K -M 256K
 87380  16384 262144    60.00    52531.67

AFTER:
======
(netserver pinned to core receiving interrupts)
$ netperf -H 10.221.81.118 -T 80,9 -P 0 -l 60 -- -m 256K -M 256K
 87380  16384 262144    60.00    52896.06

(netserver pinned to adjacent core receiving interrupts)
 $ netperf -H 10.221.81.118 -T 80,10 -P 0 -l 60 -- -m 256K -M 256K
 87380  16384 262144    60.00    85094.90

Additional tests across a larger range of parameters w/ and w/o LRO, w/
and w/o IPv6-encapsulation, different MTUs (1500, 4096, 9000), different
TCP read/write-sizes as well as UDP benchmarks, all have shown equal or
better performance with this patch.

Reviewed-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Saeed Mahameed <saeedm@nvidia.com>
Signed-off-by: Christoph Paasch <cpaasch@openai.com>
Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
index 75ccf40a7f17..301b33419207 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -1976,6 +1976,8 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *w
 					ALIGN(headlen, sizeof(long)),
 					rq->buff.map_dir);
 
+		headlen = eth_get_headlen(rq->netdev, head_addr, headlen);
+
 		frag_offset += headlen;
 		byte_cnt -= headlen;
 		linear_hr = skb_headroom(skb);
@@ -2012,9 +2014,13 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *w
 
 	if (prog) {
 		u8 nr_frags_free, old_nr_frags = sinfo->nr_frags;
+		skb_frag_t *frag = &sinfo->frags[0];
 		u8 new_nr_frags;
 		u32 len;
 
+		headlen = eth_get_headlen(rq->netdev, skb_frag_address(frag),
+					  skb_frag_size(frag));
+
 		if (mlx5e_xdp_handle(rq, prog, mxbuf)) {
 			if (__test_and_clear_bit(MLX5E_RQ_FLAG_XDP_XMIT, rq->flags)) {
 				struct mlx5e_frag_page *pfp;
@@ -2060,8 +2066,7 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *w
 				pagep->frags++;
 			while (++pagep < frag_page);
 
-			headlen = min_t(u16, MLX5E_RX_MAX_HEAD - len,
-					skb->data_len);
+			headlen = min_t(u16, headlen - len, skb->data_len);
 			__pskb_pull_tail(skb, headlen);
 		}
 	} else {
-- 
2.44.0


