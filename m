Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7C9246CDEA
	for <lists+linux-rdma@lfdr.de>; Wed,  8 Dec 2021 07:52:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240394AbhLHGzi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 8 Dec 2021 01:55:38 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:34668 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231193AbhLHGzh (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 8 Dec 2021 01:55:37 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1FFE8B8168C;
        Wed,  8 Dec 2021 06:52:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFCC5C00446;
        Wed,  8 Dec 2021 06:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638946323;
        bh=Z45lygP6RwJrON0S7PUva68y3Nc3U4Sa0WOT7zeD1aM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AoLVedqBkVlfznlJPG7A8rs7+4v8AeJwiVNR53B7+Z6ue3+Pvd80mnpF28BI9r4+b
         gZIsRbOKJVihvRB8P8nMltD5zbKeFYOmuDDlCBTY/qKFl3WZDarazxqLb7P+sF1Qq0
         YtAEJ66jHAd4dKbzW9PJfXRLTjLdmoUaiWBC4NXdE8iQgMjM5/3FAspNtnKW4MBStP
         vKCkeDhb9aLdAQ05FeVvDx4t8OVB29d7EbgGy8J2iwsqHaTarfusFKsHYaOxppXRXj
         nsY4kr4DmndjjE7AgNuxG+9a39t0ujvihnl67m5dkth30SGmWNsfziQeAxYU9HgzEj
         BJk4PBCvy7QyA==
Date:   Wed, 8 Dec 2021 08:51:59 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        Avihai Horon <avihaih@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Mark Zhang <markzhang@nvidia.com>,
        "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
Subject: Re: [PATCH rdma-next 2/3] RDMA/core: Let ib_find_gid() continue
 search even after empty entry
Message-ID: <YbBWD5rDm+wBxVjU@unreal>
References: <cover.1637581778.git.leonro@nvidia.com>
 <aab136be84ad03185a1084cb2e1ca9cad322ab23.1637581778.git.leonro@nvidia.com>
 <20211207184304.GB114160@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211207184304.GB114160@nvidia.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Dec 07, 2021 at 02:43:04PM -0400, Jason Gunthorpe wrote:
> On Mon, Nov 22, 2021 at 01:53:57PM +0200, Leon Romanovsky wrote:
> > From: Avihai Horon <avihaih@nvidia.com>
> > 
> > Currently, ib_find_gid() will stop searching after encountering the
> > first empty GID table entry. This behavior is wrong since neither IB
> > nor RoCE spec enforce tightly packed GID tables.
> > 
> > For example, when a valid GID entry exists at index N, and if a GID
> > entry is empty at index N-1, ib_find_gid() will fail to find the valid
> > entry.
> > 
> > Fix it by making ib_find_gid() continue searching even after
> > encountering missing entries.
> > 
> > Fixes: 5eb620c81ce3 ("IB/core: Add helpers for uncached GID and P_Key searches")
> > Signed-off-by: Avihai Horon <avihaih@nvidia.com>
> > Reviewed-by: Mark Zhang <markzhang@nvidia.com>
> > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> >  drivers/infiniband/core/device.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
> > index 22a4adda7981..b5d8443030d4 100644
> > +++ b/drivers/infiniband/core/device.c
> > @@ -2460,8 +2460,11 @@ int ib_find_gid(struct ib_device *device, union ib_gid *gid,
> >  		for (i = 0; i < device->port_data[port].immutable.gid_tbl_len;
> >  		     ++i) {
> >  			ret = rdma_query_gid(device, port, i, &tmp_gid);
> > +			if (ret == -ENOENT)
> > +				continue;
> >  			if (ret)
> >  				return ret;
> 
> There is no return code from rdma_query_gid that means stop searching,

In rdma_query_gid() any error stopped searching, and here we continue
same behaviour as before. You can argue that this function can't really
get illegal parameters and it never returns -EINVAL, but someone needs
to check all callers that this is true.

> so just write
> 
> if (ret)
>    continue

As long as we don't delete input validity checks, it is not correct.

Thanks

> 
> Jason
