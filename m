Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42DD37E2AF7
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Nov 2023 18:31:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbjKFRb3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 Nov 2023 12:31:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbjKFRbW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 6 Nov 2023 12:31:22 -0500
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 785C2D49
        for <linux-rdma@vger.kernel.org>; Mon,  6 Nov 2023 09:31:19 -0800 (PST)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-1f0656b5c99so1916533fac.1
        for <linux-rdma@vger.kernel.org>; Mon, 06 Nov 2023 09:31:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699291878; x=1699896678; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UFrrLVOF3oVBTcWKlMt8kRb80b+xqpX+FbLSt/FwHXQ=;
        b=VYqCJi5JjL9MSDrIv8Y2S124mOhxnoSc7RXY2Zt9oPBQ98z+oV2kki24+KAUbxw/rk
         iQQtDt3p+KZN4y8LSKBc+/U7Nao7KyZVAFRIqIxQWKB/ccJLWcAP1Fawwmoyw7mrgENZ
         8wuXCCT2cwFgqV2KO24qjoq0dor3acpxt1hjftj62pLfKxZGNZabVCMn3zxu2Xy2n+1W
         rpJDco0n5s5S58tRjA/V/1w14R5F4nGBckE5PllIwUb65dENEt42fnwyAIyqy7ulrW5O
         Byb5VYe0XdzO0kBvGmXB9ynR79d/VSerZPC6CW/qohhgEK0PcOb6cllfx3NRR9OAwpi3
         qpyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699291878; x=1699896678;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UFrrLVOF3oVBTcWKlMt8kRb80b+xqpX+FbLSt/FwHXQ=;
        b=dxu53PYO0ov+8d4C7+tYrxIYdAwW7zyD+o2+SPGHDLTFC8Eviym0CBaQphHekF8vqV
         rSzCTLCB0XLFR5J0gyk4cr3e5cU8QSZNWO3CYcqNdIo42egsPAZ3jl/o+wnCIN3w25D3
         wWY0vfdN/Mg2yUmmJT//zAeTp1wMEgQ3Auhb41pta3hSzzP4sYdRQJ3GKUCUy+AsiCsh
         6NbuOeHKl5P9XPhkeBsVX8B6AzGpIgk424uID3CX3sDw8TV83/i9+S/QcwOr4d6am8Lg
         YAJC2tChe8wnCYqUC5N7L8pKCrgvnDvgzwSs2j0OqQsTP0OU/zQDyZxYUWElqXrgABYv
         QuDA==
X-Gm-Message-State: AOJu0YyQMMLgGmeoZTtkysJ++dzl1db+EcdCHfVZBvoYD2JyHhD5NPxm
        J1f+Lwm4aa4ohkoikPS1w9Q=
X-Google-Smtp-Source: AGHT+IGHZgep0Wi0dV6SgMq6En8nIZ0bft4hKCoSaYZjtquhORtLYPlN+V5ZcT5E3Jsi1ZSvNvRRfA==
X-Received: by 2002:a05:6870:a70c:b0:1e9:7caa:896 with SMTP id g12-20020a056870a70c00b001e97caa0896mr87792oam.13.1699291878565;
        Mon, 06 Nov 2023 09:31:18 -0800 (PST)
Received: from ?IPV6:2603:8081:1405:679b:7d5a:f32b:d7fe:f16c? (2603-8081-1405-679b-7d5a-f32b-d7fe-f16c.res6.spectrum.com. [2603:8081:1405:679b:7d5a:f32b:d7fe:f16c])
        by smtp.gmail.com with ESMTPSA id r9-20020a056870e98900b001e988bf0ab0sm1477118oao.3.2023.11.06.09.31.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Nov 2023 09:31:18 -0800 (PST)
Message-ID: <9759a166-b302-46c0-9277-058152af45ef@gmail.com>
Date:   Mon, 6 Nov 2023 11:31:17 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-next 3/6] RDMA/rxe: Register IP mcast address
Content-Language: en-US
To:     Zhu Yanjun <yanjun.zhu@linux.dev>, jgg@nvidia.com,
        linux-rdma@vger.kernel.org
References: <20231103204324.9606-1-rpearsonhpe@gmail.com>
 <20231103204324.9606-4-rpearsonhpe@gmail.com>
 <30513a47-68c6-410f-bbfb-09211f07b082@linux.dev>
 <a0b998f6-7c03-466e-b163-3317f7a5576c@gmail.com>
 <0f190158-d39f-45b0-be07-73977bfb40b7@linux.dev>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <0f190158-d39f-45b0-be07-73977bfb40b7@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 11/6/23 07:26, Zhu Yanjun wrote:
> 
> 在 2023/11/6 4:19, Bob Pearson 写道:
>>
>>
>> On 11/4/23 07:42, Zhu Yanjun wrote:
>>
>>>
>>> Using reverse fir tree, a.k.a. reverse Christmas tree or reverse XMAS 
>>> tree, for
>>>
>>> variable declarations isn't strictly required, though it is still 
>>> preferred.
>>>
>>> Zhu Yanjun
>>>
>>>
>> Yeah. I usually follow that style for new code (except if there are
>> dependencies) but mostly add new variables at the end of the list
>> together  because it makes the patch simpler to read. At least it
>> does for me. If you care, I am happy to fix this.
> 
> Yes. It is good to fix it.
> 
> And your commits add mcast address supports. And I think you
> 
> should have the test case in the rdma-core to verify these commits.
> 
> Can you share the test case in the rdma maillist? ^_^
> 
> Zhu Yanjun
> 
>>
>> Bob

I could share it but it's not really in a good shape to publish. I
have to modify the limits in rxe_param.h to test max_etc. And currently
I need to hand edit the send/recv versions to do node to node. In other
words just enough to (by hand) work through the use cases enough to
convince myself it works using ip maddr and wireshark along with the
program.

What you are asking for is a bunch of work to make the test program
more like iperf or ib_send_bw. Ideally it should either reload the
driver or do something else to let each test case be a clean start.

In an ideal world there would be a two node version of pyverbs. :-)

Bob
