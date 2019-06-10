Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E4C63B7FE
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Jun 2019 17:05:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390259AbfFJPFs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 10 Jun 2019 11:05:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:58274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389368AbfFJPFs (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 10 Jun 2019 11:05:48 -0400
Received: from localhost (unknown [37.142.3.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E5FE320859;
        Mon, 10 Jun 2019 15:05:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560179147;
        bh=zqaBH7k6FyuLdye9ngus3ohQaTxHRodz4hmzWeyZIrA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JZmKROi2ptsmlcJNs4WBu1PC4o7nT78jddv4/94HMlO2F/Iw+TdWNY0gkwlXY9VTd
         nNfa2n2w1KSG4czZAeZiNo1fC0Pa824DHd0LO061KoBW6S37NgzCOul0yKHJLCMYt/
         DrLqmCi9kUz4+mKKmYATRbYOqAXyX2RNuLi3wg0U=
Date:   Mon, 10 Jun 2019 18:05:44 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH 1/3] RDMA: Move rdma_node_type to uapi/
Message-ID: <20190610150544.GG6369@mtr-leonro.mtl.com>
References: <20190605183252.6687-1-jgg@ziepe.ca>
 <20190605183252.6687-2-jgg@ziepe.ca>
 <20190610141334.GB6369@mtr-leonro.mtl.com>
 <20190610144535.GD18446@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190610144535.GD18446@mellanox.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jun 10, 2019 at 02:45:40PM +0000, Jason Gunthorpe wrote:
> On Mon, Jun 10, 2019 at 05:13:34PM +0300, Leon Romanovsky wrote:
> > On Wed, Jun 05, 2019 at 03:32:50PM -0300, Jason Gunthorpe wrote:
> > > From: Jason Gunthorpe <jgg@mellanox.com>
> > >
> > > This enum is exposed over the sysfs file 'node_type' and over netlink via
> > > RDMA_NLDEV_ATTR_DEV_NODE_TYPE, so declare it in the uapi headers.
> > >
> > > Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
> > >  drivers/infiniband/core/verbs.c  |  2 +-
> > >  include/rdma/ib_verbs.h          | 13 +------------
> > >  include/uapi/rdma/rdma_netlink.h | 12 ++++++++++++
> > >  3 files changed, 14 insertions(+), 13 deletions(-)
> > >
> > > diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
> > > index e666a1f7608d86..56af18456ba776 100644
> > > +++ b/drivers/infiniband/core/verbs.c
> > > @@ -209,7 +209,7 @@ __attribute_const__ int ib_rate_to_mbps(enum ib_rate rate)
> > >  EXPORT_SYMBOL(ib_rate_to_mbps);
> > >
> > >  __attribute_const__ enum rdma_transport_type
> > > -rdma_node_get_transport(enum rdma_node_type node_type)
> > > +rdma_node_get_transport(unsigned int node_type)
> > >  {
> > >
> > >  	if (node_type == RDMA_NODE_USNIC)
> > > diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
> > > index cdfeeda1db7f31..d5dd3cb7fcf702 100644
> > > +++ b/include/rdma/ib_verbs.h
> > > @@ -132,17 +132,6 @@ struct ib_gid_attr {
> > >  	u8			port_num;
> > >  };
> > >
> > > -enum rdma_node_type {
> >
> > Why did you drop "enum rdma_node_type" and changed to be anonymous enum?
>
> To avoid namespace pollution in a user header

IMHO, better to have type safety.

>
> Jason
