Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD9713A04DB
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Jun 2021 22:03:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234309AbhFHUBz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 8 Jun 2021 16:01:55 -0400
Received: from mail-mw2nam08on2045.outbound.protection.outlook.com ([40.107.101.45]:37536
        "EHLO NAM04-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234494AbhFHUBx (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 8 Jun 2021 16:01:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GSOlCk4q1fPKpD2ziYAKA+iz47NdfceP8u+ERFbD6AQzEwb7f8xGQtQXC7o9seLVHoY+r8yVaPnI/UBarlwV8ndkOnA5oD0dK4n19C+gW66pkHSEmGMQ/+pigCxO+fKLmUjoVSZRuTwO9f37ow/VDj8nm31vkcb1EGmm6w/QjAi7GSFQ/7B37NwQ56WschZYQclisGYICMqpTewD2zRodpjnwRwiW3B/6XMEYA+xuwLFB6ZN0FOzIFBvffeNil9+o6FD/2gOb0ybY8t+gChxo61yEVWwNCSxtenk7BickPokoojMi+Xzb3Z3PNUyieeBxDime56zEU59JvhyKheXAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Z+jfhmtoa+ekFtBhkgpTnoKq09OpwRidFt+24Kj0g8=;
 b=XJqftkdN8MYuJ6a2GOCwd6EGDy0X9prPK70hdjBdQBIHGvSIysHroz7lreTZ28JETu24O2aFgr47FzZJGXfELkQ6EY7wxitKzwPPuQ3cnlEm/z3KZVbg17llVa+VnrkLZLDUlX288chqbl5CqrskmZTKQvRvSDJb9iY5ZSrCnNQ4lfOYPmH16shNfQb31F4fkQNk4aDio+cbVo7t5nqEPzxSCAUwEmFKtyaRSb55hmKqKZc7rKO9uv6VX9/heDIaVw3O0JuUu6iMAb7YVEGkmjSQ1d6W+vptqSMUDSXn/JfA6oMyQ3pdLBkw8xFH24pYhNzZKolHbDnOerjxJbzvKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Z+jfhmtoa+ekFtBhkgpTnoKq09OpwRidFt+24Kj0g8=;
 b=A/ExgJ47PjLx2QT2UCOoJLSGltdMi5ZhLyV/xJa2W5t4+r/7fAOeX5qojdtK/VWG/C8entUfnnBflrDw2H0QCUE4vNlJG7A2M1TA4hfaaztpbAQgsZcbKXIOlSsxC92RWLezr9Rf7EoDD57mMV1iQQ6hchYHshzH1IE5l5ONlAA01BJKfoV8NymvvliStzKvCw7wNwnxkRYIQHpHglW/+KWqbssTJwZdmYUuB3pYdlBSRDEU7I7lsQQXqpcqoc16S2LDyvxTOfay9axrbKL0inBSXZCQpNIx4bkdy2ya1XQEs1PiG+fAyJc1SCXx/MHW0Ij1HvH+abvZcTLEGvz8RQ==
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5272.namprd12.prod.outlook.com (2603:10b6:208:319::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21; Tue, 8 Jun
 2021 19:59:58 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%7]) with mapi id 15.20.4219.021; Tue, 8 Jun 2021
 19:59:58 +0000
Date:   Tue, 8 Jun 2021 16:59:57 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Shiraz Saleem <shiraz.saleem@intel.com>
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH rdma-next] irdma: Use list_last_entry/list_first_entry
Message-ID: <20210608195957.GP1002214@nvidia.com>
References: <20210608194413.591-1-shiraz.saleem@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210608194413.591-1-shiraz.saleem@intel.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: BL0PR0102CA0040.prod.exchangelabs.com
 (2603:10b6:208:25::17) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by BL0PR0102CA0040.prod.exchangelabs.com (2603:10b6:208:25::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21 via Frontend Transport; Tue, 8 Jun 2021 19:59:58 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lqhtF-0049x6-Tn; Tue, 08 Jun 2021 16:59:57 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2c1d69ef-fe9e-42b0-e5ab-08d92ab7fe74
X-MS-TrafficTypeDiagnostic: BL1PR12MB5272:
X-Microsoft-Antispam-PRVS: <BL1PR12MB527272E602D5BD4941507334C2379@BL1PR12MB5272.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2089;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZQ7/ExHvWrkrvSF5IdeUf89zew6n6By1cngaHOUWlWcuyrqFvU2Zbb0tnHrJdpQEoO2KTxTv/VgxZ4/S7oWkbwL4s8ZoyPchILolWU8k4yQ/chd4esZ8JS6sXKOP9ZredYualcva58JX2LU/H4tHFracS95iJCfwRJBAyR4jZjBJqTMmqrThTMXlQeDUsXLoZfMTi4/6K+4h054rh/d1dmGGAgrbtGoWwLjrLi5yQnT+dGm6DWV1sfSIfPDxvwNabT4cIoWMUywQ5flg6mobNVD4D2y+Gtcvwr5ZC1+AF7kW8cb5FmX+eza8SpBCHdrrcYj4iqo2IZm1Q+kpYri4N4FkiPu6B1NGDg7OXrYR9jyhd3uYWb86M4VDFyqoKjnjrlyr/YuQlE1cb1A1OdNldloSZz4/TFMMf8mxrYrWOU33jNFO2lLgPU9PfZPCvDFg74fGOmcIewZvrzd3BZyJnks7cGpeEJ+UZfHi3HLb1BAM3ujEWQz79jgnTj1Ho7rAolNMvGZmVe3Ut1e6RUFfNFf22fHzqgh3TLkoWyXRUz8KQol22DQh7XushOQ7YXKqJ5mmn+vuALZI3EAjw4zX1PzPh8M5QhuMB8aXBGdi3B0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39850400004)(346002)(136003)(396003)(366004)(376002)(6916009)(426003)(36756003)(9746002)(9786002)(2616005)(478600001)(86362001)(186003)(38100700002)(2906002)(26005)(66556008)(66946007)(316002)(83380400001)(8676002)(8936002)(5660300002)(4744005)(4326008)(1076003)(33656002)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?V8p+vfXhwwbb+zBsJ60ms4kTuVhdMrKAUzAs5851nRcDnU4yQ8M2EsFjiSj9?=
 =?us-ascii?Q?+BhW8DJg90EGf0nWLPYw68l5nTHK89Xbn5FuVolKd9NvRwjO1mT6BCLRnOrE?=
 =?us-ascii?Q?zm99fq4NpQTYtPGAc+JACWA41N3Bdi0B+77EJoeKZ/7oKAjFDipUBCOt1mFa?=
 =?us-ascii?Q?2W1oUBmELgVmtSay1dbRuKUcyxzNkhgJCHKRQL0J0fKR1aiX+5ZeZvrZeexF?=
 =?us-ascii?Q?aasCnjKMK0JAEZSd5MJwVv4YwkgEdX9bwovamtSNRAvNvZi55sXqF0xQMIz0?=
 =?us-ascii?Q?ATud8nTTgpPBVXfroi/TCnOOlOtCuEmy9hScO3p0d0dRhyD/uLxe4zvgmE4M?=
 =?us-ascii?Q?0gkhroLDf5Y4VsLdiy+rNs1lWvh2caB7/PF5mTLpmLQZPvKlw2KNLskiEyzV?=
 =?us-ascii?Q?8gwuswN5l4DbLr3VaiQw3fbzbPsEQbqG16Wfiep01FurlIhFWGeCq/TvujWn?=
 =?us-ascii?Q?ai4Rf68etVOqARgSZ6iFv75CqpbZvwmrz8nBDE9TNLtDzulfltPQQuCn4qex?=
 =?us-ascii?Q?b+XLp60rFVePa6eExL6KCBgMkzWQgYUKHRATFBzHVB+Adaq51ttBjQ2y4Yk+?=
 =?us-ascii?Q?p1V9f+99aie3pb0ZNwIEI5+19bQiEL5dWBZziTsfZ9TV/+MK37J1HsUOMSlJ?=
 =?us-ascii?Q?xI8i6HG5TO9D8c1VPwYzzUF8v/O0Ymf2td4tS93/PWnUs74d+kqBuiLASaPW?=
 =?us-ascii?Q?Y1IuyCFdBxI+CCWtYk6RN0LnQox+iEfWokdHcZ4FZuvwUKJ6YBVYKks/K/De?=
 =?us-ascii?Q?cndOhc4zmqSE6v12DaRvjlDahyAM/2Lpz9UgB2uEieJGkt9HFjSFXHQ4Iosz?=
 =?us-ascii?Q?oYO9uTR02c3qJjElVsJYvShFh3ZdpdifN7Ul4SH9KcuVk2fIzMOLbUc9GMsc?=
 =?us-ascii?Q?sqiLVjOLdO4jkfBCgy6i0vDK+szm+itCyORsnQ1PaDR+bphh3qSH5MqveKMC?=
 =?us-ascii?Q?OEAOgWs1Jg37vuHJE+uvSpeCH3dOa8ysmj1Ia0v3rHxqSwDzyV4unTT73DR2?=
 =?us-ascii?Q?ctUYWnBRuI4S3Z4lFjuCm6kJyCPZiyjKDr6uau/t+PyH7VEdETMc2iHQ07nz?=
 =?us-ascii?Q?kju8ipbWrIQTZxf6QxPhKyrgfBBb3Ejf/BDUJ68lwKRBhbWb6ZXoFtPjWZdB?=
 =?us-ascii?Q?8urnyzUKkAG7M6dY4tVNzT0qyeG8iXVnXJfu13qdRyH4ZO+HfJoqvxROgZc+?=
 =?us-ascii?Q?uZnpuxQOaAU9GmzlJSYMAuxzZ5vy6XmJ8fhh8Dyvw+rhG+3MrKyjfnBYNS6/?=
 =?us-ascii?Q?yqXdaAECbE3FOoNgv2tHqyog3LbYHbZrQ6Ehs7yaer8a9twiPm7jDm6xiIfR?=
 =?us-ascii?Q?7hUttn5XNrGTQKunfLKZnrqx?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c1d69ef-fe9e-42b0-e5ab-08d92ab7fe74
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2021 19:59:58.6927
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Snape+LfceM2WmLLXS60sLRg0DGldzozw4w+TTLsx40GTbID7fPWl//069kh1jal
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5272
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jun 08, 2021 at 02:44:14PM -0500, Shiraz Saleem wrote:
> Use list_last_entry and list_first_entry instead of using prev and next
> pointers.
> 
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
>  drivers/infiniband/hw/irdma/puda.c  | 2 +-
>  drivers/infiniband/hw/irdma/utils.c | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/irdma/puda.c b/drivers/infiniband/hw/irdma/puda.c
> index 1805713..e09d3be 100644
> +++ b/drivers/infiniband/hw/irdma/puda.c
> @@ -1419,7 +1419,7 @@ static void irdma_ieq_compl_pfpdu(struct irdma_puda_rsrc *ieq,
>  
>  error:
>  	while (!list_empty(&pbufl)) {
> -		buf = (struct irdma_puda_buf *)(pbufl.prev);
> +		buf = list_last_entry(&pbufl, struct irdma_puda_buf, list);
>  		list_del(&buf->list);
>  		list_add(&buf->list, rxlist);
>  	}

This doesn't apply, nothing like this exists in my tree??

Jason
