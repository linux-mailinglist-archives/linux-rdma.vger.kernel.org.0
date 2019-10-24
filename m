Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E6C4E3417
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Oct 2019 15:26:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728026AbfJXN0M (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 24 Oct 2019 09:26:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:57470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727786AbfJXN0L (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 24 Oct 2019 09:26:11 -0400
Received: from localhost (unknown [77.137.89.37])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B2C5A2084C;
        Thu, 24 Oct 2019 13:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571923571;
        bh=qPf9wh5b0F7490ToTndPlqp+QBtOXunYxp91MkuCgeE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NdwHDo+PDT6yHLZ5ZMji+kwAljg4wRIeA+ETy1LwEqpJ3F/+8ubn02ahaZ8xDVzYQ
         KPjAh113RvNiJHBYP0BGXkK8Bohrp1/JUnLgPaBNUfh31xIcpAgPHMWIUQUkZbByVk
         f3+13GsP3SYQvirZ/njWF8HVFcSgP2KRvo5dcAGA=
Date:   Thu, 24 Oct 2019 16:26:07 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Doug Ledford <dledford@redhat.com>,
        Parav Pandit <parav@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-next] IB/core: Avoid deadlock during netlink message
 handling
Message-ID: <20191024132607.GR4853@unreal>
References: <20191015080733.18625-1-leon@kernel.org>
 <20191024131743.GA24174@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191024131743.GA24174@ziepe.ca>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Oct 24, 2019 at 10:17:43AM -0300, Jason Gunthorpe wrote:
> On Tue, Oct 15, 2019 at 11:07:33AM +0300, Leon Romanovsky wrote:
>
> > diff --git a/drivers/infiniband/core/netlink.c b/drivers/infiniband/core/netlink.c
> > index 81dbd5f41bed..a3507b8be569 100644
> > +++ b/drivers/infiniband/core/netlink.c
> > @@ -42,9 +42,12 @@
> >  #include <linux/module.h>
> >  #include "core_priv.h"
> >
> > -static DEFINE_MUTEX(rdma_nl_mutex);
> >  static struct {
> > -	const struct rdma_nl_cbs   *cb_table;
> > +	const struct rdma_nl_cbs __rcu *cb_table;
> > +	/* Synchronizes between ongoing netlink commands and netlink client
> > +	 * unregistration.
> > +	 */
> > +	struct srcu_struct unreg_srcu;
>
> A srcu in every index is serious overkill for this. Lets just us a
> rwsem:

I liked previous variant more than rwsem, but it is Parav's patch.

Thanks
