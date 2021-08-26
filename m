Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83A293F8E6F
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Aug 2021 21:03:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243378AbhHZTEi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 26 Aug 2021 15:04:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243241AbhHZTEh (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 26 Aug 2021 15:04:37 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2738EC061757;
        Thu, 26 Aug 2021 12:03:50 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id i3-20020a056830210300b0051af5666070so4861519otc.4;
        Thu, 26 Aug 2021 12:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QVJge+2AS8TC5IJErVGgCRPnUKEkPLQKxcJt3H4xrwE=;
        b=psMcUV4NooKaQwSKkDNm4xdsjbDEPVRU8ZQwvzjSjrXRVcOz4wUzn5ELSBf1J3mV/o
         WQx1+DmICcOMRbpte/ayi2Oyvd/qgpUSQ/EVnDUrauQaL7tiaEVmrxPFf8LhjMj5ypMf
         Gc5xNrPURjYoWSW7SdicW0ZMdfP+XMTFVGeGRV+X95qTbZhyggGBh/X7+RCK5Y5ekINW
         Xx+NfmonpcPZkFhNLO4PK3AtH+9DStqoPr9Yez5AlChhSUlpnCfWM601EfgYuxZuB1n3
         ao0inKg033Rd8hz70W8Q11YuGDmx85HvxUL2Pe9iSclaWA7C6Dt4pOWf+WJ4i6/gB6SV
         c0pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QVJge+2AS8TC5IJErVGgCRPnUKEkPLQKxcJt3H4xrwE=;
        b=of1YKGcAgLX7Pu6wVUhtb0JERe7oEipDBAacuWuBlGqeZFVPJSQk8thyvj2A00/CIJ
         trZ1wOqgauekFMkC2LIvNu/ixjUgUk0JUH/T81ApxMACPNlWiWFnSEkS+dd2KBXfgPi1
         xNoVaywd+ylp/bB8YLXWOY+c4yhUYIGjLvhh1QdAJVpcu3GQ0Tc5AAwWem6snxUbJcCT
         v4arcwzLcvQb2fO/a/KBlQ/HVeeDv1KD1CDGLzZPM1dLtpTc+2ndeKJAvdft2IGRyV1A
         a3UZpZS+0ftrjg5YAqmd73WGOwZyk3DoPnPHdHgkX7z/pUStYhRVazRPFPYNHOX3rT1i
         2abA==
X-Gm-Message-State: AOAM530dYftxRqDKQ1ulW0ngqFd1srmIF621aiajNBXRECji7OvYaMcm
        JxaG2fhLYAvbMXVI2UT52EHuYBIL2P8=
X-Google-Smtp-Source: ABdhPJwlyd4HrjoAMGxpHWGl4lo2hG5L8zL37ymgGMWqpgzojSmXNj1dbee2V2U9+vWUopAHxeHDxA==
X-Received: by 2002:a05:6830:2a06:: with SMTP id y6mr4362786otu.134.1630004629073;
        Thu, 26 Aug 2021 12:03:49 -0700 (PDT)
Received: from ?IPv6:2603:8081:140c:1a00:3615:bca2:7e39:65f1? (2603-8081-140c-1a00-3615-bca2-7e39-65f1.res6.spectrum.com. [2603:8081:140c:1a00:3615:bca2:7e39:65f1])
        by smtp.gmail.com with ESMTPSA id r15sm757992oth.7.2021.08.26.12.03.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Aug 2021 12:03:48 -0700 (PDT)
Subject: Re: v5.14 RXE driver broken?
To:     Jason Gunthorpe <jgg@ziepe.ca>, Zhu Yanjun <zyjzyj2000@gmail.com>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <c3d1a966-b9b0-d015-38ec-86270b5045fc@acm.org>
 <CAD=hENcriq-mwnvzY3UdowuGpKb=Uekvk-v8Lj0G=QB-qK0kJg@mail.gmail.com>
 <20210825163219.GY543798@ziepe.ca>
From:   Bob Pearson <rpearsonhpe@gmail.com>
Message-ID: <5ab2f7f1-2e76-b3f2-7dee-39d38dfeb25e@gmail.com>
Date:   Thu, 26 Aug 2021 14:03:48 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210825163219.GY543798@ziepe.ca>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 8/25/21 11:32 AM, Jason Gunthorpe wrote:
> On Wed, Aug 25, 2021 at 11:02:14AM +0800, Zhu Yanjun wrote:
>> On Tue, Aug 24, 2021 at 11:02 AM Bart Van Assche <bvanassche@acm.org> wrote:
>>>
>>> Hi Bob,
>>>
>>> If I run the following test against Linus' master branch then that test
>>> passes (commit d5ae8d7f85b7 ("Revert "media: dvb header files: move some
>>> headers to staging"")):
>>>
>>> # export use_siw=1 && modprobe brd && (cd blktests && ./check -q srp/002)
>>> srp/002 (File I/O on top of multipath concurrently with logout and login (mq)) [passed]
>>>     runtime    ...  48.849s
>>>
>>> The following test fails:
>>>
>>> # export use_siw= && modprobe brd && (cd blktests && ./check -q srp/002)
>>> srp/002 (File I/O on top of multipath concurrently with logout and login (mq)) [failed]
>>>     runtime  48.849s  ...  15.024s
>>>     +++ /home/bart/software/blktests/results/nodev/srp/002.out.bad      2021-08-23 19:51:05.182958728 -0700
>>>     @@ -1,2 +1 @@
>>>      Configured SRP target driver
>>>     -Passed
>>
>> Can this commit "RDMA/rxe: Zero out index member of struct rxe_queue"
>> in the link https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git/commit/?h=wip/jgg-for-rc
>> fix this problem?
>>
>> And the commit will be merged into linux upstream very soon.
> 
> Please let me know Bart, if the rxe driver is still broken I will
> definitely punt all the changes for RXE to the next cycle until it can
> be fixed.
> 
> Jason
> 

Jason, Bart, Zhu

I have succeeded in getting blktest to pass on 5.14. There is a bug in rxe that I had to fix. In
loopback mode when an RNR NAK is received it requests the requester to start a retry sequence
before the rnr timer fires which results in the command being retried immediately regardless of the
value of the timeout. I made a small change which requires the requester to wait for either the
timer to fire or an ack to arrive. The srp/002 test case in blktest spends a long time before posting
a receive in some cases which caused a soft lockup. There is a second non-bug which is the number of
MRs was too small to run the test. I increased these by a factor of 256 which fixed that.

My test setup has for-next + 5 recent rxe fix patches applied in addition to the RNR timing one above.

I will submit a patch for the rnr fix.

Bob

