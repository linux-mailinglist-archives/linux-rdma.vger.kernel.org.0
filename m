Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8749A57D325
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Jul 2022 20:18:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232161AbiGUSSG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 21 Jul 2022 14:18:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiGUSSF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 21 Jul 2022 14:18:05 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 735988C742
        for <linux-rdma@vger.kernel.org>; Thu, 21 Jul 2022 11:18:04 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-10d6ddda695so3568617fac.0
        for <linux-rdma@vger.kernel.org>; Thu, 21 Jul 2022 11:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=U6KCGsBXQtyPJN391OAj7tviefmVoyYtL+nqM8tRyv8=;
        b=DQHO22uYt7lQ7C67+3AJ8wsE23bGxZOkPJnXe8sE+YCoRnZctl4XJVakZQkWXk/4CK
         g5qakr6r6vk0t1JMSUkdWCRHGAQwhifiTAKkHsyOaZmzCgVNuQpq5WVypZIGWB0lwJea
         Rx/7upLEpwexgvP/wlzMQfDf4LYWoS9mvRHZgKJlt5kur/0jIS5Sz0kBZZJBP+KioNEM
         7AcNBR/HGrkQxvm7TTzHUneEf/HmosM2CXvmo/39vj7awponGQU7THoGenbvA9zw7Yyr
         5M1R66axT9ymi4kNaatEOHm8Ic3ITqUx0h0rvNqhT2suaei1qv+ziR8R9rALNIP9lBkG
         ystw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=U6KCGsBXQtyPJN391OAj7tviefmVoyYtL+nqM8tRyv8=;
        b=E8hOCH99WSV5bcM/AQrfbdOHS+3nA4twbO5RAH/7iCT1XCdCBqwpSim1S1XP/hRxqa
         EeezS1lUWykmzBdDgW4pPuJltsEUgdWo11cXuVP2fawSopkb3GEB3W5y2837QueBUp8w
         ECdsKR7Qw2kzHkJ+AcOO+u+mPDPMRJyHa5oBLLQVefhTZRM4yWZjfVsuKEhIr/iUBDCl
         kJNhO1nA9Qfa7AJfkNVzuy+yzvdVRoSIWCZs9CoBifnIvpRyku5FhFw6297VKGPP5dzO
         SOIfV07RiDcREr3a8bDSWA7F10DCCLfZhXM3kFlAmXfleAHFWXvytR6tdGQrsuCJ2NRo
         g+Tg==
X-Gm-Message-State: AJIora8EkH61WOQGbOiL0yiQDa2rcOU3C3M3dK0z0gdVB2n2Idi2zNmK
        EII37Yn8Eqg2+eM6+OL7su8=
X-Google-Smtp-Source: AGRyM1vJVcsPg2NpMT/yNjxNMOjce7xQV8AZ+Jmqs/EEGO2QsAtnjz97G3f68GOyLeSWFMBl+mrMLQ==
X-Received: by 2002:a05:6870:e248:b0:10d:215d:1b41 with SMTP id d8-20020a056870e24800b0010d215d1b41mr5908177oac.179.1658427483794;
        Thu, 21 Jul 2022 11:18:03 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:26e5:db00:e7ca:8ba1? (2603-8081-140c-1a00-26e5-db00-e7ca-8ba1.res6.spectrum.com. [2603:8081:140c:1a00:26e5:db00:e7ca:8ba1])
        by smtp.gmail.com with ESMTPSA id k6-20020a4aa5c6000000b004279be23ed4sm1013898oom.41.2022.07.21.11.18.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Jul 2022 11:18:03 -0700 (PDT)
Message-ID: <17df2afa-3c5d-c57d-47ad-640399279965@gmail.com>
Date:   Thu, 21 Jul 2022 13:18:01 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RESEND RFC PATCH for-next] Revert "RDMA/rxe: Create duplicate
 mapping tables for FMRs"
Content-Language: en-US
To:     Haris Iqbal <haris.iqbal@ionos.com>,
        Li Zhijian <lizhijian@fujitsu.com>
Cc:     Yanjun Zhu <yanjun.zhu@linux.dev>, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-rdma@vger.kernel.org, Leon Romanovsky <leon@kernel.org>,
        Guoqing Jiang <guoqing.jiang@linux.dev>
References: <1658312958-13-1-git-send-email-lizhijian@fujitsu.com>
 <CAJpMwyier2gtHoMhkrFeNXmqjUo9ab2Ba4Ef_YZoCwv__9cz=Q@mail.gmail.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <CAJpMwyier2gtHoMhkrFeNXmqjUo9ab2Ba4Ef_YZoCwv__9cz=Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 7/20/22 05:50, Haris Iqbal wrote:
> On Wed, Jul 20, 2022 at 12:22 PM Li Zhijian <lizhijian@fujitsu.com> wrote:
>>
>> Below 2 commits will be reverted:
>>      8ff5f5d9d8cf ("RDMA/rxe: Prevent double freeing rxe_map_set()")
>>      647bf13ce944 ("RDMA/rxe: Create duplicate mapping tables for FMRs")
>>
>> The community has a few bug reports which pointed this commit at last.
>> Some proposals are raised up in the meantime but all of them have no
>> follow-up operation.
>>
>> The previous commit led the map_set of FMR to be not avaliable any more if
>> the MR is registered again after invalidating. Although the mentioned
>> patch try to fix a potential race in building/accessing the same table
>> for fast memory regions, it broke rnbd etc ULPs. Since the latter could
>> be worse, revert this patch.
>>
>> With previous commit, it's observed that a same MR in rnbd server will
>> trigger below code path:
> 
> Looks Good. I tested the patch against rdma for-next and it solves the
> problem mentioned in the commit.
> One small nitpick. It should be rtrs, and not rnbd in the commit message.
> 
> Feel free to add my,
> 
> Tested-by: Md Haris Iqbal <haris.iqbal@ionos.com>
> 
Li,

It has been a while since this was added. If I recall there was a problem in rnfs
that this was supposed to fix. It was also supposed to allow overlap of using the
previous mappings and the driver creating new ones. But it seems that most fmr
based ulps don't require it, maybe all. Before we do this we should make sure that
blktests, srp, lustre, rnfs, etc all work. Have these been tested?

Bob
