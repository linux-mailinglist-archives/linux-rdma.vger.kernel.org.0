Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EC352B0AF0
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Nov 2020 18:07:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725977AbgKLRHA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 12 Nov 2020 12:07:00 -0500
Received: from nat-hk.nvidia.com ([203.18.50.4]:60403 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725999AbgKLRHA (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 12 Nov 2020 12:07:00 -0500
Received: from HKMAIL103.nvidia.com (Not Verified[10.18.92.100]) by nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fad6bb20000>; Fri, 13 Nov 2020 01:06:58 +0800
Received: from HKMAIL101.nvidia.com (10.18.16.10) by HKMAIL103.nvidia.com
 (10.18.16.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 12 Nov
 2020 17:06:54 +0000
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.105)
 by HKMAIL101.nvidia.com (10.18.16.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 12 Nov 2020 17:06:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YpsZu3418zlw9JBC1pID0s3eUtLVHnCuObfvnoK0qNLJtbarX6K5kTjp1bXLn8EmFNnUPJy4kuvkEXyR1r05s+uPfIfjouRlabXH0zf/98OVhQy93RFqkgBIClZ209OaFKm/ZJm1RifUszRUJ1bScWBboZwkoNx/h7jmrJMhq59c0hUK+9xdiSmRt++6hJKJuxfV2DPBI2qlv6KB7S2uFXSkLxj9y1IU/7tfojDass4g3z5w5ElNGvr2A6xs3hPzomLotUd3URSdJlgbmr85aYQ5iG4MU1k1yOxyLA6drM0MLgW9JWDbqpUl8zyVELSi1eBFmhiXUK2iNPstf4osLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5z7dMl7KkvuVL88iW/SxI6CsAU8go0L4m0fbFgGNIjo=;
 b=lFxl45eSzDSdrGzenFeR6jnmRqHB4Z5fGdlBF9wb1+yzrC3CRFbtur1vH8BJcrqoMijNdm2DMPLfw6MedQWxQkidxvBMiGJNLJMjIyyIMPuhpgN9IktoJsBp96h+zXKf6SbFgg25b1dwxdcTPWVX45ofd9iNne9SweQ6R0kjJX+/ZNeFUxUjlHAx847zpL1EJ2DZqlC9w+L7BlhRp5yHJTaqVl0tvGD+Zq9ePN0oC5tSk6EC05nXyTCb2d/1UZm+6+sfV69fiek+6Y7Q+pN6XNdFIEMVy4KBlbXexIKgX1fM/5PeyJfLuNnhNtDLCAGK+zZ6vPzvqHX77eXGB3ro8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4483.namprd12.prod.outlook.com (2603:10b6:5:2a2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Thu, 12 Nov
 2020 17:06:52 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3499.032; Thu, 12 Nov 2020
 17:06:52 +0000
Date:   Thu, 12 Nov 2020 13:06:50 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Qinglang Miao <miaoqinglang@huawei.com>
CC:     Adit Ranadive <aditr@vmware.com>,
        VMware PV-Drivers <pv-drivers@vmware.com>,
        Doug Ledford <dledford@redhat.com>,
        <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] RDMA/pvrdma: fix missing kfree in pvrdma_register_device
Message-ID: <20201112170650.GA937057@nvidia.com>
References: <20201111032202.17925-1-miaoqinglang@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201111032202.17925-1-miaoqinglang@huawei.com>
X-ClientProxiedBy: BL1PR13CA0129.namprd13.prod.outlook.com
 (2603:10b6:208:2bb::14) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by BL1PR13CA0129.namprd13.prod.outlook.com (2603:10b6:208:2bb::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.13 via Frontend Transport; Thu, 12 Nov 2020 17:06:51 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kdG3e-003vme-Eg; Thu, 12 Nov 2020 13:06:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1605200818; bh=5z7dMl7KkvuVL88iW/SxI6CsAU8go0L4m0fbFgGNIjo=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=bPlRU19dwddTvR2WZMkVFVM0IbnOWN2EzRyrzTC8QsKyvaMEUZU6tzqeiTizXNdKP
         8epmURAtFsjEZJMGNv1ZxYVA8rJhWKLeaT0f/Ry8eyNTiISikdEceoNKOviN95oj8Z
         HcXfzOhgLCHw71knCE4NnzDtBCvC9wWH5MSbz4FqIrOKeJb2dXIoVlU2h4AAARPf1W
         KrYlIwXdPCiah6KCRGKao/tV9NLAN/DYlD5NwdkDhwlkFWzKtrE+jEhcjGz1m64b5d
         e1b3ZdPXqcYjxCYEFfw10YdTs0Nupb6NDEdfk1pMdnWyzK15cMzgTm9J1XAmdR2FlL
         TrMJ1cOfaMEuw==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Nov 11, 2020 at 11:22:02AM +0800, Qinglang Miao wrote:
> Fix missing kfree in pvrdma_register_device() when fails
> to do ib_device_set_netdev.
> 
> Fixes: 4b38da75e089 ("RDMA/drivers: Convert easy drivers to use ib_device_set_netdev()")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>
> ---
>  drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to for-rc with the 'goto err_srq_free' from Adit

Thanks,
Jason
