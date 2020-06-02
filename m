Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 169441EBD04
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Jun 2020 15:23:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726217AbgFBNXH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 2 Jun 2020 09:23:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:37398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725958AbgFBNXH (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 2 Jun 2020 09:23:07 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C87F206A2;
        Tue,  2 Jun 2020 13:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591104187;
        bh=G6S8AvIg/ryxagkbqtMngrkkiBsarzHU8Np+PY7CBh8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uF/7sNvGzy0lKZn3o2P/v8RD8e2+OaqcUxzTTG+i/gY0xiS4nSXTnTsc/nAB4WU4O
         DLhMSn0r18LhULgWFdcS78MzgcXWTPfDKih4NUE/a5NTdbgNV7D+q2B+StfLynhCUX
         9KTsenHT5nGiOgHOEycmlvWGdkvekMCuG8qejw4c=
Date:   Tue, 2 Jun 2020 16:23:03 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Doug Ledford <dledford@redhat.com>,
        Maor Gottlieb <maorg@mellanox.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next v1 11/11] RDMA/mlx5: Add support to get MR
 resource in RAW format
Message-ID: <20200602132303.GC55778@unreal>
References: <20200527135408.480878-1-leon@kernel.org>
 <20200527135408.480878-12-leon@kernel.org>
 <20200529233121.GA3296@ziepe.ca>
 <20200531095414.GE66309@unreal>
 <20200601122646.GA4872@ziepe.ca>
 <20200602062118.GC56352@unreal>
 <20200602122702.GB6578@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200602122702.GB6578@ziepe.ca>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jun 02, 2020 at 09:27:02AM -0300, Jason Gunthorpe wrote:
> On Tue, Jun 02, 2020 at 09:21:18AM +0300, Leon Romanovsky wrote:
> > On Mon, Jun 01, 2020 at 09:26:46AM -0300, Jason Gunthorpe wrote:
> > > On Sun, May 31, 2020 at 12:54:14PM +0300, Leon Romanovsky wrote:
> > > > On Fri, May 29, 2020 at 08:31:21PM -0300, Jason Gunthorpe wrote:
> > > > > On Wed, May 27, 2020 at 04:54:08PM +0300, Leon Romanovsky wrote:
> > > > > > From: Maor Gottlieb <maorg@mellanox.com>
> > > > > >
> > > > > > Add support to get MR (mkey) resource dump in RAW format.
> > > > > >
> > > > > > Signed-off-by: Maor Gottlieb <maorg@mellanox.com>
> > > > > > Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> > > > > >  drivers/infiniband/hw/mlx5/restrack.c | 3 ++-
> > > > > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > > > >
> > > > > > diff --git a/drivers/infiniband/hw/mlx5/restrack.c b/drivers/infiniband/hw/mlx5/restrack.c
> > > > > > index 9e1389b8dd9f..834886536127 100644
> > > > > > +++ b/drivers/infiniband/hw/mlx5/restrack.c
> > > > > > @@ -116,7 +116,8 @@ int mlx5_ib_fill_res_mr_entry(struct sk_buff *msg,
> > > > > >  	struct nlattr *table_attr;
> > > > > >
> > > > > >  	if (raw)
> > > > > > -		return -EOPNOTSUPP;
> > > > > > +		return fill_res_raw(msg, mr->dev, MLX5_SGMT_TYPE_PRM_QUERY_MKEY,
> > > > > > +				    mlx5_mkey_to_idx(mr->mmkey.key));
> > > > >
> > > > > None of the raw functions actually share any code with the non raw
> > > > > part, why are the in the same function? In fact all the implemenations
> > > > > just call some other function for raw.
> > > > >
> > > > > To me this looks like they should should all be a new op
> > > > > 'fill_raw_res_mr_entry' and drop the 'bool'
> > > >
> > > > I don't think that this is right approach, we already created ops per-objects
> > > > o remove API multiplexing. Extra de-duplication will create too much ops
> > > > without any real benefit.
> > >
> > > If there is no code sharing then they should not be in the same
> > > function at all. More ops is not really a problem.
> >
> > Logically they are the same, user asks to get object property, driver returns.
>
> I'm starting to think it is also a mistake to have the same netlink op
> and trigger it by an inbound attribute. Are there other examples of
> that in netlink? Feels wrong

I have no idea, don't see it in devlink.c

>
> Jason
