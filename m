Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98F9747096
	for <lists+linux-rdma@lfdr.de>; Sat, 15 Jun 2019 17:01:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbfFOPBo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 15 Jun 2019 11:01:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43450 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725944AbfFOPBn (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sat, 15 Jun 2019 11:01:43 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3F9B659451;
        Sat, 15 Jun 2019 15:01:43 +0000 (UTC)
Received: from linux-ws.nc.xsintricity.com (ovpn-112-63.rdu2.redhat.com [10.10.112.63])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 570F35D9E2;
        Sat, 15 Jun 2019 15:01:42 +0000 (UTC)
Message-ID: <40515f44202835618492dd992971ec808ca72ada.camel@redhat.com>
Subject: Re: [PATCH v2 2/3] RDMA: Add NLDEV_GET_CHARDEV to allow char dev
 discovery and autoload
From:   Doug Ledford <dledford@redhat.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        Jason Gunthorpe <jgg@mellanox.com>
Date:   Sat, 15 Jun 2019 11:01:39 -0400
In-Reply-To: <20190615071653.GB4694@mtr-leonro.mtl.com>
References: <20190614003819.19974-1-jgg@ziepe.ca>
         <20190614003819.19974-3-jgg@ziepe.ca>
         <4b271896e1f3e643ccc5824ff6ac419787c52910.camel@redhat.com>
         <20190615071653.GB4694@mtr-leonro.mtl.com>
Organization: Red Hat, Inc.
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-yWIeMGwGIsp3M37wH1GB"
User-Agent: Evolution 3.32.2 (3.32.2-1.fc30) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Sat, 15 Jun 2019 15:01:43 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


--=-yWIeMGwGIsp3M37wH1GB
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 2019-06-15 at 10:16 +0300, Leon Romanovsky wrote:
> On Fri, Jun 14, 2019 at 03:00:32PM -0400, Doug Ledford wrote:
> > On Thu, 2019-06-13 at 21:38 -0300, Jason Gunthorpe wrote:
> > > +       if (ibdev)
> > > +               ret =3D __ib_get_client_nl_info(ibdev, client_name,
> > > res);
> > > +       else
> > > +               ret =3D __ib_get_global_client_nl_info(client_name,
> > > res);
> > > +#ifdef CONFIG_MODULES
> > > +       if (ret =3D=3D -ENOENT) {
> > > +               request_module("rdma-client-%s", client_name);
> > > +               if (ibdev)
> > > +                       ret =3D __ib_get_client_nl_info(ibdev,
> > > client_name, res);
> > > +               else
> > > +                       ret =3D
> > > __ib_get_global_client_nl_info(client_name, res);
> > > +       }
> > > +#endif
> >=20
> > I was trying to put my finger on something yesterday while reading
> > the
> > code, and this change makes it more clear for me.  Do we really
> > want to
> > limit the info type based on ibdev?  It seems to me that all global
> > info retrieval should work whether you open a specific ibdev or
> > not.
> > It's only the things that need the ibdev to return the correct
> > response
> > that should require it.  Right now we only have one global info
> > provider, but would it be better to do:
> >=20
> > 	if (!strcmp("rdma_cm", client_name))
> > 		ret =3D __ib_get_global_client_nl_info(client_name, res);
> > 	else
> > 		ret =3D __ib_get_client_nl_info(ibdev, client_name, res);
> >=20
> > The other thing I was wondering about was the module
> > loading.  Every
> > attempt to load a module is a fork/exec cycle and a context switch
> > over
> > to modprobe and back, and we make no attempt here to keep each
> > invocation of the netlink query from requesting a module.  I'm
> > concerned this is actually a potential DoS attack vector.  I was
> > thinking we should track each client name that's valid, and only
> > try
> > each name once.  I saw four module names: rdma_cm, umad, issm, and
> > uverbs.  I'm wondering if we should have a static table in the
> > netlink
> > file with an entry for each of the client names and a variable to
> > indicate we've attempted to load that module, and on -ENOENT, we
> > check
> > the table for a match to our passed in client_name, and only if we
> > have
> > a match, and it's load count is 0, do we call request_module() and
> > increment the load count.  Thoughts?
>=20
> Isn't request_module privileged operation, so only root or his
> friends
> can do this DDoS?

=46rom what I can tell, SELinux *might* prevent a user from doing this,
but it is the only thing I could find that even tries to stop it.=20
Which of course means there are no protections for SELinux disabled
case.  And I'm not sure SELinux stops it anyway.  In general, autoload
isn't very useful if the only person that can trigger it is root.  I
think in most cases, it is initiated by device file open or some such
that regular users can do.  It's possible things are fine because the
core code serializes module autoload and 1,000,000 simultaneous
requests will result in one real request, and 999,999 waiters that wait
for the result of the 1 and then take that back.  But as I read through
stuff, it's enough of a head scratcher that I'm tempted to try writing
an exploit and seeing what it does.

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Key fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57
2FDD

--=-yWIeMGwGIsp3M37wH1GB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAl0FCFMACgkQuCajMw5X
L91Bmg/8DOLDRbwxd0yk9nh+GlQOklANJ2nOulPi8EGyGTrZoz0LUswldByA1DKT
eAfaN30YDhxUCiF+yP40MyHmo+I0i/BB0ZPykFyNiNX5s3qD0J4HImsx/aYfyw6J
VUO/07HvLW+7VYeOWk68K5gtiA9OWghU3s9+2Ag2dy+cTDOe33NKppxWxNVm+Hbo
Zc/f6Qx771oWe5P3hpfW2GKMt9UGZMLbV5oZNQzjlcUrO218DL9RO9Rs57g5Oufu
kgGUgZSZJA7aT9yjgFIRBonkZWhGZN1/4bxL9QAFaX8sXeVNzvO/EAQEwKsGgENi
Ih2Sg51Hx9NcUj3c48AjQKSRwNoNWh4fKBG+GOimFB27+FFtX9obhzI9Pm8+FMSm
aVwwFCyi+iDYEG6i6N/7aVdvsAH33iONgUgsRQN0BsxhENpIASKvAQrXKKSUs1K/
yT8eNoXP/Go+kBa1m9iP0m6QE2NYtzC59PBC5ruLxE6zwm9wQzQTUSTohn3gZdo6
bUIw266MXHoXIaygWkyZFFhclBZSagwx4xNiJuGqT/4onmxE12s5DXMXCHIE9kLy
EObneI4FxPqHTLJ6UFQiF+YD9/DhDt3X3hyhCHTmZAH2J40ZOVPry3xWU4kZNoG8
KE2iinjbhaVbIgtr3R93Tx428p7kwMNb5UMHK4baq85OtJ7rNfE=
=h962
-----END PGP SIGNATURE-----

--=-yWIeMGwGIsp3M37wH1GB--

