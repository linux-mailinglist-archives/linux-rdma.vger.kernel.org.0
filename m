Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDF65399D69
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Jun 2021 11:07:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbhFCJJh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 3 Jun 2021 05:09:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:52844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229506AbhFCJJg (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 3 Jun 2021 05:09:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CBF80613AD;
        Thu,  3 Jun 2021 09:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622711272;
        bh=tyTxLmRzGcLrgS5s1ZrV5gXEzztjA30ML1iCEHzJ9Ys=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t/rqjzqj4JsVvW4HTGMme6CBwV0/ZE4SynU6ck6KdisYT5/MNBHA2UjAfyxV6ceij
         FSnjsE66z2H0mzgwqGfxn6pI6kjUvd9NXANos5c0mrcQuoEN7yt09/12nTyorr5d7z
         jY2bVMlAXhsgoHya2sbDUmeDCmX2FIs2+mJVlHWmWOfufGwfUnwbHYLRNzifgwi+dS
         OdvukMKMRXhtBCsJxoEUhMTd8NonP5CeE+YZUCkQqTHuWRarmoaPS+9Z2Jy0JPWRZA
         GlRbFZqocJGyaAtGJWKgJlqxWo9/GCsyC2faCyXaz9icR9gaoadu1ucwkYLYGnSlnn
         4RgCVPHJ1Cy6A==
Date:   Thu, 3 Jun 2021 12:07:48 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Anand Khoje <anand.a.khoje@oracle.com>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        dledford@redhat.com, jgg@ziepe.ca, haakon.bugge@oracle.com
Subject: Re: [PATCH v2 3/3] IB/core: Obtain subnet_prefix from cache in IB
 devices
Message-ID: <YLib5BhTX6tEMTfe@unreal>
References: <20210603065024.1051-1-anand.a.khoje@oracle.com>
 <20210603065024.1051-4-anand.a.khoje@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210603065024.1051-4-anand.a.khoje@oracle.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jun 03, 2021 at 12:20:24PM +0530, Anand Khoje wrote:
> ib_query_port() calls device->ops.query_port() to get the port
> attributes. The method of querying is device driver specific.
> The same function calls device->ops.query_gid() to get the GID and
> extract the subnet_prefix (gid_prefix).
> 
> The GID and subnet_prefix are stored in a cache. But they do not get
> read from the cache if the device is an Infiniband device. The
> following change takes advantage of the cached subnet_prefix.
> Testing with RDBMS has shown a significant improvement in performance
> with this change.
> 
> The function ib_cache_is_initialised() is introduced because
> ib_query_port() gets called early in the stage when the cache is not
> built while reading port immutable property.
> 
> In that case, the default GID still gets read from HCA for IB link-
> layer devices.
> 
> Fixes: fad61ad ("IB/core: Add subnet prefix to port info")
> Signed-off-by: Anand Khoje <anand.a.khoje@oracle.com>
> Signed-off-by: Haakon Bugge <haakon.bugge@oracle.com>
> ---
>  drivers/infiniband/core/cache.c  | 7 ++++++-
>  drivers/infiniband/core/device.c | 9 +++++++++
>  include/rdma/ib_cache.h          | 6 ++++++
>  include/rdma/ib_verbs.h          | 6 ++++++
>  4 files changed, 27 insertions(+), 1 deletion(-)

Can you please help me to understand how cache is updated?

There are a lot of calls to ib_query_port() and I wonder how callers can
get new GID after it was changed in already initialized cache.

Thanks
