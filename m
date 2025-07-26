Return-Path: <linux-rdma+bounces-12489-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67389B128EA
	for <lists+linux-rdma@lfdr.de>; Sat, 26 Jul 2025 06:13:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BAE01C21227
	for <lists+linux-rdma@lfdr.de>; Sat, 26 Jul 2025 04:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F32D81EBFFF;
	Sat, 26 Jul 2025 04:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OaWJ5mRt"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E76481DD
	for <linux-rdma@vger.kernel.org>; Sat, 26 Jul 2025 04:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753503223; cv=none; b=pbubpfZGlYli/x1J5eOQS15z1fTMFXEH66nPz54Qf6GEU0Ii8sfWXdtxYh0jUHeH8ryYEjbv5Akzbm/Q7EPhrzG4DcmqbAccZYeVU/5QbMdKJJgkDNLu78edUgD70HdD3c1F0QOmZ6LYikM9eXlnQI3zXhk9dLJ1fWhAthCD2zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753503223; c=relaxed/simple;
	bh=aEJhzudH3UhCt9XUnp8NMv9loRpM6529z1ht7LG7KDM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hpyTEXd3iYlWz1U+N+pNlWqBWT6eCvcFd0UfJ3l1CyolEFUfvzfjeVvDWW8ibNPw81dzTKm4wYLXgjIXkZNQcPics0syL/YfiMUaN0nqYMXvgzHv1WwtapSlFCGmd52HOoCeD4rF2Hw4Jd27aLyAGV5D6kmEwN5EJvgvkejWI7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OaWJ5mRt; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <a1667c20-bfd7-445b-9417-495db57123ee@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753503218;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2s5kxGD/aMTbDQt47ELyao5ALb4mcEY3buIsfxrRByY=;
	b=OaWJ5mRtMX6s/acxZyoj/dGBDCdph2yhMXTM0pf4FjL5WpwfBfD3zGl02Z4y5AnT6KzW3B
	bNu6oYWsCJBjo8kdpEvzD8VjPfRT83DoOgR6cCft68WIDm2qm3Drn87Kd7VE/TscGYY/dT
	uBCvHQI3WV1O2kPP+Vcp1r5N9SweYN8=
Date: Fri, 25 Jul 2025 21:13:20 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH rdma-next 1/1] RDMA/rxe: Fix rxe_skb_tx_dtor problem
To: zyjzyj2000@gmail.com, jgg@ziepe.ca, leon@kernel.org,
 linux-rdma@vger.kernel.org
Cc: syzbot+8425ccfb599521edb153@syzkaller.appspotmail.com
References: <20250726013104.463570-1-yanjun.zhu@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20250726013104.463570-1-yanjun.zhu@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2025/7/25 18:31, Zhu Yanjun 写道:
> When skb packets are sent out, these skb packets still depends on
> the rxe resources, for example, QP, sk, when these packets are
> destroyed.
> 
> If these rxe resources are released when the skb packets are destroyed,
> the call traces will appear.
> 
> To avoid skb packets hang too long time in some network devices,
> a timestamp is added when these skb packets are created. If these
> skb packets hang too long time in network devices, these network
> devices can free these skb packets to release rxe resources.
> 
> Reported-by: syzbot+8425ccfb599521edb153@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=8425ccfb599521edb153
> Tested-by: syzbot+8425ccfb599521edb153@syzkaller.appspotmail.com

In this link 
https://lore.kernel.org/all/c15f999a-7fe1-463a-b9e2-ef145c3afe81@linux.dev/T/#m06e38003c5aa1833e2b24391cef807ae88104cf4,

syzbot confirmed that this commit can fix this problem.

Best Regards,
Zhu Yanjun

> Fixes: 1a633bdc8fd9 ("RDMA/rxe: Let destroy qp succeed with stuck packet")
> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> ---
>   drivers/infiniband/sw/rxe/rxe_net.c | 29 ++++++++---------------------
>   drivers/infiniband/sw/rxe/rxe_qp.c  |  2 +-
>   2 files changed, 9 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c
> index 132a87e52d5c..ac0183a2ff7a 100644
> --- a/drivers/infiniband/sw/rxe/rxe_net.c
> +++ b/drivers/infiniband/sw/rxe/rxe_net.c
> @@ -345,33 +345,15 @@ int rxe_prepare(struct rxe_av *av, struct rxe_pkt_info *pkt,
>   
>   static void rxe_skb_tx_dtor(struct sk_buff *skb)
>   {
> -	struct net_device *ndev = skb->dev;
> -	struct rxe_dev *rxe;
> -	unsigned int qp_index;
> -	struct rxe_qp *qp;
> +	struct rxe_qp *qp = skb->sk->sk_user_data;
>   	int skb_out;
>   
> -	rxe = rxe_get_dev_from_net(ndev);
> -	if (!rxe && is_vlan_dev(ndev))
> -		rxe = rxe_get_dev_from_net(vlan_dev_real_dev(ndev));
> -	if (WARN_ON(!rxe))
> -		return;
> -
> -	qp_index = (int)(uintptr_t)skb->sk->sk_user_data;
> -	if (!qp_index)
> -		return;
> -
> -	qp = rxe_pool_get_index(&rxe->qp_pool, qp_index);
> -	if (!qp)
> -		goto put_dev;
> -
>   	skb_out = atomic_dec_return(&qp->skb_out);
> -	if (qp->need_req_skb && skb_out < RXE_INFLIGHT_SKBS_PER_QP_LOW)
> +	if (unlikely(qp->need_req_skb &&
> +		skb_out < RXE_INFLIGHT_SKBS_PER_QP_LOW))
>   		rxe_sched_task(&qp->send_task);
>   
>   	rxe_put(qp);
> -put_dev:
> -	ib_device_put(&rxe->ib_dev);
>   	sock_put(skb->sk);
>   }
>   
> @@ -383,6 +365,7 @@ static int rxe_send(struct sk_buff *skb, struct rxe_pkt_info *pkt)
>   	sock_hold(sk);
>   	skb->sk = sk;
>   	skb->destructor = rxe_skb_tx_dtor;
> +	rxe_get(pkt->qp);
>   	atomic_inc(&pkt->qp->skb_out);
>   
>   	if (skb->protocol == htons(ETH_P_IP))
> @@ -405,6 +388,7 @@ static int rxe_loopback(struct sk_buff *skb, struct rxe_pkt_info *pkt)
>   	sock_hold(sk);
>   	skb->sk = sk;
>   	skb->destructor = rxe_skb_tx_dtor;
> +	rxe_get(pkt->qp);
>   	atomic_inc(&pkt->qp->skb_out);
>   
>   	if (skb->protocol == htons(ETH_P_IP))
> @@ -497,6 +481,9 @@ struct sk_buff *rxe_init_packet(struct rxe_dev *rxe, struct rxe_av *av,
>   		goto out;
>   	}
>   
> +	/* Add time stamp to skb. */
> +	skb->tstamp = ktime_get();
> +
>   	skb_reserve(skb, hdr_len + LL_RESERVED_SPACE(ndev));
>   
>   	/* FIXME: hold reference to this netdev until life of this skb. */
> diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/rxe/rxe_qp.c
> index f2af3e0aef35..95f1c1c2949d 100644
> --- a/drivers/infiniband/sw/rxe/rxe_qp.c
> +++ b/drivers/infiniband/sw/rxe/rxe_qp.c
> @@ -244,7 +244,7 @@ static int rxe_qp_init_req(struct rxe_dev *rxe, struct rxe_qp *qp,
>   	err = sock_create_kern(&init_net, AF_INET, SOCK_DGRAM, 0, &qp->sk);
>   	if (err < 0)
>   		return err;
> -	qp->sk->sk->sk_user_data = (void *)(uintptr_t)qp->elem.index;
> +	qp->sk->sk->sk_user_data = qp;
>   
>   	/* pick a source UDP port number for this QP based on
>   	 * the source QPN. this spreads traffic for different QPs


