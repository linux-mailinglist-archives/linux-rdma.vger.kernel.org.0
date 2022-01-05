Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBEF94859B3
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Jan 2022 21:00:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243784AbiAEUAL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 5 Jan 2022 15:00:11 -0500
Received: from mail-bn8nam08on2052.outbound.protection.outlook.com ([40.107.100.52]:45697
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S243777AbiAEUAJ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 5 Jan 2022 15:00:09 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NrL3DRhgquLjXv06EaNZHMSRUBdC9ZdEJptqE4h6tF7DbaUmPXsj7Fz+pW2V/5rkjefA1UKOx/0AAmL5har95wKvSxLz+aYlOcQSK56iqSceNK32id86+GT/5FKTN/aUyl9zcxEKE2Gki2rqea8H2jWgFzjyaQ1nWb4mowGYhLM2sj5UWQVtiQzVVdUzU8ulZd3wqJtP8itP5JEiaMiCHzRfBoLSz6PKljsMAu9n++rjpYzka9Gbgyv+OVdSAl4whAKrqH2ADQ8eZzc8QLkl8ck72lKABq9fB2r1U93JnEZbtVnNKu2fraCw+SoI1UFIw2JMBeQUkjnxTT92zW+sqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FQolMZIFLG5aVbw5fqaMoH9eBJIrAN4dMxOV/Vwsmkg=;
 b=aIVzUa3kxJALoFyhSgPw4/8pYiB6KaTm00Z9sbjaLq85ZrNn8wkmoq0h05h0YTZ0SnAkyjb6C9D/sTxte/YncRQvvBVe2XfAYiszvelC2efsuGjJGqlZIIrPdL3ZfnQHvS+ambXGAWg4iE5AgUyrVVKH28kjcY1bUTK+aLH/59WGVqa/0ktuvTyj823F+LApa/BW13p6lgTvLLHYbYfnJtVIrLQ3BXoT4UKilgqkZSOPmnk+Z+TuILTdxJakWuB/ZdE9kISnhAF19aMq8VDfZNy/1JPe1NvVWjyW5WYFlayI84zc0GGqYgvL62H8Cc+q5LuOCVpysLPc8n0F7f6yLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FQolMZIFLG5aVbw5fqaMoH9eBJIrAN4dMxOV/Vwsmkg=;
 b=oOGvblMN7IeuB+Y0LL8lfa/JX11TGLY4uh06fxSkTLU2m0qNUyi/x4wCSPGAu448rPtbMuM9xd3F0deREUV4cdfjesx1u0UExGethy8okI2VxN49TDQwFr/BaIUUIGyxXvR5KEwitX57JXsRVyyW5+Z1Zg+VFw2tsZVmFhY/Yw7oMVobyvL9D5DJwWuXAVKJHi1l8MsOcqQa/6DGiqxLa2JAP7dzorTmyqzKk07WnIgyGyKcLBGahUfWWokvUC5xevKg6BYR/rWwbuO9J4ySb8wEoxn7ACGGbyq2pXjtTA7uVSpPk76+qHUOzO9/E1TSLvw3xtFultMExaWrZwrjEA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL0PR12MB5523.namprd12.prod.outlook.com (2603:10b6:208:1ce::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Wed, 5 Jan
 2022 20:00:07 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::464:eb3d:1fde:e6af]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::464:eb3d:1fde:e6af%5]) with mapi id 15.20.4867.009; Wed, 5 Jan 2022
 20:00:07 +0000
Date:   Wed, 5 Jan 2022 16:00:05 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Wenpeng Liang <liangwenpeng@huawei.com>
Cc:     leon@kernel.org, linux-rdma@vger.kernel.org, linuxarm@huawei.com
Subject: Re: [PATCH v2 for-next] RDMA/hns: Remove support for HIP06
Message-ID: <20220105200005.GA2881622@nvidia.com>
References: <20211220130558.61585-1-liangwenpeng@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211220130558.61585-1-liangwenpeng@huawei.com>
X-ClientProxiedBy: YT3PR01CA0028.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:86::34) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f76f51c7-1cbf-48f0-7765-08d9d085f8c1
X-MS-TrafficTypeDiagnostic: BL0PR12MB5523:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB552321F19F0D6743118D6E6AC24B9@BL0PR12MB5523.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LmYtPd0FAlU0a+0i8Hryr3ITErrMK1kKJ3e3GLTJUb3kWULT9MrsdsP+38096V5Q2QjnByK/1Lf+/qMKiDchPxfHVVT6V1HNs5UdfdV8NEns2z2HeGRv7GeF+lS/nHzdXL42nuU8g9hQu1dZZJjw5F/QQ2KP0Z2Ebxlt+KrE2k8ZTK0L0upO6FcyKd+//XBZWFTNa5yV/WWeWrcJDrLcLW3Ml+8eBVKf5bq8tYSuQK5agLpiTZe+hhzn6vblNoU7eN3NnNL2kcPuOioQttWoZBzYiXmyqntL/ckf77iFFUwyF0CIPqEQHeFy+2QvYMes77wnbodknK+/X3ZNsjhPKzPN3qfBMKWcgGkOp6XrWkmVrMCtMXqs+AuaLSYtHorG2PQiZiPR/V1eoFwHpISAQAP9RRbBi8f0Cmx0e+2UqNyhjApj2vxwJXYegFSBa4ot/XXtx1nGOJFKRF6C5fNbhmxbpbkSwLYXqYLGDQlR06A/Tj4LyJJd/ssTk8GfJqRqIpMZzwXCeEb5ssxGAU5XfVnwGywvjB1t5dv7qhrtnSEPA2JbeDCPQ/3zm99BBL66er30fLqruBa5Ic13rL/jgUwSHsz37aXbzGBgtiNS56pBI41SZ/mvjlH82Ug2Ev4mIp/bRfvl3snRLRPrdv2u8g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(38100700002)(316002)(83380400001)(6506007)(5660300002)(8676002)(2616005)(86362001)(26005)(4326008)(1076003)(8936002)(2906002)(66946007)(186003)(6486002)(66556008)(66476007)(33656002)(6916009)(6512007)(36756003)(508600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7YrltPfA+MmbGIfmHk/hQK6FqgGJsMDqvjs814QLrgC6qizqh8iH6/kv2PsK?=
 =?us-ascii?Q?6dFeyCmtZuOFxxEfCZ228BXJraYbmGiUKZ5ju/amwDYc+AKUSlWZlwBNgbJ8?=
 =?us-ascii?Q?hGaNXZqxWy9Yulj35S4sjsdHdrGyPJZpYBDstmQ75dHiVrguHnpMPd37KNEr?=
 =?us-ascii?Q?j1Fqvs2LMeJWpmoZMYSaCH2VrUHMflXie9MqwtFA55fUR9oVWk6p9uwr9Mbl?=
 =?us-ascii?Q?af6WYj8kRmjEyhBgoxSNkJfiHXEwyKDWVAkckkYgOywtCOFPpiOxOplUjlBs?=
 =?us-ascii?Q?DSMTl6i6SKGLUsUrYaJk8dMpwn2ZD0Imy8go01zUZylpQO8s4X2E9s90kOgJ?=
 =?us-ascii?Q?YSogIrMNkAtUMtZ2p9hO+2DvrAELbRtWzjD+0gOr/xZKdTy1cVo4LBRpIVd+?=
 =?us-ascii?Q?0KC+ApTnA6SfjdZEo4/1XOdCzZgWCNqi10o29Ctv1wBzPLh7GSixjfdTqrqN?=
 =?us-ascii?Q?0Z+Io5wNnwIZIApIf+885CrsU22oEhV3yWoWrETt85tev7I7J0ieazu8F90E?=
 =?us-ascii?Q?cB7QMXC77APF4pPQLqVuM0YGMhgcu3FBNY8LvJCDHRQ1bgg1erVidkt2aT9b?=
 =?us-ascii?Q?ntPQdEYe6FLJO7+/7Xt/pxfts8iqSxwQ6g3kkRbciHGTptn/WFXS91tgj4SH?=
 =?us-ascii?Q?nywzpYX9WCUVeHa416xIPA3qJYWhFAmfJHiDHtuyC3JFpNShU6OSppMVfJgt?=
 =?us-ascii?Q?gtymNmggMhPxCsFDi4hdR+0IgsNmcqZzmyg1bVB+NHJtUv/nrrxM/8r3nb88?=
 =?us-ascii?Q?C8rOGQWWoZTtI2WAQaZ4F0jKxYL3z9dbncgnjiL/E0fqZsmTgoPpt98FH0sl?=
 =?us-ascii?Q?wKqUQdZiu0QO5uJEvPDXW5ONWMIohGb8nSl9vXgkmJNAuH+S/Oxw+vCU6tYK?=
 =?us-ascii?Q?VYduBPXD/lLR4sGrFJNS1LRgYCDrg6oNHB760Zsg2gEUFVm8v+LRF17flqmn?=
 =?us-ascii?Q?waO64erEbtkrOFgtbyAEpJlsj2HxBrB2wj9guq4Me8sIQdzlOCL40C+vFvyR?=
 =?us-ascii?Q?cHB3jxxOn/xKxya8o+hL+2cqQ+YoSfoX/Z1WbtvymnI6QHULElg0Tk978Fvq?=
 =?us-ascii?Q?VbFqz+3Xvos4MHSMPFdseqURc2+qpE0NX8NG4RTYO3n4wPuSzjVRXuB2th/F?=
 =?us-ascii?Q?8t80QPzRMag9mK8bytPMbI7iIVzlcNNypfEzoH0faHCtt8Eu4rjG1fo6cFmY?=
 =?us-ascii?Q?6cgpM/eDIQ+lOA1ckVlhS5ccfpnCiFEbCuxomKwqTyJTcGUj+YbNpXxqw2lX?=
 =?us-ascii?Q?49z+SnYPAwOFgllvpFYjn/Ht1N828Ss+8PDKX7O4ELyC2UOvX+JfuviJJzuq?=
 =?us-ascii?Q?qZLUegz3pGVBxuARCQ964s8ixTIBhomFEZLYT7NYCeiiN4MC20fTejVgWVmY?=
 =?us-ascii?Q?SZ2prDKjyaxRlTnQAEiIvM0wqERnPpwMtbToEZDQjT9qw88EIXot8y5M+EAU?=
 =?us-ascii?Q?+E3ZrIZqfxYlOWKs1tRzN+/IoUvWi2/olsAGLAAiY+GE2NqLnIip+/UwI2yi?=
 =?us-ascii?Q?V2tRnVlQHXZCqriCyzRnObOX+0gssdEKJqTXnMvHHDusmMia+37qdtHnzb1Y?=
 =?us-ascii?Q?EKwIZs7et7iybrRTfNg=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f76f51c7-1cbf-48f0-7765-08d9d085f8c1
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2022 20:00:07.4254
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tGc1SLHuqnfslERPNH84JHZSebyBkjxHF0CDsTA+mbqyuQEK/qSR1daBiv+cQHYO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5523
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Dec 20, 2021 at 09:05:58PM +0800, Wenpeng Liang wrote:
> From: Chengchang Tang <tangchengchang@huawei.com>
> 
> HIP06 is no longer supported. In order to reduce unnecessary maintenance,
> the code of HIP06 is removed.
> 
> Signed-off-by: Chengchang Tang <tangchengchang@huawei.com>
> Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
> Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/infiniband/hw/hns/Kconfig           |   17 +-
>  drivers/infiniband/hw/hns/Makefile          |    5 -
>  drivers/infiniband/hw/hns/hns_roce_ah.c     |    5 +-
>  drivers/infiniband/hw/hns/hns_roce_alloc.c  |    3 +-
>  drivers/infiniband/hw/hns/hns_roce_cmd.c    |    1 -
>  drivers/infiniband/hw/hns/hns_roce_common.h |  202 -
>  drivers/infiniband/hw/hns/hns_roce_cq.c     |   13 -
>  drivers/infiniband/hw/hns/hns_roce_db.c     |    1 -
>  drivers/infiniband/hw/hns/hns_roce_device.h |   64 +-
>  drivers/infiniband/hw/hns/hns_roce_hem.c    |    1 -
>  drivers/infiniband/hw/hns/hns_roce_hw_v1.c  | 4675 -------------------
>  drivers/infiniband/hw/hns/hns_roce_hw_v1.h  | 1147 -----
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c  |   13 +-
>  drivers/infiniband/hw/hns/hns_roce_main.c   |   62 +-
>  drivers/infiniband/hw/hns/hns_roce_mr.c     |   22 +-
>  drivers/infiniband/hw/hns/hns_roce_pd.c     |   20 +-
>  drivers/infiniband/hw/hns/hns_roce_qp.c     |   37 +-
>  17 files changed, 33 insertions(+), 6255 deletions(-)
>  delete mode 100644 drivers/infiniband/hw/hns/hns_roce_hw_v1.c
>  delete mode 100644 drivers/infiniband/hw/hns/hns_roce_hw_v1.h

Applied to for-next, thanks

Jason
