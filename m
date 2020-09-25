Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB6FD278772
	for <lists+linux-rdma@lfdr.de>; Fri, 25 Sep 2020 14:41:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728437AbgIYMlu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 25 Sep 2020 08:41:50 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:14243 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727248AbgIYMlt (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 25 Sep 2020 08:41:49 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f6de5800000>; Fri, 25 Sep 2020 05:41:36 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 25 Sep
 2020 12:41:46 +0000
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.174)
 by HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Fri, 25 Sep 2020 12:41:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dtTxpn5j3fjdmC3GqJ7o2I6ZlDplPv8KdLj1Rsw+w3FY5ANun4i3CpZ5ArTYHVik63zGmAMMnZAed61bq0McJDNrODXKZwnkIMSHdTNB0jtFMvd2e7OezNOH3A9vV62qEowLjgppwfESoBWS4o+/44bUl4EFh4uyxwjzlVQZBkweaLrgvUScO7+YJW5j5u1pSb7/3l8SOgVkhqHvbVk8NMdbkib1P6k4wr890jKIR7MSR+M2O3JbRlBHPoBg1XjpEG9J5WlWdyxJNjc2T2MGHxXwDadbFgfdafYY3nb5kKc5NIlr+YMWIHhhzsXStqkLZdl1GOtSiy1M/4AXoNwUgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1JEML9rOoKaJi8PyEMPsvJMq03kSfRiki1ARmOSLpxk=;
 b=NUK/Npc6kRicDt+Dh8L4j+gwzT+uXSlIj5Kzu4ML1yDGAH0nb0xfgUjI94iIFVH4NingmnJPY1ynr/5PO1nmfkuG9Ptc3StC9Uyj277IHrhCaaLwKAN7H33MIdKLgeB2H4EIjwXAE2x0gu87wDfy/jx5iYcgdNhfsbAhbS+JrEwFSqWgNW/v9p8JS22vfJVA3PXlBkqtfQAg+VSxz19VrI2ILfSf1yPW39P+lgYrx+hFkbVXQAi3tTz8AzPz9hjXc/rVl7Rd//+zQuyad+iJSkOnocSSOP8ig8gu93QdCRL9arCKySBcWvXszk5oXl9PLrIyQBQ63t8RZzyhrYXLNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3113.namprd12.prod.outlook.com (2603:10b6:5:11b::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.19; Fri, 25 Sep
 2020 12:41:44 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3412.024; Fri, 25 Sep 2020
 12:41:44 +0000
Date:   Fri, 25 Sep 2020 09:41:42 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Liu Shixin <liushixin2@huawei.com>
CC:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next] RDMA/mlx5: fix type warning of sizeof in
 __mlx5_ib_alloc_counters()
Message-ID: <20200925124142.GA193344@nvidia.com>
References: <20200917081354.2083293-1-liushixin2@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200917081354.2083293-1-liushixin2@huawei.com>
X-Originating-IP: [156.34.48.30]
X-ClientProxiedBy: BL0PR02CA0056.namprd02.prod.outlook.com
 (2603:10b6:207:3d::33) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by BL0PR02CA0056.namprd02.prod.outlook.com (2603:10b6:207:3d::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.21 via Frontend Transport; Fri, 25 Sep 2020 12:41:43 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kLn2k-000oJI-IS; Fri, 25 Sep 2020 09:41:42 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 600f23ed-cce9-4939-2487-08d861505bd0
X-MS-TrafficTypeDiagnostic: DM6PR12MB3113:
X-Microsoft-Antispam-PRVS: <DM6PR12MB31135838D25A2F7FADD41582C2360@DM6PR12MB3113.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TLmV4nmRDgwVTo8qylLr83GK3TirHf3nLdDQPR2zP4hwt/n90H4mbHk/0JQ/kvqFCEb9yqWwIkR6meToPfpR2qQ6lrsoIZmFloAfun7KcJzvLWJQ8CNpVyxQkUa7Uvd5l9X7bmdxeu2bxgS9tYsGTFRsXNotH0JgdWR9hD5LPw882lzZAy1LcRva6ZgZGUF16HfgnyTQ5AEh68+jNliHkOFKNygwvlGV3GvlVJy2cMDZwuEFsb52TZg+xJO7awR8KES4mj3pWlZlHqor5epUhmmdd9Tb+e96NkWx3Sdj8pBtN9HVF4pBbsq7MacunJ58gGAwXUf72hulH4d8srBXXRDOg2Ik9adlu12kNfidu06ksVlez59GW0GT5w0q0iOS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(376002)(136003)(366004)(346002)(6916009)(316002)(5660300002)(8936002)(4326008)(2616005)(9746002)(8676002)(54906003)(33656002)(36756003)(2906002)(86362001)(9786002)(186003)(426003)(66476007)(66556008)(4744005)(26005)(83380400001)(478600001)(66946007)(1076003)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: B0o+T6lIZoHFK6W7dmZ6+j3lBP1/KHTzxk+1UQ1lNY7NQ15wcN5670adnfQxL7kYCGhEWctimwG9ohEBuz0b6pezKsgWIwD6EFGhW3RdrDV3RYkg2ppeX5SDhyFeQuCPZVcqVN8EdEKIIj/Ln6+MH585y8EMWo+Q5oSS4NPBDkmZMFHJWxRYBRIGs1h94nlrDym+o8MTz9EUj8mPD4h824iqyOT721AN7Ky6Cxb00lNdG2XG96dN36QeP3dRGInxjhmw3LYlewB2BxgBex3UPP0sFTW6iJUVUV8OREdbJ/MhKXJs0upfFsG3s8fA6hWxUam2XxdexfhKpeeXKT8DdG3tu5qo8Dm0YAx9ksjnexR1x1YRACpKWyp6mXEsoNxRswE09/bG/AURcMGNKpTeIpMJ878xaHoRjyoOVL3G3uRdkiPwuaNrlOyQt87y/TL7ST5zeB7MHKq2Hchs5g26P14QdLQVHNSCSjRHTaATwpNuhszvfrvOt+GBL+il+DMTd/1wXlK2zdtowkZrji+wi+I57HXiDwM4BMWcym1D4VoETS9FrKC8Havmi6PaBov7jLek/X1p+7Sv9n1hFHn34cr12ni7Mu23foh+xW1BnEFNxU1G8Yg9aVxccy3asV28Fonxs31vHdWhi1c/+qql0A==
X-MS-Exchange-CrossTenant-Network-Message-Id: 600f23ed-cce9-4939-2487-08d861505bd0
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2020 12:41:44.0899
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /gJKR6a0ItlNp+dNsH4TUyvCGcH6wkKBJuWPKWLQ8DgyztVd/e46+dv/AUQcYc0H
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3113
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1601037696; bh=1JEML9rOoKaJi8PyEMPsvJMq03kSfRiki1ARmOSLpxk=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:
         Authentication-Results:Date:From:To:CC:Subject:Message-ID:
         References:Content-Type:Content-Disposition:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-MS-PublicTrafficType:
         X-MS-Office365-Filtering-Correlation-Id:X-MS-TrafficTypeDiagnostic:
         X-Microsoft-Antispam-PRVS:X-MS-Oob-TLC-OOBClassifiers:
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
        b=qRSVcuscwrdAJ8mjgT7yV07v5b9FdOGBq93SyOLoyIV3lnH1wRBSEZJ3fL80Y/xj8
         PzmL9G5WxshPslYcJKGSiGZh6YpT0V+pIE4T79VdPu/8/oVAw0CEruavOOeWf0UIMv
         vGyE9XTKsLEAP6Rvh3cCfEjx2qtS2wr5i2Xt+cVfmz9o2pMEMrcFh2BabjQ6IVx/Cf
         nHqHXYQqzb4eYafTVDA26r4a2OJUbW40ZK7goSkW1knaQbiGK33APHfis1/nIzG1dG
         VDmzkPXVd5d3tJXv9YFz1vDK+SeZF9cKTPbMOHJnen6wGVSb5PZOhBk5wp1JWqWEb5
         d5vR4L+2MZJyQ==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Sep 17, 2020 at 04:13:54PM +0800, Liu Shixin wrote:
> sizeof() when applied to a pointer typed expression should gives the
> size of the pointed data, even if the data is a pointer.
> 
> Signed-off-by: Liu Shixin <liushixin2@huawei.com>
> ---
>  drivers/infiniband/hw/mlx5/counters.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied the original version to for-next

Thanks,
Jason
