Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BD5E3AE034
	for <lists+linux-rdma@lfdr.de>; Sun, 20 Jun 2021 22:22:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbhFTUYO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 20 Jun 2021 16:24:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbhFTUYN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 20 Jun 2021 16:24:13 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20215C061574
        for <linux-rdma@vger.kernel.org>; Sun, 20 Jun 2021 13:22:00 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id 6-20020a9d07860000b02903e83bf8f8fcso15569345oto.12
        for <linux-rdma@vger.kernel.org>; Sun, 20 Jun 2021 13:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7/iypNGiChbeFevrj1o9JsMgICiOYoJKjv+5NpxPv/E=;
        b=u/ixeZM/LLCnGVAJMMxcB/K82GKhU0YG9DY7sXAGviE+LvSFHVpbGDcu4I8Zk1Q5lV
         6b3ZUCwSlvALg9g/+vg5EDAx5/Ylw9yQWsPWbIl8Z2mNYd/8ZNJybDaszguPreuTG/nS
         cuqcrmExzqWWE8vcccGxHQDtfSmjPFYsCtEnoGJRldJjoSzmaAyaPqIhmv7aJfkhnCrw
         9DIv+9s2Q/BwAIpo1g8PULncj22xEPuFqSCq6vsvMapKAEXfRJ3r/VvzCw2QZlu3xfh2
         rnBvryV8WHG8x05nqRc7VkcD17xGmFup1UaOPb4Mx1tiZ26/yWwoe+d3a8NeONpJmuiQ
         Gk3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7/iypNGiChbeFevrj1o9JsMgICiOYoJKjv+5NpxPv/E=;
        b=jXnf1IL+yUjGIEEG9dkEyr+KHXLXs/GCkTYyb+r6sWDXjYxM8ObhNaINaiVE8FRKtV
         n2gDQjp8WyiMdfzdz+YAQhpzU2ThQcLCnu66J0Ei5OJbqLniAWe6hos5W88PRu+SNors
         qxNde+uTcSUG4e9T8gU01uJYPfGrL/tzzFH1RvucIVGT27ex4P56SPzU2m07vqJAa+4Y
         Pa/D+5L2GHrxd9Q1fiN0GOhESzNQYdwo6bajdjS1I05Qse7gpltvFMa1kMTHA3CsWl9W
         h/py7cavZoZYQS719cssB5iIGyuuVMJ7EAphXcFgZ845U27GU2w3MZnwdiOMtPtuXZKC
         J7eQ==
X-Gm-Message-State: AOAM531EKoCWOWjYXS8RS7nKRRdSZT5KacEERZauy1nlsfqcxMXJMo79
        MMU9yieByB80tWiMSg1fPCZ8qoO7k3w=
X-Google-Smtp-Source: ABdhPJwdqZv/R3ML3zaztTF8FIZU98LfEwPJR4Ysh7+UUHl1ZI68dZf/qN6ECCzvJP+VccJLjzDcMA==
X-Received: by 2002:a9d:2669:: with SMTP id a96mr17752249otb.127.1624220519319;
        Sun, 20 Jun 2021 13:21:59 -0700 (PDT)
Received: from ?IPv6:2603:8081:140c:1a00:8770:c31b:a4b9:fb27? (2603-8081-140c-1a00-8770-c31b-a4b9-fb27.res6.spectrum.com. [2603:8081:140c:1a00:8770:c31b:a4b9:fb27])
        by smtp.gmail.com with ESMTPSA id j7sm3214439oij.25.2021.06.20.13.21.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Jun 2021 13:21:58 -0700 (PDT)
Subject: Re: [PATCH for-next 6/6] RDMA/rxe: Fix redundant skb_put_zero
To:     Zhu Yanjun <zyjzyj2000@gmail.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
References: <20210618045742.204195-1-rpearsonhpe@gmail.com>
 <20210618045742.204195-7-rpearsonhpe@gmail.com>
 <CAD=hENfOFHUrSFws0ipYmrcQ803uFNmK9rPNLt-hPWpXndsLSQ@mail.gmail.com>
 <4ecf3073-b107-03cf-2072-e9d0f8cbff44@gmail.com>
 <CAD=hENdbzWgCfV3fwi7iJUGMTqzq1Ocukk_krbGiPQVi-7EP6Q@mail.gmail.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
Message-ID: <5c6fcd23-b508-18d6-69b4-d446def47a0a@gmail.com>
Date:   Sun, 20 Jun 2021 15:21:58 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CAD=hENdbzWgCfV3fwi7iJUGMTqzq1Ocukk_krbGiPQVi-7EP6Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 6/20/21 9:07 AM, Zhu Yanjun wrote:
> On Fri, Jun 18, 2021 at 11:32 PM Bob Pearson <rpearsonhpe@gmail.com> wrote:
>>
>> On 6/18/21 3:02 AM, Zhu Yanjun wrote:
>>> On Fri, Jun 18, 2021 at 1:00 PM Bob Pearson <rpearsonhpe@gmail.com> wrote:
>>>>
>>>> rxe_init_packet() in rxe_net.c calls skb_put_zero() to reserve space
>>>> for the payload and zero it out. All these bytes are then re-written
>>>> with RoCE headers and payload. Remove this useless extra copy.
>>>
>>> The paylen seems to be a variable, that is, the length of pkt->hdr is not fixed.
>>>
>>> Can you confirm that all the pkt->hdr are re-writtenwith RoCE headers
>>> and payload?
>>
>> Yes. rxe_init_packet() is called twice, once from rxe_req.c for request packets and once from rxe_resp.c for response packets.
>> In rxe_req.c in init_req_packet() paylen is set to
>>
>>     paylen = rxe_opcode[opcode].length + payload + pad + RXE_ICRC_SIZE
>>
>> which is the correct size of the packet from the UDP header to the frame FCS i.e. the UDP payload. rxe_opcode[opcode] is a table that includes the length of the all the RoCE headers for a given opcode which does vary. Payload is the RoCE payload and pad is the number of pad bytes required to extend the payload to a multiple of 4 bytes. RXE_ICRC_SIZE is the 4 bytes for the RoCE invariant CRC. It requires some checking but all the headers are fully written, the payload is fully copied from the client and the pad and ICRC bytes are also written. In rxe_resp.c paylen is set to the same value.
> 
> Too complicated assignment.
> So I prefer to skb_put_zero.

My goal here is to improve the performance of rxe. This one line adds an extra memory copy on every sent message. Without the skb_put_zero it passes all the tests and works correctly. What are you worried about exactly?

Bob
> 
> Zhu Yanjun
>>
>> There are two potential issues here 1) Is the intended packet sent to the destination, and 2) is there a possibility that information can leak from the kernel to the outside. The above addresses 1). 2) requires the assumption that the NIC is not examining data outside of the proper data area in the skb and doing something with it. But you have a worse problem there since the NIC has DMA access to all of kernel memory and can send any packet it likes.
>>
>> Bob Pearson
>>
>>> Zhu Yanjun
>>>
>>>>
>>>> Fixes: ecb238f6a7f3 ("IB/cxgb4: use skb_put_zero()/__skb_put_zero")
>>>> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
>>>> ---
>>>>  drivers/infiniband/sw/rxe/rxe_net.c | 2 +-
>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c
>>>> index 178a66a45312..6605ee777667 100644
>>>> --- a/drivers/infiniband/sw/rxe/rxe_net.c
>>>> +++ b/drivers/infiniband/sw/rxe/rxe_net.c
>>>> @@ -470,7 +470,7 @@ struct sk_buff *rxe_init_packet(struct rxe_dev *rxe, struct rxe_av *av,
>>>>
>>>>         pkt->rxe        = rxe;
>>>>         pkt->port_num   = port_num;
>>>> -       pkt->hdr        = skb_put_zero(skb, paylen);
>>>> +       pkt->hdr        = skb_put(skb, paylen);
>>>>         pkt->mask       |= RXE_GRH_MASK;
>>>>
>>>>  out:
>>>> --
>>>> 2.30.2
>>>>
>>

