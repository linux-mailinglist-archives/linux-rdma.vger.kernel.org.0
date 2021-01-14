Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7E462F66CD
	for <lists+linux-rdma@lfdr.de>; Thu, 14 Jan 2021 18:08:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727787AbhANRHn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 14 Jan 2021 12:07:43 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:2644 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726212AbhANRHm (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 14 Jan 2021 12:07:42 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B60007a360003>; Thu, 14 Jan 2021 09:07:02 -0800
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 14 Jan
 2021 17:07:02 +0000
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.175)
 by HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 14 Jan 2021 17:07:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q0CteI8u2VYhLNzoiJqp+9vVGTB5W+bHNNish59klxJqfPUKEVkYrhfVyqKM130OmRIUeSKLxXAEqoAI1VhkfxAAvuS1oSTZxTITmJWI+u+W7SuMn3EJKs6N+EwmpBcpLeeZvj1nLezWHW7yRULwc6PF7hyJ0UDfmI+yMypJKnxAkoec0e2DutsvxpI6ksGCo3fGu5i1N16tcEU6/Z+3mQ89ormIrVUbbnhIAgB4vUBeFZh/+MaEiDUFBQB/d1VjdXX06eN9JIGxcfT2k4xwSBtCkUABTOPQrtgnS7teZ0SC17iQMQ1oaWKQYTOoI3GC6e5c1Wevpq3fd9Z7Q9KQ2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e652anirv7dYA26SpWd0I6d6aPFQfnvoeSEduWhP6zA=;
 b=j1VmwsTh5m40tAv72qmM1GHbsRzKXkiO6dMz4qJwuHoCnQyBLltzEES2Wj4wv4+ZGKACOof3fCDlIaNQCUUw1Dbb6ZaT2WzxeuePdUTac1XgEfPX+kjMZ0LbIMt8B4W/VU2kbFGJSVCRF+lc4QZ1VN+BT6MkzcRyJ4KLGnvTmh1lnfKx01fz+aRnISpf6AnL2evQoyj8lr1FX7eiEBg1f0nOPvH/4brMiC9weRRVE15Qf/BeDOdLg8Hwjr74qLBaLUr+xhCZobw0wzvWsip+EqLp2SYCZmYvRcyNDpM9jlNvhEsbF2fI/rFKxBTLPt2XbKBqPFmhjg/RpGOPsLeWXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3211.namprd12.prod.outlook.com (2603:10b6:5:15c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6; Thu, 14 Jan
 2021 17:07:00 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::546d:512c:72fa:4727]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::546d:512c:72fa:4727%7]) with mapi id 15.20.3742.012; Thu, 14 Jan 2021
 17:07:00 +0000
Date:   Thu, 14 Jan 2021 13:06:59 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Neta Ostrovsky <netao@nvidia.com>,
        Avihai Horon <avihaih@nvidia.com>, <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-next] RDMA/cma: Fix error flow in
 default_roce_mode_store
Message-ID: <20210114170659.GB316809@nvidia.com>
References: <20210113130214.562108-1-leon@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210113130214.562108-1-leon@kernel.org>
X-ClientProxiedBy: BL0PR0102CA0015.prod.exchangelabs.com
 (2603:10b6:207:18::28) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by BL0PR0102CA0015.prod.exchangelabs.com (2603:10b6:207:18::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.10 via Frontend Transport; Thu, 14 Jan 2021 17:07:00 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1l065L-001KYo-1b; Thu, 14 Jan 2021 13:06:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1610644022; bh=e652anirv7dYA26SpWd0I6d6aPFQfnvoeSEduWhP6zA=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=Ym6H351lfZfPlkF/PeIChAFHkpe64z3y8vzGn7XFL0x0goKdjHp7Irs4wJtqTu/6w
         Hs0mbwlPfd1jZVbSJa1WFZiEd2Z5TqJ4ve2IvpHeVYOq8L7tklu8mNZfFGqz3OLOkM
         UsK1sEFSqwMRmfNtL8Q+y9qDYlXY/FW3qHJs5UHMs40a7cVUbq+4OqZHF80+pKsjJ/
         G6h6brIS0/rXzRyoJ27TvPvU24hmxMudOinJ7C1b9jcbX70llTe+G5ePXghCUEwTQu
         gxpK8VZ1/ZjHt2cwiV7nsP0nYhfj1TQ+ix+Zj6CZyNFGItQK6yz85G6IHyOk04NzPC
         +6TFRUceKnEuw==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jan 13, 2021 at 03:02:14PM +0200, Leon Romanovsky wrote:
> From: Neta Ostrovsky <netao@nvidia.com>
> 
> In default_roce_mode_store(), we took a reference to cma_dev, but
> didn't return it in error flow. Fix it by calling to cma_dev_put
> in such flow.
> 
> Fixes: 1c15b4f2a42f ("RDMA/core: Modify enum ib_gid_type and enum rdma_network_type")
> Signed-off-by: Neta Ostrovsky <netao@nvidia.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/infiniband/core/cma_configfs.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Applied to for-rc

Thanks,
Jason
