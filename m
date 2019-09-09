Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C578EAD602
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Sep 2019 11:46:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729179AbfIIJqp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 9 Sep 2019 05:46:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:59254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728701AbfIIJqp (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 9 Sep 2019 05:46:45 -0400
Received: from localhost (unknown [148.69.85.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 258E1206A1;
        Mon,  9 Sep 2019 09:46:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568022404;
        bh=jR7maaGH/KcGHteR7nCkk9JujZ8WwvgZHlZI4x7S9ZQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sU5KLCFyfBmsMLmWEsdTTL517uE5UAKqA7UMWLxt/efiz/HBWL/kAeGRUNftn6Sw7
         FyGCxdT6zoaLCYV69WHMvUvS3w/pv4Lt6qGm6qGP5gA5Iu/jMgElGFk8jRt1vaVyNQ
         n2Mt6wFh6AUdXsCzgl32IfUxVNemdhTQ5hJGje+U=
Date:   Mon, 9 Sep 2019 12:46:41 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Erez Alfasi <ereza@mellanox.com>
Subject: Re: [PATCH rdma-next v1 2/4] RDMA/nldev: Allow different fill
 function per resource
Message-ID: <20190909094641.GB6601@unreal>
References: <20190830081612.2611-1-leon@kernel.org>
 <20190830081612.2611-3-leon@kernel.org>
 <20190909084807.GC2843@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190909084807.GC2843@mellanox.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Sep 09, 2019 at 08:48:09AM +0000, Jason Gunthorpe wrote:
> On Fri, Aug 30, 2019 at 11:16:10AM +0300, Leon Romanovsky wrote:
> > From: Erez Alfasi <ereza@mellanox.com>
> >
> > So far res_get_common_{dumpit, doit} was using the default
> > resource fill function which was defined as part of the
> > nldev_fill_res_entry fill_entries.
> >
> > Add a fill function pointer as an argument allows us to use
> > different fill function in case we want to dump different
> > values then 'rdma resource' flow do, but still use the same
> > existing general resources dumping flow.
> >
> > If a NULL value is passed, it will be using the default
> > fill function that was defined in 'fill_entries' for a
> > given resource type.
> >
> > Signed-off-by: Erez Alfasi <ereza@mellanox.com>
> > Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> >  drivers/infiniband/core/nldev.c | 42 +++++++++++++++++++++++----------
> >  1 file changed, 29 insertions(+), 13 deletions(-)
> >
> > diff --git a/drivers/infiniband/core/nldev.c b/drivers/infiniband/core/nldev.c
> > index cc08218f1ef7..47f7fe5432db 100644
> > +++ b/drivers/infiniband/core/nldev.c
> > @@ -1181,7 +1181,10 @@ static const struct nldev_fill_res_entry fill_entries[RDMA_RESTRACK_MAX] = {
> >
> >  static int res_get_common_doit(struct sk_buff *skb, struct nlmsghdr *nlh,
> >  			       struct netlink_ext_ack *extack,
> > -			       enum rdma_restrack_type res_type)
> > +			       enum rdma_restrack_type res_type,
> > +			       int (*fill_func)(struct sk_buff*, bool,
> > +						struct rdma_restrack_entry*,
> > +						uint32_t))
>
> Use a typedef?

I'll take a look on that, but it is not fully clear to me what are the
gains here.

>
> >  {
> >  	const struct nldev_fill_res_entry *fe = &fill_entries[res_type];
> >  	struct nlattr *tb[RDMA_NLDEV_ATTR_MAX];
> > @@ -1244,7 +1247,12 @@ static int res_get_common_doit(struct sk_buff *skb, struct nlmsghdr *nlh,
> >  	}
> >
> >  	has_cap_net_admin = netlink_capable(skb, CAP_NET_ADMIN);
> > -	ret = fe->fill_res_func(msg, has_cap_net_admin, res, port);
> > +
> > +	if (fill_func)
> > +		ret = fill_func(msg, has_cap_net_admin, res, port);
> > +	else
> > +		ret = fe->fill_res_func(msg, has_cap_net_admin, res, port);
>
> Weird to now be choosing between two function pointers

I didn't like this either, but we didn't find an easy solution to do
chains of fill functions. In our case, we are requesting COUNTER object
which will call to MR object to fill statistic.

>
> > -#define RES_GET_FUNCS(name, type)                                              \
> > -	static int nldev_res_get_##name##_dumpit(struct sk_buff *skb,          \
> > +#define RES_GET_FUNCS(name, type)					       \
> > +	static int nldev_res_get_##name##_dumpit(struct sk_buff *skb,	       \
> >  						 struct netlink_callback *cb)  \
> > -	{                                                                      \
> > -		return res_get_common_dumpit(skb, cb, type);                   \
> > -	}                                                                      \
> > -	static int nldev_res_get_##name##_doit(struct sk_buff *skb,            \
> > -					       struct nlmsghdr *nlh,           \
> > +	{								       \
> > +		return res_get_common_dumpit(skb, cb, type, NULL);	       \
> > +	}								       \
> > +	static int nldev_res_get_##name##_doit(struct sk_buff *skb,	       \
> > +					       struct nlmsghdr *nlh,	       \
> >  					       struct netlink_ext_ack *extack) \
> > -	{                                                                      \
> > -		return res_get_common_doit(skb, nlh, extack, type);            \
> > +	{								       \
> > +		return res_get_common_doit(skb, nlh, extack, type, NULL);      \
> >  	}
>
> ie the NULL should be fill_entries[type]->fill_res_func?

The "if (fill_func) " above will do the trick.

>
> Jason
