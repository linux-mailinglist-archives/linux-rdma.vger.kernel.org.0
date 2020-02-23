Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31C2D169712
	for <lists+linux-rdma@lfdr.de>; Sun, 23 Feb 2020 10:49:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726208AbgBWJtc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 23 Feb 2020 04:49:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:39698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725980AbgBWJtc (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 23 Feb 2020 04:49:32 -0500
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0EEF420656;
        Sun, 23 Feb 2020 09:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582451371;
        bh=+ASWhGhlh5f61lI8w5+S5LbhQrZy90MaFt/vkTtK4gg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0az1MvSpKlHR4qkUkaL5QyVUWCqG5xIPbLGhXf0II5LUvecbMveqeqFCNHjNapr4X
         ZQB2BEXxFfOtJYTzGt4CNKrAG2c8J4RVfQyyxC3R6ipyHlJ9+Vzv4Fv9uMwzNJK9w5
         lHjHNKN9wqfSrCwp+/wvDSEc/vFSn5z0BR2+dN94=
Date:   Sun, 23 Feb 2020 11:49:28 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Parav Pandit <parav@mellanox.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Weihang Li <liweihang@huawei.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linuxarm@huawei.com" <linuxarm@huawei.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>
Subject: Re: Is anyone working on implementing LAG in ib core?
Message-ID: <20200223094928.GB422704@unreal>
References: <280d87d0-fbc0-0566-794b-f66cb4fadb63@huawei.com>
 <20200222234026.GO31668@ziepe.ca>
 <98482e8a-f2eb-5406-b679-0ceb946ac618@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <98482e8a-f2eb-5406-b679-0ceb946ac618@mellanox.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Feb 23, 2020 at 12:44:12AM +0000, Parav Pandit wrote:
> Hi Jason, Weihang,
>
> On 2/22/2020 5:40 PM, Jason Gunthorpe wrote:
> > On Sat, Feb 22, 2020 at 11:48:04AM +0800, Weihang Li wrote:
> >> Hi all,
> >>
> >> We plan to implement LAG in hns drivers recently, and as we know, there is
> >> already a mature and stable solution in the mlx5 driver. Considering that
> >> the net subsystem in kernel adopt the strategy that the framework implement
> >> bonding, we think it's reasonable to add LAG feature to the ib core based
> >> on mlx5's implementation. So that all drivers including hns and mlx5 can
> >> benefit from it.
> >>
> >> In previous discussions with Leon about achieving reporting of ib port link
> >> event in ib core, Leon mentioned that there might be someone trying to do
> >> this.
> >>
> >> So may I ask if there is anyone working on LAG in ib core or planning to
> >> implement it in near future? I will appreciate it if you can share your
> >> progress with me and maybe we can finish it together.
> >>
> >> If nobody is working on this, our team may take a try to implement LAG in
> >> the core. Any comments and suggestion are welcome.
> >
> > This is something that needs to be done, I understand several of the
> > other drivers are going to want to use LAG and we certainly can't have
> > everything copied into each driver.
> >
> > Jason
> >
> I am not sure mlx5 is right model for new rdma bond device support which
> I tried to highlight in Q&A-1 below.
>
> I have below not-so-refined proposal for rdma bond device.
>
> - Create a rdma bond device named rbond0 using two slave rdma devices
> mlx5_0 mlx5_1 which is connected to netdevice bond1 and underlying dma
> device of mlx5_0 rdma device.
>
> $ rdma dev add type bond name rbond0 netdev bond1 slave mlx5_0 slave
> mlx5_1 dmadevice mlx5_0
>
> $ rdma dev show
> 0: mlx5_0: node_type ca fw 12.25.1020 node_guid 248a:0703:0055:4660
> sys_image_guid 248a:0703:0055:4660
> 1: mlx5_1: node_type ca fw 12.25.1020 node_guid 248a:0703:0055:4661
> sys_image_guid 248a:0703:0055:4660
> 2: rbond0: node_type ca node_guid 248a:0703:0055:4660 sys_image_guid
> 248a:0703:0055:4660
>
> - This should be done via rdma bond driver in
> drivers/infiniband/ulp/rdma_bond

Extra question, why do we need RDMA bond ULP which combines ib devices
and not create netdev bond device and create one ib device on top of that?

Thanks
