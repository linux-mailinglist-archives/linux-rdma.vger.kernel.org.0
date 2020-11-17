Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF7652B6793
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Nov 2020 15:34:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731664AbgKQOci (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 17 Nov 2020 09:32:38 -0500
Received: from bosmailout06.eigbox.net ([66.96.187.6]:40391 "EHLO
        bosmailout06.eigbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731357AbgKQOch (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 17 Nov 2020 09:32:37 -0500
X-Greylist: delayed 1814 seconds by postgrey-1.27 at vger.kernel.org; Tue, 17 Nov 2020 09:32:36 EST
Received: from bosmailscan05.eigbox.net ([10.20.15.5])
        by bosmailout06.eigbox.net with esmtp (Exim)
        id 1kf1Yp-000197-UZ; Tue, 17 Nov 2020 09:02:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=cornelisnetworks.com; s=dkim; h=Sender:Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:References:Cc:To:
        Subject:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=OQ/j0tk/3/6taMHML6/LZ+8wC6OlN+24PAxPKRw0GKQ=; b=ovmOuOEw81+FTaKijMmKPkDwFI
        L3zmnOhkLMctmZ1Q6LA7RAliMKRgfBgoAsNQFvmbkQFMScNSBcGmpMWyOm5XQgV65HTPK0eCQfONo
        /P+AYXYPMRSxc4SMh/cOzp6b6GGHlEcdrU24kh4HrOO9/EMqBZ24ayvL7Y+Q3BBk/eUmMzigfzkP8
        FYS0l4C8YrQ1zsF//erM5Cg/IeOgD31UsmuULDUYXVJkeVuUZab0zSohhojch9Di3OLzEOWBy73m8
        LbvbatIZ5ku4BiRjOg1uQQgDwgUAwI+7/zTOrjv7DPCIeoB8eUZsPj9gdrdXQJVJsfjBhaOMsw/DX
        Wl3fTnKg==;
Received: from [10.115.3.32] (helo=bosimpout12)
        by bosmailscan05.eigbox.net with esmtp (Exim)
        id 1kf1Yp-00041S-Jb; Tue, 17 Nov 2020 09:02:19 -0500
Received: from bosauthsmtp13.yourhostingaccount.com ([10.20.18.13])
        by bosimpout12 with 
        id tS2F2300B0GvDVm01S2JKD; Tue, 17 Nov 2020 09:02:19 -0500
X-Authority-Analysis: v=2.3 cv=WuawzeXv c=1 sm=1 tr=0
 a=UH8/iCWBfdUmbm4Ft4Vi3Q==:117 a=t5jG6c9IKFG8al4zq+RKCw==:17
 a=IkcTkHD0fZMA:10 a=nNwsprhYR40A:10 a=sI1n-BzLCC4A:10 a=VwQbUJbxAAAA:8
 a=LRYjQimtAAAA:8 a=gm1xG5NVYmixJIDKLiEA:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22 a=JC7xiqAVgOyvJ6DxgMma:22
Received: from fmdmzpr03-ext.fm.intel.com ([192.55.54.38]:53205)
        by bosauthsmtp13.eigbox.net with esmtpa (Exim)
        id 1kf1Yl-0008WK-DA; Tue, 17 Nov 2020 09:02:15 -0500
From:   Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
Subject: Re: remove dma_virt_ops v2
To:     Christoph Hellwig <hch@lst.de>, Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        Zhu Yanjun <yanjunz@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Santosh Shilimkar <santosh.shilimkar@oracle.com>,
        linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com,
        linux-pci@vger.kernel.org, iommu@lists.linux-foundation.org
References: <20201106181941.1878556-1-hch@lst.de>
 <20201112165935.GA932629@nvidia.com> <20201112170956.GA18813@lst.de>
 <20201112173906.GT244516@ziepe.ca> <20201113085023.GA17412@lst.de>
Message-ID: <b6834645-d62b-f88b-9fc6-d1207ae33549@cornelisnetworks.com>
Date:   Tue, 17 Nov 2020 09:01:56 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <20201113085023.GA17412@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EN-UserInfo: 0c01d0184442a6165e428d14bd4242e2:931c98230c6409dcc37fa7e93b490c27
X-EN-AuthUser: mike.marciniszyn@cornelisnetworks.com
Sender:  Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
X-EN-OrigIP: 192.55.54.38
X-EN-OrigHost: fmdmzpr03-ext.fm.intel.com
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

>> Fixes: 551199aca1c3 ("lib/dma-virt: Add dma_virt_ops")
> 
> Note that the drivers had open coded versions of this earlier.  I think
> this goes back to the addition of the qib driver which is now gone
> or the addition of the hfi1 or rxe drivers for something that still
> matters

Christoph,Jason

I built a branch using the following recipe:
https://patchwork.kernel.org/project/linux-rdma/patch/:
20201106181941.1878556-11-hch@lst.de/ dma-mapping: remove dma_virt_ops 
20201106181941.1878556-10-hch@lst.de/ PCI/P2PDMA: Cleanup 
__pci_p2pdma_map_sg a bit
20201106181941.1878556-9-hch@lst.de/  PCI/P2PDMA: Remove the 
DMA_VIRT_OPS hacks
20201106181941.1878556-8-hch@lst.de/  RDMA/core: remove use of dma_virt_ops
20201106181941.1878556-7-hch@lst.de/  RDMA/core: remove 
ib_dma_{alloc,free}_coherent
20201106181941.1878556-6-hch@lst.de/  rds: stop using dmapool
20201106181941.1878556-5-hch@lst.de/  nvme-rdma: use ibdev_to_node 
instead of dereferencing ->dma_device
20201106181941.1878556-4-hch@lst.de/  RDMA: lift ibdev_to_node from rds 
to common code
20201106181941.1878556-3-hch@lst.de/  RDMA/umem: use ib_dma_max_seg_size 
instead of dma_get_max_seg_size
rdma/for-rc dabbd6abcdbe which has RMDA/sw: don't allow drivers using 
dma_virt_ops on highmem configs

All of our rdmavt/hfi1 tests passed.

So I can at least vouch for "RDMA/core: remove use of dma_virt_ops"

Mike
Tested-by: Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>


