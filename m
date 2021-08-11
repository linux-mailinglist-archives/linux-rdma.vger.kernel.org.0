Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D78F3E8F9F
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Aug 2021 13:45:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237407AbhHKLp1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 11 Aug 2021 07:45:27 -0400
Received: from mail-bn1nam07on2067.outbound.protection.outlook.com ([40.107.212.67]:5442
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237403AbhHKLp0 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 11 Aug 2021 07:45:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FH7/nxcbvz4UuURmg9e+qW0++PudrkMr25EKzmLfIMHUTXhiqCsbvDYrSRydL/7A3ymPnHqptoMvk2tGwprMZbt9sWcsHaPF2TTToFlMGIT62JH/q/ffzfWVHyalcBQK6SbS/xCHkKl+poKzGEgzGb2CmHSNqWNnp8Wyt+Mxt72lI1QBw3QXtXNZH1j/M1fJjvfVt5gU0GhqqJtmNtMmeyLdaupnlmx+tT6lUBRaxSqO85ejtaK63R5sBv75D9zwuMO//c+GB9nGOnzU7zbNtemVogFdvnjKwaXpkGiaOi/tAt+6kprZKsrbFURTjsnsY3h6HqSTW+P/IFpWUWObxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T07PiO3l0e/giiGvBNgelD0ejz84y5Ifa+QBD2O53Kw=;
 b=N0oStrCULNhMdl1z2yt/KS01vDJJl5htZbA3NZfJtVNCOh4kkSJrBUAwfN24xBnYZxJcWXrFyMEvBIe+8Ns39J7iQVP5JcH5GnbU003fbsNhgZZG1Ha9htUgPIz0F7xWUocNlVwZXfdkpmtDF76cUozCoeUxKCyzvnH9MDez6EwurQxBStAKgm/t2iK6Uz36uE8n31M2wqVx3OO8o3cnS0vkrOp5N6wWZX/srkVKjJURALoH7WSy5lQmLJTaYLFI0LpoCm6Z/6EfkozLe+iF8B4jMxKO8uRGR+W1NODW2YhYoD4YplMx9K3oE3EovGEqxyHbjCQC1CruMmRskKMQaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T07PiO3l0e/giiGvBNgelD0ejz84y5Ifa+QBD2O53Kw=;
 b=GfHfyUHIwJ8rLeqy8s6eshr+HDgH2Fe1t5/nss6GeJXEIkJBeV+s5m5pLAIaZj3fyli86GSRKJ0IYZg1fbc+AmgrcbXQnHfBiGc+ZhN/r43bO4CIe6dg+o09aMQwgjTuwmUJblCNuRW+D2N4iffCIiUclIHGoHN2lqfTaoA1ywsp7UoRBm0PLJ8y12e4jEeQ7tVQ3EkwNRHiJYG/fiGR6GuJTIcTfrWDrM4tgAEaeCbpnxEdH7xtso2mN2odt7tqdaHLP3+aq7nuvUMwECmqXoxTzFiOy9yzt7G21PRpyak27JkHk51orGm4dQADZDJJZNMMvZ3wCSVVM2hT3sq8xw==
Authentication-Results: marvell.com; dkim=none (message not signed)
 header.d=none;marvell.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5173.namprd12.prod.outlook.com (2603:10b6:208:308::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.15; Wed, 11 Aug
 2021 11:45:01 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::1de1:52a9:cf66:f336]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::1de1:52a9:cf66:f336%7]) with mapi id 15.20.4415.016; Wed, 11 Aug 2021
 11:45:01 +0000
Date:   Wed, 11 Aug 2021 08:44:58 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Prabhakar Kushwaha <pkushwaha@marvell.com>
Cc:     linux-rdma@vger.kernel.org, dledford@redhat.com,
        mkalderon@marvell.com, davem@davemloft.net, kuba@kernel.org,
        smalin@marvell.com, aelior@marvell.com, prabhakar.pkin@gmail.com,
        malin1024@gmail.com
Subject: Re: [PATCH for-next] qedr: Move variables reset to
 qedr_set_common_qp_params()
Message-ID: <20210811114458.GA7008@nvidia.com>
References: <20210811051650.14914-1-pkushwaha@marvell.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210811051650.14914-1-pkushwaha@marvell.com>
X-ClientProxiedBy: YTBPR01CA0013.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::26) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (24.114.84.178) by YTBPR01CA0013.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.14 via Frontend Transport; Wed, 11 Aug 2021 11:45:00 +0000
Received: from jgg by jggl with local (Exim 4.94)       (envelope-from <jgg@nvidia.com>)        id 1mDmfK-0001rb-6M; Wed, 11 Aug 2021 08:44:58 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2265f587-523f-432c-b55d-08d95cbd738b
X-MS-TrafficTypeDiagnostic: BL1PR12MB5173:
X-Microsoft-Antispam-PRVS: <BL1PR12MB51733390A7BF473A930321BDC2F89@BL1PR12MB5173.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U2aC4Azjh728YdAy9RBJzVbT+4eFN4kuLxAoqKBjUP3sEPuLyMLB6/Ly1nVEKvlTnW2/8/AHPkpTk7zrc4gcVEDex6gP1TVHYTCIhwcfkeEpl75+jQY4TDT/Gl48G3ojn7tuWq+WzosjdBEFoiyV8TtJyLJ1XazD6IOeprarxuCA67lJX34YTzgvQTLhaRYlwA0M2rcU/DZa9Ozn9Mqn6KNad4Mw0yqGijnkqI7VkF1EHuy2kAfEatYV8W7GQT8zXwzLAHvaNKy3CcImEeGQdh2RxWx7hSvkp4/s0CEPiBbepMSUTS8euLN6f+si1E/AimGmsZYszCgn6CFgb+DTt8pXQIKIUE+O28LCYGcItysTGxDTMh8aQPd+R4xLLWF3Qp8F6ooTI9p7+U5KscKJrXe0AYlT1RwCpD9bVViToJY8UZPY5G5UBO0tao1GjoBtNT57l4pr5XPeOHQFxFPSBtgMAIzTgtBV68iAmJYBUtSuVfF6Sb/CJq4TBUSdFH8S91v7vxlNH2DRiRWITDlpUToKDkHGxBHQTjQpN6rOYS65kx/y2ob6TR+yCu2+JQXdQrU2Fv0h3hWKa3QCFB2RE81ADNKHSspjzWOVH4EA7dxzZnb8snLptYrGs7vmDQ8WUk5WiTr1KwQghmTgR+F0XA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(376002)(39860400002)(366004)(396003)(9786002)(2616005)(1076003)(33656002)(66556008)(38100700002)(4326008)(7416002)(66946007)(5660300002)(9746002)(2906002)(36756003)(66476007)(8936002)(426003)(186003)(4744005)(316002)(86362001)(478600001)(6916009)(8676002)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Pmpl5mW/nOVk/BgdMPGzRJmJQKUlInWqByIjRfiRif40/VP+n0A70lMAymAT?=
 =?us-ascii?Q?eiEiBTR6xdto3dobV6LTRMtKCkF7fO7LW/JAHg3mdrbhcVldkP+N4CQusUNK?=
 =?us-ascii?Q?Bxar1vjSsN1tk8qjMdtattRiZBQ9p3o8dMGzmrs+tpuPBshsd1qt1934wVoM?=
 =?us-ascii?Q?Ym4MJ9hqcKoE1bFhq91el8ErCnqLboXuK9JVOIL1BGFioARSQsy7ZgEngovF?=
 =?us-ascii?Q?BRNxTSvf0czAFyyJ3ckn39oGswjGEBhS0wQCAKhzPjZM0D5eWllKDQWdmkda?=
 =?us-ascii?Q?WyKW4R7eNZ001mTEiLcljGdwTfekEsKF4EEtAXF7CQg/PBy/ZYnSP75Ud1AT?=
 =?us-ascii?Q?OoXParspCigTA1To+DNt1Np3D+bKvTolyTVZ28tge/OvIKZjeNpWCpD4wclB?=
 =?us-ascii?Q?r1oLarUrMrEQiN2p736qtyPGdlt/XNsJgKnpZkBK1SAH3Juwe8YPIH74VOcx?=
 =?us-ascii?Q?lSUjwOl439iK/wanMbYB9txIkF3EltMnANuTzPqfkmNKALpw7bwYV33FC8Gv?=
 =?us-ascii?Q?+YDGttWg45IeIQIqpsoXdTyfaPlvBTBCrsTnTb/0GKxHm0h1AhqMas4kQO2f?=
 =?us-ascii?Q?alEAoagw3W1SdXiLqRCvjszQIkN/gUY777D0neSPjjmNBvP6nvmPo7f02mcX?=
 =?us-ascii?Q?F/tKk2tRJpC1VdOrsdhZ3qsgmcMYyvSmA5dPhkRRAONDJx8gNjwvKYiIqKgs?=
 =?us-ascii?Q?xmesg/meL40/PmiP1QsNGxqceZfvZgt8OOBfbIjzWYeqzkrJicjPrdWauBKr?=
 =?us-ascii?Q?KKvBlbxPJbZx2wTFuAfivBLxXnCQ7kUGnTYpvNnTKLWrmhKhb5wdPRzjnCJi?=
 =?us-ascii?Q?0v1so9oKONq5IGI+Spmhj3ZQjbtow3hbRpbzj+m2z3r4sf26m43r8WvuDZHz?=
 =?us-ascii?Q?taWOxA7nZQdhUL+RZsrwEhaSCRtr5KE+Fo2loxie1CP/B8WrptrfIedhp85g?=
 =?us-ascii?Q?LP6IaFLct35mva7iRQe+Tc3xEDDcAhoxp5rNzgLqzxkgVB7riInu66s4KAmT?=
 =?us-ascii?Q?Fig84f0642bFBCpP1fXOXYAPYVNy69ThULOkuVeqx7FfwCEv5TlnWat84IiH?=
 =?us-ascii?Q?vjYVPaCfpQFpBSOegA9QrJpfSMeF4UZ08JuSLFyW1tpubAuDbaaoyfIr8gc+?=
 =?us-ascii?Q?Z5wI0DcFM2eBDtuhtZGUvP3oVFk26yMaUvZ0ggxzOO46F3mRSL5GjAtabmc3?=
 =?us-ascii?Q?s2MpsMPq78xlyLFs0bIi95/9PxiKILqhrPZTohaVyieWEbNvEu6BPwZje17u?=
 =?us-ascii?Q?QjRE8F6mD1b6ONWO74lBqp8jQihg8JFfWm2TZI2BEaZj6zTLGPZ79Wl5Mog1?=
 =?us-ascii?Q?MF85GtHkF6FoFStJq9dQ93wK?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2265f587-523f-432c-b55d-08d95cbd738b
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2021 11:45:00.9548
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EWARU0locf8g85pevcHVLPG+INFQ1o54vfh4OLyj9xqBCHwhKnTqTRF/jwnvYn/c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5173
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Aug 11, 2021 at 08:16:50AM +0300, Prabhakar Kushwaha wrote:
> Qedr code is tightly coupled with existing both INIT transitions.
> Here, during first INIT transition all variables are reset and
> the RESET state is checked in post_recv() before any posting.
> 
> Commit dc70f7c3ed34 ("RDMA/cma: Remove unnecessary INIT->INIT
> transition") exposed this bug.


Since we are reverting this the patch still makse sense? Certainly
having a driver depend on two init->init transitions seems wrong to me

Jason
