Return-Path: <linux-rdma+bounces-12688-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68904B22CD1
	for <lists+linux-rdma@lfdr.de>; Tue, 12 Aug 2025 18:12:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E37786223FD
	for <lists+linux-rdma@lfdr.de>; Tue, 12 Aug 2025 16:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 472F326E6FA;
	Tue, 12 Aug 2025 15:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q92L41Zr"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B98305E3D;
	Tue, 12 Aug 2025 15:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755014053; cv=none; b=QigxcuSnfRLO1FzATOpjXNGn1iBymi4g+MnMOKUH1Nx9bIMk+mj/jLvgkO0iUqFgWZakS+CCHFiUQ5ag2r7zXdWpTOyj1S/xhq+gAlRLHtY+0gl9I/GdtZB0mhh/kGzUHMBujp+/60OcmW1zMjlxeWgh4R3QxNbnRobtrdM3gOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755014053; c=relaxed/simple;
	bh=LnSL/I4TDJTGUKy/9MU9LngUaRGtkr4yj5O7VSL9eso=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b7ykKj/eEIUU1iY9Ona7M/y2rvqbJEe2Kv5zRiKqZWc+SPN5FRaXbZTPtHSSxjinSKXtBT8BPJIfr9tgc8VEpakUQ1oXTF8s19mdVsOZPnJ+HNBOfcY+Zy8oO8IdDtEWgsVkWEWDREhMbrWToqa1jZ/z/ZYXFdrICHFoq3OIe9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q92L41Zr; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-747e41d5469so6345122b3a.3;
        Tue, 12 Aug 2025 08:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755014051; x=1755618851; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0XGUKeIytn27uH12AB55KaSCGBl+m42SQlOGJHqsv6A=;
        b=Q92L41ZrfAZsHFuMAlKkn0YAiwqGH/SHDtjW5aqF7iTlYS/MhUdCxNMAD+sO5RX9TM
         vml2F+p39ONAAp3r8GqVhpQept6vLf5DVLX6BwJ2iDwohOt/nnnnJHBcsVLMbvR8p4H9
         z3dOIg4B4huEiNZkFnW45YInIsNHs7KU0aLwwJs44Sm8wQMo5pZgIgmYF3wQ9AvbCoZs
         RZBeoQmRg2N6VSBMgzXrt4R0fUUxtLtQpRJZlFLXe/mE7bYlwaGEF4MEu+EBepJ/vGxz
         F8EkRCkUY4eIGb9BkZJPc7BYhPMqtjZp4qYUV50TlRMYOA9WU4y7M5ezfi19ne8hxOcn
         5wZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755014051; x=1755618851;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0XGUKeIytn27uH12AB55KaSCGBl+m42SQlOGJHqsv6A=;
        b=Bt0ORmO2uMMS3fttopVlYIBHpwud6s8oOGbhM+IVU9JRhyGFrHv+R5ECNAMNHDeTng
         DSQamv8snhgew+EnWJ7uGpisrJIAZVY1lwCG8zY1Ksc6qvfmfewTALp8FuVJYCS2OM/K
         7akD/QUge5omPCQHDuEtjce5hp1Wd+1UaBvvo+X9w08UIE5mSi0VrfAplFHPp8hxm16+
         8A25Jh62n4ARLiQWE6NCRCzph/q6fgPu82yy1MrBScHQV76Pn78tYQMmqHv411gOfX9l
         W0CF+EI9I74CgIbFU2piZd3lilwGzgaspgzyq/sECkM/SNP4EmxBn5pzc8SI8QBFQMBx
         erQA==
X-Forwarded-Encrypted: i=1; AJvYcCUzZAOB6sz5DUVHAPnwjp2VyF4ZsaZzMzC/Kd8UU34znx/UEtqUAySLJO26O3nOwMUjBzxscXE9DstLrg==@vger.kernel.org, AJvYcCVSr5af9d8QvW6gUPwBKMG12K0CunFecfZEvyhNjJzVeFnZNJe7j5HRjmy53MLQd84OrKVLFQy64oDqPd8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuTYs72KUcPBTnQd1nYUevEBtKdLbiqEQZx4d3EvNuQHfAhOLZ
	5xTE7oce2Q21COHtSOsNfiWVbFYruv2y3rgOcOtX/k8HpyllATISNkpH
X-Gm-Gg: ASbGncvRrg1IzgSGtIM5XN2fOWkt2Kb/dPOQzbBXKBQQJOKzjUdRuR0cYXajkcl6SHU
	nG8cGRFFM53C4rxK58k7NyVVOh1HC8Z/bSo0JM1C44Epq0dZVpj2sW200ampvNASIUV0UVbGH4G
	Hy1omaHAK/hd2Sw5X61H3bBURIIFvUtA4K0YqsWtFwD/gbFxFBHzW2oWGvRZDw5rjeuLiXY+Bhh
	8tJMaDUk0JTOCQxeRgxTUDweNaVH1gAJ1OW+3vQGJW1dtFj7JaZ3DiLbI/+IifnPduJH1GvH/9Z
	yqYQ/VREw3uFnaMEc1z2VKHQxqvGbcg6YJZ3qnqvKOxG2qdzdMSee/wU4NnF9r+drWkXxxi4ofN
	34CnlZTrcWqi/NExcu5ewucEqgkQowiTyxM2u1W46tb0IBhhPaDGeadyaC6GrrEam6BTxcO4jcG
	SqGPEhFo2zZLc=
X-Google-Smtp-Source: AGHT+IFLqFHsJ/JQ/5sC88VOK4z7IOEAGPfo9DDCHF6jNVPKl4dgKGPZixbMByjSwwABeaYTRyniew==
X-Received: by 2002:a05:6a00:66ce:b0:748:2ac2:f8c3 with SMTP id d2e1a72fcca58-76e1fe1f6e5mr47541b3a.24.1755014050666;
        Tue, 12 Aug 2025 08:54:10 -0700 (PDT)
Received: from [192.168.11.3] (FL1-125-195-176-151.tky.mesh.ad.jp. [125.195.176.151])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bccfd026dsm29748464b3a.95.2025.08.12.08.54.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Aug 2025 08:54:10 -0700 (PDT)
Message-ID: <6dbc1383-0c9f-4648-ae8d-4219e89589f4@gmail.com>
Date: Wed, 13 Aug 2025 00:54:06 +0900
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rdma_rxe: call comp_handler without holding cq->cq_lock
To: Zhu Yanjun <yanjun.zhu@linux.dev>,
 Philipp Reisner <philipp.reisner@linbit.com>
Cc: Zhu Yanjun <zyjzyj2000@gmail.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250806123921.633410-1-philipp.reisner@linbit.com>
 <5a31f3ef-358f-4382-8ad1-8050569a2a23@linux.dev>
 <CADGDV=UgDb51nEtdide7k8==urCdrWcig8kBAY6k0PryR0c7xw@mail.gmail.com>
 <2b593684-4409-485b-9edf-e44a402ecf3a@linux.dev>
Content-Language: en-US
From: Daisuke Matsuda <dskmtsd@gmail.com>
In-Reply-To: <2b593684-4409-485b-9edf-e44a402ecf3a@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2025/08/11 22:48, Zhu Yanjun wrote:
> 在 2025/8/10 22:26, Philipp Reisner 写道:
>> On Thu, Aug 7, 2025 at 3:09 AM Zhu Yanjun <yanjun.zhu@linux.dev> wrote:
>>>
>>> 在 2025/8/6 5:39, Philipp Reisner 写道:
>>>> Allow the comp_handler callback implementation to call ib_poll_cq().
>>>> A call to ib_poll_cq() calls rxe_poll_cq() with the rdma_rxe driver.
>>>> And rxe_poll_cq() locks cq->cq_lock. That leads to a spinlock deadlock.
>>>>
>>>> The Mellanox and Intel drivers allow a comp_handler callback
>>>> implementation to call ib_poll_cq().
>>>>
>>>> Avoid the deadlock by calling the comp_handler callback without
>>>> holding cq->cw_lock.
>>>>
>>>> Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
>>>
>>> ERROR: test_resize_cq (tests.test_cq.CQTest.test_resize_cq)
>>> Test resize CQ, start with specific value and then increase and decrease
>>> ----------------------------------------------------------------------
>>> Traceback (most recent call last):
>>>     File "/root/deb/rdma-core/tests/test_cq.py", line 135, in test_resize_cq
>>>       u.poll_cq(self.client.cq)
>>>     File "/root/deb/rdma-core/tests/utils.py", line 687, in poll_cq
>>>       wcs = _poll_cq(cq, count, data)
>>>             ^^^^^^^^^^^^^^^^^^^^^^^^^
>>>     File "/root/deb/rdma-core/tests/utils.py", line 669, in _poll_cq
>>>       raise PyverbsError(f'Got timeout on polling ({count} CQEs remaining)')
>>> pyverbs.pyverbs_error.PyverbsError: Got timeout on polling (1 CQEs
>>> remaining)
>>>
>>> After I applied your patch in kervel v6.16, I got the above errors.
>>>
>>> Zhu Yanjun
>>>
>>
>> Hello Zhu,
>>
>> When I run the test_resize_cq test in a loop (100 runs each) on the
>> original code and with my patch, I get about the same failure rate.
> 
> Add Daisuke Matsuda
> 
> If I remember it correctly, when Daisuke and I discussed ODP patches, we both made tests with rxe, from our tests results, it seems that this test_resize_cq error does not occur.

Hi Zhu and Philipp,

As far as I know, this error has been present for some time.
It might be possible to investigate further by capturing a memory dump while the polling is stuck, but I have not had time to do that yet.
At least, I can confirm that this is not a regression caused by Philipp's patch.

Thanks,
Daisuke


