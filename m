Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AC9E737B28
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Jun 2023 08:25:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbjFUGS0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 21 Jun 2023 02:18:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbjFUGSD (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 21 Jun 2023 02:18:03 -0400
Received: from out-34.mta1.migadu.com (out-34.mta1.migadu.com [IPv6:2001:41d0:203:375::22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B30F1BDF
        for <linux-rdma@vger.kernel.org>; Tue, 20 Jun 2023 23:17:58 -0700 (PDT)
Message-ID: <da338b50-12fb-2836-06cb-e6579652cc58@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1687328276;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gbe2uBpkk4XvCwVYrNAfdEbeR5Ph65q/M5UWif9lvgs=;
        b=SEXruv/daxUjZwHqH6wnvKcCQqKT6/NAdixaMKLMznSFruM7aigngv3+aZZZdImcFvYRP/
        Xa1f9hUCwlNPjO4IrLBBh5/2NkU3hXCczOswN8/i0dtTHSmV0cpzCzwa534BrpIihBdKko
        ggZZQOdHbkWzJ6Tg91voYwalYuW4gds=
Date:   Wed, 21 Jun 2023 14:17:48 +0800
MIME-Version: 1.0
Subject: Re: [PATCHv5 for-rc1 v5 4/8] RDMA/rxe: Implement dellink in rxe
To:     Bob Pearson <rpearsonhpe@gmail.com>,
        Zhu Yanjun <yanjun.zhu@intel.com>, zyjzyj2000@gmail.com,
        jgg@ziepe.ca, leon@kernel.org, linux-rdma@vger.kernel.org,
        parav@nvidia.com, lehrer@gmail.com
Cc:     Rain River <rain.1986.08.12@gmail.com>
References: <20230428093914.2121131-1-yanjun.zhu@intel.com>
 <20230428093914.2121131-5-yanjun.zhu@intel.com>
 <28959f27-46a2-6b51-e0cc-f80546d0f27f@gmail.com>
 <f1464e30-9e35-638a-d042-7a06a59b8405@linux.dev>
 <fbdae0e8-87f1-c28b-f3ac-fe2b0d26ae41@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <fbdae0e8-87f1-c28b-f3ac-fe2b0d26ae41@gmail.com>
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


在 2023/6/21 11:23, Bob Pearson 写道:
> On 6/20/23 21:13, Zhu Yanjun wrote:
>> 在 2023/6/21 4:21, Bob Pearson 写道:
>>> On 4/28/23 04:39, Zhu Yanjun wrote:
>>>> From: Zhu Yanjun <yanjun.zhu@linux.dev>
>>>>
>>>> When running "rdma link del" command, dellink function will be called.
>>>> If the sock refcnt is greater than the refcnt needed for udp tunnel,
>>>> the sock refcnt will be decreased by 1.
>>>>
>>>> If equal, the last rdma link is removed. The udp tunnel will be
>>>> destroyed.
>>>>
>>>> Tested-by: Rain River <rain.1986.08.12@gmail.com>
>>>> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
>>>> ---
>>>>    drivers/infiniband/sw/rxe/rxe.c     | 12 +++++++++++-
>>>>    drivers/infiniband/sw/rxe/rxe_net.c | 17 +++++++++++++++--
>>>>    drivers/infiniband/sw/rxe/rxe_net.h |  1 +
>>>>    3 files changed, 27 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/drivers/infiniband/sw/rxe/rxe.c b/drivers/infiniband/sw/rxe/rxe.c
>>>> index 0ce6adb43cfc..ebfabc6d6b76 100644
>>>> --- a/drivers/infiniband/sw/rxe/rxe.c
>>>> +++ b/drivers/infiniband/sw/rxe/rxe.c
>>>> @@ -166,10 +166,12 @@ void rxe_set_mtu(struct rxe_dev *rxe, unsigned int ndev_mtu)
>>>>    /* called by ifc layer to create new rxe device.
>>>>     * The caller should allocate memory for rxe by calling ib_alloc_device.
>>>>     */
>>>> +static struct rdma_link_ops rxe_link_ops;
>>>>    int rxe_add(struct rxe_dev *rxe, unsigned int mtu, const char *ibdev_name)
>>>>    {
>>>>        rxe_init(rxe);
>>>>        rxe_set_mtu(rxe, mtu);
>>>> +    rxe->ib_dev.link_ops = &rxe_link_ops;
>>>>          return rxe_register_device(rxe, ibdev_name);
>>>>    }
>>>> @@ -206,9 +208,17 @@ static int rxe_newlink(const char *ibdev_name, struct net_device *ndev)
>>>>        return err;
>>>>    }
>>>>    -struct rdma_link_ops rxe_link_ops = {
>>>> +static int rxe_dellink(struct ib_device *dev)
>>>> +{
>>>> +    rxe_net_del(dev);
>>>> +
>>>> +    return 0;
>>>> +}
>>>> +
>>>> +static struct rdma_link_ops rxe_link_ops = {
>>>>        .type = "rxe",
>>>>        .newlink = rxe_newlink,
>>>> +    .dellink = rxe_dellink,
>>>>    };
>>>>      static int __init rxe_module_init(void)
>>>> diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c
>>>> index 3ca92e062800..4cc7de7b115b 100644
>>>> --- a/drivers/infiniband/sw/rxe/rxe_net.c
>>>> +++ b/drivers/infiniband/sw/rxe/rxe_net.c
>>>> @@ -530,6 +530,21 @@ int rxe_net_add(const char *ibdev_name, struct net_device *ndev)
>>>>        return 0;
>>>>    }
>>>>    +#define SK_REF_FOR_TUNNEL    2
>>>> +void rxe_net_del(struct ib_device *dev)
>>>> +{
>>>> +    if (refcount_read(&recv_sockets.sk6->sk->sk_refcnt) > SK_REF_FOR_TUNNEL)
>>>> +        __sock_put(recv_sockets.sk6->sk);
>>>> +    else
>>>> +        rxe_release_udp_tunnel(recv_sockets.sk6);
>>>> +
>>>> +    if (refcount_read(&recv_sockets.sk4->sk->sk_refcnt) > SK_REF_FOR_TUNNEL)
>>>> +        __sock_put(recv_sockets.sk4->sk);
>>>> +    else
>>>> +        rxe_release_udp_tunnel(recv_sockets.sk4);
>>>> +}
>>>> +#undef SK_REF_FOR_TUNNEL
>>>> +
>>>>    static void rxe_port_event(struct rxe_dev *rxe,
>>>>                   enum ib_event_type event)
>>>>    {
>>>> @@ -689,8 +704,6 @@ int rxe_register_notifier(void)
>>>>      void rxe_net_exit(void)
>>>>    {
>>>> -    rxe_release_udp_tunnel(recv_sockets.sk6);
>>>> -    rxe_release_udp_tunnel(recv_sockets.sk4);
>>>>        unregister_netdevice_notifier(&rxe_net_notifier);
>>>>    }
>>> These calls are moved to rxe_net_del which is called by an explicit unlink command.
>>> But if rxe_net_init fails and returns an error code this will never happen.
>>> This will result in leaking resources.
>> Thanks a lot. Bob.
>>
>> Sure, if ipv6 tunnel fails to be created, the resource related with ipv4 should be released.
>>
>> I will fix it in the latest version.
>>
>> Zhu Yanjun
> I haven't had a chance to test netns yet. I am sure it works but I will test it.
Yes. Please. It is an interesting feature.
> The only other thing I noticed are some stylistic differences with the rest of
> the rxe driver. You use
>
> struct rxe_dev *rdev;
>
> elsewhere it is
>
> struct rxe_dev *rxe;
>
> Yours is more like the mlx drivers where they use dev for ib_device and mdev for mlx_device.
> rxe tries to use ibdev ibqp, ibmr, etc for the ib objects and no prefix for the driver
> specific ones. It's less typing that way.


Got you. I think we should use rxe instead of rdev. I will fix it in the 
latest commits.


>
> With a couple of exceptions all the printk's are now in the form
>
> rxe_[type]_[obj](obj, "message", ...) or rxe_[type] if there isn't an obj to refer to.
>
> where type = info, err, warn, or dbg and obj = rxe, ah, pd, qp, cq, etc. These are basically
> adapted from the siw driver.

If I can get you correctly, you mean that we should use rxe_dbg_qp, .... 
to replace pr_err ....

I have questions:

1). What benefit will this bring?

2). If the log is in module __init or  module __exit functions, we 
should use pr_xxx? Because obj does not exist in these __init and __exit 
functions.

Best Regards,

Zhu Yanjun

>
> Regards,
>
> Bob
>
>>> Bob
>>>>    diff --git a/drivers/infiniband/sw/rxe/rxe_net.h b/drivers/infiniband/sw/rxe/rxe_net.h
>>>> index a222c3eeae12..f48f22f3353b 100644
>>>> --- a/drivers/infiniband/sw/rxe/rxe_net.h
>>>> +++ b/drivers/infiniband/sw/rxe/rxe_net.h
>>>> @@ -17,6 +17,7 @@ struct rxe_recv_sockets {
>>>>    };
>>>>      int rxe_net_add(const char *ibdev_name, struct net_device *ndev);
>>>> +void rxe_net_del(struct ib_device *dev);
>>>>      int rxe_register_notifier(void);
>>>>    int rxe_net_init(void);
