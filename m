Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F583E7C2
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Apr 2019 18:29:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728666AbfD2Q3O (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 29 Apr 2019 12:29:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46908 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728518AbfD2Q3O (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 29 Apr 2019 12:29:14 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2FEF53086225;
        Mon, 29 Apr 2019 16:29:14 +0000 (UTC)
Received: from haswell-e.nc.xsintricity.com (ovpn-112-9.rdu2.redhat.com [10.10.112.9])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 19B045D75D;
        Mon, 29 Apr 2019 16:29:12 +0000 (UTC)
Message-ID: <b2c40e59e56b00f41bc2c10e55ef75d52cef0361.camel@redhat.com>
Subject: Re: [GIT PULL] Please pull RDMA subsystem changes
From:   Doug Ledford <dledford@redhat.com>
To:     Jason Gunthorpe <jgg@mellanox.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Mon, 29 Apr 2019 12:29:10 -0400
In-Reply-To: <00c2666a46b22f004429abc9c4530bbf21fe6e43.camel@redhat.com>
References: <20190428115207.GA11924@ziepe.ca> <20190429060947.GB3665@osiris>
         <20190429084030.GA4275@mellanox.com>
         <00c2666a46b22f004429abc9c4530bbf21fe6e43.camel@redhat.com>
Organization: Red Hat, Inc.
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-GOYXXzF9KHU36Ho3xOiV"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Mon, 29 Apr 2019 16:29:14 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


--=-GOYXXzF9KHU36Ho3xOiV
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2019-04-29 at 11:42 -0400, Doug Ledford wrote:
> On Mon, 2019-04-29 at 08:40 +0000, Jason Gunthorpe wrote:
> > On Mon, Apr 29, 2019 at 08:09:47AM +0200, Heiko Carstens wrote:
> > > On Sun, Apr 28, 2019 at 11:52:12AM +0000, Jason Gunthorpe wrote:
> > > > Hi Linus,
> > > >=20
> > > > Third rc pull request
> > > >=20
> > > > Nothing particularly special here. There is a small merge conflict
> > > > with Adrea's mm_still_valid patches which is resolved as below:
> > > ...
> > > > Jason Gunthorpe (3):
> > > >       RDMA/mlx5: Do not allow the user to write to the clock page
> > > >       RDMA/mlx5: Use rdma_user_map_io for mapping BAR pages
> > > >       RDMA/ucontext: Fix regression with disassociate
> > >=20
> > > This doesn't compile. The patch below would fix it, but not sure if
> > > this is what is intended:
> > >=20
> > > drivers/infiniband/core/uverbs_main.c: In function 'rdma_umap_fault':
> > > drivers/infiniband/core/uverbs_main.c:898:28: error: 'struct vm_fault=
' has no member named 'vm_start'
> > >    vmf->page =3D ZERO_PAGE(vmf->vm_start);
> > >                             ^~
> > > diff --git a/drivers/infiniband/core/uverbs_main.c b/drivers/infiniba=
nd/core/uverbs_main.c
> > > index 7843e89235c3..65fe89b3fa2d 100644
> > > +++ b/drivers/infiniband/core/uverbs_main.c
> > > @@ -895,7 +895,7 @@ static vm_fault_t rdma_umap_fault(struct vm_fault=
 *vmf)
> > > =20
> > >  	/* Read only pages can just use the system zero page. */
> > >  	if (!(vmf->vma->vm_flags & (VM_WRITE | VM_MAYWRITE))) {
> > > -		vmf->page =3D ZERO_PAGE(vmf->vm_start);
> > > +		vmf->page =3D ZERO_PAGE(vmf->vma->vm_start);
> > >  		get_page(vmf->page);
> > >  		return 0;
> > >  	}
> > >=20
> >=20
> > Thanks Heiko, this looks right to me.=20
> >=20
> > I'm surprised to be seeing this at this point, these patches should
> > have been seen by 0 day for several days now, and they were in
> > linux-next already too..
> >=20
> > Doug, can you send this to Linus today?
>=20
> Yep.
>=20

Done.

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Key fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

--=-GOYXXzF9KHU36Ho3xOiV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAlzHJlYACgkQuCajMw5X
L91yvw//Ys2rV6w8YAjYEgeCwgJYzp6rraX9/ElJrYwnobStfgcjEddCY4QiO69g
yO9vMgHqcqmgp/WAKgDKu35vthZE6zgmuS6f80ZJ0eKYLcGfGDeeVREZfZEmjx+a
/EG/UA5Vb5N12ek8Y3Yy5Qk2uzoVjgOmKenPMxh+1SG1STNVwcp6st3TX6J35KkJ
Af3w8etl1t2nEueESciJt6DiOXf7Gxrg2MF1un2hhPgHLiicu24GC4RRTyyuNUCj
6rcYKqXh5Fr/NyiIjrQo9uGmfVkeZYoE5ZQQ4cf6MteP3/KEXF6SxmGAw4NOsVVv
0FEMmWt0JiN6R7jmRHNqnX5qFy0bB5AlzPowtkobVax9jOGP+DkGyfwa5nnn2JbW
c6cQWXJ8ez6+e4/h+C/wad7bkbNFwwgQwazdsuPg88gqT+fasQx3wg9Pt6XgNW3M
LkvWY3c6AYfReXJuXQCDAgXWZcxkU81IqhfXhKr7GuQl3o3M9XEQH24LJxZkqQfQ
VWOo0C+hPkDLfa2klxwGMDwhRZU3mfCxWxJ6Kqe1hftrHHHB0KMTx1OCb6zemfmd
/SBv4Mh1PivvWkbqPg55AEdiH1wroIDXgvbXybxVePWC7Nf7DB5hkdJ2YIm1Ht11
rAYhHUwbcBOS27A2WQ3WfCWAokPOW1LeslqMyi9XFdsusQaUftU=
=QDZ6
-----END PGP SIGNATURE-----

--=-GOYXXzF9KHU36Ho3xOiV--

