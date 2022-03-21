Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5FC44E1EF5
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Mar 2022 03:07:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244563AbiCUCIi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 20 Mar 2022 22:08:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238328AbiCUCIh (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 20 Mar 2022 22:08:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D0F4747044
        for <linux-rdma@vger.kernel.org>; Sun, 20 Mar 2022 19:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647828430;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ANFYFmuS8Tz+3eqS8fBUv9YrTs9SzhgRuqQIuCO0FkY=;
        b=VDa0E40Rch+jPYmtJMWE+XjMnh08cS6Aj8Ok8OM3C4Yczl/bwxB4psantUe3TspS3mlVAE
        61QeVsRH95QplJHxCHz/q5K8gwdcos1ObSLEnRBhlyEsqPugb2iKmqfSQjWK4+EwMv4CXy
        FXFs8kNxYMk51jOJgP9rrqt533tASp0=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-217-oBouyIjKOZ2s8QuOeWQ2bw-1; Sun, 20 Mar 2022 22:07:09 -0400
X-MC-Unique: oBouyIjKOZ2s8QuOeWQ2bw-1
Received: by mail-pj1-f71.google.com with SMTP id lr15-20020a17090b4b8f00b001c646e432baso10303461pjb.3
        for <linux-rdma@vger.kernel.org>; Sun, 20 Mar 2022 19:07:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ANFYFmuS8Tz+3eqS8fBUv9YrTs9SzhgRuqQIuCO0FkY=;
        b=TE4VM0/STQNaYLouxk8rp29oWdG5hIc+2tMuVCZWXTg1kUYAuc7vAJIllBCFoG5aiH
         JdMne7bg7FnVvGfZyGQEeUnpNh+3ohrvDcZ+kARacdvEhgn7besqlV9GxacotnvQh+f9
         hssR0EZntpBnMP73eNj1DbYNWCB9LZOwXeZUT1GLMCOZib2w/rK/cWaHrwU0Pts+6VPV
         2vroIwYRo/tCEfxn26d8J9ejx6fLE9Ft/mKOl94cXSruIToVp8FbpVPhZRGN1y7JTf+x
         Dsn4a4lIqS6ulUeUI80Fx4AWHM9fe7Cd6AQJhyKs6SKgkbG6g7xU5cc71itcLrScky26
         00FA==
X-Gm-Message-State: AOAM532KIce3H+ihB4QYEg5sB3AAFhThWreb0AJQs3/b9a6wzFtTAf89
        PRHECSWian1z/DvQeZrPPJUepxoRWtpcjwyLxUOuVHoYzk1naZwANemSLcuyvAdSIq4qx0jrBgD
        lhmbXSxJ7GWgh54CsJP8bjT7SQ8wLIjJ4Z9bQsg==
X-Received: by 2002:a17:902:dacc:b0:151:c216:2772 with SMTP id q12-20020a170902dacc00b00151c2162772mr10503333plx.107.1647828428351;
        Sun, 20 Mar 2022 19:07:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzkhjAEU+UMEwJ7dYsZwFLT9b66aKKxjwImfm3T9DN+x36YxqYzWBc5VBaCbMrOqrcungbQisNKnQYo39GnRaA=
X-Received: by 2002:a17:902:dacc:b0:151:c216:2772 with SMTP id
 q12-20020a170902dacc00b00151c2162772mr10503320plx.107.1647828428103; Sun, 20
 Mar 2022 19:07:08 -0700 (PDT)
MIME-Version: 1.0
References: <CAHj4cs8vnLXyddEJkV_1Dbmn7UaM4sLX=C1CN9tuA-5Mhczayw@mail.gmail.com>
 <9d9abd33-51f2-5a8e-9df9-8ffe72e3a30b@nvidia.com> <CAHj4cs_uViOtdMmFmJZ=htBXybjUP3uL3LnRR0C4PCnHWUM82A@mail.gmail.com>
 <bbb103d5-7622-dc88-07b8-1edc684d2f82@nvidia.com> <CAHj4cs_L=QHh4XeOJGfibfSJhhijS6s7RBNuLd_XetKT3hfjWQ@mail.gmail.com>
 <9ba8bfae-2363-e331-83c7-317a9456da31@grimberg.me>
In-Reply-To: <9ba8bfae-2363-e331-83c7-317a9456da31@grimberg.me>
From:   Yi Zhang <yi.zhang@redhat.com>
Date:   Mon, 21 Mar 2022 10:06:56 +0800
Message-ID: <CAHj4cs9cmOt=9++wuqJ1ehLPDJcaXJGyTKcHSjU-avWxr1CBrA@mail.gmail.com>
Subject: Re: [bug report] NVMe/IB: kmemleak observed on 5.17.0-rc5 with
 nvme-rdma testing
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Max Gurtovoy <mgurtovoy@nvidia.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
        Nitzan Carmi <nitzanc@nvidia.com>,
        Israel Rukshin <israelr@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Mar 20, 2022 at 9:00 PM Sagi Grimberg <sagi@grimberg.me> wrote:
>
>
> >>> # nvme connect to target
> >>> # nvme reset /dev/nvme0
> >>> # nvme disconnect-all
> >>> # sleep 10
> >>> # echo scan > /sys/kernel/debug/kmemleak
> >>> # sleep 60
> >>> # cat /sys/kernel/debug/kmemleak
> >>>
> >> Thanks I was able to repro it with the above commands.
> >>
> >> Still not clear where is the leak is, but I do see some non-symmetric
> >> code in the error flows that we need to fix. Plus the keep-alive timing
> >> movement.
> >>
> >> It will take some time for me to debug this.
> >>
> >> Can you repro it with tcp transport as well ?
> >
> > Yes, nvme/tcp also can reproduce it, here is the log:
> >
> > unreferenced object 0xffff8881675f7000 (size 192):
> >    comm "nvme", pid 3711, jiffies 4296033311 (age 2272.976s)
> >    hex dump (first 32 bytes):
> >      20 59 04 92 ff ff ff ff 00 00 da 13 81 88 ff ff   Y..............
> >      01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> >    backtrace:
> >      [<00000000adbc7c81>] kmem_cache_alloc_trace+0x10e/0x220
> >      [<00000000c04d85be>] blk_iolatency_init+0x4e/0x380
> >      [<00000000897ffdaf>] blkcg_init_queue+0x12e/0x610
> >      [<000000002653e58d>] blk_alloc_queue+0x400/0x840
> >      [<00000000fcb99f3c>] blk_mq_init_queue_data+0x6a/0x100
> >      [<00000000486936b6>] nvme_tcp_setup_ctrl+0x70c/0xbe0 [nvme_tcp]
> >      [<000000000bb29b26>] nvme_tcp_create_ctrl+0x953/0xbb4 [nvme_tcp]
> >      [<00000000ca3d4e54>] nvmf_dev_write+0x44e/0xa39 [nvme_fabrics]
> >      [<0000000056b79a25>] vfs_write+0x17e/0x9a0
> >      [<00000000a5af6c18>] ksys_write+0xf1/0x1c0
> >      [<00000000c035c128>] do_syscall_64+0x3a/0x80
> >      [<000000000e5ea863>] entry_SYSCALL_64_after_hwframe+0x44/0xae
> > unreferenced object 0xffff8881675f7600 (size 192):
> >    comm "nvme", pid 3711, jiffies 4296033320 (age 2272.967s)
> >    hex dump (first 32 bytes):
> >      20 59 04 92 ff ff ff ff 00 00 22 92 81 88 ff ff   Y........".....
> >      01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> >    backtrace:
> >      [<00000000adbc7c81>] kmem_cache_alloc_trace+0x10e/0x220
> >      [<00000000c04d85be>] blk_iolatency_init+0x4e/0x380
> >      [<00000000897ffdaf>] blkcg_init_queue+0x12e/0x610
> >      [<000000002653e58d>] blk_alloc_queue+0x400/0x840
> >      [<00000000fcb99f3c>] blk_mq_init_queue_data+0x6a/0x100
> >      [<000000006ca5f9f6>] nvme_tcp_setup_ctrl+0x772/0xbe0 [nvme_tcp]
> >      [<000000000bb29b26>] nvme_tcp_create_ctrl+0x953/0xbb4 [nvme_tcp]
> >      [<00000000ca3d4e54>] nvmf_dev_write+0x44e/0xa39 [nvme_fabrics]
> >      [<0000000056b79a25>] vfs_write+0x17e/0x9a0
> >      [<00000000a5af6c18>] ksys_write+0xf1/0x1c0
> >      [<00000000c035c128>] do_syscall_64+0x3a/0x80
> >      [<000000000e5ea863>] entry_SYSCALL_64_after_hwframe+0x44/0xae
> > unreferenced object 0xffff8891fb6a3600 (size 192):
> >    comm "nvme", pid 3711, jiffies 4296033511 (age 2272.776s)
> >    hex dump (first 32 bytes):
> >      20 59 04 92 ff ff ff ff 00 00 5c 1d 81 88 ff ff   Y........\.....
> >      01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> >    backtrace:
> >      [<00000000adbc7c81>] kmem_cache_alloc_trace+0x10e/0x220
> >      [<00000000c04d85be>] blk_iolatency_init+0x4e/0x380
> >      [<00000000897ffdaf>] blkcg_init_queue+0x12e/0x610
> >      [<000000002653e58d>] blk_alloc_queue+0x400/0x840
> >      [<00000000fcb99f3c>] blk_mq_init_queue_data+0x6a/0x100
> >      [<000000004a3bf20e>] nvme_tcp_setup_ctrl.cold.57+0x868/0xa5d [nvme_tcp]
> >      [<000000000bb29b26>] nvme_tcp_create_ctrl+0x953/0xbb4 [nvme_tcp]
> >      [<00000000ca3d4e54>] nvmf_dev_write+0x44e/0xa39 [nvme_fabrics]
> >      [<0000000056b79a25>] vfs_write+0x17e/0x9a0
> >      [<00000000a5af6c18>] ksys_write+0xf1/0x1c0
> >      [<00000000c035c128>] do_syscall_64+0x3a/0x80
> >      [<000000000e5ea863>] entry_SYSCALL_64_after_hwframe+0x44/0xae
>
> Looks like there is some asymmetry on blk_iolatency. It is intialized
> when allocating a request queue and exited when deleting a genhd. In
> nvme we have request queues that will never have genhd that corresponds
> to them (like the admin queue).
>
> Does this patch eliminate the issue?

Yes, the nvme/rdma nvme/tcp kmemleak fixed with the change.

> --
> diff --git a/block/blk-core.c b/block/blk-core.c
> index 94bf37f8e61d..6ccc02a41f25 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -323,6 +323,7 @@ void blk_cleanup_queue(struct request_queue *q)
>
>          blk_queue_flag_set(QUEUE_FLAG_DEAD, q);
>
> +       rq_qos_exit(q);
>          blk_sync_queue(q);
>          if (queue_is_mq(q)) {
>                  blk_mq_cancel_work_sync(q);
> diff --git a/block/genhd.c b/block/genhd.c
> index 54f60ded2ee6..10ff0606c100 100644
> --- a/block/genhd.c
> +++ b/block/genhd.c
> @@ -626,7 +626,6 @@ void del_gendisk(struct gendisk *disk)
>
>          blk_mq_freeze_queue_wait(q);
>
> -       rq_qos_exit(q);
>          blk_sync_queue(q);
>          blk_flush_integrity();
>          /*
> --
>


-- 
Best Regards,
  Yi Zhang

