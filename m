Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B71650E65C
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Apr 2022 18:59:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbiDYRCC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 25 Apr 2022 13:02:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232710AbiDYRCB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 25 Apr 2022 13:02:01 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32ED044A2B
        for <linux-rdma@vger.kernel.org>; Mon, 25 Apr 2022 09:58:57 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-e93ff05b23so3592400fac.9
        for <linux-rdma@vger.kernel.org>; Mon, 25 Apr 2022 09:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=oEouq6GY/SJQQl5LqlMUagtK3fDXMwoeuQPZYpXN8W0=;
        b=Xv+Zo3uy6LeZjp4k1SfSUsoOj6qHJlfm0T6GIVjukwCWAUJB3IoI/6POX68qB/lbv5
         XKQDthXVD0VQw9PlsO/EsesN+s60y6JIiE4vltwfz8T8sEdvBJPCpEG9pumn3Fcg++rR
         a6WUtf0m8QKRbSYPXXjvGsoZoZbUmM60pQWRnX1Juwcq8QKZ/2YOMw0hy+cHtfOeGI4C
         eW9+QPtsncsxFCC5TThJrUNuzjGWvAwWM63X7TnZZbpjFdZQKELJiCs/ygaFITmina6H
         pwIWnm/35cfQB2gkpO6CGGsRD9FmeOMvL8jQSaaJxaAi3rtXmr/7RS2+LZ/hS20r/qF4
         2dTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=oEouq6GY/SJQQl5LqlMUagtK3fDXMwoeuQPZYpXN8W0=;
        b=cVo/Fwv3G/nDWulN9rgjWzyl8l1+XF2W5nEasVyx7EWCtOqP6jb/IZjUCjvfGm7Q86
         UV+SCCngo058nECJvzaBS0BSr8/MPUeQUCCf3Nf/RT/FNHcxKQg60J+Cf49YGQ5UsYRv
         dM9h6u1u9FGnGvyU+ybYPhONmtMKCTcG9WqlZjiay/2GEqNsZfmHJ6C8Z7Il4bJ5ZXin
         7XeoHKKKY5YoIR2bDv4LHUFyCW3yx7yt1wK3qQwAYwSD9L/oF5YyaENjuXE+Ewa9912H
         bFUWa6xxHuu5pIp3KhVfhqo81ysniWD/L1slmvxAZMLAIJUGqa97etkBngeS2NkvBMjc
         /4Nw==
X-Gm-Message-State: AOAM5308NH6AysF1Y5kBC06slWegZx68LQekpUhp6zywQhphoMbYsh+G
        Yo8tprE2Xvvd2xy3JwEWLGbiaHHlmbg=
X-Google-Smtp-Source: ABdhPJyrKXH4a7373dg9rR0yP00cpSMmFfFQI5GClFn6x6PAhWFP8d2EereFHFFb9jtN9yeAj/hmkg==
X-Received: by 2002:a05:6870:1244:b0:ce:c0c9:620 with SMTP id 4-20020a056870124400b000cec0c90620mr11634377oao.114.1650905936129;
        Mon, 25 Apr 2022 09:58:56 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:219e:3c55:e4f9:4342? (2603-8081-140c-1a00-219e-3c55-e4f9-4342.res6.spectrum.com. [2603:8081:140c:1a00:219e:3c55:e4f9:4342])
        by smtp.gmail.com with ESMTPSA id z20-20020a056871015400b000e946697146sm965563oab.25.2022.04.25.09.58.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Apr 2022 09:58:55 -0700 (PDT)
Message-ID: <dfba7eb7-8467-59b5-2c2a-071ed1e4949f@gmail.com>
Date:   Mon, 25 Apr 2022 11:58:55 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: bug report for rdma_rxe
Content-Language: en-US
To:     Yanjun Zhu <yanjun.zhu@linux.dev>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Zhu Yanjun <zyjzyj2000@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <5de7d1a9-a7ac-aea5-d11c-49423d3f0bf1@gmail.com>
 <98ad3df7-b934-ad2b-49c6-bb07a06a5c4f@linux.dev>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <98ad3df7-b934-ad2b-49c6-bb07a06a5c4f@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 4/24/22 19:04, Yanjun Zhu wrote:
> 在 2022/4/23 5:04, Bob Pearson 写道:
>> Local operations in the rdma_rxe driver are not obviously idempotent. But, the
>> RC retry mechanism backs up the send queue to the point of the wqe that is
>> currently being acknowledged and re-walks the sq. Each send or write operation is
>> retried with the exception that the first one is truncated by the packets already
>> having been acknowledged. Each read and atomic operation is resent except that
>> read data already received in the first wqe is not requested. But all the
>> local operations are replayed. The problem is local invalidate which is destructive.
>> For example
> 
> Is there any example or just your analysis?

I have a colleague at HPE who is testing Lustre/o2iblnd/rxe. They are testing over a
highly reliable network so do not expect to see dropped or out of order packets. But they
see multiple timeout flows. When working on rping a week ago I also saw lots of timeouts
and verified that the timeout code in rxe has the behavior that when a new RC operation is
sent the retry timer is modified to go off at jiffies + qp->timeout_jiffies but only if
there is not a currently pending timer. Once set it is never cleared so it will fire
typically a few msec later initiating a retry flow. If IO operations are frequent then
there will be a timeout every few msec (about 20 times a second for typical timeout values.)
o2iblnd uses fast reg MRs to write data to the target system and then local invalidate
operations to invalidate the MR and then increments the key portion of the rkey and resets
the map and then does a reg mr operation. Retry flows cause the local invalidate and reg MR
operations to be re-executed over and over again. A single retry can cause a half a dozen
invalidate operations to be run with various rkeys and they mostly fail because they don't
match the current MR. This results in Lustre crashing.

Currently I am actually happy that the unneeded retries are happening because it makes
testing the retry code a lot easier. But eventually it would be good to clear or reset the timer
after the operation is completed which would greatly reduce the number of retries. Also
it will be important to figure out how the IBA intended for local invalidates and reg MRs to
work. The way they are now they cannot be successfully retried. Also marking them as done
and skipping them in the retry sequence does not work. (It breaks some of the blktests test
cases.)

> You know, sometimes your analysis is not always correct.
> To prove your analysis, please show us some solid example.
> 
> Zhu Yanjun
> 
>>
>> sq:    some operation that times out
>>     bind mw to mr
>>     some other operation
>>     invalidate mw
>>     invalidate mr
>>
>> can't be replayed because invalidating the mr makes the second bind fail.
>> There are lots of other examples where things go wrong.
>>
>> To make things worse the send queue timer is never cleared and for typical
>> timeout values goes off every few msec whether anything actually failed.
>>
>> Bob
> 

