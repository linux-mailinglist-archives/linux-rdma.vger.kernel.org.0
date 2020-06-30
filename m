Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EB9D20F3D7
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jun 2020 13:52:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732196AbgF3Lwa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 30 Jun 2020 07:52:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:49878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729580AbgF3Lw2 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 30 Jun 2020 07:52:28 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2FF5F20702;
        Tue, 30 Jun 2020 11:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593517947;
        bh=29TOx7lgtnxoFF6/aqZEN8JByA1ph9v6amHf7Oa5CoE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bk4QhRTtGcXun2ORwg6uy79xbHkk68EdPMlXMsE0M4ENv/wozh3PwP7CCOiKZzAwT
         O3mNZIspy1RO1879AmJiiIWlxph7NIiEDdxfVUIdaTKIt/0XqHaA/yQ2Ca+5SUuk/F
         GYTuCQI7JMnkr4QGZKdoVYZIf4/i2eBmvZiLFiT8=
Date:   Tue, 30 Jun 2020 14:52:24 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        Yishai Hadas <yishaih@mellanox.com>
Subject: Re: [PATCH rdma-next 5/5] RDMA/core: Convert RWQ table logic to
 ib_core allocation scheme
Message-ID: <20200630115224.GH17857@unreal>
References: <20200624105422.1452290-1-leon@kernel.org>
 <20200624105422.1452290-6-leon@kernel.org>
 <20200629153907.GA269101@nvidia.com>
 <20200630072137.GC17857@unreal>
 <20200630113729.GC23676@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200630113729.GC23676@nvidia.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jun 30, 2020 at 08:37:29AM -0300, Jason Gunthorpe wrote:
> On Tue, Jun 30, 2020 at 10:21:37AM +0300, Leon Romanovsky wrote:
> > On Mon, Jun 29, 2020 at 12:39:07PM -0300, Jason Gunthorpe wrote:
> > > On Wed, Jun 24, 2020 at 01:54:22PM +0300, Leon Romanovsky wrote:
> > > > @@ -4018,8 +4028,7 @@ const struct uapi_definition uverbs_def_write_intf[] = {
> > > >  			IB_USER_VERBS_EX_CMD_DESTROY_RWQ_IND_TBL,
> > > >  			ib_uverbs_ex_destroy_rwq_ind_table,
> > > >  			UAPI_DEF_WRITE_I(
> > > > -				struct ib_uverbs_ex_destroy_rwq_ind_table),
> > > > -			UAPI_DEF_METHOD_NEEDS_FN(destroy_rwq_ind_table))),
> > > > +				struct ib_uverbs_ex_destroy_rwq_ind_table))),
> > >
> > > Removing these is kind of troublesome.. This misses the one for ioctl:
> > >
> > >         UAPI_DEF_CHAIN_OBJ_TREE_NAMED(
> > >                 UVERBS_OBJECT_RWQ_IND_TBL,
> > >                 UAPI_DEF_OBJ_NEEDS_FN(destroy_rwq_ind_table)),
> >
> > I will remove, but it seems that we have some gap here, I would expect
> > any sort of compilation error for mlx4.
>
> Why would there be a compilation error?

I would expect BUILD_BUG_ON_ZERO() is thrown if ibdev_fn == NULL

>
> And it should not be removed, it needs to be reworked to point to some
> other function I suppose.

Why?

>
> Jason
