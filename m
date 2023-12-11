Return-Path: <linux-rdma+bounces-340-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88E0580BE9B
	for <lists+linux-rdma@lfdr.de>; Mon, 11 Dec 2023 01:56:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A4A6280C65
	for <lists+linux-rdma@lfdr.de>; Mon, 11 Dec 2023 00:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 396726135;
	Mon, 11 Dec 2023 00:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RQE0G6Qy"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A855A93;
	Sun, 10 Dec 2023 16:56:29 -0800 (PST)
Received: by mail-oo1-xc32.google.com with SMTP id 006d021491bc7-58cf894544cso2406440eaf.3;
        Sun, 10 Dec 2023 16:56:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702256189; x=1702860989; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MkKF7z5dWVDcPQzuq7xOJ4bZ1tfD8dwgDZR7n/xoOlk=;
        b=RQE0G6QyBTFXXy5SINlw/AZj1AB4EojGBqsGNS1hs5CPUgHGfUQovqhL6cfltmv2FY
         5tJoY7Iho4sjgn+iV8yKrIUlNAq8e2lcc3Aoe5hA9rX3qnQTWCcZbBsfrk2xQkTC40zz
         hdu/fAf1xla0DoYn4dWtfuD7hFC/5alPvDor0KFcfw0y2jDPwMNjHiMcCIcpgXuk/+5s
         /hrwYJ44BtXeBhtMgR9LFiyTX98Btd2ubpu0qaG66KSWtM3vAo7xMMrj+7skuqudMpvb
         eAXblRi1T+uc5s9ziBQi/+jhpyHSY0OZZX4gkSAnp7yO7SRQRSaT3Vb0QLabtazmlB+b
         e2Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702256189; x=1702860989;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MkKF7z5dWVDcPQzuq7xOJ4bZ1tfD8dwgDZR7n/xoOlk=;
        b=C9Nmq9sLTuvgqDqv0/DhadtVRiy2H7wpBtHib3luxDoICI5TAlx3az9pMbOgKnd5w9
         p00uvX0WNMySIH5Du+4biPu0oKbxjoud29yl4qfZw4vyD1tWnBkI60BwSAGfMfNa0H1s
         6JOY10fCwccwXt0nCtGmfFaCXrYuvjXv4SrwGlV0DyNtQsdBZthcNwJSB9TgWhvmwEhx
         LlbPcs96TFN2O/5dkZyPECfprUknqbaU65DDn/s6yqreJGwh3BRL3f4WCiQL89gEkwIQ
         j+FcJATbcFqVmBRkaiJtmTlGqSr9x3gIRbXa0Ql3r2XE+MiQV1kZD1b1i4KRymgKXlmI
         T7EQ==
X-Gm-Message-State: AOJu0YyLZgHHj+xfWqpuBTsIs9xMSwAApPtvJxPix0ZyHQbF+HTnks9s
	uXWaGMoTsmdnBCSVij4JvL4=
X-Google-Smtp-Source: AGHT+IGWIZHlQFtXq9tSPrSlxJuM8nLM3S8tcQSZ3mBktGDR4ydqRkFq+ewYgtBoz1cB/923/0T/VA==
X-Received: by 2002:a4a:58cd:0:b0:590:c350:34c3 with SMTP id f196-20020a4a58cd000000b00590c35034c3mr1184594oob.5.1702256188874;
        Sun, 10 Dec 2023 16:56:28 -0800 (PST)
Received: from ?IPV6:2603:8081:1405:679b:34a2:c217:379f:32fb? (2603-8081-1405-679b-34a2-c217-379f-32fb.res6.spectrum.com. [2603:8081:1405:679b:34a2:c217:379f:32fb])
        by smtp.gmail.com with ESMTPSA id v17-20020a056820005100b0059091609e98sm1455957oob.34.2023.12.10.16.56.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Dec 2023 16:56:28 -0800 (PST)
Message-ID: <baadce1c-7fd7-4756-9d4a-4a79483e576e@gmail.com>
Date: Sun, 10 Dec 2023 18:56:26 -0600
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-next v6 3/7] RDMA/rxe: Register IP mcast address
To: David Ahern <dsahern@kernel.org>, jgg@nvidia.com, yanjun.zhu@linux.dev,
 linux-rdma@vger.kernel.org, netdev@vger.kernel.org, rain.1986.08.12@gmail.com
References: <20231207192907.10113-1-rpearsonhpe@gmail.com>
 <20231207192907.10113-4-rpearsonhpe@gmail.com>
 <7e370f63-f256-45f3-89c9-7774877afaba@kernel.org>
Content-Language: en-US
From: Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <7e370f63-f256-45f3-89c9-7774877afaba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/8/23 09:50, David Ahern wrote:
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
> 
> 
David,

Thanks for looking at this. What is the in kernel setsock api? I'll give 
it a try but I am not sure what to call.

Bob
> 
> 

