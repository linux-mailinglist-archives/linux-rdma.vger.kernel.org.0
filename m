Return-Path: <linux-rdma+bounces-5079-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8DE19850D4
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Sep 2024 04:04:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9837F2852AB
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Sep 2024 02:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A5F614831D;
	Wed, 25 Sep 2024 02:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CPBfgyjY"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16EA4126F0A
	for <linux-rdma@vger.kernel.org>; Wed, 25 Sep 2024 02:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727229892; cv=none; b=MO4xnNqlnogf0b3YN4oJ+6uWkCfFf2BzzpSDnGxSrGzKdB60KrUQOt03hqW5ZSUxuG+svgghcxQfud0bdWkmWWoUINZV0POqtAFUjH8OdMxaklBXVkDfmNyBJfvbQ3//KDpqlXDG6deXjV28BqWa8AA2GMoJYQUlmga9sGhFuH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727229892; c=relaxed/simple;
	bh=OyJbYtQuzpkGp8l3UUy4EU1UEqjMBaXysPhoEQJv3Q8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mktnJgmITk2EPl+zRE3RnnlsQLybwSuIiqEngMPoL9TJkCCDOuCOQ1Jisjw2cbF558D5PcFAi7wGvv8+0uX8rXXqbHZE/FX4YJr9/NuoPqGAGpHuxYQsOph4ndCZHWyD4EwuweXoYpXEUNe9I4oy7xr4WZO6LsEG45E4QKnkccQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CPBfgyjY; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <5b86861b-60f7-4c90-bc0e-d863b422850f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1727229889;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xvrOmFpqgHeJjVfW0WRu/b1Bim7C3zrcjnNBL44ieqM=;
	b=CPBfgyjYf4724Xojqchvv9GpTuWN/znBUdzcJbZAZZg4iKu30zV02itpLE5hfWqOPUBj+s
	akunaWblvi06iRGsOIRVWs7wp+EzyKNUc2k5ViUGA+stuF7TYq5SBARwB9Cb6WYgQcv29e
	l2FJ2MMnRE9M0+G800m469JSzISMqCU=
Date: Wed, 25 Sep 2024 10:04:21 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [MAINLINE 0/2] Enable DIM for legacy ULPs and use it in RDS
To: Haakon Bugge <haakon.bugge@oracle.com>
Cc: Christoph Hellwig <hch@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 Leon Romanovsky <leon@kernel.org>,
 Allison Henderson <allison.henderson@oracle.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 OFED mailing list <linux-rdma@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "rds-devel@oss.oracle.com" <rds-devel@oss.oracle.com>
References: <20240918083552.77531-1-haakon.bugge@oracle.com>
 <Zuwyf0N_6E6Alx-H@infradead.org>
 <C00EA178-ED20-4D56-B6F2-200AC72F3A39@oracle.com>
 <Zu191hsvJmvBlJ4J@infradead.org>
 <525e9a31-31ee-4acf-a25c-8bf3a617283f@linux.dev>
 <ZvFY_4mCGq2upmFl@infradead.org>
 <aea6b986-2d25-4ebc-93e8-05da9c6f3ba2@linux.dev>
 <ZvJiKGtuX62jkIwY@infradead.org>
 <1ad540cb-bf1b-456b-be2d-6c35999bdaa8@linux.dev>
 <66A7418F-4989-4765-AC0F-1D23342C6950@oracle.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <66A7418F-4989-4765-AC0F-1D23342C6950@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2024/9/24 23:16, Haakon Bugge 写道:
> 
> 
>> On 24 Sep 2024, at 15:59, Zhu Yanjun <yanjun.zhu@linux.dev> wrote:
>>
>> 在 2024/9/24 14:54, Christoph Hellwig 写道:
>>> On Tue, Sep 24, 2024 at 09:58:24AM +0800, Zhu Yanjun wrote:
>>>> The users that I mentioned is not in the kernel tree.
>>> And why do you think that would matter the slightest?
>>
>> I noticed that the same cq functions are used. And I also made tests with this patch series. Without this patch series, dim mechanism will not be invoked.
> 
> Christoph alluded to say: Do not modify the old cq_create_cq() code in order to support DIM, it is better to change the ULP to use ib_alloc_cq(), and get DIM enabled that way.

Hi, Haakon

To be honest, I like your original commit that enable DIM for legacy 
ULPs because this can fix this problem once for all and improve the old 
ib_create_cq function.

The idea from Christoph will cause a lot of changes in ULPs. I am not 
very sure if these changes cause risks or not.

Thus, I prefer to your original commit. But I will follow the advice 
from Leon and Jason.

Zhu Yanjun

> 
> 
> Thxs, Håkon
> 


