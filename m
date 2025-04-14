Return-Path: <linux-rdma+bounces-9408-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF96AA880E9
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Apr 2025 14:58:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C79C2177CD2
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Apr 2025 12:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2C5D290BC6;
	Mon, 14 Apr 2025 12:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="H0qaDA1U"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B317539A
	for <linux-rdma@vger.kernel.org>; Mon, 14 Apr 2025 12:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744635510; cv=none; b=Tp8NB1HSEBQqTSh3vsLBNpxeLBKJC9OoNFeLd3O38SmOmtKHYje/Llygk0eC7SKjSK/VRyPDW1iFe0hPOBY3XH+jQO9P3Ws+cbitih4aHWQVPeWrKLHTVl/aFboivRoCf29CbaNO92Z66HWJuprtpFCR+pSHv/ZdOjw1IE3ihSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744635510; c=relaxed/simple;
	bh=bTELpSp22Rcp0H/efcoNrVwwvJ+D98qfOSHNFe7pktM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eN9kdmN4GXELQ1YUviuBUBem3UH6icAwRorPhRqKI/I0mcsCN76ubvemnBVb1L2IepGT13xWbNDPTyJe0XIFE4bRURYV0Aq7ttIZkMhBncpRIBqGDK8lKxnL1fkdyIzFZi961JYWF5ir0pygHV0AV71bsX8prlcuOOORPzRv2PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=H0qaDA1U; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <bf58fb2a-2b0d-4ca7-85cc-5239a6c526d7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1744635506;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nw0b+RkWk5OPe+c/+NEntlUgc9Puhcso3yi32XOKdhE=;
	b=H0qaDA1UhdmZkSuxE+snYxUXmLJMmuUTKzbU/RRZsdMXA+eCFmtiEzWueC9E9foyeGo5qN
	eviznKow85fHqwKbTrunFVeLn58E82Wvfno76AV6bfDpCZ4tUIzu8laQijW/V4GAEoSCS+
	SOb9cMr5INsRqLFZEbdXAPMvT+i5wY8=
Date: Mon, 14 Apr 2025 14:58:22 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 1/1] RDMA/rxe: Fix slab-use-after-free Read in
 rxe_queue_cleanup bug
To: "Daisuke Matsuda (Fujitsu)" <matsuda-daisuke@fujitsu.com>,
 "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>, "jgg@ziepe.ca"
 <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Cc: liuyi <liuy22@mails.tsinghua.edu.cn>
References: <20250412075714.3257358-1-yanjun.zhu@linux.dev>
 <OS3PR01MB98651EBCADD5C93F1BF9ADFAE5B32@OS3PR01MB9865.jpnprd01.prod.outlook.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <OS3PR01MB98651EBCADD5C93F1BF9ADFAE5B32@OS3PR01MB9865.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 14.04.25 12:49, Daisuke Matsuda (Fujitsu) wrote:
> On Sat, April 12, 2025 4:57 PM Zhu Yanjun wrote:
>>
>> Call Trace:
>>   <TASK>
>>   __dump_stack lib/dump_stack.c:94 [inline]
>>   dump_stack_lvl+0x7d/0xa0 lib/dump_stack.c:120
>>   print_address_description mm/kasan/report.c:378 [inline]
>>   print_report+0xcf/0x610 mm/kasan/report.c:489
>>   kasan_report+0xb5/0xe0 mm/kasan/report.c:602
>>   rxe_queue_cleanup+0xd0/0xe0 drivers/infiniband/sw/rxe/rxe_queue.c:195
>>   rxe_cq_cleanup+0x3f/0x50 drivers/infiniband/sw/rxe/rxe_cq.c:132
>>   __rxe_cleanup+0x168/0x300 drivers/infiniband/sw/rxe/rxe_pool.c:232
>>   rxe_create_cq+0x22e/0x3a0 drivers/infiniband/sw/rxe/rxe_verbs.c:1109
>>   create_cq+0x658/0xb90 drivers/infiniband/core/uverbs_cmd.c:1052
>>   ib_uverbs_create_cq+0xc7/0x120 drivers/infiniband/core/uverbs_cmd.c:1095
>>   ib_uverbs_write+0x969/0xc90 drivers/infiniband/core/uverbs_main.c:679
>>   vfs_write fs/read_write.c:677 [inline]
>>   vfs_write+0x26a/0xcc0 fs/read_write.c:659
>>   ksys_write+0x1b8/0x200 fs/read_write.c:731
>>   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>>   do_syscall_64+0xaa/0x1b0 arch/x86/entry/common.c:83
>>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
>>
>> In the function rxe_create_cq, when rxe_cq_from_init fails, the function
>> rxe_cleanup will be called to handle the allocated resources. In fact,
>> some memory resources have already been freed in the function
>> rxe_cq_from_init. Thus, this problem will occur.
>>
>> The solution is to let rxe_cleanup do all the work.
>>
>> Fixes: 8700e3e7c485 ("Soft RoCE driver")
>> Link: https://paste.ubuntu.com/p/tJgC42wDf6/
>> Tested-by: liuyi <liuy22@mails.tsinghua.edu.cn>
>> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> 
> Reviewed-by: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
> 
> The fix looks correct.

Thanks a lot.

Zhu Yanjun

> Thank you.
> 
>> ---
>>   drivers/infiniband/sw/rxe/rxe_cq.c | 5 +----
>>   1 file changed, 1 insertion(+), 4 deletions(-)
>>
>> diff --git a/drivers/infiniband/sw/rxe/rxe_cq.c b/drivers/infiniband/sw/rxe/rxe_cq.c
>> index fec87c9030ab..fffd144d509e 100644
>> --- a/drivers/infiniband/sw/rxe/rxe_cq.c
>> +++ b/drivers/infiniband/sw/rxe/rxe_cq.c
>> @@ -56,11 +56,8 @@ int rxe_cq_from_init(struct rxe_dev *rxe, struct rxe_cq *cq, int cqe,
>>
>>   	err = do_mmap_info(rxe, uresp ? &uresp->mi : NULL, udata,
>>   			   cq->queue->buf, cq->queue->buf_size, &cq->queue->ip);
>> -	if (err) {
>> -		vfree(cq->queue->buf);
>> -		kfree(cq->queue);
>> +	if (err)
>>   		return err;
>> -	}
>>
>>   	cq->is_user = uresp;
>>
>> --
>> 2.34.1
>>


