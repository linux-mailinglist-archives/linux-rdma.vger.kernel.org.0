Return-Path: <linux-rdma+bounces-21690-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0Qr2DyxVIGo91QAAu9opvQ
	(envelope-from <linux-rdma+bounces-21690-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 03 Jun 2026 18:24:12 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E160639B02
	for <lists+linux-rdma@lfdr.de>; Wed, 03 Jun 2026 18:24:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=UR9i53G0;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21690-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21690-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3075F301DE21
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Jun 2026 15:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29E0F2F7EEF;
	Wed,  3 Jun 2026 15:43:41 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 829B639734A
	for <linux-rdma@vger.kernel.org>; Wed,  3 Jun 2026 15:43:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780501420; cv=none; b=g1ijcvcI+0F9dJgGDeeDOTszaaQSNj56WORPdsaaeLxtno+SK9MrHqbtGoJS5+3/pCtnYbIpbbg5Ujb3p/pLSFGYtymp4akKC9jeH8iQgKChd638MOtxzEu/ijaME1h1knvD+F4LGsSQ1bZe7Tb6GM5eZgv2dIjZX6/9HW2dy2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780501420; c=relaxed/simple;
	bh=balkti5OVDv1e3Ha7FgrVvYG2i0mT15a9QZjVy8tbxE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FmBcLuY2l+6Wg/iif2DQiYObE2T/r0hOXBIVMagE5ME2hTZJ2lqhjlTBnKkxOfA9exOBdrhX+PO3RFB9YOaSYYXmhyZIvdLMbjUwnOPfflHaHi9kBAQnrKmmp2jkHd9DigCU5m+ZBW7kMN+tISvEr5iU3T0KY2XEDluhVkUiEag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UR9i53G0; arc=none smtp.client-ip=91.218.175.173
Message-ID: <3cdac159-4c61-448c-8327-d39ac0f87fe3@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780501417;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4bMS0wNeYr3XZa9nOaj9Y230uWhge45AntW5qgcEmKA=;
	b=UR9i53G085iyH4GNAj6tlFKwFiviEdq1emS2cedaG+is9NPt8wXgIxPQAUCWoqh+1ZmCqb
	5Qp/tnSvjl6qp/JFM41UPY6zL8FDA7XL4rzbq6dlC0ZKy8kXh7/6kFsTTswu+m9yQBl6LC
	hwliqBcOgOq4ZDQMkFXa5d2pp0DGrYo=
Date: Wed, 3 Jun 2026 08:43:31 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 1/1] RDMA/rxe: Fix Use-After-Free problem in
 rxe_net_del
To: Jason Gunthorpe <jgg@nvidia.com>,
 "yanjun.zhu@linux.dev" <yanjun.zhu@linux.dev>
Cc: zyjzyj2000@gmail.com, leon@kernel.org, linux-rdma@vger.kernel.org,
 syzbot+d8f76778263ab65c2b21@syzkaller.appspotmail.com
References: <20260519023541.8594-1-yanjun.zhu@linux.dev>
 <20260603012532.GA1188713@nvidia.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20260603012532.GA1188713@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:jgg@nvidia.com,m:yanjun.zhu@linux.dev,m:zyjzyj2000@gmail.com,m:leon@kernel.org,m:linux-rdma@vger.kernel.org,m:syzbot+d8f76778263ab65c2b21@syzkaller.appspotmail.com,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-21690-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER(0.00)[yanjun.zhu@linux.dev,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yanjun.zhu@linux.dev,linux-rdma@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,vger.kernel.org,syzkaller.appspotmail.com];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,d8f76778263ab65c2b21];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:mid,linux.dev:from_mime,linux.dev:dkim,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3E160639B02


在 2026/6/2 18:25, Jason Gunthorpe 写道:
> On Tue, May 19, 2026 at 04:35:41AM +0200, Zhu Yanjun wrote:
>
>> index 50a2cb5405e2..0bf5b0eabc7b 100644
>> --- a/drivers/infiniband/sw/rxe/rxe_net.c
>> +++ b/drivers/infiniband/sw/rxe/rxe_net.c
>> @@ -135,13 +135,21 @@ static struct dst_entry *rxe_find_route6(struct rxe_qp *qp,
>>   {
>>   	struct dst_entry *ndst;
>>   	struct flowi6 fl6 = {};
>> +	struct sock *sk;
>>   
>>   	fl6.flowi6_oif = ndev->ifindex;
>>   	memcpy(&fl6.saddr, saddr, sizeof(*saddr));
>>   	memcpy(&fl6.daddr, daddr, sizeof(*daddr));
>>   	fl6.flowi6_proto = IPPROTO_UDP;
>>   
>> -	ndst = ip6_dst_lookup_flow(net, rxe_ns_pernet_sk6(net), &fl6, NULL);
>> +	rxe_ns_lock(net);
>> +	sk = rxe_ns_pernet_sk6(net);
>> +	if (sk)
>> +		sock_hold(sk);
>> +	rxe_ns_unlock(net);
>> +
>> +	ndst = ip6_dst_lookup_flow(net, sk, &fl6, NULL);
>> +	sock_put(sk);
> Sashiko says this crashes when sk is null, which it can be.
>
> But this really seems weird, the rxe can be in only one namespace, why
> not reach the listening sks associated with the ib_dev through
> qp->pd->dev and not do net lookups?
>
> I would expect net lookups to only exist in the add/del link paths?

Thanks a lot. I will send out the new patch, following your advice.

Zhu Yanjun

>
> Jason

-- 
Best Regards,
Yanjun.Zhu


