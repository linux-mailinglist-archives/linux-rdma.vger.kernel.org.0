Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20A5C339B7C
	for <lists+linux-rdma@lfdr.de>; Sat, 13 Mar 2021 04:03:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbhCMDDM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 12 Mar 2021 22:03:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbhCMDDA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 12 Mar 2021 22:03:00 -0500
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E66EBC061574
        for <linux-rdma@vger.kernel.org>; Fri, 12 Mar 2021 19:02:59 -0800 (PST)
Received: by mail-ot1-x32c.google.com with SMTP id w21-20020a9d63950000b02901ce7b8c45b4so2421074otk.5
        for <linux-rdma@vger.kernel.org>; Fri, 12 Mar 2021 19:02:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uQCyUuDgNt3tIF8fWWgJ4elkkMgIOODvzbGeTSUT4C0=;
        b=T11WmN+otiJY5UpS59rEdQoXzuSxihqhxodigYMfX7msICjLGXJ5dCqxKghzq0rT5B
         Zg7IpN6FJrdTqYeVIOdTFfKr05MAcSdgUHozniupAXPSDVsN6D1M00MzAuWxoEIn+JGJ
         NJ/LigiydIDuHROW5jOcSzn0gfGt3rXRJdSTT9tp0mxlA5eWNuC7HOHqxSX/e00+CSSB
         9967Aavx/+AFaUZOe8pOqdJQ2QsNBgQhUM6PfLGtlD2GcIOKr7M5wFkXHAna/Bxi4K2g
         2paYgUTwBvCIe52WnG1uv4nO+LWTW1+5Uplr7b1UyaFrTzIe0hAD1x65TAUEB4X1M6rE
         jL8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uQCyUuDgNt3tIF8fWWgJ4elkkMgIOODvzbGeTSUT4C0=;
        b=luAD/54pzF0MUkKqJAm6Z2A7UarBW60oU2dT20sFV+Oxb7z21Zgui60SgAnZ/y3oXF
         jxXDhzNJkJZebvC7Wj8Uch5zkywVE5x5yzWe4sTlA2eOvno9IlrSWVLCp/d1I7JNC5Tk
         AV/66N9HGLpdYw7jkZCAFTf2X3d/IwIjOvLzfTvf/Kp7lqilwenLZWFMflLGQNw3pwvC
         g0n3Rvk9wzSyGOXNX5ZZJBHbFB6dSfzl3ixS2/mVHT4bp9+GhUOD3cApqR3kHrfmRJMu
         /VqQ3XGS7maXCq4wyRD+XNldN9Jwfsss9DlEiraIUO1gbj5sIXU5QtwJTUEopZh6UBoO
         OOBA==
X-Gm-Message-State: AOAM532K+NC8n79oBDVxpegHc04fJfpPMPBU1uXtn6xPNONquOZCi4Pc
        mOxUkaQYgSkGI1O2FENnQz7JWuXaH2mB0v1g6GI=
X-Google-Smtp-Source: ABdhPJydUQmfM5m7N1ALsS/6nQ1lxgih4ZW138IIVHZSB/eZrpaINFMYYaVCIsnGuyFEaDdVY8kBV2H7LXZOVinRhvk=
X-Received: by 2002:a9d:7650:: with SMTP id o16mr5708743otl.278.1615604572861;
 Fri, 12 Mar 2021 19:02:52 -0800 (PST)
MIME-Version: 1.0
References: <CAD=hENeqTTmpS5V+G646V0QvJFLVSd3Sq11ffQFcDXU-OSsQEg@mail.gmail.com>
 <YEUL2vdlWFEbZqLb@unreal> <CAD=hENcjqtXstsa3bbBCZVGF-XgAhPz-1tom68zm7WNatH2mZw@mail.gmail.com>
 <20210308121615.GW4247@nvidia.com> <CAD=hENdymrkFV-_piiOKL-fK38SQh3sTAfc7+WPSky8mHtJ8DA@mail.gmail.com>
 <20210312002533.GS2356281@nvidia.com> <CAD=hENcb4DAs7hhPLqgqAhLr8xYqxkMhGp=99bfgq1SZN57QHA@mail.gmail.com>
 <20210312130243.GU2356281@nvidia.com> <CAD=hENdqu3v5_PJwQF2=zQ6ifGZD_DUJtUStoiCA5byru5phaA@mail.gmail.com>
 <CAD=hENf07aKBivP93tN9CAR4oZ9jEygmVKowpxGTdAAV9pjpEA@mail.gmail.com> <20210312140104.GX2356281@nvidia.com>
In-Reply-To: <20210312140104.GX2356281@nvidia.com>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Sat, 13 Mar 2021 11:02:41 +0800
Message-ID: <CAD=hENcNLNvX1isjUYutfsDrXzjpJZWBMaB4EkeBMTz7F4x=pw@mail.gmail.com>
Subject: Re: Fwd: [PATCH 1/1] RDMA/umem: add back hugepage sg list
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        maorg@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Mar 12, 2021 at 10:01 PM Jason Gunthorpe <jgg@nvidia.com> wrote:
>
> On Fri, Mar 12, 2021 at 09:49:52PM +0800, Zhu Yanjun wrote:
> > In short, the sg list from __sg_alloc_table_from_pages is different
> > from the sg list from ib_umem_add_sg_table.
>
> I don't care about different. Tell me what is wrong with what we have
> today.
>
> I thought your first message said the sgl's were too small, but now
> you seem to say they are too big?

Sure.

The sg list from __sg_alloc_table_from_pages, length of sg is too big.
And the dma address is like the followings:

"
sg_dma_address(sg):0x4b3c1ce000
sg_dma_address(sg):0x4c3c1cd000
sg_dma_address(sg):0x4d3c1cc000
sg_dma_address(sg):0x4e3c1cb000
"

The sg list from ib_umem_add_sg_table, length of sg is 2M.
And the dma address is like the followings:
"
sg_dma_address(sg):0x203b400000
sg_dma_address(sg):0x213b200000
sg_dma_address(sg):0x223b000000
sg_dma_address(sg):0x233ae00000
sg_dma_address(sg):0x243ac00000
"
The above 2 sg lists will be handled in this function ib_umem_find_best_pgsz.
The returned values are different.

Zhu Yanjun
>
> I still have no idea what this problem is
>
> Jason
