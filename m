Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 984AD39FEB3
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Jun 2021 20:10:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234045AbhFHSKp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 8 Jun 2021 14:10:45 -0400
Received: from mail-dm6nam12on2047.outbound.protection.outlook.com ([40.107.243.47]:54976
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234016AbhFHSKo (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 8 Jun 2021 14:10:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oHy/0XqNZDK2SIyVIpv/zP1QPoLzh+1voy83qnSAnRladUKVr/oBphlBavGtefyFgKXrp0gYuQ4/R2Il0TCu7eZ6n5oH7i3YqsKbv7LCWFCvz2VGZFWOsqX9+ax+Bq/PPNAdK+0SS+YOgwM3C+tjPGAxCYF+oVBSasCcX8nnAYAtQcg8opWRzTbM+rpGe9xzxTdHUPSu8/OZuvIgQwwwn6162w/cocGegH/Dd+1Ol3KOGLay89KGWyolRYZIC9Ej4YDoTBx4b6UH8Sp9ijOT4pyqORkZWp5XJGJklGZKlaxgED4hASJhiFemDrZ5oN2ZAiY6c0VDJZE6YPFO54VaVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lmZLX2w95hGBhOBEnNnh7roStwl/H6bJ8wucO/XXumQ=;
 b=MLMEmwPpLHABDGP7Wxb66NKMjqe4lctXzh2dPiOaGMMhFadWZJ1JynxRgZ01YLV+RJ+8FBsztOSnShrIYBPfH7fmBNsoMh1vSHjVwsT5tBJRUw23SuqtZ6tF0QebenlpoGRvJQ87TFSVx5N5CTpH3V64nfTVyAEkH2VUJJ4egaN7hb1b4rxVGdtQ6SZdLr4LyOCdPTEX9tSIB0YMrv5e0DXCWlHWLvZvmd6gGJCrVTTzfocCyb8h9FvVfeA2CexPexD6uIV2UEwOpEXjlcTnW4ogKmYxdOrpEcz4OKcku+I5oUexlt2awreT/RXWsk+7EIigoQZlV00dW6CbWQomZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lmZLX2w95hGBhOBEnNnh7roStwl/H6bJ8wucO/XXumQ=;
 b=o8Mv8ePCqyUcSU0hiCzoQAJYUwlBop/sjq76sQW6NeMc76RGdMfxra7Nz5ToEpTZkteX7ccwNWDxO+WNnlM3H+DuG1GOuuqx65eLBKo9/g2qN77ZH4/rW4D7jRstZoVOIpt63XPGld9e7x4ed4cERfSmGEF1UhAgOj1WIDCD6LTWJvlE9SqoR4IcfIcAeIIOSu4Uv062uOexyNl3eRRYaNPmm0gLkpu3+1QuEurknqGROPYrFROdwzRkwFB3cajQtBbjm78QYIte7D4XN/ZY/V/OgLqpg1fvU/pWVejylLlp/y3thGRXsvsM3mtHMAvIw2uuH09Z73yiL4eGhAq/RQ==
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5380.namprd12.prod.outlook.com (2603:10b6:208:314::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.22; Tue, 8 Jun
 2021 18:08:49 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%7]) with mapi id 15.20.4219.021; Tue, 8 Jun 2021
 18:08:49 +0000
Date:   Tue, 8 Jun 2021 15:08:48 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Weihang Li <liweihang@huawei.com>
Cc:     dledford@redhat.com, leon@kernel.org, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH v4 for-next 00/12] RDMA: Use refcount_t for reference
 counting
Message-ID: <20210608180848.GA981825@nvidia.com>
References: <1622194663-2383-1-git-send-email-liweihang@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1622194663-2383-1-git-send-email-liweihang@huawei.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: BL0PR02CA0030.namprd02.prod.outlook.com
 (2603:10b6:207:3c::43) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by BL0PR02CA0030.namprd02.prod.outlook.com (2603:10b6:207:3c::43) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.20 via Frontend Transport; Tue, 8 Jun 2021 18:08:48 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lqg9g-0047R6-18; Tue, 08 Jun 2021 15:08:48 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c656128e-c8e4-4038-61e0-08d92aa876f3
X-MS-TrafficTypeDiagnostic: BL1PR12MB5380:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5380BA92A5A28C05D5381ED2C2379@BL1PR12MB5380.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pJbczmxiIPgn/ywbE68GwijkdPa7OrSXPxH/f/eZJ0v482XzjkZ+e64TtmkxrIWRO8Q4vqv3RRjeSfmDh738/FGX37dqovpBp8nsQIV/5eiQpAIRh9ELM8Ys1nxPIhiqw9mmmTH2Eu+Deh48zvaq2x+nA7If3/rKohqKogvDXEumXX4wlwg1KzGoO2q5Y8DZP7KvJ48yboqDm3RBTRSgEm02LX54Muazltg4Ii3tWZFMMC7CQ54CtRuIVqtYstRAZuG1FaVNolFZNALEt71LiMsN/He5r1mHSpZrm0bozor9kT39STbdxuW+E73rBpncXbjTg50ZI1Ba744nUKm6A3rndE0QW2H2bQn6qvWK55ZWFLBra9VMPEbIvDA9IIvxd/VfsV4DCue01hIN+JUGBvIQ34qAOODhhTULnX36JvNrMiONS4SCUzxfSTwqeitG5VWSbLR06WXZorGRbLfLCInBIhamK/F++I0qiM/B7Zu7qleub+eKgL0lYnMU8+1+wed3zPTwx8BJbWSELe+1xxJljOVvsFCUXFA81+xjpUmReDCwA2Q91o8h7P/EbM01AM8dE70L9M3toDNxW76GehcBLKMW1/P2Hfq0gWjI83YCVegKgxIk6MmqW3X1zPkeAj9V3nqbztIdIO84orBq/pXtZXaAFZAa+xFyG6TGz6TS1q0Q2pq4XuGh5hopH5ddNLCa9JJZ4g+ORZtq5ssaQ+rpbJ85EDipsDazJVaQU3F9m37tPI/8cEwluPYh4UgMa/N5OqDt2EVNnEkuxuSXQD4N8av0IRSl+U698r73SEyTJoHvvx2Ujd3ECcNibFYm
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(376002)(346002)(366004)(39860400002)(9746002)(66476007)(6916009)(2906002)(38100700002)(66556008)(33656002)(186003)(86362001)(966005)(8676002)(4326008)(8936002)(5660300002)(2616005)(426003)(66946007)(478600001)(9786002)(36756003)(316002)(83380400001)(1076003)(26005)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ySQR0wr75VYZOYKXO9PTuQtCLBIHGdViwLaltV+OViXZakIa6RjD1PBQA/IF?=
 =?us-ascii?Q?1Ox0oeRTffc0+zCPzLL5DaWlEcW37U2CATNcKayRpKmuClvzrbSJ9u/LcBf8?=
 =?us-ascii?Q?NtW2w/RAzp3ucTWbFeABopN2RgvyC07WTp9HfQGXBGpjMvjIasw2eAzIgexq?=
 =?us-ascii?Q?iSWosiWG6EXpAmkq9afJfQBNV5sPH9NlCveH+ohSiOtzijFOFmY4Ggb8l+xc?=
 =?us-ascii?Q?frGu3q8SVrBXfKestdbcAw9hbOVCwC/fSdpYzL4h7uAAB0SP262yNLicEIHU?=
 =?us-ascii?Q?63gqhHLbSsUdPwqfKvCTO6kZBStR220onDAmtBXR14NIZDCdPMcdv4iAKeoG?=
 =?us-ascii?Q?JPXx1JKReWmXVH1Tc/LH7LTZJTXOzv5lnVgZ6zIwe+5CkJ1SBbi9K8klPmue?=
 =?us-ascii?Q?c6TrhZVEwsthWziiKwANsAqiv49dhFsr30rnZWTnxY7lSgMr7MJEp5PVzERO?=
 =?us-ascii?Q?njCgmarX3DkPcopjaCBi+zSppJcai4mnej6IzamGLGM/TRiCR8sbqA22pcGZ?=
 =?us-ascii?Q?JU+Xza/4x9aQ+RnlCX0ITEpUWjR6mFhJpn76/JvaFzz/ilf4M41nlG5PfsrI?=
 =?us-ascii?Q?FF7Q9e86h+zVYjW8decJBr99cNGMb4eqaz9JN3wTgu5Y9agVi8340mrgr2jO?=
 =?us-ascii?Q?XNZ8RlFLuzsYPCnjxPO65pn12e756x9biB61Mcbdvo3eZPwMAIUXiwCQkDZJ?=
 =?us-ascii?Q?9+wuBLFF3eOW8y0rHSNMVg823o+QhOqbKhigmRaEd4/xTtqAbjMZVRTdOhjF?=
 =?us-ascii?Q?0MRWYY1a79bZ2ROhPYA+YSQJUZS9pB8EGvmwYYnOikus2cq68n3fQ4cjCsDE?=
 =?us-ascii?Q?8/TAY2xOSIsYV6GCtK0PUwtU/Q2Y3D2rSgzd6aVbXe6MRQESId33dvtEhQQK?=
 =?us-ascii?Q?0Hcj1DHPtYfN7ndfWoTjo9fyaE6+OMX/lTOHmiiyylcdpxU8+Vx6wLdlbSwf?=
 =?us-ascii?Q?2qA7xZYBd0nPDd1huSVEoQidh7QJu/+sT2S/dxXS9nMfIED7HHZp+FH5syzN?=
 =?us-ascii?Q?ZScSDDag8qW5HZdkgp+Opj0huJmTmoobbYoua3Stc8OIrCtGhLTZEH/z1H4Y?=
 =?us-ascii?Q?4vqP5/oa3YENQ2yN4N2aSlL6LfNCZYhxBO1gNfTDUrvwLUnlj5f59Kwkw3pI?=
 =?us-ascii?Q?QUQlEbjKS5Kv1IJCJqyChj5qoDDY3/ouwP726ZCYiw2QoGzHoY5faLI71Clw?=
 =?us-ascii?Q?9UBr6cY2fQTNjL8QWFSR78/Zg+Afb1+nBj/PpZ+wFbHVsYfknlZHWVDjwph9?=
 =?us-ascii?Q?rtGbrh++Y0uzD02KAGv8dFFAxaT28Z3tl4GvSKrA1mQE36pMNLNCG3ZSuPhp?=
 =?us-ascii?Q?ixWcHKtgXe5/NI+m08s1hBYX?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c656128e-c8e4-4038-61e0-08d92aa876f3
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2021 18:08:49.0290
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kQLdLnxJuXb6cmFyJiUi5RWmphSjWE6HlDI02ifutv1fjUwhl/6Nj1ddECuEH5zQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5380
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, May 28, 2021 at 05:37:31PM +0800, Weihang Li wrote:
> There are some refcnt in type of atomic_t in RDMA subsystem, almost all of
> them is wrote before the refcount_t is acheived in kernel. refcount_t is
> better than integer for reference counting, it will WARN on
> overflow/underflow and avoid use-after-free risks.
> 
> Changes since v3:
> * Drop the rdmavt patch because the refcount_t is not suitable for the
>   logic.
> * Link: https://patchwork.kernel.org/project/linux-rdma/cover/1621925504-33019-1-git-send-email-liweihang@huawei.com/
> 
> Changes since v2:
> * Drop i40iw related parts because this driver will be removed soon.
> * Link: https://patchwork.kernel.org/project/linux-rdma/cover/1621590825-60693-1-git-send-email-liweihang@huawei.com/
> 
> Changes since v1:
> * Split these patches by variable granularity.
> * Fix a warning on refcount of struct mcast_group.
> * Add a patch on rdmavt.
> * Drop "RDMA/hns: Use refcount_t APIs for HEM".
> * Link: https://patchwork.kernel.org/project/linux-rdma/cover/1620958299-4869-1-git-send-email-liweihang@huawei.com/
> 
> 
> Weihang Li (12):
>   RDMA/core: Use refcount_t instead of atomic_t on refcount of
>     iwcm_id_private
>   RDMA/core: Use refcount_t instead of atomic_t on refcount of
>     iwpm_admin_data
>   RDMA/core: Use refcount_t instead of atomic_t on refcount of
>     ib_mad_snoop_private
>   RDMA/core: Use refcount_t instead of atomic_t on refcount of
>     mcast_member
>   RDMA/core: Use refcount_t instead of atomic_t on refcount of
>     mcast_port
>   RDMA/core: Use refcount_t instead of atomic_t on refcount of
>     ib_uverbs_device
>   RDMA/hns: Use refcount_t instead of atomic_t for CQ reference counting
>   RDMA/hns: Use refcount_t instead of atomic_t for SRQ reference
>     counting
>   RDMA/hns: Use refcount_t instead of atomic_t for QP reference counting
>   RDMA/cxgb4: Use refcount_t instead of atomic_t for reference counting
>   RDMA/ipoib: Use refcount_t instead of atomic_t for reference counting

Applied to for-next, thanks

>   RDMA/core: Use refcount_t instead of atomic_t on refcount of
>     mcast_group

This one needs to be resent

Jason
