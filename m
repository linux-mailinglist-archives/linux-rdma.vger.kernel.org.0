Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 114A914891
	for <lists+linux-rdma@lfdr.de>; Mon,  6 May 2019 12:49:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725861AbfEFKt6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 May 2019 06:49:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:40814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725853AbfEFKt6 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 6 May 2019 06:49:58 -0400
Received: from localhost (unknown [37.142.3.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9AB88206BF;
        Mon,  6 May 2019 10:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557139797;
        bh=UIhXGzNFZZpFFqMg59VtTuAUu2udaliUyRRcOI/OkV0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V6YKIvd0VlteHykouM0+RYVaHED+uXIeyKMgWYdKJfPU4GW95v6nQmb3H7FO8wnti
         ZPUAHZKSe8Mf9pGMgkSWCXPiYwSa4ztASekJi+T4kEEfn+UXNjNzJvgwiuTnJaV678
         GT9Ap+X39iIjvUS9ZBbxca93wtzTj5PVmmbqf6N4=
Date:   Mon, 6 May 2019 13:49:52 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Gal Pressman <galpress@amazon.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Arseny Maslennikov <ar@cs.msu.ru>
Subject: Re: [PATCH rdma-next] RDMA/ipoib: Allow user space differentiate
 between valid dev_port
Message-ID: <20190506104952.GL6938@mtr-leonro.mtl.com>
References: <20190506102107.14817-1-leon@kernel.org>
 <4c4c560a-d3ec-4b32-203f-178bddde478d@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c4c560a-d3ec-4b32-203f-178bddde478d@amazon.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, May 06, 2019 at 01:35:07PM +0300, Gal Pressman wrote:
> On 06-May-19 13:21, Leon Romanovsky wrote:
> > From: Leon Romanovsky <leonro@mellanox.com>
> >
> > Systemd triggers the following warning during IPoIB device load:
> >
> >  mlx5_core 0000:00:0c.0 ib0: "systemd-udevd" wants to know my dev_id.
> >         Should it look at dev_port instead?
> >         See Documentation/ABI/testing/sysfs-class-net for more info.
> >
> > This is caused due to user space attempt to differentiate old systems
> > without dev_port and new systems with dev_port. In case dev_port will
> > be zero, the systemd will try to read dev_id instead.
> >
> > There is no need to print a warning in such case, because it is valid
> > situation and it is needed to ensure systemd compatibility with old
> > kernels.
> >
> > Link: https://github.com/systemd/systemd/blob/master/src/udev/udev-builtin-net_id.c#L358
> > Cc: <stable@vger.kernel.org> # 4.19
> > Fixes: f6350da41dc7 ("IB/ipoib: Log sysfs 'dev_id' accesses from userspace")
> > Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> > ---
> >  drivers/infiniband/ulp/ipoib/ipoib_main.c | 12 +++++++++++-
> >  1 file changed, 11 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/infiniband/ulp/ipoib/ipoib_main.c b/drivers/infiniband/ulp/ipoib/ipoib_main.c
> > index 48eda16db1a7..34e6495aa8c5 100644
> > --- a/drivers/infiniband/ulp/ipoib/ipoib_main.c
> > +++ b/drivers/infiniband/ulp/ipoib/ipoib_main.c
> > @@ -2402,7 +2402,17 @@ static ssize_t dev_id_show(struct device *dev,
> >  {
> >  	struct net_device *ndev = to_net_dev(dev);
> >
> > -	if (ndev->dev_id == ndev->dev_port)
> > +	/*
> > +	 * ndev->dev_port will be equal to 0 in old kernel prior to commit
> > +	 * 9b8b2a323008 ("IB/ipoib: Use dev_port to expose network interface port numbers")
> > +	 * Zero was chosen as special case for user space applications to fallback
> > +	 * and query dev_id to check if it has different value or not.
> > +	 *
> > +	 * Don't pring warning in such scenario.
>
> "pring" -> "print".

Are you ok with other changes and I can add your ROB tag?

Thanks
>
> > +	 *
> > +	 * https://github.com/systemd/systemd/blob/master/src/udev/udev-builtin-net_id.c#L358
> > +	 */
> > +	if (ndev->dev_port && ndev->dev_id == ndev->dev_port)
> >  		netdev_info_once(ndev,
> >  			"\"%s\" wants to know my dev_id. Should it look at dev_port instead? See Documentation/ABI/testing/sysfs-class-net for more info.\n",
> >  			current->comm);
> >
>
