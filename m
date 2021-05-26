Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9394B3920DE
	for <lists+linux-rdma@lfdr.de>; Wed, 26 May 2021 21:30:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234168AbhEZTcD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 26 May 2021 15:32:03 -0400
Received: from mail-dm6nam11on2070.outbound.protection.outlook.com ([40.107.223.70]:35521
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232702AbhEZTb4 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 26 May 2021 15:31:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FrDgnmEjSMvbO53h+0QsS1nN/KpfwQnSrczrmExJ7OMS979BKg10XZhpJrev8ToIiigDn4V/JzS3SXdvwwfkqi06nRtXygZxnVWwMwIqijjAQYFXJ526bfs9hZrZmzi5Jjhsij+1/6Em26hdLWQjHIhtYdsk/uXfRJiWpwhHuqV7hoVXk5iHZAJdTIaXUMLckcR5/rku7dDWoR4g3kc79RmZIUrrvnPTOJUMvhbp+5qCHGuouWzG4HmgGjDguu4xFMs4LkImTvWN8lk8bQZTW/NAy7IfO1cHyHgKIfyf6MmTFB2IzpdABwngfFHUSh/qAlUfWuu8u+xaNRiypxvsCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XTv99n5fnueYia5wEho/hJc1XX40fwZ3PjN+vMPsjjU=;
 b=g6/OYmgYITEOmhINTGhARcHMJu47e1LiH9XXnvW/UlmTBqHKi8OgIQs8VKW8R5YVCFIdokQgMkcfVZx8IpxOV8dap0TF8mRVjLXkLFy2Yv/610c2KVhcnIqsb/T3JRxZx3i9kDtYmkHAAQL4VHzi3voNOVyKmYZilJX5cZXeKCnDLyoqnG6b5QdiUKUqUzBrfFv5BzKy/W6ytn/FqmUDmYmPZf2baePI/fWAPDdRbHSWo9iPYBcxBhXUaZRK67Y09swCjTRMdg5rTbkbACeTGCqIV88Sz927SUxFzG2mZaGNNfiLzkb/CpunLwBgb65oGlaNH2BvUL4VTR91MjW+LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XTv99n5fnueYia5wEho/hJc1XX40fwZ3PjN+vMPsjjU=;
 b=kmM5Kxf9EsxWpGwig25lavDpUNdmEwXIpqK4LPixOUN36J3B7mP0uZUGdBI4CfJj8SQn4xkIJHVpGD8ctA/6RaxfMfzb7DZw6PQ5d2iLzPXjuXPHBsKJUbtwwPvxLyiKP6rr5AjLNscMtV5S0mf4WoZE4VoNk3nzZN86pNw6R6U3u0Tpi6976rm8lKAyxiVkfk5f2tGfqbUs6bDy4xv9Pz+OnZ0xdk+H0L1zGMpr+g76JNmiPVinlQcdc72qkyQVtvQVpjjJjntLMVuur3SjqtNkOTBtDoa2fF3ni7WIxiIDJLE1F1h1Iwia07uGgvLYeBlx1N4/12JDh9pNxeelnA==
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5336.namprd12.prod.outlook.com (2603:10b6:208:314::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.26; Wed, 26 May
 2021 19:30:23 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%7]) with mapi id 15.20.4173.020; Wed, 26 May 2021
 19:30:23 +0000
Date:   Wed, 26 May 2021 16:30:21 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Avihai Horon <avihaih@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Tom Talpey <tom@talpey.com>,
        Santosh Shilimkar <santosh.shilimkar@oracle.com>,
        Chuck Lever III <chuck.lever@oracle.com>,
        Keith Busch <kbusch@kernel.org>,
        David Laight <David.Laight@ACULAB.COM>,
        Honggang LI <honli@redhat.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: Re: [PATCH rdma-next v1 0/2] Enable relaxed ordering for ULPs
Message-ID: <20210526193021.GA3644646@nvidia.com>
References: <cover.1621505111.git.leonro@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1621505111.git.leonro@nvidia.com>
X-Originating-IP: [206.223.160.26]
X-ClientProxiedBy: YTXPR0101CA0043.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::20) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by YTXPR0101CA0043.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.27 via Frontend Transport; Wed, 26 May 2021 19:30:23 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1llzET-00FIGw-8k; Wed, 26 May 2021 16:30:21 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 359db54a-3bdd-439d-9609-08d9207cb4da
X-MS-TrafficTypeDiagnostic: BL1PR12MB5336:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB53365506DA67F189A03A7994C2249@BL1PR12MB5336.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3pakHshVddZX4tjlnKNBEoacCURS7IKUoinl3mS5875OD5L1wmp4xNw65ftILMgZH19WuoOR/0SUZloKJ9raoocMNc1nbULSAzgT0fegC6GrLeucqUUpdtZX53U6oOuEFvYtbg6eul95jbIs52CCPqkqPhZpLiXmyCznisKYP57fv/83DQW9SmzmFvyOT+rNgFb1qfbwR4v2S5kglK35f41hkBaQdofCJx7YMC1oT3pU19ZlNKbB6PAtWlgvf3a/XnRdMAYeE2WWZ7r0nULmY5gv9qMXxszFN1biHVGJV6R3mNhw9ekblWblJpjYfKT/HMyHsls0P2hyUoWeILF49CrWc28vZ8gr7rOp7+ZJ2bw677xWVq70hc25uZ9oCXAotkMo2wKRYPSIE6edm5dIFuJkForqyQnV71xQ0ieSkvyG7wA3nk9x2NvWmVb24Zw/6ii8YHeH0gCyjbHJ0IZKOGuZcnN3j7Q9b4ns8taA77d3tfD+MHf5pto/2X64DXYm5DRb7f7KC1OW6R/hEHbJAEiAD+gNbN0aoJgpehn/m1lLY0TZxWwbHG2uyYVXnmlP4OVlZ23rhYJli76i28wpfJfWNHrqxpnrmilLFoxdk1bKZxN/C51nwpJyiSN5fHyeflOHh5fNS4/W8bFERJL73oEG2zwEk9L/VIEj+OpJD5wtvuIN46I2QERKHXS66A9ONz2Rmob/S+YUHk+HYDdN7ufMRdkMCp92VWIHSIuHeV4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(39860400002)(376002)(366004)(136003)(19627235002)(7416002)(38100700002)(8936002)(107886003)(186003)(66476007)(2616005)(426003)(86362001)(9786002)(66556008)(1076003)(26005)(9746002)(36756003)(478600001)(6916009)(4326008)(966005)(54906003)(66946007)(33656002)(316002)(83380400001)(5660300002)(2906002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?D7woViZrne2UFRWLvWP5aLJa/H/43BF0X2xZHz5cCloIGgAoyh/6S0qbxxMX?=
 =?us-ascii?Q?6M8cKh0ftg34Lmuzv55ld5ik7NudqnOX+iIUdpO6OnRu9xQvTeL/eP0UX0zU?=
 =?us-ascii?Q?eK5vWmDYjEBO7zRxIgA4di8PqKZb9DhICLdKGXyRJ3QBvfRNmgLB5W7G9ODz?=
 =?us-ascii?Q?h1+8gOtuhFzK+YeIGnjBIIGdO/x8qxMmrLHXfsNr6Lx0u95/MJTmO3GI23Nb?=
 =?us-ascii?Q?wlYWdPps3dd/lUetZh7ZqRjrn8T3xIJp26x4fboL5DUcXK+9sV9zNkrKHW6V?=
 =?us-ascii?Q?J8NLFyXTx+UxiybQconJLCoPpXngkJtGM491R3MamsXe6QeK1wypwfT6ZOiV?=
 =?us-ascii?Q?6I4wvfgu7N3cJ16FXe4vWfkhlQz986U9XVKXX3jtWpCJXyFWYcbfXwVVxryC?=
 =?us-ascii?Q?iPA2V6JaXvdyLjYBbWgI3Fy6OddeTlo5XwRF5wKwdd8coISli/Zzbk+NpsWu?=
 =?us-ascii?Q?mBd6bAHJkf/bwF+cEBLtA8V568E5+Dj8h6H9l1JiO1pfrPJDMnABhgVyvjT2?=
 =?us-ascii?Q?ky5AtK244ax3CClhmYn4YRmpLjUVVxkLcz1GZumco356qbHsWGro5TTKIIQq?=
 =?us-ascii?Q?8ZCJEhj2fiKtjEcNT9cYsYnwVlGzdEfi49LNBtZp+HymAJxAJ7H/gmieGAYg?=
 =?us-ascii?Q?ayUepBt1/jaD/YSGzbDw7S34eIfakXuA0MsOnrG8vrLdd6AYXqqZdgLZPNnf?=
 =?us-ascii?Q?n6iW57RIvCX95qTHLHlF/TNHggw2b3mbbZiyosmQAeTRza4peNwsMxGzTQ8b?=
 =?us-ascii?Q?6ETRUTEOWJR3Drt6WfSRTAiuBz7YcSVUDWb85jKB7rBmUXvra1y8XhL58m46?=
 =?us-ascii?Q?vFBefaszYb+bowaqmQoT+2JVtxtqNoERB2KPSdAPPuSKGvwFjRbOs//HSC+z?=
 =?us-ascii?Q?x6GNKE423U7j0G58jmWpyuyqQnmuL/M1yQuddVZKfyPFpt1p5LxP9AiVMMzc?=
 =?us-ascii?Q?uoEdVz5312bB0JJWrQEwlbECO2fT29E0wV/m+h0tyN8TTMqGD2EFC+n91odx?=
 =?us-ascii?Q?/J6qDyR6ZFwTqx2S9oJuH0X6NyzOFmSDBJrkxHkEltxnMD8NN8TDXxT/WskR?=
 =?us-ascii?Q?sP0BHFAymIoSdizy9Ll8iSxJcN54jmKWPtOL30540FXWTvfsFjzoRGxGQgvh?=
 =?us-ascii?Q?guWYS/dB2v04A3lH149+IevAMAqPr36ceoy3AfUwAo2S21L61E3yRap+55Rw?=
 =?us-ascii?Q?2HtF3/keoG3J/ryS8V8uoSo9P2tC9pZqpdH2W0vWHcECFTf+6HZagH1FPuid?=
 =?us-ascii?Q?5dX6KiBXIT6fHXaodVA7MK5qwNvVPOTLiFCeO8GOnd1eR/u46snR1cES0lkQ?=
 =?us-ascii?Q?um/AbNESDl7FPj4HR8qY4z2j?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 359db54a-3bdd-439d-9609-08d9207cb4da
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2021 19:30:23.3635
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kjnChh9MLCgnhmcFUGPqMg2C1L9T8tE19Bkzbzg6w9R7WchJoMP/Nd78/PhXZSTn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5336
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, May 20, 2021 at 01:13:34PM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Changelog:
> v1:
>  * Enabled by default RO in IB/core instead of changing all users
> v0: https://lore.kernel.org/lkml/20210405052404.213889-1-leon@kernel.org
> 
> >From Avihai,
> 
> Relaxed Ordering is a PCIe mechanism that relaxes the strict ordering
> imposed on PCI transactions, and thus, can improve performance for
> applications that can handle this lack of strict ordering.
> 
> Currently, relaxed ordering can be set only by user space applications
> for user MRs. Not all user space applications support relaxed ordering
> and for this reason it was added as an optional capability that is
> disabled by default. This behavior is not changed as part of this series,
> and relaxed ordering remains disabled by default for user space.
> 
> On the other hand, kernel users should universally support relaxed
> ordering, as they are designed to read data only after observing the CQE
> and use the DMA API correctly. There are a few platforms with broken
> relaxed ordering implementation, but for them relaxed ordering is expected
> to be turned off globally in the PCI level. In addition, note that this is
> not the first use of relaxed ordering. Relaxed ordering has been enabled
> by default in mlx5 ethernet driver, and user space apps use it as well for
> quite a while.
> 
> Hence, this series enabled relaxed ordering by default for kernel users so
> they can benefit as well from the performance improvements.
> 
> The following test results show the performance improvement achieved
> with relaxed ordering. The test was performed by running FIO traffic
> between a NVIDIA DGX A100 (ConnectX-6 NICs and AMD CPUs) and a NVMe
> storage fabric, using NFSoRDMA:
> 
> Without Relaxed Ordering:
> READ: bw=16.5GiB/s (17.7GB/s), 16.5GiB/s-16.5GiB/s (17.7GB/s-17.7GB/s),
> io=1987GiB (2133GB), run=120422-120422msec
> 
> With relaxed ordering:
> READ: bw=72.9GiB/s (78.2GB/s), 72.9GiB/s-72.9GiB/s (78.2GB/s-78.2GB/s),
> io=2367GiB (2542GB), run=32492-32492msec
> 
> The series has been tested over NVMe, iSER, SRP and NFS with ConnectX-6
> NIC. The tests included FIO verify and stress tests, and various
> resiliency tests (shutting down NIC port in the middle of traffic,
> rebooting the target in the middle of traffic etc.).

There was such a big discussion on the last version I wondered why
this was so quiet. I guess because the cc list isn't very big..

Adding the people from the original thread, here is the patches:

https://lore.kernel.org/linux-rdma/cover.1621505111.git.leonro@nvidia.com/

I think this is the general approach that was asked for, to special case
uverbs and turn it on in kernel universally
 
Jason
