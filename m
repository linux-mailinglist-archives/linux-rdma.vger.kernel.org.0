Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C360D2528FF
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Aug 2020 10:13:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726813AbgHZINa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 26 Aug 2020 04:13:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:38188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726016AbgHZIN2 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 26 Aug 2020 04:13:28 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F81D20897;
        Wed, 26 Aug 2020 08:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598429608;
        bh=9SZM4/8jBmUkavqUtLBtpf/n6479sGM3DTvAdKiXtFg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WpLgRGTL+FMHwVP8hGGwy8+xsP4+aT4r0pxfeCOkrF3f6SrHHTy+Y2FCVQiIAGDGV
         pZZged9A1O4k3NGaaTYgqnonP1LoDhIoET7qAOnLb1aTOaN8Ch/4RnjE3GL79qk60J
         eOa4heuqQWl/IdD95NAwRRB05hxw2lWm7WOUi0aE=
Date:   Wed, 26 Aug 2020 11:13:24 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Gal Pressman <galpress@amazon.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>, linux-rdma@vger.kernel.org,
        Mark Zhang <markz@nvidia.com>
Subject: Re: [PATCH rdma-next 12/14] RDMA/restrack: Support all QP types
Message-ID: <20200826081324.GJ1362631@unreal>
References: <20200824104415.1090901-1-leon@kernel.org>
 <20200824104415.1090901-13-leon@kernel.org>
 <14ac653e-fc64-589c-e202-09fba6b39020@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14ac653e-fc64-589c-e202-09fba6b39020@amazon.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Aug 26, 2020 at 11:03:18AM +0300, Gal Pressman wrote:
> On 24/08/2020 13:44, Leon Romanovsky wrote:
> >  /**
> > - * ib_create_qp - Creates a kernel QP associated with the specified protection
> > + * ib_create_named_qp - Creates a kernel QP associated with the specified protection
> >   *   domain.
> >   * @pd: The protection domain associated with the QP.
> >   * @qp_init_attr: A list of initial attributes required to create the
> > @@ -1204,8 +1204,9 @@ static struct ib_qp *create_xrc_qp_user(struct ib_qp *qp,
> >   *
> >   * NOTE: for user qp use ib_create_qp_user with valid udata!
> >   */
> > -struct ib_qp *ib_create_qp(struct ib_pd *pd,
> > -			   struct ib_qp_init_attr *qp_init_attr)
> > +struct ib_qp *ib_create_named_qp(struct ib_pd *pd,
> > +				 struct ib_qp_init_attr *qp_init_attr,
> > +				 const char *caller)
>
> This function can be static.
> Also, caller parameter missing from doc.

This function is referenced from ib_verbs.h. How can it be static?

>
> >  {
> >  	struct ib_device *device = pd ? pd->device : qp_init_attr->xrcd->device;
> >  	struct ib_qp *qp;
> > @@ -1230,7 +1231,7 @@ struct ib_qp *ib_create_qp(struct ib_pd *pd,
> >  	if (qp_init_attr->cap.max_rdma_ctxs)
> >  		rdma_rw_init_qp(device, qp_init_attr);
> >
> > -	qp = _ib_create_qp(device, pd, qp_init_attr, NULL, NULL);
> > +	qp = _ib_create_qp(device, pd, qp_init_attr, NULL, NULL, caller);
> >  	if (IS_ERR(qp))
> >  		return qp;
> >
> > @@ -1299,7 +1300,7 @@ struct ib_qp *ib_create_qp(struct ib_pd *pd,
> >  	return ERR_PTR(ret);
> >
> >  }
> > -EXPORT_SYMBOL(ib_create_qp);
> > +EXPORT_SYMBOL(ib_create_named_qp);
>
> Shouldn't ib_create_qp be exported instead?

Not, ib_create_qp is declared as inline function, so callers need to see
function referenced in that inline body. The ib_create_named_qp() should
be exported.

Thanks
