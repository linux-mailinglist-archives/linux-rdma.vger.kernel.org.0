Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7976C640605
	for <lists+linux-rdma@lfdr.de>; Fri,  2 Dec 2022 12:46:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233132AbiLBLqD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 2 Dec 2022 06:46:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233011AbiLBLqC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 2 Dec 2022 06:46:02 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ABA9CD993
        for <linux-rdma@vger.kernel.org>; Fri,  2 Dec 2022 03:46:01 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id a14so644031pfa.1
        for <linux-rdma@vger.kernel.org>; Fri, 02 Dec 2022 03:46:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8eN40UYsGSFVL2oYHS9QnE7DfInUWGZm9cC933//9Lw=;
        b=Jc903rSdlfXl2NJFb8EAk1hL3kyDhkMcdBiatvSwcyKPAG65U6t6LtZXePusbz//VQ
         XL29kCmK3i4MznIVhlyYq83XVq8oFkEkG4wfhw14xUHfQawrexChLWdJs89NDXzf3ztX
         1jl2oPTQposFL5QSM5N7Y29FA1mQzZo+O09QgmAfzvmn1Y3Fdmz6MKZakOR/VEwMZw+r
         73wn1VncAnwJ1YEumAW1y22Hi4eeZjSRYgOVjeEqJW2XAUOuItbLGtubi2ObtwFEZH2I
         rKelb7Mt5+yrH6qjsHONtqh3WBpH8L3oN33Oo+68eTnqas8YF9NSRA/JEUH0/3SDxz+C
         RP0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8eN40UYsGSFVL2oYHS9QnE7DfInUWGZm9cC933//9Lw=;
        b=TGePlGFyFLT+z/krMs9MX8zOFRwCbyYpvEZCwuLWnKIfKcLYDJ+YVhieZKMsdVWJhe
         W9pnAOlb9+aMi7C6YfMrJPq8kz6SQRD1EU0u/S/QYwsuDniTITGtGuCPPCa2IHPGkbzF
         ctAJkygmfRa50SxEdTcI6SmwfuCJRkzsb2tpVZTQWnQhQ61qIo8X0W1pkTN8qCB112ee
         pGNxd6MAKBo06sx0/zhT9rbn4HoK1fsaDIkkUlldUwDBtdQHtI4smwrdLeQ5yfQuHRPe
         GI9ibAh7qTn8ovBbOWG4QtO6nA+BL4szPLicEm7ixkeORbstZxTY+m6KOivAtW/tAPcG
         GDTg==
X-Gm-Message-State: ANoB5pmOjyBPa60cdawKjAZLtfrB2mJ9ONYw5sJPWzrR2Io3/WvQKCZ4
        cnDSUxFfwWGo0vcw+GiRXHm2olmLD0jVAVq1VM2XG5xFjN0=
X-Google-Smtp-Source: AA0mqf5dhVNnKsEqO1OkjARNOq5LrISn9FsnCP9R/nO08+YvAUTYPbR4lB9su+N6X8xYKl/TCpE0xkHuKeFnYCy3KbM=
X-Received: by 2002:aa7:8b56:0:b0:56c:6f8:fe14 with SMTP id
 i22-20020aa78b56000000b0056c06f8fe14mr72718106pfd.75.1669981560762; Fri, 02
 Dec 2022 03:46:00 -0800 (PST)
MIME-Version: 1.0
References: <20221202110157.3221952-1-matsuda-daisuke@fujitsu.com>
In-Reply-To: <20221202110157.3221952-1-matsuda-daisuke@fujitsu.com>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Fri, 2 Dec 2022 19:45:48 +0800
Message-ID: <CAD=hENcdfWQd5ZiN0_sc-Jy5tCj2SzdBpyGNYuTwsWBTqq9Xjg@mail.gmail.com>
Subject: Re: [PATCH] Revert "RDMA/rxe: Remove unnecessary mr testing"
To:     Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
Cc:     linux-rdma@vger.kernel.org, leonro@nvidia.com, jgg@nvidia.com,
        lizhijian@fujitsu.com, rpearsonhpe@gmail.com
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

On Fri, Dec 2, 2022 at 7:02 PM Daisuke Matsuda
<matsuda-daisuke@fujitsu.com> wrote:
>
> The commit 686d348476ee ("RDMA/rxe: Remove unnecessary mr testing") causes
> a kernel crash. If responder get a zero-byte RDMA Read request, qp->resp.mr
> is not set in check_rkey(). The mr is NULL in this case, and a NULL pointer
> dereference occurs as shown below.
>
> [  139.607580] BUG: kernel NULL pointer dereference, address: 0000000000000010
> [  139.609169] #PF: supervisor write access in kernel mode
> [  139.610314] #PF: error_code(0x0002) - not-present page
> [  139.611434] PGD 0 P4D 0
> [  139.612031] Oops: 0002 [#1] PREEMPT SMP PTI
> [  139.612975] CPU: 2 PID: 3622 Comm: python3 Kdump: loaded Not tainted 6.1.0-rc3+ #34
> [  139.614465] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubuntu1.1 04/01/2014
> [  139.616142] RIP: 0010:__rxe_put+0xc/0x60 [rdma_rxe]
> [  139.617065] Code: cc cc cc 31 f6 e8 64 36 1b d3 41 b8 01 00 00 00 44 89 c0 c3 cc cc cc cc 41 89 c0 eb c1 90 0f 1f 44 00 00 41 54 b8 ff ff ff ff <f0> 0f c1 47 10 83 f8 01 74 11 45 31 e4 85 c0 7e 20 44 89 e0 41 5c
> [  139.620451] RSP: 0018:ffffb27bc012ce78 EFLAGS: 00010246
> [  139.621413] RAX: 00000000ffffffff RBX: ffff9790857b0580 RCX: 0000000000000000
> [  139.622718] RDX: ffff979080fe145a RSI: 000055560e3e0000 RDI: 0000000000000000
> [  139.624025] RBP: ffff97909c7dd800 R08: 0000000000000001 R09: e7ce43d97f7bed0f
> [  139.625328] R10: ffff97908b29c300 R11: 0000000000000000 R12: 0000000000000000
> [  139.626632] R13: 0000000000000000 R14: ffff97908b29c300 R15: 0000000000000000
> [  139.627941] FS:  00007f276f7bd740(0000) GS:ffff9792b5c80000(0000) knlGS:0000000000000000
> [  139.629418] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  139.630480] CR2: 0000000000000010 CR3: 0000000114230002 CR4: 0000000000060ee0
> [  139.631805] Call Trace:
> [  139.632288]  <IRQ>
> [  139.632688]  read_reply+0xda/0x310 [rdma_rxe]
> [  139.633515]  rxe_responder+0x82d/0xe50 [rdma_rxe]
> [  139.634398]  do_task+0x84/0x170 [rdma_rxe]
> [  139.635187]  tasklet_action_common.constprop.0+0xa7/0x120
> [  139.636189]  __do_softirq+0xcb/0x2ac
> [  139.636877]  do_softirq+0x63/0x90
> [  139.637505]  </IRQ>
>
> Link: https://lore.kernel.org/lkml/1666582315-2-1-git-send-email-lizhijian@fujitsu.com/
> Signed-off-by: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
> ---
> NOTE:
>  I think the commit 686d348476ee is not yet merged to Torvalds' tree.
>  Perhaps we may just remove the patch from the for-next tree.
>  I leave that to the maintainers as I am not familiar with patch reversion.

Sure. If this is for for-next, it had better add "[for-netx PATCH]
Revert "RDMA/rxe: Remove unnecessary mr testing""

Thanks.
Zhu Yanjun

>
>  drivers/infiniband/sw/rxe/rxe_resp.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
> index 6761bcd1d4d8..5d3a4c6f81a3 100644
> --- a/drivers/infiniband/sw/rxe/rxe_resp.c
> +++ b/drivers/infiniband/sw/rxe/rxe_resp.c
> @@ -832,7 +832,8 @@ static enum resp_states read_reply(struct rxe_qp *qp,
>
>         err = rxe_mr_copy(mr, res->read.va, payload_addr(&ack_pkt),
>                           payload, RXE_FROM_MR_OBJ);
> -       rxe_put(mr);
> +       if (mr)
> +               rxe_put(mr);
>         if (err) {
>                 kfree_skb(skb);
>                 return RESPST_ERR_RKEY_VIOLATION;
> --
> 2.31.1
>
