Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 732903167F0
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Feb 2021 14:23:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbhBJNW7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 10 Feb 2021 08:22:59 -0500
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:47273 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231891AbhBJNWt (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 10 Feb 2021 08:22:49 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id CD8B0B4F;
        Wed, 10 Feb 2021 08:21:41 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Wed, 10 Feb 2021 08:21:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=ub8+UE
        xvxBQbhQrB+eSohRzu8xeKloYPdYsNqPie1q0=; b=Szu3hkzFlwrrNaNXnO4u5+
        j8Wv0mIrLV8NKJihMfmpib9Aw5Ualjog6HDQy5b+N7trBUrDcOTk0mFTd4omrSHw
        d4Qr0Z6Jzo83yhOjr9rB1vF8aJF3Bg0aG7ITCoCJ98iV7Kr8GRDsXB4i6MXB/dpD
        rW0LClNgS75ZUdrilco5uC9IfNVlnrtLYryN57DKZV2qSfv6QNfQnEcHC1YHvpQS
        nzKz0nLO9lSk+R4hKweQ8EjuCG4GSTj4qJh+Wluth5SZ8+LvnUtFnWhXnf76Ttm9
        kB6+HF5HTDlVvvS0ATsnZlOqO8MsKtyZ9jTdjetfrAVjjTTDzCHFTyJGf5queiUw
        ==
X-ME-Sender: <xms:5N0jYCgihA4tTRLY8FeTLo5eCFCV0Wa_kENyJNpFusQ6IhBZNJdJsA>
    <xme:5N0jYFDm9I286ylmbkRgbYT9OaqyRXI3WIw-lntW7ztQJwUAOiTBbdvz0KCOAlfj7
    imDFWv53PkxgUo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrheejgdehtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepkfguohcuufgt
    hhhimhhmvghluceoihguohhstghhsehiughoshgthhdrohhrgheqnecuggftrfgrthhtvg
    hrnheptdffkeekfeduffevgeeujeffjefhtefgueeugfevtdeiheduueeukefhudehleet
    necukfhppeekgedrvddvledrudehfedrgeegnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepihguohhstghhsehiughoshgthhdrohhrgh
X-ME-Proxy: <xmx:5N0jYDdxZ5Jn9IqWpct6obkYof7b9iH8blC1Yf51a-Pr1Z1Lyku2hg>
    <xmx:5N0jYNeTm_e3zTQwjdrPK7dWawOp7xWMW-BuHXAexMWlM_PlFlmn1Q>
    <xmx:5N0jYHgJ8LHfbKOQv5ba6udtVUvbcRViATIjqLlWK1Bky2qmXQ8aUQ>
    <xmx:5d0jYOrePoYyDI4zTn-zDTUUZi1DW9eZV9Dn8JYqCCh86unfk9Oz1g>
Received: from localhost (igld-84-229-153-44.inter.net.il [84.229.153.44])
        by mail.messagingengine.com (Postfix) with ESMTPA id 793F5108005C;
        Wed, 10 Feb 2021 08:21:40 -0500 (EST)
Date:   Wed, 10 Feb 2021 15:21:37 +0200
From:   Ido Schimmel <idosch@idosch.org>
To:     Vlad Buslov <vladbu@nvidia.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>, jiri@resnulli.us,
        linux-rdma@vger.kernel.org
Subject: Re: [bug report] net/mlx5e: Handle FIB events to update tunnel
 endpoint device
Message-ID: <20210210132137.GA296697@shredder.lan>
References: <YCO+nR+3Zs9jIAfp@mwanda>
 <ygnha6scgms4.fsf@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ygnha6scgms4.fsf@nvidia.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Feb 10, 2021 at 01:55:23PM +0200, Vlad Buslov wrote:
> On Wed 10 Feb 2021 at 13:08, Dan Carpenter <dan.carpenter@oracle.com> wrote:
> > Hello Vlad Buslov,
> >
> > The patch 8914add2c9e5: "net/mlx5e: Handle FIB events to update
> > tunnel endpoint device" from Jan 25, 2021, leads to the following
> > static checker warning:
> >
> > 	drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun_encap.c:1639 mlx5e_tc_tun_init()
> > 	error: passing non negative 1 to ERR_PTR
> >
> > drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun_encap.c
> >   1622  struct mlx5e_tc_tun_encap *mlx5e_tc_tun_init(struct mlx5e_priv *priv)
> >   1623  {
> >   1624          struct mlx5e_tc_tun_encap *encap;
> >   1625          int err;
> >   1626  
> >   1627          encap = kvzalloc(sizeof(*encap), GFP_KERNEL);
> >   1628          if (!encap)
> >   1629                  return ERR_PTR(-ENOMEM);
> >   1630  
> >   1631          encap->priv = priv;
> >   1632          encap->fib_nb.notifier_call = mlx5e_tc_tun_fib_event;
> >   1633          spin_lock_init(&encap->route_lock);
> >   1634          hash_init(encap->route_tbl);
> >   1635          err = register_fib_notifier(dev_net(priv->netdev), &encap->fib_nb,
> >   1636                                      NULL, NULL);
> >
> > register_fib_notifier() calls fib_net_dump() which eventually calls
> > fib6_walk_continue() which can return 1 if "walk is incomplete (i.e.
> > suspended)".
> >
> >   1637          if (err) {
> >   1638                  kvfree(encap);
> >   1639                  return ERR_PTR(err);
> >
> > If this returns 1 it will eventually lead to an Oops.
> 
> Hi Dan,
> 
> Thanks for the bug report!
> 
> This looks a bit strange to me because none of the other users of this
> API handle positive error code in any special way (including reference
> netdevsim implementation). Maybe API itself should be fixed? Jiri, Ido,
> what do you think?

The other functions that call register_fib_notifier() return an int, but
mlx5e_tc_tun_init() returns a pointer. I think that's why it was
flagged: "error: passing non negative 1 to ERR_PTR".

fib6_walk_continue() cannot return a positive value when called from
register_fib_notifier(), but ignoring it means that you will keep
getting the same static analysis error. What about:

diff --git a/net/ipv6/ip6_fib.c b/net/ipv6/ip6_fib.c
index f43e27555725..ef9d022e693f 100644
--- a/net/ipv6/ip6_fib.c
+++ b/net/ipv6/ip6_fib.c
@@ -499,7 +499,7 @@ int fib6_tables_dump(struct net *net, struct notifier_block *nb,
 
                hlist_for_each_entry_rcu(tb, head, tb6_hlist) {
                        err = fib6_table_dump(net, tb, w);
-                       if (err < 0)
+                       if (err)
                                goto out;
                }
        }
@@ -507,7 +507,8 @@ int fib6_tables_dump(struct net *net, struct notifier_block *nb,
 out:
        kfree(w);
 
-       return err;
+       /* The tree traversal function should never return a positive value. */
+       return err > 0 ? -EINVAL : err;
 }
 
 static int fib6_dump_node(struct fib6_walker *w)

> 
> Regards,
> Vlad
> 
> >
> >   1640          }
> >   1641  
> >   1642          return encap;
> >   1643  }
> >
> > regards,
> > dan carpenter
> 
