Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C9353AFA15
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Jun 2021 02:07:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbhFVAJR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 21 Jun 2021 20:09:17 -0400
Received: from mail-dm6nam10on2083.outbound.protection.outlook.com ([40.107.93.83]:54752
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229640AbhFVAJR (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 21 Jun 2021 20:09:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WEkJ8EdbpAQ9IiVzDGEG/nkzLKKxpKv5j1UG6fkxd7o34jID7yJJw+jyZsN3u7nyIYcD8/19MxKqyw8BLzzLnKLH/2Eu3sPd5LgvR/TGb4T8HksUnqGmUlR3Ny+r8b4mUkHy7oDdx84yI1kdD+npmXgAEUba39V0DDBpdRVErVGs4tJ20J+C7/O+3og/05MlAlkfrpayAv7Y3j0yYW9cQK71ZWzHa0mpHacT9JhyVWpo60AMpiHOy80JVcbrZCTJYuqiXZNfLTwb1vFtBN92FrP8jlzS3W2U9cnELg8BaJC5sofIwTfyieppGrPIgMxlHUNiRItCRJX+FU+Ju+vtbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+E+GnAeQjljd4VtlqcEQrYpCAQn6WQ8SmDjbuu2cZnM=;
 b=dfrg7hdzNohrQJjTeE1QUiF+wbBHwJpUsH3P4QEUo/j+G4EGYhbC8HNgY9AanZbIPuJTedHXfdCsVh5UD5c6yJZ7X6kP6mBOgJCxOTpBW1Y7rPVMOOCEK2BjZFL0X0lDfkCFybGPO+/vB3FRqT7zIVcKKotc3pLMZKLIw8p0toxhBjrj7an9JJdbl86GzxvnIVeUsmTI8vS5YLe9boD7LzYQ2i8B3/q1ngIP6d1s8lBlNRnIKxq8KZma5iDbxGyEf87hUMJCRMiLjoHc+G6G4C9f6DqxCV9AcJnqVym84IWRXlVBZXLKsO4Xq19E7jyuCgCCQaWbSSTdlQFxX4T2/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+E+GnAeQjljd4VtlqcEQrYpCAQn6WQ8SmDjbuu2cZnM=;
 b=FAE0Zq5tXKRQkUVUje+jXsC4oCqjmrNFTGh9HGALYWrgz+RaoqNZ9XfKcNeub6tYEjGzJGmH92svd3+cI2w8PgCXVJSmds/X+dcIVJ7AfzNe6otAL4My7ezmSEAGaGdneL1lViGVLLR/Sc682m0pmoXPy4ZxVCAgN0XsEznJbcOW0TuW8faC+xQBYBQetO3in+TIrqalAgvEgiaoa5m44MLWVAyCWIY1XSKWDeE8vMuYRKWRGzO1xDX2bnu3u4bqkkUm1hN5dWpWHNnJYUu7Q04L3aJzZ/Lc+f2jOmu7+1O4G1i6HS/uEr8h6m+xuZMRIZ944oj9tlhnZI2KJVhfvQ==
Authentication-Results: 163.com; dkim=none (message not signed)
 header.d=none;163.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL0PR12MB5537.namprd12.prod.outlook.com (2603:10b6:208:1cc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18; Tue, 22 Jun
 2021 00:07:01 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%8]) with mapi id 15.20.4242.023; Tue, 22 Jun 2021
 00:07:01 +0000
Date:   Mon, 21 Jun 2021 21:07:00 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     ice_yangxiao@163.com
Cc:     linux-rdma@vger.kernel.org, leon@kernel.org, zyjzyj2000@gmail.com,
        Xiao Yang <yangx.jy@fujitsu.com>
Subject: Re: [PATCH RESEND] RDMA/rxe: Don't overwrite errno from ib_umem_get()
Message-ID: <20210622000700.GC2384990@nvidia.com>
References: <20210621071456.4259-1-ice_yangxiao@163.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210621071456.4259-1-ice_yangxiao@163.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: BL0PR02CA0038.namprd02.prod.outlook.com
 (2603:10b6:207:3d::15) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by BL0PR02CA0038.namprd02.prod.outlook.com (2603:10b6:207:3d::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.21 via Frontend Transport; Tue, 22 Jun 2021 00:07:01 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lvTwS-00A0Tj-AC; Mon, 21 Jun 2021 21:07:00 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2fd558aa-2995-439d-9ade-08d93511a8ac
X-MS-TrafficTypeDiagnostic: BL0PR12MB5537:
X-Microsoft-Antispam-PRVS: <BL0PR12MB553797DF2F6027309A64D417C2099@BL0PR12MB5537.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TCZHv7m9WPVoSLvm2vyyhd7pDBkv+4bMNuD9GCjkvT00RSiYfHXFPD7rPYO6WMs1a14WU6eTDOYxj4EZK15Z2xadBoR82js+dHc7vQkvW3Xxb0FtEERowxFZ5OuAmcWu5Y8u1bA4i9DvIDQrKKVCgaoAEjCHri2FIw++LAag5d+QM6fCagd2MuLw4eg8SWwAU2Z91cAtd8qQbuofTAnw5Z+F6CtH9MjjCaKtesUnmJXJNd5QkdHzBXkYIS4BkmrtYYQ2VS5SDnxaP7qiffFZAu2Qpqho8Q+HaIkUgIjJ9vst/9Bp5nKeIz72NG617+R5Zn8wz4DRJ+Tt1ktjvh7oRZyyq/amhoTXVXkmxRb11/GCeTDJi9r7rZErp9JNuom2kOI1fG7h/nTc4DeDDz1bKYHmGqsVGyPXwA0PfEoIo2zBVLxQcvuolwqXa9Sd917oi3OkG8ieLgRtMWDkm9EUfbSMAu80o91bsdc9ZrIPaDjNSHBSTxrJoDz8vaZnweQ7zTY/auhlWLPEJa1b1RYjsC+0R9wxI9iaLeQZuytRrL0y7UnUpWc3rgTFVKGqo7JGNsLEyomvuDGdH7gfGZDuWd9OKIK+mt79lBRbJtM4XC2D9AUjMveRyF4JLgjOjcw+YQ4o6IihErF9GlkIwZ1BKw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(346002)(396003)(376002)(136003)(4744005)(2616005)(26005)(426003)(316002)(9746002)(66476007)(38100700002)(8676002)(186003)(66946007)(1076003)(9786002)(66556008)(2906002)(36756003)(33656002)(83380400001)(6916009)(8936002)(478600001)(4326008)(5660300002)(86362001)(1491003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HSqlMaBfC3qIblnRzTjXQkw4zYxRxtm6/Zix04YGZcdMldW4Clj4NPGir9HT?=
 =?us-ascii?Q?HDih7Cc+H+vOTWQeS0HmHH7tkBcG083lTgQ+07WSqRBJ57S27O4e97M540xg?=
 =?us-ascii?Q?YkZyjSA5uAPf9Km5zKOEoliZSWOm9xef0tR/4NSVx6UyNcSiPxJzZ3kENbr7?=
 =?us-ascii?Q?8XafyuVCtHsLLyo8ArTrW83OzZVtuNw3+zn6oREv6tOc6rVQ1cIF0nHoa0xE?=
 =?us-ascii?Q?141Is+oxNcv/JhaJNxf9rAplzCgU/zNv377j8oy1BnPYoXWR6ysy4xBDtBvM?=
 =?us-ascii?Q?pXHOMHMIyo0+kGZCiOMexYD6otvJnHVZXMzVDfgQEmSWdxUWHAr4aI4JBzBZ?=
 =?us-ascii?Q?8KpK7itOak23Pj/9343Vp3DNbuk033ogJeFBeqUi3csjTNSBTKO/kIfmBaCZ?=
 =?us-ascii?Q?cJudRvOP2kXZggzgGmjWh+tOpt9QBes0Sx2spr63Ywl6zJ2x621RQ8ov22e2?=
 =?us-ascii?Q?FKlxEo3vNhXP2wBd3FHwCoGNkthDaIJyK0MYK0lEepGfURJphe6KYdNH+dAb?=
 =?us-ascii?Q?452pYAOMeJehHpfAf2QWKqtm+MuKJwLNjqSF7dfnd6d2SGtNR/ByodWqCwka?=
 =?us-ascii?Q?hExJ3v3ollKCbqZk8a2kESY33cNkOPrcg4b8AaiAMV8vbS84Sz4o91NZZjqt?=
 =?us-ascii?Q?ukHGF1KLiV1clJSuwP9C5Kk/SJCKkYrkklk1MfOTZL2zbidTHXhgjU+RlfO7?=
 =?us-ascii?Q?TGCiwxJFiyCXeYf6zBY0vlaURVHILDaNNA6Z5vZfdqdCDqTk1rlRvrmoYT9A?=
 =?us-ascii?Q?BgD7AfWEFh5jzgGkF/KmqmDOWP7d0nDlv78/8lZSZTW53B2ZcR8qjY25Ut+y?=
 =?us-ascii?Q?GUGxQhZHcAMl2DyD2kCOofjQCy2qhiKfkBCpjz8JaGdelLeMAFHzArABt3mo?=
 =?us-ascii?Q?G6TiM2AKhVSkvE3o+K+j0/s0CY+ntKPE2pdCpeFMubnusrkYiFkOn3608btp?=
 =?us-ascii?Q?y95XfWBP4L/F2ZprgsaW21yzjsy7K2pSR60cuOktqdOPC/6yFx+3gDxNe7T1?=
 =?us-ascii?Q?SPUcmIdfneAgJbrslktYpLXmiSxJOVng1golaL5jqiRku6FOhUnM/8W3dOM7?=
 =?us-ascii?Q?hA/gOr/905M3Z/yfxGCJwZZpMgY3UD+FV7mksmBWd/JQuoQ55LZ4hsTH+flm?=
 =?us-ascii?Q?WzKac798r5/l3wO66yyjdjl+1HmFpeX8nE4bhx+pGK6SYHbg7BEdj4jGUOZ9?=
 =?us-ascii?Q?27dKpb/706Fx3TxN1NZIEFw5VNSRxpsQms5VzsLq/5NhWvZFe8XJWbkI4sT9?=
 =?us-ascii?Q?7fcL2s8dkqpLuSyDoY7QEx9LIhzcoGmJ4ckpBqJbqzIYf9ae97Yj3FmLg7E8?=
 =?us-ascii?Q?6kRE8fZJuK1NzTuTV5S2Mwo6?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fd558aa-2995-439d-9ade-08d93511a8ac
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2021 00:07:01.1181
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gnxVcH1dRf24qXjH5VDDn8Yq4W1SFcdlESYeGHhUqJnJ0ruWdGu/MXpbyJ3paoWN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5537
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jun 21, 2021 at 03:14:56PM +0800, ice_yangxiao@163.com wrote:
> From: Xiao Yang <yangx.jy@fujitsu.com>
> 
> rxe_mr_init_user() always returns the fixed -EINVAL when ib_umem_get()
> fails so it's hard for user to know which actual error happens in
> ib_umem_get(). For example, ib_umem_get() will return -EOPNOTSUPP
> when trying to pin pages on a DAX file.
> 
> Return actual error as mlx4/mlx5 does.
> 
> Signed-off-by: Xiao Yang <yangx.jy@fujitsu.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_mr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to for-next, thanks

Jason
