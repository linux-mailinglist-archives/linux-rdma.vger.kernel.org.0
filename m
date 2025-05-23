Return-Path: <linux-rdma+bounces-10621-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C09EAAC233D
	for <lists+linux-rdma@lfdr.de>; Fri, 23 May 2025 14:58:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8912B17F73D
	for <lists+linux-rdma@lfdr.de>; Fri, 23 May 2025 12:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81FB612E1CD;
	Fri, 23 May 2025 12:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BT7hASv8"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66B281720
	for <linux-rdma@vger.kernel.org>; Fri, 23 May 2025 12:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748005067; cv=none; b=pDGjKPfhYJtfRFlG1dz6KBYnay/9wDli+h3PXnlwhCHwC2Uhi+xTn0Au61owkrPS1gZsZG02HQbm33jrcbZ+1EeEri0hI8Cfz46hm1p21kHGDw4iHGxVvbiqX32uIb+wYu1VFw+0TCReEXB7hr2CgG0wZeVcBDf27Ew5rndZDlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748005067; c=relaxed/simple;
	bh=bloQfgTi74VtMsAhWBM/xc3enTJlkIcbfYZdEpaRao4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BAbq/XpAYg6/wRPH6G2JrFpNgudbRVGuf46c/llD0uF2y+Kq0gFQAJCcZF+faidsyfu+HwglDzCchf9tuo1AzCOGXOdAdmt5QH18doMZfK/a2VJtyLGZjxK+8hiR0kNGjpei1LVX50h56PpKUqmPR5IYGbJq7E6gI49wY14raY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BT7hASv8; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-231fc83a33aso59421935ad.0
        for <linux-rdma@vger.kernel.org>; Fri, 23 May 2025 05:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748005065; x=1748609865; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=86ZxYYP+EC0nhvVmgWGiB1V4qMzR3I0a1nVFZXVh4hU=;
        b=BT7hASv8nMqOGuBi2ZFkdvLI9ydemqZSUm5B5UzsPbgJd/am9zhaNDspNS/O6kPw28
         +72SFmZZ2OKwgx0x53XtDaRG7du9MBeXyak1tutf3CDx31GIXEy8oB5Uq60kb9aF8QPX
         ZRUJrg/1GAlcLlUXhDsZi+qcRbeD7RGTsj/0Lzdy7Ba0dmxfRwjqiPZwNaJzQNtYbHgU
         KgzcAGFvyFtEaHHk+b5e+icccKyz/TnWsYHf7Y3k3+3nlKs8M7NhxBrL0sPjVlmA3L8w
         +VzCU9aGI/TT0AxHERwxVk7S44yJZf8E3TrU0JlVPIMCQ2NttV+AkaKAnKKwcZTMa7P6
         LDfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748005065; x=1748609865;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=86ZxYYP+EC0nhvVmgWGiB1V4qMzR3I0a1nVFZXVh4hU=;
        b=nopKkGQkA57I455EDHbh18ZvuogoMOWxyXos3uRcc10DMXxFWjGzbW93XGzzL+2QF0
         FoyPG6AWWbn50e5/m7CcJO3M3T1ewK67k+I9FPp54StuiMb2zmk048E5Bw7AjQRxg+rg
         uqwp/F1QQzKwgVhowstj58J02IcpbsRhNYQ3oWqxL1coZlF7vM7YimReLiiHfZURGYDv
         I5XSuv8wsZpiOdM3AwZWsGm3tC+E5CGzRiYXCHS91dnOeGO5HpIj+7QPSmxD4+nJNk4o
         2yXlydkWeVXS4bnGStEzYiy3cesmUcZB1UhSIXYBDQ9kAPjbHHPq+cGu2QDMhvoxuWi4
         avFQ==
X-Forwarded-Encrypted: i=1; AJvYcCVYM9qyHGMmO8NMPeOBP/kvy0mKFEPUkbPTITDOmQw/9sNSy3jV6zUtLUo1orkHbKj9OJ9r+UtGcgAu@vger.kernel.org
X-Gm-Message-State: AOJu0YyhDBSumQE6wr7iHTYFCqwafn4e+N7jxc8zniKPFwJ78e8FV+yC
	Ou1QS9VBE8EL3OZPzA46PuiuK2UJFPbPvC0opntJtuThc0embCQdNmUJCUgtLhW5
X-Gm-Gg: ASbGncudLyXaj7Q+uGKBIb4RD1AR21SzAvt70tfFCwsQkrVF9xE5432Rq+U1VPQLn92
	IPVpUSL8nHAyWVNH4AUPaAu0VWF+HG543akRwMwmUxocVITGuY6aXp7WfPF6qsyGBdOZhf55S43
	ZfJ9ziN36ElY1MMUn5niuo+rvzPbYUU0eZfAJU/Y61LI7//dS6YWSR/Av5c+S8IoMEltaK24BEN
	Epaz3Jni5/KPzSbDBJ7WMZUDTtCHKGWrGfXK0uG5JHCn21OTBbge0RKKSIP87K4zZwzfpe2yAgA
	dlseC8+jATZGLUkBQa0ru86i/vMxkn1kzlu2qIG5p6hyxYYu9j2Pb/fAtKj2siEm56eeTqNWMSt
	tvAy3ZOYWaTU2FXX1sWgSqQk6oBQ=
X-Google-Smtp-Source: AGHT+IFG89HQfZnPH83r2nqkPw39ZkE0yaMKuIq8CiJQJE8xm1kshnP4OVFn5EHbomDScXpsuTxsFg==
X-Received: by 2002:a17:902:c949:b0:22e:9f5:6f17 with SMTP id d9443c01a7336-231de35f05cmr338084755ad.13.1748005064993;
        Fri, 23 May 2025 05:57:44 -0700 (PDT)
Received: from [192.168.11.2] (FL1-119-244-79-106.tky.mesh.ad.jp. [119.244.79.106])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30f365b2da7sm7277076a91.9.2025.05.23.05.57.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 May 2025 05:57:44 -0700 (PDT)
Message-ID: <931a04a1-08bf-46af-83a9-f424ff4b8ded@gmail.com>
Date: Fri, 23 May 2025 21:57:42 +0900
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rdma-next] RDMA/rxe: Break endless pagefault loop for RO
 pages
To: Zhu Yanjun <yanjun.zhu@linux.dev>, Leon Romanovsky <leon@kernel.org>,
 Jason Gunthorpe <jgg@nvidia.com>
Cc: Leon Romanovsky <leonro@nvidia.com>, linux-rdma@vger.kernel.org,
 Zhu Yanjun <zyjzyj2000@gmail.com>
References: <096fab178d48ed86942ee22eafe9be98e29092aa.1747913377.git.leonro@nvidia.com>
 <72a82333-b005-4383-888c-7632bf1ce4ae@gmail.com>
 <3afc1cf8-0a8b-48b8-9707-3651136c227b@linux.dev>
Content-Language: en-US
From: Daisuke Matsuda <dskmtsd@gmail.com>
In-Reply-To: <3afc1cf8-0a8b-48b8-9707-3651136c227b@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2025/05/23 21:15, Zhu Yanjun wrote:
> On 22.05.25 15:29, Daisuke Matsuda wrote:
>>
>> On 2025/05/22 20:36, Leon Romanovsky wrote:
>>> From: Leon Romanovsky <leonro@nvidia.com>
>>>
>>> RO pages has "perm" equal to 0, that caused to the situation
>>> where such pages were marked as needed to have fault and caused
>>> to infinite loop.
>>>
>>> Fixes: eedd5b1276e7 ("RDMA/umem: Store ODP access mask information in PFN")
>>> Reported-by: Daisuke Matsuda <dskmtsd@gmail.com>
>>> Closes: https://lore.kernel.org/all/3e8f343f-7d66-4f7a-9f08-3910623e322f@gmail.com
>>> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
>>
>> Tested-by: Daisuke Matsuda <dskmtsd@gmail.com>
> 
> In the bug report mail, you mentioned
> "
> After these two patches are merged to the for-next tree, RXE ODP test always hangs:
>    RDMA/core: Convert UMEM ODP DMA mapping to caching IOVA and page linkage
>    RDMA/umem: Store ODP access mask information in PFN
> "
> 
> After this commit is applied, which of the two previous commits is innocent, and which one causes the "stuck issue in uverbs_destroy_ufile_hw"?

The issue caused by "RDMA/umem: Store ODP access mask information in PFN" has been resolved,
and after applying "RDMA/core: Convert UMEM ODP DMA mapping to caching IOVA and page linkage",
the stuck issue in uverbs_destroy_ufile_hw() emerges.

I have added some details to the bug report. I am going post a fix
though I am not sure people like changing hmm.c to fix this one.

Thanks,
Daisuke

> 
> Best Regards,
> Yanjun.Zhu
> 
>>
>> Thank you!
>> This change fixes one of the two issues I reported.
>> The kernel module does not get stuck in rxe_ib_invalidate_range() anymore.
>>
>>
>> The remaining one is the stuck issue in uverbs_destroy_ufile_hw().
>> cf. https://lore.kernel.org/all/3e8f343f-7d66-4f7a-9f08-3910623e322f@gmail.com/
>>
>> The issue occurs with test_odp_async_prefetch_rc_traffic, which is not yet
>> enabled in rxe. It might indicate that the root cause lies in ib_uverbs layer.
>> I will take a closer look anyway.
>>
>> Thanks,
>> Daisuke
>>
>>
>>> ---
>>>   drivers/infiniband/sw/rxe/rxe_odp.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/infiniband/sw/rxe/rxe_odp.c b/drivers/infiniband/sw/rxe/rxe_odp.c
>>> index a1416626f61a5..0f67167ddddd1 100644
>>> --- a/drivers/infiniband/sw/rxe/rxe_odp.c
>>> +++ b/drivers/infiniband/sw/rxe/rxe_odp.c
>>> @@ -137,7 +137,7 @@ static inline bool rxe_check_pagefault(struct ib_umem_odp *umem_odp,
>>>       while (addr < iova + length) {
>>>           idx = (addr - ib_umem_start(umem_odp)) >> umem_odp->page_shift;
>>> -        if (!(umem_odp->map.pfn_list[idx] & perm)) {
>>> +        if (!(umem_odp->map.pfn_list[idx] & HMM_PFN_VALID)) {
>>>               need_fault = true;
>>>               break;
>>>           }
>>
> 


