Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C49B243ADF7
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Oct 2021 10:28:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234140AbhJZIaZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 26 Oct 2021 04:30:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:54128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234132AbhJZIaY (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 26 Oct 2021 04:30:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A94C060E96;
        Tue, 26 Oct 2021 08:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635236881;
        bh=C3WRUlRTSy6AYyU2PxkwnZ8qyyJhEaPAu0f6cOBJ5i4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IqIbloO3NDI65CZbZEYjM7/gyMUgwedbwXf3DB84eB7T+zOxO52vXokYCSot0T6hG
         xhniWLPYocjqXuiIwir+RPvhC9yxPJ49ALUSBe13uxNvw/sF+u49Y4k43X2cX346zB
         LDD2htj2MYPtt0mvdNW4BM7PeRI1k0UVVTGQH4KEc8tz6u8TWeOOEPg1Jvz+w94zJY
         GfdovH13ajW6fWw2Noc960PZK6N+gp2OyvLkVHYVt3zL6LnNK0ZVPznPX5h/ZUPvU1
         zHUp9t1yTN317ceyo6VeJetVSbRncAWuPBmABXEy28MqdWS/h/3CisMRYSExZJRx6/
         aNGdmlOcaq1Fw==
Date:   Tue, 26 Oct 2021 11:27:57 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        Mark Zhang <markzhang@nvidia.com>,
        Ira Weiny <ira.weiny@intel.com>,
        John Fleck <john.fleck@intel.com>,
        Kaike Wan <kaike.wan@intel.com>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, Maor Gottlieb <maorg@nvidia.com>,
        Mark Bloch <markb@mellanox.com>, Mark Bloch <mbloch@nvidia.com>
Subject: Re: [PATCH rdma-rc 2/2] RDMA/core: Initialize lock when allocate a
 rdma_hw_stats structure
Message-ID: <YXe8DaH6gSFvbEyu@unreal>
References: <cover.1635055496.git.leonro@nvidia.com>
 <89baeee29503df46dd28a6a5edbad9ec1a1d86f1.1635055496.git.leonro@nvidia.com>
 <20211025145043.GA357677@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211025145043.GA357677@nvidia.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Oct 25, 2021 at 11:50:43AM -0300, Jason Gunthorpe wrote:
> On Sun, Oct 24, 2021 at 09:08:21AM +0300, Leon Romanovsky wrote:
> > From: Mark Zhang <markzhang@nvidia.com>
> > 
> > Initialize the rdma_hw_stats "lock" field when do allocation, to fix the
> > warning below. Then we don't need to initialize it in sysfs, remove it.
> 
> This is a fine cleanup, but this does not describe the bug properly,
> or have the right fixes line..

I think that this Fixes line should be instead.
Fixes: 0a0800ce2a6a ("RDMA/core: Add a helper API rdma_free_hw_stats_struct")

> 
> The issue is here:
> 
> static struct rdma_counter *alloc_and_bind(struct ib_device *dev, u32 port,
> 					   struct ib_qp *qp,
> 					   enum rdma_nl_counter_mode mode)
> {
> 	counter->stats = dev->ops.counter_alloc_stats(counter);
> 	if (!counter->stats)
> 		goto err_stats;
> 
> Which does not init counter->stat's mutex.


This is exactly what Mark is doing here.

alloc_and_bind()
 -> dev->ops.counter_alloc_stats
  -> mlx5_ib_counter_alloc_stats
   -> do_alloc_stats()
    -> rdma_alloc_hw_stats_struct()
     -> mutex_init(&stats->lock); <- Mark's change.

> 
> And trim the oops reports, don't include the usless ? fns, timestamps
> or other junk.

I don't like when people "beatify" kernel reports, many times whey are
removing too much information.

Thanks

> 
> Jason
