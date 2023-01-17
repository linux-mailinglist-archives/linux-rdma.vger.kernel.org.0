Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB51B66E45B
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Jan 2023 18:04:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbjAQREd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 17 Jan 2023 12:04:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230352AbjAQREc (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 17 Jan 2023 12:04:32 -0500
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FB94442FC
        for <linux-rdma@vger.kernel.org>; Tue, 17 Jan 2023 09:04:31 -0800 (PST)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-15027746720so32591422fac.13
        for <linux-rdma@vger.kernel.org>; Tue, 17 Jan 2023 09:04:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AyQUh0bZdr2vUnkdpbtpAeBBWeoZLHb1Bg9etjKh7Vk=;
        b=pig54Gc8gg/4LzKXJamLq68/5EJxi13/jC+s3Q2ljoh4us0ZnqwnSoaPtjmR1IULkC
         ljKTX4flQneiHFT0SKExjRyUKehB8mdGORoVXXuiyT2bfikjZkUDuayTFsYLbcn9EPGl
         gBMTPaPhk7DOaqjYFn32BjBwH8cj9UVVjFbdFrkwFEfbDgzi29bUhgEsR3DlYk0/tZ2I
         Se8O+PaQo3YI08VKi4bCATm17H8yNmrsuxAM/wiUqINTliekpEMxnklB/6TTpkjiEN7d
         Lxpnv/5Hl42MPhsSM6e1ufv5lWecIchw8GXItOjqr5jC0Z/JW7A3qXXLUjr5XePVmX9h
         Mjcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AyQUh0bZdr2vUnkdpbtpAeBBWeoZLHb1Bg9etjKh7Vk=;
        b=eHgEWoJaqyEfKCdJjnWaWQ9o1YYO3XSnc0LaMjvy70yeqvLsg/3sv1J8t1f1FHQUig
         mCDH1y8Gu1bVdEAud/L4Se4WoNy22cQGFDKZkWYwv5SA3lcOMxGGxpCIHg2k4KqnXoIL
         2mMI5ZHis5hK5pRJuF89wYo19nG8XARSn0eWCO61hY4fcXTs1o47qSFV/UCH8TsxdSRJ
         ETsG/oEn3Hgz8wqdUGos+4QLUL/J7hXjaH50jZb3y/ZchFIIDlcywqtjuAs9m1fsROS1
         3fNUBhGGY8D070rYOtOGiCDnE6imyIiHEPyDE/pTQPE0IQ+uCo2ra1KRNQY6ESDu2OQi
         qoLQ==
X-Gm-Message-State: AFqh2kqdd2lBmoJVOO1IL37gadFJVacb3P8aJCiFjxRPEvQbV/ZNYPFV
        6iC7I9eZGnl07DjunyticbCAOEAxU8F8gQ==
X-Google-Smtp-Source: AMrXdXtavORneuDY615B1OjUmCMk9uqEPkZhucmsjr29/x1ypKqv+A2F0J49ptKOQucAfAU2KJDbBQ==
X-Received: by 2002:a05:6870:64a8:b0:15f:2b91:4938 with SMTP id cz40-20020a05687064a800b0015f2b914938mr2968923oab.7.1673975070590;
        Tue, 17 Jan 2023 09:04:30 -0800 (PST)
Received: from ?IPV6:2603:8081:140c:1a00:ea18:3ee9:26d1:7526? (2603-8081-140c-1a00-ea18-3ee9-26d1-7526.res6.spectrum.com. [2603:8081:140c:1a00:ea18:3ee9:26d1:7526])
        by smtp.gmail.com with ESMTPSA id be38-20020a05687058a600b0013d6d924995sm773052oab.19.2023.01.17.09.04.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Jan 2023 09:04:30 -0800 (PST)
Message-ID: <15174079-2a2c-c84f-3b37-7e0f26b553cc@gmail.com>
Date:   Tue, 17 Jan 2023 11:04:29 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH for-next v5 4/6] RDMA-rxe: Isolate mr code from
 atomic_write_reply()
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     zyjzyj2000@gmail.com, leonro@nvidia.com, yangx.jy@fujitsu.com,
        linux-rdma@vger.kernel.org
References: <20230116235602.22899-1-rpearsonhpe@gmail.com>
 <20230116235602.22899-5-rpearsonhpe@gmail.com> <Y8a6mILrIxIwq4/m@nvidia.com>
 <9a701083-2268-dea5-fe4b-cd2de59fb647@gmail.com>
 <Y8bUAIsqMXvHIJNb@nvidia.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <Y8bUAIsqMXvHIJNb@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 1/17/23 10:59, Jason Gunthorpe wrote:
> On Tue, Jan 17, 2023 at 10:57:31AM -0600, Bob Pearson wrote:
> 
>>>> -	dst = iova_to_vaddr(mr, qp->resp.va + qp->resp.offset, payload);
>>>> -	/* check vaddr is 8 bytes aligned. */
>>>> -	if (!dst || (uintptr_t)dst & 7)
>>>> -		return RESPST_ERR_MISALIGNED_ATOMIC;
>>>> +	if (res->replay)
>>>> +		return RESPST_ACKNOWLEDGE;
>>>>  
>>>> -	/* Do atomic write after all prior operations have completed */
>>>> -	smp_store_release(dst, src);
>>>> +	mr = qp->resp.mr;
>>>> +	value = *(u64 *)payload_addr(pkt);
>>>> +	iova = qp->resp.va + qp->resp.offset;
>>>>  
>>>> -	/* decrease resp.resid to zero */
>>>> -	qp->resp.resid -= sizeof(payload);
>>>> +#if defined CONFIG_64BIT
>>>
>>> Shouldn't need a #ifdef here
>>
>> This avoids a new special error (i.e. NOT_64_bit) and makes it clear we
>> won't call the code in mr.
> 
> ? That doesn't seem right

that was the -3 of the -1, -2, -3 that we just fixed. there are three error paths out
of this state and we need a way to get to them. The #ifdef provides that third path.
>  
>> I really don't understand why Fujitsu did it all this way instead of just
>> using a spinlock for 32 bit architectures as a fallback. But if I want to
>> keep to the spirit of their implementation this is fairly clear I think.
> 
> IIRC the IBA definition is that this is supposed to be coherent with
> the host CPU, the spinlock version is for the non-atomic atomics which
> only has to be coherent with the "hca"
> 
> So a spinlock will not provide coherency with userspace that may be
> touching this same atomic memory.

Thanks. That makes sense.

Bob
> 
> Jason

