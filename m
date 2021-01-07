Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 383C02EE72E
	for <lists+linux-rdma@lfdr.de>; Thu,  7 Jan 2021 21:50:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726616AbhAGUt6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 7 Jan 2021 15:49:58 -0500
Received: from nat-hk.nvidia.com ([203.18.50.4]:40198 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725944AbhAGUt6 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 7 Jan 2021 15:49:58 -0500
Received: from HKMAIL101.nvidia.com (Not Verified[10.18.92.9]) by nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5ff773cc0000>; Fri, 08 Jan 2021 04:49:16 +0800
Received: from HKMAIL102.nvidia.com (10.18.16.11) by HKMAIL101.nvidia.com
 (10.18.16.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 7 Jan
 2021 20:49:14 +0000
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.102)
 by HKMAIL102.nvidia.com (10.18.16.11) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 7 Jan 2021 20:49:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iiQtbBmbpwjtedSKPpGI5n8m0mqGwY3w0npUYZsc7DLk+PW5mtUo6rG5ENEo/5XnVttBAvEL12qQmf1gRzfImzc00611lsvorMvJzryFHYOsI6NI8P2waYZ45cSrb922k2SG1rINKpyt+2h4ZlR3cQ9D15s3y+Ls8vWBo/VkNCPzfpRD0gV8v32gge3v3AmaSDTkzUvrJONMqv2p/PfkRw04G5ziAmEaB130dKvF6UtcuU8fqAawu5snm4vNFTWrzMIRiegWOS+WA9Iob9sx5/mHiMuZYDGJ7/TNY1sKcWKHM9S3S/FbSYY8oIWroSd4OMQK6SR6hN5+hEz+P9YzgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KMO9KITY4Azeq1jcktkuGbSarhE7ul1o+du2L3DYgIk=;
 b=XDvV9cgKpvMcAZIVJwtRSdoA+lbAce7CRKwsV/DsXAaHZeA6ZYqi3jdaztIBe7zTTCW3vC4HaL2GP9LlYlI/QPYc9beBPA+p1eKx5I28yYXqSghalevC+tfuPkQkhDHCkng0RgXiiCe4nTDdmfqTydwfExpX0QLFuGgcHVA82VXZGaatTb+z+SqCgipxQr7SdstPQ15LiNXDW8Fpz5+hDxi7QJXdnH3xYRx4wTVLLfAEda6jWkGIhEjNLOvv4ulPVuLX1VLiNpVE2NmQaKpVebHxO94sgfdlDBXC7zByN63FqNBJHtOe13qOopNf6bsXl+2kjwSgCcC/YJqlULg8FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3931.namprd12.prod.outlook.com (2603:10b6:5:1cb::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6; Thu, 7 Jan
 2021 20:49:12 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::546d:512c:72fa:4727]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::546d:512c:72fa:4727%7]) with mapi id 15.20.3742.008; Thu, 7 Jan 2021
 20:49:12 +0000
Date:   Thu, 7 Jan 2021 16:49:10 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Zheng Yongjun <zhengyongjun3@huawei.com>
CC:     <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dledford@redhat.com>
Subject: Re: [PATCH -next] RDMA/rw: Use kzalloc for allocating only one thing
Message-ID: <20210107204910.GA938437@nvidia.com>
References: <20201229135223.23815-1-zhengyongjun3@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201229135223.23815-1-zhengyongjun3@huawei.com>
X-ClientProxiedBy: BL1PR13CA0467.namprd13.prod.outlook.com
 (2603:10b6:208:2c4::22) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by BL1PR13CA0467.namprd13.prod.outlook.com (2603:10b6:208:2c4::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.2 via Frontend Transport; Thu, 7 Jan 2021 20:49:11 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kxcDW-003w99-F7; Thu, 07 Jan 2021 16:49:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1610052556; bh=KMO9KITY4Azeq1jcktkuGbSarhE7ul1o+du2L3DYgIk=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=FNAaUuXftjqDqFc2mE6iJSxo8YXu6fbGUOjA+sUa/vXa9gHugos7S11zc7IufiHwT
         mjYKAobpmW87Xb/oY2OavIrfva7WB3WeMLOcxCaTr+u7QKJpxrJBkIF2Q+8hwy82yi
         7qTrh/2XccJnssFYGN/pqaiwYwspwdD9xahMPXB5gJ1z6sXXHiqzpqdG6OIPgILW5P
         gjEj8zCY8o/cf06eLgf5/b10srtFwe7I4bR9ARHZhr+U6bFr8IsxVkrbr3OJd4D1px
         PoMmyuglz9RIPvZKUK1JP5pnyNKgPez/7T56SNSPWTMCGNY2aC+J9w1YRAjBlWKh2q
         fsZVcy4VSY6eQ==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Dec 29, 2020 at 09:52:23PM +0800, Zheng Yongjun wrote:
> Use kzalloc rather than kcalloc(1,...)
> 
> The semantic patch that makes this change is as follows:
> (http://coccinelle.lip6.fr/)
> 
> // <smpl>
> @@
> @@
> 
> - kcalloc(1,
> + kzalloc(
>           ...)
> // </smpl>
> 
> Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
> ---
>  drivers/infiniband/core/rw.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

I applied this one and

 iw_cxgb4: Use kzalloc for allocating only one thing

Together as one commit to for-next, thanks

Jason
