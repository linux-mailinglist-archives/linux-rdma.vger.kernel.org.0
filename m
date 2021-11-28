Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9965546087B
	for <lists+linux-rdma@lfdr.de>; Sun, 28 Nov 2021 19:18:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347745AbhK1SVX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 28 Nov 2021 13:21:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbhK1STX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 28 Nov 2021 13:19:23 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E50F6C061746
        for <linux-rdma@vger.kernel.org>; Sun, 28 Nov 2021 10:16:06 -0800 (PST)
Received: from mail.kernel.org (unknown [198.145.29.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7AA7F610A1
        for <linux-rdma@vger.kernel.org>; Sun, 28 Nov 2021 18:16:06 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2C47060041;
        Sun, 28 Nov 2021 18:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638123365;
        bh=TNM7yu4eF4CklM3UuSYlo560O9ABw9r1m/qj+lObvoQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pMQyai7gZ9ybdRMp/TgTwAdAVvVVqoTAJgQ8z7heBCNTkmk2CJKlflq6s+B2WubJ/
         JEQ7o0HOQXK/IiytkCVSD7Y4HMsronpQE4zkEpRdOINxrPzu8wEqg/rocWNsys1Zih
         Y21ZFBTwjUdXXCUH7TKgsVVQkY7o4L6ZuPhFK1bakQcs/81ezqqOP1zHx4lC90uCnF
         mm5DEzJ78IotZnZPdfQDJh3ma4QIxZytmm8Rx6+EVuPb7Fbipu/R2ilQyCJ64J82W8
         Vyw+04sqrc55ckvyIOyNZsN+CcUBJY1C2MiXQxvFRd6IjNv81ZlseMDqCooockgk8x
         OZQIz7whJC/Wg==
Date:   Sun, 28 Nov 2021 20:16:01 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Guoqing Jiang <guoqing.jiang@linux.dev>
Cc:     jinpu.wang@ionos.com, haris.iqbal@ionos.com, jgg@ziepe.ca,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH V2] RDMA/rtrs: Call {get,put}_cpu_ptr to silence a debug
 kernel warning
Message-ID: <YaPHYfib1GDjazG1@unreal>
References: <20211128133501.38710-1-guoqing.jiang@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211128133501.38710-1-guoqing.jiang@linux.dev>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Nov 28, 2021 at 09:35:01PM +0800, Guoqing Jiang wrote:
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
> While at it, let's make the similar change in rtrs_clt_update_wc_stats.
> And for rtrs_clt_inc_failover_cnt, though it was only called inside rcu
> section, but it still can be preempted in case CONFIG_PREEMPT_RCU is
> enabled, so change it to {get,put}_cpu_ptr pair either.
> 
> Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
> ---
> V2: also make the change in rtrs_clt_update_wc_stats and rtrs_clt_inc_failover_cnt
> 
>  drivers/infiniband/ulp/rtrs/rtrs-clt-stats.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
