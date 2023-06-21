Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1C847379AD
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Jun 2023 05:25:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230282AbjFUDZp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 20 Jun 2023 23:25:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230395AbjFUDZK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 20 Jun 2023 23:25:10 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FB642D41
        for <linux-rdma@vger.kernel.org>; Tue, 20 Jun 2023 20:23:22 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id 46e09a7af769-6b4621e6ad2so3170276a34.0
        for <linux-rdma@vger.kernel.org>; Tue, 20 Jun 2023 20:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687317790; x=1689909790;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RAxMF1q1vrTLIm4BthK1Mj1BY/ecd7RqIPkCF/GMZEs=;
        b=TX4SFmtekaJVrySI8q8pVzSA5zv4N8qLskTkEbuMevmpUxbfQKoB2GXHWpe0n9pr1d
         TqJ5OVjIUvcCCUuRDO7n5r0+fx2w63/lUoxfEB93dtNOkUYoqqX0BvSA5ErBuIajfRuJ
         nCZbJQD+gBAjl75fp4WlxqrjHMkvCCH/Od3pFRmE3n8ZvtpsoG07zKZ6zNQmvUhn46qN
         6EA9E8BBjqPz2Qsvj94sjbGKZj4C99W+oiHZ1STDd9FDky5YW9gac2pvy0FGnnKXjZG2
         KcV9p7GeAk9okeJnMSo9XAhfwt3LvYzz5W0VvVPmlqaQs+MsCLAlltc3NeTDNL1nss6Z
         rsBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687317790; x=1689909790;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RAxMF1q1vrTLIm4BthK1Mj1BY/ecd7RqIPkCF/GMZEs=;
        b=VfNGezFJumHH93O109/WFOt/iamz5ro1BdKXxmC/6DsA3p3lYvaXptidIvGKbAuChW
         lCnhoCgiy9Bp+bD7aEzbhE3wvL5g389LVd5inqYDkJyYgxeHsctbjiPH6QYAglK0dwcN
         JLeWJxwLCP0BjvhcnRnnaSvM/6HPMRLVAAy3WwduNcoH1hLfrhFWq0xobFbiuFRywA4r
         Uv4OLtptU0tnRf1XPZFAEhBWff1Wxgzz167mc9KEC8QsDauNA2D38V+ahRvwgqXm6fQ3
         Amr6ZjtFTGf+laDwYf2CRPw6WaJ0m5WqZwBCceTPwu8oKUk5Y+7taUkKu2LPw8VHjwTZ
         aJmA==
X-Gm-Message-State: AC+VfDzcQS0/cMXtkWbS3/99FyQ51IshWq7hlTzsJ50KjeU4quKxdM0v
        Y9as7w756r1MANC4lyrIxV0=
X-Google-Smtp-Source: ACHHUZ4HzkqyEDUbE1DW0+pjhBkNVNuiIc9A75EX+Fc8isYYE4XEaTgIby0m18Os1+MwZF9QORvPLA==
X-Received: by 2002:a9d:620d:0:b0:6b0:ca09:e8a2 with SMTP id g13-20020a9d620d000000b006b0ca09e8a2mr9362112otj.37.1687317790281;
        Tue, 20 Jun 2023 20:23:10 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:50fb:ab10:5526:430d? (2603-8081-140c-1a00-50fb-ab10-5526-430d.res6.spectrum.com. [2603:8081:140c:1a00:50fb:ab10:5526:430d])
        by smtp.gmail.com with ESMTPSA id p18-20020a0568301d5200b006b29c8bbe65sm1561616oth.13.2023.06.20.20.23.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jun 2023 20:23:09 -0700 (PDT)
Message-ID: <fbdae0e8-87f1-c28b-f3ac-fe2b0d26ae41@gmail.com>
Date:   Tue, 20 Jun 2023 22:23:08 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCHv5 for-rc1 v5 4/8] RDMA/rxe: Implement dellink in rxe
To:     Zhu Yanjun <yanjun.zhu@linux.dev>,
        Zhu Yanjun <yanjun.zhu@intel.com>, zyjzyj2000@gmail.com,
        jgg@ziepe.ca, leon@kernel.org, linux-rdma@vger.kernel.org,
        parav@nvidia.com, lehrer@gmail.com
Cc:     Rain River <rain.1986.08.12@gmail.com>
References: <20230428093914.2121131-1-yanjun.zhu@intel.com>
 <20230428093914.2121131-5-yanjun.zhu@intel.com>
 <28959f27-46a2-6b51-e0cc-f80546d0f27f@gmail.com>
 <f1464e30-9e35-638a-d042-7a06a59b8405@linux.dev>
Content-Language: en-US
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <f1464e30-9e35-638a-d042-7a06a59b8405@linux.dev>
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

On 6/20/23 21:13, Zhu Yanjun wrote:
> 
> 在 2023/6/21 4:21, Bob Pearson 写道:
>> On 4/28/23 04:39, Zhu Yanjun wrote:
>>> From: Zhu Yanjun <yanjun.zhu@linux.dev>
>>>
>>> When running "rdma link del" command, dellink function will be called.
>>> If the sock refcnt is greater than the refcnt needed for udp tunnel,
>>> the sock refcnt will be decreased by 1.
>>>
>>> If equal, the last rdma link is removed. The udp tunnel will be
>>> destroyed.
>>>
>>> Tested-by: Rain River <rain.1986.08.12@gmail.com>
>>> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
>>> ---
>>>   drivers/infiniband/sw/rxe/rxe.c     | 12 +++++++++++-
>>>   drivers/infiniband/sw/rxe/rxe_net.c | 17 +++++++++++++++--
>>>   drivers/infiniband/sw/rxe/rxe_net.h |  1 +
>>>   3 files changed, 27 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/infiniband/sw/rxe/rxe.c b/drivers/infiniband/sw/rxe/rxe.c
>>> index 0ce6adb43cfc..ebfabc6d6b76 100644
>>> --- a/drivers/infiniband/sw/rxe/rxe.c
>>> +++ b/drivers/infiniband/sw/rxe/rxe.c
>>> @@ -166,10 +166,12 @@ void rxe_set_mtu(struct rxe_dev *rxe, unsigned int ndev_mtu)
>>>   /* called by ifc layer to create new rxe device.
>>>    * The caller should allocate memory for rxe by calling ib_alloc_device.
>>>    */
>>> +static struct rdma_link_ops rxe_link_ops;
>>>   int rxe_add(struct rxe_dev *rxe, unsigned int mtu, const char *ibdev_name)
>>>   {
>>>       rxe_init(rxe);
>>>       rxe_set_mtu(rxe, mtu);
>>> +    rxe->ib_dev.link_ops = &rxe_link_ops;
>>>         return rxe_register_device(rxe, ibdev_name);
>>>   }
>>> @@ -206,9 +208,17 @@ static int rxe_newlink(const char *ibdev_name, struct net_device *ndev)
>>>       return err;
>>>   }
>>>   -struct rdma_link_ops rxe_link_ops = {
>>> +static int rxe_dellink(struct ib_device *dev)
>>> +{
>>> +    rxe_net_del(dev);
>>> +
>>> +    return 0;
>>> +}
>>> +
>>> +static struct rdma_link_ops rxe_link_ops = {
>>>       .type = "rxe",
>>>       .newlink = rxe_newlink,
>>> +    .dellink = rxe_dellink,
>>>   };
>>>     static int __init rxe_module_init(void)
>>> diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c
>>> index 3ca92e062800..4cc7de7b115b 100644
>>> --- a/drivers/infiniband/sw/rxe/rxe_net.c
>>> +++ b/drivers/infiniband/sw/rxe/rxe_net.c
>>> @@ -530,6 +530,21 @@ int rxe_net_add(const char *ibdev_name, struct net_device *ndev)
>>>       return 0;
>>>   }
>>>   +#define SK_REF_FOR_TUNNEL    2
>>> +void rxe_net_del(struct ib_device *dev)
>>> +{
>>> +    if (refcount_read(&recv_sockets.sk6->sk->sk_refcnt) > SK_REF_FOR_TUNNEL)
>>> +        __sock_put(recv_sockets.sk6->sk);
>>> +    else
>>> +        rxe_release_udp_tunnel(recv_sockets.sk6);
>>> +
>>> +    if (refcount_read(&recv_sockets.sk4->sk->sk_refcnt) > SK_REF_FOR_TUNNEL)
>>> +        __sock_put(recv_sockets.sk4->sk);
>>> +    else
>>> +        rxe_release_udp_tunnel(recv_sockets.sk4);
>>> +}
>>> +#undef SK_REF_FOR_TUNNEL
>>> +
>>>   static void rxe_port_event(struct rxe_dev *rxe,
>>>                  enum ib_event_type event)
>>>   {
>>> @@ -689,8 +704,6 @@ int rxe_register_notifier(void)
>>>     void rxe_net_exit(void)
>>>   {
>>> -    rxe_release_udp_tunnel(recv_sockets.sk6);
>>> -    rxe_release_udp_tunnel(recv_sockets.sk4);
>>>       unregister_netdevice_notifier(&rxe_net_notifier);
>>>   }
>> These calls are moved to rxe_net_del which is called by an explicit unlink command.
>> But if rxe_net_init fails and returns an error code this will never happen.
>> This will result in leaking resources.
> 
> Thanks a lot. Bob.
> 
> Sure, if ipv6 tunnel fails to be created, the resource related with ipv4 should be released.
> 
> I will fix it in the latest version.
> 
> Zhu Yanjun

I haven't had a chance to test netns yet. I am sure it works but I will test it.
The only other thing I noticed are some stylistic differences with the rest of
the rxe driver. You use

struct rxe_dev *rdev;

elsewhere it is

struct rxe_dev *rxe;

Yours is more like the mlx drivers where they use dev for ib_device and mdev for mlx_device.
rxe tries to use ibdev ibqp, ibmr, etc for the ib objects and no prefix for the driver
specific ones. It's less typing that way.

With a couple of exceptions all the printk's are now in the form

rxe_[type]_[obj](obj, "message", ...) or rxe_[type] if there isn't an obj to refer to.

where type = info, err, warn, or dbg and obj = rxe, ah, pd, qp, cq, etc. These are basically
adapted from the siw driver.

Regards,

Bob

> 
>>
>> Bob
>>>   diff --git a/drivers/infiniband/sw/rxe/rxe_net.h b/drivers/infiniband/sw/rxe/rxe_net.h
>>> index a222c3eeae12..f48f22f3353b 100644
>>> --- a/drivers/infiniband/sw/rxe/rxe_net.h
>>> +++ b/drivers/infiniband/sw/rxe/rxe_net.h
>>> @@ -17,6 +17,7 @@ struct rxe_recv_sockets {
>>>   };
>>>     int rxe_net_add(const char *ibdev_name, struct net_device *ndev);
>>> +void rxe_net_del(struct ib_device *dev);
>>>     int rxe_register_notifier(void);
>>>   int rxe_net_init(void);

