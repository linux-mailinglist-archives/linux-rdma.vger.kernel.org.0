Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A76F836CB2C
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Apr 2021 20:37:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236279AbhD0SiA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 27 Apr 2021 14:38:00 -0400
Received: from mail-eopbgr760071.outbound.protection.outlook.com ([40.107.76.71]:49540
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236834AbhD0Sh4 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 27 Apr 2021 14:37:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BweUQjVCU01RyWYBT+LE6DPdoTkqAdbAb/43LSrL1s399fP4qslqmBv89Tj3zxUQ+2ncKFmKGkAAKsnLOD7w4irMC6nbrN1jDRxAklamCyylEfuGJufqTFKioDcTNZtp6BbQ+7mPoB8WAOhUWIYzsrsbydZtLtKLOt9HhfqECynmItNllEsLB2Xaloeez2U6GKnCegcpHc3JbQe2Jg1JrB3lnsc1p2Rj6ieNOCqZ4XcGYmsmnEr50GV9rJ0nCSHNazaGQk0lFBKE6Xdzw9ReDoGxvzizJWL5GT0LtpASEfR1C4IboTQ2EGazhvOEERzweG+FId9CVgqBjbMu73HhXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eQuWc6q0djgTr6ykeWys9YkVAAMbXziAdxgtEWNmCcI=;
 b=PXsFn/q/unhxJ7Xt29W+8Pvgeg4Sshlld4BK4LXsYOXesJ8bX58U8tFpX7w/GJI2vpWBroDwoR1lZ0S8pvxkc2sAvHF824OXi0CvC3u+xqm4U7Qg5/rTbTVHGCBHqhMDUxWOWa/t4hcZgtEAx3rIpr0LH4p0gg2yGu8gpc0pjpYR7Q34vu/BeRn/37q1xqILCSeXnx/PsUbC0gwPtu4ut01f/aekBqB8dlbLSkJWu3gXlAnvsK6JdtK7S9eV6hditFh/sfdNVOb2OZ5EgK/bYJSwtmniXG51SxC/nBM7CBXosCoqIVLvtyDmeR3qKzGPXft85ZHCLpAA+4Wcm4Y/VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eQuWc6q0djgTr6ykeWys9YkVAAMbXziAdxgtEWNmCcI=;
 b=IippfOD5oE86Z8uupN5GHsv46YXvIKdqnrYg5guQbqLJ43R2lYbOrEvnhydehSzPk//FLnA0NjPtXxnbL2u2F3uJ+kaR5GYFTNV+4d0wf663NPnoaHuK6J3XIcuoBe8GXSUnE8BVbFDw4u75WFNKfEHi7yt9Jdzt1uYf2256I02LMah0p1hFzRGuum/agupYMkWxjxfhSv6/nfgtnarEUi1POghcmV4B32itRTFdyG+WPOKlfkL/N8cPen6xDqJ0VtZ4r6ZVntHfzE32Fe9meyaiWw4r/e2NJXADOgngTjtyEAakmyijQBWHFjChaAGDx3XNo3ZHzgy5gS/9xsXfkw==
Authentication-Results: amazon.com; dkim=none (message not signed)
 header.d=none;amazon.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4636.namprd12.prod.outlook.com (2603:10b6:5:161::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.23; Tue, 27 Apr
 2021 18:37:11 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.4065.027; Tue, 27 Apr 2021
 18:37:11 +0000
Date:   Tue, 27 Apr 2021 15:37:10 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Gal Pressman <galpress@amazon.com>
Cc:     Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        Alexander Matushevsky <matua@amazon.com>,
        Yossi Leybovich <sleybo@amazon.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Peter Xu <peterx@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: Re: [PATCH for-next v4] RDMA/nldev: Add copy-on-fork attribute to
 get sys command
Message-ID: <20210427183710.GA3259427@nvidia.com>
References: <20210418121025.66849-1-galpress@amazon.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210418121025.66849-1-galpress@amazon.com>
X-Originating-IP: [206.223.160.26]
X-ClientProxiedBy: CH0PR03CA0011.namprd03.prod.outlook.com
 (2603:10b6:610:b0::16) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by CH0PR03CA0011.namprd03.prod.outlook.com (2603:10b6:610:b0::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.22 via Frontend Transport; Tue, 27 Apr 2021 18:37:11 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lbSa6-00Dfwd-2e; Tue, 27 Apr 2021 15:37:10 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 86deb507-a0c3-4d88-2f5d-08d909ab7880
X-MS-TrafficTypeDiagnostic: DM6PR12MB4636:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB46366B14776A223AEC792D40C2419@DM6PR12MB4636.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Kf24maSsl17/Ytg3Bx330dVN0zgYEupW9CMAFJsFSSi74gven9+KlVbjSw54mLMwVU5qW7RJfFxv5fjDO459I2iq2hoJ6D9IVnauCEpb9c2q2/O9wS+SMvdE0zs/Q2/Rqwv8levbeh/CYPBYMZqb4QYJPz7cDBaSka+t5iB2SGGZmipsD1P2ihMPQjTHzYKn7xAYyEiGdNLKJ1ee85zQ+xTln8kygyem+6kf7hTRvI9L5FFwqMnwnUcZM4csBH/Te66Uw9PrJhgmhWmNwxcfjNmBG14mtrq4o5wzSFJwAkZI9yLB5OxF6U/s5Iab7I84ujSdsDDwmkrLZXF/C9bvX42T1pbDedMDQ1PQhwtQoNq94pRSzy8IAJzlVNZymcRijbrq62fr0GhzY3gG3YSLaRZ0jfe+r88Asn7TJaqt6pZAbSJVJbd8DvSZzXXn9s/RkT8aqwLnmNFEh9HKbXVv6Aw+jIIKCe62i9YV606EJxp069cYG4GE49rT0YN0Sc4M7VTMYCQIFLWTlwYkNmxFsQpPh7Cdc+uXr7Oxwlse2lgBRf+eLsVmFZxUcTw7juL3B7xYjzOD2ChtD+YjrvDjzFqCbY5gXe6bEa9hmVUssVuAFL6Nj8cmAXRllvjUc+UcczxDeJLmTrJPeaL5ChcRaKr30bhBZFHqCYKh8fa2i5Qfkcn4Go0JHIud1qV8UW03
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(346002)(396003)(366004)(136003)(316002)(478600001)(9746002)(26005)(54906003)(36756003)(8936002)(66556008)(8676002)(5660300002)(966005)(66476007)(4326008)(83380400001)(38100700002)(186003)(426003)(2906002)(2616005)(33656002)(1076003)(66946007)(6916009)(86362001)(9786002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?dfe9Wr24hBYSiIFey1mZENwDEFZcgeBsrBT/pZJ4tty79eTAgooAXnoVgJV3?=
 =?us-ascii?Q?iIOA/5TMAKoY2R1Mp6fo1e22UlYnEK9xYcSuei17zqFe97IvFp7714Ts3Xel?=
 =?us-ascii?Q?EsEemGltg+ibavqirbJa/U9r1limPPF3X1NsrXYJglHBs8+3NEb6s2zoPDiM?=
 =?us-ascii?Q?hF5BWjfsxquywdBbPLeaVixIhPvZkreseaqkv3iXkAvarJQtVeXQcWuIzO+J?=
 =?us-ascii?Q?MOAhfuZM3kwBMWonZy4824LWkEZOZXcBakmRYggLbXWNd1c72L2sRwqyKnOl?=
 =?us-ascii?Q?JvxbEvGlcAkn/I6F9aRmsYfTSiwgj/vdT9nXpPOvmjFSrKmgMEgDYyFJ0o5K?=
 =?us-ascii?Q?oinkVkGH42stNlXOzAjancQ+aUtdczIQiTv+JpZf/IMnu35m394lpzrVx+jO?=
 =?us-ascii?Q?rlqkFGjFtj8WC7G3IVjfbFz4LyeDuD3PpL1LdD9fsQ01J9de2wZotKqP7Ukr?=
 =?us-ascii?Q?tvIoWGCXoRcXHB5tn/ScmOJ6MeZtCAcJnd8QRN5Lhaufogxzm4obC0xgpHvv?=
 =?us-ascii?Q?f0Nn2kUY2XrqoDNp4pqaaS9sfWBxkOr1HR8GMBPW1zjEUwUxeruSVjHkPQ21?=
 =?us-ascii?Q?DtNCscLpY8svGAHGzNZUTgolJRcEHairlf/r6pRC0On9EIPbGZruNKrlMcDg?=
 =?us-ascii?Q?uQKoeL0XMv5U5l4nYX83gWp0ST+Ha/pbaMJPoi7yOAQjRrDt71sIY4Yi2abM?=
 =?us-ascii?Q?/N+Ripw527rv8Z5B8eu8TC2iMFsijdOPMC21rxtqDXLae1kjN/Ck6uepOYXM?=
 =?us-ascii?Q?BVxf4aKwvqqM3Jh1SArl4Y5yxNfH/Mr3GppxIDCH6SmzPFUP8GX4kgp9kNYA?=
 =?us-ascii?Q?Uv45TL3d4+oFSGNuRlIxIuZt9PFBl2CpSod+6eSMCY0hnU5MbivfHbmp/fPb?=
 =?us-ascii?Q?QCDicSTomoQZAYJ9r0tPAGFYrnT5kl/a0VBEcbahVGo9T7KHm1xD95WCv5Ko?=
 =?us-ascii?Q?DNs6AhkBZ2k49y4SefFKfKbC3ErIpRh/B6iDzTwsNwX7EUueOIc4sTB9GTvU?=
 =?us-ascii?Q?0r2ltekGKTHZEAJroA9MH3urfvLbS5mRS9EqrJK2I+/S2ZGn5WhdfZXi0hhA?=
 =?us-ascii?Q?npHrQahxhRwy02Q3EwEnBTAExD+2bQ1Fmj76fXXzDMyPdXznSbnyJ4g2vpFK?=
 =?us-ascii?Q?iig0ecGWePXi5rpMy7LRa1FA9EWwN1eSYnTsizgYlBR8BKjYkvmMTiZkj/04?=
 =?us-ascii?Q?weiMEYqZBJ59Xr2vih9CSVGjReqBdti3QWse/Do51wnjPci25m3Dwvj8lj+2?=
 =?us-ascii?Q?oodPUmIvIR4mxAeBG134FdUgphAzbaTGNKTG9NhGOEZNWVSsLstUlhX/o2ET?=
 =?us-ascii?Q?q3aeut1IJJfk7pFDxeAlafW8?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86deb507-a0c3-4d88-2f5d-08d909ab7880
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2021 18:37:11.6959
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eVzYQvVdFjMiPZpf4ng44jTBV9Et9kI2nlPvctp+RInZFRGWaZwe0SohVB+N2RFv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4636
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Apr 18, 2021 at 03:10:25PM +0300, Gal Pressman wrote:
> The new attribute indicates that the kernel copies DMA pages on fork,
> hence libibverbs' fork support through madvise and MADV_DONTFORK is not
> needed.
> 
> The introduced attribute is always reported as supported since the
> kernel has the patch that added the copy-on-fork behavior. This allows
> the userspace library to identify older vs newer kernel versions.
> Extra care should be taken when backporting this patch as it relies on
> the fact that the copy-on-fork patch is merged, hence no check for
> support is added.
> 
> Don't backport this patch unless you also have the following series:
> 70e806e4e645 ("mm: Do early cow for pinned pages during fork() for ptes")
> and 4eae4efa2c29 ("hugetlb: do early cow when page pinned on src mm").
> 
> Fixes: 70e806e4e645 ("mm: Do early cow for pinned pages during fork() for ptes")
> Fixes: 4eae4efa2c29 ("hugetlb: do early cow when page pinned on src mm")
> Signed-off-by: Gal Pressman <galpress@amazon.com>
> Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
> ---
> PR was sent:
> https://github.com/linux-rdma/rdma-core/pull/975
> 
> Changelog -
> v3->v4: https://lore.kernel.org/linux-rdma/20210412064150.40064-1-galpress@amazon.com/
> * Mention that nla_put_u8() return value is ignored on purpose
> 
> v2->v3: https://lore.kernel.org/linux-rdma/21317d2c-9a8e-0dd7-3678-d2933c5053c4@amazon.com/
> * Remove check if copy-on-fork attribute was provided from nldev_set_sys_set_doit()
> 
> v1->v2: https://lore.kernel.org/linux-rdma/20210405114722.98904-1-galpress@amazon.com/
> * Remove nla_put_u8() return value check
> * Add commit hashes to commit message and code comment
> ---
>  drivers/infiniband/core/nldev.c  | 14 ++++++++++++++
>  include/uapi/rdma/rdma_netlink.h |  2 ++
>  2 files changed, 16 insertions(+)

Applied to for-next, not the enum number will have changed compared to
what you sent

Thanks,
Jason
