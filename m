Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 187AE30F43D
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Feb 2021 14:55:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236457AbhBDNvn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 4 Feb 2021 08:51:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236124AbhBDNvc (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 4 Feb 2021 08:51:32 -0500
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 066EFC0613D6
        for <linux-rdma@vger.kernel.org>; Thu,  4 Feb 2021 05:50:50 -0800 (PST)
Received: by mail-oo1-xc32.google.com with SMTP id z36so767433ooi.6
        for <linux-rdma@vger.kernel.org>; Thu, 04 Feb 2021 05:50:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DB61A9zwN5JbCrUSGbgi+YlUmk0sna7FAWRcwbAA10U=;
        b=Kc79uhb28akxRTbMPg+WMOWTfxyPp+QPmP3EeRomf34bYMT5ODsR8AsyupITlQm4+L
         PEWVUSR0Er1doMe+MFNZjGfIUNqvUlJAZ4oWw241tYp5mz00j+VGFHoc1E0FIZxgQjms
         GHkmJNhT409VDAZfclr2zMK7w+tKY01FNJHtiFggtZRKRfbLVI+1+T7dH1793imXNgOY
         StBE38MN2hTazGjwXjfbzvIwi1ZCY1F/Tzw435eBkmLSpg5tSbUh4xRNQO+482p+wgAM
         npQjxw3bGiyE4mMSWVBD92DhDGu3ZsS1yYighLlT9Ivqbg9roBdxhLrh3aloQo1qVUSo
         rRfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DB61A9zwN5JbCrUSGbgi+YlUmk0sna7FAWRcwbAA10U=;
        b=IwmT3I+r7kzNC01WlUFLAByUx9rhXyM5u04QNDtf71gL9817+2HfMWcM12JqwA8+bt
         iBwb7Efru9rsYRP+Zwyu8C/CMAeMrdUx9BvVs8gHuxgJ13rd0Rwzmkekqn9aKkLXpsMm
         XO8NetvQAAwyjw8Htg7rCBBzkzf24rOdbePZj9557fR233yfynJlNwFSgwHIFnfYRbrA
         DFF0bu2LqojXMtll/aQ52FulnwClKCJr1IhI45aFv8zMj5vUI/QBak9HIcfXFnFoJRLY
         46PdlkdWvT2GCl3+RVRh1M5+OjAwv3D6rn6roqvf1JDzuAUVRzjRHAaDpRA+fhExL8z/
         JIJw==
X-Gm-Message-State: AOAM531P/dsMTkQzv0ziXOeZUHp3Kw7pPGlQ8g0kZzxB/BJhLwL+g+ke
        gQc6MvzUHRSFk6HInZZtHZ3cQzaNy0vHVJLVDj0=
X-Google-Smtp-Source: ABdhPJxEHe9Sc2AQbmCn9y/ZhPaAoIay1/acK2RNsdQigvHF+i5RVELNW8SRus+VIX0Pl/ihPyre4o8LqCyN0zHQb/M=
X-Received: by 2002:a4a:de94:: with SMTP id v20mr5642639oou.90.1612446649498;
 Thu, 04 Feb 2021 05:50:49 -0800 (PST)
MIME-Version: 1.0
References: <1608067636-98073-1-git-send-email-jianxin.xiong@intel.com> <5e4ac17d-1654-9abc-9a14-bda223d62866@nvidia.com>
In-Reply-To: <5e4ac17d-1654-9abc-9a14-bda223d62866@nvidia.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 4 Feb 2021 08:50:38 -0500
Message-ID: <CADnq5_M2YuOv16E2DG6sCPtL=z5SDDrN+y7iwD_pHVc7Omyrmw@mail.gmail.com>
Subject: Re: [PATCH v16 0/4] RDMA: Add dma-buf support
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Jianxin Xiong <jianxin.xiong@intel.com>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Leon Romanovsky <leon@kernel.org>,
        Christian Koenig <christian.koenig@amd.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>,
        Daniel Vetter <daniel.vetter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Feb 4, 2021 at 2:48 AM John Hubbard <jhubbard@nvidia.com> wrote:
>
> On 12/15/20 1:27 PM, Jianxin Xiong wrote:
> > This patch series adds dma-buf importer role to the RDMA driver in
> > attempt to support RDMA using device memory such as GPU VRAM. Dma-buf is
> > chosen for a few reasons: first, the API is relatively simple and allows
> > a lot of flexibility in implementing the buffer manipulation ops.
> > Second, it doesn't require page structure. Third, dma-buf is already
> > supported in many GPU drivers. However, we are aware that existing GPU
> > drivers don't allow pinning device memory via the dma-buf interface.
> > Pinning would simply cause the backing storage to migrate to system RAM.
> > True peer-to-peer access is only possible using dynamic attach, which
> > requires on-demand paging support from the NIC to work. For this reason,
> > this series only works with ODP capable NICs.
>
> Hi,
>
> Looking ahead to after this patchset is merged...
>
> Are there design thoughts out there, about the future of pinning to vidmem,
> for this? It would allow a huge group of older GPUs and NICs and such to
> do p2p with this approach, and it seems like a natural next step, right?

The argument is that vram is a scarce resource, but I don't know if
that is really the case these days.  At this point, we often have as
much vram as system ram if not more.

Alex
