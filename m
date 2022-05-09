Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BB7751F6AD
	for <lists+linux-rdma@lfdr.de>; Mon,  9 May 2022 10:42:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233087AbiEIIMr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 9 May 2022 04:12:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237811AbiEIIHL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 9 May 2022 04:07:11 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF9451B1F5F
        for <linux-rdma@vger.kernel.org>; Mon,  9 May 2022 01:03:17 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id d15so13871213lfk.5
        for <linux-rdma@vger.kernel.org>; Mon, 09 May 2022 01:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lSqXgNhENnH5HlLjoQzFpCuci15/SNgGOYPfmCwhWos=;
        b=pZXkaYBNue/esw2gy9k5iTWrw8rdY6864TmxGfLsP94ipuD3BdEQ81JNCulI5A6dm1
         F9UrgwQrYX3K6HyJ9vHK7yAaiquXoZ4n6RlryAZqOqu68cDOwo+YGPVa/nxLazUvXM+z
         jZ5GOUd/V9hezmYr2Hplq+yS9osQcpIr0Ody+EL4U6GuBBkUq+PZ6puOvqljwr527Zu9
         zij6DaT5v1xjrtpTiQTKOyyRwMCy9cCW0buiN8qVBXjDcPbpVrv7oMsKvyl8E51hRYu3
         aUCg9lFCfupPhkHtH9DoRn/RSCMsSbV9wqtIsgEAun6IXModxp5X/sDU9IxnN3nIDoMt
         /v4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lSqXgNhENnH5HlLjoQzFpCuci15/SNgGOYPfmCwhWos=;
        b=txZarEIWsk7nHTSvXA1bOPxLcA2jTHJytOkojRRRyFHlrSzaKr+qN5yXdirbGbW2qW
         6kVRsK3az3ql/6rx/m06ZYDafgOCVNiuMVsz/cPe1Qr9Ro7QHYNdm65YTzjNJ46fT4zl
         6sEm2ok1PSvzk4kFW/usQjXos9fIdC+DbRS92+tjGIPpzu3CKbvtwfK/vBCl6gPXaiqU
         iodNbFobXt/DVdM6QBWbcWhriWuOWa6tlh+mdG0s13hsx6rMrVARqGlpAO85deLl0ehY
         FZfrRVhqPucRb7TzzVp8WEqHYeDcuXbWCre78l6d+tdbAsF7M5yNFmb2Sn9fvjfBreVe
         jKcg==
X-Gm-Message-State: AOAM533gegiNzgXcyGwQJUaq+CO2+Kz2Ad19FXv+Vq65V2xsT/eRwFYh
        t+aYnAfgV3iiHObF/F/qxOKaUdT8MBDpoIClT98=
X-Google-Smtp-Source: ABdhPJzG9A72vTpQGW4eyg5x9BSSc6AiNS/lexNpmrl/6R/o0akPLzFW15/V5DvkEuMsmuKHrngCJgQJKWdGRBUMYCM=
X-Received: by 2002:a05:6512:34cc:b0:472:5c4e:34cb with SMTP id
 w12-20020a05651234cc00b004725c4e34cbmr11945896lfr.94.1652083291334; Mon, 09
 May 2022 01:01:31 -0700 (PDT)
MIME-Version: 1.0
References: <e7c31ebb-60c0-cd57-2009-5e9383ecc472@gmail.com>
 <cf8b9980-3965-a4f6-07e0-d4b25755b0db@acm.org> <4b0153c7-a8e9-98de-26ae-d421434a116d@linux.dev>
 <20220507012952.GH49344@nvidia.com>
In-Reply-To: <20220507012952.GH49344@nvidia.com>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Mon, 9 May 2022 16:01:19 +0800
Message-ID: <CAD=hENd1kTsy42qDmMjcAhB_rO7aa7eP-G377R2DDE7qkqRB3Q@mail.gmail.com>
Subject: Re: Apparent regression in blktests since 5.18-rc1+
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Yanjun Zhu <yanjun.zhu@linux.dev>,
        Bart Van Assche <bvanassche@acm.org>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Bernard Metzler <bmt@zurich.ibm.com>
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

On Sat, May 7, 2022 at 9:29 AM Jason Gunthorpe <jgg@nvidia.com> wrote:
>
> On Sat, May 07, 2022 at 08:29:31AM +0800, Yanjun Zhu wrote:
>
> > > If I try to run the SRP test 002 with the soft-RoCE driver, the
> > > following appears:
> > >
> > > [  749.901966] ================================
> > > [  749.903638] WARNING: inconsistent lock state
> > > [  749.905376] 5.18.0-rc5-dbg+ #1 Not tainted
> > > [  749.907039] --------------------------------
> > > [  749.908699] inconsistent {SOFTIRQ-ON-W} -> {IN-SOFTIRQ-W} usage.
> > > [  749.910646] ksoftirqd/5/40 [HC0[0]:SC1[1]:HE0:SE0] takes:
> > > [  749.912499] ffff88818244d350 (&xa->xa_lock#14){+.?.}-{2:2}, at:
> > > rxe_pool_get_index+0x73/0x170 [rdma_rxe]
> > > [  749.914691] {SOFTIRQ-ON-W} state was registered at:
> > > [  749.916648]   __lock_acquire+0x45b/0xce0
> > > [  749.918599]   lock_acquire+0x18a/0x450
> > > [  749.920480]   _raw_spin_lock+0x34/0x50
> > > [  749.922580]   __rxe_add_to_pool+0xcc/0x140 [rdma_rxe]
> > > [  749.924583]   rxe_alloc_pd+0x2d/0x40 [rdma_rxe]
> > > [  749.926394]   __ib_alloc_pd+0xa3/0x270 [ib_core]
> > > [  749.928579]   ib_mad_port_open+0x44a/0x790 [ib_core]
> > > [  749.930640]   ib_mad_init_device+0x8e/0x110 [ib_core]
> > > [  749.932495]   add_client_context+0x26a/0x330 [ib_core]
> > > [  749.934302]   enable_device_and_get+0x169/0x2b0 [ib_core]
> > > [  749.936217]   ib_register_device+0x26f/0x330 [ib_core]
> > > [  749.938020]   rxe_register_device+0x1b4/0x1d0 [rdma_rxe]
> > > [  749.939794]   rxe_add+0x8c/0xc0 [rdma_rxe]
> > > [  749.941552]   rxe_net_add+0x5b/0x90 [rdma_rxe]
> > > [  749.943356]   rxe_newlink+0x71/0x80 [rdma_rxe]
> > > [  749.945182]   nldev_newlink+0x21e/0x370 [ib_core]
> > > [  749.946917]   rdma_nl_rcv_msg+0x200/0x410 [ib_core]
> > > [  749.948657]   rdma_nl_rcv+0x140/0x220 [ib_core]
> > > [  749.950373]   netlink_unicast+0x307/0x460
> > > [  749.952063]   netlink_sendmsg+0x422/0x750
> > > [  749.953672]   __sys_sendto+0x1c2/0x250
> > > [  749.955281]   __x64_sys_sendto+0x7f/0x90
> > > [  749.956849]   do_syscall_64+0x35/0x80
> > > [  749.958353]   entry_SYSCALL_64_after_hwframe+0x44/0xae
> > > [  749.959942] irq event stamp: 1411849
> > > [  749.961517] hardirqs last  enabled at (1411848): [<ffffffff810cdb28>]
> > > __local_bh_enable_ip+0x88/0xf0
> > > [  749.963338] hardirqs last disabled at (1411849): [<ffffffff81ebf24d>]
> > > _raw_spin_lock_irqsave+0x5d/0x60
> > > [  749.965214] softirqs last  enabled at (1411838): [<ffffffff82200467>]
> > > __do_softirq+0x467/0x6e1
> > > [  749.967027] softirqs last disabled at (1411843): [<ffffffff810cd947>]
> > > run_ksoftirqd+0x37/0x60
> > To this, Please use this patch series
> > news://nntp.lore.kernel.org:119/20220422194416.983549-1-yanjun.zhu@linux.dev
>
> No, that is the wrong fix for this. This is mismatched lock modes with
> the lookup path in the BH, the fix is to consistently use BH locking
> with the xarray everwhere or to use RCU. I'm expecting to go with
> Bob's RCU patch.

I delved into the above calltrace. It is the same with the problem in
the link https://www.spinics.net/lists/linux-rdma/msg109875.html
So IMHO, the fix in this link
https://patchwork.kernel.org/project/linux-rdma/patch/20220422194416.983549-1-yanjun.zhu@linux.dev/
should fix this problem.

And if we want to use BH, it is very possible that the problem in the
link https://patchwork.kernel.org/project/linux-rdma/patch/20220210073655.42281-4-guoqing.jiang@linux.dev/
will occur.

And to the RCU patch series in the link
https://patchwork.kernel.org/project/linux-rdma/patch/20220421014042.26985-2-rpearsonhpe@gmail.com/
I also delved into this patch series. And I found that an atomic
problem will occur if we apply RCU patches onto V5.18-rc5.
And because of the atomic problem, I can not verify that this RCU
patches can fix this problem currently.

Zhu Yanjun

>
> We still need a proper patch for the AH problem.
>
> Jason
