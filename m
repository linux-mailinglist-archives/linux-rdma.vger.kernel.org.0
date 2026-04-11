Return-Path: <linux-rdma+bounces-19223-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iJa2LOmn2WmMrwgAu9opvQ
	(envelope-from <linux-rdma+bounces-19223-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 11 Apr 2026 03:46:17 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B2B23DDE78
	for <lists+linux-rdma@lfdr.de>; Sat, 11 Apr 2026 03:46:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 131D5300D74A
	for <lists+linux-rdma@lfdr.de>; Sat, 11 Apr 2026 01:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A80A81C5D59;
	Sat, 11 Apr 2026 01:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="opSRX8Rd"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB9218DB37;
	Sat, 11 Apr 2026 01:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775871972; cv=none; b=n+YvxA7bqy/yKNbJFmHnsp2XajTC0qwCeROXeosVXu+Q7X5wIFztMOh29U+U7iNDBWt+qzewAGyzjGuLMkydsV2k9keuEdgrpHrHjmCJ39OuQQ6ygvpCglMkKySN0W9PKuuRkXXELMZAcFxrfpXmZKMUEVGPtjHuufcqccZQv+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775871972; c=relaxed/simple;
	bh=AqaPyx3TqS1RZSxS1qIFHzXP+e53IPOlhfdcIphC/VY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pR/fHRWQg/B40r/wmc2LLi/Gp4spD5pBY9YyCjzP3nhh8ZnUbg5JrINSyidY9c+tI9Bx0bnvfk12BaPE79UyG6jmQBgqTYz7588YTRawGyU26Er4MdHaf8OK//L653Rry6lwYzohOWRojA5x2uyLz84Crwf1kRdPlnhGO49bPz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=opSRX8Rd; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <6f5dd82d-a5a8-4c0f-a7a3-1e7f47f51210@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775871968;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gSG/mS/5lofg1PEcUxp+3cOqG1kEX/KiE/mfBFFFK8s=;
	b=opSRX8Rd+Z3Y0l5VqvE92SLWwXmEldvKv01hg67a151yxSkRVaKkqFvMEeI30guoiCTZDA
	/YB5x5E70fyMoisgqXQ9sVSxCAahPS8Suy4ocq58A4vymB4qUvoaVWIexqba9z6TOayI9O
	FIqbnf4jQKlPO/qAMRVUzaJU+9UOIqE=
Date: Fri, 10 Apr 2026 18:45:58 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v5 2/3] RDMA/rxe: add SENT/RCVD bytes
To: "yanjun.zhu" <yanjun.zhu@linux.dev>, zhenwei pi <zhenwei.pi@linux.dev>,
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
Cc: zyjzyj2000@gmail.com, jgg@ziepe.ca, leon@kernel.org
References: <20260408000956.486522-1-zhenwei.pi@linux.dev>
 <20260408000956.486522-3-zhenwei.pi@linux.dev>
 <090caa77-f1ca-4854-9975-87b9e4f2bf74@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <090caa77-f1ca-4854-9975-87b9e4f2bf74@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,ziepe.ca,kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	TAGGED_FROM(0.00)[bounces-19223-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yanjun.zhu@linux.dev,linux-rdma@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 3B2B23DDE78
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


在 2026/4/10 15:37, yanjun.zhu 写道:
> On 4/7/26 5:09 PM, zhenwei pi wrote:
>> There is a lack of sent/received counter in bytes.
>>
>> Signed-off-by: zhenwei pi <zhenwei.pi@linux.dev>
>> ---
>>   drivers/infiniband/sw/rxe/rxe_hw_counters.c | 2 ++
>>   drivers/infiniband/sw/rxe/rxe_hw_counters.h | 2 ++
>>   drivers/infiniband/sw/rxe/rxe_net.c         | 2 ++
>>   drivers/infiniband/sw/rxe/rxe_recv.c        | 2 ++
>>   drivers/infiniband/sw/rxe/rxe_verbs.h       | 6 ++++++
>>   5 files changed, 14 insertions(+)
>>
>> diff --git a/drivers/infiniband/sw/rxe/rxe_hw_counters.c 
>> b/drivers/infiniband/sw/rxe/rxe_hw_counters.c
>> index 437917a7d8f2..17edaa9a9b9b 100644
>> --- a/drivers/infiniband/sw/rxe/rxe_hw_counters.c
>> +++ b/drivers/infiniband/sw/rxe/rxe_hw_counters.c
>> @@ -22,6 +22,8 @@ static const struct rdma_stat_desc 
>> rxe_counter_descs[] = {
>>       [RXE_CNT_LINK_DOWNED].name         =  "link_downed",
>>       [RXE_CNT_RDMA_SEND].name           =  "rdma_sends",
>>       [RXE_CNT_RDMA_RECV].name           =  "rdma_recvs",
>> +    [RXE_CNT_SENT_BYTES].name          =  "sent_bytes",
>> +    [RXE_CNT_RCVD_BYTES].name          =  "rcvd_bytes",
>>   };
>>     int rxe_ib_get_hw_stats(struct ib_device *ibdev,
>> diff --git a/drivers/infiniband/sw/rxe/rxe_hw_counters.h 
>> b/drivers/infiniband/sw/rxe/rxe_hw_counters.h
>> index 051f9e1c3852..01b355103cbc 100644
>> --- a/drivers/infiniband/sw/rxe/rxe_hw_counters.h
>> +++ b/drivers/infiniband/sw/rxe/rxe_hw_counters.h
>> @@ -26,6 +26,8 @@ enum rxe_counters {
>>       RXE_CNT_LINK_DOWNED,
>>       RXE_CNT_RDMA_SEND,
>>       RXE_CNT_RDMA_RECV,
>> +    RXE_CNT_SENT_BYTES,
>> +    RXE_CNT_RCVD_BYTES,
>>       RXE_NUM_OF_COUNTERS
>>   };
>>   diff --git a/drivers/infiniband/sw/rxe/rxe_net.c 
>> b/drivers/infiniband/sw/rxe/rxe_net.c
>> index 6621d01ac32d..86660031ffa2 100644
>> --- a/drivers/infiniband/sw/rxe/rxe_net.c
>> +++ b/drivers/infiniband/sw/rxe/rxe_net.c
>> @@ -503,6 +503,7 @@ int rxe_xmit_packet(struct rxe_qp *qp, struct 
>> rxe_pkt_info *pkt,
>>       int err;
>>       int is_request = pkt->mask & RXE_REQ_MASK;
>>       struct rxe_dev *rxe = to_rdev(qp->ibqp.device);
>> +    unsigned int skblen = skb->len;
>>       unsigned long flags;
>>         spin_lock_irqsave(&qp->state_lock, flags);
>> @@ -526,6 +527,7 @@ int rxe_xmit_packet(struct rxe_qp *qp, struct 
>> rxe_pkt_info *pkt,
>>       }
>>         rxe_counter_inc(rxe, RXE_CNT_SENT_PKTS);
>> +    rxe_counter_add(rxe, RXE_CNT_SENT_BYTES, skblen);
>>       goto done;
>>     drop:
>> diff --git a/drivers/infiniband/sw/rxe/rxe_recv.c 
>> b/drivers/infiniband/sw/rxe/rxe_recv.c
>> index 5861e4244049..e7bab89e7d8d 100644
>> --- a/drivers/infiniband/sw/rxe/rxe_recv.c
>> +++ b/drivers/infiniband/sw/rxe/rxe_recv.c
>> @@ -318,6 +318,7 @@ void rxe_rcv(struct sk_buff *skb)
>>       int err;
>>       struct rxe_pkt_info *pkt = SKB_TO_PKT(skb);
>>       struct rxe_dev *rxe = pkt->rxe;
>> +    unsigned int skblen = skb->len - skb_network_offset(skb);
>>         if (unlikely(skb->len < RXE_BTH_BYTES))
>>           goto drop;
>> @@ -341,6 +342,7 @@ void rxe_rcv(struct sk_buff *skb)
>>       if (unlikely(err))
>>           goto drop;
>>   +    rxe_counter_add(rxe, RXE_CNT_RCVD_BYTES, skblen);
>>       rxe_counter_inc(rxe, RXE_CNT_RCVD_PKTS);
>>         if (unlikely(bth_qpn(pkt) == IB_MULTICAST_QPN))
>
> int rxe_xmit_packet(struct rxe_qp *qp, struct rxe_pkt_info *pkt,
>                     struct sk_buff *skb)
> {
>         int err;
>         int is_request = pkt->mask & RXE_REQ_MASK;
>         struct rxe_dev *rxe = to_rdev(qp->ibqp.device);
>         unsigned long flags;
>
> skb->len is printed here, that is len1
> ...
>         if (pkt->mask & RXE_LOOPBACK_MASK)
>                 err = rxe_loopback(skb, pkt);
>         else
>                 err = rxe_send(skb, pkt);
> ...
> }
>
> In the following function
>
> static int rxe_loopback(struct sk_buff *skb, struct rxe_pkt_info *pkt)
> {
> ...
>         if (skb->protocol == htons(ETH_P_IP))
>                 skb_pull(skb, sizeof(struct iphdr));
>         else
>                 skb_pull(skb, sizeof(struct ipv6hdr));
>
> ...
>         /* remove udp header */
>         skb_pull(skb, sizeof(struct udphdr));
>
> print skb->len here, that is len2
>
>         rxe_rcv(skb);
>
> ...
> }
>
> Does len1 equal to len2?

I have made tests. The difference between len1 and len2 is 28.

It should be the total of ipv4 header + udp header because I use ipv4 
address to make tests.

I am not sure if the bytes of recv data should equal to the bytes of 
xmit data.


Zhu Yanjun

>
> If not, the transmitted length appears to differ from the received 
> length when using loopback.
>
> I am not sure whether this is expected behavior.
>
> The same observation also applies to the non-loopback case.
>
> Zhu Yanjun
>
>> diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h 
>> b/drivers/infiniband/sw/rxe/rxe_verbs.h
>> index e800545d1046..0f5ffd94643f 100644
>> --- a/drivers/infiniband/sw/rxe/rxe_verbs.h
>> +++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
>> @@ -455,6 +455,12 @@ static inline void rxe_counter_inc(struct 
>> rxe_dev *rxe, enum rxe_counters index)
>>       atomic64_inc(&rxe->stats_counters[index]);
>>   }
>>   +static inline void rxe_counter_add(struct rxe_dev *rxe, enum 
>> rxe_counters index,
>> +                   s64 val)
>> +{
>> +    atomic64_add(val, &rxe->stats_counters[index]);
>> +}
>> +
>>   static inline struct rxe_dev *to_rdev(struct ib_device *dev)
>>   {
>>       return dev ? container_of(dev, struct rxe_dev, ib_dev) : NULL;

-- 
Best Regards,
Yanjun.Zhu


