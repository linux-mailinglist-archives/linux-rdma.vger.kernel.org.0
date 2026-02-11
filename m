Return-Path: <linux-rdma+bounces-16750-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KAQBGYNnjGlWnAAAu9opvQ
	(envelope-from <linux-rdma+bounces-16750-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Feb 2026 12:26:59 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 00108123D8C
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Feb 2026 12:26:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 414FA3016918
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Feb 2026 11:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12E0B36BCE5;
	Wed, 11 Feb 2026 11:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TF7pQqsZ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E9936BCD7
	for <linux-rdma@vger.kernel.org>; Wed, 11 Feb 2026 11:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770809201; cv=none; b=eHGVBGmS4cQsXwK60ZnyiiM7wdL9Aro7M+XliirTlSXZvZDWOPwsf8hrnk/aZ2dg1j8lsTNB5ocV2p8187UZDyRDqyaw3ui9rcXtl4Z6uyCh9fmngTC569kBW8/q5wdFvNlIPb4B4ByjyYeVx9zHUl0jLa9dGNEkhgQEQn3xE88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770809201; c=relaxed/simple;
	bh=I2fcjeu1GcZMjOXO1FlxVpKY1hAZ3hKNIHjeyXL0pBs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZgC/yzNAcLklnhokJfWhoPkNZkh661ypYeF0DhjBh0gvuVf9RUfA2RFq50wSQVxXIRGo3m1Fy9uCLgn/Ud6lfbbTghx4fhpJmFfcySRbigI1lPAOfISqQ8zEXJagnbMIu9YzkfAWF7On+k5PdjQFL1lAXpn1jHaonPwGg+oVkvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TF7pQqsZ; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-4362507f0feso3434643f8f.0
        for <linux-rdma@vger.kernel.org>; Wed, 11 Feb 2026 03:26:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770809199; x=1771413999; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RUMa4wmSAMnFUZfW9TGwqjuVKNetJYo1m0rYO3T+Eb0=;
        b=TF7pQqsZgNOv/OY+D+7vbyucam+ElDCUvIxPls0F3uM1ykKzBHeA5FhZdQqd8slZVH
         jONDIO4ZHtFgrrW4TsyQ4OWmTvJOjO7VYzZvPpM7dr5NdmRvi97GT9TL/e3XBHc8Lptg
         wTusQjucPyKTEp8HIUvKkHIMfoxrAqfTbcRfo5s682s39IzDFWpmerK/2mR6SzOMEKEF
         PZRUPAS6R8ELH48ib0Q/+9aN6v7F1se2chTFAgDH7U1txz6R41u5eqv7gC4haDfEJXb3
         MhlUoWbAJ+gGRXC8pkWJZy1KlawdzGjU+3Z4UrhhOCsd2FXMizPY1bAkt6U+hERZzWNk
         Ywhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770809199; x=1771413999;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RUMa4wmSAMnFUZfW9TGwqjuVKNetJYo1m0rYO3T+Eb0=;
        b=oJXZs4kOge/WuOhH1MQKdNlnp9Y9vhZTEKbvp7WBWXP579teelT8IDLKJ7AOCxE32b
         4z8OWFThzmNEbttzF/sXZBsmt5NYBsFA8Y6JBVkZSmCzP4J3WlTGh2zjiMnWo2QGpRzo
         TWfSsCfZs13i0XUYS3TFCe3nwXms7aqJexbd6XluiouPscnDt5RcfbCA1hiD/9kJyC69
         7iSnU/nfrJ6fYv+IlOiT30Fj2pO4oR3YFRdi2OpuhWp9YbrmKyxwPX4cjhlyitl94+TF
         xuzLXCoy91TYr1rHsvUcuJEQ7VTO3GIxQnobZOFLjTn4QcPiHe7PUKkCcS9qjW4sfTTL
         q68w==
X-Forwarded-Encrypted: i=1; AJvYcCWR/gtdC2N4I16no2UxnJkP9RMiBjUO6N0RDuH+CfXW9MLtPhttzojBx7tvKDDzLhB1qOHo58j9E8Ur@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+ZK6DGZlZjOSTGOxk8jCrac9I2syj4YuIZ5eYte//RjWwZXrx
	JabduIUgLdQgj+IqxlN0EaBITf6+AFeAZ87DLmr0qzfHvZK/yOjESneH
X-Gm-Gg: AZuq6aLXyLMR47Zvg7cPD2jUY8X8RaldV9XkZYNjQkyFGfAn3LFrWqQHP5rIBxTOkYo
	fmbIE7MK9QNEZEP2mU7c4rc8DGPK9XEX1gAbjC0v0mj42xg6yfQvumltsIBGpZuJ87DZEB3d+/x
	uKZ57xNcOhnzm9OmFLCc1ykQoeCDs8LSsufFEbAttE4YEIXeR8xqXXz4puGnPqg6+yqqjUuRgge
	tSF6WQJIItXk53KDthnKNk1aI0CXyVoD502wIzxrEbcCRmHvnBjfe0HGZfvHuxxTWXvSnXYdVNb
	7hdEgSvKwy5Fmv10TbSb7Ahmcf2RnVrBe+/2Nd2v3ow1LDqAedDKn/MD+u5lsD+EcC4gzzoYRpr
	hD4SEvzaHSnZkesZVqepzXUAJ+SZgFW/54luJDHw94kAvKjlpggZwb0Yi3/K8GOnPTPxM92DhcX
	E0mTaaiu6/HffWbctdqQIYEHKFPUjGIn7Z7zzd2fnBg5o=
X-Received: by 2002:a05:6000:4014:b0:435:8f1b:bb32 with SMTP id ffacd0b85a97d-4378458f33amr2790036f8f.32.1770809198440;
        Wed, 11 Feb 2026 03:26:38 -0800 (PST)
Received: from [10.158.36.109] ([72.25.96.17])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43783d50f3asm4152797f8f.13.2026.02.11.03.26.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Feb 2026 03:26:37 -0800 (PST)
Message-ID: <09a77964-37bf-4b3c-bfa9-8939eb7761ab@gmail.com>
Date: Wed, 11 Feb 2026 13:26:35 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/mlx5e: Skip NAPI polling when PCI channel is
 offline
To: Breno Leitao <leitao@debian.org>, Saeed Mahameed <saeedm@nvidia.com>,
 Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Amir Vadai <amirv@mellanox.com>
Cc: netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, dcostantino@meta.com, rneu@meta.com,
 kernel-team@meta.com
References: <20260209-mlx5_iommu-v1-1-b17ae501aeb2@debian.org>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20260209-mlx5_iommu-v1-1-b17ae501aeb2@debian.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16750-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ttoukanlinux@gmail.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 00108123D8C
X-Rspamd-Action: no action



On 09/02/2026 20:01, Breno Leitao wrote:
> When a PCI error (e.g. AER error or DPC containment) marks the PCI
> channel as frozen or permanently failed, the IOMMU mappings for the
> device may already be torn down. If mlx5e_napi_poll() continues
> processing CQEs in this state, every call to dma_unmap_page() triggers
> a WARN_ON in iommu_dma_unmap_phys().
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

Hi,

Thanks for your patch.

You're introducing an interesting problem, but I am not convinced by 
this solution approach.

Why would the driver perform this check if it doesn't guarantee 
prevention of invalid access? It only "allows one napi cycle", which 
happen to be good enough to prevent the soft lockup in your case.

What if a napi cycle is configured with larger budget?

If the problem is that the WARN_ON is being called at a high rate, then 
it should be rate-limited.


