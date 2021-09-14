Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3195240A52C
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Sep 2021 06:18:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231817AbhINETd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 14 Sep 2021 00:19:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231393AbhINETc (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 14 Sep 2021 00:19:32 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D941C061574
        for <linux-rdma@vger.kernel.org>; Mon, 13 Sep 2021 21:18:16 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id w144so17146782oie.13
        for <linux-rdma@vger.kernel.org>; Mon, 13 Sep 2021 21:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=vNO9EQdjRrzltngyNbJDXAic8XRtC16tVcZ4XwQJHVU=;
        b=dXpcDuBwZd5PvBBV2J0rG51TEPMVO521rjNPgX3g+xpwlsorBAoSDEYn6kOx6K9q8b
         2iC+B1EzrsiDsXGGGZ8YC/EZ7wc7dnzYRnUDJixTEVSGAfSdCMNlO4VGbWxXt55yKDX6
         ZlwsvubUbqCOwnVQH4Miut6VDleBRgEnbO5mV6jv58ysgThGuqaJmTvZYWJRSq2K0n2F
         gyWPB9iyFTxgSOFhx2SBHAFak7YKadkluPNnQvGI6pvo9+SHAufZlQXL2xSLTYf5gXc+
         RKLU28EfgLNxvlic0I4i/hWnR4WGpEj8CfhfON0cYYtRUcdF+z+N+b1mM1MHgK2eMbjK
         HCJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vNO9EQdjRrzltngyNbJDXAic8XRtC16tVcZ4XwQJHVU=;
        b=X7+TwSbnDEhFM+MMBMgUUvOljFvEpSKqHxC5jOIaKSzqeRBCNxwlI+/4UvTi3WhQJv
         DT/IQxBRaJFxcqJgVvKHgQAevGOutSvVBK7hcwBCN5yEEFceK6AA/3nfqYFuijNONO8Y
         4VrwSvgeCuj0dfkRoGWkx172VY+3g5j6NXBK/hhyj6xNNZala+vMoAvdaCPQChDeVfNv
         Pj6eyrx2bZWBFde3AXVU8RVS95WxgAx62sy2RSqx2URzAW/pBmz0JcwJSANaZ1rWnqRB
         oIT25fuYs5nSV1FPMe3LfnLSce1L3/EW7Wf7EOfjo0/8LvAu2rS4ZZfXCeYVtTCi1EJq
         hoBg==
X-Gm-Message-State: AOAM533z5TUN/4ROaVtBEkAqH0dO/K0MANt/hAdN7fLcICiPmHYOEDYS
        uWhLhcU2+plNu4KFCef+vng=
X-Google-Smtp-Source: ABdhPJz+WLja+vGo0u12zKwMMGcid4AR1DzSLxLAHBQris+v3n3WCjQLNf8mkBzKX2u+x1OZINrAeA==
X-Received: by 2002:aca:d02:: with SMTP id 2mr10548870oin.126.1631593095463;
        Mon, 13 Sep 2021 21:18:15 -0700 (PDT)
Received: from ?IPv6:2603:8081:140c:1a00:d9f3:4e7a:72f1:83fe? (2603-8081-140c-1a00-d9f3-4e7a-72f1-83fe.res6.spectrum.com. [2603:8081:140c:1a00:d9f3:4e7a:72f1:83fe])
        by smtp.gmail.com with ESMTPSA id a10sm2149502oil.30.2021.09.13.21.18.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Sep 2021 21:18:14 -0700 (PDT)
Subject: Re: [PATCH for-rc v3 0/6] RDMA/rxe: Various bug fixes.
To:     Bart Van Assche <bvanassche@acm.org>,
        "Pearson, Robert B" <robert.pearson2@hpe.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "mie@igel.co.jp" <mie@igel.co.jp>,
        Xiao Yang <yangx.jy@fujitsu.com>,
        Rao Shoaib <Rao.Shoaib@oracle.com>
References: <20210909204456.7476-1-rpearsonhpe@gmail.com>
 <f0d96a3c-d49d-651d-93e0-a33a5eca9f1b@acm.org>
 <CS1PR8401MB10777EEC9CF95C00D1BA62ABBCD69@CS1PR8401MB1077.NAMPRD84.PROD.OUTLOOK.COM>
 <2cb4e1cb-4552-9391-164a-88f638dd3acf@acm.org>
 <cf358367-5cb8-0482-28e6-993a4f6bb047@gmail.com>
 <918787c7-de06-ef67-80ac-ae2e7643dd61@acm.org>
 <557a5fd9-2a30-5752-d09b-05183ab3c43b@gmail.com>
 <4d4cdf11-a073-75ce-7bf3-cf07cc205227@acm.org>
From:   Bob Pearson <rpearsonhpe@gmail.com>
Message-ID: <114d9577-7f82-4df2-5c7e-8f51878a1b9e@gmail.com>
Date:   Mon, 13 Sep 2021 23:18:13 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <4d4cdf11-a073-75ce-7bf3-cf07cc205227@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 9/13/21 10:26 PM, Bart Van Assche wrote:
> On 9/12/21 07:41, Bob Pearson wrote:
>> Fixes: 5bcf5a59c41e ("RDMA/rxe: Protext kernel index from user space")
>> Signed-off-by: Xiao Yang <yangx.jy@fujitsu.com>
>> ---
>>   drivers/infiniband/sw/rxe/rxe_queue.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/infiniband/sw/rxe/rxe_queue.c b/drivers/infiniband/sw/rxe/rxe_queue.c
>> index 85b812586ed4..72d95398e604 100644
>> --- a/drivers/infiniband/sw/rxe/rxe_queue.c
>> +++ b/drivers/infiniband/sw/rxe/rxe_queue.c
>> @@ -63,7 +63,7 @@ struct rxe_queue *rxe_queue_init(struct rxe_dev *rxe, int *num_elem,
>>       if (*num_elem < 0)
>>           goto err1;
>>   -    q = kmalloc(sizeof(*q), GFP_KERNEL);
>> +    q = kzalloc(sizeof(*q), GFP_KERNEL);
>>       if (!q)
>>           goto err1;
> 
> Hi Bob,
> 
> If I rebase this patch series on top of kernel v5.15-rc1 then the srp tests from the blktests suite pass. Kernel v5.15-rc1 includes the above patch. Feel free to add the following to this patch series:
> 
> Tested-by: Bart Van Assche <bvanassche@acm.org>
> 
> Thanks,
> 
> Bart.

Sadly, I have been trying to resolve the note from Shaib Rao who was trying to make rping work.
His solution was not correct but it led to a can of worms. The kernel verbs consumer APIs were all
using the same APIs from rxe_queue.h to manipulate the client ends of the queues but that was
totally incorrect. These are written from the POV of the driver and use the private index which
is not supposed to be visible to users of the queues. A whole day later I think I have that one about
fixed. So I will be resubmitting the series again in the morning. Its all just memory barriers so
it may not affect you.

Bob
