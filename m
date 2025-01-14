Return-Path: <linux-rdma+bounces-7002-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B833DA102E6
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Jan 2025 10:21:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5795F7A26FA
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Jan 2025 09:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80BAE1D555;
	Tue, 14 Jan 2025 09:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hw4oft+r"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 392E322DC20
	for <linux-rdma@vger.kernel.org>; Tue, 14 Jan 2025 09:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736846491; cv=none; b=GCH7fqj7KeHHrBp/ngZeMlJs892V3KoSQTtObi0Tm0OAjwpXK4SU004PCqn7ZnwZAHklP7eeY3qS/34KXna3FmOkxvOjsYP1xxbiBoBPbglde3avJD/rVMtKhjR2jrwCgzyodL+tDu5+U8GJT2XQzdqDdTqoWU0Or82OYdZhOo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736846491; c=relaxed/simple;
	bh=/K0m5VdAkbzZYsL+cb6FOHaOxoTYdyoS7HV+CYZWeVc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kmKMYZ9Q1+CcQBMOg8CxwlI2dfuk4MypWu61hvnrKpODGUEANq955961+aRlvTcrwhvQWWo/szdtlrLxTmoAKBK6OE6LpOdbutr/4DEKMVj5xpPEjOzV32nC60OO+SpV0Ks9ywyvDfmEnJ0anrayebgDmwUEn0gYK5BPuhdNaJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hw4oft+r; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <0fb49f1e-e8a8-42fb-b448-2e168a8b2940@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1736846481;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nWWuigCdNRgvbmlsFtJEBeCnjmRO+gvmXBVpZunag0U=;
	b=hw4oft+rdBR6QyOSrs1hI4/Z70G4UE/VEX8Fg/gJtqTkwBpH3+VrCXse4XmudrBLCHKkvr
	47M3GFNWXPDnuaenBooHAzKwJDQJvEiEH9p/JUilvohxgg6vW9U0ZmRNtow5AIAg/49qka
	K5C2qDhqxHqb/6awOl63MxMcDP1B24M=
Date: Tue, 14 Jan 2025 10:21:19 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 1/1] RDMA/rxe: Fix the warning "__rxe_cleanup+0x12c/0x170
 [rdma_rxe]"
To: Joe Klein <joe.klein812@gmail.com>
Cc: zyjzyj2000@gmail.com, jgg@ziepe.ca, leon@kernel.org,
 linux-rdma@vger.kernel.org
References: <20250110160927.55014-1-yanjun.zhu@linux.dev>
 <CAHjRaAeCAUw3WGjKxvFqT_5XCTut-LbnrTKgPpLshn1jmH50Pg@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <CAHjRaAeCAUw3WGjKxvFqT_5XCTut-LbnrTKgPpLshn1jmH50Pg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 13.01.25 14:28, Joe Klein wrote:
> On Fri, Jan 10, 2025 at 5:09 PM Zhu Yanjun <yanjun.zhu@linux.dev> wrote:
>>
>> The Call Trace is as below:
>> "
>>    <TASK>
>>    ? show_regs.cold+0x1a/0x1f
>>    ? __rxe_cleanup+0x12c/0x170 [rdma_rxe]
>>    ? __warn+0x84/0xd0
>>    ? __rxe_cleanup+0x12c/0x170 [rdma_rxe]
>>    ? report_bug+0x105/0x180
>>    ? handle_bug+0x46/0x80
>>    ? exc_invalid_op+0x19/0x70
>>    ? asm_exc_invalid_op+0x1b/0x20
>>    ? __rxe_cleanup+0x12c/0x170 [rdma_rxe]
>>    ? __rxe_cleanup+0x124/0x170 [rdma_rxe]
>>    rxe_destroy_qp.cold+0x24/0x29 [rdma_rxe]
>>    ib_destroy_qp_user+0x118/0x190 [ib_core]
>>    rdma_destroy_qp.cold+0x43/0x5e [rdma_cm]
>>    rtrs_cq_qp_destroy.cold+0x1d/0x2b [rtrs_core]
>>    rtrs_srv_close_work.cold+0x1b/0x31 [rtrs_server]
>>    process_one_work+0x21d/0x3f0
>>    worker_thread+0x4a/0x3c0
>>    ? process_one_work+0x3f0/0x3f0
>>    kthread+0xf0/0x120
>>    ? kthread_complete_and_exit+0x20/0x20
>>    ret_from_fork+0x22/0x30
>>    </TASK>
>> "
>> When too many rdma resources are allocated, rxe needs more time to
>> handle these rdma resources. Sometimes with the current timeout, rxe
>> can not release the rdma resources correctly.
>>
>> Compared with other rdma drivers, a bigger timeout is used.
>>
>> Fixes: 215d0a755e1b ("RDMA/rxe: Stop lookup of partially built objects")
>> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> 
> We tested this patch. All the tests can pass with this patch.


Thanks a lot. Appreciate your testing.

Zhu Yanjun

> 
> Tested-by: Joe Klein <joe.klein812@gmail.com>
> 
>> ---
>>   drivers/infiniband/sw/rxe/rxe_pool.c | 11 +++++------
>>   1 file changed, 5 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
>> index 67567d62195e..d9cb682fd71f 100644
>> --- a/drivers/infiniband/sw/rxe/rxe_pool.c
>> +++ b/drivers/infiniband/sw/rxe/rxe_pool.c
>> @@ -178,7 +178,6 @@ int __rxe_cleanup(struct rxe_pool_elem *elem, bool sleepable)
>>   {
>>          struct rxe_pool *pool = elem->pool;
>>          struct xarray *xa = &pool->xa;
>> -       static int timeout = RXE_POOL_TIMEOUT;
>>          int ret, err = 0;
>>          void *xa_ret;
>>
>> @@ -202,19 +201,19 @@ int __rxe_cleanup(struct rxe_pool_elem *elem, bool sleepable)
>>           * return to rdma-core
>>           */
>>          if (sleepable) {
>> -               if (!completion_done(&elem->complete) && timeout) {
>> +               if (!completion_done(&elem->complete)) {
>>                          ret = wait_for_completion_timeout(&elem->complete,
>> -                                       timeout);
>> +                                       msecs_to_jiffies(50000));
>>
>>                          /* Shouldn't happen. There are still references to
>>                           * the object but, rather than deadlock, free the
>>                           * object or pass back to rdma-core.
>>                           */
>>                          if (WARN_ON(!ret))
>> -                               err = -EINVAL;
>> +                               err = -ETIMEDOUT;
>>                  }
>>          } else {
>> -               unsigned long until = jiffies + timeout;
>> +               unsigned long until = jiffies + RXE_POOL_TIMEOUT;
>>
>>                  /* AH objects are unique in that the destroy_ah verb
>>                   * can be called in atomic context. This delay
>> @@ -226,7 +225,7 @@ int __rxe_cleanup(struct rxe_pool_elem *elem, bool sleepable)
>>                          mdelay(1);
>>
>>                  if (WARN_ON(!completion_done(&elem->complete)))
>> -                       err = -EINVAL;
>> +                       err = -ETIMEDOUT;
>>          }
>>
>>          if (pool->cleanup)
>> --
>> 2.34.1
>>
>>


