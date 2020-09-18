Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D760270192
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Sep 2020 18:05:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726154AbgIRQFn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 18 Sep 2020 12:05:43 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:21600 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725955AbgIRQFl (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 18 Sep 2020 12:05:41 -0400
Received: from HKMAIL102.nvidia.com (Not Verified[10.18.92.77]) by nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f64dad10000>; Sat, 19 Sep 2020 00:05:37 +0800
Received: from HKMAIL101.nvidia.com (10.18.16.10) by HKMAIL102.nvidia.com
 (10.18.16.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 18 Sep
 2020 16:05:36 +0000
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.174)
 by HKMAIL101.nvidia.com (10.18.16.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Fri, 18 Sep 2020 16:05:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eNgVwrIzupHcJLIim/mC/HShkdxN27S40N15K+bcWPnWgPUalwLI/K/z8OzYEnSKI3C+dU9UHNrEtfDhZ6TcYvC0ZkgyUbsTby4plR3efndhSORfYhFu9tqHV4/JcQ0u9i+o3mI/sks1zKaYomF5oX36AgNIVOnO/9jD6Cd+GvOYyzA3ekrECuOxq+ioFRgc5ocoTe0/C6T2PeQXXYzWKUeUWiyTSbj0e0ciy26NJpFPMfJFpHe8jeDgtRiSuXIbxHi9p9I41xsaoOjllWYBrlNdp9ES9lEzPIJlRhdGE88iDSMa3QLn9owjV+P3qaMeaUCx2NBKNd4HGQKaPElYtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KujWuG2+JW5Zt4HdwPmSHgN+ZyKFZnA4oJVFMElPYOs=;
 b=iikmvuzdBriIskTLr25CRpB0mgHpp6PHLHZdEbkrhjIHWLfmiSqYB3zDnoObnqBdiCJXjo+eG/GccvZCvIl+hZroiI4uK5iGlrM7CF1MyTzydYIy8hfCW8liOAtNUhMnV+3uAbZtVvCfOSQjNef9ZTgJtgGpW+hhl2MBUTDbDe0kK4b6bo8t9SK6k+Ybd+KcfJwGhGM0hCtrX3dSrXEcK35c5lwr3xmFL8UzGxH/sxr+jS+BUfpMHsHNXRDOncHKerZva5tQC0zIsnUBZCDwpVk1KuCnpdRt2XB4GYM1LwNGZdBhpdfcE37wsyqhIxfntESLv3q7TA1o4M7r2uwGsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3308.namprd12.prod.outlook.com (2603:10b6:5:182::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.14; Fri, 18 Sep
 2020 16:05:34 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3391.011; Fri, 18 Sep 2020
 16:05:34 +0000
Date:   Fri, 18 Sep 2020 13:05:32 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Artemy Kovalyov <artemyko@mellanox.com>,
        <linux-kernel@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
        Moni Shoua <monis@mellanox.com>,
        Yishai Hadas <yishaih@mellanox.com>
Subject: Re: [PATCH rdma-next 0/5] Reorganize mlx5 UMR creation flow
Message-ID: <20200918160532.GA320440@nvidia.com>
References: <20200914112653.345244-1-leon@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200914112653.345244-1-leon@kernel.org>
X-ClientProxiedBy: BL0PR02CA0063.namprd02.prod.outlook.com
 (2603:10b6:207:3d::40) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by BL0PR02CA0063.namprd02.prod.outlook.com (2603:10b6:207:3d::40) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.14 via Frontend Transport; Fri, 18 Sep 2020 16:05:33 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kJItA-001LN5-7W; Fri, 18 Sep 2020 13:05:32 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cffb3238-4e23-497e-c638-08d85becac82
X-MS-TrafficTypeDiagnostic: DM6PR12MB3308:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB33081FA24CC191E5FC15F448C23F0@DM6PR12MB3308.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VTgibcQ7xAxVh8yX6d/qSfd4dVDtbYQAyZaU4xB0SJBVBtsJOLyq2X7mgFZZOKTAW3G98A4aqdHIoKZt0Xmr5TxvQO0lfsBamk4aHk4ursSMJ/g4FcGFBRh5bK3gElUiuURTgbyl0vKE5FijWM0SekZl8RUESewkS7rYu3Rwb0nZoyir6o6CJFiKTA30QhCGGaUDUuQRFle21nZw668o7wnb8pGrNledaVYLI/UG3PhJJji+7IaaKb58GtjsE0fzHn+NW+CTuKKOEeu57aa4S9VqInFpxPqjabRBosurGG90jW7ndolJqC7FaNWw0oeIo40uTmnMRueFUWk5cPB3/fG8gduQncExdfyQw35bNTBJkkZ+WSdzinN2h5ufsbwx
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(346002)(396003)(39860400002)(136003)(54906003)(66946007)(66556008)(8936002)(66476007)(26005)(6916009)(8676002)(186003)(33656002)(36756003)(4326008)(107886003)(2906002)(86362001)(2616005)(9746002)(1076003)(9786002)(83380400001)(5660300002)(4744005)(316002)(478600001)(426003)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: lxCxGt3P0H7RSszgIfCp6KWI6mztGO/EgOZttULbghtbi+FEkb2jSX1GmGZmUepR1G7K41QC2E9fbPRfI+bIlOykM9S4sZXvc8mGBWhXGYqW0ycLmhd/Ir5hsr3QvqUxI3Q8P+qSB2/zn5W5MZUxwgoMqP5TcI97qi7l7n0OouB/37W1Iljv9EXdNaZIOI5d4gcObYaop9l/TXYi/cjRTFfNpICXUd504SGwsdP8O5ZmCxAduTRSPhmjZ6dTkS1IsDuQLXCxi+7KRAeeJzdhT3lsYqqdosxVxV6//R1yBzcLSC5bMdAnHxKixukY282m6MjQ+uHRgoo+BjrFn6QUL4MMpCTxBlwiGRdlGRzYMGAVNjnkRNVrmHk/839ztN/dsRzW+okwlrGMcol9s0Y85Hcy6C3qEIP5Nh+SnJyq6J6EFPGMaXt+uT6wsIb7JOKO6b3ezpfw4u2PEiwn34+4ySPGwUSoBZzi8fsbM38kr/2gVcA35UzmSvdrXHNKjHLznOqTh6CptM+zCqib5TFbkLFCeYn21dz1838yPPrfQgz6znUUrqG07VFc5RYO4hxYSCCFfnZ4s6H7uKJJpTuGY9ZvyongqhQ1Rdto7MReEUMbJXviSpgaNUH52k+axfQkhRGWdS1xseEZKVB7MMBtaA==
X-MS-Exchange-CrossTenant-Network-Message-Id: cffb3238-4e23-497e-c638-08d85becac82
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2020 16:05:34.6631
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a0H3l3DB+KAtJYnQH38pAUO9X/yYfLEiglrwykgHLjg/kqrWtRBWTw1BeLUtiJqT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3308
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1600445137; bh=KujWuG2+JW5Zt4HdwPmSHgN+ZyKFZnA4oJVFMElPYOs=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:
         Authentication-Results:Date:From:To:CC:Subject:Message-ID:
         References:Content-Type:Content-Disposition:In-Reply-To:
         X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Originating-IP:
         X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id:
         X-MS-TrafficTypeDiagnostic:X-MS-Exchange-Transport-Forked:
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
        b=HWXQd0Ka+mcsgm3cOIoPBkj/5Y0qM1T8kdou9zIDrAjxgVUFKug12qKXP0nZGQLcI
         HqW/c+3DS96VbJvM4hmRfYVtmRl5RIDXrcowLBnPqd4J9g2xZ7/NXo2b2Wo4sqI+Af
         pjxbZ1OGeQ2SzFn1mdSMxQOJmnzoJeBct9v9PDrhLFZLsZR1QgxbW5vjJLvxKl2UTa
         iLFC6jq47BeJhFXaRnghAx9cV2M0TTC3H+W7PzNt6CHw71ZIDJ+H+ROIQCrFRJc+h2
         cRLt4AtgXD+Fj7CzrjIuAEo+l2BgKainrNEIZoZzL7m5hZ2XRPMTqHwJNRiGqmb4fE
         FgoL40n44Kc1Q==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Sep 14, 2020 at 02:26:48PM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> This flow has become crufty and confusing. Revise it so that the rules
> on how UMR is used with MRs is much clearer and more correct.
> 
> Fixes a few minor bugs in ODP and rereg_mr where disallowed things were
> not properly blocked.
> 
> Thanks
> 
> Jason Gunthorpe (5):
>   RDMA/mlx5: Remove dead check for EAGAIN after alloc_mr_from_cache()
>   RDMA/mlx5: Use set_mkc_access_pd_addr_fields() in reg_create()
>   RDMA/mlx5: Make mkeys always owned by the kernel's PD when not enabled
>   RDMA/mlx5: Disable IB_DEVICE_MEM_MGT_EXTENSIONS if IB_WR_REG_MR can't
>     work
>   RDMA/mlx5: Clarify what the UMR is for when creating MRs

Applied to for-next
 
Jason
