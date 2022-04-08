Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A1CA4F9DB3
	for <lists+linux-rdma@lfdr.de>; Fri,  8 Apr 2022 21:34:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232406AbiDHTgH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 8 Apr 2022 15:36:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiDHTgG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 8 Apr 2022 15:36:06 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 988D276281
        for <linux-rdma@vger.kernel.org>; Fri,  8 Apr 2022 12:34:02 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-d6ca46da48so10732133fac.12
        for <linux-rdma@vger.kernel.org>; Fri, 08 Apr 2022 12:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=OLFMjIx6nSB/Wjvbs8ePmU512sccFbZHvLXZl3OD/qQ=;
        b=h8izV6Te/96ZqtejADXNFLpDaTYCm9oaqOlkr4OoGcBkg67HKX3Viupi0Q2MLIIQWQ
         2r6Dc6/USWF8GlKqPpP1xCFITc/PLygAGVClXzKyJ2gIBGolR60pAfBbMpvwsSdAbEVb
         cs11QMsOiPeFQr6wBh0QSQMWKChETLcriDMKo8v0Lvu8OFok86X6Ox02xxbBZjFj9mMH
         MMaAVHejA8aBmKwK5IIg5Shh7JqqqrkFUgG3FQDRw1/fq944PsX0Ix5uzBa/TaGc9uNI
         o34MoQqu8YtbmjXX563IiUTisXLDli4sGWvOEuGfWZFbtPksSm+5o6JPIGkfI9XSufKx
         y/Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=OLFMjIx6nSB/Wjvbs8ePmU512sccFbZHvLXZl3OD/qQ=;
        b=3eCxc78Yy1t+0C/O9N2sZRs9Yu/MR8o/UOlMq+1SNMaEqkUS47JcxhF5gMuDrsxiWt
         CLN3QTGdUnPVEJfOWsH/CLcZIInJQ9KRjHrCdA6a90Jbrr38e/A1eXHRNVxm/Hv+WiZV
         AzRY5I0l3VI7wA3JKkOO3MOxbTO9si5SOw5qXZIXGgO4NaoFQsOWabZI0xWxx4KdpLoY
         pNLIWgvaVwPmVvQRbxjcXmQLjuzuQpC2c5ihcGzrZZhpV6o0Vo2VFFo6K8uMBd/pytEP
         eVEQ1EXHnwNiDe/lPDLtrmo5cVurD2QVwxvjcew0FzbU4OOBtbyXXmVyvKq9BloeodSR
         p91w==
X-Gm-Message-State: AOAM531Wk4hK35ttuqHB8YiXb9IUL8NBnrbCY3mUBWYrk8xiryJb5Ix3
        SRS22bavXsW9YH51JcyxsueR5Lr7614=
X-Google-Smtp-Source: ABdhPJyhggc3zxVldLqFYH6IIJEwCKlRPWxDTNhFuB60QB/C3aJcNMDUQNgDlkZG7WsRt35SKSRgqw==
X-Received: by 2002:a05:6870:559b:b0:df:b72:d66f with SMTP id n27-20020a056870559b00b000df0b72d66fmr9256071oao.122.1649446441883;
        Fri, 08 Apr 2022 12:34:01 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:d36a:c09a:7579:af8a? (2603-8081-140c-1a00-d36a-c09a-7579-af8a.res6.spectrum.com. [2603:8081:140c:1a00:d36a:c09a:7579:af8a])
        by smtp.gmail.com with ESMTPSA id r129-20020acac187000000b002ef358c6e0esm8902148oif.49.2022.04.08.12.34.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Apr 2022 12:34:01 -0700 (PDT)
Message-ID: <5295c51f-91a3-c9a4-2811-03f13c71205e@gmail.com>
Date:   Fri, 8 Apr 2022 14:34:00 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] RDMA/rxe: Generate a completion for unsupported/invalid
 opcode
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>, Xiao Yang <yangx.jy@fujitsu.com>
Cc:     leon@kernel.org, linux-rdma@vger.kernel.org
References: <20220408033029.4789-1-yangx.jy@fujitsu.com>
 <20220408182617.GA3648486@nvidia.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <20220408182617.GA3648486@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 4/8/22 13:26, Jason Gunthorpe wrote:
> On Fri, Apr 08, 2022 at 11:30:29AM +0800, Xiao Yang wrote:
>> Current rxe_requester() doesn't generate a completion when processing an
>> unsupported/invalid opcode. If rxe driver doesn't support a new opcode
>> (e.g. RDMA Atomic Write) and RDMA library supports it, an application
>> using the new opcode can reproduce this issue. Fix the issue by calling
>> "goto err;".
>>
>> Signed-off-by: Xiao Yang <yangx.jy@fujitsu.com>
>> ---
>>  drivers/infiniband/sw/rxe/rxe_req.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Fixes line?
> 
> Jason

That would be 

Fixes: 8700e3e7c485 ("Soft RoCE (RXE) - The software RoCE driver")


Been there forever.
