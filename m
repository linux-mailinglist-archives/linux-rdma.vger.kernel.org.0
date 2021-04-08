Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5D4E358D52
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Apr 2021 21:14:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231866AbhDHTOQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 8 Apr 2021 15:14:16 -0400
Received: from mail-bn8nam11on2041.outbound.protection.outlook.com ([40.107.236.41]:2144
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231451AbhDHTOP (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 8 Apr 2021 15:14:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kFTR0PUpQfvgXDNsPiZVpBA14Fq51MTcywgpbNACtMuZflrcv6jrEpKSsURuvsDpTApZ5+QmKdGkqDbnColGl9PEXRlIBLCqQ2ZzeM7abQdsJY+bK19ASPIsIJVRkVUTI8No3f1p0pmO2mME4IfgeQiiuvPgCpE7fneAyfKG8qvhyw7WJ4+fwMFo6Ub9fPew89WSl5V91S6ERpRz3YTtG4vIikCs6zSC5zJh6rHv91YTXnEjBIgVgIa0c+6ob9J1qc/fLpg/CDKr7y7H3b2GbCDp38PT0aijeJFpd5wtf7qsJQdbGn07njZ/KtwF01lc3aFAOipOFEDFdq2LRFnLjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D0ZNtFiPIc4Ajdlil04VGDo+BgLEyCyVbDK1Sf/JoNg=;
 b=Ow014FN/aY8z4QxeNvpFK297TQPGsyzkdz2gHupf6STRzauelmbR9uyDIaCpwkL4uHMwrO7cs3VgE3wHttl2whL3lHvr03Ks0ccyO0YygdjLCuzbjQCRf5oXqyS2SoiV2m5axAJFtQZWovCzVMtn6aw/Xam+MGgidKbusG6aB3/RUN4II5ej+AJSJ0FkXjMuY7Spi2Fkpg3OGlA2Q+33qn4Dlx4/oCJDrNRcY+X89gd7TKnO26emqvMhWQcl/NTF5zPUh7uHMLVCi1wA//RoZCiwxE8B4qQNEtzjQARkIu8Gp+Fx69YjmQ+2gw35Ty2lrE2QE/xcdP3OJkg8rTFFKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D0ZNtFiPIc4Ajdlil04VGDo+BgLEyCyVbDK1Sf/JoNg=;
 b=J+4v93j5ctyZ5n47TxebeMzAlFBF7OYouyELJpxSiHPHBHnqbphmay8i8Th8S3zFGS8FihL+rhxWbxd9M6aS3exi13dFWhigcwN9dllpwzamlJZDjX6y4M043wRccqJbOWlNjA4NFf+cbJCw//dpJMhYJ0aOW1aPu9hvzSrm1z7P/vvpE4IhfbNR5ryaxzvSi0mVX5/ml+1oBRJu1Kuh4d79QDkhmqv3+REnlF6yDwn9/02nq+jwUF+xllvRzPFIVr8TociHjzuueVAnP+fQn2wT1PiVlpnj/MultP92hvdU7EHU2lfWYN/oGWXwcr9MOhGChygYKrjlCRxo9G/5sg==
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR1201MB0106.namprd12.prod.outlook.com (2603:10b6:4:4f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.32; Thu, 8 Apr
 2021 19:14:02 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3999.032; Thu, 8 Apr 2021
 19:14:02 +0000
Date:   Thu, 8 Apr 2021 16:14:01 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Weihang Li <liweihang@huawei.com>
Cc:     dledford@redhat.com, leon@kernel.org, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH for-next 0/9] RDMA/hns: Misc updates for 5.13
Message-ID: <20210408191401.GD692402@nvidia.com>
References: <1617354454-47840-1-git-send-email-liweihang@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1617354454-47840-1-git-send-email-liweihang@huawei.com>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: MN2PR07CA0030.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::40) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by MN2PR07CA0030.namprd07.prod.outlook.com (2603:10b6:208:1a0::40) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16 via Frontend Transport; Thu, 8 Apr 2021 19:14:02 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lUa6L-002uBw-AF; Thu, 08 Apr 2021 16:14:01 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 558bbe9c-1f08-4606-f609-08d8fac2785f
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0106:
X-Microsoft-Antispam-PRVS: <DM5PR1201MB01066BB2BC583DB79CCBE976C2749@DM5PR1201MB0106.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iZSlpf9/m+UNcHLHpMyizV9jLRXSYuO6lMV0LMqyN2iHFdOMTgaV7QNIVSW+mT86CoI5dJ/NmvWzmd3nKxd2WlYo6Z4ScXFEh0JOQ4ePzN+f5VhbHxHquLCP9wNamdiFWgp8YZI5DTBMrRBcYTskRGStxipr985bAeBFop4NFnTi4LhgsqaYFbRuKRAdULM5bfAezuZiLsEQfvYrQnK26FCJ6Inl2L2+knZl2OdeDA5bD7n2u4yNj5r6zVemWLkfENgWqWCkD1nZqQrWQ2dX39mSS28QLG+9EKTB/ADGkMhXFGCZUM6GBA0yN5+QF1H2KN4ycbfxfcrYWkiZB4MrOKuSgtM7jHN/+J9miz1I7RF6aRGrG+rKv5Iq9g9DtkiydUv7wwUxWBTz55l5CzgiceO0c02YuoSfwO/redhNlVoqF1aAFpbSYEQ/kndz/rMLa8I7jK7fwrr5YjpME4lRByZlTsOOj/3DisOc7ipHILhA2ME0Z5bER2I6g8MWZrEOAaDhiLMoyr+BylJG+R/Tua3vXCVUeWLyFTOT6+OccCdE31C4H8RtmNMScnozkoCmGXT/a8dyIzUvTgi9FNNJIzW1jTqdm16BlV+zzDKjJekLCCoGANm4hOTR2Jfs58RZOyI2VIJPPRTEDt239UYypeV7bAbvaQ3u8WQuwTh1/EuFyBN6y4XfV0F3q0Ds+auc
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(346002)(136003)(376002)(39860400002)(8676002)(83380400001)(26005)(66556008)(478600001)(426003)(33656002)(2906002)(2616005)(1076003)(86362001)(6916009)(66476007)(316002)(186003)(5660300002)(9786002)(36756003)(38100700001)(4744005)(66946007)(8936002)(4326008)(9746002)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?j0AIBNvvdiQ3e8zU1suB5gQBFkdOO+ehYztSvwB2254H3tS6gorpjbru9ccF?=
 =?us-ascii?Q?nnOUcZEyL3GlNBMufB82XJCohitL2rdftHgAL4cU8Sktv6KX7vLhwZ9HvWkA?=
 =?us-ascii?Q?Cv6tIxOJVSgiMLStad6PnAs+7zaCNS4g5IfEjYqYiMZOZMOfdI+1uwxp9SDE?=
 =?us-ascii?Q?a1pEQrAqkt38X7zaXZ+qb0fuwdVDNMoYPLzBCbUhOaWNHnwSRSEozV9sfxMO?=
 =?us-ascii?Q?4LdHi+YeQESg+Fz1R9jzppMB0nj7/mGYkCs56hbmzxmc1hTqVKF3rmmJD5Ab?=
 =?us-ascii?Q?31YUhY8LvabENhsM/AxyCBQKvR/lcZEkjan3W/TUeGMUmvkhdxnN4EgVg65U?=
 =?us-ascii?Q?9SBQgCn3BxRp7OMFaMdiTenDYTAvgpfVanxOdYgn40eNraBr3OsiOx3SUA21?=
 =?us-ascii?Q?cCLyO1CmTzJowSKLSf72foBqfJiCAweuEaHxUBfTAzIGfyrPiELtwmGi5uKe?=
 =?us-ascii?Q?dp0R4rvCrmhv8qJb3sUCWJjxyBBqBfg+diMe6lP8fFVxR/mCj7DPf5NDv+/i?=
 =?us-ascii?Q?6PcvTYVUUTkbycj2PmPLzwSC0dOhhYB9F6MUXPwdJTkIl2ZEyX0kU3KftIem?=
 =?us-ascii?Q?1/Zj+SI6lxaUmsEQasFvndEy+ZKVDSOjkKswJ1wS8tIYbDnmc7X99K4ZATSr?=
 =?us-ascii?Q?b0motYsSDZv05oxsnn6Rl5cJUAQkFQ0Ik/cHp1muFtPo5vrEGnwar+RtQJpi?=
 =?us-ascii?Q?HkPlsg/81QsFgQfVYtl6iKssoJsVy6Mm7emujOxzPW+tnyyXK48Nx4BGUuow?=
 =?us-ascii?Q?uYaquyFwL+yPdRnKea785XfGUFA5ujqbc/GT/LtwF/2lxFVHqfTbLiYIW3M3?=
 =?us-ascii?Q?skRt9UkgZICkjJkYRKfQiTMN0zRfOTX4+WQKU6ABTiR+ukwES3Ze5OuJHeWk?=
 =?us-ascii?Q?yRiAkHw3Oy8vSNagSWSCwDvbGw9BB2Y8iuWLGMDxdVN72UsSs0JejUA1VjUK?=
 =?us-ascii?Q?gPqPs8O6a3qvHA2Zcpti3QHflc62lFqBRaozuB9xw0JG2oiy60beSxpKcyVW?=
 =?us-ascii?Q?CPLYN9N6+BrAUUt9pkoRQMrcT3xv8yrKKoRglOzV+7wBRPV6fSxHIJiREiza?=
 =?us-ascii?Q?RZSZ+SR+7KcV3tRDyiQzNNlXIbMOAHAciQ5Fp+jkDXheEMOjM/K5Y5B/RROV?=
 =?us-ascii?Q?GEMu9Hn96dSbaDZPd0pI2Lw1dyyq7jbmoW6rbYC/+iZ+lY95Y8XZnrxWHuUV?=
 =?us-ascii?Q?1p/5p12Bl6xZ733ep5BZ2jdiRuIekvWeND7CNU+pBltNe+ES+yKbtC94HvOe?=
 =?us-ascii?Q?tlHMuqzNNsrxlUkPcR0ui4jYGlkHJ5fBXTXEdXzz/j1Xb214gXxhXQgtWKON?=
 =?us-ascii?Q?u2lNymTvWRLUND6ZgsCRuUKJgR+Cc19ZWr/+S7hWWtqi+A=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 558bbe9c-1f08-4606-f609-08d8fac2785f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2021 19:14:02.4338
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tjqI7eRUOoTjLM5KCrLCwKEpYK4XweFPnP4/DNT3815P2ainIgviTR3HwZQHRxcz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0106
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Apr 02, 2021 at 05:07:25PM +0800, Weihang Li wrote:
> There are some cleanups for the -next branch as usual:
> - #1, #2 fix issues about inline.
> - #3 ~ #6 remove some dead code and redunant check.
> - #7 ~ #9 are miscellaneous changes.
> 
> Lang Cheng (1):
>   RDMA/hns: Prevent le32 from being implicitly converted to u32
> 
> Weihang Li (2):
>   RDMA/hns: Avoid enabling RQ inline on UD
>   RDMA/hns: Fix missing assignment of max_inline_data
> 
> Wenpeng Liang (3):
>   RDMA/hns: Delete redundant abnormal interrupt status
>   RDMA/hns: Remove unsupported QP types
>   RDMA/hns: Add XRC subtype in QPC and XRC type in SRQC
> 
> Yangyang Li (2):
>   RDMA/hns: Delete redundant condition judgment related to eq
>   RDMA/hns: Delete unused members in the structure hns_roce_hw
> 
> Yixing Liu (1):
>   RDMA/hns: Simplify the function config_eqc()

Applied to for-next, thanks

Jason
