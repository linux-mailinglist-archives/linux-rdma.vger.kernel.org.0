Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C63EB44FFF3
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Nov 2021 09:19:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbhKOIWJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 15 Nov 2021 03:22:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbhKOIWD (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 15 Nov 2021 03:22:03 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E001C061746
        for <linux-rdma@vger.kernel.org>; Mon, 15 Nov 2021 00:18:50 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id r11so4320178edd.9
        for <linux-rdma@vger.kernel.org>; Mon, 15 Nov 2021 00:18:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pl6YELFst/RZMtzR733SHFx3GWcGQjKHd80q3FZTCPM=;
        b=TUd+za4Tnryvyskl/BeTOmKtI4q/Nfcevpax/Oo36mOvPHKXw/ayR/hpnl42s85xsL
         k6q2bdiL0yqQbjzo0+a0SFdz0YQJmmv/Y0NDXKrd42ZlHNKTFmplTmknALK4+dEcOc8d
         i+HAek0km/44iQLncRdQRrw+oDUfEYTWfs0ZsMEyPfdpsVwMP9c8BVv+z1142eHWU5z5
         2TKZPLNDm33pGhZ/M0kZWHEN4zFeeg2HCCxjQcM195xEjv4lEsYXpGY35e4K8b/LNcyZ
         WrccG6ErYyCgZTRH+BSYVFjZ0sI92Vh7pRvNfSk7HQyoAyK/acmjM8VdQ47z1SovGd+Z
         9jPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pl6YELFst/RZMtzR733SHFx3GWcGQjKHd80q3FZTCPM=;
        b=YQaBsQbPijqKSO7y83Secd8vgMfYITAAiYbwUGTgztCuOU1J7SZujJZK+sWJV9eNNm
         EGBHFz4cdoHVG7gJu9qjkdgk7nCXRbDz14Ba+DN4TWjiu4Wcye+ez3YO/oaFFxaZHRTi
         6SdisrukGmMmh7R+ywDGp45rldVF4rS6LzWBH9ffewoX4+z5WHEUpqstTJ7LLlYGhlzU
         tr16sRxBvI8tznZk22eD5RP28eG+0WXwbWplRs/ZmrqIFZmFYUYOaUFbJCgfotv9Ilrw
         gw3/JYlg3zp+JFSuB0kIwhAQGeLVEBdRmqMR7mUtRs0oE70Kpam2SsbJZaGVv6NNvQLE
         ecXg==
X-Gm-Message-State: AOAM533z/K8IsBSv7lqx3YetEC2ynI279KtMqKl3otvK18c/szt8I9rk
        AJQq1rIFZIVA+pILbR0GpxI0w9GfWOVZYY1Z6m+aET+iGpKzVaJ5
X-Google-Smtp-Source: ABdhPJx5LCej/9fCk7JL8yI3oBmlH2wCcDdCvSosvaBSHqRn31Xad8P+uYc0wyqAZ41/zYgOnr67j4nxNia3cnWId6g=
X-Received: by 2002:a05:6402:3546:: with SMTP id f6mr52504324edd.310.1636964328904;
 Mon, 15 Nov 2021 00:18:48 -0800 (PST)
MIME-Version: 1.0
References: <CAMGffEmC07MwNsTHQ19OwUonG4zgYsx0vj+R__9as3E5EduY8A@mail.gmail.com>
 <YYz+lmJ9C4P/2hbv@unreal> <CAMGffE=EVpgYrPnUy-jGM7i4yvwsBUz1-Mre--aP70b9hP8zug@mail.gmail.com>
 <20211112142356.GC876299@ziepe.ca> <YZC1S+T+SosaHihh@unreal>
In-Reply-To: <YZC1S+T+SosaHihh@unreal>
From:   Jinpu Wang <jinpu.wang@ionos.com>
Date:   Mon, 15 Nov 2021 09:18:37 +0100
Message-ID: <CAMGffEmfYBSUOw73n=o+iCJheAzdv93WZJJ2MK6M52JzaYWEWQ@mail.gmail.com>
Subject: Re: Missing infiniband network interfaces after update to 5.14/5.15
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Haris Iqbal <haris.iqbal@ionos.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Nov 14, 2021 at 8:05 AM Leon Romanovsky <leon@kernel.org> wrote:
>
> On Fri, Nov 12, 2021 at 10:23:56AM -0400, Jason Gunthorpe wrote:
> > On Fri, Nov 12, 2021 at 09:23:04AM +0100, Jinpu Wang wrote:
> > > On Thu, Nov 11, 2021 at 12:29 PM Leon Romanovsky <leon@kernel.org> wrote:
> > > >
> > > > On Thu, Nov 11, 2021 at 08:48:08AM +0100, Jinpu Wang wrote:
> > > > > Hi Jason, hi Leon,
> > > > >
> > > > > We are seeing exactly the same error reported here:
> > > > > https://bugzilla.redhat.com/show_bug.cgi?id=2014094
> > > > >
> > > > > I suspect it's related to
> > > > > https://lore.kernel.org/all/cover.1623427137.git.leonro@nvidia.com/
> > > > >
> > > > > Do you have any idea, what goes wrong?
> > > >
> > > > I can't reproduce it with latest Fedora 34 RPM, which I downloaded from here
> > > > https://koji.fedoraproject.org/koji/buildinfo?buildID=1851842
> > > >
> > > > and also with kernel-5.14.7-200.fc34.x86_64 version mentioned in the bug
> > > > report.
> > > >
> > > > [leonro@c-235-8-1-005 ~]$ uname -a
> > > > Linux c-235-8-1-005 5.14.7-200.fc34.x86_64 #1 SMP Wed Sep 22 14:54:28 UTC 2021 x86_64 x86_64 x86_64 GNU/Linux
> > > > [leonro@c-235-8-1-005 ~]$ rdma dev
> > > > 0: ibp8s0f0: node_type ca fw 2.42.5000 node_guid 1c34:da03:0007:7950 sys_image_guid 1c34:da03:0007:7953
> > > > 1: ibp9s0f0: node_type ca fw 2.42.5000 node_guid 1c34:da03:0007:7a60 sys_image_guid 1c34:da03:0007:7a63
> > > >
> > > > [leonro@c-235-8-1-005 ~]$ uname -a
> > > > Linux c-235-8-1-005 5.14.16-201.fc34.x86_64 #1 SMP Wed Nov 3 13:57:29 UTC 2021 x86_64 x86_64 x86_64 GNU/Linux
> > > > [leonro@c-235-8-1-005 ~]$ rdma dev
> > > > 0: ibp8s0f0: node_type ca fw 2.42.5000 node_guid 1c34:da03:0007:7950 sys_image_guid 1c34:da03:0007:7953
> > > > 1: ibp9s0f0: node_type ca fw 2.42.5000 node_guid 1c34:da03:0007:7a60 sys_image_guid 1c34:da03:0007:7a63
> > > > [leonro@c-235-8-1-005 ~]$ lspci |grep nox
> > > > 08:00.0 Network controller: Mellanox Technologies MT27520 Family [ConnectX-3 Pro]
> > > > 09:00.0 Network controller: Mellanox Technologies MT27520 Family [ConnectX-3 Pro]
> > > >
> > > > Thanks
> > > >
> > > Hi,
> > >
> > > I tried different host with CX-3/CX-5, they all work fine. and I can
> > > only reproduce on hosts with a bit old HCA:
> > > 03:00.0 InfiniBand: Mellanox Technologies MT26428 [ConnectX VPI PCIe
> > > 2.0 5GT/s - IB QDR / 10GigE] (rev b0)
> > >
> > > The bug report link
> > > https://bugzilla.redhat.com/show_bug.cgi?id=2014094, mentioned HCA
> > > ConnectX too.
> > >
> > > 01:00.0 InfiniBand [0c06]: Mellanox Technologies MT25408A0-FCC-GI
> > > ConnectX, Dual Port 20Gb/s InfiniBand / 10GigE Adapter IC with PCIe
> > > 2.0 x8 5.0GT/s In... (rev b0)
> > > with the instrument, I only narrow it down to
> > > 1438                 port = setup_port(coredev, port_num, &attr);
> > > 1439                 if (IS_ERR(port)) {
> > > 1440                         ret = PTR_ERR(port);
> > > 1441                         pr_info("setup ports failed %d\n", ret);
> > > 1442                         goto err_put;
> > > 1443                 }
> >
> > Keep going with the tracing, there are lots of allocations in there.
> >
> > > My guess is the ConnectX HCA may be missing some features, which leads
> > > to ENOMEM, I will continue the instrument if no other hint.
> >
> > Since there is no memory allocation failure splat I'm guessing some
> > memory allocation hit an overflow and silently failed - ie mlx4 is
> > possibily setting some value to something bogus
>
> Yes, look for the values returned from FW.
Hi Leon, hi Jason

I've found the problem, the device doesn't support per port diag
counters, and the driver then fails the register which is
too harsh.

I'm not sure how to fix it properly, your thought?

Thanks


[ 3426.452062] <mlx4_ib> mlx4_ib_add: counter index 1 for port 2 allocated 0
[ 3426.452067] <mlx4_ib> mlx4_ib_alloc_diag_counters: #### i =1,
per_port 0  // device MLX4_DEV_CAP_FLAG2_DIAG_PER_PORT not set. which
lead to the allocation failure.
[ 3426.494000] <mlx4_ib> mlx4_ib_alloc_hw_port_stats:
mlx4_ib_alloc_hw_port_stats name null
[ 3426.494170] <mlx4_ib> mlx4_ib_alloc_hw_port_stats:
mlx4_ib_alloc_hw_port_stats name null
[ 3426.494174] ibdev ops alloc_hw_stats_port failed
[ 3426.494175] alloc_hw_stats_port failed
[ 3426.494177] setup_hw_port_stats failed, -12
[ 3426.494181] setup ports failed -12
[ 3426.494190] infiniband mlx4_0: Couldn't register device with driver model


>
> >
> > Jason
