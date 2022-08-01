Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66FE1586584
	for <lists+linux-rdma@lfdr.de>; Mon,  1 Aug 2022 09:11:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbiHAHLy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 1 Aug 2022 03:11:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbiHAHLx (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 1 Aug 2022 03:11:53 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B7533245E;
        Mon,  1 Aug 2022 00:11:52 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id e8-20020a17090a280800b001f2fef7886eso11044190pjd.3;
        Mon, 01 Aug 2022 00:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bpPmZ6bKyH2Do30wYam6vhM6y3BXmfwq4iqnoKVKbkw=;
        b=ROlyw2vvj3SnT1wy5sylTj17me+GqYpSAX8//ZaxkNT1CtzrBJxlJcOeJr/wqVkXsS
         fBHglvUSqdGLYFyocI7p3AORcNnjuIeZ4b1MLY1pFtArZLDpSvc02AIJLJCLkU6RqIdG
         SMyMJv+M6DjAMF5K+mSD3U08oulHtxAWGcRqWLylJooPt4ye/Gw03QPlVX2dR3nwiWyM
         3UCLpr+T53ZNPGInJE4LLnePpZmz8r1trBMK2Owe6UNRnZiT5SN2KQvPjk0WycHja6r3
         e9NcT+vL/lqnbgtNo3ezBgwGyUzaJvGG6gcZVE0Rjwmtql5ifROthwYnBTdg7FSwUzPn
         DRdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bpPmZ6bKyH2Do30wYam6vhM6y3BXmfwq4iqnoKVKbkw=;
        b=EyKcE1zlhiTw5QfkXQ0vtSr6kAbiOFoGdFg+kfXBnbgJaIQeIOIuxneBmNIHCOuYbr
         SbNZIyaWkXc9MGxMNTipU6IgGEFsnVmxlhpyalN/OV4LmmB22afxqNnebnamNYIbZx7i
         Y9MCqPw29J0RJmDRTiJAIs228ouTzbG3lD0KHFaxoippUZHx5ufR6Q1hrQOnyVFn1KC2
         uLC5icq4ZMz2mdD4/fL8hpAIuxaXXG/5M7V0LcCAnJeljClxUR4IZ4sR/LQdVUCBKEzV
         bDDIycfIIJDyzfLcG44yWtEgoZL7/miV59fu5pKabVu9KYQhot3wze3k+dRBTKmljxXn
         h9ug==
X-Gm-Message-State: ACgBeo2ULlHhnXI15wtz3ITEdTBRF+BN6ltUavsilTUo95lE7Y3CgOSN
        U/yPh51IPJSClVEHLiyU2SnSr9B7yeOuIVDUF/A=
X-Google-Smtp-Source: AA6agR6TFbpdoZsJrHK2sXuBo/17nLi+H/3n3+H0lo+BYzw9FD8rcK/UppQDMiOAh4RSR+BnwsfXntYID2U8/T44ls4=
X-Received: by 2002:a17:902:b58e:b0:16c:489e:7a0b with SMTP id
 a14-20020a170902b58e00b0016c489e7a0bmr15209552pls.145.1659337911920; Mon, 01
 Aug 2022 00:11:51 -0700 (PDT)
MIME-Version: 1.0
References: <1659335010-2-1-git-send-email-lizhijian@fujitsu.com>
In-Reply-To: <1659335010-2-1-git-send-email-lizhijian@fujitsu.com>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Mon, 1 Aug 2022 15:11:40 +0800
Message-ID: <CAD=hENfqCKs3jk7pUNJq0Urqx1ZCSU2KpDcipgz_ORJs_43C=g@mail.gmail.com>
Subject: Re: [PATCH] RDMA/RXE: Add send_common_ack() helper
To:     Li Zhijian <lizhijian@fujitsu.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Xiao Yang <yangx.jy@fujitsu.com>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
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

On Mon, Aug 1, 2022 at 2:16 PM Li Zhijian <lizhijian@fujitsu.com> wrote:
>
> Most code in send_ack() and send_atomic_ack() are duplicate, move them
> to a new helper send_common_ack().
>
> In newer IBA SPEC, some opcodes require acknowledge with a zero-length read
> response, with this new helper, we can easily implement it later.
>
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_resp.c | 43 ++++++++++++++----------------------
>  1 file changed, 17 insertions(+), 26 deletions(-)
>
> diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
> index b36ec5c4d5e0..4c398fa220fa 100644
> --- a/drivers/infiniband/sw/rxe/rxe_resp.c
> +++ b/drivers/infiniband/sw/rxe/rxe_resp.c
> @@ -1028,50 +1028,41 @@ static enum resp_states do_complete(struct rxe_qp *qp,
>                 return RESPST_CLEANUP;
>  }
>
> -static int send_ack(struct rxe_qp *qp, u8 syndrome, u32 psn)
> +
> +static int send_common_ack(struct rxe_qp *qp, u8 syndrome, u32 psn,

The function is better with rxe_send_common_ack?
So when debug, rxe_ prefix can help us.

> +                                 int opcode, const char *msg)
>  {
> -       int err = 0;
> +       int err;
>         struct rxe_pkt_info ack_pkt;
>         struct sk_buff *skb;
>
> -       skb = prepare_ack_packet(qp, &ack_pkt, IB_OPCODE_RC_ACKNOWLEDGE,
> -                                0, psn, syndrome);
> -       if (!skb) {
> -               err = -ENOMEM;
> -               goto err1;
> -       }
> +       skb = prepare_ack_packet(qp, &ack_pkt, opcode, 0, psn, syndrome);
> +       if (!skb)
> +               return -ENOMEM;
>
>         err = rxe_xmit_packet(qp, &ack_pkt, skb);
>         if (err)
> -               pr_err_ratelimited("Failed sending ack\n");
> +               pr_err_ratelimited("Failed sending %s\n", msg);
>
> -err1:
>         return err;
>  }
>
> -static int send_atomic_ack(struct rxe_qp *qp, u8 syndrome, u32 psn)
> +static int send_ack(struct rxe_qp *qp, u8 syndrome, u32 psn)

rxe_send_ack

>  {
> -       int err = 0;
> -       struct rxe_pkt_info ack_pkt;
> -       struct sk_buff *skb;
> -
> -       skb = prepare_ack_packet(qp, &ack_pkt, IB_OPCODE_RC_ATOMIC_ACKNOWLEDGE,
> -                                0, psn, syndrome);
> -       if (!skb) {
> -               err = -ENOMEM;
> -               goto out;
> -       }
> +       return send_common_ack(qp, syndrome, psn,
> +                       IB_OPCODE_RC_ACKNOWLEDGE, "ACK");
> +}
>
> -       err = rxe_xmit_packet(qp, &ack_pkt, skb);
> -       if (err)
> -               pr_err_ratelimited("Failed sending atomic ack\n");
> +static int send_atomic_ack(struct rxe_qp *qp, u8 syndrome, u32 psn)

rxe_send_atomic_ack

Thanks and Regards,
Zhu Yanjun
> +{
> +       int ret = send_common_ack(qp, syndrome, psn,
> +                       IB_OPCODE_RC_ATOMIC_ACKNOWLEDGE, "ATOMIC ACK");
>
>         /* have to clear this since it is used to trigger
>          * long read replies
>          */
>         qp->resp.res = NULL;
> -out:
> -       return err;
> +       return ret;
>  }
>
>  static enum resp_states acknowledge(struct rxe_qp *qp,
> --
> 1.8.3.1
>
