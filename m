Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB0DF582D34
	for <lists+linux-rdma@lfdr.de>; Wed, 27 Jul 2022 18:55:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240660AbiG0QzH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 27 Jul 2022 12:55:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240901AbiG0QxE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 27 Jul 2022 12:53:04 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84DFC120
        for <linux-rdma@vger.kernel.org>; Wed, 27 Jul 2022 09:35:06 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id m8so22109783edd.9
        for <linux-rdma@vger.kernel.org>; Wed, 27 Jul 2022 09:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ra35BBckW7tmTXxkjZTPc+2IIyLgNYGi6O2OPjLPkRk=;
        b=INeAchBqPJHg2AziIBggu9ncU/KU+OlVqOcQWN41fzDnArNtph3YCpRXF3mRWzkAVm
         N26Xj8R/BLMwIkFogJDcf8kYUM2gM3VyTJ44tDvWbYtGbfcbJymtDXijYNxhx+WQeYSK
         RWklEGtlboQorPSSyEcYAyjFoGXYHt9xYky1+7cOdiomYbWXlP3/aLoSLu75r+sxS6Rv
         fRobrOLvGMyBf988V6DM/i0fME6CFIL00EQLI/pIhUHLlyGEqQyA1osb5I2oOy3OWSMQ
         HejFIF5pvq85hwiljSrNzwDGoyG7PHPahNGyTd4SMEGYtGWwS30JohrzOneTBNw7Q37e
         BS4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ra35BBckW7tmTXxkjZTPc+2IIyLgNYGi6O2OPjLPkRk=;
        b=6mcV0dtBHa6LtUAh2hwHrBBa4WUAI3vMsxeKpEJLqYFpMEacM6JHfSeoa5/1mZ+gmy
         MebWs6qt2fX1RB4/grJala9u4hN4SfEDoVuqyGQSM8BwyIMGzFfoI5iwjoy50OL2WOew
         eOtT5XK4XvseFQaOqd0K3/S3nZkyaatMZMkO99YBTq8hjiZCN38nb0iCZkiNvkTFNaMq
         UCOCDHRDhHuvGyPlUoIA2Ey3GvLZQoti+x98hWC9hoH2EAO5WEeZRhl0zMVp5YsAWnE5
         g8gqYgspOysKS+F8cKrC2uO0YFq/HFj6/sTbAlUgPedzWIgLmfZlyxqdRWhj7ASiEW2z
         LvQQ==
X-Gm-Message-State: AJIora9ktyadzBYd/pWROTHCDwQ14zkNDc2KcOgMlT8p/H/fPX+LalhK
        SWjbNaou4FPPlK0QCheukebez7o82s//YKifgScQcA==
X-Google-Smtp-Source: AGRyM1v6uAqAxXvDAfGASvVqhxXxynq2QUQhPVzOOcMqfZ66UpJZ/rusn70tU8KwoyJsEBi+i+VSjl2VIJygCr6eiZM=
X-Received: by 2002:a05:6402:11cb:b0:43c:c7a3:ff86 with SMTP id
 j11-20020a05640211cb00b0043cc7a3ff86mr2272255edw.383.1658939704744; Wed, 27
 Jul 2022 09:35:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220726195602.12368-1-rpearsonhpe@gmail.com> <CAJpMwygY-iTUO9mookqJUBZjxp0MjSYQMiu52xBQP74YLsUkJQ@mail.gmail.com>
 <ec579b9e-59ba-704c-f481-beb26ab6bab2@gmail.com>
In-Reply-To: <ec579b9e-59ba-704c-f481-beb26ab6bab2@gmail.com>
From:   Haris Iqbal <haris.iqbal@ionos.com>
Date:   Wed, 27 Jul 2022 18:34:53 +0200
Message-ID: <CAJpMwyjLA5eDo9LdDMGi8FESbmH52f0rOK6vFD5gCdkG0sGKtw@mail.gmail.com>
Subject: Re: [PATCH for-next] RDMA/rxe: Cleanup rxe_init_packet()
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jul 27, 2022 at 6:01 PM Bob Pearson <rpearsonhpe@gmail.com> wrote:
>
> On 7/27/22 05:23, Haris Iqbal wrote:
> > On Tue, Jul 26, 2022 at 9:56 PM Bob Pearson <rpearsonhpe@gmail.com> wrote:
> >>
> >> Currently rxe_init_packet() recomputes ndev from the address
> >> vector but struct rxe_dev already holds a reference to ndev.
> >>
> >> Cleanup rxe_init_packet to use the value of ndev in rxe and drop
> >> an unneeded parameter paylen since it is already carried in the
> >> packet info struct.
> >>
> >> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
> >> ---
> >>  drivers/infiniband/sw/rxe/rxe_loc.h  |  2 +-
> >>  drivers/infiniband/sw/rxe/rxe_net.c  | 49 +++++++++++-----------------
> >>  drivers/infiniband/sw/rxe/rxe_req.c  |  2 +-
> >>  drivers/infiniband/sw/rxe/rxe_resp.c |  3 +-
> >>  4 files changed, 23 insertions(+), 33 deletions(-)
> >>
> >> diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
> >> index f9af30f582c6..7f98d296bc0d 100644
> >> --- a/drivers/infiniband/sw/rxe/rxe_loc.h
> >> +++ b/drivers/infiniband/sw/rxe/rxe_loc.h
> >> @@ -93,7 +93,7 @@ void rxe_mw_cleanup(struct rxe_pool_elem *elem);
> >>
> >>  /* rxe_net.c */
> >>  struct sk_buff *rxe_init_packet(struct rxe_dev *rxe, struct rxe_av *av,
> >> -                               int paylen, struct rxe_pkt_info *pkt);
> >> +                               struct rxe_pkt_info *pkt);
> >>  int rxe_prepare(struct rxe_av *av, struct rxe_pkt_info *pkt,
> >>                 struct sk_buff *skb);
> >>  int rxe_xmit_packet(struct rxe_qp *qp, struct rxe_pkt_info *pkt,
> >> diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c
> >> index c53f4529f098..4a091f236dde 100644
> >> --- a/drivers/infiniband/sw/rxe/rxe_net.c
> >> +++ b/drivers/infiniband/sw/rxe/rxe_net.c
> >> @@ -443,18 +443,22 @@ int rxe_xmit_packet(struct rxe_qp *qp, struct rxe_pkt_info *pkt,
> >>         return err;
> >>  }
> >>
> >> +/**
> >> + * rxe_init_packet - allocate and initialize a new skb
> >> + * @rxe: rxe device
> >> + * @av: remote address vector
> >> + * @pkt: packet info
> >> + *
> >> + * Returns: an skb on success else NULL
> >> + */
> >>  struct sk_buff *rxe_init_packet(struct rxe_dev *rxe, struct rxe_av *av,
> >> -                               int paylen, struct rxe_pkt_info *pkt)
> >> +                               struct rxe_pkt_info *pkt)
> >>  {
> >>         unsigned int hdr_len;
> >>         struct sk_buff *skb = NULL;
> >> -       struct net_device *ndev;
> >> -       const struct ib_gid_attr *attr;
> >> +       struct net_device *ndev = rxe->ndev;
> >>         const int port_num = 1;
> >> -
> >> -       attr = rdma_get_gid_attr(&rxe->ib_dev, port_num, av->grh.sgid_index);
> >> -       if (IS_ERR(attr))
> >> -               return NULL;
> >> +       int skb_size;
> >>
> >>         if (av->network_type == RXE_NETWORK_TYPE_IPV4)
> >>                 hdr_len = ETH_HLEN + sizeof(struct udphdr) +
> >> @@ -463,26 +467,13 @@ struct sk_buff *rxe_init_packet(struct rxe_dev *rxe, struct rxe_av *av,
> >>                 hdr_len = ETH_HLEN + sizeof(struct udphdr) +
> >>                         sizeof(struct ipv6hdr);
> >>
> >> -       rcu_read_lock();
> >
> > Was removing this rcu lock intentional? If so, do we need a mention of
> > this in the commit message why its not needed anymore?
> >
> The rcu lock was required to use the rdma_read_gid_attr_ndev_rcu() API.
> For the rxe driver there is no way that the ndev is changing once the rxe device
> is set up and ndev was passed in to rxe_newlink() and saved in the rxe_dev struct.
> Not any good reason to do all this work to get ndev when we already know it.

I see. Thanks for the explanation.

One more question for my understanding.
There was a FIXME line (removed with this commit) mentioning that we
should hold a reference to the netdev. I assume it was talking about
dev_hold.
Now, while initing the rxe we call ib_device_set_netdev, which does
dev_hold. But I could not find rxe doing dev_hold anywhere directly. I
am assuming this is enough, or should rxe be also holding a reference
for this net device since technically it does use it directly at some
places?


> >> -       ndev = rdma_read_gid_attr_ndev_rcu(attr);
> >> -       if (IS_ERR(ndev)) {
> >> -               rcu_read_unlock();
> >> -               goto out;
> >> -       }
> >> -       skb = alloc_skb(paylen + hdr_len + LL_RESERVED_SPACE(ndev),
> >> -                       GFP_ATOMIC);
> >> -
> >> -       if (unlikely(!skb)) {
> >> -               rcu_read_unlock();
> >> -               goto out;
> >> -       }
> >> -
> >> -       skb_reserve(skb, hdr_len + LL_RESERVED_SPACE(ndev));
> >> -
> >> -       /* FIXME: hold reference to this netdev until life of this skb. */
> >> -       skb->dev        = ndev;
> >> -       rcu_read_unlock();
> >> +       skb_size = LL_RESERVED_SPACE(ndev) + hdr_len + pkt->paylen;
> >> +       skb = alloc_skb(skb_size, GFP_ATOMIC);
> >> +       if (unlikely(!skb))
> >> +               return NULL;
> >>
> >> +       skb_reserve(skb, LL_RESERVED_SPACE(ndev) + hdr_len);
> >> +       skb->dev = ndev;
> >>         if (av->network_type == RXE_NETWORK_TYPE_IPV4)
> >>                 skb->protocol = htons(ETH_P_IP);
> >>         else
> >> @@ -490,11 +481,9 @@ struct sk_buff *rxe_init_packet(struct rxe_dev *rxe, struct rxe_av *av,
> >>
> >>         pkt->rxe        = rxe;
> >>         pkt->port_num   = port_num;
> >> -       pkt->hdr        = skb_put(skb, paylen);
> >> -       pkt->mask       |= RXE_GRH_MASK;
> >> +       pkt->hdr        = skb_put(skb, pkt->paylen);
> >> +       pkt->mask      |= RXE_GRH_MASK;
> >>
> >> -out:
> >> -       rdma_put_gid_attr(attr);
> >>         return skb;
> >>  }
> >>
> >> diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
> >> index 49e8f54db6f5..e72db960d7ea 100644
> >> --- a/drivers/infiniband/sw/rxe/rxe_req.c
> >> +++ b/drivers/infiniband/sw/rxe/rxe_req.c
> >> @@ -397,7 +397,7 @@ static struct sk_buff *init_req_packet(struct rxe_qp *qp,
> >>         pkt->paylen = paylen;
> >>
> >>         /* init skb */
> >> -       skb = rxe_init_packet(rxe, av, paylen, pkt);
> >> +       skb = rxe_init_packet(rxe, av, pkt);
> >>         if (unlikely(!skb))
> >>                 return NULL;
> >>
> >> diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
> >> index b36ec5c4d5e0..02a5d4ebb45e 100644
> >> --- a/drivers/infiniband/sw/rxe/rxe_resp.c
> >> +++ b/drivers/infiniband/sw/rxe/rxe_resp.c
> >> @@ -670,8 +670,9 @@ static struct sk_buff *prepare_ack_packet(struct rxe_qp *qp,
> >>          */
> >>         pad = (-payload) & 0x3;
> >>         paylen = rxe_opcode[opcode].length + payload + pad + RXE_ICRC_SIZE;
> >> +       ack->paylen = paylen;
> >
> > Maybe remove the old ack->paylen assignment which is done later in
> > this function?
> >
> Agreed. Will send a v2 with this change.
> >>
> >> -       skb = rxe_init_packet(rxe, &qp->pri_av, paylen, ack);
> >> +       skb = rxe_init_packet(rxe, &qp->pri_av, ack);
> >>         if (!skb)
> >>                 return NULL;
> >>
> >> --
> >> 2.34.1
> >>
>
> Bob
