Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 288092A8456
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Nov 2020 18:00:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731060AbgKERAK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 5 Nov 2020 12:00:10 -0500
Received: from verein.lst.de ([213.95.11.211]:47871 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726996AbgKERAK (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 5 Nov 2020 12:00:10 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 0E0A568B02; Thu,  5 Nov 2020 18:00:05 +0100 (CET)
Date:   Thu, 5 Nov 2020 18:00:04 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        Zhu Yanjun <yanjunz@nvidia.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        iommu@lists.linux-foundation.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [PATCH 1/6] RMDA/sw: don't allow drivers using dma_virt_ops on
 highmem configs
Message-ID: <20201105170004.GA7502@lst.de>
References: <20201105074205.1690638-1-hch@lst.de> <20201105074205.1690638-2-hch@lst.de> <40d0a990-0fca-6f12-16ff-3612a9847ab3@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40d0a990-0fca-6f12-16ff-3612a9847ab3@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Nov 05, 2020 at 12:15:46PM +0000, Robin Murphy wrote:
> On 2020-11-05 07:42, Christoph Hellwig wrote:
>> dma_virt_ops requires that all pages have a kernel virtual address.
>> Introduce a INFINIBAND_VIRT_DMA Kconfig symbol that depends on !HIGHMEM
>> and a large enough dma_addr_t, and make all three driver depend on the
>> new symbol.
>>
>> Signed-off-by: Christoph Hellwig <hch@lst.de>
>> ---
>>   drivers/infiniband/Kconfig           | 6 ++++++
>>   drivers/infiniband/sw/rdmavt/Kconfig | 3 ++-
>>   drivers/infiniband/sw/rxe/Kconfig    | 2 +-
>>   drivers/infiniband/sw/siw/Kconfig    | 1 +
>>   4 files changed, 10 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/infiniband/Kconfig b/drivers/infiniband/Kconfig
>> index 32a51432ec4f73..81acaf5fb5be67 100644
>> --- a/drivers/infiniband/Kconfig
>> +++ b/drivers/infiniband/Kconfig
>> @@ -73,6 +73,12 @@ config INFINIBAND_ADDR_TRANS_CONFIGFS
>>   	  This allows the user to config the default GID type that the CM
>>   	  uses for each device, when initiaing new connections.
>>   +config INFINIBAND_VIRT_DMA
>> +	bool
>> +	default y
>> +	depends on !HIGHMEM
>> +	depends on !64BIT || ARCH_DMA_ADDR_T_64BIT
>
> Isn't that effectively always true now since 4965a68780c5? I had a quick 
> try of manually overriding CONFIG_ARCH_DMA_ADDR_T_64BIT in my .config, and 
> the build just forces it back to "=y".

True.  The guy who did the commit should have really told me about it :)
