Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 140E93BE7B3
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Jul 2021 14:17:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231449AbhGGMTz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 7 Jul 2021 08:19:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231358AbhGGMTz (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 7 Jul 2021 08:19:55 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE1CFC061574;
        Wed,  7 Jul 2021 05:17:14 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id d12so2200170wre.13;
        Wed, 07 Jul 2021 05:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=gFcpO09X9eqmjEev1StyvxVCY7X0AALnaeQkmkAwWuA=;
        b=ZjJsQUBAGSRzwkesl+g70QlwkbvYhuHJtn9TzO41zn/XqXK0HsPfSJXxQ1uubM80r2
         QYeHYcYzl3pdaIKusWL8Cd7Wu51RMb/uf3qRgfVEUeKySy/8psgPpeGYTaM+zPTnUhPF
         9xKe5V78YV9n8JpqoYRiJqSsCkiLrBbIA9ZtSqYpocicMRidvhtcTJamlaqtccNRyFEN
         02DbkAeA4CUIOThsqvoQeKbSJh5ta3Oe42xfSOVaXDxn0ln/B0etndt5ICGG0ZrG3npQ
         LpRDrwUb4cIJSkCzDubfh19bl4gMUkqIeaYnL4XjUhz4gGqkC155BwFDxgWq0MBa3QsZ
         xebw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=gFcpO09X9eqmjEev1StyvxVCY7X0AALnaeQkmkAwWuA=;
        b=pAACjh16ceqY2dnrPo8i6UULmcT07c5TUhWTFwsFbRZYiLzYvQPyZcb3BDxTGAT/WX
         kX4dNCIV4g+rjuJZ85XnkzndpE3TaJwoAdGjgTzQnujLWOAjY1M8HG07kNYdNUxzxAsI
         S92TgEQ1UDdHgFT4zYm4vuIdQAIGi6kI4JxPkMJw99fOL5yTyKbmHSqkEKPpVuYAqIUX
         Ir0VtFqgs68THh2leAdkiWAtiLR/DfqpMxCZqe+G+1cGB8WXh0Bm4i1PWgJLXX6S28FJ
         04sa7jbwXCi4PxZ/MGpx+Xk8aUEf5e9b3QcgTmaws7P3S3e/L4go0euuGkt6H2O3VkYf
         tsyg==
X-Gm-Message-State: AOAM531GyYFyde6Ge+aqbymCmaEIC6I/EpIi82Yq303/mmw8Gpo+6nuw
        JwR8M8XyEXLUKiFBH0KLJ/Y=
X-Google-Smtp-Source: ABdhPJw+KpKKmv799GNloUfwlu8fKZlyMeia+T+6lyR5kx2E0g6ByA5UB8esUFEyQkPer8zSwXyRww==
X-Received: by 2002:a5d:680b:: with SMTP id w11mr15450397wru.426.1625660233375;
        Wed, 07 Jul 2021 05:17:13 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:7671:3328:2129:96b5? ([2a02:908:1252:fb60:7671:3328:2129:96b5])
        by smtp.gmail.com with ESMTPSA id u2sm13550473wmc.42.2021.07.07.05.17.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jul 2021 05:17:12 -0700 (PDT)
Subject: Re: [Linaro-mm-sig] [PATCH v4 0/2] Add p2p via dmabuf to habanalabs
To:     Christoph Hellwig <hch@lst.de>, Oded Gabbay <ogabbay@kernel.org>,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        sumit.semwal@linaro.org, christian.koenig@amd.com,
        galpress@amazon.com, sleybo@amazon.com,
        dri-devel@lists.freedesktop.org, jgg@ziepe.ca,
        linux-rdma@vger.kernel.org, linux-media@vger.kernel.org,
        dledford@redhat.com, airlied@gmail.com, alexander.deucher@amd.com,
        leonro@nvidia.com, amd-gfx@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org
References: <20210705130314.11519-1-ogabbay@kernel.org>
 <YOQXBWpo3whVjOyh@phenom.ffwll.local> <20210706122110.GA18273@lst.de>
 <YORLTmyoXDtoM9Ta@phenom.ffwll.local>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <9af554b1-e4d8-4dd4-5a6a-830f3112941d@gmail.com>
Date:   Wed, 7 Jul 2021 14:17:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YORLTmyoXDtoM9Ta@phenom.ffwll.local>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Am 06.07.21 um 14:23 schrieb Daniel Vetter:
> On Tue, Jul 06, 2021 at 02:21:10PM +0200, Christoph Hellwig wrote:
>> On Tue, Jul 06, 2021 at 10:40:37AM +0200, Daniel Vetter wrote:
>>>> Greg, I hope this will be good enough for you to merge this code.
>>> So we're officially going to use dri-devel for technical details review
>>> and then Greg for merging so we don't have to deal with other merge
>>> criteria dri-devel folks have?
>>>
>>> I don't expect anything less by now, but it does make the original claim
>>> that drivers/misc will not step all over accelerators folks a complete
>>> farce under the totally-not-a-gpu banner.
>>>
>>> This essentially means that for any other accelerator stack that doesn't
>>> fit the dri-devel merge criteria, even if it's acting like a gpu and uses
>>> other gpu driver stuff, you can just send it to Greg and it's good to go.
>>>
>>> There's quite a lot of these floating around actually (and many do have
>>> semi-open runtimes, like habanalabs have now too, just not open enough to
>>> be actually useful). It's going to be absolutely lovely having to explain
>>> to these companies in background chats why habanalabs gets away with their
>>> stack and they don't.
>> FYI, I fully agree with Daniel here.  Habanlabs needs to open up their
>> runtime if they want to push any additional feature in the kernel.
>> The current situation is not sustainable.
> Before anyone replies: The runtime is open, the compiler is still closed.
> This has become the new default for accel driver submissions, I think
> mostly because all the interesting bits for non-3d accelerators are in the
> accel ISA, and no longer in the runtime. So vendors are fairly happy to
> throw in the runtime as a freebie.

Well a compiler and runtime makes things easier, but the real question 
is if they are really required for upstreaming a kernel driver?

I mean what we need is to be able to exercise the functionality. So 
wouldn't (for example) an assembler be sufficient?

> It's still incomplete, and it's still useless if you want to actually hack
> on the driver stack.

Yeah, when you want to hack on it in the sense of extending it then this 
requirement is certainly true.

But as far as I can see userspace don't need to be extendable to justify 
a kernel driver. It just needs to have enough glue to thoughtfully 
exercise the relevant kernel interfaces.

Applying that to GPUs I think what you need to be able to is to write 
shaders, but that doesn't need to be in a higher language requiring a 
compiler and runtime. Released opcodes and a low level assembler should 
be sufficient.

Regards,
Christian.

> -Daniel

