Return-Path: <linux-rdma+bounces-19221-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qHKOFWN82WmJqAgAu9opvQ
	(envelope-from <linux-rdma+bounces-19221-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 11 Apr 2026 00:40:35 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AC0473DD476
	for <lists+linux-rdma@lfdr.de>; Sat, 11 Apr 2026 00:40:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9D5A6301A725
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Apr 2026 22:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BECD3DEFE2;
	Fri, 10 Apr 2026 22:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wi/p5+3W"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 166373E0237
	for <linux-rdma@vger.kernel.org>; Fri, 10 Apr 2026 22:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775860652; cv=none; b=kyvlUPHnwY9aeAI+H1x3SUvvL2uynirpSoOhc67fWVRZUcPSdMTCr3KVhXCPNlmqSVqZ9rDdDEZREVuQXi3nQLMt6JnEGlgVwPNuxFbcAxAmLjue8sbAFIowXE0xbp3m64rjTZY/bGf1NFqLoqmjKB7fJMVmYa1oq2r0Pj9dix0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775860652; c=relaxed/simple;
	bh=qgsrtqUov5rsHtiTXc3lRid9ByZ5Ht45ocdPgaxU0f8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D+dv4M7sHPlAgS0+TPJGQ6+73ukfsNWX2rE3GwnvwI5KmQ0UosUM7UqP2Oo47Ikq3bSweN2b+1N1kUpNgVK5szyuZRw2bac+M4QWjw1NJQEDTdcJnAoVZ2vGchhNmVVrv9iWIxRJW79XtCzZ+BnXSCZ9zCv9gJRs2MmNXXGFLzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wi/p5+3W; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <090caa77-f1ca-4854-9975-87b9e4f2bf74@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775860639;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hAwfcYXNXSZsXqiGuiWdDazTY4DTbiaWIUs7rzwgVs8=;
	b=wi/p5+3W3UzX+5OhxKv1b3skKz9mfXyXBTLsBBLddc4OKXm3C2FKa+n0Uj7+SxV3HtK9EE
	m45C07k3m8fxDpOKURLrDdHdQiK4cN+V1CQBQoL5VBwkhJ7HGFTGfhVFqcvOykSW8W3hiL
	C5U0UwxtxusfPHw0USpK9Q6Ndv+Qjxg=
Date: Fri, 10 Apr 2026 15:37:09 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v5 2/3] RDMA/rxe: add SENT/RCVD bytes
To: zhenwei pi <zhenwei.pi@linux.dev>, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org, Zhu Yanjun <yanjun.zhu@linux.dev>
Cc: zyjzyj2000@gmail.com, jgg@ziepe.ca, leon@kernel.org
References: <20260408000956.486522-1-zhenwei.pi@linux.dev>
 <20260408000956.486522-3-zhenwei.pi@linux.dev>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "yanjun.zhu" <yanjun.zhu@linux.dev>
In-Reply-To: <20260408000956.486522-3-zhenwei.pi@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,ziepe.ca,kernel.org];
	TAGGED_FROM(0.00)[bounces-19221-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yanjun.zhu@linux.dev,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:dkim,linux.dev:email,linux.dev:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AC0473DD476
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/7/26 5:09 PM, zhenwei pi wrote:
> There is a lack of sent/received counter in bytes.
> 
> Signed-off-by: zhenwei pi <zhenwei.pi@linux.dev>
> ---
>   drivers/infiniband/sw/rxe/rxe_hw_counters.c | 2 ++
>   drivers/infiniband/sw/rxe/rxe_hw_counters.h | 2 ++
>   drivers/infiniband/sw/rxe/rxe_net.c         | 2 ++
>   drivers/infiniband/sw/rxe/rxe_recv.c        | 2 ++
>   drivers/infiniband/sw/rxe/rxe_verbs.h       | 6 ++++++
>   5 files changed, 14 insertions(+)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_hw_counters.c b/drivers/infiniband/sw/rxe/rxe_hw_counters.c
> index 437917a7d8f2..17edaa9a9b9b 100644
> --- a/drivers/infiniband/sw/rxe/rxe_hw_counters.c
> +++ b/drivers/infiniband/sw/rxe/rxe_hw_counters.c
> @@ -22,6 +22,8 @@ static const struct rdma_stat_desc rxe_counter_descs[] = {
>   	[RXE_CNT_LINK_DOWNED].name         =  "link_downed",
>   	[RXE_CNT_RDMA_SEND].name           =  "rdma_sends",
>   	[RXE_CNT_RDMA_RECV].name           =  "rdma_recvs",
> +	[RXE_CNT_SENT_BYTES].name          =  "sent_bytes",
> +	[RXE_CNT_RCVD_BYTES].name          =  "rcvd_bytes",
>   };
>   
>   int rxe_ib_get_hw_stats(struct ib_device *ibdev,
> diff --git a/drivers/infiniband/sw/rxe/rxe_hw_counters.h b/drivers/infiniband/sw/rxe/rxe_hw_counters.h
> index 051f9e1c3852..01b355103cbc 100644
> --- a/drivers/infiniband/sw/rxe/rxe_hw_counters.h
> +++ b/drivers/infiniband/sw/rxe/rxe_hw_counters.h
> @@ -26,6 +26,8 @@ enum rxe_counters {
>   	RXE_CNT_LINK_DOWNED,
>   	RXE_CNT_RDMA_SEND,
>   	RXE_CNT_RDMA_RECV,
> +	RXE_CNT_SENT_BYTES,
> +	RXE_CNT_RCVD_BYTES,
>   	RXE_NUM_OF_COUNTERS
>   };
>   
> diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c
> index 6621d01ac32d..86660031ffa2 100644
> --- a/drivers/infiniband/sw/rxe/rxe_net.c
> +++ b/drivers/infiniband/sw/rxe/rxe_net.c
> @@ -503,6 +503,7 @@ int rxe_xmit_packet(struct rxe_qp *qp, struct rxe_pkt_info *pkt,
>   	int err;
>   	int is_request = pkt->mask & RXE_REQ_MASK;
>   	struct rxe_dev *rxe = to_rdev(qp->ibqp.device);
> +	unsigned int skblen = skb->len;
>   	unsigned long flags;
>   
>   	spin_lock_irqsave(&qp->state_lock, flags);
> @@ -526,6 +527,7 @@ int rxe_xmit_packet(struct rxe_qp *qp, struct rxe_pkt_info *pkt,
>   	}
>   
>   	rxe_counter_inc(rxe, RXE_CNT_SENT_PKTS);
> +	rxe_counter_add(rxe, RXE_CNT_SENT_BYTES, skblen);
>   	goto done;
>   
>   drop:
> diff --git a/drivers/infiniband/sw/rxe/rxe_recv.c b/drivers/infiniband/sw/rxe/rxe_recv.c
> index 5861e4244049..e7bab89e7d8d 100644
> --- a/drivers/infiniband/sw/rxe/rxe_recv.c
> +++ b/drivers/infiniband/sw/rxe/rxe_recv.c
> @@ -318,6 +318,7 @@ void rxe_rcv(struct sk_buff *skb)
>   	int err;
>   	struct rxe_pkt_info *pkt = SKB_TO_PKT(skb);
>   	struct rxe_dev *rxe = pkt->rxe;
> +	unsigned int skblen = skb->len - skb_network_offset(skb);
>   
>   	if (unlikely(skb->len < RXE_BTH_BYTES))
>   		goto drop;
> @@ -341,6 +342,7 @@ void rxe_rcv(struct sk_buff *skb)
>   	if (unlikely(err))
>   		goto drop;
>   
> +	rxe_counter_add(rxe, RXE_CNT_RCVD_BYTES, skblen);
>   	rxe_counter_inc(rxe, RXE_CNT_RCVD_PKTS);
>   
>   	if (unlikely(bth_qpn(pkt) == IB_MULTICAST_QPN))

int rxe_xmit_packet(struct rxe_qp *qp, struct rxe_pkt_info *pkt,
                     struct sk_buff *skb)
{
         int err;
         int is_request = pkt->mask & RXE_REQ_MASK;
         struct rxe_dev *rxe = to_rdev(qp->ibqp.device);
         unsigned long flags;

skb->len is printed here, that is len1
...
         if (pkt->mask & RXE_LOOPBACK_MASK)
                 err = rxe_loopback(skb, pkt);
         else
                 err = rxe_send(skb, pkt);
...
}

In the following function

static int rxe_loopback(struct sk_buff *skb, struct rxe_pkt_info *pkt)
{
...
         if (skb->protocol == htons(ETH_P_IP))
                 skb_pull(skb, sizeof(struct iphdr));
         else
                 skb_pull(skb, sizeof(struct ipv6hdr));

...
         /* remove udp header */
         skb_pull(skb, sizeof(struct udphdr));

print skb->len here, that is len2

         rxe_rcv(skb);

...
}

Does len1 equal to len2?

If not, the transmitted length appears to differ from the received 
length when using loopback.

I am not sure whether this is expected behavior.

The same observation also applies to the non-loopback case.

Zhu Yanjun

> diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
> index e800545d1046..0f5ffd94643f 100644
> --- a/drivers/infiniband/sw/rxe/rxe_verbs.h
> +++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
> @@ -455,6 +455,12 @@ static inline void rxe_counter_inc(struct rxe_dev *rxe, enum rxe_counters index)
>   	atomic64_inc(&rxe->stats_counters[index]);
>   }
>   
> +static inline void rxe_counter_add(struct rxe_dev *rxe, enum rxe_counters index,
> +				   s64 val)
> +{
> +	atomic64_add(val, &rxe->stats_counters[index]);
> +}
> +
>   static inline struct rxe_dev *to_rdev(struct ib_device *dev)
>   {
>   	return dev ? container_of(dev, struct rxe_dev, ib_dev) : NULL;


