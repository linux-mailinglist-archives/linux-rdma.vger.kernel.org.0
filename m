Return-Path: <linux-rdma+bounces-336-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D22080B3FF
	for <lists+linux-rdma@lfdr.de>; Sat,  9 Dec 2023 12:32:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77DC21C20A2D
	for <lists+linux-rdma@lfdr.de>; Sat,  9 Dec 2023 11:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D14513FF2;
	Sat,  9 Dec 2023 11:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jjcH9YV1"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B257A10D8
	for <linux-rdma@vger.kernel.org>; Sat,  9 Dec 2023 03:32:09 -0800 (PST)
Message-ID: <50227b1f-7b45-436a-918f-00ddc470e0fa@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1702121527;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N4Ui6HjF2IxxOJer3QWL67LqWLDJEwlUqnOGyzfape0=;
	b=jjcH9YV1LuDDkZ2r5UX27mMvjpw7H9s5sezjLGgZXCgLl4/yYO+7hSJ/2Ym8/xVG0a5mhe
	OKkaDcWkv+kHU//m1mu9uGhY8bahRuqZpd5KOUVxDP+Iv1DNtVN3ogFO4a4LMJLbPMH1pM
	DvV+Dk5VYptKlPgCPJSB6HtAMqqcU1c=
Date: Sat, 9 Dec 2023 19:32:01 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH for-next v6 3/7] RDMA/rxe: Register IP mcast address
To: David Ahern <dsahern@kernel.org>, Bob Pearson <rpearsonhpe@gmail.com>,
 jgg@nvidia.com, linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
 rain.1986.08.12@gmail.com
References: <20231207192907.10113-1-rpearsonhpe@gmail.com>
 <20231207192907.10113-4-rpearsonhpe@gmail.com>
 <7e370f63-f256-45f3-89c9-7774877afaba@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <7e370f63-f256-45f3-89c9-7774877afaba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2023/12/8 23:50, David Ahern 写道:
> On 12/7/23 12:29 PM, Bob Pearson wrote:
>> diff --git a/drivers/infiniband/sw/rxe/rxe_mcast.c b/drivers/infiniband/sw/rxe/rxe_mcast.c
>> index 86cc2e18a7fd..5236761892dd 100644
>> --- a/drivers/infiniband/sw/rxe/rxe_mcast.c
>> +++ b/drivers/infiniband/sw/rxe/rxe_mcast.c
>> @@ -19,38 +19,116 @@
>>    * mcast packets in the rxe receive path.
>>    */
>>   
>> +#include <linux/igmp.h>
>> +
>>   #include "rxe.h"
>>   
>> -/**
>> - * rxe_mcast_add - add multicast address to rxe device
>> - * @rxe: rxe device object
>> - * @mgid: multicast address as a gid
>> - *
>> - * Returns 0 on success else an error
>> - */
>> -static int rxe_mcast_add(struct rxe_dev *rxe, union ib_gid *mgid)
>> +static int rxe_mcast_add6(struct rxe_dev *rxe, union ib_gid *mgid)
>>   {
>> +	struct in6_addr *addr6 = (struct in6_addr *)mgid;
>> +	struct sock *sk = recv_sockets.sk6->sk;
>>   	unsigned char ll_addr[ETH_ALEN];
>> +	int err;
>> +
>> +	lock_sock(sk);
>> +	rtnl_lock();
> 
> reverse the order. rtnl is always taken first, then socket lock.
> 
> Actually, I think it would be better to avoid burying this logic in the
> rxe driver. Can you try using the setsockopt API? I think it is now
> usable within the kernel again after the refactoring for io_uring.

Thanks, David,
Your helps are appreciated.

Zhu Yanjun

> 
> 
> 
> 


