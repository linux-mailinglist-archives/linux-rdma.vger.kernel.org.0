Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30F2D4F8B54
	for <lists+linux-rdma@lfdr.de>; Fri,  8 Apr 2022 02:56:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232099AbiDGWgg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 7 Apr 2022 18:36:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232101AbiDGWgf (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 7 Apr 2022 18:36:35 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13A0C1162A7
        for <linux-rdma@vger.kernel.org>; Thu,  7 Apr 2022 15:34:34 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-df22f50e0cso7972192fac.3
        for <linux-rdma@vger.kernel.org>; Thu, 07 Apr 2022 15:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=2y586udpZvmHC8VfBcH0I1Y9/JePDA39QoshaPptwEQ=;
        b=b6rgmN9aktRfXoZojqNhDSqTkRpfAIJ7a82vc5obakVQhADVEj68840+HG8p5jutdu
         3gyP+4BQqS7qpDm6mngF9b/rmv/9bOINLLYCALlcgidk0ja0lAJlBI2Xp6E/nRxLhV/A
         o+BqGXyEZECCD7pqrv0I0JVsbaDTNq07nQaVe/vrU7AaOT9KJmpA0kLnkS7s9l7nnJXU
         cooD6io6fBWYEqLdZWut0N4FyZL3qLBCYxbaIyp+olbQ1VfmJP6ebrXb6d2Ou51Vb3ex
         FqzE102Eq8Dbu80uVsm+4jcPBOtZ64n60ORQRsk2Cm5oRHKL/v4xMBa/UK69lWCAwOJq
         xbUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=2y586udpZvmHC8VfBcH0I1Y9/JePDA39QoshaPptwEQ=;
        b=SmYdr0EqDn3C6hnuOIAeeQbl4Z1sASivXU1XFY7xegwN+QP0vLec/Eg7p0ZKI6wUhq
         zitHbTdrWdl5Q/co7bOXRMWBqkWeaZgh58MVbcTucWGZbXgb6v9vgMblfpF73t6IlqsP
         5jOrOOLxw4wDGhgUxZetJtHJml/U12Gl0Hyc93f8ZqUeaS4lGKd5XzKrxcbdFO/hdySQ
         W6SeeBI1Fi4OuOMx59N80I1ZyhuicziOUcMhncDgsXAnRWXwnTU1tP8QyebfzS3rM4cS
         Ugm9kWIOnSXocjuhhqUfeOXbB0ciY53BVGJknjNU8MJzaH7pnh2W73HgNKYObyDUw9dn
         BQdA==
X-Gm-Message-State: AOAM5333/c3+zwjKwDthuKHS60KmBpUjZeSwZOvxr1CX+ubn8p2DZfiF
        XkYxE9VNEv8auSTvkD5ZjwHVtis2L8Q=
X-Google-Smtp-Source: ABdhPJxJcG3JMTX+SFH3O5L6+WJjuP20F8t25dObFH5ymrsEe9Rzla+MGE60XT0qlotFJQhyQPoYow==
X-Received: by 2002:a05:6870:1244:b0:ce:c0c9:620 with SMTP id 4-20020a056870124400b000cec0c90620mr7364949oao.114.1649370873442;
        Thu, 07 Apr 2022 15:34:33 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:203d:1c92:96e5:569a? (2603-8081-140c-1a00-203d-1c92-96e5-569a.res6.spectrum.com. [2603:8081:140c:1a00:203d:1c92:96e5:569a])
        by smtp.gmail.com with ESMTPSA id f21-20020a056830205500b005cdb59d5d34sm8291762otp.81.2022.04.07.15.34.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Apr 2022 15:34:32 -0700 (PDT)
Message-ID: <92181dc8-dadc-3df6-3ecc-e2dca9047be4@gmail.com>
Date:   Thu, 7 Apr 2022 17:34:32 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [bug report] rdma_rxe: WARNING: inconsistent lock state,
 inconsistent {SOFTIRQ-ON-W} -> {IN-SOFTIRQ-W} usage
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     RDMA mailing list <linux-rdma@vger.kernel.org>,
        Yi Zhang <yi.zhang@redhat.com>
References: <CAHj4cs-MT13RiEsWXUAcX_H5jEtjsebuZgSeUcfptNVuELgjYQ@mail.gmail.com>
 <1c16f053-0183-8343-9b36-62027c7260a8@acm.org>
 <CAFc_bgZ5oYtK2doybVT5fhrU+Ut-RfPT+g2z1bbf9V3jTtRTUg@mail.gmail.com>
 <d80141c8-04ee-e6ed-34d8-5cf43b49fd55@acm.org>
 <ca8722e6-db2d-0ab1-b8af-0932017df23e@gmail.com>
 <f7b84702-8001-70bf-2f26-704548b96279@acm.org>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <f7b84702-8001-70bf-2f26-704548b96279@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 4/7/22 16:44, Bart Van Assche wrote:
> On 4/7/22 14:06, Bob Pearson wrote:
>> On 4/7/22 14:49, Bart Van Assche wrote:
>>> On 4/7/22 12:15, Robert Pearson wrote:
>>>> I would say it is very possible. There was a period when the
>>>> pool locks were switched to _bh spinlocks but that was later
>>>> reversed back to _irqsave locks which cleaned up some failures. I
>>>> don't know which version Yi Zhang was using. The root cause of
>>>> this bug was caused by librdmacm making verbs API calls while
>>>> holding _irqsave locks which I didn't figure out until later.
>>>
>>> I can reproduce the issue Yi reported with kernel v5.18-rc1. Please
>>> let me know if you need any additional information to reproduce
>>> this issue.
>>
>> From your note I can't figure out what you are running. Can you give
>> me more details about the failing test case?
> 
> Hi Bob,
> 
> In Yi's email I found the following:
> 
> run blktests srp/001
> 
> That test case can be run as follows:
> 
> git clone https://github.com/osandov/blktests && cd blktests && make && sudo ./check -q srp/001
> 
> Thanks,
> 
> Bart.
> 

It looks like on 5.18-rc1+ blktest is not running for me. (Last time I ran it was pre 5.18)
I am not seeing the Warning but instead it just hangs? Are you enabling some lock checking
that I am not? If so how?

Bob
