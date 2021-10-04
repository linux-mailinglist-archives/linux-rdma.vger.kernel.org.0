Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 562AE421A66
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Oct 2021 01:00:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233174AbhJDXBz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 4 Oct 2021 19:01:55 -0400
Received: from mail-mw2nam12on2068.outbound.protection.outlook.com ([40.107.244.68]:2272
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231575AbhJDXBz (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 4 Oct 2021 19:01:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AHleuXmMb5rIfjlx0i9wzai1EMjXPEq6EEjfZvPBnh+KrXqtXPj2agGMShqxPXS7fBbKeMgnzsw7bI1Kcvo/PWqhnUObszEdwjltu7E3k0ExHRX8tpg1yjpTzVjPHBLQtqUIXdQDfdVPvDkHl2nzv3yMCM+gPr+2hCiFEQIJZOpcwesADMb2cAjSCYyRG7VdR9hWFZwPPkr41ZskaJsZHo8EhQa1jUGDH+YM8xwuSouR02OqkTaVdFjPOVScWz88VZQwpA0mBUrhV2IQAZe1G1u0RAo3OZuT4VCUREu7ija4eXzYgMW+NUeEwFkF+HqgTAvJG0Q87prPF/D/2b4DLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bGE4MZcjBhjVWPTVvckXC2euwq85nDYtugetyNjhZTg=;
 b=hiunBS9P3AzeiWGdkGW1yS9ctTq9oWYJPoCaElimQahooVuUSbl4499G4SuEAYIY4BYVpc4K1VgudE5NpKua4ZYgUcLm9oA8VEuf8To49/vJ1wD59KbgQ1l9D0rfSBvTIKi8GQ7T1hQxTEhjYs+ytJaEhWQ4K+Oe63jspD7vwxIr1Ex7VZhm6zyMNF4qkpnddPah5bSP9KgH6L6BuANCbsOnm+YU5kmW83alJU9Lc+3O2tW7vZpghpUn1S4wj+J2TmqhUi1txZQ7tSMD86HbSKBtJ22hL+SPGvbxrT/ORiO48PMHhYuBABVAbJwWul10HmJFUf+VWRR9bFQwe4cFhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bGE4MZcjBhjVWPTVvckXC2euwq85nDYtugetyNjhZTg=;
 b=nruKXEiWWyRUH9IDZwCnZIDg+Qt5b8LCST7GhzPKOLXeXv3yrub0vzTP8Q8n/4ozn4iT7xf7DrCDmXOjVDXIRHrGr0zxPtGhg32Q8ZGxtW5daONDP3ZSRkOkgrVtygBf0V1yxU7WqiV2zjZuhu35jm+rGMF0jaeUWR7SxldphXutuJtnhMWVbprQQuoH/4jCpYn/ee9d5tKB7fKrDjuQm4Z0+dK7k4OUkIED9ALiLArhx6hpn/M08+wcqJG8dy+4h8pil4UhHa5td3Qq7eiWeyCON0dzkiztcU1WEG3IiOiJkMyQQGVlBtBcbwvnchCPp8mZkPm4SfcXiNbmvM3OYQ==
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5110.namprd12.prod.outlook.com (2603:10b6:208:312::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.19; Mon, 4 Oct
 2021 23:00:04 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95%8]) with mapi id 15.20.4566.022; Mon, 4 Oct 2021
 23:00:04 +0000
Date:   Mon, 4 Oct 2021 20:00:03 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Aharon Landau <aharonl@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next] RDMA/mlx5: Avoid taking MRs from larger MR
 cache pools when a pool is empty
Message-ID: <20211004230003.GA2602856@nvidia.com>
References: <71af2770c737b936f7b10f457f0ef303ffcf7ad7.1632644527.git.leonro@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <71af2770c737b936f7b10f457f0ef303ffcf7ad7.1632644527.git.leonro@nvidia.com>
X-ClientProxiedBy: BLAPR03CA0135.namprd03.prod.outlook.com
 (2603:10b6:208:32e::20) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by BLAPR03CA0135.namprd03.prod.outlook.com (2603:10b6:208:32e::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15 via Frontend Transport; Mon, 4 Oct 2021 23:00:04 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mXWwF-00Av9b-Bl; Mon, 04 Oct 2021 20:00:03 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 20aa6b0c-bd3f-4c65-4f85-08d9878ab3ce
X-MS-TrafficTypeDiagnostic: BL1PR12MB5110:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB5110FB9924F0D3049EF20F10C2AE9@BL1PR12MB5110.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: glap9i/q9eoVmDK4zFQ5TMU4+MV1UI9zgrKca3KslXs10cqf7KYQERt5/w1N7aOEXDjIX27KUb6y0L6BgHf8rX4YoNdprjPT4G9eiVN/1h6SkIk6sujQjTBareDN3d5sJVphjTVG7a0odTwpv/efze/ORXnYdmFNVKHX/OmIbjC6Od1+rtIYLJfjPQIPLi5F+Z3pnDRtkyjEVkZ9rUeIh37iz0D5WzQ86TBbbVjFpy6I5NUgx22jLb4V5BtbSkjBYBgOGYRg36Asm7i9UkDDfWQ9u0Z17vhSxRUYCGMMH3JV1CUt5jLi4P2dOCKr0tAk+tnjmDOl4N0YUB0yt0PgYcUdNBWjGn5yjGN+NFG1ps4VzotbQ1nLIOnuUvZFNJZngQ/NlF9IYwwDuIrf+EyCsIxhvwhsxdkzrKJCK2P37hVGrt+RVUMhkxws8NW9JOm3GLzxv/RY3wUpXZROK+tiDiMC7Va8UzOmMsDUlNFapUOpASaUIv4FEXK3lvaH66k6TkE3PfwS0P7/txXW7wBD9RRsdD+CKZktp3JSAg+szDxt/nLhUUpQdlC1ftuR9iiL+9jp30YaRpSCaDYXfOB6Z7vAGYHYvIhOGbdcO/GVhsMQT3jKbXLVBkPvjv7LCUNuWgoiMI2It3RATPsuPLAPlw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(316002)(508600001)(66476007)(66556008)(6916009)(54906003)(38100700002)(26005)(186003)(2906002)(2616005)(426003)(4326008)(8936002)(5660300002)(66946007)(8676002)(83380400001)(36756003)(1076003)(33656002)(9786002)(86362001)(9746002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DSQL1rDKUdZVw+OJrHFrPT+UUbHcH1hiESKSw2Ca9eDuuDtFvWh2pFW+qXS4?=
 =?us-ascii?Q?d1Rt4uP05v0JqGYoZgTBTDp0gQQRu06CRREn25sDkm+O7hZQxwr4kbUhHGm1?=
 =?us-ascii?Q?10CraNE7k2UXM6oN9ZBP5rv/l5MFQUGpq75xkv86Xo/E9aISpsrlulF4uYXs?=
 =?us-ascii?Q?K0igvAr++KmFyTGI42Izb2qpNhM2UWZdJDT6IG3uswKBP0gfVRBq/tGCj1E4?=
 =?us-ascii?Q?SgqPYiwCz0JOEr+tYKTa58mSpk7tXfQ4bL5IIVtknS0fs2ia2xQPoJrhwJiF?=
 =?us-ascii?Q?8k9tPZL04m+gBctXwe8vBt1AqDSi8JfD19YsSHjhhJC3rY/GNzKIytLAPRgJ?=
 =?us-ascii?Q?52S799cZ50VskPcxafuu0Wr8MLxDRUHd+vSN9Z//pF3RzqoK2NMsYGgljOF6?=
 =?us-ascii?Q?t05LbTLEkxmrD3CC7U3L2qMj2SVK8a1XsR6JhAGNHPp3pACEknw/rdYCEtQB?=
 =?us-ascii?Q?c9VVGIbbw4uDHj4zO1KI6vGU4VS9xG/2FzjQm1YoLIWW6sB9f8z8stcBHzlu?=
 =?us-ascii?Q?KLQfNG31aDJOUtShP+S9ztbYRpXDwybHHQOJ2N1Nb/XS0bO0gU6k6hNSTPI8?=
 =?us-ascii?Q?o52ojF9uUJzpLOo5zqmHkxEvRtRAfqjaHt0ajH5p1tFS5ykJ4Iqi6qm0WIfb?=
 =?us-ascii?Q?GNrwdXONWFNokkli8X5tfP06XMroM92hz2sMqcloxl6Zg9ZlkIKH9k1edTxZ?=
 =?us-ascii?Q?D3gwcx5oab7BXteIP03qU3ejVOWiU5VOFTVzHnNwnklQzIvx2Z8vZHO+qS16?=
 =?us-ascii?Q?18UAp+W+unMYKLPX5F8lwvdLQuMsT/Y0l0PUZ52ZlVrfza6MIdc46kCIiW/L?=
 =?us-ascii?Q?R4e4VBpzmCNlSgQghiSJmEhsMdogcVXzoMYeZZ2CkQdbdftIffd8HRstn4t1?=
 =?us-ascii?Q?q5Uqip0oQtQEBTEO+sX+Px+AOJZkNVhphMMke7ymjU+dfBdpkfZbNPIwkunI?=
 =?us-ascii?Q?LgGDCuzKvKeJvUszzmBi5MjwL1xmQIoFyx+ch9Gf3LPy1nphFreplM/uSJn9?=
 =?us-ascii?Q?BH0dlyt2AmT0yZyRwCNeVQXL/0MmAOcO0BTbPpSQSlsPXJS4P4SlUNxeu8Cq?=
 =?us-ascii?Q?6b41VNNgVOnF/DLqcHk5T3HkJJhyvQ1gZ/8Yan8t5r1wuq0LXa7RVK3+UdND?=
 =?us-ascii?Q?6H2WvURnwrP87dYBM8flFGCUN6hc11NI/uSZIwbsbcN0HPYjf/CJCWIcccwA?=
 =?us-ascii?Q?fNlmbEMGrzfJNhl108+LEgtOjpOSIiByFoQCmjQBY6MP4keIvqe/nfikjQyM?=
 =?us-ascii?Q?qUe4XumQyZXdUGvwtXaOZ3/OgqSN6yGuvqF0QKJ6CrQBPZXQ07ghDlCBF8Mu?=
 =?us-ascii?Q?w4huuAFi8XvW1YCJaq+CSZ527wECbX3/YqcRZQkIPf9W+g=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20aa6b0c-bd3f-4c65-4f85-08d9878ab3ce
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2021 23:00:04.3416
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FJ75JHc/+NEbgE++aa76FJxq3iBPujTcDJRX926uxq/VXW5PrCBE+Vpfs5b27Gee
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5110
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Sep 26, 2021 at 11:31:43AM +0300, Leon Romanovsky wrote:
> From: Aharon Landau <aharonl@nvidia.com>
> 
> Currently, if a cache entry is empty, the driver will try to take MRs
> from larger cache entries. This behavior consumes a lot of memory.
> In addition, when searching for an mkey in an entry, the entry is locked.
> When using a multithreaded application with the old behavior, the threads
> will block each other more often, which can hurt performance as can be
> seen in the table below.
> 
> Therefore, avoid it by creating a new mkey when the requested cache entry
> is empty.
> 
> The test was performed on a machine with
> Intel(R) Xeon(R) CPU E5-2699 v4 @ 2.20GHz 44 cores.
> 
> Here are the time measures for allocating MRs of 2^6 pages. The search in
> the cache started from entry 6.
> 
> +------------+---------------------+---------------------+
> |            |     Old behavior    |     New behavior    |
> |            +----------+----------+----------+----------+
> |            | 1 thread | 5 thread | 1 thread | 5 thread |
> +============+==========+==========+==========+==========+
> |  1,000 MRs |   14 ms  |   30 ms  |   14 ms  |   80 ms  |
> +------------+----------+----------+----------+----------+
> | 10,000 MRs |  135 ms  |   6 sec  |  173 ms  |  880 ms  |
> +------------+----------+----------+----------+----------+
> |100,000 MRs | 11.2 sec |  57 sec  | 1.74 sec |  8.8 sec |
> +------------+----------+----------+----------+----------+
> 
> Signed-off-by: Aharon Landau <aharonl@nvidia.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/infiniband/hw/mlx5/mr.c | 26 +++++++++-----------------
>  1 file changed, 9 insertions(+), 17 deletions(-)

I'm surprised the cost is so high, I assume this has alot to do with
repeated calls to queue_adjust_cache_locked()? Maybe this should be
further investigated?

Anyhow, applied to for-next, thanks

Jason
