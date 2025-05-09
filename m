Return-Path: <linux-rdma+bounces-10198-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B3C7AB1327
	for <lists+linux-rdma@lfdr.de>; Fri,  9 May 2025 14:19:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23F503A68A7
	for <lists+linux-rdma@lfdr.de>; Fri,  9 May 2025 12:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00A81290BA2;
	Fri,  9 May 2025 12:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nelTEFSx"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C582101BD;
	Fri,  9 May 2025 12:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746793154; cv=none; b=U7laSZQ31hs1xlqCxQLXyz2LMDqBAGxEgPjU2YhQ1n5WCYqWKSawIOQ4fz93MG3/FRKffGe/PUzsgTSiDwa5G92mr1BkMJgn+tC7KwDd12yWGmSFLqueW6HOXizzYBGdW6fyqeGXwTxYWOT6WuNiEHeSfqjPJxw2cDkpZ22uBXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746793154; c=relaxed/simple;
	bh=a0zU1WPMKY43KvXel5UIuS/n93s/0NR70PpFKXvOlTs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=lvUFSpzxC0H0QU4fcgL4692zSW1d6fU8pjb4txVG7qvVXh0kL5vY+rWBo4gFUp/ti2xDtNscVWvp6ewz/cKvZQzLg5MY1/6AZ7pkBp92iV7plqcwp/xMLvG743tlNKNWaZQv7aBy5Y/CMDOFlCz40WK5rPIOqHJapRPcYl9O1EI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nelTEFSx; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b2093aef78dso1606619a12.0;
        Fri, 09 May 2025 05:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746793152; x=1747397952; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LD1FVxRPI6UHrZeD+ImfmExVRXEwBxLr6+TmDpqWiF8=;
        b=nelTEFSxSaM9PeRAs//vYGsgz5DADNmv+U0UUfZ0KRmn15VTYF5F4Hofj3CDFEKsrC
         FP3zRV8JaxzRKdv9UwwV5CrLh/vnYoiRgFeAu/APQWMMLYrQH0+tqjoOrTKdM+IXUlxE
         3XqpgbAyRj5aDIgpGsH1/nqTNs5RPObZQ1W+ignty4Ofwu427vB+S9AuduG3qvBxNhk6
         TiSkTRVjeB1HfzUsUdUQNn5LZuHrFEmMIAU2/wyn+bB+Ic3KFR3kXHoH2kPv8/bfJoQg
         BCxfxW5Tf4SA1pscnyAY1NSwhk/GcUttO7nN2n1zp6qowcIktICSS5PdhsDNEhYIM2br
         E0uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746793152; x=1747397952;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LD1FVxRPI6UHrZeD+ImfmExVRXEwBxLr6+TmDpqWiF8=;
        b=PEi8TOCHOSOkr+Xv5OgQvjOPT0Sa5TaFrFanycT2uttxH/f3UfaG6KdMdcAAkj1D6+
         zGOoEhhducnV3DAACsazr6vIAv1v7cbYz3wq8ixa1/RF2rCFkJ/4f4ypAIDJy5DTgRnf
         gzttgpWriD4dip0hRde30naTCWZo5fvUiksn3UtuCoa7ZkSJVJvATP4oiHVSoRypN9Dt
         d/Ao7VzjVlmo8flBj+p+Wo0CKljUgt0vBYJRuU9EOgGlcvsCZvPsf6lqFbZz7CTGCZo7
         JaMjbxPJWQ404h2gWaQGR3WEPu2ZoiB14dFlqN6OssX2lRO9uB+33ZWmD3U0KRTl7eAj
         NWVg==
X-Forwarded-Encrypted: i=1; AJvYcCU/ScmVLDZGRamthJX4dCrYOtfYGt3BryMKeWaJAEdCgxDVizNvtdF0JZiINgNFateIGpvqkjSyu6n2UK4=@vger.kernel.org, AJvYcCWsnSZpMzTyhNRBYD+SgIEkqv5HdcOPx93zqKhKEohJq1NkuBWt6atMG5JAw4Atn2xeF1imAb21ClHSBA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwyhqxBBQmzvXY7PlvOWFpQaOPf1acPzlzJx8nypTJfduwgoWux
	glC245Myzbs/X867roSBTJoM1/3oGDBvpFQZ4mcu0DhOT9DUtTcF
X-Gm-Gg: ASbGncuLQqu017u4zBT4p83B4nSihSd22kxqiIF0Iy3RP4/NqPxB/wkHqCLKo5iUlDh
	qOX396POa69/F0EZ4bxSkHV5R6516vRIQFQ7wQK1AXx+PvuYkLaUFjYUJ97A0hYnLNTW2ZFhMvI
	ApHsHui3RjDYDn5kSvUjBKPubQkvWFNEIvGsVqnSLm4E4gNeEP70/4DrZBSxMeNDyJfzJJbEFhW
	2VtbrFV0XBGyFHcfDTTh4CC+Hy4wSPf+P65/ODz6nojYZrkE3cageDV3ddYJj5DPyAQORANeVWp
	g7ujaPNhKmAtkNQu8wEwvowkPYvgb9S3fAc0HmkvAIugJ4/KvpFzJQQSO1XxqR8WTSlXxpk5195
	JoCbueKzdd92mltlqFIIm4dUFJiQ=
X-Google-Smtp-Source: AGHT+IGPV4PXB1eog/SpfPJl9Mh6FUfJVT4D7Fjv94U7J8jTwJkek3wC7GsG1fmcpHY0a2jZ1ZKC3g==
X-Received: by 2002:a17:902:d487:b0:21f:617a:f1b2 with SMTP id d9443c01a7336-22fc91a84e2mr45580865ad.46.1746793152206;
        Fri, 09 May 2025 05:19:12 -0700 (PDT)
Received: from [192.168.11.2] (FL1-119-244-79-106.tky.mesh.ad.jp. [119.244.79.106])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22fc828954fsm15862245ad.175.2025.05.09.05.19.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 May 2025 05:19:11 -0700 (PDT)
Message-ID: <2a6081b8-1772-4064-97d8-70d636b1868e@gmail.com>
Date: Fri, 9 May 2025 21:19:08 +0900
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-next v2 2/2] RDMA/rxe: Enable asynchronous prefetch
 for ODP MRs
To: Zhu Yanjun <yanjun.zhu@linux.dev>, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org, leon@kernel.org, jgg@ziepe.ca,
 zyjzyj2000@gmail.com
References: <20250503134224.4867-1-dskmtsd@gmail.com>
 <20250503134224.4867-3-dskmtsd@gmail.com>
 <dbc1bcdf-144d-44d2-8fc8-77bc2ad58b51@linux.dev>
Content-Language: en-US
From: Daisuke Matsuda <dskmtsd@gmail.com>
In-Reply-To: <dbc1bcdf-144d-44d2-8fc8-77bc2ad58b51@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2025/05/06 0:25, Zhu Yanjun wrote:
> On 03.05.25 15:42, Daisuke Matsuda wrote:
>> Calling ibv_advise_mr(3) with flags other than IBV_ADVISE_MR_FLAG_FLUSH
>> invokes asynchronous requests. It is best-effort, and thus can safely be
>> deferred to the system-wide workqueue.
>>
>> Signed-off-by: Daisuke Matsuda <dskmtsd@gmail.com>
> 
> I have made tests with rdma-core after applying this patch series. It seems that it can work well.
> I read through this commit. Other than the following minor problems, I am fine with this commit.
> 
> Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> 
>> ---
>>   drivers/infiniband/sw/rxe/rxe_odp.c | 81 ++++++++++++++++++++++++++++-
>>   1 file changed, 80 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/infiniband/sw/rxe/rxe_odp.c b/drivers/infiniband/sw/rxe/rxe_odp.c
>> index e5c60b061d7e..d98b385a18ce 100644
>> --- a/drivers/infiniband/sw/rxe/rxe_odp.c
>> +++ b/drivers/infiniband/sw/rxe/rxe_odp.c
>> @@ -425,6 +425,73 @@ enum resp_states rxe_odp_do_atomic_write(struct rxe_mr *mr, u64 iova, u64 value)
>>       return RESPST_NONE;
>>   }
>> +struct prefetch_mr_work {
>> +    struct work_struct work;
>> +    u32 pf_flags;
>> +    u32 num_sge;
>> +    struct {
>> +        u64 io_virt;
>> +        struct rxe_mr *mr;
>> +        size_t length;
>> +    } frags[];
>> +};
> 
> The struct prefetch_mr_work should be moved into header file? IMO, it is better to move this struct to rxe_loc.h?

This struct is not likely to be used in other files.
I think leaving it here would be easier for other developers to understand because relevant codes are gathered.
If there is any specific reason to move, I will do so.

> 
>> +
>> +static void rxe_ib_prefetch_mr_work(struct work_struct *w)
>> +{
>> +    struct prefetch_mr_work *work =
>> +        container_of(w, struct prefetch_mr_work, work);
>> +    int ret;
>> +    u32 i;
>> +
>> +    /* We rely on IB/core that work is executed if we have num_sge != 0 only. */
>> +    WARN_ON(!work->num_sge);
>> +    for (i = 0; i < work->num_sge; ++i) {
>> +        struct ib_umem_odp *umem_odp;
>> +
>> +        ret = rxe_odp_do_pagefault_and_lock(work->frags[i].mr, work->frags[i].io_virt,
>> +                            work->frags[i].length, work->pf_flags);
>> +        if (ret < 0) {
>> +            rxe_dbg_mr(work->frags[i].mr, "failed to prefetch the mr\n");
>> +            continue;
>> +        }
>> +
>> +        umem_odp = to_ib_umem_odp(work->frags[i].mr->umem);
>> +        mutex_unlock(&umem_odp->umem_mutex);
> 
> Obviously this function is dependent on the mutex lock umem_mutex. So in the beginning of this function, it is better to  add lockdep_assert_held(&umem_odp->umem_mutex)?

The mutex **must not** be locked at the beginning, so
perhaps we can add lockdep_assert_not_held() instead at the beginning,
but this one is not used frequently, and we can do without that.

umem_mutex is locked in rxe_odp_do_pagefault_and_lock() in the for loop.
The function calls ib_umem_odp_map_dma_and_lock(), which locks the mutex only when pagefault is successful.
If ib_umem_odp_map_dma_and_lock() fails, an error is returned and then the mutex is not locked.

Daisuke

> 
> Zhu Yanjun
> 
>> +    }
>> +
>> +    kvfree(work);
>> +}
>> +
>> +static int rxe_init_prefetch_work(struct ib_pd *ibpd,
>> +                  enum ib_uverbs_advise_mr_advice advice,
>> +                  u32 pf_flags, struct prefetch_mr_work *work,
>> +                  struct ib_sge *sg_list, u32 num_sge)
>> +{
>> +    struct rxe_pd *pd = container_of(ibpd, struct rxe_pd, ibpd);
>> +    u32 i;
>> +
>> +    INIT_WORK(&work->work, rxe_ib_prefetch_mr_work);
>> +    work->pf_flags = pf_flags;
>> +
>> +    for (i = 0; i < num_sge; ++i) {
>> +        struct rxe_mr *mr;
>> +
>> +        mr = lookup_mr(pd, IB_ACCESS_LOCAL_WRITE,
>> +                   sg_list[i].lkey, RXE_LOOKUP_LOCAL);
>> +        if (IS_ERR(mr)) {
>> +            work->num_sge = i;
>> +            return PTR_ERR(mr);
>> +        }
>> +        work->frags[i].io_virt = sg_list[i].addr;
>> +        work->frags[i].length = sg_list[i].length;
>> +        work->frags[i].mr = mr;
>> +
>> +        rxe_put(mr);
>> +    }
>> +    work->num_sge = num_sge;
>> +    return 0;
>> +}
>> +
>>   static int rxe_ib_prefetch_sg_list(struct ib_pd *ibpd,
>>                      enum ib_uverbs_advise_mr_advice advice,
>>                      u32 pf_flags, struct ib_sge *sg_list,
>> @@ -478,6 +545,8 @@ static int rxe_ib_advise_mr_prefetch(struct ib_pd *ibpd,
>>                        u32 flags, struct ib_sge *sg_list, u32 num_sge)
>>   {
>>       u32 pf_flags = RXE_PAGEFAULT_DEFAULT;
>> +    struct prefetch_mr_work *work;
>> +    int rc;
>>       if (advice == IB_UVERBS_ADVISE_MR_ADVICE_PREFETCH)
>>           pf_flags |= RXE_PAGEFAULT_RDONLY;
>> @@ -490,7 +559,17 @@ static int rxe_ib_advise_mr_prefetch(struct ib_pd *ibpd,
>>           return rxe_ib_prefetch_sg_list(ibpd, advice, pf_flags, sg_list,
>>                              num_sge);
>> -    /* Asynchronous call is "best-effort" */
>> +    /* Asynchronous call is "best-effort" and allowed to fail */
>> +    work = kvzalloc(struct_size(work, frags, num_sge), GFP_KERNEL);
>> +    if (!work)
>> +        return -ENOMEM;
>> +
>> +    rc = rxe_init_prefetch_work(ibpd, advice, pf_flags, work, sg_list, num_sge);
>> +    if (rc) {
>> +        kvfree(work);
>> +        return rc;
>> +    }
>> +    queue_work(system_unbound_wq, &work->work);
>>       return 0;
>>   }
> 


