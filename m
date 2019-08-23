Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F22A79B44E
	for <lists+linux-rdma@lfdr.de>; Fri, 23 Aug 2019 18:13:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387838AbfHWQN7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 23 Aug 2019 12:13:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36310 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732570AbfHWQN7 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 23 Aug 2019 12:13:59 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 778F030043E1;
        Fri, 23 Aug 2019 16:13:58 +0000 (UTC)
Received: from linux-ws.nc.xsintricity.com (ovpn-112-63.rdu2.redhat.com [10.10.112.63])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2A640196AE;
        Fri, 23 Aug 2019 16:13:56 +0000 (UTC)
Message-ID: <7367a14c19c1d733615ea2e4c143b28fa81f6f90.camel@redhat.com>
Subject: Re: Re: [PATCH v3] RDMA/siw: Fix 64/32bit pointer inconsistency
From:   Doug Ledford <dledford@redhat.com>
To:     Bernard Metzler <BMT@zurich.ibm.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
        geert@linux-m68k.org
Date:   Fri, 23 Aug 2019 12:13:54 -0400
In-Reply-To: <OF6BB8D2A0.FBBB26D8-ON0025845F.00522370-0025845F.0052E0CD@notes.na.collabserv.com>
References: <20190823144221.GF12968@ziepe.ca>
        ,<0f280f83ded4ec624ab897f8a83b4ab1565f35cd.camel@redhat.com>
         <20190822173738.26817-1-bmt@zurich.ibm.com>
         <20190822184147.GO29433@mtr-leonro.mtl.com>
         <OF013F89F4.F7760460-ON0025845F.004F2CE0-0025845F.00500308@notes.na.collabserv.com>
         <OF6BB8D2A0.FBBB26D8-ON0025845F.00522370-0025845F.0052E0CD@notes.na.collabserv.com>
Organization: Red Hat, Inc.
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-XBR+qIaSocUdb5auFyeZ"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Fri, 23 Aug 2019 16:13:58 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


--=-XBR+qIaSocUdb5auFyeZ
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2019-08-23 at 15:05 +0000, Bernard Metzler wrote:
> -----"Jason Gunthorpe" <jgg@ziepe.ca> wrote: -----
>=20
> > To: "Bernard Metzler" <BMT@zurich.ibm.com>
> > From: "Jason Gunthorpe" <jgg@ziepe.ca>
> > Date: 08/23/2019 04:42PM
> > Cc: "Doug Ledford" <dledford@redhat.com>, "Leon Romanovsky"
> > <leon@kernel.org>, linux-rdma@vger.kernel.org, geert@linux-m68k.org
> > Subject: [EXTERNAL] Re: [PATCH v3] RDMA/siw: Fix 64/32bit pointer
> > inconsistency
> >=20
> > On Fri, Aug 23, 2019 at 02:33:56PM +0000, Bernard Metzler wrote:
> > > > > > diff --git a/drivers/infiniband/sw/siw/siw_cm.c
> > > > > > b/drivers/infiniband/sw/siw/siw_cm.c
> > > > > > index 9ce8a1b925d2..ae7ea3ad7224 100644
> > > > > > +++ b/drivers/infiniband/sw/siw/siw_cm.c
> > > > > > @@ -355,8 +355,8 @@ static int siw_cm_upcall(struct siw_cep
> > *cep,
> > > > > > enum iw_cm_event_type reason,
> > > > > >  		getname_local(cep->sock, &event.local_addr);
> > > > > >  		getname_peer(cep->sock, &event.remote_addr);
> > > > > >  	}
> > > > > > -	siw_dbg_cep(cep, "[QP %u]: id 0x%p, reason=3D%d,
> > > > > > status=3D%d\n",
> > > > > > -		    cep->qp ? qp_id(cep->qp) : -1, id, reason,
> > > > > > status);
> > > > > > +	siw_dbg_cep(cep, "[QP %u]: reason=3D%d, status=3D%d\n",
> > > > > > +		    cep->qp ? qp_id(cep->qp) : -1, reason,
> > > > > > status);
> > > > >                                              ^^^^
> > > > > There is a chance that such construction (attempt to print -1
> > with
> > > > %u)
> > > > > will generate some sort of warning.
> > > > >=20
> > > > > Thanks
> > > >=20
> > > > I didn't see any warnings when I built it.  And %u->-1 would be
> > the
> > > > same
> > > > error on 64bit or 32bit, so I think we're safe here.
> > > >=20
> > >=20
> > > Doug,
> > > May I ask you to amend this patch in a way which would
> > > just stop this monument of programming stupidity from
> > > prolonging into the future, while of course recognizing
> > > the impossibility of erasing it from the past?
> > > Exchanging the %u with %d would help me regaining
> > > some self-confidence ;)
> >=20
> > A
> >  q?a:b
> >=20
> > Expression has only a single type. There are some tricky rules on
> > this, but since gcc does not complain on the %u it means
> > 'q?(u32):(int)' is a (u32) and the -1 is implicitly casted.
> >=20
> > The better thing to write would have been U32_MAX instead of -1
> >=20
>=20
> What I wanted to have though is an easy to spot invalid number
> for the QP. This is why I wanted to have it a negative number
> on the screen, which is obviously not nicely achievable. So,
> yeah, U32_MAX is a better idea. It will not very often be a
> valid QP ID...

Given that this patch was still the top of my tree, I fixed this up.=20
But, I think U32_MAX is wrong.  It should be UINT_MAX (which is what I
used).  Otherwise it will give errors on s390 where an int is 31 bits
(and anywhere else that might have a non-32 bit int).

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

--=-XBR+qIaSocUdb5auFyeZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAl1gEMIACgkQuCajMw5X
L93q2g/9EQVDasF2NDQZxsNsxkAGQMULQ/5TAeCjr2h/qhyILY4VpHJi1DxDNKdD
TIP/6fomNdtg0IsAdHmif6f4ejJoOKu+vtjJXJ4SRWwfV2nUA2gKsBT5ZN3bcGyK
gCVflk10Kk0MU4IqATwbEXAd4iHyrq98Mv4y7PTtt3EwqoLfwuMAjcTW0Mn8ySu7
aJrHRfs7kfQ4fiRrV9Xwf8Zg8rB0EOT9Qcfx/OGKfnn7ZVJn+M5GXokL8OEUbqU4
3v7/Esdj+CsV4cgqA4EfgRRSSBwGMY2vol5Qe5JRk+nXHqyrgDw2h2agxM2wnnXQ
lLDFGIKYRd27Qqj5v3zQcTq8yTKg5rT+5YwqhKt9dFSSyT5UBlxVvFn+xLcqaFn5
Fo+7TdyB07wWTNfYFsilko5OOmzDKQryqaX+yebqxIMe3GpoM95Id/dhGtT7xSYw
pVm3NhFocQ3Xxma0etdT9ZQPBT3KsNLJNkLabHs29EKyUMHPEX/HPK582mBMBR4p
AZ8q5ZNdpfuPCVo/nlO2/Q+/cn6MQcGytLzTLsdrsHvHZIU8Zs73u7K+N37PL+rr
zRq7CS43eQvYQZFBji9x7jWld4eEGEx7CCUZsLIIX24MEI9F9Mz2/fkhPtINbT/P
x069jRBlm08uK51BsI2IoPINSpvHIyI57Ei9sGlpXNntod8MG88=
=ialB
-----END PGP SIGNATURE-----

--=-XBR+qIaSocUdb5auFyeZ--

