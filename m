Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49FD33F7D81
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Aug 2021 23:10:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232665AbhHYVKi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 25 Aug 2021 17:10:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbhHYVKi (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 25 Aug 2021 17:10:38 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CB0BC061757;
        Wed, 25 Aug 2021 14:09:52 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id y14-20020a0568302a0e00b0051acbdb2869so724396otu.2;
        Wed, 25 Aug 2021 14:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/7YB4cPybNjgZDIEgMLvGWL4IE2bJDg61Q1v8IBgmG0=;
        b=YItIG/G+QPbK1X2/xAfz9ftgcgyIU8V4Znznwdb1oOhzXZ+ii0aSc5vLHOSuX9sOCW
         VQ5+dXZSwLhvm1StlkDmSNdwY1SmPsp6U56uQ8RiEwu6qoYm/4Iejy9wYZSCQ8Gj9isj
         d7yc/4euv5OVhuoDG1LhJC5WQQweFo4l7yKKa93G8ek2ycb7KvAdcfnRJ1EHdOkyu7k2
         6z+nUpMlW0VvQ1EJNDJIxTYRRtrbhTt30oZ5wFBHWGdwqgP2kXsZxvxWMO62OJqogAc/
         tS5o4hadxbbBoeneFLUeNqj7FGnGxbdN2SIKwf5/jlTTxAbtrKFQjixC1DRA0QDZhk4O
         6T/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/7YB4cPybNjgZDIEgMLvGWL4IE2bJDg61Q1v8IBgmG0=;
        b=QpaWQswwoZ9GhNC0kyJkDp6f6YDSsWlVyVMmytPxHDX0aa7iigFLq8eQATbLlRX105
         GzZykmc+n3/OEiGxD02HEf0KwBxE9ulkRJ3A5RBV36NBYOkycQ8dVSt/uuSGVmxUdBqS
         rcuBh0Iks+tdSpxtzgrfRxbXUXmTcDgOvhUHp64ms0lTNbAoTSwpeBLKWOmcU+J7divV
         OHeX78uUIhDTXNf9XyP4z1jnFsDKsMsh/C4CzD7AGZIpsmtPxSFdOK+qS8k9KXfz7vvd
         Y+lifROBNjqobXq7ujR1UCh1B4sbkpvGaZuGamjhVTJ89rvgRledRttmWrIKZiehrhjH
         yS2g==
X-Gm-Message-State: AOAM530gT4VteQolyHiCroW/+XRw3QTcJai7Rwd6jWRdkmgt865GiZ3e
        OIs19z+RGi9Jm52SU2FVcRnyIuWVfPM=
X-Google-Smtp-Source: ABdhPJzAy0GT3k41Q+qCZLI2phP0+BypUXhS0LYKwwF2FmGY5u+7TdpaK+0J0tb4Fo5rofGOLnKAWg==
X-Received: by 2002:a05:6830:120e:: with SMTP id r14mr334532otp.249.1629925791377;
        Wed, 25 Aug 2021 14:09:51 -0700 (PDT)
Received: from ?IPv6:2603:8081:140c:1a00:3615:bca2:7e39:65f1? (2603-8081-140c-1a00-3615-bca2-7e39-65f1.res6.spectrum.com. [2603:8081:140c:1a00:3615:bca2:7e39:65f1])
        by smtp.gmail.com with ESMTPSA id v77sm244080oie.5.2021.08.25.14.09.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Aug 2021 14:09:50 -0700 (PDT)
Subject: Re: v5.14 RXE driver broken?
To:     Bart Van Assche <bvanassche@acm.org>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Zhu Yanjun <zyjzyj2000@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <c3d1a966-b9b0-d015-38ec-86270b5045fc@acm.org>
 <CAD=hENcriq-mwnvzY3UdowuGpKb=Uekvk-v8Lj0G=QB-qK0kJg@mail.gmail.com>
 <20210825163219.GY543798@ziepe.ca>
 <423ed740-96e7-aebb-3e6f-7416108f5a62@acm.org>
 <bac1d404-ae2b-c6cc-a065-de2dab25bea9@acm.org>
From:   Bob Pearson <rpearsonhpe@gmail.com>
Message-ID: <c4550410-5b5a-b460-c57c-af2008b5c0e9@gmail.com>
Date:   Wed, 25 Aug 2021 16:09:50 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <bac1d404-ae2b-c6cc-a065-de2dab25bea9@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 8/25/21 3:58 PM, Bart Van Assche wrote:
> On 8/25/21 11:22 AM, Bart Van Assche wrote:
>> On 8/25/21 9:32 AM, Jason Gunthorpe wrote:
>>> On Wed, Aug 25, 2021 at 11:02:14AM +0800, Zhu Yanjun wrote:
>>>> On Tue, Aug 24, 2021 at 11:02 AM Bart Van Assche <bvanassche@acm.org> wrote:
>>>>>
>>>>> Hi Bob,
>>>>>
>>>>> If I run the following test against Linus' master branch then that test
>>>>> passes (commit d5ae8d7f85b7 ("Revert "media: dvb header files: move some
>>>>> headers to staging"")):
>>>>>
>>>>> # export use_siw=1 && modprobe brd && (cd blktests && ./check -q srp/002)
>>>>> srp/002 (File I/O on top of multipath concurrently with logout and login (mq)) [passed]
>>>>>      runtime    ...  48.849s
>>>>>
>>>>> The following test fails:
>>>>>
>>>>> # export use_siw= && modprobe brd && (cd blktests && ./check -q srp/002)
>>>>> srp/002 (File I/O on top of multipath concurrently with logout and login (mq)) [failed]
>>>>>      runtime  48.849s  ...  15.024s
>>>>>      +++ /home/bart/software/blktests/results/nodev/srp/002.out.bad      2021-08-23 19:51:05.182958728 -0700
>>>>>      @@ -1,2 +1 @@
>>>>>       Configured SRP target driver
>>>>>      -Passed
>>>>
>>>> Can this commit "RDMA/rxe: Zero out index member of struct rxe_queue"
>>>> in the link https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git/commit/?h=wip/jgg-for-rc
>>>> fix this problem?
>>>>
>>>> And the commit will be merged into linux upstream very soon.
>>>
>>> Please let me know Bart, if the rxe driver is still broken I will
>>> definitely punt all the changes for RXE to the next cycle until it can
>>> be fixed.
>>
>> Hi Jason,
>>
>> Thanks for having offered to revert the RXE changes from this merge window.
>> Unfortunately that wouldn't be sufficient. My test results so far for test
>> srp/002 in combination with the rdma_rxe driver are as follows:
>> * Kernel v5.12: test passes.
>> * Kernel v5.13: test fails.
>> * Kernel v5.14-rc7: test fails.
>>
>> For the rdma_rxe tests for kernel v5.14-rc7 I found the following in the kernel
>> log:
>>
>> ib_srp:add_target_store: ib_srp: max_sectors = 1024; max_pages_per_mr = 512; mr_page_size = 4096; max_sectors_per_mr = 4096; mr_per_cmd = 2
>> ib_srp: enp1s0_rxe: ib_alloc_mr() failed. Try to reduce max_cmd_per_lun, max_sect or ch_count
>>
>> There is sufficient memory available in the VM in which I ran the tests. It is
>> not clear to me why ib_alloc_mr() fails with these parameters when using the
>> rdma_rxe driver? As one can see in srp_alloc_fr_pool() the SRP initiator driver
>> respects the max_pages_per_mr RDMA driver limit.
> 
> A correction: test srp/002 passes on my setup against kernel v5.13. I probably
> selected the wrong kernel from the GRUB boot menu before I sent my previous email.
> So the test failure is something that happens with v5.14-rc but not with v5.13.
> 
> Applying the following patch on top Linus' master branch did not help:
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_param.h b/drivers/infiniband/sw/rxe/rxe_param.h
> index 742e6ec93686..643b80e47c82 100644
> --- a/drivers/infiniband/sw/rxe/rxe_param.h
> +++ b/drivers/infiniband/sw/rxe/rxe_param.h
> @@ -88,7 +88,7 @@ enum rxe_device_param {
>      RXE_MIN_SRQ_INDEX        = 0x00020001,
>      RXE_MAX_SRQ_INDEX        = 0x00040000,
> 
> -    RXE_MAX_MR            = 0x00001000,
> +    RXE_MAX_MR            = 0x00100000,
>      RXE_MAX_MW            = 0x00001000,
>      RXE_MIN_MR_INDEX        = 0x00000001,
>      RXE_MAX_MR_INDEX        = 0x00010000,
> 
> Bart.
Bart,

Are you seeing the ib_alloc_mr() failure in 5.14? I thought that was just a 5.13 thing.
I am still not seeing that error in my test setup. I am getting a soft lockup error after ~20 seconds.
During most of that there is a constant exchange of req/ack packets with nothing else happening.

If you want I can send you a patch to print out error messages from MR allocation.

Bob
