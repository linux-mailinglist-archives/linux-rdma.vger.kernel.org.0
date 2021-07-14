Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDC3B3C7CE1
	for <lists+linux-rdma@lfdr.de>; Wed, 14 Jul 2021 05:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237887AbhGND1E (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 13 Jul 2021 23:27:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237738AbhGND1E (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 13 Jul 2021 23:27:04 -0400
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EC63C0613DD
        for <linux-rdma@vger.kernel.org>; Tue, 13 Jul 2021 20:24:13 -0700 (PDT)
Received: by mail-oo1-xc32.google.com with SMTP id e203-20020a4a55d40000b029025f4693434bso265101oob.3
        for <linux-rdma@vger.kernel.org>; Tue, 13 Jul 2021 20:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7c5WVclHGmvFpRE3fyv3CORegbQ6RZKa7qh7APx/mMU=;
        b=ttEXE/qa5rFwZCx0OyruqhluJl/Goav8zzbHslLFMV2tcoiItSoOInFqvilEvt/Tbr
         gRFZzrjnHJ7kloWPunF1wTiVsaOKloJI6g6e96pzu5h4JtFl7hK5FqndN40zR4S/TEBC
         DIGhxQ6ciumMt6GG+S8QJokm32sIosip5dIlev2u1U40B12Qi9+bWvVdcH07Yd0n+HRC
         YqLdpFqxOc6R5aMSjA1w92zRck+zsQmt2RQvUakklRGlw+WiUEDMg5pJL8zvVF/WIA/x
         5UuoKkB2h2prX4oLNN3I+zyh9gG96x+nBwUE6118FetQTfqpmDWt0hpd6IOz4F5J5uaC
         5rJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7c5WVclHGmvFpRE3fyv3CORegbQ6RZKa7qh7APx/mMU=;
        b=NVx7XopWoVjN4/PXZFCKaZYOmvXgkPoDcVd+eni9ZWfP8QHBATNq4ni/U7egvYm2Hh
         dK3V3ZjC2wa3q1YWlgrjNCY6jRlH8sk89aATCkqPau8kqt8MuANOGef6zJrPxefT6Aju
         pfzhXPZIPlCJL58F0x9ySJqKyOri5oMGm0UUvx08lT5pqY0IrEWSGLT4UutHQ66Zi87/
         D1czzUdw2UfPKSncV/tXr7txrdL7p8Ya4kkt8t5D7WuFOSDRHzhicaqrvbKRkOJIoOh9
         b4Tm/vqBaa0/nfOW8g0Ff8lmIt9Pk3u0TyaAE8g7p5Y2qsc/9HgXUamklxTKIGTz2dsj
         agfQ==
X-Gm-Message-State: AOAM532ux7dA8+g8HoNJzNI4XZ4SoCT7MWfAVRylIp0J9IYiclf4fMa8
        7A8xxEqOXJW7/PgYDXyxq4DeHsAh88DehzQ0aII=
X-Google-Smtp-Source: ABdhPJy2rpCgiTVo73jFzCW1RBrsb3myRQkpiBZc3Ft9/akLPqia0ZqEHhuJUHiopWSDUWrOCEcj49iYeB1BzjTmhho=
X-Received: by 2002:a4a:5850:: with SMTP id f77mr6201965oob.15.1626233052703;
 Tue, 13 Jul 2021 20:24:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210707040040.15434-1-rpearsonhpe@gmail.com> <20210707040040.15434-3-rpearsonhpe@gmail.com>
In-Reply-To: <20210707040040.15434-3-rpearsonhpe@gmail.com>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Wed, 14 Jul 2021 11:24:01 +0800
Message-ID: <CAD=hENfMtLzYV53xpX-EC=05gZN9ZHp1yb+-g=Yb3E=w-mA01Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/9] RDMA/rxe: Move rxe_xmit_packet to a subroutine
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jul 7, 2021 at 12:01 PM Bob Pearson <rpearsonhpe@gmail.com> wrote:
>
> rxe_xmit_packet() was an overlong inline subroutine. This patch moves it
> into rxe_net.c as an ordinary subroutine.

In this commit, the function rxe_xmit_packet is moved from rxe_loc.h
to rxe_net.c.
No other changes.

I am fine with this. Thanks.

Reviewed-by: Zhu Yanjun <zyjzyj2000@gmail.com>

Zhu Yanjun

>
> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_loc.h | 45 ++---------------------------
>  drivers/infiniband/sw/rxe/rxe_net.c | 43 +++++++++++++++++++++++++++
>  2 files changed, 45 insertions(+), 43 deletions(-)
>
> diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
> index 015777e31ec9..409d10f20948 100644
> --- a/drivers/infiniband/sw/rxe/rxe_loc.h
> +++ b/drivers/infiniband/sw/rxe/rxe_loc.h
> @@ -104,6 +104,8 @@ int rxe_send(struct rxe_pkt_info *pkt, struct sk_buff *skb);
>  struct sk_buff *rxe_init_packet(struct rxe_dev *rxe, struct rxe_av *av,
>                                 int paylen, struct rxe_pkt_info *pkt);
>  int rxe_prepare(struct rxe_pkt_info *pkt, struct sk_buff *skb, u32 *crc);
> +int rxe_xmit_packet(struct rxe_qp *qp, struct rxe_pkt_info *pkt,
> +                   struct sk_buff *skb);
>  const char *rxe_parent_name(struct rxe_dev *rxe, unsigned int port_num);
>  int rxe_mcast_add(struct rxe_dev *rxe, union ib_gid *mgid);
>  int rxe_mcast_delete(struct rxe_dev *rxe, union ib_gid *mgid);
> @@ -206,47 +208,4 @@ static inline unsigned int wr_opcode_mask(int opcode, struct rxe_qp *qp)
>         return rxe_wr_opcode_info[opcode].mask[qp->ibqp.qp_type];
>  }
>
> -static inline int rxe_xmit_packet(struct rxe_qp *qp, struct rxe_pkt_info *pkt,
> -                                 struct sk_buff *skb)
> -{
> -       int err;
> -       int is_request = pkt->mask & RXE_REQ_MASK;
> -       struct rxe_dev *rxe = to_rdev(qp->ibqp.device);
> -
> -       if ((is_request && (qp->req.state != QP_STATE_READY)) ||
> -           (!is_request && (qp->resp.state != QP_STATE_READY))) {
> -               pr_info("Packet dropped. QP is not in ready state\n");
> -               goto drop;
> -       }
> -
> -       if (pkt->mask & RXE_LOOPBACK_MASK) {
> -               memcpy(SKB_TO_PKT(skb), pkt, sizeof(*pkt));
> -               rxe_loopback(skb);
> -               err = 0;
> -       } else {
> -               err = rxe_send(pkt, skb);
> -       }
> -
> -       if (err) {
> -               rxe->xmit_errors++;
> -               rxe_counter_inc(rxe, RXE_CNT_SEND_ERR);
> -               return err;
> -       }
> -
> -       if ((qp_type(qp) != IB_QPT_RC) &&
> -           (pkt->mask & RXE_END_MASK)) {
> -               pkt->wqe->state = wqe_state_done;
> -               rxe_run_task(&qp->comp.task, 1);
> -       }
> -
> -       rxe_counter_inc(rxe, RXE_CNT_SENT_PKTS);
> -       goto done;
> -
> -drop:
> -       kfree_skb(skb);
> -       err = 0;
> -done:
> -       return err;
> -}
> -
>  #endif /* RXE_LOC_H */
> diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c
> index dec92928a1cd..c93a379a1b28 100644
> --- a/drivers/infiniband/sw/rxe/rxe_net.c
> +++ b/drivers/infiniband/sw/rxe/rxe_net.c
> @@ -421,6 +421,49 @@ void rxe_loopback(struct sk_buff *skb)
>                 rxe_rcv(skb);
>  }
>
> +int rxe_xmit_packet(struct rxe_qp *qp, struct rxe_pkt_info *pkt,
> +                   struct sk_buff *skb)
> +{
> +       int err;
> +       int is_request = pkt->mask & RXE_REQ_MASK;
> +       struct rxe_dev *rxe = to_rdev(qp->ibqp.device);
> +
> +       if ((is_request && (qp->req.state != QP_STATE_READY)) ||
> +           (!is_request && (qp->resp.state != QP_STATE_READY))) {
> +               pr_info("Packet dropped. QP is not in ready state\n");
> +               goto drop;
> +       }
> +
> +       if (pkt->mask & RXE_LOOPBACK_MASK) {
> +               memcpy(SKB_TO_PKT(skb), pkt, sizeof(*pkt));
> +               rxe_loopback(skb);
> +               err = 0;
> +       } else {
> +               err = rxe_send(pkt, skb);
> +       }
> +
> +       if (err) {
> +               rxe->xmit_errors++;
> +               rxe_counter_inc(rxe, RXE_CNT_SEND_ERR);
> +               return err;
> +       }
> +
> +       if ((qp_type(qp) != IB_QPT_RC) &&
> +           (pkt->mask & RXE_END_MASK)) {
> +               pkt->wqe->state = wqe_state_done;
> +               rxe_run_task(&qp->comp.task, 1);
> +       }
> +
> +       rxe_counter_inc(rxe, RXE_CNT_SENT_PKTS);
> +       goto done;
> +
> +drop:
> +       kfree_skb(skb);
> +       err = 0;
> +done:
> +       return err;
> +}
> +
>  struct sk_buff *rxe_init_packet(struct rxe_dev *rxe, struct rxe_av *av,
>                                 int paylen, struct rxe_pkt_info *pkt)
>  {
> --
> 2.30.2
>
