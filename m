Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2820B257F28
	for <lists+linux-rdma@lfdr.de>; Mon, 31 Aug 2020 18:59:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728777AbgHaQ7O (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 31 Aug 2020 12:59:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727989AbgHaQ7O (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 31 Aug 2020 12:59:14 -0400
Received: from mail-vk1-xa44.google.com (mail-vk1-xa44.google.com [IPv6:2607:f8b0:4864:20::a44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C10C9C061573
        for <linux-rdma@vger.kernel.org>; Mon, 31 Aug 2020 09:59:13 -0700 (PDT)
Received: by mail-vk1-xa44.google.com with SMTP id n12so1455863vkk.11
        for <linux-rdma@vger.kernel.org>; Mon, 31 Aug 2020 09:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=srust-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2DWNDv66ke9vxOwbFZD11+ebbA9tjX7pT3LySr5I6ME=;
        b=IOoYtlT8bMaHr+cNxOWTZOImEceSkMUaisYGNeeN7gNcDgjPLVsqxs+jALV4w2eOla
         jBSAGmfGs6aT9AsC9VC5A7ZVvL/xR0l3ZocE0eUwVZoehSxkrdWpru7BrVvUPPvU0dMF
         Mc7mLwTvPEoWctJt3lS0L5nwxAzLmJgONKOgLQckDgPcAZSTJVabmT0S8cgvNEiD5VUC
         /iQrksdcxaKLgCFfzHp6KSOQVzF9oQhygR9ms4GYrOgpjX+RAPj5/GGlLnmi823ZQ1KL
         cUOWsx0SaHN4L6Ib7rg1Lj/kWkYbWayitBQqMOuyrqWNrLV1h7g+bHD0mu3Iog/IyzMH
         mj/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2DWNDv66ke9vxOwbFZD11+ebbA9tjX7pT3LySr5I6ME=;
        b=MSWR9FH/u/YfUf727xCQBJ2FLfCQAwcuEe3p3R6FrlDsocVLeOwtO7AuuePE2pAnDL
         4GqzHo4f2+eD/LHgqgP8t3L/1j9jL28V3/6lcmFAy4t/D/VXvlEki4MsIWHQrRBV5MgF
         D+3wg1yPJ+1UjxBUpWPAuvNUtcdk5I/dkgOqgfi0igJrl4Htd2M/PoFrz92vl4sDEneP
         ONFNNWTGwa7riJX2qQAGZ/jb3WACVe8GU+oS8qcjZANtBNdyP3JUB618apg6a4O4Lt1o
         K3ZOaW0bkR0C8qhR989goCTNkiTjbJB7dMgF9e97H+jYLaX10te2954p+SQ7mOtqRtd8
         KJeA==
X-Gm-Message-State: AOAM530TWcnqTCaEdlGXTPVgKnExwi7HWRpVdlDRdItqsitCH19L/8hK
        2wxzWoQf/kj70hWIeCoFtl8OE9FGBROdiWYMVj0=
X-Google-Smtp-Source: ABdhPJx5qsncHgI7QGw86VMp6EvvEwUo5RYl760kSQgSQHS9Z7SqVvmrVR9FqOusf3CPGme6juY8saor1RwZtj3+bLs=
X-Received: by 2002:ac5:c311:: with SMTP id j17mr1782298vkk.61.1598893152758;
 Mon, 31 Aug 2020 09:59:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200830103209.378141-1-sagi@grimberg.me> <20200831121818.GZ24045@ziepe.ca>
 <8bc2755b-e7d6-5d9c-f5e0-e8036b28beb6@grimberg.me> <CAAFE1bcXNdMD5AR80tSFVoYouTrEg_swR73ba2FVEB5UH7MXLQ@mail.gmail.com>
In-Reply-To: <CAAFE1bcXNdMD5AR80tSFVoYouTrEg_swR73ba2FVEB5UH7MXLQ@mail.gmail.com>
From:   Stephen Rust <srust@srust.org>
Date:   Mon, 31 Aug 2020 12:59:02 -0400
Message-ID: <CAHPtSN4=wsJaEOhsfD==xXoq0ahWy26nD=0z4fVvAoDn_mvZAQ@mail.gmail.com>
Subject: Re: [PATCH] IB/isert: fix unaligned immediate-data handling
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-rdma@vger.kernel.org, Max Gurtovoy <maxg@mellanox.com>,
        Stephen Rust <srust@blockbridge.com>,
        Doug Dumitru <doug@dumitru.com>,
        ming Lei <ming.lei@redhat.com>,
        Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Please see the following original thread for the history, and the git
bisect showing which commit this was introduced. Other consumers of
block layer (eg: xfs) also were required to change their alignment
around this time, to be 512B aligned.

https://lore.kernel.org/linux-rdma/20191203041504.GC6245@ming.t460p/T/#m478c0b2a455a4b897320fa859b89910ffd7b6697

Thanks.

Sagi Grimberg <sagi@grimberg.me>
> >> Currently we allocate rx buffers in a single contiguous buffers
> >> for headers (iser and iscsi) and data trailer. This means
> >> that most likely the data starting offset is aligned to 76
> >> bytes (size of both headers).
> >>
> >> This worked fine for years, but at some point this broke.
> >> To fix this, we should avoid passing unaligned buffers for
> >> I/O.
> >
> > That is a bit vauge - what suddenly broke it?
>
> Somewhere around the multipage bvec work that Ming did. The issue was
> that brd assumed a 512 aligned page vector. IIRC the discussion settled
> that the block layer expects a 512B aligned buffer(s).
>
> Adding Ming to the thread.
