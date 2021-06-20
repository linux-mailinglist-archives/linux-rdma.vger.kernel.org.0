Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4ACC73ADDB6
	for <lists+linux-rdma@lfdr.de>; Sun, 20 Jun 2021 10:11:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbhFTINZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 20 Jun 2021 04:13:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49943 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229491AbhFTINZ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 20 Jun 2021 04:13:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624176671;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=O3UmjCEtANIS8TmwS6+3vLq36CqpQGjVBan36Kttnu0=;
        b=XPI+Jtm3gKJCwmbomVEqGcgcXcEyF8B6gjSwEcVnuMIpTWtm9km1/7udEz1fZfqdc8RX0Y
        3CqVTJWzLxaDa9T+X25sEO/CgJ3FQ+xaqK/dgQKDMEndxMi1Ev8naP8dsHqwZFGdqFzSLk
        KRN1b38S5bcBI6np6PT4t/MuJhOaYyk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-565-XApEKWWGPHSy4OJJd8OOzQ-1; Sun, 20 Jun 2021 04:11:08 -0400
X-MC-Unique: XApEKWWGPHSy4OJJd8OOzQ-1
Received: by mail-wr1-f72.google.com with SMTP id j2-20020a5d61820000b029011a6a8149b5so6452270wru.14
        for <linux-rdma@vger.kernel.org>; Sun, 20 Jun 2021 01:11:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=O3UmjCEtANIS8TmwS6+3vLq36CqpQGjVBan36Kttnu0=;
        b=uUZbHBroxL2XYx7z9oXC1/pLoJPLmKdAq9Yr3fAFfJzx/R2RrrO6eP01IXljvnyCDE
         r7gMfY/iY7ayUedtpwuqjc/5oviOpis9l+/gN1iEzMyteFMpoq/xdj5XQY9H6Nqzc36Y
         3j823CqLrs18tOCo7VfN2RStw+0C+N9aYU/EniKTV6sir8l9Hr6z+cDFF+QEv9tq76Tk
         1xFJmvirC6SHS+bah72mMYd1tIDF6B6IdhYuJXZEcPHXnXaAtv29QiYp22WL8lw60/mw
         E/HMVUE7c6CTTpRgIQQoo7lj7XE2RJPoVhZ9U0E4z9s5Y0srBMquu9aB2fX7rlLipQTR
         CTrw==
X-Gm-Message-State: AOAM530rGIFpPYGXD36GU0rMxKGqeIvah5yEWQQYco/6OskNxclEJap2
        NUsbuW6AGBE8FgIUKjifOpaQZGjKjAMAd39uWFInSpYtn163LyJc8fq4ju9vcdkOpYhEKUAeNLx
        e7woH6suI6ASvyZbobOFxBA==
X-Received: by 2002:a05:600c:35c3:: with SMTP id r3mr20460198wmq.169.1624176667025;
        Sun, 20 Jun 2021 01:11:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxhGbV6S2SWIV5r9o0855mXScmwmj/Hu8fTEQloX0WXitavGEiPZpnO4ybO0h8dSqeCr7D4fQ==
X-Received: by 2002:a05:600c:35c3:: with SMTP id r3mr20460171wmq.169.1624176666739;
        Sun, 20 Jun 2021 01:11:06 -0700 (PDT)
Received: from ?IPv6:2a00:a040:19b:e02f::1005? ([2a00:a040:19b:e02f::1005])
        by smtp.gmail.com with ESMTPSA id o7sm14514588wro.76.2021.06.20.01.11.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Jun 2021 01:11:05 -0700 (PDT)
Subject: Re: [PATCH 1/1] IB/isert: align target max I/O size to initiator size
To:     Max Gurtovoy <mgurtovoy@nvidia.com>,
        Sagi Grimberg <sagi@grimberg.me>
Cc:     israelr@nvidia.com, alaa@nvidia.com, linux-rdma@vger.kernel.org,
        jgg@nvidia.com
References: <20210524085215.29005-1-mgurtovoy@nvidia.com>
 <46c4d30d-510d-b329-4793-8a354642632e@grimberg.me>
 <fdef3991-74e1-63f1-593e-ac2018286ae9@nvidia.com>
 <b62e5d29-025a-0827-ecad-a48812114220@redhat.com>
 <e6623d9e-0122-ea0c-e148-f739bd15b0bb@nvidia.com>
 <0e4f17d0-5237-e9ae-44a0-4891a53bb26a@grimberg.me>
 <2237ccdf-e2b0-aab3-6e3f-297e5b7791a1@nvidia.com>
From:   Kamal Heib <kheib@redhat.com>
Message-ID: <82ef613c-2697-261e-317e-b40d09cf0764@redhat.com>
Date:   Sun, 20 Jun 2021 11:11:03 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <2237ccdf-e2b0-aab3-6e3f-297e5b7791a1@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 6/9/21 11:45 AM, Max Gurtovoy wrote:
> 
> On 6/9/2021 2:04 AM, Sagi Grimberg wrote:
>>
>>>> On 5/25/21 7:22 PM, Max Gurtovoy wrote:
>>>>> On 5/25/2021 6:54 PM, Sagi Grimberg wrote:
>>>>>>> Since the Linux iser initiator default max I/O size set to 512KB and
>>>>>>> since there is no handshake procedure for this size in iser 
>>>>>>> protocol,
>>>>>>> set the default max IO size of the target to 512KB as well.
>>>>>>>
>>>>>>> For changing the default values, there is a module parameter for 
>>>>>>> both
>>>>>>> drivers.
>>>>>> Is this solving a bug?
>>>>> No. Only OOB for some old connect-IB devices.
>>>>>
>>>>> I think it's reasonable to align initiator and target defaults anyway.
>>>>>
>>>>>
>>>> Actually, this patch is solving a bug when trying iser over 
>>>> Connect-IB, We see
>>>> the following failure when trying to do discovery:
>>>
>>> You can work around this using the ib_isert sg_tablesize module param 
>>> and set it to 128.
>>>
>>> So it's more OOB behavior than a bug.
>>>
>>> Anyway, This is good practice to be able to establish connections 
>>> also for old devices without WAs and we also aligning to the sg_table 
>>> size in the initiator side.
>>>
>>> Jason/Sagi,
>>>
>>> can you comment on this patch for 5.14 ?
>>
>> Actually, if this is the case, why not have a fallback when creating the
>> QP? Seems more reasonable to have the exception for the old devices
>> rather than having those mandate the common denominator no?
> 
> We first wanted to support 16MiB for isert but then we get a report from 
> Chelsio that it will dramatically reduce the total amount of connections 
> the can support.
> 
> So we created a module param and reduced the default to 1MiB. Now we 
> have similar issue with Connect-IB so reducing it to 512KiB (same as the 
> default for Linux iser initiator) seems reasonable.
> 
> Users that would like larger sg_table will use the module param.
> 
> I would avoid doing fallbacks for that and maintain a code that might be 
> dead in a year or two.
> 
> 

Well, from the distro's point of view this code is not going to be dead any time
soon..., And the current user experience is very bad, Could you guys please
decide on a way to fix this issue?

Thanks,
Kamal

