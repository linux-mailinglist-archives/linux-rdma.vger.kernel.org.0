Return-Path: <linux-rdma+bounces-14813-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7277C9081E
	for <lists+linux-rdma@lfdr.de>; Fri, 28 Nov 2025 02:34:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C51753AB35A
	for <lists+linux-rdma@lfdr.de>; Fri, 28 Nov 2025 01:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 876502441A0;
	Fri, 28 Nov 2025 01:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VEwiibfb"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F33134AB;
	Fri, 28 Nov 2025 01:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764293680; cv=none; b=GK0cZ0+BmyMLi6Lv0GQvhuz/nCW64FNU9Z2fVXCHD2T2VLTh7L2Y2My5i90ZAPwSOKd+de2siiHD5XeYy/1gLB9nsrb+uUX9JE+dOndQSdCxHhxEWREmo+3coIUiUTrQnxqNAn+mH1CWIKvhqpTl97CaImhdU5mI7c6rBArCe+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764293680; c=relaxed/simple;
	bh=JgA3dUU5bdkW4Uf/578Cfr3tUM0xHvNlujR7S0mjVuc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AuCWquHy9mUaX/5Kf/G1CV+SbjzFgf/m/hLUboazCDMNTAplmu4TyofsjrkWTLCa/Hdrgal0Q3ZdQmTHHqeQyN15Wb9UPySlnEftD73xCxxXyPz3528uO3u7bcl3KQd5J2sfbpzGcf7LnsdXUpW4eh49tJs9caeQykyMnziG6FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VEwiibfb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D773AC4CEF8;
	Fri, 28 Nov 2025 01:34:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764293679;
	bh=JgA3dUU5bdkW4Uf/578Cfr3tUM0xHvNlujR7S0mjVuc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VEwiibfbjxj1piMZGm3seruiFG9nisaslxz7zrJkRtWxmklvIy3KZlzlR1GGH9Yo0
	 hjJ5wJZQygNlz6rY6P5/O4CfZJaUb6XCc3C0dwZVlESInRX5EUQrKGIILKceRoxUnm
	 VDNO56KnacQ96OJmbxEyn+YpaxXMmQEkstOEFkgbf8IYV4ydJC+0jx3rk3dAtOJwqk
	 3S+gpK1aRKeKfMQx88WnINn9xLudFR1N6HJgV7S1OfcGKkeFmpu1xdCozswxWMBjG1
	 ba7oQ/jB6N2Ox71K2p3XWZY3oG3084dbmlyFEH9s0nfSsy/Dz7/RHyVfkA2uN+HgaC
	 e0UI7D4cYfncA==
Date: Thu, 27 Nov 2025 17:34:37 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Jian Shen <shenjian15@huawei.com>, Salil Mehta
 <salil.mehta@huawei.com>, Jijie Shao <shaojijie@huawei.com>, Saeed Mahameed
 <saeedm@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Leon Romanovsky
 <leon@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang
 <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-rdma@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Moshe Shemesh
 <moshe@nvidia.com>, Yael Chemla <ychemla@nvidia.com>, Shahar Shitrit
 <shshitrit@nvidia.com>
Subject: Re: [PATCH net-next 1/3] net: Introduce
 netif_xmit_time_out_duration() helper
Message-ID: <20251127173437.479d27fa@kernel.org>
In-Reply-To: <1764054776-1308696-2-git-send-email-tariqt@nvidia.com>
References: <1764054776-1308696-1-git-send-email-tariqt@nvidia.com>
	<1764054776-1308696-2-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 25 Nov 2025 09:12:54 +0200 Tariq Toukan wrote:
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index e808071dbb7d..3cd73769fcfa 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h

include/net/net_queue.h seems like a better place for new code

> @@ -3680,6 +3680,21 @@ static inline bool netif_xmit_stopped(const struct netdev_queue *dev_queue)
>  	return dev_queue->state & QUEUE_STATE_ANY_XOFF;
>  }
>  
> +static inline unsigned int
> +netif_xmit_timeout_ms(struct netdev_queue *txq, unsigned long *trans_start)
> +{
> +	unsigned long txq_trans_start = READ_ONCE(txq->trans_start);
> +
> +	if (trans_start)
> +		*trans_start = txq_trans_start;

The drivers don't really care about this, AFAICT hns3 uses this
to calculate the stall length (return value of this func.

> +	if (netif_xmit_stopped(txq) &&
> +	    time_after(jiffies, txq_trans_start + txq->dev->watchdog_timeo))
> +		return jiffies_to_msecs(jiffies - txq_trans_start);
> +
> +	return 0;
> +}
> +
>  static inline bool
>  netif_xmit_frozen_or_stopped(const struct netdev_queue *dev_queue)
>  {
> diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
> index 852e603c1755..aa6192781a24 100644
> --- a/net/sched/sch_generic.c
> +++ b/net/sched/sch_generic.c
> @@ -523,10 +523,9 @@ static void dev_watchdog(struct timer_list *t)
>  				 * netdev_tx_sent_queue() and netif_tx_stop_queue().
>  				 */
>  				smp_mb();
> -				trans_start = READ_ONCE(txq->trans_start);
> -
> -				if (time_after(jiffies, trans_start + dev->watchdog_timeo)) {
> -					timedout_ms = jiffies_to_msecs(jiffies - trans_start);
> +				timedout_ms = netif_xmit_timeout_ms(txq,
> +								    &trans_start);
> +				if (timedout_ms) {

The use of the new helper in the core feels a bit forced, I'd leave 
the core as is. Otherwise you need the awkward output param, and
core now duplicates the netif_xmit_stopped(txq) check

>  					atomic_long_inc(&txq->trans_timeout);
>  					break;
>  				}

