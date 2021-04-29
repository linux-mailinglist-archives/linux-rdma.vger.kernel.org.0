Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 441EF36EDCB
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Apr 2021 18:03:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232004AbhD2QDz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 29 Apr 2021 12:03:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237123AbhD2QDv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 29 Apr 2021 12:03:51 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6231C06138B
        for <linux-rdma@vger.kernel.org>; Thu, 29 Apr 2021 09:03:03 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id h7so6431797plt.1
        for <linux-rdma@vger.kernel.org>; Thu, 29 Apr 2021 09:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=4OoN217VvWnGmdJdZS6oi6fNv6UiIl9gPlvowebisU8=;
        b=s5l4ADuqEZMcjzESh0vQDyvQ7UYNspcs8mMWnBn3uSuk+SLN3/PcmWEsKnduAudf3V
         b2HCFuLD6KihACOapfVsh9iZ+7dF8v0ZpOVt8Td4qqZKpTGq/8sXGD1D9uLNhAQFJaXs
         /qBo/k2mGO8LiFisde+4mhPASr2oJGrNSzujtaL9IbyOIewTcsQKglmdsnTw01Uz57c4
         zaa0nZsGBFeWo1Xduq5mF4ZKyetV3fCHAy5e1eWBmHOO6Ync2Zuu5BrIf1OxUUkFcIpy
         EW6XaXq9WA5dvZ528/OtmLo9UMDnAxV+SXJzER2KCFA+O3nAvrvpJtKhO1GVUDMkyC9w
         ksnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=4OoN217VvWnGmdJdZS6oi6fNv6UiIl9gPlvowebisU8=;
        b=erWhq94iMe1RLlVNTOVEU9QE/6ylW6dt3PCH4RxLa8a4fWwJJFPlz2SccNZb36iXim
         RwJRLNiwhKtn38NP9jthpABWJorjuLdi5FiphjtMVXkKbQPvPkgVW91ZisAYIHkcQv4U
         hBOWXGtfC+khnr6VSGsZbt/wpsw7wgXV4sJ3FIzP91YXPAYx2RMwCZqbQrbwodA3nMW8
         Vm7UCkwRdz2WdJmO5h6Kc774cynukkRagTPopA+okWYfBp0Av1UbthbyNT7LttS4akTl
         HCxD9kzTP0ZMlDBC87DaVdTMuqhVbCR+R1UNgu+doWhkqWKTJjoCGRsLvw4KW/G6R/gh
         Xs7A==
X-Gm-Message-State: AOAM531XyCO5kUGMZLmY3RhUWzdkgVyqatz3veNLgRrUmnrZuIu/7I0X
        fbHT/zgmzFidECjwYLJOZ/A=
X-Google-Smtp-Source: ABdhPJwbLKIxvFZ415HKFAjRIAuGQYiN7CvORpzK1pL9y0pnXtsYDXcWShx1f4MyEL3cOxAr/g9ToQ==
X-Received: by 2002:a17:902:6ac3:b029:e6:c6a3:a697 with SMTP id i3-20020a1709026ac3b02900e6c6a3a697mr381555plt.2.1619712183333;
        Thu, 29 Apr 2021 09:03:03 -0700 (PDT)
Received: from [192.168.0.25] ([97.99.248.255])
        by smtp.gmail.com with ESMTPSA id e20sm7912507pjt.8.2021.04.29.09.03.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Apr 2021 09:03:02 -0700 (PDT)
Subject: Re: [PATCH for-next v5 08/10] RDMA/rxe: Implement invalidate MW
 operations
To:     Zhu Yanjun <zyjzyj2000@gmail.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Bob Pearson <rpearson@hpe.com>
References: <20210422161341.41929-1-rpearson@hpe.com>
 <20210422161341.41929-9-rpearson@hpe.com>
 <CAD=hENeB_XJQOy-6tvNwe6+ZyAmw6LBe16ePT4DtcEpu+hOKTg@mail.gmail.com>
 <eb46fc9c-cc72-b928-f4ee-258fd10f2437@gmail.com>
 <CAD=hENdeuNZ7WXkXtV7BqbE0gP34=YH_gbn7odyq-GiAVccesA@mail.gmail.com>
 <4c176a90-0712-e8f7-222a-36cf87f899d7@gmail.com>
 <CAD=hENcr_LuhgdSdXLcZSi97AyBof51xntDGyTKutmv5be_iXQ@mail.gmail.com>
 <e1a4821b-dc2d-3adf-536e-62970048bcf1@gmail.com>
 <CAD=hENeMiYHLFPttYnm1oJhq+2pxXXUC_b_sQXXmENhewkgy+Q@mail.gmail.com>
From:   "Pearson, Robert B" <rpearsonhpe@gmail.com>
Message-ID: <1e192a3f-a087-a72a-9415-2817b07f6db1@gmail.com>
Date:   Thu, 29 Apr 2021 11:02:56 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <CAD=hENeMiYHLFPttYnm1oJhq+2pxXXUC_b_sQXXmENhewkgy+Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 4/29/2021 1:12 AM, Zhu Yanjun wrote:
> On Thu, Apr 29, 2021 at 11:32 AM Pearson, Robert B
> <rpearsonhpe@gmail.com> wrote:
>>
>> On 4/28/2021 10:20 PM, Zhu Yanjun wrote:
>>> On Thu, Apr 29, 2021 at 11:07 AM Pearson, Robert B
>>> <rpearsonhpe@gmail.com> wrote:
>>>> On 4/28/2021 7:54 PM, Zhu Yanjun wrote:
>>>>> Adding a prefix makes debug easy. This can help filter the functions.
>>>>> And a prefix can help us to verify the location of the function.
>>>>>
>>>>> Zhu Yanjun
>>>> For comparison here are all the subroutine names from a well known
>>>> driver file. As you can see, 100% of the non static subroutines *do*
>>>> have mlx5 in their name but the majority of the static ones *do not*,
>>>> and these are by definition not shared anywhere else but this file. This
>>>> is representative of the typical style in linux-rdma.
>>> With perf or ftrace debug tools, a lot of functions will pop out.
>>> A prefix can help the developer to locate the functions source code easily.
>>> And a prefix can help the developer filter the functions conveniently.
>>>
>>> This is why I recommend a prefix.
>>>
>>> Zhu Yanjun
>> Yes, I can tell. We're still debating this. Obviously the developers of
>> mr.c don't entirely agree and I don't either. There are places where it
>> makes sense but the code is ugly IMHO. I think you should let developers
> A prefix can make code easy to debug, then easy to maintain. This is
> not ugly code.^o^
> On the contrary, it is beautiful code. ^o^
>
>> write in the style they are most effective with, especially in the
>> context of a local static subroutine which have a very narrow scope.
> Even though the local static functions still possibly appear in kernel
> debug tools,
> it is necessary to add a prefix to make it easy to locate and filter.
> This can make maintenance
> easy.
>
> Zhu Yanjun
>
>> Bob

OK, I'll try.

Bob

