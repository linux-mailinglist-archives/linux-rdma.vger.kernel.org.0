Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 982602D1A07
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Dec 2020 20:53:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726207AbgLGTwW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 7 Dec 2020 14:52:22 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:18740 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725979AbgLGTwV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 7 Dec 2020 14:52:21 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fce87cd0000>; Mon, 07 Dec 2020 11:51:41 -0800
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 7 Dec
 2020 19:51:40 +0000
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.47) by
 HQMAIL101.nvidia.com (172.20.187.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Mon, 7 Dec 2020 19:51:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pz/2ZOV8RDDWSrPfNb8Z1DbXGvByFt3hYuddf4GLHvHkpUoxDa+9ZAWjjwzl8L/DfePV6rbOUlmzOP14PxyEVUyYQKwwgios1Fe+V1VlRCIjig4tZCXXZk90TV+0Wp/IUKrfK7OGOsM9iIOWET7BdDPl8jVk1LktqP2gP2GNfTvoZQf8WDE+/dgHM48mx+YGVW05mkq+l7KlzJIcMbAV3t7BdhOAwgUD9ASslywc7zR4gcr1QO/7N5cd/5HAEDNEOZZs3kUxiIeHV+asgAqtXk+mQ8D+tlvn4OODGmpjHRxvrFmJLiWtn2/nwdxyVCuhlCz2Cp1fUsYrQCsYxPw7cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OqIaexJlpxvlS0sTVSVeiWrodJA2KCDdTpjcefnhhKU=;
 b=lBCQ0Uo51fSolllpRK9kIXwOSiFKib8uRXgyDDF/fuN4Gi/JBHiHTAggW3gxSjaZq05LNUbinZaAQ4esgx4omr7Jak5GMDk4kxFTR6XSCNPVpU1F0x5VFVunIX5+B162wtDGjzDEKxUw6NNr3oLNo7RBbuoI3roeWsL5U+N9ebHd1FsLzQnXUCfFTLwKnl6QZY2TBGLtS0IcS3cNEyha5kqtrbKBAxxJ2y9lDHvr8FhRhFgYVKO3B9ioYzRvRX1gibAS1lJEIfW3u0yQF+8obXNg3Ov2u5QpRb6p+wu9tBVwIuPe/fnMyKRhfEj7mI4GdL8SytXkJ1hjnE8ALS4s6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4267.namprd12.prod.outlook.com (2603:10b6:5:21e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.20; Mon, 7 Dec
 2020 19:51:39 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1ce9:3434:90fe:3433]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1ce9:3434:90fe:3433%3]) with mapi id 15.20.3632.023; Mon, 7 Dec 2020
 19:51:39 +0000
Date:   Mon, 7 Dec 2020 15:51:37 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Weihang Li <liweihang@huawei.com>
CC:     <dledford@redhat.com>, <leon@kernel.org>,
        <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>
Subject: Re: [PATCH v2 for-next] RDMA/hns: Move capability flags of QP and CQ
 to hns-abi.h
Message-ID: <20201207195137.GA1786195@nvidia.com>
References: <1606872560-17823-1-git-send-email-liweihang@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1606872560-17823-1-git-send-email-liweihang@huawei.com>
X-ClientProxiedBy: BL0PR02CA0073.namprd02.prod.outlook.com
 (2603:10b6:208:51::14) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by BL0PR02CA0073.namprd02.prod.outlook.com (2603:10b6:208:51::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17 via Frontend Transport; Mon, 7 Dec 2020 19:51:38 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kmMXp-007UgL-Dg; Mon, 07 Dec 2020 15:51:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1607370701; bh=OqIaexJlpxvlS0sTVSVeiWrodJA2KCDdTpjcefnhhKU=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=kNM5GpxB9GgFxyAs4m1lPf9NFs7scO+JLAxHHdnobDbKGa9TkRQAFo1upfUR0KlIu
         tTM/kV/sw0dcms+4U9t294tzgnqtauLvxaNhJbQQUTWJ86fBAd87y0iQLZ2N8lw1EQ
         Sf67qC2m5mwuv3siUOJdovsOWixJRLxTQJXvg1QlBWZpnB/KstVWOKWIIRQYyDC9jQ
         G94cMC9+PLeMBO/92AWKpNAX634bPKeExBn/+LNfa1yU8kTyetHWdsJ3wwaPCsl8re
         IpYpuslyGu/HBEeFO2v7XS3nhxSEMu386moGQfTN0qqFUbgh1F8jVmSHCNiY96yd/9
         8Xie8nOCnizpQ==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Dec 02, 2020 at 09:29:20AM +0800, Weihang Li wrote:
> These flags will be returned to the userspace through ABI, so they should
> be defined in hns-abi.h. Furthermore, there is no need to include
> hns-abi.h in every source files, it just needs to be included in the
> common header file.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Weihang Li <liweihang@huawei.com>
> ---
> Changes since v1:
> - Replace 'BIT(x)' with '1 << x'.
> 
> Previous Version:
> v1: https://patchwork.kernel.org/project/linux-rdma/patch/1606829024-51856-1-git-send-email-liweihang@huawei.com/
> 
>  drivers/infiniband/hw/hns/hns_roce_cq.c     |  1 -
>  drivers/infiniband/hw/hns/hns_roce_device.h | 11 +----------
>  drivers/infiniband/hw/hns/hns_roce_main.c   |  1 -
>  drivers/infiniband/hw/hns/hns_roce_pd.c     |  1 -
>  drivers/infiniband/hw/hns/hns_roce_qp.c     |  1 -
>  drivers/infiniband/hw/hns/hns_roce_srq.c    |  1 -
>  include/uapi/rdma/hns-abi.h                 | 10 ++++++++++
>  7 files changed, 11 insertions(+), 15 deletions(-)

Applied to for-next, thanks

Jason
