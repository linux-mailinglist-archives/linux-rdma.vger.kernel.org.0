Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54A8F288FE6
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Oct 2020 19:19:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731953AbgJIRTJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 9 Oct 2020 13:19:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730434AbgJIRSf (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 9 Oct 2020 13:18:35 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA6F6C0613D2
        for <linux-rdma@vger.kernel.org>; Fri,  9 Oct 2020 10:18:35 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id m13so9637208otl.9
        for <linux-rdma@vger.kernel.org>; Fri, 09 Oct 2020 10:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=G7DYHGqR4MEZUz3FVOoZ01/oeuR7H9bHKs1JQTZgajg=;
        b=SBsbOi1iqoje+Y0Wst0i4qrsAZfY6/rEUlL7KN1bh2r+peRKVNwVj7kkYjxsToJaly
         W3+lYOUkw8TP/D4qC9wpmKhfqNCxcr3MsiNt7Au9C8BIK/zgaUMC5VZxHtSWfHLlAuVS
         2u4dYVFPzuS8MvuqozBVsyWv9covB5k7pYwcUdDfc5ezYHUf8kEhBjwpP0bpN/pS+FXb
         aECeBAWQq5WK+JZbO5W/l+zR5zgUrOlrLW5x5gN7udH6Ygo2QmBOYcU8zOYYu5wbIanT
         0SCrdIwoF9jaeKa/cvBAajBDllBWlVspCQT9HE1weUY+uqiWqdkgrO2OnXAIIvcNkMX7
         i3mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=G7DYHGqR4MEZUz3FVOoZ01/oeuR7H9bHKs1JQTZgajg=;
        b=I0GVRlpNgE3Oo/HL0W+9YWDngqRzMWCh3HOkxR/bndO5z28iNY9X/7Pzqz42GkxUE2
         pL1z1y5U/9We7lp0bXN9TdC/lRcH5Z9BTffPt0HukwrbWOOsDl1WmWZuj3tpBdNwP7Lj
         Hl15D1EMlgLgePO3PE2dabmh9YZWJeUoOeS5YXNwkcj3slyiPCxG/7JBkBbaJvHgXGSS
         Uah1v5lRuypbllwCWhU6woWm/2zJVG0mGAFkrgW/5qLWVkpn49ajRS8DzmZPqr8m0/9A
         f8PJ0Zwu6JpIurctylJs+jbH0O18+WlUlnhD414RBMRTuBl3ONW8nfUsHkK50zIK8s/A
         GPtw==
X-Gm-Message-State: AOAM532krSWNQKdXUewrrim7YqzCwrJaoFoXC7rMB8y3sBLpLk3zKB8R
        +kuNuE4PUWl6qW6dS0bP/Be3OMLGmGU=
X-Google-Smtp-Source: ABdhPJwtOY3vCeRg+if1KINTi7rr0yjKq1lE7qiVtMhDuwG1+22WLDRRDOaljQrMQibstM608MMHtQ==
X-Received: by 2002:a9d:7f15:: with SMTP id j21mr9134148otq.76.1602263915096;
        Fri, 09 Oct 2020 10:18:35 -0700 (PDT)
Received: from ?IPv6:2605:6000:8b03:f000:21af:60b5:ebc7:e8c6? ([2605:6000:8b03:f000:21af:60b5:ebc7:e8c6])
        by smtp.gmail.com with ESMTPSA id u2sm7406088oig.48.2020.10.09.10.18.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Oct 2020 10:18:34 -0700 (PDT)
Subject: Re: [PATCH for-next v2] rdma_rxe: fix bug rejecting multicast packets
To:     Jason Gunthorpe <jgg@nvidia.com>, Zhu Yanjun <zyjzyj2000@gmail.com>
Cc:     linux-rdma@vger.kernel.org, Bob Pearson <rpearson@hpe.com>
References: <20201008212753.265249-1-rpearson@hpe.com>
 <0e89cd73-e3ea-81fc-c5eb-be7521b10415@gmail.com>
 <20201009152827.GN4734@nvidia.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
Message-ID: <c6c80d1e-d608-c52c-dd33-3393722d266e@gmail.com>
Date:   Fri, 9 Oct 2020 12:18:34 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201009152827.GN4734@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 10/9/20 10:28 AM, Jason Gunthorpe wrote:
> On Fri, Oct 09, 2020 at 11:23:31PM +0800, Zhu Yanjun wrote:
>> On 10/9/2020 5:27 AM, Bob Pearson wrote:
>>>    - Fix a bug in rxe_rcv that causes all multicast packets to be
>>>      dropped. Currently rxe_match_dgid is called for each packet
>>>      to verify that the destination IP address matches one of the
>>>      entries in the port source GID table. This is incorrect for
>>>      IP multicast addresses since they do not appear in the GID table.
>>>    - Add code to detect multicast addresses.
>>>    - Change function name to rxe_chk_dgid which is clearer.
>>>
>>> Signed-off-by: Bob Pearson <rpearson@hpe.com>
>>>   drivers/infiniband/sw/rxe/rxe_recv.c | 19 ++++++++++++++++---
>>>   1 file changed, 16 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/infiniband/sw/rxe/rxe_recv.c b/drivers/infiniband/sw/rxe/rxe_recv.c
>>> index a3eed4da1540..b6fee61b2aee 100644
>>> +++ b/drivers/infiniband/sw/rxe/rxe_recv.c
>>> @@ -280,7 +280,17 @@ static void rxe_rcv_mcast_pkt(struct rxe_dev *rxe, struct sk_buff *skb)
>>>   	kfree_skb(skb);
>>>   }
>>> -static int rxe_match_dgid(struct rxe_dev *rxe, struct sk_buff *skb)
>>> +/**
>>> + * rxe_chk_dgid - validate destination IP address
>>> + * @rxe: rxe device that received packet
>>> + * @skb: the received packet buffer
>>> + *
>>> + * Accept any loopback packets
>>
>> About loopback packets, will rdma_find_gid_by_port return correct value?
I didn't touch that but the RXE_LOOPBACK test comes before the call to rdma_find_gid_by_port
so it should never get called for loopback packets.
> 
> I don't think you can use 127.0.0.0 with the RDMA devices, at least
> not on the wire. The CM has special code to swap it out with a real
> device address
The following does work:

$ ib_send_bw -d rxe_0 (in window A)                $ ib_send_bw -d rxe_0 127.0.0.1 (in window B)

This uses the LOOPBACK path and just hands the skb from sender to receiver. It never touches the IP stack.

I have never been able to get this to work:

$ ib_send_bw -d rxe_1 (at 10.0.0.1 in window A)    $ ib_send_bw -d rxe_2 10.0.0.1 (at 10.0.0.2 in window B)

If it did work I could test the full path.
> 
> Jason
> 

