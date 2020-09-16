Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0333F26C988
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Sep 2020 21:12:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727378AbgIPTMI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 16 Sep 2020 15:12:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:56294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727325AbgIPRkk (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 16 Sep 2020 13:40:40 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CD9792078D;
        Wed, 16 Sep 2020 14:34:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600266869;
        bh=wfPqEjBGTNoBNSozDpxVOEkloBTCPOXLfxOvQcNTcoo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WIwvdJJy8tMl4sLAJ48YmYNi2xcbyLdvs4gIKI5n5jHZcOBXtUvXlP0SkXsErow/H
         W2+WPUSAR4dFIyEZ/8kDucwIGhUjgecRy4uQI1d6pdRIJsFz1OCOQUd8EPh7V66XAu
         gCqKLbncw2xX+KDJl56Xuq3yJ1t4fuJGMsVSKots=
Date:   Wed, 16 Sep 2020 17:34:25 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        Avihai Horon <avihaih@nvidia.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next 4/4] RDMA/uverbs: Expose the new GID query API
 to user space
Message-ID: <20200916143425.GK486552@unreal>
References: <20200910142204.1309061-5-leon@kernel.org>
 <20200911195918.GT904879@nvidia.com>
 <20200913091302.GF35718@unreal>
 <20200914155550.GF904879@nvidia.com>
 <20200915114704.GB486552@unreal>
 <20200915190614.GE1573713@nvidia.com>
 <20200916103710.GH486552@unreal>
 <20200916120440.GL1573713@nvidia.com>
 <20200916124429.GI486552@unreal>
 <20200916141202.GA3699@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200916141202.GA3699@nvidia.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Sep 16, 2020 at 11:12:02AM -0300, Jason Gunthorpe wrote:
> On Wed, Sep 16, 2020 at 03:44:29PM +0300, Leon Romanovsky wrote:
> > On Wed, Sep 16, 2020 at 09:04:40AM -0300, Jason Gunthorpe wrote:
> > > On Wed, Sep 16, 2020 at 01:37:10PM +0300, Leon Romanovsky wrote:
> > > > It depends on how you want to treat errors from rdma_read_gid_attr_ndev_rcu().
> > > > Current check allows us to ensure that any error returned by this call is
> > > > handled.
> > > >
> > > > Otherwise we will find ourselves with something like this:
> > > > ndev = rdma_read_gid_attr_ndev_rcu(gid_attr);
> > > > if (IS_ERR(ndev)) {
> > > > 	if (rdma_protocol_roce())
> > > > 		goto error;
> > > > 	if (ERR_PTR(ndev) != -ENODEV)
> > > > 	        goto error;
> > > > }
> > >
> > > Isn't it just
> > >
> > > if (IS_ERR(ndev)) {
> > >    if (ERR_PTR(ndev) != -ENODEV)
> > >         goto error;
> > >    index = -1;
> > > }
> > >
> > > Which seems fine and clear enough
> >
> > It is a problem if roce device returned -ENODEV.
>
> Can it happen? RCU I suppose, but I think this is an issue in
> rdma_read_gid_attr_ndev_rcu() - it should not return ENODEV if the RCU
> shows the gid_attr is being concurrently destroyed

From RoCE point of view, it is a problem if device is destroyed or gid
not valid, the different returned values won't change much. For the IB,
we don't care.

>
> Jason
