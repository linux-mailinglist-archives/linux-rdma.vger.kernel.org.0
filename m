Return-Path: <linux-rdma+bounces-1813-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95D9789AC0D
	for <lists+linux-rdma@lfdr.de>; Sat,  6 Apr 2024 18:35:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A676282266
	for <lists+linux-rdma@lfdr.de>; Sat,  6 Apr 2024 16:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27D91107B3;
	Sat,  6 Apr 2024 16:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="J6zkw0xZ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB482940F
	for <linux-rdma@vger.kernel.org>; Sat,  6 Apr 2024 16:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712421330; cv=none; b=odwDrpZL6yOlG7v3UPR8yV2X7pKH5otoQNJD5jPDATdNXfiqJg6TwV8wEKUlbwdDkQSqWvzehshBi/pQnEHgfsTJz5jR4Vq34729ibK957krnoQxuGXbUNLxQyfwlQBpayU1HvxvdWAcziBFEd8nzWFii5L4UnhZKfOGrVrl6WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712421330; c=relaxed/simple;
	bh=wI0YZSeqzvN/qVRuAmjmcoDiN2inKK5KxxwjjW12POE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=glLflFiHxtRt202yoksKp49mhxk6EINXHX4PuHmIT2YD9QQ8KcPXgzePEGFb8vBesAzKYfsKe24fanYVU8t8t+WRHPNVAM/hFL0PJYIDI21CuNvL2FxmRAs/iP1dUt95xuEtNqyQr1FHc4kAtxI8AgLCCuOuVJt46gs9wv5pxQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=J6zkw0xZ; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <ed9e2b80-0e0f-4628-9a57-e061acf9f4d5@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1712421326;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g0bHDh8UFsXTxAzHNb9g2dmNrJtw4PGGcQUT8VOBgUI=;
	b=J6zkw0xZX5QDIOECrVUW+GdrCNjwBzj4wvFOktCIVNMI2wANWoUuPBMZHToMVP20OTJHC3
	NxYzJNsxIDytRzlBJgSADQXw62TlE2wQEIpqGIUmN6iCnVK6GONebjT/L/PQt6XtIKptcQ
	KN89DtLYfeoDE+UXKyBOzT71VDvTzgY=
Date: Sat, 6 Apr 2024 18:35:21 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 1/1] RDMA/rxe: Make pr_fmt work
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: zyjzyj2000@gmail.com, leon@kernel.org, linux-rdma@vger.kernel.org
References: <20240323083139.5484-1-yanjun.zhu@linux.dev>
 <20240327130804.GH8419@ziepe.ca>
 <a9011ab4-6947-4ad4-8d1f-653e129c38b9@linux.dev>
 <20240404145913.GF1363414@ziepe.ca>
 <7a2a41c2-c8ef-402d-933a-2b2d8a956207@linux.dev>
 <be9584b6-85fc-46bb-87b8-18ca6103a5a4@linux.dev>
 <20240404235931.GA5792@ziepe.ca>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20240404235931.GA5792@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2024/4/5 1:59, Jason Gunthorpe 写道:
> On Thu, Apr 04, 2024 at 08:03:35PM +0200, Zhu Yanjun wrote:
>>>>> Because this driver will finally call printk function to output the logs,
>>>>> the header file include/linux/printk.h needs be included.
>>>>>
>>>>> In include/linux/printk.h, pr_fmt is defined.
>>>> This doesn't make sense, printk.h has:
>>>>
>>>> #ifndef pr_fmt
>>>> #define pr_fmt(fmt) fmt
>>>> #endif
>>>>
>>>> Before or after printk.h should not have an impact.
>>
>>
>> Sorry. The previous mail is not sent successfully. I resend it.
>>
>>> #ifndef pr_fmt
>>>
>>> ...
>>>
>>> #endif
>>>
>>> The above will not undefine pr_fmt.
>>>
>>> #undef pr_fmt will undefine pr_fmt.
>>>
>>> This link explains the above in details.
>>>
>> https://www.techonthenet.com/c_language/directives/ifndef.php
> 
> Why would you want to undefine it? The point is to #define it to the
> rxe specific value. If it is already set to the rxe specific value
> before including printk.h then it will work fine?

Got your point. There are about more 130 header files that define pr_fmt 
in the kernel include directory. And these header files are included one 
another. Is there any tool to clarify the including relationship between 
these header files?

Thanks a lot
Zhu Yanjun
> 
> Jason


