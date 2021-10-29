Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11F9943FF35
	for <lists+linux-rdma@lfdr.de>; Fri, 29 Oct 2021 17:14:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbhJ2PQh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 29 Oct 2021 11:16:37 -0400
Received: from mail-mw2nam10on2071.outbound.protection.outlook.com ([40.107.94.71]:21121
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229610AbhJ2PQg (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 29 Oct 2021 11:16:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ikMKniMtmsswwS9hftVJn6Bf9t398fKgymS9N+nnYkB7OJYuKy68RLAAu2OUVc1bb4HHTK9QiuY5jYKrA3ecfb4koFDe0sgc8eoMCIjDh9DGUnxtP6gOyxTvNg28Y4i17B585DqL/TTHS6ppnMq4F7WM23XXwdvE9/5fwTz5H8uhecLYnUhFfVRi0JTfYdrgTmRUDXTADPq4wnkOZJxxQZh7bBixk0hu+nfw/0GhnQJvvkQoSL9bo6Q/3LPHzjB+uksCGGYGeIiKyyjXBvWVaTR8zZ5YZNyPACfiH4toq7x+Bjt/Rcywn90Fif/0BYeRT6nKnToqB7mVr+iHB6wI6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y/dZ9iZ4M0O+Sp7/v4BVQ6Gx2IXj3M3sYRfxGKO3kxA=;
 b=m3JL7xXLLZTuGDncXt6xSKhpxwqk+uZvsvbSN5SkbvYOPWLUBHiBC4l8YV5weloWmZqYoFsvyETtTrVA269n83gtahsIyMOyggE2xoiujQOcIOFHeN3rG+79XymY01aPV6WxuxHhfEeTlpBxVBII3HUpdvtoYUSuuJ4IrNTGfKq6Jjy9jZwfBfxxOqG38DWZM0UMpmA2EGvBpb9aWaCyBSKNaSo2W1xfqg7iEB9vlzBnyVPryZ40itMI5lAT5QiHBVqaVRGF30HzYOJ6lI4okt25VsWG+o2sNviNRAh6rx1KCJ683xdEx0Dff4M5o0GISu7UKmrjEr22aehkaumVNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y/dZ9iZ4M0O+Sp7/v4BVQ6Gx2IXj3M3sYRfxGKO3kxA=;
 b=k9d430lUhb7EMM5a3gAmHbpFjBdHIZiLGpitf+WjBvdyyYZ3s3zktl6+LzODzT8aI4vTOVDar+w0xYTtxSGCFolQy4v021R8uz0CMkmJF4RkTILa+ajWcYhFNyr4+iZ0ICN21Di0LSxiuQXdaziS9SquA8DE6i+SL4W6T1AGsbycFdRONC3hzPAn2r4Hf4krd6QgEHlAMP81bWkhsoRdHQJYnxYdIjOcbqLQ0Y4iHOcNeF7z/Usl46bMM5IX3w5G0NzJ9J/eUahFajueOJOV23ZOu/rJWoFx8WdDXxFaaK1BHCHyClhCbPB+zPvJjQ+DungMzaXik14Byrox5P+X6Q==
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5175.namprd12.prod.outlook.com (2603:10b6:208:318::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14; Fri, 29 Oct
 2021 15:14:06 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95%8]) with mapi id 15.20.4649.015; Fri, 29 Oct 2021
 15:14:06 +0000
Date:   Fri, 29 Oct 2021 12:14:05 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Kamal Heib <kamalheib1@gmail.com>
Cc:     linux-rdma@vger.kernel.org,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        Aharon Landau <aharonl@nvidia.com>
Subject: Re: [PATCH for-next] RDMA/bnxt_re: Fix kernel panic when trying to
 access bnxt_re_stat_descs
Message-ID: <20211029151405.GA842787@nvidia.com>
References: <20211027205448.127821-1-kamalheib1@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211027205448.127821-1-kamalheib1@gmail.com>
X-ClientProxiedBy: BL1PR13CA0305.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::10) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by BL1PR13CA0305.namprd13.prod.outlook.com (2603:10b6:208:2c1::10) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.4 via Frontend Transport; Fri, 29 Oct 2021 15:14:06 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mgTa1-003XG8-Eh; Fri, 29 Oct 2021 12:14:05 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b57dbd53-7723-48b6-414b-08d99aeec009
X-MS-TrafficTypeDiagnostic: BL1PR12MB5175:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5175D2B08B99A581FE517E28C2879@BL1PR12MB5175.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1186;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PqXMbp8jyPpHpY54Jlpq/PdAUTzGAKOJvnHEQOig2BA0/1gJGlLPq027/Hw5rYK0qKGtzr3MCdHog1XC3FMfYwz+B/4AEIV93/dVptH+XATOCsoiSPlCw9rFWofq5i30u7DweE8R4m+LINGA5Ku0KfiF5bGeKf9dBIL5SYxmnssSS/ng+j8fy2BrRNYzldUM9QhZMIbdp4yHJhrrF5wqL/l+BipmmKk539DX3Sdl5lop/SHxmO5j5byW2+9tj+TBZ4Rz5s3gRIbr0C7J1onab1NtRl1FureA9ip83ygU55M9cf25u9uBKVI1YPsah15gsMHCC3Rl6iO+eEhPKyLEuRGDhgXeSgVqEDVnVUWfeL2b+citU4nKbLp5OYEXKDGf3EwjazQYKb4emsV8TS8REmOzY8s/lnepweld+pvFWauAONrcGOhAssWtWyV5DLsHFY4iT4oE9kxspnbEMlS1Fv/wo3nLEU+Ho/ToYDodE0Xrxzk8DvWGblxhXaj6du6jw+FXQqkWyBXZ9qsfQ6SThzuxV4AgnMgEMSURdvgV2+KF2MPzOV4iMm35fP6koyb0iloKKorVATCubRtDiBd+nozFbFQ/pX9Ht5q4L4qbqV0cEmOb7q919wWWDYnJl856QpYh8IDYXmU7pcRSo3VuPk/vU8p2J+90t4XtHr3ejV96KYUxzDqV8kXcRPkmrItR7VtSCe9fhsZFmOcyvn35wA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(36756003)(66556008)(45080400002)(1076003)(38100700002)(107886003)(316002)(54906003)(508600001)(66476007)(8936002)(66946007)(33656002)(83380400001)(2616005)(4326008)(5660300002)(2906002)(8676002)(426003)(9786002)(9746002)(186003)(86362001)(6916009)(26005)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0n+1Mugwqx1OJr3xaJj4UFJEFW7E5wFCsLOOFEegocptQFo6gJrOQkmBrIcD?=
 =?us-ascii?Q?+8wvhqv/unMFiNqVG9jmxT/tpN9Zhvev1nbSkGCMdgQ58khlPT72PoNFf830?=
 =?us-ascii?Q?65yx9kvRGY6hCDesJGOCqd5r8A9GJVS4moNPSKq1RQX+AUff3t9DYaX249DS?=
 =?us-ascii?Q?/GseYqpUfklL9O8ce0YpUoIaPNTHKi3Iqjg8hwil5NSv/oFjVvQm+nYAyV6Y?=
 =?us-ascii?Q?QgJ+yqJnyvoF5F2oMoNS6zn4ifndLlWWfk3C6taetPJ1Sg4QgdgWbKUq5WKn?=
 =?us-ascii?Q?iXigqNnSarh5dzckUJAKtctH9EoNV4TgTsv9e7uS0sXJWfgOvq/mhWcxsRLU?=
 =?us-ascii?Q?Bsr1yWGbW438dXXO0LNsk8BeFEePiuR+1AxKrnrh+Hhp9WJcU8Zi12QrH2Bb?=
 =?us-ascii?Q?j1MJjFS98dMPKbpguq5+LYEFvuz4vBqQZkhZgI04c9zLcUM5biTIkRFbigCW?=
 =?us-ascii?Q?jlhg3WkwfEGJQJ7buvBDSk73zT7YWD2izjAHPRydqZ9XNZ5S9eFPQgDU2jFg?=
 =?us-ascii?Q?7XcF7K7jjRAyILLhXsnW8GCTsh/WGRTnHC4u8g3etAz2p9pe3QmmRcA2wfUl?=
 =?us-ascii?Q?jSHnLhrm66w1LO2D+/oov1ISqNuMwiV+6C0W8FSUWhBnPpOGMwqnE/iTpfgY?=
 =?us-ascii?Q?aLlNSf3bu0t1MbyBj5j9tniDEOytpreY3us6dZyzfyStVyPHtX47FL+utCAc?=
 =?us-ascii?Q?kshvC03U6Wy1r2g73ixSD1WxHMETSfpy2Ih5Ltn8S8F6okVFTtgQrA1bxA65?=
 =?us-ascii?Q?OAJ1Fs87xjERLYUTvEakEnr352RJx8zHtFv9RPtwbz6yVrx1YPk0mvUpK3j5?=
 =?us-ascii?Q?pO0QUa1h1F4+adYB0Dl86N1NL72S/iEDYGe2BVjTUYMHtg6FcrwUImge4X0j?=
 =?us-ascii?Q?j4x+3bMrEiRZuNCOwcZc1dM0uInWQhYvfvmkOBMyZkGtSBwEV/Zx71yMzQcE?=
 =?us-ascii?Q?SNpBvpK+veBm2kWvN1tbA34tSSeM/fMv+3qCfi+hGPnrmE60oLZF0RfyQP7W?=
 =?us-ascii?Q?j8WckoN01HGGeZ9GE1riZyxppmRDfirRnxrCoQb3sqJtT9RFnyV/e79xcvfT?=
 =?us-ascii?Q?iZ9t5xYD7IEtVTagDMLWmlZFusRwy7EyJldgYpsFZUxDejqW0lJ8sqJGeW5m?=
 =?us-ascii?Q?9QTxjDmnX+SDl1VirX9b49RjZkA3PkA4g7ENMwWLgg/VQbLgy8ts4buLhJun?=
 =?us-ascii?Q?FRD6oBTbwHIcvJkhHl4AyngLOp5UbkLT+IppKqZkXG7wWHFek6Q5xHluMtEG?=
 =?us-ascii?Q?FZcDDpvPAjVMd2DeA2GgEq8pa8CeYuAAIorp8pjpawwuwPXoabxRzQEWMXz8?=
 =?us-ascii?Q?gFil7ch2+T4k3n0DGTA3ubt4gKhm8pvxppXt4QAZQrnRJaqvwfAbip0n6fj+?=
 =?us-ascii?Q?nwxHE+wrhK65wReAmhHt2mktrOzuk91/oD7g2EW0WPYZCER9lEq4jV7X4k71?=
 =?us-ascii?Q?botnJIAeLwsSWe+hAbwF5tMP803AKfcy80cVTKHoZbgUMXHK6FzEmoGQUm5g?=
 =?us-ascii?Q?219/FVyfHPAY3C9hch7DE2v+g+DFgEZ0ivmlcIMFXEWOSWUSSHUL8YRxqxy8?=
 =?us-ascii?Q?o5JpOFLuH3xeq2aLj24=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b57dbd53-7723-48b6-414b-08d99aeec009
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2021 15:14:06.6303
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jTloZ5SARRrAPF//OQxkpKlaTwNQ2MzeBVuqv2VSOvMEO8fSwtkO3j2Hugy+HW3h
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5175
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Oct 27, 2021 at 11:54:48PM +0300, Kamal Heib wrote:
> For some reason when introducing 13f30b0fa0a9 commit the "active_pds" and
> "active_ahs" descriptors got dropped, which lead to the following panic
> when trying to access the first entry in the descriptors. Avoid this by
> return the dropped hunks.
> 
>  bnxt_re: Broadcom NetXtreme-C/E RoCE Driver
>  BUG: kernel NULL pointer dereference, address: 0000000000000000
>  #PF: supervisor read access in kernel mode
>  #PF: error_code(0x0000) - not-present page
>  PGD 0 P4D 0
>  Oops: 0000 [#1] SMP PTI
>  CPU: 2 PID: 594 Comm: kworker/u32:1 Not tainted 5.15.0-rc6+ #2
>  Hardware name: Dell Inc. PowerEdge R430/0CN7X8, BIOS 2.12.1 12/07/2020
>  Workqueue: bnxt_re bnxt_re_task [bnxt_re]
>  RIP: 0010:strlen+0x0/0x20
>  Code: 48 89 f9 74 09 48 83 c1 01 80 39 00 75 f7 31 d2 44 0f b6 04 16 44 88 04 11 48 83 c2 01 45 84 c0 75 ee c3 0f 1f 80 00 00 00 00 <80> 3f 00 74 10 48 89 f8 48 83 c0 01 80 31
>  RSP: 0018:ffffb25fc47dfbb0 EFLAGS: 00010246
>  RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000008100
>  RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
>  RBP: 0000000000000000 R08: 00000000fffffff4 R09: 0000000000000000
>  R10: ffff8a05c71fc028 R11: 0000000000000000 R12: 0000000000000000
>  R13: 0000000000000000 R14: 0000000000000000 R15: ffff8a05c3dee800
>  FS:  0000000000000000(0000) GS:ffff8a092fc40000(0000) knlGS:0000000000000000
>  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>  CR2: 0000000000000000 CR3: 000000048d3da001 CR4: 00000000001706e0
>  Call Trace:
>   kernfs_name_hash+0x12/0x80
>   kernfs_find_ns+0x35/0xd0
>   kernfs_remove_by_name_ns+0x32/0x90
>   remove_files+0x2b/0x60
>   create_files+0x1d3/0x1f0
>   internal_create_group+0x17b/0x1f0
>   internal_create_groups.part.0+0x3d/0xa0
>   setup_port+0x180/0x3b0 [ib_core]
>   ? __cond_resched+0x16/0x40
>   ? kmem_cache_alloc_trace+0x278/0x3d0
>   ib_setup_port_attrs+0x99/0x240 [ib_core]
>   ib_register_device+0xcc/0x160 [ib_core]
>   bnxt_re_task+0xba/0x170 [bnxt_re]
>   process_one_work+0x1eb/0x390
>   worker_thread+0x53/0x3d0
>   ? process_one_work+0x390/0x390
>   kthread+0x10f/0x130
>   ? set_kthread_struct+0x40/0x40
>   ret_from_fork+0x22/0x30
>  Modules linked in: bnxt_re kvm ib_uverbs dell_wmi_descriptor rfkill video iTCO_wdt iTCO_vendor_support irqbypass dcdbas ib_core ipmi_ssif rapl intel_cstate intel_uncore pcspke
>  CR2: 0000000000000000
>  ---[ end trace b4637e4c4e3001af ]---
>  RIP: 0010:strlen+0x0/0x20
>  Code: 48 89 f9 74 09 48 83 c1 01 80 39 00 75 f7 31 d2 44 0f b6 04 16 44 88 04 11 48 83 c2 01 45 84 c0 75 ee c3 0f 1f 80 00 00 00 00 <80> 3f 00 74 10 48 89 f8 48 83 c0 01 80 31
>  RSP: 0018:ffffb25fc47dfbb0 EFLAGS: 00010246
>  RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000008100
>  RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
>  RBP: 0000000000000000 R08: 00000000fffffff4 R09: 0000000000000000
>  R10: ffff8a05c71fc028 R11: 0000000000000000 R12: 0000000000000000
>  R13: 0000000000000000 R14: 0000000000000000 R15: ffff8a05c3dee800
>  FS:  0000000000000000(0000) GS:ffff8a092fc40000(0000) knlGS:0000000000000000
>  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>  CR2: 0000000000000000 CR3: 000000048d3da001 CR4: 00000000001706e0
>  Kernel panic - not syncing: Fatal exception
>  Kernel Offset: 0x400000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
>  ---[ end Kernel panic - not syncing: Fatal exception ]---
> 
> Fixes: 13f30b0fa0a9 ("RDMA/counter: Add a descriptor in struct rdma_hw_stats")
> Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
> Acked-by: Selvin Xavier <selvin.xavier@broadcom.com>
> Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
> Reviewed-By: Devesh Sharma <devesh.s.sharma@oracle.com>
> ---
>  drivers/infiniband/hw/bnxt_re/hw_counters.c | 2 ++
>  1 file changed, 2 insertions(+)

Applied to for-next, thanks

Jason
