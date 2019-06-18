Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2BCD496E5
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Jun 2019 03:39:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727159AbfFRBjG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 17 Jun 2019 21:39:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49484 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726331AbfFRBjG (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 17 Jun 2019 21:39:06 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 25FE67FDF5;
        Tue, 18 Jun 2019 01:39:05 +0000 (UTC)
Received: from linux-ws.nc.xsintricity.com (ovpn-112-63.rdu2.redhat.com [10.10.112.63])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6137258C95;
        Tue, 18 Jun 2019 01:39:04 +0000 (UTC)
Message-ID: <99f5b2e51e071b8fd49a8e7b02b05628b7fcf24f.camel@redhat.com>
Subject: Re: [PATCH for-rc 2/2] RDMA/efa: Handle mmap insertions overflow
From:   Doug Ledford <dledford@redhat.com>
To:     Gal Pressman <galpress@amazon.com>, Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-rdma@vger.kernel.org
Date:   Mon, 17 Jun 2019 21:39:01 -0400
In-Reply-To: <57150f7f-fcca-5f59-6971-9afdd1cc2f72@amazon.com>
References: <20190612072842.99285-1-galpress@amazon.com>
         <20190612072842.99285-3-galpress@amazon.com>
         <20190612120114.GD3876@ziepe.ca>
         <eb0bbd15-cf37-eacc-a4ce-62becf045c38@amazon.com>
         <57150f7f-fcca-5f59-6971-9afdd1cc2f72@amazon.com>
Organization: Red Hat, Inc.
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-01jCWCj59A8U1cimVwf/"
User-Agent: Evolution 3.32.2 (3.32.2-1.fc30) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Tue, 18 Jun 2019 01:39:05 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


--=-01jCWCj59A8U1cimVwf/
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2019-06-12 at 16:42 +0300, Gal Pressman wrote:
> On 12/06/2019 16:28, Gal Pressman wrote:
> > On 12/06/2019 15:01, Jason Gunthorpe wrote:
> > > On Wed, Jun 12, 2019 at 10:28:42AM +0300, Gal Pressman wrote:
> > > > When inserting a new mmap entry to the xarray we should check
> > > > for
> > > > 'mmap_page' overflow as it is limited to 32 bits.
> > > >=20
> > > > While at it, make sure to advance the mmap_page stored on the
> > > > ucontext
> > > > only after a successful insertion.
> > > >=20
> > > > Fixes: 40909f664d27 ("RDMA/efa: Add EFA verbs implementation")
> > > > Signed-off-by: Gal Pressman <galpress@amazon.com>
> > > >  drivers/infiniband/hw/efa/efa_verbs.c | 21 ++++++++++++++++---
> > > > --
> > > >  1 file changed, 16 insertions(+), 5 deletions(-)
> > > >=20
> > > > diff --git a/drivers/infiniband/hw/efa/efa_verbs.c
> > > > b/drivers/infiniband/hw/efa/efa_verbs.c
> > > > index 0fea5d63fdbe..c463c683ae84 100644
> > > > +++ b/drivers/infiniband/hw/efa/efa_verbs.c
> > > > @@ -204,6 +204,7 @@ static u64 mmap_entry_insert(struct efa_dev
> > > > *dev, struct efa_ucontext *ucontext,
> > > >  			     void *obj, u64 address, u64
> > > > length, u8 mmap_flag)
> > > >  {
> > > >  	struct efa_mmap_entry *entry;
> > > > +	u32 next_mmap_page;
> > > >  	int err;
> > > > =20
> > > >  	entry =3D kmalloc(sizeof(*entry), GFP_KERNEL);
> > > > @@ -216,15 +217,19 @@ static u64 mmap_entry_insert(struct
> > > > efa_dev *dev, struct efa_ucontext *ucontext,
> > > >  	entry->mmap_flag =3D mmap_flag;
> > > > =20
> > > >  	xa_lock(&ucontext->mmap_xa);
> > > > +	if (check_add_overflow(ucontext->mmap_xa_page,
> > > > +			       (u32)(length >> PAGE_SHIFT),
> > > > +			       &next_mmap_page))
> > > > +		goto err_unlock;
> > > > +
> > > >  	entry->mmap_page =3D ucontext->mmap_xa_page;
> > > > -	ucontext->mmap_xa_page +=3D DIV_ROUND_UP(length,
> > > > PAGE_SIZE);
> > > >  	err =3D __xa_insert(&ucontext->mmap_xa, entry->mmap_page,=20
> > > > entry,
> > > >  			  GFP_KERNEL);
> > > > +	if (err)
> > > > +		goto err_unlock;
> > > > +
> > > > +	ucontext->mmap_xa_page =3D next_mmap_page;
> > >=20
> > > This is not ordered right anymore, the xa_lock can be released
> > > inside
> > > __xa_insert, so to be atomic you must do everything before
> > > calling
> > > __xa_insert.
> >=20
> > Ah, missed the fact that __xa_insert could release the lock :\..
> > Thanks Jason, will bring back the mmap_xa_page assignment before
> > the __xa_insert
> > call and unwind it in case of __xa_insert failure.
>=20
> On second thought, unwinding the mmap_xa_page will cause other
> issues.. Will
> drop this part.

I wasn't sure what you intended to be the final patch on this one, so I
just ignored it.  Please post a respin of this patch that drops
whatever you want dropped.  Thanks.

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Key fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57
2FDD

--=-01jCWCj59A8U1cimVwf/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAl0IQLUACgkQuCajMw5X
L92Xgw//To0WHbxvGkSV6xn8wsF1kUPEdQKiBCTj4Nq4LHFiIKUL48bhrs7uK4jJ
HGT6dkRiwgBsP54UkOVT6locMJlGLD7m1doUNEUemNpmg87yJFTH1nbXz0nK9zW2
U4g8TBs+my2JRaaB40MidRG/BEVnZaV4t/F2MctJYWFGN+GKNa0OKic2r1/3QEW4
ZBd4YxsC/t6GqI+0usA/iMJfyzoGb8PXEH8HgX6ypBnu3nUBRxVcAeHW7XiNiwz9
ME6Ftjb9O633KKf6Q7b3b5GJVHqlI5rn8XnqsckHgV7Usus/G9nBYTurq44xahqj
ZQn/vRSeCt0aassPDi9ZKwreTP0Yif7IQ0w+6wKJosetTHDc2IUJM+BIuXHbJ/1S
ihzKwO7d9YsFSYIJWaom2MTMZIAhsz1otnonsJ+rC/zi5jtsSMcE/StnKdp/ual+
tSFfnHgTuCPM6cexBDVxzSiwT/4AdRPkIyi39PXh00yelCHklKCQc99DBz2QFrOp
268hzU/jRaTro49l5Hj/Rpxp418jLEyBEDOlMTxs6K77nQPwil+D/wy4M1ep7Rc7
C307+MTIC8MvMLLDsDfPd6dt3ZvNdKjJFbsCNtkUsiKX7ilIWr8gzdC3lx1+c6nP
2PXsgEAVNrNbwA0sktji7r4D+98IKH4Yb9wee8qFKA31lyGceMI=
=5FaJ
-----END PGP SIGNATURE-----

--=-01jCWCj59A8U1cimVwf/--

