Return-Path: <linux-rdma+bounces-2492-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3D578C64F1
	for <lists+linux-rdma@lfdr.de>; Wed, 15 May 2024 12:25:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 942F028441E
	for <lists+linux-rdma@lfdr.de>; Wed, 15 May 2024 10:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C698B5C61C;
	Wed, 15 May 2024 10:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NolITH8Z"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ECAE5A79B
	for <linux-rdma@vger.kernel.org>; Wed, 15 May 2024 10:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715768729; cv=none; b=RyVxF+Zl/MlL4TCGBCMlm2SiwMinkwSNmkuKSOaE03Im1yJ1xEDS4IsmPJrve180iGW74fGftM8xY0HoN4za4DZhzJ2FVGjG4CLIyzvuIpdrK8nKVSqhMwbwOzs/mLHVEig12H/yGMKBVU2S9z5czu/KMfGHB1afzLk89V4mEXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715768729; c=relaxed/simple;
	bh=61QtqgUIYCUvKNCI+i+FK7j9DN9tTUJuVCmvvB+wl0o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lf4AZKNxvdJwXocInrsspDFtaoGbtJLUMKZ7iLhA4uJXbt5+OM8px00Uq7HNY/eXi+yN232DWxUbBUZUsP2ivZIr//jKpyrC7b814xHsOxHVYykeo7II5l/2z/51ksz6RF5/w3M73Un2/gJ08KjbXvRWziuJDU7BAb1+Ps9SFlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NolITH8Z; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <ac26c8f8-a2ee-4844-8f72-dbcd61ff6def@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1715768725;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P/ZZaTU0/VgSxc2Swak4to3Vh7ELEAoB1SsmiSVOm8U=;
	b=NolITH8ZNoY3Gtu86EEP0rWNCiI7AbYH5k0yC7AQhTLzSnLHEWl4v48iff5ov9FFF6wixB
	3GAnpsPDS7V8FkhIQOmxe+9W3AhDphpPT17EPiljp0yhulfkkRe3NopZdXGAIaH8eovB+z
	tJQZNX1V8m3oLCIhVhK3qUWTJi9U8RY=
Date: Wed, 15 May 2024 12:25:22 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 0/6] rds: rdma: Add ability to force GFP_NOIO
To: Haakon Bugge <haakon.bugge@oracle.com>, Zhu Yanjun <zyjzyj2000@gmail.com>
Cc: OFED mailing list <linux-rdma@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>, netdev <netdev@vger.kernel.org>,
 "rds-devel@oss.oracle.com" <rds-devel@oss.oracle.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
 Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Tejun Heo <tj@kernel.org>,
 Lai Jiangshan <jiangshanlai@gmail.com>,
 Allison Henderson <allison.henderson@oracle.com>,
 Manjunath Patil <manjunath.b.patil@oracle.com>,
 Mark Zhang <markzhang@nvidia.com>, Chuck Lever III <chuck.lever@oracle.com>,
 Shiraz Saleem <shiraz.saleem@intel.com>, Yang Li <yang.lee@linux.alibaba.com>
References: <20240513125346.764076-1-haakon.bugge@oracle.com>
 <38a5ccc6-d0bc-41e0-99de-fe7902b1951f@linux.dev>
 <54d14e4e-63e7-4bce-866f-0e2f2c801232@gmail.com>
 <8F5C99B3-2575-482C-B931-7510CCF55B03@oracle.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <8F5C99B3-2575-482C-B931-7510CCF55B03@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2024/5/14 20:32, Haakon Bugge 写道:
> Hi Yanjun,
> 
> 
>> On 14 May 2024, at 14:02, Zhu Yanjun <zyjzyj2000@gmail.com> wrote:
>>
>>
>>
>> On 14.05.24 10:53, Zhu Yanjun wrote:
>>> On 13.05.24 14:53, Håkon Bugge wrote:
>>>> This series enables RDS and the RDMA stack to be used as a block I/O
>>>> device. This to support a filesystem on top of a raw block device
>>> This is to support a filesystem ... ?
>>
>> Sorry. my bad. I mean, normally rds is used to act as a communication protocol between Oracle databases. Now in this patch series, it seems that rds acts as a communication protocol to support a filesystem. So I am curious which filesystem that rds is supporting?
> 
> The peer here is a file-server which acts a block device. What Oracle calls a cell-server. The initiator here, is actually using XFS over an Oracle in-kernel pseudo-volume block device.

Thanks Haakon.
There is a link about GFP_NOFS and GFP_NOIO, 
https://lore.kernel.org/linux-fsdevel/ZZcgXI46AinlcBDP@casper.infradead.org/.

I am not sure if you have read this link or not. In this link, the 
writer has his ideas about GFP_NOFS and GFP_NOIO.

"
My interest in this is that I'd like to get rid of the FGP_NOFS flag. 
It'd also be good to get rid of the __GFP_FS flag since there's always 
demand for more GFP flags.  I have a git branch with some work in this 
area, so there's a certain amount of conference-driven development going 
on here too.

We could mutatis mutandi for GFP_NOIO, memalloc_noio_save/restore, 
__GFP_IO, etc, so maybe the block people are also interested.  I haven't 
looked into that in any detail though.  I guess we'll see what interest 
this topic gains.
"

Anyway, good luck!

Zhu Yanjun

> 
> 
> Thxs,  Håkon
> 


