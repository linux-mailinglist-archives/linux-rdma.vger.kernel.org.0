Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA00E24C75B
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Aug 2020 23:51:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727064AbgHTVvP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 20 Aug 2020 17:51:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725819AbgHTVvP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 20 Aug 2020 17:51:15 -0400
Received: from mail-oo1-xc44.google.com (mail-oo1-xc44.google.com [IPv6:2607:f8b0:4864:20::c44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18646C061385
        for <linux-rdma@vger.kernel.org>; Thu, 20 Aug 2020 14:51:15 -0700 (PDT)
Received: by mail-oo1-xc44.google.com with SMTP id x6so761441ooe.8
        for <linux-rdma@vger.kernel.org>; Thu, 20 Aug 2020 14:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tOafVGrhuv5GD9E/S5s3uXjdN4xhG6mbpDWL3Am0usA=;
        b=T6a4F6VjImTFqYRMK0qXcpBnHtSFzOd2pHXktLUQHlJjStaKKkpbeBdo9Kjrsw6nq8
         NtdzTjRZu6jtIMuleh0F5kXHP5YHeyPRtK2rXH0qeF35ZdXhkldgZiQSK3vbiQHOwL+M
         0ziCniZ+Gu1l3TTCTNsO7CYHUWmV/mp2sfg/anIZuVouvIaTYw1leVV2TkwAOvSf22IS
         OXCA4wuyFtjYWOD+i1o0gMks4/ssS9urq2A0BaFPYCbodDlcEYrp0U7muS1afm5iAqEU
         VEIFLAKG1ftQlPG3UXxoF4Rzsm7W8NOrL7VjkdiHP+EV7B27Sg2WUnjCVvNuOTdOS+0K
         WilA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tOafVGrhuv5GD9E/S5s3uXjdN4xhG6mbpDWL3Am0usA=;
        b=H9PME4/re4HfSlexFQwfPNQzmnGRXT4YGSXZYhwp3bnGwXSScgtSq3w3XAj/dBdixh
         Rq7bgjrETHkBR9nomq7dYjxYU/nn455HNzSrOgQCAmoANnGOXrpP3Py/E7CylmFOyJ/4
         6p8wc51GpuGJR333ub6sW2PpRGs1ZN+cwbcfczefaPXiMGYiNueW1o6TmCtc4qIEXvjS
         HjJOM2ioni/CY0H7KpDPy05AKJYqfB1133z95ICvGht1WzoBIQW+dEvuKKGUgmKy62AI
         AKdFWW0/BH1dGwUOMm4tHWAGpHmGE+9oo8ZsVHVxod59ZteuY9JUd1vuOM9hhGbaT0ph
         ua9w==
X-Gm-Message-State: AOAM530HbtAa28SWdonjjFf0mCuDYV6Ue/PoSxaEZdGRf07wuPnidPgR
        /gk2akso8VdHMNd8TtKxpXI=
X-Google-Smtp-Source: ABdhPJwlQOGVGJPWhjSJsYbP2V54XThXXaTcxIey+1EcRjc38FHfGjcsuFuXIj5hMT4FUdXH3c7Ivw==
X-Received: by 2002:a4a:d2d8:: with SMTP id j24mr502967oos.82.1597960274489;
        Thu, 20 Aug 2020 14:51:14 -0700 (PDT)
Received: from ?IPv6:2605:6000:8b03:f000:d55c:7584:8c78:87ff? ([2605:6000:8b03:f000:d55c:7584:8c78:87ff])
        by smtp.gmail.com with ESMTPSA id a15sm652558oid.49.2020.08.20.14.51.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Aug 2020 14:51:14 -0700 (PDT)
Subject: Re: Memory window support for rdma_rxe
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org
Cc:     Zhu Yanjun <zyjzyj2000@gmail.com>
References: <20200819034002.8835-1-rpearson@hpe.com>
 <20200819050204.GP7555@unreal>
 <13f4a586-9f9c-e348-ec85-d9109adcab5b@gmail.com>
 <20200820074116.GZ7555@unreal>
 <92e509ee-8a6a-6e3b-c1e3-1d6ec84c44fe@gmail.com>
Message-ID: <d940eef5-56f9-c61f-7be0-5cc740a1115f@gmail.com>
Date:   Thu, 20 Aug 2020 16:51:13 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <92e509ee-8a6a-6e3b-c1e3-1d6ec84c44fe@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 8/20/20 2:27 PM, Bob Pearson wrote:
> On 8/20/20 2:41 AM, Leon Romanovsky wrote:
>> On Wed, Aug 19, 2020 at 11:36:54AM -0500, Bob Pearson wrote:
>>> On 8/19/20 12:02 AM, Leon Romanovsky wrote:
>>>> On Tue, Aug 18, 2020 at 10:39:46PM -0500, Bob Pearson wrote:
>>>>> This a cleaned up resend of an earlier patch set. This set of patches
>>>>> implements the memory windows verbs and local send operations. Each of these
>>>>> has been tested at a basic level and regressions tests have been run to
>>>>> see that basic rxe functionality is OK.
>>>>
>>>> Can you please submit the series together with standard cover-letter
>>>> (git format-patch --cover-letter ..) that include diffstat and patch
>>>> list.
>>>>
>>>> It is helpful to see the whole picture of expected changes.
>>>>
>>>> Does it pass rdma-core pyverbs tests?
>>>>
>>>> Thanks
>>>>
>>> Leon,
>>>
>>> Thanks for the comments. They are helpful. I haven't worked on rxe or anything else in Linux for about 6-7 years so there are a lot of things that have changed. I have a few questions that you may be able to answer.
>>>
>>> The build robot seems to be catching things that make in the kernel tree is missing (I think.) Is there a way to check if patches will work before sending them in an email? The most recent attempt had a stray variable declaration left over from some other change but I never saw a compiler warning.
>>
>> You can catch most (90%) of errors reported by kbuild if you use
>> latest GCC compiler to prepare your patches. Latest Fedora (32) has
>> it. Compile your code with allyesconfig, allmodconfig and allnoconfig.
>>
>> Rest of errors you can find with smatch and sparse tools.
>>
>>>
>>> I had used --compose rather than --cover-letter and wondered how people got those nice [PATCH 0/N] messages. I'll give it a try.
>>>
>>> I've never come to terms with Python (white space shouldn't carry syntax IMHO) and have no idea what pyverbs is doing. How do you run the tests you mention?
>>
>> https://github.com/linux-rdma/rdma-core/blob/master/Documentation/testing.md#how-to-run-rdma-cores-tests
>> Bottom line:
>> 1. Download rdma-core
>> 2. Compile on the system with your rxe device, use build.sh script in
>> source code
>> 3. Run the tests directly from the source code
>> ./build/bin/run_tests.py -v
>>
>>>
>>> I tried to get git send-email to put a version number into the subject lines with -v2 which it happily accepts but it does nothing. In the end I had to edit each email one at a time. Is there an easier way to get e.g. [PATCH v3 xx/yy]?
>>
>> It is done during format-patch stage, my command line for the series is;
>> git format-patch --cover-letter -M -C -v X --subject-prefix "PATCH $TARGET" -o /tmp/
>>                                      ^^^^ version                 ^^^^ rdma-next or rdma-rc
>>
>>>
>>> Thanks for the help,
>>>
>>> Bob Pearson
> Interesting. I fairly easily got the tests working but have found bugs in error cases in the response state machine that I'll have to fix. The test behaves badly (perhaps on purpose) by deallocating the MWs and then banging away sending writes to the now defunct MW. The responder should nak the rkey violation but doesn't. The cause of that is that do_complete assumes that no errors ever occur and skips out if there isn't receive wqe to complete bypassing the ACKNOWLEDGE state. This should also have been seen for MRs if anyone ever did the same thing.
> 
> Bob 
> 
The run_tests.py tests are mostly running. There are four test cases that always fail (AH, and mcast) but have nothing to do with MWs. And there are occasional other failures from INIT->RTR QP transition timeouts failures. These are not reproducible and occur on various tests. I do not believe this has anything to do with the MW code either. It never gets there when it happens to be a MW case.

There were three issues with the MW code that are fixed now. One was a use before set of a pointer, one was a difference of interpretation of the IBA specs (I wasn't allowing invalidation of a MW unless it was valid), the last was was the missing acks described above.

Do you know if this is normal behavior for rxe?

I am going to post v3 patch set now.

Bob
