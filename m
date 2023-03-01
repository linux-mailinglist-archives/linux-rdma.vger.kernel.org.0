Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E97E6A7798
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Mar 2023 00:15:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbjCAXPW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 1 Mar 2023 18:15:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbjCAXPP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 1 Mar 2023 18:15:15 -0500
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D07A3608B
        for <linux-rdma@vger.kernel.org>; Wed,  1 Mar 2023 15:15:10 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id bp19so9429792oib.4
        for <linux-rdma@vger.kernel.org>; Wed, 01 Mar 2023 15:15:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rYglzVRpFsOhxsPbD3GFA93lBDsTJCiqSiE3/gHaOvE=;
        b=eDFOz2YujlvZO6vBiWWTulaZt3e9SbGtsU41ec7T+N0VviDEgJaPmrf3KUNVbkEx94
         eq4WOLMufKFTcpJVO7tLA19T2aNjtHf5cXiOlsg92UGbZf/YGO5yIObrjBY5ZyPw0nL7
         /ffB9F8sOxpInAZy2MHlNDQh1RGJLgUZXqs7lGLJ2VHrsnl4Yce5BU6Fw+ylhALeaJdu
         RPf4xIzu3CyPk3jEmUorHdMUAeKj3fJ2tTR5/trqc8CMSVur/0nJ4wvgJNDoiJh5LXmM
         ANW2w8tmA9UC1QpFUeBuUk+g2tcaifKsk570auZxlWqEAt1y6v6emmiJzPVA6ohCqxZu
         eUsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rYglzVRpFsOhxsPbD3GFA93lBDsTJCiqSiE3/gHaOvE=;
        b=MkpQ5ag+isT1rf0Z83wwlXfNF0v1Yon6urBx47RBd4SftZ0H3f0T40+w4FKxt0LKVw
         WF3Hy9noatpoNhyiW8RmhfRx6POPcEn4HlQknEW1UxF1BsJIi7QxNESSdewIMJaF7dxJ
         6XiajvyFOMT6InkRLpzYcV+qAEVBIu9aMHtTtiMY5mwn75DIv7lx8EQ6tyg0CRBQW3U7
         c3mATiqDI5z4CaKNK99+i93alXgC+vgZrfsnKDdyaBCFmXV3PdND0hX838j/wExZvFKE
         jJ0POOAY4MWblybfSEa9ytwBLTvx8ypiqfuvlGuHZzFLXzSvJ4lXA9CRbDyLDqazI65s
         Tgyw==
X-Gm-Message-State: AO0yUKVzbOH1gyV/b06WNvT0ULGFL3F9I+U6asWB4XjTt78dZdeh54nX
        V4m2PW+7iQXGMaRAC5TI7ao=
X-Google-Smtp-Source: AK7set8yXQjhoBIOOc6xyKvKROCpJLJ07IEy+6GwIBgLP88/Wa19rm5LQc1Iy38MJaG70Opi8s8oKg==
X-Received: by 2002:a05:6808:2a06:b0:364:7541:f9cd with SMTP id ez6-20020a0568082a0600b003647541f9cdmr4044589oib.21.1677712509521;
        Wed, 01 Mar 2023 15:15:09 -0800 (PST)
Received: from ?IPV6:2603:8081:140c:1a00:a096:b278:de3e:afca? (2603-8081-140c-1a00-a096-b278-de3e-afca.res6.spectrum.com. [2603:8081:140c:1a00:a096:b278:de3e:afca])
        by smtp.gmail.com with ESMTPSA id v132-20020acade8a000000b003646062e83bsm6363944oig.29.2023.03.01.15.15.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Mar 2023 15:15:08 -0800 (PST)
Message-ID: <108cf8f1-6123-620e-8700-53246c7a8287@gmail.com>
Date:   Wed, 1 Mar 2023 17:15:07 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] RDMA/rxe: Fix parameter errors
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     zyjzyj2000@gmail.com, leonro@nvidia.com,
        linux-rdma@vger.kernel.org, Rao.Shoaib@oracle.com
References: <20230119180506.5197-1-rpearsonhpe@gmail.com>
 <Y8mXfmju8W+3FdDp@nvidia.com>
Content-Language: en-US
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

Did this get lost? for-next is now at 6.2-rc3 now and the bug is still in rxe_param.h.

Bob
