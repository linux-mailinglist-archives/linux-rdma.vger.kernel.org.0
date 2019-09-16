Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2654FB40A1
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Sep 2019 20:53:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726724AbfIPSxj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 16 Sep 2019 14:53:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:50698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725912AbfIPSxi (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 16 Sep 2019 14:53:38 -0400
Received: from localhost (unknown [77.137.89.37])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8DFFF206A4;
        Mon, 16 Sep 2019 18:53:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568660018;
        bh=8EJJVoQBy1M6FY6G2rYO0WfzKkVaFCDd0SbMjfnZGhM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dWALIpZ7MslPQYWLKXQv0ocBw2L+190wLiHFtVt3UhhrWYR82Hpw5VA+ixdr5d9Y2
         FJTY2LShJj39jUC3yVzSZg6tchfZBqssrih7vbEneZ7Juzr76s56aYuwPZi3MifkYX
         Oc2gx1ILgbvwBk15x8rV/vg4Oid+IpgGzJDgkG40=
Date:   Mon, 16 Sep 2019 21:53:33 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Jack Morgenstein <jackm@dev.mellanox.co.il>,
        Mark Zhang <markz@mellanox.com>
Subject: Re: [PATCH 3/4] RDMA/nldev: Reshuffle the code to avoid need to
 rebind QP in error path
Message-ID: <20190916185333.GD18203@unreal>
References: <20190916071154.20383-1-leon@kernel.org>
 <20190916071154.20383-4-leon@kernel.org>
 <20190916184818.GH2585@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190916184818.GH2585@mellanox.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Sep 16, 2019 at 06:48:24PM +0000, Jason Gunthorpe wrote:
> On Mon, Sep 16, 2019 at 10:11:53AM +0300, Leon Romanovsky wrote:
> > From: Leon Romanovsky <leonro@mellanox.com>
> >
> > Properly unwind QP counter rebinding in case of failure.
>
> What is the actual problem here? Calling 'bind' in an error
> unwind seems insane, is that the issue?

Yep

>
> > Fixes: b389327df905 ("RDMA/nldev: Allow counter manual mode configration through RDMA netlink")
> > Reviewed-by: Mark Zhang <markz@mellanox.com>
> > Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> >  drivers/infiniband/core/nldev.c | 12 +++++-------
> >  1 file changed, 5 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/infiniband/core/nldev.c b/drivers/infiniband/core/nldev.c
> > index 5e2b7eb0761b..6eb14481a72e 100644
> > +++ b/drivers/infiniband/core/nldev.c
> > @@ -1860,24 +1860,22 @@ static int nldev_stat_del_doit(struct sk_buff *skb, struct nlmsghdr *nlh,
> >
> >  	cntn = nla_get_u32(tb[RDMA_NLDEV_ATTR_STAT_COUNTER_ID]);
> >  	qpn = nla_get_u32(tb[RDMA_NLDEV_ATTR_RES_LQPN]);
> > -	ret = rdma_counter_unbind_qpn(device, port, qpn, cntn);
> > -	if (ret)
> > -		goto err_unbind;
> > -
> >  	if (fill_nldev_handle(msg, device) ||
> >  	    nla_put_u32(msg, RDMA_NLDEV_ATTR_PORT_INDEX, port) ||
> >  	    nla_put_u32(msg, RDMA_NLDEV_ATTR_STAT_COUNTER_ID, cntn) ||
> >  	    nla_put_u32(msg, RDMA_NLDEV_ATTR_RES_LQPN, qpn)) {
> >  		ret = -EMSGSIZE;
> > -		goto err_fill;
> > +		goto err_unbind;
>
> These label names don't make much sense anymore
>
> Jason
