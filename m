Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E283513529
	for <lists+linux-rdma@lfdr.de>; Thu, 28 Apr 2022 15:31:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346656AbiD1Nep (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 28 Apr 2022 09:34:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347214AbiD1Neo (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 28 Apr 2022 09:34:44 -0400
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33052186EC
        for <linux-rdma@vger.kernel.org>; Thu, 28 Apr 2022 06:31:28 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-e9027efe6aso5119707fac.10
        for <linux-rdma@vger.kernel.org>; Thu, 28 Apr 2022 06:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ZVMMaU8+d4BVpHVua6101wuVnWHye3TOrK/WSVfGodk=;
        b=jwpbsKJ0WzGbGyJ0tSBHS4xKIgzuZp9AypoxpOSoXaqKLqcFOrPQnsDTfTQWbCCYNB
         F1JgNuvbRkMvPUvLgtSUQRruTtkmXrWck/zlMO85khTjeM/Hk47lW79RKIT3MaVHdFY+
         aNKO1flYq0I+PDWyNueU3dK6e+V9BMWTjBzFD+MDaJzmC7i3oXRmA855HCQkDRJISeI7
         BRe+4lz373E3jCHRwlh6tVtrAGQp0HGses7NNeyc0c9yPT2sJ/L95whpYujyUhlwJ5RH
         BTwh6mYjbPU9cI4tO9DRS/DI5YfsfaKboVdhfQc4LCh9N+c06fkt0TG+gPo4srqQzodX
         5Nzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ZVMMaU8+d4BVpHVua6101wuVnWHye3TOrK/WSVfGodk=;
        b=4hsaqdSWqWwHA1YPXzw/ivMZznW1IivyL3unpcZFRxIfAj6PYx0mv0gIXItymguO62
         RAPOpICCTQejZopLnXM2SVbQr2CCkvtz4QgVbLy4QEtVLHKk8qG/bkVoOPDsqFoJCrAj
         MkyJj4RjavV38LSvVYCOqZPqRfpELspbKbOe+5P+FuiisDwLJrp/wuJfDRVxjiMExG0I
         l8W34r6FxMmwjxL3BLKy/VXBuf7PBceCycNvmr4W7jMCwSRMEmUwvc+29/OFhUyS/ihq
         nIhIhV5GB8QBGF622Vphpp709dlD6sH11syZ/DgcvrlRNv2EoG4V+nCd6xB0GYVBkeo0
         mvUw==
X-Gm-Message-State: AOAM5319U0L3x3PcV13CCcnZLK04rDH23EWc01dM1u0SJJ1d1MghaiVj
        bCdkQ8Osc9AD67ZrDycL7Ro=
X-Google-Smtp-Source: ABdhPJyFpXgMEEIZJsbBbBBxANkhhOM3nvQNzLFuQNSAM+MHjOF8bI8vYUUTymMzWLVyYbzjOAHtFg==
X-Received: by 2002:a05:6870:8311:b0:e9:3da:4579 with SMTP id p17-20020a056870831100b000e903da4579mr12375675oae.258.1651152687482;
        Thu, 28 Apr 2022 06:31:27 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:b0c6:ca88:407e:4b4b? (2603-8081-140c-1a00-b0c6-ca88-407e-4b4b.res6.spectrum.com. [2603:8081:140c:1a00:b0c6:ca88:407e:4b4b])
        by smtp.gmail.com with ESMTPSA id o6-20020a4a84c6000000b0035e5906bcc4sm23533oog.4.2022.04.28.06.31.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Apr 2022 06:31:26 -0700 (PDT)
Message-ID: <8bcec47a-a484-494a-7fc0-66a5d7f52eb8@gmail.com>
Date:   Thu, 28 Apr 2022 08:31:24 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: bug report for rdma_rxe
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Yanjun Zhu <yanjun.zhu@linux.dev>,
        Zhu Yanjun <zyjzyj2000@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        jhack@hpe.com
References: <5de7d1a9-a7ac-aea5-d11c-49423d3f0bf1@gmail.com>
 <98ad3df7-b934-ad2b-49c6-bb07a06a5c4f@linux.dev>
 <dfba7eb7-8467-59b5-2c2a-071ed1e4949f@gmail.com>
 <20220425225831.GG2125828@nvidia.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <20220425225831.GG2125828@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 4/25/22 17:58, Jason Gunthorpe wrote:
> On Mon, Apr 25, 2022 at 11:58:55AM -0500, Bob Pearson wrote:
>> On 4/24/22 19:04, Yanjun Zhu wrote:
>>> 在 2022/4/23 5:04, Bob Pearson 写道:
>>>> Local operations in the rdma_rxe driver are not obviously idempotent. But, the
>>>> RC retry mechanism backs up the send queue to the point of the wqe that is
>>>> currently being acknowledged and re-walks the sq. Each send or write operation is
>>>> retried with the exception that the first one is truncated by the packets already
>>>> having been acknowledged. Each read and atomic operation is resent except that
>>>> read data already received in the first wqe is not requested. But all the
>>>> local operations are replayed. The problem is local invalidate which is destructive.
>>>> For example
>>>
>>> Is there any example or just your analysis?
>>
>> I have a colleague at HPE who is testing Lustre/o2iblnd/rxe. They are testing over a
>> highly reliable network so do not expect to see dropped or out of order packets. But they
>> see multiple timeout flows. When working on rping a week ago I also saw lots of timeouts
>> and verified that the timeout code in rxe has the behavior that when a new RC operation is
>> sent the retry timer is modified to go off at jiffies + qp->timeout_jiffies but only if
>> there is not a currently pending timer. Once set it is never cleared so it will fire
>> typically a few msec later initiating a retry flow. If IO operations are frequent then
>> there will be a timeout every few msec (about 20 times a second for typical timeout values.)
>> o2iblnd uses fast reg MRs to write data to the target system and then local invalidate
>> operations to invalidate the MR and then increments the key portion of the rkey and resets
>> the map and then does a reg mr operation. Retry flows cause the local invalidate and reg MR
>> operations to be re-executed over and over again. A single retry can cause a half a dozen
>> invalidate operations to be run with various rkeys and they mostly fail because they don't
>> match the current MR. This results in Lustre crashing.
>>
>> Currently I am actually happy that the unneeded retries are happening because it makes
>> testing the retry code a lot easier. But eventually it would be good to clear or reset the timer
>> after the operation is completed which would greatly reduce the number of retries. Also
>> it will be important to figure out how the IBA intended for local invalidates and reg MRs to
>> work. The way they are now they cannot be successfully retried. Also marking them as done
>> and skipping them in the retry sequence does not work. (It breaks some of the blktests test
>> cases.)
> 
> local operations on a QP are not supposed to need retry because they
> are not supposed to go on the network, so backing up the sq past its
> current position should not re-execute any local operations until the
> sq passes its actual head.
> 
> Or, stated differently, you have a head/tail pointer for local work
> and a head/tail pointer for network work and the two track
> independently within the defined ordering constraints.
> 
> Jason

This is a strong constraint on the send queue but is the only sane solution I suspect.
It implies that not attempting to redo local operations implies that the verbs consumer
must guarantee that they can safely change the MR/MW state as soon as the operation is
executed for the first time. This means that either there is a fence or they have seen
the completion of all IO operations that depend on the memory. It is not clear that all
test cases obey these rules or that they don't. We should WARN on those situations where
we can see a violation.

There is another source of errors in the driver that we now suspect. The send queue is
variously owned by three or more threads: verbs API calls which post operations,
the requester tasklet which turns wqe's into RoCE request packets and the completer tasklet
that responds to RoCE ack/read-reply packets (for RC) or marking the wqe as done (for UD/UC).
Both tasklets read and write wqe fields but do not use any locking to enforce consistency.
For normal flows this is mostly OK because the wqe is either only accessed by the requester
tasklet or later the completer tasklet. But in retry flows they can overlap. There needs to
be a clear ownership of the wqes by one tasklet or the other and memory barriers at the
hand-offs.

The wqe->state variable should indicate which tasklet owns the wqe and a lock should be held
when the state is loaded or changed. The retry prep routine req_retry() should hold the lock for the
duration of re-marking the wqes.

Bob
