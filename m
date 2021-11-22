Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2891458A07
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Nov 2021 08:44:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbhKVHr3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 22 Nov 2021 02:47:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:53086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231360AbhKVHr2 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 22 Nov 2021 02:47:28 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id AFC1B60F24;
        Mon, 22 Nov 2021 07:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637567062;
        bh=NnFCyGLBe9eZmqScFNZcEfdIpXXxcZlYJKlLn6gkZ7o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BfhwAaDKTcyr4WjFv9DnLpmnLdT1jfFw01sOKNCRoG/AN9yL+tMjKT+MlJzyqiELi
         Zczw9Orh17SBxILOBuQv+i/lp4xbBRgmqWahTU2vkW3w+QUmMhDtKXbQD6oh8ekz8y
         cTj/1slBjYMcVRSD0hL5lO7iDdwx2VK9+oxtEfwbobLQ2RfJp2t1jmMmUI4NsB+zgk
         7TRNN2X8qVdRGxMz9PqfEQpJ/h+FrFtuYD+bKnGN9i6IyIbX32YaemSyXJiclpY/It
         DVAsQ69PUuXz7X2vMYE7VK1uvwNOqGM8H8Hvpw2dYV0WpT1/cUzZRSV4T5ioXVE4Fh
         gZsMHB9anmsDw==
Date:   Mon, 22 Nov 2021 09:44:18 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Guoqing Jiang <guoqing.jiang@linux.dev>
Cc:     haris.iqbal@ionos.com, jinpu.wang@ionos.com, jgg@ziepe.ca,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH] RDMA/rtrs: Call {get,put}_cpu_ptr to silence a debug
 kernel warning
Message-ID: <YZtKUpNhxAFS43yy@unreal>
References: <20211121142223.22887-1-guoqing.jiang@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211121142223.22887-1-guoqing.jiang@linux.dev>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Nov 21, 2021 at 10:22:23PM +0800, Guoqing Jiang wrote:
> With preemption enabled (CONFIG_DEBUG_PREEMPT=y), the following appeared
> when rnbd client tries to map remote block device.
> 
> [ 2123.221071] BUG: using smp_processor_id() in preemptible [00000000] code: bash/1733
> [ 2123.221175] caller is debug_smp_processor_id+0x17/0x20
> [ 2123.221214] CPU: 0 PID: 1733 Comm: bash Not tainted 5.16.0-rc1 #5
> [ 2123.221218] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.14.0-0-g155821a-rebuilt.opensuse.org 04/01/2014
> [ 2123.221229] Call Trace:
> [ 2123.221231]  <TASK>
> [ 2123.221235]  dump_stack_lvl+0x5d/0x78
> [ 2123.221252]  dump_stack+0x10/0x12
> [ 2123.221257]  check_preemption_disabled+0xe4/0xf0
> [ 2123.221266]  debug_smp_processor_id+0x17/0x20
> [ 2123.221271]  rtrs_clt_update_all_stats+0x3b/0x70 [rtrs_client]
> [ 2123.221285]  rtrs_clt_read_req+0xc3/0x380 [rtrs_client]
> [ 2123.221298]  ? rtrs_clt_init_req+0xe3/0x120 [rtrs_client]
> [ 2123.221321]  rtrs_clt_request+0x1a7/0x320 [rtrs_client]
> [ 2123.221340]  ? 0xffffffffc0ab1000
> [ 2123.221357]  send_usr_msg+0xbf/0x160 [rnbd_client]
> [ 2123.221370]  ? rnbd_clt_put_sess+0x60/0x60 [rnbd_client]
> [ 2123.221377]  ? send_usr_msg+0x160/0x160 [rnbd_client]
> [ 2123.221386]  ? sg_alloc_table+0x27/0xb0
> [ 2123.221395]  ? sg_zero_buffer+0xd0/0xd0
> [ 2123.221407]  send_msg_sess_info+0xe9/0x180 [rnbd_client]
> [ 2123.221413]  ? rnbd_clt_put_sess+0x60/0x60 [rnbd_client]
> [ 2123.221429]  ? blk_mq_alloc_tag_set+0x2ef/0x370
> [ 2123.221447]  rnbd_clt_map_device+0xba8/0xcd0 [rnbd_client]
> [ 2123.221462]  ? send_msg_open+0x200/0x200 [rnbd_client]
> [ 2123.221479]  rnbd_clt_map_device_store+0x3e5/0x620 [rnbd_client
> 
> To supress the calltrace, let's call get_cpu_ptr/put_cpu_ptr pair in
> rtrs_clt_update_rdma_stats to disable preemption when accessing per-cpu
> variable.
> 
> Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
> ---
>  drivers/infiniband/ulp/rtrs/rtrs-clt-stats.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt-stats.c b/drivers/infiniband/ulp/rtrs/rtrs-clt-stats.c
> index f7e459fe68be..6ff72f2b1a3a 100644
> --- a/drivers/infiniband/ulp/rtrs/rtrs-clt-stats.c
> +++ b/drivers/infiniband/ulp/rtrs/rtrs-clt-stats.c
> @@ -169,9 +169,10 @@ static inline void rtrs_clt_update_rdma_stats(struct rtrs_clt_stats *stats,
>  {
>  	struct rtrs_clt_stats_pcpu *s;
>  
> -	s = this_cpu_ptr(stats->pcpu_stats);
> +	s = get_cpu_ptr(stats->pcpu_stats);
>  	s->rdma.dir[d].cnt++;
>  	s->rdma.dir[d].size_total += size;
> +	put_cpu_ptr(stats->pcpu_stats);

I see that this_cpu_ptr() is used in many other places in rtrs-clt-stats.c, 
why do we need to change only one place?

Thanks

>  }
>  
>  void rtrs_clt_update_all_stats(struct rtrs_clt_io_req *req, int dir)
> -- 
> 2.31.1
> 
