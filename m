Return-Path: <linux-rdma+bounces-11515-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E793CAE2A26
	for <lists+linux-rdma@lfdr.de>; Sat, 21 Jun 2025 18:10:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8FBF176634
	for <lists+linux-rdma@lfdr.de>; Sat, 21 Jun 2025 16:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4DD821FF2C;
	Sat, 21 Jun 2025 16:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mcaVUkos"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481B220C49E
	for <linux-rdma@vger.kernel.org>; Sat, 21 Jun 2025 16:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750522211; cv=none; b=g5RS2s8B5zlK6iYROMR7nsmfAU/WnSrKNxc6NJQd8EDImOzaSZGLM9v1XxLoEbxFfx54r4xZwD+VI6FodYaRNHIsytV1cjb+qDRFoXrHS4ePJNoPnmqpqU4bDijfRak1kanfQWqwfv70qAfRGn1NRz7XJXt+40E+yOThOwBHO/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750522211; c=relaxed/simple;
	bh=SDTl3xy6j3Dqzdg8SG0MCWZcS3XIFlPcXcqe56Gq4JU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iarApAAj4pMjPWN8dVbPe4zmdhtdgQQzBsCQ7NuwxYww+Sa1Xg1oeQb7n9zl7+eHhymhKxkwt03g0C5sZc98ZOJWoqoVacS+pgydW2puGBFrfRxR2YI6wp80k0Ik8j1IXV+0OSx0lWFyMpRQQzPdyHQzZREMYjZ8LLnwZY4YpVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mcaVUkos; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <cd5670d7-b2ba-487b-94c4-bb781a9d0bf1@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1750522195;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZbR8+eD0l+HPJUYQuSGTTOhQsUZE6eRuwbpXbCLLz4Y=;
	b=mcaVUkosaNLFM1EVr+vpueBjIr/s0OJO6U4bCFy79sMrluP7ZUzGWvPWBFLMezhXruI/uH
	UxcvrKWSs5PpyU0Ha6csTluxZFKO6VNRrAv16n3UwxzDmfmwSk9bU8d/wZADVwd4mRHud0
	40uc6jW7FjlVRRI0pihXGr8t6WMjshU=
Date: Sat, 21 Jun 2025 09:09:41 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] RDMA/siw: work around clang stack size warning
To: Arnd Bergmann <arnd@arndb.de>, Arnd Bergmann <arnd@kernel.org>,
 Bernard Metzler <bmt@zurich.ibm.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Leon Romanovsky <leon@kernel.org>, Nathan Chancellor <nathan@kernel.org>
Cc: Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Potnuri Bharat Teja <bharat@chelsio.com>, Showrya M N <showrya@chelsio.com>,
 Eric Biggers <ebiggers@google.com>, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev
References: <20250620114332.4072051-1-arnd@kernel.org>
 <2d04fee6-5d95-4c50-b2b1-ee67f42932e2@linux.dev>
 <ca2eaa50-c3ed-491d-ab38-65a7c1dc2820@app.fastmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <ca2eaa50-c3ed-491d-ab38-65a7c1dc2820@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


在 2025/6/21 1:43, Arnd Bergmann 写道:
> On Sat, Jun 21, 2025, at 06:12, Zhu Yanjun wrote:
>> 在 2025/6/20 4:43, Arnd Bergmann 写道:
>>
>> Because the array of kvec structures in siw_tx_hdt consumes the majority
>> of the stack space, would it be possible to use kmalloc or a similar
>> dynamic memory allocation function instead of allocating this memory on
>> the stack?
>>
>> Would using kmalloc (or an equivalent) also effectively resolve the
>> stack usage issue?
> Yes, moving the allocation somewhere else (kmalloc, static variable,
> per siw_sge, per siw_wqe) would avoid the high stack usage effectively,
> it's a tradeoff and I picked the solution that made the most sense
> to me, but there is a good chance another alternative is better here.
>
> The main differences are:
>
> - kmalloc() adds runtime overhead that may be expensive in a
>    fast path
>
> - kmalloc() can fail, which adds complexity from error handling.
>    Note that small allocations with GFP_KERNEL do not fail but instead
>    wait for memory to become available
>
> - If kmalloc() runs into a low-memory situation, it can go through
>    writeback, which in turn can use more stack space than the
>    on-stack allocation it was replacing
>
> - static allocations bloat the kernel image and require locking that
>    may be expensive
>
> - per-object preallocations can be wasteful if a lot of objects
>    are created, and can still require locking if the object is used
>    from multiple threads
>
> As I wrote, I mainly picked the 'noinline_for_stack' approach
> here since that is how the code is known to work with gcc, so
> there is little risk of my patch causing problems.
>
> Moving the both the kvec array and the page array into
> the siw_wqe is likely better here, I'm not familiar enough
> with the driver to tell whether that is an overall improvement.Th
Thank you very much. There are several possible solutions to this issue, 
and the appropriate one depends on the specific scenario. For the 
problem in siw, the noinline_for_stack approach has been selected. In my 
opinion, this appears to be more of a workaround than a true fix. While 
it does mitigate the issue, the underlying problem in siw still remains.

That said, now that we have a clearer understanding of the problem and 
its root cause through discussions and extended analysis, a more robust 
and long-term solution should eventually be proposed.

Thanks,

Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>

Zhu Yanjun

>
> A related change I would like to see is to remove the
> kmap_local_page() in this driver and instead make it
> depend on 64BIT or !CONFIG_HIGHMEM, to slowly chip away
> at the code that is highmem aware throughout the kernel.
> I'm not sure if that that would also help drop the array
> here.
>
>       Arnd

-- 
Best Regards,
Yanjun.Zhu


