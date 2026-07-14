Return-Path: <linux-rdma+bounces-23164-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id PWq5JZ18VWqTpAAAu9opvQ
	(envelope-from <linux-rdma+bounces-23164-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Jul 2026 02:02:37 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 84CCF74FD17
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Jul 2026 02:02:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=Sv8tNbtL;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-23164-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-23164-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8C9CD3007A7D
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Jul 2026 00:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B54571A267;
	Tue, 14 Jul 2026 00:02:31 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A733C1F
	for <linux-rdma@vger.kernel.org>; Tue, 14 Jul 2026 00:02:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783987351; cv=none; b=H0emTXo7cVv0XBOA463L4YsS3UIGJu7COzUL8jPiaglbqgN9ykw7PzRDfRVWaDZmV3ro/zsL8cUgrAvWXsKyhRiWU8yuJ6yrJhKCjLEtLOtkMZoEUY5Tv3jM+uVebRVkKTwIDdqquq1TfdsjycGK+e6TizmGyRTu6hSiEKpUuOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783987351; c=relaxed/simple;
	bh=1L8JvVBzBcyG9MQvJzL+wcsa7rg68SqvwvMSctPvYKw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=emicKYElQAAJ4h38MQnLjBqqVNtB6/NnkOooEUk6JiHtWHKINDxr6qZDzoL8FIg1sVvqI37HMra57d5ysbog/W+ZEtBTBsUYPwtvg5CLYlaDRB6BE8JkZGoDce7uLbL3TBCc+y5ffX31+X9qKUFfm0g2WD9HozfXyOZRiQigwrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Sv8tNbtL; arc=none smtp.client-ip=95.215.58.172
Message-ID: <c7cc0866-9d54-4909-9d22-7b6ddfb9096e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783987348;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P3CGYX08Omc664kPgRVv3mK6pSM33sl7uf5FOrhMCFg=;
	b=Sv8tNbtLYpD/qROQTE5r3YaV1iO4teHKk8o49SGUkU65k5NbmBSclAF04A6JGONr8remLI
	VIQRgDXFLVivqBGM4p971Lvaz4Oacg3RActCn0UQqmtZXXct/WwJSuUxJelKeKswp69DmX
	ENDCGf3sPZvEIHd5r3SXoSuBJjj097U=
Date: Mon, 13 Jul 2026 17:02:23 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] RDMA/rxe: Hold netdev reference for transmit skbs
To: weimin xiong <15927021679@163.com>, linux-rdma@vger.kernel.org,
 "yanjun.zhu@linux.dev" <yanjun.zhu@linux.dev>
Cc: jgg@nvidia.com, xiongweimin <xiongweimin@kylinos.cn>
References: <20260713100309.101189-1-15927021679@163.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20260713100309.101189-1-15927021679@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:15927021679@163.com,m:linux-rdma@vger.kernel.org,m:yanjun.zhu@linux.dev,m:jgg@nvidia.com,m:xiongweimin@kylinos.cn,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER(0.00)[yanjun.zhu@linux.dev,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[163.com,vger.kernel.org,linux.dev];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-23164-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yanjun.zhu@linux.dev,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linux.dev:from_mime,linux.dev:dkim,linux.dev:mid,vger.kernel.org:from_smtp,nvidia.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 84CCF74FD17

在 2026/7/13 3:03, weimin xiong 写道:
> From: xiongweimin <xiongweimin@kylinos.cn>
> 
> rxe_init_packet() assigns skb->dev from an RCU-protected GID attribute
> without holding a netdev reference. If the netdev is unregistered before
> the skb is freed, subsequent accesses to skb->dev are unsafe.
> 
> Hold a reference with dev_hold() when the skb is initialized and release
> it from the transmit destructor or via rxe_put_skb() on error paths.
> 
> Signed-off-by: xiongweimin <xiongweimin@kylinos.cn>

This commit can not be applied in linux kernel upstream cleanly.

The logic of holding a netdev reference to guarantee memory safety 
(preventing Use-After-Free) is correct. But, this introduces the classic 
risk of blocking netdev unregistration if an skb is leaked or held 
indefinitely.

To mitigate this and ensure clean netdev unregistration:
Ensure the driver properly handles `NETDEV_UNREGISTER` notifications by 
immediately flushing all QPs/TX queues to release pending skbs under 
unregistration events.

So please modify this commit to apply this commit on linux upstream.

Zhu Yanjun

> Cc: linux-rdma@vger.kernel.org
> Cc: Jason Gunthorpe <jgg@nvidia.com>
> ---
> 
> --- a/drivers/infiniband/sw/rxe/rxe_loc.h
> +++ b/drivers/infiniband/sw/rxe/rxe_loc.h
> @@ -95,6 +95,7 @@ void rxe_mw_cleanup(struct rxe_pool_elem *elem);
>   /* rxe_net.c */
>   struct sk_buff *rxe_init_packet(struct rxe_dev *rxe, struct rxe_av *av,
>   				int paylen, struct rxe_pkt_info *pkt);
> +void rxe_put_skb(struct sk_buff *skb);
>   int rxe_prepare(struct rxe_av *av, struct rxe_pkt_info *pkt,
>   		struct sk_buff *skb);
>   int rxe_xmit_packet(struct rxe_qp *qp, struct rxe_pkt_info *pkt,
> --- a/drivers/infiniband/sw/rxe/rxe_net.c
> +++ b/drivers/infiniband/sw/rxe/rxe_net.c
> @@ -355,6 +355,16 @@ static void rxe_skb_tx_dtor(struct sk_buff *skb)
>   
>   	rxe_put(qp);
>   	sock_put(skb->sk);
> +	if (skb->dev) {
> +		dev_put(skb->dev);
> +		skb->dev = NULL;
> +	}
> +}
> +
> +void rxe_put_skb(struct sk_buff *skb)
> +{
> +	if (skb->dev)
> +		dev_put(skb->dev);
> +	kfree_skb(skb);
>   }
>   
>   static int rxe_send(struct sk_buff *skb, struct rxe_pkt_info *pkt)
> @@ -441,7 +451,7 @@ int rxe_xmit_packet(struct rxe_qp *qp, struct rxe_pkt_info *pkt,
>   	goto done;
>   
>   drop:
> -	kfree_skb(skb);
> +	rxe_put_skb(skb);
>   	err = 0;
>   done:
>   	return err;
> @@ -486,8 +496,8 @@ struct sk_buff *rxe_init_packet(struct rxe_dev *rxe, struct rxe_av *av,
>   
>   	skb_reserve(skb, hdr_len + LL_RESERVED_SPACE(ndev));
>   
> -	/* FIXME: hold reference to this netdev until life of this skb. */
> +	dev_hold(ndev);
>   	skb->dev	= ndev;
>   	rcu_read_unlock();
>   
> --- a/drivers/infiniband/sw/rxe/rxe_req.c
> +++ b/drivers/infiniband/sw/rxe/rxe_req.c
> @@ -793,7 +793,7 @@ next_wqe:
>   			wqe->status = IB_WC_LOC_PROT_ERR;
>   		else
>   			wqe->status = IB_WC_LOC_QP_OP_ERR;
> -		kfree_skb(skb);
> +		rxe_put_skb(skb);
>   		if (ah)
>   			rxe_put(ah);
>   		goto err;
> --- a/drivers/infiniband/sw/rxe/rxe_resp.c
> +++ b/drivers/infiniband/sw/rxe/rxe_resp.c
> @@ -817,7 +817,7 @@ static struct sk_buff *copy_data(struct rxe_qp *qp,
>   
>   	err = rxe_prepare(&qp->pri_av, ack, skb);
>   	if (err) {
> -		kfree_skb(skb);
> +		rxe_put_skb(skb);
>   		return NULL;
>   	}
>   
> @@ -945,7 +945,7 @@ static enum resp_states read(struct rxe_qp *qp,
>   	err = rxe_mr_copy(mr, res->read.va, payload_addr(&ack_pkt),
>   			  payload, RXE_FROM_MR_OBJ);
>   	if (err) {
> -		kfree_skb(skb);
> +		rxe_put_skb(skb);
>   		state = RESPST_ERR_RKEY_VIOLATION;
>   		goto err_out;
>   	}
> 


