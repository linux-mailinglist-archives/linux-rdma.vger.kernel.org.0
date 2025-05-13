Return-Path: <linux-rdma+bounces-10315-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38776AB4AF0
	for <lists+linux-rdma@lfdr.de>; Tue, 13 May 2025 07:23:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70A7C8C1618
	for <lists+linux-rdma@lfdr.de>; Tue, 13 May 2025 05:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 579D71E5200;
	Tue, 13 May 2025 05:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H9o+8IxV"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 546081E3DE5;
	Tue, 13 May 2025 05:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747113803; cv=none; b=RQ0gylpXiawb0lbPyjPF0CM6y885EsCfrfFz+qf+wc17Rp2SDbN6vCMHhb6g4aSXyOWNq63J97e/KLTWTDhBvgmPT+9EBJYr4Wff9FWzJ4e5H60LxXzR0mL1jVC3q++dIMJ8j1DrbpUzh+xgTneVQYFkp5EWgpYa0h4gqkmnTcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747113803; c=relaxed/simple;
	bh=aE8ztuB3Eqeqn5wiysT2iC/+hyLn74AWp47PIUslqkc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mc7IOM4Iqv0zyKBwqKm+Z4Xtoku0AHv5p5S29Sr8LgEHLSXTxfoubYzwFV5mlfbeAsux/osnKq1lZG5OGrs16Y4NLDUwyLf9LjtjZyGQf9vtGKtvRYF9KUzwz1fjCp4cyM2iC4rzQpJqDgMgetKI8yIIWqi1xGPYWIMN9jdn7Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H9o+8IxV; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-30a8c929220so4278199a91.0;
        Mon, 12 May 2025 22:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747113800; x=1747718600; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yQisTrxwC/Vl5fN/D8+UckrSbUIKShKukgNP8WEycMA=;
        b=H9o+8IxVn+9KNCBXL2YGMjRF7BovlOSiDbhAR0a4J7SklSzMjRXyzbu2YKQHnaCMIC
         lA713UkVMg0AFLvoi08HSTZdkY0bDDd+6vvkW/8Fi6GTjOuD9vBY1ADY3+QDju/hcjXC
         k+yOx1zsil8O+q/iI3r1FThq3Vz7w6bAfowu8ivAv+ygN07QYHL8rxKE7IWtUmDjzd0R
         oScNb7PXHmc7KwSEGyHJvulsqu+sR7fcSp4uXIOmzMLGhmBBNSSouQw6hp7Fhvxjlqk0
         +HmVBI+5D29oaQmY3EtSZ+bJHm94hdJH8T+TeP2nAtGBiJmtTRKBy1cuobjm5sMzP5Tu
         42bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747113800; x=1747718600;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yQisTrxwC/Vl5fN/D8+UckrSbUIKShKukgNP8WEycMA=;
        b=qc9N+wIFbvTtaeUhLQWuQIMsQBEFXGzE58iNFueS9TXuBibXUw6LHozePxnb7Yyvnn
         HwShlK6habQYlXxBPjYHVWJW9Kt1MP6lTwu14PEuabFv7Dh/B+iM6jrOmGgEUwhfQwI6
         Q4oDAamVp12YdW/ZL3EFw4sxwre447XEOr68h51NMtBbIX09xJ+1rmN32zJjPwAuICmp
         GGzOdbDaQCBTv+t6oLWwMo0lwqrf+KJbyRuFwIbUNPMRevMZa48s8Bg670fpjtXe7JdY
         QeMnahz9JJpnd7KsTol0j2z9tmFY5fyQMo7NpGhkkhmV6VnsEe4zRezo0q+1t7LyuWVj
         XeoQ==
X-Forwarded-Encrypted: i=1; AJvYcCUhqOGtRhm7MV+NqeO5GrSQSxAAO/kcc4XXqoVCS8qI12ndjY2zCRygv70LCb2esJ+4w0JjN8BugQWm@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1VQyL9jj9BgHoF1SnEEPds4MaQ3RAvtZAZ3L456jiPt7RHgqc
	Me6j6daomsvjQi1Ioke5kky7LCmvMT5kiRwlGuSjECepw5S4Q3P4jLOTpMHx
X-Gm-Gg: ASbGncsmJInrE7GEPt1czH/Df+PeAA14iJ8sw55os5qQAFRcHdxMxeqjzaD4JGa6H61
	tEmZBv1f9KGq5T6C8vjL/SkAxGkaESucp9VJ4R1eAX+SnWhp2FL34EMZTkSfHhmjgUSpIe5ivws
	0C9XtjCtMOMJ7Lj+A/XT0h7g+0UBUDSKbrf0T2rwLKg3xOoSXbdyaetttaYqZSKZXGpZDhdnwSL
	mSK4GQkuHoY1SLTlTt3L4RLbdBo+ufIj/x3tzjF+aZOkVjfxNrh/2hdCZHPEAdcLi/py/m5VC2e
	w75C7rR+Jxf2PEooSel7BcgWDLJ6Vj4bPz2qrhhCVRK6RllRFdZuryqJhIMG9M/SCllSJ6gbLSu
	jmctqYC+C0I/P7mrE5VNuGQNF7nI=
X-Google-Smtp-Source: AGHT+IFPZzFgALlgRXL53V1F4nuJumyPijThB62BcwxNiLZj9TZ85tqMnN8xvWT7OAcubIqDQb9ktw==
X-Received: by 2002:a17:90b:3c06:b0:2ff:5ec1:6c6a with SMTP id 98e67ed59e1d1-30c3d3e8dd3mr28274066a91.18.1747113800248;
        Mon, 12 May 2025 22:23:20 -0700 (PDT)
Received: from [192.168.11.2] (FL1-119-244-79-106.tky.mesh.ad.jp. [119.244.79.106])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30c39e607dasm8353102a91.35.2025.05.12.22.23.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 May 2025 22:23:19 -0700 (PDT)
Message-ID: <c30a327d-c9bf-4683-b05f-588f5ff6ab3f@gmail.com>
Date: Tue, 13 May 2025 14:23:17 +0900
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
 <ad917c1c-2508-41eb-ae5a-8b4fcd97ca7f@gmail.com>
 <c009c4e5-418c-444d-8609-0475f3864ed9@linux.dev>
Content-Language: en-US
From: Daisuke Matsuda <dskmtsd@gmail.com>
In-Reply-To: <c009c4e5-418c-444d-8609-0475f3864ed9@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2025/05/11 13:52, Zhu Yanjun wrote:
> 在 2025/5/11 4:06, Daisuke Matsuda 写道:
>>
>> On 2025/05/10 17:04, Greg Sword wrote:
>>> On Sat, May 10, 2025 at 3:19 PM Daisuke Matsuda <dskmtsd@gmail.com> wrote:
>>>>
>>>> On 2025/05/10 13:43, Zhu Yanjun wrote:
>>>>>
>>>>> 在 2025/5/10 4:46, Daisuke Matsuda 写道:
>>>>>> On 2025/05/10 0:19, Zhu Yanjun wrote:
>>>>>>> On 03.05.25 15:42, Daisuke Matsuda wrote:
>>>>>>>> Minimal implementation of ibv_advise_mr(3) requires synchronous calls being
>>>>>>>> successful with the IBV_ADVISE_MR_FLAG_FLUSH flag. Asynchronous requests,
>>>>>>>> which are best-effort, will be added subsequently.
>>>>>>>>
>>>>>>>> Signed-off-by: Daisuke Matsuda <dskmtsd@gmail.com>
>>>>>>>> ---
>>>>>>>>    drivers/infiniband/sw/rxe/rxe.c     |  7 +++
>>>>>>>>    drivers/infiniband/sw/rxe/rxe_loc.h | 10 ++++
>>>>>>>>    drivers/infiniband/sw/rxe/rxe_odp.c | 86 +++++++++++++++++++++ ++++++++
>>>>>>>>    3 files changed, 103 insertions(+)
>>>>>>>>
>>>>>>>> diff --git a/drivers/infiniband/sw/rxe/rxe.c b/drivers/ infiniband/sw/rxe/rxe.c
>>>>>>>> index 3a77d6db1720..e891199cbdef 100644
>>>>>>>> --- a/drivers/infiniband/sw/rxe/rxe.c
>>>>>>>> +++ b/drivers/infiniband/sw/rxe/rxe.c
>>>>>>>> @@ -34,6 +34,10 @@ void rxe_dealloc(struct ib_device *ib_dev)
>>>>>>>>        mutex_destroy(&rxe->usdev_lock);
>>>>>>>>    }
>>>>>>>> +static const struct ib_device_ops rxe_ib_dev_odp_ops = {
>>>>>>>> +    .advise_mr = rxe_ib_advise_mr,
>>>>>>>> +};
>>>>>>>> +
>>>>>>>>    /* initialize rxe device parameters */
>>>>>>>>    static void rxe_init_device_param(struct rxe_dev *rxe, struct net_device *ndev)
>>>>>>>>    {
>>>>>>>> @@ -103,6 +107,9 @@ static void rxe_init_device_param(struct rxe_dev *rxe, struct net_device *ndev)
>>>>>>>>            rxe->attr.odp_caps.per_transport_caps.rc_odp_caps |= IB_ODP_SUPPORT_SRQ_RECV;
>>>>>>>>            rxe->attr.odp_caps.per_transport_caps.rc_odp_caps |= IB_ODP_SUPPORT_FLUSH;
>>>>>>>>            rxe->attr.odp_caps.per_transport_caps.rc_odp_caps |= IB_ODP_SUPPORT_ATOMIC_WRITE;
>>>>>>>> +
>>>>>>>> +        /* set handler for ODP prefetching API - ibv_advise_mr(3) */
>>>>>>>> +        ib_set_device_ops(&rxe->ib_dev, &rxe_ib_dev_odp_ops);
>>>>>>>>        }
>>>>>>>>    }
>>>>>>>> diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/ infiniband/sw/rxe/rxe_loc.h
>>>>>>>> index f7dbb9cddd12..21b070f3dbb8 100644
>>>>>>>> --- a/drivers/infiniband/sw/rxe/rxe_loc.h
>>>>>>>> +++ b/drivers/infiniband/sw/rxe/rxe_loc.h
>>>>>>>> @@ -197,6 +197,9 @@ enum resp_states rxe_odp_atomic_op(struct rxe_mr *mr, u64 iova, int opcode,
>>>>>>>>    int rxe_odp_flush_pmem_iova(struct rxe_mr *mr, u64 iova,
>>>>>>>>                    unsigned int length);
>>>>>>>>    enum resp_states rxe_odp_do_atomic_write(struct rxe_mr *mr, u64 iova, u64 value);
>>>>>>>> +int rxe_ib_advise_mr(struct ib_pd *pd, enum ib_uverbs_advise_mr_advice advice,
>>>>>>>> +             u32 flags, struct ib_sge *sg_list, u32 num_sge,
>>>>>>>> +             struct uverbs_attr_bundle *attrs);
>>>>>>>>    #else /* CONFIG_INFINIBAND_ON_DEMAND_PAGING */
>>>>>>>>    static inline int
>>>>>>>>    rxe_odp_mr_init_user(struct rxe_dev *rxe, u64 start, u64 length, u64 iova,
>>>>>>>> @@ -225,6 +228,13 @@ static inline enum resp_states rxe_odp_do_atomic_write(struct rxe_mr *mr,
>>>>>>>>    {
>>>>>>>>        return RESPST_ERR_UNSUPPORTED_OPCODE;
>>>>>>>>    }
>>>>>>>> +static inline int rxe_ib_advise_mr(struct ib_pd *pd, enum ib_uverbs_advise_mr_advice advice,
>>>>>>>> +                   u32 flags, struct ib_sge *sg_list, u32 num_sge,
>>>>>>>> +                   struct uverbs_attr_bundle *attrs)
>>>>>>>> +{
>>>>>>>> +    return -EOPNOTSUPP;
>>>>>>>> +}
>>>>>>>> +
>>>>>>>>    #endif /* CONFIG_INFINIBAND_ON_DEMAND_PAGING */
>>>>>>>>    #endif /* RXE_LOC_H */
>>>>>>>> diff --git a/drivers/infiniband/sw/rxe/rxe_odp.c b/drivers/ infiniband/sw/rxe/rxe_odp.c
>>>>>>>> index 6149d9ffe7f7..e5c60b061d7e 100644
>>>>>>>> --- a/drivers/infiniband/sw/rxe/rxe_odp.c
>>>>>>>> +++ b/drivers/infiniband/sw/rxe/rxe_odp.c
>>>>>>>> @@ -424,3 +424,89 @@ enum resp_states rxe_odp_do_atomic_write(struct rxe_mr *mr, u64 iova, u64 value)
>>>>>>>>        return RESPST_NONE;
>>>>>>>>    }
>>>>>>>> +
>>>>>>>> +static int rxe_ib_prefetch_sg_list(struct ib_pd *ibpd,
>>>>>>>> +                   enum ib_uverbs_advise_mr_advice advice,
>>>>>>>> +                   u32 pf_flags, struct ib_sge *sg_list,
>>>>>>>> +                   u32 num_sge)
>>>>>>>> +{
>>>>>>>> +    struct rxe_pd *pd = container_of(ibpd, struct rxe_pd, ibpd);
>>>>>>>> +    unsigned int i;
>>>>>>>> +    int ret = 0;
>>>>>>>> +
>>>>>>>> +    for (i = 0; i < num_sge; ++i) {
>>>>>>>> +        struct rxe_mr *mr;
>>>>>>>> +        struct ib_umem_odp *umem_odp;
>>>>>>>> +
>>>>>>>> +        mr = lookup_mr(pd, IB_ACCESS_LOCAL_WRITE,
>>>>>>>> +                   sg_list[i].lkey, RXE_LOOKUP_LOCAL);
>>>>>>>> +
>>>>>>>> +        if (IS_ERR(mr)) {
>>>>>>>> +            rxe_dbg_pd(pd, "mr with lkey %x not found\n", sg_list[i].lkey);
>>>>>>>> +            return PTR_ERR(mr);
>>>>>>>> +        }
>>>>>>>> +
>>>>>>>> +        if (advice == IB_UVERBS_ADVISE_MR_ADVICE_PREFETCH_WRITE &&
>>>>>>>> +            !mr->umem->writable) {
>>>>>>>> +            rxe_dbg_mr(mr, "missing write permission\n");
>>>>>>>> +            rxe_put(mr);
>>>>>>>> +            return -EPERM;
>>>>>>>> +        }
>>>>>>>> +
>>>>>>>> +        ret = rxe_odp_do_pagefault_and_lock(mr, sg_list[i].addr,
>>>>>>>> +                            sg_list[i].length, pf_flags);
>>>>>>>> +        if (ret < 0) {
>>>>>>>> +            if (sg_list[i].length == 0)
>>>>>>>> +                continue;
>>>>>>>> +
>>>>>>>> +            rxe_dbg_mr(mr, "failed to prefetch the mr\n");
>>>>>>>> +            rxe_put(mr);
>>>>>>>> +            return ret;
>>>>>>>> +        }
>>>>>>>> +
>>>>>>>> +        umem_odp = to_ib_umem_odp(mr->umem);
>>>>>>>> +        mutex_unlock(&umem_odp->umem_mutex);
>>>>>>>> +
>>>>>>>> +        rxe_put(mr);
>>>>>>>> +    }
>>>>>>>> +
>>>>>>>> +    return 0;
>>>>>>>> +}
>>>>>>>> +
>>>>>>>> +static int rxe_ib_advise_mr_prefetch(struct ib_pd *ibpd,
>>>>>>>> +                     enum ib_uverbs_advise_mr_advice advice,
>>>>>>>> +                     u32 flags, struct ib_sge *sg_list, u32 num_sge)
>>>>>>>> +{
>>>>>>>> +    u32 pf_flags = RXE_PAGEFAULT_DEFAULT;
>>>>>>>> +
>>>>>>>> +    if (advice == IB_UVERBS_ADVISE_MR_ADVICE_PREFETCH)
>>>>>>>> +        pf_flags |= RXE_PAGEFAULT_RDONLY;
>>>>>>>> +
>>>>>>>> +    if (advice == IB_UVERBS_ADVISE_MR_ADVICE_PREFETCH_NO_FAULT)
>>>>>>>> +        pf_flags |= RXE_PAGEFAULT_SNAPSHOT;
>>>>>>>> +
>>>>>>>> +    /* Synchronous call */
>>>>>>>> +    if (flags & IB_UVERBS_ADVISE_MR_FLAG_FLUSH)
>>>>>>>> +        return rxe_ib_prefetch_sg_list(ibpd, advice, pf_flags, sg_list,
>>>>>>>> +                           num_sge);
>>>>>>>> +
>>>>>>>> +    /* Asynchronous call is "best-effort" */
>>>>>>>
>>>>>>> Asynchronous call is not implemented now, why does this comment appear?
>>>>>>
>>>>>> Even without the 2nd patch, async calls are reported as successful.
>>>>>
>>>>>
>>>>> Async call is not implemented. How to call "async calls are reported as successful"?
>>>>
>>>> Please see the manual.
>>>> cf. https://manpages.debian.org/testing/libibverbs-dev/ ibv_advise_mr.3.en.html
>>>>
>>>> If IBV_ADVISE_MR_FLAG_FLUSH is not given to 'flags' parameter,
>>>> then this function 'rxe_ib_advise_mr_prefetch()' simply returns 0.
>>>> Consequently, ibv_advise_mr(3) and underlying ioctl(2) get no error.
>>>> This behaviour is allowd in the spec as I quoted in the last reply.
>>>
>>> The functionality wasn't implemented, you added the comments first.
>>> You're still weaseling when people point this out.
>>>
>>>>
>>>> It might be nice to return -EOPNOTSUPP just below the comment instead,
>>>> but not doing so is acceptable according to the spec. Additionally,
>>>> such change will be overwritten in the next patch after all.
>>>
>>> Move comments to the next patch. In this patch, return -EOPNOTSUPP.
>>
>> Any opinion from Zhu?
>> I may post a new revision to change the intermediate code,
>> but the final result after applying the patchset will be the same.
>> You are the maintainer of rxe, so I will follow that.
> 
> Thanks a lot. I am fine with your commit.
> Please "Move comments to the next patch. In this patch, return -EOPNOTSUPP".
> I think that it is a good idea. The final result should be the same. Please send out the latest commit following the suggestions.
> 
> Thanks a lot for your contributions and efforts.

Thank you for the reply and support.

I've posted a new version with the following changes:
  - Added return -EOPNOTSUPP; (1st patch)
  - Changed type definition from 'unsigned int' to 'u32' as you suggested (1st patch)
  - Deleted redundant if-continue statements in rxe_ib_prefetch_sg_list() (1st patch)

Thanks,
Daisuke

> 
> Best Regards,
> Zhu Yanjun
> 
>>
>> Thanks,
>> Daisuke
>>
>>
>>>
>>> --G--
>>>
>>>>
>>>> Thanks,
>>>> Daisuke
>>>>
>>>>>
>>>>>
>>>>> Zhu Yanjun
>>>>>
>>>>>> The comment is inserted to show the reason, which is based on the
>>>>>> description from 'man 3 ibv_advise_mr' as follows:
>>>>>> ===
>>>>>> An application may pre-fetch any address range within an ODP MR when using the IBV_ADVISE_MR_ADVICE_PREFETCH or IBV_ADVISE_MR_ADVICE_PREFETCH_WRITE advice. Semantically, this operation is best-effort. That means the kernel does not guarantee that underlying pages are updated in the HCA or the pre-fetched pages would remain resident.
>>>>>> ===
>>>>>>
>>>>>> Thanks,
>>>>>> Daisuke
>>>>>>
>>>>>>>
>>>>>>> Zhu Yanjun
>>>>>>>
>>>>>>>> +
>>>>>>>> +    return 0;
>>>>>>>> +}
>>>>>>>> +
>>>>>>>> +int rxe_ib_advise_mr(struct ib_pd *ibpd,
>>>>>>>> +             enum ib_uverbs_advise_mr_advice advice,
>>>>>>>> +             u32 flags,
>>>>>>>> +             struct ib_sge *sg_list,
>>>>>>>> +             u32 num_sge,
>>>>>>>> +             struct uverbs_attr_bundle *attrs)
>>>>>>>> +{
>>>>>>>> +    if (advice != IB_UVERBS_ADVISE_MR_ADVICE_PREFETCH &&
>>>>>>>> +        advice != IB_UVERBS_ADVISE_MR_ADVICE_PREFETCH_WRITE &&
>>>>>>>> +        advice != IB_UVERBS_ADVISE_MR_ADVICE_PREFETCH_NO_FAULT)
>>>>>>>> +        return -EOPNOTSUPP;
>>>>>>>> +
>>>>>>>> +    return rxe_ib_advise_mr_prefetch(ibpd, advice, flags,
>>>>>>>> +                     sg_list, num_sge);
>>>>>>>> +}
>>>>>>>
>>>>>>
>>>>
>>>>
>>
> 


