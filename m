Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41D7945DFC9
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Nov 2021 18:33:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234898AbhKYRfy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 25 Nov 2021 12:35:54 -0500
Received: from mail-bn8nam08on2073.outbound.protection.outlook.com ([40.107.100.73]:55313
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S243166AbhKYRdx (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 25 Nov 2021 12:33:53 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q0sSuWa4r+22nmcd/2rM9BdPwVf+tou+RmlOcWsrSQZMOyKRuGER8cLZE4wNQNM78/aB3AkTAhi96PkjRiBW/YKT6Z+c6nkxcSN09q4PQmSSRF+/0GMICoLgro8Fgbol5MH4kL8f2bfhbSSNYMvl7zxkbSb8zAJ4bgftGyg8GqbpfyCrkeGWVcavtlIQuuoC4QYHR+j0BD56ip6DNJe+/pq0VwdKk9W3FJmIk3t2ivdALhrivBqkidXcXF328EjHMYFPww1mcKMf3Lq3ZXxQSYQqQViQ91fONYhYfQZopVGXzcg31e8bpxa2LnOq/6vi56Fs7v4qOH8TdHZ/INPWHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5cE1KZFj+6uY6gWuUnD3vW6Ia2GMS9aJ4sldP3ku9xE=;
 b=KfDqdxxUZK9gUfIo9LjzE0OwQ7dVrOMvdg3sDzBMtXO7YLWX8iIZq5NzSBInNfKVgpN8aLpJ3fll1utHfB/zyMcgG8zmdNHu20ZXXHxzMnZi+SSD9Dg2aWn5Kqi3/PHay2cY12BVMWpeKLJ2fQVk5fzHDaZRZ/YIsQyPzN23o4JXYqr6YSh969MlX01eHImzDPo/jBoJJGSb0KyUxB0OygRb42+arvlxzhQpa8RafiAfYev5vx2Im64O1DXDDUTA24Ba8ztpq4ZADT/5Ve7/O3IYsmIFZbTe/S7NGKCL76h6wlsQc3Qo4fCPLvOxBnmUKUzDPPe661QMmbx+Udsx/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5cE1KZFj+6uY6gWuUnD3vW6Ia2GMS9aJ4sldP3ku9xE=;
 b=EQlXQwzgpWRigSx4NhmVyfgm6ZUBE8NOyaybnPB/Ed5V0hKWLv+F0arSIuNd6YN8aRUEDI2YraYK6KkXDKMFb2X5ouyORaEjT2S56lMjgEiS3dYSxiLxdyqYkRHcxnaWF6meqrztVU2hXTreDTCP0bJj2V7cm4D/i19om4QmoHXvQjjufo8xUE9R/NzZ82SkRhQ0vVk3YZF2SdPTtfyaZqJml4OXwxNrZSTnIW3GAMMCUcntx1tM/A1YmSIHrNuT6KGosqjUCBienBCifMYaCgdD1MycVcLMcviAD8wl/XXDwJVlAMOFuIB7B2DvKPT4gko13jkNqj8m9V4KmGN/7g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5253.namprd12.prod.outlook.com (2603:10b6:208:30b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22; Thu, 25 Nov
 2021 17:30:41 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::5897:83b2:a704:7909]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::5897:83b2:a704:7909%8]) with mapi id 15.20.4734.023; Thu, 25 Nov 2021
 17:30:41 +0000
Date:   Thu, 25 Nov 2021 13:30:39 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 0/4] IB/mthca: Cleanup and optimize a few bitmap operation
Message-ID: <20211125173039.GA499138@nvidia.com>
References: <cover.1637785902.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1637785902.git.christophe.jaillet@wanadoo.fr>
X-ClientProxiedBy: BLAPR03CA0149.namprd03.prod.outlook.com
 (2603:10b6:208:32e::34) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by BLAPR03CA0149.namprd03.prod.outlook.com (2603:10b6:208:32e::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22 via Frontend Transport; Thu, 25 Nov 2021 17:30:40 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mqIZz-0025rO-Oc; Thu, 25 Nov 2021 13:30:39 -0400
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 85fdbf2a-05d9-497b-38b0-08d9b0394d70
X-MS-TrafficTypeDiagnostic: BL1PR12MB5253:
X-Microsoft-Antispam-PRVS: <BL1PR12MB525330496D08830DD69150FAC2629@BL1PR12MB5253.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uLtirlr8LGeHjHIwUFC39X4kpAC675vBfw9WRFBJhB6aJsCt8R/0oRj0IqEMlGWz00DPgqulExgOOmeVGi2M3FQorX6wDpM9/rUFB66gadKkPgQc4r24mlKx3aaRBJSJxr2aE5Z2QQUSImfduwDHYP919xAuRKpsd4Rok+c/AIlZvn8GtOlfmK+d67Lysk28d3BA9uu2kl3IXL5zP3dDDjG6uIX4RrC29GVOiLaTue0xUC90QRHHVV0si4TJQpKy5i7xchVBqA80KDAq2ltQfTq2mPex5jEBzEQd9zCSoHjY1BCwDeg58FyiDOe/vxuCkcp6Of4w7tKyDoh1RLzBlDiMWgGHXUXxDJxR6peBndlkbEVZGgdafzcLxniyG3kr/zLO02TALYLjsYg8hBVSLIKe7YI4pdhBkdxp4T8V5OsSWCDva7JBf+VOTo6hirBRxbEP1/WhvgiRxLffRNbNdtAE159MpYwlt47PYHK0gjGtfzCS1igeKY6Rmgg9/3MDet+fmGyqdbsY2t0GG/Xe9+j08BOwnDlwP1IGgHHxgNW1SZDMg55q81rfUPqas3gDTLbTNc9PTsU9pynORIlI6Ds7mfKTYdgk1Kz/3mby2fjxu74mofoQlzIf5oIcxWTaj0o+897aNoPz7HcRx47/KSwXIewQ7bYJuxEei9Lxl8FYSLecJBbaNvj4yvtwjxuTmM5SHBwR+iSJ2xcRvKgBxg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8676002)(8936002)(6916009)(83380400001)(26005)(426003)(508600001)(38100700002)(4326008)(1076003)(86362001)(9786002)(9746002)(186003)(316002)(5660300002)(66946007)(4744005)(66476007)(66556008)(36756003)(2906002)(33656002)(2616005)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gboozAO8T5TlXvOC3Wdj5iMQcm3YbP9iwEBtUl/1BK0J/9lFaAcq1ddgfraz?=
 =?us-ascii?Q?g+znbwtSbzgF1dogIcg7lmI8KaIk0tFOVfOyTVXdQAFYO2OQzzkczB7+iAPd?=
 =?us-ascii?Q?c6nCT6KEzN7JtKVPZUnRBTmCrp2N/Lp254Bo0nTylbOVz8kcbTGh1Y+FmUSp?=
 =?us-ascii?Q?5SnIZ//Hm6azdr+hUWqOY9HRcWdZnCHdeeu4HGGG4Sygh0wIoJe0IyM02TXp?=
 =?us-ascii?Q?wB6mIQ7+Bk8dUyKO498DD5Wm6BB7i6wvEFf7hwWMYG53DBaO+0kCBOy52SPW?=
 =?us-ascii?Q?0KZ0b3D56Gsakf2B+J/wWDpBdzC7crX8c3LCCRjkEhK7HR8pgKGfsVWlDxW8?=
 =?us-ascii?Q?DqXzvmdupNhjNT5FY3z+rGym3h0yJLXtpurNg34qBNIrHdoVgqY8PBbBLMJg?=
 =?us-ascii?Q?3RCAhOyx6A01PJBLsN73r3n6W9jlrjrbBq4QHxJ/j3piBVtFHcmvUPh+53Oi?=
 =?us-ascii?Q?n6sUo6pZ1sFlIVAx8/nU9K0V9iQB5BEq5rfd5T7Q6XZFZt71ZRhpk1fmgRgZ?=
 =?us-ascii?Q?0V51nj0HXKp9xEg9nzSSI+iXqiW2GfVCM/ktc0uLSzZVBJEVJfAiajxFO3Zi?=
 =?us-ascii?Q?HlEbiHRrwgjkF462krZVXX2WgfjbFycsTKpHX/lOhau5ofMzgNwTaHJfkTZC?=
 =?us-ascii?Q?iXNFzyq1VCk4IEwGjZhCWZ3RylP/ocbSJzTkdoQtt77J3RsIiwWKw5EBGQ03?=
 =?us-ascii?Q?5JlgcT0ilOYmKXomCzVdL8mw+UeCjdTJ3M5HkGS/P472AVwZPiQ/jIbhyVka?=
 =?us-ascii?Q?TV4SZmT2msk50s9jbEAkcoi24KEpzcDIN0uizx5UX3hWyKR+599hVH7BNtJ6?=
 =?us-ascii?Q?8xXjqwGlZiZQsaYazFZtXAm7M4IXZ4EE6VdDG4rFOkqYPlSHp9tlMteh4UvZ?=
 =?us-ascii?Q?m/gSMxUl09T/BguUMSvF781GOZ3feiwkWAf2aeWiaQvrtiZKI3rovxiQPZur?=
 =?us-ascii?Q?zI0c3nFOQsaWm4E+stTyYOaw0sJIW1ou0hrwh8d0tD6nUKb2I7DiZpsMd1Ia?=
 =?us-ascii?Q?uDvYvaF1i8viyd0Rz6XglJiZ6pkXTJoao73VNDAAdl1zPISjGaUFGziKx6Pe?=
 =?us-ascii?Q?7rJycsl8IxJCzU7IpPCnrqhYBLtMVgju784jRxaMCzhLFWyDJRkLT1gZIW6J?=
 =?us-ascii?Q?TppS5oIKPbVa0tM0eD9I9Zc+qyqLPt34aOATvwQsmYU/Y959+eOIcCSIyzi2?=
 =?us-ascii?Q?29dB4lNnb9rVqk/wOB/rE92+KgS1CGMM9nQOaYsPz1l1HAujnqFZ9creSTFD?=
 =?us-ascii?Q?NcZeSE5v/BTA3w+cSeovY00FxeDfzIVJlxdLPsZA+iWXj1eant5/Tg1/0yLV?=
 =?us-ascii?Q?bi5v2OtZK9Cb4hHEnFGIEfN5Ebof3Rn+ASqKl/qTVHBZ0P5p/Y+1IxPkAksK?=
 =?us-ascii?Q?hBXxCCWE+ZlsKNWSExXlNnU/H9qWuiwgOYkd0gfWgT+D6ILoUlCEWQ9G0pvm?=
 =?us-ascii?Q?bf7VCrDF+Abz0ZP8Gr851AkA12qBj/TJQVcibEKCZHuy+1UlVCwJKAHX2gYk?=
 =?us-ascii?Q?Fd7YmZz9vRpntWkT3tHNwNkJ4fA6v6CKSen05Wkr6Dv+FPQxbs17cwSKfml1?=
 =?us-ascii?Q?/9/6bvlxdMwJspSCCh4=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85fdbf2a-05d9-497b-38b0-08d9b0394d70
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2021 17:30:40.9505
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DTaVAtOiNXcISBE4Y6z252ftD0dhGjbYDG6pNhAZ0lG3KTMNTN9/IGJzjnu39auJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5253
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Nov 24, 2021 at 09:40:09PM +0100, Christophe JAILLET wrote:
> Patch 1 and 2 are just cleanups that uses 'bitmap_zalloc()' and 'bitmap_set()'
> instead of hand-writing these functions.
> 
> Patch 3 and 4 are more questionable. They replace calls to '[set|clear]_bit()'
> by their non-atomic '__[set|clear]_bit()' alternatives.
> In both files, it looks safe to do so because accesses to the corresponding
> bitmaps are protected by spinlocks.
> However, these patches are compile tested only. It not sure it worth changing the
> code just for saving a few atomic operations.
> So review, test and apply only if it make sense.
> 
> Christophe JAILLET (4):
>   IB/mthca: Use bitmap_zalloc() when applicable
>   IB/mthca: Use bitmap_set() when applicable
>   IB/mthca: Use non-atomic bitmap functions when possible in
>     'mthca_allocator.c'
>   IB/mthca: Use non-atomic bitmap functions when possible in
>     'mthca_mr.c'

Applied to for-next, thanks

Jason
