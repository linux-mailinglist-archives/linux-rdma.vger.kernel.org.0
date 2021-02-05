Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8DAF310F7C
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Feb 2021 19:07:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233096AbhBEQYC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 5 Feb 2021 11:24:02 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:12293 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233707AbhBEQWM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 5 Feb 2021 11:22:12 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B601d887e0000>; Fri, 05 Feb 2021 10:03:42 -0800
Received: from HKMAIL101.nvidia.com (10.18.16.10) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 5 Feb
 2021 18:03:22 +0000
Received: from HKMAIL103.nvidia.com (10.18.16.12) by HKMAIL101.nvidia.com
 (10.18.16.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 5 Feb
 2021 18:03:19 +0000
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.36.58) by
 HKMAIL103.nvidia.com (10.18.16.12) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Fri, 5 Feb 2021 18:03:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xw9SEVBZlQfpZ77DAcJN3tZDQk7VboB0X8Kkg64tbHsdkKX8uNtlakMa68bc9cxbQRd+L8U0HHRjuW2xdF2ydLhD+kJlkvZJogVJ7LeiXYtQZF7hqZVG9n6pF+6ZLg86W1FaqjvEcZ/8iaSDuzWqyWX3UvK35ldYUEa0Q+GpKs16cIRy9bnOhiWuooh3Gs+vFfpOr65Pr60rVkyMzt04LzvGO8v/pCjHd/Qt20b6oX1jPoQKqwAwCVU01/677G0cqHZN+PUh7gWCr4Ls1QNn24HaAi/+Vn0ShgnDGrDqEGn/XS4RvyHPjXM5+cxMSFWvY1jyRXwATZtUr7bREwjdmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8+ZoKvI3hsiaSaFNcCqssYKhvJnLs/zF6g75qp+7jFQ=;
 b=nPxDTkGBClxyJf1G36rc4rfIUSHlgA45XrRonk8N5Fgh5lguvvh146FTT0ShsieV+uUCHBxESULfnd/6zKqATJrJo4Ok2P9ECj9CoRIPfzIPoxJN3CrX4xmjeqCmMHY2EztTlfO8RAUsKf39Y+jtpwuVBYqODSlX+xn9bDIGw/d0HRHeA+bVYQbilOnb31dxU6DwIHKaHToI3XPdcko5aQMLutWMX3cCeFZk0/ebJDfFqDbPti6YXPLA61mld8lR9mOWowHULubT4og9gJcw4PeTy25CVZNEy12WhFoFHeWiA82/JrmqX6IWjkzeqLAaA5oIv+t69PRhSYDAzrNdRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB2581.namprd12.prod.outlook.com (2603:10b6:4:b2::36) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.17; Fri, 5 Feb
 2021 18:03:17 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::d6b:736:fa28:5e4]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::d6b:736:fa28:5e4%7]) with mapi id 15.20.3825.025; Fri, 5 Feb 2021
 18:03:17 +0000
Date:   Fri, 5 Feb 2021 14:03:15 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Weihang Li <liweihang@huawei.com>
CC:     <dledford@redhat.com>, <leon@kernel.org>,
        <linux-rdma@vger.kernel.org>, <linuxarm@openeuler.org>
Subject: Re: [PATCH v2 RFC 0/7] RDMA/hns: Add support for Dynamic Context
 Attachment
Message-ID: <20210205180315.GA969245@nvidia.com>
References: <1611394994-50363-1-git-send-email-liweihang@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1611394994-50363-1-git-send-email-liweihang@huawei.com>
X-ClientProxiedBy: BLAPR03CA0032.namprd03.prod.outlook.com
 (2603:10b6:208:32d::7) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by BLAPR03CA0032.namprd03.prod.outlook.com (2603:10b6:208:32d::7) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.19 via Frontend Transport; Fri, 5 Feb 2021 18:03:17 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1l85Rr-00449y-KQ; Fri, 05 Feb 2021 14:03:15 -0400
X-Header: ProcessedBy-CMR-outbound
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1612548222; bh=8+ZoKvI3hsiaSaFNcCqssYKhvJnLs/zF6g75qp+7jFQ=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Header;
        b=gUrfNQm5GdhZOvTG4NY2VWFGWhXCORdTLLVzt8rw9wGZoXLINELbyVpqGMhCIZ4Wt
         Fx+kSkkWuMyjd2r/rJsZP5+JJAYuhhxMezOOoAvCF3oJpvuu+bNoj1K6QZ8BQ4NW4g
         6O50y/yNXXsl/KMzpSq62Ov2IIRjzQnmENeraApEecOyEndGAxn9iIjJUUHA9Pc5Hb
         hikTruLxNqoZ608QK7Li64S7sYy0FJGhzTPTRbt9xdV46GJ3dMWh2WqHvsScixHJUE
         Ew5DFqtlkFXFEaoPH/FwkRlGW20k67hFeDC99+pBoYw6WtaMxSSukd+dIs9OJupO4I
         UTduTEj6UXZUQ==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Jan 23, 2021 at 05:43:07PM +0800, Weihang Li wrote:
> The hip09 introduces the DCA(Dynamic Context Attachment) feature which
> supports many RC QPs to share the WQE buffer in a memory pool. If a QP
> enables DCA feature, the WQE's buffer will not be allocated when creating
> but when the users start to post WRs. This will reduce the memory
> consumption when there are too many QPs are inactive.
> 
> Changes since v1:
> * Replace all GFP_ATOMIC with GFP_NOWAIT, because the former may use
>   emergency pool if no regular memory can be found.
> * Change size of cap_flags of alloc_ucontext_resp from 32 to 64 to avoid
>   a potential problem when pass it back to the userspace.
> * Move definition of HNS_ROCE_CAP_FLAG_DCA_MODE to hns-abi.h.
> * Rename free_mem_states() to free_dca_states() in #1.
> * Link: https://patchwork.kernel.org/project/linux-rdma/cover/1610706138-4219-1-git-send-email-liweihang@huawei.com/
> 
> Xi Wang (7):
>   RDMA/hns: Introduce DCA for RC QP
>   RDMA/hns: Add method for shrinking DCA memory pool
>   RDMA/hns: Configure DCA mode for the userspace QP
>   RDMA/hns: Add method for attaching WQE buffer
>   RDMA/hns: Setup the configuration of WQE addressing to QPC
>   RDMA/hns: Add method to detach WQE buffer
>   RDMA/hns: Add method to query WQE buffer's address
> 
>  drivers/infiniband/hw/hns/Makefile          |    2 +-
>  drivers/infiniband/hw/hns/hns_roce_dca.c    | 1264 +++++++++++++++++++++++++++
>  drivers/infiniband/hw/hns/hns_roce_dca.h    |   68 ++
>  drivers/infiniband/hw/hns/hns_roce_device.h |   31 +
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c  |  223 ++++-
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.h  |    3 +
>  drivers/infiniband/hw/hns/hns_roce_main.c   |   27 +-
>  drivers/infiniband/hw/hns/hns_roce_qp.c     |  119 ++-
>  include/uapi/rdma/hns-abi.h                 |   64 ++

Where are the rdma-core changes to go with this?

Jason
