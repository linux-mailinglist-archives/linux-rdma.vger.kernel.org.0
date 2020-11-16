Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEA822B534A
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Nov 2020 21:56:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730777AbgKPU4f (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 16 Nov 2020 15:56:35 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:18411 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730488AbgKPU4f (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 16 Nov 2020 15:56:35 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fb2e77a0000>; Mon, 16 Nov 2020 12:56:26 -0800
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 16 Nov
 2020 20:56:35 +0000
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Mon, 16 Nov 2020 20:56:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aq7NMtKu/GOqqQ4ylwi4ucyD4bmL4Q6+OqM9hxrN+7aKmpf1gNMyxYNQOQMjE3jKGIQvM56takaaByNy0MTZQ5yYJB3RR/eNh35He2gGC5gecb5V9FIdjSkFCefXD6tQg9OnUqCtHNYbEuUTPjmekd2G4l+Agjv8nqA1jGuTrDGfDMSnHaPaiD/yV/DfNI/raIhPZlJwz8nmFGPm1f2gkCOIGl8YrJMj/UQb868ddMHSwBwxBC674JhQwg+K8v0GBslwQpvLR4D2fxap9ayVeWNPMNYFQZ8AXvfrlwnUoAFpLpZx01CHJC+lVtnGU2f6Y7w6Bx5DZ8rDhsX0UyCuHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RqRIZRFRscV+eepsLfhQ3kKnBmV/YQC0pyrNZuCNF2I=;
 b=HtDy0vkG/WFr7ajWEP7GQ+0e3qWBkqzyL1xKN88kZRn2A2JefmTx7nriSKLTDA5HTeq8ecm8dqFrTOIY2ldU+ZiQ6iHHG9S/S9mFKbnLgwk4s3LUWYAiMseCY9juHMmsb4X3bVs6zbScNxVRqNVSUZ1mXOgPx7zVZgQ/EGpWgZ22vi5xaBsMzrB1OROfuAHoqRlAsxSleUSBtBwFpNgMHSn/voIuLCpevkbEBKeVXaoi2Go02PkkGMsT+w/8C4RIvXrPynpgl30RfdZXVpeSmbbVR9bKmjRQkCIignUf5nneS0v0T3fywDrUfFWh7wxEMD04R+OnvfYYbtVfJw+S0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3305.namprd12.prod.outlook.com (2603:10b6:5:189::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.28; Mon, 16 Nov
 2020 20:56:33 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::e40c:730c:156c:2ef9]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::e40c:730c:156c:2ef9%7]) with mapi id 15.20.3564.028; Mon, 16 Nov 2020
 20:56:33 +0000
Date:   Mon, 16 Nov 2020 16:56:31 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eli Cohen <eli@mellanox.com>,
        Haggai Abramonvsky <hagaya@mellanox.com>,
        Jack Morgenstein <jackm@dev.mellanox.co.il>,
        <linux-kernel@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
        "majd@mellanox.com" <majd@mellanox.com>,
        Matan Barak <matanb@mellanox.com>,
        Or Gerlitz <ogerlitz@mellanox.com>,
        Roland Dreier <roland@purestorage.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Yishai Hadas <yishaih@mellanox.com>
Subject: Re: [PATCH rdma-next v1 0/7] Use ib_umem_find_best_pgsz() for all
 umems
Message-ID: <20201116205631.GA1626752@nvidia.com>
References: <20201115114311.136250-1-leon@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201115114311.136250-1-leon@kernel.org>
X-ClientProxiedBy: MN2PR07CA0005.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::15) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR07CA0005.namprd07.prod.outlook.com (2603:10b6:208:1a0::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.25 via Frontend Transport; Mon, 16 Nov 2020 20:56:33 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kelY7-006pDA-TE; Mon, 16 Nov 2020 16:56:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1605560186; bh=RqRIZRFRscV+eepsLfhQ3kKnBmV/YQC0pyrNZuCNF2I=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=rs6u9K3a/Pw+GTCxFzuD2OL5sWiKUz3SYc/q+078Bm7CZTMmxjpk7dwIzOXsyybgQ
         9NnhLYxuyOqcEVb+QjoaDFXG/0zzXHE6JXC2Iji+bCSG9T74IcYRX3qEzwZyxzZr16
         6i4T4HQL1wUT+ODhr53Y7iJ7ut/WPQ9EzXM57zDLcZ4tt7yHehPbecIisruW9Irx4v
         d7KYaBrfcyn8TcgY7D0VyGGJr0B6mm3CUt10/32dNDrJrTnLpFUZeyk15G2pchs8bI
         HX/fllQxLua6YCs1jxNK3CBv11ZiRtIWv8flMGXTgcq49HuTBbg2TCn6QU1PIIT+dH
         NbPfdPIxtpAoA==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Nov 15, 2020 at 01:43:04PM +0200, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Changelog:
> v1:
>  * Added patch for raw QP
>  * Fixed commit messages
> v0: https://lore.kernel.org/lkml/20201026132635.1337663-1-leon@kernel.org
> 
> -------------------------
> >From Jason:
> 
> Move the remaining cases working with umems to use versions of
> ib_umem_find_best_pgsz() tailored to the calculations the devices
> requires.
> 
> Unlike a MR there is no IOVA, instead a page offset from the starting page
> is possible, with various restrictions.
> 
> Compute the best page size to meet the page_offset restrictions.
> 
> Thanks
> 
> Jason Gunthorpe (7):
>   RDMA/mlx5: Use ib_umem_find_best_pgoff() for SRQ
>   RDMA/mlx5: Use mlx5_umem_find_best_quantized_pgoff() for WQ
>   RDMA/mlx5: Directly compute the PAS list for raw QP RQ's
>   RDMA/mlx5: Use mlx5_umem_find_best_quantized_pgoff() for QP
>   RDMA/mlx5: mlx5_umem_find_best_quantized_pgoff() for CQ
>   RDMA/mlx5: Use ib_umem_find_best_pgsz() for devx
>   RDMA/mlx5: Lower setting the umem's PAS for SRQ

Applied to for-next

Jason
