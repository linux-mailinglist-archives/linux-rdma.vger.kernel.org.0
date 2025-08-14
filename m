Return-Path: <linux-rdma+bounces-12731-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7823FB25ACC
	for <lists+linux-rdma@lfdr.de>; Thu, 14 Aug 2025 07:33:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7702C682C1A
	for <lists+linux-rdma@lfdr.de>; Thu, 14 Aug 2025 05:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4538021FF58;
	Thu, 14 Aug 2025 05:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lYzao/mH"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE76E214209
	for <linux-rdma@vger.kernel.org>; Thu, 14 Aug 2025 05:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755149622; cv=none; b=Ndb0z16PYaCZiI5uphRNnWE64Sc9UPOOcaIsi+F4B2Rju49uPvtN0ZH7xT7zad2UZvYaqCVTtKWIDK0+rkob2nibl8HXBQAfM2osvyo1+BkqXqbMi19Lu0VYfqcc4InenFY9tV0uPUdifWHuQ9mHeCzMtkzuEGljwYXBXNuppyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755149622; c=relaxed/simple;
	bh=VcUo178fVNWvpH78Ju8+yLQGLn0LituxlSDmfbhM0LY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cNM/2T3viGSbn4tnQ5/5/6/e0qdMODdjQAKdlUxAERiAXFxP3dcNhhf4bSk5vrl0wiFmATKsgoLVi7zMXD3fiYUmPb5ShvI4Xm/vSLAycW4+p/r1bDwlbSHG1jycUuMoXxg14KxG721J6uz5qdIBVdoc5zRBxAwYvRbhqantOWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lYzao/mH; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <885bb38c-4108-4fa2-a6d2-1e60d5e84af9@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755149616;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2ysRfz7QSkDUSCKxN1w9k+s3LEZAMPvR/U4yfJKX0uA=;
	b=lYzao/mHPw2bZYsq0g+6APeT5i30dOkMFJTAvWOplyAxui4+tS8HT8oHLNhre9hhg7+/+Y
	O0p8KoQMXRkpq+emsPeu/QubcYgoJLT4Oazizr/3woSR/sRkfVQpzZlhFzW1dvLI1sChky
	KmRgttXq/FCT+vIfXnPN8krre1drtEI=
Date: Wed, 13 Aug 2025 22:33:18 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] rdma_rxe: call comp_handler without holding cq->cq_lock
To: Daisuke Matsuda <dskmtsd@gmail.com>,
 Philipp Reisner <philipp.reisner@linbit.com>
Cc: Zhu Yanjun <zyjzyj2000@gmail.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250806123921.633410-1-philipp.reisner@linbit.com>
 <5a31f3ef-358f-4382-8ad1-8050569a2a23@linux.dev>
 <CADGDV=UgDb51nEtdide7k8==urCdrWcig8kBAY6k0PryR0c7xw@mail.gmail.com>
 <2b593684-4409-485b-9edf-e44a402ecf3a@linux.dev>
 <6dbc1383-0c9f-4648-ae8d-4219e89589f4@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <6dbc1383-0c9f-4648-ae8d-4219e89589f4@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2025/8/12 8:54, Daisuke Matsuda 写道:
> On 2025/08/11 22:48, Zhu Yanjun wrote:
>> 在 2025/8/10 22:26, Philipp Reisner 写道:
>>> On Thu, Aug 7, 2025 at 3:09 AM Zhu Yanjun <yanjun.zhu@linux.dev> wrote:
>>>>
>>>> 在 2025/8/6 5:39, Philipp Reisner 写道:
>>>>> Allow the comp_handler callback implementation to call ib_poll_cq().
>>>>> A call to ib_poll_cq() calls rxe_poll_cq() with the rdma_rxe driver.
>>>>> And rxe_poll_cq() locks cq->cq_lock. That leads to a spinlock 
>>>>> deadlock.
>>>>>
>>>>> The Mellanox and Intel drivers allow a comp_handler callback
>>>>> implementation to call ib_poll_cq().
>>>>>
>>>>> Avoid the deadlock by calling the comp_handler callback without
>>>>> holding cq->cw_lock.
>>>>>
>>>>> Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
>>>>
>>>> ERROR: test_resize_cq (tests.test_cq.CQTest.test_resize_cq)
>>>> Test resize CQ, start with specific value and then increase and 
>>>> decrease
>>>> ----------------------------------------------------------------------
>>>> Traceback (most recent call last):
>>>>     File "/root/deb/rdma-core/tests/test_cq.py", line 135, in 
>>>> test_resize_cq
>>>>       u.poll_cq(self.client.cq)
>>>>     File "/root/deb/rdma-core/tests/utils.py", line 687, in poll_cq
>>>>       wcs = _poll_cq(cq, count, data)
>>>>             ^^^^^^^^^^^^^^^^^^^^^^^^^
>>>>     File "/root/deb/rdma-core/tests/utils.py", line 669, in _poll_cq
>>>>       raise PyverbsError(f'Got timeout on polling ({count} CQEs 
>>>> remaining)')
>>>> pyverbs.pyverbs_error.PyverbsError: Got timeout on polling (1 CQEs
>>>> remaining)
>>>>
>>>> After I applied your patch in kervel v6.16, I got the above errors.
>>>>
>>>> Zhu Yanjun
>>>>
>>>
>>> Hello Zhu,
>>>
>>> When I run the test_resize_cq test in a loop (100 runs each) on the
>>> original code and with my patch, I get about the same failure rate.
>>
>> Add Daisuke Matsuda
>>
>> If I remember it correctly, when Daisuke and I discussed ODP patches, 
>> we both made tests with rxe, from our tests results, it seems that 
>> this test_resize_cq error does not occur.
> 
> Hi Zhu and Philipp,
> 
> As far as I know, this error has been present for some time.
> It might be possible to investigate further by capturing a memory dump 
> while the polling is stuck, but I have not had time to do that yet.
> At least, I can confirm that this is not a regression caused by 
> Philipp's patch.

Hi, Daisuke

Thanks a lot. I’m now able to consistently reproduce this problem. I 
have created a commit here: 
https://github.com/zhuyj/linux/commit/8db3abc00bf49cac6ea1d5718d28c6516c94fb4e.

After applying this commit, I ran test_resize_cq 10,000 times, and the 
problem did not occur.

I’m not sure if there’s a better way to fix this issue. If anyone has a 
better solution, please share it.

Thanks a lot.
Zhu Yanjun

> 
> Thanks,
> Daisuke
> 


