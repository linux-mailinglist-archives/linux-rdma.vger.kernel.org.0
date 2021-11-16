Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A20AA453A7B
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Nov 2021 20:57:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234892AbhKPUAw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 16 Nov 2021 15:00:52 -0500
Received: from mail-dm6nam10on2054.outbound.protection.outlook.com ([40.107.93.54]:43456
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231550AbhKPUAw (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 16 Nov 2021 15:00:52 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ax48j2r95H6zwqbK/KtBtBWX0GTAwQp3f1eTz6QIFa3SxJ8b1bUZbWa0AMwYXFoSpZWD64776gewC8DzU5j46J8lsqK9Aud3zIdNpg4v6Y9jkes97pyQbcHh6Hq9E9esViCWtcPWGFYxq84HDErEpIAjppHMZHhqroe7JOUoIdMsX5Oz+swGlSI+jBJG00uXH0Lao8VeVob5/DPrXVj+9yjuK7hQpuegAuYQm0pcMHR0jJxtvymqVUzE0Xm3ri4spuWSCXN543THddRr76JJNtxceKZXZSk4BL7eNVoDr3dXNLjF4RO2HtkIxe/5Fl8j30mjngNusk5bMcZhOqnUFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t2+PRFUOCUzUc8K409J5u3wE3qlOTgh7jifPV0jH4Hg=;
 b=CmNnCZ/ealCz2z8hIOIw26N5Lyko8c11epokB/hl6IY/gBVtOeDuztPFmRbN/J4kvHbTW3krpanpAD5U1IwbZPJAL6R6ggVA9n+F0ICk7kkewa4uqUjD4L+ZV2tPC7SzdKV5Ipu2QKE7kcCXAN+Vq6wGyPDuWo9WHJQjfL/LzObfOjS5Owg2VmDwx/nuBgHqiCO5ek8uyDv/VIeIS4o1I+iXN0Ps/oAebdNDio1DVV0ruPDYvpiwxoLj5+49PYhOCnIGS7kiJfJcQmLv9+2ZbFW6g5ncIaW1ex4NWQC0tpxVDascuL0j5NorLvcUTP7C2takcWfsQcRCJ+eG985jOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t2+PRFUOCUzUc8K409J5u3wE3qlOTgh7jifPV0jH4Hg=;
 b=kHtaGVg2mPef/6cNO0grkGouSyiILGL5RqQmmRB1B0FfDBWNpDBSt8GQXtKDy52AQj5xNntKyycu6iDDp3Uy/4wtHU9fSEQQJFMJz7kky7seKea7Mj8c0CJ0V2yPnQuLiNebldEAgCpK3t0ebZi+FoIlX04ivW4VG0PsD1jOKYgJSGFOma0zJ/C1XRo7rN9o/Vb/T+wtcLh0Ho4dn0xQVjRi6JhCFyrGA5pmjy9QFcrPN+XrV18yUOLgq/DhaKntZEMTHh57yOMUnLhPlRoAZpxVZntE78+EtM6zYBePUtDMjGp00biGM8zr9wEeEIAL1gkBUCA767hN3xLqQOQJ4Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5272.namprd12.prod.outlook.com (2603:10b6:208:319::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Tue, 16 Nov
 2021 19:57:53 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::5897:83b2:a704:7909]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::5897:83b2:a704:7909%7]) with mapi id 15.20.4690.027; Tue, 16 Nov 2021
 19:57:53 +0000
Date:   Tue, 16 Nov 2021 15:57:52 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Wenpeng Liang <liangwenpeng@huawei.com>
Cc:     leon@kernel.org, linux-rdma@vger.kernel.org, linuxarm@huawei.com
Subject: Re: [PATCH v2 rdma-core 1/2] Update kernel headers
Message-ID: <20211116195752.GC2105516@nvidia.com>
References: <20211116150316.21925-1-liangwenpeng@huawei.com>
 <20211116150316.21925-2-liangwenpeng@huawei.com>
 <0fc3c207-afaa-7f64-3f93-d633b7ba5636@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0fc3c207-afaa-7f64-3f93-d633b7ba5636@huawei.com>
X-ClientProxiedBy: BL0PR0102CA0011.prod.exchangelabs.com
 (2603:10b6:207:18::24) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by BL0PR0102CA0011.prod.exchangelabs.com (2603:10b6:207:18::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19 via Frontend Transport; Tue, 16 Nov 2021 19:57:53 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mn4aW-00BCvF-OG; Tue, 16 Nov 2021 15:57:52 -0400
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 643c5e0c-a2e0-4fcd-1535-08d9a93b6061
X-MS-TrafficTypeDiagnostic: BL1PR12MB5272:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5272F8F66DB9AF1972078706C2999@BL1PR12MB5272.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:112;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KNa6yv+5aPZl440h/J6AL5+wXFH0SdwPBjFhiqZZTin/VkFd9hWsUcy57RldpWLvfUuhcBtdfP96HoOfPn00tkE45C8ribIljvfmLZ8SE6jDXttw0WqUVM+WOZiaAgjVP85cS0SUd7gjvyRjAH85v11KfZ7KZpVQ9f3oE6tqOSsgV4y4Vjp7d1SXnJmwK33L2zxH1fxoa6+2qOcm855OPYmRZXQcX3wGSsVnuxdPBe7PmxL6DwohaR1NXAWBPlySv34UWZdXVB33V4PdFRwp9KDdwGiRDvAFpYlV4Bx1Jg9s/u9MNFGL7+sumzC2J/ksm/FtAVE0p3dKyG3YYr9pvxRrseCF/IAwNmTCB2AIjfxa0LkNILLo5IY5ZPum3lbwTOPiYFIAkEiKq6+SikHGxIBM9L5zXAWhoVyk1JwpkgWpCsUa+pBGjkMujOeJ9upPFTzfGmKTEI90IB9D93LmTMrnix4WVikT4zdHWZ0WPjjRX/6myLSMXR5LixLkTD3NQi3coATE28hNQdcChwYHrWvIGn7sO4NlSt/BmEVZpMnvapkwhQsRwLOyI1iIkUG5+Wf7+H3j5hpqZd7kwJQyJNVctLH2eGvhO6eRPff/drNDGposUPAGUf3Vk2w8KXIrx7LVrqtyy2zYhJOz1OQ7f02Cuy367H0PmZoFNCaxsoi3n7AO3AUdiWJUZPHaKvGFHXDwY7ajtvmNmcXE4BNBtvhOR/DNoOYPKWh5svGxWsU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6916009)(8676002)(8936002)(53546011)(4326008)(5660300002)(86362001)(1076003)(186003)(26005)(4744005)(36756003)(9746002)(66946007)(2616005)(66556008)(966005)(9786002)(38100700002)(316002)(508600001)(66476007)(426003)(83380400001)(33656002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2RHoYyDymhCkXA0RJ7iWbQ3fe4qI5HaBp9Op7GfAGFs+ZuhBbXR5j0llGXCU?=
 =?us-ascii?Q?mIKKOux7qGIqwSou7xGhHjmiOMG+e0t0+n6lbkpJy9GUDqocvUBHnUDPrMMC?=
 =?us-ascii?Q?6d1tGleUY5X3hktaJT/HE3nYQQH3ZPKWAg673tw5xbLQUKH0N/qx0y1lmdda?=
 =?us-ascii?Q?WSz0YO1U/Xb4SZp1bsraqqRy1lKI85rNif4Wy5NPOh40V7p2VB8/wWiLLha+?=
 =?us-ascii?Q?UrBaPkIqg+/ImOu36+uwJU7TZ4kqHfcJkh9dYI9t2UD5YkTuCjF00TtJDKnP?=
 =?us-ascii?Q?g0JKaTVvP90mf5ikXy+0tc7jJ/K6ZsCEuqybnDjBawFLF0XGoC8RjLnqEkOe?=
 =?us-ascii?Q?+cYWdDdFV0a5zMNKw3Y6B7R4PuOrWWQqal9UKxSMeWsakyed5X9qhu/yWrKP?=
 =?us-ascii?Q?ZGYeeXfEZOmK4Kcxt/kK6PwvnpnhZ5yorR9rvDO9aGEfWG7+FNLAcJiwzCBb?=
 =?us-ascii?Q?L/8sJQ8ErtMZf35BB9AZa71JG+qLOaBiXN1U1v7zmA03ScbUee8ebE3BVMtz?=
 =?us-ascii?Q?KGyLGuL07AyGPZfnsAdDOu4kXSoMtgpo7lvgiMIQwEU6mcFOJEI2hMoIPWtr?=
 =?us-ascii?Q?m/ilMAso2pZPdQU1j+Enf8nQ1axeATrb+J/nROKWLc3IzucxAhduabXeK29A?=
 =?us-ascii?Q?1G7iO8hn8998rl6XiSHxHWo1adMCGQRFAb4Fe+vkAskFLBTtmzxl5jK83HHU?=
 =?us-ascii?Q?fnxhqIDCD748bY0/o8evUY5+oGzIuClthOhUC8vNez2nHsuBycjYE4AfdFic?=
 =?us-ascii?Q?E1486Ttsr5+liTdkd/f45RQvOB5jgWhtuemtYZF+TdAq/DE1ItxWEbkiKPtQ?=
 =?us-ascii?Q?WZdY/4RSHxcrVSLADfz0dqdX5gvYuHo4OfWqHrnRirBaRZE2etMmiB8EhVhE?=
 =?us-ascii?Q?U85PDHelDzUDxYmXHFVxGemMGB7Usz2ZOYnNW7iMHJ0Z9+dvF6g2rzCUg/2z?=
 =?us-ascii?Q?pqMXT6NHs1ZOfLVmCWphX08wZIuCDMEJmmK4ayNJijgmXgiXaW3G5mNr8V2j?=
 =?us-ascii?Q?LEMFDz0frQXfismB2a2bqQ4GA6Lb2OewxI/lp/y+4vhjw56URs8O+H97Ydrh?=
 =?us-ascii?Q?BV9ijBWNmKhqm1QZV6NrDqFL9T53rvgOvhsYN184iYYfv93e8ps8W/ySQ6Dm?=
 =?us-ascii?Q?BEH9fhswMD79RBKFYVms7ZR0Xkd1W9Sgn5+N3zqhhgfu3IfgesMl6e88tXOt?=
 =?us-ascii?Q?sPJ4p0ntW9AFhHXV0l5SR/DuYlHlBNyq9Ksai3sLLB1GbLMsU/PmhA23bHX5?=
 =?us-ascii?Q?mFhBLXk1mVA1UwQ32vpEU+/vDSfO3oN7E419XGFw99SUaNWvU1dPYouStxSv?=
 =?us-ascii?Q?UewLybR7hxoJ4repnp+ZF6jXNVZhfRkDuVIBHga6/EcY4JAG+02DMksj1zNk?=
 =?us-ascii?Q?WQwpKHtL5VMiQGE9he1X3POCOG4mzLHJyBPVNwwap+76viyFRHgy9MtiI3yp?=
 =?us-ascii?Q?iHxFly8B+5qIfgvdVTN6Ldt114ovNFBkvfVaAe0371lhKq7pwa1L1RX8L1X0?=
 =?us-ascii?Q?+sYrblidgOy9t89goYrqJ7ElbWybqgQM1XIy6u/d80xsDxr9gV/u/M+mS5Ta?=
 =?us-ascii?Q?RJTOBmLT+8eUjXAQCCA=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 643c5e0c-a2e0-4fcd-1535-08d9a93b6061
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2021 19:57:53.6727
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ihNThVG271/Y9qQGFHXWfE1HQr0W9LQAa8wqQuW/2yWlD3yT7f2Cry5EPBToYqOs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5272
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Nov 16, 2021 at 11:31:00PM +0800, Wenpeng Liang wrote:
> 
> On 2021/11/16 23:03, Wenpeng Liang wrote:
> > To commit ?? ("RDMA/hns: Support direct wqe of userspace").
> > 
> > Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
> >  kernel-headers/rdma/hns-abi.h       |  2 ++
> >  kernel-headers/rdma/rdma_netlink.h  |  5 +++++
> >  kernel-headers/rdma/rdma_user_rxe.h | 14 +++++++++++---
> >  3 files changed, 18 insertions(+), 3 deletions(-)
> 
> Hi Leon,
> 
> I have encountered a problem and I hope to master a correct
> submission method.

https://github.com/linux-rdma/rdma-core/pull/1084

Jason
