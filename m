Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 553BE2B0CB8
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Nov 2020 19:35:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726151AbgKLSfg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 12 Nov 2020 13:35:36 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:9531 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726148AbgKLSfg (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 12 Nov 2020 13:35:36 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fad807c0000>; Thu, 12 Nov 2020 10:35:40 -0800
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 12 Nov
 2020 18:35:35 +0000
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by HQMAIL111.nvidia.com (172.20.187.18) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 12 Nov 2020 18:35:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TuhfGCRJOZIYj85fQcL/6QOqr33u4F43kEGAc+xX+eTAa5mo2ib4tkWsBY6O/dT4qK8eOS29fvXVKAns72FbfWIdE75cW8+zLurGyYtEqcWjo8ZutazmTGXTipyrDNPhPuaMZ1baMkYY5IgiL264os55baC3Uagrffu6hqoiRBXTlRalRzWWGZXbj8IOYVK4W18mNAztcaJh3NyAf+Siw2j2pqZM7oHJs60sNe0ytCwKChMT/S6+7EmCisJoOwJQ1aJBYx6EiN3k6gXiDdBW/n3BNLj/Z63nsfzc+ukYs3tch+NAMzcrA9qt0zTORUWAS+Qg9nZPIOmPLkyR8lpQMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xUzwi9x81Gr6/1ig96S3ugoH15M/BWV4ZoXdAM9gO+U=;
 b=SdDxWsIbHNz5xilGJQJCbqLkrGfD78P/MO7TdLlw5cNThltSOLHXb8+ffLNjFmTSZ7tx+BuM3+HGleG1FCC1wIokpjZ/OIX9Clv5N1c8v6b6osQeIshscINreYy7jfGWBXRXoo4hp3oqOlBZM5/rzJ4VMm1NQZaKC41Ar4ao/hZ5Q8RtuQK9/B1Q8AXJHtM0EW2Y0xKO/cSiejj9VUFVdJaE8suHIFt/tHWotpTzJkLweDEA8NH85EzKn5H+8aC0Wz0I5AKyyDdD4uJZ9qBeyBnAUh9WEv5CibcAVeJWIr0iMosHtFPczP+wh0NDNgKri2OwlxQEOJyfU+m568ciSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4498.namprd12.prod.outlook.com (2603:10b6:5:2a2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Thu, 12 Nov
 2020 18:35:33 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3499.032; Thu, 12 Nov 2020
 18:35:33 +0000
Date:   Thu, 12 Nov 2020 14:35:32 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Weihang Li <liweihang@huawei.com>
CC:     <dledford@redhat.com>, <leon@kernel.org>,
        <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>
Subject: Re: [PATCH for-next 7/8] RDMA/hns: Add UD support for HIP09
Message-ID: <20201112183532.GA964096@nvidia.com>
References: <1604057975-23388-1-git-send-email-liweihang@huawei.com>
 <1604057975-23388-8-git-send-email-liweihang@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1604057975-23388-8-git-send-email-liweihang@huawei.com>
X-ClientProxiedBy: BL1PR13CA0151.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::6) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by BL1PR13CA0151.namprd13.prod.outlook.com (2603:10b6:208:2bd::6) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.21 via Frontend Transport; Thu, 12 Nov 2020 18:35:33 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kdHRU-0042pl-6T; Thu, 12 Nov 2020 14:35:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1605206140; bh=xUzwi9x81Gr6/1ig96S3ugoH15M/BWV4ZoXdAM9gO+U=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=UYL+cUw7UCWbdTRnWv01ves2BKpHlXZ0OH3AdMR1bBy/nc1IVORp5XHyveGUx1b4F
         wgGJ96LWZDzxflyCTs6nMj1DXiN/MbKcMnXrZQIdSE6klPRNuPuwOe7SuKTbd911l0
         LqxOqUzUTPJGyopS+RuWSXBE4POOau/ivYMI1U8QCz5GYMm7e5sxpeP2Z9MIbFADy+
         WZWRvb6gDxX57L0jI6M8zrPNp6jhzOSszVPHHXF5gsFtLb2Q2N4XGrDH58oY3EN9rQ
         EZoJ+fQ/AV7ZQ1MQ9IYdCTd77VtwSL4pDm3+w9wZ6oaDX+Cdt/WQ8r+THxBnDgimHj
         Ma8c4bZQLsDFA==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Oct 30, 2020 at 07:39:34PM +0800, Weihang Li wrote:
> HIP09 supports service type of Unreliable Datagram, add necessary process
> to enable this feature.
> 
> Signed-off-by: Weihang Li <liweihang@huawei.com>
>  drivers/infiniband/hw/hns/hns_roce_device.h | 2 ++
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 8 +++++---
>  drivers/infiniband/hw/hns/hns_roce_qp.c     | 3 ++-
>  3 files changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
> index 9a032d0..23f8fe7 100644
> +++ b/drivers/infiniband/hw/hns/hns_roce_device.h
> @@ -222,7 +222,9 @@ enum {
>  	HNS_ROCE_CAP_FLAG_FRMR                  = BIT(8),
>  	HNS_ROCE_CAP_FLAG_QP_FLOW_CTRL		= BIT(9),
>  	HNS_ROCE_CAP_FLAG_ATOMIC		= BIT(10),
> +	HNS_ROCE_CAP_FLAG_UD			= BIT(11),

Why add this flag if nothing reads it?

>  	HNS_ROCE_CAP_FLAG_SDI_MODE		= BIT(14),
> +
>  };

Extra space


If I recall properly earlier chips did not have a GID table so could
not support UD because they could not secure the AH, or something like
that.

So, I would expect to see that only the new devices support UD, but
I can't quite see that in this patch??

Jason
