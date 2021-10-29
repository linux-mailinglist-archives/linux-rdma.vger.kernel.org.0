Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D47D43FF0B
	for <lists+linux-rdma@lfdr.de>; Fri, 29 Oct 2021 17:06:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbhJ2PI5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 29 Oct 2021 11:08:57 -0400
Received: from mail-dm3nam07on2049.outbound.protection.outlook.com ([40.107.95.49]:25729
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229684AbhJ2PIz (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 29 Oct 2021 11:08:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RD434qfApEQtzhcuEtcGLmJuY7zTsf38SVr+IMUH9o1bHKHPkb3Ap6/tOFNMVHajlDWkz44nPXUIQA7u4lXWjUv8h6TOI5tgdLAVLM/V4JzWweWL/EPRgCwC1jlk1E8wKd0L0EwqSpvNqKR2cvvJvdW3hQuQzROyn5AsahJfrpm+ptbUnk31Q8wK+xanBeuvTOIbNpN9xfAOqlkBwGHJSFy5NUYd6flWmpy9S2RsEmTw2MGz83sIelQXC5R+eE43JqcFFIAVILOLIb42YOaNKxNxkA+kXnvW1qKrRnCvaRLjuGGeoppvmju0z5rhAPaX3BKrU/6Y4X9ApBModvCSxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+CvgTjIJiGCm77eeFf/mk4pBJMiPgeiuQXzCbilnL1g=;
 b=hBQqbSuvfItP2oCj6TlS6q+vB+0nNqlEVDWLzzFSBdF94oRTIgN7bRlYhyaHJfIZJsgqy0Ckhi9hYiJV0sEEFLCwJiUymJFEaHKpmXIrzd33kty6Wm15/n6st+/9FbaqGLDJOZkIIvHYtEhSYGUCKDiUgkhswf/yBEyd7Zs9nmU277QLzTg2l0OO03D3ER5zWz5L7NE/Xve97MYVP6fVE/mPbpmwy4afEKMcyrgoaTlWNOdEgOE7KnNM3rDgkLfx6oeDUW6FhvKasx0ct/ury21tVXEHyYx/QnlZJSXvc6XhnIMxvl3u30190KhFinCmghfES0rBuIvvV4hfNYMNUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+CvgTjIJiGCm77eeFf/mk4pBJMiPgeiuQXzCbilnL1g=;
 b=qOOTwgE6oXWgK4FLo5+kMKM3mnsx/kjT5mdKGOm1C4YZAD7LnTpl3T3mgqYysGewbBOnv0xxdWgsalEcIs7xn6hyPjLYAkn/cO4xFXmofbmePaREhvj1M4+Xl/jW/y0diDvDhrSQsTpSQMjjZupLHvnbgHCt5o6ywXwBDmntmnx0QyvINHMm8tZILF/SqFYio+jwu0qhI/oYo6ZPHtuUjczAGyEeuMOosrL3iLcACzDck0kIjxXb3uqCS8XvtjUegzsVD5CLqm3TP+4T60BmFoCpm3Q1Cg77zCNX8vOHsyfT+a/d5jz9mSUIw3YBac3V8XXL2SsptqlNiPVa+d43HA==
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5061.namprd12.prod.outlook.com (2603:10b6:208:310::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14; Fri, 29 Oct
 2021 15:06:26 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95%8]) with mapi id 15.20.4649.015; Fri, 29 Oct 2021
 15:06:26 +0000
Date:   Fri, 29 Oct 2021 12:06:24 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Wenpeng Liang <liangwenpeng@huawei.com>
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH for-rc] RDMA/hns: Modify the value of MAX_LP_MSG_LEN to
 meet hardware compatibility
Message-ID: <20211029150624.GC834869@nvidia.com>
References: <20211029100537.27299-1-liangwenpeng@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211029100537.27299-1-liangwenpeng@huawei.com>
X-ClientProxiedBy: MN2PR13CA0002.namprd13.prod.outlook.com
 (2603:10b6:208:160::15) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by MN2PR13CA0002.namprd13.prod.outlook.com (2603:10b6:208:160::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.5 via Frontend Transport; Fri, 29 Oct 2021 15:06:25 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mgTSa-003VDi-Vh; Fri, 29 Oct 2021 12:06:24 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 44e66b82-eb17-483c-b981-08d99aedad7f
X-MS-TrafficTypeDiagnostic: BL1PR12MB5061:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5061BD94DDDCA63ABFE08617C2879@BL1PR12MB5061.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bI+O9Fp0T7A/kfylABSQqeasm4S0d9IT9sbJDMCEG9eT00LJBzq87rW+saC8dpK045FswEpwIF1hkHM6lHxzZl7fg5bQGV9fsIO0zD6t0EDvUG40KHxt5yijZk2ZmKfqmVBCzhKw1iszzb8kDk20icrSCI5+trRLjNgO/Mwz3dhHvXti/cMIrwiuKfxGUl2/bd8ZmsG2sRsDx95UHOF9HVn8hhUdXbUvj9uVSQ6gd6sxdOgU/6baswBlfF5mYmOGQut5GPvYoGvLvj8V6skKO5+oStipYx3BBKwPenSDR64XckoVSMoj+QBhQYZQAdsUDmPLZrMFob7Wp64KAML04lX8haalv9Grq0WeNccI+/yI2jTTzrgtZ6QBAw0cqrEPmezQXqNJgrmjq0/ZcVG9LkK3HqsVXfDtNG008Lpvufxt1UgZNtPMaaShL6rXsxTO1sMIRrCUvY0SUoBq8vsSAVH/kwDqhGHGkqeUdrHTTYx4hxCyRgX3AAD9daiR3JkZtlRJ4q5YXUC2GIBOhT0yAuOO0lRpPFc50IPG9j107B5KG1sqGzqou2f/P31/MhrxW8hayXlXIM4VJd+AgIxEx6MIEvisXXR9Fc1VRY3ypmwh5Cvzgxp6rEhuVfOTZFrkPCfur/Ggrwm1+1fW4XkUV2oCW2KkUnNcIy0aXIama1GX1OGlAt9LhY0Wtm4Cz/0T4+DWzytbtewbr4zHEunYyg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(33656002)(2906002)(186003)(38100700002)(8676002)(316002)(6916009)(5660300002)(83380400001)(36756003)(1076003)(508600001)(66476007)(26005)(9786002)(426003)(9746002)(66946007)(2616005)(4326008)(8936002)(4744005)(86362001)(66556008)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jK1/eO7z8rBu1Yy/t9QOX3gqZFljPXtu7SA/DWfsflhzyd0y8I8fwB+yfhJv?=
 =?us-ascii?Q?3naw51g64cSVRohzsYjOKqsquxdEh3D2a/LHXHy+YQwKNZKG2FOdvcWzlOO/?=
 =?us-ascii?Q?3m+rbF13qGv0qL1ZiRh7zgdrObruVk0BOx2nNknNubEP/W14EnnAU/mcDlLZ?=
 =?us-ascii?Q?jBEeqVoGYv/YYjniWSep5igfWQGZkkx608/LHIIt+XSXYmz60S3wVF7mzHGP?=
 =?us-ascii?Q?t/114/7YrwoitJcijgebrC28FK3PZytsiPEB5tYTKrrwe430JKV8UVVjVDcN?=
 =?us-ascii?Q?cU4wON+rv12shTVeLIt6siMK/fx+FJVQOSaReoBZNpyqYNzT0PVhVg8I/AKy?=
 =?us-ascii?Q?b8+9/RpNbwKGEVrX2Mmz9LX8OosRpSfcyqufEtKj2cgRgB4rsmP1D+d/SkQb?=
 =?us-ascii?Q?ShaS+CpkcqhsKeaEqF9gXOuILr+UEx9qvvOV7L40gyqY+E6aweygRW7ub+c7?=
 =?us-ascii?Q?csOcM92lxLjyKdCCTNMjFkuWtFK1wRqQbjNq0e/yOYY9qN2dfqv5VA1RgQSI?=
 =?us-ascii?Q?LcbOoStgf8ewmrMT+xj+dVW1MZa08Ai/Dv1MSPob+65uMR0fyq7opEtp++9z?=
 =?us-ascii?Q?oxS9zg21HkvrqWjLqe2SHM6F+kYCZhe60UbtHqj9hEtf00H3cPNlMpYdWnt0?=
 =?us-ascii?Q?zPFM6eL0uWjg/VStTs759ga6o8QFnX3QsjmjdpN1DCBRpe/P0e3VKqjDRGN2?=
 =?us-ascii?Q?DHG8dK+q+6VTUrTbngtMFoB1pHxepLJhGOIvcR9kuMRarZh0PyZILFfZ21r3?=
 =?us-ascii?Q?8EFnMIQTvcuKMbZJ7Rbk4bJZupAqtkFXco/KF6tPkW4XzYYn9jfna/arCn0d?=
 =?us-ascii?Q?redfjkVV6a0n1f4nvbZ1SUpV+rE/yyAZMI5gw4UpcW4fHLf6zXvRCtl3UCsT?=
 =?us-ascii?Q?xYM4PNINmR9W7/od3216cH9+/MqHyApXK3EzN4yRpbL17j7Szq7aIwfNMKNL?=
 =?us-ascii?Q?65VqF1YOjg/C2z36zBuxI1Z0Qah1fVuBiPVrfsJOz4BPBl+5/I88Ht0BSdIq?=
 =?us-ascii?Q?Bvb2TrDBNB8go3lBvn+ygyDIqcGnSppq1EFm9PEY+rC0D5F5LdZwkyQCoboT?=
 =?us-ascii?Q?0TtqJ1Mp1fN6lot7kX4bvtP7Mn5XEwGlYcPDTRIIQP57zB+AIYlMdJvbfvDV?=
 =?us-ascii?Q?AafJw2FAc+FGDWeLBc98TOwlPiBMU2SyABKk3ya1ndazmYHsgHcR5schdlGG?=
 =?us-ascii?Q?IQ+LY5KMdv8TbEwC1J4Rpy3Ijq3hDfobGXI0GF2LpKApPNXnACmRwATAKv0q?=
 =?us-ascii?Q?lyjzM/14vwCJxhKrD0pMlvka/lgpVIfIhrP7EaJSpBkBj18aJYw1Cg3A3nLI?=
 =?us-ascii?Q?HjD9BvK9rzCQl9mKqzEeLIL5qYI+rf/vb/J33sdseEQmJGXOr6EsyFhEt7Wm?=
 =?us-ascii?Q?/ePjWbfxBssK3oRV11/kYAkVPgBwIFMzMEEj61BqfzTsVcoFROy8WlDW+KXS?=
 =?us-ascii?Q?A9RthMlkFRcrjSBMdlsht0x0HGMEr1XmnkQqx+Jd3ls4hPIlOhEgQ4vs9LX5?=
 =?us-ascii?Q?xfj89HFSF4kxT7C3xFy+6n5oDTLyumGJVEZYsjO9hGJdA7KyCKSIcLVW1d5B?=
 =?us-ascii?Q?U5NOE7rK4WPnTlj9fSk=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44e66b82-eb17-483c-b981-08d99aedad7f
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2021 15:06:26.1706
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EubVktGO6GXVp+83+dnEUq36I3IwBPtZOUDnvYiJ+O5cEs/Zabdne4OwcZ4qMmDP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5061
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Oct 29, 2021 at 06:05:37PM +0800, Wenpeng Liang wrote:
> From: Yixing Liu <liuyixing1@huawei.com>
> 
> The upper limit of MAX_LP_MSG_LEN on HIP08 is 64K, and the upper limit on
> HIP09 is 16K. Regardless of whether it is HIP08 or HIP09, only 16K will be
> used. In order to ensure compatibility, it is unified to 16K.
> 
> Setting MAX_LP_MSG_LEN to 16K will not cause the performance loss of HIP08.
> 
> Fixes: fbed9d2be292 ("RDMA/hns: Fix configuration of ack_req_freq in QPC")
> Signed-off-by: Yixing Liu <liuyixing1@huawei.com>
> Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
> ---
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied to for-rc, thanks

Jason
