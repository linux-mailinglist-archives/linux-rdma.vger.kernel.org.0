Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B3FD3165CE
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Feb 2021 12:58:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbhBJL6U (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 10 Feb 2021 06:58:20 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:7868 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230294AbhBJL4R (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 10 Feb 2021 06:56:17 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B6023c9af0000>; Wed, 10 Feb 2021 03:55:27 -0800
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 10 Feb
 2021 11:55:27 +0000
Received: from reg-r-vrt-018-180.nvidia.com (172.20.145.6) by
 DRHQMAIL107.nvidia.com (10.27.9.16) with Microsoft SMTP Server (TLS) id
 15.0.1473.3; Wed, 10 Feb 2021 11:55:25 +0000
References: <YCO+nR+3Zs9jIAfp@mwanda>
User-agent: mu4e 1.4.10; emacs 27.1
From:   Vlad Buslov <vladbu@nvidia.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>, <jiri@resnulli.us>,
        "idosch@idosch.org" <idosch@idosch.org>
CC:     <linux-rdma@vger.kernel.org>
Subject: Re: [bug report] net/mlx5e: Handle FIB events to update tunnel
 endpoint device
In-Reply-To: <YCO+nR+3Zs9jIAfp@mwanda>
Date:   Wed, 10 Feb 2021 13:55:23 +0200
Message-ID: <ygnha6scgms4.fsf@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1612958127; bh=3raFW0rsRTyybCMA7smN+krzWvXmRtbZqQzJFdQ7o+U=;
        h=References:User-agent:From:To:CC:Subject:In-Reply-To:Date:
         Message-ID:MIME-Version:Content-Type:X-Originating-IP:
         X-ClientProxiedBy;
        b=DDxICqVkH1o1mn7o61c3cg2JXjRa2YFxuHG5O4LPrN8s3oxkIGBhzsUaRt7FDATpJ
         9re2bJoEjzT2wpkLedWGd75smzijnBHnb/NDp5pjW79pc3JYxp49HjdzgEtPFMQIRX
         0I5Sc5wm8t0g8ge9lcxdhAucSAn7O3reS7HEKVMJUPM3jF7rOhWLSGcfjKeESsGbaL
         u+RSYcWHJAII3yuYfl69Fqh5Fx9f72x/Bx9x74wrxyL/VY9P6th5iFkBowSOOfOYvN
         kikNtfjM17gt005JFMrGTbSL1BCk+BglLwSIVa4Ib8rjbrLuNjATteNL6GmiPEoSoj
         E81FOE+aMERlw==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed 10 Feb 2021 at 13:08, Dan Carpenter <dan.carpenter@oracle.com> wrote:
> Hello Vlad Buslov,
>
> The patch 8914add2c9e5: "net/mlx5e: Handle FIB events to update
> tunnel endpoint device" from Jan 25, 2021, leads to the following
> static checker warning:
>
> 	drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun_encap.c:1639 mlx5e_tc_tun_init()
> 	error: passing non negative 1 to ERR_PTR
>
> drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun_encap.c
>   1622  struct mlx5e_tc_tun_encap *mlx5e_tc_tun_init(struct mlx5e_priv *priv)
>   1623  {
>   1624          struct mlx5e_tc_tun_encap *encap;
>   1625          int err;
>   1626  
>   1627          encap = kvzalloc(sizeof(*encap), GFP_KERNEL);
>   1628          if (!encap)
>   1629                  return ERR_PTR(-ENOMEM);
>   1630  
>   1631          encap->priv = priv;
>   1632          encap->fib_nb.notifier_call = mlx5e_tc_tun_fib_event;
>   1633          spin_lock_init(&encap->route_lock);
>   1634          hash_init(encap->route_tbl);
>   1635          err = register_fib_notifier(dev_net(priv->netdev), &encap->fib_nb,
>   1636                                      NULL, NULL);
>
> register_fib_notifier() calls fib_net_dump() which eventually calls
> fib6_walk_continue() which can return 1 if "walk is incomplete (i.e.
> suspended)".
>
>   1637          if (err) {
>   1638                  kvfree(encap);
>   1639                  return ERR_PTR(err);
>
> If this returns 1 it will eventually lead to an Oops.

Hi Dan,

Thanks for the bug report!

This looks a bit strange to me because none of the other users of this
API handle positive error code in any special way (including reference
netdevsim implementation). Maybe API itself should be fixed? Jiri, Ido,
what do you think?

Regards,
Vlad

>
>   1640          }
>   1641  
>   1642          return encap;
>   1643  }
>
> regards,
> dan carpenter

