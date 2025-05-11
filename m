Return-Path: <linux-rdma+bounces-10260-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B19C6AB2623
	for <lists+linux-rdma@lfdr.de>; Sun, 11 May 2025 04:06:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26BA51775C4
	for <lists+linux-rdma@lfdr.de>; Sun, 11 May 2025 02:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2341149C4A;
	Sun, 11 May 2025 02:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YwDp4Pwk"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04DD813DDAE;
	Sun, 11 May 2025 02:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746929177; cv=none; b=HgWYa9LhOAcmftkOMWVGujwixvzTnl6atny4nq7zrrTm/ne8XJvKCSRKvvTGUPLmh94FlXE7PwsGibTi+3xdsUsgyHbyp/sFFD9s0KkBYzthpdSmOwy/FjQV6nuUMKqSJ8LPVdrPonyP1UC/CCYM/MzGNCxrCub67l9IF9BM48E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746929177; c=relaxed/simple;
	bh=98ndXhCnbe6LuYyNNE6H1LDju9kSaG2YoNkqcDH7Iis=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ty/AIwDzFlVY/6iW7REyTYA0EBEkxv1rp8+f8hBOWIIbmFIuj+n7w9k2OcUaxNerw5uL5hTEOudC2P/538nF407EZ5dsw7vkzyLd4ml5C0nEE5ABy4LLngpIQV6PHVSGD4KzWEyUH3PltIuwkgvTUjEuyV4yam+kPSxZkTB0HCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YwDp4Pwk; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-74068f95d9fso3152989b3a.0;
        Sat, 10 May 2025 19:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746929174; x=1747533974; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7xavpdlV7cZBxk/OGVYz5UUZOuq06Pk4hE0oN3K/Zfw=;
        b=YwDp4Pwkxup8526m8jSbAlXB3XpcGFNVaXEbyZ6Hns9K5O8wjlxENqvinDooWSDM7T
         50muYBzBhg4NbFFw3cylWDp8ewMdnfs945Oh/nSakJmEqkkeEi2DUz2rKajryLaGORBx
         VA9LKOH3l7ePur6EurlTf3Voad2KZiMV6QynMvwL2MNqbIWP3kpgJq0GzOLOhB+W1ZKJ
         RDNhzzGeBsJmAQYRHFtGMx5e22RrUWnZ090mMiKi/FFXu7LeC8oS5k4155uMDM/fjvtZ
         WebOlLV5Tyh3l8BSUpH8a2TzQRJrvOxARfvHL6EiGklB+mgiittAFaPdSdeejRvE+eDn
         /reQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746929174; x=1747533974;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7xavpdlV7cZBxk/OGVYz5UUZOuq06Pk4hE0oN3K/Zfw=;
        b=NjUUiqbdH0TD7T6qTyCoe2RAsqGBW8hDkOnTGmhX/5qOb+vXUyWSKiioSoRWQaMfKX
         2FomytKvFa8MX8ux6JZ8ifRE0mXCG1DDIJzZqWwP4E5E6TLZNru7UMmeUDyNrI+/dZ/0
         872ThBV8awCtQJV39lwPucE6YNdc4sE01htYvaSbiHi4IjknjJlwD0ySsaLf0th7XKjt
         morhzsUck71Y8Clnr6YDmk7MqprAWrrLd4Ey5abyZRbILMhivaylVWDqWXf8/JHOB1e7
         gJgEqCEcM/xqK0WOVnX3YWWEYgLbuCTSqiiWdzFrJ0eLo2BNMlE0/5xUJxw9XWPfBY2d
         N6NA==
X-Forwarded-Encrypted: i=1; AJvYcCXC+Sm1rydLLl/2tFetRahUrTCXq7CcODH6IFF5GaG1k1XCUoO9YJzqHKBumwdqCw8T4DpqW8DPhQyw@vger.kernel.org
X-Gm-Message-State: AOJu0YzGVi4tmIwKKo91TGlnCDSX52jVrd9L35PiDyWs1ZHzW5q37o7x
	UX/Ja9X3dkLzsqwNzq2hMI8lhpRDv11kg1zmuvx8aO9QKlPhboZCeJ1ltSHD
X-Gm-Gg: ASbGncssw7ffGfcPMOOEjRy+MM2/2YyO4VaHkM5+YdT/wG6pb4iBTOPI9CRNkJpZyII
	OXtK2ICUAT7ODQ8yRudEqhP6H3IXycmFljB0FQFjpQezI9hOS5kcZzveJP6MuuHy4Zkd/Hy9Xc8
	fd3PXJxmqzaSiKzBrnEWwFIjmttnRofdDe3OK2wWrQpBeCE8GVO2IR3aOwtcSDwmJolY8T8NMQD
	pFZlAombl9T/+35kHmG33AQK8xmZym6JKNPx9+yzVRTsGhZyuiZC9gDCLE1azwG0Aa9iddrsZCm
	oZWccAv8fRhkyunZJjjNAdRHnG6U2eHTSsCVUu/fG6aqAp96YUQxhy/DhS7hgA1CQm+ZfmlU4FB
	+P4zShzr6vivw5G6PMYXYHAtKC9g=
X-Google-Smtp-Source: AGHT+IG59iG8A7MD1sK3fSO5fSEoZoJUba/xi7xuXaniABm9s3GW5wuIhJG2Iob+UQ9SFMlFow2V3g==
X-Received: by 2002:a05:6a21:6d96:b0:1f3:397d:86f1 with SMTP id adf61e73a8af0-215abb03faemr10677349637.16.1746929173967;
        Sat, 10 May 2025 19:06:13 -0700 (PDT)
Received: from [192.168.11.2] (FL1-119-244-79-106.tky.mesh.ad.jp. [119.244.79.106])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74237704ff3sm3795155b3a.1.2025.05.10.19.06.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 May 2025 19:06:13 -0700 (PDT)
Message-ID: <ad917c1c-2508-41eb-ae5a-8b4fcd97ca7f@gmail.com>
Date: Sun, 11 May 2025 11:06:10 +0900
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-next v2 1/2] RDMA/rxe: Implement synchronous prefetch
 for ODP MRs
To: Zhu Yanjun <yanjun.zhu@linux.dev>
Cc: linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
 leon@kernel.org, jgg@ziepe.ca, zyjzyj2000@gmail.com
References: <20250503134224.4867-1-dskmtsd@gmail.com>
 <20250503134224.4867-2-dskmtsd@gmail.com>
 <cdea578b-5570-4a8d-98cc-61081a281a84@linux.dev>
 <b5560914-e613-499d-88c8-82f5255a1dd1@gmail.com>
 <093ee42f-4dd5-4f52-b7a5-ba5e22b18bdc@linux.dev>
 <e07e0ad8-32da-452e-809a-f3dfeb8b56f3@gmail.com>
 <CAEz=LcutW6BZKB-Def3HmV=WrzjKjmAt_WnxPw3Yu45CoV0+Hw@mail.gmail.com>
Content-Language: en-US
From: Daisuke Matsuda <dskmtsd@gmail.com>
In-Reply-To: <CAEz=LcutW6BZKB-Def3HmV=WrzjKjmAt_WnxPw3Yu45CoV0+Hw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2025/05/10 17:04, Greg Sword wrote:
> On Sat, May 10, 2025 at 3:19 PM Daisuke Matsuda <dskmtsd@gmail.com> wrote:
>>
>> On 2025/05/10 13:43, Zhu Yanjun wrote:
>>>
>>> 在 2025/5/10 4:46, Daisuke Matsuda 写道:
>>>> On 2025/05/10 0:19, Zhu Yanjun wrote:
>>>>> On 03.05.25 15:42, Daisuke Matsuda wrote:
>>>>>> Minimal implementation of ibv_advise_mr(3) requires synchronous calls being
>>>>>> successful with the IBV_ADVISE_MR_FLAG_FLUSH flag. Asynchronous requests,
>>>>>> which are best-effort, will be added subsequently.
>>>>>>
>>>>>> Signed-off-by: Daisuke Matsuda <dskmtsd@gmail.com>
>>>>>> ---
>>>>>>    drivers/infiniband/sw/rxe/rxe.c     |  7 +++
>>>>>>    drivers/infiniband/sw/rxe/rxe_loc.h | 10 ++++
>>>>>>    drivers/infiniband/sw/rxe/rxe_odp.c | 86 +++++++++++++++++++++++++++++
>>>>>>    3 files changed, 103 insertions(+)
>>>>>>
>>>>>> diff --git a/drivers/infiniband/sw/rxe/rxe.c b/drivers/infiniband/sw/rxe/rxe.c
>>>>>> index 3a77d6db1720..e891199cbdef 100644
>>>>>> --- a/drivers/infiniband/sw/rxe/rxe.c
>>>>>> +++ b/drivers/infiniband/sw/rxe/rxe.c
>>>>>> @@ -34,6 +34,10 @@ void rxe_dealloc(struct ib_device *ib_dev)
>>>>>>        mutex_destroy(&rxe->usdev_lock);
>>>>>>    }
>>>>>> +static const struct ib_device_ops rxe_ib_dev_odp_ops = {
>>>>>> +    .advise_mr = rxe_ib_advise_mr,
>>>>>> +};
>>>>>> +
>>>>>>    /* initialize rxe device parameters */
>>>>>>    static void rxe_init_device_param(struct rxe_dev *rxe, struct net_device *ndev)
>>>>>>    {
>>>>>> @@ -103,6 +107,9 @@ static void rxe_init_device_param(struct rxe_dev *rxe, struct net_device *ndev)
>>>>>>            rxe->attr.odp_caps.per_transport_caps.rc_odp_caps |= IB_ODP_SUPPORT_SRQ_RECV;
>>>>>>            rxe->attr.odp_caps.per_transport_caps.rc_odp_caps |= IB_ODP_SUPPORT_FLUSH;
>>>>>>            rxe->attr.odp_caps.per_transport_caps.rc_odp_caps |= IB_ODP_SUPPORT_ATOMIC_WRITE;
>>>>>> +
>>>>>> +        /* set handler for ODP prefetching API - ibv_advise_mr(3) */
>>>>>> +        ib_set_device_ops(&rxe->ib_dev, &rxe_ib_dev_odp_ops);
>>>>>>        }
>>>>>>    }
>>>>>> diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
>>>>>> index f7dbb9cddd12..21b070f3dbb8 100644
>>>>>> --- a/drivers/infiniband/sw/rxe/rxe_loc.h
>>>>>> +++ b/drivers/infiniband/sw/rxe/rxe_loc.h
>>>>>> @@ -197,6 +197,9 @@ enum resp_states rxe_odp_atomic_op(struct rxe_mr *mr, u64 iova, int opcode,
>>>>>>    int rxe_odp_flush_pmem_iova(struct rxe_mr *mr, u64 iova,
>>>>>>                    unsigned int length);
>>>>>>    enum resp_states rxe_odp_do_atomic_write(struct rxe_mr *mr, u64 iova, u64 value);
>>>>>> +int rxe_ib_advise_mr(struct ib_pd *pd, enum ib_uverbs_advise_mr_advice advice,
>>>>>> +             u32 flags, struct ib_sge *sg_list, u32 num_sge,
>>>>>> +             struct uverbs_attr_bundle *attrs);
>>>>>>    #else /* CONFIG_INFINIBAND_ON_DEMAND_PAGING */
>>>>>>    static inline int
>>>>>>    rxe_odp_mr_init_user(struct rxe_dev *rxe, u64 start, u64 length, u64 iova,
>>>>>> @@ -225,6 +228,13 @@ static inline enum resp_states rxe_odp_do_atomic_write(struct rxe_mr *mr,
>>>>>>    {
>>>>>>        return RESPST_ERR_UNSUPPORTED_OPCODE;
>>>>>>    }
>>>>>> +static inline int rxe_ib_advise_mr(struct ib_pd *pd, enum ib_uverbs_advise_mr_advice advice,
>>>>>> +                   u32 flags, struct ib_sge *sg_list, u32 num_sge,
>>>>>> +                   struct uverbs_attr_bundle *attrs)
>>>>>> +{
>>>>>> +    return -EOPNOTSUPP;
>>>>>> +}
>>>>>> +
>>>>>>    #endif /* CONFIG_INFINIBAND_ON_DEMAND_PAGING */
>>>>>>    #endif /* RXE_LOC_H */
>>>>>> diff --git a/drivers/infiniband/sw/rxe/rxe_odp.c b/drivers/infiniband/sw/rxe/rxe_odp.c
>>>>>> index 6149d9ffe7f7..e5c60b061d7e 100644
>>>>>> --- a/drivers/infiniband/sw/rxe/rxe_odp.c
>>>>>> +++ b/drivers/infiniband/sw/rxe/rxe_odp.c
>>>>>> @@ -424,3 +424,89 @@ enum resp_states rxe_odp_do_atomic_write(struct rxe_mr *mr, u64 iova, u64 value)
>>>>>>        return RESPST_NONE;
>>>>>>    }
>>>>>> +
>>>>>> +static int rxe_ib_prefetch_sg_list(struct ib_pd *ibpd,
>>>>>> +                   enum ib_uverbs_advise_mr_advice advice,
>>>>>> +                   u32 pf_flags, struct ib_sge *sg_list,
>>>>>> +                   u32 num_sge)
>>>>>> +{
>>>>>> +    struct rxe_pd *pd = container_of(ibpd, struct rxe_pd, ibpd);
>>>>>> +    unsigned int i;
>>>>>> +    int ret = 0;
>>>>>> +
>>>>>> +    for (i = 0; i < num_sge; ++i) {
>>>>>> +        struct rxe_mr *mr;
>>>>>> +        struct ib_umem_odp *umem_odp;
>>>>>> +
>>>>>> +        mr = lookup_mr(pd, IB_ACCESS_LOCAL_WRITE,
>>>>>> +                   sg_list[i].lkey, RXE_LOOKUP_LOCAL);
>>>>>> +
>>>>>> +        if (IS_ERR(mr)) {
>>>>>> +            rxe_dbg_pd(pd, "mr with lkey %x not found\n", sg_list[i].lkey);
>>>>>> +            return PTR_ERR(mr);
>>>>>> +        }
>>>>>> +
>>>>>> +        if (advice == IB_UVERBS_ADVISE_MR_ADVICE_PREFETCH_WRITE &&
>>>>>> +            !mr->umem->writable) {
>>>>>> +            rxe_dbg_mr(mr, "missing write permission\n");
>>>>>> +            rxe_put(mr);
>>>>>> +            return -EPERM;
>>>>>> +        }
>>>>>> +
>>>>>> +        ret = rxe_odp_do_pagefault_and_lock(mr, sg_list[i].addr,
>>>>>> +                            sg_list[i].length, pf_flags);
>>>>>> +        if (ret < 0) {
>>>>>> +            if (sg_list[i].length == 0)
>>>>>> +                continue;
>>>>>> +
>>>>>> +            rxe_dbg_mr(mr, "failed to prefetch the mr\n");
>>>>>> +            rxe_put(mr);
>>>>>> +            return ret;
>>>>>> +        }
>>>>>> +
>>>>>> +        umem_odp = to_ib_umem_odp(mr->umem);
>>>>>> +        mutex_unlock(&umem_odp->umem_mutex);
>>>>>> +
>>>>>> +        rxe_put(mr);
>>>>>> +    }
>>>>>> +
>>>>>> +    return 0;
>>>>>> +}
>>>>>> +
>>>>>> +static int rxe_ib_advise_mr_prefetch(struct ib_pd *ibpd,
>>>>>> +                     enum ib_uverbs_advise_mr_advice advice,
>>>>>> +                     u32 flags, struct ib_sge *sg_list, u32 num_sge)
>>>>>> +{
>>>>>> +    u32 pf_flags = RXE_PAGEFAULT_DEFAULT;
>>>>>> +
>>>>>> +    if (advice == IB_UVERBS_ADVISE_MR_ADVICE_PREFETCH)
>>>>>> +        pf_flags |= RXE_PAGEFAULT_RDONLY;
>>>>>> +
>>>>>> +    if (advice == IB_UVERBS_ADVISE_MR_ADVICE_PREFETCH_NO_FAULT)
>>>>>> +        pf_flags |= RXE_PAGEFAULT_SNAPSHOT;
>>>>>> +
>>>>>> +    /* Synchronous call */
>>>>>> +    if (flags & IB_UVERBS_ADVISE_MR_FLAG_FLUSH)
>>>>>> +        return rxe_ib_prefetch_sg_list(ibpd, advice, pf_flags, sg_list,
>>>>>> +                           num_sge);
>>>>>> +
>>>>>> +    /* Asynchronous call is "best-effort" */
>>>>>
>>>>> Asynchronous call is not implemented now, why does this comment appear?
>>>>
>>>> Even without the 2nd patch, async calls are reported as successful.
>>>
>>>
>>> Async call is not implemented. How to call "async calls are reported as successful"?
>>
>> Please see the manual.
>> cf. https://manpages.debian.org/testing/libibverbs-dev/ibv_advise_mr.3.en.html
>>
>> If IBV_ADVISE_MR_FLAG_FLUSH is not given to 'flags' parameter,
>> then this function 'rxe_ib_advise_mr_prefetch()' simply returns 0.
>> Consequently, ibv_advise_mr(3) and underlying ioctl(2) get no error.
>> This behaviour is allowd in the spec as I quoted in the last reply.
> 
> The functionality wasn't implemented, you added the comments first.
> You're still weaseling when people point this out.
> 
>>
>> It might be nice to return -EOPNOTSUPP just below the comment instead,
>> but not doing so is acceptable according to the spec. Additionally,
>> such change will be overwritten in the next patch after all.
> 
> Move comments to the next patch. In this patch, return -EOPNOTSUPP.

Any opinion from Zhu?
I may post a new revision to change the intermediate code,
but the final result after applying the patchset will be the same.
You are the maintainer of rxe, so I will follow that.

Thanks,
Daisuke


> 
> --G--
> 
>>
>> Thanks,
>> Daisuke
>>
>>>
>>>
>>> Zhu Yanjun
>>>
>>>> The comment is inserted to show the reason, which is based on the
>>>> description from 'man 3 ibv_advise_mr' as follows:
>>>> ===
>>>> An application may pre-fetch any address range within an ODP MR when using the IBV_ADVISE_MR_ADVICE_PREFETCH or IBV_ADVISE_MR_ADVICE_PREFETCH_WRITE advice. Semantically, this operation is best-effort. That means the kernel does not guarantee that underlying pages are updated in the HCA or the pre-fetched pages would remain resident.
>>>> ===
>>>>
>>>> Thanks,
>>>> Daisuke
>>>>
>>>>>
>>>>> Zhu Yanjun
>>>>>
>>>>>> +
>>>>>> +    return 0;
>>>>>> +}
>>>>>> +
>>>>>> +int rxe_ib_advise_mr(struct ib_pd *ibpd,
>>>>>> +             enum ib_uverbs_advise_mr_advice advice,
>>>>>> +             u32 flags,
>>>>>> +             struct ib_sge *sg_list,
>>>>>> +             u32 num_sge,
>>>>>> +             struct uverbs_attr_bundle *attrs)
>>>>>> +{
>>>>>> +    if (advice != IB_UVERBS_ADVISE_MR_ADVICE_PREFETCH &&
>>>>>> +        advice != IB_UVERBS_ADVISE_MR_ADVICE_PREFETCH_WRITE &&
>>>>>> +        advice != IB_UVERBS_ADVISE_MR_ADVICE_PREFETCH_NO_FAULT)
>>>>>> +        return -EOPNOTSUPP;
>>>>>> +
>>>>>> +    return rxe_ib_advise_mr_prefetch(ibpd, advice, flags,
>>>>>> +                     sg_list, num_sge);
>>>>>> +}
>>>>>
>>>>
>>
>>


