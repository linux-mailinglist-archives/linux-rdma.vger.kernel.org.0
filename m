Return-Path: <linux-rdma+bounces-5116-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C4E1987675
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Sep 2024 17:26:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C55531F26F59
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Sep 2024 15:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8213B14D70B;
	Thu, 26 Sep 2024 15:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KY4U4I7h"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9479C14BF8B
	for <linux-rdma@vger.kernel.org>; Thu, 26 Sep 2024 15:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727364363; cv=none; b=UIFOIsGxbgJoOD8UsCw7rmT8wHnMAJZr//hDpUUNZEWBxtpCcpqh+A5GS+4JkYH91cnVVbGd+j4Zh+ISCrxYPCxTuf6TbCGbFQP7rHQdWYBZNQiIm4/nSwYLfm/gRNZLYiGeXYevck9WV3DjkvHJNI3ZqN0hlB5ebG6XcszvvYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727364363; c=relaxed/simple;
	bh=8O97gAQSQMSTIA1LZZJBwR/Vypo4UoHG527XvQ/bhCI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UvJlVe/tY75wmemBRWRBgc/nVGU39UR9s3dvpxVpFFqQbWQXXVCRbsoKYEhAHnN+Zfjh573LAGh0Nq8IUeSNY9sriwAOhqQBj1irBVFjLmuOUs0JETRAp/nqo0m00m9AnhyFJsB5XLUof4+uHTLiNyCa80K0hlzD6xIteWGBjo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KY4U4I7h; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <8d19d735-c2a8-456a-ac97-7f8d86cd7ed1@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1727364359;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z4ZlEW2hvu2WiB0zyG9qp5Yw8aOdRlroBQryAcoNJJ4=;
	b=KY4U4I7hrDGJSp6YKullSWSD5lP2OkyMVPJoqQhWbnI4jzplUfAvFTcH639OiAiefibyig
	EzCYgm91vBGkKuRpLuN/KhwHYK/O42gr6CaSUJTQEZAxRtOSKYdnq+NwFp6FmlTkJW++Bd
	m/OHo6S1IFun6CIEdK6Zrm2+S87b158=
Date: Thu, 26 Sep 2024 23:25:33 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [MAINLINE 0/2] Enable DIM for legacy ULPs and use it in RDS
To: Leon Romanovsky <leon@kernel.org>
Cc: Haakon Bugge <haakon.bugge@oracle.com>,
 Christoph Hellwig <hch@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 Allison Henderson <allison.henderson@oracle.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 OFED mailing list <linux-rdma@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "rds-devel@oss.oracle.com" <rds-devel@oss.oracle.com>
References: <Zuwyf0N_6E6Alx-H@infradead.org>
 <C00EA178-ED20-4D56-B6F2-200AC72F3A39@oracle.com>
 <Zu191hsvJmvBlJ4J@infradead.org>
 <525e9a31-31ee-4acf-a25c-8bf3a617283f@linux.dev>
 <ZvFY_4mCGq2upmFl@infradead.org>
 <aea6b986-2d25-4ebc-93e8-05da9c6f3ba2@linux.dev>
 <ZvJiKGtuX62jkIwY@infradead.org>
 <1ad540cb-bf1b-456b-be2d-6c35999bdaa8@linux.dev>
 <66A7418F-4989-4765-AC0F-1D23342C6950@oracle.com>
 <5b86861b-60f7-4c90-bc0e-d863b422850f@linux.dev>
 <20240925092645.GD967758@unreal>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20240925092645.GD967758@unreal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2024/9/25 17:26, Leon Romanovsky 写道:
> On Wed, Sep 25, 2024 at 10:04:21AM +0800, Zhu Yanjun wrote:
>> 在 2024/9/24 23:16, Haakon Bugge 写道:
>>>
>>>
>>>> On 24 Sep 2024, at 15:59, Zhu Yanjun <yanjun.zhu@linux.dev> wrote:
>>>>
>>>> 在 2024/9/24 14:54, Christoph Hellwig 写道:
>>>>> On Tue, Sep 24, 2024 at 09:58:24AM +0800, Zhu Yanjun wrote:
>>>>>> The users that I mentioned is not in the kernel tree.
>>>>> And why do you think that would matter the slightest?
>>>>
>>>> I noticed that the same cq functions are used. And I also made tests with this patch series. Without this patch series, dim mechanism will not be invoked.
>>>
>>> Christoph alluded to say: Do not modify the old cq_create_cq() code in order to support DIM, it is better to change the ULP to use ib_alloc_cq(), and get DIM enabled that way.
>>
>> Hi, Haakon
>>
>> To be honest, I like your original commit that enable DIM for legacy ULPs
>> because this can fix this problem once for all and improve the old
>> ib_create_cq function.
>>
>> The idea from Christoph will cause a lot of changes in ULPs. I am not very
>> sure if these changes cause risks or not.
>>
>> Thus, I prefer to your original commit. But I will follow the advice from
>> Leon and Jason.
> 
> Christoph was very clear and he summarized our position very well. We
> said similar thing to SMC folks in 2022 [1] and RDS is no different here.

Thanks, Leon. I will read this link carefully.

> 
> So no, "old ib_create_cq" shouldn't be used by ULPs.

Got it. I have replaced ib_create_cq with ib cq pool APIs. Perhaps 
drivers/infiniband/ulp/srpt/ib_srpt.c is a good example to use ib cq 
pool APIs.

Best Regards,
Zhu Yanjun

> 
> Thanks
> 
> [1] https://lore.kernel.org/netdev/YePesYRnrKCh1vFy@unreal/
> 
>>
>> Zhu Yanjun
>>
>>>
>>>
>>> Thxs, Håkon
>>>
>>
>>


