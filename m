Return-Path: <linux-rdma+bounces-21025-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mOkbCDxhDWoIwwUAu9opvQ
	(envelope-from <linux-rdma+bounces-21025-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 20 May 2026 09:22:36 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B3524588D97
	for <lists+linux-rdma@lfdr.de>; Wed, 20 May 2026 09:22:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AC195300C5BC
	for <lists+linux-rdma@lfdr.de>; Wed, 20 May 2026 07:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C42735B634;
	Wed, 20 May 2026 07:19:27 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mailgw1.hygon.cn (unknown [101.204.27.37])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1486346AFB;
	Wed, 20 May 2026 07:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.204.27.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779261567; cv=none; b=UkUoMxwaOJCcdldrssO7D0YKE9LftsROhnWoRfpCd+8ZKxIUc4EFbTbneac2VD2Btqhuktmx4eQ5MMbImwDIk04bW5bkjz21rEMzeW5CzuooOHrVv6vQVS2N77ideJsbW/CLTdW8OQoL2HZqusdvM4mfzp59NMvxgOVOs9vUeA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779261567; c=relaxed/simple;
	bh=DsB1y8zvTzcDbYBkIUfmm86TaPSA3yTGT1BxBy9/rjo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=h+paOKAaoMoMPAdH8q+sWtaruwOJnSECkV1wmlqey1bT9yKyRpKy1gPwnMVv/JMeAr4r6Wxbx9b5F9zECJ8TbDdci3+DXRqM9yMs3+5ZQyHgOClgKe0kphbGkMVU54IyCzicKSCvlbSPyhqBifJ1jawPh1y4FupETFbBUGnzNXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=hygon.cn; spf=fail smtp.mailfrom=hygon.cn; arc=none smtp.client-ip=101.204.27.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=hygon.cn
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hygon.cn
Received: from maildlp1.hygon.cn (unknown [127.0.0.1])
	by mailgw1.hygon.cn (Postfix) with ESMTP id 4gL2w32tVjzTNdP;
	Wed, 20 May 2026 15:18:59 +0800 (CST)
Received: from maildlp1.hygon.cn (unknown [172.23.18.60])
	by mailgw1.hygon.cn (Postfix) with ESMTP id 4gL2w31JxwzTNdP;
	Wed, 20 May 2026 15:18:59 +0800 (CST)
Received: from cncheex04.Hygon.cn (unknown [172.23.18.114])
	by maildlp1.hygon.cn (Postfix) with ESMTPS id B35114B60;
	Wed, 20 May 2026 15:18:53 +0800 (CST)
Received: from [172.19.24.96] (172.19.24.96) by cncheex04.Hygon.cn
 (172.23.18.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Wed, 20 May
 2026 15:18:58 +0800
Message-ID: <d832ba36-4b25-4ce1-a247-2520439f6548@hygon.cn>
Date: Wed, 20 May 2026 15:18:57 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/mlx5: Update mlx5_irq.mask when IRQ affinity changes
To: Tariq Toukan <tariqt@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>, Leon
 Romanovsky <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20260514074208.23353-1-liyi@hygon.cn>
 <99c99bde-9800-4a5e-b8a1-7cc472af52cd@nvidia.com>
From: Yi Li <liyi@hygon.cn>
In-Reply-To: <99c99bde-9800-4a5e-b8a1-7cc472af52cd@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: cncheex06.Hygon.cn (172.23.18.116) To cncheex04.Hygon.cn
 (172.23.18.114)
X-Spamd-Result: default: False [0.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[hygon.cn : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-21025-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	FROM_NEQ_ENVFROM(0.00)[liyi@hygon.cn,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[hygon.cn:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: B3524588D97
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Tariq,

Thanks for the feedback.

On 5/17/2026 4:58 PM, Tariq Toukan wrote:

> 
> Hi,
> 
> Thanks for the patch. Looking at the proposal, I want to discuss two distinct aspects:
> 
> NAPI Execution Location: We already track effective affinity closely through irq_get_effective_affinity_mask(); NAPI processing is dynamically moved accordingly, including a forced NAPI cycle break if needed.
> 

Right. I also see the driver flushes the page_pool alloc cache via page_pool_nid_changed() in mlx5e_post_rx_wqes(),
so RX data buffers follow the NAPI CPU as well.

> Memory Allocation Location: This is the core focus of your patch.
> 

If I understand correctly, the current design keeps the page_pool cache
near the NAPI CPU, and the channel queues near the NIC based on numa-distance.
Please correct me if that's wrong.

> I have serious comments on the proposed implementation, but first I want to discuss the idea.
> 
> We investigated a similar approach a few years ago but ultimately decided against upstreaming it due to stability concerns:
> 
> High Volatility: The "current affinity" value can be extremely dynamic, potentially shifting multiple times per second depending on system load and tuning.
> 
> Performance Risk: Sampling a highly volatile "current" value to allocate relatively permanent resources (like channel queues) risks severe worst-case performance regressions if the affinity shifts immediately after allocation.
> 

I agree with the concern. But page_pool already samples node id change on the hot path.
Sampling affinity only in mlx5e_open_channel() might avoid most of the risk?

> Because of this, we have historically relied on numa-distance logic for channel allocations to ensure a predictable baseline.
> 
> Do you have any benchmark data or specific use cases showing a clear net benefit over the existing numa-distance logic?
> 

Honestly, my Nginx test showed no measurable throughput change.

It's more of a functional issue I ran into. My setup:
  - 6 NUMA nodes, 32 SMT cores each
  - ConnectX-6 on node0
  - node1 and node2 equidistant from node0
  - 63 combined queues
  - default spread: 32 IRQs on node0, 16 on node1, 16 on node2

I moved the 16 IRQs from node2 to node1 via smp_affinity. The IRQs
followed, but the queues stayed on node2, and I observed a lot of
cross-node traffic to/from node2. Nginx wasn't affected -- the
bottleneck is elsewhere in my workload.

Do you think it OK to have an option so users can change queue location?
I'm not sure how common this need is in production, so I'd appreciate your idea.

Also, I agree irq_get_effective_affinity_mask() is better than the IRQ notifier:

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index b6c12460b54a..073239082144 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -2769,6 +2769,7 @@ static int mlx5e_open_channel(struct mlx5e_priv *priv, int ix,
 {
        struct net_device *netdev = priv->netdev;
        struct mlx5e_channel_param *cparam;
+       const struct cpumask *eff_mask;
        struct mlx5_core_dev *mdev;
        struct mlx5e_xsk_param xsk;
        bool async_icosq_needed;
@@ -2786,6 +2787,10 @@ static int mlx5e_open_channel(struct mlx5e_priv *priv, int ix,
        if (err)
                return err;

+       eff_mask = irq_get_effective_affinity_mask(irq);
+       if (eff_mask)
+               cpu = cpumask_first(eff_mask);
+
        err = mlx5e_channel_stats_alloc(priv, ix, cpu);
        if (err)
                return err;


> Best regards,
> Tariq
> 
> 

Thanks,
-Yi



