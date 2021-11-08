Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7283447F87
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Nov 2021 13:36:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238126AbhKHMj2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 8 Nov 2021 07:39:28 -0500
Received: from mail-mw2nam08on2049.outbound.protection.outlook.com ([40.107.101.49]:10528
        "EHLO NAM04-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237481AbhKHMj1 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 8 Nov 2021 07:39:27 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N5vONHSEtcZjNAj/Uhk1SYzAGrqMiM+YzgK1KA67eU1HYpGHsv+JkSQQWqnvvdMfl5cba/pkjodXfmpRNSwGCPTjeP9MR/xq1WAW5iAjoY+44/8cqj/c2hzuFYAFzS8286f2xC/GstvX9TgDtl2CprCHtcBvGpTxp/A9F2h4YDVfZQCr3WjMCMFkb92uatOgzhz5isWmTmcWrit27KTa5Ddxu2jO7E3A3Dj24N4X+3csEaifMPD/5pbxCPQ1xmzIrjoOFQTG0UERHhl1nZdw5lVcv7QSsiGAKBpfS1Bsuvuk60W6T9YbP63MacGcca4pVASYypsgdRMXBats7Oms1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bHsOdidPXC7nyS0PaTY57x7rG9XGlvPD+xWBHTF03sc=;
 b=kd9UPnvi1AeuN6/4KlZphjL4yFrITI2QIFVUsSXn5HVc2KWwEdjKL8Ukceh6iZhEIuVoH8ETbNqnshZ2kj+6rAFE6CxWinXhpf9yfCP04xzJD1cTmAvVN/n1Sn79TYHa5Sly6SWI+o6peZoUH8SS3tcDtTsZBDkcJHS0sKGa3nH5OfIaog2I7NLiUqtelIK6iDqjb56KK2WbdFhaaaXEiU7AQY+ziZdLFkxKpyLRXH+0oAkkwbG2e3CAkdtq/SQS/BzJqJxAUp/WaSHBIqjrJ4IQdftliQ87Dqi2tH+OWI7ZUvNTdNHhySiuNVOQvyNViCfbuQj1rlIFSRBtU6TKtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bHsOdidPXC7nyS0PaTY57x7rG9XGlvPD+xWBHTF03sc=;
 b=HeEk9QdjVm6REMgrG2DFE/c2SQlk3PAlInXlj51pBZulVnrxPkpY1kqxWbMT1m6i9v/XuCSn/IYqMFIX+6/5C5Xq4/WTAAYG2sqPIjHN9HKEak67xXMYrYeWWpF6DuA3QO3zpuSKdtRDO1omlZyzl8WuK6O7oG+/R11KaM3yiX6wvElLg0tHzJecGJokDFc2AXevEtSPhUK3fM3ZX8AKofj+jNsPlaY4wbzOl8xc6E89hzoRKJ960btdognnhr7IY2Bp2XsBEywlHgrJTI1J4HTvTkUJCo+ggbh2rCDW8Nva9N84uFdTlbkPYjNh32b0US1cJqWvL0Cxo2kWvqkvaQ==
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5320.namprd12.prod.outlook.com (2603:10b6:208:314::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.13; Mon, 8 Nov
 2021 12:36:40 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::5897:83b2:a704:7909]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::5897:83b2:a704:7909%7]) with mapi id 15.20.4669.016; Mon, 8 Nov 2021
 12:36:40 +0000
Date:   Mon, 8 Nov 2021 08:36:39 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        kernel test robot <lkp@intel.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-rc] RDMA/netlink: Annotate unused function that is
 needed for compilation check
Message-ID: <20211108123639.GT2744544@nvidia.com>
References: <4a8101919b765e01d7fde6f27fd572c958deeb4a.1636267207.git.leonro@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a8101919b765e01d7fde6f27fd572c958deeb4a.1636267207.git.leonro@nvidia.com>
X-ClientProxiedBy: BL1PR13CA0023.namprd13.prod.outlook.com
 (2603:10b6:208:256::28) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by BL1PR13CA0023.namprd13.prod.outlook.com (2603:10b6:208:256::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.6 via Frontend Transport; Mon, 8 Nov 2021 12:36:40 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mk3t9-0078oN-Td; Mon, 08 Nov 2021 08:36:39 -0400
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 89d5488b-7ec8-40c2-4cdd-08d9a2b46a04
X-MS-TrafficTypeDiagnostic: BL1PR12MB5320:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5320F65BF953BEB75DBD9B6FC2919@BL1PR12MB5320.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:590;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FUlWBugmSpOBe9p+WPiWkEa0HZJUHy8v4F380nD97+Ho61wZsdEEE7GQm4ge67xdBz9CzHSopNmvf5SI5ms0kQqyaeUnr4x7m0nfi6CBGA1g8O7TRfvy3Jr12uPleXb+5YW8Uo980iaUHmfl7ITT0LMpohYQqOGi5XrZibS4xRHU3hubGW1WXdUp8VNPgOFMej29Ry0JSG46586xJla4Yp6ilLOxPhmKQ8eGCJMJxpYAH10wllBEHwqwtieLwgJMQ2ZVvufv9l/IhLQ85nBVbXqU3zLUmfWTlJjfDdIyWuBakAgL7FBqv7UCqRjZjBXVEmAuGMAoe35CsgBpdKh7eGNYMFR5xNAmxvAYtb7zfAzWyTMyOvO82Ad3AD0X2DZRrpheqGBVpJhJtFZt9sYd/D+ok7orRD3AQtuTrF7plDm/I7S6rQ653fMayCyjOKBCWizOGwLe7Iopd3KmcQpYVX3s5sq3l+1VUYZivN9sn9ntm0OmEjLlQut1SEMA+SWLbUut3z4NQPgZO+GKnOUGXFsx0dLM/OPEBhAZmu1HVbIMzAYcyZSHlzVIr/Sbbv+IeNEdjCBreGmoNbDJqe7xOYAeePK1UBCEojNP9Ae4Uge+EmeUU934WqdH6NpTxpue0WsiaFXeihIxzk4CZo71ug==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(86362001)(38100700002)(186003)(316002)(66556008)(4326008)(26005)(54906003)(83380400001)(36756003)(2906002)(508600001)(66476007)(1076003)(2616005)(426003)(6916009)(9746002)(8676002)(9786002)(8936002)(66946007)(33656002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?V0VXcy28U132H9VTRvm7yl6KFZK9mNXfP/7hBr1XfYVhBk68doSV1GBBlLE0?=
 =?us-ascii?Q?giS6Es3i4ZfI/KZKIAn7nUCCVRF3olKdft9aNr6OiJD5K6+0X+aWbWyev/by?=
 =?us-ascii?Q?r7tRvpd/fX7XIEUS14IwIYX10EQfflPaTs/1Dy/2ek/7i9GRiBQYlBADnd5i?=
 =?us-ascii?Q?1ouy7rVGUmmbemTlIMOa4g3cR1+63Zh1YM15K6pRJSkbJecCCkrAMYObiS8O?=
 =?us-ascii?Q?sRtQfKw6Pj/39620cY3uTKw18MHtIhpdqs3RNKk6Gu3754UR4Fxpv6esOQmG?=
 =?us-ascii?Q?NBsMc8kRjKNw8ZDe7OFeB0Jp/vUgVXYeONW3ZE4AluNBQ5DiaFnw8pqdyOl1?=
 =?us-ascii?Q?HjQIavLStKTIvC2Uhq4Odrggdf5UIIUnxaViM7iEw6cJ3lTSeRFL8NOOCWD2?=
 =?us-ascii?Q?KAIMptvpZgBmPP/riQDLAthhnBrL1ABCxwmf8qhfSXbg6O43thBQe71cLJ7b?=
 =?us-ascii?Q?HO+Ts2SiaB8qQkocBkwRggfQGcL5UqFyOWxl2cU/ZFf2hBudMc/DMBkQaeW1?=
 =?us-ascii?Q?m9yWi/r7E5ratpHK4RTQgm6Wh10TjRq9qdygvTnpNCdF1SWVz0so+jyIW4Ga?=
 =?us-ascii?Q?LOLwRnMeX7sKUnJZ31ZPKzhJzONYwys6/j0S5F7gPfuZdduBsNAuxrfZn5v7?=
 =?us-ascii?Q?QVH61QDnP6esD9eGhZjbtbYpsO1Ev4jZNLdf+r8MSYFAm+XypE/5NZZs8wg7?=
 =?us-ascii?Q?mqfcZBUsfnDYdM5dV2aMnOTj8fVXeE3XCneGTdk9H+Q1OpCqNZh4fyC9ZpTd?=
 =?us-ascii?Q?cToYySfdMP43OT9RymfORq2asa8LkmG0qJJX4cqy/EL1C909jkK52zy+YxP6?=
 =?us-ascii?Q?hQLueMpqI+WvmSbPOjs/Nz2u8C0nX1DbH2WOx1MaRK2GT+07XUoFZsNhzLWl?=
 =?us-ascii?Q?eXZE8tbhFsGm41Ah9N89HojfRoz2FvjtlLmh7ASHBSrUvc+Xv4v3QLbXuz4D?=
 =?us-ascii?Q?P1ybMItWzv1AV7bZgihuDH0ItBYzWjgRlkZeMyEKrAYVm5x7CK3m00KPJG3v?=
 =?us-ascii?Q?dY7Toca0c8I3y8Wr0em92/JXqVPL2tXjNPcaFFGG5HaXGHgMruN1YQB71eyL?=
 =?us-ascii?Q?cVuLQoIosQLuOQY90zIvG6SQnGryYO7ZPQIZ3c8NKg2E6AKyesVqT9K6JFrp?=
 =?us-ascii?Q?uaU/2ihj3DJvMf6KrPPzpI5i3JMMevGyRaXw2HqZcBzydyhVekerylij053m?=
 =?us-ascii?Q?A8/Tgpl0ch8XBfNVNSJXEm4nNwsGEtNkkkzQkzm/Hp4t93EcX0D9HvKENoAe?=
 =?us-ascii?Q?lwb2tJkYqZEsMVBnMqf1YszOKj+GKnfDgz8yoncmIhbY/YfEZWDivysEFdjG?=
 =?us-ascii?Q?Fyiu38u/5O9EsaeANh5W1sjiIbh2BFJ3dnGttl0bYDI4uTtO7RxrjnEwBbom?=
 =?us-ascii?Q?Nm6DbVPfhcMdAJrmzxpwDb+EM4NnViTHcXiShYirfgJd9EHYPfou6/uO5GHk?=
 =?us-ascii?Q?PiXAOTWQZGVoFKmRSoUV6ILPNf7PYcQcQZ94ZawDS7TEc2ypYRJ58sFHfmk9?=
 =?us-ascii?Q?NbIm0JKXbWrv1OMSHft+17SxnWM2k66jDrBy2qiRhkWoZS+C44uWK1dwQbyP?=
 =?us-ascii?Q?mmchbtxICw8ZC6KxlKg=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89d5488b-7ec8-40c2-4cdd-08d9a2b46a04
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2021 12:36:40.7987
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DLOSjsh9T7QctpFm/MPntqnKk88YY/cAZ0JUpfClLj2hYsabQgn+TK4XYR/+zTX8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5320
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Nov 07, 2021 at 08:40:47AM +0200, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> >> drivers/infiniband/core/nldev.c:2543:1: warning: unused function '__chk_RDMA_NL_NLDEV'
>    MODULE_ALIAS_RDMA_NETLINK(RDMA_NL_NLDEV, 5);
>    ^
> 
> Fixes: e3bf14bdc17a ("rdma: Autoload netlink client modules")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  include/rdma/rdma_netlink.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/rdma/rdma_netlink.h b/include/rdma/rdma_netlink.h
> index 2758d9df71ee..c2a79aeee113 100644
> --- a/include/rdma/rdma_netlink.h
> +++ b/include/rdma/rdma_netlink.h
> @@ -30,7 +30,7 @@ enum rdma_nl_flags {
>   * constant as well and the compiler checks they are the same.
>   */
>  #define MODULE_ALIAS_RDMA_NETLINK(_index, _val)                                \
> -	static inline void __chk_##_index(void)                                \
> +	static inline void __maybe_unused __chk_##_index(void)                 \
>  	{                                                                      \
>  		BUILD_BUG_ON(_index != _val);                                  \
>  	}                                                                      \

This is a compiler bug, static inline should never need maybe_unsed

Jason
