Return-Path: <linux-rdma+bounces-15239-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 341E5CE8B12
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Dec 2025 05:57:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 70BB53012271
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Dec 2025 04:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90DAF2DC34B;
	Tue, 30 Dec 2025 04:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DSmgozT2"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6445A17C211
	for <linux-rdma@vger.kernel.org>; Tue, 30 Dec 2025 04:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767070665; cv=none; b=YulZjFdxEfEQjp2it4dUxmGHzDYKvIc0kjJEk2ZzTNM+3fD4ldNE72ppPOhmr/ntc7AXPcqsGmmXpllRxVv7bGTcpN7hFQCxYa/rtvXE4Px8qKXrBzcG8yxCFk/d0kaOJs9sfUB74dyhjkChp9S28MZat0LRNCSoKC1B5yt1bFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767070665; c=relaxed/simple;
	bh=UHejUxIOiJNPkZ+X+F7Ky0bil2pn0G+jGvR/jLb/Qfo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K7WPqFNQ46Pw6IPXN9Dh6nWhcOuboiK8qTQBbUQxEawOIfSsb78WNZQlezEgMIX1AdMIOG/o/Fz9/fiP7UwTDdcaG9YAIG+A4qg4lg1KzrF5Rd9ua3nm6NT6rm8VXtjBTnBU1pTX2yBkBkJ97Ov44Zq4u34NWD1TYB2p4woPd+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DSmgozT2; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <feefff5b-c4e1-4e4b-a24d-9829f781e132@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767070661;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8jR1RShAKd4fFahFwXSy+UdXIP8qrTv+iczu8RBnVKc=;
	b=DSmgozT23LwG/jeg/23OMS8VPPID2/BkkvxWvExRB31fnuhBnX9emMTwRegsedwmrNYf5/
	rvP2knRLa+QZkA3Cl78c1fSX+1rMbNfuBysWub39fQ27mzCoSHOZwbi3AsXaDHUuzdJtws
	tcB2jDsKIbnkfDmyaIyTomsP6FxwA90=
Date: Mon, 29 Dec 2025 20:57:19 -0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH RFC] rxe: Fix iova-to-va conversion for MR page sizes !=
 PAGE_SIZE
To: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>, "jgg@ziepe.ca"
 <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>,
 Yi Zhang <yi.zhang@redhat.com>
References: <20251226095237.3047496-1-lizhijian@fujitsu.com>
 <0afef9d8-dbe9-4df0-bdf0-0c4be15e7d04@linux.dev>
 <5727c511-7fd2-4119-b7d9-3b33b578e767@linux.dev>
 <68c333fb-7026-4412-9bcd-be877b95b99f@fujitsu.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <68c333fb-7026-4412-9bcd-be877b95b99f@fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


在 2025/12/29 20:47, Zhijian Li (Fujitsu) 写道:
> Hi Yanjun,
>
>
> On 30/12/2025 12:02, Zhu Yanjun wrote:
>>> Hi, Yi
>>>
>>> The mentioned testcase, the link is:
>>> https://lore.kernel.org/all/CAHj4cs9XRqE25jyVw9rj9YugffLn5+f=1znaBEnu1usLOciD+g@mail.gmail.com/T/
>>>
>>> Can you help to make tests to verify whether this problem is fixed or not?
>>>
>> On x86_64 hosts, after this commit is applied, all the testcases in rdma-core can pass. But in Fedora Core 42 with ARM64 architecture,
>>
>> there are some errors with rdma-core.
>
> Many thanks for your testing.
>
> This commit should only affect IB_MR_TYPE_MEM_REG MRs, which are exposed to the
> Upper Layer Protocol (ULP) in the current kernel.
>
> Since rdma-core typically utilizes IB_MR_TYPE_USER(mr.page_size always same with PAGE_SIZE), it should not be impacted.

Got it. No worry. If this commit can pass Yi's tests, I will make tests 
again.

Let us wait for Yi's test results.

Thanks a lot for your efforts.

Zhu Yanjun

>
> Thanks
> Zhijian
>
>> I did not make tests with blktest.

-- 
Best Regards,
Yanjun.Zhu


