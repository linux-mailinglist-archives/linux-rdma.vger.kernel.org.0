Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DDC841B743
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Sep 2021 21:13:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242374AbhI1TOx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 28 Sep 2021 15:14:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:38916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229678AbhI1TOw (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 28 Sep 2021 15:14:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2203D6135D;
        Tue, 28 Sep 2021 19:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632856393;
        bh=7B069zu3fIEzc7J70Px6o5DhIK24ITV1Z/pXFm5SPE0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=l6f3rhKcvzS0cbgcm8Mrrz4ooPJZlG/4m1v9BWnHnLbjLhFxTHio3iJqUb30rWppT
         bkrU3N/7CrsynPS44VKf0F2VQiuAKkNUFlNPTayOIUECmpi5i8qpKmMSC/lBmgtS7j
         X4kQkoxKPRo4YEiG5j2cprdm3SqnXAJO0aQYTGHuo1F1PYDZMuTo0r+HG+4p53LGkx
         6g2hElAnx6lHAbgmMZ4OmahFoV7S1PCe5RpOroGQpbz3A8K5WRGTW29H9j5IXkbBGD
         3mQlgTa3+GnIvq5ZXBvfbIyXjy3El0UVXSA16dxV71BieYlJXPFw3G4y+ns8x5uyUQ
         yBbjLwWqCZu2w==
Received: by mail-yb1-f177.google.com with SMTP id b82so10852ybg.1;
        Tue, 28 Sep 2021 12:13:13 -0700 (PDT)
X-Gm-Message-State: AOAM533yGAKgXXVhFyLR4KCWpEiXc68xctSPw1mwofXvq2AJCebThXU+
        eucum2gS5POVXfUbELpSsADXhFQW6GVUdPulV9w=
X-Google-Smtp-Source: ABdhPJzG+BFlkram6wvHYJeDdwoU4EG8PEfLiuo+UnYK/GvSnKWgTPJ0sB5vh6yCxEX5jumwKy2fpW82HRuvpNo3wUE=
X-Received: by 2002:a25:3614:: with SMTP id d20mr8888513yba.537.1632856392408;
 Tue, 28 Sep 2021 12:13:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210912165309.98695-1-ogabbay@kernel.org> <20210912165309.98695-2-ogabbay@kernel.org>
 <20210928171329.GF3544071@ziepe.ca>
In-Reply-To: <20210928171329.GF3544071@ziepe.ca>
From:   Oded Gabbay <ogabbay@kernel.org>
Date:   Tue, 28 Sep 2021 22:12:45 +0300
X-Gmail-Original-Message-ID: <CAFCwf11_2TTVnqr8HqrsCW6cxUHu9txKuX-3U6mgMVPq8WqKdg@mail.gmail.com>
Message-ID: <CAFCwf11_2TTVnqr8HqrsCW6cxUHu9txKuX-3U6mgMVPq8WqKdg@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] habanalabs: define uAPI to export FD for DMA-BUF
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Gal Pressman <galpress@amazon.com>,
        Yossi Leybovich <sleybo@amazon.com>,
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Sep 28, 2021 at 8:13 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Sun, Sep 12, 2021 at 07:53:08PM +0300, Oded Gabbay wrote:
> >       /* HL_MEM_OP_* */
> >       __u32 op;
> > -     /* HL_MEM_* flags */
> > +     /* HL_MEM_* flags.
> > +      * For the HL_MEM_OP_EXPORT_DMABUF_FD opcode, this field holds the
> > +      * DMA-BUF file/FD flags.
> > +      */
> >       __u32 flags;
> >       /* Context ID - Currently not in use */
> >       __u32 ctx_id;
> > @@ -1072,6 +1091,13 @@ struct hl_mem_out {
> >
> >                       __u32 pad;
> >               };
> > +
> > +             /* Returned in HL_MEM_OP_EXPORT_DMABUF_FD. Represents the
> > +              * DMA-BUF object that was created to describe a memory
> > +              * allocation on the device's memory space. The FD should be
> > +              * passed to the importer driver
> > +              */
> > +             __u64 fd;
>
> fd's should be a s32 type in a fixed width uapi.
Yep, will correct this.

>
> I usually expect to see the uapi changes inside the commit that
> consumes them, splitting the patch like this seems strange but
> harmless.
I'll remember that when I send the RDMA patches down the road :)

Thanks,
Oded
>
> Jason
