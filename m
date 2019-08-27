Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 510979E869
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Aug 2019 14:53:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbfH0Mxq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 27 Aug 2019 08:53:46 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:32375 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726278AbfH0Mxq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 27 Aug 2019 08:53:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1566910425; x=1598446425;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=1kXD2EhmtGrEdU0xZRKP0U78jWWZwgdOv6BI2jBAFi8=;
  b=nGuQZ9EP8yhrcKZqNL6fZnxKFLnvRF3BxqAyRzdw6/KlJGL5k10NSOMa
   rI/aLBS8t7uOT2/ps4V5nBY6U+kFmEIRDLwCp7VuU1CvO+54aIdmP85x8
   /CD+o4OCPgxErGodBzLDQYM9365C8zf4UGwUy5/1veK3ZdDQp6ETHM+AI
   Q=;
X-IronPort-AV: E=Sophos;i="5.64,437,1559520000"; 
   d="scan'208";a="697896783"
Received: from sea3-co-svc-lb6-vlan3.sea.amazon.com (HELO email-inbound-relay-1e-97fdccfd.us-east-1.amazon.com) ([10.47.22.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 27 Aug 2019 12:53:40 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1e-97fdccfd.us-east-1.amazon.com (Postfix) with ESMTPS id 9FDF1A26A9;
        Tue, 27 Aug 2019 12:53:38 +0000 (UTC)
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 27 Aug 2019 12:53:37 +0000
Received: from 8c85908914bf.ant.amazon.com (10.43.160.100) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 27 Aug 2019 12:53:34 +0000
Subject: Re: ib_umem_get and DMA_API_DEBUG question
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     Leon Romanovsky <leon@kernel.org>, Christoph Hellwig <hch@lst.de>,
        "RDMA mailing list" <linux-rdma@vger.kernel.org>
References: <526c5b18-5853-c8dc-e112-31287a46e707@amazon.com>
 <9bae7550-35cf-b183-1e1c-fd1f8e01ef79@amazon.com>
 <20190827120011.GA7149@ziepe.ca>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <b58d77f3-b9cb-2cab-b068-60a6bf42d8b0@amazon.com>
Date:   Tue, 27 Aug 2019 15:53:29 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190827120011.GA7149@ziepe.ca>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.160.100]
X-ClientProxiedBy: EX13D23UWC001.ant.amazon.com (10.43.162.196) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 27/08/2019 15:00, Jason Gunthorpe wrote:
> On Tue, Aug 27, 2019 at 11:28:20AM +0300, Gal Pressman wrote:
>> On 26/08/2019 17:05, Gal Pressman wrote:
>>> Hi all,
>>>
>>> Lately I've been seeing DMA-API call traces on our automated testing runs which
>>> complain about overlapping mappings of the same cacheline [1].
>>> The problem is (most likely) caused due to multiple calls to ibv_reg_mr with the
>>> same address, which as a result DMA maps the same physical addresses more than 7
>>> (ACTIVE_CACHELINE_MAX_OVERLAP) times.
>>
>> BTW, on rare occasions I'm seeing the boundary check in check_sg_segment [1]
>> fail as well. I don't have a stable repro for it though.
>>
>> Is this a known issue as well? The comment there states it might be a bug in the
>> DMA API implementation, but I'm not sure.
>>
>> [1] https://elixir.bootlin.com/linux/v5.3-rc3/source/kernel/dma/debug.c#L1230
> 
> Maybe we are missing a dma_set_seg_boundary ?
> 
> PCI uses low defaults:
> 
> 	dma_set_max_seg_size(&dev->dev, 65536);
> 	dma_set_seg_boundary(&dev->dev, 0xffffffff);

What would you set it to?
