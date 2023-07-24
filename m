Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F51375FF04
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Jul 2023 20:26:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbjGXS0x (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 24 Jul 2023 14:26:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjGXS0w (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 24 Jul 2023 14:26:52 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FA8C127
        for <linux-rdma@vger.kernel.org>; Mon, 24 Jul 2023 11:26:49 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-1bb7297c505so782059fac.1
        for <linux-rdma@vger.kernel.org>; Mon, 24 Jul 2023 11:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690223208; x=1690828008;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TedRC37i6cCqyWGRe2qBH8/CkDWmrggBws+CxmW996Q=;
        b=GHcVT+q5QcfX2sWVcHq4C58BRYFWXfOl5e/zWcUysLmlhOm+30lHQCl6wCzYIFuupO
         6wriUa1pW2mjDWHztMzDvkKiFlFNe6SCAaMorjL6HgyuWghAs98G4F2Zxu/LxPBl0BgA
         yNEoTrwyBKdI3XB3kft6QmSzhTjb6r0+eFoXKBGgimpqnhUmZ5Z9DcoPM4NbUKL4Y4xW
         LxzOwOnAvua69SlFMGht1aAdnS+iBqBiyxLMq+sMQvOyS4e3dkLpwnEqwzCGz+FTcCvI
         rQQPal75kgufYo1jY6HvGTnFf7KUJmtheJFnsSuhx6CbaeSkyERGXDS99zJGWxIyYUkY
         qL/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690223208; x=1690828008;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TedRC37i6cCqyWGRe2qBH8/CkDWmrggBws+CxmW996Q=;
        b=WDrizhaL7rbUItSa4QV7KotsDZ5ZHPc0CjuR7M05me8GNwKyI1ZeaTO1mj2+kslqGz
         UMJ5Iii3/Z2t0fHVA+eApo7QcYmQwCOa/5YdjL+uuNg870ZLZGHl3gu8c5rfWZLnuppG
         n8sF6qBdH9feL9vchmlsyI8iSP64KuamYsBnmwCCePvsJWemo8JVaeUMeExk0dwgYEy/
         JA6168d4FiTmjw6R0rfAeUVmM8VJUR4ilWcZXGIBKPw+afM/3xI70dM2PTcr8pU9s6yL
         UmvUfsWtJSrBHxHYHaMSM1A0ju1ohYP8s1VKWYHcfMfXys+mjTb3EIwlPnVLZtxp0HRs
         3n4g==
X-Gm-Message-State: ABy/qLZ+PVB/K22m4cjFp89kTDZsfshY/AIPMOmZrTsquj0e5P4zdKmp
        XvU/A3jzw0ISzXA8PnTq4VqmwYL9VA4=
X-Google-Smtp-Source: APBJJlGOytUl1mn4SS/WN1+icurJ/wyC0UmbyeJGyZot3dqCexX7xjbrlq3HI5nHdI8LPM15ZXh4EA==
X-Received: by 2002:a05:6870:d110:b0:1bb:5480:4b4 with SMTP id e16-20020a056870d11000b001bb548004b4mr5437542oac.8.1690223208569;
        Mon, 24 Jul 2023 11:26:48 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:1433:d43e:43e7:6f50? (2603-8081-140c-1a00-1433-d43e-43e7-6f50.res6.spectrum.com. [2603:8081:140c:1a00:1433:d43e:43e7:6f50])
        by smtp.gmail.com with ESMTPSA id b4-20020a056871030400b001a695700c69sm337321oag.37.2023.07.24.11.26.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jul 2023 11:26:47 -0700 (PDT)
Message-ID: <e71acf55-0744-f71c-294c-f2b122d16cdf@gmail.com>
Date:   Mon, 24 Jul 2023 13:26:47 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH for-next 4/9] RDMA/rxe: Fix delayed send packet handling
Content-Language: en-US
To:     Leon Romanovsky <leon@kernel.org>,
        Zhu Yanjun <zyjzyj2000@gmail.com>
Cc:     jgg@nvidia.com, jhack@hpe.com, linux-rdma@vger.kernel.org
References: <20230721205021.5394-1-rpearsonhpe@gmail.com>
 <20230721205021.5394-5-rpearsonhpe@gmail.com>
 <CAD=hENeFSR1R8C0PkSSoE22atotT_1tJ1tzHzpNoirb996FNmQ@mail.gmail.com>
 <20230724175923.GC11388@unreal>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <20230724175923.GC11388@unreal>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 7/24/23 12:59, Leon Romanovsky wrote:
> On Sun, Jul 23, 2023 at 09:03:34PM +0800, Zhu Yanjun wrote:
>> On Sat, Jul 22, 2023 at 4:51 AM Bob Pearson <rpearsonhpe@gmail.com> wrote:
>>>
>>> In cable pull testing some NICs can hold a send packet long enough
>>> to allow ulp protocol stacks to destroy the qp and the cleanup
>>> routines to timeout waiting for all qp references to be released.
>>> When the NIC driver finally frees the SKB the qp pointer is no longer
>>> valid and causes a seg fault in rxe_skb_tx_dtor().
>>
>> If a packet is held in some NICs, the later packets of this packet
>> will also be held by this NIC. So this will cause QP not to work well.
>> This is a serious problem. And the problem should be fixed in this
>> kind of NICs. We should not fix it in RXE.
>>
>> And a QP exists for at least several seconds. A packet can be held in
>> NIC for such a long time? This problem does exist in the real world,
>> or you imagine this scenario?
>>
>> I can not imagine this kind of scenario. Please Jason or Leon also check this.
> 
> I stopped to follow RXE changes for a long time. They don't make any sense to me.
> Even this patch, which moves existing IB reference counter from one place to another
> and does it for every SKB is beyond my understanding.

At the end of the day, we used to take a reference on the QP for each send packet and
drop it in the destructor function. (why? we are keeping a count of pending send packets
to keep from overloading the send queue.) But with link failures which can take many seconds
to recover this gets in the way of lustre cleaning up a bad connection when it times out
first. So instead we take a reference on the sock struct since if you destroy the QP you
also destroy the QP socket struct which drops its reference on the sock struct which gets it
freed before the packet is finally sent and the destructor gets called. That reference is dropped in
the destructor. We still need to get to the qp pointer in the destructor so we pass the
qp# in the sock->user_data instead of the qp pointer. Now if the qp has been destroyed the
qp lookup from the qp# fails and you just don't touch the counter. It really all just does work fine.

Bob
> 
> Thanks
> 
>>
>> Thanks.
>> Zhu Yanjun
>>>
>>> This patch passes the qp index instead of the qp to the skb destructor
>>> callback function. The call back is required to lookup the qp from the
>>> index and if it has been destroyed the lookup will return NULL and the
>>> qp will not be referenced avoiding the seg fault.
>>>
>>> Fixes: 8700e3e7c485 ("Soft RoCE driver")
>>> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
>>> ---
>>>  drivers/infiniband/sw/rxe/rxe_net.c | 87 ++++++++++++++++++++++-------
>>>  drivers/infiniband/sw/rxe/rxe_qp.c  |  1 -
>>>  2 files changed, 67 insertions(+), 21 deletions(-)
>>>
>>> diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c
>>> index cd59666158b1..10e4a752ff7c 100644
>>> --- a/drivers/infiniband/sw/rxe/rxe_net.c
>>> +++ b/drivers/infiniband/sw/rxe/rxe_net.c
>>> @@ -131,19 +131,28 @@ static struct dst_entry *rxe_find_route(struct net_device *ndev,
>>>         return dst;
>>>  }
>>>
>>> +static struct rxe_dev *get_rxe_from_skb(struct sk_buff *skb)
>>> +{
>>> +       struct rxe_dev *rxe;
>>> +       struct net_device *ndev = skb->dev;
>>> +
>>> +       rxe = rxe_get_dev_from_net(ndev);
>>> +       if (!rxe && is_vlan_dev(ndev))
>>> +               rxe = rxe_get_dev_from_net(vlan_dev_real_dev(ndev));
>>> +
>>> +       return rxe;
>>> +}
>>> +
>>>  static int rxe_udp_encap_recv(struct sock *sk, struct sk_buff *skb)
>>>  {
>>>         struct udphdr *udph;
>>>         struct rxe_dev *rxe;
>>> -       struct net_device *ndev = skb->dev;
>>>         struct rxe_pkt_info *pkt = SKB_TO_PKT(skb);
>>>
>>>         /* takes a reference on rxe->ib_dev
>>>          * drop when skb is freed
>>>          */
>>> -       rxe = rxe_get_dev_from_net(ndev);
>>> -       if (!rxe && is_vlan_dev(ndev))
>>> -               rxe = rxe_get_dev_from_net(vlan_dev_real_dev(ndev));
>>> +       rxe = get_rxe_from_skb(skb);
>>>         if (!rxe)
>>>                 goto drop;
>>>
>>> @@ -345,46 +354,84 @@ int rxe_prepare(struct rxe_av *av, struct rxe_pkt_info *pkt,
>>>
>>>  static void rxe_skb_tx_dtor(struct sk_buff *skb)
>>>  {
>>> -       struct sock *sk = skb->sk;
>>> -       struct rxe_qp *qp = sk->sk_user_data;
>>> -       int skb_out = atomic_dec_return(&qp->skb_out);
>>> +       struct rxe_dev *rxe;
>>> +       unsigned int index;
>>> +       struct rxe_qp *qp;
>>> +       int skb_out;
>>> +
>>> +       /* takes a ref on ib device if success */
>>> +       rxe = get_rxe_from_skb(skb);
>>> +       if (!rxe)
>>> +               goto out;
>>> +
>>> +       /* recover source qp index from sk->sk_user_data
>>> +        * free the reference taken in rxe_send
>>> +        */
>>> +       index = (int)(uintptr_t)skb->sk->sk_user_data;
>>> +       sock_put(skb->sk);
>>>
>>> +       /* lookup qp from index, takes a ref on success */
>>> +       qp = rxe_pool_get_index(&rxe->qp_pool, index);
>>> +       if (!qp)
>>> +               goto out_put_ibdev;
>>> +
>>> +       skb_out = atomic_dec_return(&qp->skb_out);
>>>         if (unlikely(qp->need_req_skb &&
>>>                      skb_out < RXE_INFLIGHT_SKBS_PER_QP_LOW))
>>>                 rxe_sched_task(&qp->req.task);
>>>
>>>         rxe_put(qp);
>>> +out_put_ibdev:
>>> +       ib_device_put(&rxe->ib_dev);
>>> +out:
>>> +       return;
>>>  }
>>>
>>>  static int rxe_send(struct sk_buff *skb, struct rxe_pkt_info *pkt)
>>>  {
>>> +       struct rxe_qp *qp = pkt->qp;
>>> +       struct sock *sk;
>>>         int err;
>>>
>>> -       skb->destructor = rxe_skb_tx_dtor;
>>> -       skb->sk = pkt->qp->sk->sk;
>>> +       /* qp can be destroyed while this packet is waiting on
>>> +        * the tx queue. So need to protect sk.
>>> +        */
>>> +       sk = qp->sk->sk;
>>> +       sock_hold(sk);
>>> +       skb->sk = sk;
>>>
>>> -       rxe_get(pkt->qp);
>>>         atomic_inc(&pkt->qp->skb_out);
>>>
>>> +       sk->sk_user_data = (void *)(long)qp->elem.index;
>>> +       skb->destructor = rxe_skb_tx_dtor;
>>> +
>>>         if (skb->protocol == htons(ETH_P_IP)) {
>>> -               err = ip_local_out(dev_net(skb_dst(skb)->dev), skb->sk, skb);
>>> +               err = ip_local_out(dev_net(skb_dst(skb)->dev), sk, skb);
>>>         } else if (skb->protocol == htons(ETH_P_IPV6)) {
>>> -               err = ip6_local_out(dev_net(skb_dst(skb)->dev), skb->sk, skb);
>>> +               err = ip6_local_out(dev_net(skb_dst(skb)->dev), sk, skb);
>>>         } else {
>>> -               rxe_dbg_qp(pkt->qp, "Unknown layer 3 protocol: %d\n",
>>> -                               skb->protocol);
>>> -               atomic_dec(&pkt->qp->skb_out);
>>> -               rxe_put(pkt->qp);
>>> -               kfree_skb(skb);
>>> -               return -EINVAL;
>>> +               rxe_dbg_qp(qp, "Unknown layer 3 protocol: %d",
>>> +                          skb->protocol);
>>> +               err = -EINVAL;
>>> +               goto err_not_sent;
>>>         }
>>>
>>> +       /* IP consumed the packet, the destructor will handle cleanup */
>>>         if (unlikely(net_xmit_eval(err))) {
>>> -               rxe_dbg_qp(pkt->qp, "error sending packet: %d\n", err);
>>> -               return -EAGAIN;
>>> +               rxe_dbg_qp(qp, "Error sending packet: %d", err);
>>> +               err = -EAGAIN;
>>> +               goto err_out;
>>>         }
>>>
>>>         return 0;
>>> +
>>> +err_not_sent:
>>> +       skb->destructor = NULL;
>>> +       atomic_dec(&pkt->qp->skb_out);
>>> +       kfree_skb(skb);
>>> +       sock_put(sk);
>>> +err_out:
>>> +       return err;
>>>  }
>>>
>>>  /* fix up a send packet to match the packets
>>> diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/rxe/rxe_qp.c
>>> index a569b111a9d2..dcbf71031453 100644
>>> --- a/drivers/infiniband/sw/rxe/rxe_qp.c
>>> +++ b/drivers/infiniband/sw/rxe/rxe_qp.c
>>> @@ -194,7 +194,6 @@ static int rxe_qp_init_req(struct rxe_dev *rxe, struct rxe_qp *qp,
>>>         err = sock_create_kern(&init_net, AF_INET, SOCK_DGRAM, 0, &qp->sk);
>>>         if (err < 0)
>>>                 return err;
>>> -       qp->sk->sk->sk_user_data = qp;
>>>
>>>         /* pick a source UDP port number for this QP based on
>>>          * the source QPN. this spreads traffic for different QPs
>>> --
>>> 2.39.2
>>>

