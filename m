Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC62B9EA24
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Aug 2019 15:53:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726522AbfH0Nx2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 27 Aug 2019 09:53:28 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:34656 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726170AbfH0Nx1 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 27 Aug 2019 09:53:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1566914007; x=1598450007;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=f6LSsBrNKEvq0MVACuy5gLnxkxjASDxTZ9lIVZYJPVM=;
  b=Ji0fMHx8B/ewxc/qVdqO4Viu4P3X2XYjQv7wBx+pQ4KEQfW/jYMfw/pp
   MxQdNQ9mYY0k9eOekmRnqz4DbPoGc3UE9eVbkBv7PZy5v1e0TumuAL9zZ
   g5RupcyftJsiKRZSF8iJsv1pEr7MEy+f2LsWBf6fcBvbmhDLFcXxwsny8
   E=;
X-IronPort-AV: E=Sophos;i="5.64,437,1559520000"; 
   d="scan'208";a="697915132"
Received: from sea3-co-svc-lb6-vlan3.sea.amazon.com (HELO email-inbound-relay-2a-22cc717f.us-west-2.amazon.com) ([10.47.22.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 27 Aug 2019 13:53:10 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2a-22cc717f.us-west-2.amazon.com (Postfix) with ESMTPS id 74F02A22BD;
        Tue, 27 Aug 2019 13:53:09 +0000 (UTC)
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 27 Aug 2019 13:53:08 +0000
Received: from 8c85908914bf.ant.amazon.com (10.43.162.191) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 27 Aug 2019 13:53:06 +0000
Subject: Re: ib_umem_get and DMA_API_DEBUG question
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     Leon Romanovsky <leon@kernel.org>, Christoph Hellwig <hch@lst.de>,
        "RDMA mailing list" <linux-rdma@vger.kernel.org>
References: <526c5b18-5853-c8dc-e112-31287a46e707@amazon.com>
 <9bae7550-35cf-b183-1e1c-fd1f8e01ef79@amazon.com>
 <20190827120011.GA7149@ziepe.ca>
 <b58d77f3-b9cb-2cab-b068-60a6bf42d8b0@amazon.com>
 <20190827131722.GB7149@ziepe.ca>
 <53d882a0-8f2b-802e-b985-5a85419ccecd@amazon.com>
 <20190827133719.GC7149@ziepe.ca>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <c8c058a9-f9ac-0228-646c-0ae1739652a2@amazon.com>
Date:   Tue, 27 Aug 2019 16:53:01 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190827133719.GC7149@ziepe.ca>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.162.191]
X-ClientProxiedBy: EX13P01UWA003.ant.amazon.com (10.43.160.197) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 27/08/2019 16:37, Jason Gunthorpe wrote:
> On Tue, Aug 27, 2019 at 04:22:51PM +0300, Gal Pressman wrote:
>> On 27/08/2019 16:17, Jason Gunthorpe wrote:
>>> On Tue, Aug 27, 2019 at 03:53:29PM +0300, Gal Pressman wrote:
>>>> On 27/08/2019 15:00, Jason Gunthorpe wrote:
>>>>> On Tue, Aug 27, 2019 at 11:28:20AM +0300, Gal Pressman wrote:
>>>>>> On 26/08/2019 17:05, Gal Pressman wrote:
>>>>>>> Hi all,
>>>>>>>
>>>>>>> Lately I've been seeing DMA-API call traces on our automated testing runs which
>>>>>>> complain about overlapping mappings of the same cacheline [1].
>>>>>>> The problem is (most likely) caused due to multiple calls to ibv_reg_mr with the
>>>>>>> same address, which as a result DMA maps the same physical addresses more than 7
>>>>>>> (ACTIVE_CACHELINE_MAX_OVERLAP) times.
>>>>>>
>>>>>> BTW, on rare occasions I'm seeing the boundary check in check_sg_segment [1]
>>>>>> fail as well. I don't have a stable repro for it though.
>>>>>>
>>>>>> Is this a known issue as well? The comment there states it might be a bug in the
>>>>>> DMA API implementation, but I'm not sure.
>>>>>>
>>>>>> [1] https://elixir.bootlin.com/linux/v5.3-rc3/source/kernel/dma/debug.c#L1230
>>>>>
>>>>> Maybe we are missing a dma_set_seg_boundary ?
>>>>>
>>>>> PCI uses low defaults:
>>>>>
>>>>> 	dma_set_max_seg_size(&dev->dev, 65536);
>>>>> 	dma_set_seg_boundary(&dev->dev, 0xffffffff);
>>>>
>>>> What would you set it to?
>>>
>>> Full 64 bits.
>>>
>>> For umem the driver is responsible to chop up the SGL as required, not
>>> the core code.
>>
>> But wouldn't this possibly hide driver bugs? Perhaps even in other flows?
> 
> The block stack also uses this information, I've been meaning to check
> if we should use dma_attrs in umem so we can have different
> parameters.
> 
> I'm not aware of any issue with the 32 bit boundary on RDMA devices..

So something like this?

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index 99c4a55545cf..2aa0e48f8dac 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -1199,8 +1199,9 @@ static void setup_dma_device(struct ib_device *device)
 		WARN_ON_ONCE(!parent);
 		device->dma_device = parent;
 	}
-	/* Setup default max segment size for all IB devices */
+	/* Setup default DMA properties for all IB devices */
 	dma_set_max_seg_size(device->dma_device, SZ_2G);
+	dma_set_seg_boundary(device->dma_device, U64_MAX);
 
 }
 
