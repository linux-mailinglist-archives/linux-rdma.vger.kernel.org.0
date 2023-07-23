Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACF8475E404
	for <lists+linux-rdma@lfdr.de>; Sun, 23 Jul 2023 19:25:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbjGWRZB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 23 Jul 2023 13:25:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbjGWRZB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 23 Jul 2023 13:25:01 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD99A121
        for <linux-rdma@vger.kernel.org>; Sun, 23 Jul 2023 10:24:59 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id 46e09a7af769-6bb14015560so1665982a34.2
        for <linux-rdma@vger.kernel.org>; Sun, 23 Jul 2023 10:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690133099; x=1690737899;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IleOuyuiKuW+CTiywiFPyy5up/nHGPfNU2JikrSOY1Q=;
        b=obpHDUz7M5bwlUzhx2Wqup/W+8/CQ8ZqetL1i5aJXjucdrPiUntEjVUUf9QAEtTAV9
         SOhK+ll2QbXuYbPXxccG8M4aFwoVs3hB18bZHTnidil6KWGYBHs2VdnxjQwEYziRUd+M
         yRNbUkb3XIvB5AeYwez5ADx/CiJ9UZ1iOpKD/pi7mymWPt1xKj5Em+Xh+bsd4OpUTVMB
         YuLc2NqVn44YvoETz3HvcLB7fsaEAg7GuI0gir4wsSv9LfdRkKZZn763CVdEFwYnhXGl
         71/6yiPpKdvCwimyYnTSZw+5p89OrNQSMHO+r+Un5s2cw8QnNqqJCqYAAFBem2ee9Xbv
         VUeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690133099; x=1690737899;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IleOuyuiKuW+CTiywiFPyy5up/nHGPfNU2JikrSOY1Q=;
        b=dRYK8vBimlX9ROUhcm58JYSVpfTtcYe1gNSk2+FaV6Ca/RUUbL07u31pR0OA5B/2Oi
         gElqclwp6p3Jhy4373j/uChVB3wu7w0NiGxiyQKU2V/13acPXqpw8NswRXHZV9ZWhHrR
         DXfTdPtU6A7u+9BCjqDQuUMEb0XOw2Se2pE2OhZ5celx7n2e/zOVSE+ytY/g5tK2AADz
         O91aGw5aMSGKVJ+pZw4D+iR1gIp8xbhKDY9lGYZHaFaROKGOz2WGhuLPgfGgIAA06F/R
         c4sba23+mwpI5arQcJr65Ia+A8yhOc6LhLFds5I3mal6dfz8agv0pksuoG2JwtC/wdka
         hE0Q==
X-Gm-Message-State: ABy/qLagLJrY1RVwT91pwKsve6vLS/q+/6ADe5VoXmFTMTEZZg8X+M0g
        n+nWpSP7/92dRRXd8NErc/RZPtBTtzM=
X-Google-Smtp-Source: APBJJlHaQT2chV0BI4gd//bzOS3WS6D+dBIt6yd35cSkVnVTeQmpx/RFFwKn+v9UAEay2/4O69/FcQ==
X-Received: by 2002:a05:6830:1d52:b0:6b8:691e:ec53 with SMTP id p18-20020a0568301d5200b006b8691eec53mr4373749oth.11.1690133098851;
        Sun, 23 Jul 2023 10:24:58 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:351d:323b:44b0:f852? (2603-8081-140c-1a00-351d-323b-44b0-f852.res6.spectrum.com. [2603:8081:140c:1a00:351d:323b:44b0:f852])
        by smtp.gmail.com with ESMTPSA id k25-20020a0568301bf900b006b8a0c7e14asm3203324otb.55.2023.07.23.10.24.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Jul 2023 10:24:58 -0700 (PDT)
Message-ID: <fca4bc52-448f-7285-f8d6-60b61fbc04b1@gmail.com>
Date:   Sun, 23 Jul 2023 12:24:57 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH for-next 4/9] RDMA/rxe: Fix delayed send packet handling
To:     Zhu Yanjun <zyjzyj2000@gmail.com>
Cc:     jgg@nvidia.com, leon@kernel.org, jhack@hpe.com,
        linux-rdma@vger.kernel.org
References: <20230721205021.5394-1-rpearsonhpe@gmail.com>
 <20230721205021.5394-5-rpearsonhpe@gmail.com>
 <CAD=hENeFSR1R8C0PkSSoE22atotT_1tJ1tzHzpNoirb996FNmQ@mail.gmail.com>
Content-Language: en-US
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <CAD=hENeFSR1R8C0PkSSoE22atotT_1tJ1tzHzpNoirb996FNmQ@mail.gmail.com>
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

On 7/23/23 08:03, Zhu Yanjun wrote:
> On Sat, Jul 22, 2023 at 4:51 AM Bob Pearson <rpearsonhpe@gmail.com> wrote:
>>
>> In cable pull testing some NICs can hold a send packet long enough
>> to allow ulp protocol stacks to destroy the qp and the cleanup
>> routines to timeout waiting for all qp references to be released.
>> When the NIC driver finally frees the SKB the qp pointer is no longer
>> valid and causes a seg fault in rxe_skb_tx_dtor().
> 
> If a packet is held in some NICs, the later packets of this packet
> will also be held by this NIC. So this will cause QP not to work well.
> This is a serious problem. And the problem should be fixed in this
> kind of NICs. We should not fix it in RXE.
> 
> And a QP exists for at least several seconds. A packet can be held in
> NIC for such a long time? This problem does exist in the real world,
> or you imagine this scenario?

This was a real bug observed in a 24 hour stress test where we were running IOR
traffic over Lustre on a 256 node cluster. Then we ran a test that randomly disabled
links for 10-20 second and then reenbled them. Lustre will automatically detect the
down links and reroute the storage traffic to a new RC connection and then when the
link recovers it will reestablish RC connections on the link. The failover is triggered
by Lustre timing out on an IO operation and it then tears down the QPs. When the link
is back up the tx queue is finally processed by the NIC and the skbs are freed in the
sender calling the rxe skb destructor function which attempts to update a counter in
the QP state. During the test we would observe 2-3 kernel panics from referencing the
destroyed qp pointer. We made this change to avoid delaying the qp destroy call for an
arbitrarily long time and instead took a reference on the struct sock and used the qpn
instead of the qp pointer. There is a later patch in this series that fixes a related
but different problem which can occur at the end of the test if someone attempts to
rmmod the rxe driver while a packet is still pending. In this case it the code in the
destructor function which is gone not the QP. But still need to protect with ref counts.

Bob
> 
> I can not imagine this kind of scenario. Please Jason or Leon also check this.
> 
> Thanks.
> Zhu Yanjun
>>
>> This patch passes the qp index instead of the qp to the skb destructor
>> callback function. The call back is required to lookup the qp from the
>> index and if it has been destroyed the lookup will return NULL and the
>> qp will not be referenced avoiding the seg fault.
>>
>> Fixes: 8700e3e7c485 ("Soft RoCE driver")
>> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
>> ---
>>  drivers/infiniband/sw/rxe/rxe_net.c | 87 ++++++++++++++++++++++-------
>>  drivers/infiniband/sw/rxe/rxe_qp.c  |  1 -
>>  2 files changed, 67 insertions(+), 21 deletions(-)
>>
>> diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c
>> index cd59666158b1..10e4a752ff7c 100644
>> --- a/drivers/infiniband/sw/rxe/rxe_net.c
>> +++ b/drivers/infiniband/sw/rxe/rxe_net.c
>> @@ -131,19 +131,28 @@ static struct dst_entry *rxe_find_route(struct net_device *ndev,
>>         return dst;
>>  }
>>
>> +static struct rxe_dev *get_rxe_from_skb(struct sk_buff *skb)
>> +{
>> +       struct rxe_dev *rxe;
>> +       struct net_device *ndev = skb->dev;
>> +
>> +       rxe = rxe_get_dev_from_net(ndev);
>> +       if (!rxe && is_vlan_dev(ndev))
>> +               rxe = rxe_get_dev_from_net(vlan_dev_real_dev(ndev));
>> +
>> +       return rxe;
>> +}
>> +
>>  static int rxe_udp_encap_recv(struct sock *sk, struct sk_buff *skb)
>>  {
>>         struct udphdr *udph;
>>         struct rxe_dev *rxe;
>> -       struct net_device *ndev = skb->dev;
>>         struct rxe_pkt_info *pkt = SKB_TO_PKT(skb);
>>
>>         /* takes a reference on rxe->ib_dev
>>          * drop when skb is freed
>>          */
>> -       rxe = rxe_get_dev_from_net(ndev);
>> -       if (!rxe && is_vlan_dev(ndev))
>> -               rxe = rxe_get_dev_from_net(vlan_dev_real_dev(ndev));
>> +       rxe = get_rxe_from_skb(skb);
>>         if (!rxe)
>>                 goto drop;
>>
>> @@ -345,46 +354,84 @@ int rxe_prepare(struct rxe_av *av, struct rxe_pkt_info *pkt,
>>
>>  static void rxe_skb_tx_dtor(struct sk_buff *skb)
>>  {
>> -       struct sock *sk = skb->sk;
>> -       struct rxe_qp *qp = sk->sk_user_data;
>> -       int skb_out = atomic_dec_return(&qp->skb_out);
>> +       struct rxe_dev *rxe;
>> +       unsigned int index;
>> +       struct rxe_qp *qp;
>> +       int skb_out;
>> +
>> +       /* takes a ref on ib device if success */
>> +       rxe = get_rxe_from_skb(skb);
>> +       if (!rxe)
>> +               goto out;
>> +
>> +       /* recover source qp index from sk->sk_user_data
>> +        * free the reference taken in rxe_send
>> +        */
>> +       index = (int)(uintptr_t)skb->sk->sk_user_data;
>> +       sock_put(skb->sk);
>>
>> +       /* lookup qp from index, takes a ref on success */
>> +       qp = rxe_pool_get_index(&rxe->qp_pool, index);
>> +       if (!qp)
>> +               goto out_put_ibdev;
>> +
>> +       skb_out = atomic_dec_return(&qp->skb_out);
>>         if (unlikely(qp->need_req_skb &&
>>                      skb_out < RXE_INFLIGHT_SKBS_PER_QP_LOW))
>>                 rxe_sched_task(&qp->req.task);
>>
>>         rxe_put(qp);
>> +out_put_ibdev:
>> +       ib_device_put(&rxe->ib_dev);
>> +out:
>> +       return;
>>  }
>>
>>  static int rxe_send(struct sk_buff *skb, struct rxe_pkt_info *pkt)
>>  {
>> +       struct rxe_qp *qp = pkt->qp;
>> +       struct sock *sk;
>>         int err;
>>
>> -       skb->destructor = rxe_skb_tx_dtor;
>> -       skb->sk = pkt->qp->sk->sk;
>> +       /* qp can be destroyed while this packet is waiting on
>> +        * the tx queue. So need to protect sk.
>> +        */
>> +       sk = qp->sk->sk;
>> +       sock_hold(sk);
>> +       skb->sk = sk;
>>
>> -       rxe_get(pkt->qp);
>>         atomic_inc(&pkt->qp->skb_out);
>>
>> +       sk->sk_user_data = (void *)(long)qp->elem.index;
>> +       skb->destructor = rxe_skb_tx_dtor;
>> +
>>         if (skb->protocol == htons(ETH_P_IP)) {
>> -               err = ip_local_out(dev_net(skb_dst(skb)->dev), skb->sk, skb);
>> +               err = ip_local_out(dev_net(skb_dst(skb)->dev), sk, skb);
>>         } else if (skb->protocol == htons(ETH_P_IPV6)) {
>> -               err = ip6_local_out(dev_net(skb_dst(skb)->dev), skb->sk, skb);
>> +               err = ip6_local_out(dev_net(skb_dst(skb)->dev), sk, skb);
>>         } else {
>> -               rxe_dbg_qp(pkt->qp, "Unknown layer 3 protocol: %d\n",
>> -                               skb->protocol);
>> -               atomic_dec(&pkt->qp->skb_out);
>> -               rxe_put(pkt->qp);
>> -               kfree_skb(skb);
>> -               return -EINVAL;
>> +               rxe_dbg_qp(qp, "Unknown layer 3 protocol: %d",
>> +                          skb->protocol);
>> +               err = -EINVAL;
>> +               goto err_not_sent;
>>         }
>>
>> +       /* IP consumed the packet, the destructor will handle cleanup */
>>         if (unlikely(net_xmit_eval(err))) {
>> -               rxe_dbg_qp(pkt->qp, "error sending packet: %d\n", err);
>> -               return -EAGAIN;
>> +               rxe_dbg_qp(qp, "Error sending packet: %d", err);
>> +               err = -EAGAIN;
>> +               goto err_out;
>>         }
>>
>>         return 0;
>> +
>> +err_not_sent:
>> +       skb->destructor = NULL;
>> +       atomic_dec(&pkt->qp->skb_out);
>> +       kfree_skb(skb);
>> +       sock_put(sk);
>> +err_out:
>> +       return err;
>>  }
>>
>>  /* fix up a send packet to match the packets
>> diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/rxe/rxe_qp.c
>> index a569b111a9d2..dcbf71031453 100644
>> --- a/drivers/infiniband/sw/rxe/rxe_qp.c
>> +++ b/drivers/infiniband/sw/rxe/rxe_qp.c
>> @@ -194,7 +194,6 @@ static int rxe_qp_init_req(struct rxe_dev *rxe, struct rxe_qp *qp,
>>         err = sock_create_kern(&init_net, AF_INET, SOCK_DGRAM, 0, &qp->sk);
>>         if (err < 0)
>>                 return err;
>> -       qp->sk->sk->sk_user_data = qp;
>>
>>         /* pick a source UDP port number for this QP based on
>>          * the source QPN. this spreads traffic for different QPs
>> --
>> 2.39.2
>>

