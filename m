Return-Path: <linux-rdma+bounces-1197-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2F1086F88E
	for <lists+linux-rdma@lfdr.de>; Mon,  4 Mar 2024 03:28:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 012601C20B28
	for <lists+linux-rdma@lfdr.de>; Mon,  4 Mar 2024 02:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD9A81864;
	Mon,  4 Mar 2024 02:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GFbyjr7F"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C6715B7
	for <linux-rdma@vger.kernel.org>; Mon,  4 Mar 2024 02:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709519287; cv=none; b=SR6PnjY9bm8WDJALVbA0B5HXO1uMOxOLCdYB7cXIC4Yf0FAxZ3u7Scv8o+AivxItSStXZBJ+6KSO7/XuAvQDiIr5d10R3tX4qnOOGAxCOOcD8GaQWa0lkS/JNie6ddATV3k8xGmWsfNAA2VUyIZ2E+RuNfaHI/1GYK45bdWnXuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709519287; c=relaxed/simple;
	bh=Lxi/GwcyHffRZyDkM6ZiyzHoAvkPz9PAdQ08ZI1MKn4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eX1xV0fjsH0w7k2u8Q3g6GeZ48IjanEy8IhbY+l8l5T65Bgs9dvZbhQ3OE86v0tm4XyLWqrBBLnPQu50KgYslvXnVrPORUGkYiqBg4jMG4v8aX7x+z82LHvYxbQIuJOsFbfuHvPbRQOUAHoKv3pzQT+lmBw6e0hLmtXFFCsKf5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GFbyjr7F; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <22df55f8-cf64-4aa8-8c0b-b556c867b926@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1709519282;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AwmaRBK9f4xeTr2KKIZaEkYuoxsnConkJ3QY8WkxaG4=;
	b=GFbyjr7FhhwloIRGYJbvYR2kjPjcVdcWEeIEFJysy6dwcV7/jHlDBt/GAmHusvPsiaRlNZ
	UB7rrqP99IQeHRy17j5j5Kx45ucggNjfStR4c5A4+uGW1Gcy07R2jku2TzogQkWFWGB+PJ
	j/QAT+SkCeRTAFVbxsPeNebm/D8kfjk=
Date: Mon, 4 Mar 2024 03:27:52 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [LSF/MM/BPF TOPIC] [LSF/MM/BPF ATTEND] : Two stage IOMMU DMA
 mapping operations
To: Zhu Yanjun <zyjzyj2000@gmail.com>, Leon Romanovsky <leon@kernel.org>,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 linux-rdma <linux-rdma@vger.kernel.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>, Jens Axboe <axboe@kernel.dk>,
 Bart Van Assche <bvanassche@acm.org>, "kbusch@kernel.org"
 <kbusch@kernel.org>, Damien Le Moal <damien.lemoal@opensource.wdc.com>,
 Amir Goldstein <amir73il@gmail.com>,
 "josef@toxicpanda.com" <josef@toxicpanda.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 "daniel@iogearbox.net" <daniel@iogearbox.net>, Christoph Hellwig
 <hch@lst.de>, Dan Williams <dan.j.williams@intel.com>,
 "jack@suse.com" <jack@suse.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Chuck Lever <chuck.lever@oracle.com>
References: <97f385db-42c9-4c04-8fba-9b1ba8ffc525@nvidia.com>
 <20240227113007.GD1842804@unreal>
 <be75fe5b-9901-425c-8dbb-771dcb084e2e@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <be75fe5b-9901-425c-8dbb-771dcb084e2e@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2024/3/3 17:43, Zhu Yanjun 写道:
> On 27.02.24 12:30, Leon Romanovsky wrote:
>> On Tue, Feb 27, 2024 at 08:17:27AM +0000, Chaitanya Kulkarni wrote:
>>> Hi,
>>
>> <...>
>>
>>> In order to create a good platform for a concrete and meaningful
>>> discussion at LSFMM 24, we plan to post an RFC within the next two 
>>> weeks.
>>
>> The code can be found here 
>> https://git.kernel.org/pub/scm/linux/kernel/git/leon/linux-rdma.git/log/?h=dma-split
> 
> Thanks a lot. I will delve into it. An interesting topic.

The commits should be the followings. I am interested in them.

5d8f8f35859c (HEAD -> dma-split, origin/dma-split) cover-letter: Split 
IOMMU DMA mapping operation to two steps
3beffcde0c12 vfio/mlx5: Convert vfio to use DMA link API
acdfef1ccbcb vfio/mlx5: Explicitly store page list
f16314362e66 vfio/mlx5: Rewrite create mkey flow to allow better code reuse
763e753cd6ed vfio/mlx5: Explicitly use number of pages instead of 
allocated length
7f58ebf0cfc4 RDMA/umem: Prevent UMEM ODP creation with SWIOTLB
f1c687fde096 RDMA/core: Separate DMA mapping to caching IOVA and page 
linkage
ffc81619c60d RDMA/umem: Store ODP access mask information in PFN
67038d9e24fd RDMA/umem: Preallocate and cache IOVA for UMEM ODP
ce141bccd409 iommu/dma: Implement link/unlink page callbacks
1dd12d4a44d1 iommu/dma: Prepare map/unmap page functions to receive IOVA
b9714667f54f iommu/dma: Provide an interface to allow preallocate IOVA
21dbfc7fc2f1 dma-mapping: provide callbacks to link/unlink pages to 
specific IOVA
52689a26b87a dma-mapping: provide an interface to allocate IOVA
34f8a8baecaa mm/hmm: let users to tag specific PFNs

Zhu Yanjun

> 
> Zhu Yanjun
> 
>>
>> Thanks
>>
>>>
>>> Required Attendees list :-
>>>
>>> Christoph Hellwig
>>> Jason Gunthorpe
>>> Jens Axboe
>>> Chuck Lever
>>> David Howells
>>> Keith Busch
>>> Bart Van Assche
>>> Damien Le Moal
>>> Martin Petersen
>>>
>>> -ck
>>>
>>> [1]
>>> https://lore.kernel.org/all/169772852492.5232.17148564580779995849.stgit@klimt.1015granger.net
>>> [2] https://lore.kernel.org/linux-iommu/20200708065014.GA5694@lst.de/
>>>
>>>
>>>
> 


