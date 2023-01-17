Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0479670B34
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Jan 2023 23:06:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbjAQWGc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 17 Jan 2023 17:06:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230038AbjAQWFg (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 17 Jan 2023 17:05:36 -0500
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FF6F5D100
        for <linux-rdma@vger.kernel.org>; Tue, 17 Jan 2023 12:41:55 -0800 (PST)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-12c8312131fso33341739fac.4
        for <linux-rdma@vger.kernel.org>; Tue, 17 Jan 2023 12:41:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dPTTwLrNX0YuzVsxibUQyezCEtcvZHPzwtNL6uSI0ic=;
        b=Zk1w83TeCZhq/uvzmYI2Gx5D8eVn5XK+PCyZRVU8/Kxwx5ebbCzIicO6zm9EVjz7Cq
         SHsPQArVcCpNZdWm6Rtv5i5ElpsJs8BCqZAQNrHRzO49F/wr9aP6nxBerpAs8mMTj+Tv
         D6sv0oSvR3fHzcpPlSKpmeE1actf/u88Z6Rtz/VTM8/gaNhDbowc/7w5PhSH9ZtOewPl
         ho/MVjVYkMJ27QpovZC6qcezwcCHiPjKIFSVcgugzdSmkjyjPOvGwnFW3T1rpRfgNVu0
         aoKHIeLf6J5DDWyuVfmxU7HA6Zn+5lJ11fKvOPr6nwSNpCtSv9gIACkAtb4CQBKdidGu
         JWXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dPTTwLrNX0YuzVsxibUQyezCEtcvZHPzwtNL6uSI0ic=;
        b=T3hbOiyUJHi1k83ApREfmiL8v1w7cFCwCFsVMS2XDUqFAEiJjS+WIMDhiVcL2KVXTr
         jkiPDlyVWTYd81ftbabU+Tn/DFYbkiH+jsiUJ0/8/ode4diJjaNFBp1Megfuj7y5fa6j
         r4x4EoGp5mhacUD/VOanOaFQhuErez+Ef9uky/UQWtfQYzSg4lLXq8ejLeEchK3lTFgT
         MA8LeqZCP4+0YngIPdo2ks65yMd57pmM5N0ualvh6jydQFAhYAt+OqIH3GGqie6lmqs5
         3oOSJ5yp0TAQfyZgoET0eVRSejwCvpsf0e1yDTI4Qb1O1yuhFhiESf28jdZ+SYyE0HQH
         +MSg==
X-Gm-Message-State: AFqh2kppOzhXmm/2mxXaErefeAeUtVR/BRDz7X4JCVhHHIW2Iz59hb7N
        x4ipJKSHUvlOoTvJ+1HbwhaeLpVDxbkUVg==
X-Google-Smtp-Source: AMrXdXurkmnNlcy+nY6AlraNuqNO6/Lc5pBrFyPxhIXMrvge4jIFnwk88gqdxIG8zOutklLZbpmyOA==
X-Received: by 2002:a05:6870:4c81:b0:15b:9fba:b5ad with SMTP id pi1-20020a0568704c8100b0015b9fbab5admr2717731oab.8.1673988115227;
        Tue, 17 Jan 2023 12:41:55 -0800 (PST)
Received: from ?IPV6:2603:8081:140c:1a00:26e:3286:4ecc:e653? (2603-8081-140c-1a00-026e-3286-4ecc-e653.res6.spectrum.com. [2603:8081:140c:1a00:26e:3286:4ecc:e653])
        by smtp.gmail.com with ESMTPSA id v12-20020a056870b50c00b0014fc049fc0asm17323397oap.57.2023.01.17.12.41.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Jan 2023 12:41:54 -0800 (PST)
Message-ID: <1a198842-91f6-2fe4-a478-1df4dda341c0@gmail.com>
Date:   Tue, 17 Jan 2023 14:41:53 -0600
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
 <15174079-2a2c-c84f-3b37-7e0f26b553cc@gmail.com>
 <Y8bjYnQLvw3Uv7CD@nvidia.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <Y8bjYnQLvw3Uv7CD@nvidia.com>
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

On 1/17/23 12:05, Jason Gunthorpe wrote:
> On Tue, Jan 17, 2023 at 11:04:29AM -0600, Bob Pearson wrote:
>> On 1/17/23 10:59, Jason Gunthorpe wrote:
>>> On Tue, Jan 17, 2023 at 10:57:31AM -0600, Bob Pearson wrote:
>>>
>>>>>> -	dst = iova_to_vaddr(mr, qp->resp.va + qp->resp.offset, payload);
>>>>>> -	/* check vaddr is 8 bytes aligned. */
>>>>>> -	if (!dst || (uintptr_t)dst & 7)
>>>>>> -		return RESPST_ERR_MISALIGNED_ATOMIC;
>>>>>> +	if (res->replay)
>>>>>> +		return RESPST_ACKNOWLEDGE;
>>>>>>  
>>>>>> -	/* Do atomic write after all prior operations have completed */
>>>>>> -	smp_store_release(dst, src);
>>>>>> +	mr = qp->resp.mr;
>>>>>> +	value = *(u64 *)payload_addr(pkt);
>>>>>> +	iova = qp->resp.va + qp->resp.offset;
>>>>>>  
>>>>>> -	/* decrease resp.resid to zero */
>>>>>> -	qp->resp.resid -= sizeof(payload);
>>>>>> +#if defined CONFIG_64BIT
>>>>>
>>>>> Shouldn't need a #ifdef here
>>>>
>>>> This avoids a new special error (i.e. NOT_64_bit) and makes it clear we
>>>> won't call the code in mr.
>>>
>>> ? That doesn't seem right
>>
>> that was the -3 of the -1, -2, -3 that we just fixed. there are three error paths out
>> of this state and we need a way to get to them. The #ifdef provides
>> that third path.
> 
> I feel like it should be solvable without this ifdef though
> 
> Jason

You could get rid of the ifdef in the atomic_write_reply() routine but then the rxe_mr_do_atomic_write() routine would have to have a second version in the #else case
that would have to return something different so that the third exit could be taken i.e.
whatever replaces the original -3. I really think this is simpler.

Bob
