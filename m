Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0CF024F0C3
	for <lists+linux-rdma@lfdr.de>; Sat, 22 Jun 2019 00:28:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726043AbfFUW2k (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 21 Jun 2019 18:28:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54890 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726017AbfFUW2k (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 21 Jun 2019 18:28:40 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E3037308218D;
        Fri, 21 Jun 2019 22:28:39 +0000 (UTC)
Received: from linux-ws.nc.xsintricity.com (ovpn-112-50.rdu2.redhat.com [10.10.112.50])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1002E608A7;
        Fri, 21 Jun 2019 22:28:38 +0000 (UTC)
Message-ID: <9a894290bb24d0190e2a302f9d8e934f3dff7e1b.camel@redhat.com>
Subject: Re: [PATCH v3 05/11] SIW application interface
From:   Doug Ledford <dledford@redhat.com>
To:     Bart Van Assche <bvanassche@acm.org>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        linux-rdma@vger.kernel.org
Date:   Fri, 21 Jun 2019 18:28:36 -0400
In-Reply-To: <f805a19d-256f-fa60-fc2d-dbc0939ed5cf@acm.org>
References: <20190620162133.13074-1-bmt@zurich.ibm.com>
         <20190620162133.13074-6-bmt@zurich.ibm.com>
         <f805a19d-256f-fa60-fc2d-dbc0939ed5cf@acm.org>
Organization: Red Hat, Inc.
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-gSyhWb0fu9KY3MReKxFJ"
User-Agent: Evolution 3.32.2 (3.32.2-1.fc30) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Fri, 21 Jun 2019 22:28:39 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


--=-gSyhWb0fu9KY3MReKxFJ
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2019-06-20 at 09:33 -0700, Bart Van Assche wrote:
> On 6/20/19 9:21 AM, Bernard Metzler wrote:
> > diff --git a/include/uapi/rdma/siw-abi.h b/include/uapi/rdma/siw-
> > abi.h
> > new file mode 100644
> > index 000000000000..3dd8071ace7b
> > --- /dev/null
> > +++ b/include/uapi/rdma/siw-abi.h
> > @@ -0,0 +1,185 @@
> > +/* SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause */
> > +
> > +/* Authors: Bernard Metzler <bmt@zurich.ibm.com> */
> > +/* Copyright (c) 2008-2019, IBM Corporation */
> > +
> > +#ifndef _SIW_USER_H
> > +#define _SIW_USER_H
> > +
> > +#include <linux/types.h>
> > +
> > +#define SIW_NODE_DESC_COMMON "Software iWARP stack"
>=20
> How can the definition of a string like this be useful in an UAPI
> header
> file? If user space code doesn't need this string please move this
> definition away from include/uapi.
>=20
> > +#define SIW_ABI_VERSION 1
>=20
> Same question here: how can this definition be useful in an UAPI
> header
> file? As you know Linux user space APIs must be backwards compatible.

I moved both of these to sw/siw/siw.h instead of the uapi header.

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

--=-gSyhWb0fu9KY3MReKxFJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAl0NWhQACgkQuCajMw5X
L91GgA/9FPHR8aVmbeUyGqZccPXZ7DzU18OYvo8lBlj//3Y8WeCPmuSmwtu8/T6w
4gbbZjUuRbKZGMPNw/aaoCgTjuC6sYZHE7b5rt7tYZmHqWX1r8HMVdHK7ecwpDBs
bCKC8dhf2C22UCUeVKfj+imVmkx/4EOZ60MBQ9AJ6Y4b1AQKuCaVLs7VmwInZ20s
Jti+JeWzivGCGVibNBtfHeOa6z5dI7WNPk+mj3eBGJRB2q6CPzOD8Ame6iilxkIS
C1jWqliC1Ig+IFY7cZRXC+hfueUZ5IBwxtpcip/nl5E0rgtqFGdBvjjAPvrNuHzU
ao9B7m/s0x2g3oPZpRTi4lfz3PruDiKKaP4Z1BZa2guDgV/7K4+TRU4c6AgtL1uT
zdLfMG7R8ZHus/cgVdWhBOcAJcfiNu9xQ9dCS4qUHBDGtBF2FDaHvW4IV5hDQMzn
cZY4psFOaSNw8as8e7oRLEUdRn0WireY2QuMGWzNuk8PPH9HIpBa3p7mb8CtG8n2
AepxZZyzy+4US2M8Xm8mEbcYfvPDifejIp5oNkJnj04XwIcJ+Q8GX+CEqB1dVgn6
48Tp5RzvbZmaBXsBIE7K/4RE8THekArgz+/LFeS5kGy+MIrWhm6i65/CJuZYcYUj
PdsN5wp9VWtZ/+Zskrzigp8jvJZ/S6Co/5JxAh/Cok5dKSqsGv0=
=Ff+w
-----END PGP SIGNATURE-----

--=-gSyhWb0fu9KY3MReKxFJ--

