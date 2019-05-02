Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 434D1123A7
	for <lists+linux-rdma@lfdr.de>; Thu,  2 May 2019 22:52:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726030AbfEBUwd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 2 May 2019 16:52:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42198 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725962AbfEBUwd (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 2 May 2019 16:52:33 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B467E81DFE;
        Thu,  2 May 2019 20:52:32 +0000 (UTC)
Received: from haswell-e.nc.xsintricity.com (ovpn-112-9.rdu2.redhat.com [10.10.112.9])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 996F55D9C4;
        Thu,  2 May 2019 20:52:31 +0000 (UTC)
Message-ID: <532524968a01efe5ff9151a97b05ca0d03ddeab7.camel@redhat.com>
Subject: Re: Is this a known build issue on s390x for v5.1-rc7?
From:   Doug Ledford <dledford@redhat.com>
To:     jtoppins@redhat.com, Jason Gunthorpe <jgg@mellanox.com>
Cc:     RDMA mailing list <linux-rdma@vger.kernel.org>
Date:   Thu, 02 May 2019 16:52:29 -0400
In-Reply-To: <6ff4c15a28b585f41125fc264086c0d1aedefe4d.camel@redhat.com>
References: <9dd7f774-2b14-d4a7-3a85-edff758e36d0@redhat.com>
         <6ff4c15a28b585f41125fc264086c0d1aedefe4d.camel@redhat.com>
Organization: Red Hat, Inc.
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-HOPGPxTTV4fuK0SmibTu"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Thu, 02 May 2019 20:52:32 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


--=-HOPGPxTTV4fuK0SmibTu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2019-05-02 at 16:50 -0400, Doug Ledford wrote:
> > make[4]: *** [drivers/infiniband/core/uverbs_main.o] Error 1
> > make[3]: *** [drivers/infiniband/core] Error 2
> > make[2]: *** [drivers/infiniband] Error 2
> > make[1]: *** [drivers] Error 2
> > make: *** [sub-make] Error 2
>=20
> Yes, there's a fix in Linus' tree for it.
>=20

commit 6a5c5d26c4c6c3cc486fef0bf04ff9551132611b
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon Apr 29 09:48:53 2019 -0700

    rdma: fix build errors on s390 and MIPS due to bad ZERO_PAGE use
   =20
--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Key fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

--=-HOPGPxTTV4fuK0SmibTu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAlzLWI0ACgkQuCajMw5X
L92MBw//eBTSRg3t0N2Ac4YOzaiXMMSt5yf+QQBvpPE4K3zteX8ofTVJech5woZ1
UHvTx/ZKj5diPTbcGLgUYI0MLZv2elW/RyFETFNJ9heBUyGf1zf8lUhgqMxNX4Ni
fRvKF80U6Od4NopBE62Ksx3ySph7Ud+aEYy3yQ8EgwvY/el9M8+10WYTPqHSwoh6
rkAADwIl7cluqghLK4PHtyzZG62DyPrOe+DpZjELrfPX+TWQ9RPd/AtY0AKcTqKI
o0SRPNPcwC2C5fw0BxQvHUeBDGQHxJdZrzdDwkMxg6wllFntX0hotfS21JQ1FmUz
XcPxiBBtrWvWh6ISYPQ137rzmJ/zuzGupTDIyDon81Vr3gbE2caRDy8iTYl5Yrld
tSyTLL2yVO8oAWJqDxW0AJi6IDvF4Tk/86ip20P2z0mqK//ejH2o2HIvYKwjJgMp
ay6asMevqOGwFe6HDmUDJUuN8MhkbU7XPhNqxGsi1d5/lpxKguoVQ+wYz/65mRcS
6Tvw+WgzqON1eWhvKvv9RCDDQFF3GDUMhnDoGnKs9dK0NxEyuJcoMCJwjiFK7lnn
ng9Q+LiD+lJEeAXueS600bJaB7DQghX/Rj/lbQxLVscxmvQELIkjvOcT9xyhXUbL
OaZVK8K4D9gP9YEPXEGQoTD5lgmEJVwmPQ6shgPnY9fi5zC9Mp0=
=OA/m
-----END PGP SIGNATURE-----

--=-HOPGPxTTV4fuK0SmibTu--

