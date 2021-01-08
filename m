Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB0842EF968
	for <lists+linux-rdma@lfdr.de>; Fri,  8 Jan 2021 21:40:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729547AbhAHUjX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 8 Jan 2021 15:39:23 -0500
Received: from nat-hk.nvidia.com ([203.18.50.4]:1263 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729546AbhAHUjU (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 8 Jan 2021 15:39:20 -0500
Received: from HKMAIL103.nvidia.com (Not Verified[10.18.92.77]) by nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5ff8c2ce0000>; Sat, 09 Jan 2021 04:38:38 +0800
Received: from HKMAIL101.nvidia.com (10.18.16.10) by HKMAIL103.nvidia.com
 (10.18.16.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 8 Jan
 2021 20:38:37 +0000
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (104.47.38.52) by
 HKMAIL101.nvidia.com (10.18.16.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Fri, 8 Jan 2021 20:38:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kWzH8TfH1V7b6kRdBNDILYZniBm4ljtmXu/msmmnFCVjcnAba6IajWwY30wVKP+OOy1PTYhGUXoDtWk8DWiLIQ8WcZOSMuBjM68OdIaoUB7slSxPWa0LirPv6AqwnOEqCUGDzeQvWoaNPl3MvbWIO6tRCI/0zG/WkfI0/ANkEwOKCshi+H1z3Pv+PURX7qJneWUxghfh8wTY3FD14UxyrTE1e8n1/Pj0jS6gAddngIazUr67VL+83zUQEZ2eU3pTY22KThb05DCKcH2O/Ecy18t1WvAoq/W3mjj1ag3nOCQpHnXS5jlTuJEcCpuMzMnSyF4HgqarEpm3g2a5sUuM+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=98d7rm0+5UE/SEVI0x2a/xqjUv/VWp5R9tWetG86OQ0=;
 b=GamH5ARHAmR0Hc07PvhmQf/+8A8MeiGnu5XcVGQx93v2FiHaRy+mi46tRoVp3SZoZkCDENlPn3IhbEEQzDPZb5zOyFW/T/XSu7eHh9M87DdEvB3ix4SNGY75LuW4BwWs2iI97TuGA3wtwunm75yq05PSKvV9c7nA778oZ3aHB8Q6nnsxBCMKV6SSEUUDVxlw2OOwVJg3dDSldDOATA81a/gqaW5bTUqDgZFHqmFBQRv//aF2dh7/EfYV16fGAkvQaDjveAC4V07dJpgVmx2Gxe/8Y1nOaC+Z9+Uz5qp9S4m5ZC4WHlz7dAgpjdgXen/eKE5zwKPLtp4hgbffv/tLKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3929.namprd12.prod.outlook.com (2603:10b6:5:148::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.9; Fri, 8 Jan
 2021 20:38:34 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::546d:512c:72fa:4727]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::546d:512c:72fa:4727%7]) with mapi id 15.20.3742.008; Fri, 8 Jan 2021
 20:38:34 +0000
Date:   Fri, 8 Jan 2021 16:38:32 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bernard Metzler <bmt@zurich.ibm.com>
CC:     <linux-rdma@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
        <leon@kernel.org>, Kamal Heib <kamalheib1@gmail.com>,
        Yi Zhang <yi.zhang@redhat.com>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v4] RDMA/siw: Fix handling of zero-sized Read and Receive
 Queues.
Message-ID: <20210108203832.GA1050149@nvidia.com>
References: <20210108125845.1803-1-bmt@zurich.ibm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210108125845.1803-1-bmt@zurich.ibm.com>
X-ClientProxiedBy: BL1PR13CA0290.namprd13.prod.outlook.com
 (2603:10b6:208:2bc::25) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by BL1PR13CA0290.namprd13.prod.outlook.com (2603:10b6:208:2bc::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.2 via Frontend Transport; Fri, 8 Jan 2021 20:38:34 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kxyWm-004PCw-M1; Fri, 08 Jan 2021 16:38:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1610138318; bh=98d7rm0+5UE/SEVI0x2a/xqjUv/VWp5R9tWetG86OQ0=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=rbm0KZThEIDY2OzDgLtyzf8P/UKCyQ7LCjGBARelpFC69GnY+G9OzSuOJsgXlkVlT
         0cubfau2pVWYcu7Vr3TQlcuxO8n5qfLOXdD2QQ8BsoflpjoszFsGTEGRIlQ/v94Rbh
         wNUcLr5HBAF4MPTTtsj3itBbiSrFYpyuiki3IOt5Hb0W/WliODj69QnkBiWVHvgHok
         lDfnVIuePMPj8Rp8T3yGfO3VrJHYOppJXn3EKFmxHpragl+bq9sLvP7BvNVjeJb1lp
         qmqKa7surCMYFqqROqP0urrK2ckSuTNpm1U4HLyYEBZ2FuxcobsgatiIIpgJm7/9Te
         HCFr8RYUqghVw==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jan 08, 2021 at 01:58:45PM +0100, Bernard Metzler wrote:
> During connection setup, the application may choose to zero-size
> inbound and outbound READ queues, as well as the Receive queue.
> This patch fixes handling of zero-sized queues, but not prevents
> it.
> 
> Kamal Heib says in an initial error report:
> When running the blktests over siw the following shift-out-of-bounds is
> reported, this is happening because the passed IRD or ORD from the ulp
> could be zero which will lead to unexpected behavior when calling
> roundup_pow_of_two(), fix that by blocking zero values of ORD or IRD.
> 
> UBSAN: shift-out-of-bounds in ./include/linux/log2.h:57:13
> shift exponent 64 is too large for 64-bit type 'long unsigned int'
> CPU: 20 PID: 3957 Comm: kworker/u64:13 Tainted: G S     5.10.0-rc6 #2
> Hardware name: Dell Inc. PowerEdge R630/02C2CP, BIOS 2.1.5 04/11/2016
> Workqueue: iw_cm_wq cm_work_handler [iw_cm]
> Call Trace:
>  dump_stack+0x99/0xcb
>  ubsan_epilogue+0x5/0x40
>  __ubsan_handle_shift_out_of_bounds.cold.11+0xb4/0xf3
>  ? down_write+0x183/0x3d0
>  siw_qp_modify.cold.8+0x2d/0x32 [siw]
>  ? __local_bh_enable_ip+0xa5/0xf0
>  siw_accept+0x906/0x1b60 [siw]
>  ? xa_load+0x147/0x1f0
>  ? siw_connect+0x17a0/0x17a0 [siw]
>  ? lock_downgrade+0x700/0x700
>  ? siw_get_base_qp+0x1c2/0x340 [siw]
>  ? _raw_spin_unlock_irqrestore+0x39/0x40
>  iw_cm_accept+0x1f4/0x430 [iw_cm]
>  rdma_accept+0x3fa/0xb10 [rdma_cm]
>  ? check_flush_dependency+0x410/0x410
>  ? cma_rep_recv+0x570/0x570 [rdma_cm]
>  nvmet_rdma_queue_connect+0x1a62/0x2680 [nvmet_rdma]
>  ? nvmet_rdma_alloc_cmds+0xce0/0xce0 [nvmet_rdma]
>  ? lock_release+0x56e/0xcc0
>  ? lock_downgrade+0x700/0x700
>  ? lock_downgrade+0x700/0x700
>  ? __xa_alloc_cyclic+0xef/0x350
>  ? __xa_alloc+0x2d0/0x2d0
>  ? rdma_restrack_add+0xbe/0x2c0 [ib_core]
>  ? __ww_mutex_die+0x190/0x190
>  cma_cm_event_handler+0xf2/0x500 [rdma_cm]
>  iw_conn_req_handler+0x910/0xcb0 [rdma_cm]
>  ? _raw_spin_unlock_irqrestore+0x39/0x40
>  ? trace_hardirqs_on+0x1c/0x150
>  ? cma_ib_handler+0x8a0/0x8a0 [rdma_cm]
>  ? __kasan_kmalloc.constprop.7+0xc1/0xd0
>  cm_work_handler+0x121c/0x17a0 [iw_cm]
>  ? iw_cm_reject+0x190/0x190 [iw_cm]
>  ? trace_hardirqs_on+0x1c/0x150
>  process_one_work+0x8fb/0x16c0
>  ? pwq_dec_nr_in_flight+0x320/0x320
>  worker_thread+0x87/0xb40
>  ? __kthread_parkme+0xd1/0x1a0
>  ? process_one_work+0x16c0/0x16c0
>  kthread+0x35f/0x430
>  ? kthread_mod_delayed_work+0x180/0x180
>  ret_from_fork+0x22/0x30
> 
> Fixes: a531975279f3 ("rdma/siw: main include file")
> Fixes: f29dd55b0236 ("rdma/siw: queue pair methods")
> Fixes: 8b6a361b8c48 ("rdma/siw: receive path")
> Fixes: b9be6f18cf9e ("rdma/siw: transmit path")
> Fixes: 303ae1cdfdf7 ("rdma/siw: application interface")
> Reported-by: Kamal Heib <kamalheib1@gmail.com>
> Reported-by: Yi Zhang <yi.zhang@redhat.com>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Bernard Metzler <bmt@zurich.ibm.com>
> ---
> v2 changes:
> - Fix uninitialized variable introduced in siw_qp_rx.c, as
>   Reported-by: kernel test robot <lkp@intel.com>
> - Add initial error report as
>   Reported-by: Kamal Heib <kamalheib1@gmail.com>
> 
> v3 changes:
> - correct patch changelog location
> - remove prints for failed queue malloc's as pointed out by
>   Leon Romanovsky
> 
> v4 changes:
> - unwind siw_activate_tx function avoiding confusing
>   goto's as requested by Jason Gunthorp
> 
>  drivers/infiniband/sw/siw/siw.h       |   2 +-
>  drivers/infiniband/sw/siw/siw_qp.c    | 271 ++++++++++++++------------
>  drivers/infiniband/sw/siw/siw_qp_rx.c |  26 ++-
>  drivers/infiniband/sw/siw/siw_qp_tx.c |   4 +-
>  drivers/infiniband/sw/siw/siw_verbs.c |  20 +-
>  5 files changed, 177 insertions(+), 146 deletions(-)

Applied to for-next, thanks

Jason
