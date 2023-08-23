Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02708785D22
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Aug 2023 18:19:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237517AbjHWQTT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 23 Aug 2023 12:19:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237513AbjHWQTS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 23 Aug 2023 12:19:18 -0400
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B536E7F;
        Wed, 23 Aug 2023 09:19:15 -0700 (PDT)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-1c4b4c40281so3618603fac.1;
        Wed, 23 Aug 2023 09:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692807555; x=1693412355;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gGAxAmWrKS9Xwi8s1FfhyzMjJ6aJUXMBgQRbaSFIeM0=;
        b=Tb9MBQgTkfDShQBc11U9uqkT7ASLLa3oQpX9xh5/aWgnQYWTkz6I5r65ZbFpdwf10m
         A5x92zxDYSoqkwp8gZnAUBH2kT88BWUeuM3+O5/L4ZN5zguKtJxFkZLUa4j4u3qPBvmW
         PWTrA1PLwIJ9FW0ELzXaRW2kCfxmsPegRn4ZNqweBL2rpjtJVM6h/28vLRmR8OP8ziVk
         qTXTlrne2oxE4V+pU0AInKp/DNxXtPsN4doiLB2PkV7zzRqbIqHHt0AUCDf6+LF507Wy
         bvMK40J4lKmwJuMlyz7P3/UGwWUylHqnIWqmZpxxTkrrDHek+Ue4iFY1b/OGjLuQEe0w
         ESGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692807555; x=1693412355;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gGAxAmWrKS9Xwi8s1FfhyzMjJ6aJUXMBgQRbaSFIeM0=;
        b=FdD4wuTwq0JYrYevNLbaS6wfVlTLRUug/letrRB+oFuNizlD2ym3vxb8JFroy0sarX
         OwDOvMjo9mLwM/6ZWDXkEBWl5HCuewZe+WFbYxuMoIkg3NAHY7IZKF4V/gGuSjJstlVr
         W5RKPqbghrfGI8fYQtTpaW1lawvajwU24aeFlEEKbqfCZnEq5ke/vt1Bd/Oe885DUYQd
         BXphLbV5cuxzc4pSPekgGEVlEhXHsvBikAYEMRMxtQK53GdyMK2Y1k06uW7PONaF7NgW
         W/H1uH+eSPRs+8TknbtZ7lYOn7oM7JZwYKXz61Ja28RvOj8vE5fuT75+uMBQyGgpQQ0V
         W2eA==
X-Gm-Message-State: AOJu0YxkZyANod8v+05at462AOc7nkSAIc13jAdczTQzfUtklkLczsKi
        EDD81CIqSu47ktl63WyEHD8=
X-Google-Smtp-Source: AGHT+IHqEYTDBdKEA4sZnnUWz+fx86MDmHH9uwXOKHGv9dC8V+D+P8mWiP3raxWefmZdt5pPKt/Ndg==
X-Received: by 2002:a05:6870:d620:b0:1bf:42a8:2cd2 with SMTP id a32-20020a056870d62000b001bf42a82cd2mr7816641oaq.25.1692807554658;
        Wed, 23 Aug 2023 09:19:14 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:3212:6dcf:4ab0:e410? (2603-8081-140c-1a00-3212-6dcf-4ab0-e410.res6.spectrum.com. [2603:8081:140c:1a00:3212:6dcf:4ab0:e410])
        by smtp.gmail.com with ESMTPSA id q23-20020a056830019700b006b8ad42654csm5764023ota.0.2023.08.23.09.19.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Aug 2023 09:19:14 -0700 (PDT)
Message-ID: <27e31e00-74a3-6209-5ad5-1783d6e67a0d@gmail.com>
Date:   Wed, 23 Aug 2023 11:19:13 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [bug report] blktests srp/002 hang
To:     Bart Van Assche <bvanassche@acm.org>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
References: <dsg6rd66tyiei32zaxs6ddv5ebefr5vtxjwz6d2ewqrcwisogl@ge7jzan7dg5u>
 <0c5c732c-283c-b29a-0ac2-c32211fc7e17@gmail.com>
 <yewvcfcketee5qduraajra2g37t2mpxdlmj7aqny3umf7mkavk@wsm5forumsou>
 <8be8f611-e413-9584-7c2e-2c1abf4147be@acm.org>
Content-Language: en-US
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <8be8f611-e413-9584-7c2e-2c1abf4147be@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 8/22/23 10:20, Bart Van Assche wrote:
> On 8/22/23 03:18, Shinichiro Kawasaki wrote:
>> CC+: Bart,
>>
>> On Aug 21, 2023 / 20:46, Bob Pearson wrote:
>> [...]
>>> Shinichiro,
>>
>> Hello Bob, thanks for the response.
>>
>>>
>>> I have been aware for a long time that there is a problem with blktests/srp. I see hangs in
>>> 002 and 011 fairly often.
>>
>> I repeated the test case srp/011, and observed it hangs. This hang at srp/011
>> also can be recreated in stable manner. I reverted the commit 9b4b7c1f9f54
>> then observed the srp/011 hang disappeared. So, I guess these two hangs have
>> same root cause.
>>
>>> I have not been able to figure out the root cause but suspect that
>>> there is a timing issue in the srp drivers which cannot handle the slowness of the software
>>> RoCE implemtation. If you can give me any clues about what you are seeing I am happy to help
>>> try to figure this out.
>>
>> Thanks for sharing your thoughts. I myself do not have srp driver knowledge, and
>> not sure what clue I should provide. If you have any idea of the action I can
>> take, please let me know.
> 
> Hi Shinichiro and Bob,
> 
> When I initially developed the SRP tests these were working reliably in
> combination with the rdma_rxe driver. Since 2017 I frequently see issues when
> running the SRP tests on top of the rdma_rxe driver, issues that I do not see
> if I run the SRP tests on top of the soft-iWARP driver (siw). How about
> changing the default for the SRP tests from rdma_rxe to siw and to let the
> RDMA community resolve the rdma_rxe issues?
> 
> Thanks,
> 
> Bart.
> 

Bart,

I have also seen the same hangs in siw. Not as frequently but the same symptoms.
About every month or so I take another run at trying to find and fix this bug but
I have not succeeded yet. I haven't seen anything that looks like bad behavior from 
the rxe side but that doesn't prove anything. I also saw these hangs on my system
before the WQ patch went in if my memory serves. Out main application for this
driver at HPE is Lustre which is a little different than SRP but uses the same
general approach with fast MRs. Currently we are finding the driver to be quite stable
even under very heavy stress.

I would be happy to collaborate with someone (you?) who knows the SRP side well to resolve
this hang. I think that is the quickest way to fix this. I have no idea what SRP is waiting for.

Best regards,

Bob 
