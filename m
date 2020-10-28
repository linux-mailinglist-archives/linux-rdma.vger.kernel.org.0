Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F14C829DC38
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Oct 2020 01:22:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731439AbgJ2AWb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 28 Oct 2020 20:22:31 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:1411 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388926AbgJ1WiG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 28 Oct 2020 18:38:06 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f9975bd0000>; Wed, 28 Oct 2020 06:44:29 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 28 Oct
 2020 13:44:22 +0000
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.106)
 by HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Wed, 28 Oct 2020 13:44:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M2uPTtg9NQHstNCgAkrl7j6PEqZ9W2KnGCTH3H+6+w9V4Grm6acGV1AwvG6CFti0FnjTZVoJgEdYQxW41cQ8ZMYv1/ECVIqQTcHHTugrTZEy/xfp1HlF2Tn3+wQOkghffjHjhaPX2C/1OJuAMYnqekum620oIDz4murtubX4ZXjfckoyM9UlQQl/0Ko+WbtVniPpbHyf/NAMR70V0JYEwVUkNZCF5TZNObJE57FwVeamDy3SAFYcNg/PzSn6HzuyyP3x3ar1UPhAymcX0Q7XYzRupOK1XrInCqcnLddZ32ct/FWZwvy13RBVf7ax8WFfVMsVZlBtT20md0Q93i8xhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P9QUyHpzQ2ndwW+DsNxJKwemH/MiGJeJBp23BtCN4EY=;
 b=DcIVyxgZBIBrwpXF9cBYZjWgzpGyyRpb9sokJ32IXt99jUsaw9Y8bsaMVMjLrZKeNqtqI2/uQATNMeU1J57QvqAw24YisYD23M0ZOYx7wwrYsAyOU2zOHO/UFNpsxkXI3HmlJwIzTtKcf08Iy7UJDVyjsqEq8lZ6wx5kmgRF2o/XRhrYmPUUvOAc06EvNwV/zkpFJwuD400I7YtdTishC/frFsbX4/kHvVwa4isYDq+fSgbMoiekqjXVBAYAphLKtrPdodEm2EjRzz1nW1S+dNs8UDgWRBTMAy++BOf6XNRmc9m4oDF54JWUf/L8dlJ0WtO41MnjLMbnkTRhmnFDng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3018.namprd12.prod.outlook.com (2603:10b6:5:118::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.24; Wed, 28 Oct
 2020 13:44:21 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3499.027; Wed, 28 Oct 2020
 13:44:21 +0000
Date:   Wed, 28 Oct 2020 10:44:19 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Jack Wang <jinpu.wang@cloud.ionos.com>
CC:     <linux-rdma@vger.kernel.org>, <bvanassche@acm.org>,
        <leon@kernel.org>, <dledford@redhat.com>,
        Gioh Kim <gi-oh.kim@cloud.ionos.com>
Subject: Re: [PATCH] RDMA/ipoib: distribute cq completion vector better
Message-ID: <20201028134419.GA2417977@nvidia.com>
References: <20201013074342.15867-1-jinpu.wang@cloud.ionos.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201013074342.15867-1-jinpu.wang@cloud.ionos.com>
X-ClientProxiedBy: MN2PR06CA0002.namprd06.prod.outlook.com
 (2603:10b6:208:23d::7) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR06CA0002.namprd06.prod.outlook.com (2603:10b6:208:23d::7) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend Transport; Wed, 28 Oct 2020 13:44:21 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kXlkR-00A943-Vs; Wed, 28 Oct 2020 10:44:20 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1603892669; bh=P9QUyHpzQ2ndwW+DsNxJKwemH/MiGJeJBp23BtCN4EY=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=SkuUZz9jO63f9R+NKuurPkS2iZQoQNJ23hSIKsxUae5GFAzfKxJH9ABibFslmRCwJ
         I2UKLgFFgeb3gV6P099vOiH02gdxEzRgmiX5kyPIFDuw2aAn9go3CNDs36uuAc99xZ
         QiAVZU5IZeEWRovsVzCdz4yCsVlg7tQkhvLwbpUarq/XC9IbfAZH7gV/PwyOvQkkaG
         LKdBB7+ffM1UARQ3dGAZramrUPWuXQKKcPSjkHAZA9xO85E3p9vzdf75exNvUITZyX
         Q2ENwq9tzzosF9/hPFGH1fDVX9r0zXIiLaGSKofC/5aA9mzs3uFpvlKQS+wOlJBzo7
         LW4R0QzLsVRVw==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Oct 13, 2020 at 09:43:42AM +0200, Jack Wang wrote:
> Currently ipoib choose cq completion vector based on port number,
> when HCA only have one port, all the interface recv queue completion
> are bind to cq completion vector 0.
> 
> To better distribute the load, use same method as __ib_alloc_cq_any
> to choose completion vector, with the change, each interface now use
> different completion vectors.
> 
> Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
> Reviewed-by: Gioh Kim <gi-oh.kim@cloud.ionos.com>
> ---
>  drivers/infiniband/ulp/ipoib/ipoib_verbs.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

If you care about IPoIB performance you should be using the
accelerated IPoIB stuff, the drivers implementing that all provide
much better handling of CQ affinity.

What scenario does this patch make a difference?

Jason
