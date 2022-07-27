Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20197582A2A
	for <lists+linux-rdma@lfdr.de>; Wed, 27 Jul 2022 18:01:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234541AbiG0QBl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 27 Jul 2022 12:01:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234680AbiG0QBa (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 27 Jul 2022 12:01:30 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 219AC4B0DB
        for <linux-rdma@vger.kernel.org>; Wed, 27 Jul 2022 09:01:29 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id w6-20020a056830410600b0061c99652493so13186445ott.8
        for <linux-rdma@vger.kernel.org>; Wed, 27 Jul 2022 09:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=2sOc3NmHrzbDDB8sJGqMe/vXfdf8hrTvMFkw6aEJiU0=;
        b=DrVFy08BYJxm1NMYcXt8KrrQTU7reJMHsJdsyXHN+GTAkGEbOlbnRVIeWuvPTT+RVX
         SaLzUOotYwZJdfXgmrSDBwn9/YCij3hUGq92R2dlXkM84fLKTkzjCkJQNaYZgJ3YnUhR
         MkkWbGWZD4GhCUnZHY6jRQbMDJjeZxv74KP8wkfiRy+A5Snf5f/ArjYg1QnlH8DdTjr8
         T7ci/go7yePgG5Bjk9fhXca4eaJ8ESCbM1C7Wl3KK6wl0QMFKLPBv7uIO7I5+ktlT1WR
         +e6xDrT7cKGwexVVRttfq8nZRN68pIUnEkGAJXMCvZFAyie9YBJznqBt8e9ZIX7fNtRe
         26Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=2sOc3NmHrzbDDB8sJGqMe/vXfdf8hrTvMFkw6aEJiU0=;
        b=MD7V5TDDpJEdFT5ih1pbPWyOMIZepeVyQjhdJmvmVw5rhGfpUlFOun70EJle4ZBdod
         UVpb9dznh4iUF1jzTAxJ8aJmvctIaQMOLGdRVi+KH56ECrh5pxXQzCdfo0T5MiJAvNt9
         CEyFIbsk0pQLROlyL0MYKTrb+Ew5RxRMMBUSDwbfOq+gdUQs85srbELmPqS7U0gMTTLY
         vgnZMXD+eXCaIsKH7rTN0iTTFGhEEdxucF42LVDP4l7ySAinlEFv/FXGAHZhrp+o4S7Z
         IZkQUvjkoVDWU+AxhBIe6QLCNH72TFI0NSjKECAixQ0E0HX7iATSOjzWhdBclRkYMCK9
         ka4w==
X-Gm-Message-State: AJIora/IRAHIxNv/xxn9GgWJZ11lWCMj3VPmGb7JNhTw3xVEWdLP6nCF
        u3KZpPgQzZ2C6GwcXQhQh+4=
X-Google-Smtp-Source: AGRyM1tdP2hh32YuvvGpcjW6eHQVx/Pq0f/++w+Z9v51cls/AfjTbpzl5AdLXRjBfQeQNJwtcIwXzQ==
X-Received: by 2002:a9d:7b4a:0:b0:61c:ac60:b6c4 with SMTP id f10-20020a9d7b4a000000b0061cac60b6c4mr8289833oto.262.1658937687688;
        Wed, 27 Jul 2022 09:01:27 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:49ec:e8e0:26a4:534c? (2603-8081-140c-1a00-49ec-e8e0-26a4-534c.res6.spectrum.com. [2603:8081:140c:1a00:49ec:e8e0:26a4:534c])
        by smtp.gmail.com with ESMTPSA id g29-20020a544f9d000000b0033a37114eb0sm7455009oiy.19.2022.07.27.09.01.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Jul 2022 09:01:27 -0700 (PDT)
Message-ID: <ec579b9e-59ba-704c-f481-beb26ab6bab2@gmail.com>
Date:   Wed, 27 Jul 2022 11:01:26 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH for-next] RDMA/rxe: Cleanup rxe_init_packet()
Content-Language: en-US
To:     Haris Iqbal <haris.iqbal@ionos.com>
Cc:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
References: <20220726195602.12368-1-rpearsonhpe@gmail.com>
 <CAJpMwygY-iTUO9mookqJUBZjxp0MjSYQMiu52xBQP74YLsUkJQ@mail.gmail.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <CAJpMwygY-iTUO9mookqJUBZjxp0MjSYQMiu52xBQP74YLsUkJQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 7/27/22 05:23, Haris Iqbal wrote:
> On Tue, Jul 26, 2022 at 9:56 PM Bob Pearson <rpearsonhpe@gmail.com> wrote:
>>
>> Currently rxe_init_packet() recomputes ndev from the address
>> vector but struct rxe_dev already holds a reference to ndev.
>>
>> Cleanup rxe_init_packet to use the value of ndev in rxe and drop
>> an unneeded parameter paylen since it is already carried in the
>> packet info struct.
>>
>> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
>> ---
>>  drivers/infiniband/sw/rxe/rxe_loc.h  |  2 +-
>>  drivers/infiniband/sw/rxe/rxe_net.c  | 49 +++++++++++-----------------
>>  drivers/infiniband/sw/rxe/rxe_req.c  |  2 +-
>>  drivers/infiniband/sw/rxe/rxe_resp.c |  3 +-
>>  4 files changed, 23 insertions(+), 33 deletions(-)
>>
>> diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
>> index f9af30f582c6..7f98d296bc0d 100644
>> --- a/drivers/infiniband/sw/rxe/rxe_loc.h
>> +++ b/drivers/infiniband/sw/rxe/rxe_loc.h
>> @@ -93,7 +93,7 @@ void rxe_mw_cleanup(struct rxe_pool_elem *elem);
>>
>>  /* rxe_net.c */
>>  struct sk_buff *rxe_init_packet(struct rxe_dev *rxe, struct rxe_av *av,
>> -                               int paylen, struct rxe_pkt_info *pkt);
>> +                               struct rxe_pkt_info *pkt);
>>  int rxe_prepare(struct rxe_av *av, struct rxe_pkt_info *pkt,
>>                 struct sk_buff *skb);
>>  int rxe_xmit_packet(struct rxe_qp *qp, struct rxe_pkt_info *pkt,
>> diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c
>> index c53f4529f098..4a091f236dde 100644
>> --- a/drivers/infiniband/sw/rxe/rxe_net.c
>> +++ b/drivers/infiniband/sw/rxe/rxe_net.c
>> @@ -443,18 +443,22 @@ int rxe_xmit_packet(struct rxe_qp *qp, struct rxe_pkt_info *pkt,
>>         return err;
>>  }
>>
>> +/**
>> + * rxe_init_packet - allocate and initialize a new skb
>> + * @rxe: rxe device
>> + * @av: remote address vector
>> + * @pkt: packet info
>> + *
>> + * Returns: an skb on success else NULL
>> + */
>>  struct sk_buff *rxe_init_packet(struct rxe_dev *rxe, struct rxe_av *av,
>> -                               int paylen, struct rxe_pkt_info *pkt)
>> +                               struct rxe_pkt_info *pkt)
>>  {
>>         unsigned int hdr_len;
>>         struct sk_buff *skb = NULL;
>> -       struct net_device *ndev;
>> -       const struct ib_gid_attr *attr;
>> +       struct net_device *ndev = rxe->ndev;
>>         const int port_num = 1;
>> -
>> -       attr = rdma_get_gid_attr(&rxe->ib_dev, port_num, av->grh.sgid_index);
>> -       if (IS_ERR(attr))
>> -               return NULL;
>> +       int skb_size;
>>
>>         if (av->network_type == RXE_NETWORK_TYPE_IPV4)
>>                 hdr_len = ETH_HLEN + sizeof(struct udphdr) +
>> @@ -463,26 +467,13 @@ struct sk_buff *rxe_init_packet(struct rxe_dev *rxe, struct rxe_av *av,
>>                 hdr_len = ETH_HLEN + sizeof(struct udphdr) +
>>                         sizeof(struct ipv6hdr);
>>
>> -       rcu_read_lock();
> 
> Was removing this rcu lock intentional? If so, do we need a mention of
> this in the commit message why its not needed anymore?
> 
The rcu lock was required to use the rdma_read_gid_attr_ndev_rcu() API.
For the rxe driver there is no way that the ndev is changing once the rxe device
is set up and ndev was passed in to rxe_newlink() and saved in the rxe_dev struct.
Not any good reason to do all this work to get ndev when we already know it.
>> -       ndev = rdma_read_gid_attr_ndev_rcu(attr);
>> -       if (IS_ERR(ndev)) {
>> -               rcu_read_unlock();
>> -               goto out;
>> -       }
>> -       skb = alloc_skb(paylen + hdr_len + LL_RESERVED_SPACE(ndev),
>> -                       GFP_ATOMIC);
>> -
>> -       if (unlikely(!skb)) {
>> -               rcu_read_unlock();
>> -               goto out;
>> -       }
>> -
>> -       skb_reserve(skb, hdr_len + LL_RESERVED_SPACE(ndev));
>> -
>> -       /* FIXME: hold reference to this netdev until life of this skb. */
>> -       skb->dev        = ndev;
>> -       rcu_read_unlock();
>> +       skb_size = LL_RESERVED_SPACE(ndev) + hdr_len + pkt->paylen;
>> +       skb = alloc_skb(skb_size, GFP_ATOMIC);
>> +       if (unlikely(!skb))
>> +               return NULL;
>>
>> +       skb_reserve(skb, LL_RESERVED_SPACE(ndev) + hdr_len);
>> +       skb->dev = ndev;
>>         if (av->network_type == RXE_NETWORK_TYPE_IPV4)
>>                 skb->protocol = htons(ETH_P_IP);
>>         else
>> @@ -490,11 +481,9 @@ struct sk_buff *rxe_init_packet(struct rxe_dev *rxe, struct rxe_av *av,
>>
>>         pkt->rxe        = rxe;
>>         pkt->port_num   = port_num;
>> -       pkt->hdr        = skb_put(skb, paylen);
>> -       pkt->mask       |= RXE_GRH_MASK;
>> +       pkt->hdr        = skb_put(skb, pkt->paylen);
>> +       pkt->mask      |= RXE_GRH_MASK;
>>
>> -out:
>> -       rdma_put_gid_attr(attr);
>>         return skb;
>>  }
>>
>> diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
>> index 49e8f54db6f5..e72db960d7ea 100644
>> --- a/drivers/infiniband/sw/rxe/rxe_req.c
>> +++ b/drivers/infiniband/sw/rxe/rxe_req.c
>> @@ -397,7 +397,7 @@ static struct sk_buff *init_req_packet(struct rxe_qp *qp,
>>         pkt->paylen = paylen;
>>
>>         /* init skb */
>> -       skb = rxe_init_packet(rxe, av, paylen, pkt);
>> +       skb = rxe_init_packet(rxe, av, pkt);
>>         if (unlikely(!skb))
>>                 return NULL;
>>
>> diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
>> index b36ec5c4d5e0..02a5d4ebb45e 100644
>> --- a/drivers/infiniband/sw/rxe/rxe_resp.c
>> +++ b/drivers/infiniband/sw/rxe/rxe_resp.c
>> @@ -670,8 +670,9 @@ static struct sk_buff *prepare_ack_packet(struct rxe_qp *qp,
>>          */
>>         pad = (-payload) & 0x3;
>>         paylen = rxe_opcode[opcode].length + payload + pad + RXE_ICRC_SIZE;
>> +       ack->paylen = paylen;
> 
> Maybe remove the old ack->paylen assignment which is done later in
> this function?
> 
Agreed. Will send a v2 with this change.
>>
>> -       skb = rxe_init_packet(rxe, &qp->pri_av, paylen, ack);
>> +       skb = rxe_init_packet(rxe, &qp->pri_av, ack);
>>         if (!skb)
>>                 return NULL;
>>
>> --
>> 2.34.1
>>

Bob
