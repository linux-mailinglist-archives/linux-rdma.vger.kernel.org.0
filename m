Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23413472B26
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Dec 2021 12:19:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231390AbhLMLTK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 13 Dec 2021 06:19:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231281AbhLMLTK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 13 Dec 2021 06:19:10 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CA6CC061574
        for <linux-rdma@vger.kernel.org>; Mon, 13 Dec 2021 03:19:09 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id b40so30133956lfv.10
        for <linux-rdma@vger.kernel.org>; Mon, 13 Dec 2021 03:19:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igel-co-jp.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=pisr92gZKvsteBy/s9F3IAR+cQBvUriK+eu6zsF7wyw=;
        b=Q9NH27t3R9Qm08Yn225jCBXBnjCDUbBZlO9iRSlzuJM0fyX3f4CIpWznxDuwS3/xNl
         y2RpQuwsrnpMkdIOZb4IWOfvErkD6LdjKd7X8Paq83V3hc5v2n3QXq3pP4vuRHpp8gyK
         QkJW8E8vid1iTF5iQKzovyuhseShdVMobmPGSrZXnl9JqSSSPJlix4PWSVSmZMrKeyhO
         ygeYT11OLE4eFeCBzH4iRsOtraCkEgzGqvcV/xvaxftmcI3T2BN7wUUKDpuZG+EkT+ai
         hBk2Zdp1yNsq5FvvflSwi97L2anCWRtNWArzEuD2dELEz2VNih1Zd0dWPKt9aRScBjcZ
         ILGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pisr92gZKvsteBy/s9F3IAR+cQBvUriK+eu6zsF7wyw=;
        b=i5BdaYW6q0vocudqmYwMDw/rc/NE+/G0eu6/AhbPeDXglNRSA3r3EWe7QoDLKDLI1c
         GugCmWbmZ8oONSPwYFyaCx71wjtzKnv9kQMUHO8Z44y0FeIwFgeIinxRcT7c5iTFzxr8
         XPQSWv87Rmu/gL1vk3IoMAh+aP4/TPBptU8hOOUFRcqfQojWHQpN0Er3r8dWF6hmc8pY
         Jn3rT+RQqIfyrSueweFZDJlrYElmEDOeW04g4j1EDGQaTPCX9i0u0XI98hH7sRehoWJU
         KoJ9dGsM7uoY5xZ5mkzia4zD4MGlD1VYzmCo06QBEwFXXKX2dQP1LA5NFsU9gOoa0Ntm
         PzQA==
X-Gm-Message-State: AOAM5325NLpkKroMCGAaEF4357Jd8Pd5PYfbnB8u85t6B1bi/+5l4BMv
        yu+K0MOY8TGK5rBytb/mBaTH5mccxaH6kcKemUVdlw==
X-Google-Smtp-Source: ABdhPJx30c7FAJ3lvGEDI+ZSXrcR+/grZyj0VFN1XwsLOUnbgMIYy/6u7p86PmkVTn96nNYygrLsKqZS0iLS3XSZseg=
X-Received: by 2002:a05:6512:118b:: with SMTP id g11mr26987032lfr.46.1639394347900;
 Mon, 13 Dec 2021 03:19:07 -0800 (PST)
MIME-Version: 1.0
References: <20211122110817.33319-1-mie@igel.co.jp> <CANXvt5oB8_2sDGccSiTMqeLYGi3Vuo-6NnHJ9PGgZZMv=fnUVw@mail.gmail.com>
 <20211207171447.GA6467@ziepe.ca> <CANXvt5rCayOcengPr7Z_aFmJaXwWj9VcWZbaHnuHj6=2CkPndA@mail.gmail.com>
 <20211210124204.GG6467@ziepe.ca> <880e25ad-4fe9-eacd-a971-993eaea37fc4@amd.com>
 <20211210132656.GH6467@ziepe.ca> <d25b2895-63b6-158d-ff73-f05e437e0f91@amd.com>
In-Reply-To: <d25b2895-63b6-158d-ff73-f05e437e0f91@amd.com>
From:   Shunsuke Mie <mie@igel.co.jp>
Date:   Mon, 13 Dec 2021 20:18:57 +0900
Message-ID: <CANXvt5rzmEnF3Gph4U6NT-XzJhV6zqyay1g7dHkTgH=Aqc6Geg@mail.gmail.com>
Subject: Re: [RFC PATCH v4 0/2] RDMA/rxe: Add dma-buf support
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Zhu Yanjun <zyjzyj2000@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Doug Ledford <dledford@redhat.com>,
        Jianxin Xiong <jianxin.xiong@intel.com>,
        Leon Romanovsky <leon@kernel.org>,
        Maor Gottlieb <maorg@nvidia.com>,
        Sean Hefty <sean.hefty@intel.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        linux-media@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Damian Hobson-Garcia <dhobsong@igel.co.jp>,
        Takanari Hayama <taki@igel.co.jp>,
        Tomohito Esaki <etom@igel.co.jp>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

2021=E5=B9=B412=E6=9C=8810=E6=97=A5(=E9=87=91) 22:29 Christian K=C3=B6nig <=
christian.koenig@amd.com>:
>
> Am 10.12.21 um 14:26 schrieb Jason Gunthorpe:
> > On Fri, Dec 10, 2021 at 01:47:37PM +0100, Christian K=C3=B6nig wrote:
> >> Am 10.12.21 um 13:42 schrieb Jason Gunthorpe:
> >>> On Fri, Dec 10, 2021 at 08:29:24PM +0900, Shunsuke Mie wrote:
> >>>> Hi Jason,
> >>>> Thank you for replying.
> >>>>
> >>>> 2021=E5=B9=B412=E6=9C=888=E6=97=A5(=E6=B0=B4) 2:14 Jason Gunthorpe <=
jgg@ziepe.ca>:
> >>>>> On Fri, Dec 03, 2021 at 12:51:44PM +0900, Shunsuke Mie wrote:
> >>>>>> Hi maintainers,
> >>>>>>
> >>>>>> Could you please review this patch series?
> >>>>> Why is it RFC?
> >>>>>
> >>>>> I'm confused why this is useful?
> >>>>>
> >>>>> This can't do copy from MMIO memory, so it shouldn't be compatible
> >>>>> with things like Gaudi - does something prevent this?
> >>>> I think if an export of the dma-buf supports vmap, CPU is able to ac=
cess the
> >>>> mmio memory.
> >>>>
> >>>> Is it wrong? If this is wrong, there is no advantages this changes..
> >>> I don't know what the dmabuf folks did, but yes, it is wrong.
> >>>
> >>> IOMEM must be touched using only special accessors, some platforms
> >>> crash if you don't do this. Even x86 will crash if you touch it with
> >>> something like an XMM optimized memcpy.
> >>>
> >>> Christian? If the vmap succeeds what rules must the caller use to
> >>> access the memory?
> >> See dma-buf-map.h and especially struct dma_buf_map.
> >>
> >> MMIO memory is perfectly supported here and actually the most common c=
ase.
> > Okay that looks sane, but this rxe RFC seems to ignore this
> > completely. It stuffs the vaddr directly into a umem which goes to all
> > manner of places in the driver.
> >
> > ??
>
> Well, yes that can go boom pretty quickly.
Sorry, I was wrong. The dma_buf_map treats both iomem and vaddr region, but
this RFC only supports vaddr. Advantage of the partial support is we can us=
e the
vaddr dma-buf in RXE without changing a rxe data copy implementation.

An example of a dma-buf pointing to a vaddr is some gpu drivers use RAM for
VRAM and we can get dma-buf for the region that indicates vaddr regions.
Specifically, the gpu driver using gpu/drm/drm_gem_cma_helper.c is one such
example.

> Not sure what they want to use this for.
I'd like to use RDMA with RXE for that memory region.

Best,
Shunsuke
> Christian.
>
> >
> > Jason
>
