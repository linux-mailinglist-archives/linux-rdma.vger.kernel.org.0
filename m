Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C76C0282AB6
	for <lists+linux-rdma@lfdr.de>; Sun,  4 Oct 2020 14:51:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726105AbgJDMvN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 4 Oct 2020 08:51:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726073AbgJDMvM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 4 Oct 2020 08:51:12 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B478C0613CF
        for <linux-rdma@vger.kernel.org>; Sun,  4 Oct 2020 05:51:12 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id e18so687877wrw.9
        for <linux-rdma@vger.kernel.org>; Sun, 04 Oct 2020 05:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NWBeWhYvqI1FaAKjAJpj6jWIW4TXx/1lMCIilXhrywA=;
        b=f2i5xWa4yyLpNeSJ7hm8jsA3LbBHvgmugpTM5iHYCX6UC/K8XbS+FFyRZom4udOiIM
         gMUNqhF2qSumLTv+g/aoqV/mD0go/XrUtgmhIy7A2tP63lunlPOWKTbe5enm6u7ZyZDw
         Bw+L6oHU/dwvfcprOkWXTaXpovsoXi6HDf2DkugZ7onnIcFO3cmY0Ij4qUjuQc5GtvJq
         q41o4Tg32P2Q3oqZ+IR5wuYjY3SWVNZ6cjs04nOtzcFrwKZ3zfA1vLrXwXoC91rwpcRH
         LbQf2McqMoelrluLhPC4M05hGyhILQIdfzJElBhjBRAxGsoTscylecIarAVAoJV8ha6C
         sM1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NWBeWhYvqI1FaAKjAJpj6jWIW4TXx/1lMCIilXhrywA=;
        b=RMj7Sz28lw+WKGlooEoWqva2dU0h9IV7gyvOUTwLKgZbQ2a+HmNuDcB2Lr2GibN62q
         NhJ0fqHi8+/XhImqJAf3jeZ5VmJFhcRcw3DFweH1vyfYG6XrgVJqJkfWl300YmQZYJVY
         ReRz2UBq9CsJbYC1+TQu0wvnIrR7rpywfKkUiaFtqbMaL0KrVxsYgVaZvC98aTwRY6Cn
         5qd15FHDgIGVOyYQ/7Md/OIrZpe+Kq6AHg0BWRBd/hBppeho14pf17dYpiat1ai8zWYJ
         ZmknkzQsO6Gg5dZagzCEtJR8pbY1LGgB0crGIdRFRsgz/MK7OXqMAXOOnmB9yyceEPci
         x26A==
X-Gm-Message-State: AOAM5324FYik/a5XAEkqdJqHIweg5QJnkkqHCR7Hd2tli2+kX1RJ9lTd
        ReSXSR1EaDe7FX0YbhiopEY=
X-Google-Smtp-Source: ABdhPJyriXm7JncFThtaQtAh9sybPdhmygkvwHXVRFo/6iI5B0kdnKIHoyYRrJ/NskXOGuEs6I0jeQ==
X-Received: by 2002:a5d:4645:: with SMTP id j5mr11465513wrs.388.1601815870784;
        Sun, 04 Oct 2020 05:51:10 -0700 (PDT)
Received: from kheib-workstation ([77.137.152.100])
        by smtp.gmail.com with ESMTPSA id c25sm8631865wml.31.2020.10.04.05.51.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2020 05:51:10 -0700 (PDT)
Date:   Sun, 4 Oct 2020 15:51:07 +0300
From:   Kamal Heib <kamalheib1@gmail.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: Re: [PATCH for-rc v2] RDMA/ipoib: Set rtnl_link_ops for ipoib
 interfaces
Message-ID: <20201004125107.GA5480@kheib-workstation>
References: <20200930094013.156839-1-kamalheib1@gmail.com>
 <20201002120236.GA1327974@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201002120236.GA1327974@nvidia.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Oct 02, 2020 at 09:02:36AM -0300, Jason Gunthorpe wrote:
> On Wed, Sep 30, 2020 at 12:40:13PM +0300, Kamal Heib wrote:
> > To avoid inconsistent user experience for PKey interfaces that are
> > created via netlink vs PKey interfaces that are created via sysfs and the
> > base interface, make sure to set the rtnl_link_ops for all ipoib network
> > devices, so the ipoib attributes will be reported/modified via iproute2
> > for all ipoib interfaces regardless of how they are created.
> > 
> > Also, after setting the rtnl_link_ops for the base interface, implement
> > the dellink() callback to block users from trying to remove it.
> > 
> > Fixes: 9baa0b036410 ("IB/ipoib: Add rtnl_link_ops support")
> > Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
> > v2: Update commit message.
> >  drivers/infiniband/ulp/ipoib/ipoib_main.c    |  2 ++
> >  drivers/infiniband/ulp/ipoib/ipoib_netlink.c | 11 +++++++++++
> >  drivers/infiniband/ulp/ipoib/ipoib_vlan.c    |  2 ++
> >  3 files changed, 15 insertions(+)
> > 
> > diff --git a/drivers/infiniband/ulp/ipoib/ipoib_main.c b/drivers/infiniband/ulp/ipoib/ipoib_main.c
> > index ab75b7f745d4..96b6be5d507d 100644
> > +++ b/drivers/infiniband/ulp/ipoib/ipoib_main.c
> > @@ -2477,6 +2477,8 @@ static struct net_device *ipoib_add_port(const char *format,
> >  	/* call event handler to ensure pkey in sync */
> >  	queue_work(ipoib_workqueue, &priv->flush_heavy);
> >  
> > +	ndev->rtnl_link_ops = ipoib_get_link_ops();
> > +
> >  	result = register_netdev(ndev);
> 
> Why do we need this one? I understand fixing the sysfs but not this part.
>

We need this one to report/modify the ipoib attributes for the parent
interface (please take a look at pkey, mode, and umcast after applying
this patch):

$ ip -d link show dev mlx5_ib0
29: mlx5_ib0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 2044 qdisc mq state UP mode DEFAULT group default qlen 256
    link/infiniband 00:00:1f:e4:fe:80:00:00:00:00:00:00:24:8a:07:03:00:a3:19:64 brd 00:ff:ff:ff:ff:12:40:1b:ff:ff:00:00:00:00:00:00:ff:ff:ff:ff promiscuity 0 minmtu 68 maxmtu 65520
    ipoib pkey  0xffff mode  datagram umcast  0000 addrgenmode none numtxqueues 256 numrxqueues 32 gso_max_size 65536 gso_max_segs 65535

> >  	if (result) {
> >  		pr_warn("%s: couldn't register ipoib port %d; error %d\n",
> > diff --git a/drivers/infiniband/ulp/ipoib/ipoib_netlink.c b/drivers/infiniband/ulp/ipoib/ipoib_netlink.c
> > index 38c984d16996..d5a90a66b45c 100644
> > +++ b/drivers/infiniband/ulp/ipoib/ipoib_netlink.c
> > @@ -144,6 +144,16 @@ static int ipoib_new_child_link(struct net *src_net, struct net_device *dev,
> >  	return 0;
> >  }
> >  
> > +static void ipoib_del_child_link(struct net_device *dev, struct list_head *head)
> > +{
> > +	struct ipoib_dev_priv *priv = ipoib_priv(dev);
> > +
> > +	if (!priv->parent)
> > +		return;
> > +
> > +	unregister_netdevice_queue(dev, head);
> > +}
> 
> The above is why this hunk was added right?

This hunk was added to block users from trying to remove the parent
interface.

> 
> >  static size_t ipoib_get_size(const struct net_device *dev)
> >  {
> >  	return nla_total_size(2) +	/* IFLA_IPOIB_PKEY   */
> > @@ -158,6 +168,7 @@ static struct rtnl_link_ops ipoib_link_ops __read_mostly = {
> >  	.priv_size	= sizeof(struct ipoib_dev_priv),
> >  	.setup		= ipoib_setup_common,
> >  	.newlink	= ipoib_new_child_link,
> > +	.dellink	= ipoib_del_child_link,
> >  	.changelink	= ipoib_changelink,
> >  	.get_size	= ipoib_get_size,
> >  	.fill_info	= ipoib_fill_info,
> > diff --git a/drivers/infiniband/ulp/ipoib/ipoib_vlan.c b/drivers/infiniband/ulp/ipoib/ipoib_vlan.c
> > index 30865605e098..c60db9f3f5ac 100644
> > +++ b/drivers/infiniband/ulp/ipoib/ipoib_vlan.c
> > @@ -129,6 +129,8 @@ int __ipoib_vlan_add(struct ipoib_dev_priv *ppriv, struct ipoib_dev_priv *priv,
> >  		goto out_early;
> >  	}
> >  
> > +	ndev->rtnl_link_ops = ipoib_get_link_ops();
> > +
> 
> If this is only for the sysfs case why isn't it in ipoib_vlan_add()
> which is the sysfs only flow?
>

Basically, I was making sure set the rtnl_link_ops before calling
register_netdevice(), but you are right this can be moved to the
ipoib_vlan_add() as the setting of the rtnl_link_ops for pkey that is
created via netlink is done before calling newlink callback, I'll send a
v3 that move it to ipoib_vlan_add().

Thanks,
Kamal

> Jason
