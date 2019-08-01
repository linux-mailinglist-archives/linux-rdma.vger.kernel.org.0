Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A9EB7DF30
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Aug 2019 17:36:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbfHAPgO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 1 Aug 2019 11:36:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52428 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726654AbfHAPgO (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 1 Aug 2019 11:36:14 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5B0B714B108;
        Thu,  1 Aug 2019 15:36:13 +0000 (UTC)
Received: from linux-ws.nc.xsintricity.com (ovpn-112-50.rdu2.redhat.com [10.10.112.50])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E1E0D60922;
        Thu,  1 Aug 2019 15:36:11 +0000 (UTC)
Message-ID: <9fb14e51fe57bd3015ca8a1db6222a40aba95560.camel@redhat.com>
Subject: Re:  [PATCH for-rc] siw: MPA Reply handler tries to read beyond MPA
 message
From:   Doug Ledford <dledford@redhat.com>
To:     Bernard Metzler <BMT@zurich.ibm.com>,
        Krishnamraju Eraparaju <krishna2@chelsio.com>
Cc:     jgg@ziepe.ca, linux-rdma@vger.kernel.org, bharat@chelsio.com,
        nirranjan@chelsio.com, krishn2@chelsio.com
Date:   Thu, 01 Aug 2019 11:36:09 -0400
In-Reply-To: <OF4DB6F345.7C76F976-ON00258449.00392FF3-00258449.003C1BFB@notes.na.collabserv.com>
References: <20190731103310.23199-1-krishna2@chelsio.com>
         <OF4DB6F345.7C76F976-ON00258449.00392FF3-00258449.003C1BFB@notes.na.collabserv.com>
Organization: Red Hat, Inc.
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-xfA4yVevE3nruPAPpTSV"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Thu, 01 Aug 2019 15:36:13 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


--=-xfA4yVevE3nruPAPpTSV
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2019-08-01 at 10:56 +0000, Bernard Metzler wrote:
> -----"Krishnamraju Eraparaju" <krishna2@chelsio.com> wrote: -----
>=20
> > To: jgg@ziepe.ca, bmt@zurich.ibm.com
> > From: "Krishnamraju Eraparaju" <krishna2@chelsio.com>
> > Date: 07/31/2019 12:34PM
> > Cc: linux-rdma@vger.kernel.org, bharat@chelsio.com,
> > nirranjan@chelsio.com, krishn2@chelsio.com, "Krishnamraju Eraparaju"
> > <krishna2@chelsio.com>
> > Subject: [EXTERNAL] [PATCH for-rc] siw: MPA Reply handler tries to
> > read beyond MPA message
> >=20
> > while processing MPA Reply, SIW driver is trying to read extra 4
> > bytes
> > than what peer has advertised as private data length.
> >=20
> > If a FPDU data is received before even siw_recv_mpa_rr() completed
> > reading MPA reply, then ksock_recv() in siw_recv_mpa_rr() could also
> > read FPDU, if "size" is larger than advertised MPA reply length.
> >=20
> > 501 static int siw_recv_mpa_rr(struct siw_cep *cep)
> > 502 {
> >          .............
> > 572
> > 573         if (rcvd > to_rcv)
> > 574                 return -EPROTO;   <----- Failure here
> >=20
> > Looks like the intention here is to throw an ERROR if the received
> > data
> > is more than the total private data length advertised by the peer.
> > But
> > reading beyond MPA message causes siw_cm to generate
> > RDMA_CM_EVENT_CONNECT_ERROR event when TCP socket recv buffer is
> > already
> > queued with FPDU messages.
> >=20
> > Hence, this function should only read upto private data length.
> >=20
> > Signed-off-by: Krishnamraju Eraparaju <krishna2@chelsio.com>
> > ---
> > drivers/infiniband/sw/siw/siw_cm.c | 4 ++--
> > 1 file changed, 2 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/infiniband/sw/siw/siw_cm.c
> > b/drivers/infiniband/sw/siw/siw_cm.c
> > index a7cde98e73e8..8dc8cea2566c 100644
> > --- a/drivers/infiniband/sw/siw/siw_cm.c
> > +++ b/drivers/infiniband/sw/siw/siw_cm.c
> > @@ -559,13 +559,13 @@ static int siw_recv_mpa_rr(struct siw_cep
> > *cep)
> > 	 * A private data buffer gets allocated if hdr->params.pd_len !=3D
> > 0.
> > 	 */
> > 	if (!cep->mpa.pdata) {
> > -		cep->mpa.pdata =3D kmalloc(pd_len + 4, GFP_KERNEL);
> > +		cep->mpa.pdata =3D kmalloc(pd_len, GFP_KERNEL);
> > 		if (!cep->mpa.pdata)
> > 			return -ENOMEM;
> > 	}
> > 	rcvd =3D ksock_recv(
> > 		s, cep->mpa.pdata + cep->mpa.bytes_rcvd - sizeof(struct
> > mpa_rr),
> > -		to_rcv + 4, MSG_DONTWAIT);
> > +		to_rcv, MSG_DONTWAIT);
> >=20
> > 	if (rcvd < 0)
> > 		return rcvd;
> > --=20
> > 2.23.0.rc0
> >=20
> >=20
>=20
> The intention of this code is to make sure the
> peer does not violates the MPA handshake rules.
> The initiator MUST NOT send extra data after its
> MPA request and before receiving the MPA reply.
> So, for the MPA request case, this code is needed
> to check for protocol correctness.
> You are right for the MPA reply case - if we are
> _not_ in peer2peer mode, the peer can immediately
> start sending data in RDMA mode after its MPA Reply.
> So we shall add appropriate code to be more specific
> For an error, we are (1) processing an MPA Request,
> OR (2) processing an MPA Reply AND we are not expected
> to send an initial READ/WRITE/Send as negotiated with
> the peer (peer2peer mode MPA handshake).
>=20
> Just removing this check would make siw more permissive,
> but to a point where peer MPA protocol errors are
> tolerated. I am not in favor of that level of
> forgiveness.
>=20
> If possible, please provide an appropriate patch
> or (if it causes current issues with another peer
> iWarp implementation) just run in MPA peer2peer mode,
> where the current check is appropriate.
> Otherwise, I would provide an appropriate fix by Monday
> (I am still out of office this week).
>=20
>=20
> Many thanks and best regards,
> Bernard.
>=20

I had taken the patch, but I've since dropped it (it had only made it to
my wip/dl-for-rc branch).  I'll wait for the proper fix (I looked, and I
could code it up, but I don't know what tests to use in the conditionals
since I don't know how you track peer2peer mode on the connection).

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

--=-xfA4yVevE3nruPAPpTSV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAl1DBukACgkQuCajMw5X
L909gBAAnbUqD8Nfqvlwsi6QdzdCHnUUtaEbF6a+IYf5u6oAoXV0v/wy6NdXi3ON
l9NZzLGRHDcoZqT/TPuqIMbTOrE08PBpw8BRyk2J8WbrmTE9VuZ0gCl396b8sSIC
HuySn/9oxif/kW5Yb/abzf6E/gc18L089RTOdLsKTpsGQDT8DHgqju+gviK78W1z
7qEdlBbzKSSlc7aFjXof7EgyJsmfsJZySBauAatrvDcLeCDXwwDa+nDLnqSCfgez
Ewr1jQvZsk+IIYosg87V9ZBNWujcvyMiWIKy1+JCWmbV0PJBcSUTa+ky7l7/XdvX
dSYtxz4FQdM7x2TlVKXPvzuAoP/aWmWHdZpTZZd1mVHGJpjT92RX91AyRKGzI3hY
Yhts4oH20rA8YQYtjMm9vmzcuKVtZ82lCSkwZFhsX67fxy40sgGal1Sy33nFJi1B
OEAJRbCvVO/VoS2quN+NKgCbwNJA8WQ1tU0ibOZHwGoXpXpnOMf/8AW3vQ/iegYV
aod/2c3w3UbC163V+bUCcALswUlyaiz8v7gDlhVlllMj+aUgFQQ/K/fZjiXUvsXg
XBzba0myJKsmM+RVPObz1skS8Nj0j0N3VnH8NKmeVucwXB0lDwwKIGlmwWJ4hZZk
7EXhXemZRyIbLF5+DoZr6ZC/pp5D/wZSVPwRtCe73xfgIRALlaU=
=SJ+n
-----END PGP SIGNATURE-----

--=-xfA4yVevE3nruPAPpTSV--

