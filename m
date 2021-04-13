Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C72ED35E97B
	for <lists+linux-rdma@lfdr.de>; Wed, 14 Apr 2021 01:08:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348763AbhDMXJN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 13 Apr 2021 19:09:13 -0400
Received: from mail-dm6nam12on2054.outbound.protection.outlook.com ([40.107.243.54]:30048
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232979AbhDMXJK (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 13 Apr 2021 19:09:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XJy1K6qfMtXh8jOauGYK5zvmV6Phh5I8fuv5jhg8froMYIuFC0WltCHw1GVf4IUif0SU3tqKO27ZLZPWjlvdUBbq11WGp6Ghe1ppdQS6Kv6y3F6j8F6yS5c7fJ+wVWR+6SBpjwnENGXFUwMJT3QjMYtLMhzH8DPEKAYS1kwHQQ4bunTyj04gXB9mYYv/XOWc96d0GCR5+hSROBSqb340AnBUeDKklaeDHYQWohKejdO1MLVIYs0HoXjslQ0CsWk6Cmh/cMUDsyStUjRjhiccoSyU0aGgY1JAavXN84NLmzkWyY2iJ2CdX87jC7U62Y97+rljGSOLsWVUpPa7TL0sVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D2Sl+hX1gn3baHh1jJy8yvDFssmRyCbFnro8RRGaSPI=;
 b=EK19sYLR6ZNsWz6Ag+OSMSnRwgA/+zAzerpTeDqhyKGCeGsLGY8YLPDVUx8tG4fcRTfwC6MrH6dDPgeJhVOOQRbF4FTS2t7tSLHhW+Io8Xy7YETvMdsa+LZBQiQCMvxGa71k5hgkDUA6ceduKr78s7JclbMIfZULHL4v10TMmvFvd1enMMzUQutLKQUxUgcNXe+xSeQ+M6sJ3WrBLdCY20KcmHLZHxQ6Cc+mrSNfPLEPezzAEn9FWGZ7ZoOQ2x1SnPw/s6FY7FeQ14U8E19kUWkbsBm6+MfC5DD7Zqh/ssAt9HoX/3YQ7zOyWJ5wBWzp3aJ3UgOiwKc/3S28TikkPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D2Sl+hX1gn3baHh1jJy8yvDFssmRyCbFnro8RRGaSPI=;
 b=o32r0953U2RbiTnS4K6/zAQTQatd1qdWSH2k3PLMRILzMGmXLaTdpmLy3556mzO0cNZq9mV7EVIrWPy81V+vHHVdLpX8Jxbskmxf9bcGyVy6/shSQYDi9f5Yd4PnmtW9ATwfu0nByVlLnRDnex2WkcfiTJ7/n+kmAgbsNSyMjZcJkPQ0nVaC3qeprepw/Aw+buea4qNcgNLgA5ODkGdEy0tQVqWG2cXXGW6ULfNfZqcQs7U19u+4c2kBarH90q4k/REmd8feTkyiQ2GlGjBSTVjC7JckTkSt6LlZLr+7ZvzWP9Q2Q8sRScJ6evb+6eI2FxGXUAu7UL9G2/vxaZduRQ==
Authentication-Results: ionos.com; dkim=none (message not signed)
 header.d=none;ionos.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4780.namprd12.prod.outlook.com (2603:10b6:5:168::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Tue, 13 Apr
 2021 23:08:48 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.4020.022; Tue, 13 Apr 2021
 23:08:48 +0000
Date:   Tue, 13 Apr 2021 20:08:47 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Jack Wang <jinpu.wang@ionos.com>
Cc:     linux-rdma@vger.kernel.org, bvanassche@acm.org, leon@kernel.org,
        dledford@redhat.com
Subject: Re: [PATCH v3] RDMA/ipoib: print a message if only child interface
 is UP
Message-ID: <20210413230847.GA1385534@nvidia.com>
References: <20210408093215.24023-1-jinpu.wang@ionos.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210408093215.24023-1-jinpu.wang@ionos.com>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: MN2PR18CA0018.namprd18.prod.outlook.com
 (2603:10b6:208:23c::23) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by MN2PR18CA0018.namprd18.prod.outlook.com (2603:10b6:208:23c::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16 via Frontend Transport; Tue, 13 Apr 2021 23:08:48 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lWS9H-005oS1-3Q; Tue, 13 Apr 2021 20:08:47 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c3098f65-b6a2-451f-5444-08d8fed11845
X-MS-TrafficTypeDiagnostic: DM6PR12MB4780:
X-Microsoft-Antispam-PRVS: <DM6PR12MB47802273C450D3B3E6C5752CC24F9@DM6PR12MB4780.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1013;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hpx5z9Od5nRPNOlKV+JEjfJUwGgWrrQenYWl/Wyudw8NsnafMyhQQtznZ3bpnSVyGchSAjdtwGrggB2BbUV1Vjf/W21B2uxkDwXzhmWKnV3VJ/zSTfyD7c2ar+YU7hXgvOaVLTEt6yvyW5XpYbK8kMjQBNmwv2u8ypkmCizW12LVRUt2L9/L7HYp3KOntKrQWUaj4SjifFSvWV8clliSw6Upg1qG1rGqvqR+Ke2vz+dFbI3SnnBBRAZKeth7JXJslp0pNS0l0voMmFl/suQK2Pxca7ymiDK0ymrd8INu205iLbtNM2+Hn9RFoetlH5/B95isiSyfcC8eb/J4p9AwlN5qAHzcDCXVv7Ms2ecxLM/Ve4mEf03V1RaKEIgPHddbH3CdiAPtF9ZCftqvp/Mae3K291r7d7vvS8YMkWvp5XVt4FQF1LgfLcZmLRhzavPZUz+efSPOf6EAdpmScW/+SXTEywf+Yeh4uyOKcPCJjVP4fuFpTKhGvrJ1XtNGlE45Z6r+JzUfls2t7scrhbW2CtMqeSTNt66gLBBNNJzxxsBi1lYmvlXSTyj1opoo4hlWs39+8qp3/c0HTSENbcMKNC1fuozlOgUouyBTJ0ZStoY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(396003)(136003)(346002)(366004)(66476007)(66946007)(66556008)(15650500001)(9746002)(36756003)(4326008)(6916009)(5660300002)(86362001)(9786002)(2906002)(316002)(38100700002)(426003)(8676002)(83380400001)(8936002)(33656002)(1076003)(478600001)(186003)(26005)(4744005)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?1szmjgLQgURLCiM85wcFr4BDO/RHrjMqI/V7mGXfQ9tT0GJK2sp9jg1pP60/?=
 =?us-ascii?Q?T8/Sh2hmiAc4pvbEM0ipUJS6Q776nobB+FdS3qNywJeBOjll12MWyFA5OZBG?=
 =?us-ascii?Q?xIFbuyQmaO8wHy9hgrWLWKOmrwNeAXw8k+eU64Cm1z9YJFlMdOD6gTVWBMtW?=
 =?us-ascii?Q?AOzYZW8JnI33vU+9M7OXvAl/X0OWxzowg+jUr4ITWfgNRYkHN/yjOloiY649?=
 =?us-ascii?Q?7FffxYlb6/2My2+51jfZUubAIXTChpj5g4v69VsXvC7Ot+Mq4XWJLlwYB8dl?=
 =?us-ascii?Q?zqVBPCSDpXCIZxEqBm7HjoqFgKGuUbTVRJwQ7WP7hFBzMXLGQKtzDeP41n0i?=
 =?us-ascii?Q?UOV1MOiHMTuyoR4IIBaK+cJBoCa/4JK8QQJ4m3mIXbt5GMrGHB+LSUcF+Qw1?=
 =?us-ascii?Q?bEGWiEfWifYa1U3N/XjaJkvcHoPv2uCaK7nYe8SIfU2M5xSxO7tecD4w6pI1?=
 =?us-ascii?Q?llCQzaC6BXOpJcAJQJynQkQndCFoTVEhofO34dvdBsASGYZNJP/u5YXCx+HY?=
 =?us-ascii?Q?DDuIiNGFAQ7r/Gm7a5j7bAnyNknmERhxzmJJzkuHdnA22lH9gU4s5gBF22T1?=
 =?us-ascii?Q?aiFqEqsbGrm2iIZDhF4M0HhLN6KdRLAf7IpOCZErgLKkjQvqXK9Tv6EZByMO?=
 =?us-ascii?Q?NH4r91+NCShrAWKlpLiQU0qO9mXLLBG0SVvi5FuS7MFIg+STZ5dswaqV9ND7?=
 =?us-ascii?Q?kqqKu7g98e3xcGeaFRLVcrI0BlN61H8z/BXIqPVGET2uoG2qUI0/Oe1tebFm?=
 =?us-ascii?Q?9anMDLgM9JdhxQaVKoV5EdOvt2n0QZAIyQ1lvwnqz8tI5KXwH/lZVnKPdM1V?=
 =?us-ascii?Q?vUgmAgnJiJtzxYTwgipA7rQvQxaFJ9sk8IOBtTZwxWgwDoMpYIdBli6zbrwS?=
 =?us-ascii?Q?dVrPvXKxIKR0zbYW2wtrYsxPBzYGOvJlXQRu1CKJ280YWKTP5vPd5ndUOnmP?=
 =?us-ascii?Q?4BRuT19RLp6BQBpohXt5TaGVlTem4tvJe6aAR7/UnW6HVS4veXVki2ekzzGc?=
 =?us-ascii?Q?R4DL/zkXoZnqPt788dGbT7yjts9cghq4KZgJa6iwtrkcC/FhzEbhEpaaDT4Z?=
 =?us-ascii?Q?3W/+OoaX2DdK+hnR3Zq5JwZdZk9yzc+hmGSnf2biNDpN5fd3c7mxvdOgw3by?=
 =?us-ascii?Q?yWWvjU/bUoN9bPPJcMJyb6GPbs2doaIU1CLq3gQwewrNq9IkgPJyvC3hmw37?=
 =?us-ascii?Q?rnKrP0nkvpGRDdCdqfFFnIHX6XS6dFWluJR13CCycWxRp1t/biNiK5y2UD47?=
 =?us-ascii?Q?Nlb23lTWuIhKyXozd/SGfCCKhRsXKx4wvxblQY4M12962S8IZAc7CD8oRTAR?=
 =?us-ascii?Q?i/tRIoPcb2mi3E3jNv1NFH/ZWaC3eyZYfLCpOBz1FQczlQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3098f65-b6a2-451f-5444-08d8fed11845
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2021 23:08:48.6409
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fx9o4XBMYIiFZdrW3Mc89Ze9CmKsEVc4dD08dcCafs/wtzeaa4J7h8TFErj80CKS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4780
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Apr 08, 2021 at 11:32:15AM +0200, Jack Wang wrote:
> When "enhanced IPoIB" enabled for CX-5 devices, it requires
> the parent device to be UP, otherwise the child devices won't
> work.
> 
> This add a debug message to give admin a hint, if only child interface
> is UP, but parent interface is not.
> 
> Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
> Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/infiniband/ulp/ipoib/ipoib_main.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)

Applied to for-next, thanks

Jason
