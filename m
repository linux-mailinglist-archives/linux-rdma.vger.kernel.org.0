Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 548632B0AD6
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Nov 2020 17:59:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726163AbgKLQ7o (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 12 Nov 2020 11:59:44 -0500
Received: from nat-hk.nvidia.com ([203.18.50.4]:53996 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726133AbgKLQ7n (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 12 Nov 2020 11:59:43 -0500
Received: from HKMAIL101.nvidia.com (Not Verified[10.18.92.77]) by nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fad69fd0000>; Fri, 13 Nov 2020 00:59:41 +0800
Received: from HKMAIL104.nvidia.com (10.18.16.13) by HKMAIL101.nvidia.com
 (10.18.16.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 12 Nov
 2020 16:59:41 +0000
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.43) by
 HKMAIL104.nvidia.com (10.18.16.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 12 Nov 2020 16:59:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fo5Fylpcqg1c1ICago8gt/nwxngqcg9pwCP0bbD+BLkp2jsR6iGi+ENnqZ+nQSAcxaoFHKAT9haAD9lDmwwTERdrR0gUe3cN0TMUPjwkx2EVNTHn6lFf4SBF18LK9nYfvA0SZW7khOeFL+Kq76OY26We/yxljzw6VVCIufvHFtywQimFw3LLsC0KrgdrKmzBZILVUhzAzZFrWJN1XsFqbHOXLpWtL+gz1rbExdv0+Hh27BRMAqw+mZPzWCg0nd0OIgLytsbnnmw9KrxHarajaR+WiUzqZ6r90qZ+PofZYQlEjdyGcJt0Vsrs7dYAbyQyOh0ZRZ7kV6fBmGyZEO6xLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mjYw2sGjcuhzNrZV2pwl3CFN9OypHf5Gzys0L+0bO88=;
 b=eDtReuw/trq0HvRSUcFSdVLzMQfhELH4HxfF0SpbKRFjiDOwMjpqAuYYMJzNWS5hrPFPdgqlRsephJ0+x15W4iKhfq42XOi3Zi4AYijBC0XWQQSx2ggw0NJeyuF6cBLEKYh2gioP12RzAeKeZzeeXi9tCsXPHr/9Q0Zb4365AuVjFOV5urvOxmxubiOLdM768UGuWaVMkdKK4uxraCaxwk7LLTmIStTmsMwyTPHHjrjdgVOCb/cr3rShpfE2b2TTwvV52hT8gN6bdW+VIDe74F9w8XIBgTYqye8LERz/RyyPaMUVmGbqjcoVds43YQazWxRCLZcYeo36kjfMcM07pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4042.namprd12.prod.outlook.com (2603:10b6:5:215::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Thu, 12 Nov
 2020 16:59:37 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3499.032; Thu, 12 Nov 2020
 16:59:37 +0000
Date:   Thu, 12 Nov 2020 12:59:35 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     Bjorn Helgaas <bhelgaas@google.com>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        Zhu Yanjun <yanjunz@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Santosh Shilimkar <santosh.shilimkar@oracle.com>,
        <linux-rdma@vger.kernel.org>, <rds-devel@oss.oracle.com>,
        <linux-pci@vger.kernel.org>, <iommu@lists.linux-foundation.org>
Subject: Re: remove dma_virt_ops v2
Message-ID: <20201112165935.GA932629@nvidia.com>
References: <20201106181941.1878556-1-hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201106181941.1878556-1-hch@lst.de>
X-ClientProxiedBy: BL0PR02CA0078.namprd02.prod.outlook.com
 (2603:10b6:208:51::19) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by BL0PR02CA0078.namprd02.prod.outlook.com (2603:10b6:208:51::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.25 via Frontend Transport; Thu, 12 Nov 2020 16:59:37 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kdFwd-003ul0-PF; Thu, 12 Nov 2020 12:59:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1605200381; bh=mjYw2sGjcuhzNrZV2pwl3CFN9OypHf5Gzys0L+0bO88=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=PolRm/+9iSArJhGLhQEUp/bdPhYEjooDTEC295gKwXUHVln7M7s9RORnhZwFicZxt
         PncGptw0xN6WVnpE1Bowh2O1W1fTRSWFGW06Z097NJganQnSWr1AFPn17kJhcW1LaY
         Xi/nL3UvYblGvNqK7wgy1A+y0uWNAIHJ0wtvChZce6i0nCIkyGh0PX3x2V9aZJUunc
         +eXQFJiHo8w7cb6aPwHubTNUGraCHyOFi6eW/RljHNZgpyjL0/uAD3g3SuV+++q1a+
         xKipKL9WrtvlzqQoEnB6d1p4Wv2f/sc/c98QFCZHMGrwfWdp9sZuxjxyr3qk6rfJk8
         npTADLGoUnAtg==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Nov 06, 2020 at 07:19:31PM +0100, Christoph Hellwig wrote:
> Hi Jason,
> 
> this series switches the RDMA core to opencode the special case of
> devices bypassing the DMA mapping in the RDMA ULPs.  The virt ops
> have caused a bit of trouble due to the P2P code node working with
> them due to the fact that we'd do two dma mapping iterations for a
> single I/O, but also are a bit of layering violation and lead to
> more code than necessary.
> 
> Tested with nvme-rdma over rxe.
> 
> Note that the rds changes are untested, as I could not find any
> simple rds test setup.
> 
> Changes since v2:
>  - simplify the INFINIBAND_VIRT_DMA dependencies
>  - add a ib_uses_virt_dma helper
>  - use ib_uses_virt_dma in nvmet-rdma to disable p2p for virt_dma devices
>  - use ib_dma_max_seg_size in umem
>  - stop using dmapool in rds
> 
> Changes since v1:
>  - disable software RDMA drivers for highmem configs
>  - update the PCI commit logs

Lets give Santosh a little longer for RDS, I've grabbed the precursor
parts to for-next for now:

 nvme-rdma: Use ibdev_to_node instead of dereferencing ->dma_device
 RDMA: Lift ibdev_to_node from rds to common code
 RDMA/core: Remove ib_dma_{alloc,free}_coherent
 RDMA/umem: Use ib_dma_max_seg_size instead of dma_get_max_seg_size
 RMDA/sw: Don't allow drivers using dma_virt_ops on highmem configs

Will get the rest next week regardless.

Thanks,
Jason
