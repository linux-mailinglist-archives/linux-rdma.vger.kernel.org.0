Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A548B1E4F56
	for <lists+linux-rdma@lfdr.de>; Wed, 27 May 2020 22:32:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727843AbgE0Uc6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 27 May 2020 16:32:58 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:38791 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726129AbgE0Uc5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 27 May 2020 16:32:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590611574;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7QhDnJsT+hoeldOHYp5VzuFylA52DjRupwiUqmVYtsk=;
        b=MtN5XtW1oHvzUEAMdJqQ/uFoK85lPPyfXvJierTmOq98c0Ws/aYMGdwNQ8bE5qoeCl/jyY
        aR/Hg4skGO0XYZFI0sHLc0FBw8+hfrd8iSLQmyZ62kv/AlZmA9qwxcqtGc2LHHbQCOpopY
        YxAOLMB2Btxv8AbcLrRHXnL7PfQHdSs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-455-lIw3YW9TNreTCRwsD-4Ghw-1; Wed, 27 May 2020 16:32:50 -0400
X-MC-Unique: lIw3YW9TNreTCRwsD-4Ghw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3D8121005512;
        Wed, 27 May 2020 20:32:49 +0000 (UTC)
Received: from linux-ws.nc.xsintricity.com (unknown [10.10.110.50])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 082F51A913;
        Wed, 27 May 2020 20:32:47 +0000 (UTC)
Message-ID: <9cd656241bf31f454a72731de7509a7244353193.camel@redhat.com>
Subject: Re: [PATCH rdma-next v1] IB/ipoib: Fix double free of skb in case
 of multicast traffic in CM mode
From:   Doug Ledford <dledford@redhat.com>
To:     Leon Romanovsky <leon@kernel.org>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Valentine Fatiev <valentinef@mellanox.com>,
        Alaa Hleihel <alaa@mellanox.com>,
        Alex Vesker <valex@mellanox.com>,
        Erez Shitrit <erezsh@mellanox.com>, linux-rdma@vger.kernel.org
Date:   Wed, 27 May 2020 16:32:45 -0400
In-Reply-To: <20200527134705.480068-1-leon@kernel.org>
References: <20200527134705.480068-1-leon@kernel.org>
Organization: Red Hat, Inc.
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-1gkOOBtk52mRdbWIj2wy"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--=-1gkOOBtk52mRdbWIj2wy
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2020-05-27 at 16:47 +0300, Leon Romanovsky wrote:
> From: Valentine Fatiev <valentinef@mellanox.com>
>=20
> While connected mode set and we have connected and datagram traffic
> in parallel it might end with double free of datagram skb.
>=20
> Current mechanism assumes that the order in the completion queue is
> the
> same as the order of sent packets for all QPs. Order is kept only for
> specific QP, in case of mixed UD and CM traffic we have few QPs(one UD
> and few CM's) in parallel.
>=20
> The problem:
> ----------------------------------------------------------
>=20
> Transmit queue:
> -----------------
> UD skb pointer kept in queue itself, CM skb kept in spearate queue and
> uses transmit queue as a placeholder to count the number of total
> transmitted packets.
>=20
> 0   1   2   3   4  5  6  7  8   9  10  11 12 13 .........127
> ------------------------------------------------------------
> NL ud1 UD2 CM1 ud3 cm2 cm3 ud4 cm4 ud5 NL NL NL ...........
> ------------------------------------------------------------
>     ^                                  ^
>    tail                               head
>=20
> Completion queue (problematic scenario) - the order not the same as in
> the transmit queue:
>=20
>   1  2  3  4  5  6  7  8  9
> ------------------------------------
>  ud1 CM1 UD2 ud3 cm2 cm3 ud4 cm4 ud5
> ------------------------------------
>=20
> 1. CM1 'wc' processing
>    - skb freed in cm separate ring.
>    - tx_tail of transmit queue increased although UD2 is not freed.
>      Now driver assumes UD2 index is already freed and it could be
> used for
>      new transmitted skb.
>=20
> 0   1   2   3   4  5  6  7  8   9  10  11 12 13 .........127
> ------------------------------------------------------------
> NL NL  UD2 CM1 ud3 cm2 cm3 ud4 cm4 ud5 NL NL NL ...........
> ------------------------------------------------------------
>         ^   ^                       ^
>       (Bad)tail                    head
> (Bad - Could be used for new SKB)
>=20
> In this case (due to heavy load) UD2 skb pointer could be replaced by
> new transmitted packet UD_NEW, as the driver assumes its free.
> At this point we will have to process two 'wc' with same index but we
> have only one pointer to free.
> During second attempt to free the same skb we will have NULL pointer
> exception.
>=20
> 2. UD2 'wc' processing
>    - skb freed according the index we got from 'wc', but it was
> already
>      overwritten by mistake. So actually the skb that was released is
> the
>      skb of the new transmitted packet and not the original one.
>=20
> 3. UD_NEW 'wc' processing
>    - attempt to free already freed skb. NUll pointer exception.
>=20
> The fix:
> ----------------------------------------------------------------------
> -
> The fix is to stop using the UD ring as a placeholder for CM packets,
> the cyclic ring variables tx_head and tx_tail will manage the UD
> tx_ring,
> a new cyclic variables global_tx_head and global_tx_tail are
> introduced
> for managing and counting the overall outstanding sent packets, then
> the
> send queue will be stopped and waken based on these variables only.
>=20
> Note that no locking is needed since global_tx_head is updated in the
> xmit
> flow and global_tx_tail is updated in the NAPI flow only.
> A previous attempt tried to use one variable to count the outstanding
> sent
> packets, but it did not work since xmit and NAPI flows can run at the
> same
> time and the counter will be updated wrongly. Thus, we use the same
> simple
> cyclic head and tail scheme that we have today for the UD tx_ring.
>=20
> Fixes: 2c104ea68350 ("IB/ipoib: Get rid of the tx_outstanding variable
> in all modes")
> Signed-off-by: Valentine Fatiev <valentinef@mellanox.com>
> Signed-off-by: Alaa Hleihel <alaa@mellanox.com>
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>

This seems like a pretty important fix that should go to for-rc, not
for-next.

Regardless, looks good to me.
Acked-by: Doug Ledford <dledford@redhat.com>

> ---
> Changelog:
> v1:
>  * Alaa rewrote the patch without atomic variables
> v0:=20
> https://lore.kernel.org/linux-rdma/20200212072635.682689-5-leon@kernel.or=
g/
> ---
>  drivers/infiniband/ulp/ipoib/ipoib.h      |  4 ++++
>  drivers/infiniband/ulp/ipoib/ipoib_cm.c   | 15 +++++++++------
>  drivers/infiniband/ulp/ipoib/ipoib_ib.c   |  9 +++++++--
>  drivers/infiniband/ulp/ipoib/ipoib_main.c | 10 ++++++----
>  4 files changed, 26 insertions(+), 12 deletions(-)
>=20
> diff --git a/drivers/infiniband/ulp/ipoib/ipoib.h
> b/drivers/infiniband/ulp/ipoib/ipoib.h
> index e188a95984b5..9a3379c49541 100644
> --- a/drivers/infiniband/ulp/ipoib/ipoib.h
> +++ b/drivers/infiniband/ulp/ipoib/ipoib.h
> @@ -377,8 +377,12 @@ struct ipoib_dev_priv {
>  =09struct ipoib_rx_buf *rx_ring;
>=20
>  =09struct ipoib_tx_buf *tx_ring;
> +=09/* cyclic ring variables for managing tx_ring, for UD only */
>  =09unsigned int=09     tx_head;
>  =09unsigned int=09     tx_tail;
> +=09/* cyclic ring variables for counting overall outstanding send
> WRs */
> +=09unsigned int=09     global_tx_head;
> +=09unsigned int=09     global_tx_tail;
>  =09struct ib_sge=09     tx_sge[MAX_SKB_FRAGS + 1];
>  =09struct ib_ud_wr      tx_wr;
>  =09struct ib_wc=09     send_wc[MAX_SEND_CQE];
> diff --git a/drivers/infiniband/ulp/ipoib/ipoib_cm.c
> b/drivers/infiniband/ulp/ipoib/ipoib_cm.c
> index c59e00a0881f..9bf0fa30df28 100644
> --- a/drivers/infiniband/ulp/ipoib/ipoib_cm.c
> +++ b/drivers/infiniband/ulp/ipoib/ipoib_cm.c
> @@ -756,7 +756,8 @@ void ipoib_cm_send(struct net_device *dev, struct
> sk_buff *skb, struct ipoib_cm_
>  =09=09return;
>  =09}
>=20
> -=09if ((priv->tx_head - priv->tx_tail) =3D=3D ipoib_sendq_size - 1) {
> +=09if ((priv->global_tx_head - priv->global_tx_tail) =3D=3D
> +=09    ipoib_sendq_size - 1) {
>  =09=09ipoib_dbg(priv, "TX ring 0x%x full, stopping kernel net
> queue\n",
>  =09=09=09  tx->qp->qp_num);
>  =09=09netif_stop_queue(dev);
> @@ -786,7 +787,7 @@ void ipoib_cm_send(struct net_device *dev, struct
> sk_buff *skb, struct ipoib_cm_
>  =09} else {
>  =09=09netif_trans_update(dev);
>  =09=09++tx->tx_head;
> -=09=09++priv->tx_head;
> +=09=09++priv->global_tx_head;
>  =09}
>  }
>=20
> @@ -820,10 +821,11 @@ void ipoib_cm_handle_tx_wc(struct net_device
> *dev, struct ib_wc *wc)
>  =09netif_tx_lock(dev);
>=20
>  =09++tx->tx_tail;
> -=09++priv->tx_tail;
> +=09++priv->global_tx_tail;
>=20
>  =09if (unlikely(netif_queue_stopped(dev) &&
> -=09=09     (priv->tx_head - priv->tx_tail) <=3D ipoib_sendq_size
> >> 1 &&
> +=09=09     ((priv->global_tx_head - priv->global_tx_tail) <=3D
> +=09=09      ipoib_sendq_size >> 1) &&
>  =09=09     test_bit(IPOIB_FLAG_ADMIN_UP, &priv->flags)))
>  =09=09netif_wake_queue(dev);
>=20
> @@ -1232,8 +1234,9 @@ static void ipoib_cm_tx_destroy(struct
> ipoib_cm_tx *p)
>  =09=09dev_kfree_skb_any(tx_req->skb);
>  =09=09netif_tx_lock_bh(p->dev);
>  =09=09++p->tx_tail;
> -=09=09++priv->tx_tail;
> -=09=09if (unlikely(priv->tx_head - priv->tx_tail =3D=3D
> ipoib_sendq_size >> 1) &&
> +=09=09++priv->global_tx_tail;
> +=09=09if (unlikely((priv->global_tx_head - priv-
> >global_tx_tail) <=3D
> +=09=09=09     ipoib_sendq_size >> 1) &&
>  =09=09    netif_queue_stopped(p->dev) &&
>  =09=09    test_bit(IPOIB_FLAG_ADMIN_UP, &priv->flags))
>  =09=09=09netif_wake_queue(p->dev);
> diff --git a/drivers/infiniband/ulp/ipoib/ipoib_ib.c
> b/drivers/infiniband/ulp/ipoib/ipoib_ib.c
> index c332b4761816..da3c5315bbb5 100644
> --- a/drivers/infiniband/ulp/ipoib/ipoib_ib.c
> +++ b/drivers/infiniband/ulp/ipoib/ipoib_ib.c
> @@ -407,9 +407,11 @@ static void ipoib_ib_handle_tx_wc(struct
> net_device *dev, struct ib_wc *wc)
>  =09dev_kfree_skb_any(tx_req->skb);
>=20
>  =09++priv->tx_tail;
> +=09++priv->global_tx_tail;
>=20
>  =09if (unlikely(netif_queue_stopped(dev) &&
> -=09=09     ((priv->tx_head - priv->tx_tail) <=3D
> ipoib_sendq_size >> 1) &&
> +=09=09     ((priv->global_tx_head - priv->global_tx_tail) <=3D
> +=09=09      ipoib_sendq_size >> 1) &&
>  =09=09     test_bit(IPOIB_FLAG_ADMIN_UP, &priv->flags)))
>  =09=09netif_wake_queue(dev);
>=20
> @@ -634,7 +636,8 @@ int ipoib_send(struct net_device *dev, struct
> sk_buff *skb,
>  =09else
>  =09=09priv->tx_wr.wr.send_flags &=3D ~IB_SEND_IP_CSUM;
>  =09/* increase the tx_head after send success, but use it for queue
> state */
> -=09if (priv->tx_head - priv->tx_tail =3D=3D ipoib_sendq_size - 1) {
> +=09if ((priv->global_tx_head - priv->global_tx_tail) =3D=3D
> +=09    ipoib_sendq_size - 1) {
>  =09=09ipoib_dbg(priv, "TX ring full, stopping kernel net
> queue\n");
>  =09=09netif_stop_queue(dev);
>  =09}
> @@ -662,6 +665,7 @@ int ipoib_send(struct net_device *dev, struct
> sk_buff *skb,
>=20
>  =09=09rc =3D priv->tx_head;
>  =09=09++priv->tx_head;
> +=09=09++priv->global_tx_head;
>  =09}
>  =09return rc;
>  }
> @@ -807,6 +811,7 @@ int ipoib_ib_dev_stop_default(struct net_device
> *dev)
>  =09=09=09=09ipoib_dma_unmap_tx(priv, tx_req);
>  =09=09=09=09dev_kfree_skb_any(tx_req->skb);
>  =09=09=09=09++priv->tx_tail;
> +=09=09=09=09++priv->global_tx_tail;
>  =09=09=09}
>=20
>  =09=09=09for (i =3D 0; i < ipoib_recvq_size; ++i) {
> diff --git a/drivers/infiniband/ulp/ipoib/ipoib_main.c
> b/drivers/infiniband/ulp/ipoib/ipoib_main.c
> index d12e5c9c38af..3cfb682b91b0 100644
> --- a/drivers/infiniband/ulp/ipoib/ipoib_main.c
> +++ b/drivers/infiniband/ulp/ipoib/ipoib_main.c
> @@ -1183,9 +1183,11 @@ static void ipoib_timeout(struct net_device
> *dev, unsigned int txqueue)
>=20
>  =09ipoib_warn(priv, "transmit timeout: latency %d msecs\n",
>  =09=09   jiffies_to_msecs(jiffies - dev_trans_start(dev)));
> -=09ipoib_warn(priv, "queue stopped %d, tx_head %u, tx_tail %u\n",
> -=09=09   netif_queue_stopped(dev),
> -=09=09   priv->tx_head, priv->tx_tail);
> +=09ipoib_warn(priv,
> +=09=09   "queue stopped %d, tx_head %u, tx_tail %u,
> global_tx_head %u, global_tx_tail %u\n",
> +=09=09   netif_queue_stopped(dev), priv->tx_head, priv-
> >tx_tail,
> +=09=09   priv->global_tx_head, priv->global_tx_tail);
> +
>  =09/* XXX reset QP, etc. */
>  }
>=20
> @@ -1700,7 +1702,7 @@ static int ipoib_dev_init_default(struct
> net_device *dev)
>  =09=09goto out_rx_ring_cleanup;
>  =09}
>=20
> -=09/* priv->tx_head, tx_tail & tx_outstanding are already 0 */
> +=09/* priv->tx_head, tx_tail and global_tx_tail/head are already 0
> */
>=20
>  =09if (ipoib_transport_dev_init(dev, priv->ca)) {
>  =09=09pr_warn("%s: ipoib_transport_dev_init failed\n",
> --
> 2.26.2
>=20

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

--=-1gkOOBtk52mRdbWIj2wy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAl7Ozm0ACgkQuCajMw5X
L923lQ/+IeTMS3LCOvh6YPTv8a2CEKoj8rL0q66hmkzqzn4joQM/Obo3Rgkkjakr
1AAu/vMYMZHpvUSeqrHdGdqDH6x08blTk2gyK+Dm4O5SlBKZOkWT8zLqHgq7hD/+
t1drdlX74zsh+ZD/EM+f7A+BDre4FHhx96HyeQ5Ba1DkdXOBO2dIo+MkvLa9Az/f
0SEM45RjKvMdpUqLtIMcg3ZxHoN1aj4XP1PhZR4xSQDmao21rmK67xFhRsU8GCzy
wsLZbR6IFo209WdQt7Noeu9f3pGqjrjVsxXQoa4QrxhUi8+Kj6tzZ4xKFbvQb0qb
kBiBpVE6tZYW8LKOgpKFJ+MbJzcmTPqnLe8oP3O6pZ5vMYMD0Pd/hwIqSw9+EIuC
+o6Zc8RRIkMsejIXqjqqmE+lx/+ygJJ6tIb4zS21Na3aUAnQBl9W+xXAmbgWlqvk
E8ugLTzM6oPgFmg2fwodaiOMDhtRrX68PFVyb7cgtSUv3iiFDeYDOaBoWo/7f4EE
yS+/D2lCK5Pc91tD4aFEJki3k3PLXRBKyYF7PJz6uLEIbzuot9pRGYqcX1F+bVB0
OMXOC8a4fR/Oe/OovAHsRvDNPVbQSfMQVL5Y+6s6Ewg3ow/2Nog9NPLa1wtv7gZI
owh78sAtmhykEhDoiqO8dDv2VgkQOzw4u5PrZw2fkMkI8qHbiGk=
=kkzq
-----END PGP SIGNATURE-----

--=-1gkOOBtk52mRdbWIj2wy--

