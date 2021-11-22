Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BBEB4589C2
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Nov 2021 08:26:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238735AbhKVH3N (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 22 Nov 2021 02:29:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238732AbhKVH3N (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 22 Nov 2021 02:29:13 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30DD7C061574
        for <linux-rdma@vger.kernel.org>; Sun, 21 Nov 2021 23:26:07 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id o20so28165404eds.10
        for <linux-rdma@vger.kernel.org>; Sun, 21 Nov 2021 23:26:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4PJWeWjLCAPB9rbDQ+FRsMH/gx68JQVqUsuH2tNlF+g=;
        b=VLGjCD4V9VcLN5Zeeui8j8RRkSg1OIpekZR3cbrNWbffpxZWBM1OuengqIOALNjPMA
         cifHAX7Ic8MZxO/eI+B+uSXuulQ6mG1sI5+SHzFTBAtBYGTDEoO73LCHB0YeAQ1TWCXI
         iWbulXzWvf8F3sJiGwCIlUfOiUwieugHKgU7Q9Pue8/PHc5PzQ1/c07zD5j/hQD77V33
         U4KXy+2TCzyBlCLQ0qeOFSO9Ytt9O2IycIEv9BXsFX3Jou5AN76kSzEe+zc4fF43nPP/
         oWU/Pqs3a1qi4jMl+QvbAolJvoseaY9M90A44ea9x0VEKU/4jbkIKOlZtu3rWmQl41Rw
         WMpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4PJWeWjLCAPB9rbDQ+FRsMH/gx68JQVqUsuH2tNlF+g=;
        b=o/cy/k7SPLYx98RwSb0v8YGK8GoN8wdxcYxCDitq3O1bwFvCeF6sagmUEwhwG9bsh0
         qGXjvERz96qMsrv4HnlivmRLYaH967jzUHoxrWPXHXuKGayZNsQwCZsfRoM1uGN4AQsf
         sNyr+4GRVZcNKNOGzJDAkiw7DATv/Zg7VAytX4HCV7OEusmYPdTOWbNu6oSiQe4hF2i2
         sCaSXttXcG2r0xy6xLEgR2H3VdtPVyx530RPrUfvT3+QyTvUXUCxCgghI7q5+5f238eN
         CN0gb3UdQrld/2O/APUD6ciyr9Sh5LXFzHZ0E32PCiKR0UHYalPbHRaa+cenYJP/81Mx
         jJDA==
X-Gm-Message-State: AOAM533n51X+pBeJImI+phDi0J7R6/4wfDkHVAc22o9oDByE6nRFns/D
        /16GLrPrXbkH44HvMQEiQmNDuL1XjiV90kNc50dp2Q==
X-Google-Smtp-Source: ABdhPJxYrdWlFxZgMo7J0I+JaguAiaLwt8l5eKsXmSO50aLQhDWEw8ueLtf6UUIGvWALCEYBU3XR2nRj2LcTPOAJTbE=
X-Received: by 2002:a17:906:a1da:: with SMTP id bx26mr38497288ejb.558.1637565965638;
 Sun, 21 Nov 2021 23:26:05 -0800 (PST)
MIME-Version: 1.0
References: <20211121142223.22887-1-guoqing.jiang@linux.dev>
In-Reply-To: <20211121142223.22887-1-guoqing.jiang@linux.dev>
From:   Jinpu Wang <jinpu.wang@ionos.com>
Date:   Mon, 22 Nov 2021 08:25:54 +0100
Message-ID: <CAMGffEk7gjTPR_be0nuu0TnQ6R07zzc7x64Fm7g75HpQPFvA-A@mail.gmail.com>
Subject: Re: [PATCH] RDMA/rtrs: Call {get,put}_cpu_ptr to silence a debug
 kernel warning
To:     Guoqing Jiang <guoqing.jiang@linux.dev>
Cc:     haris.iqbal@ionos.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Nov 21, 2021 at 3:22 PM Guoqing Jiang <guoqing.jiang@linux.dev> wrote:
>
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
Looks good to me.
Acked-by: Jack Wang <jinpu.wang@ionos.com>

Thanks Guoqing.
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
>         struct rtrs_clt_stats_pcpu *s;
>
> -       s = this_cpu_ptr(stats->pcpu_stats);
> +       s = get_cpu_ptr(stats->pcpu_stats);
>         s->rdma.dir[d].cnt++;
>         s->rdma.dir[d].size_total += size;
> +       put_cpu_ptr(stats->pcpu_stats);
>  }
>
>  void rtrs_clt_update_all_stats(struct rtrs_clt_io_req *req, int dir)
> --
> 2.31.1
>
