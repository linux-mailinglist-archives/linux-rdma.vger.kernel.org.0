Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 479DB18489A
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Mar 2020 14:57:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbgCMN5U (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 13 Mar 2020 09:57:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:52616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726691AbgCMN5U (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 13 Mar 2020 09:57:20 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4725420724;
        Fri, 13 Mar 2020 13:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584107840;
        bh=A3h3LHgga/D3s82H/SIWB+T0FvqhTmanbzNZvNU84ww=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cKDP5CEuPUsjTYGHwmD0CUKye4J1tO6DMoJLTeDQUakLXqSC+KFiwcYS2+es5Ohac
         +qJxFJmBuC/SSgh22lg6mjnecA2Q02GmQcwpZMhqaX+M4lLTCHuN2CzRaGJY0wF0hV
         ydTXqCvdH3N8ROrwfWtV7lLiMrXyx4uLaR9PTNqE=
Date:   Fri, 13 Mar 2020 15:57:14 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Doug Ledford <dledford@redhat.com>,
        Gal Pressman <galpress@amazon.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next v1 03/11] RDMA/efa: Use in-kernel offsetofend()
 to check field availability
Message-ID: <20200313135714.GH31504@unreal>
References: <20200310091438.248429-1-leon@kernel.org>
 <20200310091438.248429-4-leon@kernel.org>
 <20200313134456.GA24733@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200313134456.GA24733@ziepe.ca>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Mar 13, 2020 at 10:44:56AM -0300, Jason Gunthorpe wrote:
> On Tue, Mar 10, 2020 at 11:14:30AM +0200, Leon Romanovsky wrote:
> > From: Leon Romanovsky <leonro@mellanox.com>
> >
> > Remove custom and duplicated variant of offsetofend().
> >
> > Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> >  drivers/infiniband/hw/efa/efa_verbs.c | 7 ++-----
> >  1 file changed, 2 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/infiniband/hw/efa/efa_verbs.c b/drivers/infiniband/hw/efa/efa_verbs.c
> > index bf3120f140f7..5c57098a4aee 100644
> > +++ b/drivers/infiniband/hw/efa/efa_verbs.c
> > @@ -144,9 +144,6 @@ static inline bool is_rdma_read_cap(struct efa_dev *dev)
> >  	return dev->dev_attr.device_caps & EFA_ADMIN_FEATURE_DEVICE_ATTR_DESC_RDMA_READ_MASK;
> >  }
> >
> > -#define field_avail(x, fld, sz) (offsetof(typeof(x), fld) + \
> > -				 sizeof_field(typeof(x), fld) <= (sz))
> > -
> >  #define is_reserved_cleared(reserved) \
> >  	!memchr_inv(reserved, 0, sizeof(reserved))
> >
> > @@ -609,7 +606,7 @@ struct ib_qp *efa_create_qp(struct ib_pd *ibpd,
> >  	if (err)
> >  		goto err_out;
> >
> > -	if (!field_avail(cmd, driver_qp_type, udata->inlen)) {
> > +	if (offsetofend(typeof(cmd), driver_qp_type) > udata->inlen) {
>
> The > needs to be >=, and generally we write compares as
>    'variable XX constant'

Why ">="
The original code is
if (!field_avail(cmd, driver_qp_type, udata->inlen))
==>
if (!(offsetof(typeof(cmd), driver_qp_type) + sizeof_field(typeof(cmd), driver_qp_type,) <= (udata->inlen))
===>
if (!(offsetofend(typeof(cmd), driver_qp_type) <= (udata->inlen))
===>
if (offsetofend(typeof(cmd), driver_qp_type) > (udata->inlen)

like I wrote.

>


>
> > @@ -896,7 +893,7 @@ int efa_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
> >  		goto err_out;
> >  	}
> >
> > -	if (!field_avail(cmd, num_sub_cqs, udata->inlen)) {
> > +	if (offsetofend(typeof(cmd), num_sub_cqs) > udata->inlen) {
>
> Same
>
> Jason
