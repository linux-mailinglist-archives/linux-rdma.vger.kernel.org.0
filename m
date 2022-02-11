Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D2214B2BE9
	for <lists+linux-rdma@lfdr.de>; Fri, 11 Feb 2022 18:39:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348699AbiBKRhX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 11 Feb 2022 12:37:23 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344286AbiBKRhU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 11 Feb 2022 12:37:20 -0500
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 781EC38F
        for <linux-rdma@vger.kernel.org>; Fri, 11 Feb 2022 09:37:18 -0800 (PST)
Received: by mail-ot1-x32e.google.com with SMTP id o9-20020a9d7189000000b0059ee49b4f0fso6591200otj.2
        for <linux-rdma@vger.kernel.org>; Fri, 11 Feb 2022 09:37:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=EWQpsc+eWd3AKTYDmo9luZVaS4FFFSGnJLxVLBNY9/c=;
        b=ONaHwi5ynnmcBdpLis7sF5HCx3TurNyoaM/vjME4WkxYA5NNtVukJneckwuZtQoeNk
         ySMUTrYvmycKU0vf8RiHU5j/Ja4mYcjSdq06dE19+QQgXpid1iPG4yB+BhxupI1xjM5m
         XUizc3FBerZBdUk6Xnzsb1LfsRfRIhtwTaAIfmXErv+S5UinadY5lXL5Gu82n7sFOn7a
         bPbGqdDoUSPO9HvgqXkRVIae+JZ2Magkwgsdq4T9JNHdL4b88UIP5+D7sM2optyjnDdK
         Xzg2eF86tn7KUWnv7cDZXFYCl+UC8agkv5k+3A9hnq4jh1Z317MCAx8V+lJyx9OzSA8P
         1e9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=EWQpsc+eWd3AKTYDmo9luZVaS4FFFSGnJLxVLBNY9/c=;
        b=SLtglofIpS1FIQKQhI7zViB4sEr/ADjMiCiZ8MWwauUDVXMmAuKu6NkPQOwNk4uk0F
         G8pbQCUUUaCG1SUt2eDbUfZQOtXLwpvSpV7ewdaOt0rM9NxSHV2II2zR9yvvqK3sG6tv
         IjS7zaKTW/7EoKzibeDG9x3icBeG6BglcAkFqGRwiAQ+3WDqn1wgJ3DqVFlSfxA/HkOy
         ys6uCNSxNn5GFqpINTfs+u2PAkZaeOnMeMpGr1nP0ilPAwwk2+u6c+XUsCSFBUQMkSpC
         Ps1hqVCBTF70+B1BqYopI7ioqdFRJ6hCKiW1V4xgJR8VL/muBEklZxG91a2CCsvlx7Lk
         dLTg==
X-Gm-Message-State: AOAM532/B5kangWHfw7/0FMa1p4Jev+/DsNGbQx/tr5T8I5f7WEY4sLB
        8DBu2T/wIB45ONdkc7sKGwSZQUKaODc=
X-Google-Smtp-Source: ABdhPJxRug4DqMNMVIHKI9GZSYvZgQXN7sB6rsQ0bytZkzHt6/RTTjXX+aSE0RO4xUjbRnahHYI9WQ==
X-Received: by 2002:a9d:112:: with SMTP id 18mr1011818otu.379.1644601037811;
        Fri, 11 Feb 2022 09:37:17 -0800 (PST)
Received: from ?IPV6:2603:8081:140c:1a00:4354:ebed:9b2:4ca2? (2603-8081-140c-1a00-4354-ebed-09b2-4ca2.res6.spectrum.com. [2603:8081:140c:1a00:4354:ebed:9b2:4ca2])
        by smtp.gmail.com with ESMTPSA id d14sm9624813ooh.44.2022.02.11.09.37.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Feb 2022 09:37:17 -0800 (PST)
Message-ID: <0bfd4e4f-0311-ed02-d23e-7bd5a2a9750b@gmail.com>
Date:   Fri, 11 Feb 2022 11:37:16 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 2/3] RDMA/rxe: Replace write_lock_bh with
 write_lock_irqsave in __rxe_drop_index
Content-Language: en-US
To:     Guoqing Jiang <guoqing.jiang@linux.dev>,
        Zhu Yanjun <zyjzyj2000@gmail.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
References: <20220210073655.42281-1-guoqing.jiang@linux.dev>
 <20220210073655.42281-3-guoqing.jiang@linux.dev>
 <CAD=hENd6GiLggA5L9p_jQk9MA4ckh3vNB=EKXZ6BZxKrgNCoAg@mail.gmail.com>
 <cd90c0e1-0327-4f0b-1b38-489fd18cf9d5@gmail.com>
 <b9d5b243-2397-42bd-d833-1a1e5e4ce32c@linux.dev>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <b9d5b243-2397-42bd-d833-1a1e5e4ce32c@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2/11/22 04:09, Guoqing Jiang wrote:
> 
> 
> On 2/10/22 11:49 PM, Bob Pearson wrote:
>> On 2/10/22 08:16, Zhu Yanjun wrote:
>>> On Thu, Feb 10, 2022 at 3:37 PM Guoqing Jiang<guoqing.jiang@linux.dev>  wrote:
>>>> Same as __rxe_add_index, the lock need to be fully IRQ safe, otherwise
>>>> below calltrace appears.
>>>>
>> I had the impression that NAPI ran on a soft IRQ and the rxe tasklets are also on soft IRQs. So at least in theory spin_lock_bh() should be sufficient. Can someone explain where the hard interrupt is coming from that we need to protect.
> 
> Since rxe is actually run on top of NIC,  could it comes from NIC if NIC driver doesn't switch to NAPI
> or from other hardware? But my knowledge about the domain is limited.
> 
>>   There are other race conditions in current rxe that may also be the cause of this. I am trying to get a patch series accepted to deal with those.
> 
> If possible, could you investigate why rxe after 5.15 kernel doesn't work as reported in cover letter? Thank you!
> 
> Guoqing

Guoqing,

It would help to know more about the test setup you are using. I.e. which NIC/driver.
I mostly test on head of tree and things seem to be working.
You could add something like

	if (in_irq())
		<print something once or twice>

to rxe_udp_encap_recv() to check if you are in a hard interrupt in the receive path.

Bob
