Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DA1E52D9B9
	for <lists+linux-rdma@lfdr.de>; Thu, 19 May 2022 18:04:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238814AbiESQEZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 19 May 2022 12:04:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241633AbiESQEX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 19 May 2022 12:04:23 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A6245251F
        for <linux-rdma@vger.kernel.org>; Thu, 19 May 2022 09:04:23 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id m6-20020a05683023a600b0060612720715so3822511ots.10
        for <linux-rdma@vger.kernel.org>; Thu, 19 May 2022 09:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=ebM/72GqT49Twlsx60yVNvJOmQ/SpR2sWZUJFB8z/wY=;
        b=I7rTP8HBq7QAIF71LIy0pziLJ/XM10j0u+wNUvC54lRKdJpwrYaOBTyhXzdPbvQaZt
         LH9QrsEtu5v5SQCzb+EyMAKiO1vIDke+4ujgCuUSL4ywO3z8NargpUQOTCOdZMv6Q/jv
         DVboguZ1Uh5kK976hbCAMNsRIFsRSyVL/RndsaDlUIm5iRQmMJE0aciwOllOZj/c4VIB
         mZevButfbcdnWsWOmUNv0tbFyL8u3ZWVSeX+ML9c7XnXYMDygQ15++8wn5knWPElr0YP
         5mHdcnZ66ZFZJ0qcEXp00n67q41ule/JX1g/iozsrlD6XO5mqgUwMoehqkKslq1XrCmJ
         3FQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ebM/72GqT49Twlsx60yVNvJOmQ/SpR2sWZUJFB8z/wY=;
        b=TYzmKKtA9LixDIjNhOt262bWD0pb2au9NSMG+lFmrR+xQ3B2Ve4wz7VVsbzbFL8xDA
         glBJA5SHLIJbPJdU8VJyQFvmZ3XeC3gLD7s+EpEwSpCD4iNv3VlfqU+42UeDgmFv3g3D
         6sxRqSNO2E+o3UXt/VnCfxf4IkXhqNsW4kVwqmUZCYAg1BOl+i8Nf2ZWezvzgAfu7D29
         GtIp3f3l58en1afzSkVqfiOsJYYEM/pjddZbvYZi8vZZvXZuq2fFT2OFD2rje1Ahftob
         1xKfNWR9Q4s9AEsIPeBNvYtip2oo2g1Qo/Vogyx5K+alSW26qcrsk7FU4KM+1i0KLr8m
         2oeA==
X-Gm-Message-State: AOAM5315wTUamyIVwB40t12gHw4YXSKXcz5uP/McITHoIy9ViWhDXATr
        A9CJ0PxatYwfpKhjC6PKc74=
X-Google-Smtp-Source: ABdhPJwxT3amBMWx5M3svK2JhthrPFNwfAVoP+WHhfmpGw2skIs0KtJL0Ns/jGRdAj7hoZ0jS7OeWg==
X-Received: by 2002:a9d:69c9:0:b0:60a:eb25:f6f with SMTP id v9-20020a9d69c9000000b0060aeb250f6fmr458774oto.190.1652976261958;
        Thu, 19 May 2022 09:04:21 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:6c28:37cd:7de6:334c? (2603-8081-140c-1a00-6c28-37cd-7de6-334c.res6.spectrum.com. [2603:8081:140c:1a00:6c28:37cd:7de6:334c])
        by smtp.gmail.com with ESMTPSA id m29-20020a056870059d00b000e99b1909d4sm2516797oap.25.2022.05.19.09.04.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 May 2022 09:04:21 -0700 (PDT)
Message-ID: <72cdd7fd-f796-5731-68f0-eb9daa94a317@gmail.com>
Date:   Thu, 19 May 2022 11:04:21 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: Fwd: Bug in pyverbs for test_qp_ex_rc_bind_mw
Content-Language: en-US
To:     Edward Srouji <edwards@nvidia.com>,
        "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <9c9bbda0-4134-207c-96cb-eb594aab40d4@gmail.com>
 <0793a5bf-e984-94e7-2389-86dfa38729e2@gmail.com>
 <6c64428a-2691-02f6-7c8d-8fe63045c846@fujitsu.com>
 <a2f7aab9-f9d9-f5de-505d-d65021d21c34@nvidia.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <a2f7aab9-f9d9-f5de-505d-d65021d21c34@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 5/19/22 07:22, Edward Srouji wrote:
> 
> On 5/19/2022 6:04 AM, lizhijian@fujitsu.com wrote:
>>
>> On 18/05/2022 11:41, Bob Pearson wrote:
>>>
>>> -------- Forwarded Message --------
>>> Subject: Re: Bug in pyverbs for test_qp_ex_rc_bind_mw
>>> Date: Tue, 17 May 2022 22:41:08 -0500
>>> From: Bob Pearson <rpearsonhpe@gmail.com>
>>> To: Jason Gunthorpe <jgg@nvidia.com>, Zhu Yanjun <zyjzyj2000@gmail.com>, Edward Srouji <edwards@nvidia.com>, Leon Romanovsky <leon@kernel.org>
>>>
>>> On 5/17/22 21:57, Bob Pearson wrote:
>>>> test_qp_ex_rc_bind_mw has an error in that the new_rkey is computed from the old mr rkey and not the old mw rkey.
>>>> The following lines
>>>>
>>>>     mw = MW(server.pd, mw_type=e.IBV_MW_TYPE_2)
>>>>     ...
>>>>     new_rkey = inc_rkey(server.mr.rkey)
>>>>     server.qp.wr_bind_mw(mw, new_rkey, bind_info)
>>>>
>>>> will compute a new rkey with the same index as mr and a key portion that is one larger than mr modulo 256.
>>>> This is passed to wr_bind_mw which expects a parameter with a new key portion of the mw (not the mr).
>>>> The memory windows implementation in rxe generates a random initial rkey for mw and for bind_mw it
>>>> checks that the new 8 bit key is different than the old key. Since the mr and mw are random wrt each other
>>>> we expect that the new key will match the old key approx 1 out of 256 test runs which will cause an error
>>>> which is just what I see.
>>>>
>>>> The correct code should be
>>>>
>>>>     new_key = inc_rkey(<old mw.rkey>)
>>>>
>>>> which will guarantee that it is always different than the previous key. The problem is I can't figure out
>>>> how to compute the rkey from the mw or I would submit a patch.
>>>>
>>>> Bob
>>>>
>>> If in test_qpex.py I type
>>>
>>> print("mw = ", mw)
>>> print("mr = ", self.server.mr)
>>>
>>> I get
>>>
>>> mw = MW:
>>> Rkey        : 12345678
>>> Handle        : 4
>>> MW Type        : IBV_MW_TYPE_2
>>>
>>> mr = MR
>>> lkey        : 432134
>>> rkey        : 432134
>>> length        : 1024
>>> buf        : 9403912345678
>>> handle        : 2
>>>
>>> The difference is the colon ':' after MW and caps.
>> For the difference, just post a RP to make them identical: https://github.com/linux-rdma/rdma-core/pull/1175
> Thanks for the adjustment.
>> Thanks
>> Zhijian
>>
>>> I can refer to mr.rkey as self.server.mr.rkey no problem
>>>
>>> but mw.Rkey doesn't work. Neither does mw.rkey or anything else I have thought of.
> 
> mw.rkey should work... I noticed that you've already figured that out and sent a patch.

I can't believe I didn't try that. It was 1 AM and I was tired. A nights sleep resolved the
issue and reading the pyx code.

Bob
> 
> We expose the MW rkey in pyverbs (within the cython code).
> If you still have an issue with it please let me know.
> 
>>>
>>> I hate python. Just hate it.
> Don't hate the game, hate the player :) (in this case).
>>> Bob

