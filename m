Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13B06390893
	for <lists+linux-rdma@lfdr.de>; Tue, 25 May 2021 20:09:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbhEYSKk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 25 May 2021 14:10:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbhEYSKi (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 25 May 2021 14:10:38 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BBEDC061574
        for <linux-rdma@vger.kernel.org>; Tue, 25 May 2021 11:09:07 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id z3so31112862oib.5
        for <linux-rdma@vger.kernel.org>; Tue, 25 May 2021 11:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=k2R/f22/J1Y/Z9X0Hszg1LCVl567AYSVN8XMI6zLRQk=;
        b=hzviaFP88PjQrluTvB38CR9q9OOEtpyM3Q3NgwyagdvSoYpa5li3YKtatpayz43AXk
         3c9vy5LyFm6SHGsifY2J3N8NqnzOomcIIsErinduxJtDvhHUsjNHihmXhOeY7RLJ5Dlc
         LAolJd/7T2mhql37WJlnzD09fzUt3GX8ssm5nlmuuiHjFDtsuj54Rh7O2rEqgi2QUKNt
         Dh+4AODO+/Tk+BGbRKazs3U3/lLUXVr5LELYara4B5RlEKs5/3FX17v6ozTLQ4y0LEVi
         tZN0pUE+4yIY8KRMfsPomjeydl/4ZvTC/GKmyaCEtDn/99zt3uXGRlkYiMF40ezWyLwZ
         /Tvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=k2R/f22/J1Y/Z9X0Hszg1LCVl567AYSVN8XMI6zLRQk=;
        b=cQsqefPyFFNsRtSfu1NDRg7VeiAv3XtUTq/shQmJPZ9JoFVTvrbpTDZKfHaat9ql9a
         UBXjPGbz9a4/BA+2JJVXnBLnGtg5DSsVu5KUOFrORjvoZZ4Vbc7IIVDdyFKsAdsqFcyi
         7jplHotmoOTLfASJaxzd7JJtOd92qXgZUohXORjJbDcByKxaFwv6fbMA3MAYGN049QkS
         qZevhUZ6pSEW9myPe/vRJ+LSI2XB0OPdD5429EWJDiE2MPYnICwwUO6t696C9bS+vITO
         oxyFW5hzg1vCJd8BPFpIMaDCUBZddatD4hHDD6j0Ivm9cquxzqbi2oF6Rbpdv7MShn8I
         qCQw==
X-Gm-Message-State: AOAM531ewFlTaI0Zkzeq0QHD4piKRKjd14KoDoimErPMcR8kb061/Hg9
        BrS+jSSR2lM038pBzgySsbbmghDn0aQ7Zg==
X-Google-Smtp-Source: ABdhPJzpHuFNOFHutlOndKvbGiATNgyoJTGat1cuMuNyDgwDXi3liUOQXy648fYoruJos7UVEuWbMQ==
X-Received: by 2002:aca:e142:: with SMTP id y63mr14892306oig.57.1621966146724;
        Tue, 25 May 2021 11:09:06 -0700 (PDT)
Received: from ?IPv6:2603:8081:140c:1a00:c8b7:c209:b9f4:b5f3? (2603-8081-140c-1a00-c8b7-c209-b9f4-b5f3.res6.spectrum.com. [2603:8081:140c:1a00:c8b7:c209:b9f4:b5f3])
        by smtp.gmail.com with ESMTPSA id i11sm3897146otk.70.2021.05.25.11.09.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 May 2021 11:09:06 -0700 (PDT)
Subject: Re: [PATCH for-next v7 00/10] RDMA/rxe: Implement memory windows
To:     "Pearson, Robert B" <robert.pearson2@hpe.com>,
        Zhu Yanjun <zyjzyj2000@gmail.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
References: <20210521201824.659565-1-rpearsonhpe@gmail.com>
 <CAD=hENeKHgwLEOAsZ+2tu7M-+3Pv9QVccbWSwLy+zV-zX2h-bg@mail.gmail.com>
 <dd81d60d-f4fa-feae-90a0-201ee995e07f@gmail.com>
 <CAD=hENeP=wh2gHAzkyi9KyZrKmDcmQeR3GB46Re-7ufL-CJqXw@mail.gmail.com>
 <CS1PR8401MB1096CDA5C1FF0BD22611015FBC259@CS1PR8401MB1096.NAMPRD84.PROD.OUTLOOK.COM>
 <CAD=hENdi4XC=ZQDnm4TGx2CHTgkQuFWd2ET7GbXOMz1zsz_JRg@mail.gmail.com>
 <CS1PR8401MB10960767E276430FB619CC6ABC259@CS1PR8401MB1096.NAMPRD84.PROD.OUTLOOK.COM>
 <CAD=hENfATTprVG+wYa+1qjdTcuetLyzTt8gHjfcWp5PsLVL4Pw@mail.gmail.com>
 <CS1PR8401MB109691557DEE165AC0B9C47ABC259@CS1PR8401MB1096.NAMPRD84.PROD.OUTLOOK.COM>
From:   "Pearson, Robert B" <rpearsonhpe@gmail.com>
Message-ID: <77192b9c-9d8a-061f-5ffc-1052504104bc@gmail.com>
Date:   Tue, 25 May 2021 13:09:01 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <CS1PR8401MB109691557DEE165AC0B9C47ABC259@CS1PR8401MB1096.NAMPRD84.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 5/25/2021 10:23 AM, Pearson, Robert B wrote:
> On further reflection I realize I did not understand correctly the user/kernel API issue correctly. I was assuming that the user application should continue to run but that we could require re-compiling rdma-core. If we require that old rdma-core binaries run on newer kernels then the 40 bytes is an issue. I always recompiled rdma-core and didn't test running with old binaries. Fortunately there is an easy fix. The flags field in the earlier rxe mw version had one bit in it but the new version dropped that and I never went back and removed the field. Dropping the flags field doesn't break anything but lets the mw struct fit in the wr union without extending it.
>
> I will fix, retest and resubmit.
>
> Bob
>
> -----Original Message-----
> From: Zhu Yanjun <zyjzyj2000@gmail.com>
> Sent: Tuesday, May 25, 2021 10:00 AM
> To: Pearson, Robert B <robert.pearson2@hpe.com>
> Cc: Pearson, Robert B <rpearsonhpe@gmail.com>; Jason Gunthorpe <jgg@nvidia.com>; RDMA mailing list <linux-rdma@vger.kernel.org>
> Subject: Re: [PATCH for-next v7 00/10] RDMA/rxe: Implement memory windows
>
> On Tue, May 25, 2021 at 1:27 PM Pearson, Robert B <robert.pearson2@hpe.com> wrote:
>> There's nothing to change. There is no problem. Just get the headers sync'ed.
>> If that doesn't fix your issues your tree has gotten corrupted somehow. But, I don't think that is the issue. I saw the same type of errors you reported when rdma_core is built with the old header file. That definitely will cause problems. The size of the send queue WQEs changed because new fields were added. Then user space and the kernel immediately get off from each other.
>>
>> Good luck,
> About rdma-core, the root cause is clear. I am fine with this patch series.
> Thanks, Bob.
>
> Zhu Yanjun
>
Well. Interesting. Having pulled latest rdma-core again and fixed the 
wr.mw size issue I now see a bunch of CQ and QP errors which have 
nothing to do with the memory windows patches. It looks more like a 
memory ordering problem around the queues. Is this possibly related to 
the recent relaxed ordering changes?? The one py test failure I have 
chased down is in the resize cq test. The first time it runs after 
building a new module I can print out the new cqe and the current queue 
count and see the expected 1 which is less than 6 but the code takes the 
wrong branch and does not report an error. Rerunning the test I get the 
expected behavior and the test passes. This will take a bit of effort.

Bob

