Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FBE275FEAB
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Jul 2023 20:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230349AbjGXSAO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 24 Jul 2023 14:00:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231849AbjGXR75 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 24 Jul 2023 13:59:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 053931BD8
        for <linux-rdma@vger.kernel.org>; Mon, 24 Jul 2023 10:59:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 75C286134C
        for <linux-rdma@vger.kernel.org>; Mon, 24 Jul 2023 17:59:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 464F2C433C7;
        Mon, 24 Jul 2023 17:59:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690221567;
        bh=Ouowv38jeW5oVjg5T4sFKdiP2NyeQr6JixFv7el8+14=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CX3Il+Wi2KvF39130stQK6StrcFaJZCYuaazTFmvCK76yuMIrT+UuMDCDRbl+Qy30
         kXI9sXRhtjfKoy7dVE56gbq7oOyqUoklwxB4IOmtmJw6FMKoiQ+6hEdt2bFG7SsnPk
         DVlx2k8Zy+gSlaFXcA/FQw0AVCbVvaX6zFeVVPaZwSGXNk42gWk8ixoI6BmXYFAo9o
         sHDTHbm7b+f9Q/KAb6b2xdjcaMsYNzJA7rLjPlUtVNuzCqj3HaTFcK4VCd1ZfDWxQz
         sRihZoT8qSzlZvSqd5BRB/zSifV9VpMRwJAPmz6Y3I8YJ6uL6WQp1EycXg1GYtZvx7
         zCmq6/6LGa98A==
Date:   Mon, 24 Jul 2023 20:59:23 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Zhu Yanjun <zyjzyj2000@gmail.com>
Cc:     Bob Pearson <rpearsonhpe@gmail.com>, jgg@nvidia.com, jhack@hpe.com,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next 4/9] RDMA/rxe: Fix delayed send packet handling
Message-ID: <20230724175923.GC11388@unreal>
References: <20230721205021.5394-1-rpearsonhpe@gmail.com>
 <20230721205021.5394-5-rpearsonhpe@gmail.com>
 <CAD=hENeFSR1R8C0PkSSoE22atotT_1tJ1tzHzpNoirb996FNmQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD=hENeFSR1R8C0PkSSoE22atotT_1tJ1tzHzpNoirb996FNmQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Jul 23, 2023 at 09:03:34PM +0800, Zhu Yanjun wrote:
> On Sat, Jul 22, 2023 at 4:51 AM Bob Pearson <rpearsonhpe@gmail.com> wrote:
> >
> > In cable pull testing some NICs can hold a send packet long enough
> > to allow ulp protocol stacks to destroy the qp and the cleanup
> > routines to timeout waiting for all qp references to be released.
> > When the NIC driver finally frees the SKB the qp pointer is no longer
> > valid and causes a seg fault in rxe_skb_tx_dtor().
> 
> If a packet is held in some NICs, the later packets of this packet
> will also be held by this NIC. So this will cause QP not to work well.
> This is a serious problem. And the problem should be fixed in this
> kind of NICs. We should not fix it in RXE.
> 
> And a QP exists for at least several seconds. A packet can be held in
> NIC for such a long time? This problem does exist in the real world,
> or you imagine this scenario?
> 
> I can not imagine this kind of scenario. Please Jason or Leon also check this.

I stopped to follow RXE changes for a long time. They don't make any sense to me.
Even this patch, which moves existing IB reference counter from one place to another
and does it for every SKB is beyond my understanding.

Thanks

> 
> Thanks.
> Zhu Yanjun
> >
> > This patch passes the qp index instead of the qp to the skb destructor
> > callback function. The call back is required to lookup the qp from the
> > index and if it has been destroyed the lookup will return NULL and the
> > qp will not be referenced avoiding the seg fault.
> >
> > Fixes: 8700e3e7c485 ("Soft RoCE driver")
> > Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
> > ---
> >  drivers/infiniband/sw/rxe/rxe_net.c | 87 ++++++++++++++++++++++-------
> >  drivers/infiniband/sw/rxe/rxe_qp.c  |  1 -
> >  2 files changed, 67 insertions(+), 21 deletions(-)
> >
> > diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c
> > index cd59666158b1..10e4a752ff7c 100644
> > --- a/drivers/infiniband/sw/rxe/rxe_net.c
> > +++ b/drivers/infiniband/sw/rxe/rxe_net.c
> > @@ -131,19 +131,28 @@ static struct dst_entry *rxe_find_route(struct net_device *ndev,
> >         return dst;
> >  }
> >
> > +static struct rxe_dev *get_rxe_from_skb(struct sk_buff *skb)
> > +{
> > +       struct rxe_dev *rxe;
> > +       struct net_device *ndev = skb->dev;
> > +
> > +       rxe = rxe_get_dev_from_net(ndev);
> > +       if (!rxe && is_vlan_dev(ndev))
> > +               rxe = rxe_get_dev_from_net(vlan_dev_real_dev(ndev));
> > +
> > +       return rxe;
> > +}
> > +
> >  static int rxe_udp_encap_recv(struct sock *sk, struct sk_buff *skb)
> >  {
> >         struct udphdr *udph;
> >         struct rxe_dev *rxe;
> > -       struct net_device *ndev = skb->dev;
> >         struct rxe_pkt_info *pkt = SKB_TO_PKT(skb);
> >
> >         /* takes a reference on rxe->ib_dev
> >          * drop when skb is freed
> >          */
> > -       rxe = rxe_get_dev_from_net(ndev);
> > -       if (!rxe && is_vlan_dev(ndev))
> > -               rxe = rxe_get_dev_from_net(vlan_dev_real_dev(ndev));
> > +       rxe = get_rxe_from_skb(skb);
> >         if (!rxe)
> >                 goto drop;
> >
> > @@ -345,46 +354,84 @@ int rxe_prepare(struct rxe_av *av, struct rxe_pkt_info *pkt,
> >
> >  static void rxe_skb_tx_dtor(struct sk_buff *skb)
> >  {
> > -       struct sock *sk = skb->sk;
> > -       struct rxe_qp *qp = sk->sk_user_data;
> > -       int skb_out = atomic_dec_return(&qp->skb_out);
> > +       struct rxe_dev *rxe;
> > +       unsigned int index;
> > +       struct rxe_qp *qp;
> > +       int skb_out;
> > +
> > +       /* takes a ref on ib device if success */
> > +       rxe = get_rxe_from_skb(skb);
> > +       if (!rxe)
> > +               goto out;
> > +
> > +       /* recover source qp index from sk->sk_user_data
> > +        * free the reference taken in rxe_send
> > +        */
> > +       index = (int)(uintptr_t)skb->sk->sk_user_data;
> > +       sock_put(skb->sk);
> >
> > +       /* lookup qp from index, takes a ref on success */
> > +       qp = rxe_pool_get_index(&rxe->qp_pool, index);
> > +       if (!qp)
> > +               goto out_put_ibdev;
> > +
> > +       skb_out = atomic_dec_return(&qp->skb_out);
> >         if (unlikely(qp->need_req_skb &&
> >                      skb_out < RXE_INFLIGHT_SKBS_PER_QP_LOW))
> >                 rxe_sched_task(&qp->req.task);
> >
> >         rxe_put(qp);
> > +out_put_ibdev:
> > +       ib_device_put(&rxe->ib_dev);
> > +out:
> > +       return;
> >  }
> >
> >  static int rxe_send(struct sk_buff *skb, struct rxe_pkt_info *pkt)
> >  {
> > +       struct rxe_qp *qp = pkt->qp;
> > +       struct sock *sk;
> >         int err;
> >
> > -       skb->destructor = rxe_skb_tx_dtor;
> > -       skb->sk = pkt->qp->sk->sk;
> > +       /* qp can be destroyed while this packet is waiting on
> > +        * the tx queue. So need to protect sk.
> > +        */
> > +       sk = qp->sk->sk;
> > +       sock_hold(sk);
> > +       skb->sk = sk;
> >
> > -       rxe_get(pkt->qp);
> >         atomic_inc(&pkt->qp->skb_out);
> >
> > +       sk->sk_user_data = (void *)(long)qp->elem.index;
> > +       skb->destructor = rxe_skb_tx_dtor;
> > +
> >         if (skb->protocol == htons(ETH_P_IP)) {
> > -               err = ip_local_out(dev_net(skb_dst(skb)->dev), skb->sk, skb);
> > +               err = ip_local_out(dev_net(skb_dst(skb)->dev), sk, skb);
> >         } else if (skb->protocol == htons(ETH_P_IPV6)) {
> > -               err = ip6_local_out(dev_net(skb_dst(skb)->dev), skb->sk, skb);
> > +               err = ip6_local_out(dev_net(skb_dst(skb)->dev), sk, skb);
> >         } else {
> > -               rxe_dbg_qp(pkt->qp, "Unknown layer 3 protocol: %d\n",
> > -                               skb->protocol);
> > -               atomic_dec(&pkt->qp->skb_out);
> > -               rxe_put(pkt->qp);
> > -               kfree_skb(skb);
> > -               return -EINVAL;
> > +               rxe_dbg_qp(qp, "Unknown layer 3 protocol: %d",
> > +                          skb->protocol);
> > +               err = -EINVAL;
> > +               goto err_not_sent;
> >         }
> >
> > +       /* IP consumed the packet, the destructor will handle cleanup */
> >         if (unlikely(net_xmit_eval(err))) {
> > -               rxe_dbg_qp(pkt->qp, "error sending packet: %d\n", err);
> > -               return -EAGAIN;
> > +               rxe_dbg_qp(qp, "Error sending packet: %d", err);
> > +               err = -EAGAIN;
> > +               goto err_out;
> >         }
> >
> >         return 0;
> > +
> > +err_not_sent:
> > +       skb->destructor = NULL;
> > +       atomic_dec(&pkt->qp->skb_out);
> > +       kfree_skb(skb);
> > +       sock_put(sk);
> > +err_out:
> > +       return err;
> >  }
> >
> >  /* fix up a send packet to match the packets
> > diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/rxe/rxe_qp.c
> > index a569b111a9d2..dcbf71031453 100644
> > --- a/drivers/infiniband/sw/rxe/rxe_qp.c
> > +++ b/drivers/infiniband/sw/rxe/rxe_qp.c
> > @@ -194,7 +194,6 @@ static int rxe_qp_init_req(struct rxe_dev *rxe, struct rxe_qp *qp,
> >         err = sock_create_kern(&init_net, AF_INET, SOCK_DGRAM, 0, &qp->sk);
> >         if (err < 0)
> >                 return err;
> > -       qp->sk->sk->sk_user_data = qp;
> >
> >         /* pick a source UDP port number for this QP based on
> >          * the source QPN. this spreads traffic for different QPs
> > --
> > 2.39.2
> >
