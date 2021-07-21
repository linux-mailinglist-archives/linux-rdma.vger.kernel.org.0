Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3080A3D095E
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Jul 2021 09:07:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233812AbhGUG03 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 21 Jul 2021 02:26:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:53138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233863AbhGUGZd (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 21 Jul 2021 02:25:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 53F9D601FC;
        Wed, 21 Jul 2021 07:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626851171;
        bh=08lEzRX5n8byADguPgtNpJBNzWbbiyZADO72K/GVRR0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T/uhDbnGiykZtiPZoPEmuttb7R9FOyrLc/uosMRneqB+/ceHKlqsZiXs51SxOfbPM
         fEIRW7K4sAS9zcBgTUUdKqZzQ4vsZn07GHp8FSrq/oTuA1i2zEbvN12ZECqYZGt52Q
         F4DALKxOns9+B3CZ7Vha0dBWNf2x9enjgC3yrUCX5xB6R4b2aBLchIfEU/S4f/1M+J
         FnRYti3mtg+c9FrjpgoBYfnAmypBXFks0iijHKwV39fHuOIuDfgWBFl7MF83IGnH9Q
         UNd9g+Bcg1WF4vmDruNG7t66qqLqgyQezzCsB2+A1zI1lQnBbDfKbCC+ddg1k+rxvq
         b495V8h7Vfq5g==
Date:   Wed, 21 Jul 2021 10:06:06 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, Mark Zhang <markz@mellanox.com>
Subject: Re: [PATCH rdma-next 7/7] RDMA/core: Create clean QP creations
 interface for uverbs
Message-ID: <YPfHXpFtB1RJ4yjU@unreal>
References: <cover.1626846795.git.leonro@nvidia.com>
 <8eaf125d3bfb463e1641b6f2794203cc93d76c90.1626846795.git.leonro@nvidia.com>
 <YPfDUN6CaOdGZLPS@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YPfDUN6CaOdGZLPS@infradead.org>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jul 21, 2021 at 07:48:48AM +0100, Christoph Hellwig wrote:
> > +struct ib_qp *ib_create_qp_user(struct ib_device *dev, struct ib_pd *pd,
> > +				struct ib_qp_init_attr *attr,
> > +				struct ib_udata *udata,
> > +				struct ib_uqp_object *uobj, const char *caller);
> > +static inline struct ib_qp *ib_create_qp_uverbs(struct ib_device *dev,
> > +						struct ib_pd *pd,
> > +						struct ib_qp_init_attr *attr,
> > +						struct ib_udata *udata,
> > +						struct ib_uqp_object *uobj)
> > +{
> > +	if (attr->qp_type == IB_QPT_XRC_TGT)
> > +		return ib_create_qp_user(dev, pd, attr, NULL, uobj,
> > +					 KBUILD_MODNAME);
> > +
> > +	return ib_create_qp_user(dev, pd, attr, udata, uobj, NULL);
> 
> Why not always pass along the udata and caller and just not use them
> in the low-level code?

You will need to add some sort of "if qp tpye" for ib_create_qp_uverbs() callers,
because they always provide udata != NULL. 

After this series, the callers look like this:

 1438         qp = ib_create_qp_uverbs(device, pd, &attr, &attrs->driver_udata, obj);
                                                          ^^^^^^^^^ not NULL

So instead of bothering callers, I implemented it here with one "if".

Thanks
