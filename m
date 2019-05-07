Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 558ED1690F
	for <lists+linux-rdma@lfdr.de>; Tue,  7 May 2019 19:23:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727436AbfEGRX2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 7 May 2019 13:23:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33828 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726926AbfEGRX2 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 7 May 2019 13:23:28 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6E79630832EE;
        Tue,  7 May 2019 17:23:27 +0000 (UTC)
Received: from haswell-e.nc.xsintricity.com (ovpn-112-3.rdu2.redhat.com [10.10.112.3])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7FD3E5D9D1;
        Tue,  7 May 2019 17:23:26 +0000 (UTC)
Message-ID: <eaac8b3827f864a99ff8f846e403b7927385c19b.camel@redhat.com>
Subject: Re: iWARP and soft-iWARP interop testing
From:   Doug Ledford <dledford@redhat.com>
To:     Steve Wise <larrystevenwise@gmail.com>
Cc:     linux-rdma <linux-rdma@vger.kernel.org>,
        "Gunthorpe, Jason" <jgg@ziepe.ca>,
        Bernard Metzler <BMT@zurich.ibm.com>
Date:   Tue, 07 May 2019 13:23:20 -0400
In-Reply-To: <CADmRdJd44FYgYAvN8njcJcs5LwUiAcE89_vNXvqgp+cgOzcdVw@mail.gmail.com>
References: <49b807221e5af3fab8813a9ce769694cb536072a.camel@redhat.com>
         <CADmRdJd44FYgYAvN8njcJcs5LwUiAcE89_vNXvqgp+cgOzcdVw@mail.gmail.com>
Organization: Red Hat, Inc.
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-y5AEPbLnyPuTG5GZDCZP"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Tue, 07 May 2019 17:23:27 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


--=-y5AEPbLnyPuTG5GZDCZP
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2019-05-07 at 08:03 -0500, Steve Wise wrote:
> On Mon, May 6, 2019 at 3:39 PM Doug Ledford <dledford@redhat.com> wrote:
> > So, Jason and I were discussing the soft-iWARP driver submission, and h=
e
> > thought it would be good to know if it even works with the various iWAR=
P
> > hardware devices.  I happen to have most of them on hand in one form or
> > another, so I set down to test it.  In the process, I ran across some
> > issues just with the hardware versions themselves, let alone with soft-
> > iWARP.  So, here's the results of my matrix of tests.  These aren't
> > performance tests, just basic "does it work" smoke tests...
> >=20
> > Hardware:
> > i40iw =3D Intel x722
> > qed1 =3D QLogic FastLinQ QL45000
> > qed2 =3D QLogic FastLinQ QL41000
> > cxgb4 =3D Chelsio T520-CR
> >=20
> >=20
> >=20
> > Test 1:
> > rping -s -S 40 -C 20 -a $local
> > rping -c -S 40 -C 20 -I $local -a $remote
> >=20
> >                     Server Side
> >         i40iw           qed1            qed2            cxgb4          =
 siw
> > i40iw   FAIL[1]         FAIL[1]         FAIL[1]         FAIL[1]        =
 FAIL[1]
> > qed1    FAIL[1]         FAIL[1]         FAIL[1]         FAIL[1]        =
 FAIL[1]
> > qed2    FAIL[1]         FAIL[1]         FAIL[1]         FAIL[1]        =
 FAIL[1]
> > cxgb4   FAIL[1]         FAIL[1]         FAIL[1]         FAIL[1]        =
 FAIL[1]
> > siw     FAIL[2]         FAIL[1]         FAIL[1]         FAIL[1]        =
 Untested
> >=20
> > Failure 1:
> > Client side shows:
> > client DISCONNECT EVENT...
> > Server side shows:
> > server DISCONNECT EVENT...
> > wait for RDMA_READ_ADV state 10
> >=20
>=20
> Hey Doug,
>=20
> Try adding -Vv to display the ping data..  The log message you cite
> are normal, not indicative of an error.

You know...I had -vV on my initial test runs before I checked out the
entire matrix of machines to run this set of tests, and somehow it got
dropped.  I think you're right, and all these FAILS can be marked as
PASS instead.  It is certainly an awkward way to end a successful test,
but I do think it is passing.

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Key fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

--=-y5AEPbLnyPuTG5GZDCZP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAlzRvwgACgkQuCajMw5X
L93QAg/+OjmoPp8HbWg+N8W3dBRgHShRqXD+hxuKqA82YD9I1uZerZkSZ1DLlqIg
AL+RnvqhWAwik0i0VxkBfVjxcCUCl9iVI1S279s6KJ4jo81WHihevq566Ccx55Wh
Mb0J3bPdWukp+EMdbg5Ck/vhWL5EgR294mt/LVhoW2W8Ngbj9FGu5tV8zfFWmtoV
O/eMsAcxB3f1DPzxUGEas9enZJgCDSSvpfnPvtaXXwkFIL+TIpJ4DTeC31gSesU4
/ZEw60mXPJD3iAPwK4oaQg55RhqozCb+w9UiGvr17zpI5nuThDz5UEm/6W5vllZ+
cpraPggETS1EVLqzqKtCN58jc/br33j+FDnJBauYmo3XM9aVozzfQR359gXO9WhX
uWUIyCl+dtruVlvLT03nPyWEEDu+e9nZo62YqCVYHJ6ojw5zpy5TQtlsFAhlw5BV
zhaI6GlYRGcvsoNFo07NDiZDORj9AZ0qUyrV3TG7DXlfUOPJ7VSTCIgImI5kRyoJ
KFbJObH6bsgYXbJ/OPSbEgCaMjkjjXOITUz011uGT/SNNyBmRfSpdW4kCqJ1BsHu
lf1Cd09qAK95wb43m4S1M6/gOXFKPkoglyxwvlU8FjZ4k9pbdkA33lAxH94NUwvj
RvRyfr4Tbc5U/T7lPCtJdazfuS3xyKf1V1tUGRyYXRIdmv0OCZE=
=H13g
-----END PGP SIGNATURE-----

--=-y5AEPbLnyPuTG5GZDCZP--

