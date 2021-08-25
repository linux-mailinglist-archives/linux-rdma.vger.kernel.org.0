Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 224A43F7BFF
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Aug 2021 20:03:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230477AbhHYSDv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 25 Aug 2021 14:03:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbhHYSDv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 25 Aug 2021 14:03:51 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 361E4C061757;
        Wed, 25 Aug 2021 11:03:05 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id x9-20020a056830278900b0051b8be1192fso63243otu.7;
        Wed, 25 Aug 2021 11:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=He20geAQHfYMCdVrkb9W7TINeIUEX3jBqDB5fwb9kak=;
        b=PITN47Anp2Z2S4JBE3YXNb6mJj5iByMWKIEjM6TEvPrdLnwmVt3h+B1N2KgyJz2Weo
         w7Q7gFLhLn0p6+RAQ12sQTa7pFOrsB0lBwp13Shv5jVISnictInv4oy+lUUpz4tIise4
         m8TB1zv9wF1nVnJLCphXrKiQXAB3H2egD6l2lpF50Q+R3MC7W0GveUbw3ZCYtBVC6A1Q
         R+FyyVdyPiyT3RefuA9DQbxu+KJhQEuYAs5fcvfS1NqYDBND7UeH+FC7sqzg9hw92oVv
         UpweTZY4y9cyCaMqfYbsVyu7cpHI9AL+n7ownIo9pWFz4njfUCaf3jpI8Sjn/yc0t0HS
         WCHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=He20geAQHfYMCdVrkb9W7TINeIUEX3jBqDB5fwb9kak=;
        b=VeNe3/026vlBakvepC91jva5LS7rLsawIAc9AqfwOrvWjYZUxwHqM/BnTJI6Zv9sGM
         JuQECSG0/m8a1xNQ51VCJmgj1Lihx0YwOczYQHPRgQiaatuo9opfEyFODUfUG7jZwx//
         lt0gJXAlYYGiL2dpJBfFH1pAz/sTGYhtqaTlmbDVHJ8oXcrTbzmIQz/lKRKaCs3uB+W0
         q/BvGKKGu2ZCfVUXuWCmNiWfV7PaJKLFV4xitvFx0uFnt2z1Et18jybgBfSxhz0JUz4H
         I/V+TddpR2BhCDVG1s4EVVwYIZeuS5cMLK99XkY584D4pS01vXLRIvLhbsgP6QW/anUK
         AWVw==
X-Gm-Message-State: AOAM531M4pLTFqpo1Jb/4AIKUO4pCP5csGgEUFwLjjpkIE+V92glvea4
        hWaooV/G5l9Iy4CFkLTm+3YPwxROSfI=
X-Google-Smtp-Source: ABdhPJyCXINS9p04adcS2paiPGvxHpIV5MkWVYN6pYYoljKtVKljIRVqua7gR9fBVoIXfd0DzTy1Dg==
X-Received: by 2002:a05:6830:20cf:: with SMTP id z15mr37229880otq.7.1629914584514;
        Wed, 25 Aug 2021 11:03:04 -0700 (PDT)
Received: from ?IPv6:2603:8081:140c:1a00:60f3:453f:de39:d85d? (2603-8081-140c-1a00-60f3-453f-de39-d85d.res6.spectrum.com. [2603:8081:140c:1a00:60f3:453f:de39:d85d])
        by smtp.gmail.com with ESMTPSA id a23sm97408otp.44.2021.08.25.11.03.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Aug 2021 11:03:04 -0700 (PDT)
Subject: Re: v5.14 RXE driver broken?
To:     Jason Gunthorpe <jgg@ziepe.ca>, Zhu Yanjun <zyjzyj2000@gmail.com>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <c3d1a966-b9b0-d015-38ec-86270b5045fc@acm.org>
 <CAD=hENcriq-mwnvzY3UdowuGpKb=Uekvk-v8Lj0G=QB-qK0kJg@mail.gmail.com>
 <20210825163219.GY543798@ziepe.ca>
From:   Bob Pearson <rpearsonhpe@gmail.com>
Message-ID: <28714f52-9d9b-e733-8a4b-042cde022552@gmail.com>
Date:   Wed, 25 Aug 2021 13:03:03 -0500
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
Jason,

I am (I think) able to reproduce Bart's issue. I wouldn't hold up the 'bug fix' patches they are all legitimate.

Bob
