Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A4DE4B100A
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Feb 2022 15:17:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237351AbiBJORE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 10 Feb 2022 09:17:04 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242719AbiBJORE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 10 Feb 2022 09:17:04 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACF161B1
        for <linux-rdma@vger.kernel.org>; Thu, 10 Feb 2022 06:17:04 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id q22so8204773ljh.7
        for <linux-rdma@vger.kernel.org>; Thu, 10 Feb 2022 06:17:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/80eX9ACRvjav2JN/BwXjYtDsUENuLHGKwRNrvFTYD0=;
        b=RLfzMVyFSfxiwYu0BM7497WyzBrvnDqgb8GCoiLroOJzbHe6uDP856a7ltgiDBwgnS
         /LRESFETmGpwZpW8feTkQl3mjmt0YvOJjuUOhswn6OjHe3nk00b26fRzNN1t5ghSLD9c
         FnHhL1DlcdaS/3wnsr2967GxGRLwTQeglLaGNILLM+mS9xtMElpcqwIRMx10f3S65zOo
         POxBUaQ3J770qeO8ENPob6A2ZBY38U5lmorWPJGJTC2RxpjJs/HpxJMcWnYX1BVFpG+R
         XUKuQA6zZdwBz/4vDmpv/ox3aJ9TMK1qZGowMlRSYXfEOfB+FQu34e3iSV1tSNdIf6J3
         V7Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/80eX9ACRvjav2JN/BwXjYtDsUENuLHGKwRNrvFTYD0=;
        b=Eiu/NWFxdH7ofBqUeZ9xjlU5T/LiSC7Ps/w1AwCJ/Td7qMVTqDkLrhZ5y3OPF6VHGL
         FE4Lb0TJlf2hkUuhuVh5010u0wNf966QnMbygXCQnmmUESbH1Rm8sbqqLCUDx2P1xCqi
         3D728HfFJs1KPUpSI8gK/EVxrzxUbZbFyMzPzi0yCVnNICB0DSNdEx/OGSOrpq/C//dk
         YWnlscqB0urXg7asNGQRnzvSvUt24ehXVY6hjC3QuocOmchFEfVbAhNcq9ym0Ej1muqd
         jr4HfwKE5X6cCa6yckFFs0fhsgdvuxiB94IFj044J7XGPkd39PYUjx93bgwKcvTmNFjq
         0McQ==
X-Gm-Message-State: AOAM5303Td5j/ZeArz1vNlP20t+CF9FhRL69xFQpc3wmJbGGqj7yZQBh
        mo500gGZOki80XRgQsoo0NtLgHNxUCPt3lluLmTogrf6
X-Google-Smtp-Source: ABdhPJzyypRkPP7UCYGV4g3fru1A/5618rehYfwSQyI6FGruW7VBkMySSxsWGMW4T2v/LWsOuDxn3t6CgdhJv9xYD2Y=
X-Received: by 2002:a2e:914d:: with SMTP id q13mr2628533ljg.442.1644502622260;
 Thu, 10 Feb 2022 06:17:02 -0800 (PST)
MIME-Version: 1.0
References: <20220210073655.42281-1-guoqing.jiang@linux.dev> <20220210073655.42281-3-guoqing.jiang@linux.dev>
In-Reply-To: <20220210073655.42281-3-guoqing.jiang@linux.dev>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Thu, 10 Feb 2022 22:16:50 +0800
Message-ID: <CAD=hENd6GiLggA5L9p_jQk9MA4ckh3vNB=EKXZ6BZxKrgNCoAg@mail.gmail.com>
Subject: Re: [PATCH 2/3] RDMA/rxe: Replace write_lock_bh with
 write_lock_irqsave in __rxe_drop_index
To:     Guoqing Jiang <guoqing.jiang@linux.dev>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Feb 10, 2022 at 3:37 PM Guoqing Jiang <guoqing.jiang@linux.dev> wrote:
>
> Same as __rxe_add_index, the lock need to be fully IRQ safe, otherwise
> below calltrace appears.
>
> [  250.757218] ------------[ cut here ]------------
> [  250.758997] WARNING: CPU: 6 PID: 90 at kernel/softirq.c:363 __local_bh_enable_ip+0xb1/0x110
> [ ... ]
> [  250.769900] CPU: 6 PID: 90 Comm: kworker/u16:3 Kdump: loaded Tainted: G           OEL    5.17.0-rc3-57-default #17
> [  250.770413] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a-rebuilt.opensuse.org 04/01/2014
> [  250.770955] Workqueue: ib_mad1 timeout_sends [ib_core]
> [  250.771400] RIP: 0010:__local_bh_enable_ip+0xb1/0x110
> [  250.771678] Code: e8 54 ae 04 00 e8 7f 4e 20 00 fb 66 0f 1f 44 00 00 65 8b 05 b1 03 b3 60 85 c0 74 51 5b 5d c3 65 8b 05 3f 0f b3 60 85 c0 75 8e <0f> 0b eb 8a e8 76 4c 20
>  00 eb 99 48 89 ef e8 9c 8d 0b 00 eb a2 48
> [  250.772562] RSP: 0018:ffff88801b2e7ae8 EFLAGS: 00010046
> [  250.772845] RAX: 0000000000000000 RBX: 0000000000000201 RCX: dffffc0000000000
> [  250.773197] RDX: 0000000000000007 RSI: 0000000000000201 RDI: ffffffffa1d5dbac
> [  250.773548] RBP: ffffffffc15c4da7 R08: ffffffff9f5059da R09: 0000000000000000
> [  250.773911] R10: 0000000000000001 R11: 0000000000000001 R12: 0000000000000000
> [  250.774261] R13: ffff888017c0e850 R14: ffff888016f18000 R15: 0000000000000005
> [  250.774614] FS:  0000000000000000(0000) GS:ffff888104f00000(0000) knlGS:0000000000000000
> [  250.775009] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  250.775296] CR2: 00007f7ea9e84fe8 CR3: 000000000216e002 CR4: 0000000000770ee0
> [  250.775651] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [  250.784298] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [  250.791093] PKRU: 55555554
> [  250.796587] Call Trace:
> [  250.801957]  <TASK>
> [  250.807269]  rxe_destroy_ah+0x17/0x60 [rdma_rxe]
> [  250.812682]  rdma_destroy_ah_user+0x5a/0xb0 [ib_core]
> [  250.818242]  cm_free_priv_msg+0x6e/0x130 [ib_cm]
> [  250.823738]  cm_send_handler+0x1f6/0x480 [ib_cm]
> [  250.829176]  ? ib_cm_insert_listen+0x100/0x100 [ib_cm]
> [  250.834654]  ? lockdep_hardirqs_on_prepare+0x129/0x220
> [  250.840111]  ? _raw_spin_unlock_irqrestore+0x2d/0x60
> [  250.845514]  timeout_sends+0x310/0x420 [ib_core]
> [  250.851007]  ? ib_send_mad+0x850/0x850 [ib_core]
> [  250.856471]  ? mark_held_locks+0x24/0x90
> [  250.861679]  ? lock_is_held_type+0xe4/0x140
> [  250.866835]  process_one_work+0x5a8/0xa80
> [  250.871949]  ? lock_release+0x450/0x450
> [  250.877061]  ? pwq_dec_nr_in_flight+0x100/0x100
> [  250.882144]  ? rwlock_bug.part.0+0x60/0x60
> [  250.887093]  ? _raw_spin_lock_irq+0x54/0x60
> [  250.891960]  worker_thread+0x2b5/0x760
> [  250.896691]  ? process_one_work+0xa80/0xa80
> [  250.901265]  kthread+0x169/0x1a0
> [  250.905722]  ? kthread_complete_and_exit+0x20/0x20
> [  250.910094]  ret_from_fork+0x1f/0x30
> [  250.914381]  </TASK>
> [  250.918441] irq event stamp: 21397
> [  250.922427] hardirqs last  enabled at (21395): [<ffffffffa0579c6d>] _raw_spin_unlock_irqrestore+0x2d/0x60
> [  250.926476] hardirqs last disabled at (21396): [<ffffffffa05799a4>] _raw_spin_lock_irq+0x54/0x60
> [  250.930443] softirqs last  enabled at (21370): [<ffffffff9f5319f8>] process_one_work+0x5a8/0xa80
> [  250.934329] softirqs last disabled at (21397): [<ffffffffc15c1b60>] __rxe_drop_index+0x20/0x40 [rdma_rxe]
> [  250.938120] ---[ end trace 0000000000000000 ]---
>
> Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>

Acked-by: Zhu Yanjun <zyjzyj2000@gmail.com>

Zhu Yanjun

> ---
>  drivers/infiniband/sw/rxe/rxe_pool.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
> index b4444785da52..026b60363fd6 100644
> --- a/drivers/infiniband/sw/rxe/rxe_pool.c
> +++ b/drivers/infiniband/sw/rxe/rxe_pool.c
> @@ -320,10 +320,11 @@ void __rxe_drop_index_locked(struct rxe_pool_elem *elem)
>  void __rxe_drop_index(struct rxe_pool_elem *elem)
>  {
>         struct rxe_pool *pool = elem->pool;
> +       unsigned long flags;
>
> -       write_lock_bh(&pool->pool_lock);
> +       write_lock_irqsave(&pool->pool_lock, flags);
>         __rxe_drop_index_locked(elem);
> -       write_unlock_bh(&pool->pool_lock);
> +       write_unlock_irqrestore(&pool->pool_lock, flags);
>  }
>
>  void *rxe_alloc_locked(struct rxe_pool *pool)
> --
> 2.26.2
>
