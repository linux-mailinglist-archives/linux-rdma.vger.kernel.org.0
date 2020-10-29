Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33A2129EBE2
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Oct 2020 13:33:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725765AbgJ2MdV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 29 Oct 2020 08:33:21 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:51630 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725601AbgJ2MdU (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 29 Oct 2020 08:33:20 -0400
Received: from HKMAIL104.nvidia.com (Not Verified[10.18.92.100]) by nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f9ab68e0000>; Thu, 29 Oct 2020 20:33:18 +0800
Received: from HKMAIL104.nvidia.com (10.18.16.13) by HKMAIL104.nvidia.com
 (10.18.16.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 29 Oct
 2020 12:33:18 +0000
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.103)
 by HKMAIL104.nvidia.com (10.18.16.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 29 Oct 2020 12:33:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N98KTbcbqtgcmfljQBgx1FJ9h4SsnxpElSkv+lev3MeH0RZpOwnwDj6yemhG1n5KhYDM/kjAOX0itfaLF2u2x0SyuTpt83ogw5DhH48tAnsqrgP16aOYng7IkD1x9JcoI3X4D/8tLcp4eLlg/3PsCkhC2hPRhvMp3vVH8Nxs+w3PRoL81R9m0VQ/PVwOuZaQSFL1LaOxftRrFTkkPGcQjXtkXCcHXVFHQjD2rptKBv1vr/NdCn+he/lQ8eC+XUmTGbbjlkodTB+njWMQAfaOdmEAqtLqToGuYzpyIgeV3heIsm3kYKywYNranG4vBlJXoyeoVZb3pKvvEOPQUQlMaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LroQqwVfbQDZpAi4KvDfZvtrEy62Ie6SIUPaV42tIj8=;
 b=UUmV3SHHQJdYujtuBk7IFhTFi//c834iXuW4qDi6BsSONp1KyqVmjW6joMgGQTepbngGixNomzdjqsnVz2r1pAMO88cEuvzHWaLPCU4ZiQf/MEO2o+EfI8nx5+sdE+jeBLOCwnkmS353pR9a/uro4MY1jgfc4DX1mJdfcaEwilEwc5VHZdKcQlXmj8GRRYr4QH+lKllXQh1/saN/qNnRlUC46bUzi0NsXTryzL0BuBhtFRomZcltyIw2ujYIO0jyFaDxfVSoMb8YV2fF4rG7uzaRqqRn4RjX5ooYb8EqNOn2jmA6g0PutHSwAH76ERIxP7FSD/IJtIdIsar2qLEqDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4943.namprd12.prod.outlook.com (2603:10b6:5:1bc::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Thu, 29 Oct
 2020 12:33:16 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3499.027; Thu, 29 Oct 2020
 12:33:16 +0000
Date:   Thu, 29 Oct 2020 09:33:15 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>, <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-next 4/5] RDMA/mlx5: Split mlx5_ib_update_xlt() into
 ODP and non-ODP cases
Message-ID: <20201029123315.GA2727747@nvidia.com>
References: <20201026132314.1336717-1-leon@kernel.org>
 <20201026132314.1336717-5-leon@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201026132314.1336717-5-leon@kernel.org>
X-ClientProxiedBy: MN2PR16CA0010.namprd16.prod.outlook.com
 (2603:10b6:208:134::23) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR16CA0010.namprd16.prod.outlook.com (2603:10b6:208:134::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend Transport; Thu, 29 Oct 2020 12:33:16 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kY77D-00BRgq-7K; Thu, 29 Oct 2020 09:33:15 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1603974798; bh=LroQqwVfbQDZpAi4KvDfZvtrEy62Ie6SIUPaV42tIj8=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=SVh1Wk38uQqpoMcybCCsnQUgX0xSV1PgXKneAdHs+S40Jq3IO85ionX4Qnodqx8+0
         eonWVnB1Me9NdsopK5GTEhwojIW+5pBAVgTr9gYEbzEDsWv6TwkmtoSVSyCdbzb8H5
         a4de2TftPussA/dO1B0x/lhStDG6c2zdZpXnx5u80ZvcVdkAzr3KAeLWbKdgPobDwS
         H7zu6P0TZNmIBE1tdrf+hquAX6d5DymV2z5Fpvg+Sm4AcaJkwP69SZ5CultEg7iI6Y
         FWlfShZVLkBx1n01d7TUEn1Q6lE8FK3Q3H5GXQu0nnGCK5kG67JAwI+KwMTlcjsiO6
         6mjIoOS2zFlNA==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Oct 26, 2020 at 03:23:13PM +0200, Leon Romanovsky wrote:
> @@ -1483,10 +1540,14 @@ struct ib_mr *mlx5_ib_reg_user_mr(struct ib_pd *pd, u64 start, u64 length,
>  		 */
>  		int update_xlt_flags = MLX5_IB_UPD_XLT_ENABLE;
>  
> -		err = mlx5_ib_update_xlt(
> -			mr, 0,
> -			ib_umem_num_dma_blocks(umem, 1UL << mr->page_shift),
> -			mr->page_shift, update_xlt_flags);
> +		if (is_odp_mr(mr))
> +			err = mlx5_ib_update_xlt(
> +				mr, 0,
> +				ib_umem_num_dma_blocks(umem,
> +						       1UL << mr->page_shift),
> +				mr->page_shift, update_xlt_flags);
> +		else
> +			err = mlx5_ib_update_mr_pas(mr, update_xlt_flags);

This rebase looks a bit weird, this whole block is !ODP already, so
why is there an 'if is_odp_mr()' ?

Should just be this:

	if (xlt_with_umr && !(access_flags & IB_ACCESS_ON_DEMAND)) {
		/*
		 * If the MR was created with reg_create then it will be
		 * configured properly but left disabled. It is safe to go ahead
		 * and configure it again via UMR while enabling it.
		 */
		err = mlx5_ib_update_mr_pas(mr, MLX5_IB_UPD_XLT_ENABLE);
		if (err) {
			dereg_mr(dev, mr);
			return ERR_PTR(err);
		}
	}

Jason
