Return-Path: <linux-rdma+bounces-2951-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1346D8FF0D3
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Jun 2024 17:38:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10CDC1C23E77
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Jun 2024 15:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6390B19750F;
	Thu,  6 Jun 2024 15:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EcrJbFlf"
X-Original-To: linux-rdma@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37A41974EC;
	Thu,  6 Jun 2024 15:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717688280; cv=none; b=tHQHXGrHey7Vk8hevq0dEFxHyCJuiFF1MCimcDwieshm3DjZvdJlZRV2oEa+9vfKzrkKv2r/OpE08IKK1tHNKVSsXgnZvzELQvSPwCZ7fSkCeSQ0q+eQvQbtejZuqgIIU3rRM1GHi+FOhDOFZt5B1Gg3F1EXbm3NVj8f7TjAIcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717688280; c=relaxed/simple;
	bh=OO6oYJAW8pC8roD5DJjWf7tOAyCBn4io7jsoyroiUeU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DjfMX3fBMAaykgQRKJBKjfTXW9RQQJrFSoWbqWvoRiUqq1Fm4e48yoXE91m+y2N4VGMX9nujKaE6uPCHJkmEKXyl0Eqvqo73kh94YA2jDYqkEBn8eE951fAXb0+Ft8II9BJvAqaH8i7Qn4dkgcMAiJPt03CyjJZmMf1S7oRQXFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=EcrJbFlf; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=irDz+4gcio50Pp5r1x+2BPTF9AxJeW0Y2klp54euioc=; b=EcrJbFlfSdYFnCMT6xo0FK5/LT
	43hnX1GHLeXHHe4yte581ygfmy7e/JIniI0mxEnGAUuCTMfqPcdtd45bR2wqTuN7LO0w7rBlNhO3I
	mYcQCQO9agXrpT0s/8D0kznCGL7xm86nMtCmaUq7QLOwQZxaCD9u0eMZEVOrKUU5udxRmD7+5sdhF
	2VFJWlP4Y2WAFUPYIxVMryvcM4mhIel6cDEKw6eOyvKyOgNK5FInhi3zx3SD7/il7CLehKp8jqp6P
	bPn8+nE1XyyOOUahITpNCTase9sR5Y0T6XUeMXFfsYk/66DJ8Mad6SJnGqq07YZZgDZRBUZXdSIgu
	y9ZTdHWQ==;
Received: from [50.53.4.147] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sFFBW-0000000AKdn-41tL;
	Thu, 06 Jun 2024 15:37:51 +0000
Message-ID: <39bea11b-d28b-408d-ad8d-df8fe942fe4d@infradead.org>
Date: Thu, 6 Jun 2024 08:37:49 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/8] fwctl: Basic ioctl dispatch for the character device
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
 Jason Gunthorpe <jgg@nvidia.com>
Cc: Leon Romanovsky <leon@kernel.org>, Zhu Yanjun <zyjzyj2000@gmail.com>,
 Jonathan Corbet <corbet@lwn.net>, Itay Avraham <itayavr@nvidia.com>,
 Jakub Kicinski <kuba@kernel.org>, linux-doc@vger.kernel.org,
 linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>, Saeed Mahameed <saeedm@nvidia.com>,
 Tariq Toukan <tariqt@nvidia.com>,
 Andy Gospodarek <andrew.gospodarek@broadcom.com>,
 Aron Silverton <aron.silverton@oracle.com>,
 Dan Williams <dan.j.williams@intel.com>, David Ahern <dsahern@kernel.org>,
 Christoph Hellwig <hch@infradead.org>, Jiri Pirko <jiri@nvidia.com>,
 Leonid Bloch <lbloch@nvidia.com>, linux-cxl@vger.kernel.org,
 patches@lists.linux.dev, Peter Zijlstra <peterz@infradead.org>,
 Julia Lawall <julia.lawall@inria.fr>
References: <2-v1-9912f1a11620+2a-fwctl_jgg@nvidia.com>
 <6cfe00ce-1860-4aba-bcb8-54f8d365d2dc@linux.dev>
 <20240604122221.GR3884@unreal> <20240604175023.000004e2@Huawei.com>
 <20240604165844.GM19897@nvidia.com> <20240605120737.00007472@Huawei.com>
 <20240605182726.GX19897@nvidia.com> <20240606143424.00001fbd@Huawei.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240606143424.00001fbd@Huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/6/24 6:34 AM, Jonathan Cameron wrote:
> On Wed, 5 Jun 2024 15:27:26 -0300
> Jason Gunthorpe <jgg@nvidia.com> wrote:
> 
>> On Wed, Jun 05, 2024 at 12:07:37PM +0100, Jonathan Cameron wrote:
>>
>>>> I don't recall that dramatic conclusion in the discussion, but it does
>>>> make alot of sense to me.  
>>>
>>> I'll be less lazy (and today found the search foo to track it down).
>>>
>>> https://lore.kernel.org/all/CAHk-=wicfvWPuRVDG5R1mZSxD8Xg=-0nLOiHay2T_UJ0yDX42g@mail.gmail.com/  
>>
>> Oh that is a bit different discussion than I was thinking of.. I fixed
>> all the cases to follow this advise and checked that all the free
>> functions are proper pairs of whatever is being allocated.
> 
> Yes. I think we are approaching the point where maybe we need
> a 'best practice guide' somewhere. It is sort of coding style, but
> it is perhaps rather complex perhaps to put in that doc.
> 
> I'm happy to help review such changes, but it would be too far down
> my todo list if I took on writing one.
> 
> Maybe there is one I've missed?


There is not a published one that I know of, other than one that I pasted into
an email in Dec-2023, in this post:

https://lore.kernel.org/lkml/34e27c57-fc18-4918-bf44-4f8a53825361@infradead.org/


-- 
#Randy
https://people.kernel.org/tglx/notes-about-netiquette
https://subspace.kernel.org/etiquette.html

