Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9EC475E1F9
	for <lists+linux-rdma@lfdr.de>; Sun, 23 Jul 2023 15:03:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbjGWNDv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 23 Jul 2023 09:03:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjGWNDv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 23 Jul 2023 09:03:51 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C34EE4E
        for <linux-rdma@vger.kernel.org>; Sun, 23 Jul 2023 06:03:48 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-997c4107d62so508663266b.0
        for <linux-rdma@vger.kernel.org>; Sun, 23 Jul 2023 06:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690117427; x=1690722227;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Dx2l+zn7hDuMpEuQPEtR1jHj3AFYQtCQXEZCVFY4rY=;
        b=SyLa2weibsO/tB9CudnnYkedi5WC1ljNGoPlVg4BIUrlMopSzwR72G9MyeMOfpQLAT
         GjycqIv61JXCa3RwN9eDbxIHGmWg5hWVQGKnHT3C4BYiS0Jx9NFmm/d1iYXwE2jrZzyH
         NpXCFliE6CNCCifghETZgiAnlV2Alk48wF/cqzwjdUOCHQfcpGPGPOjkBkvLQjD2mwHm
         +6pwFy7AdAXQ7Jo9pHV+J/ivw6CMQHKsNxEqWoLo310Rkcld7FTvJbOam/ra9eDSLMm4
         f18VVTax1ASTAmqctlY57wrp1e/3vgeRPb9eXvkGuUElB2G53pRmRPrcdpn+VfU0bm2l
         NsyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690117427; x=1690722227;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3Dx2l+zn7hDuMpEuQPEtR1jHj3AFYQtCQXEZCVFY4rY=;
        b=EZ/+N7W5AaxnpHCvVkzANs6QDRA8m9nJCGtfziYyqSSjj6x+chbyZ0kth0Vo2f6nkw
         KExzGinLSAKPnXeG3IB+m6+PYzCVFAzb1yvJ4uCdFFertK6oTnjYgTeelvoggNXV/bMR
         O8eF54gmU6NrflT/eSF3G63J9hyB4lM9pZMEkVPBAw1e0uywEY1iEmjdyMTQt5pi67V8
         uUoeQm0/3vF1uwRd41Ap+NjxJ1EwuYIXWXBUS5+ldhigIdzeEx38NcogYMs9Cf3gH4cN
         YpZjJ//NH2nOlDgH/+a8JtkxtzPEQbnRrNwr4REnTvn7aFgF2aA/+tO6a+mzAaPmAiaG
         ExgQ==
X-Gm-Message-State: ABy/qLbiHa3n6BJWVu3Daule032d6RVIaBK/MLbgQ7J0Xh65bwHFQhxt
        U54TbUwvEMCxtSw/K0EhyM+MCQ9WIRQMdoeS9Ek=
X-Google-Smtp-Source: APBJJlEX8tFJeGYwaj0olH4cd8GwZpss79hgEOCm7M/2GACi/yNk58mVcMMXeENlE8m+Hs15EXpvtJt8xDrPjFqacMo=
X-Received: by 2002:a17:906:224c:b0:96f:8666:5fc4 with SMTP id
 12-20020a170906224c00b0096f86665fc4mr7871062ejr.50.1690117426643; Sun, 23 Jul
 2023 06:03:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230721205021.5394-1-rpearsonhpe@gmail.com> <20230721205021.5394-5-rpearsonhpe@gmail.com>
In-Reply-To: <20230721205021.5394-5-rpearsonhpe@gmail.com>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Sun, 23 Jul 2023 21:03:34 +0800
Message-ID: <CAD=hENeFSR1R8C0PkSSoE22atotT_1tJ1tzHzpNoirb996FNmQ@mail.gmail.com>
Subject: Re: [PATCH for-next 4/9] RDMA/rxe: Fix delayed send packet handling
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     jgg@nvidia.com, leon@kernel.org, jhack@hpe.com,
        linux-rdma@vger.kernel.org
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

On Sat, Jul 22, 2023 at 4:51=E2=80=AFAM Bob Pearson <rpearsonhpe@gmail.com>=
 wrote:
>
> In cable pull testing some NICs can hold a send packet long enough
> to allow ulp protocol stacks to destroy the qp and the cleanup
> routines to timeout waiting for all qp references to be released.
> When the NIC driver finally frees the SKB the qp pointer is no longer
> valid and causes a seg fault in rxe_skb_tx_dtor().

If a packet is held in some NICs, the later packets of this packet
will also be held by this NIC. So this will cause QP not to work well.
This is a serious problem. And the problem should be fixed in this
kind of NICs. We should not fix it in RXE.

And a QP exists for at least several seconds. A packet can be held in
NIC for such a long time? This problem does exist in the real world,
or you imagine this scenario?

I can not imagine this kind of scenario. Please Jason or Leon also check th=
is.

Thanks.
Zhu Yanjun
>
> This patch passes the qp index instead of the qp to the skb destructor
> callback function. The call back is required to lookup the qp from the
> index and if it has been destroyed the lookup will return NULL and the
> qp will not be referenced avoiding the seg fault.
>
> Fixes: 8700e3e7c485 ("Soft RoCE driver")
> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_net.c | 87 ++++++++++++++++++++++-------
>  drivers/infiniband/sw/rxe/rxe_qp.c  |  1 -
>  2 files changed, 67 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/=
rxe/rxe_net.c
> index cd59666158b1..10e4a752ff7c 100644
> --- a/drivers/infiniband/sw/rxe/rxe_net.c
> +++ b/drivers/infiniband/sw/rxe/rxe_net.c
> @@ -131,19 +131,28 @@ static struct dst_entry *rxe_find_route(struct net_=
device *ndev,
>         return dst;
>  }
>
> +static struct rxe_dev *get_rxe_from_skb(struct sk_buff *skb)
> +{
> +       struct rxe_dev *rxe;
> +       struct net_device *ndev =3D skb->dev;
> +
> +       rxe =3D rxe_get_dev_from_net(ndev);
> +       if (!rxe && is_vlan_dev(ndev))
> +               rxe =3D rxe_get_dev_from_net(vlan_dev_real_dev(ndev));
> +
> +       return rxe;
> +}
> +
>  static int rxe_udp_encap_recv(struct sock *sk, struct sk_buff *skb)
>  {
>         struct udphdr *udph;
>         struct rxe_dev *rxe;
> -       struct net_device *ndev =3D skb->dev;
>         struct rxe_pkt_info *pkt =3D SKB_TO_PKT(skb);
>
>         /* takes a reference on rxe->ib_dev
>          * drop when skb is freed
>          */
> -       rxe =3D rxe_get_dev_from_net(ndev);
> -       if (!rxe && is_vlan_dev(ndev))
> -               rxe =3D rxe_get_dev_from_net(vlan_dev_real_dev(ndev));
> +       rxe =3D get_rxe_from_skb(skb);
>         if (!rxe)
>                 goto drop;
>
> @@ -345,46 +354,84 @@ int rxe_prepare(struct rxe_av *av, struct rxe_pkt_i=
nfo *pkt,
>
>  static void rxe_skb_tx_dtor(struct sk_buff *skb)
>  {
> -       struct sock *sk =3D skb->sk;
> -       struct rxe_qp *qp =3D sk->sk_user_data;
> -       int skb_out =3D atomic_dec_return(&qp->skb_out);
> +       struct rxe_dev *rxe;
> +       unsigned int index;
> +       struct rxe_qp *qp;
> +       int skb_out;
> +
> +       /* takes a ref on ib device if success */
> +       rxe =3D get_rxe_from_skb(skb);
> +       if (!rxe)
> +               goto out;
> +
> +       /* recover source qp index from sk->sk_user_data
> +        * free the reference taken in rxe_send
> +        */
> +       index =3D (int)(uintptr_t)skb->sk->sk_user_data;
> +       sock_put(skb->sk);
>
> +       /* lookup qp from index, takes a ref on success */
> +       qp =3D rxe_pool_get_index(&rxe->qp_pool, index);
> +       if (!qp)
> +               goto out_put_ibdev;
> +
> +       skb_out =3D atomic_dec_return(&qp->skb_out);
>         if (unlikely(qp->need_req_skb &&
>                      skb_out < RXE_INFLIGHT_SKBS_PER_QP_LOW))
>                 rxe_sched_task(&qp->req.task);
>
>         rxe_put(qp);
> +out_put_ibdev:
> +       ib_device_put(&rxe->ib_dev);
> +out:
> +       return;
>  }
>
>  static int rxe_send(struct sk_buff *skb, struct rxe_pkt_info *pkt)
>  {
> +       struct rxe_qp *qp =3D pkt->qp;
> +       struct sock *sk;
>         int err;
>
> -       skb->destructor =3D rxe_skb_tx_dtor;
> -       skb->sk =3D pkt->qp->sk->sk;
> +       /* qp can be destroyed while this packet is waiting on
> +        * the tx queue. So need to protect sk.
> +        */
> +       sk =3D qp->sk->sk;
> +       sock_hold(sk);
> +       skb->sk =3D sk;
>
> -       rxe_get(pkt->qp);
>         atomic_inc(&pkt->qp->skb_out);
>
> +       sk->sk_user_data =3D (void *)(long)qp->elem.index;
> +       skb->destructor =3D rxe_skb_tx_dtor;
> +
>         if (skb->protocol =3D=3D htons(ETH_P_IP)) {
> -               err =3D ip_local_out(dev_net(skb_dst(skb)->dev), skb->sk,=
 skb);
> +               err =3D ip_local_out(dev_net(skb_dst(skb)->dev), sk, skb)=
;
>         } else if (skb->protocol =3D=3D htons(ETH_P_IPV6)) {
> -               err =3D ip6_local_out(dev_net(skb_dst(skb)->dev), skb->sk=
, skb);
> +               err =3D ip6_local_out(dev_net(skb_dst(skb)->dev), sk, skb=
);
>         } else {
> -               rxe_dbg_qp(pkt->qp, "Unknown layer 3 protocol: %d\n",
> -                               skb->protocol);
> -               atomic_dec(&pkt->qp->skb_out);
> -               rxe_put(pkt->qp);
> -               kfree_skb(skb);
> -               return -EINVAL;
> +               rxe_dbg_qp(qp, "Unknown layer 3 protocol: %d",
> +                          skb->protocol);
> +               err =3D -EINVAL;
> +               goto err_not_sent;
>         }
>
> +       /* IP consumed the packet, the destructor will handle cleanup */
>         if (unlikely(net_xmit_eval(err))) {
> -               rxe_dbg_qp(pkt->qp, "error sending packet: %d\n", err);
> -               return -EAGAIN;
> +               rxe_dbg_qp(qp, "Error sending packet: %d", err);
> +               err =3D -EAGAIN;
> +               goto err_out;
>         }
>
>         return 0;
> +
> +err_not_sent:
> +       skb->destructor =3D NULL;
> +       atomic_dec(&pkt->qp->skb_out);
> +       kfree_skb(skb);
> +       sock_put(sk);
> +err_out:
> +       return err;
>  }
>
>  /* fix up a send packet to match the packets
> diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/r=
xe/rxe_qp.c
> index a569b111a9d2..dcbf71031453 100644
> --- a/drivers/infiniband/sw/rxe/rxe_qp.c
> +++ b/drivers/infiniband/sw/rxe/rxe_qp.c
> @@ -194,7 +194,6 @@ static int rxe_qp_init_req(struct rxe_dev *rxe, struc=
t rxe_qp *qp,
>         err =3D sock_create_kern(&init_net, AF_INET, SOCK_DGRAM, 0, &qp->=
sk);
>         if (err < 0)
>                 return err;
> -       qp->sk->sk->sk_user_data =3D qp;
>
>         /* pick a source UDP port number for this QP based on
>          * the source QPN. this spreads traffic for different QPs
> --
> 2.39.2
>
