Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77D013BD92F
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Jul 2021 16:56:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231556AbhGFO70 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 6 Jul 2021 10:59:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231852AbhGFO7J (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 6 Jul 2021 10:59:09 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A12BC0613A6
        for <linux-rdma@vger.kernel.org>; Tue,  6 Jul 2021 07:56:20 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id b5so20968367ilc.12
        for <linux-rdma@vger.kernel.org>; Tue, 06 Jul 2021 07:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=a8/qLLqO6eL91stH3wL0KRpl9T08Ic+NpnQGQ6x06VA=;
        b=j2sPe5/YeFhkbk8Ao1wBoSJI3mHjTKeYtGS/ylikxffAh4pjlXAic9iDxRv5Mv0c88
         o5b7lMNG7FTsdoBh7D7HFqLBpXx4OWDvWQolA2AYbIKyYGFb/BJCIZ86BrUQNsb/C3Zk
         XsAk6eIa1iX7IreWpvN3CU6N8yZIaUepsXSqCVxrBMKOSQwVo+4QlVdlIX3ICQnCZ+RN
         LgJrLxii8/f54h0waeGuOrMJGYXgQlD5kGp/v5vw+plNVj3amj0GPy79B+VVJnzMwf0X
         slP6aAspIJPeReLpfjtTCTHLR7t2wU8m1oRA1naFZ3fVxAxznodtagNFx7SXVX3ixwEZ
         eBuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=a8/qLLqO6eL91stH3wL0KRpl9T08Ic+NpnQGQ6x06VA=;
        b=qplU4Ch4JploRcwVUNeoY3L/9HWsf7VZW9YthcYITjPOFnT0mmJXU79pUn+MNLUs9S
         +wyGOQlLMaojr9nw3Awot+amo7CSq4zP1Sjef0SNMOb9idPkDgvdB3484g4LKTlgRo3H
         Gyaarae8jnZqZsZ1qNp0zl5IaYNw2N731Re6dktUIRIfKBKWj0VztdQHPWWkt0fd5F0F
         y2zalF19tI5QiV7nEg8MMfEl2TWg3d2pgXw7Lif+uyyA8dTsAykq4TbSlmz0sAYd6x3S
         ug018+Sd9CrTHGfkFNwjP8BLYr/s/rZQiraP7mPK+QkcJJf4KK5C8JFGn1G9L14fh+Sg
         p/Kg==
X-Gm-Message-State: AOAM533dHNkLcYY4+i74jcamb4X7kDMSrVGw4CvRelUOLR4KkP/23gWd
        Z1hIMbMASZXjewhHJgZ1JxO1Yg==
X-Google-Smtp-Source: ABdhPJwog3epP3zDyPdL9Dn1Mv3QQbO1xKAP/j5dh3/z+a/bJ15P6+dhr9KB3Du7HHV3+Ab4fMGLOg==
X-Received: by 2002:a92:dd05:: with SMTP id n5mr14308230ilm.72.1625583379441;
        Tue, 06 Jul 2021 07:56:19 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id l18sm8626632ilo.64.2021.07.06.07.56.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jul 2021 07:56:19 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1m0mUj-004Rth-V9; Tue, 06 Jul 2021 11:56:17 -0300
Date:   Tue, 6 Jul 2021 11:56:17 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     Oded Gabbay <oded.gabbay@gmail.com>,
        Oded Gabbay <ogabbay@kernel.org>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        Gal Pressman <galpress@amazon.com>, sleybo@amazon.com,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Dave Airlie <airlied@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>
Subject: Re: [PATCH v4 0/2] Add p2p via dmabuf to habanalabs
Message-ID: <20210706145617.GO4604@ziepe.ca>
References: <20210705130314.11519-1-ogabbay@kernel.org>
 <YOQXBWpo3whVjOyh@phenom.ffwll.local>
 <CAFCwf10_rTYL2Fy6tCRVAUCf4-6_TtcWCv5gEEkGnQ0KxqMUBg@mail.gmail.com>
 <CAKMK7uEAJZUHNLreBB839BZOfnTGNU4rCx-0k55+67Nbxtdx3A@mail.gmail.com>
 <CAKMK7uHpKFVm55O_NB=WYCsv0iUt92ZUn6eCzifH=unbhe3J8g@mail.gmail.com>
 <CAKMK7uFGr=ugyKj0H3ctbh28Jnr25vAgXPBaDBMmfErCxYVo3w@mail.gmail.com>
 <20210706134430.GL4604@ziepe.ca>
 <CAKMK7uFEZjp2_WBhtkVxSNQ-1WcBSr3NDotY0fjz0iLRw8Barw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKMK7uFEZjp2_WBhtkVxSNQ-1WcBSr3NDotY0fjz0iLRw8Barw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jul 06, 2021 at 04:09:25PM +0200, Daniel Vetter wrote:
> Anyway, for anything that works like a gpu accelerator, like 3d accel,
> or parallel compute accel (aka gpgpu) or spatial compute accel (aka
> NN/AI) or maybe even fpga accel most of the magic to use the hardware
> is in this backend compiler, which translates from an IR into whatever
> your accelerator consumes. That's the part we really care about for
> modern accelerators because without that defacto the hardware is
> useless. Generally these chips have full-blown, if special purpose
> ISA, with register files, spilling, branches, loops and other control
> flow (sometimes only execution masks on simpler hw).

I don't know if I see it so clearly as you do - at the end of the day
the user keys in the program in some proprietary (or open!) language
and and wack of propritary magic transforms it to "make it work".

There are many barriers that prevent someone without the secret
knowledge from duplicating the end result of a working program. An
accelerator ISA is certainly one example, but I wouldn't overly focus
on it as the only blocker.

Like you said below the NVIDIA GPU ISA seems known but the HW is still
not really useful for other reasons.

Habana seems to have gone the other way, the HW is fully useful but we
don't have the ISA transformation and other details.

Both cases seem to have ended up with something useless, and I have a
hard time saying nouveau has more right to be in the kernel tree than
Habana does.

> > Honestly, I think GPU is approaching this backwards. Wayland should
> > have been designed to prevent proprietary userspace stacks.
> 
> That's not possible without some serious cans of worms though. Wayland
> is a protocol, and you can't forbid people from implementing it.
> Otherwise all the compatible open implementations of closed protocols
> wouldn't be possible either.

Well, in many ways so is Linux, but nobody would seriously
re-implement Linux just to produce a driver.

> So I'm not clear what you're suggesting here we should do different.

Not enabling proprietary stacks as above would be a good start.

Jason
