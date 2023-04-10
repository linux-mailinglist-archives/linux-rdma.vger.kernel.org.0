Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A1116DC72C
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Apr 2023 15:13:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbjDJNNU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 10 Apr 2023 09:13:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbjDJNNT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 10 Apr 2023 09:13:19 -0400
X-Greylist: delayed 171 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 10 Apr 2023 06:13:18 PDT
Received: from out-58.mta0.migadu.com (out-58.mta0.migadu.com [IPv6:2001:41d0:1004:224b::3a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B75540EE
        for <linux-rdma@vger.kernel.org>; Mon, 10 Apr 2023 06:13:18 -0700 (PDT)
Message-ID: <46aa88fe-89f0-6880-9bb7-081d1d18023b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1681132396;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c5MI4iAb1uJoiC0FdQ+XwbH72/3ljJ1YZ4LZyFUStR0=;
        b=NkLp0JuseGqxPPEWwNosVDzR6dsIHveJa5BHT74Rp93c7hsfZJRrlu70YKvtg8SM0agczE
        d7/RkBTRb1GJWKv763m+A7nS024jfuBLljw5QOD9cjnnFKO4LtjrpwSPen/eMPXoaM19ew
        bbE/PpUsBJc4xGhAEnet2cEc9RbX7e8=
Date:   Mon, 10 Apr 2023 21:13:13 +0800
MIME-Version: 1.0
Subject: Re: [PATCH for-next 3/3] RDMA/rtrs: Avoid use-after-free in
 rtrs_clt_rdma_cm_handler
To:     Li Zhijian <lizhijian@fujitsu.com>, haris.iqbal@ionos.com,
        jinpu.wang@ionos.com, jgg@ziepe.ca, leon@kernel.org,
        linux-rdma@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <1681108984-2-1-git-send-email-lizhijian@fujitsu.com>
 <1681108984-2-4-git-send-email-lizhijian@fujitsu.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
In-Reply-To: <1681108984-2-4-git-send-email-lizhijian@fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 4/10/23 14:43, Li Zhijian wrote:
> Currently, con will be destroyed when wait_event_interruptible_timeout()
> returns ERESTARTSYS. But the in-flight event handler
> rtrs_clt_rdma_cm_handler() could be rescheduled/wakeup which
> may cause a use-after-free.
>
>      WARNING: CPU: 0 PID: 14766 at drivers/infiniband/ulp/rtrs/rtrs-clt.c:1687 rtrs_clt_rdma_cm_handler+0x620/0x640 [rtrs_client]
>       Modules linked in: rnbd_client rtrs_client rtrs_core rdma_cm iw_cm ib_cm rdma_rxe ib_uverbs ib_core libiscsi scsi_transport_iscsi crc32_generic udp_tunnel dax_pmem nd_pmem nd_btt virtiofs crc32c_intel nvme fuse nvme_core nfit
> libnvdimm dm_multipath scsi_dh_rdac scsi_dh_emc scsi_dh_alua dm_mirror dm_region_hash dm_log dm_mod [last unloaded: ib_core]
>       CPU: 0 PID: 14766 Comm: kworker/u2:3 Kdump: loaded Tainted: G        W          6.2.0-rc6-roce-flush+ #56
>       Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
>       Workqueue: ib_addr process_one_req [ib_core]
>       RIP: 0010:rtrs_clt_rdma_cm_handler+0x620/0x640 [rtrs_client]
>       Code: 00 0f 85 5f fd ff ff 4c 8b 23 41 bd f4 ff ff ff e9 95 fb ff ff 0f 0b 4c 89 f7 41 bd ea ff ff ff e8 75 c8 92 ec e9 4b ff ff ff <0f> 0b 4c 89 f7 41 bd ea ff ff ff e8 60 c8 92 ec e9 36 ff ff ff e8
>       RSP: 0018:ffffa4ef41cdbc60 EFLAGS: 00010246
>       RAX: 0000000000000000 RBX: ffff9372c394e600 RCX: 0000000000000001
>       RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffffffffad634277
>       RBP: ffffa4ef41cdbd00 R08: 0000000000000000 R09: 0000000000000001
>       R10: 0000000000003ff3 R11: 0000000000000000 R12: ffff9372c3164800
>       R13: ffff9372c3164800 R14: ffff9372c394e640 R15: ffff9372c5219020
>       FS:  0000000000000000(0000) GS:ffff9372fbc00000(0000) knlGS:0000000000000000
>       CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>       CR2: 00007f35bb7d5de0 CR3: 0000000020c2a006 CR4: 00000000001706f0
>       DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>       DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>       Call Trace:
>        <TASK>
>        ? mark_held_locks+0x49/0x80
>        ? lock_is_held_type+0xd7/0x130
>        ? cma_cm_event_handler+0x49/0x200 [rdma_cm]
>        cma_cm_event_handler+0x49/0x200 [rdma_cm]
>        addr_handler+0xf1/0x1e0 [rdma_cm]
>        ? lock_acquire+0xca/0x2f0
>        ? lock_acquire+0xda/0x2f0
>        process_one_req+0x43/0x170 [ib_core]
>        process_one_work+0x274/0x590
>        worker_thread+0x4f/0x3d0
>        ? __pfx_worker_thread+0x10/0x10
>        kthread+0xe7/0x110
>        ? __pfx_kthread+0x10/0x10
>        ret_from_fork+0x2c/0x50
>        </TASK>
>       irq event stamp: 1432669
>       hardirqs last  enabled at (1432683): [<ffffffffac508eb2>] __up_console_sem+0x52/0x60
>       hardirqs last disabled at (1432698): [<ffffffffac508e97>] __up_console_sem+0x37/0x60
>       softirqs last  enabled at (1432518): [<ffffffffac48c985>] __irq_exit_rcu+0xc5/0x120
>       softirqs last disabled at (1432509): [<ffffffffac48c985>] __irq_exit_rcu+0xc5/0x120
>       ---[ end trace 0000000000000000 ]---
>
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> ---
>   drivers/infiniband/ulp/rtrs/rtrs-clt.c | 14 ++++++++++----
>   1 file changed, 10 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> index 4c8f42e46e2f..760a7eb51297 100644
> --- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> +++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> @@ -2074,6 +2074,7 @@ static int create_cm(struct rtrs_clt_con *con)
>   		rtrs_err(s, "Failed to resolve address, err: %d\n", err);
>   		goto destroy_cm;
>   	}
> +again:
>   	/*
>   	 * Combine connection status and session events. This is needed
>   	 * for waiting two possible cases: cm_err has something meaningful
> @@ -2083,10 +2084,15 @@ static int create_cm(struct rtrs_clt_con *con)
>   			clt_path->state_wq,
>   			con->cm_err || clt_path->state != RTRS_CLT_CONNECTING,
>   			msecs_to_jiffies(RTRS_CONNECT_TIMEOUT_MS));
> -	if (err == 0 || err == -ERESTARTSYS) {
> -		if (err == 0)
> -			err = -ETIMEDOUT;
> -		/* Timedout or interrupted */
> +	if (err == -ERESTARTSYS) {
> +		/* interrupted,
> +		 * try again to avoid the in-flight rtrs_clt_rdma_cm_handler()
> +		 * getting a use-after-free
> +		 */
> +		goto again;
> +	} else if (err == 0) {
> +		err = -ETIMEDOUT;
> +		/* Timedout */
>   		goto errr;
>   	}

Can event handler still be triggered in case of timeout?

And I guess either stop_cm -> rdma_disconnect or destroy_cm -> 
rdma_destroy_id
should prevent this kind of racy issue.

Thanks,
Guoqing
