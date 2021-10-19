Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B72E433C68
	for <lists+linux-rdma@lfdr.de>; Tue, 19 Oct 2021 18:35:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbhJSQhp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 19 Oct 2021 12:37:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234351AbhJSQho (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 19 Oct 2021 12:37:44 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B30CC06161C
        for <linux-rdma@vger.kernel.org>; Tue, 19 Oct 2021 09:35:32 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id o4so5784871oia.10
        for <linux-rdma@vger.kernel.org>; Tue, 19 Oct 2021 09:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9+tp2db3n9+upPeOtf+zoNBOTN89gz41PdPdp5d4epc=;
        b=NglykX21v78kR/Xv7+Naasv2c/BoQLw1hcSuKirieODrfiX02fJyByvt6AI98Q+ZOi
         UWxUrQs0gBKzKX+fJw2/mZubY7xrPd/PQt84ZuDfXj0LD5RTCrusf89RYNtBtzisKpE1
         UGFnQUhNfLoZUCzN4qMDiEDPmAkz07JRHZGQwFs3QscXscfmytHwWz7jMte+qx6EqPj5
         dU4CHCJix/98DPktvGV9aCYj1ARq/xNi1+gsaCtRIY7hsRs0zdF8FkmdBkOOGemCVvjV
         aB0TyimwebgBrHwJDn+djpcXYwIpnushuNRAg4IdB1pRDhoHPySbjmCfCVR0DznPY5o/
         Awuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9+tp2db3n9+upPeOtf+zoNBOTN89gz41PdPdp5d4epc=;
        b=I4/fq5AaDqzbyAkep5sdIkffemZsY3KTelU2A9LhvE9W2K2T+a6xktEOuBCp4HRAmC
         C1mH/Lm307PXp8/1/m7k/5+MHlNypT4MKGuYiPfp8izgh+GJLxH+TXiWMkhMzW+gDH3R
         J1wgOd9B+uUX7mmJeKsO76OI2HytzXIeF+2XZlMHDzzqSerscApQ3BHkBQKBP9Fke1TD
         wg8MGwpTy9TWCaQMkOyx+jPvS1Y3BhNnHu2i8CPz6l/L5wxCH6IC3/Lf/2+9ncNW1fUy
         DfBVElTkpWhuAbFtcHSlPSvb0PkkjO+gqu+qfhqEo4vBz1HjZKTjIGMY1EdFaj96jfB8
         KH2Q==
X-Gm-Message-State: AOAM531aaE27vwm2ZFBoYUgN3+9tgRgfbYpotMRUJM+Z6V/3SS3je0w7
        bd7RXF5hNIu5ldGGXzEIYCOHNNTP+NU=
X-Google-Smtp-Source: ABdhPJw7q5d1xVuRE3PQFgCNhv8MYi3TO8g5exY4jtV6X0uY51k+xfYDb2hXK78MqiWj6GYQGqeyYA==
X-Received: by 2002:a05:6808:5d5:: with SMTP id d21mr4817680oij.104.1634661331233;
        Tue, 19 Oct 2021 09:35:31 -0700 (PDT)
Received: from ?IPv6:2603:8081:140c:1a00:86d0:e43b:a488:e722? (2603-8081-140c-1a00-86d0-e43b-a488-e722.res6.spectrum.com. [2603:8081:140c:1a00:86d0:e43b:a488:e722])
        by smtp.gmail.com with ESMTPSA id c3sm3821248otr.42.2021.10.19.09.35.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Oct 2021 09:35:30 -0700 (PDT)
Subject: Re: [PATCH for-next 0/6] RDMA/rxe: Fix potential races
To:     Leon Romanovsky <leon@kernel.org>
Cc:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
References: <20211010235931.24042-1-rpearsonhpe@gmail.com>
 <YWUskJBU5ZHrIhhS@unreal> <bfb21e28-2f92-e372-871e-32c5f72338f4@gmail.com>
 <YW7DGrG04eJwbf7d@unreal>
From:   Bob Pearson <rpearsonhpe@gmail.com>
Message-ID: <ccdf6ffa-dc14-7b50-7a17-c0d01d9305bf@gmail.com>
Date:   Tue, 19 Oct 2021 11:35:30 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YW7DGrG04eJwbf7d@unreal>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 10/19/21 8:07 AM, Leon Romanovsky wrote:
> On Tue, Oct 12, 2021 at 03:19:46PM -0500, Bob Pearson wrote:
>> On 10/12/21 1:34 AM, Leon Romanovsky wrote:
>>> On Sun, Oct 10, 2021 at 06:59:25PM -0500, Bob Pearson wrote:
>>>> There are possible race conditions related to attempting to access
>>>> rxe pool objects at the same time as the pools or elements are being
>>>> freed. This series of patches addresses these races.
>>>
>>> Can we get rid of this pool?
>>>
>>> Thanks
>>>
>>>>
>>>> Bob Pearson (6):
>>>>   RDMA/rxe: Make rxe_alloc() take pool lock
>>>>   RDMA/rxe: Copy setup parameters into rxe_pool
>>>>   RDMA/rxe: Save object pointer in pool element
>>>>   RDMA/rxe: Combine rxe_add_index with rxe_alloc
>>>>   RDMA/rxe: Combine rxe_add_key with rxe_alloc
>>>>   RDMA/rxe: Fix potential race condition in rxe_pool
>>>>
>>>>  drivers/infiniband/sw/rxe/rxe_mcast.c |   5 +-
>>>>  drivers/infiniband/sw/rxe/rxe_mr.c    |   1 -
>>>>  drivers/infiniband/sw/rxe/rxe_mw.c    |   5 +-
>>>>  drivers/infiniband/sw/rxe/rxe_pool.c  | 235 +++++++++++++-------------
>>>>  drivers/infiniband/sw/rxe/rxe_pool.h  |  67 +++-----
>>>>  drivers/infiniband/sw/rxe/rxe_verbs.c |  10 --
>>>>  6 files changed, 140 insertions(+), 183 deletions(-)
>>>>
>>>> -- 
>>>> 2.30.2
>>>>
>>
>> Not sure which 'this' you mean? This set of patches is motivated by someone at HPE
>> running into seg faults caused very infrequently by rdma packets causing seg faults
>> when trying to copy data to or from an MR. This can only happen (other than just dumb
>> bug which doesn't seem to be the case) by a late packet arriving after the MR is
>> de-registered. The root cause of that is the way rxe currently defers cleaning up
>> objects with krefs and potential races between cleanup and new packets looking up
>> rkeys. I found a lot of potential race conditions and tried to close them off. There
>> are another couple of patches coming as well.
> 
> I have no doubts that this series fixes RXE, but my request was more general.
> Is there way/path to remove everything declared in rxe_pool.c|h?
> 
> Thanks
> 

Take a look at the note I copied you on more recently. There is some progress but not
complete elimination of rxe_pool. There is another project suggested by Jason which is
replacing red black trees by xarrays as an alternative approach to indexing rdma objects.
This would still duplicate the indexing done by rdma-core. A while back I looked at
trying to reuse the rdma-core indexing but no effort was made to make that easy. All
of the APIs are private to rdma-core. These indices are managed by the rxe driver for
use as lkeys/rkeys, qpns, srqns, and more recently address handles. xarrays seem to be
more efficient when the indices are fairly compact. There is a suggestion that IB and RoCE
should attempt to make indices that are visible on the network more sparse. Nothing
will make them secure but they could be a lot more secure than they are currently. I
believe mlx5 is now using random keys for this reason.

Bob 
