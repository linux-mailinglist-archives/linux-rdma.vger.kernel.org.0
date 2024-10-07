Return-Path: <linux-rdma+bounces-5276-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8429A99341B
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Oct 2024 18:57:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C5201F23766
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Oct 2024 16:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD9B61DCB11;
	Mon,  7 Oct 2024 16:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="QWcN4/Ji"
X-Original-To: linux-rdma@vger.kernel.org
Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C4341DC754;
	Mon,  7 Oct 2024 16:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728319931; cv=none; b=Ca3It7bmDnj6bCyGnzFb5PT2cvxoTxdjMSwRFw6+r0rjWtDkbCDpo6W+o3GpLgY2R79XtWGd9Z/2PMj8SY7sCl2szZLi3W7WbB9M7993gUr+a0hu3T1wKqNpPTfeUYuk5yrjFc2+Hjo2ur4lmtoZDiWlu3YLJdWmYg0CWZFy/qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728319931; c=relaxed/simple;
	bh=5mIvnNdoNo+0MukNeeulavqaUHxmXAH85h08owe7Ofs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sjB4HQ06e1QLLLofwT9l9q9tHf+I1rLD7IycmwAEEtv9dVnlWKZD14mXbSC0x3u+0sTAvQVlQcoGv0ncGQu1XV95VUpR/IwF3IBUudmHRg8Z8f09l9SzTOJ64e3MQ7XK9YZARRCzbO8XCk6BtOWVUlRcLIC5aNO4rlAF9dp7RL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=QWcN4/Ji; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4XMlYj28mczlgTWP;
	Mon,  7 Oct 2024 16:52:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1728319926; x=1730911927; bh=aHenSmXXW0jZUfid8Lv2w31M
	s17YLCNe6E+/ywOcxqk=; b=QWcN4/JiKH4pJAB8ym4+BA/MY6D91Gi00rZ3k/Si
	mJSSOC+29sfV/L7aSAaCweWR/5iEvpoBqoeqLRvUkn/PriZMqo+UW6R3WER+H7u8
	UxrCbufXWVnqqfqyDHnLlo7I77pQzxf6HXBtnaugkcYLROEEFfoQbqJzIsOITkZI
	SdcGofqHlc34ljzD/gkhkwVoj9ZKVnBNjYX1wRQI4psb3vu8WPYZNdzFTo0EBvlJ
	PM5WAFU1ZLauaK6LEuc3gzgEnFGSIEReqYY8k/1J6alRcGrI4H4Qn/AIzZZ344tP
	PkugJJXJLnEQpZTH/Bb74ZmJI78ElyQ6qiTyG05+xBLC4g==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id jihWyptPqzXa; Mon,  7 Oct 2024 16:52:06 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4XMlYd6FWfzlgTWM;
	Mon,  7 Oct 2024 16:52:05 +0000 (UTC)
Message-ID: <04daaf4c-9c62-404e-8c5e-1fffb3f2ecbd@acm.org>
Date: Mon, 7 Oct 2024 09:52:05 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] RDMA/srpt: Make slab cache names unique
To: Jens Axboe <axboe@kernel.dk>, Zhu Yanjun <yanjun.zhu@linux.dev>,
 Jason Gunthorpe <jgg@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>
Cc: linux-rdma@vger.kernel.org,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <20241004173730.1932859-1-bvanassche@acm.org>
 <3108a1da-3eb3-4b9d-8063-eab25c7c2f29@linux.dev>
 <e9778971-9041-4383-8633-c3c8b137e92e@kernel.dk>
 <09ffcd22-8853-4bb3-8471-ef620303174b@acm.org>
 <09aa620c-b44b-41d2-a207-d2cc477fdad2@kernel.dk>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <09aa620c-b44b-41d2-a207-d2cc477fdad2@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/7/24 9:28 AM, Jens Axboe wrote:
> On 10/7/24 10:14 AM, Bart Van Assche wrote:
>> On 10/7/24 7:06 AM, Jens Axboe wrote:
>>> Still seems way over engineered, just use an atomic_long_t for a
>>> continually increasing index number.
>>
>> Even an atomic_long_t can wrap around and hence can result in duplicate
>> slab cache names. With my patch it is guaranteed that slab cache names
>> are unique. I'm not claiming that this patch is the best possible
>> solution but it's a working solution and a solution that doesn't require
>> too many changes to the ib_srpt driver.
> 
> Come on... The current patch doesn't even check if ida_alloc() got an ID.
> Without that, using some mechanism to alloc+free an index is surely less
> than useful.

Is it necessary in this case to check the ida_alloc() result? ida_free()
ignores negative values. So if ida_alloc() fails, the worst that can
happen is that a slab name with a negative number is passed to 
kmem_cache_create(). Additionally, if my interpretation of the ida code
is correct, it allocates memory in 128 byte chunks. So if allocation of
an ida fails, it means that less than 128 bytes of memory are left. More
than 128 bytes are required by kmem_cache_create(). Hence, if ida
allocation fails, the kmem cache creation will also fail and the slab
name with the negative number will not become visible in procfs.

Do you agree that in this case it is safe not to check whether
ida_alloc() succeeds?

Thanks,

Bart.

