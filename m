Return-Path: <linux-rdma+bounces-10197-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A9CCCAB1282
	for <lists+linux-rdma@lfdr.de>; Fri,  9 May 2025 13:51:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFB721BC78AD
	for <lists+linux-rdma@lfdr.de>; Fri,  9 May 2025 11:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06EF728F95E;
	Fri,  9 May 2025 11:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZyHSN98V"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19DF11E1E1D;
	Fri,  9 May 2025 11:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746791473; cv=none; b=ZVpvYK8jOureURaHx39xqWFtj5XP3RBKSXNQ6AUJur/KcQIsj51cNeNx8dZQOya2Lc3IN3sv2f4KYtFg+ktQIBOkJd9cQe0GMq4YAPyjpnaKAR67J313t914MWEyfDI3hAiDa8Sj/fqpJacQuYWAReqdEfmqjp4u8gKA1exSqHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746791473; c=relaxed/simple;
	bh=x0Eov/pOM4W2XohQNflH4vVwDhAfd7meZ9Cu8GKg7aM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=hTSQJW9TQ845r7iJU79h8sjw6kr07o8zcCpxEZ/3RC/iMgut7f5QbVwpQkoWVwX4XTX2WvweiWG2qp/fl76jW2VHYJATovdX0//woDUmS7jlFCQ3f0oaWNAuTPlomIYEAza56ifM4GFDQZUgBVNnrfF2w/P8DJdBKt23HTVNl7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZyHSN98V; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-73bf1cef6ceso2116523b3a.0;
        Fri, 09 May 2025 04:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746791471; x=1747396271; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MqyU7nBX5b7As71ha8OnebqHK1nffKwJGunuvXIhu2I=;
        b=ZyHSN98Vt+qf0waoF/0k7wR7OxjD+2/dSg7NW5akfabFPHc7mQkDiBEC83+ycNvw+4
         kZZwtyiey+nfPecoDUenTYPFFH0HfdjV3tjMWzMFj/+A7vk6SfQizzSiyn05r4+W0wCE
         FHL6GMK0FWu1d+/zOh51yJThUFTGUmL3+6gow/fUiQk8oH7wpZH2uGOK7kZSQn1xOAr5
         //iyO1/l/cEvs8P6fFV+ISp6oeDSsfa8q5KXfQCf0fY5//FM4Mw42rS2PsxgQQtsZ+wn
         drXsQGWa3BEIzKPiSM36xJsGU/+Ym/puID0g2MwqEJzZi4QbozAXJqDLO2TX7rctUePe
         0hYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746791471; x=1747396271;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MqyU7nBX5b7As71ha8OnebqHK1nffKwJGunuvXIhu2I=;
        b=ZD2Z45cp4rj+bazQqSMle+RcDk44lMDRV2Wpe6ghDEe/uDdo4aGI8yzuvlzWOwNOca
         vQtbNKyzWWIqprJEdln7N2WN8zNEu2Zc0kMvXi8VYWOXNChv0SPCJlIaL7vqMQLoiuNp
         trFA9EXAwKJ6u+Mufms9jIPWHActOLvzlUUIhErOp1s6dATSrZR8zfHUQcBFyA2XTgAD
         gQwISsd0bkfUP/RDMO0Y1UcwB3jt118skH1nhDg7lqiiMr2+Xrw7xc2bN+pcTqr8Jb9/
         3i0Cy9pt74R4/Ydxv4Fno5K5SBvru0wcWCHXgckcDW0JCHublrAXgzPWtTqqQ4lHGqiv
         dJwg==
X-Forwarded-Encrypted: i=1; AJvYcCVp5EIwGTl7mDZdikiWLbaWgILAQ06XaqY+fFuCAwZ4yvn0BjcP484BZYCsuQxSBieDTfOF9pYdxV+z3Y4=@vger.kernel.org, AJvYcCW1xTWw3j04XxRKAp+eiUnbzshKotSKeD7lFOFdBNuItiWDIhrE8ebSc5S0+VvAkWQG8iIESS8jv7/EVg==@vger.kernel.org
X-Gm-Message-State: AOJu0YySLCLikaK2s0mQbrmWJFC1/YRzVBRtdtM+QbVDB2b9LrMX8J3g
	9fK7p526UoumlTGfuxexuOH1ML578i4HLG6VtRR0W+YX+Lsz922Q
X-Gm-Gg: ASbGncuwWrjEczthHlpNrUGu/UQsrBG6SPcPgeBQvbvQ/GPEWBkOIlYj0AAgRsCbyFP
	CM/NzTBoRPhr2C/22fwTBTNgtUkkZy4K+oQvpCfuGA1afhpWdK7BATCJBgsjU00yml49xGJBo8j
	FTalLqRg79PEKyvgjW0Rquz7GTCrrtNWwgP5EN4GYzMdPkpeYd4wF3lKOJe0nzauppYdY4LDLo2
	ppiuFn8WuLqnKz01ySeWcEFIq5yVkxkKdWNDqRpYY8D98EsQet2Mhb9luPoIFpBGGxWBlGU6OKQ
	6bmgwSdsUwwB/3YXYETRX2tlnW/lByn988bg7BYiZD+YA8qV+WAX7Q4dwLdY7HU8MF0kNsab+u2
	iuH0V3feCEj3rVxpY
X-Google-Smtp-Source: AGHT+IHlwZ8wtdrMrrb74HbSxoC99AAVkvX+uqhHgeJFFxuOKhdZ56m9f1UMj5QnXDstzxudhFaXMg==
X-Received: by 2002:a05:6a00:9286:b0:736:9f20:a175 with SMTP id d2e1a72fcca58-7423bc1d44bmr4125142b3a.2.1746791471154;
        Fri, 09 May 2025 04:51:11 -0700 (PDT)
Received: from [192.168.11.2] (FL1-119-244-79-106.tky.mesh.ad.jp. [119.244.79.106])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74237a40589sm1617950b3a.145.2025.05.09.04.51.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 May 2025 04:51:10 -0700 (PDT)
Message-ID: <afe30f3a-4f1d-48b3-80d4-382a65829ba0@gmail.com>
Date: Fri, 9 May 2025 20:51:07 +0900
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-next v2 1/2] RDMA/rxe: Implement synchronous prefetch
 for ODP MRs
To: Zhu Yanjun <yanjun.zhu@linux.dev>, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org, leon@kernel.org, jgg@ziepe.ca,
 zyjzyj2000@gmail.com
References: <20250503134224.4867-1-dskmtsd@gmail.com>
 <20250503134224.4867-2-dskmtsd@gmail.com>
 <2e3676d3-ce82-4a87-be33-9ce6d7007c3b@linux.dev>
Content-Language: en-US
From: Daisuke Matsuda <dskmtsd@gmail.com>
In-Reply-To: <2e3676d3-ce82-4a87-be33-9ce6d7007c3b@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2025/05/05 16:57, Zhu Yanjun wrote:
> On 03.05.25 15:42, Daisuke Matsuda wrote:
>> Minimal implementation of ibv_advise_mr(3) requires synchronous calls being
>> successful with the IBV_ADVISE_MR_FLAG_FLUSH flag. Asynchronous requests,
>> which are best-effort, will be added subsequently.
>>
>> Signed-off-by: Daisuke Matsuda <dskmtsd@gmail.com>
>> ---
>>   drivers/infiniband/sw/rxe/rxe.c     |  7 +++
>>   drivers/infiniband/sw/rxe/rxe_loc.h | 10 ++++
>>   drivers/infiniband/sw/rxe/rxe_odp.c | 86 +++++++++++++++++++++++++++++
>>   3 files changed, 103 insertions(+)
>>
>> diff --git a/drivers/infiniband/sw/rxe/rxe.c b/drivers/infiniband/sw/rxe/rxe.c
>> index 3a77d6db1720..e891199cbdef 100644
>> --- a/drivers/infiniband/sw/rxe/rxe.c
>> +++ b/drivers/infiniband/sw/rxe/rxe.c
>> @@ -34,6 +34,10 @@ void rxe_dealloc(struct ib_device *ib_dev)
>>       mutex_destroy(&rxe->usdev_lock);
>>   }
>> +static const struct ib_device_ops rxe_ib_dev_odp_ops = {
>> +    .advise_mr = rxe_ib_advise_mr,
>> +};
>> +
>>   /* initialize rxe device parameters */
>>   static void rxe_init_device_param(struct rxe_dev *rxe, struct net_device *ndev)
>>   {
>> @@ -103,6 +107,9 @@ static void rxe_init_device_param(struct rxe_dev *rxe, struct net_device *ndev)
>>           rxe->attr.odp_caps.per_transport_caps.rc_odp_caps |= IB_ODP_SUPPORT_SRQ_RECV;
>>           rxe->attr.odp_caps.per_transport_caps.rc_odp_caps |= IB_ODP_SUPPORT_FLUSH;
>>           rxe->attr.odp_caps.per_transport_caps.rc_odp_caps |= IB_ODP_SUPPORT_ATOMIC_WRITE;
>> +
>> +        /* set handler for ODP prefetching API - ibv_advise_mr(3) */
>> +        ib_set_device_ops(&rxe->ib_dev, &rxe_ib_dev_odp_ops);
>>       }
>>   }
>> diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
>> index f7dbb9cddd12..21b070f3dbb8 100644
>> --- a/drivers/infiniband/sw/rxe/rxe_loc.h
>> +++ b/drivers/infiniband/sw/rxe/rxe_loc.h
>> @@ -197,6 +197,9 @@ enum resp_states rxe_odp_atomic_op(struct rxe_mr *mr, u64 iova, int opcode,
>>   int rxe_odp_flush_pmem_iova(struct rxe_mr *mr, u64 iova,
>>                   unsigned int length);
>>   enum resp_states rxe_odp_do_atomic_write(struct rxe_mr *mr, u64 iova, u64 value);
>> +int rxe_ib_advise_mr(struct ib_pd *pd, enum ib_uverbs_advise_mr_advice advice,
>> +             u32 flags, struct ib_sge *sg_list, u32 num_sge,
>> +             struct uverbs_attr_bundle *attrs);
>>   #else /* CONFIG_INFINIBAND_ON_DEMAND_PAGING */
>>   static inline int
>>   rxe_odp_mr_init_user(struct rxe_dev *rxe, u64 start, u64 length, u64 iova,
>> @@ -225,6 +228,13 @@ static inline enum resp_states rxe_odp_do_atomic_write(struct rxe_mr *mr,
>>   {
>>       return RESPST_ERR_UNSUPPORTED_OPCODE;
>>   }
>> +static inline int rxe_ib_advise_mr(struct ib_pd *pd, enum ib_uverbs_advise_mr_advice advice,
>> +                   u32 flags, struct ib_sge *sg_list, u32 num_sge,
>> +                   struct uverbs_attr_bundle *attrs)
>> +{
>> +    return -EOPNOTSUPP;
>> +}
>> +
>>   #endif /* CONFIG_INFINIBAND_ON_DEMAND_PAGING */
>>   #endif /* RXE_LOC_H */
>> diff --git a/drivers/infiniband/sw/rxe/rxe_odp.c b/drivers/infiniband/sw/rxe/rxe_odp.c
>> index 6149d9ffe7f7..e5c60b061d7e 100644
>> --- a/drivers/infiniband/sw/rxe/rxe_odp.c
>> +++ b/drivers/infiniband/sw/rxe/rxe_odp.c
>> @@ -424,3 +424,89 @@ enum resp_states rxe_odp_do_atomic_write(struct rxe_mr *mr, u64 iova, u64 value)
>>       return RESPST_NONE;
>>   }
>> +
>> +static int rxe_ib_prefetch_sg_list(struct ib_pd *ibpd,
>> +                   enum ib_uverbs_advise_mr_advice advice,
>> +                   u32 pf_flags, struct ib_sge *sg_list,
>> +                   u32 num_sge)
>> +{
>> +    struct rxe_pd *pd = container_of(ibpd, struct rxe_pd, ibpd);
>> +    unsigned int i;
>> +    int ret = 0;
>> +
>> +    for (i = 0; i < num_sge; ++i) {
> 
> i is unsigned int, num_sge is u32. Perhaps they all use u32 type?
> It is a minor problem.

Since we have dropped support for 32-bit archtectures,
these types should practically be identical.

> Other than that, I am fine with this commit.
> 
> I have made tests with rdma-core. Both the synchronous and asynchrounos modes can work well.

Thank you for the review and testing.

Daisuke

> 
> Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> 
> Zhu Yanjun
> 
>> +        struct rxe_mr *mr;
>> +        struct ib_umem_odp *umem_odp;
>> +
>> +        mr = lookup_mr(pd, IB_ACCESS_LOCAL_WRITE,
>> +                   sg_list[i].lkey, RXE_LOOKUP_LOCAL);
>> +
>> +        if (IS_ERR(mr)) {
>> +            rxe_dbg_pd(pd, "mr with lkey %x not found\n", sg_list[i].lkey);
>> +            return PTR_ERR(mr);
>> +        }
>> +
>> +        if (advice == IB_UVERBS_ADVISE_MR_ADVICE_PREFETCH_WRITE &&
>> +            !mr->umem->writable) {
>> +            rxe_dbg_mr(mr, "missing write permission\n");
>> +            rxe_put(mr);
>> +            return -EPERM;
>> +        }
>> +
>> +        ret = rxe_odp_do_pagefault_and_lock(mr, sg_list[i].addr,
>> +                            sg_list[i].length, pf_flags);
>> +        if (ret < 0) {
>> +            if (sg_list[i].length == 0)
>> +                continue;
>> +
>> +            rxe_dbg_mr(mr, "failed to prefetch the mr\n");
>> +            rxe_put(mr);
>> +            return ret;
>> +        }
>> +
>> +        umem_odp = to_ib_umem_odp(mr->umem);
>> +        mutex_unlock(&umem_odp->umem_mutex);
>> +
>> +        rxe_put(mr);
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>> +static int rxe_ib_advise_mr_prefetch(struct ib_pd *ibpd,
>> +                     enum ib_uverbs_advise_mr_advice advice,
>> +                     u32 flags, struct ib_sge *sg_list, u32 num_sge)
>> +{
>> +    u32 pf_flags = RXE_PAGEFAULT_DEFAULT;
>> +
>> +    if (advice == IB_UVERBS_ADVISE_MR_ADVICE_PREFETCH)
>> +        pf_flags |= RXE_PAGEFAULT_RDONLY;
>> +
>> +    if (advice == IB_UVERBS_ADVISE_MR_ADVICE_PREFETCH_NO_FAULT)
>> +        pf_flags |= RXE_PAGEFAULT_SNAPSHOT;
>> +
>> +    /* Synchronous call */
>> +    if (flags & IB_UVERBS_ADVISE_MR_FLAG_FLUSH)
>> +        return rxe_ib_prefetch_sg_list(ibpd, advice, pf_flags, sg_list,
>> +                           num_sge);
>> +
>> +    /* Asynchronous call is "best-effort" */
>> +
>> +    return 0;
>> +}
>> +
>> +int rxe_ib_advise_mr(struct ib_pd *ibpd,
>> +             enum ib_uverbs_advise_mr_advice advice,
>> +             u32 flags,
>> +             struct ib_sge *sg_list,
>> +             u32 num_sge,
>> +             struct uverbs_attr_bundle *attrs)
>> +{
>> +    if (advice != IB_UVERBS_ADVISE_MR_ADVICE_PREFETCH &&
>> +        advice != IB_UVERBS_ADVISE_MR_ADVICE_PREFETCH_WRITE &&
>> +        advice != IB_UVERBS_ADVISE_MR_ADVICE_PREFETCH_NO_FAULT)
>> +        return -EOPNOTSUPP;
>> +
>> +    return rxe_ib_advise_mr_prefetch(ibpd, advice, flags,
>> +                     sg_list, num_sge);
>> +}
> 


