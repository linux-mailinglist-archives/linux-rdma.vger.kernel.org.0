Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D9CD45DFD6
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Nov 2021 18:33:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350999AbhKYRgo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 25 Nov 2021 12:36:44 -0500
Received: from mail-bn8nam08on2067.outbound.protection.outlook.com ([40.107.100.67]:39977
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1347024AbhKYRel (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 25 Nov 2021 12:34:41 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j9CMCVG7xjQKDzMZXGUr5jPqVFni3gKJRgcIlxgZUZls9dQ6GDUpY/MUbdd5nXCX5y/pMzGxtOy/3ZtO9Ipxf+I+kFFnfuvTrxHvraohd7yqylVI0Q+SBE5qY3SNB14DwFP2MA12hfoNHdfgwpjJFniq81Uk66vONSZTTwKM0/TcPidhZXOy36FnOa2XTpYRqaIQdZYWd5GqDeM4bfc2UX5TWHfhcNECdDg504GaGd9R1rMBKZGUOAK7peg55YyrPvD6sRj5wnmlEjNhQCde4rkWPzWpME9vZ2srddOuS5szgpITPkc1iklx9FuHzps3irsccwDamQMOSWR2pM9gLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mmL5DTbjFVmSPcvHdT2hIlQEVLfd+sYtVIjrtkhtcZI=;
 b=fafxPBftxSHvJ9FqglsdcoZoh7lyDwYsYYSdI3bYEn/Le4iTQfp/aEJna1BuqS7mHBdNxS2MQ9zVz7Z2/822axK+rqONn6WIFVLnnIj5SMqjjMAhtSXmrS17JA8Sgx2qQq4aVNTWwGZ46k4OMK3tS56GILImDNPaMmJL+uZbcHL/L7e2WvJqALyJVx/xWJGjTv0pm/I+J16X4B3k/+GsQcCEjNXTzYVpfrLowdH+UUGz/XbTNSyzGP300PzVO5sC2KZHERBZsDoWZZWpjJ2SSbarvGEYhn+yqMzQ6BWj7lNCjwtl6KeSmRl/rkesEV5q92pJgBkfT7yJA0JgfLD3+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mmL5DTbjFVmSPcvHdT2hIlQEVLfd+sYtVIjrtkhtcZI=;
 b=Djt2jAFkV1k4XzJOFvYTkEYJpNFl9sDW9rPUKsbfqrG22UtoI1nuPuDr0UcdojWB7cswnokHOSQXN2lqZ6EL84otPPnmaTtdZScvbEVOVkNFZEqTdqy4m4pbyP95C8aF8inLw5nUYw4ZJz+wxdTBFtFRipTNq5nPQYgWAnupEBGiYfklTz5BJm7xYv3g1cChLQ2CpsBG7FB9TUXCb0KUNfZynFF4jp9tkLKevY5YlZ2UM5OO7gJu3ndb3/RPHVA5KtHPyqKyg4H2yUOmMf+LEbPT7QWPuHtKfqA6jYbu5A7DVbPHllQADCuB2OVry1vaCxblZZO+Y9Eor/H60HAcCQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5253.namprd12.prod.outlook.com (2603:10b6:208:30b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22; Thu, 25 Nov
 2021 17:30:54 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::5897:83b2:a704:7909]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::5897:83b2:a704:7909%8]) with mapi id 15.20.4734.023; Thu, 25 Nov 2021
 17:30:54 +0000
Date:   Thu, 25 Nov 2021 13:30:53 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     bharat@chelsio.com, dledford@redhat.com,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 0/3] Cleanup and optimize a few bitmap operations
Message-ID: <20211125173053.GB499138@nvidia.com>
References: <cover.1637789139.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1637789139.git.christophe.jaillet@wanadoo.fr>
X-ClientProxiedBy: BL1P223CA0025.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:2c4::30) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by BL1P223CA0025.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:2c4::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23 via Frontend Transport; Thu, 25 Nov 2021 17:30:54 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mqIaD-0025rj-P8; Thu, 25 Nov 2021 13:30:53 -0400
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 56961262-ea44-4d20-8169-08d9b039559a
X-MS-TrafficTypeDiagnostic: BL1PR12MB5253:
X-Microsoft-Antispam-PRVS: <BL1PR12MB52537ED8337F779954AB2955C2629@BL1PR12MB5253.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7+uNzlhSGquilxgWA/zsUDKKKazZ56r9BAOJr8Hntfis8TCrLvkJdg1GSQ/L9Au9VJAj6Ar22om2rbNaEqqNELI52C5/ydA8x07K9pmoEY8GiP9U/3wegYsdIWe16KOyDE7ZJaEazNRUcglkqBigpd+YnWC06bVpmg08xgVkxkwNcW9VKkpx9uGyRLqWO7FwsXimCEJkJ2fiLqkRS28p2tO+tfHIPRqi5aC7h9RHPMVmRK1t/nfCuH2tSRbMlLaJTLP34hrWkhj9Ww52iWkOxcUf0Hp37e0eEwGofWriR6Gsev4iWfzDRRIA5/890Z3AHxXubwuuZszsib5waJuWFSrdv4POeQwZDXuBF4j5eBw8eioCed8zGxhtk3xo0XIyoTP75zW4Tx5JiYbAqf/TSpPHCtoyCcM4oeiLLJWtXKzPxmw1YepcbvF2yttkJJkmCnCbYW+kGwZNrPVTnUDIJhBpDWn//M6PVyF214FlCQrwJgTvH9kZmCHyaeVPo5qkIz2rqG1lMA4gLCywu0M7VVXW+Ukmgf/wMnJ7FE7hlMgdBzeBLH6TIn6wcfnbiCK2naFGanlb52GZOqs2RrZ60Oa7nSM1sbTT+bCYioPGUGddJ6GTyftYRo8srgM0MZASasfqFMDVjBnXSPX108001c0NguWUOrxr1x/ZfAhcEl9m3F/rDMzMmEUKIjRvQ1aT3duvYlSadfZv7iqm87xxEw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8676002)(8936002)(6916009)(83380400001)(26005)(426003)(508600001)(38100700002)(4326008)(1076003)(86362001)(9786002)(9746002)(186003)(316002)(5660300002)(66946007)(4744005)(66476007)(66556008)(36756003)(2906002)(33656002)(2616005)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hJHz/6Gx9+BwMJozsFii/hu09B2oi63P2x1wjVyfutzoqjSkApDi/JPElK8v?=
 =?us-ascii?Q?i0cczWXBfqvx06EuiOev7qnBvn7gk18w3+ONlTnhov9TLJID5kSt+UmkAkMi?=
 =?us-ascii?Q?QFlAs5wGxQXQt/E8JilnmZTkXIip8Va9LGpbE/UIKIa1eDLcHcTIxf+4k9X0?=
 =?us-ascii?Q?W+tgyztnvmy8lkSOOzuUo0CXAqjW3cUBQVvx5MabtWMiucWiOcbTXF287ggA?=
 =?us-ascii?Q?qrIsx+F80kM5/hAi1gZqyfP0INW3phEikuzWzorlQi0zD65bekaw9Eh0LggP?=
 =?us-ascii?Q?/bp2lkfIXk7EUp0b/SFvvXQX15AvnF4j/amBxnP5Ftz4fzm5FDBiD4Bp70Ux?=
 =?us-ascii?Q?QeH3s5u/8NcxTr8XMatirz9YCrD46dKKUmbJNjVwMx93dTntrWf76/sSLbKc?=
 =?us-ascii?Q?NlBNRqcIucv5aIJOYsq6Yeto8Z5l8tf95UYCl8wFjpDqPhrWCskhy9vfGRSf?=
 =?us-ascii?Q?TWV85tod7qgrqXwJw3m2ACBaD+14hglY5Z/kY5Tke7hfj8i5wIwrbN8iOOuW?=
 =?us-ascii?Q?pKDxf5fcDckEnVdfZnm0NfPQlz4NGc+5sIDk+3NxOMuQzqgrja/Q9soGoQdg?=
 =?us-ascii?Q?r19kTjRvkvxCs7dJkQpHrHQJjGh2pTKworpd35+iLwQ8RNXUeoU8mKiezC1k?=
 =?us-ascii?Q?F7iJvx0y/VUDUYRFicJNSqhfIKJU35OGgII5vImZiIN7F7hRzWCMUO/98gaM?=
 =?us-ascii?Q?gZtS+3j3d0v4341coaG4/w1lUEEXrP7Aub1Qx574E0IBGBW4Uhpq4aj63Vkb?=
 =?us-ascii?Q?/wcZlA8aISpmchTWA9r/bWwgtcMfxMMJHWqz5M8fQKrLF6WVHqTeUSdX+A3f?=
 =?us-ascii?Q?Evvx+v4NvqOavj+p96QScJszeGHTvq5g8OidBmN+1phR8idMDhYbMj/QxvTo?=
 =?us-ascii?Q?Iyuw9bvxMDiH3Yknd0OCkGn8O8eBxOevbnwrpuT6Bd4IB3XxIeKhFEWcMXV9?=
 =?us-ascii?Q?QTLWbGH1spHt7LpB3JHt9h+V/+gGB/f4rSagnuz5q5l9YH3I6jV3d4IfJefV?=
 =?us-ascii?Q?4Js9TkSSHjzO8vJ5uJpNBAYSnMrIFCRJt5fGfgE17vVCcSuSjugklWlargUB?=
 =?us-ascii?Q?fjWklRs5g/en7yKhzKTrX7M5jMTQDIZvhYx4b862HrdGWCnFiQEgMSkFWx/M?=
 =?us-ascii?Q?5uNhHZazma5nQGP/YmnxWeJhIdkuxLV7127AZdoc2z6eN2pRkd9+oxO2CbDo?=
 =?us-ascii?Q?F66NhyhWxhURgiipCQOimDsW6LJY5Xpi1zn5Ujic6C9b2m/t2Q67Od2lDFcm?=
 =?us-ascii?Q?vwQAYfugJ2iq+DZNNTeTDmaL3junOysd4xEGhIE1VjtY9SQO0uv5NSjLRUD5?=
 =?us-ascii?Q?LQBOtEvzTwZYwdZz58N4uP4oZOGnG+5D0A7xNTgvQ5jGUp7KTWR0KQ9iKzwP?=
 =?us-ascii?Q?S5Ruo8r1eGKjmsJ+KgTppR20kCvVTVX2WINqK0h6lnlsHu76hzXS5HAnvyH+?=
 =?us-ascii?Q?RqV8vGccYxPh5ESNF7XebTPIGE3746mRnyEQ1OGt7qX3T+U92DgaUU+fDFES?=
 =?us-ascii?Q?CT/4Fjxe2yteCTPX9S1gz1gkrJG8szNVpfpEhaf88fG8SPdotN8sb/M8Bm6X?=
 =?us-ascii?Q?45JlLyVTSAeeVh4xvpo=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56961262-ea44-4d20-8169-08d9b039559a
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2021 17:30:54.6504
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rRuzdeD9DajlWOoPWAmkrtoR1yLMGTuqsEdnkexabJgpHuEHPpBKimeI9tcnEBGG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5253
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Nov 24, 2021 at 10:30:08PM +0100, Christophe JAILLET wrote:
> Patch 1 and 2 are just cleanups that uses 'bitmap_zalloc()' and 'bitmap_set()'
> instead of hand-writing these functions.
> 
> Patch 3 is more questionable. It replaces calls to '[set|clear]_bit()' by their
> non-atomic '__[set|clear]_bit()' alternatives.
> It looks safe to do so because accesses to the corresponding bitmaps are
> protected by spinlocks.
> However, this patch is compile-tested only. It is not sure that it worth
> changing the code just for saving a few atomic operations.
> So review, test and apply only if it make sense.
> 
> Christophe JAILLET (3):
>   RDMA/cxgb4: Use bitmap_zalloc() when applicable
>   RDMA/cxgb4: Use bitmap_set() when applicable
>   RDMA/cxgb4: Use non-atomic bitmap functions when possible

Applied to for-next, thanks

Jason
