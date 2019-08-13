Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 419C58B582
	for <lists+linux-rdma@lfdr.de>; Tue, 13 Aug 2019 12:26:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727550AbfHMK0H (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 13 Aug 2019 06:26:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:58340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727416AbfHMK0H (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 13 Aug 2019 06:26:07 -0400
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D5AAE20679;
        Tue, 13 Aug 2019 10:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565691966;
        bh=mDsqUEIo2EKF7Bypb/jdUYk9tPROhU9qIunLZG/gs1w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0nF8TdG/A9cxrJSTbXWGmBuqbsnNH+t/94JMHEWxQlELTPKTODzIm8xnisbzbTIJb
         7G0rc1mgfJC7Z9YTzWLSxhoo0WXHk5/iKYikaUApSWnUg1huORxVJyWE89Xrkz9ACq
         S1daesAika+36MfLpkKdcNkB0Br8gC/JN+QmPgUY=
Date:   Tue, 13 Aug 2019 13:26:03 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>
Cc:     Jason Gunthorpe <jgg@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-next] RDMA/mlx5: Annotate lock dependency in
 unbinding slave port
Message-ID: <20190813102603.GG29138@mtr-leonro.mtl.com>
References: <20190808083907.29316-1-leon@kernel.org>
 <5008d1458ccbbf368ce8c2235c200798fee480cd.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5008d1458ccbbf368ce8c2235c200798fee480cd.camel@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Aug 12, 2019 at 10:31:19AM -0400, Doug Ledford wrote:
> On Thu, 2019-08-08 at 11:39 +0300, Leon Romanovsky wrote:
> > From: Leon Romanovsky <leonro@mellanox.com>
> >
> > NULL-ing notifier_call is performed under protection
> > of mlx5_ib_multiport_mutex lock. Such protection is
> > not easily spotted and better to be guarded by lockdep
> > annotation.
> >
> > Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> > ---
> > Based on -rc commit: 23eaf3b5c1a7 ("RDMA/mlx5: Release locks during
> > notifier unregister")
> > ---
> >  drivers/infiniband/hw/mlx5/main.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/infiniband/hw/mlx5/main.c
> > b/drivers/infiniband/hw/mlx5/main.c
> > index 7933534be931..63969484421c 100644
> > --- a/drivers/infiniband/hw/mlx5/main.c
> > +++ b/drivers/infiniband/hw/mlx5/main.c
> > @@ -5835,6 +5835,8 @@ static void mlx5_ib_unbind_slave_port(struct
> > mlx5_ib_dev *ibdev,
> >  	int err;
> >  	int i;
> >
> > +	lockdep_assert_held(&mlx5_ib_multiport_mutex);
> > +
> >  	mlx5_ib_cleanup_cong_debugfs(ibdev, port_num);
> >
> >  	spin_lock(&port->mp.mpi_lock);
> > --
> > 2.20.1
> >
>
> Hi Leon,
>
> This patch needed to catch both the unbind and the bind/init routine as
> they both require the multiport mutex be held.  Can you respin please?

It has comment "5889 /* The mlx5_ib_multiport_mutex should be held when
calling this function */", why do we need lockdep?

Just kidding, sending fixed patch now.

Thanks

>
> --
> Doug Ledford <dledford@redhat.com>
>     GPG KeyID: B826A3330E572FDD
>     Fingerprint = AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD


