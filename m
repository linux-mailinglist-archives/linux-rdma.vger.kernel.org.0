Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E9877CCA3
	for <lists+linux-rdma@lfdr.de>; Wed, 31 Jul 2019 21:17:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730713AbfGaTRp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 31 Jul 2019 15:17:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33068 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730690AbfGaTRp (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 31 Jul 2019 15:17:45 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9F0E73082129;
        Wed, 31 Jul 2019 19:17:44 +0000 (UTC)
Received: from linux-ws.nc.xsintricity.com (ovpn-112-50.rdu2.redhat.com [10.10.112.50])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5EDC760922;
        Wed, 31 Jul 2019 19:17:43 +0000 (UTC)
Message-ID: <b5c1a7d76e4aaf89063c56f1437fa803e3d7ea45.camel@redhat.com>
Subject: Re: [PATCH for-rc] siw: MPA Reply handler tries to read beyond MPA
 message
From:   Doug Ledford <dledford@redhat.com>
To:     Krishnamraju Eraparaju <krishna2@chelsio.com>, jgg@ziepe.ca,
        bmt@zurich.ibm.com
Cc:     linux-rdma@vger.kernel.org, bharat@chelsio.com,
        nirranjan@chelsio.com, krishn2@chelsio.com
Date:   Wed, 31 Jul 2019 15:17:40 -0400
In-Reply-To: <20190731103310.23199-1-krishna2@chelsio.com>
References: <20190731103310.23199-1-krishna2@chelsio.com>
Organization: Red Hat, Inc.
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-JzINDnd2nH+kYZHtM/pU"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Wed, 31 Jul 2019 19:17:44 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


--=-JzINDnd2nH+kYZHtM/pU
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2019-07-31 at 16:03 +0530, Krishnamraju Eraparaju wrote:
> while processing MPA Reply, SIW driver is trying to read extra 4 bytes
> than what peer has advertised as private data length.
>=20
> If a FPDU data is received before even siw_recv_mpa_rr() completed
> reading MPA reply, then ksock_recv() in siw_recv_mpa_rr() could also
> read FPDU, if "size" is larger than advertised MPA reply length.
>=20
>  501 static int siw_recv_mpa_rr(struct siw_cep *cep)
>  502 {
>           .............
>  572
>  573         if (rcvd > to_rcv)
>  574                 return -EPROTO;   <----- Failure here
>=20
> Looks like the intention here is to throw an ERROR if the received
> data
> is more than the total private data length advertised by the peer. But
> reading beyond MPA message causes siw_cm to generate
> RDMA_CM_EVENT_CONNECT_ERROR event when TCP socket recv buffer is
> already
> queued with FPDU messages.
>=20
> Hence, this function should only read upto private data length.
>=20
> Signed-off-by: Krishnamraju Eraparaju <krishna2@chelsio.com>

Once you apply this patch, the if (rcvd > to_rcv) test you listed above
in the commit message becomes dead code.  So I removed it while applying
the patch.  Thanks.

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

--=-JzINDnd2nH+kYZHtM/pU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAl1B6VQACgkQuCajMw5X
L90umxAAis74DZrjtu/rlZltx3FisDSxfKK/IOwE+nV7f+RWCEaKqcv9PqqbxXLO
iwe6SZo1DU/rOhzqFOhxcJfIk1wOa+RrRMkZFedni1HMlEeRc4W0onnIKRVDCviN
BS8qAy378gZkvPG9e6xO2GP567wmjhq8NEv3MtvuDuAFf8C+GOEnZ4EeLN//dwoD
CBy1+TMVfW9/JED2NiuqDJpn9Vzg6Uma7KicO9WCwuBfwUVyAqNXnK88PFxdKTIv
KZoyKrOmRNrUdXh97d3dRCwAYAz7TqFmFaZVsMnHgjJeJEJeqe1BeaskgyEJWxdC
BdI3vhwEyiICf5sm9rlTBz8Dn3qFHh7K/2/+fuD4jJtmSDgilD88sUg7+XGXaUq1
fvnmnY5blPgsND3lyDD1WDnpTY8Qq50cX43QQY1Mhbch60Z/n2NxPIfVJQN6ILbd
aXHtcm7hJ1YKJF90Ki5eehaQ6HJQiyMrjmlIPF6kzShhnEu1mlygR74L77FYminN
d1ajVB0vUSQFHVd1DRkEEu5pdstPOwjQ2HK6+SfESQSLe1Y9Re8LJMVWAuWcRSv9
owUGtzy/0IYRhqu+umgklylvxJwoD1E6wwck3vWDelMR+t6TbaJhUnRssjtyrved
WzQXqXKp/8frgkCSXTHR5q6Vu16HsdtzFzWa8PpvUsONtoBaptc=
=qbtC
-----END PGP SIGNATURE-----

--=-JzINDnd2nH+kYZHtM/pU--

