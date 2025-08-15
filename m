Return-Path: <linux-rdma+bounces-12776-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 208B8B285CF
	for <lists+linux-rdma@lfdr.de>; Fri, 15 Aug 2025 20:30:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 219A85652AA
	for <lists+linux-rdma@lfdr.de>; Fri, 15 Aug 2025 18:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C03CF25A331;
	Fri, 15 Aug 2025 18:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QqtpQKBU"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C48101D9A5D
	for <linux-rdma@vger.kernel.org>; Fri, 15 Aug 2025 18:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755282599; cv=none; b=rs1TgY4fVbhCjVTXh8HulRmchQRzJ6jhpRkUx/7zNJo3yS7aPKF8l48aPMJa+brUk1RTOy3nhchYybCJ1OT0nQCxD8ZwcHlVqxpZPH13DUOa4CdATARHU9VkRLrIZU8in2BtBkyCvhRjySefDlJJKf8WqebO6MUpJaQqGlyS0iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755282599; c=relaxed/simple;
	bh=ONrYoJTIdgGb/5wF/dH1qo760V5msEGyARLjyAejL3Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DL0Sh15VydWwT3/r2txWrdR3qOgHhs0dHYZ68Gr3Ly+p+NH9VWi2pRoVzb8/JxSiCYc6WU7MnJ7bqbDhfgw4NwZWlCoD43hRZKFedidyobreL/uPcocIFl9S1Qc//Oq1mAqMMoq210v81FlbV6UEZwFbH3Sjg0XOIwrIVfufDsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QqtpQKBU; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <a077b829-7fed-4f72-a854-f17759867604@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755282594;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NTIIr6J1qWMNNwEbgzgtDoYE0QB1SAchhR4ySYVGnL4=;
	b=QqtpQKBUtwQfDlctzpZTyRwGcr5ZmcyvMKFSx0HnX3yd5lXJj+vEIcR1GRUYd4UXStIQj1
	DGTnmtP19u1vavolBvT++8LVUgpz6mlgPOh5BYW+Oy+InnRLVTEVrZ+l5rFIkeebaqC6BB
	JVBeErO1m9KRFoW5z11fojYVhT9K++w=
Date: Fri, 15 Aug 2025 11:29:38 -0700
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
 <885bb38c-4108-4fa2-a6d2-1e60d5e84af9@linux.dev>
 <620f8611-1e95-4ebd-9db2-eb7231cfb3f2@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Yanjun.Zhu" <yanjun.zhu@linux.dev>
In-Reply-To: <620f8611-1e95-4ebd-9db2-eb7231cfb3f2@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 8/14/25 7:07 AM, Daisuke Matsuda wrote:
> On 2025/08/14 14:33, Zhu Yanjun wrote:
>> 在 2025/8/12 8:54, Daisuke Matsuda 写道:
>>> On 2025/08/11 22:48, Zhu Yanjun wrote:
>>>> 在 2025/8/10 22:26, Philipp Reisner 写道:
>>>>> On Thu, Aug 7, 2025 at 3:09 AM Zhu Yanjun <yanjun.zhu@linux.dev> 
>>>>> wrote:
>>>>>>
>>>>>> 在 2025/8/6 5:39, Philipp Reisner 写道:
>>>>>>> Allow the comp_handler callback implementation to call 
>>>>>>> ib_poll_cq().
>>>>>>> A call to ib_poll_cq() calls rxe_poll_cq() with the rdma_rxe 
>>>>>>> driver.
>>>>>>> And rxe_poll_cq() locks cq->cq_lock. That leads to a spinlock 
>>>>>>> deadlock.
>>>>>>>
>>>>>>> The Mellanox and Intel drivers allow a comp_handler callback
>>>>>>> implementation to call ib_poll_cq().
>>>>>>>
>>>>>>> Avoid the deadlock by calling the comp_handler callback without
>>>>>>> holding cq->cw_lock.
>>>>>>>
>>>>>>> Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
>>>>>>
>>>>>> ERROR: test_resize_cq (tests.test_cq.CQTest.test_resize_cq)
>>>>>> Test resize CQ, start with specific value and then increase and 
>>>>>> decrease
>>>>>> ---------------------------------------------------------------------- 
>>>>>>
>>>>>> Traceback (most recent call last):
>>>>>>     File "/root/deb/rdma-core/tests/test_cq.py", line 135, in 
>>>>>> test_resize_cq
>>>>>>       u.poll_cq(self.client.cq)
>>>>>>     File "/root/deb/rdma-core/tests/utils.py", line 687, in poll_cq
>>>>>>       wcs = _poll_cq(cq, count, data)
>>>>>>             ^^^^^^^^^^^^^^^^^^^^^^^^^
>>>>>>     File "/root/deb/rdma-core/tests/utils.py", line 669, in _poll_cq
>>>>>>       raise PyverbsError(f'Got timeout on polling ({count} CQEs 
>>>>>> remaining)')
>>>>>> pyverbs.pyverbs_error.PyverbsError: Got timeout on polling (1 CQEs
>>>>>> remaining)
>>>>>>
>>>>>> After I applied your patch in kervel v6.16, I got the above errors.
>>>>>>
>>>>>> Zhu Yanjun
>>>>>>
>>>>>
>>>>> Hello Zhu,
>>>>>
>>>>> When I run the test_resize_cq test in a loop (100 runs each) on the
>>>>> original code and with my patch, I get about the same failure rate.
>>>>
>>>> Add Daisuke Matsuda
>>>>
>>>> If I remember it correctly, when Daisuke and I discussed ODP 
>>>> patches, we both made tests with rxe, from our tests results, it 
>>>> seems that this test_resize_cq error does not occur.
>>>
>>> Hi Zhu and Philipp,
>>>
>>> As far as I know, this error has been present for some time.
>>> It might be possible to investigate further by capturing a memory 
>>> dump while the polling is stuck, but I have not had time to do that 
>>> yet.
>>> At least, I can confirm that this is not a regression caused by 
>>> Philipp's patch.
>>
>> Hi, Daisuke
>>
>> Thanks a lot. I’m now able to consistently reproduce this problem. I 
>> have created a commit here: 
>> https://github.com/zhuyj/linux/commit/8db3abc00bf49cac6ea1d5718d28c6516c94fb4e.
>>
>> After applying this commit, I ran test_resize_cq 10,000 times, and 
>> the problem did not occur.
>>
>> I’m not sure if there’s a better way to fix this issue. If anyone has 
>> a better solution, please share it.
>
> Hi Zhu,
>
> Thank you very much for the investigation.
>
> I agree that the issue can be worked around by adding a delay in the 
> rxe completer path.
> However, since the issue is easily reproducible, introducing an 
> explicit sleep might
> add unnecessary overhead. I think a short busy-wait would be a more 
> desirable alternative.
>
> The intermediate change below does make the issue disappear on my 
> node, but I don't think
> this is a complete solution. In particular, it appears that 
> ibcq->event_handler() —
> typically ib_uverbs_cq_event_handler() — is not re-entrant, so simply 
> spinning like this
> could be risky.
>
> ===
> diff --git a/drivers/infiniband/sw/rxe/rxe_comp.c 
> b/drivers/infiniband/sw/rxe/rxe_comp.c
> index a5b2b62f596b..a10a173e53cf 100644
> --- a/drivers/infiniband/sw/rxe/rxe_comp.c
> +++ b/drivers/infiniband/sw/rxe/rxe_comp.c
> @@ -454,7 +454,7 @@ static void do_complete(struct rxe_qp *qp, struct 
> rxe_send_wqe *wqe)
>         queue_advance_consumer(qp->sq.queue, QUEUE_TYPE_FROM_CLIENT);
>
>         if (post)
> -               rxe_cq_post(qp->scq, &cqe, 0);
> +               while (rxe_cq_post(qp->scq, &cqe, 0) == -EBUSY);
>
>         if (wqe->wr.opcode == IB_WR_SEND ||
>             wqe->wr.opcode == IB_WR_SEND_WITH_IMM ||
> ===
>
> If you agree with this direction, I can take some time in the next 
> week or so to make a
> formal patch. Of course, you are welcome to take over this idea if you 
> prefer.


Thanks for building on top of my earlier proposal and for sharing your 
findings. I appreciate the effort you’ve put into exploring this approach.

That said, there are a few concerns we should address before moving forward:

Busy-wait duration – It’s difficult to guarantee that the busy-wait will 
remain short. If it lasts too long, we may hit the “CPU is locked for 
too long” warnings, which could impact system responsiveness.

Placement of busy-wait – The current implementation adds the busy-wait 
after -EBUSY is returned, rather than at the exact location where it 
occurs. This may hide the actual contention source and could introduce 
side effects in other paths.

Reentrancy risk – Since ibcq->event_handler() (usually 
ib_uverbs_cq_event_handler()) is not re-entrant, spinning inside it 
could be risky and lead to subtle bugs.

I think the idea of avoiding a full sleep makes sense, but perhaps we 
could look into alternative approaches — for example, an adaptive delay 
mechanism or handling the -EBUSY condition closer to where it originates.

If you’re interested in pursuing this further, I’d be happy to review an 
updated patch. I believe this direction still has potential if we 
address the above points.

Thanks again for your contribution, and I look forward to your next version.
Best regards,

Yanjun.Zhu

>
> Thanks,
> Daisuke
>
>>
>> Thanks a lot.
>> Zhu Yanjun
>>
>>>
>>> Thanks,
>>> Daisuke
>>>
>>
>

