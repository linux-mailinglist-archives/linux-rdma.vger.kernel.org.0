Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 163F372AFC7
	for <lists+linux-rdma@lfdr.de>; Sun, 11 Jun 2023 02:33:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229450AbjFKAdx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 10 Jun 2023 20:33:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231949AbjFKAdw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 10 Jun 2023 20:33:52 -0400
X-Greylist: delayed 399 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 10 Jun 2023 17:33:50 PDT
Received: from out-10.mta1.migadu.com (out-10.mta1.migadu.com [IPv6:2001:41d0:203:375::a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0749F3AA3
        for <linux-rdma@vger.kernel.org>; Sat, 10 Jun 2023 17:33:49 -0700 (PDT)
Message-ID: <1c95d615-c3fc-070d-0637-183846e1f2aa@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1686443226;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hvhLgzJgfs+HdDvMEko/cJpLhG1luwW0eAkD8TxeboU=;
        b=PwUFRKr9JddgMdRfca2WLYjB1/9XItP162q0rjTV3HIDBfp4+9kbkMah5+5viu7tB4V96b
        As5uGhsZHbVyUC3slPpBl+LMHR0glvhi+KEYftSCBadR5yaCKloZeguTtl7XV/uY0MKIIY
        tIoHW5j3s1jHak36DZuAkP9/mPZg8w8=
Date:   Sun, 11 Jun 2023 08:27:00 +0800
MIME-Version: 1.0
Subject: Re: [PATCH v1] RDMA/core: Handle ARPHRD_NONE devices for iWARP
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Tom Talpey <tom@talpey.com>, Chuck Lever <cel@kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Bernard Metzler <BMT@zurich.ibm.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <168616682205.2099.4473975057644323224.stgit@oracle-102.nfsv4bat.org>
 <dd9f65ab-d54f-7830-8043-57ea66c76149@talpey.com>
 <68b162e4-06a1-520d-f157-d655cffafb01@linux.dev>
 <81CAD740-E3A0-497C-A4AD-276B8B2FDB35@oracle.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <81CAD740-E3A0-497C-A4AD-276B8B2FDB35@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


在 2023/6/11 0:43, Chuck Lever III 写道:
>
>> On Jun 9, 2023, at 8:04 PM, Zhu Yanjun <yanjun.zhu@linux.dev> wrote:
>>
>> 在 2023/6/10 4:49, Tom Talpey 写道:
>>> On 6/7/2023 3:43 PM, Chuck Lever wrote:
>>>> From: Chuck Lever <chuck.lever@oracle.com>
>>>>
>>>> We would like to enable the use of siw on top of a VPN that is
>>>> constructed and managed via a tun device. That hasn't worked up
>>>> until now because ARPHRD_NONE devices (such as tun devices) have
>>>> no GID for the RDMA/core to look up.
>>>>
>>>> But it turns out that the egress device has already been picked for
>>>> us. addr_handler() just has to do the right thing with it.
>>>>
>>>> Tested with siw and qedr, both initiator and target.
>>>>
>>>> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
>>>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>>>> ---
>>>>    drivers/infiniband/core/cma.c |    3 +++
>>>>    1 file changed, 3 insertions(+)
>>>>
>>>> This of course needs broader testing, but it seems to work, and it's
>>>> a little nicer than "if (dev_type == ARPHRD_NONE)".
>>>>
>>>> One thing I discovered is that the NFS/RDMA server implementation
>>>> does not deal at all with more than one RDMA device on the system.
>>>> I will address that with an ib_client; SunRPC patches forthcoming.
>>>>
>>>> diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
>>>> index 56e568fcd32b..c9a2bdb49e3c 100644
>>>> --- a/drivers/infiniband/core/cma.c
>>>> +++ b/drivers/infiniband/core/cma.c
>>>> @@ -694,6 +694,9 @@ cma_validate_port(struct ib_device *device, u32 port,
>>>>        if (!rdma_dev_access_netns(device, id_priv->id.route.addr.dev_addr.net))
>>>>            return ERR_PTR(-ENODEV);
>>>> +    if (rdma_protocol_iwarp(device, port))
>>>> +        return rdma_get_gid_attr(device, port, 0);
>>> This might work, but I'm skeptical of the conditional. There's nothing
>>> special about iWARP that says a GID should come from the outgoing device
>>> mac. And, other protocols without IB GID addressing won't benefit.
> Hi Zhu, thanks for having a look.
>
>
>> Agree with you. Other protocols, such as RXE, also need be handled.
>> So a better solution than this needs.
> I assume you mean, in particular, RoCEv2 with rxe on a non-Ethernet
> device? Tom and I discussed that possibility privately while I
> developed this patch.

I am not sure if I can get you correctly or not. I mean, if RXE is 
attached to a loopback device,

the symptopms are similar to iWARP.

So if you want to fix this problem on iWARP, it is better to also fix 
the similar problem on RXE.

That is , your patch should fix the similar problems on all the rdma 
devices, not just for iWARP.

I am not sure if this request is appropriate to you or not.

Zhu Yanjun

>
> I do not object to that idea. But I would feel more comfortable if
> that was justified and tested via a separate patch. I expect that
> the logic for those cases will look different to what I'm adding here.
>
>
>> Zhu Yanjun
>>
>>> Wouldn't it be better to detect a missing GID, or infer the need from
>>> some other transport attribute?
>>> Tom.
>>>> +
>>>>        if ((dev_type == ARPHRD_INFINIBAND) && !rdma_protocol_ib(device, port))
>>>>            return ERR_PTR(-ENODEV);
>
> --
> Chuck Lever
>
>
