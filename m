Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 725166117AC
	for <lists+linux-rdma@lfdr.de>; Fri, 28 Oct 2022 18:40:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbiJ1QkU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 28 Oct 2022 12:40:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbiJ1QkR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 28 Oct 2022 12:40:17 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on20612.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e89::612])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35E7040579
        for <linux-rdma@vger.kernel.org>; Fri, 28 Oct 2022 09:40:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gkWYZLBQdjR6xy+UUVSsNp3jcR8bSpI6/aNUCl6v+D+yd1EYcin//C+R2wTF3xPeDm5eOIZSRTwkQqoNsMy9CuD3uo4NcM7/ILJ+KseR5OUrHs7kUVcXAV9F65YhZMp6nQujv69vqDUFQzR/fWLzcuegCzj+eukVmkk+5NiTyWaRjVKmL5nUa5YrXCo8SdtxMbiWSqGOrcGpepc1i+lfmtv1XBN6Eg3CtUTbAQu22VNJKKqmppGMS9YuHUmhcHxeWycZuybQP6Xivi0maUWOoCDanNSU+NW4PKDgULE3GGE7AhSx2TmURox3qntnbsRACrnP5aSiW6aT/LidR3CVHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IDvamFdwHySIxn8k5YrdG6V9YYy7fkR3bsp1NoqtT/Y=;
 b=YrlJZEuFtqwBGydHL8mBMt9+3Z+atFzQwa4umJm3lffUl5Z7JjJ/bo0T5EJe510l2X5txisl0CdnFh8txt5hCoYYrC9Ph6wLGmdmaeD230XnpAw3xCCDhdh433sPj+qd1HKaaMKt6EraupJEvvyPFMeSrewXjl0z8dfTuIQap+EdUXYOxND4PJEIyS3ZBdUbGM0uo25Eu6+cXzfKbRfGtuv71Out0EkHZkD+Vfv+TiGdSrVauswuzvMox8ZR9dZ1giIS0ht6g77oUTTV43B+azSMjx4Jol+w/bqH1c/0onC3Q7kX7jkUsNn1NigIdzltsEHFIEf7Y0rRvKsmv3BulQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IDvamFdwHySIxn8k5YrdG6V9YYy7fkR3bsp1NoqtT/Y=;
 b=OhyESoTDrHUO6cIM6nXCs6Qfj1f/XwE3Xsv30e+k1KGOwTi8aHB+eVG8wekQTw2iJW4wRiWmR5hNZFkvacbcxPiSfypfjB2ffhqLOIkENaFMY+XLuhg0WHb+SgQHnx7GpWoK1Q8ItJNemmIPzUgh0fzzR9vcWJjHwwtWgQwyjAOgvMn/cnDr6tlYji1Ryh4TpMJc0ASz4Vm0yZ9HzzzxCmDFAj27A6ajMhrXUspBCbZM8t5YFarfgOZk5EPyBOjYgB/UZgBqPAEEKaWEjDlO1xh4SjKyP5AM0n9+DoTqIX1ivL4bhCQsAr+hm9AmSyBbM2el8k0bqNpAwXfIQY5yQQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BL1PR12MB5995.namprd12.prod.outlook.com (2603:10b6:208:39b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.14; Fri, 28 Oct
 2022 16:40:12 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de%6]) with mapi id 15.20.5769.015; Fri, 28 Oct 2022
 16:40:12 +0000
Date:   Fri, 28 Oct 2022 13:40:11 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Haoyue Xu <xuhaoyue1@hisilicon.com>
Cc:     leon@kernel.org, linux-rdma@vger.kernel.org, linuxarm@huawei.com
Subject: Re: [PATCH v2 for-rc 3/5] RDMA/hns: Remove enable rq inline in
 kernel and add compatibility handling
Message-ID: <Y1wF68CgChG+hM87@nvidia.com>
References: <20221026095054.2384620-1-xuhaoyue1@hisilicon.com>
 <20221026095054.2384620-4-xuhaoyue1@hisilicon.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221026095054.2384620-4-xuhaoyue1@hisilicon.com>
X-ClientProxiedBy: BL1PR13CA0240.namprd13.prod.outlook.com
 (2603:10b6:208:2bf::35) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BL1PR12MB5995:EE_
X-MS-Office365-Filtering-Correlation-Id: 08fd07f5-d029-4146-3fbc-08dab903157f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x0s3OUpeNDojx3sVWtG+05aH2KaNeXjfZxraMJJDsUhjyZsZJv4nws1iIsmftashCIsTSeFJtLc4WtpNLFMmJ0f6F8k54kfUT65M66WmGCpIep/oQjpvcTXw9hexdsaoNkrSQSmXl6bcMINj/tVaV9EsAz1D1n3T3O+YNHY9T/VlKA89eBvGIywPx6YhBsgAeSXtJST4Xh9IxlVBdeAB6ip0AWIKM8DtOqfZ5mmy5oJEOm5n1d1hBeF3oP3kNs+hg88XtQiU6G/cp41rswLqdEfCU7RCVA5QOPJ02VatvSM0bktpMEv8gkcLZrptf82agc9J6eeul4lxbP1HDA0UKjhOUI+/4/8FhRa4iSxIbZF+9OOjnkIhL3GKj4voZ/7BQY0Z24YDeKStu28Y9/Dr3wKx4RZ6hpcbEofnJweJlkyW+xRAC/p12VX7bIFv9aj8URoWV+1Erfyn6XzmDJic2OcgU8/U2VlJFoMutY0BPohK8hJ37epxrC3sW4nlq3AeAKEFM9DvN/RO60+uUGJgVykITdi925nCKjOaUb3LMcFXOuJTM+1UOj/IyKF7utOrsEI1K5A/gRRId/xuW4W1tEKhq4u2Ve2ke7/YiiJP4pbNwXA9adI1+zrKxuShzbN3vUfhVF25tuzk+nrb0bD3FqaYG0Qq4pA6buGx/v0A0Vy5993eHr9mG52DqcsiWQn4+8dYWzV+lq94UGqtEmmGJgOGjpo6VAn++tZLlx0oGAl1K9FbInTaVkLj8aAgj28L
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(366004)(136003)(346002)(376002)(451199015)(6506007)(66476007)(4326008)(8676002)(2906002)(86362001)(66556008)(5660300002)(26005)(38100700002)(41300700001)(186003)(6512007)(66946007)(316002)(2616005)(36756003)(6486002)(83380400001)(6916009)(478600001)(8936002)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cXK/u0OV/2+ekmy3pfRfS26MCVL+XSWwRXr15GKd110XhzrmxfpCtdcNK4a9?=
 =?us-ascii?Q?jTu3TpasDEUeUmMmgvg2ibFXTFLcl896nDW75iXyFrf+qPiIyjY4vkHWytXX?=
 =?us-ascii?Q?dEtFaCd/2ro89KYvO2M2vAQKdzMSN8Q86CTT09JBBHV8sTpfxIWsAyA9vDOQ?=
 =?us-ascii?Q?ZfGsq4gfEvIP0VjJIOMFuctnjukTr5U3P/ZPeLAVFo+Qkis6uLs3PlzbWpiD?=
 =?us-ascii?Q?NCNKn5QVaj6p4BCKFhmKLTM6KvvoDENx2jTWi4lrunGCzMpEjYgpltvf6AUb?=
 =?us-ascii?Q?8owKMQApqN/xAvtNB274BAvj2shosKF6wxtnt63m7ldsj26AnX45wpOY2I4F?=
 =?us-ascii?Q?D84NfHh9JqI2nZTGtGcWaIOqj+3PfmZpURBmy/4ivoc2k4kw7su1jf72MGKg?=
 =?us-ascii?Q?i3HAjtkRmR+tiS2xRkQk44+YWY2SiQvnP9uPpmEorNFQSuzuv4q71fKdSjx+?=
 =?us-ascii?Q?x1owTg1Ff0k6d1LIA7o9aVQzdJTH7eUjKxNIw7FAvL+ad+JsCnqWAzhqeHnI?=
 =?us-ascii?Q?UdHBLYDHo3MrPzZUYmz8uoiNzvmLRonqvpMxIe3dAdzpttK++9fOw8RAZ2v0?=
 =?us-ascii?Q?40WxGGGvEdGrKPOSZZfT51vEJKyJE4pk7PN0DnUsaoYaUHYOp4Il7fNCFkou?=
 =?us-ascii?Q?smmE4S7bUTfTOS6V+zhQqhfC+WtL9LB2mSPUwP/6Ck2yOfLxtaIKvPnUI7Z2?=
 =?us-ascii?Q?VMUlhGV9O8kKO6UJjxhbFIqzc4gFCvBvZTF3TibxeZag10qy5+3Sb5+zcWzG?=
 =?us-ascii?Q?CZ4jzUjp3YzI4hmigLABi4oDNm31nCHVIHZ3LHNuHpoRl+NdxPorZpwNrXO0?=
 =?us-ascii?Q?wxGc7oiUWg4L2ekmuJZVN446Wz+xfUwaZnE2zE3kt3/3J3+WjaCqKjoCEtTh?=
 =?us-ascii?Q?suujxK16d4Fm6y47mkRgoxu3/5QNqRMMJ+WsOm5kaFK5hUMAbz+IsIKXzsSR?=
 =?us-ascii?Q?OmH7U3wtKOZvfMfMpiRedKEYGpztiDD13zLu+g1tnH3tKq4VJdCE3K5QdTcb?=
 =?us-ascii?Q?zjXYfIHG/kuf59D+mK1Ww5NruENTPSnlUvCrbEZXhHQO77ZVBGhFz0u6y7fU?=
 =?us-ascii?Q?oIkvxvSK2GPtL7+1nhR5AqF4E9OATlc3PrbPyjc8pxHAGLNq2NqWZCIHKPSC?=
 =?us-ascii?Q?+nZbXCfIFxKx2hCjyzOlCdPH+ChRcHbgevgs/WpI3i4ZTvSgairTHKwD1dkH?=
 =?us-ascii?Q?bqOautGZtHc9SeHuY67s0xVVD4XbuQg3kSpIjW/D9PTgSTvzIBx7XKeYnmBt?=
 =?us-ascii?Q?RVt2suS5sMu4+/WJIU+oi/RRed6iOR+LZWLEdoYwygqvpcuWG16rQm0Q01IT?=
 =?us-ascii?Q?5TBgxEh1F3YbuLHeau05N4RQwYeaM5x5cmMTitDEjQhIoxkjdSBA8tHAcXw1?=
 =?us-ascii?Q?6UICSj714j6ge+xnKSrim3XCkCJ/3FDwm81WXyOnYf/HVa7eMNl/39P4sDcU?=
 =?us-ascii?Q?4AvsBhjmSyJ2VB2F2o9rs+uEcW9Bvoschx1mfBCEazhtrXptEzarsZJLcs76?=
 =?us-ascii?Q?OlEJmrzfUyXyLtkWXhVGnxvzZLeQ4NcA1ycF5J6PQI1Kgpb323oKKdSwHjhL?=
 =?us-ascii?Q?cRaj544xlhVq/oSC4yc=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08fd07f5-d029-4146-3fbc-08dab903157f
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2022 16:40:12.4610
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YMCSJPPwWT1p7KOdx8dKqySfHnyyjBu3qpEVgvdc+j7/hCSxjwcv5cm2Og/NvGA8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5995
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Oct 26, 2022 at 05:50:52PM +0800, Haoyue Xu wrote:
> From: Luoyouming <luoyouming@huawei.com>
> 
> The rq inline makes some changes as follows, Firstly, it is only
> used in user space. Secondly, it should notify hardware in QP RTR
> status. Thirdly, Add compatibility processing between different
> user space and kernel space. Change the HNS_ROCE_CAP_FLAG_RQ_INLINE
> to a new bit to prevent old kernel spaces / spaced from enabling
> rq inline.
> 
> Signed-off-by: Luoyouming <luoyouming@huawei.com>
> Signed-off-by: Haoyue Xu <xuhaoyue1@hisilicon.com>
> ---
>  drivers/infiniband/hw/hns/hns_roce_device.h |  6 +++--
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 28 +++++++++++++--------
>  drivers/infiniband/hw/hns/hns_roce_main.c   |  5 ++++
>  drivers/infiniband/hw/hns/hns_roce_qp.c     |  2 +-
>  include/uapi/rdma/hns-abi.h                 |  2 ++
>  5 files changed, 30 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
> index f701cc86896b..9ce053fe737d 100644
> --- a/drivers/infiniband/hw/hns/hns_roce_device.h
> +++ b/drivers/infiniband/hw/hns/hns_roce_device.h
> @@ -132,7 +132,8 @@ enum hns_roce_event {
>  enum {
>  	HNS_ROCE_CAP_FLAG_REREG_MR		= BIT(0),
>  	HNS_ROCE_CAP_FLAG_ROCE_V1_V2		= BIT(1),
> -	HNS_ROCE_CAP_FLAG_RQ_INLINE		= BIT(2),
> +	/* discard this bit, reserved for compatibility */
> +	HNS_ROCE_CAP_FLAG_DISCARD		= BIT(2),

If it is for compatability with userspace why is this enum not under
include/uapi? Something has gone wrong here, please fix it.

Also, it is better to name this __HNS_ROCE_CAP_FLAG_RQ_INLINE to
indicate it is not used instead of 'discard'

Jason
