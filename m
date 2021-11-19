Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5DD545724B
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Nov 2021 17:02:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236068AbhKSQFM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 19 Nov 2021 11:05:12 -0500
Received: from mail-mw2nam10on2065.outbound.protection.outlook.com ([40.107.94.65]:50049
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234970AbhKSQFM (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 19 Nov 2021 11:05:12 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oHpX1XivJHr/zpbwpcayQXt4oI2tYifEFIV9YA9N8G3mpPDE5+4knC6d0sb+fLYvRaSuikF3uizx5x+cioBz2YUZrxeIKzWV3VWtBZLcHIPAoJ7pEN8d11otk2SfD5NXwI9I2XRVtx1n4OGMe1msb0xmXti5g6jTNh9jOJE7oszeDPhauYdWV8b47p32ix7PqQ4gwUQW/XaCYVestqformpKShkxX+Ak4398JxXLYr2ETku46wot3nzwYdnraY8l2AMIgXTFjiKSUbgRiV1KHHhKg3wmo3hsyPQNxFOI8N607vdSTRwD7SoqEXBnSCXRL9uoxKZKyAde3EPMiW7j6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xj7EMcbqcFZdTaCDxtVIK+s76KAbC3M2uygenhmEjnM=;
 b=WMRuXBoRrCCe2NEm+rV99kLbDS6CRkq9XBmjGV8dvg/+CXUJ2XZU98ftIDMnx3fuBWh/kVOuemEmSTz9cqJfaR/gZK5cMzgszah5c4oGNXJdrvGQadddvkhoTVNwsHNZokCWyZYQ3FKHSmI8pv7dXq4CIB+6uOJoaFRT2klQ0KKhkWobyRrDqFFq1JHFH2HnZkmAI+PDcwJa7MUQ1V2BSdS0M2YWIl7YfbteY5Fz7eD0hWYlMpTw3tT1zQTA1JgV9bHzfEv34fDn/KUXiNnICS7VlYvid1x9sj/oNYd15/9P514EN1AIuVtMfIAUoiyPn+d8h+RwMbl7HQjFXV4qSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xj7EMcbqcFZdTaCDxtVIK+s76KAbC3M2uygenhmEjnM=;
 b=ablYlVcm+pokXb+lAwI6nkju5Ba0AETWXfBF5uIQhroLS9rja7aYUdGRkfxGTV3FPgy/BqcqLyJoErxUL9OGTTOdIDns6qxDqyijiQ94gswaB75eIk80+79BNojN62M9KvMwSs71Gru3PAmsDoG/PL19SccLl1sTcGLCg0npFbBDWfMM7AbHOIqpca1Dc+cp+KZcDYppYRbxlDN/IgyE5Rem6GU6/V0ZK1TS+L1m/Bl5VGbplUSv1Mm3QHv+f/uZtvsjWNSlumeVewQZ9RQMZi9slVp1rpYza3wFyzV/Bm1ywaOAXARZxyKLWMt0GMQ/RTTH+wvYH5WRV6prC3N1nQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5158.namprd12.prod.outlook.com (2603:10b6:208:31c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Fri, 19 Nov
 2021 16:02:09 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::5897:83b2:a704:7909]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::5897:83b2:a704:7909%7]) with mapi id 15.20.4713.022; Fri, 19 Nov 2021
 16:02:09 +0000
Date:   Fri, 19 Nov 2021 12:02:07 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Kamal Heib <kamalheib1@gmail.com>
Cc:     linux-rdma@vger.kernel.org,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Doug Ledford <dledford@redhat.com>
Subject: Re: [PATCH for-next] RDMA/cxgb4: Use helper function to set GUIDs
Message-ID: <20211119160207.GA2936321@nvidia.com>
References: <20211118100456.45423-1-kamalheib1@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211118100456.45423-1-kamalheib1@gmail.com>
X-ClientProxiedBy: BLAPR03CA0092.namprd03.prod.outlook.com
 (2603:10b6:208:32a::7) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by BLAPR03CA0092.namprd03.prod.outlook.com (2603:10b6:208:32a::7) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22 via Frontend Transport; Fri, 19 Nov 2021 16:02:08 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mo6L1-00CJsl-RB; Fri, 19 Nov 2021 12:02:07 -0400
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e73c9b05-6000-4011-fc25-08d9ab75f0a6
X-MS-TrafficTypeDiagnostic: BL1PR12MB5158:
X-Microsoft-Antispam-PRVS: <BL1PR12MB51581A5C9678658641D5E753C29C9@BL1PR12MB5158.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZaX/1lSZRyRaQQfWDjpyWUXqLP/ViAQx0TOwVZAeYy9RLuHhpjFnUFCWb1BoplqgPTT3/XOxckQjiTbRqcrHmor+fHqe4f0Iv6qYTwD/v2DjivYQAvFsHD6gJE88bEPzM+E4ucfa6p/DP+oOZ+U9vdmdymyqa1wa8dUTeYrm3qyjeBS4oFBtvzgFmPe1ixgoswtEsTHHC+KhZsSGO03AqHksPwPgMfpgo+q+uLDstU5ZFcS0RP3LYhI8KFodcSKWQ5cc+iurx+a+hjma8Tw+PJ0QNkfpv5x5AeNX/Wq2xqkydAJLQOmyk3l/6FGZkHvEPgmliaQOwuS+rplQfyAYgUlI1ux6s5aZo8GdlWAUwWkd6ftKBpqpid7X5l3IZUPlnxMS2yZzqxLYquxds2PuZqWw5JDdvT0R2g1wcFT1TDty3kIXP4lHfcM6XLWl9wn80QAbT6QTHteY/NH5LY9H27y/SMUqsKqJPpsw6nCS8f27Y/Q3coDABWxJUzqNjB+BmW/n1sN2N83tXSEx32a4wuzODwr2tVQfcXTZle0+Dc8UFWJeG8kIkAizv3xi7IE2D8KWWmR1v66OmN8DFbhEISy16JxsBwtNOGat0I+N1aSLdx2F4PBSUw0Us56RMhmUlCBZDCuobyHXhOBW+NtqcQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(5660300002)(66946007)(316002)(4326008)(1076003)(86362001)(33656002)(54906003)(26005)(4744005)(6916009)(2906002)(83380400001)(36756003)(9786002)(508600001)(8676002)(426003)(186003)(2616005)(66476007)(8936002)(38100700002)(66556008)(9746002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ednmMU6+hFnOLv5eK53xvUkmxoulln6+9uvlBcAK6VkCifIP8TNOGajgec3K?=
 =?us-ascii?Q?UPjFywBNtN1QjfGVeUIpzFEEgYslxxfkulzYWP035Jik19DDI08MZlYGcXjI?=
 =?us-ascii?Q?QFMw8VJ/QMAflZVWT7jh3iP0CV7XpwWX5FmARZ9QpgIS6X/UPb8+wkgzB5X4?=
 =?us-ascii?Q?z123gbA+z4BozWI0/n1fVdkdtEyYrfXoHaviHv0Pb/TIRbV60j7Q+XNUn8Mz?=
 =?us-ascii?Q?akvurSgAmY3NuC9XiiIR0bDrz0vavPHSTkpAf0nngE/S0qOoPNHn4Sfunxf0?=
 =?us-ascii?Q?dQM25pupD/nQSlZJ87rJWSrniDGvGtkvQSwvzRv8MtwvOFozWog53hlEpjEE?=
 =?us-ascii?Q?zgbiVF7Cj2gYdllhZOWbB+jhBTS5ugfJF1gV1kvlgoTP03zUpoBsknlVK6/2?=
 =?us-ascii?Q?U6q74ItcWDuYmBwJmLdXjFNn3orE7FuksNkBNSuv3kAP0qAk/E2RlQcb5dGO?=
 =?us-ascii?Q?YBUatL0pMTzcGTDEJdFaS87fQEPFx1J8twQTVl9wNmFFLXeAwFo/nkSQ0AGJ?=
 =?us-ascii?Q?nCk5pqvd7VRdxWDE2fmb5xiKC+Vcqnaua9T5Qu2is0VI0bpI3288msQP6zCi?=
 =?us-ascii?Q?At0XvQBCRXlIYqn13gao0jJH3raT1zNulhDcMe20vnYvq7uex5VIX/yzRdLu?=
 =?us-ascii?Q?oE9RVq8Q0n3rxIop4pEYICE7NXNkxM9StTiaoIQwLDx6Pp8UexGkAs7dJ0Bx?=
 =?us-ascii?Q?LKhoURl0kxLYvqFbz3n7VWy0tg82+L6bT+XslQNkLUHh3Irzh49B5YKuKAks?=
 =?us-ascii?Q?63d+SWQkXPsQ49GtweL5lPLBrnVz5NpCbqRr0BdiBg5zGxvVXA1dYRd9l0Fn?=
 =?us-ascii?Q?oln9PKKeXjeRb6Dd0XztYBQ0PyySnYSEaPH3TheSYd+fxRosYsaakeWDxKUV?=
 =?us-ascii?Q?Z/CW3cFKj0CFlJPFxFI6n9TtmWC0qV6ghdfHIF4ClPdbcn1GDau3z720NunL?=
 =?us-ascii?Q?32Y/EtJUwxOwz8D0q7jZl47j5hwQFavG+dE9HjB+TB7bwgMSR2FzCXSz+2J2?=
 =?us-ascii?Q?ThZ1DrWpUOS+Kg68Mz/ai8vdQUwToXIDq7BPr0gddZpIaaSa1bklicwNZmAA?=
 =?us-ascii?Q?dPpO9sgoLYssH30OnhTltwCdluXSCo8Fy5FWUrEp5qfqY8lF1Lkzex40ev75?=
 =?us-ascii?Q?4cVPjk2IJmTBg7UYz4PoSZ+g1ZMXESR8S960SkUwgYy4y+CKFWvX03+OoQs9?=
 =?us-ascii?Q?5qaJecdQ/zZT9N/QTSDx/sKjQFrIzf9L7kvD5xCyKOS0QzmuebNBIv9y9lYi?=
 =?us-ascii?Q?dVaZQxjjy5TrcWiZgRJq+ypclM2BQuFeqOQMBjytsy8+7gtq4rrwtTklX3tJ?=
 =?us-ascii?Q?JSbDfRAUULMZld+SvNx3r1nLnPLvGiD1bRGQd55wL7eNp7ZEGwLNu1HHITR2?=
 =?us-ascii?Q?V8RK1vi/EXS8Tm1YIXF0hPrvrI4UOiy/aL7rSOe03T8rrv1itVzL4ybK8/aN?=
 =?us-ascii?Q?WNC0JYQmz/xCDvet6kSUzl5SuYMehCEd49z3Fio8JrYBYWtBXIjn7Qxs7zue?=
 =?us-ascii?Q?oLcw8ld6aUpE4eO33qM0cEwVejNSepTlUr92fS2nq1cI1ttu0twiZuS+W5rM?=
 =?us-ascii?Q?AVvs+W/Okmy5pttXsgM=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e73c9b05-6000-4011-fc25-08d9ab75f0a6
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2021 16:02:09.0188
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ERT0HCL621gI58dV58zXuNuRUnJ29z094HG6Cii17/Obs4AFdCz36rnk01j3A8dj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5158
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Nov 18, 2021 at 12:04:56PM +0200, Kamal Heib wrote:
> Use the addrconf_addr_eui48() helper function to set the GUIDs, Also
> make sure the GUIDs are valid EUI-64 identifiers.
> 
> Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
> ---
>  drivers/infiniband/hw/cxgb4/provider.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)

Applied to for-next, thanks

Jason
