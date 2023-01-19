Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A483674365
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Jan 2023 21:18:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbjASUSL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 19 Jan 2023 15:18:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbjASUSJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 19 Jan 2023 15:18:09 -0500
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9D2F9CBA5
        for <linux-rdma@vger.kernel.org>; Thu, 19 Jan 2023 12:18:06 -0800 (PST)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-15ebfdf69adso3988669fac.0
        for <linux-rdma@vger.kernel.org>; Thu, 19 Jan 2023 12:18:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mtGB1QzTYEslXd0PazLbeWFyLUxDjrorKuJqhRgi3Rc=;
        b=emIXJI9M3s0l9RY47DTDWpySPAf4/XK8XfUBXhG2qKO9XW1AywaKaM9SFKhLRH8On9
         ne2tcA6fmdXEbabrRo3Gp0CejgActs+C2KjPYRtqLDCkhXI5g9A3zVmxfMholI42MWTV
         KQI498opg8ANV2AgLcjoub+dYHsAPhmEarlH8mKiGr9if26yXAN2OpvtotE5vR05BD6G
         Kt/NS/tg+bU5jWSSxjZqGLz4PuHcUr6DuP74GnooAfZ6W2chWgabmKWYXllCrFzoopJ2
         pRXooqf/ZHXGfCe7QGaQYmIQ27EVaRKxK9729Yb+vVUbTNDQKgPdFriGW9YQQkgBBUKe
         nfpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mtGB1QzTYEslXd0PazLbeWFyLUxDjrorKuJqhRgi3Rc=;
        b=lqoC9UdDnj8h7Ee+aXv7OTE06dBSXsWxhjADzffqepCbBf8Uv/Ge/+SRSQvFiKhq0x
         8GHjJi0iM9Hs2nJNbQIveyl6mxZ0pfSPAgpkR8WPuQF2JJb/OZlfEr5fWGxcZ06j3Gj6
         v6br2UkBz5SeNTiychWUhvY9o1z9QldroGw/F0fxjGdQAdCsT31Q44sxE8/89KnOfaj3
         EqAG2ziNz3jjoCt5B+/j3SaxvodtKVvNa1kheUg9XDFHVmLW+IUdxj5uIxVD25qnl/Sv
         uGs86DLdRBulCa++SYvzqnlWwvfWAyw0sTI2Ph+R4HhJREpozxSpeie7BwM7Df0lcnke
         U9UA==
X-Gm-Message-State: AFqh2kqRs15kj4AJxmWb0ZjHICEzzGjn7CMyWnIet+ccn8wySQk5UTq5
        63WPrO/PbOJQ4Zpu2os9aqE=
X-Google-Smtp-Source: AMrXdXu2tgsgnm1VLj71YmxZERkif45+ZY/99Il9QqF/k6cMK4I2gSyoKfPZDSlwj5Fd4wfJd9SLPA==
X-Received: by 2002:a05:6870:6b06:b0:15e:aba8:2676 with SMTP id mt6-20020a0568706b0600b0015eaba82676mr6751580oab.16.1674159486172;
        Thu, 19 Jan 2023 12:18:06 -0800 (PST)
Received: from ?IPV6:2603:8081:140c:1a00:d086:74d8:5274:c0f1? (2603-8081-140c-1a00-d086-74d8-5274-c0f1.res6.spectrum.com. [2603:8081:140c:1a00:d086:74d8:5274:c0f1])
        by smtp.gmail.com with ESMTPSA id r30-20020a056870581e00b0015f82773e88sm3776261oap.32.2023.01.19.12.18.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Jan 2023 12:18:05 -0800 (PST)
Message-ID: <6b429d0c-dfdf-0a21-edaa-72511aef8aef@gmail.com>
Date:   Thu, 19 Jan 2023 14:18:04 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] RDMA/rxe: Fix parameter errors
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     zyjzyj2000@gmail.com, leonro@nvidia.com,
        linux-rdma@vger.kernel.org, Rao.Shoaib@oracle.com
References: <20230119180506.5197-1-rpearsonhpe@gmail.com>
 <Y8mXfmju8W+3FdDp@nvidia.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <Y8mXfmju8W+3FdDp@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 1/19/23 13:18, Jason Gunthorpe wrote:
> On Thu, Jan 19, 2023 at 12:05:07PM -0600, Bob Pearson wrote:
>> Correct errors in rxe_param.h caused by extending the range of
>> indices for MRs allowing it to overlap the range for MWs. Since
>> the driver determines whether an rkey is for an MR or MW by comparing
>> the index part of the rkey with these ranges this can cause an
>> MR to be incorrectly determined to be an MW.
>>
>> Additionally the parameters which determine the size of the index
>> ranges for MR, MW, QP and SRQ are incorrect since the actual
>> number of integers in the range [min, max] is (max - min + 1) not
>> (max - min).
>>
>> This patch corrects these errors.
>>
>> Fixes: 0994a1bcd5f7 ("RDMA/rxe: Bump up default maximum values used via uverbs")
>> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
>> ---
>>  drivers/infiniband/sw/rxe/rxe_param.h | 27 +++++++++++++++++++--------
>>  1 file changed, 19 insertions(+), 8 deletions(-)
> 
> This
> 
> commit 1aefe5c177c1922119afb4ee443ddd6ac3140b37
> Author: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
> Date:   Tue Dec 20 17:08:48 2022 +0900
> 
>     RDMA/rxe: Prevent faulty rkey generation
>     
>     If you create MRs more than 0x10000 times after loading the module,
>     responder starts to reply NAKs for RDMA/Atomic operations because of rkey
>     violation detected in check_rkey(). The root cause is that rkeys are
>     incremented each time a new MR is created and the value overflows into the
>     range reserved for MWs.
>     
>     This commit also increases the value of RXE_MAX_MW that has been limited
>     unlike other parameters.
>     
>     Fixes: 0994a1bcd5f7 ("RDMA/rxe: Bump up default maximum values used via uverbs")
>     Link: https://lore.kernel.org/r/20221220080848.253785-2-matsuda-daisuke@fujitsu.com
>     Signed-off-by: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
>     Tested-by: Li Zhijian <lizhijian@fujitsu.com>
>     Reviewed-by: Li Zhijian <lizhijian@fujitsu.com>
>     Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> 
> 
> Is already in v6.2-rc and conflicts with this patch, it looks like it
> is doing the same thing, can you sort it out please?
> 
> Thanks,
> Jason

Missed that one. Yes, they are basically identical except he cut the range in half and gave one to each and I doubled it. The other change I made is still a bug but much less important. It reports an incorrect max_xxx number in hca attributes but has no ill effect.
We can leave it the way it is for now.

Bob
