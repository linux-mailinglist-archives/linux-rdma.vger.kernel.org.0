Return-Path: <linux-rdma+bounces-8918-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DB61A6DEF2
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Mar 2025 16:45:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41A38188B7E1
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Mar 2025 15:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BF69347C7;
	Mon, 24 Mar 2025 15:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UaQaK3in"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB8D10F1
	for <linux-rdma@vger.kernel.org>; Mon, 24 Mar 2025 15:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742831119; cv=none; b=CxyXSBSC9tf+7ThF6YAHYBvLbTMmIBpICUoQORbMeU5nX1EaEqI+k7syOiE7H15pU3ZC1BrEFtX4E272a6fh+RPd6GxDBgGrRKDEC526TfEMHBpjVllXQFfuR/8t5dejQt8o2DGMdlWBRKWRv4k/v8G2DsnRkVimw16WMjYWk3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742831119; c=relaxed/simple;
	bh=N3Q3JWBcPQtCsD0t51YmqnUkHqfCO4udJSBrX3dPd8s=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=aPa6HUdGzvf9mVr59vHJW2uSLIW/SMGB+wnwdistFdrH/5pH5AddwS3BuDheciDZJ+ECT+Z8pkrWuI86lIgyhqyXVAicS/r4adZocUcpaypVe99PTve2UXC8JwbOCQenQi+YjlRfD4yhJDhi5gQ5rPfViktMX9jMF5HYYNYMBJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UaQaK3in; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <70301d87-7e5d-46db-8762-858d5025a61e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1742831114;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kkI/vi0CWlSeQvD/dHZLyMxK18wEy+qHzMmKwKKmYeM=;
	b=UaQaK3incsnR2KPB8vjaRHAMAuu7brmj4VG/1m2MLqUAUpnic0F+moVsdbInZ8EwckSco4
	2YtXdL/wORLxfsjgRJjsNjT5beH0oqLFjQD3YAoiNd68RMFeMc/HLc43jNUng3Tm7OwA8g
	m0hsIHRoYJcUIhlBDsrZi/auKoJVEC8=
Date: Mon, 24 Mar 2025 16:45:02 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [VulnerabilityReport ] Use-After-Free in RDMA Subsystem
 (rxe_queue_cleanup) - CVE Request
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
To: Greg KH <gregkh@linuxfoundation.org>,
 "liuy22@mails.tsinghua.edu.cn" <liuy22@mails.tsinghua.edu.cn>
Cc: security <security@kernel.org>, Zhu Yanjun <zyjzyj2000@gmail.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
 RDMA mailing list <linux-rdma@vger.kernel.org>
References: <202503231510286807771@mails.tsinghua.edu.cn>
 <2025032355-penniless-ferocious-d459@gregkh>
 <bc73437b-a9e7-42db-8709-32f61c241111@linux.dev>
In-Reply-To: <bc73437b-a9e7-42db-8709-32f61c241111@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Sorry. Add linux rdma maillist.

Zhu Yanjun

在 2025/3/24 16:38, Zhu Yanjun 写道:
>
> 在 2025/3/23 23:25, Greg KH 写道:
>> RDMA maintainers on the To: list here, I've bounced the original to them
>> as well.
>>
>> More comments below:
>>
>> On Sun, Mar 23, 2025 at 03:10:28PM +0800, 
>> liuy22@mails.tsinghua.edu.cn wrote:
>>> Dear Linux Kernel Security Team,
>>>
>>> I am reporting a security vulnerability in the Linux kernel's RDMA 
>>> subsystem involving a use-after-free condition. Below are the 
>>> technical details and proposed fix.
>>>
>>> Vulnerability Details
>>> Component: RDMA subsystem (drivers/infiniband/sw/rxe/rxe_queue.c)
>>> Function: rxe_queue_cleanup() (line 195)
>>> Issue: KASAN: slab-use-after-free Read in rxe_queue_cleanup
>>> Kernel Version: 6.13.6 (observed in a QEMU VM with Debian 11 x86_64)
>>> Impact: May allow local attackers to escalate privileges or cause 
>>> denial-of-service (DoS) via uncontrolled memory corruption.
>>> PoC: Generated by Syzkaller. Full report and trigger: 
>>> https://paste.ubuntu.com/p/tJgC42wDf6/
>>>
>>> I have attempted to anaylse the root cause, and I find that the 
>>> rxe_queue_cleanup() function accesses cq->queue after it has been 
>>> freed. This occurs when error handling in rxe_cq.c frees cq->queue 
>>> but does not set the pointer to NULL, leading to a dangling reference.
>>>
>>> Attached below is a patch for drivers/infiniband/sw/rxe/rxe_cq.c to 
>>> nullify the pointer after freeing:
>
> Hi, Liuy22
>
> If I get you correctly, in the function rxe_create_cq, 
> rxe_cq_from_init fails because the function do_mmap_info
>
> 1062 static int rxe_create_cq(struct ib_cq *ibcq, const struct 
> ib_cq_init_attr *attr,
> 1063              struct uverbs_attr_bundle *attrs)
> 1064 {
>
> ...
>
> 1098
> 1099     err = rxe_cq_from_init(rxe, cq, attr->cqe, attr->comp_vector, 
> udata,   <----This function failed because do_mmap_info failed.
> 1100                    uresp);
> 1101     if (err) {
> 1102         rxe_dbg_cq(cq, "create cq failed, err = %d\n", err);
> 1103         goto err_cleanup;
> 1104     }
> ...
>
> 1108 err_cleanup:
> 1109     cleanup_err = rxe_cleanup(cq);
> 1110     if (cleanup_err)
> 1111         rxe_err_cq(cq, "cleanup failed, err = %d\n", cleanup_err);
>
> Then rxe_cleanup is called to clean up cq.
>
> Is it correct? Can you share the call trace with us? So we can delve 
> into this problem, discuss this problem, find out the root cause, then 
> fix it.
>
> Thanks a lot.
>
> Zhu Yanjun
>
>>>
>>> diff -u a/drivers/infiniband/sw/rxe/rxe_cq.c 
>>> b/drivers/infiniband/sw/rxe/rxe_cq.c
>>> --- a/drivers/infiniband/sw/rxe/rxe_cq.c 2025-03-23 
>>> 10:02:17.436250465 +0800
>>> +++ b/drivers/infiniband/sw/rxe/rxe_cq.c 2025-03-23 
>>> 10:02:12.656152582 +0800
>>> @@ -59,6 +59,7 @@
>>>    if (err) {
>>>    vfree(cq->queue->buf);
>>>    kfree(cq->queue);
>>> + cq->queue = NULL;
>>>    return err;
>>>    }
>> Can you submit this as a proper patch for inclusion in the tree, so that
>> you get proper credit for fixing the issue as well as finding it?
>>
>>> After applying the patch, the PoC no longer triggers the 
>>> use-after-free.
>>>
>>> I kindly hope that this report is acknowledged as soon as possible, 
>>> and a CVE ID is assigned for tracking. I also look forward to advice 
>>> on further steps (e.g., embargo coordination).
>> This is not how CVE ids are handled, please read our documentation for
>> how that happens (hint, not here.)
>>
>> thanks,
>>
>> greg k-h
>
-- 
Best Regards,
Yanjun.Zhu


