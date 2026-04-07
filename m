Return-Path: <linux-rdma+bounces-19068-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id LlwcC/BW1GkStQcAu9opvQ
	(envelope-from <linux-rdma+bounces-19068-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 07 Apr 2026 02:59:28 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 79D673A887F
	for <lists+linux-rdma@lfdr.de>; Tue, 07 Apr 2026 02:59:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2CBE33023DB2
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Apr 2026 00:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CD9B1DE4FB;
	Tue,  7 Apr 2026 00:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KL+bznNf"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCAE0165F16
	for <linux-rdma@vger.kernel.org>; Tue,  7 Apr 2026 00:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775523564; cv=none; b=HRbN15ItSldXhXntiXPVOyjnH1kXjyfAVwFODGEa+1N33QtX7UU2i0fTexq0PxRotBuJxkqzuQUyFekc13flvWxxL9w1sLcyL77FMm/aiI7c6qsYwfwTpbtwzx6LgBerzVilEI4UTcYB7fy30LYNCuJDKdhZO7sk/sRcp2DNUvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775523564; c=relaxed/simple;
	bh=Ruh2hw9g1yIA5sM/JvdtPU+1+diSx8vcr11yMSGBpNY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U87DpY+eaViPwbwDNlqYwLHycwyIAiOT5NETAZuDK3Oni+x7u+DbvayphmIs+JtI16+/AmbQDrPHSVZsl4p5EjkeMkIXj3YvVNOCS6DvccCUTveKez8OvmJY9Pwj7R6noHlSOTarXO7jB8B6qVsWICcKGNakgrZitIPNjniVU9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KL+bznNf; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <cd0427bc-badd-4e54-ae91-e8ad6557fb95@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775523559;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F/x41L2AHVWKTqLTiopJhOr7DaAP3xYk8NAlRbjTExo=;
	b=KL+bznNfbBLvKdwm/DyotBoIHLJu2LB9Qb1O5zvnqFQ3bat0AsPTWiT8W0ONKRqCyZ+Ai9
	LawzhbblyCvYScGGSz5/mJmveHWMscYvY0+VFbX5UBk/UyxqgwudIkLOeSkOoCmaCqByOu
	IPWGR/T4wqVmu+0J9D1UqkLLlZQ9dmk=
Date: Tue, 7 Apr 2026 08:58:57 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v4 3/4] RDMA/rxe: add SENT/RCVD bytes
To: Zhu Yanjun <yanjun.zhu@linux.dev>, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org
Cc: zyjzyj2000@gmail.com, jgg@ziepe.ca, leon@kernel.org
References: <20260406132830.435381-1-zhenwei.pi@linux.dev>
 <20260406132830.435381-4-zhenwei.pi@linux.dev>
 <92943fb0-b0ec-443e-a04f-204faba0c9cf@linux.dev>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: zhenwei pi <zhenwei.pi@linux.dev>
In-Reply-To: <92943fb0-b0ec-443e-a04f-204faba0c9cf@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19068-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,ziepe.ca,kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhenwei.pi@linux.dev,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.dev:dkim,linux.dev:email,linux.dev:mid]
X-Rspamd-Queue-Id: 79D673A887F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 4/6/26 22:55, Zhu Yanjun wrote:
> 在 2026/4/6 6:28, zhenwei pi 写道:
>> There is a lack of sent/received counter in bytes.
>>
>> Signed-off-by: zhenwei pi <zhenwei.pi@linux.dev>
>> ---
>>   drivers/infiniband/sw/rxe/rxe_hw_counters.c | 2 ++
>>   drivers/infiniband/sw/rxe/rxe_hw_counters.h | 2 ++
>>   drivers/infiniband/sw/rxe/rxe_net.c         | 2 ++
>>   drivers/infiniband/sw/rxe/rxe_recv.c        | 6 ++++++
>>   drivers/infiniband/sw/rxe/rxe_verbs.h       | 6 ++++++
>>   5 files changed, 18 insertions(+)
>>
>> diff --git a/drivers/infiniband/sw/rxe/rxe_hw_counters.c b/drivers/ 
>> infiniband/sw/rxe/rxe_hw_counters.c
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
>>   int rxe_ib_get_hw_stats(struct ib_device *ibdev,
>> diff --git a/drivers/infiniband/sw/rxe/rxe_hw_counters.h b/drivers/ 
>> infiniband/sw/rxe/rxe_hw_counters.h
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
>> diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/ 
>> sw/rxe/rxe_net.c
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
>>       spin_lock_irqsave(&qp->state_lock, flags);
>> @@ -526,6 +527,7 @@ int rxe_xmit_packet(struct rxe_qp *qp, struct 
>> rxe_pkt_info *pkt,
>>       }
>>       rxe_counter_inc(rxe, RXE_CNT_SENT_PKTS);
>> +    rxe_counter_add(rxe, RXE_CNT_SENT_BYTES, skblen);
>>       goto done;
>>   drop:
>> diff --git a/drivers/infiniband/sw/rxe/rxe_recv.c b/drivers/ 
>> infiniband/sw/rxe/rxe_recv.c
>> index 5861e4244049..0d9112e95eae 100644
>> --- a/drivers/infiniband/sw/rxe/rxe_recv.c
>> +++ b/drivers/infiniband/sw/rxe/rxe_recv.c
>> @@ -318,6 +318,7 @@ void rxe_rcv(struct sk_buff *skb)
>>       int err;
>>       struct rxe_pkt_info *pkt = SKB_TO_PKT(skb);
>>       struct rxe_dev *rxe = pkt->rxe;
>> +    unsigned int skblen = skb->len + sizeof(struct udphdr);
>>       if (unlikely(skb->len < RXE_BTH_BYTES))
>>           goto drop;
>> @@ -341,6 +342,11 @@ void rxe_rcv(struct sk_buff *skb)
>>       if (unlikely(err))
>>           goto drop;
>> +    if (skb->protocol == htons(ETH_P_IP))
>> +        skblen += sizeof(struct iphdr);
>> +    else if (skb->protocol == htons(ETH_P_IPV6))
>> +        skblen += sizeof(struct ipv6hdr);
>> +    rxe_counter_add(rxe, RXE_CNT_RCVD_BYTES, skblen);
> 
>  From the above source code, I think that you want to calculate total 
> length starting from the Network Layer (IP Header).
> Maybe the following is compact.
> 
> "
> unsigned int skblen = skb->len - skb_network_offset(skb);
> rxe_counter_add(rxe, RXE_CNT_RCVD_BYTES, skblen);
> "
> 
> Zhu Yanjun
> 

Yes, TX side uses the total length of IP + UDP + IB as sent bytes, RX 
side should record the same length. Because IP and UDP headers have 
already been pulled at this stage, so add the addional length here. 
skb_network_offset(skb) is fine, I'll use it instead in the next version 
later.

Thanks.

>>       rxe_counter_inc(rxe, RXE_CNT_RCVD_PKTS);
>>       if (unlikely(bth_qpn(pkt) == IB_MULTICAST_QPN))
>> diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/ 
>> infiniband/sw/rxe/rxe_verbs.h
>> index e800545d1046..0f5ffd94643f 100644
>> --- a/drivers/infiniband/sw/rxe/rxe_verbs.h
>> +++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
>> @@ -455,6 +455,12 @@ static inline void rxe_counter_inc(struct rxe_dev 
>> *rxe, enum rxe_counters index)
>>       atomic64_inc(&rxe->stats_counters[index]);
>>   }
>> +static inline void rxe_counter_add(struct rxe_dev *rxe, enum 
>> rxe_counters index,
>> +                   s64 val)
>> +{
>> +    atomic64_add(val, &rxe->stats_counters[index]);
>> +}
>> +
>>   static inline struct rxe_dev *to_rdev(struct ib_device *dev)
>>   {
>>       return dev ? container_of(dev, struct rxe_dev, ib_dev) : NULL;
> 


