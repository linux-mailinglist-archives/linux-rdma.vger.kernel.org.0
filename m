Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 695B46EBC91
	for <lists+linux-rdma@lfdr.de>; Sun, 23 Apr 2023 05:09:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbjDWDJP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 22 Apr 2023 23:09:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbjDWDJL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 22 Apr 2023 23:09:11 -0400
Received: from out-51.mta1.migadu.com (out-51.mta1.migadu.com [95.215.58.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C95EB30CD
        for <linux-rdma@vger.kernel.org>; Sat, 22 Apr 2023 20:09:02 -0700 (PDT)
Message-ID: <c5a35877-4b73-b24a-0b59-22cfcb491810@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1682219338;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UiI7aYBFwyNLLgi+on13Cme/oriax/GhkXRlX/073dw=;
        b=FFYJLdpR/pNs+gYWUaY7WVwUIl6yUBPzb0S17HJPRye/lOqYyTuPIsIe4JwaZJaChCQlR4
        8AF2c9xAY+rVO1quDY6Xxph6nhCmahIBpbZDAZIi0JE9RDPBgkY/9yBsYlHBGY/rncfCYr
        ADhF4dFbSYxWh3Lfdv5aGlA8YLgv5jE=
Date:   Sun, 23 Apr 2023 11:08:55 +0800
MIME-Version: 1.0
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
Subject: Re: [PATCH for-next v2 3/3] RDMA/rtrs: Fix rxe_dealloc_pd warning
To:     Li Zhijian <lizhijian@fujitsu.com>, haris.iqbal@ionos.com,
        jinpu.wang@ionos.com, jgg@ziepe.ca, leon@kernel.org,
        linux-rdma@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <1682213212-2-1-git-send-email-lizhijian@fujitsu.com>
 <1682213212-2-4-git-send-email-lizhijian@fujitsu.com>
Content-Language: en-US
In-Reply-To: <1682213212-2-4-git-send-email-lizhijian@fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 4/23/23 09:26, Li Zhijian wrote:
> In current design:
> 1. PD and clt_path->s.dev are shared among connections.
> 2. every con[n]'s cleanup phase will call destroy_con_cq_qp()
> 3. clt_path->s.dev will be always decreased in destroy_con_cq_qp(), and
>     when clt_path->s.dev become zero, it will destroy PD.
> 4. when con[1] failed to create, con[1] will not take clt_path->s.dev,
>     but it try to decreased clt_path->s.dev
>
> So, in case create_cm(con[0]) succeeds but create_cm(con[1])
> fails, destroy_con_cq_qp(con[1]) will be called first which will destory
> the PD while this PD is still taken by con[0].
>
> Here, we refactor the error path of create_cm() and init_conns(), so that
> we do the cleanup in the order they are created.
>
> The warning occurs when destroying RXE PD whose reference count is not
> zero.
> -----------------------------------------------
>   rnbd_client L597: Mapping device /dev/nvme0n1 on session client, (access_mode: rw, nr_poll_queues: 0)
>   ------------[ cut here ]------------
>   WARNING: CPU: 0 PID: 26407 at drivers/infiniband/sw/rxe/rxe_pool.c:256 __rxe_cleanup+0x13a/0x170 [rdma_rxe]
>   Modules linked in: rpcrdma rdma_ucm ib_iser rnbd_client libiscsi rtrs_client scsi_transport_iscsi rtrs_core rdma_cm iw_cm ib_cm crc32_generic rdma_rxe udp_tunnel ib_uverbs ib_core kmem device_dax nd_pmem dax_pmem nd_
> vme crc32c_intel fuse nvme_core nfit libnvdimm dm_multipath scsi_dh_rdac scsi_dh_emc scsi_dh_alua dm_mirror dm_region_hash dm_log dm_mod
>   CPU: 0 PID: 26407 Comm: rnbd-client.sh Kdump: loaded Not tainted 6.2.0-rc6-roce-flush+ #53
>   Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
>   RIP: 0010:__rxe_cleanup+0x13a/0x170 [rdma_rxe]
>   Code: 45 84 e4 0f 84 5a ff ff ff 48 89 ef e8 5f 18 71 f9 84 c0 75 90 be c8 00 00 00 48 89 ef e8 be 89 1f fa 85 c0 0f 85 7b ff ff ff <0f> 0b 41 bc ea ff ff ff e9 71 ff ff ff e8 84 7f 1f fa e9 d0 fe ff
>   RSP: 0018:ffffb09880b6f5f0 EFLAGS: 00010246
>   RAX: 0000000000000000 RBX: ffff99401f15d6a8 RCX: 0000000000000000
>   RDX: 0000000000000001 RSI: ffffffffbac8234b RDI: 00000000ffffffff
>   RBP: ffff99401f15d6d0 R08: 0000000000000001 R09: 0000000000000001
>   R10: 0000000000002d82 R11: 0000000000000000 R12: 0000000000000001
>   R13: ffff994101eff208 R14: ffffb09880b6f6a0 R15: 00000000fffffe00
>   FS:  00007fe113904740(0000) GS:ffff99413bc00000(0000) knlGS:0000000000000000
>   CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>   CR2: 00007ff6cde656c8 CR3: 000000001f108004 CR4: 00000000001706f0
>   DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>   DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>   Call Trace:
>    <TASK>
>    rxe_dealloc_pd+0x16/0x20 [rdma_rxe]
>    ib_dealloc_pd_user+0x4b/0x80 [ib_core]
>    rtrs_ib_dev_put+0x79/0xd0 [rtrs_core]
>    destroy_con_cq_qp+0x8a/0xa0 [rtrs_client]
>    init_path+0x1e7/0x9a0 [rtrs_client]
>    ? __pfx_autoremove_wake_function+0x10/0x10
>    ? lock_is_held_type+0xd7/0x130
>    ? rcu_read_lock_sched_held+0x43/0x80
>    ? pcpu_alloc+0x3dd/0x7d0
>    ? rtrs_clt_init_stats+0x18/0x40 [rtrs_client]
>    rtrs_clt_open+0x24f/0x5a0 [rtrs_client]
>    ? __pfx_rnbd_clt_link_ev+0x10/0x10 [rnbd_client]
>    rnbd_clt_map_device+0x6a5/0xe10 [rnbd_client]
>
> Signed-off-by: Li Zhijian<lizhijian@fujitsu.com>
> ---
> V2: refactor error path instead of introducing a new flag #Leon
> ---
>   drivers/infiniband/ulp/rtrs/rtrs-clt.c | 55 +++++++++++---------------
>   1 file changed, 23 insertions(+), 32 deletions(-)
>
> diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> index c2065fc33a56..5234be5c6bf8 100644
> --- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> +++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> @@ -2039,6 +2039,7 @@ static int rtrs_clt_rdma_cm_handler(struct rdma_cm_id *cm_id,
>   	return 0;
>   }
>   
> +/* The caller should the do the cleanup in case of error */

Remove the first 'the' from above sentence.

>   static int create_cm(struct rtrs_clt_con *con)
>   {
>   	struct rtrs_path *s = con->c.path;
> @@ -2061,14 +2062,14 @@ static int create_cm(struct rtrs_clt_con *con)
>   	err = rdma_set_reuseaddr(cm_id, 1);
>   	if (err != 0) {
>   		rtrs_err(s, "Set address reuse failed, err: %d\n", err);
> -		goto destroy_cm;
> +		return err;
>   	}
>   	err = rdma_resolve_addr(cm_id, (struct sockaddr *)&clt_path->s.src_addr,
>   				(struct sockaddr *)&clt_path->s.dst_addr,
>   				RTRS_CONNECT_TIMEOUT_MS);
>   	if (err) {
>   		rtrs_err(s, "Failed to resolve address, err: %d\n", err);
> -		goto destroy_cm;
> +		return err;
>   	}
>   	/*
>   	 * Combine connection status and session events. This is needed
> @@ -2083,29 +2084,15 @@ static int create_cm(struct rtrs_clt_con *con)
>   		if (err == 0)
>   			err = -ETIMEDOUT;
>   		/* Timedout or interrupted */
> -		goto errr;
> -	}
> -	if (con->cm_err < 0) {
> -		err = con->cm_err;
> -		goto errr;
> +		return err;
>   	}
> -	if (READ_ONCE(clt_path->state) != RTRS_CLT_CONNECTING) {
> +	if (con->cm_err < 0)
> +		return con->cm_err;
> +	if (READ_ONCE(clt_path->state) != RTRS_CLT_CONNECTING)
>   		/* Device removal */
> -		err = -ECONNABORTED;
> -		goto errr;
> -	}
> +		return -ECONNABORTED;
>   
>   	return 0;
> -
> -errr:
> -	stop_cm(con);
> -	mutex_lock(&con->con_mutex);
> -	destroy_con_cq_qp(con);
> -	mutex_unlock(&con->con_mutex);
> -destroy_cm:
> -	destroy_cm(con);
> -
> -	return err;
>   }
>   
>   static void rtrs_clt_path_up(struct rtrs_clt_path *clt_path)
> @@ -2333,7 +2320,7 @@ static void rtrs_clt_close_work(struct work_struct *work)
>   static int init_conns(struct rtrs_clt_path *clt_path)
>   {
>   	unsigned int cid;
> -	int err;
> +	int err, i;
>   
>   	/*
>   	 * On every new session connections increase reconnect counter
> @@ -2349,10 +2336,8 @@ static int init_conns(struct rtrs_clt_path *clt_path)
>   			goto destroy;
>   
>   		err = create_cm(to_clt_con(clt_path->s.con[cid]));
> -		if (err) {
> -			destroy_con(to_clt_con(clt_path->s.con[cid]));
> +		if (err)
>   			goto destroy;
> -		}
>   	}
>   	err = alloc_path_reqs(clt_path);
>   	if (err)
> @@ -2363,15 +2348,21 @@ static int init_conns(struct rtrs_clt_path *clt_path)
>   	return 0;
>   
>   destroy:
> -	while (cid--) {
> -		struct rtrs_clt_con *con = to_clt_con(clt_path->s.con[cid]);
> +	/* Make sure we do the cleanup in the order they are created */
> +	for (i = 0; i <= cid; i++) {
> +		struct rtrs_clt_con *con;
>   
> -		stop_cm(con);
> +		if (!clt_path->s.con[i])
> +			break;
>   
> -		mutex_lock(&con->con_mutex);
> -		destroy_con_cq_qp(con);
> -		mutex_unlock(&con->con_mutex);
> -		destroy_cm(con);
> +		con = to_clt_con(clt_path->s.con[i]);
> +		if (con->c.cm_id) {
> +			stop_cm(con);
> +			mutex_lock(&con->con_mutex);
> +			destroy_con_cq_qp(con);
> +			mutex_unlock(&con->con_mutex);
> +			destroy_cm(con);
> +		}
>   		destroy_con(con);
>   	}

Can we factor out a function for above? Then rtrs_clt_stop_and_destroy_conns
might reuse it as well.

Thanks,
Guoqing
