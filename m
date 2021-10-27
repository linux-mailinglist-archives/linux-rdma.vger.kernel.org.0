Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25D5A43CF1C
	for <lists+linux-rdma@lfdr.de>; Wed, 27 Oct 2021 18:56:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242992AbhJ0Q6Z (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 27 Oct 2021 12:58:25 -0400
Received: from mail-mw2nam10on2088.outbound.protection.outlook.com ([40.107.94.88]:10144
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S243121AbhJ0Q6N (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 27 Oct 2021 12:58:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YJxv7bWcSD0pHpO89oGMylLmEy1EgqkosOtBcsQ9isydnRfcFUUN1VDmCQ9kZpiOaHPts6v3xV8/2oNlD3P2R8t7URJU4gxU0PYpo4E5FMUdITM/hijA1TH1PVPzDwlz44GPhEvnEr6wi6B3SMhY4I6WuNxxDXgNus+UZJ+tXyGsF2wmEvwplTKSvHYrZXOwDfkjRG/DWIy8X6oa+ZeNJ0eK2MsZbEpJktDuRL8/6ulLfdcmjYLFPLAc1uzzjQi1B/kM2Rho2qAI/8/c9C+1He4pn/+kC2AeRZGpxoQDeiju1tOnTQa21k8tJWBYwro1CBmonR0eIUXdGyN4ra+QjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SeLpVe+iz5SRm5G1uJTMUBuKuHxPwtbwk7ZmdaA5Ipo=;
 b=GKMNd/F6z1ip5irlw3YTpTnWdCqgV2QirXCC9KIlFjb/eXDZhjkEJvZeUK0WAWTBwW2uwoP94Yrn1X+rY8VNciId3sNkXoN/ozr+KN5BYh+tJtrtm7ujids+0VeOEgRrjwSkuvU9MdEqu6h6/4sKyS1HlMgEnFhwywraj4LJnxaj9c8znkcsOnhV1H3gPQnc/uGTf9tdUco4Sy7aEG3KugZgw/GpEAbB5craFa744awgdZXg69E5xCcf9qG5MhyVXt7wHVGGJEU6UzJKQSV48pH8b3dy4/k8ay6Tma2gEpXs9mJ6uZ8kodBL4+9FbD52DLkXG0IsFekwjWkBCDrn3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SeLpVe+iz5SRm5G1uJTMUBuKuHxPwtbwk7ZmdaA5Ipo=;
 b=g8SCx+jM5wWmLVDwdqmMyeRLB/bdU8QN6+qQzQRf4jA+U8jwMnckj5LoePOsyDMyEdmnmGCy2K5DioD6szV1EwRP1do0Rg0BFGPYWsviVSjiuMw1ezCljQo8Rxzq+mzRAwH2n7jXRjHR9snRuP+ScYnBuRmHtLL2n4ZTzAC6t1W6YzhF2DzoFYPw+lobfhRVMq93HqgoP9HCpqhDbcNWUkHFmjNiV63aKW3jv1nYdHQLgthrHIZ1uRVeloKJDzPZH5vxpDG6Q4dVUNXW9JPAxjWQve8FiBxCVG3w149MMlNrUy2vmb/ksyO9pcCvrccuE9S5joyMpIj6BfSE4m5Vvw==
Authentication-Results: perches.com; dkim=none (message not signed)
 header.d=none;perches.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5253.namprd12.prod.outlook.com (2603:10b6:208:30b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14; Wed, 27 Oct
 2021 16:55:44 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95%8]) with mapi id 15.20.4649.015; Wed, 27 Oct 2021
 16:55:44 +0000
Date:   Wed, 27 Oct 2021 13:55:42 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Joe Perches <joe@perches.com>
Cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        zyjzyj2000@gmail.com, dledford@redhat.com,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] RDMA/rxe: Make rxe_type_info static const
Message-ID: <20211027165542.GB644080@nvidia.com>
References: <2c42065049bb2b99bededdc423a9babf4a98adee.1635093628.git.christophe.jaillet@wanadoo.fr>
 <166b715d71f98336e8ecab72b0dbdd266eee9193.camel@perches.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <166b715d71f98336e8ecab72b0dbdd266eee9193.camel@perches.com>
X-ClientProxiedBy: YTXPR0101CA0050.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::27) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (206.223.160.26) by YTXPR0101CA0050.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15 via Frontend Transport; Wed, 27 Oct 2021 16:55:43 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mfmDG-002hZk-Hc; Wed, 27 Oct 2021 13:55:42 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: adea8e9a-8b1d-4623-a65d-08d9996a9da2
X-MS-TrafficTypeDiagnostic: BL1PR12MB5253:
X-Microsoft-Antispam-PRVS: <BL1PR12MB52536C8312275501092472D8C2859@BL1PR12MB5253.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2449;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 88lJdtpF4jmlxh3bzq8Rj6obm4uOFwcsSDDH4NWkyYrjefLTCYuQFhhDNdXw7I2rSN/7zYBarDS+JcEQ7UoMOd/6YAV8S4yRLaz4eweC87DRIJcAjCbPA1RQDTp4YgBFogBO+V1PwKrTwOz3YXYzy8LfnpW4M8Q3YzrS55vjsRqHsJaBuLBuUm+ZJbXnDOxCvdOYTIY/7Qjg+bieeNcc28NiXX9syv2uOvIIuPZCSaTLKYjSLTdDrvEeZRRE4jPdlef57bpSPBESemSN+2DKZsjHx/2v0AWqMtTZIVgp//tyOTInOdSS9nB/3PN1CEQLRqib06vRIuQA1pyog1PEjNWrh51A7TFQdBSbZMPtEgpN9/3qStEGesXyVt43AaRFjQoQ/rj9tp0bofvNSnQR6wsCVoq3jCcfnSqg8q/cil9LyH5kLpAjjM2SGjesqWyl623SIz9vgDj7Qul2uRk9Ux9YvitHDj0F4u8S+2XgccNMTQ2h1Mn+uiz3NblFC00aRnZzDNUCv124d1wjkXg5g5+M+xgUhS3W4fFtmuGN7u5ez8V5LfGXAxgRhrXg0tkPrn0fbnsSkjAnS38evRjw014DxJdt4mRXGvrdZM18S3dyYwg5t/N6kwRZzQinDYNQcNK50sKtJCHdBxiVZX2vUxJANxq8Cz1AEUDD3Ogf0bneeepbb/LXl4kmSl+tRh0qQz2qIxGH20TTyTBkbhfKyg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6916009)(33656002)(8936002)(9786002)(5660300002)(508600001)(9746002)(8676002)(2906002)(83380400001)(1076003)(4326008)(426003)(36756003)(66556008)(66476007)(316002)(186003)(66946007)(38100700002)(26005)(2616005)(4744005)(86362001)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?njhAneAzq66MltQkDSrN6i1cpuo4ZhCxfLvrVQTiXnmlnWYG5RtqdZYzhuXt?=
 =?us-ascii?Q?IbkLmtq9q26xKmKdSNQydWR+kdpdMORw9uq/e7f0DLK0/Q/GMEoFve7gC9J9?=
 =?us-ascii?Q?7gq6Ga8p+RjxNKJwyJQiSqj8GGT6NWHquUIIrJWdraNNXu7ocX/H1OwJdYnx?=
 =?us-ascii?Q?Cv72DcyZXhylIyZslYpPzIipo1+Aj4rk5matxpS3n/aJnGwLiS5AGT0x9+z7?=
 =?us-ascii?Q?jtFXXRch2s9ll4Em6ZI38etUd7OifB3o69RVlXPU/qVR42YtD2r9m7SBITop?=
 =?us-ascii?Q?ICoeiRoTLnvYPE+K9pKxwJFNeOuAhQ7jRaKu39M/Y6hcHbuW98CbatVddCeI?=
 =?us-ascii?Q?G66m9DgOpSsUvJ1NvLqJ7BsEeX8+7OgiEGErIQaas8tyXyRDp/Y+zlYYQrqa?=
 =?us-ascii?Q?RvqRVmyvbTsxbug1Hi7ylkjsvLwMjaSNNsP1m4tfkMg8IVD5IJJn5ALB6FwI?=
 =?us-ascii?Q?7w3+hVa2SP1x/dmnlHHDD2nUxe/hi67JeLbLtQw4NkQ0ocU0RUsLxiepTp5n?=
 =?us-ascii?Q?dxwc9DuTcOebJQCnuyZTqESnK1Vr0Tq8RYe5hgW2UBZlHEw15KSdDfqhV6vy?=
 =?us-ascii?Q?oUAlwIUPICmI3rtESQPp4/aIJTqOeiCSWDL6vTa6+4yNZFfTGukqNRtaNoNv?=
 =?us-ascii?Q?Q/CbG/v+Uu4GirosX+ogClXmtFDF/tN8Ppr1kB0wiLAviYEWxmft3YSA2HCE?=
 =?us-ascii?Q?kpxci+lHqTx4CKg9eDjA3LVHUl+e5tMiR8CupGGWJom1/iRY1Tok8q/dn/z3?=
 =?us-ascii?Q?v8sxIBSQlsX/7jzFzt1DlXuv7Pj873ozyk+LMGwcNTK5uq/e5Y4SzNSvEq3X?=
 =?us-ascii?Q?vNWwPHZRoObeh/vVSwiLO3/FwoMLAMXwnWjTN6UdKLI5jQtjOzwfVBGShOGY?=
 =?us-ascii?Q?thAgiHKMtxdx1+xV9wqLhVBZluSbfL4E+NN1o8EqCUnButqArNHEinTGRnWa?=
 =?us-ascii?Q?mzaGd4c8+4dFB0e8gPMbXziCF4uwXNJKuEDUbDWDFCdu4BuVBFz0GXlAfVvG?=
 =?us-ascii?Q?Ci7HGzX9BvhbMDW4iNv+p70Q8fRn7iJfCYNUbaeYSuzNI0vqdvVY3rJenxh0?=
 =?us-ascii?Q?rmvNxl3SQeJdTx5sTE2RFlbIoq9swU4RTztvpd+wF2/i/7yqRLU2k3VE6xja?=
 =?us-ascii?Q?K/ikBhAnqQLYfugniptitJAk0si5UppCJa5APBThGdK3FV7MOsSgiDetfvZ6?=
 =?us-ascii?Q?gQCCf0U9nSD0q5TyRnvneA1qdaJvZb5Xv4/+EWToF+Qu9VGFC6aGYIfCR5+z?=
 =?us-ascii?Q?rMTEo1NBXBp26Dj2AvQtQrfhn7zPr+uwwl83C4GQUU7fV80eSchPwKIopb5k?=
 =?us-ascii?Q?rTqrqUZ8GR/Mu/CeLucEGYqpF+xCnzyL8dl+wZeJ//NCwi/i8h2tm5Ce+YnK?=
 =?us-ascii?Q?+GMSfJ4h8qJ6rKpHz2MJ+qa7u8LUrBEnhMLGaKkDLEFQEWFrcx7UcDuRIJ8V?=
 =?us-ascii?Q?9Q1wmZOwFKWy5o7dJyX8UnN6lAibgf4bD+JRUH3DDXpmy9+RikNIY55wMwOJ?=
 =?us-ascii?Q?JP4/49J8eyEkmTqbC/1YbreZ/SWAMeS6fCAlMPrgrjI3jvrxa2tSJT4qyRjV?=
 =?us-ascii?Q?GmRGbSuw4Pt4gE++UvY=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: adea8e9a-8b1d-4623-a65d-08d9996a9da2
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2021 16:55:44.1683
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rlms1rB3xQHNk8jQ1PG2IGL/NkUdalUuh+sgqXfylM/Dp9ZeYVYIkoSpKkC/BwGD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5253
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Oct 24, 2021 at 10:13:14AM -0700, Joe Perches wrote:
> Make struct rxe_type_info static const and local to the only uses.
> Moves a bit of data to text.
> 
> $ size drivers/infiniband/sw/rxe/rxe_pool.o* (defconfig w/ infiniband swe)
>    text	   data	    bss	    dec	    hex	filename
>    4456	     12	      0	   4468	   1174	drivers/infiniband/sw/rxe/rxe_pool.o.new
>    3817	    652	      0	   4469	   1175	drivers/infiniband/sw/rxe/rxe_pool.o.old
> 
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_pool.c | 28 ++++++++++++++++++----------
>  drivers/infiniband/sw/rxe/rxe_pool.h | 14 --------------
>  2 files changed, 18 insertions(+), 24 deletions(-)

Applied to for-next, thanks

Jason
