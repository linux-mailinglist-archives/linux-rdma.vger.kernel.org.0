Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1DA079E926
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Aug 2019 15:23:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726250AbfH0NXD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 27 Aug 2019 09:23:03 -0400
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:61361 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725920AbfH0NXC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 27 Aug 2019 09:23:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1566912182; x=1598448182;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=x4a5ZwJa2cHl+ThOsIeQwb1WhxBytJAphcw08gkiJJE=;
  b=aSnuCJYRRoj84JHWfdvqnBVtkCjROdpX2Zl/V4pw71Z37LWgDn4nfRrF
   18u4RBucmHPeZ9RVJnlohBkuIIqEzk+b1diKVDKAriXwkvvug8BBglvGv
   SSft11HEzTw5ie4fuFf4FwW3rphFSVzglicV8PF+O+T1pcIHTu26gT34n
   k=;
X-IronPort-AV: E=Sophos;i="5.64,437,1559520000"; 
   d="scan'208";a="412083075"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1a-807d4a99.us-east-1.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP; 27 Aug 2019 13:23:01 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1a-807d4a99.us-east-1.amazon.com (Postfix) with ESMTPS id 65970A263B;
        Tue, 27 Aug 2019 13:23:00 +0000 (UTC)
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 27 Aug 2019 13:22:59 +0000
Received: from 8c85908914bf.ant.amazon.com (10.43.162.125) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 27 Aug 2019 13:22:56 +0000
Subject: Re: ib_umem_get and DMA_API_DEBUG question
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     Leon Romanovsky <leon@kernel.org>, Christoph Hellwig <hch@lst.de>,
        "RDMA mailing list" <linux-rdma@vger.kernel.org>
References: <526c5b18-5853-c8dc-e112-31287a46e707@amazon.com>
 <9bae7550-35cf-b183-1e1c-fd1f8e01ef79@amazon.com>
 <20190827120011.GA7149@ziepe.ca>
 <b58d77f3-b9cb-2cab-b068-60a6bf42d8b0@amazon.com>
 <20190827131722.GB7149@ziepe.ca>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <53d882a0-8f2b-802e-b985-5a85419ccecd@amazon.com>
Date:   Tue, 27 Aug 2019 16:22:51 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190827131722.GB7149@ziepe.ca>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.162.125]
X-ClientProxiedBy: EX13D14UWB003.ant.amazon.com (10.43.161.162) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 27/08/2019 16:17, Jason Gunthorpe wrote:
> On Tue, Aug 27, 2019 at 03:53:29PM +0300, Gal Pressman wrote:
>> On 27/08/2019 15:00, Jason Gunthorpe wrote:
>>> On Tue, Aug 27, 2019 at 11:28:20AM +0300, Gal Pressman wrote:
>>>> On 26/08/2019 17:05, Gal Pressman wrote:
>>>>> Hi all,
>>>>>
>>>>> Lately I've been seeing DMA-API call traces on our automated testing runs which
>>>>> complain about overlapping mappings of the same cacheline [1].
>>>>> The problem is (most likely) caused due to multiple calls to ibv_reg_mr with the
>>>>> same address, which as a result DMA maps the same physical addresses more than 7
>>>>> (ACTIVE_CACHELINE_MAX_OVERLAP) times.
>>>>
>>>> BTW, on rare occasions I'm seeing the boundary check in check_sg_segment [1]
>>>> fail as well. I don't have a stable repro for it though.
>>>>
>>>> Is this a known issue as well? The comment there states it might be a bug in the
>>>> DMA API implementation, but I'm not sure.
>>>>
>>>> [1] https://elixir.bootlin.com/linux/v5.3-rc3/source/kernel/dma/debug.c#L1230
>>>
>>> Maybe we are missing a dma_set_seg_boundary ?
>>>
>>> PCI uses low defaults:
>>>
>>> 	dma_set_max_seg_size(&dev->dev, 65536);
>>> 	dma_set_seg_boundary(&dev->dev, 0xffffffff);
>>
>> What would you set it to?
> 
> Full 64 bits.
> 
> For umem the driver is responsible to chop up the SGL as required, not
> the core code.

But wouldn't this possibly hide driver bugs? Perhaps even in other flows?
