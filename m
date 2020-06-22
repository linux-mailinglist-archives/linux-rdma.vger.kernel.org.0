Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA730203852
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Jun 2020 15:40:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729163AbgFVNkC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 22 Jun 2020 09:40:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:49932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728212AbgFVNkB (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 22 Jun 2020 09:40:01 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 32D6720738;
        Mon, 22 Jun 2020 13:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592833200;
        bh=BuqWIl0VV62TEPlZS+3WK2SPfxqARUjehrpAG7AIXZg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tQI9UE9cNcq5xwM4a4cBikUU1llChBTuQ07ppy1a75U2Qfi2s8G9Wz+YLz1RczRj5
         E98OlRMsPuOW7IdCYBI2qChpu8GHkVcOF1upG9r8HfMAVFCiuMeH/Ihg2mxsvrWo94
         BgdtQxcdHcDLssaiDYqZvYGNDtmB1Z8Fe+1+EfZo=
Date:   Mon, 22 Jun 2020 16:39:57 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Maor Gottlieb <maorg@mellanox.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next 2/2] RDMA/core: Optimize XRC target lookup
Message-ID: <20200622133957.GA184720@unreal>
References: <20200621104110.53509-1-leon@kernel.org>
 <20200621104110.53509-3-leon@kernel.org>
 <20200622122910.GB2590509@mellanox.com>
 <3ee325e8-6872-22a8-4f2b-e1740d15a194@mellanox.com>
 <20200622130520.GE2590509@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200622130520.GE2590509@mellanox.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jun 22, 2020 at 10:05:20AM -0300, Jason Gunthorpe wrote:
> On Mon, Jun 22, 2020 at 03:57:29PM +0300, Maor Gottlieb wrote:
> >
> > On 6/22/2020 3:29 PM, Jason Gunthorpe wrote:
> > > On Sun, Jun 21, 2020 at 01:41:10PM +0300, Leon Romanovsky wrote:
> > > > @@ -2318,19 +2313,18 @@ EXPORT_SYMBOL(ib_alloc_xrcd_user);
> > > >   int ib_dealloc_xrcd_user(struct ib_xrcd *xrcd, struct ib_udata *udata)
> > > >   {
> > > > +	unsigned long index;
> > > >   	struct ib_qp *qp;
> > > >   	int ret;
> > > >   	if (atomic_read(&xrcd->usecnt))
> > > >   		return -EBUSY;
> > > > -	while (!list_empty(&xrcd->tgt_qp_list)) {
> > > > -		qp = list_entry(xrcd->tgt_qp_list.next, struct ib_qp, xrcd_list);
> > > > +	xa_for_each(&xrcd->tgt_qps, index, qp) {
> > > >   		ret = ib_destroy_qp(qp);
> > > >   		if (ret)
> > > >   			return ret;
> > > >   	}
> > > Why doesn't this need to hold the tgt_qps_rwsem?
> > >
> > > Jason
> >
> > Actually, we don't need this part of code. if usecnt is zero so we don't
> > have any tgt qp in the list. I guess it is leftovers of ib_release_qp which
> > was already deleted.
>
> Then have a WARN_ON that the xarray is empty

No problem.

Thanks

>
> Jason
