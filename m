Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0FDC2A8234
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Nov 2020 16:30:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731170AbgKEPaC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 5 Nov 2020 10:30:02 -0500
Received: from foss.arm.com ([217.140.110.172]:35576 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731129AbgKEPaC (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 5 Nov 2020 10:30:02 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2EB0514BF;
        Thu,  5 Nov 2020 07:30:01 -0800 (PST)
Received: from [10.57.54.223] (unknown [10.57.54.223])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 593BA3F718;
        Thu,  5 Nov 2020 07:29:59 -0800 (PST)
Subject: Re: [PATCH 1/6] RMDA/sw: don't allow drivers using dma_virt_ops on
 highmem configs
To:     Jason Gunthorpe <jgg@ziepe.ca>, Christoph Hellwig <hch@lst.de>
Cc:     Zhu Yanjun <yanjunz@nvidia.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        iommu@lists.linux-foundation.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        Logan Gunthorpe <logang@deltatee.com>
References: <20201105074205.1690638-1-hch@lst.de>
 <20201105074205.1690638-2-hch@lst.de> <20201105144123.GB4142106@ziepe.ca>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <74729b8d-146f-803a-98a3-e8149bd97e34@arm.com>
Date:   Thu, 5 Nov 2020 15:29:58 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201105144123.GB4142106@ziepe.ca>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2020-11-05 14:41, Jason Gunthorpe wrote:
> On Thu, Nov 05, 2020 at 08:42:00AM +0100, Christoph Hellwig wrote:
>> dma_virt_ops requires that all pages have a kernel virtual address.
>> Introduce a INFINIBAND_VIRT_DMA Kconfig symbol that depends on !HIGHMEM
>> and a large enough dma_addr_t, and make all three driver depend on the
>> new symbol.
>>
>> Signed-off-by: Christoph Hellwig <hch@lst.de>
>>   drivers/infiniband/Kconfig           | 6 ++++++
>>   drivers/infiniband/sw/rdmavt/Kconfig | 3 ++-
>>   drivers/infiniband/sw/rxe/Kconfig    | 2 +-
>>   drivers/infiniband/sw/siw/Kconfig    | 1 +
>>   4 files changed, 10 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/infiniband/Kconfig b/drivers/infiniband/Kconfig
>> index 32a51432ec4f73..81acaf5fb5be67 100644
>> +++ b/drivers/infiniband/Kconfig
>> @@ -73,6 +73,12 @@ config INFINIBAND_ADDR_TRANS_CONFIGFS
>>   	  This allows the user to config the default GID type that the CM
>>   	  uses for each device, when initiaing new connections.
>>   
>> +config INFINIBAND_VIRT_DMA
>> +	bool
>> +	default y
> 
> Oh, I haven't seen this kconfig trick with default before..

It's commonly done using the "def_bool" shorthand. I fact, I think 
simply "def_bool !HIGHMEM" would suffice for the fundamental definition 
here.

>> +	depends on !HIGHMEM
>> +	depends on !64BIT || ARCH_DMA_ADDR_T_64BIT
>> +
>>   if INFINIBAND_USER_ACCESS || !INFINIBAND_USER_ACCESS
>>   source "drivers/infiniband/hw/mthca/Kconfig"
>>   source "drivers/infiniband/hw/qib/Kconfig"
>> diff --git a/drivers/infiniband/sw/rdmavt/Kconfig b/drivers/infiniband/sw/rdmavt/Kconfig
>> index 9ef5f5ce1ff6b0..c8e268082952b0 100644
>> +++ b/drivers/infiniband/sw/rdmavt/Kconfig
>> @@ -1,7 +1,8 @@
>>   # SPDX-License-Identifier: GPL-2.0-only
>>   config INFINIBAND_RDMAVT
>>   	tristate "RDMA verbs transport library"
>> -	depends on X86_64 && ARCH_DMA_ADDR_T_64BIT
>> +	depends on INFINIBAND_VIRT_DMA
> 
> Usually I would expect a non-menu item to be used with select not
> 'depends on' - is the use of default avoiding that?

A select wouldn't make any sense here - if the user chooses to enable 
the subsystem it can't automatically pull in "the absence of highmem" 
from the arch code; there's still a literal dependency on certain 
conditions being met for the option to be available. The intermediate 
config symbol just abstracts that set of conditions.

Robin.
