Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 570E579206
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Jul 2019 19:24:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728515AbfG2RY1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 29 Jul 2019 13:24:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37196 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725934AbfG2RY1 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 29 Jul 2019 13:24:27 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 52C2D307D9D0;
        Mon, 29 Jul 2019 17:24:27 +0000 (UTC)
Received: from linux-ws.nc.xsintricity.com (ovpn-112-50.rdu2.redhat.com [10.10.112.50])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A48F25D9C8;
        Mon, 29 Jul 2019 17:24:26 +0000 (UTC)
Message-ID: <e6a930259f457a6d4dabfef0265545cff02ee427.camel@redhat.com>
Subject: Re: [PATCH rdma-rc] RDMA/qedr: Fix the hca_type and hca_rev
 returned in device attributes
From:   Doug Ledford <dledford@redhat.com>
To:     Michal Kalderon <michal.kalderon@marvell.com>, jgg@ziepe.ca
Cc:     linux-rdma@vger.kernel.org
Date:   Mon, 29 Jul 2019 13:24:24 -0400
In-Reply-To: <20190728111338.21930-1-michal.kalderon@marvell.com>
References: <20190728111338.21930-1-michal.kalderon@marvell.com>
Organization: Red Hat, Inc.
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-AanyM8C4CBhBcoHHUsxr"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Mon, 29 Jul 2019 17:24:27 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


--=-AanyM8C4CBhBcoHHUsxr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 2019-07-28 at 14:13 +0300, Michal Kalderon wrote:
> There was a place holder for hca_type and vendor was returned
> in hca_rev. Fix the hca_rev to return the hw revision and fix
> the hca_type to return an informative string representing the
> hca.
>=20
> Signed-off-by: Michal Kalderon <michal.kalderon@marvell.com>

This one was really kind of borderline for belonging in rc.  In the end,
I took it there because you requested it in your submission, but I think
it could have easily waited in for-next too.  Anyway, thanks, applied.

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

--=-AanyM8C4CBhBcoHHUsxr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAl0/K8gACgkQuCajMw5X
L914Vg/+Kdq3S3GmOpgxyEe1lvHWLmKn91N49h822VNylDov//E85UuovXoRt7F+
eqn7C+31eTUarVbXwU4TElUVCTes9SjtVL4aJ35o0xirQIw3AzczN8tOLD1ibxjz
UC9EWq9YWaxppBK90OhnmxovADd4g90Or/hZj9cKs5fvzuqGonSz4aKLNlP8MPcU
rPbBha+QGsFCHXmN+zhG9PzGFA5AKuwh+EVHaWSmsE+Z2Xw3gCcsq5MEyQ40jj5d
hV1Tw64p04U/fV5JxJa2iGuZIpD1ELRiAiXNEuu7/+A1ozL3zK0bvObdQMfFsxLR
+us7HnJx3n4LjyWowA3IkNJ8ixSxVOKW7CbK0V0cjTPZTxZlIHDpfq/rtXFdVq56
IKJjidtS/G/OJdQZEQJHOY9jpu6JK9pH4N+vHqiS0OzideXsuFzKJd8qnhO1+EbY
s2xq4/93LmRbk30pSKOJoZgDe8HB0qnkIhJvyWcyTCOCzH9IkIoIeOOM+sVz31lS
ydI3HTH3C28UWdNr8DbXbwt8gLG7WqCIM7KskLK7Nu+I+DwADi90yjuiuOrDBRV4
0t9ML28EVu8ocONL5WOINmt0z2Bc48QrEPHwlceFdtPEejWfFJOp8wGEjrc/3iMp
3MRIpPwr84wkDo6lcJsqjUGz2HH8Nyl9vtMB9e54qFzeBUIXEJo=
=jLFQ
-----END PGP SIGNATURE-----

--=-AanyM8C4CBhBcoHHUsxr--

