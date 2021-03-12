Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFF78338203
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Mar 2021 01:03:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229664AbhCLADD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 11 Mar 2021 19:03:03 -0500
Received: from mail-dm6nam10on2088.outbound.protection.outlook.com ([40.107.93.88]:18976
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229606AbhCLACn (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 11 Mar 2021 19:02:43 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W9v32/tDMuohPGwI57Y59CZjlIZnBOjhOtUMaIovNji60x5Mya3qw9CXUXHTQP84qfKXHGqzF81cDqTdtUM0pcP7tdJ5byf2hFWspC+/JZT/zUUey23qlY5RYL4gsTuDDzRfZFDqKDaoWFd+0YstydIxtPix7JsHVw4hKFntzs1CPK4hozApKvlAokcwL5hGQgWPoUNJwQ2JL672WSuGy6hb5iVzxjIjW5VcDbwPoW3ELRvWhPKx1nXA4s1g6/FzUYETa14zeHkL+DL3CENGJydG413+lp+Q5aJpQOcu3CW39prgzq8Eef9dfIacOfxovcq5GKTT08VPWqPBvsHAHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V35FHf8ubnyvYDuyfqOfZxcP6nsDyPDuPKPiPMTap3c=;
 b=Bg5MtmrArmWPIF0tD8wnpEXoBgI/dqd4BLtnh/HrZh06ahNxPg1TH0lG3Ue8OVGCV7nadWb/60U2ZYGmiOjiJc81RSImW1fbrYNp3uTk+xj0r26N6ewwHkKz/Z6ZqYlmhmxSysnBoV5vZx9Rf+npEg8nFC4Gb4X21U6JcXhCI2tgUerz/3ycM3oV1UrvVtu+vU4rTOxaZW+e5bWefXTRK94JCuCO6dGogaREXCwMrW/+ysZKInwxCI0olr++iQKuU+cThmUda4uHtGX1a/T3H0qPo+8DLL29TIwjO0uy9kTQtkZYUbpa6NKELR72WNYPCSE1K9qL59F8jGiGdy14kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V35FHf8ubnyvYDuyfqOfZxcP6nsDyPDuPKPiPMTap3c=;
 b=C7xfpaW5W5J8QhKKwp8e4AX4h+qX/sI11c+of2B/01HkR35MF3ofAqaK3m4E7x3ouDlMD74PSdt1eiaw1F4JXuZbwX0x2BVDa/+ECN+MyrbWPvm6JGXp+2KmeWAgdxvSXsepi8vV2mhSeX3rFLbcQL1YutxMciaRITEGNDV8ZoAtXlkxme9aZY6a31wiD9jsKu1tDPZklBz7amG2M0vg8BK3f4bJm8yx92hDN5uoeYDGshpddPNUIjPgWXSzicBWMQ0ywQVA7vssGb3OYHAx3+lt++imyoDtO+qA+gk1T80NZ5Iy/x3YBscKIbUg8q5r1YqRqIs5kyGzXM+B0K1GZQ==
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB3827.namprd12.prod.outlook.com (2603:10b6:a03:1ab::16)
 by BY5PR12MB4855.namprd12.prod.outlook.com (2603:10b6:a03:1dd::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Fri, 12 Mar
 2021 00:02:40 +0000
Received: from BY5PR12MB3827.namprd12.prod.outlook.com
 ([fe80::4c46:77c0:7d7:7e43]) by BY5PR12MB3827.namprd12.prod.outlook.com
 ([fe80::4c46:77c0:7d7:7e43%6]) with mapi id 15.20.3912.028; Fri, 12 Mar 2021
 00:02:40 +0000
Date:   Thu, 11 Mar 2021 20:02:39 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Weihang Li <liweihang@huawei.com>
Cc:     dledford@redhat.com, leon@kernel.org, linux-rdma@vger.kernel.org,
        linuxarm@openeuler.org
Subject: Re: [PATCH v2 for-next] RDMA/hns: Add support for XRC on HIP09
Message-ID: <20210312000239.GA2769255@nvidia.com>
References: <1614826558-35423-1-git-send-email-liweihang@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1614826558-35423-1-git-send-email-liweihang@huawei.com>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: BL1PR13CA0365.namprd13.prod.outlook.com
 (2603:10b6:208:2c0::10) To BY5PR12MB3827.namprd12.prod.outlook.com
 (2603:10b6:a03:1ab::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by BL1PR13CA0365.namprd13.prod.outlook.com (2603:10b6:208:2c0::10) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.10 via Frontend Transport; Fri, 12 Mar 2021 00:02:40 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lKVGJ-00BcQG-22; Thu, 11 Mar 2021 20:02:39 -0400
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b130672b-768d-499e-8fc8-08d8e4ea2751
X-MS-TrafficTypeDiagnostic: BY5PR12MB4855:
X-Microsoft-Antispam-PRVS: <BY5PR12MB485570C8F2BF3C2EACEF09A5C26F9@BY5PR12MB4855.namprd12.prod.outlook.com>
X-MS-Exchange-Transport-Forked: True
X-MS-Oob-TLC-OOBClassifiers: OLM:2449;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kDldxXpOSblD9xbFOQvsRLOIykAaQ9WN9UELatazxFzYV/fxu6HC2pn+eiPVSCuz5j+GrcjH34t1zgTdlXun1Seo6v04y3K2F4GPIYN/SZKw+6yK3c1Xu6+8T7w3HusrlNDgQZRZ7rKvU1r9mQ02exJt49wEPXQe1D43/VQI8C5vqyJcRmhxDI+DkuzBfA112udUkC2CCpggD5UbVriWL6P/65gbJrWDnRrjn5RJqrGrGveYfaW1V9IpCN+QTb1coO7CvJEG/xU5jEDLHz1FPVI0Ts5aBP2QbZa8jI+eRWSHWb58pwYu3mQGMgtn2S2EbIA3tbapBVJ47WDrDaDw6tDGUdQZI+LKAa5Bw5O9GobX67315HjSwjyERZioPaiw+AYDSb5kNbi9WX/l50zBILW2D/wf5KfPqbyi7va/0PUWPkXqYSeiMsuTglgcMUrbGXrW4Tew+x9QYypow4eN6Wya7VQxgXNMCG7tkt2JrBieAX3HRT/bJyORArB5r7TcRyBtBoOpyRmhyD/V90+yujhlBzJfmfJso4jRDecnwctca8U5wtlmoQeP2DoJ1Ms2zBCFBTd9OiNuG09rBDNDdGCD/gJ6YafXsRRmYhYf0dc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(39860400002)(136003)(366004)(376002)(1076003)(8676002)(33656002)(8936002)(316002)(966005)(2906002)(66946007)(6916009)(9786002)(83380400001)(426003)(9746002)(478600001)(66476007)(36756003)(86362001)(4326008)(186003)(5660300002)(26005)(2616005)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?9Mxo/4XzmzUSh0PLlmLgXnHPjqCjuCM/nd75UUToY9wGOc3rSqoz+jH53mUu?=
 =?us-ascii?Q?3u+6tO/B2q48b2Xj1I9jxtZO5GvHc1drdYXhPgoefCQ+ninuH/nVcGackv5l?=
 =?us-ascii?Q?UfAhOPYppTKpwrc32eFnBcZD55tZ9mF4EVw85cpir5Qh7boMkkHm+TOc3blm?=
 =?us-ascii?Q?PeQvLnbQc0oTghEmGqdbZKTTWFfrAzzoEwARmowvdK/CWkP1+4wCaQuv72hX?=
 =?us-ascii?Q?O74lOqezjDx+gWTFjZTVZVy1AehJREImhQiTISP9vYI0GCN/X8fo6KSOZ79o?=
 =?us-ascii?Q?sSswZDTnFVS68ChN3j0VwknfmJgVy9PkfBRTxcKG7KkLpKuPYApfi06CLEgf?=
 =?us-ascii?Q?LYGQkU4Y1X77V04gawzD/GYnXVEebE/y1pbdm23Q9CQkggvVTfNGy+WRWTBj?=
 =?us-ascii?Q?sZm3NdYd3TpOUTmHSzng57yUOwCJtrAVtm+P2CLWit+m3BlOvja/NE6izr3H?=
 =?us-ascii?Q?pYqbHqwa0nI26ST9buk+9DmKalV8HgImAsz+G3tzQagKUk4V4clmtAL5suNc?=
 =?us-ascii?Q?oLeYGOVqTaSE1VoSoxmaZk8kuHe8Bwfd4H9WoI5+qI0nRgI3OGIIgCaMDsP1?=
 =?us-ascii?Q?WgTcF/YTaiO6zzObusIXN5Tt19rxITAk5yQTCN0IKzsVeGzhVMHMSvvx3o47?=
 =?us-ascii?Q?p23+KrTI9rBTbayyStikFpmUO7E9AYpZc1u03RRp95Ozmnj57dB0CH9aQg3l?=
 =?us-ascii?Q?vP07pzswsB5mn1ZHH+7FxvLFou1rRprvQ0vUTqCUQua7L8SuWjGYXvJsTmjO?=
 =?us-ascii?Q?IAh/6FJakOFjiGwduGzzQLFLo64QvzwHduDtK/LIW4x5LaFc+0iaw48tKmGE?=
 =?us-ascii?Q?zOzLlxSXBrBUSA04DdHGdmQAYtn0iI31Izj4FMHw0b0TbLsEr9z135YBgh3t?=
 =?us-ascii?Q?JFuB2eqK0qaxWS+edWHKxeMryD21Syu9yg5lEu/z1hxtc5NfH+2wDRCm4Eje?=
 =?us-ascii?Q?0xXpmcBHvCwuxgmNohDy2e6XxdkC2FXcX96up/qFNkowEYSUICWBBP58J1pc?=
 =?us-ascii?Q?waktx1yIQUyHRkV7rQLteMs9slXTb2XwP4cz7RGAxCYUI3bGYuF6VEbaF3j8?=
 =?us-ascii?Q?0tbMbRrRcnR6J6JM+EGvTFWdqGKhRppnMKCldSiPUFWvZ7IB5eV6GGnHjaQi?=
 =?us-ascii?Q?NqHLUm0kxP7m4GccSXT4B6w53GYZGl+YUnUAhYCSlpzTwfDenur75BsNeJ4O?=
 =?us-ascii?Q?XbH3JbrO0jlLbZ0w070IMpJ/Nfvk6Sz2l8u+L5nko7Wv2DK2GkNhneDyt9M9?=
 =?us-ascii?Q?hicAwlUIpC9vb90huzRYt6rgmiae25OpeSFZdVNcXKInbfOBJUTa7PJ8VKYy?=
 =?us-ascii?Q?1f6/GKcAB5MVt/iUTF+6/PBPKt/Rpeds3cFAJNZ17cV2Kg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b130672b-768d-499e-8fc8-08d8e4ea2751
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2021 00:02:40.8490
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bYejgM69d+AbbHEIFdcbsMuj0AyVXCQz1wEIjK49S324STC7ZQ2s0/NIY51CCgYF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4855
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Mar 04, 2021 at 10:55:58AM +0800, Weihang Li wrote:
> From: Wenpeng Liang <liangwenpeng@huawei.com>
> 
> The HIP09 supports XRC transport service, it greatly saves the number of
> QPs required to connect all processes in a large cluster.
> 
> Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
> Signed-off-by: Weihang Li <liweihang@huawei.com>
> ---
> Changes since v1:
> - Change all type of xrcdn-related variables/fields to u32.
> - Link: https://patchwork.kernel.org/project/linux-rdma/patch/1614689298-13601-1-git-send-email-liweihang@huawei.com/
> 
>  drivers/infiniband/hw/hns/hns_roce_alloc.c  |   3 +
>  drivers/infiniband/hw/hns/hns_roce_device.h |  25 +++++
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 147 +++++++++++++++++++---------
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.h  |   2 +
>  drivers/infiniband/hw/hns/hns_roce_main.c   |  32 +++++-
>  drivers/infiniband/hw/hns/hns_roce_pd.c     |  51 ++++++++++
>  drivers/infiniband/hw/hns/hns_roce_qp.c     |  63 ++++++++----
>  drivers/infiniband/hw/hns/hns_roce_srq.c    |   3 +
>  include/uapi/rdma/hns-abi.h                 |   2 +
>  9 files changed, 258 insertions(+), 70 deletions(-)

Applied to for-next, thanks

Jason
