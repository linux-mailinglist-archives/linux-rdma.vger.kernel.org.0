Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88E066C7FCE
	for <lists+linux-rdma@lfdr.de>; Fri, 24 Mar 2023 15:23:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbjCXOXj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 24 Mar 2023 10:23:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230192AbjCXOXi (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 24 Mar 2023 10:23:38 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2083.outbound.protection.outlook.com [40.107.102.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 360EA2279C
        for <linux-rdma@vger.kernel.org>; Fri, 24 Mar 2023 07:23:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NnDQ0UQWqh/QfMPWN3i2osvSkztIbm2kAntRUg0H6FL5fJbo/0cVUvmNPaf70wG17XsCwdbdLscIplGVoVMh4wsTo9CDS/AkWafcFPAWnbumqkvEwBsSjtJsdj3HInwHbnkzBQ9M7THVimsrI+i2yDXzfGbXh4Du8qST2Bzme9DamcZl1lyahjMna5LVdDUg10pm5qSGb2y8Wuj67hkyggyWG5hHFKXt3dugHPJLGsvaJDzc3Ih6xVVhPK0tvVBHjrZFXHo4h4P/booSL5cKM/ZyQIK1CcTMUW2fVQhjNsNYFYJMk13y5W4vorNZYO1kxU8gfDKHiSXNhNhld/Bi9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mh31iSL/dk6MmaIy6Hzhk0WjUuG/kdV3M9X7ryXjnLo=;
 b=gB5DNYKGuUYqD1GTaQRYvTquBAk5PsKvNxmLHjoEwMYM5kxHW/5emEo2y6xbVOgTcvoJ9JFUa85eiG8OqUBYviOloYDs1b2ZFbWwaFkN/ROQYF8mi6OdqJHso7ru904dLgwV55avkpIIomRiOXW09JYb1IEUFAmP+DH+ZeJVvRQol2ub/POotoLoYQpPoNFvFWYMZuFuh+tFxqGOWaKShMNJrcUV4SXQOG9p3TDfg/bytRMQiSz7/FX6TFxzMhK8k3gpid902O8yNtU6E+Suc14acFXYVqI3EAcDwpqZgS/Etho8VNVuwETeDrQAnAFiH/WilMccDrmZeQLkomfwRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mh31iSL/dk6MmaIy6Hzhk0WjUuG/kdV3M9X7ryXjnLo=;
 b=OuYcH6axBwORCoQlWHIEi/Ixz3ROprucIjLG+UR2tCRXKA8HC54dZvhcGVMCDxVSlDqRRayBE0g0zcnhoe+7RVafVyfNyRDvG6+ZuTwcYqwf0itYRGsCq3UCQU52LxJNAHsMq2wkusYIcg80NN0lmtixfS0f+LQqCKuB5JWjrL72CEkESQXubTfb4tLVZB+wofVTBgn/l3nzLy/RgO21p8Rpi/L2YouAh0MOG8OOZAEMwQAXO91yq+2Nkv5S3ibLPUsAfX6vSPjjE/gvn9rU7ViV+AJQElpcP59PqyPg7RjzxRMQUcn5Dz9r+IdleRbPx5ozNpVV0icKH8UXbrLj0w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH7PR12MB5806.namprd12.prod.outlook.com (2603:10b6:510:1d2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Fri, 24 Mar
 2023 14:23:34 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.037; Fri, 24 Mar 2023
 14:23:34 +0000
Date:   Fri, 24 Mar 2023 11:23:33 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     zyjzyj2000@gmail.com, jhack@hpe.com, matsuda-daisuke@fujitsu.com,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next v3 0/8] RDMA/rxe: Correct qp reference counting
Message-ID: <ZB2yZb2ff6T4aa3y@nvidia.com>
References: <20230304174533.11296-1-rpearsonhpe@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230304174533.11296-1-rpearsonhpe@gmail.com>
X-ClientProxiedBy: BL0PR03CA0013.namprd03.prod.outlook.com
 (2603:10b6:208:2d::26) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH7PR12MB5806:EE_
X-MS-Office365-Filtering-Correlation-Id: a8feea9e-9aaf-4a50-1dee-08db2c7359f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nhYqhVXi/x93GktAAZNiEDRBTAasC8TcSc0LfcuzupxxigXPkDy6mztSGQaGsoKA9uJb+x0QnMr3pB6fMBD9zqpNzVA8uowfAm2vQkWGunhLhNRUqkR3hsf8DGNYY1abF6dLg19U/pqYBQbQ169oC+mqSuv3Ub1XsU3po/fPc0S2Ie+tJuhlVYW53y81CKTnTjnyc9vD/8G9UzIEq1H46lLM9bY7HDIEdhuHl6sGMuEL+df/sigT929M3dBE+5FgkvTZTKUtMYEDjn54L2q9H8kkTY7gbQhh+E96XSkVDCRMVK5oZCXTwV7DD5ExK+1gPNZyQ3HbmxHpX3Y7gG63tCV8atoBeNIp64//05h3fSDsVRs/i43yMdezAbxDCju3fpou5JrR180mzsYunUz07NP1SezBqA5Ztv3RXNQ/oJI8w/l5t+gehOnaqvl92M+59UprUgDzW2EeOaFqDp44A5MVkYxHvMNjmAQ6gLytdD8mVqa4rrDUD/8CD2QZrThneOLAVsBNNgVCuINzhJpKRo16KmdX/wVWehsPibZwin49SiYG/PJ0gUy5N0hgjoQWEuSqYP2RqlnnSH71Fxb5nKYWucfbPN6umtWVtIFQvoI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(396003)(346002)(376002)(39860400002)(366004)(451199018)(45080400002)(66556008)(66476007)(8676002)(6916009)(4326008)(66946007)(5660300002)(41300700001)(316002)(6506007)(26005)(8936002)(6512007)(36756003)(186003)(966005)(86362001)(83380400001)(6486002)(38100700002)(2906002)(478600001)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5ce9cdr4p8SqNnCRgmwS9573nKYv12lGbJh8krY+ENVtpTaSj7uY47VbWd+d?=
 =?us-ascii?Q?P+ZdwwWg6lSWsIFf2yJK9Wn4W2F84QLrDhQilNB68hXSJW/bFgAzCiv3V1pL?=
 =?us-ascii?Q?vcy3l8wqEVik4xpU/1FrCmLyE7lgPGafqz9vWkybEmkSNt04CVGmf52VXZHV?=
 =?us-ascii?Q?tsYPVeg/nDqNQAt/HU+DDggm05sDd6NwIIDDwUiRKGk7PJXuLiEtgjqQ/Zef?=
 =?us-ascii?Q?hdg/+SD2apmTxVwHZWYzXtb/tEU85wqWpeuc6/vZ6p8KjF07pKfWu1tx2txu?=
 =?us-ascii?Q?Y7EswoLo0lvPSSxVsMB36FFzY3jmFh2emX3RE87sXw64+uclcpM5mCxeYUXc?=
 =?us-ascii?Q?vRUFz8c+JkhdHoXzbhY5AT+fte4TEsIWJXQCIKghauwA4HhuEcltFoyxUgVh?=
 =?us-ascii?Q?dilO9KqYHXiE0ZiEgvJ9EygdcjvH8gXCQEF726rh28vyoY6j65k6BpDbzexJ?=
 =?us-ascii?Q?NWqzWb5nNo0QbRvV1ccHiZQfmbHHTZN5NyCy+GyMD/OzIMwIRhbkqq+g8qRX?=
 =?us-ascii?Q?yZ0k0tdqK+i+V+fmAAEgS25lecoDkkKZ7WjXFUWpZIaqqC5mLjmkx9qcJ34j?=
 =?us-ascii?Q?NZx7OOB5eovKUbV4TE4ot8WRk9TvhiUbfFuY1YzpyEgLgl4vkGPfkXfNU1Eq?=
 =?us-ascii?Q?0AmV4P7q6zS6vGJmVP7ZBEsCCyi3rzs5o7DGds6bPiM+7UwAfTa3Bwg+1LLz?=
 =?us-ascii?Q?dQyBqxmuBLL8Zt6Yo0Snm6ItiE/uleprdOdI3xmfuNeppGZw316RLM86pGPm?=
 =?us-ascii?Q?jk0O+Lkx9D0Xb/BlVb1P14QwEMdvQcvkN+TtzN/Xo8VaQvW+QrWulL+n5rF8?=
 =?us-ascii?Q?3JB/gv4Os72TWLBuPAV0mOOBHko01sp46sRZxa/+l5mC8mGIzVbQBjODzd5e?=
 =?us-ascii?Q?opjiHYeZ6uwZ0Bj0OQyzFJ01y7Tij8EDujm2UKilUrHiIp+2RhqdAhzhvECC?=
 =?us-ascii?Q?DundMXTzWOatSy0cK3arOaGAyLjMo0paFk8U9fAUzboMz6IbZnhTGeHUn/eD?=
 =?us-ascii?Q?PE5QYSeilR73YAcnHZbsuiWUnOZyzJnn9OOWGcjVAEsfBoIql9L73NHsWbKJ?=
 =?us-ascii?Q?q1W3UwG7YaNDSLl721QdeqAsNKAtT9oEBjRZUqsRn5SBRyt31KdKVAHmKNO0?=
 =?us-ascii?Q?JSzJR2BI86Z9mKBceLJ2V3H8K0fFBZHUklmSgTtYhnK+Fy1M718ZjM6rGmzC?=
 =?us-ascii?Q?ic6r5PsjWiFx3kGAWHJzWMeviwNScfFhpinY12yeP12o16Kh3b3pIDiJgRXk?=
 =?us-ascii?Q?nHVFaqag0Vi/h0k6qktxEs2S3tl1Pd45HfX6Bvzo110/AEJInYi2vdv4Z0X0?=
 =?us-ascii?Q?DRwERAccYXKzL+17rfAMOldcwaAVIf0o2aDbkxzZYI5Url8deKakC9IhjnMm?=
 =?us-ascii?Q?5rUGvnlT0ORjPQDnDPzMlSlp5LXjIa87myOcc3wAh6ba5lOqnM0h8Th+NcUw?=
 =?us-ascii?Q?ZI2z1w0mojockwYRKUw7d26eLV8gFOuPDRbLWSXOouYvmCYt5GnIcHzzq03Z?=
 =?us-ascii?Q?yJ3/E+HAjSzqvHwcnTSmyKEI9EGncyfDW27sFFVR2rXHk/+HOLKv5jliVJ4Q?=
 =?us-ascii?Q?ayDc3i5bxUSWER4U51F6WMyLbbXkqiJwWbBbpd8F?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8feea9e-9aaf-4a50-1dee-08db2c7359f9
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2023 14:23:34.7291
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SOHt3Jcec9ftYhAi5wwM6ngIX3BZA5JlOiH30MgPRYJ4YawYPBS2HyFOmdcBkWC8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5806
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Mar 04, 2023 at 11:45:26AM -0600, Bob Pearson wrote:
> This patch series corrects qp reference counting issues
> related to deferred execution of tasklets. These issues were
> discovered in attempting to resolve soft lockups of the rxe
> driver observed by Daisuke Matsuda in a version of the driver
> using work queues where the workqueue implementation was based
> on the current tasklet based driver. An attempt to find the
> root cause of those lockups lead to an error in the tasklet
> implementation that has been present since the driver went
> upstream. This patch series corrects that error.
> 
> With this patch series applied the rxe driver is more stable and
> has run the test cases reported by Matsuda for over 24 hours without
> errors.
> 
> The series also corrects some errors in qp reference counting
> related to qp cleanup.
> 
> This series depends on the RDMA/rxe: Add error logging to rxe"
> series as a prerequisite.
> 
> Link: https://lore.kernel.org/linux-rdma/TYCPR01MB845522FD536170D75068DD41E5099@TYCPR01MB8455.jpnprd01.prod.outlook.com/
> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
> 
> v3:
>   Fixed an error in patch 4/8 "RDMA/rxe: Cleanup error state handling in
>   rxe_comp.c". Didn't set wqe.status to IB_WC_WR_FLUSH_ERR when
>   flushing send queue. This broke blktests which calls modify qp to
>   set qp to IB_QPS_ERR and waits for the flushed cqe's.
> 
> v2:
>   This version of this series split off the changes to rxe debug code
>   which have been submitted as "RDMA/rxe: Add error logging to rxe".
>   One unrelated patch was dropped and other patches earlier included
>   in a series to convert from tasklets to workqueues were moved into
>   this series because they are relevant both for the tasklet version
>   and the workqueue version of the driver.
> 
> Bob Pearson (8):
>   RDMA/rxe: Convert tasklet args to queue pairs
>   RDMA/rxe: Cleanup reset state handling in rxe_resp.c
>   RDMA/rxe: Cleanup error state handling in rxe_comp.c
>   RDMA/rxe: Remove qp reference counting in tasks
>   RDMA/rxe: Remove __rxe_do_task()
>   RDMA/rxe: Make tasks schedule each other
>   RDMA/rxe: Rewrite rxe_task.c

Applied to for-next

>   RDMA/rxe: Warn if refcnt zero in rxe_put

This one I dropped

Thanks,
Jason
