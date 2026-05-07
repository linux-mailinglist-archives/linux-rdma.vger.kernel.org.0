Return-Path: <linux-rdma+bounces-20125-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gHRWBati/GkqPgAAu9opvQ
	(envelope-from <linux-rdma+bounces-20125-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 07 May 2026 12:00:11 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AB4B4E6638
	for <lists+linux-rdma@lfdr.de>; Thu, 07 May 2026 12:00:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C8D3F309B9C1
	for <lists+linux-rdma@lfdr.de>; Thu,  7 May 2026 09:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A50213C65FF;
	Thu,  7 May 2026 09:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JCSVJN6l"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010066.outbound.protection.outlook.com [52.101.85.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF7E3BBA1D;
	Thu,  7 May 2026 09:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778147665; cv=fail; b=SaxH9cdvW/FJeR7m9gKxVMq8EEfGTDrYCodaWYAlkqIaYbnS/ADS1pWzBNqmYvUMN9SonMfUXlcCyMPcutcL7nHBFO89efZIkGzRxOL3z8rmYz73iPq7yh+UE8hx1ll2wUN3Odrxauz1VBfuoCnColIhFg4GjeX9zQNwzXGnZxc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778147665; c=relaxed/simple;
	bh=jg6gUK5dsxBJbLY1DLlkQSv/NFCIZcNdlj9/q7Mm0m4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DlwA6ewJ3N5/V1SBvv+Wkwfr3KrqgeEOi7XHkE/+fC1DhVMR2fk+2CpA8Qx5f51eBHpZjVxRfkfJL5iqhdtUNrql4q9lQckoXgUSY/ZhFRZtGSyg5Ae5hR6S8ObrAJvu7Q9ex2SlbxM1YrmCSsxEtIEwLyOAhWBt8aM5wpt6qZk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JCSVJN6l; arc=fail smtp.client-ip=52.101.85.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aaOBXQBkWCy2yaEkNIHdse8ppP31nfCMufKHbcf4Wpekqxh3l+pEmV7nkRHtm2Kjg3mvTqHKxp/SHOg91ZgcOMNavm1nQhlDqwP5NEV4NL0Xh92WWjrcRRk6NxZD3UQq9ri2GNnU3m3Jn1+DqwH1BRiD6QmovGxmTa8Z34DCM7J3zCEm0xo554S7yh/uXZyb1DZm+xdG8S+dTgeqafKnzfOMbMo77x2My9hyur9m7fk61tWoHYJBVVdjMr0Q9d51sbsUkO2GvM7DDFAZrbDO47TvN6N11N/cmgdtStM70sOP+nPKgmUsB2alPmLvcpIQbZI6PvHzjDvpe02/V0jwDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LR3nhB4DLqBG79O7N6p+487SY+rWqOYxi/Hx7druYcA=;
 b=ngwRVOXa0gwBROm7iK0Dqg1d5JijOgCB0Prs3uu7wD3HYvbWYkRLt0mlroLYdlym97MTTZEzXOFHRfERi6lOyrel9jcI4CAq3pXAWXp0mJFulcHPiSFyPox2PUUD4UUDBIN9IYLlHzeh6BAfi6TPXLdpaNhMLn/SM4fIZZt7bdyepGRDwqhtF5JYn7KSkhBW8sruL9WT5fkk+EPtMGMjnIvcZDpatmUDGwpQiSQmqtZLBL44XMPqeOhfpynWJaQxaawrpHFWEfhmOe5IoDMIpShVRgeDW42c85ogw1LKMiue70C0KKwJ08DHTDvXrf4qevnN6fCD9bk6udplRG4Kng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=openai.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LR3nhB4DLqBG79O7N6p+487SY+rWqOYxi/Hx7druYcA=;
 b=JCSVJN6lgRd3EDMThRkw6gy6/Ih/BLdUCQWNYxK8WkvPJ2o854Pts/lhlcgT4mkqPqZ4A97OhU4LnQlDpDrQogqIg9RkwdUfl2V+Ha6O28bbVRUbS39YQiJvFe6gFarh0eechFX9eB/kbXrC9h26QCevw0MILCpnrW/gHWeT2JzEHgMWAuQNKvfUufGH3/Zbz0i82GIQdHcYx0SClAPyyEqknCEAsm1fmXebEo6wdsH8IGMF+QslrGcYEtOwcvKFQcRISeKKkEPxUYSrWBI2brekuX6Jd8jXZJdH4pn28Bupk4Xmp5bKcY4MllIvEF9t9pj+WMyz+dutIuSLaigrFQ==
Received: from MN2PR16CA0053.namprd16.prod.outlook.com (2603:10b6:208:234::22)
 by SAVPR12MB999168.namprd12.prod.outlook.com (2603:10b6:806:4e6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.28; Thu, 7 May
 2026 09:54:18 +0000
Received: from BL02EPF0002992D.namprd02.prod.outlook.com
 (2603:10b6:208:234:cafe::b2) by MN2PR16CA0053.outlook.office365.com
 (2603:10b6:208:234::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.16 via Frontend Transport; Thu,
 7 May 2026 09:54:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL02EPF0002992D.mail.protection.outlook.com (10.167.249.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Thu, 7 May 2026 09:54:18 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 7 May
 2026 02:54:05 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 7 May 2026 02:54:05 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 7 May 2026 02:54:00 -0700
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
Subject: [PATCH net-next V6 1/3] net/mlx5e: DMA-sync earlier in mlx5e_skb_from_cqe_mpwrq_nonlinear
Date: Thu, 7 May 2026 12:53:28 +0300
Message-ID: <20260507095330.318892-2-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0002992D:EE_|SAVPR12MB999168:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ab0f89d-9faa-408c-3726-08deac1e9aff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|7416014|1800799024|82310400026|3023799003|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	auiMG1nzVqugwOE26GMnnAgXdtpESYzWKHw974FB2o0SgIA5tMB+cGmeeRjdpohSwN3x3QjraG9glkDQZYRp5cY/qiB0KmXJEJApVNqPt0oO6n/P/mvNQKoVGn8YctL/ZdxD3/N77TWYM9/hQ1kf/izMiI4fMIldQ/zu6AaQtEMqBG1B53+wvvh8MQkeYiCO16xwscTLgLdYufao/+cCO92p5rvTrSN/AO6U+Tv+wOSJhXFxURGv6PtupfbDWDG/AxpEUnvgyOnssilpqIPZCV/8dEHLRFXVW3uAgmV6pB7yVqxqsUmuRsMXPK6oAMLCqJ1PrXcQLiD0NT/yEvjZbRqU7uo0JOJBMME02TETWWqOeLEj8Dh8kFcQ63oFBjFV/AtAFbgicECXK+AffOtWhr2arGfIotsHk/ybASZoFy/JUjHbkmu4EdBV/WA0px9l/TtZLiLuYoGFAfVaBePrwV4favC3d8MQyoKt5wGtq9nbaiivQh+C5fbUKhjAnGclSVvaNG4dgaKPE7tCVp6Dc6Vb5xnA66LrqJU518rpFrFvHX52/bZzw/D/O3ttP1ZFTfDzoPqn/l2NNfchmRXwr9U4+O0AU6ViqWm85PNqvlYRmA02x1i0Zz/PSxWbm4Hw9NJTL/ckSsM5dh+WK8pHtiOg4ol6rsDvaszPTMO+szf/x3ex0WOxr48auPcMKQHGGbVPtdU1t/AOuK3bWDMwqWoJws+oQM6YmyiasLHgzz8=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(376014)(7416014)(1800799024)(82310400026)(3023799003)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	6PdxXUPTvgM77jxs3slcYoDkLn/F7MzOdQEz23tHwiRtHYjrW/Qcx4k2AHWjU752ELE1UJxKeLV/yLINQk+rlPsXsVi3wK6pXevEi7HGFEQhogTtZgeTxcbVbAs1IMhZnFdJJhAlO0jxD/duonteXoqrCZ2R0R+VRiUCOBTv6SfAFILkl5BgHBGksHJ9a1dbCzuVJhRy9im4bNb37WxvreAW0FH+5/N5IRuIPnNuzcK030jMDGN+Pkwb4v7KSoua3/NPAGr0HinLBH8csqU026CiRbXMroAXfxkk/IkrWh00N5jxLHUoSlYnz+UjX67cjO9Hki9CleVAQ7Nihvz8qk7KKOVmktY8RsgT4bTG+0G+p54LfbtYDFgFKBABppDO6bM39DzQTF68IKgtzzTdfDaSroC87oAEpz0mke1nyE7QNtpR1fYZ6PL+x/UmRaM4
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 09:54:18.0762
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ab0f89d-9faa-408c-3726-08deac1e9aff
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0002992D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAVPR12MB999168
X-Rspamd-Queue-Id: 8AB4B4E6638
X-Rspamd-Server: lfdr
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
	FREEMAIL_CC(0.00)[nvidia.com,kernel.org,vger.kernel.org,iogearbox.net,gmail.com,fomichev.me];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20125-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

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


