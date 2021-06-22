Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E49033B03A7
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Jun 2021 14:05:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230273AbhFVMHP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 22 Jun 2021 08:07:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231276AbhFVMHO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 22 Jun 2021 08:07:14 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FFB4C061574;
        Tue, 22 Jun 2021 05:04:58 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id t40so23475185oiw.8;
        Tue, 22 Jun 2021 05:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=UXu33zooM1Crc13Vebp8C5tdePhjb755cOhdTYx1RhI=;
        b=IBxYEyz8qFrpyXjdmOhua9qpGyNdwX02NaojZVpftJeAz4cyuDCEAd0+qADxitTYR9
         7LRSirAlbT/vLaBcd+EYJxNpTrceIy3pY9v4vL2s6kVGve2mWavF/S9gdoUEARKwK86J
         MRxtY7QJRKDwFpOVd1o8eFa7zoGV0XWD+kEyUY9F4Fya8NeamnK6jjoUDTk28fAgr6hp
         xtzu8p/laLWYbN9YzUjaZnlg2BzkAEBUrlpuilkihQrotRNoB1aKYIzadRsiBb/qRf5P
         5eigpS//hdZK/xPV9k2CHEAQdna490dEykBfiNm2Sx4X4XKQnb3AfoUMJXKOf+KtYuYs
         /9Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=UXu33zooM1Crc13Vebp8C5tdePhjb755cOhdTYx1RhI=;
        b=k1ECK+fAcnROWxBvZQDQP/K9jTBoZmDvzERi+biK6ZlPeqvCd1b+jXbMbIM67oGxIw
         MODB2zi4V4IYd+8krZCYRho86jdoynSkr/5mYLS3pxjeG3BQZEl9fUh62LS6+s8x55sO
         iJnz7Uqq6MHOjdtKM/jTQXV+SQvbrnqmtha9YS47WayhTY+xfXrRbEagtw7UuPmXjJuw
         0D0OSEAxBHpEV07Bpr9pcdivOG5ZvI+pFxPHbRLqd+BPxRkm4mmpPPNyVTV1jMsj0sDm
         bkGAUcOLJ3sEeGmXQ7IaF0y3EEB7A3hscArzl3/Z9ZzQxK2xLlOJ50Vcv0O+3leCN6Yx
         6tqw==
X-Gm-Message-State: AOAM533dFAztzj6MnI0PpH0SeaLyRSoHa0Cqx1QppMw6vZhwC8bFSwhz
        DPuxgM7TXchH+DhHRZFCGkgEuuek9gq2EVGQ39g=
X-Google-Smtp-Source: ABdhPJz9eTOAYS/A5LDYycSvFHQxs/rBQ2qipYP0MTUC17z8ZF/zeA2uqIWquOAnXIrUs1z3RzFaGSzZm9SwmWCsolo=
X-Received: by 2002:aca:ac02:: with SMTP id v2mr2855756oie.154.1624363497566;
 Tue, 22 Jun 2021 05:04:57 -0700 (PDT)
MIME-Version: 1.0
References: <CAKMK7uFOfoxbD2Z5mb-qHFnUe5rObGKQ6Ygh--HSH9M=9bziGg@mail.gmail.com>
 <YNCN0ulL6DQiRJaB@kroah.com> <20210621141217.GE1096940@ziepe.ca>
 <CAFCwf10KvCh0zfHEHqYR-Na6KJh4j+9i-6+==QaMdHHpLH1yEA@mail.gmail.com>
 <20210621175511.GI1096940@ziepe.ca> <CAKMK7uEO1_B59DtM7N2g7kkH7pYtLM_WAkn+0f3FU3ps=XEjZQ@mail.gmail.com>
 <CAFCwf11jOnewkbLuxUESswCJpyo7C0ovZj80UrnwUOZkPv2JYQ@mail.gmail.com>
 <20210621232912.GK1096940@ziepe.ca> <d358c740-fd3a-9ecd-7001-676e2cb44ec9@gmail.com>
 <CAFCwf11h_Nj_GEdCdeTzO5jgr-Y9em+W-v_pYUfz64i5Ac25yg@mail.gmail.com> <20210622120142.GL1096940@ziepe.ca>
In-Reply-To: <20210622120142.GL1096940@ziepe.ca>
From:   Oded Gabbay <oded.gabbay@gmail.com>
Date:   Tue, 22 Jun 2021 15:04:30 +0300
Message-ID: <CAFCwf10GmBjeJAFp0uJsMLiv-8HWAR==RqV9ZdMQz+iW9XWdTA@mail.gmail.com>
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
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jun 22, 2021 at 3:01 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Tue, Jun 22, 2021 at 11:42:27AM +0300, Oded Gabbay wrote:
> > On Tue, Jun 22, 2021 at 9:37 AM Christian K=C3=B6nig
> > <ckoenig.leichtzumerken@gmail.com> wrote:
> > >
> > > Am 22.06.21 um 01:29 schrieb Jason Gunthorpe:
> > > > On Mon, Jun 21, 2021 at 10:24:16PM +0300, Oded Gabbay wrote:
> > > >
> > > >> Another thing I want to emphasize is that we are doing p2p only
> > > >> through the export/import of the FD. We do *not* allow the user to
> > > >> mmap the dma-buf as we do not support direct IO. So there is no ac=
cess
> > > >> to these pages through the userspace.
> > > > Arguably mmaping the memory is a better choice, and is the directio=
n
> > > > that Logan's series goes in. Here the use of DMABUF was specificall=
y
> > > > designed to allow hitless revokation of the memory, which this isn'=
t
> > > > even using.
> > >
> > > The major problem with this approach is that DMA-buf is also used for
> > > memory which isn't CPU accessible.
>
> That isn't an issue here because the memory is only intended to be
> used with P2P transfers so it must be CPU accessible.
>
> > > That was one of the reasons we didn't even considered using the mappi=
ng
> > > memory approach for GPUs.
>
> Well, now we have DEVICE_PRIVATE memory that can meet this need
> too.. Just nobody has wired it up to hmm_range_fault()
>
> > > > So you are taking the hit of very limited hardware support and redu=
ced
> > > > performance just to squeeze into DMABUF..
> >
> > Thanks Jason for the clarification, but I honestly prefer to use
> > DMA-BUF at the moment.
> > It gives us just what we need (even more than what we need as you
> > pointed out), it is *already* integrated and tested in the RDMA
> > subsystem, and I'm feeling comfortable using it as I'm somewhat
> > familiar with it from my AMD days.
>
> You still have the issue that this patch is doing all of this P2P
> stuff wrong - following the already NAK'd AMD approach.

Could you please point me exactly to the lines of code that are wrong
in your opinion ?
I find it hard to understand from your statement what exactly you
think that we are doing wrong.
The implementation is found in the second patch in this patch-set.

Thanks,
Oded
>
> > I'll go and read Logan's patch-set to see if that will work for us in
> > the future. Please remember, as Daniel said, we don't have struct page
> > backing our device memory, so if that is a requirement to connect to
> > Logan's work, then I don't think we will want to do it at this point.
>
> It is trivial to get the struct page for a PCI BAR.
>
> Jason
