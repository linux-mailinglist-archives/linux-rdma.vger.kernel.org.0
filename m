Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45FD02A33B2
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Nov 2020 20:11:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726337AbgKBTLp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 2 Nov 2020 14:11:45 -0500
Received: from nat-hk.nvidia.com ([203.18.50.4]:6634 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725927AbgKBTLm (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 2 Nov 2020 14:11:42 -0500
Received: from HKMAIL103.nvidia.com (Not Verified[10.18.92.100]) by nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fa059ec0000>; Tue, 03 Nov 2020 03:11:40 +0800
Received: from HKMAIL104.nvidia.com (10.18.16.13) by HKMAIL103.nvidia.com
 (10.18.16.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 2 Nov
 2020 19:11:40 +0000
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.41) by
 HKMAIL104.nvidia.com (10.18.16.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Mon, 2 Nov 2020 19:11:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XE8hNdKCe1U2uADVY6ORsIKJjuA6/pMaw2cbHhDLvpIolXYrPID96+SFmdvWQLV8DWi3/tZiepcnX5YW0o5MBVhsxHWF++hmSnBasne8RQwcKCIBKK3dILX7UtmK+FcCYkD4E8AlUDwnY6Oezq1zssjQrVfsaK76moOj0EQRU+/c6K3H44aXdc12xU6T1q2ga+ZRjuzOvbLe7T1SIAjzhLLwDcR4XGYnIcnPuMmzE6rUh5+9ODJWjx0CeyT2mYyNLTrjAgJ6G7oGzKR0DILd3v6VtGz46L+WTnfZI36osX1N/sQElClmgS0h5gqLEI+cEZAtpAS5BbDKjrzZhEPiJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VnGO6fsh8+QyfzpXOKxgwFG0wibTMdqZqGet0QwqhR4=;
 b=mzwxGHtO1m032BwqETPlZKX0cFFRqXZjODgZK7NeHYb2Y7031vcL8s2gaS2wGPD8ON7DwjBLyPq8iGP7NAQ+bABW07S4qS92pbGvS2g9O/fnXFQhPsBAh0VVrEa4mR+mb2fn0hpQlJNMRq2f9k9bg3i3jlHVNUcTJl4tTKnVIrAjibPoTR9NN/kpkP54KejN98F2NJr7p9j1nZ7hehCsRIvbIZUrCSCoebHzzLpkaar28FqXWT/61kZcSp8OR6pvU1XBiFga/3AvsuX9aJqHXndeXLU3OQ2XwYBG74C4RmDk1xidpT33F2F3suQsnQ/0lt91Bt7ZjdrICqFCdf0Jug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3516.namprd12.prod.outlook.com (2603:10b6:5:18b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.29; Mon, 2 Nov
 2020 19:11:37 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3499.030; Mon, 2 Nov 2020
 19:11:37 +0000
Date:   Mon, 2 Nov 2020 15:11:35 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Artemy Kovalyov <artemyko@mellanox.com>,
        <linux-rdma@vger.kernel.org>, Saeed Mahameed <saeedm@mellanox.com>
Subject: Re: [PATCH rdma-next 0/7] Use only a umem and HW page_shift to
 calculate MR sizes
Message-ID: <20201102191135.GA3701319@nvidia.com>
References: <20201026131936.1335664-1-leon@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201026131936.1335664-1-leon@kernel.org>
X-ClientProxiedBy: BL1PR13CA0112.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::27) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by BL1PR13CA0112.namprd13.prod.outlook.com (2603:10b6:208:2b9::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.10 via Frontend Transport; Mon, 2 Nov 2020 19:11:36 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kZfEt-00FWyI-Ep; Mon, 02 Nov 2020 15:11:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1604344300; bh=VnGO6fsh8+QyfzpXOKxgwFG0wibTMdqZqGet0QwqhR4=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=YQay+PX358s1PSaa4espgso1W79NUwZ2duhhxLgi3kO/hL+du1oN9MHjjcLG7+EwO
         4Az8eTGtHP/kU4AmctadRr69Lj7mMMovvrscUcINHUO4WZcHWTkzclcyJbT9/zNLym
         /rAsm69VdOdPJd3DWtgAGrL9vCL/HcpnINgRTKwe6o5DrCnUW13Y/57VOPH6DQQfQZ
         lkra3e5qMggOE9afR2jbL2DmwzoqDDCnY2mlS9CQAJaHEs8CKyRqegG/mFJFJuZiKV
         mHYNULFYTg2H68fUr3ngl0pNhU8Mxg/yrpa8OXfmDtbEXZ9in9smFr/sLPUMHpVFL+
         KOFJq0z0DYAog==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Oct 26, 2020 at 03:19:29PM +0200, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> >From Jason:
> 
> The MR code computes and passes around a tuple of (npages, page_shift,
> ncont, order) to represent the size of the MR in various terms.
> 
> This is quite confusing about what term refers to what, and overlaps with
> data already stored and computed inside the umem. Rework all of this to be
> more umem centric and use these identities instead:
> 
>       npages == ib_umem_num_pages(mr->umem)
>       page_shift == mr->page_shift
>       ncont == ib_umem_num_dma_blocks(mr->umem, 1 << mr->page_shift)
>       order == order_base_2(ncont)
> 
> By storing the page_shift inside the mlx5_ib_mr it becomes nearly self
> describing.
> 
> Thanks
> 
> Jason Gunthorpe (7):
>   RDMA/mlx5: Remove mlx5_ib_mr->order
>   RDMA/mlx5: Fix corruption of reg_pages in mlx5_ib_rereg_user_mr()
>   RDMA/mlx5: Remove mlx5_ib_mr->npages
>   RDMA/mlx5: Move mlx5_ib_cont_pages() to the creation of the mlx5_ib_mr
>   RDMA/mlx5: Remove order from mlx5_ib_cont_pages()
>   RDMA/mlx5: Remove ncont from mlx5_ib_cont_pages()
>   RDMA/mlx5: Remove npages from mlx5_ib_cont_pages()

Applied to for-next, thanks

Jason
