Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A67A22A8550
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Nov 2020 18:53:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725998AbgKERxA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 5 Nov 2020 12:53:00 -0500
Received: from nat-hk.nvidia.com ([203.18.50.4]:10093 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725862AbgKERw7 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 5 Nov 2020 12:52:59 -0500
Received: from HKMAIL102.nvidia.com (Not Verified[10.18.92.77]) by nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fa43bf90001>; Fri, 06 Nov 2020 01:52:57 +0800
Received: from HKMAIL103.nvidia.com (10.18.16.12) by HKMAIL102.nvidia.com
 (10.18.16.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 5 Nov
 2020 17:52:57 +0000
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by HKMAIL103.nvidia.com (10.18.16.12) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 5 Nov 2020 17:52:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kT6jWBd5lj42nWmxy6QIYmlD1VXymbKlx0r+otRMaeC/HLb/idbh/OtlbZ4BWQ8CRLx+wxe9ZU0tFgLk/Rgq83Txl3znPgmDvAMgjAddxQd3ZYmf4VUaqCRHoEJ73MZbFFeRrmMYZHN0U5Of99AmH4DXX1YenFFHnOpATCHY+H88UsSaWeQx/ecaTXZWw+OMvxQvASKX8ZnQAE6Ewr2UA6BlB3dEz0YDpEMtoEQW0dFhfaQrAorUMhdt4IoeLNrRSd/FzOxoSwOWnNsJTkBadCXNBOQnYyKCr5dGKquv+HkPDBeMOWnv7lr2B7UN3ut1pP4nU7gDUMLKhxpRWyOTHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=esruBjUIV9csi9Z2DV68UuDn0TgwbmhRo4AlIrUG3aM=;
 b=gH8GdHh2gL6Ang8bkN1DmlH+DQ05Y2RS451aERYxtsWLZ8pxTyjh/3gT7V1zTZxaaVCWRfGPka1MdYj7frK5fE+4cUQ46r7tf78KBEo1u0eMo9HgfyceqIJXibwMSPDCuVt+VHryzo9zOqt3V6UnceQ/yjeBDC95i1nbmaQ8K4bEcg/sj3dKeyjwvRldlKCCoFoMu+1JUCf3ZWkysfo6/QE2tESqI8FEImx9dnY4y9wQSg29kqM2UNsr9y+JTEjRCGGcEjOrXNsBrgU9/BO9hPhVeoUiRyp2RMffYhhfxh7LA1idxCDe9La0jl3XkUd5I36sjK8RuT+IBovwl2CTjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3308.namprd12.prod.outlook.com (2603:10b6:5:182::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.24; Thu, 5 Nov
 2020 17:52:55 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3499.032; Thu, 5 Nov 2020
 17:52:55 +0000
Date:   Thu, 5 Nov 2020 13:52:53 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     Bjorn Helgaas <bhelgaas@google.com>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        Zhu Yanjun <yanjunz@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        <linux-rdma@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <iommu@lists.linux-foundation.org>
Subject: Re: [PATCH 3/6] RDMA/core: remove use of dma_virt_ops
Message-ID: <20201105175253.GA35235@nvidia.com>
References: <20201105074205.1690638-1-hch@lst.de>
 <20201105074205.1690638-4-hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201105074205.1690638-4-hch@lst.de>
X-ClientProxiedBy: BL1PR13CA0158.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::13) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by BL1PR13CA0158.namprd13.prod.outlook.com (2603:10b6:208:2bd::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.13 via Frontend Transport; Thu, 5 Nov 2020 17:52:54 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kajRN-0009F7-BJ; Thu, 05 Nov 2020 13:52:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1604598777; bh=esruBjUIV9csi9Z2DV68UuDn0TgwbmhRo4AlIrUG3aM=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=Ah4kJARpCj0xBw/Ygap1PJau2gU9YIZ8Y3K+7V5srjsdPYs+Q4B3ud0uUky73Sm12
         ZSZBAVEyNYqZ12rk6EMJKrcgJQgLzM+YwJdhPJtfgFyebmqfy/rSZmSIgncUyEu1fU
         8V+gMcjtsyeiXtC/apDLQ5BgII6ODsB04lhDjWVfI0ufBDaKFfLyp6dCQZO9uzn7zL
         0Y6hzmQ+NN53i4KnMgi6C00+HKR39UMJpnOTO6AGGo8kyWz06aHHEYtNwTJYliouDB
         b3PiGkW0kNv4offwLexQQ2ETxoiZXeVZVFV8iJl8bvgh0PAcgpS84aC5T4YCw4bpw7
         5FdAC60p0+wSg==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Nov 05, 2020 at 08:42:02AM +0100, Christoph Hellwig wrote:
> @@ -1341,7 +1322,14 @@ int ib_register_device(struct ib_device *device, const char *name,
>  	if (ret)
>  		return ret;
>  
> -	setup_dma_device(device, dma_device);
> +	/*
> +	 * If the caller does not provide a DMA capable device then the IB core
> +	 * will set up ib_sge and scatterlist structures that stash the kernel
> +	 * virtual address into the address field.
> +	 */
> +	device->dma_device = dma_device;
> +	WARN_ON(dma_device && !dma_device->dma_parms);

I noticed there were a couple of places expecting dma_device to be set
to !NULL:

drivers/infiniband/core/umem.c:                 dma_get_max_seg_size(device->dma_device), sg, npages,
drivers/nvme/host/rdma.c:       ctrl->ctrl.numa_node = dev_to_node(ctrl->device->dev->dma_device);
net/rds/ib.c:                                              device->dma_device,

No sure what to do about RDS..

Jason
