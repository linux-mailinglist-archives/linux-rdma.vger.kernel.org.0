Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C63F45A4347
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Aug 2022 08:31:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbiH2GbW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 29 Aug 2022 02:31:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbiH2GbT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 29 Aug 2022 02:31:19 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B499E4B0D4
        for <linux-rdma@vger.kernel.org>; Sun, 28 Aug 2022 23:31:12 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id r22so6845788pgm.5
        for <linux-rdma@vger.kernel.org>; Sun, 28 Aug 2022 23:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=3r8+mWhrBmrnNLRtuMlZ02HiCF8YHvefjNcEqF7BblU=;
        b=JpmuRRdSmzGO13Xs5jsQ0OC4VDzwuMGPa+aIWaRiTzke/n1kSq3ahYGuhlEb63HOAz
         QdYait5YZ1TOFytR8SSSeAaaIY5xHQxX2h5eZ7fQ0RP1dGSUMgR38xZi7P61poehaqaT
         0pKU8VubEtHM+d2wBuYLeVLKXZH3kEXFc7hatd/h1Xbl4GANoF+B9IH0XFwg0rmYh+A3
         PYR2S7LU5UgRsgqtH803zXYZbhvoG6JN8M35eHQjpQJoeZRDQBBsgmOq7o2Pxz4ef0+W
         4J5RSYLQOeo163Qiz3CQSAYNgMHDrQ57N7ojwx/lrY7NUFjDjRddbVC8+Knfmmt08ft6
         /Qug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=3r8+mWhrBmrnNLRtuMlZ02HiCF8YHvefjNcEqF7BblU=;
        b=ni0197ZiVaFnQlWEiz5cro4InQpcmRQvl1+spYcU+XXJUDu5TSkncqLwtuvdFZLaS2
         qIcFGHLWepW+/r0mSJykN2yIG7fffbPFRJE50qwHYFtx4U2KDjKBcTatnjfO+w2mWiTp
         OcNpOfCpylwtEoIM2DNOVIydomV2CS1SKTx7rB2b8eKxpMlTjbtZahrLvSZSPpWPpfQQ
         UzLU7t99I9pfiSEhNfTGXVNIQ8oZsFIkAvS481/4v02Ngiq2ELAYEQUEdTnVhWQczFYP
         zfZxndM0fq/6HaL3ZZt6wdM6WhdRvG3hw/hxBrObKy6pSfgPnqL4I7UJnzWWVk4cDtWt
         tZHA==
X-Gm-Message-State: ACgBeo3k++8SlPPwXdsfek5EoPiDV5tYD3HhyJjeC4XaceBPTqRYEzmx
        gFADuSAeZFz0hrje3HchrKImD0B+7GEdYKQ4mchPMA2XYhc=
X-Google-Smtp-Source: AA6agR7XvE6Sx6Dz2nfwrBvFeL777uBgZYSOc1Ri6U8qRQkfwi5M8SGpUHWMvh3XN+TY23Dq+Anw4YQQ8GCJTg9n0yI=
X-Received: by 2002:a62:2503:0:b0:538:426a:af11 with SMTP id
 l3-20020a622503000000b00538426aaf11mr3071384pfl.22.1661754671499; Sun, 28 Aug
 2022 23:31:11 -0700 (PDT)
MIME-Version: 1.0
References: <Ywi8ZebmZv+bctrC@nvidia.com> <20220829054413.1630495-1-matsuda-daisuke@fujitsu.com>
In-Reply-To: <20220829054413.1630495-1-matsuda-daisuke@fujitsu.com>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Mon, 29 Aug 2022 14:31:00 +0800
Message-ID: <CAD=hENf0d_HyPRi2wmWLswULrn9UWHvQvz54-E7=M5DTSB-qGg@mail.gmail.com>
Subject: Re: [PATCH] RDMA/rxe: Delete error messages triggered by incoming
 Read requests
To:     Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
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

On Mon, Aug 29, 2022 at 1:45 PM Daisuke Matsuda
<matsuda-daisuke@fujitsu.com> wrote:
>
> An incoming Read request causes multiple Read responses. If a user MR to
> copy data from is unavailable or responder cannot send a reply, then the
> error messages can be printed for each response attempt, resulting in
> message overflow.
>
> Signed-off-by: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_resp.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
>
> diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
> index b36ec5c4d5e0..4b3e8aec2fb8 100644
> --- a/drivers/infiniband/sw/rxe/rxe_resp.c
> +++ b/drivers/infiniband/sw/rxe/rxe_resp.c
> @@ -811,8 +811,6 @@ static enum resp_states read_reply(struct rxe_qp *qp,
>
>         err = rxe_mr_copy(mr, res->read.va, payload_addr(&ack_pkt),
>                           payload, RXE_FROM_MR_OBJ);
> -       if (err)
> -               pr_err("Failed copying memory\n");

pr_err_once is better?

>         if (mr)
>                 rxe_put(mr);
>
> @@ -823,10 +821,8 @@ static enum resp_states read_reply(struct rxe_qp *qp,
>         }
>
>         err = rxe_xmit_packet(qp, &ack_pkt, skb);
> -       if (err) {
> -               pr_err("Failed sending RDMA reply.\n");

The same with the above

Zhu Yanjun

> +       if (err)
>                 return RESPST_ERR_RNR;
> -       }
>
>         res->read.va += payload;
>         res->read.resid -= payload;
> --
> 2.31.1
>
