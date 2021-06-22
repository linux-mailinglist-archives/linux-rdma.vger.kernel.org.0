Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 923E43B08D3
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Jun 2021 17:25:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232177AbhFVP1O (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 22 Jun 2021 11:27:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232300AbhFVP1L (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 22 Jun 2021 11:27:11 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 096F5C061574;
        Tue, 22 Jun 2021 08:24:56 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id h24-20020a9d64180000b029036edcf8f9a6so21606083otl.3;
        Tue, 22 Jun 2021 08:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4X+AcHyDDe3HhjQCq2G+eaJ8kvsIjHhuoyLFdEACcnQ=;
        b=F9cy62wh9RybK9h82fBHPpp8hPDnZx1s+Z0/GOTSU92eNMyNLfj1mmqR2+r3kT8aM1
         xYDm3xoWuWMpBQnf+yCUtYaytLMGRdU+gDGi6swnU2/1W4YjA3DmVGgEJEhpqqWEJhiE
         01z+W8Xkif0R9mOOrdnFJqQd5G+uUqQGTMfvsT/2xP5BWwkuBCnE6fDDDeJPKFj99hpa
         IUTx7/RubZA8kR6BUpUTkctQ7E0FSq1LJm9p8lS8IeiHhgNrTRG9ObqVGWK0oLwjI4ER
         nWl4Jh30VyNTX8WV9ruVKyd0scG13WLdSbrapyE0pKhuHbHyEx+IQYLAiGL9vT11KyaE
         aOoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4X+AcHyDDe3HhjQCq2G+eaJ8kvsIjHhuoyLFdEACcnQ=;
        b=Eh7SchjWN0/sC0XIQzwQqaR68iJ7uySxMQOMVWXWPWnQvNUU0Bl/nSndklPp89sDP+
         EQKA/lCyqbNfyJkPcuk/nk0iUe9rtQRP7h5k5OTAG1jma9KJ/DWaAgGXCCv+CcfmmgJn
         4zMRX4gOYDQO1i2oUL2jp/1aPqG1MGxnmfoNXCuuk5lClx4Tyw5N6o2zjDw2Wv8sbeiX
         nir0xFCiqZ7WD/sfjC8ZHUkkV0pHjDH7mAxFPTBLx0+X5ayDARRZUq+Eo1gm7FO9eISZ
         qfuXyW1dmOon2POLz/AtV89aCRXLLCjydIX1iQiPmdUGV+0+LqpdNYZlTex2XY5gwd8G
         Q8qg==
X-Gm-Message-State: AOAM531LgEQnidWugvgE6zkPnQUUUfJYBiMHvv+sXZ5JIuGZlocLAEUv
        11mZ3F+Bdkb0EYByogZKAiL80L/sqcxpNtOSUXk=
X-Google-Smtp-Source: ABdhPJxdbW8W5cXUxxqtgxKi95nj/EmM2JjajNW5+/OukMinRa2g08LQoWclCFHmO/psGwfcUIox+YZCnLKA4tnM/9A=
X-Received: by 2002:a9d:4581:: with SMTP id x1mr3651165ote.145.1624375495284;
 Tue, 22 Jun 2021 08:24:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210621175511.GI1096940@ziepe.ca> <CAKMK7uEO1_B59DtM7N2g7kkH7pYtLM_WAkn+0f3FU3ps=XEjZQ@mail.gmail.com>
 <CAFCwf11jOnewkbLuxUESswCJpyo7C0ovZj80UrnwUOZkPv2JYQ@mail.gmail.com>
 <20210621232912.GK1096940@ziepe.ca> <d358c740-fd3a-9ecd-7001-676e2cb44ec9@gmail.com>
 <CAFCwf11h_Nj_GEdCdeTzO5jgr-Y9em+W-v_pYUfz64i5Ac25yg@mail.gmail.com>
 <20210622120142.GL1096940@ziepe.ca> <CAFCwf10GmBjeJAFp0uJsMLiv-8HWAR==RqV9ZdMQz+iW9XWdTA@mail.gmail.com>
 <20210622121546.GN1096940@ziepe.ca> <CAFCwf13BuS+U3Pko_62hFPuvZPG26HQXuu-cxPmcADNPO22g9g@mail.gmail.com>
 <20210622151142.GA2431880@ziepe.ca>
In-Reply-To: <20210622151142.GA2431880@ziepe.ca>
From:   Oded Gabbay <oded.gabbay@gmail.com>
Date:   Tue, 22 Jun 2021 18:24:28 +0300
Message-ID: <CAFCwf1361iVGeGtcc8WsQeFmHMWY+J6UNkzJnrodFrsOh9zgqQ@mail.gmail.com>
Subject: Re: [Linaro-mm-sig] [PATCH v3 1/2] habanalabs: define uAPI to export
 FD for DMA-BUF
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
        Gal Pressman <galpress@amazon.com>, sleybo@amazon.com,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Oded Gabbay <ogabbay@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
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

On Tue, Jun 22, 2021 at 6:11 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Tue, Jun 22, 2021 at 04:12:26PM +0300, Oded Gabbay wrote:
>
> > > 1) Setting sg_page to NULL
> > > 2) 'mapping' pages for P2P DMA without going through the iommu
> > > 3) Allowing P2P DMA without using the p2p dma API to validate that it
> > >    can work at all in the first place.
> > >
> > > All of these result in functional bugs in certain system
> > > configurations.
> > >
> > > Jason
> >
> > Hi Jason,
> > Thanks for the feedback.
> > Regarding point 1, why is that a problem if we disable the option to
> > mmap the dma-buf from user-space ?
>
> Userspace has nothing to do with needing struct pages or not
>
> Point 1 and 2 mostly go together, you supporting the iommu is not nice
> if you dont have struct pages.
>
> You should study Logan's patches I pointed you at as they are solving
> exactly this problem.
Yes, I do need to study them. I agree with you here. It appears I have
a hole in my understanding.
I'm missing the connection between iommu support (which I must have of
course) and struct pages.

>
> > In addition, I didn't see any problem with sg_page being NULL in the
> > RDMA p2p dma-buf code. Did I miss something here ?
>
> No, the design of the dmabuf requires the exporter to do the dma maps
> and so it is only the exporter that is wrong to omit all the iommu and
> p2p logic.
>
> RDMA is OK today only because nobody has implemented dma buf support
> in rxe/si - mainly because the only implementations of exporters don't
Can you please educate me, what is rxe/si ?

> set the struct page and are thus buggy.

ok...
so how come that patch-set was merged into 5.12 if it's buggy ?
Because the current exporters are buggy ?  I probably need a history
lesson here.
But I understand why you think it's a bad idea to add a new buggy exporter.

>
> > I will take two GAUDI devices and use one as an exporter and one as an
> > importer. I want to see that the solution works end-to-end, with real
> > device DMA from importer to exporter.
>
> I can tell you it doesn't. Stuffing physical addresses directly into
> the sg list doesn't involve any of the IOMMU code so any configuration
> that requires IOMMU page table setup will not work.
>
> Jason

Yes, that's what I expect to see. But I want to see it with my own
eyes and then figure out how to solve this.
Maybe the result will be going to Logan's path, maybe something else,
but I need to start by seeing the failure in a real system.

Thanks for the information, it is really helpful.

Oded
