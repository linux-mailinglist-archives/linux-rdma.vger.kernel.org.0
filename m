Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A1946E6625
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Apr 2023 15:43:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231753AbjDRNnY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Apr 2023 09:43:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230311AbjDRNnY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 18 Apr 2023 09:43:24 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81D6AB762
        for <linux-rdma@vger.kernel.org>; Tue, 18 Apr 2023 06:43:22 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id dm2so73426203ejc.8
        for <linux-rdma@vger.kernel.org>; Tue, 18 Apr 2023 06:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681825401; x=1684417401;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8wdeAI4bz/ty68JM0snmXVDvHDkiCZAGHSgfgvJZDxE=;
        b=gSela94KfsiAA15/gMsC6Stu7AAFwwIgqFdEPMnaoasaeDzExdlTdF3XE0vXfQEbvi
         7STBksV79aaTi8XMnI1ezNXrD1Odbq/guoiHXhy6wEznY2X7EvmeUwjHXoVyGtMkz2H/
         29D/JJBIxTz6gdQobAqMz0ixCJlKKHY79P9Zob19Ni11ZWRJBNJt3PVDDeM720JHPBez
         TpPZkn7iehclEylis6fFFscp7fhwUjGVV4CVOfPyb+O3zGdmjf3suK61DVkEdsxRy5nW
         BOXSb8rpNTqEtYChEMwvq5G2839yYsGZ12pY65sBUFgg+OsZuVg+bJbYYj/mPi/zOT99
         fe8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681825401; x=1684417401;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8wdeAI4bz/ty68JM0snmXVDvHDkiCZAGHSgfgvJZDxE=;
        b=e5P9FGiNQyKEkPGsRCP+4NP3lwust429NuWyIsDlqIr+gPfwu0Bqq4pN1gMr3Tf0uJ
         Ku11YRTO34nOkplYUFWGIQCwk7YpYtQoqjJpqPbGH7f/nzH8RSLIzxlqW34dIaJQnLq4
         1uzuiUZeeByNvw3Hb9KjevrKr38I+iqhDoe4Vfcntt+AFpepj0x2IKilcfHsEgpMwmKo
         owFlYXFe2y8m16WHDogiIqRiNqK+dZdx1Q6FcvT+lQnb+7MbV5N20cPovnxJbcQ29Vzf
         q0nlhJxwCAV39zqrUcd7b/llsUdMbtgRv5A1RG3FvZIPHFB4FnDy7rfndyukjVd3NfNC
         T41A==
X-Gm-Message-State: AAQBX9f18Wt0z/4znJNFTmZmAhYXiIBD7vYMDJbqool2eA+G82t2sh/w
        pWpgaiZIp5zTcM1n2gh47rRA5apFtapmBNc4A4g=
X-Google-Smtp-Source: AKy350YN3zuNjH+pcagWdSii3gegLSaWDuZimOBUdCLsPFIaqgh6BJPEvNnGnZmB0V0AGOuw5LsKZcK9xOFBeaE8Hj8=
X-Received: by 2002:a17:907:8b92:b0:94f:2b80:f3b4 with SMTP id
 tb18-20020a1709078b9200b0094f2b80f3b4mr9222211ejc.69.1681825400725; Tue, 18
 Apr 2023 06:43:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230418090642.1849358-1-matsuda-daisuke@fujitsu.com>
In-Reply-To: <20230418090642.1849358-1-matsuda-daisuke@fujitsu.com>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Tue, 18 Apr 2023 21:43:07 +0800
Message-ID: <CAD=hENexj_UWdLtNK=UvGJ-y9WpN3aTAKzmWWHorb7vdYnV_+w@mail.gmail.com>
Subject: Re: [PATCH jgg-for-next] RDMA/rxe: Fix spinlock recursion deadlock on requester
To:     Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
Cc:     linux-rdma@vger.kernel.org, jgg@nvidia.com, rpearsonhpe@gmail.com,
        leonro@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Apr 18, 2023 at 5:07=E2=80=AFPM Daisuke Matsuda
<matsuda-daisuke@fujitsu.com> wrote:
>
> After applying commit f605f26ea196, the following deadlock is observed:
>  Call Trace:
>   <IRQ>
>   _raw_spin_lock_bh+0x29/0x30
>   check_type_state.constprop.0+0x4e/0xc0 [rdma_rxe]
>   rxe_rcv+0x173/0x3d0 [rdma_rxe]
>   rxe_udp_encap_recv+0x69/0xd0 [rdma_rxe]
>   ? __pfx_rxe_udp_encap_recv+0x10/0x10 [rdma_rxe]
>   udp_queue_rcv_one_skb+0x258/0x520
>   udp_unicast_rcv_skb+0x75/0x90
>   __udp4_lib_rcv+0x364/0x5c0
>   ip_protocol_deliver_rcu+0xa7/0x160
>   ip_local_deliver_finish+0x73/0xa0
>   ip_sublist_rcv_finish+0x80/0x90
>   ip_sublist_rcv+0x191/0x220
>   ip_list_rcv+0x132/0x160
>   __netif_receive_skb_list_core+0x297/0x2c0
>   netif_receive_skb_list_internal+0x1c5/0x300
>   napi_complete_done+0x6f/0x1b0
>   virtnet_poll+0x1f4/0x2d0 [virtio_net]
>   __napi_poll+0x2c/0x1b0
>   net_rx_action+0x293/0x350
>   ? __napi_schedule+0x79/0x90
>   __do_softirq+0xcb/0x2ab
>   __irq_exit_rcu+0xb9/0xf0
>   common_interrupt+0x80/0xa0
>   </IRQ>
>   <TASK>
>   asm_common_interrupt+0x22/0x40
>   RIP: 0010:_raw_spin_lock+0x17/0x30
>   rxe_requester+0xe4/0x8f0 [rdma_rxe]
>   ? xas_load+0x9/0xa0
>   ? xa_load+0x70/0xb0
>   do_task+0x64/0x1f0 [rdma_rxe]
>   rxe_post_send+0x54/0x110 [rdma_rxe]
>   ib_uverbs_post_send+0x5f8/0x680 [ib_uverbs]
>   ? netif_receive_skb_list_internal+0x1e3/0x300
>   ib_uverbs_write+0x3c8/0x500 [ib_uverbs]
>   vfs_write+0xc5/0x3b0
>   ksys_write+0xab/0xe0
>   ? syscall_trace_enter.constprop.0+0x126/0x1a0
>   do_syscall_64+0x3b/0x90
>   entry_SYSCALL_64_after_hwframe+0x72/0xdc
>   </TASK>
>
> The deadlock is easily reproducible with perftest. Fix it by disabling
> softirq when acquiring the lock in process context.

I am fine. Thanks.

Acked-by: Zhu Yanjun <zyjzyj2000@gmail.com>

Zhu Yanjun

>
> Fixes: f605f26ea196 ("RDMA/rxe: Protect QP state with qp->state_lock")
> Signed-off-by: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_req.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/=
rxe/rxe_req.c
> index 8e50d116d273..65134a9aefe7 100644
> --- a/drivers/infiniband/sw/rxe/rxe_req.c
> +++ b/drivers/infiniband/sw/rxe/rxe_req.c
> @@ -180,13 +180,13 @@ static struct rxe_send_wqe *req_next_wqe(struct rxe=
_qp *qp)
>         if (wqe =3D=3D NULL)
>                 return NULL;
>
> -       spin_lock(&qp->state_lock);
> +       spin_lock_bh(&qp->state_lock);
>         if (unlikely((qp_state(qp) =3D=3D IB_QPS_SQD) &&
>                      (wqe->state !=3D wqe_state_processing))) {
> -               spin_unlock(&qp->state_lock);
> +               spin_unlock_bh(&qp->state_lock);
>                 return NULL;
>         }
> -       spin_unlock(&qp->state_lock);
> +       spin_unlock_bh(&qp->state_lock);
>
>         wqe->mask =3D wr_opcode_mask(wqe->wr.opcode, qp);
>         return wqe;
> --
> 2.39.1
>
