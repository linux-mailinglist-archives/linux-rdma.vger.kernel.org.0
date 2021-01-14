Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6EF82F6783
	for <lists+linux-rdma@lfdr.de>; Thu, 14 Jan 2021 18:30:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728014AbhANRYs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 14 Jan 2021 12:24:48 -0500
Received: from nat-hk.nvidia.com ([203.18.50.4]:50140 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726510AbhANRYs (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 14 Jan 2021 12:24:48 -0500
Received: from HKMAIL101.nvidia.com (Not Verified[10.18.92.77]) by nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B60007e350002>; Fri, 15 Jan 2021 01:24:05 +0800
Received: from HKMAIL104.nvidia.com (10.18.16.13) by HKMAIL101.nvidia.com
 (10.18.16.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 14 Jan
 2021 17:24:05 +0000
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.44) by
 HKMAIL104.nvidia.com (10.18.16.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 14 Jan 2021 17:24:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JlNKIp8ISiUxcGllhlxr46/Aj7jWioI+10P28NWTabeIEoZ/DaFes1hisBg6T6HBTDWoqhHe2XaWJGukuoSXZIKE0V6fdpJqyxX36rnacc7VkFHOwJm7cgOY2fgu1zS6IODLuf5qZRHbbcBzVOxs4l+YAs3/9tTnE7rtVq/aFCP+2p21icxK8u3LylpsK21v7tq8EoTexZ4Hn4R+lRcpaBHMNSrliTW05ln5j5pFQ6rOovraf/+hUr93IpmM+PCq+8zFo4veB833ziOw/Y1U3W1+0RRk4STaERYuDQ4doZWoz5wKlLyC/z/oR3dJD9Ak/sRME3inqrxqrid9c+X0IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q4SiXvTNQSSwmRqsJYQ8OiBgfSU3oXxGvR4qcjhqxSc=;
 b=iQGOj+S9W/5EfzzvXTq8ftfpBlUcjDRX1x7xfpaBRkB9MgGiUs521avRvBDjcpBjVL8/eoTrE7tLunPlB4tc02i2TVJ0D/+yGGlVgEcR31TNSaX5SvsyLacVgv6WkTk7pW841omjFSWInQOsXhtFvICuHw9Do6GOrVkADk9X8jULtmlCT0Cq57jMMg03mHHR8gL5ev5+B+dKgJFYyq1+ZoiupqKA3tUrLxKhDeeIjz0QKkFNA0yrVtWmz2uzkjz1bt56pVyxH2r1Jriy+dCooHUEOSa6F1QtuMYKJ097k94Be3RzTnHjB70zXUfu8Ezs2tbuyi9XmWaeBYo1kJ1JxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3017.namprd12.prod.outlook.com (2603:10b6:5:3e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6; Thu, 14 Jan
 2021 17:24:02 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::546d:512c:72fa:4727]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::546d:512c:72fa:4727%7]) with mapi id 15.20.3742.012; Thu, 14 Jan 2021
 17:24:02 +0000
Date:   Thu, 14 Jan 2021 13:23:59 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bryan Tan <bryantan@vmware.com>
CC:     <linux-rdma@vger.kernel.org>, <pv-drivers@vmware.com>
Subject: Re: [PATCH for-rc] RDMA/vmw_pvrdma: Fix network_hdr_type reported in
 WC
Message-ID: <20210114172359.GC316809@nvidia.com>
References: <1610634408-31356-1-git-send-email-bryantan@vmware.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1610634408-31356-1-git-send-email-bryantan@vmware.com>
X-ClientProxiedBy: BLAPR03CA0079.namprd03.prod.outlook.com
 (2603:10b6:208:329::24) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by BLAPR03CA0079.namprd03.prod.outlook.com (2603:10b6:208:329::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.10 via Frontend Transport; Thu, 14 Jan 2021 17:24:01 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1l06Ln-001KrH-Ji; Thu, 14 Jan 2021 13:23:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1610645045; bh=Q4SiXvTNQSSwmRqsJYQ8OiBgfSU3oXxGvR4qcjhqxSc=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=d0FazQczAqFTG/86k+XDOD7M2lhLZOEV9Rnu81OInE1iuPDdJWmnVR6uHGSctJ36G
         CgixCOaDga/nXAv/T6lB00KssdsCy5cyjhOb1zqLfFSHxD/trEdP6XEmellE1kGOPk
         owcVWjto0BB0mhiQbUc8uRogJ1mHHELoxJr3NcqNo3jsbXeTxyqeNgqECS/Xk/pyoT
         9wJNy//1a7WWy9slfdXqRoQkjavdir504JKdJb7/uUnOqUrrwNvd+JexkUPg+ZGQR8
         i0hicsxlnBApnAM2itK9mAY3wtr0u4XEBHm2C2rDhjPn9tHo979Sk78XblhyDC5aR2
         p7bafQV0/TIKA==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jan 14, 2021 at 06:26:48AM -0800, Bryan Tan wrote:
> The PVRDMA device defines network_hdr_type according to an old
> definition of the rdma_network_type enum that has since changed,
> resulting in the wrong rdma_network_type being reported. Fix this by
> explicitly defining the enum used by the PVRDMA device and adding a
> function to convert the pvrdma_network_type to rdma_network_type enum.

How come I can't find anything reading this in rdma-core?

$ ~/oss/rdma-core#git grep network_hdr_type
kernel-headers/rdma/vmw_pvrdma-abi.h:	__u8 network_hdr_type;

??

> Fixes: 1c15b4f2a42f ("RDMA/core: Modify enum ib_gid_type and enum rdma_network_type")
> Signed-off-by: Bryan Tan <bryantan@vmware.com>

Add Cc: stable@vger.kernel.org # 5.10+

> diff --git a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_dev_api.h b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_dev_api.h
> index 86a6c054ea26..637d33944f95 100644
> --- a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_dev_api.h
> +++ b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_dev_api.h
> @@ -201,6 +201,13 @@ enum pvrdma_device_mode {
>  	PVRDMA_DEVICE_MODE_IB,		/* InfiniBand. */
>  };
>  
> +enum pvrdma_network_type {
> +	PVRDMA_NETWORK_IB,
> +	PVRDMA_NETWORK_ROCE_V1 = PVRDMA_NETWORK_IB,
> +	PVRDMA_NETWORK_IPV4,
> +	PVRDMA_NETWORK_IPV6
> +};

This is in the wrong place, uapi data needs to be in
includ/ulp/rdma/vmw_pvrdma-abi.h

Jason
