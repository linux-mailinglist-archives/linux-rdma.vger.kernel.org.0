Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B08433ACF25
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Jun 2021 17:33:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235531AbhFRPfL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 18 Jun 2021 11:35:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235690AbhFRPfC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 18 Jun 2021 11:35:02 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98C0DC061574
        for <linux-rdma@vger.kernel.org>; Fri, 18 Jun 2021 08:32:52 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id t140so11007709oih.0
        for <linux-rdma@vger.kernel.org>; Fri, 18 Jun 2021 08:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Xd5QjTe4uWXP118dpRaT9dbxsXoCwPmnvbserUtYyTs=;
        b=bdh31Vda7c5WHAea/wG5Twt+m0JG/ZH+UjfEB/a1HBJ5PRaejxQrQFpwNXmpzf6fuE
         Li0JerLqtRIX9Fej3/sD0H2VhTNzxWQI5LW8SWcHs9gciACbMoYguQNLnLNpWGjhoDgu
         QgSXpM3NV5zxmD29+env5u3Wt2GkD/W8dytQ7pnUpRWR38SXsFgkem5nfBjbfbRyFKHc
         GfK4fcb6f845a3xx2ElaQ1rG5Wx43r5LuznpXt6pPjp8VRNwMGAE6iBdY/+VyaG8ShMJ
         0KX3OV+z+BR+pO+uxrafFWo6io6Bu2cx5eFK92grB3WHeHoD7hDyVXKu2TUjXYpihhm5
         QiRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Xd5QjTe4uWXP118dpRaT9dbxsXoCwPmnvbserUtYyTs=;
        b=EwcuusyHIdm+tslYpwq/poD6pRU0immd2Dp+JOv/rHFZ21LqEFSkUBCCJw9shVoc1q
         PEztLbocZTMYXtuGa74rFsY0JnyCxdFKNByr8E5MDqYDMt1TDxOmny0Bo+kfZlQesijk
         cRNeTVVD3bAKNno9olGxdFlBmj/J4p8FgaAt+a++jP947NhFQP50iyihez7ZC/iEG/Yz
         WNCoMHcTrmG14x/XRXiwp4nc+EZLuz8dLQOILqpc1SXf+CualOb/c08eb6C5j/TJybR3
         AIOSc3VNy4HsDT8ksJoxostZSzCizCHIPKr8GX1fkFn78mVUsDjHMWgOEg7ZwvCZLRjA
         qE8g==
X-Gm-Message-State: AOAM532A+wkw/dUJvChbmcnPuzSWvRBZhtnX9UCV0HjiiUBV0r+mhfHQ
        xeaqLquI/qFzPZm76H91V1Sn04V3WIw=
X-Google-Smtp-Source: ABdhPJz79EJYhoMf9GJWcrZsz+qc3aT/y+4rmi/0MuUUhppYFJrhhE1bXdg/lZTCaPwwo/mTqKU+Sg==
X-Received: by 2002:aca:b484:: with SMTP id d126mr15100588oif.80.1624030371662;
        Fri, 18 Jun 2021 08:32:51 -0700 (PDT)
Received: from ?IPv6:2603:8081:140c:1a00:2fce:3453:431e:5204? (2603-8081-140c-1a00-2fce-3453-431e-5204.res6.spectrum.com. [2603:8081:140c:1a00:2fce:3453:431e:5204])
        by smtp.gmail.com with ESMTPSA id b198sm1865097oii.19.2021.06.18.08.32.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Jun 2021 08:32:51 -0700 (PDT)
Subject: Re: [PATCH for-next 6/6] RDMA/rxe: Fix redundant skb_put_zero
To:     Zhu Yanjun <zyjzyj2000@gmail.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
References: <20210618045742.204195-1-rpearsonhpe@gmail.com>
 <20210618045742.204195-7-rpearsonhpe@gmail.com>
 <CAD=hENfOFHUrSFws0ipYmrcQ803uFNmK9rPNLt-hPWpXndsLSQ@mail.gmail.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
Message-ID: <4ecf3073-b107-03cf-2072-e9d0f8cbff44@gmail.com>
Date:   Fri, 18 Jun 2021 10:32:50 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CAD=hENfOFHUrSFws0ipYmrcQ803uFNmK9rPNLt-hPWpXndsLSQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 6/18/21 3:02 AM, Zhu Yanjun wrote:
> On Fri, Jun 18, 2021 at 1:00 PM Bob Pearson <rpearsonhpe@gmail.com> wrote:
>>
>> rxe_init_packet() in rxe_net.c calls skb_put_zero() to reserve space
>> for the payload and zero it out. All these bytes are then re-written
>> with RoCE headers and payload. Remove this useless extra copy.
> 
> The paylen seems to be a variable, that is, the length of pkt->hdr is not fixed.
> 
> Can you confirm that all the pkt->hdr are re-writtenwith RoCE headers
> and payload?

Yes. rxe_init_packet() is called twice, once from rxe_req.c for request packets and once from rxe_resp.c for response packets.
In rxe_req.c in init_req_packet() paylen is set to

    paylen = rxe_opcode[opcode].length + payload + pad + RXE_ICRC_SIZE

which is the correct size of the packet from the UDP header to the frame FCS i.e. the UDP payload. rxe_opcode[opcode] is a table that includes the length of the all the RoCE headers for a given opcode which does vary. Payload is the RoCE payload and pad is the number of pad bytes required to extend the payload to a multiple of 4 bytes. RXE_ICRC_SIZE is the 4 bytes for the RoCE invariant CRC. It requires some checking but all the headers are fully written, the payload is fully copied from the client and the pad and ICRC bytes are also written. In rxe_resp.c paylen is set to the same value.
 
There are two potential issues here 1) Is the intended packet sent to the destination, and 2) is there a possibility that information can leak from the kernel to the outside. The above addresses 1). 2) requires the assumption that the NIC is not examining data outside of the proper data area in the skb and doing something with it. But you have a worse problem there since the NIC has DMA access to all of kernel memory and can send any packet it likes.

Bob Pearson

> Zhu Yanjun
> 
>>
>> Fixes: ecb238f6a7f3 ("IB/cxgb4: use skb_put_zero()/__skb_put_zero")
>> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
>> ---
>>  drivers/infiniband/sw/rxe/rxe_net.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c
>> index 178a66a45312..6605ee777667 100644
>> --- a/drivers/infiniband/sw/rxe/rxe_net.c
>> +++ b/drivers/infiniband/sw/rxe/rxe_net.c
>> @@ -470,7 +470,7 @@ struct sk_buff *rxe_init_packet(struct rxe_dev *rxe, struct rxe_av *av,
>>
>>         pkt->rxe        = rxe;
>>         pkt->port_num   = port_num;
>> -       pkt->hdr        = skb_put_zero(skb, paylen);
>> +       pkt->hdr        = skb_put(skb, paylen);
>>         pkt->mask       |= RXE_GRH_MASK;
>>
>>  out:
>> --
>> 2.30.2
>>

