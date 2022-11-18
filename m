Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D69262EE57
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Nov 2022 08:30:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232404AbiKRHa3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 18 Nov 2022 02:30:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234976AbiKRHa2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 18 Nov 2022 02:30:28 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8DE1205EF
        for <linux-rdma@vger.kernel.org>; Thu, 17 Nov 2022 23:30:27 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id h14so3775299pjv.4
        for <linux-rdma@vger.kernel.org>; Thu, 17 Nov 2022 23:30:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RVNtIcDW2dpyg8lGsET83ZaJ5NNQTMzDbrZHsTcgCos=;
        b=SNWpyZm8uk0ZDC+XvQax79gtul2nBur8buMBnXRTVRGyYPb2qa+m+9SYYzlLnFg7dd
         dT47G1//e4cI4xQnQctLFoWLCIJvQVpFi0oyZDPEoiN9cjjTG3khuY4NWlB+deA3He4P
         CnB8Ybg82gwB417a0x9tAZXy9IxvVltooBQpixu58fb/78+YxDumaxQti1oLB9WvZF+p
         UpW9ZJTSB39t8YX+HfFxZ6dTCMRgQhLmz0gOHmvcFZbK6OL8SLI4j7BVYe/5vo1+DGrW
         aBweJg5Pw4DwVxuaquu8WBKwGm9Ixux3fw0pwGhQp7+k/wEk0tr1B9nubLeBHN7ED/Ta
         S8rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RVNtIcDW2dpyg8lGsET83ZaJ5NNQTMzDbrZHsTcgCos=;
        b=XP8ygYups3S4XCRudAV2VnQI1QdgQ55c/W5xrzvaYiRjBr1QWsOF/Xp/FhseDF8rE8
         lEd61FSYi6S1UmSPPHhvhouA7pfj0wGv00XHFrteB3YX2VV2RidB8blBnCeDye7INRax
         NsNYR7lM0SGOEONOPder0uEP60KVa0fhGVNytMrZ+uYlb75i96z9zZ11J43E3BJ787z0
         XhOJolf59EWP0p2lb0R4JeP3VWx0q72lAoGU2rWb7NAKLgcyhMyVW+8IcZtDyieuSh9R
         qBNHTVvztmJvBVFuOZlQenA3Q1sxWfVM4HaneufYLIY5ig1UCm1yREwyXXAwS9k3xBds
         GS2g==
X-Gm-Message-State: ANoB5pmgKAc+jBv5dMjU9GElZPygNN0eTd0qnNweuH7C8F2viy+AFA6U
        kU/Xycp+gcbzbZlfJMIIxqlcSoHulTVjnlBkSWZ33eaPbfs=
X-Google-Smtp-Source: AA0mqf6HtWDuOgYzXWprZ+xy0G9eZQ4ENQyg+sIv6rs1XdXYLs2Bfb+2fyqrQpRuAViznwN+fcnPUBiAI2K2EuhkMB8=
X-Received: by 2002:a17:90b:198e:b0:20d:23ee:c041 with SMTP id
 mv14-20020a17090b198e00b0020d23eec041mr6399323pjb.140.1668756627452; Thu, 17
 Nov 2022 23:30:27 -0800 (PST)
MIME-Version: 1.0
References: <20221117123347.2576350-1-zhangxiaoxu5@huawei.com> <CAD=hENfW9oTdHmnaxtv59q+cJAYA05i40Xsp17DW9pXXjHfpFQ@mail.gmail.com>
In-Reply-To: <CAD=hENfW9oTdHmnaxtv59q+cJAYA05i40Xsp17DW9pXXjHfpFQ@mail.gmail.com>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Fri, 18 Nov 2022 15:30:15 +0800
Message-ID: <CAD=hENd=ET1ax9tPLJM1ngJs7b3POjhHWwwawZM_wUP-FqmYow@mail.gmail.com>
Subject: Re: [PATCH] RDMA/rxe: Fix null-ptr-deref in rxe_qp_do_cleanup when
 socket create failed
To:     Zhang Xiaoxu <zhangxiaoxu5@huawei.com>
Cc:     linux-rdma@vger.kernel.org, jgg@ziepe.ca, leon@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Nov 18, 2022 at 3:03 PM Zhu Yanjun <zyjzyj2000@gmail.com> wrote:
>
> On Thu, Nov 17, 2022 at 7:29 PM Zhang Xiaoxu <zhangxiaoxu5@huawei.com> wrote:
> >
> > There is a null-ptr-deref when mount.cifs over rdma:
> >
> >   BUG: KASAN: null-ptr-deref in rxe_qp_do_cleanup+0x2f3/0x360 [rdma_rxe]
> >   Read of size 8 at addr 0000000000000018 by task mount.cifs/3046
> >
> >   CPU: 2 PID: 3046 Comm: mount.cifs Not tainted 6.1.0-rc5+ #62
> >   Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-1.fc3
> >   Call Trace:
> >    <TASK>
> >    dump_stack_lvl+0x34/0x44
> >    kasan_report+0xad/0x130
> >    rxe_qp_do_cleanup+0x2f3/0x360 [rdma_rxe]
> >    execute_in_process_context+0x25/0x90
> >    __rxe_cleanup+0x101/0x1d0 [rdma_rxe]
> >    rxe_create_qp+0x16a/0x180 [rdma_rxe]
> >    create_qp.part.0+0x27d/0x340
> >    ib_create_qp_kernel+0x73/0x160
> >    rdma_create_qp+0x100/0x230
> >    _smbd_get_connection+0x752/0x20f0
> >    smbd_get_connection+0x21/0x40
> >    cifs_get_tcp_session+0x8ef/0xda0
> >    mount_get_conns+0x60/0x750
> >    cifs_mount+0x103/0xd00
> >    cifs_smb3_do_mount+0x1dd/0xcb0
> >    smb3_get_tree+0x1d5/0x300
> >    vfs_get_tree+0x41/0xf0
> >    path_mount+0x9b3/0xdd0
> >    __x64_sys_mount+0x190/0x1d0
> >    do_syscall_64+0x35/0x80
> >    entry_SYSCALL_64_after_hwframe+0x46/0xb0
> >
> > The root cause of the issue is the socket create failed in
> > rxe_qp_init_req().
> >
> > So add a null ptr check about the sk before reset the dst socket.
> >
> > Fixes: 8700e3e7c485 ("Soft RoCE driver")
> > Signed-off-by: Zhang Xiaoxu <zhangxiaoxu5@huawei.com>
> > ---
> >  drivers/infiniband/sw/rxe/rxe_qp.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/rxe/rxe_qp.c
> > index a62bab88415c..4bab641fdd42 100644
> > --- a/drivers/infiniband/sw/rxe/rxe_qp.c
> > +++ b/drivers/infiniband/sw/rxe/rxe_qp.c
> > @@ -829,7 +829,7 @@ static void rxe_qp_do_cleanup(struct work_struct *work)
> >         if (qp->resp.mr)
> >                 rxe_put(qp->resp.mr);
> >
> > -       if (qp_type(qp) == IB_QPT_RC)
> > +       if (qp_type(qp) == IB_QPT_RC && qp->sk)
> >                 sk_dst_reset(qp->sk->sk);
>
> If qp->sk is not created successfully, it need not be released.
>
> 833
> 834         free_rd_atomic_resources(qp);
> 835

I think I used an older version. The followings are the latest version.

835         free_rd_atomic_resources(qp);
836
837         if (qp->sk) {
838                 kernel_sock_shutdown(qp->sk, SHUT_RDWR);
839                 sock_release(qp->sk);
840         }

Zhu Yanjun

> 836         kernel_sock_shutdown(qp->sk, SHUT_RDWR);
>
>                if (qp->sk) {              <---add qp->sk test here
> 837           sock_release(qp->sk);
>               }

>
> Zhu Yanjun
>
> >
> >         free_rd_atomic_resources(qp);
> > --
> > 2.31.1
> >
