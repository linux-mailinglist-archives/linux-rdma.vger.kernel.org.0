Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7017349FEC5
	for <lists+linux-rdma@lfdr.de>; Fri, 28 Jan 2022 18:16:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350506AbiA1RQl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 28 Jan 2022 12:16:41 -0500
Received: from mail-bn8nam12on2087.outbound.protection.outlook.com ([40.107.237.87]:16608
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1350511AbiA1RQk (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 28 Jan 2022 12:16:40 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XcfInsJYIeYfnVO7rSdIgJpU5IUZtTp23EWCs9h579zRniDLRcIl9bnKvREQwNe8e5MXARWn7BDOWz8J6BwNX2+DEC3bUkBukDV3JyUgxcaWRXAXc3h7Pnli7oLN4w3QVaZ5aU5yLQaUO7XIewwVe5PO8SqW9KcbFov9tGeRAKwUGHvhUuJH12dDNAypBdrirMyWZoD81VcpWZlviTn/Gz9Z5R0TZBpwXMf6z7S0yKf5xvPAZhB90CIL9zxoZlEIn+ImoTDd230LMJs3aB26WdLJ+R/nMaiZ2JgSzwNX8sS1SVQ1tAZ6GmNRBvLjjBX1FgwTZAOF5XFU3cLxVPwwOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rVCSyrOnQyBMu6bHFOg451wKJdjDi9SFW9bTkcqkauc=;
 b=eQi/xFhMOWI/kSNKPp7ojBBeA9OQB9YLaniYODONjfL66qxnIy7UkeUZP16CrwIzqQqbMVNAtn1u0zAQoxTk12KZ6DNwQKsQv6a/Uln6j+8HGTz5SWgzuG9C8SL7A1jeXK2q9XIooUYpK1pzZqho0wgbQlYSD/3Fo9F95VYUyfMw9PXdnxx5gG2FKiVsFh58H7ctFILdS0PMPTDPUkVeSMMySffFsJiAKiPrnacPv/U2ZZTlQrFWrdxJaPwr1vxopSzevi9Shh85Wwd3AJO4ldYsTCShvUK9jcDS9dVTVp7Hl/IGR8XtQ26f5ZuCqCKH1yyongRvlc0NOkUVzlsqKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rVCSyrOnQyBMu6bHFOg451wKJdjDi9SFW9bTkcqkauc=;
 b=g3R9Z+j6v5tNeowgf7lFQpRHXem1WwKjrvgIEEQZiWnzQMMW5u7miXXWtdp5fCY+qvzgAtcUqc1Dz7S4zkUhVMnVMoTVPg+byuqsR5TYWy+C+f6mLRYV+rW/Q5LPGqw4OhAYo9ZzMsfRWF2kovu2INAtQkCAvzyRpGUcHA7+u3MQv6gByII9G4z0XrJMI2iY/Ri28OxayFiyeq3RjePLXheGIPJb9PLuH4GdARqKmnTZAlwbBmmvZsukUUYNq1PIoilAowuFuC0vwZXgpnI/XOWtJfiEOjZ6jzjbzSjT3JpqXpmPFnfopT73G0avGCZg2vRBhB6CS6wML5Fl2opSiA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by CY4PR1201MB0069.namprd12.prod.outlook.com (2603:10b6:910:1a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17; Fri, 28 Jan
 2022 17:16:38 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::e8f4:9793:da37:1bd3]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::e8f4:9793:da37:1bd3%4]) with mapi id 15.20.4930.020; Fri, 28 Jan 2022
 17:16:38 +0000
Date:   Fri, 28 Jan 2022 13:16:36 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Potnuri Bharat Teja <bharat@chelsio.com>,
        Steve Wise <larrystevenwise@gmail.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] RDMA/cxgb4: fix refcounting leak in c4iw_ref_send_wait()
Message-ID: <20220128171636.GA1892386@nvidia.com>
References: <20220124122502.GB31673@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220124122502.GB31673@kili>
X-ClientProxiedBy: BLAPR03CA0129.namprd03.prod.outlook.com
 (2603:10b6:208:32e::14) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a205ed39-8cf7-4f9c-b3d4-08d9e281f162
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0069:EE_
X-Microsoft-Antispam-PRVS: <CY4PR1201MB00691E23BF75E4DB599A5B06C2229@CY4PR1201MB0069.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aZ/F4rK0ssHCliMby5qDR3/MI/gCSxbG/2hltRx8Z0qiGshwnLc+RF4drq9KKkwyq9Q37IgpAINL0ElGtuN5/SA3zIJ4ByU50n80cfeMYHoAArh7bLHFFitOPCH9Jtrbl+S3Wt7vzTsaEuA7NkZbrcz0T9DHxxuNfSLPbqC4jJ9VaD1ZY/zQ0xP7AhZB5lquB9BggaBN0N9yzPEdW+2aEk0xVwuyK+7iDkx0f5CgV1Mt6upRmOxVq+0Vi68Yxs0VTqKhTWiAEz+GK8FEOmWjiNxNIgLQbb9AnWSUhxgt30DMSikl/WqxMjQeWy7s2CfeR2gkWaaTxyR6KsZ8G4qYZyqQLWJ/LjccC/LrMt4uDSniZpETUVVU8gOAQWYJidwa11vy8+Mw0JUH4yXvtO4GucZjmbvTosmdGzqepX8vXyS6sMexePjUCscpdScWJpLYrSNUuc3NXBmgwpvF0pT79Rbhxg9gtluDy9kvubRU370R61rbJK2RRdPft8xQCTudYYeHF922zicIaHn14T9R1luOxL76Xcrv7O1MHWei1Sp45wn73+MKBnKgsUCuWhTN+PHoRztu30n99NeQsCKBQY127W4vQ5DkoYjV+As5M0Owa1ZxwLK66dTHeYJK+CeNEW8XjXtetr8cHV2SGM8KbQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2616005)(316002)(186003)(1076003)(6486002)(6512007)(36756003)(83380400001)(5660300002)(26005)(2906002)(6506007)(6916009)(33656002)(38100700002)(86362001)(8936002)(8676002)(66476007)(66946007)(66556008)(54906003)(4326008)(508600001)(20210929001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tR3jxFkqwEqqN8zRy6h8uAbMQQxWp/Q+ci0OoFTZFwlEg44T6Lur5q5KKHNY?=
 =?us-ascii?Q?/gJjXgySzZUp+DVCzr3nHXi5nGzgk4NLrUje3bdPhHn1qL+2zLmkxTod3d8F?=
 =?us-ascii?Q?uI3i5mhn2HEynwJLxuiZcw1zkcRMFMB3/+Zkg6HZmpvJJRXGapXBMjiFsc9d?=
 =?us-ascii?Q?CD+DwJHsOna3wj71g9PbptFmjuT+F7xG2G0OB/UWq74utc5M/uEkrS2pvWNF?=
 =?us-ascii?Q?DE+RYRycO9AHVOKasdIsB2juLQreLN7nVy6zojmMnvJs99YnhSelnuI1Qhj+?=
 =?us-ascii?Q?NiTrfyvLhr44k2UuMhOuPWtXfi2ZFlhvG0CnMa1cOIKCpRlXEcbrJoKOhhcV?=
 =?us-ascii?Q?BbzANj7lptt3njC2rp30nfp407NWdOWq4bsMtVJkmyPOhp+H39xXl0PmQ6Jl?=
 =?us-ascii?Q?/Obz7ZuimtJ+taBTLi/lbBnp8yQ2av1GWCnuqyj5pBqxZLn5IVXXbCIWHfwW?=
 =?us-ascii?Q?v/FUrwF99C4liCmRE/QUxrpuWgceClfAs8C67XXYUo1I9PJ0I8i1D+H+Hb2S?=
 =?us-ascii?Q?X0F7UIjRlQlv7/bHsnAU3pNxosRpZrHBh7U3nKZpXeqc9OkSvPr1zjf+DLN9?=
 =?us-ascii?Q?0meUB/gn6jpg9gPfDixV3qqSDcEjxEKMXfoH9PHjX4zco/qk65MdCH/Lr9Uy?=
 =?us-ascii?Q?F2fX8v87D+jegOJWp6apZJloBI2UJgrBX5m79qPYSgHq8H3C3dLjTedKLNmO?=
 =?us-ascii?Q?zpZR33fz+GKJoh3E144Kqiny8EVUu4ikJIgR0ZqJldrYz1V/A7CiFzvqojTZ?=
 =?us-ascii?Q?+jhG6EYJuXEECLsU6gHO0PonYwRWc+wY2l7wzHrxOh025Ov6hhm/OjmQfHd9?=
 =?us-ascii?Q?ZcKrBS4sgtLnrg/rkYpt+Vc3HuzYUT0LU82uH3YQItpF8jjvaVf2UD/9n5PE?=
 =?us-ascii?Q?3rQZRtsuG1vfxQeXX/hxteQGjMT+pLMokDTWqKE3/au9L2H6+TP0oeyt8001?=
 =?us-ascii?Q?5hqQM7ACmx5suB96JWzsnHMjsuCca+M2HBVSF1D5DOQDyi2ezo6WIMlra3Gu?=
 =?us-ascii?Q?ug5nTENhYrF3+Z00M0bGTiPIDVFHrFUdCbuDA4jatS3KANS76eddnGhj/ZV6?=
 =?us-ascii?Q?ndiWiFNRkmcxgqvsML4CCcHLo13KwACZxDTuMv3+n4lgaT8m49+QLL+Tmz3t?=
 =?us-ascii?Q?fmd+rs/JwThXNtmTnd5Wi06XDzVvoSRAOom+zXgL+1kibO96zQcJD03YDIfs?=
 =?us-ascii?Q?x/EvWARob9jE4HuvQ3MhXZp6PGaXVZewIJUe+eAZSWquj1IS3d1ZUcIckl0I?=
 =?us-ascii?Q?XPO62XhpHjkHgH+Pzb1Ze6vKA6QbL35q4sAjZ2tBz55M+ZnyZ+Oi2gzaDXou?=
 =?us-ascii?Q?GA1yKOEoKQtV7UDAK7dbkVT7VlgMK+Go/9w6XOhNBTr2ZH9KVZVmVxVXr90U?=
 =?us-ascii?Q?qY2jLDwCxci0zwSaS0PZ9b6pTDRTzKa2li36cD6v7tPtyZkde1YsrEOBA9oE?=
 =?us-ascii?Q?aCS/UA/viGxs331VsLckcJfDOqXMDgjSDINQTjsVAj3ZYyKZN1aHOEUvsmO1?=
 =?us-ascii?Q?BBR1wOPKtIDHKtJYXp5pzBrbi90W/anbNKV2NEKl1qaxztTx349pjDeoJz1r?=
 =?us-ascii?Q?agObcehjpjiSmOmJK/o=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a205ed39-8cf7-4f9c-b3d4-08d9e281f162
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2022 17:16:38.0571
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0D48ChcPAXtp8BK3K0/Pi2XXlOdFIJDz9Hh1vYcBtqoprUf0H/HPQMmqpch47sMf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0069
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jan 24, 2022 at 03:25:02PM +0300, Dan Carpenter wrote:
> Call c4iw_put_wr_wait() if c4iw_wait_for_reply() fails.  This
> code uses kobject so the worst impact from this bug is a DoS.
> 
> Fixes: 2015f26cfade ("iw_cxgb4: add referencing to wait objects")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
> >From static analysis.  Not tested.
> 
>  drivers/infiniband/hw/cxgb4/iw_cxgb4.h | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)

Are you sure?  

Looking at the caller alloc_srq_queue() it calls down to
c4iw_ref_send_wait() then immediately exits on failure

The only caller c4iw_create_srq() 

	ret = alloc_srq_queue(srq, ucontext ? &ucontext->uctx :
			&rhp->rdev.uctx, srq->wr_waitp);
	if (ret)
		goto err_free_skb;

And then

err_free_skb:
	kfree_skb(srq->destroy_skb);
err_free_srq_idx:
	c4iw_free_srq_idx(&rhp->rdev, srq->idx);
err_free_wr_wait:
	c4iw_put_wr_wait(srq->wr_waitp);

So we just double put the thing with this patch

I have no idea how this logic is supposed to work, and clearly
something is buggy in here,  but I can't say this is right..

Jason
