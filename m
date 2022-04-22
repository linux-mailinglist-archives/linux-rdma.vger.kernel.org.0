Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5976A50C43B
	for <lists+linux-rdma@lfdr.de>; Sat, 23 Apr 2022 01:12:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231822AbiDVWN2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 22 Apr 2022 18:13:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232835AbiDVWNE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 22 Apr 2022 18:13:04 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2076.outbound.protection.outlook.com [40.107.93.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CFB62220C8
        for <linux-rdma@vger.kernel.org>; Fri, 22 Apr 2022 14:00:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QhudSa+prZd/i7Ptd67SFhHQgMWNAupHPYjyaIHlh7WnK/7dQCpIk1EJ93KfXd97NwhIRzKlGE6c/5/4i0NCDibUi/STGu92cwvkgquNrC0SzsbUgcxHbxtRuda5yk1gJHsY45Upos3iRKUP5cE5Ie9aH7xz00BJLz/vZ2quoDeRa2ni+q/PLq4K5T9teriqhyjqhVJa47EyeElZI3qm/eld8/tvJ1lME3w7+IRZ44jRW1ddObxgiAGTPDWvw9gAN64A3SawVRkDNJbRsRIDftUVMJqh2cWsEyHWczxukuGCeRIpEgpyw4d5ahV/84rzBvp2b2KhqAUVADpTNwZcjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0CJ8BW0c80c5UWvUb6O1bbSGJouGYZxBt0cH78uetCc=;
 b=IoFzb8mNq+OatwGV2iLOTimAl4XmHBTNnlZxHfpHmrmkruYfW1YRdrGvlrvlHQO+3h8hpI/BoAxGM6n8ddQC3izGq4i0WiTqnWxwFiEXsdWXpdOJ6HzgzEXVFJS0qI4E2QgeVi3JkB+xMR/Q21PxMoGLL1Y8Le+PBXdz7vC5+Bsz0qk6yJuh3UIhlj5QLjY95bzDY4s3WaDbV0+aNFp1BNHGzA9HObEwnWBpJ6arNfiibKxJGt00rLQfN5+XW1y/Xe9EVhbnNoalC+Ssy0dDPKlogu1Y7ZdmZk7aIg2eIlKRsnGHXyWdpUCmaUIdOPGkfYpl/ILI4yhqvMDn/U/jsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0CJ8BW0c80c5UWvUb6O1bbSGJouGYZxBt0cH78uetCc=;
 b=A/zRyhoAQ8f+BuRdP6f56ziDh64vHypdUQAuIeLZZOK49uY2uasUMDfC6HXdR9Bliyq936C+eoVMYp0oa00M7OcJmKV2xe7SKohVCHTs3lJXBVolwzUdInSpsqaBDDa1UZQBxkhV8dbu+BXsJwwa3UJM6kdHaT+HGOd0xHpN5SEOYgNkvVLQjauhQUADJIfaYf6GjamArRcAEYmEIMDlzyd7SYAXh0V9bcD1bWdtZmbMtG9kC6tJRJnQu+s/BCNWEXRrli0ih6UGyP3pH7Kp2v9ACAgEyTL9SWCX2wZpBIZWTZewPJR/YY5UtnIaQN2bW7f/1fDeY1Bf6vSPQVp2LQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by BL1PR12MB5048.namprd12.prod.outlook.com (2603:10b6:208:30a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Fri, 22 Apr
 2022 21:00:26 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2%6]) with mapi id 15.20.5186.015; Fri, 22 Apr 2022
 21:00:26 +0000
Date:   Fri, 22 Apr 2022 18:00:25 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     Zhu Yanjun <zyjzyj2000@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: much about ah objects in rxe
Message-ID: <20220422210025.GL2120790@nvidia.com>
References: <983bec37-4765-b45e-0f73-c474976d2dfc@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <983bec37-4765-b45e-0f73-c474976d2dfc@gmail.com>
X-ClientProxiedBy: MN2PR05CA0001.namprd05.prod.outlook.com
 (2603:10b6:208:c0::14) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8d6a7ce4-0b57-41b5-e9b3-08da24a32048
X-MS-TrafficTypeDiagnostic: BL1PR12MB5048:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB504883E4DF2790CB87EF0A0BC2F79@BL1PR12MB5048.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mdrWHpS8KFHiqOQBak7eurstUB71qK6b1tNnWhYDj/32XwfqgAFW7R5QfmBwP5+htPhp+1t7hdXF8Eph/2x9FoEIbYttnTS41GhVx+NgHqrlFxhtiyjuIgDpt/UEnfnhBZ/0IPsMSxGfpBG4QRcSQt3SFMnXsRkxF/7hoRMilXOm7md3upAjQ4XjvDGbugm7eztx4fd0fE6DKlNEWtwd29sIH5btYxfnIJsTi524CiNsOYVqedvRSaZq9uji/iVxedv/jxrd5kQAGZfWJU2y5NkMb1OVGGC+yiiNkOWls6OyddWDfcqiNXrOWduazVzeEuf+DFRcfcuto7FTuw29p3egrrxm41FxCQErYWsCXw4jG73XmCM1Bnbimk4cpG3vcHRqwFJ83XQFFf8otUFxEYg3iG0kqiT6CEs3BQeMoZmz06hMBEwVI2Mdrj41rLbSZSRIAfWZRyxvfY/WXG4r4QjAadZkK4wcuoeBsvPMYCpShTgy4rS/FRuAtENS94YBGuh0Jn9P3XRcZK4b2MwA5tbzKsevEfgUEepT9a5mgsQMmvuI7En8kIZMWzqb/fqfTx8S+QrYmZAyC2n7E8kDxe/6Jrrf3tTUUhLoX4movhfV3qUIp8/5IK8+vGETca0yIdahLCvn78q1lOD1ghflv0TdPRL7v8P6gO78wy8bQWV0HnhVY62Emuiy9N2VcPNYlJQ9ZjBLMiPWLCq5+IStng==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2616005)(186003)(2906002)(26005)(38100700002)(5660300002)(8936002)(83380400001)(1076003)(66476007)(66556008)(508600001)(6506007)(6512007)(316002)(66946007)(8676002)(4326008)(6486002)(6916009)(54906003)(33656002)(36756003)(86362001)(21314003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Gaej9wjFqzu+V9zL6DRwswu7366RLy5rDiOKPz5k1UClGamR9sbcC4xz/BdQ?=
 =?us-ascii?Q?o4N88uE+X3zb2aJk/We59mizo4XZ3RCnbMlBVpUYQHp6K+BhenkZgNHobr8G?=
 =?us-ascii?Q?DwMXXPMX/S3H9mov2mk3zRFDYRgKH2vmFmbnaOqt9TBr7N1i3LZjGz2zFCbR?=
 =?us-ascii?Q?gm48Gxdx3kjhq73CyRUFPQ3fxy2mIxfeqS37sMfBT8x6HkhfmUbvLAS0pGYh?=
 =?us-ascii?Q?/D/05TxhOZmEEgOPYdbb2WS0ccXoWGcYh2H7QKa6fqhIyDQ5Dv7wHIWaqMAr?=
 =?us-ascii?Q?mtykuh+x3OKkEqnqL+LyoA3lsVMH3KibmkCAbXyRUtTbzV8ni7C90sL3rfhc?=
 =?us-ascii?Q?BciCKCbwqxGx1DovIBPx+p2eZiBeqDA/7enyhch0b5uDaBvclWAMeASFKIu2?=
 =?us-ascii?Q?GuYIRze1n9l/EyW4wbm0GffGCj7zo5/RuiZL40L10Jr80aQPsqj4WjtSDniL?=
 =?us-ascii?Q?pUUy2VE/YoriNyCek0Zm1su/IPO6hGKr+EihSCf8IsGkQHn4QQN4gynxYf10?=
 =?us-ascii?Q?I6aHyUzk/dkvzM+vdA7pBFGKNoQr3uifImsKyAXvAHeyAXUVYZUUkIE1uJKg?=
 =?us-ascii?Q?uQWJwUhJ/OVYYfu33ZTAgCncVh/H/D0veWBTecrr4bzq3AqxWn7c219NkHUL?=
 =?us-ascii?Q?/Fn4J0V8iLoTADRlHbyC/Y4zgR/X8gtn7lVcrgBxFZcKy53HiRb3J8UlbAoz?=
 =?us-ascii?Q?xjphMaKmHGT0qEAB7d9ak9aUdQgBOGe5bb5zsrmuS0Y7DY1eJlmFZobDnEsK?=
 =?us-ascii?Q?qk2EbaLTodAu7LP17hA8nQIm70iYroz6NpjQ8EVgc5JJ47hGkt7JU8d/+W5z?=
 =?us-ascii?Q?4PkwSfJwaEkZc8N0cv1EVZQKNFcVOvHwnnZ54UY+PkWEB/yBTCQhOvdK+zmc?=
 =?us-ascii?Q?mNhcCjZHnaO+P5SDWvV6k8CvMvMrRidyfAFi6Yvtv7ADdidTyZFMwhtpPuWN?=
 =?us-ascii?Q?lhH2C4IcRbXvxmUoAL0SykhP8iOk35ZUbJFtmBOlDd67V9ajtiR0zANEhDdy?=
 =?us-ascii?Q?d9ttMLvt0mAKZX6JesqEqLNSsrGIqSfW/akMOxC0p8xBsgN4ZTkeHg9jAWVY?=
 =?us-ascii?Q?bipxWX8degWX6VWDkL+NGfwmaq7nPnZElQSoyyWwm5UIM5cKMioi1/JkvKdc?=
 =?us-ascii?Q?Z+AmPXocy9R7NuAH8kDWvAvKZUkn13I5D0Ose0edX901vEWzWXS6j1OmXJ0I?=
 =?us-ascii?Q?a1FFEpUvOJU2a+JalDOOjGNiUrMIbIYwFITGK5gzEBYK3xmFIjZ7CQEqcCZJ?=
 =?us-ascii?Q?+60J+0Tsdqv1gIXKPzglTEs5dI/o/x2WUUgEjUD08zYhIeBs07q17W5AcGWf?=
 =?us-ascii?Q?nER7JuY3oViCG5K6Y2+b9DFcSGzxte4czBXZ4/i+c7gvMsf+xU4WJc81wY7l?=
 =?us-ascii?Q?yacurm3xbZSAAqZiZ+E18pvcJMymy9HKNiTYDFahonZkbgpU+nKThcnQcRdO?=
 =?us-ascii?Q?sFBQDNpNRod/xwDA+DZnmym/aAbw1+nXaF8PM7QgAxaRIYTuxZKDo/3QAVH7?=
 =?us-ascii?Q?MZqMXWS7S4iGeuy8nVimj/lgk5Pir0UXCJfovhei270/2mxJO0tfUsNAQwRi?=
 =?us-ascii?Q?M+TXuflgjmDHx9Yrlnl/w5l6Nh8PjOWHRp19fZFiGgPHrKIvtVdeFoLjBSr6?=
 =?us-ascii?Q?eI0bd+DRcDdQx3PgK0ahM8H4WMIXzYN8QgRAtZQdDp9Ks5+SFjxe4nSkRCzw?=
 =?us-ascii?Q?TxZDivNJdIYuhSNvg9VGOduhrannn8RGr7gx3kIvGYxHegNWlf1f3LmGLJ4k?=
 =?us-ascii?Q?DzGb/ASdCQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d6a7ce4-0b57-41b5-e9b3-08da24a32048
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2022 21:00:26.7827
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0UJMeFIWjARMlRgbHuwvXQfv+g9q5aZEP6UynpfmgDbxjqw5Z+nk/o36rXnhYxJC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5048
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Apr 22, 2022 at 01:32:24PM -0500, Bob Pearson wrote:
> Jason,
> 
> I am confused a little.
> 
>  - xa_alloc_xxx internally takes xa->xa_lock with a spinlock but
>    has a gfp_t parameter which is normally GFP_KERNEL. So I trust them when they say
>    that it releases the lock around kmalloc's by 'magic' as you say.
> 
>  - The only read side operation on the rxe pool xarrays is in rxe_pool_get_index() but
>    that will be protected by a rcu_read_lock so it can't deadlock with the write
>    side spinlocks regardless of type (plain, _bh, _saveirq)
> 
>  - Apparently CM is calling ib_create_ah while holding spin locks. This would
>    call xa_alloc_xxx which would unlock xa_lock and call kmalloc(..., GFP_KERNEL)
>    which should cause a warning for AH. You say it does not because xarray doesn't
>    call might_sleep().
> 
> I am not sure how might_sleep() works. When I add might_sleep() just ahead of
> xa_alloc_xxx() it does not cause warnings for CM test cases (e.g. rping.)
> Another way to study this would be to test for in_atomic() but

might_sleep should work, it definately triggers from inside a
spinlock. Perhaps you don't have all the right debug kconfig enabled?

> that seems to be discouraged and may not work as assumed. It's hard to reproduce
> evidence that ib_create_ah really has spinlocks held by the caller. I think it
> was seen in lockdep traces but I have a hard time reading them.

There is a call to create_ah inside RDMA CM that is under a spinlock
 
>  - There is a lot of effort trying to make 'deadlocks' go away. But the read side
>    is going to end as up rcu_read_lock so there soon will be no deadlocks with
>    rxe_pool_get_index() possible. xarrays were designed to work well with rcu
>    so it would better to just go ahead and do it. Verbs objects tend to be long
>    lived with lots of IO on each instance. This is a perfect use case for rcu.

Yes

> I think this means there is no reason for anything but a plain spinlock in rxe_alloc
> and rxe_add_to_pool.

Maybe, are you sure there are no other xa spinlocks held from an IRQ?

And you still have to deal with the create AH called in an atomic
region.

> To sum up once we have rcu enabled the only required change is to use GFP_ATOMIC
> or find a way to pre-allocate for AH objects (assuming that I can convince myself
> that ib_create_ah really comes with spinlocks held).

Possibly yes

Jason
