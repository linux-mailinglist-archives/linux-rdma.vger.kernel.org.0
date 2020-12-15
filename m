Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D10652DA7A3
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Dec 2020 06:25:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725816AbgLOFYu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 15 Dec 2020 00:24:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:36426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725962AbgLOFYj (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 15 Dec 2020 00:24:39 -0500
Date:   Tue, 15 Dec 2020 07:23:55 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608009839;
        bh=9HIoHrJxXz0UpdUuhYVcnt1M8xokvraD0s52MvVemdA=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=V66A3+HmaT3qGmtC1UF/KE76h9D3jtVnDPu6DiymNgtFuNqn1HiuHks0jt/rGo3vw
         a9jhEjpFf0bNd6V3mwq0GfCHFiJI1tfX4J2lj8opXxrp3ty3DFTUVTay/zBm8jKYq+
         LUGEYrQc/oJ9S0kTBJIzj531KxhuiAbsbf7loxPD/CqodWaJHKsrWyNs8KnxGy0Sno
         XK63g4H+XYe64CcoCeJFTUgixb13eyYAe2l6mPpIkGxoP2jeJt6u/+wjMLP0860IMo
         W418RVgpk55AxuVpOp4CFrO+vu8QveGV24eeN9gWOGB+pmN1Kt8A8gbJPtP7+2YFoj
         KQ2roZTRwvO2w==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        Daniel Jurgens <danielj@mellanox.com>,
        linux-rdma@vger.kernel.org, Parav Pandit <parav@mellanox.com>
Subject: Re: [PATCH rdma-rc 4/5] RDMA/cma: Don't overwrite sgid_attr after
 device is released
Message-ID: <20201215052355.GJ5005@unreal>
References: <20201213132940.345554-1-leon@kernel.org>
 <20201213132940.345554-5-leon@kernel.org>
 <20201214192636.GA2551375@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201214192636.GA2551375@nvidia.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Dec 14, 2020 at 03:26:36PM -0400, Jason Gunthorpe wrote:
> On Sun, Dec 13, 2020 at 03:29:39PM +0200, Leon Romanovsky wrote:
>
> > Call Trace:
> >  addr_handler+0x266/0&times;350 drivers/infiniband/core/cma.c:3190
> >  process_one_req+0xa3/0&times;300 drivers/infiniband/core/addr.c:645
> >  process_one_work+0x54c/0&times;930 kernel/workqueue.c:2272
> >  worker_thread+0x82/0&times;830 kernel/workqueue.c:2418
> >  kthread+0x1ca/0&times;220 kernel/kthread.c:292
> >  ret_from_fork+0x1f/0&times;30 arch/x86/entry/entry_64.S:296
>
> Why has this been weirdly HTML escaped??? I fixed it..

Ahh sorry, I fixed the lines in beginning of the dump, but missed these lines.

Thanks

>
> Jason
