Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C22299F6F
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Aug 2019 21:08:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731943AbfHVTIn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 22 Aug 2019 15:08:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36098 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731821AbfHVTIn (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 22 Aug 2019 15:08:43 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DD79D308A98C;
        Thu, 22 Aug 2019 19:08:42 +0000 (UTC)
Received: from linux-ws.nc.xsintricity.com (ovpn-112-63.rdu2.redhat.com [10.10.112.63])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D766610016EA;
        Thu, 22 Aug 2019 19:08:40 +0000 (UTC)
Message-ID: <0f280f83ded4ec624ab897f8a83b4ab1565f35cd.camel@redhat.com>
Subject: Re: [PATCH v3] RDMA/siw: Fix 64/32bit pointer inconsistency
From:   Doug Ledford <dledford@redhat.com>
To:     Leon Romanovsky <leon@kernel.org>,
        Bernard Metzler <bmt@zurich.ibm.com>
Cc:     linux-rdma@vger.kernel.org, jgg@ziepe.ca, geert@linux-m68k.org
Date:   Thu, 22 Aug 2019 15:08:38 -0400
In-Reply-To: <20190822184147.GO29433@mtr-leonro.mtl.com>
References: <20190822173738.26817-1-bmt@zurich.ibm.com>
         <20190822184147.GO29433@mtr-leonro.mtl.com>
Organization: Red Hat, Inc.
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-796GEvFYSs1gxLfT+TP1"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Thu, 22 Aug 2019 19:08:43 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


--=-796GEvFYSs1gxLfT+TP1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2019-08-22 at 21:41 +0300, Leon Romanovsky wrote:
> On Thu, Aug 22, 2019 at 07:37:38PM +0200, Bernard Metzler wrote:
> > Fixes improper casting between addresses and unsigned types.
> > Changes siw_pbl_get_buffer() function to return appropriate
> > dma_addr_t, and not u64.
> >=20
> > Also fixes debug prints. Now any potentially kernel private
> > pointers are printed formatted as '%pK', to allow keeping that
> > information secret.
> >=20
> > Fixes: d941bfe500be ("RDMA/siw: Change CQ flags from 64->32 bits")
> > Fixes: b0fff7317bb4 ("rdma/siw: completion queue methods")
> > Fixes: 8b6a361b8c48 ("rdma/siw: receive path")
> > Fixes: b9be6f18cf9e ("rdma/siw: transmit path")
> > Fixes: f29dd55b0236 ("rdma/siw: queue pair methods")
> > Fixes: 2251334dcac9 ("rdma/siw: application buffer management")
> > Fixes: 303ae1cdfdf7 ("rdma/siw: application interface")
> > Fixes: 6c52fdc244b5 ("rdma/siw: connection management")
> > Fixes: a531975279f3 ("rdma/siw: main include file")
> >=20
> > Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > Reported-by: Jason Gunthorpe <jgg@ziepe.ca>
> > Reported-by: Leon Romanovsky <leon@kernel.org>
> > Signed-off-by: Bernard Metzler <bmt@zurich.ibm.com>
> > ---
> >  drivers/infiniband/sw/siw/siw.h       |  8 +--
> >  drivers/infiniband/sw/siw/siw_cm.c    | 74 ++++++++++++----------
> > -----
> >  drivers/infiniband/sw/siw/siw_cq.c    |  5 +-
> >  drivers/infiniband/sw/siw/siw_mem.c   | 14 ++---
> >  drivers/infiniband/sw/siw/siw_mem.h   |  2 +-
> >  drivers/infiniband/sw/siw/siw_qp.c    |  2 +-
> >  drivers/infiniband/sw/siw/siw_qp_rx.c | 26 +++++-----
> >  drivers/infiniband/sw/siw/siw_qp_tx.c | 43 ++++++++--------
> >  drivers/infiniband/sw/siw/siw_verbs.c | 40 +++++++--------
> >  9 files changed, 106 insertions(+), 108 deletions(-)
> >=20
> > diff --git a/drivers/infiniband/sw/siw/siw.h
> > b/drivers/infiniband/sw/siw/siw.h
> > index 77b1aabf6ff3..dba4535494ab 100644
> > --- a/drivers/infiniband/sw/siw/siw.h
> > +++ b/drivers/infiniband/sw/siw/siw.h
> > @@ -138,9 +138,9 @@ struct siw_umem {
> >  };
> >=20
> >  struct siw_pble {
> > -	u64 addr; /* Address of assigned user buffer */
> > -	u64 size; /* Size of this entry */
> > -	u64 pbl_off; /* Total offset from start of PBL */
> > +	dma_addr_t addr; /* Address of assigned buffer */
> > +	unsigned int size; /* Size of this entry */
> > +	unsigned long pbl_off; /* Total offset from start of PBL */
> >  };
> >=20
> >  struct siw_pbl {
> > @@ -734,7 +734,7 @@ static inline void siw_crc_skb(struct
> > siw_rx_stream *srx, unsigned int len)
> >  		  "MEM[0x%08x] %s: " fmt, mem->stag, __func__,
> > ##__VA_ARGS__)
> >=20
> >  #define siw_dbg_cep(cep, fmt,
> > ...)                                             \
> > -	ibdev_dbg(&cep->sdev->base_dev, "CEP[0x%p] %s: "
> > fmt,                  \
> > +	ibdev_dbg(&cep->sdev->base_dev, "CEP[0x%pK] %s: "
> > fmt,                  \
> >  		  cep, __func__, ##__VA_ARGS__)
> >=20
> >  void siw_cq_flush(struct siw_cq *cq);
> > diff --git a/drivers/infiniband/sw/siw/siw_cm.c
> > b/drivers/infiniband/sw/siw/siw_cm.c
> > index 9ce8a1b925d2..ae7ea3ad7224 100644
> > --- a/drivers/infiniband/sw/siw/siw_cm.c
> > +++ b/drivers/infiniband/sw/siw/siw_cm.c
> > @@ -355,8 +355,8 @@ static int siw_cm_upcall(struct siw_cep *cep,
> > enum iw_cm_event_type reason,
> >  		getname_local(cep->sock, &event.local_addr);
> >  		getname_peer(cep->sock, &event.remote_addr);
> >  	}
> > -	siw_dbg_cep(cep, "[QP %u]: id 0x%p, reason=3D%d, status=3D%d\n",
> > -		    cep->qp ? qp_id(cep->qp) : -1, id, reason, status);
> > +	siw_dbg_cep(cep, "[QP %u]: reason=3D%d, status=3D%d\n",
> > +		    cep->qp ? qp_id(cep->qp) : -1, reason, status);
>                                              ^^^^
> There is a chance that such construction (attempt to print -1 with %u)
> will generate some sort of warning.
>=20
> Thanks

I didn't see any warnings when I built it.  And %u->-1 would be the same
error on 64bit or 32bit, so I think we're safe here.

Thanks Bernard, it's in my wip/dl-for-rc branch to get 0day testing.

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

--=-796GEvFYSs1gxLfT+TP1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAl1e6DYACgkQuCajMw5X
L91pqw/8CWkGyGXD8O/VEPSdN2b/eAmSYjlMC3wa67/cgdIrlECBsqHxOqtDnDKF
b6uxLW+5x7basbol97iPDtqwuj/q/AkoPTvFuVS+5/4qb5OF0//H138glHu0kxBb
qsFd87WiQ5Jcnn1E6tULNpIVI1l0dZpHFN4eWX2wemL5C/lVLxqsgLckkDENw7mr
bEeWNzxXJSZKHDH3O1UPBawTWAdDfzHfubV3FgCnDIMpgSeyA+tEoWXm2JLBBEri
m0AvB2N6p2/kJDeOJtfD5CC767iXJCOS9ieMmZGxMM262gc1A9pxDVIJHAg/bnqj
ILoo+EFll6DMMrnrZEn9ds2I1530TeL6zQpXUXww+uOOeK9HzHRvyaCTUD/eUx5v
tx9OD4EXU8JsG6998eFwE7FpyN0dEriLN1YjH2/NpWbT8GQNeGzzCDXEAP3EfqIZ
hH62AXCCDMaki3f2R0h7gUIz2iPsaW2eNH58dLBPZWs67lp/x7MMOUHzPvdHDSV3
FyALcbaVAgg3etvtZIre+XVcDU/d+Koo3WiZa14fYXWTSZnxMB9D7ivDisB8vqLA
G+ANiJIgZb95ufAls499q6dBdraE7HFDHzUkbXRkd9golR56AzbkwOLSuLrIAhVy
BALWgMuGFlsO+/Tc+yqtXlhdaNukm3EyZGrJvfLTDyVD87Fdwqw=
=/qey
-----END PGP SIGNATURE-----

--=-796GEvFYSs1gxLfT+TP1--

