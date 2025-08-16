Return-Path: <linux-rdma+bounces-12792-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF945B28F49
	for <lists+linux-rdma@lfdr.de>; Sat, 16 Aug 2025 17:57:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FFA0567CE9
	for <lists+linux-rdma@lfdr.de>; Sat, 16 Aug 2025 15:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F0A3252904;
	Sat, 16 Aug 2025 15:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LdoNlsDB"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6183413C3F6;
	Sat, 16 Aug 2025 15:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755359843; cv=none; b=eqQxrLvLUaaliWmGjTvU9dp4PSOmn36D79+6cenP9WiQnxX1lBCRwMAsLm3YZf6KeMGHEnUAp03T0RcG9VUcjnKPC9P4b/7inxHpX09ImaCG2Tiqs7zjBzODueCehemFMg4FtQIjlusD4ToR6H2/khDIEewaqwIqUKGNRZsgsl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755359843; c=relaxed/simple;
	bh=vYuo0S/VGbvqxecrh2gAvRdUs7OS1lRM6r0zHmTQ0qg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ANciGNIb8aJRkG/oaWna8SmqV+GFzHmLwFT063UGZXytbW+NMOUrmmLb5q7nQyCuLIBjUv2t10M7V1wk1pkB838KnpA7Sy47EOWy4WtcI16x5kUemfSp6/wyWyck7ZopI7w6vj/lz8hdTeIAI5lax5dU11H/PasxLK4kWZlzmc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LdoNlsDB; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-76e2eb3726cso1726479b3a.3;
        Sat, 16 Aug 2025 08:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755359841; x=1755964641; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LPrc/JNd/wTypW/D8hqYJr0cpHoxHtqjo2RpMW8vmM0=;
        b=LdoNlsDBZgfWz6JG8v5fkXMQuKVicrlYFUD0GZothmqbPhiw3f9Sqczj2Wlisqnugj
         Kr7Spa2/6GtQ9T/NrvTfJWX/prO7TGFSgGbzWTaWr5no0n131FDnwdfxYIoz9oNrJs+S
         Q5N3ha/qdnOd4+YuXzfpKBZZBPEBEXNEHCEG/fRBppiIcDKVNf+vFQbpOWPaCNfXQwHu
         BkxaZCnsjmUGqhXftkR4jMVGafhItt8DBZ88XqjvKbQDNleIJO7EwfUmJcr+SikJrv4C
         8gj9g/RFs2tRhWuhTfOPzaSgb2sxo1XtJ4nmn83IdBnopxl7hYhlkDJnsVcFBOYu0heS
         876Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755359841; x=1755964641;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LPrc/JNd/wTypW/D8hqYJr0cpHoxHtqjo2RpMW8vmM0=;
        b=nyV+RXZ6Leywu75tIKrW6ikXjmH/466TCKgEH5ELwwP9KhlGun4AV8jg4GBDU8wsDV
         S4BHpPEewCya92zmTSZA/JPnMOCE81hTH39kPY/PyzzYIu3Q5bpigGPc9A7txqgsR3qG
         mgM9m3bCQXKZ+lWPQ7ngGmv0S3lRhLRaJcKkZ7C9jgJeIplbWV07mYAx4ibvVbKnkUvG
         r9oio01Kxs3a3tQu2qrY6Zbx9p8/D8QmF7vHjaI/ZfXyXq5Ep7Yghz8ahYUg1P2ualUN
         naE9G25iFV+j2sjOZwDi4xEz/RuH9ol9QGOeGT5ELzYoViU6yodzhZjpUPYDhyVl6JNJ
         RbyA==
X-Forwarded-Encrypted: i=1; AJvYcCU9MeLE8nisbfnsOR1aoe0PRhXSWD+hIZxd/6a1sw5ykO78XvNapd75b4CFVzPake1jVY2+rzMFSqypc0M=@vger.kernel.org, AJvYcCWJjYuJ+arsBGdv5RljE8WFRrSQK86V9z1VlrpPAS03BY2lVXS9AZXwtImpj4Ldou09sTd7pxZD/ZMAqA==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywi12r1S5xU7c17NzQia9zWPmAZzaEr3KpQPSxK6bYb8Jsr0Bwy
	v3QrIPqMlrOG8Nxn7va+5oBTM5zWwrYhCUcHV061p962XWh5Zb72xF6L
X-Gm-Gg: ASbGnct3LOyPJc7wrvzQwZwoCupVALyhDkPcjYwh0iVyJOI0YpIUsva4PY14LvexRWq
	J2zZXJPpFMUSe/Yd+lkFX1yjVpltNEgT2xTUVSQtIRD8MEBVeO6/w30inp7bvC3zgsZ34o8Yunl
	UPPLhJAh+7V7SXqgXm0HKAGFhOAjcXKWj8+YKhvceiBSFRc7xw+NvKuz0j24qZrvUvipZ92mhuN
	NtGuNMBDTRZitM8MtCjVJR4nFPg3utFv8Ag1L4gGBeLIQwqMwES1G4Zvso6irYyh6E8HcaQhI0z
	SvMd6KYtNhyzZCvSFVC0IzYrNnNDhDTD5K6AhVzjBlWIQqaSJJESqXrdqiPeBYm8A6dIwoDFfBN
	4djNGoNVWVQlNU8o2C9GB7t6nNOqUyCD35R6cmOhzlZ6bro0XS95SHKPjqU0s9vZsHy/UGBsHuz
	PD
X-Google-Smtp-Source: AGHT+IEFPvtuRnIBemC6wyOM7XHbd/Xn9iPX4Zr2XuT5Tji0OwRWlX/hD0gOZTs9auasVdsf2mssQA==
X-Received: by 2002:a05:6a20:1594:b0:220:396b:991e with SMTP id adf61e73a8af0-240d2ff8054mr9953874637.32.1755359840528;
        Sat, 16 Aug 2025 08:57:20 -0700 (PDT)
Received: from [192.168.11.3] (FL1-125-195-176-151.tky.mesh.ad.jp. [125.195.176.151])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b472d76f9e0sm4025322a12.44.2025.08.16.08.57.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Aug 2025 08:57:20 -0700 (PDT)
Message-ID: <b9f63255-a10c-4b29-875f-69e4754c1800@gmail.com>
Date: Sun, 17 Aug 2025 00:57:17 +0900
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rdma_rxe: call comp_handler without holding cq->cq_lock
To: "Yanjun.Zhu" <yanjun.zhu@linux.dev>,
 Philipp Reisner <philipp.reisner@linbit.com>
Cc: Zhu Yanjun <zyjzyj2000@gmail.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250806123921.633410-1-philipp.reisner@linbit.com>
 <5a31f3ef-358f-4382-8ad1-8050569a2a23@linux.dev>
 <CADGDV=UgDb51nEtdide7k8==urCdrWcig8kBAY6k0PryR0c7xw@mail.gmail.com>
 <2b593684-4409-485b-9edf-e44a402ecf3a@linux.dev>
 <6dbc1383-0c9f-4648-ae8d-4219e89589f4@gmail.com>
 <885bb38c-4108-4fa2-a6d2-1e60d5e84af9@linux.dev>
 <620f8611-1e95-4ebd-9db2-eb7231cfb3f2@gmail.com>
 <a077b829-7fed-4f72-a854-f17759867604@linux.dev>
Content-Language: en-US
From: Daisuke Matsuda <dskmtsd@gmail.com>
In-Reply-To: <a077b829-7fed-4f72-a854-f17759867604@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2025/08/16 3:29, Yanjun.Zhu wrote:
> 
> On 8/14/25 7:07 AM, Daisuke Matsuda wrote:
>> On 2025/08/14 14:33, Zhu Yanjun wrote:
>>> 在 2025/8/12 8:54, Daisuke Matsuda 写道:
>>>> On 2025/08/11 22:48, Zhu Yanjun wrote:
>>>>> 在 2025/8/10 22:26, Philipp Reisner 写道:
>>>>>> On Thu, Aug 7, 2025 at 3:09 AM Zhu Yanjun <yanjun.zhu@linux.dev> wrote:
>>>>>>>
>>>>>>> 在 2025/8/6 5:39, Philipp Reisner 写道:
>>>>>>>> Allow the comp_handler callback implementation to call ib_poll_cq().
>>>>>>>> A call to ib_poll_cq() calls rxe_poll_cq() with the rdma_rxe driver.
>>>>>>>> And rxe_poll_cq() locks cq->cq_lock. That leads to a spinlock deadlock.
>>>>>>>>
>>>>>>>> The Mellanox and Intel drivers allow a comp_handler callback
>>>>>>>> implementation to call ib_poll_cq().
>>>>>>>>
>>>>>>>> Avoid the deadlock by calling the comp_handler callback without
>>>>>>>> holding cq->cw_lock.
>>>>>>>>
>>>>>>>> Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
>>>>>>>
>>>>>>> ERROR: test_resize_cq (tests.test_cq.CQTest.test_resize_cq)
>>>>>>> Test resize CQ, start with specific value and then increase and decrease
>>>>>>> ----------------------------------------------------------------------
>>>>>>> Traceback (most recent call last):
>>>>>>>     File "/root/deb/rdma-core/tests/test_cq.py", line 135, in test_resize_cq
>>>>>>>       u.poll_cq(self.client.cq)
>>>>>>>     File "/root/deb/rdma-core/tests/utils.py", line 687, in poll_cq
>>>>>>>       wcs = _poll_cq(cq, count, data)
>>>>>>>             ^^^^^^^^^^^^^^^^^^^^^^^^^
>>>>>>>     File "/root/deb/rdma-core/tests/utils.py", line 669, in _poll_cq
>>>>>>>       raise PyverbsError(f'Got timeout on polling ({count} CQEs remaining)')
>>>>>>> pyverbs.pyverbs_error.PyverbsError: Got timeout on polling (1 CQEs
>>>>>>> remaining)
>>>>>>>
>>>>>>> After I applied your patch in kervel v6.16, I got the above errors.
>>>>>>>
>>>>>>> Zhu Yanjun
>>>>>>>
>>>>>>
>>>>>> Hello Zhu,
>>>>>>
>>>>>> When I run the test_resize_cq test in a loop (100 runs each) on the
>>>>>> original code and with my patch, I get about the same failure rate.
>>>>>
>>>>> Add Daisuke Matsuda
>>>>>
>>>>> If I remember it correctly, when Daisuke and I discussed ODP patches, we both made tests with rxe, from our tests results, it seems that this test_resize_cq error does not occur.
>>>>
>>>> Hi Zhu and Philipp,
>>>>
>>>> As far as I know, this error has been present for some time.
>>>> It might be possible to investigate further by capturing a memory dump while the polling is stuck, but I have not had time to do that yet.
>>>> At least, I can confirm that this is not a regression caused by Philipp's patch.
>>>
>>> Hi, Daisuke
>>>
>>> Thanks a lot. I’m now able to consistently reproduce this problem. I have created a commit here: https://github.com/zhuyj/linux/commit/8db3abc00bf49cac6ea1d5718d28c6516c94fb4e.
>>>
>>> After applying this commit, I ran test_resize_cq 10,000 times, and the problem did not occur.
>>>
>>> I’m not sure if there’s a better way to fix this issue. If anyone has a better solution, please share it.
>>
>> Hi Zhu,
>>
>> Thank you very much for the investigation.
>>
>> I agree that the issue can be worked around by adding a delay in the rxe completer path.
>> However, since the issue is easily reproducible, introducing an explicit sleep might
>> add unnecessary overhead. I think a short busy-wait would be a more desirable alternative.
>>
>> The intermediate change below does make the issue disappear on my node, but I don't think
>> this is a complete solution. In particular, it appears that ibcq->event_handler() —
>> typically ib_uverbs_cq_event_handler() — is not re-entrant, so simply spinning like this
>> could be risky.
>>
>> ===
>> diff --git a/drivers/infiniband/sw/rxe/rxe_comp.c b/drivers/infiniband/sw/rxe/rxe_comp.c
>> index a5b2b62f596b..a10a173e53cf 100644
>> --- a/drivers/infiniband/sw/rxe/rxe_comp.c
>> +++ b/drivers/infiniband/sw/rxe/rxe_comp.c
>> @@ -454,7 +454,7 @@ static void do_complete(struct rxe_qp *qp, struct rxe_send_wqe *wqe)
>>         queue_advance_consumer(qp->sq.queue, QUEUE_TYPE_FROM_CLIENT);
>>
>>         if (post)
>> -               rxe_cq_post(qp->scq, &cqe, 0);
>> +               while (rxe_cq_post(qp->scq, &cqe, 0) == -EBUSY);
>>
>>         if (wqe->wr.opcode == IB_WR_SEND ||
>>             wqe->wr.opcode == IB_WR_SEND_WITH_IMM ||
>> ===
>>
>> If you agree with this direction, I can take some time in the next week or so to make a
>> formal patch. Of course, you are welcome to take over this idea if you prefer.
> 
> 
> Thanks for building on top of my earlier proposal and for sharing your findings. I appreciate the effort you’ve put into exploring this approach.
> 
> That said, there are a few concerns we should address before moving forward:
> 
> Busy-wait duration – It’s difficult to guarantee that the busy-wait will remain short. If it lasts too long, we may hit the “CPU is locked for too long” warnings, which could impact system responsiveness.
> 
> Placement of busy-wait – The current implementation adds the busy-wait after -EBUSY is returned, rather than at the exact location where it occurs. This may hide the actual contention source and could introduce side effects in other paths.
> 
> Reentrancy risk – Since ibcq->event_handler() (usually ib_uverbs_cq_event_handler()) is not re-entrant, spinning inside it could be risky and lead to subtle bugs.
> 
> I think the idea of avoiding a full sleep makes sense, but perhaps we could look into alternative approaches — for example, an adaptive delay mechanism or handling the -EBUSY condition closer to where it originates.
> 
> If you’re interested in pursuing this further, I’d be happy to review an updated patch. I believe this direction still has potential if we address the above points.

Other parts with similar queueing implementation do not present any problem,
so adding "an adaptive delay mechanism" only inside rxe_cq_post() looks the best solution.

I will look into and submit a patch

Thanks,
Daisuke


