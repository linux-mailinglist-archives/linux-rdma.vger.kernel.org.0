Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 654DF738AFB
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Jun 2023 18:24:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231124AbjFUQYR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 21 Jun 2023 12:24:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232081AbjFUQYK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 21 Jun 2023 12:24:10 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 914611995
        for <linux-rdma@vger.kernel.org>; Wed, 21 Jun 2023 09:24:05 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id 5614622812f47-39e86b3da59so4635313b6e.3
        for <linux-rdma@vger.kernel.org>; Wed, 21 Jun 2023 09:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687364645; x=1689956645;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RrpK3tJdz4wL2gevvuMxLZWod4NeNDCS5ao0KZlnCp8=;
        b=pvQB/YZYtB9ahdUulXY4yhhapPS8aXLG7wdg0DWQYydV5L0q2PDbaWN9OdQXuKdIwc
         dx1sYLfFJvG4d7rDa/nVyhdzEmDzduQr8Su9JVfwtWbzQNpEjmcWN7U8c32WZ1kJyAND
         6G0/cPBl5jGf8PXgmbAMEb5Bwg1aNZghIUKayhrJNWMIlEniavyE9CUz69BBvo1EHU6g
         FdSu4808+e5VKnu+PfTlSVisUzvYR05QuMu0FfnNv50nv9C0QEsw9VvNZlSNDy/jUvVp
         avS+AInhil+yvTlmAza6gTevvP/OZ5OfK85D1eYLiV7oRZWWR5gNyc+p8zKMm9oWMaOt
         XJwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687364645; x=1689956645;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RrpK3tJdz4wL2gevvuMxLZWod4NeNDCS5ao0KZlnCp8=;
        b=BJj9mCF6J2kY1LlhIPfSrtTSy53QbtfFlCyzALXx+g4o3GiSscu2WDdKw9gqX2Lndu
         8YP4WbNq2g+1q+uaQ9mA08Hylm3GrRUSk0zLfHKFHsC5LZwSUfToCxHKwiFiUN4jdYw6
         Ydl1l+xhmdIQtH7uGTZz8gw/0acPc5e7WXaqMepJzINw/e2tRE2ygXff6k5vDXF32Dz7
         RuY8djdL3HGhi9wNlnaPPGn48NNOU2pz7aBW3XtP17sbtiQxXIrb5CE4Nm+9suSfeXRk
         I9A/jwL3NfUmoVrN6xE3CVHCeLoIGWxKiqjsTY70Gg5BQV8SFez0RlS8S4DYsBQ0UOJ0
         0l5w==
X-Gm-Message-State: AC+VfDx5jBHTc4pl2P2jgtqxkLdVMa9GHAvZybMBR/oV4KMQ5Og9ushW
        QIj9qTAm+cu+d0ZreAQm0as=
X-Google-Smtp-Source: ACHHUZ6oC6Rtqh3JqyBubsgdpyGsbguHrqKi33ifs7veyhn7OjPHjDYE+2UBJtdUrxl8UKaGn7uGYA==
X-Received: by 2002:a05:6808:18a3:b0:39a:b35b:a06c with SMTP id bi35-20020a05680818a300b0039ab35ba06cmr9026487oib.30.1687364644711;
        Wed, 21 Jun 2023 09:24:04 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:2719:6bc2:12ce:e92d? (2603-8081-140c-1a00-2719-6bc2-12ce-e92d.res6.spectrum.com. [2603:8081:140c:1a00:2719:6bc2:12ce:e92d])
        by smtp.gmail.com with ESMTPSA id k7-20020a544707000000b0039ee0bd8a11sm2274393oik.42.2023.06.21.09.24.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jun 2023 09:24:04 -0700 (PDT)
Message-ID: <a3121337-9fa9-a159-b93d-fd3b375f5cb0@gmail.com>
Date:   Wed, 21 Jun 2023 11:24:03 -0500
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
 <fbdae0e8-87f1-c28b-f3ac-fe2b0d26ae41@gmail.com>
 <da338b50-12fb-2836-06cb-e6579652cc58@linux.dev>
Content-Language: en-US
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <da338b50-12fb-2836-06cb-e6579652cc58@linux.dev>
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

On 6/21/23 01:17, Zhu Yanjun wrote:
> 
> 在 2023/6/21 11:23, Bob Pearson 写道:
>> On 6/20/23 21:13, Zhu Yanjun wrote:
>>> 在 2023/6/21 4:21, Bob Pearson 写道:
>>>> On 4/28/23 04:39, Zhu Yanjun wrote:
>>>>> From: Zhu Yanjun <yanjun.zhu@linux.dev>
>>>>>
>>>>> When running "rdma link del" command, dellink function will be called.
>>>>> If the sock refcnt is greater than the refcnt needed for udp tunnel,
>>>>> the sock refcnt will be decreased by 1.
>>>>>
>>>>> If equal, the last rdma link is removed. The udp tunnel will be
>>>>> destroyed.
>>>>>
>>>>> Tested-by: Rain River <rain.1986.08.12@gmail.com>
>>>>> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
>>>>> ---
>>>>>    drivers/infiniband/sw/rxe/rxe.c     | 12 +++++++++++-
>>>>>    drivers/infiniband/sw/rxe/rxe_net.c | 17 +++++++++++++++--
>>>>>    drivers/infiniband/sw/rxe/rxe_net.h |  1 +
>>>>>    3 files changed, 27 insertions(+), 3 deletions(-)
>>>>>
>>>>> diff --git a/drivers/infiniband/sw/rxe/rxe.c b/drivers/infiniband/sw/rxe/rxe.c
>>>>> index 0ce6adb43cfc..ebfabc6d6b76 100644
>>>>> --- a/drivers/infiniband/sw/rxe/rxe.c
>>>>> +++ b/drivers/infiniband/sw/rxe/rxe.c
>>>>> @@ -166,10 +166,12 @@ void rxe_set_mtu(struct rxe_dev *rxe, unsigned int ndev_mtu)
>>>>>    /* called by ifc layer to create new rxe device.
>>>>>     * The caller should allocate memory for rxe by calling ib_alloc_device.
>>>>>     */
>>>>> +static struct rdma_link_ops rxe_link_ops;
>>>>>    int rxe_add(struct rxe_dev *rxe, unsigned int mtu, const char *ibdev_name)
>>>>>    {
>>>>>        rxe_init(rxe);
>>>>>        rxe_set_mtu(rxe, mtu);
>>>>> +    rxe->ib_dev.link_ops = &rxe_link_ops;
>>>>>          return rxe_register_device(rxe, ibdev_name);
>>>>>    }
>>>>> @@ -206,9 +208,17 @@ static int rxe_newlink(const char *ibdev_name, struct net_device *ndev)
>>>>>        return err;
>>>>>    }
>>>>>    -struct rdma_link_ops rxe_link_ops = {
>>>>> +static int rxe_dellink(struct ib_device *dev)
>>>>> +{
>>>>> +    rxe_net_del(dev);
>>>>> +
>>>>> +    return 0;
>>>>> +}
>>>>> +
>>>>> +static struct rdma_link_ops rxe_link_ops = {
>>>>>        .type = "rxe",
>>>>>        .newlink = rxe_newlink,
>>>>> +    .dellink = rxe_dellink,
>>>>>    };
>>>>>      static int __init rxe_module_init(void)
>>>>> diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c
>>>>> index 3ca92e062800..4cc7de7b115b 100644
>>>>> --- a/drivers/infiniband/sw/rxe/rxe_net.c
>>>>> +++ b/drivers/infiniband/sw/rxe/rxe_net.c
>>>>> @@ -530,6 +530,21 @@ int rxe_net_add(const char *ibdev_name, struct net_device *ndev)
>>>>>        return 0;
>>>>>    }
>>>>>    +#define SK_REF_FOR_TUNNEL    2
>>>>> +void rxe_net_del(struct ib_device *dev)
>>>>> +{
>>>>> +    if (refcount_read(&recv_sockets.sk6->sk->sk_refcnt) > SK_REF_FOR_TUNNEL)
>>>>> +        __sock_put(recv_sockets.sk6->sk);
>>>>> +    else
>>>>> +        rxe_release_udp_tunnel(recv_sockets.sk6);
>>>>> +
>>>>> +    if (refcount_read(&recv_sockets.sk4->sk->sk_refcnt) > SK_REF_FOR_TUNNEL)
>>>>> +        __sock_put(recv_sockets.sk4->sk);
>>>>> +    else
>>>>> +        rxe_release_udp_tunnel(recv_sockets.sk4);
>>>>> +}
>>>>> +#undef SK_REF_FOR_TUNNEL
>>>>> +
>>>>>    static void rxe_port_event(struct rxe_dev *rxe,
>>>>>                   enum ib_event_type event)
>>>>>    {
>>>>> @@ -689,8 +704,6 @@ int rxe_register_notifier(void)
>>>>>      void rxe_net_exit(void)
>>>>>    {
>>>>> -    rxe_release_udp_tunnel(recv_sockets.sk6);
>>>>> -    rxe_release_udp_tunnel(recv_sockets.sk4);
>>>>>        unregister_netdevice_notifier(&rxe_net_notifier);
>>>>>    }
>>>> These calls are moved to rxe_net_del which is called by an explicit unlink command.
>>>> But if rxe_net_init fails and returns an error code this will never happen.
>>>> This will result in leaking resources.
>>> Thanks a lot. Bob.
>>>
>>> Sure, if ipv6 tunnel fails to be created, the resource related with ipv4 should be released.
>>>
>>> I will fix it in the latest version.
>>>
>>> Zhu Yanjun
>> I haven't had a chance to test netns yet. I am sure it works but I will test it.
> Yes. Please. It is an interesting feature.
>> The only other thing I noticed are some stylistic differences with the rest of
>> the rxe driver. You use
>>
>> struct rxe_dev *rdev;
>>
>> elsewhere it is
>>
>> struct rxe_dev *rxe;
>>
>> Yours is more like the mlx drivers where they use dev for ib_device and mdev for mlx_device.
>> rxe tries to use ibdev ibqp, ibmr, etc for the ib objects and no prefix for the driver
>> specific ones. It's less typing that way.
> 
> 
> Got you. I think we should use rxe instead of rdev. I will fix it in the latest commits.
> 
> 
>>
>> With a couple of exceptions all the printk's are now in the form
>>
>> rxe_[type]_[obj](obj, "message", ...) or rxe_[type] if there isn't an obj to refer to.
>>
>> where type = info, err, warn, or dbg and obj = rxe, ah, pd, qp, cq, etc. These are basically
>> adapted from the siw driver.
> 
> If I can get you correctly, you mean that we should use rxe_dbg_qp, .... to replace pr_err ....
> 
> I have questions:
> 
> 1). What benefit will this bring?
> 
> 2). If the log is in module __init or  module __exit functions, we should use pr_xxx? Because obj does not exist in these __init and __exit functions.
I think that is the way the driver is now. Go ahead.
> 
> Best Regards,
> 
> Zhu Yanjun
> 
>>
>> Regards,
>>
>> Bob
>>
>>>> Bob
>>>>>    diff --git a/drivers/infiniband/sw/rxe/rxe_net.h b/drivers/infiniband/sw/rxe/rxe_net.h
>>>>> index a222c3eeae12..f48f22f3353b 100644
>>>>> --- a/drivers/infiniband/sw/rxe/rxe_net.h
>>>>> +++ b/drivers/infiniband/sw/rxe/rxe_net.h
>>>>> @@ -17,6 +17,7 @@ struct rxe_recv_sockets {
>>>>>    };
>>>>>      int rxe_net_add(const char *ibdev_name, struct net_device *ndev);
>>>>> +void rxe_net_del(struct ib_device *dev);
>>>>>      int rxe_register_notifier(void);
>>>>>    int rxe_net_init(void);

