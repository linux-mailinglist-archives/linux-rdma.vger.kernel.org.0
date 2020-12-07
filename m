Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC21C2D1A84
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Dec 2020 21:30:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725799AbgLGU2m (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 7 Dec 2020 15:28:42 -0500
Received: from nat-hk.nvidia.com ([203.18.50.4]:30017 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725774AbgLGU2m (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 7 Dec 2020 15:28:42 -0500
Received: from HKMAIL104.nvidia.com (Not Verified[10.18.92.77]) by nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fce90500000>; Tue, 08 Dec 2020 04:28:00 +0800
Received: from HKMAIL101.nvidia.com (10.18.16.10) by HKMAIL104.nvidia.com
 (10.18.16.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 7 Dec
 2020 20:28:00 +0000
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.48) by
 HKMAIL101.nvidia.com (10.18.16.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Mon, 7 Dec 2020 20:28:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S4Gfo3Hpeoz4E3q/ETIQL2EyA8km0lLf9SQqv0YfhhUy5lNiXYQzQFSrv0Yzi2RdLdXb9k2UV+OpmlIwWV3//fwXr/Hb7i2H0yZadKoIj+F5isqlGQx7QcMTGBvYTE0LWMqAWQBYf4G5oHX5HTunUuwUZixYTn0W/IDuAojM2bO3ZNGbTO4xyZesXVcwsDMz1vPefbuuiFu5NuwziuLj9jiKTwzdouqXXTus3X5ejZxWhlC1svif6rP3rQsWBa0YmhJppRiHxNRpHrV/YfuOpq0Bm2xiAeWWsDpJAhsSjecE7eVMHOuoKCZ3GwvFKyEqsJ1q1Ws1q96GWTnZncPUdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t9NQPhPth+DDfvlyG4BCH1u5+Hwgenp0EC6FS79+QvI=;
 b=YPBI5Bc3y+js/XMr3FLrVsJkMItqcPncpPZCXJANPXwh5F2opsK2ItLYT678a/Vilzu202sJPpRex71pkGZn6UetKXhhqBArX/l6YhvGTXt1Dhin/swy6kV4l8SFT8QX0E9Kozs3ZjxovqjHUKTI2TuKRWS5qF1SAigYjbDnNYl4QrUgTy5rPkEP/GqDaPQXtgjxj+z2A5R5kFKwsu/S2Od5eIUIpuhHPekHTCqXhPfaQjno/1uEZC1fWoPmPDB6vVL0tatcJASW9rmVFifqNLJLWEIcrV2fCpDRU57kQ6NJzWfQIcRWF1PaG76g3ozZ3mdCY880JoLPUchVpv5ZVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4042.namprd12.prod.outlook.com (2603:10b6:5:215::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17; Mon, 7 Dec
 2020 20:27:58 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1ce9:3434:90fe:3433]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1ce9:3434:90fe:3433%3]) with mapi id 15.20.3632.023; Mon, 7 Dec 2020
 20:27:58 +0000
Date:   Mon, 7 Dec 2020 16:27:56 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Kamal Heib <kamalheib1@gmail.com>
CC:     <linux-rdma@vger.kernel.org>, Bernard Metzler <bmt@zurich.ibm.com>,
        Doug Ledford <dledford@redhat.com>
Subject: Re: [PATCH for-rc] RDMA/siw: Fix shift-out-of-bounds when call
 roundup_pow_of_two()
Message-ID: <20201207202756.GA1798393@nvidia.com>
References: <20201207093728.428679-1-kamalheib1@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201207093728.428679-1-kamalheib1@gmail.com>
X-ClientProxiedBy: MN2PR11CA0001.namprd11.prod.outlook.com
 (2603:10b6:208:23b::6) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by MN2PR11CA0001.namprd11.prod.outlook.com (2603:10b6:208:23b::6) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17 via Frontend Transport; Mon, 7 Dec 2020 20:27:58 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kmN6y-007Xr9-Kd; Mon, 07 Dec 2020 16:27:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1607372880; bh=t9NQPhPth+DDfvlyG4BCH1u5+Hwgenp0EC6FS79+QvI=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=nqWJ7bSweGg3sOLX+KvQc62a+1XZskzHrwnrujpQ6v5+Lg64BeiNvNn1OPAH6L1sk
         o4DalPLwx0BnoBTa+Sy+Bd7nH5TWfkemZ4LrAPXpn0zcD15xwmQbU8fxvip3TCnJWk
         IyG6LbGQbt2arZ4aYfa39O3ijEOncmMZfy0sY+2CU657QBFyDDBIDXDBmN9Z37ZPIc
         1rX/DVoK6RbR9K6fnvSChGxZOaqRYS56Sb524JIlkXp8bDEm+1DgyGJVbtuA6uQR84
         m+MYJBUy6eX0P6caPkrKY0zRKzOnmAhOVNp4znUhiJU5QyT+gSGGuLR+AMOpL8B5n2
         uQBlsfjeo29gA==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Dec 07, 2020 at 11:37:28AM +0200, Kamal Heib wrote:
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
> Fixes: 6c52fdc244b5 ("rdma/siw: connection management")
> Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
>  drivers/infiniband/sw/siw/siw_cm.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/sw/siw/siw_cm.c b/drivers/infiniband/sw/siw/siw_cm.c
> index 66764f7ef072..dff0b00cc55d 100644
> +++ b/drivers/infiniband/sw/siw/siw_cm.c
> @@ -1571,7 +1571,8 @@ int siw_accept(struct iw_cm_id *id, struct iw_cm_conn_param *params)
>  		qp->tx_ctx.gso_seg_limit = 0;
>  	}
>  	if (params->ord > sdev->attrs.max_ord ||
> -	    params->ird > sdev->attrs.max_ird) {
> +	    params->ird > sdev->attrs.max_ird ||
> +	    !params->ord || !params->ird) {
>  		siw_dbg_cep(

Are you sure this is the right place for this? Why not higher up? It
looks like the other iwarp drivers have the same problem

Jason
