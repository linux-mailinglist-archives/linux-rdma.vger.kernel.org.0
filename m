Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D7F34B3214
	for <lists+linux-rdma@lfdr.de>; Sat, 12 Feb 2022 01:38:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354446AbiBLAiD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 11 Feb 2022 19:38:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354444AbiBLAhy (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 11 Feb 2022 19:37:54 -0500
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66F6FD6
        for <linux-rdma@vger.kernel.org>; Fri, 11 Feb 2022 16:37:52 -0800 (PST)
Received: by mail-oo1-xc33.google.com with SMTP id v17-20020a4ac911000000b002eac41bb3f4so12222186ooq.10
        for <linux-rdma@vger.kernel.org>; Fri, 11 Feb 2022 16:37:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=kukJwsLtjJ3Uky7DWUIA8ZXSyJ0Cky2ROkNkXYg1gY0=;
        b=hzQjjRQOYUVvd5dxWGkpvxq3bMkvjaK2welO00ZWlR+RB4WjRx63h4emsAHNgywVWt
         4Xy67WO0BvAlh0FFlZiw1/zRvHLWrmGwrB2K6drL1vqNA2YHmgwJOMMcO98kQnQj1MCM
         kaxjl4y2W3gZ/nR7OyAB4PeBwgeINs5jeKiwdVbkpV2/4HfHnGPtrpXpz/W1lBJ2+YWu
         4/SFVKAs1+8HVRTS2saT+uZpHiid1YCB/O1dJXYd62eQH+4gH7FgKmoI8iA30ZVoYJXT
         UakICvhVYw0jDqEilTq8jQpiZViAAv6ZYLfFrgAdOQiKLsHBtTrry3uPbsNGkZZduBni
         1Whg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=kukJwsLtjJ3Uky7DWUIA8ZXSyJ0Cky2ROkNkXYg1gY0=;
        b=gNxrTmF4+c811TGTH/BKqZStMKJw9CUpNXpm1aZlbtdoWacALB1wV9N89d326l9C+m
         BMkHbaT02gJXdFkp2MitIvQUhQyTEsQlc2XYELXnTpSu2LsWneJQaQYAPgCnxRPx26Cv
         CAajInWujC0WPvPUOKa/9Q6WR9Y+kET9fb31oy04O7YPkQIkpGXxtUfc1xfPpzF1ZHfY
         17eJt51NreOVjjQvzrgLQy+QTUfB23UCeNE00JUW8I6/Y2wbtFe7TiHlitcC+HrKJeC9
         0Du6K56zNRbkabHj9fld28e/+DnWu1ee7qsZ7JNuFBovM+h9pEf2gdcKHsarjMkdssSe
         MWEQ==
X-Gm-Message-State: AOAM533ITv5PNWh8J+PAY5LMwZPEXAWPPe678SWhjRLk+GVnc6iLBq6y
        u1Vzt3qLvlnCqW2TP4m6TFcSkoBNo1Y=
X-Google-Smtp-Source: ABdhPJyWuUl2hChu6geYodY11hAXQJOF4xQYibEo0/cJ8ZYAoqqLrh3TQXkYEHUEptjdMEdLUost+A==
X-Received: by 2002:a05:6870:32c5:: with SMTP id r5mr955702oac.342.1644626271719;
        Fri, 11 Feb 2022 16:37:51 -0800 (PST)
Received: from ?IPV6:2603:8081:140c:1a00:4354:ebed:9b2:4ca2? (2603-8081-140c-1a00-4354-ebed-09b2-4ca2.res6.spectrum.com. [2603:8081:140c:1a00:4354:ebed:9b2:4ca2])
        by smtp.gmail.com with ESMTPSA id x31sm4624171otb.55.2022.02.11.16.37.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Feb 2022 16:37:51 -0800 (PST)
Message-ID: <0d7916f4-5e53-409d-73d2-d4eadf9c3e0d@gmail.com>
Date:   Fri, 11 Feb 2022 18:37:50 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH for-next v11 08/11] RDMA/rxe: Add code to cleanup mcast
 memory
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
References: <20220208211644.123457-1-rpearsonhpe@gmail.com>
 <20220208211644.123457-9-rpearsonhpe@gmail.com>
 <20220211184301.GA576950@nvidia.com>
 <a34545c4-dd47-2613-e08a-cfbc3ce0d32c@gmail.com>
 <20220211195627.GR4160@nvidia.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <20220211195627.GR4160@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2/11/22 13:56, Jason Gunthorpe wrote:
> On Fri, Feb 11, 2022 at 01:36:06PM -0600, Bob Pearson wrote:
>> On 2/11/22 12:43, Jason Gunthorpe wrote:
>>> On Tue, Feb 08, 2022 at 03:16:42PM -0600, Bob Pearson wrote:
>>>> Well behaved applications will free all memory allocated by multicast
>>>> but programs which do not clean up properly can leave behind allocated
>>>> memory when the rxe driver is unloaded. This patch walks the red-black
>>>> tree holding multicast group elements and then walks the list of attached
>>>> qp's freeing the mca's and finally the mcg's.
>>>
>>> How does this happen? the ib core ensures that all uobjects are
>>> destroyed, so if something is still in the rb tree here it means that
>>> an earlier uobject destruction leaked it
>>>
>>> Jason
>>
>> The mc_grp and mc_elem objects are not rdma-core uobjects. So their memory
>> is allocated by the rxe driver. They get created by ib_attach_mcast and destroyed
>> by ib_detach_mcast. If an application crashes without calling a matching
>> ib_detach_mcast for each attachment the driver would have leaked the memory.
>> This patch fixes that.
> 
> The mcast attachment is affiliated with a QP, when all the QPs are
> destroyed, which are rdma-core objects, then all attachments should be
> free'd as well. That should have happened by the time things get here
> 
> I would expect a simple WARN_ON that the rb tree is empty in destroy
> to catch any bugs.
> 
> Jason
I wrote a simple user test case that calls ibv_attach_mcast() and then sleeps.
If I type ^C the qp is detached as you predicted so someone is counting
them somewhere. It isn't obvious in rdma-core. Not sure what you are suggesting
above. The detach code already checks to see if the attachment is *not* present.
The only time it is clear that there shouldn't be any more attachments present
is when the device is closed which is what the cleanup code is doing. I can add
a warning if there was anything there but it will likely never get called since
someone above me is actively cleaning them up from failed apps. Or we can just drop
this patch and assume it isn't needed.

Bob
