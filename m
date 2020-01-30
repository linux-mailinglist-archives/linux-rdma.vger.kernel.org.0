Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 767D114DE2B
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Jan 2020 16:47:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbgA3Prb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 30 Jan 2020 10:47:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:51956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726948AbgA3Prb (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 30 Jan 2020 10:47:31 -0500
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C006120674;
        Thu, 30 Jan 2020 15:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580399250;
        bh=9fqxxY0C0DNhTOtHUtTsAKC2HNf3sdP9t1HWLeh6fkI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B5SZlKMdo661WpfGX/rkD1jRBmP+y/NuJDaawn4O92XJgsgSeOaUzn7WwbvOvTZ4z
         n1YptYOnIVuYgNZ2nBxm/yTUGZxuAajeoDa1N3hVvOVlTHg7l0dZzR5gYEWNCxZ144
         7zUWpK2ANT1K8D+KW6LnY76rWyQoliyYacnZGDP4=
Date:   Thu, 30 Jan 2020 17:47:26 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Yishai Hadas <yishaih@mellanox.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: [PATCH rdma-rc] RDMA/mlx5: Fix compilation breakage without
 INFINIBAND_USER_ACCESS
Message-ID: <20200130154726.GH3326@unreal>
References: <20200130112957.337869-1-leon@kernel.org>
 <20200130153426.GF21192@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200130153426.GF21192@mellanox.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jan 30, 2020 at 11:34:26AM -0400, Jason Gunthorpe wrote:
> On Thu, Jan 30, 2020 at 01:29:57PM +0200, Leon Romanovsky wrote:
> > From: Leon Romanovsky <leonro@mellanox.com>
> >
> > Compilation of mlx5 driver without CONFIG_INFINIBAND_USER_ACCESS generates
> > the following error.
> >
> > on x86_64:
> >
> > ld: drivers/infiniband/hw/mlx5/main.o: in function `mlx5_ib_handler_MLX5_IB_METHOD_VAR_OBJ_ALLOC':
> > main.c:(.text+0x186d): undefined reference to `ib_uverbs_get_ucontext_file'
> > ld: drivers/infiniband/hw/mlx5/main.o:(.rodata+0x2480): undefined reference to `uverbs_idr_class'
> > ld: drivers/infiniband/hw/mlx5/main.o:(.rodata+0x24d8): undefined reference to `uverbs_destroy_def_handler'
> >
> > Guard the problematic code, so VAR objects API won't be compiled without CONFIG_INFINIBAND_USER_ACCESS.
> >
> > Fixes: 7be76bef320b ("IB/mlx5: Introduce VAR object and its alloc/destroy methods")
> > Reported-by: Randy Dunlap <rdunlap@infradead.org>
> > Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> >  drivers/infiniband/hw/mlx5/main.c | 22 +++++++++++++---------
> >  1 file changed, 13 insertions(+), 9 deletions(-)
>
> Hurm. This is actually a side effect of some other code that needs to
> be deleted.. We can now make all the generated structs static and rely
> on compiler pruning to sort this out.
>
> So this:
>
>         if (IS_ENABLED(CONFIG_INFINIBAND_USER_ACCESS))
>                 dev->ib_dev.driver_def = mlx5_ib_defs;
>
> Will cause the compiler to drop the entire tree of stuff, above
> references inclded.

It is viable solution too, more cryptic than previous one, but cleaner for sure.

Thanks
