Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DCB9E79A25
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Jul 2019 22:42:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728305AbfG2Umw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 29 Jul 2019 16:42:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35782 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727086AbfG2Umw (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 29 Jul 2019 16:42:52 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1F91281F0F;
        Mon, 29 Jul 2019 20:42:52 +0000 (UTC)
Received: from linux-ws.nc.xsintricity.com (ovpn-112-50.rdu2.redhat.com [10.10.112.50])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8055B5D9C9;
        Mon, 29 Jul 2019 20:42:51 +0000 (UTC)
Message-ID: <f1e27e28a420e2123242bfbc196796ba250f15e4.camel@redhat.com>
Subject: Re: [RFC] mlx5: add parameter to disable enhanced IPoIB
From:   Doug Ledford <dledford@redhat.com>
To:     Nicolas Morey-Chaisemartin <NMoreyChaisemartin@suse.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Date:   Mon, 29 Jul 2019 16:42:48 -0400
In-Reply-To: <42703d01-0496-a4ce-6599-5115e49290af@suse.com>
References: <42703d01-0496-a4ce-6599-5115e49290af@suse.com>
Organization: Red Hat, Inc.
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-x2WMt/5qwk2h6tLr5dpa"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Mon, 29 Jul 2019 20:42:52 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


--=-x2WMt/5qwk2h6tLr5dpa
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2019-07-29 at 18:57 +0000, Nicolas Morey-Chaisemartin wrote:
> Recent ConnextX-[45] HCA have enhanced IPoIB enabled which prevents
> the use of the connected mode.
> Although not an issue in a fully compatible setup, it can be an issue
> in a mixed HW one.
>=20
> Mellanox OFED uses a ipoib_enhanced flag on the ib_ipoib module to
> work around the issue.
> This patch adds a similarly name flag to the mlx5_ib module to disable
> enhanced IPoIB for
> all mlx5 HCA and allow users to pick datagram/connected the usual way.
>=20
> Signed-off-by: Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com
> >
> ---
>  drivers/infiniband/hw/mlx5/main.c | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/drivers/infiniband/hw/mlx5/main.c
> b/drivers/infiniband/hw/mlx5/main.c
> index c2a5780cb394..779a35883494 100644
> --- a/drivers/infiniband/hw/mlx5/main.c
> +++ b/drivers/infiniband/hw/mlx5/main.c
> @@ -78,6 +78,10 @@ MODULE_AUTHOR("Eli Cohen <eli@mellanox.com>");
>  MODULE_DESCRIPTION("Mellanox Connect-IB HCA IB driver");
>  MODULE_LICENSE("Dual BSD/GPL");
> =20
> +static int ipoib_enhanced =3D 1;
> +module_param(ipoib_enhanced, int, 0444);
> +MODULE_PARM_DESC(ipoib_enhanced, "Enable IPoIB enhanced for capable
> devices (default =3D 1) (0-1)");
> +
>  static char mlx5_version[] =3D
>  	DRIVER_NAME ": Mellanox Connect-IB Infiniband driver v"
>  	DRIVER_VERSION "\n";
> @@ -6383,6 +6387,7 @@ static int mlx5_ib_stage_caps_init(struct
> mlx5_ib_dev *dev)
>  		(1ull << IB_USER_VERBS_EX_CMD_DESTROY_FLOW);
> =20
>  	if (MLX5_CAP_GEN(mdev, ipoib_enhanced_offloads) &&
> +	    ipoib_enhanced &&
>  	    IS_ENABLED(CONFIG_MLX5_CORE_IPOIB))
>  		ib_set_device_ops(&dev->ib_dev,
>  				  &mlx5_ib_dev_ipoib_enhanced_ops);

Module parameters are highly frowned upon in general, and in this
particular instance, I could easily see where if you had a dual port IB
card, with one port plugged into a fully compatible setup, and the other
port plugged into a more heterogeneous setup (say a Lustre backend or
something), that you really want this to be on a per-port basis.  So,
I'm gonna say this is a nak unless Mellanox comes back and says doing
this per-port is strictly not possible (and even if it must be per-card
or driver wide, I would still prefer maybe a netlink control to a module
option, if for no other reason than I don't want to hear the groans from
other kernel folk if I take a module option now a days).

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

--=-x2WMt/5qwk2h6tLr5dpa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAl0/WkkACgkQuCajMw5X
L93fKw//a8AgnzRrepsQyzBiPZFrChEsLT+8lEs9f7Ob3NzJEnr5MWmREPmftYD3
1X09dK+hKOPXGoIYv/VCTLWdj1q3FT6cK///9hA5pik+TlQt5upfVRiE8iTpreQF
LseEq/hMBmEsu/hpP+3mapQ1wWvd9rv2XiocQPMxYbAzM5cFOtmEPUhIOSGAZpEN
UgVOqaE2toCeASGzmZkWh56VTo/MkIB3RGNB8aLls4S10ZRUzYeTDUy+/M2tXZVS
60Tx1jotoAjBvVcuU6EyMaelTnNIDWQz/xOV42apKlb4xFI5N9ZY2QFJPfiPfGdO
OmqrR7wbjyXqAIhN3RJaJ8AfHeF3tlnIddlSJh8tRLQpb8H4Ln9PR/QewZbqAvXJ
6yXejjwKiTaqivUilmnomzfRlVuP6RzUP+P0XRcLCg0JNRnYy+v1VUxagXiVrYju
6bILor0vGXhQq0IBozPgUyczpMA9xjlG/HMZ6FR4Vqh6tI5tYW33zdEUQL0cjEK9
MCIbznk6ySdIFJYFWLP3K/5QaOUtQwf/SV1FuJOshd8YchHk7167ra8m0aadgmVN
MHNaD6d915JRw5ZfUF44DiIPcjjuTGIutAwRdJIUySnSMYNEpBRn8uwZOLh/Fbor
8ax5f5Sv/RkTiSc62bdHNRjOHXCPkAzQwAVJG+qY0uXOnJTLgXk=
=0Er9
-----END PGP SIGNATURE-----

--=-x2WMt/5qwk2h6tLr5dpa--

