Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 259AF767918
	for <lists+linux-rdma@lfdr.de>; Sat, 29 Jul 2023 01:40:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbjG1XkJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 28 Jul 2023 19:40:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbjG1XkI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 28 Jul 2023 19:40:08 -0400
Received: from out-74.mta1.migadu.com (out-74.mta1.migadu.com [95.215.58.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4F9E422B
        for <linux-rdma@vger.kernel.org>; Fri, 28 Jul 2023 16:40:06 -0700 (PDT)
Message-ID: <789019fe-d640-b0b5-5992-da79781e3d3d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1690587604;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sm+d16pCSGP9ruDnohYFWLdXGCjS9QMAyBHDnlVmXds=;
        b=r6KBujDBGF9PjY2bK6LQZfSuYK3lB2Y19gvYLVEZDSG9ZF8QuML0yvGTUs8SL0y97z+kPq
        gFFYcif1ixn3b2KhdfSuezdnx7rm3nQFVXNNVOLU2fUrtBrbBZHtPT/T8GbByoV+W8eYbV
        fBN/FQGzlw5jk2x5Y/nV4TtYqkvgyz8=
Date:   Sat, 29 Jul 2023 07:39:57 +0800
MIME-Version: 1.0
Subject: Re: [PATCH for-next v3 05/10] RDMA/rxe: Extend rxe_icrc.c to support
 frags
To:     Bob Pearson <rpearsonhpe@gmail.com>, jgg@nvidia.com,
        zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org, jhack@hpe.com,
        "leon@kernel.org" <leon@kernel.org>
References: <20230727200128.65947-1-rpearsonhpe@gmail.com>
 <20230727200128.65947-6-rpearsonhpe@gmail.com>
 <9dad4639-d3bf-8d1c-c3e5-3b8a6085bdcc@linux.dev>
 <65f72f3d-6890-7099-800e-d327000117d9@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <65f72f3d-6890-7099-800e-d327000117d9@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


在 2023/7/28 22:49, Bob Pearson 写道:
> On 7/28/23 09:20, Zhu Yanjun wrote:
>> 在 2023/7/28 4:01, Bob Pearson 写道:
>>> Extend the subroutines rxe_icrc_generate() and rxe_icrc_check()
>>> to support skb frags.
>>>
>>> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
>>> ---
>>>    drivers/infiniband/sw/rxe/rxe_icrc.c | 65 ++++++++++++++++++++++++----
>>>    drivers/infiniband/sw/rxe/rxe_net.c  | 51 +++++++++++++++++-----
>>>    drivers/infiniband/sw/rxe/rxe_recv.c |  1 +
>>>    3 files changed, 98 insertions(+), 19 deletions(-)
>>>
>>> diff --git a/drivers/infiniband/sw/rxe/rxe_icrc.c b/drivers/infiniband/sw/rxe/rxe_icrc.c
>>> index c9aa0995e900..393391863350 100644
>>> --- a/drivers/infiniband/sw/rxe/rxe_icrc.c
>>> +++ b/drivers/infiniband/sw/rxe/rxe_icrc.c
>>> @@ -63,7 +63,7 @@ static __be32 rxe_crc32(struct rxe_dev *rxe, __be32 crc, void *next, size_t len)
>>>      /**
>>>     * rxe_icrc_hdr() - Compute the partial ICRC for the network and transport
>>> - *          headers of a packet.
>>> + *            headers of a packet.
>>>     * @skb: packet buffer
>>>     * @pkt: packet information
>>>     *
>>> @@ -129,6 +129,56 @@ static __be32 rxe_icrc_hdr(struct sk_buff *skb, struct rxe_pkt_info *pkt)
>>>        return crc;
>>>    }
>>>    +/**
>>> + * rxe_icrc_payload() - Compute the ICRC for a packet payload and also
>>> + *            compute the address of the icrc in the packet.
>>> + * @skb: packet buffer
>>> + * @pkt: packet information
>>> + * @icrc: current icrc i.e. including headers
>>> + * @icrcp: returned pointer to icrc in skb
>>> + *
>>> + * Return: 0 if the values match else an error
>>> + */
>>> +static __be32 rxe_icrc_payload(struct sk_buff *skb, struct rxe_pkt_info *pkt,
>>> +                   __be32 icrc, __be32 **icrcp)
>>> +{
>>> +    struct skb_shared_info *shinfo = skb_shinfo(skb);
>>> +    skb_frag_t *frag;
>>> +    u8 *addr;
>>> +    int hdr_len;
>>> +    int len;
>>> +    int i;
>>> +
>>> +    /* handle any payload left in the linear buffer */
>>> +    hdr_len = rxe_opcode[pkt->opcode].length;
>>> +    addr = pkt->hdr + hdr_len;
>>> +    len = skb_tail_pointer(skb) - skb_transport_header(skb)
>>> +        - sizeof(struct udphdr) - hdr_len;
>>> +    if (!shinfo->nr_frags) {
>>> +        len -= RXE_ICRC_SIZE;
>>> +        *icrcp = (__be32 *)(addr + len);
>>> +    }
>>> +    if (len > 0)
>>> +        icrc = rxe_crc32(pkt->rxe, icrc, payload_addr(pkt), len);
>>> +    WARN_ON(len < 0);
>>> +
>>> +    /* handle any payload in frags */
>>> +    for (i = 0; i < shinfo->nr_frags; i++) {
>>> +        frag = &shinfo->frags[i];
>>> +        addr = page_to_virt(frag->bv_page) + frag->bv_offset;
>>> +        len = frag->bv_len;
>>> +        if (i == shinfo->nr_frags - 1) {
>>> +            len -= RXE_ICRC_SIZE;
>>> +            *icrcp = (__be32 *)(addr + len);
>>> +        }
>>> +        if (len > 0)
>>> +            icrc = rxe_crc32(pkt->rxe, icrc, addr, len);
>>> +        WARN_ON(len < 0);
>>> +    }
>>> +
>>> +    return icrc;
>>> +}
>>> +
>>>    /**
>>>     * rxe_icrc_check() - Compute ICRC for a packet and compare to the ICRC
>>>     *              delivered in the packet.
>>> @@ -143,13 +193,11 @@ int rxe_icrc_check(struct sk_buff *skb, struct rxe_pkt_info *pkt)
>>>        __be32 pkt_icrc;
>>>        __be32 icrc;
>>>    -    icrcp = (__be32 *)(pkt->hdr + pkt->paylen - RXE_ICRC_SIZE);
>>> -    pkt_icrc = *icrcp;
>>> -
>>>        icrc = rxe_icrc_hdr(skb, pkt);
>>> -    icrc = rxe_crc32(pkt->rxe, icrc, (u8 *)payload_addr(pkt),
>>> -                payload_size(pkt) + pkt->pad);
>>> +    icrc = rxe_icrc_payload(skb, pkt, icrc, &icrcp);
>>> +
>>>        icrc = ~icrc;
>>> +    pkt_icrc = *icrcp;
>>>          if (unlikely(icrc != pkt_icrc))
>>>            return -EINVAL;
>>> @@ -167,9 +215,8 @@ void rxe_icrc_generate(struct sk_buff *skb, struct rxe_pkt_info *pkt)
>>>        __be32 *icrcp;
>>>        __be32 icrc;
>>>    -    icrcp = (__be32 *)(pkt->hdr + pkt->paylen - RXE_ICRC_SIZE);
>>>        icrc = rxe_icrc_hdr(skb, pkt);
>>> -    icrc = rxe_crc32(pkt->rxe, icrc, (u8 *)payload_addr(pkt),
>>> -                payload_size(pkt) + pkt->pad);
>>> +    icrc = rxe_icrc_payload(skb, pkt, icrc, &icrcp);
>>> +
>>>        *icrcp = ~icrc;
>>>    }
>>> diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c
>>> index c44ef39010f1..c43f9dd3ae6e 100644
>>> --- a/drivers/infiniband/sw/rxe/rxe_net.c
>>> +++ b/drivers/infiniband/sw/rxe/rxe_net.c
>>> @@ -148,33 +148,53 @@ static int rxe_udp_encap_recv(struct sock *sk, struct sk_buff *skb)
>>>        struct udphdr *udph;
>>>        struct rxe_dev *rxe;
>>>        struct rxe_pkt_info *pkt = SKB_TO_PKT(skb);
>>> +    u8 opcode;
>>> +    u8 buf[1];
>>> +    u8 *p;
>> opcode and *p duplicate.
>> You can use only one variable.
> opcode is u8 p is *u8.


I mean that you can use one variable, (for example,opcode) can complete 
the same functionality with the 2 variables (p and opcode).

Zhu Yanjun


>> u8 *opcode;
>>>          /* takes a reference on rxe->ib_dev
>>>         * drop when skb is freed
>>>         */
>>>        rxe = get_rxe_from_skb(skb);
>>>        if (!rxe)
>>> -        goto drop;
>>> +        goto err_drop;
>>>    -    if (skb_linearize(skb)) {
>>> -        ib_device_put(&rxe->ib_dev);
>>> -        goto drop;
>>> +    /* Get bth opcode out of skb, it may be in a fragment */
>>> +    p = skb_header_pointer(skb, sizeof(struct udphdr), 1, buf);
>>> +    if (!p)
>>> +        goto err_device_put;
>>> +    opcode = *p;
>>
>>      opcode = skb_header_pointer(skb, sizeof(struct udphdr), 1, buf);
>>      if (!opcode)
>>          goto err_device_put;
>> ;
>>> +
>>> +    /* If using fragmented skbs make sure roce headers
>>> +     * are in linear buffer else make skb linear
>>> +     */
>>> +    if (rxe_use_sg && skb_is_nonlinear(skb)) {
>>> +        int delta = rxe_opcode[opcode].length -
>>          int delta = rxe_opcode[(*opcode)].length -
>>
>>> +            (skb_headlen(skb) - sizeof(struct udphdr));
>>> +
>>> +        if (delta > 0 && !__pskb_pull_tail(skb, delta))
>>> +            goto err_device_put;
>>> +    } else {
>>> +        if (skb_linearize(skb))
>>> +            goto err_device_put;
>>>        }
>>>          udph = udp_hdr(skb);
>>>        pkt->rxe = rxe;
>>>        pkt->port_num = 1;
>>>        pkt->hdr = (u8 *)(udph + 1);
>>> -    pkt->mask = RXE_GRH_MASK;
>>> +    pkt->mask = rxe_opcode[opcode].mask | RXE_GRH_MASK;
>> <..>
>>
>> Zhu Yanjun
>>>        pkt->paylen = be16_to_cpu(udph->len) - sizeof(*udph);
>>>    -    /* remove udp header */
>>>        skb_pull(skb, sizeof(struct udphdr));
>>>          rxe_rcv(skb);
>>>          return 0;
>>> -drop:
>>> +
>>> +err_device_put:
>>> +    ib_device_put(&rxe->ib_dev);
>>> +err_drop:
>>>        kfree_skb(skb);
>>>          return 0;
>>> @@ -446,24 +466,35 @@ static int rxe_send(struct sk_buff *skb, struct rxe_pkt_info *pkt)
>>>     */
>>>    static int rxe_loopback(struct sk_buff *skb, struct rxe_pkt_info *pkt)
>>>    {
>>> -    memcpy(SKB_TO_PKT(skb), pkt, sizeof(*pkt));
>>> +    struct rxe_pkt_info *newpkt;
>>> +    int err;
>>>    +    /* make loopback line up with rxe_udp_encap_recv */
>>>        if (skb->protocol == htons(ETH_P_IP))
>>>            skb_pull(skb, sizeof(struct iphdr));
>>>        else
>>>            skb_pull(skb, sizeof(struct ipv6hdr));
>>> +    skb_reset_transport_header(skb);
>>> +
>>> +    newpkt = SKB_TO_PKT(skb);
>>> +    memcpy(newpkt, pkt, sizeof(*newpkt));
>>> +    newpkt->hdr = skb_transport_header(skb) + sizeof(struct udphdr);
>>>          if (WARN_ON(!ib_device_try_get(&pkt->rxe->ib_dev))) {
>>>            kfree_skb(skb);
>>> -        return -EIO;
>>> +        err = -EINVAL;
>>> +        goto drop;
>>>        }
>>>          /* remove udp header */
>>>        skb_pull(skb, sizeof(struct udphdr));
>>>          rxe_rcv(skb);
>>> -
>>>        return 0;
>>> +
>>> +drop:
>>> +    kfree_skb(skb);
>>> +    return err;
>>>    }
>>>      int rxe_xmit_packet(struct rxe_qp *qp, struct rxe_pkt_info *pkt,
>>> diff --git a/drivers/infiniband/sw/rxe/rxe_recv.c b/drivers/infiniband/sw/rxe/rxe_recv.c
>>> index f912a913f89a..940197199252 100644
>>> --- a/drivers/infiniband/sw/rxe/rxe_recv.c
>>> +++ b/drivers/infiniband/sw/rxe/rxe_recv.c
>>> @@ -338,6 +338,7 @@ void rxe_rcv(struct sk_buff *skb)
>>>        if (unlikely(err))
>>>            goto drop;
>>>    +    /* skb->data points at UDP header */
>>>        err = rxe_icrc_check(skb, pkt);
>>>        if (unlikely(err))
>>>            goto drop;
