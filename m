Return-Path: <linux-rdma+bounces-10242-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B23EAB21A7
	for <lists+linux-rdma@lfdr.de>; Sat, 10 May 2025 09:19:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 480F7177DD2
	for <lists+linux-rdma@lfdr.de>; Sat, 10 May 2025 07:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BCDD1DF273;
	Sat, 10 May 2025 07:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C8fR/NWh"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE592747B;
	Sat, 10 May 2025 07:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746861548; cv=none; b=bAWq/BqIOKrpO5Z1I90rhV8NcKB4QIQqcXl0ZDV26CP2d+cdHNINgKmQKuzEPs017DN2tygKVXup3FvzFGh0nQwweOWDUUSuO3WMRbeUF3cX6KjHKhw5sNdQFXfcUUB6ZZGhj5gAFJFBoPvbNX9VhQdcDL58+NJAVWYWvrn4c9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746861548; c=relaxed/simple;
	bh=x/6Nj4jfIjBS2T8K/+HNTFSghyP4K3RB4/iYDV1JBkI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=qwgoT5y13edCAa74pUtIO2aFG9l9STEMzUyty6arSFjX1UoYF7Tj+EyN3yY9oulmOZQIJVYRC4GPDYuMB75+X5ShX9hArh57zfJ2X8jBk/qs02wMdzR8ubtW5DzFF6we4ZmvDUyWIbPXERz/rnylPny65aAEJhLUY0Vpz8iZK18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C8fR/NWh; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-227b828de00so28137555ad.1;
        Sat, 10 May 2025 00:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746861545; x=1747466345; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mI00I1jgV1Gz3HCNeGR3mFLybO5XNTxT635pmmEPFsI=;
        b=C8fR/NWhVdtotP1CY+N5bDhVzrTRhceuiqXBhZGGz4SIlubeXy79F1Ci1Ez0kHA76q
         7SSEqCZgD74DfOZh4lEBuoqJWQXKiPQaxetXHZ1j+O7No+Cdvtt1iYvIXd2Ab3Im8T4v
         gSmUgIwcRiRPx0MkQr4L9+hj47btpTFIzt7yFTzG2yXl7YmkJ2nyqsE7+gOBeNn/Obur
         e9Ex+ketnpn10Fji1UYzP3qqOSW56ICO053lh4raFySLgcu1Oyp/EqH3ma9+TBWfamu2
         6zaOsX/trVbsV9Q5oxvfD1uTI9gr1cf2zT2ZmuaFa4yEHNCj4oAOATDXqxZCWZm26Paj
         syaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746861545; x=1747466345;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mI00I1jgV1Gz3HCNeGR3mFLybO5XNTxT635pmmEPFsI=;
        b=vMAlSJmXr9OScWtg+kUrrHRpKvkMX3r3pgFFZ+O2cb7+nW8x3zZvFZgPttGMKkLabQ
         tnye+xaUefDDRqwSR/uB8IhrPvq/08ZRqlRTF7TaovAzEkcqzNdDWW26j2Wq4xkq9b+o
         u2KNeAqLjtPO+655iNMnhGh8XsoUmeIIX17xKx9tjkmCsp7qVTBf20uCTGLAE081iOAq
         JjQ2Hkv3Wot3TRGOwKH36uw0Uy5Ul5NdvILkX6tIX9yYLNE3CHStbscLu3yXal9EYNlf
         8lYQNheDaCA5DPJhEc7ivh508h7B9ec3nIacTXDSqFVGFLbWYDa8t7HKmUbmWz6qNJeo
         0a6g==
X-Forwarded-Encrypted: i=1; AJvYcCVW7KGY/Yf/LQnNSEP+MzfNVdbADSGkvgH+A1U5l+ILSH+mPQNBwyDK1+NfDMw/Nj68d/tKIHkOUjX77Q==@vger.kernel.org, AJvYcCWCa2lETPA8za7ZaqJ4fwkxDwD9wrNSyOG2IsCXJZg6JDTj9LtoenmqU2/haJncuQKN9MhtW2OsDv3LXEs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXoG7i88R0Sh00P3VaTXxVRS2hGEzDJpoZ6q7SmXvJMJFxG238
	Ht80x+/IY9jVS42ZwQvSqYcmNUpWjWAVh4sMU6QGIX4gGv/wtkN7ClJseOcg
X-Gm-Gg: ASbGnctXCOHiDRh6tekpg1F3uCns0IGNiwmvvCshPT6HKkoLGOmjP6u8e9miNrUtGXE
	2/DL2WOuYp5AZFjgvzCw5Q01v4RyOT7oMkbm916h2TGYmpsEPrdGl9zp2VjGvfkaOsEoiaoq9QP
	Ed7tmxGLLRnm9T12bjcHo077Dm/c4ZcvKMl7MCPGrBOLu9x9hPiNmo9TfAXSZuk2o7zYrdtNR9C
	yCyLeqig3RDBuenjCJUPe+43HWHyqPTIeTgaXUTp9WWT9JPEK0cyGvzYN3SwAZBz2GvnShgmu5Z
	+Tpy/+3oLP5da37VJYl7KnoDj2FFm8iWiXy87AuC/23hgOWbjo/zP5ZANJqT8qp2w1zpM1IfQ3L
	JUafE52ZWcCZG8aTydlUtxvo3SN4=
X-Google-Smtp-Source: AGHT+IGoZ2ngl1aphNRdZ03UYT87SSVWYcmt2OUX32zVzS8N1bUq66LrmQlqncxZjlprzsf8yVZvRA==
X-Received: by 2002:a17:903:2346:b0:215:bc30:c952 with SMTP id d9443c01a7336-22fc8b1b2e4mr78727755ad.6.1746861544532;
        Sat, 10 May 2025 00:19:04 -0700 (PDT)
Received: from [192.168.11.2] (FL1-119-244-79-106.tky.mesh.ad.jp. [119.244.79.106])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22fc828b3a0sm28229215ad.179.2025.05.10.00.19.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 May 2025 00:19:04 -0700 (PDT)
Message-ID: <e07e0ad8-32da-452e-809a-f3dfeb8b56f3@gmail.com>
Date: Sat, 10 May 2025 16:18:59 +0900
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
 <b5560914-e613-499d-88c8-82f5255a1dd1@gmail.com>
 <093ee42f-4dd5-4f52-b7a5-ba5e22b18bdc@linux.dev>
Content-Language: en-US
From: Daisuke Matsuda <dskmtsd@gmail.com>
In-Reply-To: <093ee42f-4dd5-4f52-b7a5-ba5e22b18bdc@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2025/05/10 13:43, Zhu Yanjun wrote:
> 
> 在 2025/5/10 4:46, Daisuke Matsuda 写道:
>> On 2025/05/10 0:19, Zhu Yanjun wrote:
>>> On 03.05.25 15:42, Daisuke Matsuda wrote:
>>>> Minimal implementation of ibv_advise_mr(3) requires synchronous calls being
>>>> successful with the IBV_ADVISE_MR_FLAG_FLUSH flag. Asynchronous requests,
>>>> which are best-effort, will be added subsequently.
>>>>
>>>> Signed-off-by: Daisuke Matsuda <dskmtsd@gmail.com>
>>>> ---
>>>>   drivers/infiniband/sw/rxe/rxe.c     |  7 +++
>>>>   drivers/infiniband/sw/rxe/rxe_loc.h | 10 ++++
>>>>   drivers/infiniband/sw/rxe/rxe_odp.c | 86 +++++++++++++++++++++++++++++
>>>>   3 files changed, 103 insertions(+)
>>>>
>>>> diff --git a/drivers/infiniband/sw/rxe/rxe.c b/drivers/infiniband/sw/rxe/rxe.c
>>>> index 3a77d6db1720..e891199cbdef 100644
>>>> --- a/drivers/infiniband/sw/rxe/rxe.c
>>>> +++ b/drivers/infiniband/sw/rxe/rxe.c
>>>> @@ -34,6 +34,10 @@ void rxe_dealloc(struct ib_device *ib_dev)
>>>>       mutex_destroy(&rxe->usdev_lock);
>>>>   }
>>>> +static const struct ib_device_ops rxe_ib_dev_odp_ops = {
>>>> +    .advise_mr = rxe_ib_advise_mr,
>>>> +};
>>>> +
>>>>   /* initialize rxe device parameters */
>>>>   static void rxe_init_device_param(struct rxe_dev *rxe, struct net_device *ndev)
>>>>   {
>>>> @@ -103,6 +107,9 @@ static void rxe_init_device_param(struct rxe_dev *rxe, struct net_device *ndev)
>>>>           rxe->attr.odp_caps.per_transport_caps.rc_odp_caps |= IB_ODP_SUPPORT_SRQ_RECV;
>>>>           rxe->attr.odp_caps.per_transport_caps.rc_odp_caps |= IB_ODP_SUPPORT_FLUSH;
>>>>           rxe->attr.odp_caps.per_transport_caps.rc_odp_caps |= IB_ODP_SUPPORT_ATOMIC_WRITE;
>>>> +
>>>> +        /* set handler for ODP prefetching API - ibv_advise_mr(3) */
>>>> +        ib_set_device_ops(&rxe->ib_dev, &rxe_ib_dev_odp_ops);
>>>>       }
>>>>   }
>>>> diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
>>>> index f7dbb9cddd12..21b070f3dbb8 100644
>>>> --- a/drivers/infiniband/sw/rxe/rxe_loc.h
>>>> +++ b/drivers/infiniband/sw/rxe/rxe_loc.h
>>>> @@ -197,6 +197,9 @@ enum resp_states rxe_odp_atomic_op(struct rxe_mr *mr, u64 iova, int opcode,
>>>>   int rxe_odp_flush_pmem_iova(struct rxe_mr *mr, u64 iova,
>>>>                   unsigned int length);
>>>>   enum resp_states rxe_odp_do_atomic_write(struct rxe_mr *mr, u64 iova, u64 value);
>>>> +int rxe_ib_advise_mr(struct ib_pd *pd, enum ib_uverbs_advise_mr_advice advice,
>>>> +             u32 flags, struct ib_sge *sg_list, u32 num_sge,
>>>> +             struct uverbs_attr_bundle *attrs);
>>>>   #else /* CONFIG_INFINIBAND_ON_DEMAND_PAGING */
>>>>   static inline int
>>>>   rxe_odp_mr_init_user(struct rxe_dev *rxe, u64 start, u64 length, u64 iova,
>>>> @@ -225,6 +228,13 @@ static inline enum resp_states rxe_odp_do_atomic_write(struct rxe_mr *mr,
>>>>   {
>>>>       return RESPST_ERR_UNSUPPORTED_OPCODE;
>>>>   }
>>>> +static inline int rxe_ib_advise_mr(struct ib_pd *pd, enum ib_uverbs_advise_mr_advice advice,
>>>> +                   u32 flags, struct ib_sge *sg_list, u32 num_sge,
>>>> +                   struct uverbs_attr_bundle *attrs)
>>>> +{
>>>> +    return -EOPNOTSUPP;
>>>> +}
>>>> +
>>>>   #endif /* CONFIG_INFINIBAND_ON_DEMAND_PAGING */
>>>>   #endif /* RXE_LOC_H */
>>>> diff --git a/drivers/infiniband/sw/rxe/rxe_odp.c b/drivers/infiniband/sw/rxe/rxe_odp.c
>>>> index 6149d9ffe7f7..e5c60b061d7e 100644
>>>> --- a/drivers/infiniband/sw/rxe/rxe_odp.c
>>>> +++ b/drivers/infiniband/sw/rxe/rxe_odp.c
>>>> @@ -424,3 +424,89 @@ enum resp_states rxe_odp_do_atomic_write(struct rxe_mr *mr, u64 iova, u64 value)
>>>>       return RESPST_NONE;
>>>>   }
>>>> +
>>>> +static int rxe_ib_prefetch_sg_list(struct ib_pd *ibpd,
>>>> +                   enum ib_uverbs_advise_mr_advice advice,
>>>> +                   u32 pf_flags, struct ib_sge *sg_list,
>>>> +                   u32 num_sge)
>>>> +{
>>>> +    struct rxe_pd *pd = container_of(ibpd, struct rxe_pd, ibpd);
>>>> +    unsigned int i;
>>>> +    int ret = 0;
>>>> +
>>>> +    for (i = 0; i < num_sge; ++i) {
>>>> +        struct rxe_mr *mr;
>>>> +        struct ib_umem_odp *umem_odp;
>>>> +
>>>> +        mr = lookup_mr(pd, IB_ACCESS_LOCAL_WRITE,
>>>> +                   sg_list[i].lkey, RXE_LOOKUP_LOCAL);
>>>> +
>>>> +        if (IS_ERR(mr)) {
>>>> +            rxe_dbg_pd(pd, "mr with lkey %x not found\n", sg_list[i].lkey);
>>>> +            return PTR_ERR(mr);
>>>> +        }
>>>> +
>>>> +        if (advice == IB_UVERBS_ADVISE_MR_ADVICE_PREFETCH_WRITE &&
>>>> +            !mr->umem->writable) {
>>>> +            rxe_dbg_mr(mr, "missing write permission\n");
>>>> +            rxe_put(mr);
>>>> +            return -EPERM;
>>>> +        }
>>>> +
>>>> +        ret = rxe_odp_do_pagefault_and_lock(mr, sg_list[i].addr,
>>>> +                            sg_list[i].length, pf_flags);
>>>> +        if (ret < 0) {
>>>> +            if (sg_list[i].length == 0)
>>>> +                continue;
>>>> +
>>>> +            rxe_dbg_mr(mr, "failed to prefetch the mr\n");
>>>> +            rxe_put(mr);
>>>> +            return ret;
>>>> +        }
>>>> +
>>>> +        umem_odp = to_ib_umem_odp(mr->umem);
>>>> +        mutex_unlock(&umem_odp->umem_mutex);
>>>> +
>>>> +        rxe_put(mr);
>>>> +    }
>>>> +
>>>> +    return 0;
>>>> +}
>>>> +
>>>> +static int rxe_ib_advise_mr_prefetch(struct ib_pd *ibpd,
>>>> +                     enum ib_uverbs_advise_mr_advice advice,
>>>> +                     u32 flags, struct ib_sge *sg_list, u32 num_sge)
>>>> +{
>>>> +    u32 pf_flags = RXE_PAGEFAULT_DEFAULT;
>>>> +
>>>> +    if (advice == IB_UVERBS_ADVISE_MR_ADVICE_PREFETCH)
>>>> +        pf_flags |= RXE_PAGEFAULT_RDONLY;
>>>> +
>>>> +    if (advice == IB_UVERBS_ADVISE_MR_ADVICE_PREFETCH_NO_FAULT)
>>>> +        pf_flags |= RXE_PAGEFAULT_SNAPSHOT;
>>>> +
>>>> +    /* Synchronous call */
>>>> +    if (flags & IB_UVERBS_ADVISE_MR_FLAG_FLUSH)
>>>> +        return rxe_ib_prefetch_sg_list(ibpd, advice, pf_flags, sg_list,
>>>> +                           num_sge);
>>>> +
>>>> +    /* Asynchronous call is "best-effort" */
>>>
>>> Asynchronous call is not implemented now, why does this comment appear?
>>
>> Even without the 2nd patch, async calls are reported as successful.
> 
> 
> Async call is not implemented. How to call "async calls are reported as successful"?

Please see the manual.
cf. https://manpages.debian.org/testing/libibverbs-dev/ibv_advise_mr.3.en.html

If IBV_ADVISE_MR_FLAG_FLUSH is not given to 'flags' parameter,
then this function 'rxe_ib_advise_mr_prefetch()' simply returns 0.
Consequently, ibv_advise_mr(3) and underlying ioctl(2) get no error.
This behaviour is allowd in the spec as I quoted in the last reply.

It might be nice to return -EOPNOTSUPP just below the comment instead,
but not doing so is acceptable according to the spec. Additionally,
such change will be overwritten in the next patch after all.

Thanks,
Daisuke

> 
> 
> Zhu Yanjun
> 
>> The comment is inserted to show the reason, which is based on the
>> description from 'man 3 ibv_advise_mr' as follows:
>> ===
>> An application may pre-fetch any address range within an ODP MR when using the IBV_ADVISE_MR_ADVICE_PREFETCH or IBV_ADVISE_MR_ADVICE_PREFETCH_WRITE advice. Semantically, this operation is best-effort. That means the kernel does not guarantee that underlying pages are updated in the HCA or the pre-fetched pages would remain resident.
>> ===
>>
>> Thanks,
>> Daisuke
>>
>>>
>>> Zhu Yanjun
>>>
>>>> +
>>>> +    return 0;
>>>> +}
>>>> +
>>>> +int rxe_ib_advise_mr(struct ib_pd *ibpd,
>>>> +             enum ib_uverbs_advise_mr_advice advice,
>>>> +             u32 flags,
>>>> +             struct ib_sge *sg_list,
>>>> +             u32 num_sge,
>>>> +             struct uverbs_attr_bundle *attrs)
>>>> +{
>>>> +    if (advice != IB_UVERBS_ADVISE_MR_ADVICE_PREFETCH &&
>>>> +        advice != IB_UVERBS_ADVISE_MR_ADVICE_PREFETCH_WRITE &&
>>>> +        advice != IB_UVERBS_ADVISE_MR_ADVICE_PREFETCH_NO_FAULT)
>>>> +        return -EOPNOTSUPP;
>>>> +
>>>> +    return rxe_ib_advise_mr_prefetch(ibpd, advice, flags,
>>>> +                     sg_list, num_sge);
>>>> +}
>>>
>>


