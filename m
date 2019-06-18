Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 833B64AC69
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Jun 2019 22:58:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730176AbfFRU6U (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Jun 2019 16:58:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32842 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730102AbfFRU6U (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 18 Jun 2019 16:58:20 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4B1D230001D8;
        Tue, 18 Jun 2019 20:58:20 +0000 (UTC)
Received: from linux-ws.nc.xsintricity.com (ovpn-112-50.rdu2.redhat.com [10.10.112.50])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9A05360922;
        Tue, 18 Jun 2019 20:58:19 +0000 (UTC)
Message-ID: <1ec72297f837bf95fadaf846b7fe39a7b24de23c.camel@redhat.com>
Subject: Re: [PATCH v2 2/3] RDMA: Add NLDEV_GET_CHARDEV to allow char dev
 discovery and autoload
From:   Doug Ledford <dledford@redhat.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
Cc:     linux-rdma@vger.kernel.org
Date:   Tue, 18 Jun 2019 16:58:16 -0400
In-Reply-To: <20190618184653.GM6961@ziepe.ca>
References: <20190614003819.19974-1-jgg@ziepe.ca>
         <20190614003819.19974-3-jgg@ziepe.ca>
         <20190618121709.GK4690@mtr-leonro.mtl.com> <20190618131019.GE6961@ziepe.ca>
         <97a95f7e5447b0ddf4dee15c536d72bd9fb65780.camel@redhat.com>
         <20190618165338.GO4690@mtr-leonro.mtl.com> <20190618184653.GM6961@ziepe.ca>
Organization: Red Hat, Inc.
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-GDQujJAflBoYPY2tB3z+"
User-Agent: Evolution 3.32.2 (3.32.2-1.fc30) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Tue, 18 Jun 2019 20:58:20 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


--=-GDQujJAflBoYPY2tB3z+
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2019-06-18 at 15:46 -0300, Jason Gunthorpe wrote:
> On Tue, Jun 18, 2019 at 07:53:38PM +0300, Leon Romanovsky wrote:
> >=20
> > I have a very strong opinion about it.
>=20
> Then Doug should add the policies, here are the output values from the
> userspace:
>=20
>         [RDMA_NLDEV_ATTR_CHARDEV] =3D { .type =3D NLA_U64 },
>         [RDMA_NLDEV_ATTR_CHARDEV_ABI] =3D { .type =3D NLA_U64 },
>         [RDMA_NLDEV_ATTR_DEV_INDEX] =3D { .type =3D NLA_U32 },
>         [RDMA_NLDEV_ATTR_DEV_NODE_TYPE] =3D { .type =3D NLA_U8 },
>         [RDMA_NLDEV_ATTR_NODE_GUID] =3D { .type =3D NLA_U64 },
>         [RDMA_NLDEV_ATTR_UVERBS_DRIVER_ID] =3D { .type =3D NLA_U32 },
>         [RDMA_NLDEV_ATTR_CHARDEV_NAME] =3D { .type =3D NLA_NUL_STRING },
>         [RDMA_NLDEV_ATTR_DEV_NAME] =3D { .type =3D NLA_NUL_STRING },
>         [RDMA_NLDEV_ATTR_DEV_PROTOCOL] =3D { .type =3D NLA_NUL_STRING },
>         [RDMA_NLDEV_ATTR_FW_VERSION] =3D { .type =3D NLA_NUL_STRING },

Most of those were already in the policies.  Only the four that you
added to enum rdma_nldev_attr needed added to the policies, and two of
them your patch already added.  The only question I had is what the
string length should be on ATTR_CHARDEV_NAME?  I throw in the default of
.len =3D RDMA_NLDEV_ATTR_ENTRY_STRLEN, but I wasn't sure if that was right
for this entry?

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

--=-GDQujJAflBoYPY2tB3z+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAl0JUGgACgkQuCajMw5X
L929XhAAphFBDTRT3xR0/Rh47quVhhZFoT7hWJ4+BRtPjhpGC1RX/+14HoLXUBfn
IM1TdmTwd0QrRaZh1XQIhYMKCW7S2EKnZiEWzy8SNpVf22wpIXPJYLoWjfrHoq/r
45m5Ue5W5C6/+nofarP52NOGTLGdLyUxzDwS5PHfIzcXBuehKQ5iC2kfFs9ndQ9d
iXVLFScx2PGS+LxOa9LYLSXpvkhTxKZwdWh59hXvkD3OA+hhClq/9c67xaalttut
CfvcL1xdeIu11kjay98JQclpszYHgX6gowcIsK3rgveq/0+5UOz6JP2csCKuYaeN
rc8zSeO97skrSVrX5loXNdgrnWQt3p1GognCOIZK4zpnDyLs7gaY8gJom6GrWexX
QyVTQfwvVk7UDFnk8VyYwdeXHE/MP748HepeuDaLFnDfjQYLmq0Vg3DcC0otZeug
lk+WwYzw2cHZICXHHhh+9dN7PZZkFbhyj/hTih2PCcoVkfSL8A84Cc2+MpFZO9iv
USTdL+88e1sdBsyB+pikmVEOBaX5M6tKvdd0HYelzVxPL2PTQUoH2t0jiIrvZXI3
o+/m89uDTi9ArBGI3JOzLYXUybHIgdu4zlq2MIIobIlIHdQcvpJiXwlN0i3A31wS
lM6JE0VhvSR7G8+HxOz/Li79+CJzsy1EFmocQiGoxlUDgaGRCYo=
=98oo
-----END PGP SIGNATURE-----

--=-GDQujJAflBoYPY2tB3z+--

