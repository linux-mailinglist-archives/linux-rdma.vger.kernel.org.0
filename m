Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5C524B0E6D
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Feb 2022 14:29:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242227AbiBJN3s (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 10 Feb 2022 08:29:48 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242232AbiBJN3r (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 10 Feb 2022 08:29:47 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BC88BDD
        for <linux-rdma@vger.kernel.org>; Thu, 10 Feb 2022 05:29:47 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id i17so10399317lfg.11
        for <linux-rdma@vger.kernel.org>; Thu, 10 Feb 2022 05:29:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p71fuOwvKf7srUUOObP9mgE9D4Vzqik7NlOgFnlvDsc=;
        b=AeI7NXgyGRZtULw2+HyuB47hxZObAd7NctoodD+VIZ3Hpq36IbZAGOEny7NuL58JSE
         0w2aKb7K3tYQZ3LEutYvtzHAFSpyGnqp8jojt8mb/FhsiBgNe2VuKPt75YmabOtuIFSy
         lgL8TU+jzwnpiGJoPe6THVLE+6Ox/W+dEO++FzHPxCt/Lu+iL+TmUcgg4DfMl56KvZWh
         R9jI6WcWeq7caeNIKD2qZLYmGhBIVLqCGF0/vCASVDGggl19X8WMraqYRVnub/x6JQE7
         BNF5C+9+Hx/zdpQp9BB6PxYRwCDrFhxxRfdJT+CwsBeXesEXfs/DYNaMelNajkeJLcBj
         oP4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p71fuOwvKf7srUUOObP9mgE9D4Vzqik7NlOgFnlvDsc=;
        b=gjz+YMbFV9JYljGxtJ6ge/Dzflvt2T7HbUk+c4aQIK/l1OnEN5xJ1yLSCjoHgrex8S
         LPp9/U7NCRPqqa4UAPc7VoFN7VOO7GtlhjxC8liUa/kz8lyjYYYaFubjc4r/IZDJaq+8
         FxGh5b0Or61TOjyAy/vob6MKDU6ykgxzrI9jOpQnnJWmkHv6iIuR//rwa8BxOjtQwBXn
         RPOYrfn4fUbuTn5OKe8loKDjctRAZLtAPA0JZSq06JNnneYTF9qS4a4ghXI/J0qNXCjC
         DSvomHAksPX5tjn31DJrjwRHJZ0HKCXdzACU4BxJdlQhIx7wxTjCP+1ROPm0BuSvnF5V
         ZOfg==
X-Gm-Message-State: AOAM531nxRBHLZaIPjGydeUcL/mbvKc5Hy0VZ1GBeBYj99+OKh+wXzDV
        8UcLTO04w7IWTYA2HT2ZLVjWPYWFiS9mWlVc/Nw=
X-Google-Smtp-Source: ABdhPJwEL7Rtu30J/VB9iJMvWwJ27VnipfRdD+7G27MTamocXppQx9zYP57iNBk1OfpUraEpBDMWteV9chMgL1GolbE=
X-Received: by 2002:a05:6512:3f90:: with SMTP id x16mr5240049lfa.666.1644499785499;
 Thu, 10 Feb 2022 05:29:45 -0800 (PST)
MIME-Version: 1.0
References: <20220210073655.42281-1-guoqing.jiang@linux.dev> <20220210073655.42281-2-guoqing.jiang@linux.dev>
In-Reply-To: <20220210073655.42281-2-guoqing.jiang@linux.dev>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Thu, 10 Feb 2022 21:29:33 +0800
Message-ID: <CAD=hENfLjt885C46NC0M=e7pFhEY8gf+QRnEAuyqpU-tHS22Fw@mail.gmail.com>
Subject: Re: [PATCH 1/3] RDMA/rxe: Replace write_lock_bh with
 write_lock_irqsave in __rxe_add_index
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
> We need to make the lock fully IRQ safe, otherwise below calltrace appears.
>
> [  495.697917] ------------[ cut here ]------------
> [  495.698316] WARNING: CPU: 5 PID: 67 at kernel/softirq.c:363 __local_bh_enable_ip+0xb1/0x110
> [ ... ]
> [  495.702594] CPU: 5 PID: 67 Comm: kworker/5:1 Kdump: loaded Tainted: G            EL    5.17.0-rc3-57-default #17
> [  495.702856] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a-rebuilt.opensuse.org 04/01/2014
> [  495.703144] Workqueue: ib_cm cm_work_handler [ib_cm]
> [  495.708238] RIP: 0010:__local_bh_enable_ip+0xb1/0x110
> [  495.713197] Code: e8 54 ae 04 00 e8 7f 4e 20 00 fb 66 0f 1f 44 00 00 65 8b 05 b1 03 f3 51 85 c0 74 51 5b 5d c3 65 8b 05 3f 0f f3 51 85 c0 75 8e <0f> 0b eb 8a e8 76 4c 20 00 eb 99 48 89 ef e8 9c 8d 0b 00 eb a2 48
> [  495.723257] RSP: 0018:ffff888100f9f1d8 EFLAGS: 00010046
> [  495.728296] RAX: 0000000000000000 RBX: 0000000000000201 RCX: dffffc0000000000
> [  495.733441] RDX: 0000000000000007 RSI: 0000000000000201 RDI: ffffffffb095dbac
> [  495.738546] RBP: ffffffffc1761aa5 R08: ffffffffae1059da R09: 0000000000000000
> [  495.743689] R10: 0000000000000001 R11: 0000000000000001 R12: ffff88800f6cd380
> [  495.748913] R13: 0000000000000000 R14: ffff8880031e1ae0 R15: ffff8880031e1a28
> [  495.754091] FS:  0000000000000000(0000) GS:ffff888109880000(0000) knlGS:0000000000000000
> [  495.759217] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  495.764434] CR2: 00007f69a232e830 CR3: 00000000b6a16005 CR4: 0000000000770ee0
> [  495.769531] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [  495.774505] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [  495.779449] PKRU: 55555554
> [  495.784331] Call Trace:
> [  495.789157]  <TASK>
> [  495.793988]  __rxe_add_index+0x35/0x40 [rdma_rxe]
> [  495.798938]  rxe_create_ah+0xa9/0x1e0 [rdma_rxe]
> [  495.804007]  _rdma_create_ah+0x28a/0x2c0 [ib_core]
> [  495.809328]  ? ib_create_srq_user+0x2c0/0x2c0 [ib_core]
> [  495.814439]  ? lock_acquire+0x182/0x410
> [  495.819558]  ? lock_release+0x450/0x450
> [  495.824880]  rdma_create_ah+0xe1/0x1a0 [ib_core]
> [  495.830101]  ? _rdma_create_ah+0x2c0/0x2c0 [ib_core]
> [  495.835261]  ? rwlock_bug.part.0+0x60/0x60
> [  495.840418]  cm_alloc_msg+0xb4/0x260 [ib_cm]
> [  495.845528]  cm_alloc_priv_msg+0x29/0x70 [ib_cm]
> [  495.850656]  ib_send_cm_rep+0x7c/0x860 [ib_cm]
> [  495.855677]  ? lock_is_held_type+0xe4/0x140
> [  495.860761]  rdma_accept+0x44c/0x5e0 [rdma_cm]
> [  495.865817]  ? cma_rep_recv+0x330/0x330 [rdma_cm]
> [  495.870658]  ? rcu_read_lock_sched_held+0x3f/0x60
> [  495.875388]  ? trace_kmalloc+0x29/0xd0
> [  495.879807]  ? __kmalloc+0x1c5/0x3a0
> [  495.884114]  ? rtrs_iu_alloc+0x12b/0x260 [rtrs_core]
> [  495.888343]  rtrs_srv_rdma_cm_handler+0x7ba/0xcf0 [rtrs_server]
> [  495.892503]  ? rtrs_srv_inv_rkey_done+0x100/0x100 [rtrs_server]
> [  495.896532]  ? find_held_lock+0x85/0xa0
> [  495.900417]  ? lock_release+0x24e/0x450
> [  495.904174]  ? rdma_restrack_add+0x9c/0x220 [ib_core]
> [  495.907939]  ? rcu_read_lock_sched_held+0x3f/0x60
> [  495.911638]  cma_cm_event_handler+0x77/0x2c0 [rdma_cm]
> [  495.915225]  cma_ib_req_handler+0xbd5/0x23f0 [rdma_cm]
> [  495.918702]  ? cma_cancel_operation+0x1f0/0x1f0 [rdma_cm]
> [  495.922039]  ? lockdep_lock+0xb4/0x170
> [  495.925195]  ? _find_first_zero_bit+0x28/0x50
> [  495.928525]  ? mark_held_locks+0x65/0x90
> [  495.931787]  cm_process_work+0x2f/0x210 [ib_cm]
> [  495.934952]  ? _raw_spin_unlock_irq+0x35/0x50
> [  495.937930]  ? cm_queue_work_unlock+0x40/0x110 [ib_cm]
> [  495.940899]  cm_req_handler+0xf7f/0x2030 [ib_cm]
> [  495.943738]  ? cm_lap_handler+0xba0/0xba0 [ib_cm]
> [  495.946708]  ? lockdep_hardirqs_on_prepare+0x220/0x220
> [  495.949600]  cm_work_handler+0x6ce/0x37c0 [ib_cm]
> [  495.952395]  ? lock_acquire+0x182/0x410
> [  495.955245]  ? lock_release+0x450/0x450
> [  495.958005]  ? lock_downgrade+0x3c0/0x3c0
> [  495.960695]  ? ib_cm_init_qp_attr+0xa90/0xa90 [ib_cm]
> [  495.963323]  ? mark_held_locks+0x24/0x90
> [  495.965902]  ? lock_is_held_type+0xe4/0x140
> [  495.968597]  process_one_work+0x5a8/0xa80
> [  495.971155]  ? lock_release+0x450/0x450
> [  495.973812]  ? pwq_dec_nr_in_flight+0x100/0x100
> [  495.976426]  ? rwlock_bug.part.0+0x60/0x60
> [  495.979006]  ? _raw_spin_lock_irq+0x54/0x60
> [  495.981600]  worker_thread+0x2b5/0x760
> [  495.984272]  ? process_one_work+0xa80/0xa80
> [  495.986832]  kthread+0x169/0x1a0
> [  495.989348]  ? kthread_complete_and_exit+0x20/0x20
> [  495.992032]  ret_from_fork+0x1f/0x30
> [  495.994622]  </TASK>
> [  495.997126] irq event stamp: 52525
> [  495.999637] hardirqs last  enabled at (52523): [<ffffffffaf179c6d>] _raw_spin_unlock_irqrestore+0x2d/0x60
> [  496.002367] hardirqs last disabled at (52524): [<ffffffffaf179a10>] _raw_spin_lock_irqsave+0x60/0x70
> [  496.005109] softirqs last  enabled at (52514): [<ffffffffc1764b58>] rxe_post_recv+0xb8/0x120 [rdma_rxe]
> [  496.007888] softirqs last disabled at (52525): [<ffffffffc1761a92>] __rxe_add_index+0x22/0x40 [rdma_rxe]
> [  496.010698] ---[ end trace 0000000000000000 ]---
>
> Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
Acked-by: Zhu Yanjun <zyjzyj2000@gmail.com>

Zhu Yanjun
> ---
>  drivers/infiniband/sw/rxe/rxe_pool.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
> index 63c594173565..b4444785da52 100644
> --- a/drivers/infiniband/sw/rxe/rxe_pool.c
> +++ b/drivers/infiniband/sw/rxe/rxe_pool.c
> @@ -300,10 +300,11 @@ int __rxe_add_index(struct rxe_pool_elem *elem)
>  {
>         struct rxe_pool *pool = elem->pool;
>         int err;
> +       unsigned long flags;
>
> -       write_lock_bh(&pool->pool_lock);
> +       write_lock_irqsave(&pool->pool_lock, flags);
>         err = __rxe_add_index_locked(elem);
> -       write_unlock_bh(&pool->pool_lock);
> +       write_unlock_irqrestore(&pool->pool_lock, flags);
>
>         return err;
>  }
> --
> 2.26.2
>
