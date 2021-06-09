Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 156A63A162C
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Jun 2021 15:53:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236830AbhFINzV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 9 Jun 2021 09:55:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:57850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236756AbhFINzV (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 9 Jun 2021 09:55:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6742461182;
        Wed,  9 Jun 2021 13:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623246807;
        bh=ff4dV/Z38To+N3LgvFxthRICWqy7lAIQzMK8o90TLz0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z9LlhhaezrjS96RWuxlvB34lPrzTrgB3HFhR/nN2rWzG3+eKQ3wDsOcfbBHH+AYi4
         joWFOtxLR/EWF9a7PbBVQ2wcx4jB3p5IkLxM8i3S9vzbHKUNc6F/8ULX1U+2F2WmvD
         vif2BBIs/AKAWytfY96yOAbR5Sm7EGDmhGYxn4mW0q6R0yaqVfkL1jMG+E1lvJ41KY
         zhyTJq5FbaNJYkY56QD6tVRyRNcqOG2AO2lcsDQiqmMCHwZxDrTNNh6UVMoQ+fYJoE
         7BCFakgISw87PGqSmSsYn3npcSlXHq7vfd2P4fQ6S6bugdyAZD5hbifEqIXsWopNVC
         0TdvuWhikcarw==
Date:   Wed, 9 Jun 2021 16:53:23 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Avihai Horon <avihaih@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>,
        Tom Talpey <tom@talpey.com>,
        Santosh Shilimkar <santosh.shilimkar@oracle.com>,
        Chuck Lever III <chuck.lever@oracle.com>,
        Keith Busch <kbusch@kernel.org>,
        David Laight <David.Laight@aculab.com>,
        Honggang LI <honli@redhat.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: Re: [PATCH v2 rdma-next] RDMA/mlx5: Enable Relaxed Ordering by
 default for kernel ULPs
Message-ID: <YMDH05/yTtSIk9kI@unreal>
References: <b7e820aab7402b8efa63605f4ea465831b3b1e5e.1623236426.git.leonro@nvidia.com>
 <20210609125241.GA1347@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210609125241.GA1347@lst.de>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jun 09, 2021 at 02:52:41PM +0200, Christoph Hellwig wrote:
> On Wed, Jun 09, 2021 at 02:05:03PM +0300, Leon Romanovsky wrote:
> > From: Avihai Horon <avihaih@nvidia.com>
> > 
> > Relaxed Ordering is a capability that can only benefit users that support
> > it. All kernel ULPs should support Relaxed Ordering, as they are designed
> > to read data only after observing the CQE and use the DMA API correctly.
> > 
> > Hence, implicitly enable Relaxed Ordering by default for kernel ULPs.
> > 
> > Signed-off-by: Avihai Horon <avihaih@nvidia.com>
> > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> > ---
> > Changelog:
> > v2:
> >  * Dropped IB/core patch and set RO implicitly in mlx5 exactly like in
> >    eth side of mlx5 driver.
> 
> This looks great in terms of code changes.  But can we please also add a
> patch to document that PCIe relaxed ordering is fine for kernel ULP usage
> somewhere?

Sure, did you have in mind some concrete place? Or will new file in the
Documentation/infiniband/ folder be good enough too?

Thanks
