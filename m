Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6205448EB2
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Jun 2019 21:27:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729025AbfFQT11 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 17 Jun 2019 15:27:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59364 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729028AbfFQT10 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 17 Jun 2019 15:27:26 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BE019356DA;
        Mon, 17 Jun 2019 19:27:25 +0000 (UTC)
Received: from linux-ws.nc.xsintricity.com (ovpn-112-63.rdu2.redhat.com [10.10.112.63])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1BF0789588;
        Mon, 17 Jun 2019 19:27:24 +0000 (UTC)
Message-ID: <1c871dfaa2f5ddd9f07ab5f16e0a0e4f6c64917c.camel@redhat.com>
Subject: Re: [PATCH v2 2/3] RDMA: Add NLDEV_GET_CHARDEV to allow char dev
 discovery and autoload
From:   Doug Ledford <dledford@redhat.com>
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Date:   Mon, 17 Jun 2019 15:27:22 -0400
In-Reply-To: <20190617185443.GC25886@mellanox.com>
References: <20190614003819.19974-1-jgg@ziepe.ca>
         <20190614003819.19974-3-jgg@ziepe.ca>
         <4b271896e1f3e643ccc5824ff6ac419787c52910.camel@redhat.com>
         <20190617185443.GC25886@mellanox.com>
Organization: Red Hat, Inc.
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-Tn0HLZcDVvXf6FTFzTpO"
User-Agent: Evolution 3.32.2 (3.32.2-1.fc30) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Mon, 17 Jun 2019 19:27:25 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


--=-Tn0HLZcDVvXf6FTFzTpO
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2019-06-17 at 18:54 +0000, Jason Gunthorpe wrote:
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
> > not.=20
>=20
> Each chardev name has a specified query protocol - global chardevs
> must not specify a ibdev, and local ones must. Each name can only be
> global or ibdev - no mixing. Too confusing.

I can see where that's the uapi as envisioned, my point though is would
it be better to allow opening of an ibdev, retrieval of device specific
data, and also retrieval of the available global data?  It just
prevents having to open two files to get information that isn't device
specific.  But, it's not a big deal either.

> It is uapi so we should be strict, if the ibdev is not allowed then
> it
> should be checked to be absent in case we do something different
> later.
>=20
> > The other thing I was wondering about was the module
> > loading.  Every
> > attempt to load a module is a fork/exec cycle and a context switch
> > over
> > to modprobe and back, and we make no attempt here to keep each
>=20
> It is a common pattern in the kernel, ie we did exactly this code to
> load the ib netlink module in the netlink core.
>=20
> If there is a problem then it should be addressed globally..

Yeah, I agree.  I'm not sure there is a problem.

> > indicate we've attempted to load that module, and on -ENOENT, we
> > check
> > the table for a match to our passed in client_name, and only if we
> > have
> > a match, and it's load count is 0, do we call request_module() and
> > increment the load count.  Thoughts?
>=20
> I assume it becomes single threaded and batched at some point, so it
> is not so bad...

Thanks, series applied.


--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Key fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57
2FDD

--=-Tn0HLZcDVvXf6FTFzTpO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAl0H6ZoACgkQuCajMw5X
L93leBAAinS5lkDmbySl8Oojw8tkGmyODEyl77/MO6xoKeORiSCyjTG/LG0gaajL
2C3mUBLsE16CwP1BORPkGkjn4LQ8X8LRFIRUKRIpEjBJHrivX9GY4URLNXiJ7oWB
1AicTqbEREMy03pFIk21lmG5N6sLYC4bubQfg0O2DG2BB4VKkXvzfu3EFstI5pBM
MMP8swMQjU6J7FoGi+CnFe68XuQG/fMRxE6DF7JrQDTHc6DJUF/qLj/YQ4QZ1jcG
vPJLV4wCW4x8rx8Epn8uTDQ5L0E7abT37isVw2r/ekE4Qs6iktVBViY1qUpm/IHD
zo5I7MVhcwtp4FCYTWoCUI5n4eH4pcO8tRuxPTYvfmQxSqoNN3X0XVRGk92qxwoe
src925SOwmAtyFl31rGPs25sYNIK4PiM0sllIL6G5tRivcwBsb2l/QDjnNkkviGl
Kf0dFvfzjykmw1aQQ0ZH4ZDaZNzPH0yTgYnLN6wbNvk0/upjoaa2GfomACJppo0b
6MJgLg3J7BQGnH29eyjG1cWQ/fpXXXNhV2G84WoH6LAGOeqoyMp/kQ0TERaUE3Zt
drDZOyOnbRw+5CMo/U7uztASWjs07x0YODPAg1bQq1kTnt7jmxbR6xDlqCKv0wlZ
86W7x36zGXbMu/G2xDqwjhAVqXEwQxTIfAFxBsmZKlFLa0w4lEk=
=GRKp
-----END PGP SIGNATURE-----

--=-Tn0HLZcDVvXf6FTFzTpO--

