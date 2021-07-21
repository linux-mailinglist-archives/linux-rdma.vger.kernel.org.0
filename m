Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D25D53D1962
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Jul 2021 23:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbhGUVHk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 21 Jul 2021 17:07:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbhGUVHk (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 21 Jul 2021 17:07:40 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7849DC061575
        for <linux-rdma@vger.kernel.org>; Wed, 21 Jul 2021 14:48:15 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id a17-20020a9d3e110000b02904ce97efee36so1481535otd.7
        for <linux-rdma@vger.kernel.org>; Wed, 21 Jul 2021 14:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=84YUr5sr6aJY/uAuV/lEr3cBRJ1xw89z9nVlgzgWG78=;
        b=H++ZCL5kKPORl9+Vm9ywdwpuH0JSogSHV/0P0TvbtVh3F7NJgDSRd3jvDHptdndxZf
         Uh93/lNRwtoGk8rO84goP9VZqSdaFAV3GEw17AAlUy5EO3+F2yPkaiquwlkUlZcuQZt7
         yw6pak0wVQ/cqugPLXSDiI5c9IC7fHTiLyr9diksW9Ee9DVYtnx7syri4B2Romm/RWuA
         39y4aev9yhB4TqCdkHoTtDWv/lDZJWXf570k4Txy5qucZnh1W+0S21xTU9R86VrS/yw1
         Bt7SxBSalJLxyqS1IjAQWqP3CyXfJ6VDQoqRofqChNhVgA2/psn9cl2y4+gk0YijXX/L
         yH+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=84YUr5sr6aJY/uAuV/lEr3cBRJ1xw89z9nVlgzgWG78=;
        b=hbyEXONQ4X6sVvbiF4RYBbbVRpVhBgHQ3oCta54VMPEzVhD+njU+UmL1r/04vfl+ac
         9d3CdW8ChA7sXeTvm/VpdhWJG/3Ehqc7jGMLF/1OwIV0yAEvTOxm8S76ib3C+h7nDfZg
         pe9r7ahWeEAB2COm1zbz5Adv1bnuBCIhn7VARMgWQAR3+halbVpsp90dQdHIERnAIHD5
         kpm+SrACk6UsrOvipjQIhLyAFKaZEedFhKqqVo2QSlN3T6lq5QgA55FXDzmaxUfGT109
         8KmEqXgKF7SGoOBvwvbaq+IK7q/bLNQzkRLCEzQVQxej3fpfsXUorcmCU0136suyqWF4
         w7Og==
X-Gm-Message-State: AOAM533qNPCMic4SLKC0sIg9iA3zCBHQBja6oflIUG3MPFn++A8Ga/8z
        +VWDmUl3qOiavrGMFviDE0q0pJsA/pM=
X-Google-Smtp-Source: ABdhPJxHvQw/V/cUYGSMlzVWYp55X/tUg8ceIv+nI4ZjRbPBYehXrV1FYzXN/QGC97kVkH+aie/DSQ==
X-Received: by 2002:a9d:7f94:: with SMTP id t20mr7421050otp.44.1626904094801;
        Wed, 21 Jul 2021 14:48:14 -0700 (PDT)
Received: from ?IPv6:2603:8081:140c:1a00:f09d:c26a:c3f3:d2e6? (2603-8081-140c-1a00-f09d-c26a-c3f3-d2e6.res6.spectrum.com. [2603:8081:140c:1a00:f09d:c26a:c3f3:d2e6])
        by smtp.gmail.com with ESMTPSA id u14sm1128266oth.73.2021.07.21.14.48.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jul 2021 14:48:14 -0700 (PDT)
Subject: Re: RDMA/rxe is broken (impacting running NFSoRDMA over softRoCE)
To:     Olga Kornievskaia <aglo@umich.edu>,
        Leon Romanovsky <leon@kernel.org>
Cc:     Zhu Yanjun <zyjzyj2000@gmail.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        linux-rdma <linux-rdma@vger.kernel.org>
References: <CAN-5tyGbmTjiT+nxXB7BMp6mwpUs+HVUGy-CGXBBrC04jQ3grA@mail.gmail.com>
 <63d7f374-1252-82c8-769d-2d1a540466fd@gmail.com>
 <CAN-5tyFQd3wzRXtcQoO0wC-bU1Ggk05K7ikokY_ZGZidG=CP5A@mail.gmail.com>
 <YPe02wEIHJffalro@unreal>
 <CAN-5tyEDF+KvSLxBNR_1vPdiJTDJMt1hc_ztk3E-J109x+Z4SA@mail.gmail.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
Message-ID: <6a01339f-32bc-d4b5-1bd2-44ce4b1b6e84@gmail.com>
Date:   Wed, 21 Jul 2021 16:48:08 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAN-5tyEDF+KvSLxBNR_1vPdiJTDJMt1hc_ztk3E-J109x+Z4SA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 7/21/21 4:15 PM, Olga Kornievskaia wrote:
> On Wed, Jul 21, 2021 at 1:47 AM Leon Romanovsky <leon@kernel.org> wrote:
>>
>> On Tue, Jul 20, 2021 at 05:48:03PM -0400, Olga Kornievskaia wrote:
>>> On Tue, Jul 20, 2021 at 2:27 AM Bob Pearson <rpearsonhpe@gmail.com> wrote:
>>
>> <...>
>>
>>> There were a number of commits that lead to crashes. commit
>>> ec9bf373f2458f4b5f1ece8b93a07e6204081667 "RDMA/core: Use refcount_t
>>> instead of atomic_t on refcount of ib_uverbs_device" leads to the
>>> following kernel oops. commit 205be5dc9984b67a3b388cbdaa27a2f2644a4bd6
>>> "RDMA/irdma: Fix spelling mistake "Allocal" -> "Allocate"" also leads
>>> to the kernel oops.
>>
>> The commits above aren't relevant to RXE at all.
>>
>> If first commit is wrong, all drivers will experience crashes and second
>> commit is in irdma and not in RXE.
>>
>> And both of them are legit commits.
> 
> Yes I realize they are problems outside of rxe but I didn't run into
> any crashes when I ran rpring on the 5.14-rc1 (it was hanging and
> that's what I reported here) so I thought perhaps later patches have
> addressed the crashes I've seen.
> 
> Would you like me to post a separate email report on the crash(es) (I
> don't recall if it's the same one or two different ones)?
> 
>>
>> Thanks

If you are able please try the patch I just sent. It should make things a little better.
If not I have another idea to try as well.
Bob
