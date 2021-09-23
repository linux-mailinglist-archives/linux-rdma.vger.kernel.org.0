Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70ABB41663A
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Sep 2021 21:56:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242982AbhIWT6E (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 23 Sep 2021 15:58:04 -0400
Received: from mail-bn8nam11on2056.outbound.protection.outlook.com ([40.107.236.56]:50113
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S242955AbhIWT6E (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 23 Sep 2021 15:58:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UuAh1N2pXByi1cpkaAF7T8/TwdHu1C/LUmQTGi2sISIEUInwMCgyjgBnTxKCNZucdg8Ek4Q3FWuTyJsrrXrIawuQWS+wzzTEPJ2Wor6tIs/RjmfXsq77sw60VrkyOgHvjtco2jngYzg/LqHsgxPoMEaF+jDkehy7hiTRkFE51bKv/cViULEQaCVuLs1WMhbTJYM2uUOT3nytl0SY2sPKPXwIvFCE+BpyXyqMSTPYoTB8Pru2jp5q1BQZ9QevTP7h2MLnXl2p6ImfLxiNOq1BT2rDgr+1cLECeFo1ueH3RkMFh1fB/J/f+1DlPpLCe7uFj8gtrbZ9CynsyRqSVamMng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=jdk1RFSSgN73xxWCa1kUWUNQw2+foZCA/tD77pY4PiQ=;
 b=fNx3dHsMwDAdrijUnnGSrDdV8ai19Tp9SQ9SONsgZMWWSzEtKIkHUZrJd9yrMlkHpGJ3xvwDCElzEUHH0f43NFHDQksy9PFBUau5aPEHniuxmwtYEvk1GMBc8GezO2LlDbE7aa3BJ/TbJDrpDSpMgDfGCDzhVVq+LhA+hGPtGv4wZoef9DhWMkqrc7j6/Yk9zXhWvjxO/O17gv5ZBWvWRkQR2BQOVl20rkZ05DGN6eQMgyGimaKTFweGoSKFdc8gyh1cU5TSReMwcO/FYVnWazXQX95lUr3w3a6yVm0ZBpyauCaRfg83p1QlsdfhqzO8ngqDFDmpvOHklZdY9/bxWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jdk1RFSSgN73xxWCa1kUWUNQw2+foZCA/tD77pY4PiQ=;
 b=H4v0cq61hMpV1Vtr7Vmqngs4uXvRGZv8VyZJccgYuLYBrfrZ0sD56KoQpMfpCFD46sdR3lQZASCMHnsAikSY2WgcymrpkJ8+HNA3GUOPPJF87Nk0aixCBRVvd8AwX1srcdaMuXRbY6MWRh1epi4n7i3roTW5QLlF3L05jjqBvhHLYkcnSCf9o6gTLGy87aoufH4NrANDx9uHkeqNkTuaXsDqoZGw/OoukFvWk1M4UfBHJiVKDrfmpg5Nf4NjeMXY+k2CVIM45u7ykWeSsDRHSuSnr4gWL0gFjegvlBgykNw/3A/z+We1I+3sCQBfqCGkCAReS/0W8iq+fclQCJmOsQ==
Authentication-Results: umich.edu; dkim=none (message not signed)
 header.d=none;umich.edu; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5304.namprd12.prod.outlook.com (2603:10b6:208:314::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.14; Thu, 23 Sep
 2021 19:56:31 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95%8]) with mapi id 15.20.4544.015; Thu, 23 Sep 2021
 19:56:30 +0000
Date:   Thu, 23 Sep 2021 16:56:29 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Olga Kornievskaia <aglo@umich.edu>
Cc:     Bob Pearson <rpearsonhpe@gmail.com>,
        Zhu Yanjun <zyjzyj2000@gmail.com>,
        linux-rdma <linux-rdma@vger.kernel.org>, bvanassche@acm.org,
        mie@igel.co.jp, rao.shoaib@oracle.com
Subject: Re: [PATCH for-rc v4 0/5] RDMA/rxe: Various bug fixes.
Message-ID: <20210923195629.GQ964074@nvidia.com>
References: <20210914164206.19768-1-rpearsonhpe@gmail.com>
 <CAN-5tyF6vJQEK3+FJ44+7T223nMqs_dSXYKOKz-fPJ=3OHK12Q@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAN-5tyF6vJQEK3+FJ44+7T223nMqs_dSXYKOKz-fPJ=3OHK12Q@mail.gmail.com>
X-ClientProxiedBy: BL1PR13CA0275.namprd13.prod.outlook.com
 (2603:10b6:208:2bc::10) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by BL1PR13CA0275.namprd13.prod.outlook.com (2603:10b6:208:2bc::10) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.8 via Frontend Transport; Thu, 23 Sep 2021 19:56:30 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mTUpZ-004Wh5-Qx; Thu, 23 Sep 2021 16:56:29 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ca8cf5c4-ba99-45ed-4e47-08d97ecc3cc3
X-MS-TrafficTypeDiagnostic: BL1PR12MB5304:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5304DD244567C2F47779B8D3C2A39@BL1PR12MB5304.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eYO+EkZZCQO2pmpGUBrlP4oP2bfQSFg1UP0qqhJz6O4dMUOghz6bxV0U/6Ah6mUbmOB0vD02wO9qYYxATTQ4TJzX4eTtatp8iYm96C4eUI/l6vMSaQEIusjNrB9mAONpS2K6aCwzWnn2i9i8ROZRRY4Zpo5BbZW7Dai68pMrclpBdWhB9lEh3kSG4hWPi1YpFw10tn4ZaV7eNX1FxeGYvwYkrjV4qsRFG6bTufzp7T904eOMYeqn/KyzpNS+rqIPxpwkDBhsNOc7u3CrnshuiKJR3r/NkaxxC+tnZh+ZfDFf0C09T7s0O6DwLEDcqnDZA061u2UBHOng3J6i5VgQY1nzMPGztuk+LQ0X/MV7yNPzbvKWIkaYskPc5s9gNsqtErFZSI0q7qBwcrSdJH3Ua4WV3rbEaNvP6XarYdilfStivbaUwoEn8pWs8Nuu06zsZMWnXOctpWjAeQyL3RSQHkeQUkTYSw60lCK5MoRYhX3waCSmCQSIKcFMs0BLiNcVvx1epMwUENEIGbaaSPHgeCKwXYUvuGNsT4jHeTsW6IbySdYnIL0IdRim2rS18/VW5k/9+l/spsMXAry9BHvCofi20GGEL/QtR1kE3oR4b3MbjqF9EbMaBwu47+OVo3eeiR6hpu5es3or4Pj6F+fCTqDrCgHvDWsAe6zZYeMR1wefYaEvMgktJRdJbL4VEopW
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6916009)(508600001)(66476007)(66946007)(426003)(66556008)(83380400001)(316002)(8676002)(36756003)(54906003)(26005)(5660300002)(2906002)(33656002)(4326008)(86362001)(9746002)(1076003)(9786002)(53546011)(8936002)(186003)(2616005)(38100700002)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6GLxX/ixPqWoogQeyLED5VbDtMb7GCrK0UWDJ89QM+JhsQg+p7WJcm80yDrK?=
 =?us-ascii?Q?xf2fGfWdhtWVQudPmKg35Ez5KDf0l3liYEMfITjYn4m+Z86mvvc9M1RzmEEQ?=
 =?us-ascii?Q?/JJM469xUCnyLKJDU2SYjT3T9oBkLmmtM5jCv2yKFQt9udKMzklHUoNR6MD2?=
 =?us-ascii?Q?aQsl87xq+N19yCPBLVby1mfLNA68DpwtLEGD+5MKkWYnpng2rWA/lC/T0cE2?=
 =?us-ascii?Q?DBlXqXW9f4elqtsr81aV41RWlqFDaS/7wkSv9UuarUih11TvWWKCX41ws59h?=
 =?us-ascii?Q?4RqxMGS4Tg8hvykEqFE4cXCa78x4IZR75vQP1wcIWzQY/65K4eCO8K+/iw+i?=
 =?us-ascii?Q?ZmmNEHQYbOnCeevih5zW1dA08h8ACzuSSUfAjgz2FE2OZ2IQxIksxPFJqLsR?=
 =?us-ascii?Q?ztbF3hIe/day++5HLJ0RzEA6KuYA/r1lygeicrz5cf8jw1aJd+0MGQWHdUzq?=
 =?us-ascii?Q?smp6WFcESulvRAGL9kVxHYtpUbs+gqZFmSfo9rOtxdwiT3nLEYOdnSxG8MrE?=
 =?us-ascii?Q?5d6L80x/oAS9E7WQVf+63bTCvJarauYv8NWN8YS5IgEDEWcerxJVDmVV/Jw9?=
 =?us-ascii?Q?kl8ApQRRae/sqV8mppT9/jgiLNGOzJMNrklJp6emtOzGNXhhdqOPuzwR45Te?=
 =?us-ascii?Q?sh1Q7ZxZ/Au4AgW5573RsgfW4qS8/zCKxbEgqTN06BMKqBDm9283PNmZK7OA?=
 =?us-ascii?Q?XjOnqnfkwoINAMbsFUq8pGRkI4j6JZ1YQyN4mdniA1B7eh0vn64BlnxS5D+R?=
 =?us-ascii?Q?wGZOg1Ehk7biBEaZbyJxwcEfolF0dTkERl1JtB0eP3ZY5p/spzbhDLuo4VNv?=
 =?us-ascii?Q?6+4pplWidi6yjblwcQVRWQcGTkGEZmxKTFD9EJfXQqlNXMDzolQT6GS3yR9a?=
 =?us-ascii?Q?AyiSeQZUEdv8+9oLphUxj23+DwxJ+VRnc12wUTVPBp6txcthlg2FgLI2wWgk?=
 =?us-ascii?Q?DD2kQAdqgAEbe/0k3/qr+RmB+L/K9oUH+DPmbdI/gCY78KpZ8nP/eKWn9paJ?=
 =?us-ascii?Q?RuQhDUWLOhsw6f7nmua1FevFihAOB3LFseEOlUuLRx2R3Wzx0J9rx1acG7B8?=
 =?us-ascii?Q?TpPvGrIeoi2nuMQBHUlKzIHngu9DE4y6XiVEjU1BUa2SintcZc03vkMMWpQv?=
 =?us-ascii?Q?MoklTLCP22dy8mJvu2su05uoi+uE6acSDLHztLUSEZQmntaNgX1XymTMXSFJ?=
 =?us-ascii?Q?IRPZecY+f8AlkE1ycBuJVfg22RHwcd0ggRZb7ozpyi3HWegoij1XD+gEqfAK?=
 =?us-ascii?Q?YX5KI778tQmi53z5VjfFfe0lk2JWSRQtiKg7DwIDFOC7R6hk74Wonm2yacs6?=
 =?us-ascii?Q?L2NmUhHLj3Qj0jW1E6skep7a?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca8cf5c4-ba99-45ed-4e47-08d97ecc3cc3
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2021 19:56:30.8840
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +aY28SB/uMPrANfmXjamOCBinPCvTm/F2ww5hObn04g5k+BdHmQCCFWmkCpvyiFW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5304
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Sep 23, 2021 at 02:49:54PM -0400, Olga Kornievskaia wrote:
> On Tue, Sep 14, 2021 at 12:49 PM Bob Pearson <rpearsonhpe@gmail.com> wrote:
> >
> > This series of patches implements several bug fixes and minor
> > cleanups of the rxe driver. Specifically these fix a bug exposed
> > by blktest.
> >
> > They apply cleanly to both
> > commit 1b789bd4dbd48a92f5427d9c37a72a8f6ca17754 (origin/for-rc)
> > commit 6a217437f9f5482a3f6f2dc5fcd27cf0f62409ac (origin/for-next)
> >
> > The first patch is a rewrite of an earlier patch.
> > It adds memory barriers to kernel to kernel queues. The logic for this
> > is the same as an earlier patch that only treated user to kernel queues.
> > Without this patch kernel to kernel queues are expected to intermittently
> > fail at low frequency as was seen for the other queues.
> >
> > The second patch cleans up the state and type enums used by MRs.
> >
> > The third patch separates the keys in rxe_mr and ib_mr. This allows
> > the following sequence seen in the srp driver to work correctly.
> >
> >         do {
> >                 ib_post_send( IB_WR_LOCAL_INV )
> >                 ib_update_fast_reg_key()
> >                 ib_map_mr_sg()
> >                 ib_post_send( IB_WR_REG_MR )
> >         } while ( !done )
> >
> > The fourth patch creates duplicate mapping tables for fast MRs. This
> > prevents rkeys referencing fast MRs from accessing data from an updated
> > map after the call to ib_map_mr_sg() call by keeping the new and old
> > mappings separate and atomically swapping them when a reg mr WR is
> > executed.
> >
> > The fifth patch checks the type of MRs which receive local or remote
> > invalidate operations to prevent invalidating user MRs.
> >
> > v3->v4:
> > Two of the patches in v3 were accepted in v5.15 so have been dropped
> > here.
> >
> > The first patch was rewritten to correctly deal with queue operations
> > in rxe_verbs.c where the code is the client and not the server.
> >
> > v2->v3:
> > The v2 version had a typo which broke clean application to for-next.
> > Additionally in v3 the order of the patches was changed to make
> > it a little cleaner.
> 
> Hi Bob,
> 
> After applying these patches only top of 5.15-rc1. rping and mount
> NFSoRDMA works.

I've lost track with all the mails, are we good on this series now or
was there still more fixing needed?

Jason
