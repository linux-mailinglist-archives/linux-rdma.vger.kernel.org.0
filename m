Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 007B63B20B9
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Jun 2021 21:01:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbhFWTDO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 23 Jun 2021 15:03:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbhFWTDO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 23 Jun 2021 15:03:14 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63711C061574;
        Wed, 23 Jun 2021 12:00:56 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id r16so4496188oiw.3;
        Wed, 23 Jun 2021 12:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HU0njkEAFXSJ+n1VhC5vO37YX20GbDuiyUcRu8p0LjY=;
        b=rM3WDg9MMATVrxXbwamjLp8MYkt3nKZzzeXshLf8ILv5x6LgyXo2blESNLQIVeXsFD
         rpjPxLKs1h6HOwdPV14GthqwAemSKTrfW+nY32gCA+UIpPY6ihPofAgehpg7681KUIJo
         IxLdr13iGdEUHDNjN933QVGA/I/zGKtjSXUCfl9XFFp8gtAZxYi7iB3TIHJWaw+D725M
         voWKL6spbhaM8cvdeDxt2zl3XvfYn/ragq8k6CV6q9O/DUtK/a5Pnmd6TVv8UhbanjwQ
         P4Fo52HgvmP31qSnkL1NysqPThoMiJhTwMPxGzMMAHosCkhwP6CH4HFv2r6M9U3QsvSH
         iaew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HU0njkEAFXSJ+n1VhC5vO37YX20GbDuiyUcRu8p0LjY=;
        b=tZpEiZfQUP3pxqwqUCicHAsUMj+8TDqluwq4DU4XGbZ/YfFQbsLOJDoggWIEfA5eN4
         ZS5Y9FWo5CpzgGrTh5z1y3TfHbH0h7CO7ZrUUaKl1YpHhHIqNDYOpSJLxDMcW6nPdB7z
         GXydTzjpLR94ZOEPXL7wzTct8cuGo8afRwMzCoPWbBqQ5Svfn6AwGrY/7oBgZAlRdvO+
         qyJS0fhzPanwFCI7GZtCO0YQLVlNhmU4SnpvlDaJwwVO0AfeWnG9gT+fAHL+W8KF+jad
         IHYN0QVPuOtGxWCBUIcXbiaY/3DG4fYM2pP5VqqsDa23jeKIvjLhAvj5iprIOxydlAys
         S5QQ==
X-Gm-Message-State: AOAM532yXGvtRpu6Nhw27CMRqHmuJKZ3MDz4zQI6jI7IbdgVfsQWJuBt
        ARLoIcE1FS8UhvFAhygsp2VAmfUleX0O01bWedQ=
X-Google-Smtp-Source: ABdhPJwZaqDGEAw39pokh5wKazMtsYd0U8zjcFHkgl/u/5WFqx2ojdszUYddCg8iZJyKUS2V1hzOATZO27SCBKnlQ9E=
X-Received: by 2002:aca:ac02:: with SMTP id v2mr4495297oie.154.1624474855653;
 Wed, 23 Jun 2021 12:00:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210622120142.GL1096940@ziepe.ca> <d497b0a2-897e-adff-295c-cf0f4ff93cb4@amd.com>
 <20210622152343.GO1096940@ziepe.ca> <3fabe8b7-7174-bf49-5ffe-26db30968a27@amd.com>
 <20210622154027.GS1096940@ziepe.ca> <09df4a03-d99c-3949-05b2-8b49c71a109e@amd.com>
 <20210622160538.GT1096940@ziepe.ca> <d600a638-9e55-6249-b574-0986cd5cea1e@gmail.com>
 <20210623182435.GX1096940@ziepe.ca> <CAFCwf111O0_YB_tixzEUmaKpGAHMNvMaOes2AfMD4x68Am4Yyg@mail.gmail.com>
 <20210623185045.GY1096940@ziepe.ca>
In-Reply-To: <20210623185045.GY1096940@ziepe.ca>
From:   Oded Gabbay <oded.gabbay@gmail.com>
Date:   Wed, 23 Jun 2021 22:00:29 +0300
Message-ID: <CAFCwf12tW_WawFfAfrC8bgVhTRnDA7DuM+0V8w3JsUZpA2j84w@mail.gmail.com>
Subject: Re: [Linaro-mm-sig] [PATCH v3 1/2] habanalabs: define uAPI to export
 FD for DMA-BUF
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Gal Pressman <galpress@amazon.com>, sleybo@amazon.com,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Oded Gabbay <ogabbay@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>,
        Doug Ledford <dledford@redhat.com>,
        Tomer Tayar <ttayar@habana.ai>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        "open list:DMA BUFFER SHARING FRAMEWORK" 
        <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jun 23, 2021 at 9:50 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Wed, Jun 23, 2021 at 09:43:04PM +0300, Oded Gabbay wrote:
>
> > Can you please explain why it is so important to (allow) access them
> > through the CPU ?
>
> It is not so much important, as it reflects significant design choices
> that are already tightly baked into alot of our stacks.
>
> A SGL is CPU accessible by design - that is baked into this thing and
> places all over the place assume it. Even in RDMA we have
> RXE/SWI/HFI1/qib that might want to use the CPU side (grep for sg_page
> to see)
>
> So, the thing at the top of the stack - in this case the gaudi driver
> - simply can't assume what the rest of the stack is going to do and
> omit the CPU side. It breaks everything.
>
> Logan's patch series is the most fully developed way out of this
> predicament so far.

I understand the argument and I agree that for the generic case, the
top of the stack can't assume anything.
Having said that, in this case the SGL is encapsulated inside a dma-buf object.

Maybe its a stupid/over-simplified suggestion, but can't we add a
property to the dma-buf object,
that will be set by the exporter, which will "tell" the importer it
can't use any CPU fallback ? Only "real" p2p ?
Won't that solve the problem by eliminating the unsupported access methods ?

Oded

>
> > The whole purpose is that the other device accesses my device,
> > bypassing the CPU.
>
> Sure, but you don't know that will happen, or if it is even possible
> in any given system configuration. The purpose is to allow for that
> optimization when possible, not exclude CPU based approaches.
>
> Jason
