Return-Path: <linux-rdma+bounces-23240-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id s8tYKwD1Vmo1DgEAu9opvQ
	(envelope-from <linux-rdma+bounces-23240-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Jul 2026 04:48:32 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ABA975A24A
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Jul 2026 04:48:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=YDih8ZLW;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-23240-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-23240-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8D77230667FF
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Jul 2026 02:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C71843A9D9B;
	Wed, 15 Jul 2026 02:47:47 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51EA13A9611
	for <linux-rdma@vger.kernel.org>; Wed, 15 Jul 2026 02:47:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784083667; cv=none; b=B+92bfbBImdZ0P/sUGaJb9fMX2LWKSgtD0M+bCQrBLEU61tezwEU3o9ilPlJDWeU5PIpB9xlwvNtZrZ3uIbGdSwcqFJoVOOHPiR7esH7tyJmm0NDOFinz+DY0MUfuD2Or9SCrOWhzoQ5vSiYq6bEbpM6cEdljuJeYv/HxGuiVsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784083667; c=relaxed/simple;
	bh=r44lZeUHewxvqDW9lXHBEcXgXPP/NeNRrM66oxA5yWE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qCyYNqNvfL5x6yjfcse8xULDPx4QcYmkNXOsunjBntVHiXdptK05A1eRa2WM87LXMTrN/5dqcwN2eJlj4NiIkE7ZMDndpJ7gajSYV9OGFKMGE8n0jtBd0LvtG0BhWIXtWMffjnU1czZi8i+jr6aYcHvRZu+pvxhS7XZsNYFOkyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YDih8ZLW; arc=none smtp.client-ip=91.218.175.183
Message-ID: <035a9a88-3cec-419b-a5d9-4ebd2fd19beb@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784083660;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fMTuDt6iGUzcU6ANOBy/vPBRquUxPNdxpEWyqzlg5ak=;
	b=YDih8ZLW6SzNwTnOfWY9CL2E9C0ppOuVXxzpFjGlQ6JjxIkIhXGRWYWRVRv/nUFA79FWCe
	Jd5wb++thp+9/5dolFuQr3KvkkisbtfosWGqm6o7yR6s0p+OfKsimlkN71ABmfT9gsO+On
	GnFYYfwE7UiEp3c3QZBDhECzMmq1E/s=
Date: Tue, 14 Jul 2026 19:47:34 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2] RDMA/rxe: Hold netdev reference for transmit skbs
To: weimin xiong <15927021679@163.com>, linux-rdma@vger.kernel.org,
 "yanjun.zhu@linux.dev" <yanjun.zhu@linux.dev>
Cc: jgg@nvidia.com, xiongweimin <xiongweimin@kylinos.cn>,
 "leon@kernel.org" <leon@kernel.org>
References: <20260713100309.101189-1-15927021679@163.com>
 <20260714015554.174436-1-15927021679@163.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20260714015554.174436-1-15927021679@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:15927021679@163.com,m:linux-rdma@vger.kernel.org,m:yanjun.zhu@linux.dev,m:jgg@nvidia.com,m:xiongweimin@kylinos.cn,m:leon@kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER(0.00)[yanjun.zhu@linux.dev,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[163.com,vger.kernel.org,linux.dev];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-23240-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yanjun.zhu@linux.dev,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:from_mime,linux.dev:dkim,linux.dev:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,kylinos.cn:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9ABA975A24A

在 2026/7/13 18:55, weimin xiong 写道:
> From: xiongweimin <xiongweimin@kylinos.cn>
> 
> rxe_init_packet() assigns skb->dev from an RCU-protected GID attribute
> without holding a netdev reference. If the netdev is unregistered before
> the skb is freed, subsequent accesses to skb->dev are unsafe.
> 
> Hold a reference with dev_hold() when the skb is initialized and release
> it from the transmit destructor or via rxe_put_skb() on error paths that
> run before the destructor is installed.
> 
> To avoid blocking netdev unregistration on held skbs, flush all QPs to
> the error state on NETDEV_GOING_DOWN and NETDEV_UNREGISTER so pending TX
> work is drained and references can be dropped.
> 
> Signed-off-by: xiongweimin <xiongweimin@kylinos.cn>
> ---
>   drivers/infiniband/sw/rxe/rxe_loc.h  |  1 +
>   drivers/infiniband/sw/rxe/rxe_net.c  | 48 ++++++++++++++++++++++++++--
>   drivers/infiniband/sw/rxe/rxe_req.c  |  2 +-
>   drivers/infiniband/sw/rxe/rxe_resp.c |  4 +--
>   4 files changed, 49 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
> index 64d636bf8..7c3cc48e8 100644
> --- a/drivers/infiniband/sw/rxe/rxe_loc.h
> +++ b/drivers/infiniband/sw/rxe/rxe_loc.h
> @@ -92,6 +92,7 @@ void rxe_mw_cleanup(struct rxe_pool_elem *elem);
>   /* rxe_net.c */
>   struct sk_buff *rxe_init_packet(struct rxe_dev *rxe, struct rxe_av *av,
>   				int paylen, struct rxe_pkt_info *pkt);
> +void rxe_put_skb(struct sk_buff *skb);
>   int rxe_prepare(struct rxe_av *av, struct rxe_pkt_info *pkt,
>   		struct sk_buff *skb);
>   int rxe_xmit_packet(struct rxe_qp *qp, struct rxe_pkt_info *pkt,
> diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c
> index 3741b2c4b..44a16cb16 100644
> --- a/drivers/infiniband/sw/rxe/rxe_net.c
> +++ b/drivers/infiniband/sw/rxe/rxe_net.c
> @@ -441,6 +441,22 @@ static void rxe_skb_tx_dtor(struct sk_buff *skb)
>   
>   	rxe_put(qp);
>   	sock_put(skb->sk);
> +	if (skb->dev) {
> +		dev_put(skb->dev);
> +		skb->dev = NULL;
> +	}

Since rdma packets can be routed, during routing, the skb->dev can be 
changed. That is, in the source host, the skb->dev is INT_A. This 
dev_hold works on INT_A. But in the dst host, the skb->dev is INT_B. So 
the dev_put works on INT_B. It is not correct.

Using skb->dev in the TX destructor (rxe_skb_tx_dtor) is fundamentally 
incorrect because skb->dev is not guaranteed to remain unchanged 
throughout the transmit path. When a packet traverses virtual devices 
(e.g. VLAN, bonding, tunnels) or is forwarded through the IP stack, the 
networking core may replace skb->dev with the actual egress device (for 
example, ip_finish_output2() assigns skb->dev = dst->dev).

As a result, the destructor may no longer be operating on the original 
RXE/RoCE device, leading to two serious issues:

Reference count corruption: dev_put(skb->dev) may drop the reference 
count of the new egress device, even though no corresponding dev_hold() 
was performed. This can result in a reference count underflow, 
use-after-free, or even a kernel crash.

Reference leak: The reference acquired for the original RXE/RoCE 
netdevice is never released, leaking the device reference. In practice, 
this can prevent the device from being freed and lead to the familiar 
"waiting for ethX to become free" hang during interface teardown.

Do not rely on skb->dev in the destructor. Instead, preserve the 
original netdevice pointer explicitly (for example, in skb->cb, if 
appropriate) or manage its lifetime through the associated QP/port 
context. The corresponding dev_put() should always be performed on the 
same pointer that was previously passed to dev_hold().

Zhu Yanjun

> +}
> +
> +/*
> + * Free an skb that still holds a netdev reference from rxe_init_packet()
> + * and does not yet have rxe_skb_tx_dtor() installed. Once the TX
> + * destructor is set, callers must use kfree_skb() instead.
> + */
> +void rxe_put_skb(struct sk_buff *skb)
> +{
> +	if (skb->dev)
> +		dev_put(skb->dev);
> +	kfree_skb(skb);
>   }
>   
>   static int rxe_send(struct sk_buff *skb, struct rxe_pkt_info *pkt)
> @@ -529,7 +545,7 @@ int rxe_xmit_packet(struct rxe_qp *qp, struct rxe_pkt_info *pkt,
>   	goto done;
>   
>   drop:
> -	kfree_skb(skb);
> +	rxe_put_skb(skb);
>   	err = 0;
>   done:
>   	return err;
> @@ -574,7 +590,7 @@ struct sk_buff *rxe_init_packet(struct rxe_dev *rxe, struct rxe_av *av,
>   
>   	skb_reserve(skb, hdr_len + LL_RESERVED_SPACE(ndev));
>   
> -	/* FIXME: hold reference to this netdev until life of this skb. */
> +	dev_hold(ndev);
>   	skb->dev	= ndev;
>   	rcu_read_unlock();
>   
> @@ -710,6 +726,28 @@ void rxe_set_port_state(struct rxe_dev *rxe)
>   	dev_put(ndev);
>   }
>   
> +/*
> + * Move all QPs to the error state so pending send/recv work is drained and
> + * in-flight TX skbs (which hold a netdev reference) can be released. Called
> + * from the netdev notifier so unregister cannot stall on held skbs.
> + */
> +static void rxe_flush_qps(struct rxe_dev *rxe)
> +{
> +	struct rxe_pool_elem *elem;
> +	struct rxe_qp *qp;
> +	unsigned long index;
> +
> +	rcu_read_lock();
> +	xa_for_each(&rxe->qp_pool.xa, index, elem) {
> +		if (!elem || !kref_get_unless_zero(&elem->ref_cnt))
> +			continue;
> +		qp = elem->obj;
> +		rxe_qp_error(qp);
> +		rxe_put(qp);
> +	}
> +	rcu_read_unlock();
> +}
> +
>   static int rxe_notify(struct notifier_block *not_blk,
>   		      unsigned long event,
>   		      void *arg)
> @@ -721,7 +759,12 @@ static int rxe_notify(struct notifier_block *not_blk,
>   		return NOTIFY_OK;
>   
>   	switch (event) {
> +	case NETDEV_GOING_DOWN:
> +		/* Start draining TX queues before the netdev disappears. */
> +		rxe_flush_qps(rxe);
> +		break;
>   	case NETDEV_UNREGISTER:
> +		rxe_flush_qps(rxe);
>   		ib_unregister_device_queued(&rxe->ib_dev);
>   		rxe_net_del(&rxe->ib_dev);
>   		break;
> @@ -735,7 +778,6 @@ static int rxe_notify(struct notifier_block *not_blk,
>   			rxe_counter_inc(rxe, RXE_CNT_LINK_DOWNED);
>   		break;
>   	case NETDEV_REBOOT:
> -	case NETDEV_GOING_DOWN:
>   	case NETDEV_CHANGEADDR:
>   	case NETDEV_CHANGENAME:
>   	case NETDEV_FEAT_CHANGE:
> diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
> index 12d03f390..927ef68de 100644
> --- a/drivers/infiniband/sw/rxe/rxe_req.c
> +++ b/drivers/infiniband/sw/rxe/rxe_req.c
> @@ -796,7 +796,7 @@ int rxe_requester(struct rxe_qp *qp)
>   			wqe->status = IB_WC_LOC_PROT_ERR;
>   		else
>   			wqe->status = IB_WC_LOC_QP_OP_ERR;
> -		kfree_skb(skb);
> +		rxe_put_skb(skb);
>   		if (ah)
>   			rxe_put(ah);
>   		goto err;
> diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
> index d8cbdfa70..ee3630e4b 100644
> --- a/drivers/infiniband/sw/rxe/rxe_resp.c
> +++ b/drivers/infiniband/sw/rxe/rxe_resp.c
> @@ -866,7 +866,7 @@ static struct sk_buff *prepare_ack_packet(struct rxe_qp *qp,
>   
>   	err = rxe_prepare(&qp->pri_av, ack, skb);
>   	if (err) {
> -		kfree_skb(skb);
> +		rxe_put_skb(skb);
>   		return NULL;
>   	}
>   
> @@ -994,7 +994,7 @@ static enum resp_states read_reply(struct rxe_qp *qp,
>   	err = rxe_mr_copy(mr, res->read.va, payload_addr(&ack_pkt),
>   			  payload, RXE_FROM_MR_OBJ);
>   	if (err) {
> -		kfree_skb(skb);
> +		rxe_put_skb(skb);
>   		state = RESPST_ERR_RKEY_VIOLATION;
>   		goto err_out;
>   	}


