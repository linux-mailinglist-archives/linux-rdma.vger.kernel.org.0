Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DF243F23E6
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Aug 2021 01:58:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233972AbhHSX6s (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 19 Aug 2021 19:58:48 -0400
Received: from mail-dm6nam12on2077.outbound.protection.outlook.com ([40.107.243.77]:34368
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233370AbhHSX6r (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 19 Aug 2021 19:58:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bucd8I2nzV3xq/w5QojD8dQlhFPJUZ74x18UjEsKL38WjthGucgbSdwHiepFK8pmBTMcqxg1upoKD/1osnnThvIpYtZ7IEble3TShrzRGnQWRVkNWtO7TIrmXJlmpMSo65pg6kf4Dkg54jBD9MyNKuvS0ASlP6u5hmmPSb5mAaJxEJoV/6RD9hBmJIeKJolCNa+LyKUnG16rC+y6X+ZBuZgN4B4Wnh6odJCMnRVmxZP1Xg7B2jnhnc6KohczxR1Rf1C9NQqHv6YPVYccyS8AfL2n3uT8jifvc0yRo4m8blryb05voPtIsVLL7+ObYXH26Cezy1xdOY+4w7B6gp54Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FJIwJzd5tEOMJK/AEVeP5jVWD2mVLBPy/MfH7ZRVH3s=;
 b=Tbnd9uMjrztIttiC72KAqeveuOkq2MvuXDV3Kcbq/D+Vwx/R8nswug5PTXP7BG24FJnTNpnwk+hyRz7OLOax3CtXXu66ZXSdXBr5x4NNugeP2/9LOrb+oKiUUGujeAcIm5NnJBeLqnrPm7vnqrqsTnQk9DgZ5/cTR+k2ED+nXz+QsIjket2zryullrV+fqtQ/rrPAJ+oZiSvvfANgRhpNuRSnAl4fIJezesDJvLaXYaD3pmBLA74Vwh1nS8OOulOquxDGLr1qcKUhs5ldAXdmwuJw8JW3Zr7kuJcmEPwr+dbwI2lHIsTA7Mlgwe75ByfLKHMXgGKZYwObg0hEJNc8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FJIwJzd5tEOMJK/AEVeP5jVWD2mVLBPy/MfH7ZRVH3s=;
 b=GENJmJ1IB2wCMpbEG++p2eZjN6Nx3xal+2qBidU07PqQCZs0X70CjzKB02RCN/Hep9WyxOW3SvgLM2feFxrfgCd3Eh4RKdntorTUIFt3rBfyjBdOs49eseU5YoizUDEHUEvLZz4QEHOU6ZK4WXTBhaU1YJf4BshSkcxw1LMJkz/75m7VkD0Il+KRVlMjYpAz54KR98Zc66U0xqgRL4naeBm1s3ZfFpSMlIM1V/XijL0lDBmmWCEplBUC3qGPnSHHoKfMjlFpR24M17JYOShmsZmGWTzHtaYQnjO/VjLtKoQjwyHHDCnQn6+cSEVY3JkL0l6KF5YDWV2MNdhd8H26uQ==
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5126.namprd12.prod.outlook.com (2603:10b6:208:312::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.16; Thu, 19 Aug
 2021 23:58:09 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::1de1:52a9:cf66:f336]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::1de1:52a9:cf66:f336%8]) with mapi id 15.20.4436.019; Thu, 19 Aug 2021
 23:58:09 +0000
Date:   Thu, 19 Aug 2021 20:58:08 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Wenpeng Liang <liangwenpeng@huawei.com>
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com, leon@kernel.org, Xi Wang <wangxi11@huawei.com>
Subject: Re: [PATCH v4 for-next 08/12] RDMA/hns: Add method to query WQE
 buffer's address
Message-ID: <20210819235808.GA399558@nvidia.com>
References: <1627525163-1683-1-git-send-email-liangwenpeng@huawei.com>
 <1627525163-1683-9-git-send-email-liangwenpeng@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1627525163-1683-9-git-send-email-liangwenpeng@huawei.com>
X-ClientProxiedBy: BL1PR13CA0333.namprd13.prod.outlook.com
 (2603:10b6:208:2c6::8) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.113.129) by BL1PR13CA0333.namprd13.prod.outlook.com (2603:10b6:208:2c6::8) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.6 via Frontend Transport; Thu, 19 Aug 2021 23:58:09 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mGrvE-001fyG-Qu; Thu, 19 Aug 2021 20:58:08 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5f8c3ab7-ead8-4c5a-2ee3-08d9636d323e
X-MS-TrafficTypeDiagnostic: BL1PR12MB5126:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5126CDCDA42A64714282F12AC2C09@BL1PR12MB5126.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M+yu/eL7UFsJj8nCTyoO9nbpmXsBa+yqPWwCQmQcKgmMgbh/fV/Kyn2h8gICTSn0/9NIZi0jj9WdRTcqxBzU6GQLH/pi4fVvHcrb2RZvMxAaXR3FswiQ0frJeUhbMOZCPdZ0ZRnPCmKeVYu3RCRN+CxHjcCG7ftekRjS3J1E+JEDtu3CZwQ1UpC1PBbAGEGF1NUrJ8RAvenU+/lbC9RK9zDK4T2NHQPSPDpQDs1pdzjAi2mk7V3mE0mGnS064npRwFvkn86QVr3UQ0DbFMZii0WvfL+yTdXJd9QB6nwpe6/ZCc8JzTa2StdjM6d34TLmBQ6SG1un6T7DZSz/0ZIKbDGm8FWMqYcKDSFBe69SWCHHIJnxBSCCex3VoMJx6GjFBF/B+/Yi7Dgmk1x28lUXt2E2UwdZAmMzDAlPoz8eIMh60+8hMXKS3/63SrKg4mm5TdJfJJsKat1iKa22UehQVFVmJMqe2S7rbHFowy7UeTmd5su+4LBPtAptzR65Pzp0dRlo+gjqtWRpXLNItVO1CskgFAx4cCC4SsCdDHpY2rxXWKOR4+BVe2jO9RqgliTApgJVwV8+HjEbEVGd3notkFbW7pWnOVdSaWFHXSp5ZfDr+nbeOIMkNSwUArz1xetNQW15BqjQXaTTSuColPauxTunwwtwT5lHJN5Se2ryZrOZJ5uPCykUT6MWji9mmtQrZM+PBrCqSxrRB9qRgN1fIA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(346002)(39860400002)(366004)(396003)(426003)(478600001)(66946007)(26005)(9786002)(33656002)(38100700002)(66556008)(6916009)(186003)(36756003)(8936002)(8676002)(86362001)(4744005)(1076003)(316002)(5660300002)(4326008)(9746002)(2906002)(66476007)(2616005)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UEYMyw4Sbebx1oR9hxdNS0T4BobpCMdaFvVXPfso5PeBHpfCN6d1HG3SOuqa?=
 =?us-ascii?Q?Bdzcsr0dLWRKrtH9H22bMVNxsoFBTkLACLZMhta0kApjT1qEeYE3tQiGl6tZ?=
 =?us-ascii?Q?qAlQAlkwZd3P6Uus2LzC7yvUAjWqpZJyGBKC7wNigIiXhZmex4FFgxgzHAFf?=
 =?us-ascii?Q?jH/IchOfWbzddZrNxfCWMcGDB1hK7MtsKMB7+O+l4awmXsf6G091LQy0WREd?=
 =?us-ascii?Q?o7veM8rcscuq8Uoxmt/EiYWI6Yx9t2evZM3ZDp/VFvIqSwl5svtSqC13G/9Q?=
 =?us-ascii?Q?pHR1/iJwaMFvORf5q51OPK+JKPnn+Zke6IQGAAJ5vNrbPkPWkJjelw52zAgr?=
 =?us-ascii?Q?1XM/Yk2uwLs9d2iWy4DMMLFV0VI//K2HQqAOcylS7oQLLjigQ1Nc9GmzkT9i?=
 =?us-ascii?Q?TZJXRS3SIQEFzaxAtTAEGIJA2e2VSdnUsi+b3LejIeNiNkO4ugx/oVDfM3as?=
 =?us-ascii?Q?/8EJHWlhak9U1iEOnhERgk5n824Jgbrj+On02KYBzXQR6RwKaWt3WbL3Ljxf?=
 =?us-ascii?Q?3KT0ZDRMlbpn6RNM2AuixbEvbQmSbRVbyRJg4P1YoC9WBjAnK4QeudN3G568?=
 =?us-ascii?Q?Q5qdAtVgP/h6/eBSlLWfGSFnnYwxkhJmTiBvf6RwPEWxHVJGfLPpJtPINkQ+?=
 =?us-ascii?Q?oZCp0PHs6wtHoaHTGMCCiB7/uUuiMVpOv/DVfbElc9njwlP4I4UtTLwaWLol?=
 =?us-ascii?Q?5a43HlU2WtaaB0uLfVi7vPd3NF0HgjIOgMiu27UleBRczDTQ5uvwcxpFMbA0?=
 =?us-ascii?Q?ppH5IRU/6kKnmpgcmaze4gG32QL0ZkF9VhdfvRgyY3T22Ye2vdeS/iJjlDaG?=
 =?us-ascii?Q?O04PdSS0r1YrtyMCEQefmgs/2OBMDsJwDh4h1N+JXxviAG81z8Lxb+6idb2m?=
 =?us-ascii?Q?gh0quhrztoNCDT9DK6rHI0qZZZZs4iHxY53BvqLmJHmPZ6uwuZFBV9hpGK5h?=
 =?us-ascii?Q?GrRfPdDi/WucvFvw88aXEzpL8qGjSnB2sGsN9IUXbYTLxjcBn5h5aE4JEuwE?=
 =?us-ascii?Q?Olr03qsli/Gyvq2s0/Ct5YzLDAFkVw4BoTDAZzIcYFY5611+0xsc74QJbVxt?=
 =?us-ascii?Q?bpUdcTBVdyUsbPgZ+vD7IUjyMVxDLspfCnKrBclrc249UGRZl2AGT3LPQZ0B?=
 =?us-ascii?Q?J+XEIW8TIr9akEN7Mvk8tcXDQYulBEdo6MpCMhuNDCz7H7QTy6NIM4xFBm0a?=
 =?us-ascii?Q?hMtOehbva2HDzKFVD5mqqYSRd2ZrEHLU5gDndv9Ht6+/CC2luCYuEfUEjSxD?=
 =?us-ascii?Q?L2AG/zFMAwAIjfaDtzKMTag5iMrA/zSFaU/XLL+24ExEZs0xGQAZ1r1s9mic?=
 =?us-ascii?Q?M1NJTAU9cqevMnTiIz0fsXlS?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f8c3ab7-ead8-4c5a-2ee3-08d9636d323e
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2021 23:58:09.6082
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8FA4b4R51Ssw8SEqDnh/tohJ8lE89Q2u/CkcZbU6/M8Q72UZcQOmIpq37Mtdv9Pv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5126
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jul 29, 2021 at 10:19:19AM +0800, Wenpeng Liang wrote:

>  DECLARE_UVERBS_NAMED_OBJECT(HNS_IB_OBJECT_DCA_MEM,
>  			    UVERBS_TYPE_ALLOC_IDR(dca_cleanup),
>  			    &UVERBS_METHOD(HNS_IB_METHOD_DCA_MEM_REG),
>  			    &UVERBS_METHOD(HNS_IB_METHOD_DCA_MEM_DEREG),
>  			    &UVERBS_METHOD(HNS_IB_METHOD_DCA_MEM_SHRINK),
>  			    &UVERBS_METHOD(HNS_IB_METHOD_DCA_MEM_ATTACH),
> -			    &UVERBS_METHOD(HNS_IB_METHOD_DCA_MEM_DETACH));
> +			    &UVERBS_METHOD(HNS_IB_METHOD_DCA_MEM_DETACH),
> +			    &UVERBS_METHOD(HNS_IB_METHOD_DCA_MEM_QUERY));

These lists should be kept sorted in each patch

> +struct hns_dca_query_resp {
> +	u64 mem_key;
> +	u32 mem_ofs;
> +	u32 page_count;
> +};

This is strange, why in a public header, why have the query_dca_mem
function at all? Just inline it and remove the struct entirely.

Jason
