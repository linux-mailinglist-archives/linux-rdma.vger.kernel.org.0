Return-Path: <linux-rdma+bounces-16694-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qPWfEs+VimnjMAAAu9opvQ
	(envelope-from <linux-rdma+bounces-16694-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Feb 2026 03:19:59 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E161111642C
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Feb 2026 03:19:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A1614302DB77
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Feb 2026 02:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBF902D877E;
	Tue, 10 Feb 2026 02:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="S44+kLpJ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9213275112;
	Tue, 10 Feb 2026 02:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770689993; cv=none; b=tZ+nO7Q+bzgMOCHR3wL28GBxOqip8rEL24+2nFmNk7hHqf1gTfP6O+kaVEbY78NEC4SjuhGY30SGMJMz6tQY+K0IHYmoD/gWWe3NJUm2X+pKmL+57sRRHU+x4TYgdgC+6l5zFgQbIEcjUhs+BfELQmVTkryV6NzxNs1OC4gG6zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770689993; c=relaxed/simple;
	bh=MG8jvzZf/kzglYRZMkv6gbzkxD7FW8wmHIBPZCNHuM4=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=AeVJ32hHfk+uhDMioAtwuZ82LtWXoKs16TZicsQfieNz30Rf7l9jjk5FCcppvpThDJO45q5e7f+i/KtDiYdQOJBhYdJW1S/dtbkWCxkj50ik3z4223KTpMUykthni0OKuRcJ8QsivHZY8rmbSYy8w0U5UEjH0BS6JMqaxIffnto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=S44+kLpJ; arc=none smtp.client-ip=113.46.200.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=uecur6houava9Fdo15L338waubBYoJUZ+/hRmaHFZEI=;
	b=S44+kLpJTpkr731oWQk+wroAkLZwJDiU4j59tMy0cWytiRFKVb299lo83Zp9BrlxDhRV2fkLB
	cst9J6FK07pNOPtazds3xmNtX9howq8DoFns31ByZk28jrLbqUPGW2GYdTze6qGQ9H+xuEAPuQq
	LcD4CBgy0Ql5xDM/oosfc3E=
Received: from mail.maildlp.com (unknown [172.19.162.140])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4f94sC1cKBzRhQm;
	Tue, 10 Feb 2026 10:15:11 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 3CD292012A;
	Tue, 10 Feb 2026 10:19:48 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 10 Feb 2026 10:19:47 +0800
Message-ID: <49fe0af5-7dcf-42e0-bd73-0bd42c067d26@huawei.com>
Date: Tue, 10 Feb 2026 10:19:46 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<dcostantino@meta.com>, <rneu@meta.com>, <kernel-team@meta.com>
Subject: Re: [PATCH net] net/mlx5e: Skip NAPI polling when PCI channel is
 offline
To: Breno Leitao <leitao@debian.org>, Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Leon
 Romanovsky <leon@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Amir Vadai
	<amirv@mellanox.com>
References: <20260209-mlx5_iommu-v1-1-b17ae501aeb2@debian.org>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <20260209-mlx5_iommu-v1-1-b17ae501aeb2@debian.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemk100013.china.huawei.com (7.202.194.61)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	TAGGED_FROM(0.00)[bounces-16694-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shaojijie@huawei.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[huawei.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,huawei.com:mid,huawei.com:dkim]
X-Rspamd-Queue-Id: E161111642C
X-Rspamd-Action: no action


on 2026/2/10 2:01, Breno Leitao wrote:
> When a PCI error (e.g. AER error or DPC containment) marks the PCI
> channel as frozen or permanently failed, the IOMMU mappings for the
> device may already be torn down. If mlx5e_napi_poll() continues
> processing CQEs in this state, every call to dma_unmap_page() triggers
> a WARN_ON in iommu_dma_unmap_phys().

Hi:
   My comment has nothing to do with the changes made in this patch itself.


I am more interested in this error itself.
1. If there is an issue with dma_unmp, does dma_map in tx have a similar problem?
2. Can this error be detected by mlx5_pci_err_detected()? If not, does this mean that all PCIe NIC drivers might have similar issues?
    Do other drivers need to do similar checks?

Thanks,
Jijie Shao

>
> In a real-world crash scenario on an NVIDIA Grace (ARM64) platform,
> a DPC event froze the PCI channel and the mlx5 NAPI poll continued
> processing error CQEs, calling dma_unmap for each pending WQE. Here is
> an example:
>
> The DPC event on port 0007:00:00.0 fires and eth1 (on 0017:01:00.0) starts
> seeing error CQEs almost immediately:
>
>      pcieport 0007:00:00.0: DPC: containment event, status:0x2009
>      mlx5_core 0017:01:00.0 eth1: Error cqe on cqn 0x54e, ci 0xb06, ...
>
> The WARN_ON storm begins ~0.4s later and repeats for every pending WQE:
>
>      WARNING: CPU: 32 PID: 0 at drivers/iommu/dma-iommu.c:1237 iommu_dma_unmap_phys
>      Call trace:
>       iommu_dma_unmap_phys+0xd4/0xe0
>       mlx5e_tx_wi_dma_unmap+0xb4/0xf0
>       mlx5e_poll_tx_cq+0x14c/0x438
>       mlx5e_napi_poll+0x6c/0x5e0
>       net_rx_action+0x160/0x5c0
>       handle_softirqs+0xe8/0x320
>       run_ksoftirqd+0x30/0x58
>
> After 23 seconds of WARN_ON() storm, the watchdog fires:
>
>      watchdog: BUG: soft lockup - CPU#32 stuck for 23s! [ksoftirqd/32:179]
>      Kernel panic - not syncing: softlockup: hung tasks
>
> Each unmap hit the WARN_ON in the IOMMU layer, printing a full stack
> trace. With dozens of pending WQEs, this created a storm of WARN_ON
> dumps in softirq context that monopolized the CPU for over 23 seconds,
> triggering a soft lockup panic.
>
> Fix this by checking pci_channel_offline() at the top of
> mlx5e_napi_poll() and bailing out immediately when the channel is
> offline. napi_complete_done() is called before returning to clear the
> NAPI_STATE_SCHED bit, ensuring that napi_disable() in the teardown path
> does not spin forever waiting for it. No CQ interrupts are re-armed
> since the explicit mlx5e_cq_arm() calls are skipped, so the NAPI
> instance will not be re-scheduled. The pending DMA buffers are left for
> device removal to clean up.
>
> Fixes: e586b3b0baee ("net/mlx5: Ethernet Datapath files")
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>   drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
>
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c
> index 76108299ea57d..934ad7fafa801 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c
> @@ -138,6 +138,19 @@ int mlx5e_napi_poll(struct napi_struct *napi, int budget)
>   	bool xsk_open;
>   	int i;
>   
> +	/*
> +	 * When the PCI channel is offline, IOMMU mappings may already be torn
> +	 * down.  Processing CQEs would call dma_unmap for every pending WQE,
> +	 * each hitting a WARN_ON in the IOMMU layer.  The resulting storm of
> +	 * warnings in softirq context can monopolise the CPU long enough to
> +	 * trigger a soft lockup and prevent any RCU grace period from
> +	 * completing.
> +	 */
> +	if (unlikely(pci_channel_offline(c->mdev->pdev))) {
> +		napi_complete_done(napi, 0);
> +		return 0;
> +	}
> +
>   	rcu_read_lock();
>   
>   	qos_sqs = rcu_dereference(c->qos_sqs);
>
> ---
> base-commit: a956792a1543c2bf4a2266cb818dc7c4135006f0
> change-id: 20260209-mlx5_iommu-c8b238b1bb14
>
> Best regards,
> --
> Breno Leitao <leitao@debian.org>
>
>

