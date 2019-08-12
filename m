Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80B8C8A11E
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Aug 2019 16:31:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbfHLObY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 12 Aug 2019 10:31:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41956 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726296AbfHLObX (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 12 Aug 2019 10:31:23 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6339C308FC4A;
        Mon, 12 Aug 2019 14:31:23 +0000 (UTC)
Received: from linux-ws.nc.xsintricity.com (ovpn-112-57.rdu2.redhat.com [10.10.112.57])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8D28960C18;
        Mon, 12 Aug 2019 14:31:22 +0000 (UTC)
Message-ID: <5008d1458ccbbf368ce8c2235c200798fee480cd.camel@redhat.com>
Subject: Re: [PATCH rdma-next] RDMA/mlx5: Annotate lock dependency in
 unbinding slave port
From:   Doug Ledford <dledford@redhat.com>
To:     Leon Romanovsky <leon@kernel.org>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Date:   Mon, 12 Aug 2019 10:31:19 -0400
In-Reply-To: <20190808083907.29316-1-leon@kernel.org>
References: <20190808083907.29316-1-leon@kernel.org>
Organization: Red Hat, Inc.
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-BYfon7d2GqQxdMq0gdIp"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Mon, 12 Aug 2019 14:31:23 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


--=-BYfon7d2GqQxdMq0gdIp
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2019-08-08 at 11:39 +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@mellanox.com>
>=20
> NULL-ing notifier_call is performed under protection
> of mlx5_ib_multiport_mutex lock. Such protection is
> not easily spotted and better to be guarded by lockdep
> annotation.
>=20
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> ---
> Based on -rc commit: 23eaf3b5c1a7 ("RDMA/mlx5: Release locks during
> notifier unregister")
> ---
>  drivers/infiniband/hw/mlx5/main.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/infiniband/hw/mlx5/main.c
> b/drivers/infiniband/hw/mlx5/main.c
> index 7933534be931..63969484421c 100644
> --- a/drivers/infiniband/hw/mlx5/main.c
> +++ b/drivers/infiniband/hw/mlx5/main.c
> @@ -5835,6 +5835,8 @@ static void mlx5_ib_unbind_slave_port(struct
> mlx5_ib_dev *ibdev,
>  	int err;
>  	int i;
>=20
> +	lockdep_assert_held(&mlx5_ib_multiport_mutex);
> +
>  	mlx5_ib_cleanup_cong_debugfs(ibdev, port_num);
>=20
>  	spin_lock(&port->mp.mpi_lock);
> --
> 2.20.1
>=20

Hi Leon,

This patch needed to catch both the unbind and the bind/init routine as
they both require the multiport mutex be held.  Can you respin please?

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

--=-BYfon7d2GqQxdMq0gdIp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAl1ReDgACgkQuCajMw5X
L92oxQ//Z+GPUoRoj+J3pEOt6u5SDQa1paGN0OG1/8Za2ofif2z18fDvUmj18BHp
+tvUpI/Qg5zo5xKwYtYl6hbkXe7XBLMtp9LeoThrmu1VdmSzPTam1wMA3GVxFQdk
dTKZGybcLCI5wLe+usvSZ+biJBL3RRrCM48ptDTxJH+5GNgff0aE0XhXjFjOhC+G
KnWVNlh4jr4v/QP6tmcyacPWZQwfP5TUlljkE5xkptXMBasVsIaZE7xoNWgjHHGb
yKfa6GELjFom4qCwUQfks9fftcofM189vnTWAdod4bYBZqxHYwTTJQzUIeWt62C+
uz0Umz8pFjmwJDgPZ0nBmCFMk8tE3LA1PhZb/xYQ9+/TBPE0+nGud0BHrM7htJQ1
2G+olZaVkuhlMKSvkK7U0JSG/ZCpOmNVB2RckRdPXtI8XMny/6T6HHEFGMPNZcpH
vWLxmVXpwqE8CZ7N2owL1RsFhFm8/+A8UfJST+MJ2b3hRbnOt8tDTw+S4LhTyqZ5
cHOUd4Z1sekvjnbuNYybF0mDlJ1mDiZinWyO3/f3nLssJRUrj/u9ACudMd+XLce7
NG9k1lCEgEvBl55ljdexJoYPcBsC8FjLNZkV1EqSD6uiNBXWjwmNv9GbPN09rj16
Rrk+CSs/oEg/i3uR+4K8kAfsXTSsFhBsGsl6idOOcJfi0e2M6ZY=
=LTfy
-----END PGP SIGNATURE-----

--=-BYfon7d2GqQxdMq0gdIp--

