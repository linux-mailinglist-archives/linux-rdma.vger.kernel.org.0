Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B5CEF0010
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Nov 2019 15:41:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728647AbfKEOlH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 5 Nov 2019 09:41:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:53128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728417AbfKEOlG (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 5 Nov 2019 09:41:06 -0500
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B4E4E21928;
        Tue,  5 Nov 2019 14:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572964866;
        bh=9qJ/t+ccqlOOrccaK8tf3z8F5EWdOnavgzrVMz4gslo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PNH8kmMPrhZlxHlCl/3wI+oWsVjfbFAZ1IMrPnTya3J36RHeGvVjzD4mhWtooGXVe
         Fl88JkNfuNP//tOEgW4ZMAR4GzEZYvWzmU5dnjE/e8XOPyUUyIF7oNQ/AVlh3k1n6v
         1gWOzU9R0r4M1J+bpqHhAt/8A7HoUghkwiqWOyDE=
Date:   Tue, 5 Nov 2019 16:41:03 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Parav Pandit <parav@mellanox.com>
Cc:     Yixian Liu <liuyixian@huawei.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linuxarm@huawei.com" <linuxarm@huawei.com>
Subject: Re: [PATCH rdma-next] RDMA/core: Use pr_warn_ratelimited
Message-ID: <20191105144103.GF6763@unreal>
References: <1572925690-7336-1-git-send-email-liuyixian@huawei.com>
 <AM0PR05MB4866B3612F0AE576136EED94D17E0@AM0PR05MB4866.eurprd05.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM0PR05MB4866B3612F0AE576136EED94D17E0@AM0PR05MB4866.eurprd05.prod.outlook.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Nov 05, 2019 at 04:09:12AM +0000, Parav Pandit wrote:
> Hi Yixian Liu,
>
> > -----Original Message-----
> > From: linux-rdma-owner@vger.kernel.org <linux-rdma-
> > owner@vger.kernel.org> On Behalf Of Yixian Liu
> > Sent: Monday, November 4, 2019 9:48 PM
> > To: dledford@redhat.com; jgg@ziepe.ca
> > Cc: Parav Pandit <parav@mellanox.com>; leon@kernel.org; linux-
> > rdma@vger.kernel.org; linuxarm@huawei.com
> > Subject: [PATCH rdma-next] RDMA/core: Use pr_warn_ratelimited
> >
> > This warning can be triggered easily when adding a large number of VLANs
> > while the capacity of GID table is small.
> >
> > Fixes: 598ff6bae689 ("IB/core: Refactor GID modify code for RoCE")
> > Signed-off-by: Yixian Liu <liuyixian@huawei.com>
> > ---
> >  drivers/infiniband/core/cache.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> Thanks for the patch. However, vlan netdevice addition is an administrative operation allowed to process which has CAP_NET_ADMIN privilege.
> So large number of VLAN addition by a user for a RoCE device whose GID capacity is small is constrained operation.
> Therefore, we shouldn't be rate limiting it.
> By rate limiting we miss the information about any bugs in GID cache management.
> At best we can convert it to dev_dbg() so that we still get the necessary debug information when needed.
> I wanted to convert them trace functions which will allow us to more debug level prints such as netdev name, vlan etc.
> I think I remember comment from Leon too while working on it, but it was long haul that time.

I wanted to work on it, but it never happened.

Thanks
