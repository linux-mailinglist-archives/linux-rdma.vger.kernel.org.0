Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26B672A33B3
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Nov 2020 20:12:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725806AbgKBTMC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 2 Nov 2020 14:12:02 -0500
Received: from nat-hk.nvidia.com ([203.18.50.4]:25662 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725791AbgKBTMC (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 2 Nov 2020 14:12:02 -0500
Received: from HKMAIL102.nvidia.com (Not Verified[10.18.92.9]) by nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fa05a000000>; Tue, 03 Nov 2020 03:12:00 +0800
Received: from HKMAIL101.nvidia.com (10.18.16.10) by HKMAIL102.nvidia.com
 (10.18.16.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 2 Nov
 2020 19:12:00 +0000
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (104.47.45.56) by
 HKMAIL101.nvidia.com (10.18.16.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Mon, 2 Nov 2020 19:12:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bZoiSFV9fRwTC186PlHN81G0pjRMpIOlEhi4gdcrLD5god9ynHRaBZOA0EOPrkNxJ/j7bxbgtkIgsX1RQJImlIcTHb7n+AZTiLxTcqLWJsTM4LBKt+h7Z7lFb6extEhUjzqkuFce46IhKRSqOC4y2r0lL/UH0yL6q+CwNPI/jomAFBRqaV60WFDDYkEEFnjEt+G/5kLLuSAD6Vv3nzFnKs+zVWy6lEc2ZKnb3DKZuLCzXAkFSRLzSqwd0y/odLbmXingZ5Hu7/Le8hGlMvYZKtams2Q52Tz4zOkKQzoyS9zxHjCmxn6ouQsD8TfZWRcmbwHxA/QHfTEDHi/Sw9+2lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vDxv8CV8iNEOoviNQiymFlLQwHEReobGekeWG+f2lk8=;
 b=WX+nFej3TmYY6u0hYZE4v1ECmRN8BFhjGCbIHLDYC/Evm6Ch0vA+M8jQ4BLJS717sdUPG2pbG5Yg/zuSGM4GNzEL7NcO0O+IUTg+hztbFjtn3VUiuwSxgbwERJXCSYL7gOfLbAKvHP6/UIkEPZbI8Q2qaInIVKy7ikMxW+rAO4AfjQX3JgbMyRLybOM6zUrhOP7rESzDpgyikTYcScfXBD4P3VN/CZN9Ho3uu3d8ww4udNrGS2nXfRoc+HlQucOLtY0ZJo7nd6wLTbEO7Dk8/9apRPaUVSHTK7NrHjN1KRDptg+0ZHv+yliw6Zve+RO9gCG5Pbr7iQIqxSkLcQegOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3516.namprd12.prod.outlook.com (2603:10b6:5:18b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.29; Mon, 2 Nov
 2020 19:11:58 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3499.030; Mon, 2 Nov 2020
 19:11:58 +0000
Date:   Mon, 2 Nov 2020 15:11:56 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-next 0/5] Use ib_umem_find_best_pgsz() when creating
 MRs
Message-ID: <20201102191156.GB3701319@nvidia.com>
References: <20201026132314.1336717-1-leon@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201026132314.1336717-1-leon@kernel.org>
X-ClientProxiedBy: BL1PR13CA0147.namprd13.prod.outlook.com
 (2603:10b6:208:2bb::32) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by BL1PR13CA0147.namprd13.prod.outlook.com (2603:10b6:208:2bb::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.10 via Frontend Transport; Mon, 2 Nov 2020 19:11:58 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kZfFE-00FWyp-UT; Mon, 02 Nov 2020 15:11:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1604344320; bh=vDxv8CV8iNEOoviNQiymFlLQwHEReobGekeWG+f2lk8=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=J5I0xJbwZlNnqKSlaoTWMc1DkWoxsY7abrekAmTu0/YxmO5BrG5DwKZXYYKgZu6vU
         h0J6ozHpvzhgxD7BAie/nNlmggINq/QB9sIBkM8Axrdq0yi9qvBmjWBrIpUW44A00h
         3PGt2j+eHebvtUa+KRfRgEeZsxJuwXnft1lbskZQioywuvbNoLXhyuCYfAx4h4ywAr
         75Y2esvHoU0+Kn0444Iky27t19a+++3tUMRXASIQXNZ/YtOLjmoR64esnW8T5zAPRc
         OwxFQ10KZpq8frRcircNyqFZsDrEsCeAoI70XvlsbwUTG1EPU70dgOF2tqvRV0GGeK
         DyfDbgja++HRw==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Oct 26, 2020 at 03:23:09PM +0200, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> >From Jason:
> 
> The new common code does a better job finding large page sizes. Use it in
> mlx5 for MRs.
> 
> This requires moving the MTT population for mailboxes and UMR over to
> rdma_for_each_dma_block().
> 
> Thanks
> 
> Jason Gunthorpe (5):
>   RDMA/mlx5: Change mlx5_ib_populate_pas() to use rdma_for_each_block()
>   RDMA/mlx5: Move xlt_emergency_page_mutex into mr.c
>   RDMA/mlx5: Split the WR setup out of mlx5_ib_update_xlt()
>   RDMA/mlx5: Split mlx5_ib_update_xlt() into ODP and non-ODP cases
>   RDMA/mlx5: Use ib_umem_find_best_pgsz() for mkc's

Applied to for-next, with the updated hunk

Thanks,
Jason
