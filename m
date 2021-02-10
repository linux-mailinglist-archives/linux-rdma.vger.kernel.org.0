Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C38D316855
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Feb 2021 14:51:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231478AbhBJNvk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 10 Feb 2021 08:51:40 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:15559 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231546AbhBJNvK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 10 Feb 2021 08:51:10 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B6023e4a50000>; Wed, 10 Feb 2021 05:50:29 -0800
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 10 Feb
 2021 13:50:28 +0000
Received: from reg-r-vrt-018-180.nvidia.com (172.20.145.6) by
 DRHQMAIL107.nvidia.com (10.27.9.16) with Microsoft SMTP Server (TLS) id
 15.0.1473.3; Wed, 10 Feb 2021 13:50:27 +0000
References: <YCO+nR+3Zs9jIAfp@mwanda> <ygnha6scgms4.fsf@nvidia.com>
 <20210210132137.GA296697@shredder.lan>
User-agent: mu4e 1.4.10; emacs 27.1
From:   Vlad Buslov <vladbu@nvidia.com>
To:     Ido Schimmel <idosch@idosch.org>
CC:     Dan Carpenter <dan.carpenter@oracle.com>, <jiri@resnulli.us>,
        <linux-rdma@vger.kernel.org>
Subject: Re: [bug report] net/mlx5e: Handle FIB events to update tunnel
 endpoint device
In-Reply-To: <20210210132137.GA296697@shredder.lan>
Date:   Wed, 10 Feb 2021 15:50:03 +0200
Message-ID: <ygnh7dngghh0.fsf@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1612965029; bh=AKU/ClDpRMf8+cRL4t2vO+ZSQnlNp5K68niM59E315M=;
        h=References:User-agent:From:To:CC:Subject:In-Reply-To:Date:
         Message-ID:MIME-Version:Content-Type:X-Originating-IP:
         X-ClientProxiedBy;
        b=HdRe+UQqGe7Yo9qEvVl5kJaDlHemAMeecMHigiRssmtKJPQn46IYQcdUaZLVhxTlB
         u2hzFc2GqTpJz8WAABsuJgq7C4RVVa4k6BF8A9mDpTpWswrEOHUqlYCpBDCQV6i5yR
         eOoMA7Kn6IWVY1HtQ9jAQLXyaBH95iUsnOA3gTzV6TPxYSDB3SkO52VUhl5fR3jXcV
         ZSOgBf/GBZYu24ARaaTw3XTXlhuTCTSjx0ip+MhqgoMDLDbaIJZtbJwZEu4qNWMnoT
         W/rDjIDkVJbHSU9gtE3bz9VmF3yGSb9luUIkGnC53SOILuZmljip0Frw3LfXryhnvO
         D0jEjm+o1pwEQ==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On Wed 10 Feb 2021 at 15:21, Ido Schimmel <idosch@idosch.org> wrote:
> On Wed, Feb 10, 2021 at 01:55:23PM +0200, Vlad Buslov wrote:
>> On Wed 10 Feb 2021 at 13:08, Dan Carpenter <dan.carpenter@oracle.com> wrote:
>> > Hello Vlad Buslov,
>> >
>> > The patch 8914add2c9e5: "net/mlx5e: Handle FIB events to update
>> > tunnel endpoint device" from Jan 25, 2021, leads to the following
>> > static checker warning:
>> >
>> > 	drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun_encap.c:1639 mlx5e_tc_tun_init()
>> > 	error: passing non negative 1 to ERR_PTR
>> >
>> > drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun_encap.c
>> >   1622  struct mlx5e_tc_tun_encap *mlx5e_tc_tun_init(struct mlx5e_priv *priv)
>> >   1623  {
>> >   1624          struct mlx5e_tc_tun_encap *encap;
>> >   1625          int err;
>> >   1626  
>> >   1627          encap = kvzalloc(sizeof(*encap), GFP_KERNEL);
>> >   1628          if (!encap)
>> >   1629                  return ERR_PTR(-ENOMEM);
>> >   1630  
>> >   1631          encap->priv = priv;
>> >   1632          encap->fib_nb.notifier_call = mlx5e_tc_tun_fib_event;
>> >   1633          spin_lock_init(&encap->route_lock);
>> >   1634          hash_init(encap->route_tbl);
>> >   1635          err = register_fib_notifier(dev_net(priv->netdev), &encap->fib_nb,
>> >   1636                                      NULL, NULL);
>> >
>> > register_fib_notifier() calls fib_net_dump() which eventually calls
>> > fib6_walk_continue() which can return 1 if "walk is incomplete (i.e.
>> > suspended)".
>> >
>> >   1637          if (err) {
>> >   1638                  kvfree(encap);
>> >   1639                  return ERR_PTR(err);
>> >
>> > If this returns 1 it will eventually lead to an Oops.
>> 
>> Hi Dan,
>> 
>> Thanks for the bug report!
>> 
>> This looks a bit strange to me because none of the other users of this
>> API handle positive error code in any special way (including reference
>> netdevsim implementation). Maybe API itself should be fixed? Jiri, Ido,
>> what do you think?
>
> The other functions that call register_fib_notifier() return an int, but
> mlx5e_tc_tun_init() returns a pointer. I think that's why it was
> flagged: "error: passing non negative 1 to ERR_PTR".

Actually, some of them do. I mentioned netdevsim specifically because
nsim_fib_create() returns pointer and also casts return value of
register_fib_notifier() with ERR_PTR.

>
> fib6_walk_continue() cannot return a positive value when called from
> register_fib_notifier(), but ignoring it means that you will keep
> getting the same static analysis error. What about:
>
> diff --git a/net/ipv6/ip6_fib.c b/net/ipv6/ip6_fib.c
> index f43e27555725..ef9d022e693f 100644
> --- a/net/ipv6/ip6_fib.c
> +++ b/net/ipv6/ip6_fib.c
> @@ -499,7 +499,7 @@ int fib6_tables_dump(struct net *net, struct notifier_block *nb,
>  
>                 hlist_for_each_entry_rcu(tb, head, tb6_hlist) {
>                         err = fib6_table_dump(net, tb, w);
> -                       if (err < 0)
> +                       if (err)
>                                 goto out;
>                 }
>         }
> @@ -507,7 +507,8 @@ int fib6_tables_dump(struct net *net, struct notifier_block *nb,
>  out:
>         kfree(w);
>  
> -       return err;
> +       /* The tree traversal function should never return a positive value. */
> +       return err > 0 ? -EINVAL : err;
>  }
>  
>  static int fib6_dump_node(struct fib6_walker *w)
>

Makes sense. You want me to send the fix or you will do it?

>> 
>> Regards,
>> Vlad
>> 
>> >
>> >   1640          }
>> >   1641  
>> >   1642          return encap;
>> >   1643  }
>> >
>> > regards,
>> > dan carpenter
>> 

