Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDAB32ED6BC
	for <lists+linux-rdma@lfdr.de>; Thu,  7 Jan 2021 19:33:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727673AbhAGSdE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 7 Jan 2021 13:33:04 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:3920 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727177AbhAGSdD (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 7 Jan 2021 13:33:03 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5ff753b70000>; Thu, 07 Jan 2021 10:32:23 -0800
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 7 Jan
 2021 18:32:23 +0000
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.171)
 by HQMAIL111.nvidia.com (172.20.187.18) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 7 Jan 2021 18:32:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I+XU0/6EgiEZs1mXbm3Lg260yX7X5LCVpE+10apIuqaqC80uKHsQZloMiiWBDJbx5Gy6Cpnd259B6IB/n/0N7Ye83wUw4owk7YBmYlpPacTPphIzNjSwo4PiBiEevUbtboYQOsF4E76R/j0JLdEnm/y4gt/bFrbEY9r3dpaA7ZmDR5HKQ0NFT3RHcIMI0KUTKv3gmFp35SwYSQFH7LzhfTsl61gx5aneOhqwe+4aqKa2y4psdbo/tDYzJ8IUs7sbCXvjkMXiwITfpYbY2dGE5MdpE6s7G1lykhIxQfDvI+d3Sgfnx9Av0Y/QiXguBJyVouaHX6zxTR0plTXEE4cOtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q16VugC6vU6xRfGWLxf7ojWhtDfQ9XdTQsGlckT246w=;
 b=EMM/iffe90rYzYWCFlCDvI6CbGSe/8jDVgaELhXnjdlp1c8xQM8isa9mzyzBK1PAg7r5mg/C2sIqXkgW1LLUL1vsC5tN+Js67j0i+q+PJ7TJJPShXAe6dOh4R+QHBG1pg+mMaud2Q5p7wCFRzcBLgSyxYtmA2bkkMpaSx8WrhGEU38t9pbKY8mmQPOzGPlF2cGAuBWe26wJzWEaUSQQQdtWP+X/snm+QlvL8JMtlq59n1Prza/RSwFkJutFqEtruN+CuUxv/j+3jJEkQnFaPRTkzAXoy+xVGwfjkd+CAxN/ML3K0c4VvrZPp9V9T4muFSIoJnpcvrr5xxTiU2B6aXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB2486.namprd12.prod.outlook.com (2603:10b6:4:b2::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3721.24; Thu, 7 Jan
 2021 18:32:21 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::546d:512c:72fa:4727]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::546d:512c:72fa:4727%7]) with mapi id 15.20.3742.008; Thu, 7 Jan 2021
 18:32:21 +0000
Date:   Thu, 7 Jan 2021 14:32:19 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-next] RDMA/restrack: Don't treat as an error
 allocation ID wrapping
Message-ID: <20210107183219.GA916909@nvidia.com>
References: <20201216100753.1127638-1-leon@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201216100753.1127638-1-leon@kernel.org>
X-ClientProxiedBy: MN2PR12CA0010.namprd12.prod.outlook.com
 (2603:10b6:208:a8::23) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by MN2PR12CA0010.namprd12.prod.outlook.com (2603:10b6:208:a8::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6 via Frontend Transport; Thu, 7 Jan 2021 18:32:20 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kxa55-003qXw-Oa; Thu, 07 Jan 2021 14:32:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1610044343; bh=q16VugC6vU6xRfGWLxf7ojWhtDfQ9XdTQsGlckT246w=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=ULaeFOl+1g9XVT0Gjb9cBulSTeXKzBdg2B/EkdoYfmkChPCbQBFKZPJxpTumzoLrX
         3DmrrRkUK7Sx/QVTozsAst+BMTer0KtoAWrA+bjw1dKpDSHPPSu84JwDhC13XEp8K3
         dAm/tX4yvvnxGEsa1NL/U9zsfnIeQiiLNgjxQEb+IfnUPH2I+DdRhSTTytHzv2iwK3
         HygHCPtTigAMhkEkd+WhNr2PWXfhS/ZziQx9B31JeLhu3M+hf9QeIyvK5digL48V+h
         FcqDBF8LuI/SVYOMx7dvkG9cVve7vgozlYYwHkCxUcpSe0ANQug88AN0Ju35fEQxH8
         mOzh2M2kfZJ8g==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Dec 16, 2020 at 12:07:53PM +0200, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> xa_alloc_cyclic() call returns positive number if ID allocation
> succeeded but wrapped. It is not an error, so normalize the "ret"
> variable to zero as marker of not-an-error.
> 
>    drivers/infiniband/core/restrack.c:261 rdma_restrack_add()
>    warn: 'ret' can be either negative or positive
> 
> Fixes: fd47c2f99f04 ("RDMA/restrack: Convert internal DB from hash to XArray")
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/infiniband/core/restrack.c | 1 +
>  1 file changed, 1 insertion(+)

Applied to for-rc, thanks

Jason
