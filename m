Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE4463F8F6C
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Aug 2021 22:03:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243474AbhHZUEF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 26 Aug 2021 16:04:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243459AbhHZUEC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 26 Aug 2021 16:04:02 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AF88C061757;
        Thu, 26 Aug 2021 13:03:15 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id c19-20020a9d6153000000b0051829acbfc7so5018961otk.9;
        Thu, 26 Aug 2021 13:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rX3dhwons3Ttx0/Lf5ADeqFx8MRTLQL7F8T8xTFWwqA=;
        b=S/OA4Zv8h2UTwXcCHDGIQFoYz2XxPPhqy4oCVpxKPYek4hzt7TfqXiuFLBl6jQX8V2
         +mHsuOjn+dlc0Xt2onSNLJfDimQJuqvMP2J8P+WZhQSus4mcJ130pqXmMP/nqjr/tqSn
         Fx+8x/BzwLN64eETgtb6DIEhBjTZBo56VC4Oq4aAbYNSfG/wG/buKfwRwfLYrgOh+oqv
         Ryvofw0LtNZZH5gtgYVCAm2r5yJKtZiokTM3TDpWlON72EpqvsQFaff58HCMxeEHlkOI
         /FkKrjok2xeCU2a8m9x/h6Br3Tc2bQvj/I/SaKdKFNBA+FV3ILCopaR5rsweDvv60gwV
         cjgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rX3dhwons3Ttx0/Lf5ADeqFx8MRTLQL7F8T8xTFWwqA=;
        b=MsLn7AFfo21nGTCEPJcJ192fVTa9B5B3Be15lKmySvIBRFM9qvh3GX+dR0H3c2fV9v
         jPx49GmN+JNOAZww/vKKfIWKW/bP3v7NNVls7ondHiGgtoyRZSFbOFnifyzMdzmm2Dhw
         FlusCOTC4wfEhOaFLDf/1J5JbQRXo+qZ7cpJ37GKDGUel2VxYaQCZP0PZ/yrn/5ONLwR
         Oa5Iglpp7jXawNdcnndNKeB4mBIR+cpZPAsyPd4Dif8O1jcYw5lnEKgbnmMEM1DdARLo
         QwRlZgBW3vxXuKqwFsb0g8k/BmzUs9WtkXP42YSnizZa5qvAoNRXR4yKd2XTnEPPu4tb
         1aLA==
X-Gm-Message-State: AOAM530ixp2XAwtmWCRKjHICEUmK2EKSGVlorPVfu19AD47sYNwALEMn
        3ZxlfkuR/7IMCVwtuelERiNNzAAjBmQ=
X-Google-Smtp-Source: ABdhPJwXqpcsAeG1+fMrFWWrUgGiLSm6+8gL979bEzGegaa7hpa7QMrzL4HumMjYPkhZ84evmuYE+g==
X-Received: by 2002:a05:6830:911:: with SMTP id v17mr4842646ott.133.1630008194287;
        Thu, 26 Aug 2021 13:03:14 -0700 (PDT)
Received: from ?IPv6:2603:8081:140c:1a00:fb42:55db:45a:a9e8? (2603-8081-140c-1a00-fb42-55db-045a-a9e8.res6.spectrum.com. [2603:8081:140c:1a00:fb42:55db:45a:a9e8])
        by smtp.gmail.com with ESMTPSA id c75sm793877oob.47.2021.08.26.13.03.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Aug 2021 13:03:14 -0700 (PDT)
Subject: Re: v5.14 RXE driver broken?
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Zhu Yanjun <zyjzyj2000@gmail.com>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <c3d1a966-b9b0-d015-38ec-86270b5045fc@acm.org>
 <CAD=hENcriq-mwnvzY3UdowuGpKb=Uekvk-v8Lj0G=QB-qK0kJg@mail.gmail.com>
 <20210825163219.GY543798@ziepe.ca>
 <5ab2f7f1-2e76-b3f2-7dee-39d38dfeb25e@gmail.com>
Message-ID: <baca0d7a-d254-1fb2-977c-6c3176ba4e5a@gmail.com>
Date:   Thu, 26 Aug 2021 15:03:13 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <5ab2f7f1-2e76-b3f2-7dee-39d38dfeb25e@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 8/26/21 2:03 PM, Bob Pearson wrote:
> On 8/25/21 11:32 AM, Jason Gunthorpe wrote:
>> On Wed, Aug 25, 2021 at 11:02:14AM +0800, Zhu Yanjun wrote:
>>> On Tue, Aug 24, 2021 at 11:02 AM Bart Van Assche <bvanassche@acm.org> wrote:
>>>>
>>>> Hi Bob,
>>>>
>>>> If I run the following test against Linus' master branch then that test
>>>> passes (commit d5ae8d7f85b7 ("Revert "media: dvb header files: move some
>>>> headers to staging"")):
>>>>
>>>> # export use_siw=1 && modprobe brd && (cd blktests && ./check -q srp/002)
>>>> srp/002 (File I/O on top of multipath concurrently with logout and login (mq)) [passed]
>>>>     runtime    ...  48.849s
>>>>
>>>> The following test fails:
>>>>
>>>> # export use_siw= && modprobe brd && (cd blktests && ./check -q srp/002)
>>>> srp/002 (File I/O on top of multipath concurrently with logout and login (mq)) [failed]
>>>>     runtime  48.849s  ...  15.024s
>>>>     +++ /home/bart/software/blktests/results/nodev/srp/002.out.bad      2021-08-23 19:51:05.182958728 -0700
>>>>     @@ -1,2 +1 @@
>>>>      Configured SRP target driver
>>>>     -Passed
>>>
>>> Can this commit "RDMA/rxe: Zero out index member of struct rxe_queue"
>>> in the link https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git/commit/?h=wip/jgg-for-rc
>>> fix this problem?
>>>
>>> And the commit will be merged into linux upstream very soon.
>>
>> Please let me know Bart, if the rxe driver is still broken I will
>> definitely punt all the changes for RXE to the next cycle until it can
>> be fixed.
>>
>> Jason
>>
> 
> Jason, Bart, Zhu
> 
> I have succeeded in getting blktest to pass on 5.14. There is a bug in rxe that I had to fix. In
> loopback mode when an RNR NAK is received it requests the requester to start a retry sequence
> before the rnr timer fires which results in the command being retried immediately regardless of the
> value of the timeout. I made a small change which requires the requester to wait for either the
> timer to fire or an ack to arrive. The srp/002 test case in blktest spends a long time before posting
> a receive in some cases which caused a soft lockup. There is a second non-bug which is the number of
> MRs was too small to run the test. I increased these by a factor of 256 which fixed that.
> 
> My test setup has for-next + 5 recent rxe fix patches applied in addition to the RNR timing one above.
> 
> I will submit a patch for the rnr fix.
> 
> Bob
> 

Well it's better but not quite done yet.
