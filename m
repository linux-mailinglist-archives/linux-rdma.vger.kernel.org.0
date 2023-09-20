Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 396C97A8FEF
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Sep 2023 01:43:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbjITXnS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 20 Sep 2023 19:43:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjITXnR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 20 Sep 2023 19:43:17 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B637CF
        for <linux-rdma@vger.kernel.org>; Wed, 20 Sep 2023 16:43:08 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id 46e09a7af769-6c46430606bso270525a34.2
        for <linux-rdma@vger.kernel.org>; Wed, 20 Sep 2023 16:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695253387; x=1695858187; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a7VYvH4H5NWDvI9E/tbpBpURTAayW2ojpNSreRQs7T4=;
        b=Nn798mzi/W+oMyDgiHVOXeWE7z3TKP46O1tzi6caSqbWH8pp7nyvil52rfyd2MLSjp
         ZwDwtMKxCuzyAc47dQgUmt+5aUO4FSj8Tze4n8nCQl9b/otUyh1wQcRRdOvik+exdoox
         LYKE/S7/cM/6ugg4ogXbx44JqDzQnHVEtWoZurbNYhD4L8/8JOo64IY/EVQfuVuRu7pM
         qbNWueSPrjW4kuYjNz6XLrxuuJ9zhpmWThYXanrzVcmwTgLpzx2fRsEOG12aDc0T8gwG
         XL/pyW+eI4IdWkNtJg0vDdbG/QCogDv5xFBQ+s62NdJwYftlOZXoO/JFll2BLIRWlBMl
         /kdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695253387; x=1695858187;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a7VYvH4H5NWDvI9E/tbpBpURTAayW2ojpNSreRQs7T4=;
        b=D5wr7ur8HPed/4mvvZ0CrgYZGAjyM8/sOw3rMsVwdpjdSInptkV56j0l1e2siRSyBC
         bAYObqb5kr233c5DDoN+LOs9L4DgabffEF110GJ4U2iP9aXeJLlneR/kHB8qchDHHJGc
         aFwpC8OZgmELHCDBrpDDAhZPGItT226tX1CVqr78STqA67Hdb0f8cCTjGaJ/FZYIz0vn
         PFNVMMKefy6q+cNDAJgI34mGDKsn8ySbxDC+u60SxpGxJWD8PYlZfB6rFnx0EaaU+HsU
         KAMdbMcXNMqXm/CegimYbwFFZ5x7NP43lifX2CpijwsYqHnvN7h58HqWqq0AeGMmi0Tb
         ZC8A==
X-Gm-Message-State: AOJu0YxT81Sh9ZU/k3Uscv6LzvAixjkWTX7BXfb99NYnbFpqaXcpVn6A
        5Eiiz1ifZDfnQUOngB8zFVo=
X-Google-Smtp-Source: AGHT+IHQc1ZBux13AF5Emy5Jg1HkFG4lPe7iRQNPqhNReWxJ5hyVcmGq6XUuTtpF4+qRPxXAp75sfg==
X-Received: by 2002:a9d:7849:0:b0:6b9:9288:613c with SMTP id c9-20020a9d7849000000b006b99288613cmr4121921otm.13.1695253387499;
        Wed, 20 Sep 2023 16:43:07 -0700 (PDT)
Received: from ?IPV6:2603:8081:1405:679b:2790:d0a7:1c4e:2824? (2603-8081-1405-679b-2790-d0a7-1c4e-2824.res6.spectrum.com. [2603:8081:1405:679b:2790:d0a7:1c4e:2824])
        by smtp.gmail.com with ESMTPSA id m5-20020a9d6ac5000000b006b87f593877sm151688otq.37.2023.09.20.16.43.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Sep 2023 16:43:06 -0700 (PDT)
Message-ID: <b0007b56-c986-072f-c75c-ccb23cd001b8@gmail.com>
Date:   Wed, 20 Sep 2023 18:43:05 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: help with performance loss question
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <acaf78ec-9c88-572e-9c65-29606f5a895d@gmail.com>
 <20230920205230.GK13733@nvidia.com>
Content-Language: en-US
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <20230920205230.GK13733@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 9/20/23 15:52, Jason Gunthorpe wrote:
> On Wed, Sep 20, 2023 at 02:54:42PM -0500, Bob Pearson wrote:
>> Jason,
>>
>> I am trying to figure out what caused a big drop in performance in the rxe driver between
>> v6.5-rc5 and v6.5-rc6. The maximum performance for 'ib_send_bw -F -a' in local loopback mode
>> dropped from about 1.9GB/sec to 1.1GB/sec between these two tags. I have also measured the performance
>> of a 6.5 kernel with the 6.4 rxe driver and 6.4 infiniband/core drivers and that also shows the lower
>> performance so it is not something in the rdma subsystem. (In fact there were no changes in the rxe
>> driver from 6.5-rc5 to 6.5-rc6.)
>>
>> If I type 'git log --oneline v6.5-rc6 ^v6.5-rc5' I get about 360 lines but many of them are merge sets
>> that can contain many patches. Is there a way to list all the patches contained between these two
>> tags?
> 
> I recommend you just do a git bisection, it will be more robust and
> 360 patches will not take many steps
> 
> Jason

Thanks, I narrowed it down to the mitigation for the AMD/Inception vuln. that got added in v6.5-rc6.
It's a huge performance hit. I think there is a way to turn it off.

commit fb3bd914b3ec28f5fb697ac55c4846ac2d542855
Author: Borislav Petkov (AMD) <bp@alien8.de>
Date:   Wed Jun 28 11:02:39 2023 +0200

    x86/srso: Add a Speculative RAS Overflow mitigation
    
    Add a mitigation for the speculative return address stack overflow
    vulnerability found on AMD processors.
    
    The mitigation works by ensuring all RET instructions speculate to
    a controlled location, similar to how speculation is controlled in the
    retpoline sequence.  To accomplish this, the __x86_return_thunk forces
    the CPU to mispredict every function return using a 'safe return'
    sequence.
    
    To ensure the safety of this mitigation, the kernel must ensure that the
    safe return sequence is itself free from attacker interference.  In Zen3
    and Zen4, this is accomplished by creating a BTB alias between the
    untraining function srso_untrain_ret_alias() and the safe return
    function srso_safe_ret_alias() which results in evicting a potentially
    poisoned BTB entry and using that safe one for all function returns.
    
    In older Zen1 and Zen2, this is accomplished using a reinterpretation
    technique similar to Retbleed one: srso_untrain_ret() and
    srso_safe_ret().
    
    Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>

Apparently it requires a kernel fix for zen 1/2 but can be fixed with updated microcode
for zen 3/4. Since I am doing dev on a zen 2 (3900X) cpu. I'll replicate the perf testing
on my second system which is a zen 3 box to see if it is better.

Bob


