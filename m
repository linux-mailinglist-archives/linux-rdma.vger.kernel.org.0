Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB04E1645D5
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Feb 2020 14:41:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbgBSNl1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 19 Feb 2020 08:41:27 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:33614 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726548AbgBSNl1 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 19 Feb 2020 08:41:27 -0500
Received: by mail-qt1-f196.google.com with SMTP id d5so203146qto.0
        for <linux-rdma@vger.kernel.org>; Wed, 19 Feb 2020 05:41:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dev-mellanox-co-il.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TrR0V3dqwCqbXVPPSssLCUWAQ/Kgx56wm361iNxogrg=;
        b=j/5dWNtmq6dz2M1ZA/UmLoDF+Mht/++oeWPxTtbiOjZpNIdNPDoZxklpaGRksK14vG
         qPeFRZTLPuYwlE79MoNR77qQliY0R1tIKG48uMXJXbBB+PzgKIAhv2Du44Mnq1YDwmbs
         uVB1A9ea/x13vpsxWnjLiJRLa3tYxqeUSeF6kXMdFoHs+IOwywJK9cfADOwNSaZEkd1D
         WvWM5xhpQ4XRRa6pHlRwGa/SUjNHJq2C4lXLOm1gakn13RmbPO1lx7C+vLrZDi5h3YF0
         yeAjZKech/TuQWCJyE76Ppat333NtIm4hNj3Py9NFkNLWO+/5riIgL5FF8IEAS0Xrh2/
         xVGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TrR0V3dqwCqbXVPPSssLCUWAQ/Kgx56wm361iNxogrg=;
        b=bHTwLiswe+rFDcmsHeqfRwfk2zs+tp3V16wL1wxPokVOHr+EQ4W7KWabbw0/kbGqQE
         kYJx8/taEr7MCl/aKlAHWU4q6mYMk6nJjNf1DzPt36knfw255HnI6R5k3JbUSLHM8+Jp
         LV5t0x+vxL3aiYfka+qwpSzm0EOjyCa202pmBGSq4eISkYJmUvfU/QnRkgG5T0FGMYb4
         4YoKpUDJb9SATHsJRNWuPzrUJm+0VLkh3USBeUt61FAkmYJh+f+I37oaN34rlFyoZCH7
         Yr5vDer8BPcoo1l3DdswIZxzlilItUTN0ogoPpuVRafwlLyticIugJdDUz6iP4UuRPIs
         oy7A==
X-Gm-Message-State: APjAAAV8Ol2CAGm5tcGFL3ThK2YXPP4rzSWdtPnYmpMZAfv8z2fbGo2Z
        tMSUkrOfRE+JCkarps2PYEh20SbRjfaB5SoiX03etw==
X-Google-Smtp-Source: APXvYqzOEFFaLFNFvWMcHT5nnjH/CJVeNR9mVHmDGs4WRQ3kYjmMU+V+6JbBEypmVfvcTCr5nGoAmL0IGuJx63Cf5ZE=
X-Received: by 2002:ac8:3fa9:: with SMTP id d38mr20773970qtk.333.1582119686392;
 Wed, 19 Feb 2020 05:41:26 -0800 (PST)
MIME-Version: 1.0
References: <20200210131223.87776.21339.stgit@awfm-01.aw.intel.com> <20200210131944.87776.64386.stgit@awfm-01.aw.intel.com>
In-Reply-To: <20200210131944.87776.64386.stgit@awfm-01.aw.intel.com>
From:   Erez Shitrit <erezsh@dev.mellanox.co.il>
Date:   Wed, 19 Feb 2020 15:41:15 +0200
Message-ID: <CAAk-MO91iV9GDZChWCKjMAmv553EDGfSdr9B8aFw1f4yncx-Wg@mail.gmail.com>
Subject: Re: [PATCH for-next 13/16] IB/{hfi1, ipoib, rdma}: Broadcast ping
 sent packets which exceeded mtu size
To:     Dennis Dalessandro <dennis.dalessandro@intel.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Doug Ledford <dledford@redhat.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Dennis Dalessandro <dennis.alessandro@intel.com>,
        Gary Leshner <Gary.S.Leshner@intel.com>,
        Kaike Wan <kaike.wan@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Feb 10, 2020 at 3:19 PM Dennis Dalessandro
<dennis.dalessandro@intel.com> wrote:
>
> From: Gary Leshner <Gary.S.Leshner@intel.com>
>
> When in connected mode ipoib sent broadcast pings which exceeded the mtu
> size for broadcast addresses.

But this broadcast done via the UD QP and not via the connected mode,
please explain

>
> Add an mtu attribute to the rdma_netdev structure which ipoib sets to its
> mcast mtu size.
>
> The RDMA netdev uses this value to determine if the skb length is too long
> for the mtu specified and if it is, drops the packet and logs an error
> about the errant packet.
>
> Reviewed-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
> Reviewed-by: Dennis Dalessandro <dennis.alessandro@intel.com>
> Signed-off-by: Gary Leshner <Gary.S.Leshner@intel.com>
> Signed-off-by: Kaike Wan <kaike.wan@intel.com>
> Signed-off-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
> ---
>  drivers/infiniband/ulp/ipoib/ipoib_main.c      |    2 ++
>  drivers/infiniband/ulp/ipoib/ipoib_multicast.c |    1 +
>  drivers/infiniband/ulp/ipoib/ipoib_vlan.c      |    3 +++
>  3 files changed, 6 insertions(+)
>
> diff --git a/drivers/infiniband/ulp/ipoib/ipoib_main.c b/drivers/infiniband/ulp/ipoib/ipoib_main.c
> index 5c1cf68..ddb896f 100644
> --- a/drivers/infiniband/ulp/ipoib/ipoib_main.c
> +++ b/drivers/infiniband/ulp/ipoib/ipoib_main.c
> @@ -1906,6 +1906,7 @@ static int ipoib_ndo_init(struct net_device *ndev)
>  {
>         struct ipoib_dev_priv *priv = ipoib_priv(ndev);
>         int rc;
> +       struct rdma_netdev *rn = netdev_priv(ndev);
>
>         if (priv->parent) {
>                 ipoib_child_init(ndev);
> @@ -1918,6 +1919,7 @@ static int ipoib_ndo_init(struct net_device *ndev)
>         /* MTU will be reset when mcast join happens */
>         ndev->mtu = IPOIB_UD_MTU(priv->max_ib_mtu);
>         priv->mcast_mtu = priv->admin_mtu = ndev->mtu;
> +       rn->mtu = priv->mcast_mtu;

If this is something specific for your lower driver (opa_vnic etc.)
you don't need to do that here, you can use the rn->clnt_priv member
in order to get the mcast_mtu

>         ndev->max_mtu = IPOIB_CM_MTU;
>
>         ndev->neigh_priv_len = sizeof(struct ipoib_neigh);
> diff --git a/drivers/infiniband/ulp/ipoib/ipoib_multicast.c b/drivers/infiniband/ulp/ipoib/ipoib_multicast.c
> index 7166ee9b..3d5f6b8 100644
> --- a/drivers/infiniband/ulp/ipoib/ipoib_multicast.c
> +++ b/drivers/infiniband/ulp/ipoib/ipoib_multicast.c
> @@ -246,6 +246,7 @@ static int ipoib_mcast_join_finish(struct ipoib_mcast *mcast,
>                 if (priv->mcast_mtu == priv->admin_mtu)
>                         priv->admin_mtu = IPOIB_UD_MTU(mtu);
>                 priv->mcast_mtu = IPOIB_UD_MTU(mtu);
> +               rn->mtu = priv->mcast_mtu;
>
>                 priv->qkey = be32_to_cpu(priv->broadcast->mcmember.qkey);
>                 spin_unlock_irq(&priv->lock);
> diff --git a/drivers/infiniband/ulp/ipoib/ipoib_vlan.c b/drivers/infiniband/ulp/ipoib/ipoib_vlan.c
> index 8ac8e18..3086560 100644
> --- a/drivers/infiniband/ulp/ipoib/ipoib_vlan.c
> +++ b/drivers/infiniband/ulp/ipoib/ipoib_vlan.c
> @@ -97,6 +97,7 @@ int __ipoib_vlan_add(struct ipoib_dev_priv *ppriv, struct ipoib_dev_priv *priv,
>  {
>         struct net_device *ndev = priv->dev;
>         int result;
> +       struct rdma_netdev *rn = netdev_priv(ndev);
>
>         ASSERT_RTNL();
>
> @@ -117,6 +118,8 @@ int __ipoib_vlan_add(struct ipoib_dev_priv *ppriv, struct ipoib_dev_priv *priv,
>                 goto out_early;
>         }
>
> +       rn->mtu = priv->mcast_mtu;
> +
>         priv->parent = ppriv->dev;
>         priv->pkey = pkey;
>         priv->child_type = type;
>
