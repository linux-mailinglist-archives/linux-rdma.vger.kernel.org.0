Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2854A4A37EB
	for <lists+linux-rdma@lfdr.de>; Sun, 30 Jan 2022 18:47:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232540AbiA3Rro (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 30 Jan 2022 12:47:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355752AbiA3Rro (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 30 Jan 2022 12:47:44 -0500
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1414FC061714
        for <linux-rdma@vger.kernel.org>; Sun, 30 Jan 2022 09:47:44 -0800 (PST)
Received: by mail-oi1-x232.google.com with SMTP id e81so22493497oia.6
        for <linux-rdma@vger.kernel.org>; Sun, 30 Jan 2022 09:47:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=MldFBF0cKUb7nZnykhQvN2B16U8v/Rmhm4pyj8UF5wU=;
        b=Kuw/Jw+c5urv8Fmu5LwS80gALwGnfmrPJR6SCbozrRKfD277Hxx07y3svAqAy8GGNB
         kud65llN0oA348qSBEfPb6/0JP5pHIzAInQJ6D+q69XIvXmIPDcR/O5Kymp51SWUAHgH
         y84HfZgpbUrmH1xtNZA2QV3lUxTOJJt8fzLU/4upkMLQpQ+V0yNhPLpRhYgjtcRV2uya
         AmU7BaADBjvMqnTG611sJce69B+ec78hhZUFqY/lL8L48ruyL6hSxpnz9is/OKtngbAr
         4PV9O7hdCgo5bjyU0b/jY9jj0to+aiQujD3XCHcWBggue42kUp93AyipS5kbGu3Ot2Tv
         IYlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=MldFBF0cKUb7nZnykhQvN2B16U8v/Rmhm4pyj8UF5wU=;
        b=B8lEWAB3A726O6QrlfNOzrP5sQ1J8qPFzaYpuAA8yofUG7+ktmh4YXa4I2IvhXaRNo
         i0Ceg0FsndtFIXNyNVf7yOUgdqOovr6+/jSGEJMTOhDbM9fIEEowXZDwi+WDSGGaWwZ0
         61bOJco/uK58UQ/JhzN95K0zsF/I/p76ju5iq9jzvclrjfN3+uXjm0/SA+9NgkqokCGW
         s8yULXG1/rGfHpmjg7DlYz64TghDSVBdSZ8kPm2y/pxi+5tGDykiKg7LZwTwUj9dMGOa
         +zl0HOGxCR6tzuPMeMzmuWCV37bfXcOgXwUMSGroKjOYu0hFjZPuMR7XOOQxuXdzsyjt
         YZnw==
X-Gm-Message-State: AOAM53017vKnvdkiRnquYfKfQPfeKgcZLFan5qe6cjSf03u3vpr5tOGM
        W9k0tOkRM1oi37/fhexaNxY=
X-Google-Smtp-Source: ABdhPJyUfSaGK6G3/Gv8C0p6mThY0zQzF+6oqMyjFN1yAnMEgi8gjW02bDfIAlW8Yp6+TH4yw1MUDw==
X-Received: by 2002:a54:450b:: with SMTP id l11mr11439106oil.282.1643564863336;
        Sun, 30 Jan 2022 09:47:43 -0800 (PST)
Received: from [192.168.0.27] (097-099-248-255.res.spectrum.com. [97.99.248.255])
        by smtp.gmail.com with ESMTPSA id t4sm11540198oie.14.2022.01.30.09.47.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Jan 2022 09:47:43 -0800 (PST)
Message-ID: <9ba690db-b708-749e-7cc9-8bd0396264ad@gmail.com>
Date:   Sun, 30 Jan 2022 11:47:42 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [RFC PATCH v9 09/26] RDMA/rxe: Introduce RXECB(skb)
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
References: <20220127213755.31697-1-rpearsonhpe@gmail.com>
 <20220127213755.31697-10-rpearsonhpe@gmail.com>
 <20220128182947.GE1786498@nvidia.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <20220128182947.GE1786498@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 1/28/22 12:29, Jason Gunthorpe wrote:
> On Thu, Jan 27, 2022 at 03:37:38PM -0600, Bob Pearson wrote:
>> Add a #define RXECB(skb) to rxe_hdr.h as a short cut to
>> refer to single members of rxe_pkt_info which is stored in skb->cb
>> in the receive path. Use this to make some cleanups in rxe_recv.c
>>
>> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
>>  drivers/infiniband/sw/rxe/rxe_hdr.h  |  3 ++
>>  drivers/infiniband/sw/rxe/rxe_recv.c | 55 +++++++++++++---------------
>>  2 files changed, 29 insertions(+), 29 deletions(-)
>>
>> diff --git a/drivers/infiniband/sw/rxe/rxe_hdr.h b/drivers/infiniband/sw/rxe/rxe_hdr.h
>> index e432f9e37795..2a85d1e40e6a 100644
>> +++ b/drivers/infiniband/sw/rxe/rxe_hdr.h
>> @@ -36,6 +36,9 @@ static inline struct sk_buff *PKT_TO_SKB(struct rxe_pkt_info *pkt)
>>  	return container_of((void *)pkt, struct sk_buff, cb);
>>  }
>>  
>> +/* alternative to access a single element of rxe_pkt_info from skb */
>> +#define RXECB(skb) ((struct rxe_pkt_info *)((skb)->cb))
> 
> May as well make this a static inline
> 
> Jason

Mostly these seem to be #defines. See e.g. IPCB, IP6CB, NAPI_GRO_CB, etc. Not sure why but
I copied those.

Bob
