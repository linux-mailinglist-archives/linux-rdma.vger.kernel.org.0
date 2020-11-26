Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADF4F2C5CC0
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Nov 2020 20:58:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731633AbgKZT5p (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 26 Nov 2020 14:57:45 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:10688 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728118AbgKZT5p (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 26 Nov 2020 14:57:45 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fc008b70000>; Thu, 26 Nov 2020 11:57:43 -0800
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 26 Nov
 2020 19:57:44 +0000
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.49) by
 HQMAIL101.nvidia.com (172.20.187.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 26 Nov 2020 19:57:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KlI1u6gWub0lXABPqvrBMcBbl64NAy9F8curv0YHstMJAZ8Pg2Cg7nGqDqDZsp6rn35qrgxqNJQ3DnzpanQSTddgZS49WwQvYk7UPSKYMRtyDbpXxEDjQMFntRa4pHFUUZs1E5ZDtMDB+15H8lXtfKh0hxFkkZHCj0vYfjfbp+LnFJ1tDKyluqK+0LrfgQ6SVtkbf+7qp8Etz6TWwP2NSW6fUr3erTDMiFV0Z2GNnKITZfqnDR1cSbbtwsu5CtyxgFtkp5W1qdtVLZ0XWmcLIIoRjl9UU/imxcNTMhT5gou14Zla1oTG4K66+90u+sAorr8uXNOSxp3s2HnotS3KlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TT7++akeujK6Jqq/sDBJCbz2uMtVHMyisvuYF8OKVQU=;
 b=V+ZiM2wNxnOx+OCUtR+pzVz+4b5uYdW9hWAd4x/dIIXZCbJgVupARxP1lotH66h2QTZrAcNrh387r3l4IOlY7/VeqlBP6VjWf8q46FbKi2JRPxgv50JjimwVBbpQQCgsavbJEao3qbhCpew7dj2hB6f2ed5rQDSSc/GpToMBpIqmBj8kPELJN7PbdQAflFvOUc5vi/Wn958UBOxQqB6kXNPSN/WyO+nBNiVVoGJ7f+wh+QwpIsnA4yPqHQRUBeUnsQlGm9jZ3Yg2F7x5LVqkJERpE8TU35Ig+bav+PDWxD2TqpWCxivDUlnuPJ6D7+SiAKjnLpe3q2aDvgwcy1sVyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4266.namprd12.prod.outlook.com (2603:10b6:5:21a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.20; Thu, 26 Nov
 2020 19:57:43 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1ce9:3434:90fe:3433]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1ce9:3434:90fe:3433%3]) with mapi id 15.20.3611.024; Thu, 26 Nov 2020
 19:57:43 +0000
Date:   Thu, 26 Nov 2020 15:57:41 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Parav Pandit <parav@nvidia.com>, <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-next v1] IB/mlx5: Use PCI device for dma mappings
Message-ID: <20201126195741.GC557094@nvidia.com>
References: <20201125064628.8431-1-leon@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201125064628.8431-1-leon@kernel.org>
X-ClientProxiedBy: BL0PR0102CA0054.prod.exchangelabs.com
 (2603:10b6:208:25::31) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by BL0PR0102CA0054.prod.exchangelabs.com (2603:10b6:208:25::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.24 via Frontend Transport; Thu, 26 Nov 2020 19:57:43 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kiNOf-002Kwu-Sv; Thu, 26 Nov 2020 15:57:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1606420663; bh=TT7++akeujK6Jqq/sDBJCbz2uMtVHMyisvuYF8OKVQU=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=KVAfbHTkawVvPnreMUp/cc2z30fxRKP8xWYr8kVlmyub9zcifJP2yk47xgU+0li1z
         a+Apxrb33ffD7YWOEowl9MDEyE86oiAwRhTzq7LWyZx+3rjvEx/Q+AhI3d7KKmEsYA
         y+KTlLv7o7ri+wENMj29p7iudaxwue1PnWInWTOn9VeNnG1sNFj6YPE2M9R2ygI7G/
         lnWMtPRtpEUDlUnzge5OE33aT7FZr+K6vGpSVfnPNevErcbYu7NK7LnFK7s4iUbmkr
         CJN79fbC/SSLPBevF84n67Gq7E7Ox26bcOCQ6CNnCximUDNdENITr8eqsF+fE0oYUX
         iIEJmnarDtI8g==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Nov 25, 2020 at 08:46:28AM +0200, Leon Romanovsky wrote:
> From: Parav Pandit <parav@nvidia.com>
> 
> DMA operation of the IB device is done using ib_device->dma_device.
> 
> Instead of accessing parent of the IB device, use the PCI dma device
> which is setup to ib_device->dma_device during IB device registration.
> 
> Signed-off-by: Parav Pandit <parav@nvidia.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
> Chagenlog:
> v1:
>  * Use PCI device directly instead of ib_dma API
>  * Limited checkpatch to 80 symbols.
> v0: https://lore.kernel.org/linux-rdma/20201123082400.351371-1-leon@kernel.org
> ---
>  drivers/infiniband/hw/mlx5/mr.c | 20 +++++++++++---------
>  1 file changed, 11 insertions(+), 9 deletions(-)

Applied to for-next, thanks

Jason
