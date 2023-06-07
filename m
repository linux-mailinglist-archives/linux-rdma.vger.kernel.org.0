Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AC5A726364
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Jun 2023 16:54:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239415AbjFGOyc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 7 Jun 2023 10:54:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235393AbjFGOy3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 7 Jun 2023 10:54:29 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D02C71734
        for <linux-rdma@vger.kernel.org>; Wed,  7 Jun 2023 07:54:27 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id 46e09a7af769-6b2a4655352so377027a34.3
        for <linux-rdma@vger.kernel.org>; Wed, 07 Jun 2023 07:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686149666; x=1688741666;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Khpb2dpEq2oEthSRf1UlV6stlVnTZ53f+DWKnAnO/bg=;
        b=MIsoXG/UeTD187uR18W2+EMg0Yh0rC/UJFKgtz3lz14HszFMSj7PiMlagfq6bUXeqr
         twD1EIYf4+2UtLXnDP4kAZ6Xm7kOQJCbYjewE42yrsG8jGdh1ZuXx5QO2hkEKeo2y0z2
         l0HoqdGpDI1u17OBDEPTxGm+vLq60bbEuNknB53vPjDMu1P7IyEW5yKHQeLjmV9gr0NJ
         JlCDdORlD9P13oVP8gTymr/AArOqMPT0RTR5oTPkcsRdW+IJM0DIpSMXFoY8q8okwgU4
         bmq2j+VZU6e4hc4hgL7oLIOrIxRUdQZNnMKs/ZQx4ot5gWMrv/hfBlDDmKcBGof/K8wT
         u2iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686149666; x=1688741666;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Khpb2dpEq2oEthSRf1UlV6stlVnTZ53f+DWKnAnO/bg=;
        b=WtqUQkRC1Ht+b+yB+zUXISl2Ckn76+wtbYxiWVzwkae8ICBhXvMFFBM9R1qjtCqqkk
         4qS020DJc/RImHPfJzylCQzpg0N1LX9DShoC5kXP+2NwpXf+psXxJ8+49WD1B0/Ylk0I
         3TAYkcak767BloIs2mGQ2UFpeZTxFRvHGZar0sBnNdqi5gb33pamlveAOM/Ygd73MEpP
         8ufBrGbmIHIro2V83GaqZPNPjjXJDoCaqlVszNhdatuWAa3l7aR3XIzj/AxMU4qyCj4T
         4g6DFHfWw6TGcK9m6dDgp8aFHwvlfX+MNBgFtmVGzGukMwvGYUhwjasNVxQt4uqrEnW5
         pmqw==
X-Gm-Message-State: AC+VfDwDYHRQFOSDlBHhz84srBMSSaEx4FnjoMep4gg4X2rmxLfRP399
        imcU1rLiIrlM9VSMjttM6mo=
X-Google-Smtp-Source: ACHHUZ4EyRa2KcNU2TS7MCzb2Iwk41PR2pi+5Sy/7NDll710fpUf7mvwx5qx+kWfWVCp1t3B8tPHVA==
X-Received: by 2002:a05:6830:1312:b0:6ac:a677:9dff with SMTP id p18-20020a056830131200b006aca6779dffmr3421011otq.4.1686149666060;
        Wed, 07 Jun 2023 07:54:26 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:29d3:a3c9:1600:226c? (2603-8081-140c-1a00-29d3-a3c9-1600-226c.res6.spectrum.com. [2603:8081:140c:1a00:29d3:a3c9:1600:226c])
        by smtp.gmail.com with ESMTPSA id i5-20020a9d68c5000000b006b1ea725c07sm2791087oto.59.2023.06.07.07.54.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jun 2023 07:54:25 -0700 (PDT)
Message-ID: <5a3518e5-e809-ffe1-32f8-d9f854b3419c@gmail.com>
Date:   Wed, 7 Jun 2023 09:54:24 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: IB_POLL_DIRECT
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        Bart Van Assche <bvanassche@acm.org>
References: <ed01bad5-b63b-855c-b2da-d98718fa2b4d@gmail.com>
 <ZH/NkL//qx/oz6kZ@nvidia.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <ZH/NkL//qx/oz6kZ@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 6/6/23 19:21, Jason Gunthorpe wrote:
> On Tue, Jun 06, 2023 at 03:54:25PM -0500, Bob Pearson wrote:
>> AFAIK the poll workqueue and poll softirq cqs are working correctly but the poll direct cq sometimes
>> loses the thread and just stops processing those cqs. The test cases sometimes recover after about
>> a 2 second delay and start processing again and eventually fail after about a 10 second delay and
>> cleanup and go home.
> 
> This sort of sounds like a race with re-arming?
>  
>> The failures feel like a race or at least are timing sensitive. If you run the test suite several times
>> various test cases will sometimes succeed and sometimes fail. But they always fail in the same way.
>>
>> Looking at the mlxn drivers for inspiration, I don't see anything specific about IB_POLL_DIRECT except
>> that they have a private version of send_queue_drain which also calls a cqe drain function which calls
>> ib_process_cq_direct() in a loop until the cq is drained. But this is only during qp tear down. (No other
>> verbs driver does this but as far as I know no other driver is passing blktests.) This is only done for
>> IB_POLL_DIRECT, so I wonder, is this required to use that correctly?
>>
>> I am still figuring out how IB_POLL_DIRECT works. It doesn't allow the driver to call cq->comp_handler so
>> I don't know how it figures out when there are new wcs to process.
> 
> IIRC POLL_DIRECT means you don't get completion interrutps and instead
> the ULP has to occasionally call ib_process_cq_direct() which will
> pull out the CQEs.
> 
> So you should look at how ib_process_cq_direct() is being called in
> srp and presumably something about that logic is not calling it..
> 
> It kind of looks like SRP is using it to reap send completions when
> the send queue progresses, so maybe your issue is that the sendq is
> getting stuck?
> 
> Jason

Jason,

This was a helpful. I had counted the total number of posts and polls from all the CQs
and there were differences throughout the run. I fixed some unprotected code that changed the
notify state of the CQs with a spinlock and then the totals added up in balance at the end of
the run but still had a lot more posts than polls at the delay points. Then I replaced the
CQs in the srp driver with IB_POLL_WORKQUEUE instead of IB_POLL_DIRECT and then the posts and
polls stayed on track the whole time but there were still big delays and the test failed.

This is consistent with the suggestion you made above with sporadic calls to ib_process_cq_direct()
causing the differences. So at the end of the day the problem seems to be elsewhere and the delays are
caused by some other problem.

I'll keep chasing it.

Thanks,

Bob
