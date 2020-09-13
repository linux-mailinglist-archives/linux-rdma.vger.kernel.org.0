Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B711267E66
	for <lists+linux-rdma@lfdr.de>; Sun, 13 Sep 2020 09:42:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725899AbgIMHmN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 13 Sep 2020 03:42:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:57502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725912AbgIMHmJ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 13 Sep 2020 03:42:09 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6BDF8208E4;
        Sun, 13 Sep 2020 07:42:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599982929;
        bh=1+ks5eBvgyftq+woCZ7NkUpmRWGYCsWG4ZWHIrAPN14=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZD/x0EtZFtJMQ+VHBXa1vZXqZncT9ljrSBk561mGLIBVmWVv9a2aCWxsg59qrN8Iz
         1TQmCqurXWkumNN6tJKEeaIueQf53uTK2TmH86bb1UX8ax8qvVGr6KYplVr8m6tlLe
         sIeKL3TsOBuiW+A71TP2NjnbZ+3xSSJX3O7ORP/s=
Date:   Sun, 13 Sep 2020 10:42:04 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        Avihai Horon <avihaih@nvidia.com>,
        Ariel Elior <aelior@marvell.com>, linux-rdma@vger.kernel.org,
        Michal Kalderon <mkalderon@marvell.com>
Subject: Re: [PATCH rdma-next 2/4] RDMA/core: Modify enum ib_gid_type and
 enum rdma_network_type
Message-ID: <20200913074204.GD35718@unreal>
References: <20200910142204.1309061-1-leon@kernel.org>
 <20200910142204.1309061-3-leon@kernel.org>
 <20200911191116.GR904879@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200911191116.GR904879@nvidia.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Sep 11, 2020 at 04:11:16PM -0300, Jason Gunthorpe wrote:
> On Thu, Sep 10, 2020 at 05:22:02PM +0300, Leon Romanovsky wrote:
>
> > diff --git a/drivers/infiniband/core/cma_configfs.c b/drivers/infiniband/core/cma_configfs.c
> > index 3c1e2ca564fe..f1b277793980 100644
> > +++ b/drivers/infiniband/core/cma_configfs.c
> > @@ -123,16 +123,21 @@ static ssize_t default_roce_mode_store(struct config_item *item,
> >  {
> >  	struct cma_device *cma_dev;
> >  	struct cma_dev_port_group *group;
> > -	int gid_type = ib_cache_gid_parse_type_str(buf);
> > +	int gid_type;
> >  	ssize_t ret;
> >
> > -	if (gid_type < 0)
> > -		return -EINVAL;
> > -
> >  	ret = cma_configfs_params_get(item, &cma_dev, &group);
> >  	if (ret)
> >  		return ret;
> >
> > +	gid_type = ib_cache_gid_parse_type_str(buf);
> > +	if (gid_type < 0)
> > +		return -EINVAL;
> > +
> > +	if (gid_type == IB_GID_TYPE_IB &&
> > +	    rdma_protocol_roce_eth_encap(cma_dev->device, group->port_num))
> > +		gid_type = IB_GID_TYPE_ROCE;
>
> This logic should be in cma_set_default_gid_type() so as not to move
> struct cma_device

We wanted to keep "this hack of git type" as close as possible to the
actual needed place.

I'll fix.

Thanks

>
> Jason
