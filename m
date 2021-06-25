Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE8C13B4395
	for <lists+linux-rdma@lfdr.de>; Fri, 25 Jun 2021 14:48:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbhFYMuf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 25 Jun 2021 08:50:35 -0400
Received: from mail-bn1nam07on2072.outbound.protection.outlook.com ([40.107.212.72]:12142
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229653AbhFYMuf (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 25 Jun 2021 08:50:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kEfB3wkFwD7J7LDqnEZDeMgsegV5rqSFdO2uV3z3gKZS0XC214c8ipAqKO2iF9/f/lyqsq7cAvHv1Qn4ZiBIFL1ltOyir6h4DWttjsiBwXxmFx8KSS+JGl7cxOUw01vK+gTypOVuVK80KJGd41z+RLtxIDiO/vVC4Z/E+cy7yAYgsHMI/ZbNStIZHL1bLkQNQ5cZrTt4RdDP+oHWv5/cQ4Du8Eh3lpssp5AO9R/4hVwhUhQpf2BwbIJyP3DSiWDGFCJDS+Bn30KWXNQk3GyxNI6DzY1osFveluRzSO2J5zK3gitTRnziklrOA7tGYVd7Xtv1F0F1O82el0eIn1J39A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gb9CSXjdXUMWQphwR3Ej5TsPbsDmtDchfxcd4dIo16M=;
 b=maGw9paiQdU3XP11EEKCoZVu4O8q7MsGv4RBERmUsBkHUifMv5PRI0Re8//1hlFmbMYrpZnYdQy8lh9BtdkldHAgy8TL6utveWVoL9oniiom+9zG0H6LKM8BpMcCMRIbIFbMrrtvMO5HkqXiyrKt9OBFrsGneeK4KEsX9NGFd7GQ6XI+Jv3xrt/slHQaRYQ1MjyZbCbWoDH0ey+kghDfXWhTRjBx0fO7ZTC/nprG9mNGjHuDzbw0hRvjcQP+jV7NxDhxPwi3VSqMYWaaRsRh50Ab4f8NqjAXvbppcjQk5RTjRylvhYsE3vNoWmoWZ/EbPLgIqFgL2quOt2Kkbc27qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gb9CSXjdXUMWQphwR3Ej5TsPbsDmtDchfxcd4dIo16M=;
 b=m04l6xmRB0ObFk72aJj1f5NnnxoNPhv+bf9QvMS1FbKbDhJKiby587l53D8N4shpv5hsudRHFWvUpOHTFirWD0tpw6L2BF1pOSg2o7ggcyfU0q93U69sy3ZX3BUhhQxCiPZT97jVVSfBvhpFMFh96PhOpPP2L5s1yzPotcipuiY8+B2kCnibPXfSWq6SYVWOl3MwDBVpwVd9q2ATwWRNMQ0BOJez5OS3sy4+CmY+CHWgQ3LEMZKpa3CNPvPZwdmIIAJZAdhb1UhsfQ5OJigX0KRIMl7D5JgmH7U3bjFu718VzzalA2iIZs/yCYkPC7+/K8Buk0TZpvc4BosS3anjwA==
Authentication-Results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5032.namprd12.prod.outlook.com (2603:10b6:208:30a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.20; Fri, 25 Jun
 2021 12:48:13 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%8]) with mapi id 15.20.4264.023; Fri, 25 Jun 2021
 12:48:13 +0000
Date:   Fri, 25 Jun 2021 09:48:12 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Anand Khoje <anand.a.khoje@oracle.com>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        dledford@redhat.com, haakon.bugge@oracle.com, leon@kernel.org
Subject: Re: [PATCH v5 for-next 3/3] IB/core: Obtain subnet_prefix from cache
 in IB devices
Message-ID: <20210625124812.GS2371267@nvidia.com>
References: <20210616154509.1047-1-anand.a.khoje@oracle.com>
 <20210616154509.1047-4-anand.a.khoje@oracle.com>
 <20210621234913.GA2364052@nvidia.com>
 <012d6cd2-5167-ed81-80db-444fd2741ea8@oracle.com>
 <20210624175458.GR2371267@nvidia.com>
 <5fd99709-8a90-e875-1ed2-74f5bcce6eec@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5fd99709-8a90-e875-1ed2-74f5bcce6eec@oracle.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: BL0PR02CA0061.namprd02.prod.outlook.com
 (2603:10b6:207:3d::38) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by BL0PR02CA0061.namprd02.prod.outlook.com (2603:10b6:207:3d::38) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18 via Frontend Transport; Fri, 25 Jun 2021 12:48:13 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lwlFk-00CWe0-C4; Fri, 25 Jun 2021 09:48:12 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 02fd808f-087f-4d58-f3bc-08d937d77e98
X-MS-TrafficTypeDiagnostic: BL1PR12MB5032:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5032D3F719576CD6B0747B25C2069@BL1PR12MB5032.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rk8Fb+AXajeDkfHkNUicWBZ81DVrks9PCoeGosxweek6JxomS/AWca8w7N+KEcCMTJLiCiqpusGC3OUBf9LT3dj3w6i1yd80yuo+MAsRfIFpDTaPyrvzdyzLg00kvmE8fMzoiKK4yjeMVsPOefFzsNWx/1z5wI7E+/9VM5EtrYZgZx8G0fi3XFB4LoxwyPvOa/BN5RY6EmNKAUNuppOSxjMmJI2ajD9DZdC1FikCMgkW6er1Wh9Ktte7Z6STtEVc5Qj4KdE1CZHlOXxzJl2IVlUHLfIlMAsZmqVYtdcv6RhxF60BXQ7cpExmMyS37YpzKTiWG/MfTuUcfeU0oHmzT/RnblXburn4hTVZi1901RkVJQ0Z/GFiEe8DFbe3zElM8JHxALGbAR/e9TPToxe9bXx6ZKsKX6NqXTVval2vAdE8z3BKJtBy+PruXS2Txd2wwZHSFdMsSM4xSqv38hNH+ZcxD714ayb9+++AK5KKdrYhlL88QJMHUAB2QZPANLKhod7LS+dc5x8Ns24wltYtpQ7oSrCEZ+oYgpe9m5cun1mw05Wn5CqcBmY51KFzYj9F6cnzh//w/VYuJRr38MkABWRt+0VMqjcrWwo/2j+Z/x4pNjdj1Nq1MKFYfPw1vro1j6a3leI+Uhrhsx20t6iDog==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(136003)(376002)(366004)(396003)(38100700002)(186003)(426003)(4744005)(2616005)(1076003)(9786002)(2906002)(9746002)(33656002)(6916009)(316002)(26005)(5660300002)(83380400001)(478600001)(36756003)(86362001)(8936002)(66476007)(66946007)(66556008)(8676002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rOQ5AFb19a9nxD+40KwpM/QQjiHsohYuHiXX5/CHlXaDXOyowrswuQRzWg5X?=
 =?us-ascii?Q?2mFqZGE9/TeBUN1cEi2lRWitIb3jAmm/BhzhWzZRsB5PRx7XeJ9WjVizjmPf?=
 =?us-ascii?Q?lUeZ+lti8HNT0pS/hE/jR4GlHYbr0I20GbiD7M0ux2eagqxF/xC0KNpGk+Z7?=
 =?us-ascii?Q?aqYNAKe1waTLaCi/JDH3TCzSpWzk/vGoZ1+IrsriMO7TFbfTsDAmi3bWIw80?=
 =?us-ascii?Q?tia7XXefsxXOjUAEuARochKGUdwQuYoc+Da8IVqxZobWxZ6megwhddoTmH4M?=
 =?us-ascii?Q?TAA8IaTPd42f7JoHF3Y3u155dmWaJ7quzI7l6CFRLorEQT9Oh9/KHVpz3wNk?=
 =?us-ascii?Q?t9tIicDMkng9bmoy+CA5vIulGzuUfbxu+ukVsm8/yMjnkNIGHaM5ZAmiT62q?=
 =?us-ascii?Q?FTZv1KqTKuLYyYR01vPz8iUZMO4yBi1W26JWSTHTLZLo8NZtowzsA+1iW/8F?=
 =?us-ascii?Q?PhXYPES/bf+09q1TnpSxJh5E2wejhaWtS4Fk+1YARCbEndqY3XG9/QqFG8Kv?=
 =?us-ascii?Q?vYGM3rng/0dUXYPXnsjEZ6o0Dj7ZHk99mslEqkIOh2hq0LEKILMAwsaSqP+L?=
 =?us-ascii?Q?FYSgft82SP1UMTNGlnHB8gd0LXguN8DIGStiSkeR6b4zuKZcgpMV/hZSsvqF?=
 =?us-ascii?Q?uxR9NS776yETba6Q36EtzWkh5mCtKhbRY+1U2+8b3NgzWi8vAlvwoD8PJp2j?=
 =?us-ascii?Q?HyQK60SDT/munXrqxyhPRJI/BISs+uNHPkX8y4EAjzRSluGP34YZDTdwF4C2?=
 =?us-ascii?Q?je5EhoIOC7Xnl6/+3IRelI8POq0p2V2QBUdV9Ll77KSSkh9JtKRdMnD1POFf?=
 =?us-ascii?Q?IH0P3KbX3v46uRzLHjGf4iaKrButEYDcFSZ2okjj2QemgPOfiYikfWbT+XTY?=
 =?us-ascii?Q?bauTjUaqtIxSg6o5U8Gx27NIRpi2AmmhwWin3uppSnBekTGuiA0qQkvvnhAJ?=
 =?us-ascii?Q?ZuI/SLHkbrBqhPbqEMcE2IKoeB4HZ8tRyloVb72ka0ynZn6+JQfPOODzmg1F?=
 =?us-ascii?Q?ohyrWuwBU6QfwdDS6kfjZy2945oYOE7oxVtk00unb236iC01FH2dtzXPqElg?=
 =?us-ascii?Q?AVEccBZ9HnkC23jt40jMNIqO5L6Wdb/8oRXJTyLwTCzuz5iLskPD2FRj4lsg?=
 =?us-ascii?Q?0SXb4bTVaryLF796/u0FlIqDPJZ5Fk0MHiAy7d/ZADuKH5aJB1IJtUPA+G3c?=
 =?us-ascii?Q?eTR5atjsUSbBslWmOLUy+hapXlxXieMkLZtdw6hQGdt0gMp+ldj2a4fh4hYW?=
 =?us-ascii?Q?DU5h1MBQFC8iG/or68g2+duV+nPnFsI2V3r8wyE72/a/7NJRGgdliG0wyhsv?=
 =?us-ascii?Q?a3X627fQYafYBFzdWqyIAzQm?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02fd808f-087f-4d58-f3bc-08d937d77e98
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2021 12:48:13.2449
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yXGYXXgoCDGwUSsFXRVCRdvwujquoG3QLfl4MRhr14Ak3uoZK1+hEDYbpzZeWwls
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5032
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jun 25, 2021 at 11:33:58AM +0530, Anand Khoje wrote:
> 
> If the above change is to be made, there could arise a scenario in which:
>  In case of a cache_update event, another application/module could try to
> call ib_query_port() and read subnet_prefix while the cache is still getting
> updated and the application/module could end up reading a stale value of
> subnet_prefix.

Applications relying on this data must hook the event and update their
state when the event fires.

So long as ib_query_port returns the correct value in the event
handler it is all OK. This whole thing is racy - the HW can change the
subnet_prefix at anytime, this is just shuffling the race around.

> - Is it possible that different GIDs in the gid_table will have different
> values of subnet_prefix?

Valid GIDs should have the same prefix

Jason
