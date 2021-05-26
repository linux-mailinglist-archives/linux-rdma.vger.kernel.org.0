Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3849439211E
	for <lists+linux-rdma@lfdr.de>; Wed, 26 May 2021 21:49:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234406AbhEZTun (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 26 May 2021 15:50:43 -0400
Received: from mail-mw2nam10on2071.outbound.protection.outlook.com ([40.107.94.71]:29153
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231924AbhEZTum (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 26 May 2021 15:50:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bgAd/tfCo2eJBc7rWVu754dgxXUHzBTfij+zbgi/av1DyaOSxCazhpLCQj8D6Ri3DtzOb3C3dDsm37BTvzStFpNaj7pADdQVa9ae2O+LHeqvOX4w2zl+YCZZQoZ/Sa/Udqm/iJyyBYMxUBLyfrAYtxBVx5NRlZiZ2asRMO5xpAOSKiYZ0RJkAIxNlQSfmw6IWVGi2n2Q0zEjHpU4AOqySM4yf/ltAHFv2CL5xUI1NqxifUkkKwDKlNeM6qjSpjg30ciykLtsUDUpGDP1BIKJyQFlEipn/Q8HDjQkzkNhC8dHy6z9GifY+9ko6QT8JKq2iWk5fyatmGDD7cohP4JxoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t4LNgDHxJIIKAhocztp0tDJaP7WOUQoU6iIzfhbHGbE=;
 b=keHt66ZKdVswsO64gnwy4VzV7nrCkQ2ryAdFApRS8+/DT4qEoN9zykZc8SLb8/sb7KrePqMim/tIB9xJ/Ex16/eW05wsehxkL8UzYjNWyo0D4wWC1/btB5eRMqwhB+MDlCc+LLce2jKlZx2J59MOvexURP4wRFa+cy5u0h01vZMKRoKJtlFUblXAHs/XT0TPeYeqbAlUw6xehQiIdDEW5fP1+0lnx7ApE22AYoFevqhM3nurJbmDdi3kFYI7v6I519hq/lLXvdttaaF3oJAu/4pcwAIOPi0ge38ug+O6w15v5Pawu2MVVOwhS7Hnm5FTZoepmnWrfLaR99jAKMt58A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t4LNgDHxJIIKAhocztp0tDJaP7WOUQoU6iIzfhbHGbE=;
 b=QYcURN+bJY/zjjNBec4vKUo145/B+kxtPkud2zY9qxl1H1yvLeGbfmSQrIM6L/UHEfRiizzAfuDCYs635ZO+7aWisP3I4pmyVBh93r3RHjOgZ2qiLAmNCKPFDqgolagzoTdDYQ+nvUKfPfpCOOfvTuBKtk4WHPZMiamy4LtTv6MKmXaLHt97q1jyKBaOH1kAyPn0plSw0w/i1wg1taho0IbzPTfALb0urkCQrzN1cFWTkXP44M5FaLE5yu/qlzslEgHBiox4ck0+EjR5aQPACcSqHtq3vGY6OQAleJvGV1YuyvkoGAsTeayjhlWublJPH4D+S9hL9LHAffnNeQoEsA==
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5272.namprd12.prod.outlook.com (2603:10b6:208:319::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.21; Wed, 26 May
 2021 19:49:08 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%7]) with mapi id 15.20.4173.020; Wed, 26 May 2021
 19:49:08 +0000
Date:   Wed, 26 May 2021 16:49:06 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Avihai Horon <avihaih@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next v1 2/2] RDMA/mlx5: Allow modifying Relaxed
 Ordering via fast registration
Message-ID: <20210526194906.GA3646419@nvidia.com>
References: <cover.1621505111.git.leonro@nvidia.com>
 <9442b0de75f4ee029e7c306fce34b1f6f94a9e34.1621505111.git.leonro@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9442b0de75f4ee029e7c306fce34b1f6f94a9e34.1621505111.git.leonro@nvidia.com>
X-Originating-IP: [206.223.160.26]
X-ClientProxiedBy: CH0PR13CA0020.namprd13.prod.outlook.com
 (2603:10b6:610:b1::25) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by CH0PR13CA0020.namprd13.prod.outlook.com (2603:10b6:610:b1::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend Transport; Wed, 26 May 2021 19:49:08 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1llzWc-00FIeQ-Uj; Wed, 26 May 2021 16:49:06 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aa95c0d9-6481-4d0d-8979-08d9207f536e
X-MS-TrafficTypeDiagnostic: BL1PR12MB5272:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB527207DEABB7BC900B3CA468C2249@BL1PR12MB5272.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Rxb/jQYFoEVteHyKCTX1JX6pEovuPUwUmakyasiT0O9mfehkLUJpL/LfGSHTjDaD/QIENwMyh1xeSN/Dy223RPVAVIZC/6d4URu256jPKuHdH1fl7qQihVqxkX32sKahrVKNn2JeMudHl4QIqt3aTmS0IY8LDkqhr0hb6WLygcnQ8T4Ij7NkOIJj2Mc74GpzjLQC22iF0PraWqUJ7cpEhXEyIXVXcByancu/lP5BmmjXxCHmG2vQhXV1ik6QMvihWJ4ogxesv8OEZUiKODZ/gtHyzWYgH3Hek7uAe7ip7SsoTI7J3dz0ZHHvVqda69t+Xgk0G6VlzLnvi8Bf+5g0YuOGrd2NGMoK2Rc0L6rpaR9jKBzHjPkgoato0PYc1z8KdSRRI9P3k+xczHXefPqYIVllfKWFGwXTkAWr4kTz1VyGRwxQF7BkEh0Ic0dXrdG3yqQHpIR1PaT4o5OLg7NzPvYVUoc1jlYLd5ompWCoKcf9LFSF/XLZwJ2nG25B3zU/eRUkyNLdgMLRNR5edgh75oiVnvblML18oGImSRFeUUguRCrEokgiOrvsY5yoh2E0nmXBirTsF1VyGgSMoO7AGNDM/3VSZUi0ifrgjmNoflw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(376002)(39860400002)(396003)(346002)(186003)(6916009)(4326008)(478600001)(26005)(426003)(8936002)(2616005)(36756003)(8676002)(38100700002)(54906003)(316002)(2906002)(5660300002)(33656002)(86362001)(66946007)(66556008)(83380400001)(1076003)(9746002)(9786002)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?QmQcHjCTec/lg6cvRET+xQ3AaNmKEmajR9FoAmJZpoPxpiAN5nxqywi6ZMmg?=
 =?us-ascii?Q?q5ed+Js1NECM3N7j+TaClOzmv5DfagyxRLSn0sCQ3ZXecLqO7+KoLre9J7q0?=
 =?us-ascii?Q?JVkR0xklFNyOgJ3ZboprfqQZlF3mB2F4Z/aPME8PTlZNVcTgSQleyzL6gaXb?=
 =?us-ascii?Q?XQm2hnja0CbVAen2hZq9X7dQUG79ijQ9t8V0gPOPUCBIwBiKUZSISdYccbIf?=
 =?us-ascii?Q?rPM2Me6sZ0oEWqKfCtnWHDo9cjQYkEkfgdTOI7NXkZaOKxEp3IAmhw/ed3wy?=
 =?us-ascii?Q?Ji7NxorFAYeqjrmJ86DybYcQnOvSDidxQQgPSt6FEAwnkwPNQLAqza4XjGGh?=
 =?us-ascii?Q?4BPr4mXQOqo67NtmYGmC9p6jz37V3DTS496N7c3Mqdgn+oDygOkA/D04zYKt?=
 =?us-ascii?Q?Tzq1ZrVLO/7I53VsCRrGap6vBIGCUyp9TeLJttl+xErzrPQZUDRdlVAW37wV?=
 =?us-ascii?Q?rveYvqf+UKn2Fhzqb/sfLQOftWo3xMwKrYGRpsneHReT5r9yQzXUZbpuNs2c?=
 =?us-ascii?Q?mULQHOU8i2dnLmdkii1uTi2EyZympIOJKlDXf/iy1Gjwb+etb8iaw5GkZ7dv?=
 =?us-ascii?Q?najHjnT+q0a+IHCm533RwTQ2y0lihVchTlIZATh3tTi8SceUlh2Zb4gnHpUq?=
 =?us-ascii?Q?MGMc6pzNCQtecUu6klO0RxtdnmxSBtMDZYly6Bf0wiKIiKmyN1B16J4QRS3c?=
 =?us-ascii?Q?Xz9G0kNgHCZfzKvt2rzNq2uminJe9UYqd6h6955/PkY5ZwuqplM/Xf0ERj33?=
 =?us-ascii?Q?FevlHzzsMlimiZ0N8TOqFnAsef8bOE0Td19cd7dGHo5yi8HlxbMgTLWKtXP3?=
 =?us-ascii?Q?VHs8Rq3a/K0EH020ahxPOk+suS/ElEfDtXYO6KNKz2wTHQfobMGQp4UvCaMm?=
 =?us-ascii?Q?aV7jUfNPx0cEGXj8MRJBf56zof+tMl/TyB/snVoNIAs6Op4Q6pqSpwUElKTP?=
 =?us-ascii?Q?U5JUchC8HRMdXmOvnGwzvESBx4rFvryS1OTv/0hDWFxzy2sEIsV8K33s42Nx?=
 =?us-ascii?Q?L+t383K71qeJvnX13M/2vIcf2w2PhWJRe7PtDnkFl+AOEOZxZjaEsus1pTwu?=
 =?us-ascii?Q?OZ4f1MI1QONBM7h8hytotlLBn4l4sEzCH2E9dYbcz9uOWJBmR/R7Hc4ii8Ve?=
 =?us-ascii?Q?PD/X8s1oH+RP6tvhh2otyvz/7+RnOXMm2J++NWTeHDEO9gWTk8kB4J+yUV7p?=
 =?us-ascii?Q?BaUoDHVawV0cChqJkK2cThGFzYcFv8Hc4FkPgiKCsXqI1ce0IbDWDXmmajJw?=
 =?us-ascii?Q?wB5iJDV384QVeGccz+W7+TU+jX+3M+X3g2d0sC5WtRsWLPDrDy00vF4XtTg1?=
 =?us-ascii?Q?3TZo3M+BIse1aN0SuFlhbUp2?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa95c0d9-6481-4d0d-8979-08d9207f536e
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2021 19:49:08.3369
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wBLyXv/imqu7GGeyoR+adiru/xwytf/G63IXOfzdq1HZv1J0Ak5qO1/3C0BMa5kE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5272
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, May 20, 2021 at 01:13:36PM +0300, Leon Romanovsky wrote:
> From: Avihai Horon <avihaih@nvidia.com>
> 
> Relaxed Ordering is enabled by default for kernel ULPs, and is set
> during MKey creation, yet it cannot be modified by them afterwards.
> 
> Allow modifying Relaxed Ordering via fast registration work request.
> This is done by setting the relevant flags in the MKey context mask and
> the Relaxed Ordering flags in the MKey context itself.
> 
> Only ConnectX-7 supports modifying Relaxed Ordering via fast
> registration, and HCA capabilities indicate it. These capabilities are
> checked, and if a fast registration work request tries to modify Relaxed
> Ordering and the capabilities are not present, the work request will fail.

 
> @@ -762,23 +786,33 @@ static void set_sig_mkey_segment(struct mlx5_mkey_seg *seg,
>  	seg->len = cpu_to_be64(length);
>  	seg->xlt_oct_size = cpu_to_be32(get_xlt_octo(size));
>  	seg->bsfs_octo_size = cpu_to_be32(MLX5_MKEY_BSF_OCTO_SIZE);
> +
> +	if (!(access_flags & IB_ACCESS_DISABLE_RELAXED_ORDERING)) {
> +		MLX5_SET(mkc, seg, relaxed_ordering_write,
> +			 MLX5_CAP_GEN(dev->mdev, relaxed_ordering_write_umr));
> +		MLX5_SET(mkc, seg, relaxed_ordering_read,
> +			 MLX5_CAP_GEN(dev->mdev, relaxed_ordering_read_umr));
> +	}
>  }

I don't quite get this patch

FRWR can only be used with kernel MRs

All kernel MRs are created with relaxed ordering set

Nothing does a FRWR with IB_ACCESS_DISABLE_RELAXED_ORDERING set

So why not leave the relaxed ordering bits masked in the UMR for FWRW
so that the UMR doesn't change them at all and fail/panic if the
caller requests IB_ACCESS_DISABLE_RELAXED_ORDERING ?

Jason
