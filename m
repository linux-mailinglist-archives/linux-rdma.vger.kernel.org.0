Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C797525774
	for <lists+linux-rdma@lfdr.de>; Thu, 12 May 2022 23:57:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358927AbiELV5X (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 12 May 2022 17:57:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355633AbiELV5Q (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 12 May 2022 17:57:16 -0400
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1345D483A5
        for <linux-rdma@vger.kernel.org>; Thu, 12 May 2022 14:57:14 -0700 (PDT)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-edf3b6b0f2so8342817fac.9
        for <linux-rdma@vger.kernel.org>; Thu, 12 May 2022 14:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=/r8yUvgSlY893JhVfM0xJr4Pw/JfAJ2TlpTyMXVoVCg=;
        b=Mj3rM0uaug48Hdfd9ySM1pw58o+F0SrdabCZICGYuoBiXKCQoo//292ngZW6rpjsI5
         QZOcYFg4WpuO6bszN2dPVuktUm6DjJaiJA5Ygb2ZwR48J0zdLmpfhR1cM706tZPTsXUy
         bdtLkHE1dXjfKtUIvLCz492E/dHSdqtxYex2YZ4+UPKSb7XgViZAG5ehUru0+0RvD0Yn
         PxfQJah1q0GbaK1ru6KC/czuYIoXvmVvvtekYhMmlqxlagGzDt3t+LmrIbZvGMLvM2FO
         OL7lzO7vHhruGwUG0zZ0tCb6Nhdnjuo2igtlhBP/McHujl8s+gPEY3lOqdbJlw8MoEqW
         NwCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=/r8yUvgSlY893JhVfM0xJr4Pw/JfAJ2TlpTyMXVoVCg=;
        b=Yaa8DINoe53fpQIsKdLJO4nOPHeDcYeP0Q3mlHI0ZDqtA3bJRDV8sdEKOwkgiG01rm
         4PovoGAYJiJkqTdEXm8NDtO+IuYpQGJgjB3OWHQH9TX+D59kWvu1cWPakNRx/IU9lama
         Zw6yISaqyfPu+TslMLzNVhq/LsS08/rlOcCGiGpkfhbft3ryteXqm1Hdk8v/T8z5V06k
         u84ldCmlJluSNMTJhzR/6JcqC7HQaVUkXehW+LetAtvwxdjYVEaZUxJezxbTMx9ErSlB
         e2/jgB9nRwDZ7MmkYVWjvS2I9JSJjA3/+RlUB+qh2Xc3PlkheKXa0wlTlsEKsnpVdMtQ
         iDvg==
X-Gm-Message-State: AOAM5315JKqbVz8rGbIb/92iJ/wZYq4GB6r4DiFBWldgPhUfL3NIjl/P
        /vUE0u4yGl2fTV1wIJ3Nva8=
X-Google-Smtp-Source: ABdhPJykEGHH8Rf4qVKBkaq8XydCR5xOUxi8DRLJVN93STVsguKr9rv4GRYU9CYSvUNFyHOQAH8iUA==
X-Received: by 2002:a05:6870:a70a:b0:d9:aea4:a62 with SMTP id g10-20020a056870a70a00b000d9aea40a62mr6711913oam.143.1652392633454;
        Thu, 12 May 2022 14:57:13 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:7f98:64fc:d1b4:c63a? (2603-8081-140c-1a00-7f98-64fc-d1b4-c63a.res6.spectrum.com. [2603:8081:140c:1a00:7f98:64fc:d1b4:c63a])
        by smtp.gmail.com with ESMTPSA id z5-20020a056870514500b000e686d13887sm248879oak.33.2022.05.12.14.57.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 May 2022 14:57:12 -0700 (PDT)
Message-ID: <b2908c39-636a-1cba-db22-838640385d84@gmail.com>
Date:   Thu, 12 May 2022 16:57:11 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: Apparent regression in blktests since 5.18-rc1+
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>,
        Yanjun Zhu <yanjun.zhu@linux.dev>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Zhu Yanjun <zyjzyj2000@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Bernard Metzler <bmt@zurich.ibm.com>
References: <e7c31ebb-60c0-cd57-2009-5e9383ecc472@gmail.com>
 <cf8b9980-3965-a4f6-07e0-d4b25755b0db@acm.org>
 <4b0153c7-a8e9-98de-26ae-d421434a116d@linux.dev>
 <20220507012952.GH49344@nvidia.com>
 <81571bbb-c5d2-9b68-765d-f004eb7ba6fd@linux.dev>
 <43c2fed8-699f-19fe-81fa-c5f5b4af646f@gmail.com>
 <4c3439c3-6279-804f-63b2-99d8529e5d3d@acm.org>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <4c3439c3-6279-804f-63b2-99d8529e5d3d@acm.org>
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

On 5/7/22 23:13, Bart Van Assche wrote:
> On 5/7/22 06:43, Bob Pearson wrote:
>> The hang I was showing was for siw not rxe. rxe also shows similar hangs on my system.
>> The siw run was vanilla rdma-linux without any patches.
> 
> Hi Bob,
> 
> If I run the SRP tests against the rdma for-next branch then I can reproduce the hang mentioned in a previous email.
> 
> If I merge Linus' master branch into the rdma for-next branch then the SRP tests pass with the Soft-iWARP driver and also with the soft-RoCE driver.
> 
> I think this shows that the root cause of the hang is in the rdma for-next branch and not in the SRP tests. Maybe a patch from the master branch is missing from the rdma for-next branch?
> 
> Thanks,
> 
> Bart.

I am trying to reproduce your result. What version of Linus' tree did you use?
rdma for-next is 5.18-rc1+
rdma for-rc is 5.18-rc6 (as of earlier today) which is an official tag. Not sure if there is an advanced one from that.

Bob
 
