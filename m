Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8356E6C9
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Apr 2019 17:43:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728605AbfD2PnH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 29 Apr 2019 11:43:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58530 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728438AbfD2PnH (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 29 Apr 2019 11:43:07 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DE2E6309264B;
        Mon, 29 Apr 2019 15:43:06 +0000 (UTC)
Received: from haswell-e.nc.xsintricity.com (ovpn-112-9.rdu2.redhat.com [10.10.112.9])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EB9444D2;
        Mon, 29 Apr 2019 15:43:05 +0000 (UTC)
Message-ID: <00c2666a46b22f004429abc9c4530bbf21fe6e43.camel@redhat.com>
Subject: Re: [GIT PULL] Please pull RDMA subsystem changes
From:   Doug Ledford <dledford@redhat.com>
To:     Jason Gunthorpe <jgg@mellanox.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Mon, 29 Apr 2019 11:42:59 -0400
In-Reply-To: <20190429084030.GA4275@mellanox.com>
References: <20190428115207.GA11924@ziepe.ca> <20190429060947.GB3665@osiris>
         <20190429084030.GA4275@mellanox.com>
Organization: Red Hat, Inc.
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-mzcW/QoMlvpvSjLBBkEq"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Mon, 29 Apr 2019 15:43:06 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


--=-mzcW/QoMlvpvSjLBBkEq
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2019-04-29 at 08:40 +0000, Jason Gunthorpe wrote:
> On Mon, Apr 29, 2019 at 08:09:47AM +0200, Heiko Carstens wrote:
> > On Sun, Apr 28, 2019 at 11:52:12AM +0000, Jason Gunthorpe wrote:
> > > Hi Linus,
> > >=20
> > > Third rc pull request
> > >=20
> > > Nothing particularly special here. There is a small merge conflict
> > > with Adrea's mm_still_valid patches which is resolved as below:
> > ...
> > > Jason Gunthorpe (3):
> > >       RDMA/mlx5: Do not allow the user to write to the clock page
> > >       RDMA/mlx5: Use rdma_user_map_io for mapping BAR pages
> > >       RDMA/ucontext: Fix regression with disassociate
> >=20
> > This doesn't compile. The patch below would fix it, but not sure if
> > this is what is intended:
> >=20
> > drivers/infiniband/core/uverbs_main.c: In function 'rdma_umap_fault':
> > drivers/infiniband/core/uverbs_main.c:898:28: error: 'struct vm_fault' =
has no member named 'vm_start'
> >    vmf->page =3D ZERO_PAGE(vmf->vm_start);
> >                             ^~
> > diff --git a/drivers/infiniband/core/uverbs_main.c b/drivers/infiniband=
/core/uverbs_main.c
> > index 7843e89235c3..65fe89b3fa2d 100644
> > +++ b/drivers/infiniband/core/uverbs_main.c
> > @@ -895,7 +895,7 @@ static vm_fault_t rdma_umap_fault(struct vm_fault *=
vmf)
> > =20
> >  	/* Read only pages can just use the system zero page. */
> >  	if (!(vmf->vma->vm_flags & (VM_WRITE | VM_MAYWRITE))) {
> > -		vmf->page =3D ZERO_PAGE(vmf->vm_start);
> > +		vmf->page =3D ZERO_PAGE(vmf->vma->vm_start);
> >  		get_page(vmf->page);
> >  		return 0;
> >  	}
> >=20
>=20
> Thanks Heiko, this looks right to me.=20
>=20
> I'm surprised to be seeing this at this point, these patches should
> have been seen by 0 day for several days now, and they were in
> linux-next already too..
>=20
> Doug, can you send this to Linus today?

Yep.

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Key fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

--=-mzcW/QoMlvpvSjLBBkEq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAlzHG4MACgkQuCajMw5X
L91tQhAAta0q1pZ9kNDLRR7iMYU1dTbBuzlfyv6/bwsyY8C8SQt7TY2Q3vyNBHAp
AOuQcDMTAg7FT2EqIATXrSlPOA+mt132MO0HvgPydt/iBNW6LGQCvwW/Kevn5NMk
/G6P8SpV58YMJKotRTdD0dd2t8uQgx6Cqlq+d/Us88ioHFMvztDvJ4ztfaAdvhdV
1reQwGmItiu1LSZZXqKrjC2oQ01jZNopWkiywZ/NLW5FXIBgnTgKXe2D8XcbeE/I
/mEgc5V7wmncHLQaL+WvikRhzf10uz4nqXX4IchNHgX0ic/+ps/jhVYPAsko4Chn
p6nGvr9Jv9Zc/I0wOzlJjiROqtGgjGsz+ZvYfozDQCFK4f0Ui1j6z9UO7LRpjkue
MBksv0aYZSEX0Y8i6rVu4VBPs+oHStPtFn04W5IS0Emxb/W/+f02uRNm6PkzeNTQ
PdCbepECCnqduhSmUWYLMNmma8+tkmzYUneDxacVfX5RZg5q4M0jPBNV8sCHoqyQ
lmjrd17h33ddNtdy4Ai0o05IrPowdk+byc/cVuusGyCs4UUEyVJBuf9r+aoN3yp5
PaBphMczFQQtnhZgHsZoMe7yATmTyrHPwCXAsxsrtSaCJ6ivDbzdoERgn+QK971F
0X4i6SL94TSGR0yOLSJfbcTlRVq0aYmUvN6FbjjoFt+b880eg74=
=zkfn
-----END PGP SIGNATURE-----

--=-mzcW/QoMlvpvSjLBBkEq--

