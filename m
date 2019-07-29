Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8BBC792FE
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Jul 2019 20:26:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387700AbfG2S0F (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 29 Jul 2019 14:26:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52436 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387396AbfG2S0E (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 29 Jul 2019 14:26:04 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7F17A8552A;
        Mon, 29 Jul 2019 18:26:04 +0000 (UTC)
Received: from linux-ws.nc.xsintricity.com (ovpn-112-50.rdu2.redhat.com [10.10.112.50])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 71BBC5C1A1;
        Mon, 29 Jul 2019 18:26:03 +0000 (UTC)
Message-ID: <6c57b3c1ba1f906b089358ecc8cd3e7151c36b9b.camel@redhat.com>
Subject: Re: [PATCH for-next v2] RDMA/efa: Expose device statistics
From:   Doug Ledford <dledford@redhat.com>
To:     Gal Pressman <galpress@amazon.com>, Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-rdma@vger.kernel.org, Firas JahJah <firasj@amazon.com>,
        Yossi Leybovich <sleybo@amazon.com>
Date:   Mon, 29 Jul 2019 14:26:00 -0400
In-Reply-To: <20190725130353.11544-1-galpress@amazon.com>
References: <20190725130353.11544-1-galpress@amazon.com>
Organization: Red Hat, Inc.
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-qG+2WnCtspfrHHwZAh7Z"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Mon, 29 Jul 2019 18:26:04 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


--=-qG+2WnCtspfrHHwZAh7Z
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2019-07-25 at 16:03 +0300, Gal Pressman wrote:
> Expose hardware statistics through the sysfs api:
> /sys/class/infiniband/efa_0/hw_counters/*.
> /sys/class/infiniband/efa_0/ports/1/hw_counters/*.
>=20
> Reviewed-by: Firas JahJah <firasj@amazon.com>
> Reviewed-by: Yossi Leybovich <sleybo@amazon.com>
> Signed-off-by: Gal Pressman <galpress@amazon.com>
> ---
> This patch should be merged after:
> https://patchwork.kernel.org/patch/11053949/
>=20
> To prevent null dereference.

I merged the current for-rc into for-next and then took this to for-
next.  Thanks.

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

--=-qG+2WnCtspfrHHwZAh7Z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAl0/OjkACgkQuCajMw5X
L93T8Q/+JEWjcB9PmUjC2a4J5mK1gEmOron8/ycG83aWDJMZ7UkmUKB4wDNtZim8
yW2hahropsxavEQ6xqnuFKdjbVCUaultmPPZ/AXdzSOU5wdFerVeGqMwd0zR+Tmu
cwtNHLCwYDpJRZedyJVvIuyN768V0MnH+6ZFpxk2lXuGrchsxxLdb8kzdMMEyJQw
LDodqNDPHB795fMqOipzUTczEcWvxGjNtPfiKvPV2ObvHzBOR8lQUCHbxjg/eyFe
lPo/lD8zG9iX2kecgK54bYp6GkP95N3rrn4xINfra+myC0RI8RW4oiTX13cT/nFW
6XsWFhkNAc2mdyW3z82YPWxQ1xWd8InMDjNTeePzTaE7RfuqdGx/zrwLXaJ9CQuX
suSQYF4Zutgoj4DVox7LImO1r2Le9lWCvTdm7vEvosZ96jYHPcwdZI8ac52gNIlI
gM0Yek17h/rHf32fzqKb6VFJqaVR025HDnUkt9lI4g7afjsM9brNFlW1pAYnIDwB
9LNgHaEyv36gGlN+wpzkwFiI55tcuxzV5gy6qerjE/fjs9/GUUAmej2XKOuFEEvu
H94gHfosOO6GQbkNdLbZmdjRUw6R+upqjCqXkxKP4Fof7l9KR0JcEMYBmhHsOEe2
GKUo1NRPnEoJ2ccvwdfKqCEzHbNSA9kQ3L6osKWVrTIaA7SQKQY=
=7f6Y
-----END PGP SIGNATURE-----

--=-qG+2WnCtspfrHHwZAh7Z--

