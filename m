Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 080753B05B1
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Jun 2021 15:18:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231215AbhFVNUf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 22 Jun 2021 09:20:35 -0400
Received: from mail-bn1nam07on2075.outbound.protection.outlook.com ([40.107.212.75]:22147
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231196AbhFVNUe (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 22 Jun 2021 09:20:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lZbgFLcLSjPqCIv0mpVBXADJfod9SjiLXs5WZMaA0PWtnawn8FFOrPLbwIY85UOiPBTxqOHa9hcFxFJT5m22OZ9cmmedMMW9XGpsYvMO5iVrfBUeNGHuM8/zp8OTbZJjYH6A404PuevJzRhVI+jv1cKoAiH+xl2Q0XJD9+mcNHa2lk3h0qzWgOZEaZQ14VSRm7PSbwxCgkh3cqS5Q9H0NGp9yTWjR+dxFBF6ZBJxyh8xYXCGbhDlREpytY+yYK2r8p43jxc6S9y3fGAir9IspjVKfRROCjC0BrBTnNheV8uvL4ZhTAZg2ywW0kOJnYXJp7tzcWt/mC4FILD0y1bqwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xDpupHegn3KpEGGglJTRV8TpXXjmtEVC7KoA+/7CSLg=;
 b=U0XMQk5fj8l3ux926zZeZJjXkKOuzaN8CI333IM7WHLq3NBqBb46o1vDz9RH7NV4k/4JWWpRS3StXukT2DUMEQ1jjvLfClPHIT22pELWQ/3snPh/eC3tgkvM/MSu0GcT0Xz7U29rIHfTtLMWL4yDCop3UbGy052AvxgxsTV4046CcuXbSEfhlSw3JTGhjwrwecMmDF7ntGD8hXABtRgCsoH20ljCpwOMC0QTle8dAWjoITKuHZfsE9/K2DXOon6FK29+uUQb4lbbcCjJpKeUlPYHFZaf6oaEm9dJmCiEGhaRLmqBnoce9PYBh0Fgl8HKNpgkrnzvENB/06eGJDzdng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xDpupHegn3KpEGGglJTRV8TpXXjmtEVC7KoA+/7CSLg=;
 b=Z4WArYf9Xyudhl9tvUzOfPwR3/YHyuxT5uvlh8ZUqZtqo2AxPMMOIxcmI44uzXI14HHMuBOeJhCM3abbliQLnj6DrweRw27dc7rnx17BLfNvnMLOak/k72tXTmdJRD4SGu2Uh6jHU1cVaofkRbP6C2Q3C1CVoyBGACwzgrNEgCY9ZohEyQx5MHPN5eamIQs0w6vPYsbij9ZsawZK2b/DwzyObZ8SWA2unziRXHlo518VMLCR6WQf0D2H6ykITMsZXjj8PekDgkr4lFnidFx2XDF4pcwIATYorz9+YDrVIOwXexLk7Dtw60hBdGd2ES4UBNEVO4C28O7gM36/h2f2Mw==
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5320.namprd12.prod.outlook.com (2603:10b6:208:314::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16; Tue, 22 Jun
 2021 13:18:17 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%8]) with mapi id 15.20.4264.018; Tue, 22 Jun 2021
 13:18:17 +0000
Date:   Tue, 22 Jun 2021 10:18:16 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>, Christoph Hellwig <hch@lst.de>,
        Maor Gottlieb <maorg@nvidia.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Yishai Hadas <yishaih@nvidia.com>,
        Zhu Yanjun <zyjzyj2000@gmail.com>
Subject: Re: [PATCH rdma-next 2/2] RDMA: Use dma_map_sgtable for map umem
 pages
Message-ID: <20210622131816.GA2371267@nvidia.com>
References: <cover.1624361199.git.leonro@nvidia.com>
 <29b80ff0c32675351c0a1b2f34e0181f463beb3d.1624361199.git.leonro@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29b80ff0c32675351c0a1b2f34e0181f463beb3d.1624361199.git.leonro@nvidia.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: BL1PR13CA0294.namprd13.prod.outlook.com
 (2603:10b6:208:2bc::29) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by BL1PR13CA0294.namprd13.prod.outlook.com (2603:10b6:208:2bc::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.7 via Frontend Transport; Tue, 22 Jun 2021 13:18:17 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lvgIC-00ABDC-B1; Tue, 22 Jun 2021 10:18:16 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4853f144-c70b-46fd-bf47-08d9358032df
X-MS-TrafficTypeDiagnostic: BL1PR12MB5320:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB532035976E3094C7BF14B770C2099@BL1PR12MB5320.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:57;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m69mmSo05b5UUDseDKl9Pk/J8ROVmO3knjtLjsklhEzW/GYBnoBRRkwYlTzr6qq9fYNcW4ou3RRsDBWHxTguVCSl5jJbZc8EX0QDQGcGur+VZegLswwGpJWiy6taFOUzYJMv/ZcSZa+9fwcoxhtspwXFLvKYg7OJ4L2rmBgeKaFxz0lg2GJSEAmJM6ZMVZ2c2tVSPWbYzilIdXmwqU3WcetK6iSJr4FM6GQyOik2PMzMKapL8DBAsvYCQEdkzghKWsiDQbH3VfuOkyYzjNqGksL/a9InfW7uKXaUfClIxPpOTdeK2ej3ez4p5HqArFWdVRoo5VqbToaJ6051V4oJG/bZkD0JvwdDjsnDnwNs5uBJCRq9j+Fx0SmLbfUKBtzBZnAZQ6iOe4kvKyH5kEnVj2hlS34ufo5gBGRyuunhgEOgZAxwdWfqMzrnhTfj1lYZfHfi/BMjS+CyONK5gneFS89ABmPE8eoE6oFIuGG4/XdaF29RbsWhq9YFJcImdsI3H5hfgKWl25gDkOnzgK9Am6zrRegOHiyqdhBsBlGa0r1Mx8KWDcfaXWZ5uyYcASBSsgYyape6gvOF887qwH+qE5Zm02r3Q6xUfHLeQw7FEqE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(396003)(376002)(346002)(39860400002)(4744005)(2906002)(83380400001)(4326008)(38100700002)(8676002)(5660300002)(66946007)(26005)(66476007)(186003)(9786002)(8936002)(66556008)(86362001)(54906003)(9746002)(6916009)(36756003)(426003)(33656002)(478600001)(1076003)(2616005)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FJdelhvsleUrXx2SKBRIvfOytSIpz54cpYUYAlLBs5jaqaZ2gUIAqRcZqsGg?=
 =?us-ascii?Q?GpVApxmJT5hMYY/1DCCTrZn0iAYdaOboHvXl/EOwBJiMp7VRxyBTAU9DfJGQ?=
 =?us-ascii?Q?5B5Q0tXQrP4/2ipukjbKoEEKmBRE7D76qwQW+t2scWZ2mXY7WXTy4SfROZzi?=
 =?us-ascii?Q?xZbAUUpPqcTObKpkLrE/vGwGldP/8bfbDf6LjkmazQ2Y/T2GWWY/8yMKpJsr?=
 =?us-ascii?Q?LYOWDdNX2SlEHDcY9sW1C/V0f7OXvZa1N4gpakrcuQR5TdwSgAluRtBZaoYe?=
 =?us-ascii?Q?lCVqVgfOCTBZ7nus2LSMiIVo8eloPFXm1lj4zsKsnXjAKT8rLfzuYUKiorBl?=
 =?us-ascii?Q?1jVv31wJkAR6ibQvRXk01hfzPQB7Vdn6jblsj63mSCOvpcAH5Uxedx3W4Swk?=
 =?us-ascii?Q?oWBn2zrq1/NgqpO17mH1BK7ZCYSrq9rady+Xmyu5U9EqUYMOkLq44gOrGevT?=
 =?us-ascii?Q?S98bVhMPQGajdwl/dftpmzQiyB6R3T3+ffIyfVfgH6ijRyH/8r7dW+O4VZcZ?=
 =?us-ascii?Q?pX6RixdDYQ9iKfOijJEU6O6zWT3rQxN7C224qMWuXxMZNuaQS7lTcc7jkJ8T?=
 =?us-ascii?Q?YL9B8iw1pLG+URDX3gJki0p+xuPMy/fz5/YJRiVfgINr5H1NoeCws9zYSnNY?=
 =?us-ascii?Q?6Nxsnr2zG0PbAHRs0htvjloeuGNIL1zRVoUTSAAFXi1lmOAa4sB2mjKv//pl?=
 =?us-ascii?Q?xzQE2rF1EqOVtJvB+0VEY/3dU8qBYrXdhU9eZy7KWvgBH+1CYFv0Jkg5+bGG?=
 =?us-ascii?Q?t/gzQv0MW0J7S9ZdHXyRDyqEDyHIGvvEPPlwejlq5m2gYgMEc2WwlECajOtD?=
 =?us-ascii?Q?W3r9hbLsJ6ybSKbVElox51EZu4bvIQdQvSGdSnL3feBGJ6KKTgcfzbsaVWvt?=
 =?us-ascii?Q?V1WICm1VgGHF52oC7KdbIhqlb5SfX6PrGtxE2+N0AKcmGnK3kxHBssVGzgF0?=
 =?us-ascii?Q?+W6npslWXyaAJQcZTArG+pWnFCgrRXPqC605QInhKhZA/CFqIlk2BREqGBRo?=
 =?us-ascii?Q?asw0gDWzpHFhOe6vOk+bkx+7jkgURw/C6OV0nFTAVAfbhdMK0QmkwIWFCXno?=
 =?us-ascii?Q?SiKcamnxaS8MlLpbGDeQopvM9XD+mx5pjlgJ9hZ3v9F9PO5vfIuypMz0Wkxj?=
 =?us-ascii?Q?PSfqmrxAe+A6bl6AvC1Q49+fkGq5KK4jIH9jHh48sx6b/fDia1m/92hhi81x?=
 =?us-ascii?Q?tKfgxbjUdwLGMbxLedidyuNlJr3TR/rBLih9h2GWMsJy0QVsl5HjoKHIN1gl?=
 =?us-ascii?Q?b9YUjDOtFJ/HffYtKqn1OjilB+iUGgpzlphwMZbol9BOK4Z/Cd6MkbBYI/kg?=
 =?us-ascii?Q?3+Ei8SZIz65l0QuSKiWPX9r6?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4853f144-c70b-46fd-bf47-08d9358032df
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2021 13:18:17.6978
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 04G2FdNu4lFMwtC2s/jWvpxQle7TZkr1Yx4FerF23J0T22Ws7E6/MQcJ5lPnSoTC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5320
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jun 22, 2021 at 02:39:42PM +0300, Leon Romanovsky wrote:

> diff --git a/drivers/infiniband/core/umem.c b/drivers/infiniband/core/umem.c
> index 0eb40025075f..a76ef6a6bac5 100644
> +++ b/drivers/infiniband/core/umem.c
> @@ -51,11 +51,11 @@ static void __ib_umem_release(struct ib_device *dev, struct ib_umem *umem, int d
>  	struct scatterlist *sg;
>  	unsigned int i;
>  
> -	if (umem->nmap > 0)
> -		ib_dma_unmap_sg(dev, umem->sg_head.sgl, umem->sg_nents,
> -				DMA_BIDIRECTIONAL);
> +	if (dirty)
> +		ib_dma_unmap_sgtable_attrs(dev, &umem->sg_head,
> +					   DMA_BIDIRECTIONAL, 0);
>  
> -	for_each_sg(umem->sg_head.sgl, sg, umem->sg_nents, i)
> +	for_each_sgtable_dma_sg(&umem->sg_head, sg, i)
>  		unpin_user_page_range_dirty_lock(sg_page(sg),
>  			DIV_ROUND_UP(sg->length, PAGE_SIZE), make_dirty);

This isn't right, can't mix sg_page with a _dma_ API

Jason
