Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F2163DDB20
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Aug 2021 16:34:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233939AbhHBOer (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 2 Aug 2021 10:34:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234380AbhHBOeb (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 2 Aug 2021 10:34:31 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 548DEC061796
        for <linux-rdma@vger.kernel.org>; Mon,  2 Aug 2021 07:34:21 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id y34so34086913lfa.8
        for <linux-rdma@vger.kernel.org>; Mon, 02 Aug 2021 07:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bkFpCSh9FfN97YxjwRJHic4KVV+k2i4JH2uEmfv1alc=;
        b=Ey4QUE5z6ny8QN9J94kl+UJrzFkGjlFUcL+MRlVpwZRBo92QHKilnBnxae4TphSyK5
         NvdudP8+b39nOJCbSB5LEyHwJ9CsiEkIxIXt4lWeBnsIVPpgt9z0m1HS42uvmR+aV5/f
         KeHEnkdB2yCh9BRoTPuP+aaFg+3OnF2OgyUjbZB2/foA9NMUNg8FY6P5xrA/JbnjdkwJ
         ZZRJ+FsZCqqQz4XwbXuMmhy48G6KoUGM5aqwqWexWcCCd/JzEMqmcC2nk2OPBdZrE6iC
         AQf5t8lluxW1qIYHj3A7XGm5Dc9awXsSkrl9Sx6lq35f01buY79yynfrRhA1mWLYAE87
         fm7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bkFpCSh9FfN97YxjwRJHic4KVV+k2i4JH2uEmfv1alc=;
        b=f3x7u3nENQpqzpWq0sDird/3lmmJRBFcSQNn4WaV/TcFL55gzqNxyJyFKM90gD7nWw
         RVNULT6lvMbeMx+IRZ7Ai7umlloCQZKshMzQ5BsZCRv6QeAYlmdxoAZj7f4d2iyA2WYK
         NJnX+PfsG4DRTyMT6VCe5Q4vyC6BuyhjfkZmrAz4EbNeevcX00cXzt8VObdWDaMMnE78
         +GOHZvblUgNy9wU7Coj0TFjRcT5/sewsxCglUgDUbvP3g022R1bWu4sEwOIiMcpJyzjO
         VVBFQX1OMg8wwGNnyDdNMrP3oUZBrpW5veoYww8WXsGIbROzru/IKaGXQcLBCka+aci/
         oFlw==
X-Gm-Message-State: AOAM5327Z1d/sxgba47rVrQbDBsqRuTsHvyio2X2+96vnqQWNC7efg3A
        VIyxGFpVVlFWe7QQ7EARm3bJESW0tja0WmcDy7w9Rg==
X-Google-Smtp-Source: ABdhPJxtpOKCCtiqzTy+K4nBbaXKy+fL6iTv5d3y5l6QJJEUCLyeCNW/SPgS0a3N1x+QV7vN2iFdIgNpkXOn58vgK0g=
X-Received: by 2002:a19:f11b:: with SMTP id p27mr13080357lfh.422.1627914859551;
 Mon, 02 Aug 2021 07:34:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210730131832.118865-1-jinpu.wang@ionos.com> <20210730131832.118865-7-jinpu.wang@ionos.com>
 <YQeaCMYGAqDHzsi5@unreal>
In-Reply-To: <YQeaCMYGAqDHzsi5@unreal>
From:   Haris Iqbal <haris.iqbal@ionos.com>
Date:   Mon, 2 Aug 2021 16:34:08 +0200
Message-ID: <CAJpMwyha3ygshtja4OyhQPwdfvew6EC_-S3M9LHhwsqOTKonog@mail.gmail.com>
Subject: Re: [PATCH for-next 06/10] RDMA/rtrs: Remove len parameter from
 helper print functions of sysfs
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Jack Wang <jinpu.wang@ionos.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Aug 2, 2021 at 9:09 AM Leon Romanovsky <leon@kernel.org> wrote:
>
> On Fri, Jul 30, 2021 at 03:18:28PM +0200, Jack Wang wrote:
> > From: Md Haris Iqbal <haris.iqbal@ionos.com>
> >
> > Since we have changed all sysfs show functions to use sysfs_emit, we do
> > not require the len (PAGE_SIZE) in our helper print functions. So remove
> > it from the function parameter.
> >
> > Signed-off-by: Md Haris Iqbal <haris.iqbal@ionos.com>
> > Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
> > ---
> >  drivers/infiniband/ulp/rtrs/rtrs-clt-stats.c | 12 ++++--------
> >  drivers/infiniband/ulp/rtrs/rtrs-clt.h       | 12 +++++-------
> >  drivers/infiniband/ulp/rtrs/rtrs-pri.h       |  2 +-
> >  drivers/infiniband/ulp/rtrs/rtrs-srv-stats.c |  3 +--
> >  drivers/infiniband/ulp/rtrs/rtrs-srv.h       |  3 +--
> >  5 files changed, 12 insertions(+), 20 deletions(-)
>
> I suggest to squash this patch to the one mentioned in the commit message.

The purpose of the 2 patches are different. I would prefer keeping
them separate; unless there is a clear and obvious reason NOT to do
so.

Thanks

>
> Thanks
