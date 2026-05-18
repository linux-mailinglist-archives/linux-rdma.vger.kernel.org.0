Return-Path: <linux-rdma+bounces-20929-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yKFnC5BhC2pHGwUAu9opvQ
	(envelope-from <linux-rdma+bounces-20929-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2026 20:59:28 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 29EF15727E8
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2026 20:59:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0619E3008C80
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2026 18:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E48D384CEC;
	Mon, 18 May 2026 18:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pTiiXzq2"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C251A2392
	for <linux-rdma@vger.kernel.org>; Mon, 18 May 2026 18:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779130761; cv=none; b=hyhdx2hYakiSCGcSjdml2p+J4qaWtgLsPMmuAr2a7YkyoOalUXgqCT7Qkm/rTK4ql3l34sRp2/GFdQ3E58D9lP9F0MU4/TEn1wxlx/C7NjzrOIwsKfvS4lyx4tXbxYdKw61CNokTzcgk1ZM0ZcLV4viGYa6FW8BamAPkKy/f0c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779130761; c=relaxed/simple;
	bh=UEft3WY5Gmk+Qy0997MWOoS5bTqKPHQpyWMfHOt7Zps=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J57zOzLseyiAdz0wE+4xl/RHh0HUIMRWbyC+aOJ+EJqyP3gReLV/ETyS3GPHqZ96L4QsZBBjJgiqcJ05TRVsAftIoLQFqOjgjncd96AsaZ4O0FAmGrEPtr5pinPvzuOebhfE5mw8BseTllJjhZ/JAj7Yckhv0Eexs9d6dDQoacs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pTiiXzq2; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <e06988e3-97f2-48ae-9358-932af4e840d4@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779130756;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oSf+LGF5W/Gz1vcJGj9mDkU0de611D0MsevGsuiqTG4=;
	b=pTiiXzq24qKl541sJMcXihrpSzfTdF9ozlkm5kPFwcMGuar8UTxvW2PYQUEaUUFYiZQ+hY
	1q5BNWNn7OZaDiloujwgVbkrQn3omrpXN9TIfYOUkGKh81cmCOA0+6m6ieB2OngXS1U1Xv
	x6y74RRsVB9Uns8XBumBcjb9A8heEmY=
Date: Mon, 18 May 2026 11:59:12 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 1/1] RDMA/rxe: Fix Use-After-Free problem in rxe_net_del
To: Leon Romanovsky <leon@kernel.org>, Zhu Yanjun <yanjun.zhu@linux.dev>
Cc: zyjzyj2000@gmail.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org,
 syzbot+d8f76778263ab65c2b21@syzkaller.appspotmail.com
References: <20260517044747.475621-1-yanjun.zhu@linux.dev>
 <20260518113913.GO33515@unreal>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "yanjun.zhu" <yanjun.zhu@linux.dev>
In-Reply-To: <20260518113913.GO33515@unreal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20929-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,ziepe.ca,vger.kernel.org,syzkaller.appspotmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yanjun.zhu@linux.dev,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,d8f76778263ab65c2b21];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,linux.dev:mid,linux.dev:dkim]
X-Rspamd-Queue-Id: 29EF15727E8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/18/26 4:39 AM, Leon Romanovsky wrote:
> On Sun, May 17, 2026 at 06:47:47AM +0200, Zhu Yanjun wrote:
>> +	rxe_ns_lock(net);
>> +
>>   	sk = rxe_ns_pernet_sk4(net);
>>   	if (sk)
>>   		rxe_sock_put(sk, rxe_ns_pernet_set_sk4, net);
>> @@ -663,6 +665,8 @@ void rxe_net_del(struct ib_device *dev)
>>   	if (sk)
>>   		rxe_sock_put(sk, rxe_ns_pernet_set_sk6, net);
>>   
>> +	rxe_ns_unlock(net);
>> +
>>   	dev_put(ndev);
>>   }
>>   
>> diff --git a/drivers/infiniband/sw/rxe/rxe_ns.c b/drivers/infiniband/sw/rxe/rxe_ns.c
>> index 8b9d734229b2..799a727bc1fe 100644
>> --- a/drivers/infiniband/sw/rxe/rxe_ns.c
>> +++ b/drivers/infiniband/sw/rxe/rxe_ns.c
>> @@ -16,6 +16,7 @@
>>   struct rxe_ns_sock {
>>   	struct sock __rcu *rxe_sk4;
>>   	struct sock __rcu *rxe_sk6;
>> +	struct mutex	release_lock;
> 
> This change renders the existing rcu_read_lock() and rcu_read_unlock()
> calls unnecessary.

Thanks, Leon. I fully agree with you.
In the next version, I will remove the existing rcu locks.

Zhu Yanjun

> 
> Thanks


