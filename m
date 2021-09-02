Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B3DF3FF458
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Sep 2021 21:49:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231670AbhIBTuO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 2 Sep 2021 15:50:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231467AbhIBTuK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 2 Sep 2021 15:50:10 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C54C9C061575
        for <linux-rdma@vger.kernel.org>; Thu,  2 Sep 2021 12:49:11 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id c42-20020a05683034aa00b0051f4b99c40cso4025525otu.0
        for <linux-rdma@vger.kernel.org>; Thu, 02 Sep 2021 12:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EzyrU+xa0Yrkk9Q3P/3AlPjyEmcIvLAv99Z9aOwVVvo=;
        b=XUyymOwsXKkB9Dfk0BjcvSdj4fJGG7dLlsVJgBW3FE8dCgHDiy/JeLrqj6e3eXkBdp
         yEj0nnRZh8PR/D2Y6u+pIHzQuWhdSMomQ9UCKzAHHQPZGcFmVYRCtCATF8VUHTEGvoGb
         y0kvPnupdfaU01p2ImdzNAWeezf7h92/qMRba20NyO+tRFT6bDTsAsv2iFPA+6aV62ZZ
         Qz3o5eBQzUWS7P5HPeIDQntptPnEkDvnbrV63r3GujoZZQpQY/nzYNTKrB/1Hw7b+Hs8
         DA8eWkCYYuIQJaWIijo21CYy7/RMBsVh/tYtqEfi79OgLBv/Knsq4MpYCCDZXdnINvwb
         /Xaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EzyrU+xa0Yrkk9Q3P/3AlPjyEmcIvLAv99Z9aOwVVvo=;
        b=iOrnTscKEPw5Fm8VEyeR4TxTY0jyPRbuHF90Yx3Br70mlaQaTGPoyTFwQE49cK3SKR
         Ht9j7bbRCU5WKViy5r4xZ3M5EYV85mp+yU3dZx4zdnTOI9laxb0qDna5erKgx+BZ9mo0
         Qf4kiNDFwdO3zFRNJ1+egN1hs2U/eTzLydE7cMS8qAYo9r/tJIOArEDqJjYSRJBJtmwz
         F5ubtFxYRjeC5eQGWlj0cRBwcVh1ssCQ3AMGMYDd+110aAt6xmcgKf43wHJa/sRvOk93
         P/rM7fLTSn81Q5XoSJ44JFwGBp/roQg6+ee16lfIaesgRcjbFSIBhmos6N2l4zs2eanG
         5O2A==
X-Gm-Message-State: AOAM530T388HIu+Tqebup+SaIsyloNKSzgQ6e3y6YgyO6feUP/a5/CwE
        2VL+Padrm530hGbXBFcboTT4f1GcVRg=
X-Google-Smtp-Source: ABdhPJxcYuesZtdUSY2GF4PWaxLVy7JXNkY9N+4TOnHp6muWEhhCcgqWf5uSgZG3sQohcHm4hrF/Ug==
X-Received: by 2002:a9d:70cc:: with SMTP id w12mr4014255otj.306.1630612151094;
        Thu, 02 Sep 2021 12:49:11 -0700 (PDT)
Received: from ?IPv6:2603:8081:140c:1a00:4eab:3b55:82a2:257? (2603-8081-140c-1a00-4eab-3b55-82a2-0257.res6.spectrum.com. [2603:8081:140c:1a00:4eab:3b55:82a2:257])
        by smtp.gmail.com with ESMTPSA id bi41sm565947oib.54.2021.09.02.12.49.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Sep 2021 12:49:10 -0700 (PDT)
Subject: Re: rdma link add NAME type rxe netdev IFACE stopped working
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Zhu Yanjun <zyjzyj2000@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <f1c73298-b37f-8589-bdb1-a727c3b7c844@gmail.com>
 <b4a1e866-95ed-7bf1-f9da-bca5700db7e1@gmail.com>
 <20210902130213.GT1200268@ziepe.ca>
From:   Bob Pearson <rpearsonhpe@gmail.com>
Message-ID: <629283f9-2833-62c1-c3cc-e22084bb076a@gmail.com>
Date:   Thu, 2 Sep 2021 14:49:10 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210902130213.GT1200268@ziepe.ca>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 9/2/21 8:02 AM, Jason Gunthorpe wrote:
> On Wed, Sep 01, 2021 at 10:25:25PM -0500, Bob Pearson wrote:
>> On 9/1/21 10:04 PM, Bob Pearson wrote:
>>> rdma link has started to fail today reporting an error as follows after working before.
>>>
>>> bob@ubunto-21:~$ sudo rdma link add rxe0 type rxe netdev enp0s3
>>>
>>> error: Invalid argument
>>>
>>> bob@ubunto-21:
>>>
>>> Nothing has changed in the past day or two except I pulled recent changes into rdma-core. This runs after
>>> typing
>>>
>>> export LD_LIBRARY_PATH=/home/bob/src/rdma-core/build/lib/:/usr/local/lib:/usr/lib
>>>
>>> which is also the same. Any ideas?
>>>
>>> Bob
>>>
>>
>> Update. I then recompiled the kernel after pulling latest changes
>> and now it works. In theory this shouldn't be necessary. The kernel
>> APIs should be beckwards compatible.
> 
> I don't think anything has changed here in a long time, so I have no
> guess
> 
> 'rdma link' has no relation to rdma-core either
> 
> Perhaps your kernel got in a bad state?
> 
> Jason
> 

Must have. Thanks. -- Bob
