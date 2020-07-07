Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CA62216CA0
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Jul 2020 14:16:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbgGGMPy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 7 Jul 2020 08:15:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:60778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725944AbgGGMPy (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 7 Jul 2020 08:15:54 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 67DC920708;
        Tue,  7 Jul 2020 12:15:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594124154;
        bh=RPYVNo/RBcC/PvgjnjycqEtelKEA3vP+6156hy2sTyo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MJPS5hnu6yzdi7KQ39emV/grapzuXCp8q5ZbgDUCAxJ0JIAecTh9XJhEoUwTACEKt
         4U10erXXnVfleNSMZ17soH0ldp0KXZNeM+UouI1m5FXBgMZm4VAOywPk7TuxpsW0yo
         hDzWCOqfuNrMvyvbOQ9cpApsNVSI0Gq5Ok2VHS6g=
Date:   Tue, 7 Jul 2020 15:15:50 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Doug Ledford <dledford@redhat.com>, Lijun Ou <oulijun@huawei.com>,
        linux-rdma@vger.kernel.org,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Weihang Li <liweihang@huawei.com>,
        "Wei Hu(Xavier)" <huwei87@hisilicon.com>,
        Yishai Hadas <yishaih@mellanox.com>
Subject: Re: [PATCH rdma-next v1 2/4] RDMA: Clean MW allocation and free flows
Message-ID: <20200707121550.GL207186@unreal>
References: <20200630101855.368895-1-leon@kernel.org>
 <20200630101855.368895-3-leon@kernel.org>
 <20200706230416.GA1283287@nvidia.com>
 <20200707044203.GI207186@unreal>
 <20200707112109.GL23676@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200707112109.GL23676@nvidia.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jul 07, 2020 at 08:21:09AM -0300, Jason Gunthorpe wrote:
> On Tue, Jul 07, 2020 at 07:42:03AM +0300, Leon Romanovsky wrote:
> > On Mon, Jul 06, 2020 at 08:04:16PM -0300, Jason Gunthorpe wrote:
> > > On Tue, Jun 30, 2020 at 01:18:53PM +0300, Leon Romanovsky wrote:
> > > > @@ -916,21 +916,24 @@ static int ib_uverbs_alloc_mw(struct uverbs_attr_bundle *attrs)
> > > >  		goto err_put;
> > > >  	}
> > > >
> > > > -	mw = pd->device->ops.alloc_mw(pd, cmd.mw_type, &attrs->driver_udata);
> > > > -	if (IS_ERR(mw)) {
> > > > -		ret = PTR_ERR(mw);
> > > > +	mw = rdma_zalloc_drv_obj(ib_dev, ib_mw);
> > > > +	if (!mw) {
> > > > +		ret = -ENOMEM;
> > > >  		goto err_put;
> > > >  	}
> > > >
> > > > -	mw->device  = pd->device;
> > > > -	mw->pd      = pd;
> > > > +	mw->device = ib_dev;
> > > > +	mw->pd = pd;
> > > >  	mw->uobject = uobj;
> > > > -	atomic_inc(&pd->usecnt);
> > > > -
> > > >  	uobj->object = mw;
> > > > +	mw->type = cmd.mw_type;
> > > >
> > > > -	memset(&resp, 0, sizeof(resp));
> > > > -	resp.rkey      = mw->rkey;
> > > > +	ret = pd->device->ops.alloc_mw(mw, &mw->rkey, &attrs->driver_udata);
> > >
> > > Why the strange &mw->rkey ? Can't the drivers just do mw->rkey = foo ?
> >
> > We can, if we want to allow drivers set fields in ib_* structures that
> > there passed as part of alloc_* flows.
>
> This is better than passing weird loose pointers around

I don't think that it is right approach, but I'll change.

Thanks

>
> Jason
