Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D29F4289E21
	for <lists+linux-rdma@lfdr.de>; Sat, 10 Oct 2020 06:05:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbgJJEEz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 10 Oct 2020 00:04:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730857AbgJJDyz (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 9 Oct 2020 23:54:55 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE66AC0613CF
        for <linux-rdma@vger.kernel.org>; Fri,  9 Oct 2020 20:54:30 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id 7so8842602pgm.11
        for <linux-rdma@vger.kernel.org>; Fri, 09 Oct 2020 20:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=v5+XnBhlD3eN0Qt7568H3FC+yCMlxLZ0K++bGzRf7JQ=;
        b=svoZr/BuZMqFT5JTcviQElMMSaN1Bc5SyRzN+KGWR8sE9V/ROFoqC/sifC9HXtzg5U
         xHuVgS72ykvV4/CGEaLo2Sbs3wLyh2VJekANaWlMloQAfImDN9eCInfsbHMNg+Ze5o6N
         x/Pg5wgPAbwhrXH5Vmvm2HQHE5q86cLtVXO43r3Oxnroqc239BXo7RCGXw7WA+FZGjdb
         VnKbB18XLzFoGQb9aUrapF5pJs5F6VYQTXvswuQl4GbwAihb6BnjcP/SpVU7FwChQMVr
         U0XMCkpRSiHaC0l/6XJKZJAXSM3cZ/OQwQfX49CVBIaV8qxOf7K+iicFy87fLuzn3PsJ
         8+Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=v5+XnBhlD3eN0Qt7568H3FC+yCMlxLZ0K++bGzRf7JQ=;
        b=qQ52NWx+pyY8iBYV+cV7x1MCEcitiuf0+ruidF4JRetTlEkBJzh5v6rkF1cXQTHr94
         AHa6ZSGGAvJTZDjaddA3Hy1Mt7cR33ez2DOy+vYL2G8jvZU/4h2E53v1eJio54MkEOK5
         VdgaiJNio/0UFTXQz9MGUa+rvUHeG8PkwWYzZBL2Ab2bC9Hq4d0wuFILLLw8c8ab9bMs
         XETeTNCC+/6BVBXPQm2NnulDNKPg2+jMeuwFB5R1mNlBgACziO3xr4RtpuSCmRaCJCve
         Hii8KM5x6gF1k9Vo04SQkKzeKwDCEgDESVnYuPcj0thHHEcFLVV5zxayovivAsL0NtRo
         8EPA==
X-Gm-Message-State: AOAM531CBeA8xWnrQtB4VeBhZsGHNyLuvy0+FpprBddR82Dtcbyezdcf
        X4Z1krk06tzPGZz4BF/4w/tFK+ioD2s=
X-Google-Smtp-Source: ABdhPJz2eaA4H+BzYGqFZPve7YN1NSLFdC58T7tqZopDGwBL5MxNniFlbM+SgtvfCM0yotIi+UlGDQ==
X-Received: by 2002:a62:7f07:0:b029:155:2b57:7398 with SMTP id a7-20020a627f070000b02901552b577398mr13203367pfd.17.1602302070132;
        Fri, 09 Oct 2020 20:54:30 -0700 (PDT)
Received: from [10.75.201.17] ([129.126.144.50])
        by smtp.gmail.com with ESMTPSA id fu19sm12934493pjb.43.2020.10.09.20.54.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Oct 2020 20:54:29 -0700 (PDT)
Subject: Re: [PATCH for-next v2] rdma_rxe: fix bug rejecting multicast packets
To:     Bob Pearson <rpearsonhpe@gmail.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Bob Pearson <rpearson@hpe.com>
References: <20201008212753.265249-1-rpearson@hpe.com>
 <0e89cd73-e3ea-81fc-c5eb-be7521b10415@gmail.com>
 <20201009152827.GN4734@nvidia.com>
 <c6c80d1e-d608-c52c-dd33-3393722d266e@gmail.com>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Message-ID: <cac39621-a45a-7efd-e675-d82ae9ec30cc@gmail.com>
Date:   Sat, 10 Oct 2020 11:54:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <c6c80d1e-d608-c52c-dd33-3393722d266e@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 10/10/2020 1:18 AM, Bob Pearson wrote:
> On 10/9/20 10:28 AM, Jason Gunthorpe wrote:
>> On Fri, Oct 09, 2020 at 11:23:31PM +0800, Zhu Yanjun wrote:
>>> On 10/9/2020 5:27 AM, Bob Pearson wrote:
>>>>     - Fix a bug in rxe_rcv that causes all multicast packets to be
>>>>       dropped. Currently rxe_match_dgid is called for each packet
>>>>       to verify that the destination IP address matches one of the
>>>>       entries in the port source GID table. This is incorrect for
>>>>       IP multicast addresses since they do not appear in the GID table.
>>>>     - Add code to detect multicast addresses.
>>>>     - Change function name to rxe_chk_dgid which is clearer.
>>>>
>>>> Signed-off-by: Bob Pearson <rpearson@hpe.com>
>>>>    drivers/infiniband/sw/rxe/rxe_recv.c | 19 ++++++++++++++++---
>>>>    1 file changed, 16 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/drivers/infiniband/sw/rxe/rxe_recv.c b/drivers/infiniband/sw/rxe/rxe_recv.c
>>>> index a3eed4da1540..b6fee61b2aee 100644
>>>> +++ b/drivers/infiniband/sw/rxe/rxe_recv.c
>>>> @@ -280,7 +280,17 @@ static void rxe_rcv_mcast_pkt(struct rxe_dev *rxe, struct sk_buff *skb)
>>>>    	kfree_skb(skb);
>>>>    }
>>>> -static int rxe_match_dgid(struct rxe_dev *rxe, struct sk_buff *skb)
>>>> +/**
>>>> + * rxe_chk_dgid - validate destination IP address
>>>> + * @rxe: rxe device that received packet
>>>> + * @skb: the received packet buffer
>>>> + *
>>>> + * Accept any loopback packets
>>> About loopback packets, will rdma_find_gid_by_port return correct value?
> I didn't touch that but the RXE_LOOPBACK test comes before the call to rdma_find_gid_by_port
> so it should never get called for loopback packets.

I confronted the loopback problem with rdma-core tests.

And I made a patch to fix it. If the following commit exists, this 
problem will not occur.


commit 5c99274be8864519328aa74bc550ba410095bc1c
Author: Zhu Yanjun <yanjunz@mellanox.com>
Date:   Tue Jun 30 15:36:05 2020 +0300

     RDMA/rxe: Skip dgid check in loopback mode

     In the loopback tests, the following call trace occurs.

      Call Trace:
       __rxe_do_task+0x1a/0x30 [rdma_rxe]
       rxe_qp_destroy+0x61/0xa0 [rdma_rxe]
       rxe_destroy_qp+0x20/0x60 [rdma_rxe]
       ib_destroy_qp_user+0xcc/0x220 [ib_core]
       uverbs_free_qp+0x3c/0xc0 [ib_uverbs]
       destroy_hw_idr_uobject+0x24/0x70 [ib_uverbs]
       uverbs_destroy_uobject+0x43/0x1b0 [ib_uverbs]
       uobj_destroy+0x41/0x70 [ib_uverbs]
       __uobj_get_destroy+0x39/0x70 [ib_uverbs]
       ib_uverbs_destroy_qp+0x88/0xc0 [ib_uverbs]
       ib_uverbs_handler_UVERBS_METHOD_INVOKE_WRITE+0xb9/0xf0 [ib_uverbs]
       ib_uverbs_cmd_verbs+0xb16/0xc30 [ib_uverbs]

     The root cause is that the actual RDMA connection is not created in the
     loopback tests and the rxe_match_dgid will fail randomly.

     To fix this call trace which appear in the loopback tests, skip 
check of
     the dgid.

     Fixes: 8700e3e7c485 ("Soft RoCE driver")
     Link: https://lore.kernel.org/r/20200630123605.446959-1-leon@kernel.org
     Signed-off-by: Zhu Yanjun <yanjunz@mellanox.com>
     Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
     Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

>> I don't think you can use 127.0.0.0 with the RDMA devices, at least
>> not on the wire. The CM has special code to swap it out with a real
>> device address
> The following does work:
>
> $ ib_send_bw -d rxe_0 (in window A)                $ ib_send_bw -d rxe_0 127.0.0.1 (in window B)
>
> This uses the LOOPBACK path and just hands the skb from sender to receiver. It never touches the IP stack.
>
> I have never been able to get this to work:
>
> $ ib_send_bw -d rxe_1 (at 10.0.0.1 in window A)    $ ib_send_bw -d rxe_2 10.0.0.1 (at 10.0.0.2 in window B)
>
> If it did work I could test the full path.
>> Jason
>>

