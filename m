Return-Path: <linux-rdma+bounces-10239-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5195AB20FF
	for <lists+linux-rdma@lfdr.de>; Sat, 10 May 2025 04:46:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A4A33A30F1
	for <lists+linux-rdma@lfdr.de>; Sat, 10 May 2025 02:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAE742A8D0;
	Sat, 10 May 2025 02:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NMMkEn67"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 177A17E9;
	Sat, 10 May 2025 02:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746845170; cv=none; b=FtifFMwrwrng2mIQVZhSwY+OBPykVPDamXSiSq3bR+IoJoo7iutChah2qzLivhVX7odVJj+/vSk0t4oSBmSy7L87w0vGfI2TK8Ev6+TfFYuSTK82b8nwaASjriXcxmbNWLWen8mlZSaPMgflyaOZHK4Qg06rmrXstEyPdT325JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746845170; c=relaxed/simple;
	bh=vmQ2G3YHFqaGJxRQSznzYP+cVNkunMYSZ290j7TCx6U=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=tBAdlxJRlOIeEZ/9nufMU1GvpOhQnV2Sn60GdZXv45+Q5deYnMBuiBs8RtdMr4S8x7eos4MNUikYErSLC4AzGbnJJZk7UQMKFhybJqHtRHr/cgzohUpJfFc6ay2NStDIpQBye19ifV/Hapw5EdEarMltx0EIGPSkvKhY1QzxiA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NMMkEn67; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-30a8cbddce3so2474475a91.1;
        Fri, 09 May 2025 19:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746845168; x=1747449968; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=m/yHIEOas07Rege8xaw2TSi1aHLDAWR8pVsPOzQp7vM=;
        b=NMMkEn67n9WXmsWt3D6jTLdW2ecrBTLl0fTb5AD+6ggwsDDOx/jdpjzX9RyKPKgs8b
         3lBqt+ehCBa7971WK7v9MssHxjXVeThBYwaILkFGcwT7WmtfxXBGvzX6ElE1EOnWP8rI
         kCASpaagGdXfM+0nkpcDzN7MDGPCUoR7wPptFrwePClLW2kr7aZ7oLQi39K1pwrOnlI7
         z7YK4eq6Mnuip3JMQWgFouhzOINxYUOQ0yKMD1BuUY+g7u6CMWVUvFCuQEXhENFGUQrG
         wvdkpxuhn8FBznLHtOErpg6RYv5hrpVLl+mSdBu5gujoFMQjYfqvj/mae93Nwg5MvfgG
         n72g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746845168; x=1747449968;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m/yHIEOas07Rege8xaw2TSi1aHLDAWR8pVsPOzQp7vM=;
        b=W6jOaBJpN+ZlXO1ZJVaXhYZIIcDLH2kujhXXH7EmoUC4gj9SbpDSIKQXc2RLBkc6HT
         D8hQSHpQTuYgshoBYD4t777oQsb1ugvg7GmTvAU7l9sbGJ1c/LKxTtvwl5DN0XINuDrq
         DyXiQ/4RA+2sJmuH3xmTdyepdQMFg5xs0pfoIGsQVsrt24bFIQm3MG19UPjjuxInJEu0
         mFZC6mkNSjsbZtEvgG963shS8C1t81vLldoPJvHjS4UT3MkJJxlZKAULiA2AhHxiCzWd
         WCu55TnqFVP/XSLSNk18Bx3vZJp56mJqlsijx+b39q7sFfyeQTLGJ+0AI+quKVl2DoqW
         MfLg==
X-Forwarded-Encrypted: i=1; AJvYcCWOFfWALC1j3mM2U56aBPQ/NF+hyce7JrAOmolUPE0M4Z4XVXm/wtH9alwuxkDZ3NJskpRXLOrzEt13mA==@vger.kernel.org, AJvYcCXPrwGPfxN2dRNm0TDGUrbF28N255QNs4e6K61xR+3H7THWPLWwAHiMGErIDmZpORUFKqyDT+2n2Z4l62U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+09OHOQ3+46pAefUxRh/W7tQ/M9soGjLDQFFDiS7xewVtrouu
	oI0v/yXPt+3oLfeNUGV+tM3i9bRmxi5bDW3+kt+Y5lKI2v+rO/Id3vq992iA
X-Gm-Gg: ASbGncvQhnVQUkdVULZ3kAsLcHOpRmx7vFkUKv56Ad9RLSc4eGTKzhu8o7HsO0XS2d+
	ahAf6EvBA9TVHEdmIyTuaA5aA2KuBUeOTS95nfQfI04ZmVihgiHCuwjoZvifwBIoEMI91ftqTIt
	X+UL/Khf5lmHcKShq1u7HDLgtydbbdCz+d/QlNxdza3M6e6FXvTY3QhxlNN+XpldVO4XfWITZS5
	KW2oNVjGIZ5FCyRcoGvDlg2MBhcFB6WNBFBiSVQB8pvQJJsK+AoDkRM+/ItJDKgiuw2k9Rg2I0u
	00CZfUUkLfUFFZEYEdLJlMYDR1qZMK38xWoHTGl8RWjvsCIHi786omtzwzoxgM/rRTtNxtWiMXB
	sJ5CgnIHcDWUEgGwFLAUyQwzH+Ls=
X-Google-Smtp-Source: AGHT+IGJjlfaACz8A7xon+J+jxF5svlaxdDSe8LJUS2WmIj+7XirEPM3IfWdb9Ns0mHiKGwET4Wwfw==
X-Received: by 2002:a17:90b:3a8f:b0:2f8:b2c:5ef3 with SMTP id 98e67ed59e1d1-30c3cff4114mr9980646a91.14.1746845167922;
        Fri, 09 May 2025 19:46:07 -0700 (PDT)
Received: from [192.168.11.2] (FL1-119-244-79-106.tky.mesh.ad.jp. [119.244.79.106])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30ad4d2e499sm4826715a91.16.2025.05.09.19.46.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 May 2025 19:46:07 -0700 (PDT)
Message-ID: <b5560914-e613-499d-88c8-82f5255a1dd1@gmail.com>
Date: Sat, 10 May 2025 11:46:04 +0900
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
 <cdea578b-5570-4a8d-98cc-61081a281a84@linux.dev>
Content-Language: en-US
From: Daisuke Matsuda <dskmtsd@gmail.com>
In-Reply-To: <cdea578b-5570-4a8d-98cc-61081a281a84@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2025/05/10 0:19, Zhu Yanjun wrote:
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
> 
> Asynchronous call is not implemented now, why does this comment appear?

Even without the 2nd patch, async calls are reported as successful.
The comment is inserted to show the reason, which is based on the
description from 'man 3 ibv_advise_mr' as follows:
===
An application may pre-fetch any address range within an ODP MR when using the IBV_ADVISE_MR_ADVICE_PREFETCH or IBV_ADVISE_MR_ADVICE_PREFETCH_WRITE advice. Semantically, this operation is best-effort. That means the kernel does not guarantee that underlying pages are updated in the HCA or the pre-fetched pages would remain resident.
===

Thanks,
Daisuke

> 
> Zhu Yanjun
> 
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


