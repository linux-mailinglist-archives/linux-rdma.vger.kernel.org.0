Return-Path: <linux-rdma+bounces-2757-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B1958D7591
	for <lists+linux-rdma@lfdr.de>; Sun,  2 Jun 2024 15:08:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E62B31F214E1
	for <lists+linux-rdma@lfdr.de>; Sun,  2 Jun 2024 13:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC05C3B1A3;
	Sun,  2 Jun 2024 13:08:19 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE29210795
	for <linux-rdma@vger.kernel.org>; Sun,  2 Jun 2024 13:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717333699; cv=none; b=iFfwlgqJxli07DT2Coh9o4z6mxmQBE5Eg8bujHugaYytpuXCVzrOCDKDE5N9v5dZZ9jRPHWSTS3tr6icd9hNBxJUCU1spP3tEv/3KC3sqY7BMcOoc3wp+LZPxqXWMs6NvPmytGCrtOFoYJeE4CYS0Iv65j7fFS98LnB9XnK3EqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717333699; c=relaxed/simple;
	bh=X3Eyk2IvqvfIomYEGEEIKRaClYFbZehWB2iIwC3ldcU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MiAgA2pBxwNHljPkslKuyBjSqvqcAPZZWjGuJtpXDRoy2Y7z2Tg92x8J/hTE2dbLN8c0TFCxejVSy1XaF9V8WlTkJpbVmgTRkBSLdHLSHPn4Of0ushF/WwXv9q2BvACYk6L4ZXca+UEuI4JO43UI81+5asW4H/3fGuyFfTo4W/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-52b7ecafe05so501866e87.3
        for <linux-rdma@vger.kernel.org>; Sun, 02 Jun 2024 06:08:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717333696; x=1717938496;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0HWM/J4zSwgMlyBXIB+KRnl1sEORQ0zoP0qKW4SRLdg=;
        b=Xqfxq/HK388Y36s6YDsBGl6KuZMPDqm/nBoe1/YbWTWjL0jCPhvohL0VOafI3blXeP
         u3WTKEPmX2Qz59eXa7asEYkj7npkJ0GlFNQKYzYzfXF3W7m0OToHqZiQwFnGBUkldFBz
         gHyNMDJfCUX43z4MotTxTFa5aMCRcBzfJ3/b5y6cRfYohXk/w+N31yHlNXcyd8epoKW1
         9xEBtHI7xVdAog6+Qg3Qo5mEdMXEtCs4BveyyPJ8hAcWms65jECLU2wGjFurE9VAuQIB
         B0VZOzSUc7p+ju/nf5FRwJnVuDiNQL2yo/lRa4fq6mNOSsg1Col2s3EmDghJiWazWdCC
         Soug==
X-Gm-Message-State: AOJu0YzvrmEaPdx/RwrDvd3QTtPF0gKZj1wf+U/yC+N3F7GikfimsKYz
	SwqwpH7O29YJ2n09jEgXNa95BfOaPB++JclnK7hNjp0+y3DJ0J2j
X-Google-Smtp-Source: AGHT+IHeFhHwqOcYvEnCY+gVt6VW18DFxkI3iwU/p3OHmqiNvrHY8ytQHJk61ikS3JJtoKgvwbTTOg==
X-Received: by 2002:ac2:4313:0:b0:516:c241:a912 with SMTP id 2adb3069b0e04-52b895545a7mr3568935e87.1.1717333695470;
        Sun, 02 Jun 2024 06:08:15 -0700 (PDT)
Received: from [10.100.102.74] (85.65.205.146.dynamic.barak-online.net. [85.65.205.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42128edaaf0sm104723185e9.15.2024.06.02.06.08.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Jun 2024 06:08:15 -0700 (PDT)
Message-ID: <f1f52597-c159-4c87-993d-51221c974dfe@grimberg.me>
Date: Sun, 2 Jun 2024 16:08:13 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rfc] rdma/verbs: fix a possible uaf when draining a srq
 attached qp
To: Max Gurtovoy <mgurtovoy@nvidia.com>, Leon Romanovsky <leon@kernel.org>
Cc: linux-rdma@vger.kernel.org, linux-nvme@lists.infradead.org,
 Jason Gunthorpe <jgg@ziepe.ca>, Israel Rukshin <israelr@nvidia.com>,
 Oren Duer <ooren@nvidia.com>
References: <20240526083125.1454440-1-sagi@grimberg.me>
 <20240602081934.GJ3884@unreal>
 <ac1ccd5e-598e-4e67-8e32-2f8d499d6ff7@grimberg.me>
 <d70273b6-56ad-494e-b1d2-884b537dcfa7@nvidia.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <d70273b6-56ad-494e-b1d2-884b537dcfa7@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 02/06/2024 14:43, Max Gurtovoy wrote:
> Hi Sagi,
>
> On 02/06/2024 11:53, Sagi Grimberg wrote:
>>
>>
>> On 02/06/2024 11:19, Leon Romanovsky wrote:
>>> On Sun, May 26, 2024 at 11:31:25AM +0300, Sagi Grimberg wrote:
>>>> ib_drain_qp does not do drain a shared recv queue (because it is
>>>> shared). However in the absence of any guarantees that the recv
>>>> completions were consumed, the ulp can reference these completions
>>>> after draining the qp and freeing its associated resources, which
>>>> is a uaf [1].
>>>>
>>>> We cannot drain a srq like a normal rq, however in ib_drain_qp
>>>> once the qp moved to error state, we reap the recv_cq once in
>>>> order to prevent consumption of recv completions after the drain.
>>>>
>>>> [1]:
>>>> -- 
>>>> [199856.569999] Unable to handle kernel paging request at virtual 
>>>> address 002248778adfd6d0
>>>> <....>
>>>> [199856.721701] Workqueue: ib-comp-wq ib_cq_poll_work [ib_core]
>>>> <....>
>>>> [199856.827281] Call trace:
>>>> [199856.829847]  nvmet_parse_admin_cmd+0x34/0x178 [nvmet]
>>>> [199856.835007]  nvmet_req_init+0x2e0/0x378 [nvmet]
>>>> [199856.839640]  nvmet_rdma_handle_command+0xa4/0x2e8 [nvmet_rdma]
>>>> [199856.845575]  nvmet_rdma_recv_done+0xcc/0x240 [nvmet_rdma]
>>>> [199856.851109]  __ib_process_cq+0x84/0xf0 [ib_core]
>>>> [199856.855858]  ib_cq_poll_work+0x34/0xa0 [ib_core]
>>>> [199856.860587]  process_one_work+0x1ec/0x4a0
>>>> [199856.864694]  worker_thread+0x48/0x490
>>>> [199856.868453]  kthread+0x158/0x160
>>>> [199856.871779]  ret_from_fork+0x10/0x18
>>>> -- 
>>>>
>>>> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
>>>> ---
>>>> Note this patch is not yet tested, but sending it for visibility and
>>>> early feedback. While nothing prevents ib_drain_cq to process a cq
>>>> directly (even if it has another context) I am not convinced if all
>>>> the upper layers don't have any assumptions about a single context
>>>> consuming the cq, even if it is while it is drained. It is also
>>>> possible to to add ib_reap_cq that fences the cq poll context before
>>>> reaping the cq, but this may have other side-effects.
>>> Did you have a chance to test this patch?
>>> I looked at the code and it seems to be correct change, but I also 
>>> don't
>>> know about all ULP assumptions.
>>
>> Not yet...
>>
>> One thing that is problematic with this patch though is that there is no
>> stopping condition to the direct poll. So if the CQ is shared among a 
>> number of
>> qps (and srq's), nothing prevents the polling from consume 
>> completions forever...
>>
>> So we probably need it to be:
>> -- 
>> diff --git a/drivers/infiniband/core/verbs.c 
>> b/drivers/infiniband/core/verbs.c
>> index 580e9019e96a..f411fef35938 100644
>> --- a/drivers/infiniband/core/verbs.c
>> +++ b/drivers/infiniband/core/verbs.c
>> @@ -2971,7 +2971,7 @@ void ib_drain_qp(struct ib_qp *qp)
>>                  * guarantees that the ulp will free resources and 
>> only then
>>                  * consume the recv completion.
>>                  */
>> -               ib_process_cq_direct(qp->recv_cq, -1);
>> +               ib_process_cq_direct(qp->recv_cq, qp->recv_cq->cqe);
>
> I tried to fix the problem few years ago in [1] but eventually the 
> patchset was not accepted.
>
> We should probably try to improve the original series (using cq->cqe 
> instead of -1 for example) and upstream it.
>
> [1] 
> https://lore.kernel.org/all/1516197178-26493-1-git-send-email-maxg@mellanox.com/

Yes. I'd like to know if the qp event is needed though, given that the 
qp is already in error state (from the sq drain)
and then we run a single pass over the recv_cq, is it possible to miss 
any completions.

Would like to resolve the drain without involving the ulp drivers.

If so, then perhaps we can intercept the qp event at the core, before 
sending it to the ulp and there we can complete
the srq completion.

