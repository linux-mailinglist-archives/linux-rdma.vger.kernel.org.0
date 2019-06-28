Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9733859C85
	for <lists+linux-rdma@lfdr.de>; Fri, 28 Jun 2019 15:05:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbfF1NFP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 28 Jun 2019 09:05:15 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:29374 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726731AbfF1NFP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 28 Jun 2019 09:05:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1561727114; x=1593263114;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=UMxexAAg70SurrGzVAPcB3UYyKjybAck6ocbUMvpiz0=;
  b=P/flZIeHLlqa/v2NzL+83sU73CAquK//hBvUVpswoeDljeQjQUEh9AJ2
   Q7+RX9UemF39leuQRrsW0wQ5f+BwVCASDq0GbumS6UvO0aFvAo/uoAWrB
   qwJxK7gG6lxG+8Lb7V+YDjWhFu6GTILq4N4YhkGCR4lUhp1lMzK/QhXzH
   4=;
X-IronPort-AV: E=Sophos;i="5.62,427,1554768000"; 
   d="scan'208";a="808311096"
Received: from sea3-co-svc-lb6-vlan3.sea.amazon.com (HELO email-inbound-relay-1a-7d76a15f.us-east-1.amazon.com) ([10.47.22.38])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 28 Jun 2019 13:05:12 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1a-7d76a15f.us-east-1.amazon.com (Postfix) with ESMTPS id 5CBF5A2190;
        Fri, 28 Jun 2019 13:05:09 +0000 (UTC)
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Fri, 28 Jun 2019 13:05:09 +0000
Received: from 8c85908914bf.ant.amazon.com (10.43.162.109) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Fri, 28 Jun 2019 13:05:03 +0000
Subject: Re: [RFC rdma 1/3] RDMA/core: Create a common mmap function
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     Michal Kalderon <michal.kalderon@marvell.com>,
        <dledford@redhat.com>, <leon@kernel.org>, <sleybo@amazon.com>,
        <ariel.elior@marvell.com>, <linux-rdma@vger.kernel.org>
References: <20190627135825.4924-1-michal.kalderon@marvell.com>
 <20190627135825.4924-2-michal.kalderon@marvell.com>
 <d6e9bc3b-215b-c6ea-11d2-01ae8f956bfa@amazon.com>
 <20190627155219.GA9568@ziepe.ca>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <14e60be7-ae3a-8e86-c377-3bf126a215f0@amazon.com>
Date:   Fri, 28 Jun 2019 16:04:57 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190627155219.GA9568@ziepe.ca>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.162.109]
X-ClientProxiedBy: EX13D25UWB002.ant.amazon.com (10.43.161.44) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 27/06/2019 18:52, Jason Gunthorpe wrote:
> On Thu, Jun 27, 2019 at 06:25:37PM +0300, Gal Pressman wrote:
>> On 27/06/2019 16:58, Michal Kalderon wrote:
>>> Create a common API for adding entries to a xa_mmap.
>>> This API can be used by drivers that don't require special
>>> mapping for user mapped memory.
>>>
>>> The code was copied from the efa driver almost as is, just renamed
>>> function to be generic and not efa specific.
>>
>> I don't think we should force the mmap flags to be the same for all drivers..
>> Take a look at mlx5 for example:
>>
>> enum mlx5_ib_mmap_cmd {
>> 	MLX5_IB_MMAP_REGULAR_PAGE               = 0,
>> 	MLX5_IB_MMAP_GET_CONTIGUOUS_PAGES       = 1,
>> 	MLX5_IB_MMAP_WC_PAGE                    = 2,
>> 	MLX5_IB_MMAP_NC_PAGE                    = 3,
>> 	/* 5 is chosen in order to be compatible with old versions of libmlx5 */
>> 	MLX5_IB_MMAP_CORE_CLOCK                 = 5,
>> 	MLX5_IB_MMAP_ALLOC_WC                   = 6,
>> 	MLX5_IB_MMAP_CLOCK_INFO                 = 7,
>> 	MLX5_IB_MMAP_DEVICE_MEM                 = 8,
>> };
>>
>> The flags taken from EFA aren't necessarily going to work for other drivers.
>> Maybe the flags bits should be opaque to ib_core and leave the actual mmap
>> callbacks in the drivers. Not sure how dealloc_ucontext is going to work with
>> opaque flags though?
> 
> Yes, the driver will have to take care of masking the flags before
> lookup
> 
> We should probably store the struct page * in the
> rdma_user_mmap_entry() and use that to key struct page behavior.
I don't follow why we need the struct page? How will this work for MMIO?

> 
> Do you think we should go further and provide a generic mmap() that
> does the right thing? It would not be hard to provide a callback that
> computes the pgprot flags 

I think a generic mmap with a driver callback to do the actual
rdma_user_mmap_io/vm_insert_page/... according to the flags is a good approach.

If the flags are opaque to ib_core we'll need another callback to tell the
driver when the entries are being freed. This way, if the entry is a DMA page
for example (stated by the flags), the driver can free these buffers.
