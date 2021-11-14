Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D8E644F712
	for <lists+linux-rdma@lfdr.de>; Sun, 14 Nov 2021 08:06:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbhKNHIp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 14 Nov 2021 02:08:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:42682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229532AbhKNHIo (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 14 Nov 2021 02:08:44 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B9A6C60FE7;
        Sun, 14 Nov 2021 07:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636873551;
        bh=mP+R9XN/7Ln1caAxXdcVrttNBHgkoW7PJMTcfPqXWY8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XTCXvZbIrsC8H/wSebdOicUXzaRZTRU6CiW9grwd1wEHMuRzJkgIDr0DaP/E357F9
         2F6eUNrgZ8p1U4GKhNQJ5Ppx8fO+PWCJray5uDNyzYaeftTbL7QWuyFiEovoKd3JCq
         SWrocMvjcAsdHqDFbDr9J2zn8zvMVIDJxzfv8uEd4lzGcPHhClOgrqdutBvx93SQGH
         nQ0QtuQI4dWjIaI02MHa0oFeOIYDh2EfB9PANiSfIPFn6v/5oXcuVjZysZrGzYTj3d
         Jb41e1IY/3ItnkWWwpCLse92i8Iq/8uU+zsjIVVUkbgLWFnpKryK9XGDAGF2W+t4AU
         9E515aw/fbuBQ==
Date:   Sun, 14 Nov 2021 09:05:47 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Jinpu Wang <jinpu.wang@ionos.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Haris Iqbal <haris.iqbal@ionos.com>
Subject: Re: Missing infiniband network interfaces after update to 5.14/5.15
Message-ID: <YZC1S+T+SosaHihh@unreal>
References: <CAMGffEmC07MwNsTHQ19OwUonG4zgYsx0vj+R__9as3E5EduY8A@mail.gmail.com>
 <YYz+lmJ9C4P/2hbv@unreal>
 <CAMGffE=EVpgYrPnUy-jGM7i4yvwsBUz1-Mre--aP70b9hP8zug@mail.gmail.com>
 <20211112142356.GC876299@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211112142356.GC876299@ziepe.ca>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Nov 12, 2021 at 10:23:56AM -0400, Jason Gunthorpe wrote:
> On Fri, Nov 12, 2021 at 09:23:04AM +0100, Jinpu Wang wrote:
> > On Thu, Nov 11, 2021 at 12:29 PM Leon Romanovsky <leon@kernel.org> wrote:
> > >
> > > On Thu, Nov 11, 2021 at 08:48:08AM +0100, Jinpu Wang wrote:
> > > > Hi Jason, hi Leon,
> > > >
> > > > We are seeing exactly the same error reported here:
> > > > https://bugzilla.redhat.com/show_bug.cgi?id=2014094
> > > >
> > > > I suspect it's related to
> > > > https://lore.kernel.org/all/cover.1623427137.git.leonro@nvidia.com/
> > > >
> > > > Do you have any idea, what goes wrong?
> > >
> > > I can't reproduce it with latest Fedora 34 RPM, which I downloaded from here
> > > https://koji.fedoraproject.org/koji/buildinfo?buildID=1851842
> > >
> > > and also with kernel-5.14.7-200.fc34.x86_64 version mentioned in the bug
> > > report.
> > >
> > > [leonro@c-235-8-1-005 ~]$ uname -a
> > > Linux c-235-8-1-005 5.14.7-200.fc34.x86_64 #1 SMP Wed Sep 22 14:54:28 UTC 2021 x86_64 x86_64 x86_64 GNU/Linux
> > > [leonro@c-235-8-1-005 ~]$ rdma dev
> > > 0: ibp8s0f0: node_type ca fw 2.42.5000 node_guid 1c34:da03:0007:7950 sys_image_guid 1c34:da03:0007:7953
> > > 1: ibp9s0f0: node_type ca fw 2.42.5000 node_guid 1c34:da03:0007:7a60 sys_image_guid 1c34:da03:0007:7a63
> > >
> > > [leonro@c-235-8-1-005 ~]$ uname -a
> > > Linux c-235-8-1-005 5.14.16-201.fc34.x86_64 #1 SMP Wed Nov 3 13:57:29 UTC 2021 x86_64 x86_64 x86_64 GNU/Linux
> > > [leonro@c-235-8-1-005 ~]$ rdma dev
> > > 0: ibp8s0f0: node_type ca fw 2.42.5000 node_guid 1c34:da03:0007:7950 sys_image_guid 1c34:da03:0007:7953
> > > 1: ibp9s0f0: node_type ca fw 2.42.5000 node_guid 1c34:da03:0007:7a60 sys_image_guid 1c34:da03:0007:7a63
> > > [leonro@c-235-8-1-005 ~]$ lspci |grep nox
> > > 08:00.0 Network controller: Mellanox Technologies MT27520 Family [ConnectX-3 Pro]
> > > 09:00.0 Network controller: Mellanox Technologies MT27520 Family [ConnectX-3 Pro]
> > >
> > > Thanks
> > >
> > Hi,
> > 
> > I tried different host with CX-3/CX-5, they all work fine. and I can
> > only reproduce on hosts with a bit old HCA:
> > 03:00.0 InfiniBand: Mellanox Technologies MT26428 [ConnectX VPI PCIe
> > 2.0 5GT/s - IB QDR / 10GigE] (rev b0)
> > 
> > The bug report link
> > https://bugzilla.redhat.com/show_bug.cgi?id=2014094, mentioned HCA
> > ConnectX too.
> > 
> > 01:00.0 InfiniBand [0c06]: Mellanox Technologies MT25408A0-FCC-GI
> > ConnectX, Dual Port 20Gb/s InfiniBand / 10GigE Adapter IC with PCIe
> > 2.0 x8 5.0GT/s In... (rev b0)
> > with the instrument, I only narrow it down to
> > 1438                 port = setup_port(coredev, port_num, &attr);
> > 1439                 if (IS_ERR(port)) {
> > 1440                         ret = PTR_ERR(port);
> > 1441                         pr_info("setup ports failed %d\n", ret);
> > 1442                         goto err_put;
> > 1443                 }
> 
> Keep going with the tracing, there are lots of allocations in there.
> 
> > My guess is the ConnectX HCA may be missing some features, which leads
> > to ENOMEM, I will continue the instrument if no other hint.
> 
> Since there is no memory allocation failure splat I'm guessing some
> memory allocation hit an overflow and silently failed - ie mlx4 is
> possibily setting some value to something bogus

Yes, look for the values returned from FW.

> 
> Jason
