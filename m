Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E8A545463C
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Nov 2021 13:15:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237215AbhKQMSc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 17 Nov 2021 07:18:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:37968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233484AbhKQMSa (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 17 Nov 2021 07:18:30 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5682261BE2;
        Wed, 17 Nov 2021 12:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637151332;
        bh=1PE13EB/nQAdsXp8nG7rXFKvqu8pvjlvvDWLY9+LP1w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c9f0xt1gAUzQpXqnNlq/bAf0hIShcBaMeA9+NpXvYfJvKrxO/4iWXkD4HmZg5uZxo
         Ww6HiUYa5qyjr3/AsXqatFrEf7F2NB3okwr6x3ZZp3rBixjIgvel859n4fqwZA5Mn1
         X+tb4tzfaPHpA/X+1BV1f+9XwIT1ASsOP4nhnx66Q7Yw4j6ezMUwwCQ/nZUnseQbuZ
         I3INeXnUWc/dZJ13BYhitWjU0aIUDZluVnBc2QCxXhCTMdMVZFAcYMxYO1FI7Ty5iW
         BD8i8Cikvmw7I50PoRUZRJH7qnIV3p4Ne8FkhdeH0yTJ3W+VmZOWCKL9FGPndupJGq
         Cfu9INASu9i1w==
Date:   Wed, 17 Nov 2021 14:15:27 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Jinpu Wang <jinpu.wang@ionos.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Haris Iqbal <haris.iqbal@ionos.com>
Subject: Re: Missing infiniband network interfaces after update to 5.14/5.15
Message-ID: <YZTyX+G6AXA1rDJo@unreal>
References: <CAMGffEmC07MwNsTHQ19OwUonG4zgYsx0vj+R__9as3E5EduY8A@mail.gmail.com>
 <YYz+lmJ9C4P/2hbv@unreal>
 <CAMGffE=EVpgYrPnUy-jGM7i4yvwsBUz1-Mre--aP70b9hP8zug@mail.gmail.com>
 <20211112142356.GC876299@ziepe.ca>
 <YZC1S+T+SosaHihh@unreal>
 <CAMGffEmfYBSUOw73n=o+iCJheAzdv93WZJJ2MK6M52JzaYWEWQ@mail.gmail.com>
 <CAMGffEkmm3rqyHooraMq4ELkCP=tXORqNENR9Ur0mOhDmRJZWw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMGffEkmm3rqyHooraMq4ELkCP=tXORqNENR9Ur0mOhDmRJZWw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Nov 15, 2021 at 10:20:50AM +0100, Jinpu Wang wrote:
> On Mon, Nov 15, 2021 at 9:18 AM Jinpu Wang <jinpu.wang@ionos.com> wrote:
> >
> > On Sun, Nov 14, 2021 at 8:05 AM Leon Romanovsky <leon@kernel.org> wrote:
> > >
> > > On Fri, Nov 12, 2021 at 10:23:56AM -0400, Jason Gunthorpe wrote:
> > > > On Fri, Nov 12, 2021 at 09:23:04AM +0100, Jinpu Wang wrote:
> > > > > On Thu, Nov 11, 2021 at 12:29 PM Leon Romanovsky <leon@kernel.org> wrote:
> > > > > >
> > > > > > On Thu, Nov 11, 2021 at 08:48:08AM +0100, Jinpu Wang wrote:
> > > > > > > Hi Jason, hi Leon,
> > > > > > >
> > > > > > > We are seeing exactly the same error reported here:
> > > > > > > https://bugzilla.redhat.com/show_bug.cgi?id=2014094
> > > > > > >
> > > > > > > I suspect it's related to
> > > > > > > https://lore.kernel.org/all/cover.1623427137.git.leonro@nvidia.com/
> > > > > > >
> > > > > > > Do you have any idea, what goes wrong?
> > > > > >
> > > > > > I can't reproduce it with latest Fedora 34 RPM, which I downloaded from here
> > > > > > https://koji.fedoraproject.org/koji/buildinfo?buildID=1851842
> > > > > >
> > > > > > and also with kernel-5.14.7-200.fc34.x86_64 version mentioned in the bug
> > > > > > report.
> > > > > >
> > > > > > [leonro@c-235-8-1-005 ~]$ uname -a
> > > > > > Linux c-235-8-1-005 5.14.7-200.fc34.x86_64 #1 SMP Wed Sep 22 14:54:28 UTC 2021 x86_64 x86_64 x86_64 GNU/Linux
> > > > > > [leonro@c-235-8-1-005 ~]$ rdma dev
> > > > > > 0: ibp8s0f0: node_type ca fw 2.42.5000 node_guid 1c34:da03:0007:7950 sys_image_guid 1c34:da03:0007:7953
> > > > > > 1: ibp9s0f0: node_type ca fw 2.42.5000 node_guid 1c34:da03:0007:7a60 sys_image_guid 1c34:da03:0007:7a63
> > > > > >
> > > > > > [leonro@c-235-8-1-005 ~]$ uname -a
> > > > > > Linux c-235-8-1-005 5.14.16-201.fc34.x86_64 #1 SMP Wed Nov 3 13:57:29 UTC 2021 x86_64 x86_64 x86_64 GNU/Linux
> > > > > > [leonro@c-235-8-1-005 ~]$ rdma dev
> > > > > > 0: ibp8s0f0: node_type ca fw 2.42.5000 node_guid 1c34:da03:0007:7950 sys_image_guid 1c34:da03:0007:7953
> > > > > > 1: ibp9s0f0: node_type ca fw 2.42.5000 node_guid 1c34:da03:0007:7a60 sys_image_guid 1c34:da03:0007:7a63
> > > > > > [leonro@c-235-8-1-005 ~]$ lspci |grep nox
> > > > > > 08:00.0 Network controller: Mellanox Technologies MT27520 Family [ConnectX-3 Pro]
> > > > > > 09:00.0 Network controller: Mellanox Technologies MT27520 Family [ConnectX-3 Pro]
> > > > > >
> > > > > > Thanks
> > > > > >
> > > > > Hi,
> > > > >
> > > > > I tried different host with CX-3/CX-5, they all work fine. and I can
> > > > > only reproduce on hosts with a bit old HCA:
> > > > > 03:00.0 InfiniBand: Mellanox Technologies MT26428 [ConnectX VPI PCIe
> > > > > 2.0 5GT/s - IB QDR / 10GigE] (rev b0)
> > > > >
> > > > > The bug report link
> > > > > https://bugzilla.redhat.com/show_bug.cgi?id=2014094, mentioned HCA
> > > > > ConnectX too.
> > > > >
> > > > > 01:00.0 InfiniBand [0c06]: Mellanox Technologies MT25408A0-FCC-GI
> > > > > ConnectX, Dual Port 20Gb/s InfiniBand / 10GigE Adapter IC with PCIe
> > > > > 2.0 x8 5.0GT/s In... (rev b0)
> > > > > with the instrument, I only narrow it down to
> > > > > 1438                 port = setup_port(coredev, port_num, &attr);
> > > > > 1439                 if (IS_ERR(port)) {
> > > > > 1440                         ret = PTR_ERR(port);
> > > > > 1441                         pr_info("setup ports failed %d\n", ret);
> > > > > 1442                         goto err_put;
> > > > > 1443                 }
> > > >
> > > > Keep going with the tracing, there are lots of allocations in there.
> > > >
> > > > > My guess is the ConnectX HCA may be missing some features, which leads
> > > > > to ENOMEM, I will continue the instrument if no other hint.
> > > >
> > > > Since there is no memory allocation failure splat I'm guessing some
> > > > memory allocation hit an overflow and silently failed - ie mlx4 is
> > > > possibily setting some value to something bogus
> > >
> > > Yes, look for the values returned from FW.
> > Hi Leon, hi Jason
> >
> > I've found the problem, the device doesn't support per port diag
> > counters, and the driver then fails the register which is
> > too harsh.
> >
> > I'm not sure how to fix it properly, your thought?
> >
> > Thanks
> >
> with this change,  the device can be detected properly. if you think
> it's the right direction, I can submit a patch.

Thanks, it looks like a right fix.

> 
> Thanks!
> +
> +static const struct ib_device_ops mlx4_ib_hw_stats_ops1 = {
> +       .alloc_hw_device_stats = mlx4_ib_alloc_hw_device_stats,
> +       .get_hw_stats = mlx4_ib_get_hw_stats,
> +};
> +
>  static int mlx4_ib_alloc_diag_counters(struct mlx4_ib_dev *ibdev)
>  {
>         struct mlx4_ib_diag_counters *diag = ibdev->diag_counters;
> @@ -2230,8 +2238,11 @@ static int mlx4_ib_alloc_diag_counters(struct
> mlx4_ib_dev *ibdev)
> 
>         for (i = 0; i < MLX4_DIAG_COUNTERS_TYPES; i++) {
>                 /* i == 1 means we are building port counters */
> -               if (i && !per_port)
> -                       continue;
> +               if (i && !per_port) {
> +                       ib_set_device_ops(&ibdev->ib_dev,
> &mlx4_ib_hw_stats_ops1);
> +                       return 0;
> +               }
