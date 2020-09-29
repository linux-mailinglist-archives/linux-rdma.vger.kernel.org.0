Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5520327D3CF
	for <lists+linux-rdma@lfdr.de>; Tue, 29 Sep 2020 18:45:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728186AbgI2Qpg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 29 Sep 2020 12:45:36 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:53473 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728299AbgI2Qpd (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 29 Sep 2020 12:45:33 -0400
Received: from HKMAIL104.nvidia.com (Not Verified[10.18.92.9]) by nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f7364aa0000>; Wed, 30 Sep 2020 00:45:30 +0800
Received: from HKMAIL104.nvidia.com (10.18.16.13) by HKMAIL104.nvidia.com
 (10.18.16.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 29 Sep
 2020 16:45:18 +0000
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.103)
 by HKMAIL104.nvidia.com (10.18.16.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Tue, 29 Sep 2020 16:45:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NLbWjTjJQ7O2NXdZBzkGF8lGwE/mxC+KNkVGzxOXNwsbsajylk/O/H6Qpet1xwIjJ0bB6bYpmKBjw7lACiQp3x90DP+XXT1EqvoBsanEYYldtXgbn5vpI7RqXr0W/K8Bmw0xPKTTQZC71mqx8JXkd84EpgVT/gL0kiXTDcc8CLH5R7ZC30YSwSUd6YVZ3PQtRQAmq+jshrQgZfkVcyYr82XjUrhhvZG/A7v+TWQbohOLmi5hfXmu1tdTbtBU3R71SyylnZCeXI93xvS41BYK95ybix1yPMBshfgSJb/ZX3VtbHskwYlwqSqACyLO5W078rMkWR2/ZLgUSR5VBdc39w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uUW8xTUqm/2zmdEvKwnnpRQoG5l1sFAtVdjFS6FgOn4=;
 b=EWtGuPl3MWgCdelgQqkg/gqaKUOKpznZ8G3lSfRwxRcWQpqWE9tPKZij4NR+Y5e9VL1bOYMld6IUOwRa92jBQlsGXhzL+EJlWy4H6pt4jTwLcnRIfrZgQlbdhq8XfjP4xn0ggucRAXErK3r48slwF2xGKwaTVyLNLfqGvjcAmVWUCi1YcPoedanV6LjIeuvdYcurxtYSoMayTVeU4AH8pOmlVa0mJVdCJB4PoX3Wmy+Oys/JfxVUv9M7VslK55SVU5EV70pUKjLxADKiYupzpoH6ZwK8luHfuEMgSfHWbZiCiQYFZ4xbxJCHucTcn7+GRSdWQVC54O8ZqnFGwNlJbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB2812.namprd12.prod.outlook.com (2603:10b6:5:44::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20; Tue, 29 Sep
 2020 16:45:16 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3433.032; Tue, 29 Sep 2020
 16:45:16 +0000
Date:   Tue, 29 Sep 2020 13:45:14 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Adit Ranadive <aditr@vmware.com>,
        Ariel Elior <aelior@marvell.com>,
        "Faisal Latif" <faisal.latif@intel.com>,
        Lijun Ou <oulijun@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-rdma@vger.kernel.org>, Maor Gottlieb <maorg@mellanox.com>,
        Michal Kalderon <mkalderon@marvell.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        VMware PV-Drivers <pv-drivers@vmware.com>,
        "Weihang Li" <liweihang@huawei.com>,
        "Wei Hu(Xavier)" <huwei87@hisilicon.com>,
        "Yishai Hadas" <yishaih@nvidia.com>
Subject: Re: [PATCH rdma-next v1 00/10] Prepare drivers to move QP allocation
 to ib_core
Message-ID: <20200929164514.GA756519@nvidia.com>
References: <20200926102450.2966017-1-leon@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200926102450.2966017-1-leon@kernel.org>
X-Originating-IP: [156.34.48.30]
X-ClientProxiedBy: MN2PR08CA0013.namprd08.prod.outlook.com
 (2603:10b6:208:239::18) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR08CA0013.namprd08.prod.outlook.com (2603:10b6:208:239::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.22 via Frontend Transport; Tue, 29 Sep 2020 16:45:15 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kNIkc-003Aog-Pu; Tue, 29 Sep 2020 13:45:14 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 87933e5d-dc21-46a8-807a-08d864970ae6
X-MS-TrafficTypeDiagnostic: DM6PR12MB2812:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB28120454B7A023B9CC299D92C2320@DM6PR12MB2812.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2449;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DZ+0LffQkns1aBeurmNE9dEGxL/sj/YC+bGNxulQ27xuhA5GOlQn74OyFOPSFuQpBSItNl1C+Yyh+6oZdi0fLgbk95wLFrI106b+t/6LZOL3BGXcKrE14Fm0fREXp6Gd9FNTnb+u8sdimm679qzpejQQIWm0KexzG3HNKE8rxfK/KwKCucdUWz+HPoeyjzhjHe7Zg0X4j79l+TFUkuaUawLzkcXzJ0Z0p58ZjtVspmKecHryu4D+VIiGoSR7gW1yxTWxMToyvoAwR+vlxNFSQF73GycgopSM4DCKe0GMMCZRjMqxZjd4JccxI8WHRkmTlS79U0zGFrunG2whHTpGAOXcpEg/3tGK/RxLYiuc82AoaomedDZVfhcfd8BXNUb26ytP73COA5uwFhlIiX2OQglQbZVPtxAltF5XtxUR/6c+fl15JAQYL/A9Nwhg4+kCmK8l6ZyZdIFTYfvL2RGzVHPm/4C2Py6QravQPnEgmgo3tqbWf/U389VbMu8cwHLN
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(376002)(346002)(366004)(136003)(1076003)(186003)(4326008)(6916009)(66556008)(8676002)(426003)(7416002)(66476007)(83380400001)(66946007)(54906003)(2616005)(107886003)(8936002)(36756003)(316002)(9746002)(9786002)(26005)(5660300002)(86362001)(966005)(33656002)(478600001)(2906002)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: WoYAZbmTEntjlOB3+4KyJugLFXLpCVJGfa6BWU5f67QMluSUSnzFrBmrLeYoxS3EsUYduKTJgKfN/EFgLEaI1V/JwHyytd1GEldYwRfzUzG3msfC4RWRMRb9o5nDXXmp+m780OFh74SHvkGO6XWHP3U8hnLq16pilp0Zoq0kz4O6v0/K5QSVLxCHLQknkgIpSVgWevZMHSgkIg5D65mPKr8JCzuMShi+W+bicpANHM+gsjFvLydrv2OqXSIWOaCl/BgSGnkMXvVrqkQtn3FfRmBplllLtapgWDts9OrhyOWpWuVnkS2uH5c6CSL1O9LppwkzyRvD3A29hcDR8AFhEk7erig6VcEhlqXhIEAwlzprEMfB0fofzBZC7H43PXmG1rJecwSQbqOR1dNqpVghPIXSWqPab66YrvN+7Rqmtb7n1SKU38M9SLEHuQrPHo3ye8IbmLrkIPZNpjMbhLeM+yC8Wt1d4HvaHbDevpCDhvH2aBZFS0gFuEd6SVTHuUWgxZOKxXqe5mxtgJqw1NUzjt4V+5J4Tmv1xuXfb0YAbYT8C/sK6Ovm9UXwiuT0EUpajP/nuLoVf6wJGNTddobciIbSQJcyLbr9GTQ+BgtOhqiDbQJC5S8T1KU4GnMN75I+F6ZsoqO3tHxehpXFHejqQQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 87933e5d-dc21-46a8-807a-08d864970ae6
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2020 16:45:16.0561
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gAt/bJRvbOmKU17p8WOJrJgEcYH7YznVnAaceSFX9EpRQM7V2IHkc8Rg78Ei0vFt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2812
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1601397930; bh=uUW8xTUqm/2zmdEvKwnnpRQoG5l1sFAtVdjFS6FgOn4=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:
         Authentication-Results:Date:From:To:CC:Subject:Message-ID:
         References:Content-Type:Content-Disposition:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-MS-PublicTrafficType:
         X-MS-Office365-Filtering-Correlation-Id:X-MS-TrafficTypeDiagnostic:
         X-MS-Exchange-Transport-Forked:X-Microsoft-Antispam-PRVS:
         X-MS-Oob-TLC-OOBClassifiers:X-MS-Exchange-SenderADCheck:
         X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
         X-Forefront-Antispam-Report:X-MS-Exchange-AntiSpam-MessageData:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-AuthSource:
         X-MS-Exchange-CrossTenant-AuthAs:
         X-MS-Exchange-CrossTenant-OriginalArrivalTime:
         X-MS-Exchange-CrossTenant-FromEntityHeader:
         X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
         X-MS-Exchange-CrossTenant-UserPrincipalName:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
        b=Pq+qmlCX5uaI9CzOecBMZm6aNDcBzPUoVV/dpVuwcY5EEPeb70b6Phz4dQxufYsir
         RTwgc11lTlKMUJpojhvPp/G61D3uIpPOduxHZa0laBuF30tGDu0nx3oOx2AL8AeYSS
         zHy7imzOsNOvL1VMheHGzHOIBoN5BF+vYsMnI/3K8SiOso835ZDTFViFNcv1LlVuSb
         P2+h3k+dVMhkrQh1c3qaid1vkNk412udwPSa5FGCpOZbAoN784dhgvQg4Oy4iyoVh4
         QQirQVfh866Rv4JRPJiEOGo4gPnTBOzj7k/AZaPxpYwaWns7pJw24v4rU3OrfUcB5o
         939eHhGwPtl+w==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Sep 26, 2020 at 01:24:40PM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Changelog:
> v1:
>  * Rebased
>  * Fixed commit messages.
>  * Changed "fallthrough" to be "break".
> v0: https://lore.kernel.org/lkml/20200910140046.1306341-1-leon@kernel.org
> -------------------------------------------------------------------------
> 
> Hi,
> 
> This series mainly changes mlx4, mlx5, and mthca drivers to future
> change of QP allocation scheme.
> 
> The rdmavt driver will be sent separately.
> 
> Thanks
> 
> Leon Romanovsky (10):
>   RDMA/mlx5: Embed GSI QP into general mlx5_ib QP
>   RDMA/mlx5: Reuse existing fields in parent QP storage object
>   RDMA/mlx5: Change GSI QP to have same creation flow like other QPs
>   RDMA/mlx5: Delete not needed GSI QP signal QP type
>   RDMA/mlx4: Embed GSI QP into general mlx4_ib QP
>   RDMA/mlx4: Prepare QP allocation to remove from the driver
>   RDMA/core: Align write and ioctl checks of QP types
>   RDMA/drivers: Remove udata check from special QP
>   RDMA/mthca: Combine special QP struct with mthca QP
>   RDMA/i40iw: Remove intermediate pointer that points to the same struct

Applied to for-next, with the extra hunk

Thanks,
Jason
