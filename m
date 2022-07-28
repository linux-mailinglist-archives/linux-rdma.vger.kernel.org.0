Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 963EF584494
	for <lists+linux-rdma@lfdr.de>; Thu, 28 Jul 2022 19:03:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbiG1RC7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 28 Jul 2022 13:02:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231925AbiG1RC6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 28 Jul 2022 13:02:58 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2063.outbound.protection.outlook.com [40.107.101.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F006374348
        for <linux-rdma@vger.kernel.org>; Thu, 28 Jul 2022 10:02:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C4nO715ocobLGePr0QozLXEob7XjTbJnzrRySQ3TJ3qQsvaA3lZ+mwcyi06ce3sYlxO03dtJ3pgASv4t0HK0cFBZsDnAXA2eC/1wl1HUOKdIwfNgthlG7Eb/RZeMxNOOSo6513fehp/YxzumIzlFE6jPLkoNXwJz+/a6j/P+thHZb1db5V1+BojpcQ/MybouO4oJnHv3mdm7XBB3hJNF+igX24pX/rceqB4YbjsN9n7kXuGPtv6Khp0bE45T82mF6k2s1nVRz2+OzR+MQLfMFc8928p/jd3sT2CFlnc7Vk4nrtWfKL2nJuOsCmvBaFALsJmU8pWZRiZwbnlHefTIBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aKDNwXzBzJ/Be2zPeaopwPnYXXei2qW0KZMf3RRKS6w=;
 b=lzenoa3qzGAXNn87dM+Pzy3cY5vH4/gW22MakFWQ7d5RpaDZzRLr3eAtHn3jt49+AVToUFqaSEPDn1chGiva4rGQJiAvNV00YYMVN38fzd2JsqC9qW5WPMCIXod7eZ4dvgIGa9YjbV5FVyhvUZr/VdqNRpP9lHpd9gfy5WIQsqpqMo7L1z54dFDxqFB/N7ETY66/+i2/DpjeR+6JfExwbqMxYSI/qgYFwi8K4Jdqjjyqe/38pcaSzH+s33wm2mcaGv/ynuHyiuOdC1pFllHxx5Bl3WLdUTO4eYLxMm/odvgc2/Dse4G7y4KpPL+JZJmyQ1/6fgHnEzLcZjGmX5nDZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aKDNwXzBzJ/Be2zPeaopwPnYXXei2qW0KZMf3RRKS6w=;
 b=qjHnqKGkVJ6yf7m6Qy0KWgZ2P2qa3xKQC2dS8SUPQUQi4gImlpKNbC1AZ66Fw782MBCjlpn13PNwRByhBPFqTNGFQ+GmweJfXlqQpuwrpGXIMD1BGDxRQpYcjFK3JgCqz86n8QyN4Qa59PfWgE4cbN+aU2TKmWnHzNu3+UvLYhtj5wf9qgDm7ctwlKqZaBF99lt0fxQvJ0uKYHkWedPT1BLsIpDeq6hwWBatYiXVFBPua2aIOznsWqeY7X+RmV6eqzCi10cNVbUFGIL1S1LyVRQ1ytbEiufB9F69RtKZuf7nHBj6M/39dMhsCKA5dxv/p1LM99Q5d0x/MFCuNO7ZYA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by DM6PR12MB4548.namprd12.prod.outlook.com (2603:10b6:5:2a1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.6; Thu, 28 Jul
 2022 17:02:55 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::4cce:310f:93:5d58]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::4cce:310f:93:5d58%8]) with mapi id 15.20.5482.006; Thu, 28 Jul 2022
 17:02:55 +0000
Date:   Thu, 28 Jul 2022 13:42:54 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     lizhijian@fujitsu.com, zyjzyj2000@gmail.com,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next] RDMA/rxe: Guard mr state with spin lock
Message-ID: <YuK8jXgAncDlppm9@nvidia.com>
References: <20220725200114.2666-1-rpearsonhpe@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220725200114.2666-1-rpearsonhpe@gmail.com>
X-ClientProxiedBy: BL1PR13CA0227.namprd13.prod.outlook.com
 (2603:10b6:208:2bf::22) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bda620d2-315f-4950-df5d-08da70bb0415
X-MS-TrafficTypeDiagnostic: DM6PR12MB4548:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nGPsz3x/6g23iTqyNMi85/0iglMVhpBkjPdedKO7Sy7jAiIU+nu6jdfNBzyU2OjkwGnrz2AbBsx6G9AKXT+454/q1Lg0EW7J9PyfAtPOABfuZwly2FQn5FrTJDA4/8F0f/kAOE/Nuhevt9QVWI7L93ScRRL18t6MFcCxMuagPIbEnX8Vnqsb7aUv20UjBV4TDQTW74GP/cvEic6ZabJx7se+t4RCEwd7+mxrJFmw1qMcfVB5y2M7FlQV9dv5E0rn/stk64/iRdu5axbgsROyKjTxl7J/Vam5mdLct3wIpgRKNx/jO7lDV99wf131G7nUnLZ/6B46Lv477Vd54TFStJCMEWcw+DDQCyDzw0Ev9BqFHeiOTQ9XDXxwupDhqPnKJ0rkFe315vREK/C6Hgm1CLzQfBpuu88mgdkwFANZAuhl0INjrJfimLTlsWDdyXSWwawIsi2PwifrvZUcl/AaWCdijllVsijAYVTlxm2BKnesYZIzfOhDoWQy6NSSyyFpwJ600GEsVC0wtCD7eg69dpC/EgN3x1tuNvzScDO0rUBItpH8bUlj88s/Egpdg7PFHom9pHDyR8mzhe9xMkp7qGA3s4NSEY2r0UvRJgCvkNReZwQ5AHj8RxVrpDXCa7t0zOlfO6ExkgYUWfeRN0rdb+69NV6Ev+JAH0EWqHJmpL3usRXHe1v1Psvfbt9xEBY2U6FGMnQAsO5iRUE8fJJt+xkUxvlIOYnWYpgKnFqoNw5GasiHt0623frstco6Qw3+
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(366004)(396003)(136003)(376002)(346002)(66476007)(8936002)(8676002)(186003)(83380400001)(6916009)(66556008)(316002)(66946007)(5660300002)(4326008)(36756003)(2616005)(6512007)(41300700001)(6506007)(2906002)(4744005)(38100700002)(6486002)(86362001)(478600001)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3hz/mxvwBm4pLTHTFt/fz3/lHWuSfwFTNDkaUASPnE21y8Ry8Xx9dySBeaEx?=
 =?us-ascii?Q?1XGkTpLnqqyypzJVuERIUQUD6HsWVsvsJFTrE85fw6hB96ml5f8FrIjZ9o0S?=
 =?us-ascii?Q?EVbMbguFqVrtc/IrtJITbWgwyTX41NUwv+xM+6dcRBgyBhjvbmIBBkKUOem8?=
 =?us-ascii?Q?0rXco9m6XttYDDjM19SQ2vqiEfiTt7tVx7PWjj5BMUg6E4E0sq5nofLQ400X?=
 =?us-ascii?Q?G+ttU+H5UDWhYVDonSMs2nSef8jzDI/cKaCYHGfMrPKcVEvwIekJgvnDdikT?=
 =?us-ascii?Q?SLiMF3Payz6JGWHgJJ17G9OH/otOZM5M7Nww2Vs+lJaFpp86ZLhgU5n9u+/d?=
 =?us-ascii?Q?rcHjlJlfwmEN2zx3uuhV3qVB6h+GNtYRWH4nhJBst4fav3iZQsa0vWd/VGX9?=
 =?us-ascii?Q?YVug1jBLq/CESoBHzJ3bBl4mHstnXm26YyArfv8eWCWHQ+ljMNlx0fq4aZeW?=
 =?us-ascii?Q?EmsC2FwHY1iSZLAepoTyj/EkEKKLQ8jbAX7u71nHxH/2yoc84oru4sxqBUE6?=
 =?us-ascii?Q?vwtM5cPWcKwtxAktDR0f0BwyTwRZklP4B0Quez1+31wbLV3gy6frleQ7k07a?=
 =?us-ascii?Q?nj0l2ydgSJArkPnc51stqeQNCG+92rKj61NsmbTCknrtxhU9pnn54ZpnfCFd?=
 =?us-ascii?Q?pRs1hvCt8jRB4vbfkw+k8S9cpkqHkF0Tve5iAK2yQxFdTktUGywrZ5+5qlcG?=
 =?us-ascii?Q?3ekHe3SfGDZ0MIsF6WeJxQb2OkuPLD0fFHov3z1Sn+w7DiY7oUi2W4yDPIpi?=
 =?us-ascii?Q?2xN+8VdLO85xTTWFNDwYz22QUvvdXHC9mI/BnIYNgEyTe9XP6fLReDe7mQup?=
 =?us-ascii?Q?MdSqNzUEYx9FSW9gJX78wdyg1tkQEcmG5NsKNmu24hNFhHbrPHtKUvZ+0JAP?=
 =?us-ascii?Q?YN3hwJj3MtYzko4/MeTz68tTkAWn/XpaLpGv7Q5c8ujzXoVRs887Cw+vyW6u?=
 =?us-ascii?Q?IMS0q6w+ECN0ZZ1l1SMuyShLkDiANTbhl/rdVNqyiXnyAlxXGby4cpnOgQqV?=
 =?us-ascii?Q?tjUz4aZ06eQsJHm876X45uh65p7/d6AC1RpSxVs+ncDMx23LtPTJibd2/VGB?=
 =?us-ascii?Q?fq2CwDHyJpug+g16GEiaYuyNEOqvwrMMJsdNX/IKOlyISfB5i6S0WI+ZJpzF?=
 =?us-ascii?Q?c8sN3w9Rz/eTQBhlzTu9vDqg4fntbfGXPY6Rr3U2AMSS+REbeW8m97UWV9W/?=
 =?us-ascii?Q?r3bnMGa+zTiHjLQasBDVeliK/4JaHtZ9cz0zQbTww968dC/cDBuL9JIhX4G7?=
 =?us-ascii?Q?3N5LgXhzd75plzdbdIViYg45bugz3GwrPzAtyLJdcruX5j8eRvGzoF4S4y25?=
 =?us-ascii?Q?L8hbc2aYMDN6GCITbrpeNp8pt3AW5kKD+5rompOFeINP19obHs1sRYyVkL9N?=
 =?us-ascii?Q?hiEHQAdYPSqX/uIGUjXyn9AzmNGxSjUb55OBgNKVrvtm+iOyDdnPT9nsjCU0?=
 =?us-ascii?Q?mj+rfsXOt0do+nuY2D8l5S3D8v4GGwkZCH1bEbTtWERbe1T1oYF9v9ZNu9zo?=
 =?us-ascii?Q?iWuSEDuyFA2WIGK2ZSN9Wo+aI3511ewhJCXgvfuIDQd3/I7IqSU9un4vXJtt?=
 =?us-ascii?Q?9EwYHNRNeiiESf6mr0FRmXl+2r2VnBsqrT6FUWdd?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bda620d2-315f-4950-df5d-08da70bb0415
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2022 17:02:55.7165
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O0T57GJr00gjq/NJCgvqEFV2cCK8v3sc+lrjLKE4stoKuCDqeXSjSCTcNr5sGtF1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4548
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jul 25, 2022 at 03:01:15PM -0500, Bob Pearson wrote:
> Currently the rxe driver does not guard changes to the mr state
> against race conditions which can arise from races between
> local operations and remote invalidate operations. This patch
> adds a spinlock to the mr object and makes the state changes
> atomic.

This doesn't make it atomic..

> +	state = smp_load_acquire(&mr->state);
> +
>  	if (unlikely((type == RXE_LOOKUP_LOCAL && mr->lkey != key) ||
>  		     (type == RXE_LOOKUP_REMOTE && mr->rkey != key) ||
>  		     mr_pd(mr) != pd || (access && !(access & mr->access)) ||
> -		     mr->state != RXE_MR_STATE_VALID)) {
> +		     state != RXE_MR_STATE_VALID)) {
>  		rxe_put(mr);

This is still just differently racy

The whole point of invalidate is to say that when the invalidate
completion occurs there is absolutely no touching of the memory that
MR points to.

I don't see how this acheives this like this. You need a proper lock
spanning from the lookup here until all the "dma" is completed.

Jason
