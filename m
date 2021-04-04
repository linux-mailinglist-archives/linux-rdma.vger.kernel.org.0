Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 008AF3538DD
	for <lists+linux-rdma@lfdr.de>; Sun,  4 Apr 2021 18:39:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbhDDQjs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 4 Apr 2021 12:39:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbhDDQjr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 4 Apr 2021 12:39:47 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FD13C061756
        for <linux-rdma@vger.kernel.org>; Sun,  4 Apr 2021 09:39:43 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id t23-20020a0568301e37b02901b65ab30024so9406476otr.4
        for <linux-rdma@vger.kernel.org>; Sun, 04 Apr 2021 09:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SahPTSoYWBP60LH5o6hGyQN6/DK3dX91rxs/xxPtJ1A=;
        b=uR51A5yyyeHhjCMo9Z7b1+77DGqLeidGb5DW49bEIMH4vKWru6nfQH7jRHB/6wVmmR
         bvho6vrUlM25fSYdxWNKmZdnnTZgmdCEnjdY2LOmocMAzEK3rLQKt6rwqmvYGAJMXL1Q
         ELWsRiEEefHSeCgnZ2NaX4sLaVPK9PIdB0Db8RtcXDGYDPsGEmuCdN3+hsxvxiF73KIh
         lvYigRorY3wTk3zmQonBeGJzNus0Y0JHZSQoijjK7qTefapFeK8iC0eJ83A2LkJdLmc1
         FM0tplahBkUVMAufsX0hpJZQ4gQTfwRd5pc1/onPlqn6V/34IcxOgs1DODTQkQUxKSuw
         viXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SahPTSoYWBP60LH5o6hGyQN6/DK3dX91rxs/xxPtJ1A=;
        b=SkoK0DiqMQOKS2Fk8wK+dYuIbLcntCpqs4GxSWvx5IZ3OFdhYUgAKgH1dVyGwmiBh+
         JY3swfKnw296seM2hG8xzwtG7WZSVYtOiiWkCrW+gvveBahCk4mVs0N+XsmsizFxDYh5
         8otY/aUvIgh2U6LZlljdNNPazxxCMx6fikgazZOOOtTBu1pMhlbKGrfOr+IQSrXemdy7
         SVD+ZCU3KIyWTJ6lQneU5pJcG1rWsf3xHswdFqrppTvwJjrncLl8eYlhhBHKY4auL+Sl
         mmZwFqAGl1Xwv6e8mzF/ljuhCBMECLJdyvInN345qX4PoFk87wUND2NHprBq3Yhn0HfK
         hung==
X-Gm-Message-State: AOAM532zBcY6PIA3sQcXYdBcTZKpkO2sjfZKzUJFYcnKIL9N3qtow7ej
        F8jdOTsHxOCJedFXvu1q/EE=
X-Google-Smtp-Source: ABdhPJx9AvBVqSfSwmWl7Xezqu5DteydvoFT0WVXocfdVkRNijXeI/iq8Glk2F05mSEcX7Dm/5TVqQ==
X-Received: by 2002:a9d:4d8f:: with SMTP id u15mr19451760otk.296.1617554382792;
        Sun, 04 Apr 2021 09:39:42 -0700 (PDT)
Received: from ?IPv6:2603:8081:140c:1a00:fc16:2b19:7148:d67a? (2603-8081-140c-1a00-fc16-2b19-7148-d67a.res6.spectrum.com. [2603:8081:140c:1a00:fc16:2b19:7148:d67a])
        by smtp.gmail.com with ESMTPSA id j72sm2669877oih.46.2021.04.04.09.39.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Apr 2021 09:39:42 -0700 (PDT)
Subject: Re: [PATCH for-next v2] RDMA/rxe: Split MEM into MR and MW
To:     Mark Bloch <mbloch@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>
Cc:     zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org,
        Bob Pearson <rpearson@hpe.com>
References: <20210325212425.2792-1-rpearson@hpe.com>
 <20210330201245.GA1447467@nvidia.com>
 <d008b9f1-ba94-725b-2753-d586a4e400bb@gmail.com>
 <7456d7f7-628e-0393-eca9-726c0f5a643b@nvidia.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
Message-ID: <7c1e4425-94ac-facb-810c-4d762894e64d@gmail.com>
Date:   Sun, 4 Apr 2021 11:39:41 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <7456d7f7-628e-0393-eca9-726c0f5a643b@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 4/4/21 2:41 AM, Mark Bloch wrote:
> On 4/3/21 10:00 PM, Bob Pearson wrote:
>> On 3/30/21 3:12 PM, Jason Gunthorpe wrote:
>>> On Thu, Mar 25, 2021 at 04:24:26PM -0500, Bob Pearson wrote:
>>>> In the original rxe implementation it was intended to use a common
>>>> object to represent MRs and MWs but they are different enough to
>>>> separate these into two objects.
>>>>
>>>> This allows replacing the mem name with mr for MRs which is more
>>>> consistent with the style for the other objects and less likely
>>>> to be confusing. This is a long patch that mostly changes mem to
>>>> mr where it makes sense and adds a new rxe_mw struct.
>>>>
>>>> Signed-off-by: Bob Pearson <rpearson@hpe.com>
>>>> Acked-by: Zhu Yanjun <zyjzyj2000@gmail.com>
>>>> ---
>>>> v2:
>>>>  v1 of this patch included some fields in the new rxe_mw struct
>>>>  which were not yet needed. They are removed in v2.
>>>>  This patch includes changes needed to address the fact that
>>>>  the ib_mw struct is now being allocated in rdma/core.
>>>
>>> Applied to for-next
>>>
>>> I touched it with clang-format first though, lots of little whitespace
>>> issues
>>>
>>> Thanks,
>>> Jason
>>>
>>
>> When you apply to for-next where does it go? Until it shows up somewhere
>> I need to apply the patch but since you changed it I don't know what it
>> ended up as. If I knew which tree contained the patch I could figure it out.
>>
>> Thanks,
> 
> You should see it here: wip/jgg-for-next
> https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git/log/?h=wip/jgg-for-next
> https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git/commit/?h=wip/jgg-for-next&id=364e282c4fe7e24a5f32cd6e93e1056c6a6e3d31
> 
> Mark
> 
>>
>> Bob
>>
> 
Thanks.
