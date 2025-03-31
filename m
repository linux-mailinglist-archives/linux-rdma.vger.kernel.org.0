Return-Path: <linux-rdma+bounces-9039-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D107FA76C88
	for <lists+linux-rdma@lfdr.de>; Mon, 31 Mar 2025 19:27:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F4523A65C1
	for <lists+linux-rdma@lfdr.de>; Mon, 31 Mar 2025 17:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AEEF21517C;
	Mon, 31 Mar 2025 17:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cKM3VAQR"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50211C173C
	for <linux-rdma@vger.kernel.org>; Mon, 31 Mar 2025 17:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743442071; cv=none; b=PVfqFbL6gwpB8YkCBMWqC5p5fOZzbiNJRX11kAYC7ZTllu2Fokp3BNRhBE87jyIiNaddHwhRlkvEhRbS0hC4sAwPz9ww0UV75LlzxePRVyNS5vKberp7FtNH50/TDgazui8tswkfTTm0JDer/EPb2AVF4Uhwlk58+UDLgd198+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743442071; c=relaxed/simple;
	bh=RHbuDqf2P6GrjmbkdAzliTTXeXWtlD8dXqsymEYwdu4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KzVU/l2S7fn50nSi5Ggh00r7pR49KFwoce/NeYP2y/AnTTvijrL6xBbvRQx4SZozMT4Jm8S8WHtH9uUuMfMrKBSNWjYe3o0NAcnS+TxymTjaVuDsny4/Wrz7CViyDeU5QlefBHL+Pi5kH2IArt2lOjKtH3AzkS76chpXqyntkNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cKM3VAQR; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <b75c5329-0049-4c9c-ba79-a1132d848d5d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1743442066;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kruHksm1UUrwgJcBmXQdaCtoFTJLiAQJ5TstMyZdLT4=;
	b=cKM3VAQRMbRUBvKmepdeEBvKKrgCy/aUrmWomdFtLQYbrteR3LStobDIBjyp0Bf616W2DD
	GazjbLQ5wO4qzhk7O9yg33pE6Bdq1WL0P+96eB0TX6hi++7CMqbxBqSM9Lo1iSQOK6eLjz
	z4IcHW8TKxH7M/eu4P3RguPEEjaAA/g=
Date: Mon, 31 Mar 2025 19:27:40 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v5 2/2] page_pool: Track DMA-mapped pages and
 unmap them when destroying the pool
To: Alexander Lobakin <aleksander.lobakin@intel.com>,
 =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>,
 Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Tariq Toukan <tariqt@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Horman <horms@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Mina Almasry <almasrymina@google.com>, Yonglong Liu
 <liuyonglong@huawei.com>, Yunsheng Lin <linyunsheng@huawei.com>,
 Pavel Begunkov <asml.silence@gmail.com>, Matthew Wilcox
 <willy@infradead.org>, netdev@vger.kernel.org, bpf@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-mm@kvack.org, Qiuling Ren
 <qren@redhat.com>, Yuying Ma <yuma@redhat.com>
References: <20250328-page-pool-track-dma-v5-0-55002af683ad@redhat.com>
 <20250328-page-pool-track-dma-v5-2-55002af683ad@redhat.com>
 <aaf31c50-9b57-40b7-bbd7-e19171370563@intel.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <aaf31c50-9b57-40b7-bbd7-e19171370563@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2025/3/31 18:35, Alexander Lobakin 写道:
> From: Toke Høiland-Jørgensen <toke@redhat.com>
> Date: Fri, 28 Mar 2025 13:19:09 +0100
> 
>> When enabling DMA mapping in page_pool, pages are kept DMA mapped until
>> they are released from the pool, to avoid the overhead of re-mapping the
>> pages every time they are used. This causes resource leaks and/or
>> crashes when there are pages still outstanding while the device is torn
>> down, because page_pool will attempt an unmap through a non-existent DMA
>> device on the subsequent page return.
> 
> [...]
> 
>> @@ -173,10 +212,10 @@ struct page_pool {
>>   	int cpuid;
>>   	u32 pages_state_hold_cnt;
>>   
>> -	bool has_init_callback:1;	/* slow::init_callback is set */
>> +	bool dma_sync;			/* Perform DMA sync for device */
> 
> Have you seen my comment under v3 (sorry but I missed that there was v4
> already)? Can't we just test the bit atomically?

Perhaps test_bit series functions can test the bit atomically. Maybe 
there are more good options about this testing the bit atomically. But 
test_bit should implement the task that tests the bit atomically.

Zhu Yanjun

> 
>>   	bool dma_map:1;			/* Perform DMA mapping */
>> -	bool dma_sync:1;		/* Perform DMA sync for device */
>>   	bool dma_sync_for_cpu:1;	/* Perform DMA sync for cpu */
>> +	bool has_init_callback:1;	/* slow::init_callback is set */
> 
> Thanks,
> Olek


