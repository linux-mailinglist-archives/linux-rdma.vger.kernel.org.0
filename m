Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68ED725B79A
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Sep 2020 02:31:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726586AbgICAbX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 2 Sep 2020 20:31:23 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:8277 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726312AbgICAbV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 2 Sep 2020 20:31:21 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f50394a0000>; Wed, 02 Sep 2020 17:31:06 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 02 Sep 2020 17:31:20 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 02 Sep 2020 17:31:20 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 3 Sep
 2020 00:31:19 +0000
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 3 Sep 2020 00:31:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hC/MhegMdu3apHlhs9VHoaN3yOJ5e/2EIAsXT4CS02rcyZj1KT3tnOfLGuuNnOI5/1e4htTm1SXjAn2kQL+etdEEyXSEnSx+pX1Vf1Dp5i2iF7LqfPp17NKxobMMzhNpUHyVkRDmsTVu2Gy+njlom16JCL7KUTmzlRi2r1HjlCJtIgIi9sTYEzhVkK5MB9iENt4Lr3hTjC9exVUsbGuGpg2g5IBLEVBbOxEkFUqEUfq4wS/wCerxICRK49xlIaFGql+ypoRxkm8WlL5IlVPfSpPWplwRWBx/KGbPMZrJREquIALyBtuqaKQJXE6DhBlI5XKEikB+a6tISadWq6mwuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eYm+4T7OWXOFjKRbL6eJ4LiFyDkSq1RU+aM2ArZL9sE=;
 b=m8JZeXZJc7D0t4qquCEabKGZje3FjrmMg35OsY9NH8/pUulyyohBEgYXN5gW8tOE873IFEAcKfZDaw9F2YfIsNLMDfhSDB3JQLhmFTb2VE8/JebcBHbvWxGn/Igw/SIOHiICubfnV6pZG07QeaK/8rpQQWe5wRYzmpheQZGufJimlFIamFlOHeEAw1p5LvuiJEqaz19Kh+PEfwpcEYZSJ0bwMinjGGQhxb/srZY/HZ2MYkeev/Q3uXR63SbDttZyIhd4YRQaJzvtrF3WCveerv5/8TEbN8J4/UPgcSNTH5vIAghyyGr+6VOKnBYTRh1DfnrgbGZI1N0EU1E3TSaF7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB2581.namprd12.prod.outlook.com (2603:10b6:4:b2::36) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19; Thu, 3 Sep
 2020 00:31:18 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76%3]) with mapi id 15.20.3326.025; Thu, 3 Sep 2020
 00:31:18 +0000
Date:   Wed, 2 Sep 2020 21:31:15 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-next v1 03/10] RDMA/mlx5: Issue FW command to
 destroy SRQ on reentry
Message-ID: <20200903003115.GA1480685@nvidia.com>
References: <20200830084010.102381-1-leon@kernel.org>
 <20200830084010.102381-4-leon@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200830084010.102381-4-leon@kernel.org>
X-ClientProxiedBy: MN2PR04CA0015.namprd04.prod.outlook.com
 (2603:10b6:208:d4::28) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by MN2PR04CA0015.namprd04.prod.outlook.com (2603:10b6:208:d4::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15 via Frontend Transport; Thu, 3 Sep 2020 00:31:17 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kDd9n-006DqW-Uf; Wed, 02 Sep 2020 21:31:15 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7fa40af6-5911-4ad3-9b98-08d84fa0ac3a
X-MS-TrafficTypeDiagnostic: DM5PR12MB2581:
X-Microsoft-Antispam-PRVS: <DM5PR12MB2581857B4D7C36B9862E3989C22C0@DM5PR12MB2581.namprd12.prod.outlook.com>
X-MS-Exchange-Transport-Forked: True
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qmi2zcmq9Y5sqcvnnbYBfT7hJz4HpqbAkTU7EOViU66co/AHBmw9uQF9mJLkuYEUruK6avENa3zTTNxQQH9wcCalvJ/abUY0jyZX7dNe/wvfT6eAoRo2+SGcsKLuDjisVlVKE2/mXFjDacPmcQPYwSJKKElyr6fs+MZsuwwObJPb392mMSFms3YVGRvumdBEtk1N8QSrfvDilraWD6qkOhNJohhn0Zoijf8o+ozlgkZSQ00HjHK/zi4z8u+pQLRCzcZK3xdrNvF8Nlz8+2At2g7l2fpA01icQAagfAxGBGcPRTMJsmtLGiJYYvowtWSjAinC71lGnStZVJarXVneMA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(366004)(39850400004)(136003)(376002)(54906003)(33656002)(4326008)(2616005)(1076003)(9786002)(6916009)(426003)(9746002)(5660300002)(66556008)(186003)(478600001)(26005)(66476007)(86362001)(316002)(83380400001)(66946007)(2906002)(8936002)(8676002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: Py4w8hCuW1/uBLmBFa1LjhUGkuYLMJP/pjthTSKa86WyHoC0uze6tUsAX+thChyQyoiAxFAFAn1E2fKrsZm6CtcCpcV/Qiy21p0UMYkbVY64Q18X26y/wfMn3/mtnAtpgHO52cysctOyaKiTmMH0IbXbcW4dITQqfD3RZuIpjHmHm065yyfuWzfqLJpGUcvXup1D24viAPjRMBNbnW1d/x4jDybsMpLMH289QhDphCLEQ6WNf9iMLO35DTyVVEalRBVakpyjBd7nR95+iJB+/3SE+vXRjhuNjmeFfqu2aH8sE4y/3iYEcJtR0BX6ypjg1iglnmaqzCI8SkjMiGOKwdCTjE6HEfVb6x9xk7FHiOqs1wmDnGe0RgcRbiA4By242zAolmSoEUzhGymI2c3IFh1t8SKif+0nm1EVEz+OXB6ZS0eEvqZuGK07e1diJr330mnyj5gl8aV4wqrPx0lu9AkzSuFVm/MabFc3SJRPbn2H55H/eH13U8wQ79j1EwYAtnV0xcw4hyuSFmU2KZlRboGlO0fZduAPiipOC0lOCnBO0p1fPOq9Y+NkfVSV72W26deaOFdcqiyhN6kPnC5eylrkiZWFUMtsn1vIraC6f41JvvgCcUKSBHla7FH0E4Ch7rfglBXWP8UW0A0CldkJXQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fa40af6-5911-4ad3-9b98-08d84fa0ac3a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2020 00:31:18.3414
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l7aorrgOHSFIiUYpCgkttrzB/KLbBMRwwL5gVe93Q/E8sMZqjgAVCS4IPlVEPYd8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2581
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1599093066; bh=eYm+4T7OWXOFjKRbL6eJ4LiFyDkSq1RU+aM2ArZL9sE=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:Authentication-Results:Date:From:To:CC:
         Subject:Message-ID:References:Content-Type:Content-Disposition:
         In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Originating-IP:
         X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id:
         X-MS-TrafficTypeDiagnostic:X-Microsoft-Antispam-PRVS:
         X-MS-Exchange-Transport-Forked:X-MS-Oob-TLC-OOBClassifiers:
         X-MS-Exchange-SenderADCheck:X-Microsoft-Antispam:
         X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
         X-MS-Exchange-AntiSpam-MessageData:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-AuthSource:
         X-MS-Exchange-CrossTenant-AuthAs:
         X-MS-Exchange-CrossTenant-OriginalArrivalTime:
         X-MS-Exchange-CrossTenant-FromEntityHeader:
         X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
         X-MS-Exchange-CrossTenant-UserPrincipalName:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
        b=f1Mn0D1HAXnouA/XEiF/lRu6xkMhZFoMJFQlQdJGBiC11+24KOKHQJ3TAX77wKGXw
         NbvujiWGISkwrIMRc387kb/2FOQkqpYsFpA5Ac+CjnAZklWghodcgxL89+vpYq3bnM
         7ngSh20R7i9XJb6Q5IJbpNZRCqYSlGHknF+RGUdLTZaYnX5OugufftUFxjfJIgGoha
         Q9TnxzOsREmp+JATa2K8a+Hac0GHgnPkXp1TGU7aU1feUZCv/9rFDaBZ9mSLjGTQ+s
         G6nZMiB4tiieUZ7z/sAN5rEKAaHjOuPiSqC0BftN4X7A8uxdZzmvBYNnaoNwzT7ANr
         GZyqSrLAh91wA==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Aug 30, 2020 at 11:40:03AM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@mellanox.com>
> 
> The HW release can fail and leave the system in limbo state,
> where SRQ is removed from the table, but can't be destroyed later.
> In every reentry, the initial xa_erase_irq() check will fail.
> 
> Rewrite the erase logic to keep index, but don't store the entry
> itself. By doing it, we can safely reinsert entry back in the case
> of destroy failure and be safe from any xa_store_irq() error.
> 
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
>  drivers/infiniband/hw/mlx5/srq_cmd.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/mlx5/srq_cmd.c b/drivers/infiniband/hw/mlx5/srq_cmd.c
> index 37aaacebd3f2..c6d807f04d9d 100644
> +++ b/drivers/infiniband/hw/mlx5/srq_cmd.c
> @@ -596,13 +596,22 @@ void mlx5_cmd_destroy_srq(struct mlx5_ib_dev *dev, struct mlx5_core_srq *srq)
>  	struct mlx5_core_srq *tmp;
>  	int err;
>  
> -	tmp = xa_erase_irq(&table->array, srq->srqn);
> -	if (!tmp || tmp != srq)
> +	/* Delete entry, but leave index occupied */
> +	tmp = xa_store_irq(&table->array, srq->srqn, NULL, 0);
> +	if (WARN_ON(!tmp || tmp != srq))
>  		return;

This isn't an allocating xarray:

	xa_init_flags(&table->array, XA_FLAGS_LOCK_IRQ);

So storing NULL actually does delete the entry and clean up the memory
and the store below could fail.

I think this should be written as

   xa_cmpxchg_irq(&table->array, srq->srqn, srq, XA_ZERO_ENTRY, 0);

And the undo below would be

   xa_cmpxchg_irq(&table->array, srq->srqn, XA_ZERO_ENTRY, srq 0);

> +	xa_erase_irq(&table->array, srq->srqn);

And this is racy since the FW could have reallocated the same srqn and
already set it in the xarray.

It needs to be xa_release_irq(), which looks like it needs to be
added to match xa_reserve_irq()

Jason
