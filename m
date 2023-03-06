Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C86156ACF8D
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Mar 2023 21:51:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbjCFUvZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 Mar 2023 15:51:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjCFUvY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 6 Mar 2023 15:51:24 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2076.outbound.protection.outlook.com [40.107.223.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FABD23653
        for <linux-rdma@vger.kernel.org>; Mon,  6 Mar 2023 12:51:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=goqAFZIxxT4mLNnkK54v9CBNAlLg+qOZGkt3KzD/u5ej4h73WK1dcVpHUTINmeSyWviA3pp7GOdJM82LN+Ylh1NSNiQ6Wm6eaHdaOdfMDxWRBgWYETQRE7v9tpwMd2yl/HnrGAKwQjh6qh48pXLMBpfEfFHMJSPS8dsnM/Fc2F3L9k7fQ5Atxcq6ykBC175cM8c+ic+VrqRP34mLctYUbKMk0s//cFNTZnFpAzm7Q05qXni6E549kIAsTexh7KRSDgrf8QSAX3D0wGV2DGhG0sa9gOpMzn7/2kBvfYgrpDt1iR0LHAdv+D5I65dnlzDSMI/4Z4y9zFE2tGKqE2m4dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BULoYKYesER5Np/PMPslunTn8kP7MoB4TPo5ASGZqB4=;
 b=fPyAFXZFNTH6hnNVMc6woptADm1cR8X3QkRvrxr4olHrxpGZZP+wmGA403l7M5e/7gy0Or6ycOxqMZGY7R+a7DFKgsOqJzE1h1rebPXKDSBj3evfE6CPGch3bpmEXhRe6z19QmrdCOEZhJyo3c19Um125Gqx47tJLonBUe5WJFB0pfYuGHBHuX54LW6PzGveAkwyTumIhgyn4wvdlAirApypbsiSz2Foguhb4u01dSXK6fv80TbR7jSsqvtQFniEgxBAErGRssYhJY5UuOsA8whsxiZsREUSdFDL5FJdl101BdKmZdmcjnkE9U+ZV07hGLYBJnLIKAJgVTC6aPO6AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BULoYKYesER5Np/PMPslunTn8kP7MoB4TPo5ASGZqB4=;
 b=hiQqAs6c6y7O+esZOZMUGtSWVXiT/lZL2gzM4Vu0l0o+cYm8+j/gqYMPuCNUztSzPTVXF7bKoj0OsdaAMGnjrDUBtnzV5D2xjTSsOk5c32L8aAbDr5tftFnROzaati/MRRfmQhTww3p5BGUwGqMfjXm7qqkOj+6DFWIDiVMasNp0CvOOeHScJ1XeYKTBf80VL7H5isWiSlJ4Q0WkT1ODKk+6PZI686KA5yYIAIjar+NXuJJleqNwgBoe0YbDWOkc9+wMm6qNZb3ybUqhbnSH7gz+6p3i+4PpgR5S3zQIhLobiNRjg5lo+gSMRynufEv4WZkR9+MPfcdRQ4wRjogzbA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MW4PR12MB7013.namprd12.prod.outlook.com (2603:10b6:303:218::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.27; Mon, 6 Mar
 2023 20:51:21 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6156.027; Mon, 6 Mar 2023
 20:51:21 +0000
Date:   Mon, 6 Mar 2023 16:51:19 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     zyjzyj2000@gmail.com, leonro@nvidia.com,
        linux-rdma@vger.kernel.org, Rao.Shoaib@oracle.com
Subject: Re: [PATCH] RDMA/rxe: Fix parameter errors
Message-ID: <ZAZSR2g4ZzESuXRc@nvidia.com>
References: <20230119180506.5197-1-rpearsonhpe@gmail.com>
 <Y8mXfmju8W+3FdDp@nvidia.com>
 <108cf8f1-6123-620e-8700-53246c7a8287@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <108cf8f1-6123-620e-8700-53246c7a8287@gmail.com>
X-ClientProxiedBy: YT1PR01CA0133.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::12) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MW4PR12MB7013:EE_
X-MS-Office365-Filtering-Correlation-Id: c48a71f9-9718-4405-1a3e-08db1e848a60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TKTF5MwbXSFsVKgRn0d6ELgxr6qIXMOdGSpddFjV6Hn0n2CG4SvAgSzlwkS3L4yJwDDoS9S5FDCDlk47hZC0QpgEsNZxEF6xXDZyxwHfvNuPjfZnfBTd2cwlT2rcT/cuJZKzbZeTA0Hed3aPxFI5CbBgLehqWDDgFU/OKQULHySUyYqnfUMRUgJZ/3ZXY6MNHqG8RWVsCtvDdk1xrBo4sMzsTvH/CP8FLajEnRsfCdXYEaD5mnfCKT36NO6PhOqy0UnaHmQVCbAL3PlF+bPScfY/Bcb0b0dsNCQLwO+mZNPguF+0p6Mc3Ju532VC0VJanv9K2cueHIOvk4gmW7egguTcjCQSE7jg1EcbvC15QzmWhu7BimIRGnEj4sfL5WcBKojd9SVz7hJAFRlezU5mWWGAoh/AptYyKRRXSBr/IfBCLzPTSvx8hB+jqVmmEyc1Y59DNNovTjbq5jporKsMYW+gd1c+R/XQGb9zOg5/SuuvAaNSGh18CIJghwE7Ft5usc8HshM56a7JerXp6zlaCTutwNsd6JD6DjUL40lGKkhz5J+rcq74IVD0VxEK98Xvig20OuWRPoNgZtl/zZxjmrkRL907qgU12HWdsheiZMldhATX63ADwEss4+N9OLmP8i9BFHR/kJ7nzw+bHAcCvNk+8QrLMNHBhzN9/UwT4iIY0YOtZg3XhiiT5B9UVjBS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(136003)(376002)(39860400002)(346002)(366004)(451199018)(36756003)(6506007)(6512007)(186003)(6486002)(966005)(2616005)(26005)(53546011)(6916009)(478600001)(8936002)(8676002)(4326008)(66556008)(41300700001)(66946007)(5660300002)(66476007)(316002)(38100700002)(86362001)(2906002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4z0T1z7GFy2ASkyA2h0pF9/f8328kGkJF3RIg1yY9ck3eKCf6G/fj0x4IGqp?=
 =?us-ascii?Q?Os5HtiuJR4l09pKfQGDMDRR4QjxhOdOE2Vg4ChAMy+oNVEhb1GDxbra2qDqX?=
 =?us-ascii?Q?t1gYKu8KYKIVisXoE2hghGshxKm76CjJpJnbqNSOKLreJyyOG8LN+45tQtZb?=
 =?us-ascii?Q?f/vH4u8Od07oXOEnTmzqnP5JyDQCx0tidBcPthBZVZgH2ukDY31yAf2TjH1T?=
 =?us-ascii?Q?6OMNwbWtJonbrCq8xh0lyhPJp7kMcgoqlTLMUBvikVQLsLFV0Cy0I+HBVZBM?=
 =?us-ascii?Q?oAsRd+7PAsV+MVJ00OxUKl1MDfmcqGhNlsrCHE9I8i6POI+zDte3M0t1cZJk?=
 =?us-ascii?Q?K21yu1Z4ZlyVQgaheLVWH3H4SUmMfMDxDBWAx8+x/boq8gvKrPo3aN+ORQsW?=
 =?us-ascii?Q?XISTIwSKLmKF4dA5llwSB/SncTs17QX/tIadeuMnXEGMtbAMyOWp1h5iDPDG?=
 =?us-ascii?Q?kxPC2CbG0tZFpIKw8xwC6DH+2SFk6dvI5EUs2IBm3lLr39huevV0sxARcXkv?=
 =?us-ascii?Q?Gs2Y+2yphd1bdRpS4GHFMf7jTjvhMVkVFi3ODUJysCdTdcyMlLGj8PqHev19?=
 =?us-ascii?Q?PL5ayz9mZryX2Q+hDiFDhvlk15aS/fev0w8QrOYLUaSg+LTnw38U8nwCJk45?=
 =?us-ascii?Q?kPuElbVDSYazBMXpBrh60wzq0tnsUgiqfY268bdLSRDrdx9oUN9BdGnXJxub?=
 =?us-ascii?Q?JYgbvaZIQul/rXqRoaqVl8a0nZmwbiiTKtBAVuHwlEiFzoqe1WZrgnMrV42A?=
 =?us-ascii?Q?cAU03Zbuw+Gh2KLFWF56xRfAGKvura3urA7ToXuGj0yr51lkz3BuQfC7Ek7I?=
 =?us-ascii?Q?THSINRX294KFdBR2339iS0JMSqQFMOtj+jVnENBmbU0BsiDTT7WofswXDmjA?=
 =?us-ascii?Q?gJtK+/AMXD2tCyXcANHLdHE0uF0EXpJBAU0ug644cDV18+mFH5k+BGa5/QS4?=
 =?us-ascii?Q?AWgWjCO+NWZ9huOSN5l9KVireRDMf6l6+mIT5B6fcq7cHn/fN/fkSo+Y7/g1?=
 =?us-ascii?Q?TkaomxUIsm4K44IAaat22DmIxTKaHnScPD/YZYO9Or5RM0El3wTXZgW9ZqpU?=
 =?us-ascii?Q?CCJH6MyDQVFlokWnwTqAw/cqoxtGwGk9RguBEDuPiZY9jX5HSo6ywim6FdRX?=
 =?us-ascii?Q?KlvmCsHRORRpmxwDu3RsT7lr1WYwtMu3+R/TQOv89vi9oRepVkFSTdAF9Azx?=
 =?us-ascii?Q?5QoEcL36tvqHGYmCllmnatyXAwsN/FIB07Yd4IW0vnVliVTrBrSCs4S7M2gH?=
 =?us-ascii?Q?6cVdytZHgJw47zggKoJEVhNDrSgXPkbghqC5CHKLKaaqcDtgt7ruZn5UHFaD?=
 =?us-ascii?Q?igGQMYVazVhti0dYAWUAeuHIxn8NyRbXWj6kH7C9bZw7eLoDqH2GYrmysER2?=
 =?us-ascii?Q?eRl/ey29B8d1ofwibxSU4BJVLL5a66lHB4Wm6XPZ1sc5cr0mL+D/sc5eR6wJ?=
 =?us-ascii?Q?ubZoN0yug6EMPD0P3XtkoSAbujgTNYwcfYRXsdOd4GFNIc/w9k8FC9mzunT2?=
 =?us-ascii?Q?rTcoOm4SvUFLvQ0BfGEhLYlGBoeCvmi80aeRk0F9Pdt9/NjWZdf9fPf8mu7G?=
 =?us-ascii?Q?tr154bUoflbWCxj24xKB9MXqyMLCnjtT4tIeoiO+?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c48a71f9-9718-4405-1a3e-08db1e848a60
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2023 20:51:21.1430
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hZqdCdDvGC4xOT23jvp3T/qGCDjvExN3fi9v2hJ8A/JGmTcGGzww+rveNGKZ0Kg9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7013
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Mar 01, 2023 at 05:15:07PM -0600, Bob Pearson wrote:
> On 1/19/23 13:18, Jason Gunthorpe wrote:
> > On Thu, Jan 19, 2023 at 12:05:07PM -0600, Bob Pearson wrote:
> >> Correct errors in rxe_param.h caused by extending the range of
> >> indices for MRs allowing it to overlap the range for MWs. Since
> >> the driver determines whether an rkey is for an MR or MW by comparing
> >> the index part of the rkey with these ranges this can cause an
> >> MR to be incorrectly determined to be an MW.
> >>
> >> Additionally the parameters which determine the size of the index
> >> ranges for MR, MW, QP and SRQ are incorrect since the actual
> >> number of integers in the range [min, max] is (max - min + 1) not
> >> (max - min).
> >>
> >> This patch corrects these errors.
> >>
> >> Fixes: 0994a1bcd5f7 ("RDMA/rxe: Bump up default maximum values used via uverbs")
> >> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
> >> ---
> >>  drivers/infiniband/sw/rxe/rxe_param.h | 27 +++++++++++++++++++--------
> >>  1 file changed, 19 insertions(+), 8 deletions(-)
> > 
> > This
> > 
> > commit 1aefe5c177c1922119afb4ee443ddd6ac3140b37
> > Author: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
> > Date:   Tue Dec 20 17:08:48 2022 +0900
> > 
> >     RDMA/rxe: Prevent faulty rkey generation
> >     
> >     If you create MRs more than 0x10000 times after loading the module,
> >     responder starts to reply NAKs for RDMA/Atomic operations because of rkey
> >     violation detected in check_rkey(). The root cause is that rkeys are
> >     incremented each time a new MR is created and the value overflows into the
> >     range reserved for MWs.
> >     
> >     This commit also increases the value of RXE_MAX_MW that has been limited
> >     unlike other parameters.
> >     
> >     Fixes: 0994a1bcd5f7 ("RDMA/rxe: Bump up default maximum values used via uverbs")
> >     Link: https://lore.kernel.org/r/20221220080848.253785-2-matsuda-daisuke@fujitsu.com
> >     Signed-off-by: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
> >     Tested-by: Li Zhijian <lizhijian@fujitsu.com>
> >     Reviewed-by: Li Zhijian <lizhijian@fujitsu.com>
> >     Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> > 
> > 
> > Is already in v6.2-rc and conflicts with this patch, it looks like it
> > is doing the same thing, can you sort it out please?
> > 
> > Thanks,
> > Jason
> 
> Did this get lost? for-next is now at 6.2-rc3 now and the bug is
> still in rxe_param.h.

Check again we are at v6.3-rc1 now, if something needs to be fixed
send a new patch..

Jason
