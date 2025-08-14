Return-Path: <linux-rdma+bounces-12765-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ABB39B2691E
	for <lists+linux-rdma@lfdr.de>; Thu, 14 Aug 2025 16:24:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE59D1CE2DC9
	for <lists+linux-rdma@lfdr.de>; Thu, 14 Aug 2025 14:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 627ED1DDC35;
	Thu, 14 Aug 2025 14:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LAHk3EJq"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CCA8321439;
	Thu, 14 Aug 2025 14:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755180459; cv=none; b=i63eC/5s9B94BriToXn6y1BGXZVrNGuCzuPZqB9qWFVwKZi437uYALaEMljE8q0DoXVR1719GChkhBcfdiU6wojn220KNFMe51kQblUTCfEWwq1NkzLBBkzS1eSHPCN3uPMPZWCsIoH8mqaBwcLRJUphHBb/pddEHJTZwJAKyIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755180459; c=relaxed/simple;
	bh=ogP+TxjeUQ615opTCvKtc8nW60djt1JYUZPPSNMeeNI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SSeq6NrUC55oWsoo/tCgERHDul+4i5jFVJrwlmvAc0a1LsVURgKohbuEuemUbegpXEzw5keMTDW2IJHV5S3AxT3bA9hFF2whpXdp2rffW99LRC7nwBxCercWu7l3cl7/8jjuWLZIkS2B3fJLRZzYwAo/K2l653sAzik3uu3KmoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LAHk3EJq; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-76e39ec6f30so325492b3a.2;
        Thu, 14 Aug 2025 07:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755180457; x=1755785257; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O6cvNIV0xqhli0dmeveiiyFXh9agijpGuMN3/g8PfPY=;
        b=LAHk3EJqge7XC4z/eJKrVDNz3uPwyhU7pLc+q/1hK+INmUu9N25R40rDSUSGyGWfMW
         Wg67Tnj7hP03zGpGTb+xp6WQ0uibdkfm87cSrQP06gIMnL5HRtxta5HHJYYCHz6hYF/y
         xLZ12ENI/QnKhzb3NXS8G58tyjaNLp0gX/Gw5Go8rR5w3F/nK/Gs5mGB7Icb04Sft2DF
         HL/kte9aFt7F1X/OA2uJ2aCc3JrXi8aqvg5UpEDDsnamgx5IFcyYMos3SYlnTePhOoDO
         b7H68hPd3rSXmmKQjiw5Pt7nTuE3tPezPsleom5vTy6pPql0chI/OiZfSZFH4+eG0J2v
         +lvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755180457; x=1755785257;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O6cvNIV0xqhli0dmeveiiyFXh9agijpGuMN3/g8PfPY=;
        b=OozpV9PSxmUL5FiBlA8fRiwcH1QUShwhs0N8YsgESRQfzzB5DgRh9wRUJsntM83y1/
         VEvNVMEuu+vb5UXNwjmvd6Ff7H8Gbpb15VH+czllvWJsMlannI5kpjvm7A6wneTRJDfs
         NjBd9Ow4LV0PJuXGjpQiQ+syHW9aQvhpIo6viCbdqSrwMJDH9rU4CbG33q0K2Sh+hMbj
         yh4e88qTl/wQySa+EVzkWrxkCZDnDwhqSBLmaDbUiNsicaVw7D7BPed+h2K4ERZlSZ1j
         RMmIOuVzoAGP/lKjJDWNlWG8prvNZIO92TpJS7Tjy8WHFF+dcSEGvwgnfJUR4KTBnjFx
         TfBQ==
X-Forwarded-Encrypted: i=1; AJvYcCUtMjBpaH9n4FcnwqNE4MQ9N1J3wA5eFKY0LALVNJ+7aY+2A7iZjUqQQRzrhGhbTvudTY4MyvOtPF37pg==@vger.kernel.org, AJvYcCVPUv5+GYkUScPSyhU1fMPM/O5+wJy3QCei44fOHmFT1TwP9s3Az+O+iF4FcbZ5ApnaYreR+GWAKvJadRY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKvtYScPMoM4ldfP7NRq2Dh+5pr2IV8hb2G3EDT8KECAMXNC9P
	TfkpZ1XOTraiicNYJJJIs/uAB7qq6FXdBwh6/IKgVSizaczN4NABhRLc
X-Gm-Gg: ASbGncubSEUMkmgPtDpYzvdVsy1Gyxcra32k2QkX/RnsDLGxdz1Q7JQIO32AWDotg/j
	xjnsh5vmYOVkBVbTBrbGIxsHaX+FOpotzhtjkDTz3L/u3uSfeq1phiOmwwtL2UkROZGrQugsg1j
	YnrLDMabMdV25AFmqOR71iZf1r5gPW1oL2feYKejDm9NdbjWI3WWMZsahHjU40zhFjMhHFRw74J
	ba4+WBW9SDilZ17NDavpHoyISdOyPendndC430oklX+mdwiZG9ZR0vay3LZ5wZGupnL3hSYOrxU
	I6MU8+1OzfDIl2ChbQbSQ0oYPv8FlyRy/kU6ZXbWuJCAG9HAoV1sIDCD1ntRcjz/c0diT9p1ekR
	jlToFnQ2vxDTy2hIL6vbgavSnzup7qvmaWOk1zqT8rzR7gCEL2XZ5689fKHv7ASB2E+1ndr6aKE
	3g
X-Google-Smtp-Source: AGHT+IETXK2tayceA9Thr6gxuCMdcQM9N9NolHLj7dddZ1gHkfbEUG88wriyjfEjKMnlGI75KEkibg==
X-Received: by 2002:a05:6a20:939d:b0:230:69f1:620a with SMTP id adf61e73a8af0-240bd375c4fmr5308601637.42.1755180456653;
        Thu, 14 Aug 2025 07:07:36 -0700 (PDT)
Received: from [192.168.11.3] (FL1-125-195-176-151.tky.mesh.ad.jp. [125.195.176.151])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b43c54fbce4sm11782244a12.55.2025.08.14.07.07.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Aug 2025 07:07:36 -0700 (PDT)
Message-ID: <620f8611-1e95-4ebd-9db2-eb7231cfb3f2@gmail.com>
Date: Thu, 14 Aug 2025 23:07:33 +0900
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
 <6dbc1383-0c9f-4648-ae8d-4219e89589f4@gmail.com>
 <885bb38c-4108-4fa2-a6d2-1e60d5e84af9@linux.dev>
Content-Language: en-US
From: Daisuke Matsuda <dskmtsd@gmail.com>
In-Reply-To: <885bb38c-4108-4fa2-a6d2-1e60d5e84af9@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2025/08/14 14:33, Zhu Yanjun wrote:
> 在 2025/8/12 8:54, Daisuke Matsuda 写道:
>> On 2025/08/11 22:48, Zhu Yanjun wrote:
>>> 在 2025/8/10 22:26, Philipp Reisner 写道:
>>>> On Thu, Aug 7, 2025 at 3:09 AM Zhu Yanjun <yanjun.zhu@linux.dev> wrote:
>>>>>
>>>>> 在 2025/8/6 5:39, Philipp Reisner 写道:
>>>>>> Allow the comp_handler callback implementation to call ib_poll_cq().
>>>>>> A call to ib_poll_cq() calls rxe_poll_cq() with the rdma_rxe driver.
>>>>>> And rxe_poll_cq() locks cq->cq_lock. That leads to a spinlock deadlock.
>>>>>>
>>>>>> The Mellanox and Intel drivers allow a comp_handler callback
>>>>>> implementation to call ib_poll_cq().
>>>>>>
>>>>>> Avoid the deadlock by calling the comp_handler callback without
>>>>>> holding cq->cw_lock.
>>>>>>
>>>>>> Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
>>>>>
>>>>> ERROR: test_resize_cq (tests.test_cq.CQTest.test_resize_cq)
>>>>> Test resize CQ, start with specific value and then increase and decrease
>>>>> ----------------------------------------------------------------------
>>>>> Traceback (most recent call last):
>>>>>     File "/root/deb/rdma-core/tests/test_cq.py", line 135, in test_resize_cq
>>>>>       u.poll_cq(self.client.cq)
>>>>>     File "/root/deb/rdma-core/tests/utils.py", line 687, in poll_cq
>>>>>       wcs = _poll_cq(cq, count, data)
>>>>>             ^^^^^^^^^^^^^^^^^^^^^^^^^
>>>>>     File "/root/deb/rdma-core/tests/utils.py", line 669, in _poll_cq
>>>>>       raise PyverbsError(f'Got timeout on polling ({count} CQEs remaining)')
>>>>> pyverbs.pyverbs_error.PyverbsError: Got timeout on polling (1 CQEs
>>>>> remaining)
>>>>>
>>>>> After I applied your patch in kervel v6.16, I got the above errors.
>>>>>
>>>>> Zhu Yanjun
>>>>>
>>>>
>>>> Hello Zhu,
>>>>
>>>> When I run the test_resize_cq test in a loop (100 runs each) on the
>>>> original code and with my patch, I get about the same failure rate.
>>>
>>> Add Daisuke Matsuda
>>>
>>> If I remember it correctly, when Daisuke and I discussed ODP patches, we both made tests with rxe, from our tests results, it seems that this test_resize_cq error does not occur.
>>
>> Hi Zhu and Philipp,
>>
>> As far as I know, this error has been present for some time.
>> It might be possible to investigate further by capturing a memory dump while the polling is stuck, but I have not had time to do that yet.
>> At least, I can confirm that this is not a regression caused by Philipp's patch.
> 
> Hi, Daisuke
> 
> Thanks a lot. I’m now able to consistently reproduce this problem. I have created a commit here: https://github.com/zhuyj/linux/commit/8db3abc00bf49cac6ea1d5718d28c6516c94fb4e.
> 
> After applying this commit, I ran test_resize_cq 10,000 times, and the problem did not occur.
> 
> I’m not sure if there’s a better way to fix this issue. If anyone has a better solution, please share it.

Hi Zhu,

Thank you very much for the investigation.

I agree that the issue can be worked around by adding a delay in the rxe completer path.
However, since the issue is easily reproducible, introducing an explicit sleep might
add unnecessary overhead. I think a short busy-wait would be a more desirable alternative.

The intermediate change below does make the issue disappear on my node, but I don't think
this is a complete solution. In particular, it appears that ibcq->event_handler() —
typically ib_uverbs_cq_event_handler() — is not re-entrant, so simply spinning like this
could be risky.

===
diff --git a/drivers/infiniband/sw/rxe/rxe_comp.c b/drivers/infiniband/sw/rxe/rxe_comp.c
index a5b2b62f596b..a10a173e53cf 100644
--- a/drivers/infiniband/sw/rxe/rxe_comp.c
+++ b/drivers/infiniband/sw/rxe/rxe_comp.c
@@ -454,7 +454,7 @@ static void do_complete(struct rxe_qp *qp, struct rxe_send_wqe *wqe)
         queue_advance_consumer(qp->sq.queue, QUEUE_TYPE_FROM_CLIENT);

         if (post)
-               rxe_cq_post(qp->scq, &cqe, 0);
+               while (rxe_cq_post(qp->scq, &cqe, 0) == -EBUSY);

         if (wqe->wr.opcode == IB_WR_SEND ||
             wqe->wr.opcode == IB_WR_SEND_WITH_IMM ||
===

If you agree with this direction, I can take some time in the next week or so to make a
formal patch. Of course, you are welcome to take over this idea if you prefer.

Thanks,
Daisuke

> 
> Thanks a lot.
> Zhu Yanjun
> 
>>
>> Thanks,
>> Daisuke
>>
> 


