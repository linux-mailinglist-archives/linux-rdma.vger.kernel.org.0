Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECDDD1D930D
	for <lists+linux-rdma@lfdr.de>; Tue, 19 May 2020 11:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728477AbgESJOk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 19 May 2020 05:14:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726388AbgESJOk (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 19 May 2020 05:14:40 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C3BEC061A0C
        for <linux-rdma@vger.kernel.org>; Tue, 19 May 2020 02:14:38 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id u188so2621191wmu.1
        for <linux-rdma@vger.kernel.org>; Tue, 19 May 2020 02:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P0FCRf+dTi24ioQ6++WoKkPel78TMMaMNtTZJxFedYM=;
        b=JBeDOUVJfKjg7U2LLMc02GY5YYWKYyQdU+bXVcwdKGAN7MkkoGTWVymmpJcC274eul
         5tAw3a0i3JsksqpDcPYux77IV0YSeu2c4EkpG6ABWAbLPrnGDkKNHbwnm1fGn7fVc509
         ox9J746CMxG3WSr8aYfE2UIvRi/DeHzB2H7CuXMaUEooiinpupI7nM4/koDAcRWUlrgE
         9NIZ05/g4lWW3Gaqw2Tl2iGyJt/t3Br1//3CHkiEBA9F5TUaXGH9FZPs/Sx5vdtEhx37
         V4sExMi3n5L1PXLrPVBML+4hUHZOt5nXynlAh8MtBtnS5T/u0bWTQl+ig0ZkPWecD/KN
         QFxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P0FCRf+dTi24ioQ6++WoKkPel78TMMaMNtTZJxFedYM=;
        b=sKhlRxDOlovnnBn+wnD8U0XnZ4QZR2LZ3Va38x0/E7fZ2DQIpgv/xrjsuF/p/TSGNK
         +cvBroY6LqB02BEHnRfOWnNt4JTFmT34raq/8L3EpzBnpZTIgRX2P70I6+QCQMwhkCOd
         TXYivk0M3BA5qPvqDXbJ7kx2zEhmqxN7UIv5C3yKgsPy5R4bCglFyZEdInf1ZWi8MeYm
         05yj5eliCm1cmtkv8WA52UoyEUkqMs4pxq9IDeW0A7wz0GqOvul3Ux7dmLx5VJ3GdqyZ
         fEDknhVSRsAtv/CkBLkwLpqqBJ+Xv/cfFDfY5H9tcO2sA6Hn0FeZcylMPiX9KdBgr0JI
         9Kmw==
X-Gm-Message-State: AOAM532TdhVj15iwHMxvhoHxnmy/UqgShLuUHlbUi/lUhTpHA+RUYe7q
        lOqJtuiNJksCq+ixT+6zrb9yqJet0hYjUOJB3BJ8
X-Google-Smtp-Source: ABdhPJxt33H5r+9EPh/ct/Nqr2KLJ99l+vxPSm+tzYDY5aP1Zl3ChyyW0lQX55W6h/Lz1Picbq395Wj70Cthjbj3NHg=
X-Received: by 2002:a1c:5402:: with SMTP id i2mr4567374wmb.185.1589879677255;
 Tue, 19 May 2020 02:14:37 -0700 (PDT)
MIME-Version: 1.0
References: <e132ee19-ff55-c017-732c-284a3b20daf7@infradead.org>
 <20200519080136.885628-1-danil.kipnis@cloud.ionos.com> <20200519080136.885628-2-danil.kipnis@cloud.ionos.com>
 <20200519084812.GP188135@unreal>
In-Reply-To: <20200519084812.GP188135@unreal>
From:   Danil Kipnis <danil.kipnis@cloud.ionos.com>
Date:   Tue, 19 May 2020 11:14:26 +0200
Message-ID: <CAHg0Huw9HiNz1jYcypiirbB6encMcBOuGMLDE+9m0wGp0B6VfA@mail.gmail.com>
Subject: Re: [PATCH 1/1] rnbd/rtrs: pass max segment size from blk user to the
 rdma library
To:     Leon Romanovsky <leon@kernel.org>
Cc:     linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Jinpu Wang <jinpu.wang@cloud.ionos.com>,
        Doug Ledford <dledford@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>,
        Randy Dunlap <rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Leon

On Tue, May 19, 2020 at 10:48 AM Leon Romanovsky <leon@kernel.org> wrote:
>
> On Tue, May 19, 2020 at 10:01:36AM +0200, Danil Kipnis wrote:
> > When Block Device Layer is disabled, BLK_MAX_SEGMENT_SIZE is undefined.
> > The rtrs is a transport library and should compile independently of the
> > block layer. The desired max segment size should be passed down by the
> > user.
> >
> > Introduce max_segment_size parameter for the rtrs_clt_open() call.
> >
> > Signed-off-by: Danil Kipnis <danil.kipnis@cloud.ionos.com>
> > Reported-by: Randy Dunlap <rdunlap@infradead.org>
> > ---
>
> Please, add fixes line.
I'm new to this for-next fix up procedure. What tree the commit I
should reference with the fixes line should come from? Should I split
this commit so that I can reference the commits which add separate
files in the original patchset here
https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git/log/?h=for-next
? And also if I have to fix yet another issue - how do I then
reference the commit this patch creates if applied?
Thank you!

>
> Thanks
