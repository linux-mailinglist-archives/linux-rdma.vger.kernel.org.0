Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 66D5516939
	for <lists+linux-rdma@lfdr.de>; Tue,  7 May 2019 19:30:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbfEGRaP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 7 May 2019 13:30:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55510 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726256AbfEGRaP (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 7 May 2019 13:30:15 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6ED3B90916;
        Tue,  7 May 2019 17:30:14 +0000 (UTC)
Received: from haswell-e.nc.xsintricity.com (ovpn-112-3.rdu2.redhat.com [10.10.112.3])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 841851001E8D;
        Tue,  7 May 2019 17:30:13 +0000 (UTC)
Message-ID: <79daef2a1c32693a96b62b0d61277896f1a9d48a.camel@redhat.com>
Subject: Re: iWARP and soft-iWARP interop testing
From:   Doug Ledford <dledford@redhat.com>
To:     Bernard Metzler <BMT@zurich.ibm.com>
Cc:     linux-rdma <linux-rdma@vger.kernel.org>,
        "Gunthorpe, Jason" <jgg@ziepe.ca>
Date:   Tue, 07 May 2019 13:30:11 -0400
In-Reply-To: <OFE1E7EE12.36A09436-ON002583F3.00346573-002583F3.004AD2B1@notes.na.collabserv.com>
References: <49b807221e5af3fab8813a9ce769694cb536072a.camel@redhat.com>
         <OFE1E7EE12.36A09436-ON002583F3.00346573-002583F3.004AD2B1@notes.na.collabserv.com>
Organization: Red Hat, Inc.
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-HGoB/ZzdighVW0YuU0RN"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Tue, 07 May 2019 17:30:14 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


--=-HGoB/ZzdighVW0YuU0RN
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2019-05-07 at 13:37 +0000, Bernard Metzler wrote:
> Hi Doug,
>=20
> many thanks for taking the time and effort...!=20
> I'd love to have all that HW around here.
>=20
> Some comments inline
>=20
> Thanks very much!
> Bernard.
>=20
> -----"Doug Ledford" <dledford@redhat.com> wrote: -----
>=20
> > To: "linux-rdma" <linux-rdma@vger.kernel.org>
> > From: "Doug Ledford" <dledford@redhat.com>
> > Date: 05/06/2019 10:38PM
> > Cc: "Gunthorpe, Jason" <jgg@ziepe.ca>, "Bernard Metzler"
> > <BMT@zurich.ibm.com>
> > Subject: iWARP and soft-iWARP interop testing
> >=20
> > So, Jason and I were discussing the soft-iWARP driver submission, and
> > he
> > thought it would be good to know if it even works with the various
> > iWARP
> > hardware devices.  I happen to have most of them on hand in one form
> > or
> > another, so I set down to test it.  In the process, I ran across some
> > issues just with the hardware versions themselves, let alone with
> > soft-
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
> >                    Server Side
> > 	i40iw		qed1		qed2		cxgb4		siw
> > i40iw	FAIL[1]		FAIL[1]		FAIL[1]		FAIL[1]		FAIL[1]
> > qed1	FAIL[1]		FAIL[1]		FAIL[1]		FAIL[1]		FAIL[1]
> > qed2	FAIL[1]		FAIL[1]		FAIL[1]		FAIL[1]		FAIL[1]
> > cxgb4	FAIL[1]		FAIL[1]		FAIL[1]		FAIL[1]		FAIL[1]
> > siw	FAIL[2]		FAIL[1]		FAIL[1]		FAIL[1]		Untested
> >=20
> > Failure 1:
> > Client side shows:
> > client DISCONNECT EVENT...
> > Server side shows:
> > server DISCONNECT EVENT...
> > wait for RDMA_READ_ADV state 10
> >=20
>=20
> I see the same behavior between two siw instances. In my tests, these eve=
nts
> are created only towards the end of the rping test. Using the -v flag on
> client and server, I see the right amount of data being exchanged before
> ('-C 2' to save space here):
>=20
> Server:
> [bmt@rims ~]$ rping -s -S 40 -C 2 -a 10.0.0.1 -v
> server ping data: rdma-ping-0: ABCDEFGHIJKLMNOPQRSTUVWXYZ
> server ping data: rdma-ping-1: BCDEFGHIJKLMNOPQRSTUVWXYZ[
> server DISCONNECT EVENT...
> wait for RDMA_READ_ADV state 10
> [bmt@rims ~]$=20
>=20
> Client:
> [bmt@spoke ~]$ rping -c -S 40 -C 2 -I 10.0.0.2 -a 10.0.0.1 -v
> ping data: rdma-ping-0: ABCDEFGHIJKLMNOPQRSTUVWXYZ
> ping data: rdma-ping-1: BCDEFGHIJKLMNOPQRSTUVWXYZ[
> client DISCONNECT EVENT...
> [bmt@spoke ~]$=20
>=20
> I am not sure if that DISCONNECT EVENT thing is a failure
> though, or just the regular end of the test.

You and Steve are right.  I somehow dropped the -v from my test runs and
mistook this test ending for a failure.  It's probably worth fixing in
rping as it really is confusing ;-)

>=20
> > Failure 2:
> > Client side shows:
> > cma event RDMA_CM_EVENT_REJECTED, error -104
> > wait for CONNECTED state 4
> > connect error -1
> > Server side show:
> > Nothing, server didn't indicate anything had happened
> >=20
>=20
> Looks like an MPA reject - maybe this is due to i40iw being
> unwilling to switch of CRC, if it is not turned on at siw
> side? Or any other MPA reject reason...for fixing, we could
> take that issue into a private conversation thread. Turning
> on siw debugging will likely show the reason.

I'm not too worried about it.  If it's just a mismatch of options, then
it might be worth figuring out what options the i40iw doesn't like being
on/off and documenting it though.

>=20
> > Test 2:
> > ib_read_bw -d $device -R
> > ib_read_bw -d $device -R $remote
> >=20
> >                    Server Side
> > 	i40iw		qed1		qed2		cxgb4		siw
> > i40iw	PASS		PASS		PASS		PASS		PASS
> > qed1	PASS		PASS		PASS		PASS		PASS[1]
> > qed2	PASS		PASS		PASS		PASS		PASS[1]
> > cxgb4	PASS		PASS		PASS		PASS		PASS
> > siw	FAIL[1]		PASS		PASS		PASS		untested
> >=20
> > Pass 1:
> > These tests passed, but show pretty much worst case performance
> > behavior.  While I got 600MB/sec on one test, and 175MB/sec on
> > another,
> > the two that I marked were only at the 1 or 2MB/sec level.  I thought
> > they has hung initially.
>=20
> Compared to plain TCP, performance suffers from not using
> segmentation offloading.  Also, always good to set MTU size to max.=20
> With all that, on a 40Gbs link, line speed should be possible.
> But, yes, performance is not our main focus currently.

I wasn't really testing for performance here.  And I couldn't really
anyway.  I had a mix of 10Gig, 40Gig, and 25Gig hardware in this matrix.
It wouldn't be even close to an apples to apples comparison.  But, those
two tests, which only effect the qed driver, showed a clearly
pathological behavior.  It would be worth debugging in the future.

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Key fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

--=-HGoB/ZzdighVW0YuU0RN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAlzRwKMACgkQuCajMw5X
L92G1Q/9GnTjEtmjeQJBLYgPt7IeaFQB5Bnjeu2gviihApz1Z/eUcuprK3Sb0AFB
UJz6D+Dbtf5+er/IlJQghvrGmpwDW+KRFSP2dtTV4LaPdTf3RGUprpqRJI6Fm1/O
8r4Kg+u+BirLXHQevjm/GQY4pxiOk5RCJ0UTwimIisdNxANH1X3jm9HzZIjur9xj
tDQhvHmhc3O9nSURCHxXOfoGAv5Na7XYNe1LoQlneEqYt2nl+e0jsY3peOfirvpJ
FIu7QmmMm0YiScFtXwVzQS0uZL4RIus9jPAWZSSG4rzTtjQDQEuQMy4iZwSdSwGd
filzRAdJMIUGCSObusWEebDm1gqAUCdvqQCaVsfwO+giIqH6zssKIxQliBmUCNu7
d4rvctduDludT4Zb4dAIgu78PDGxM4N9GbRAO0XDJhbdRYVqJzd3pUXo14bPeoqj
xsqCgnQt5F9W0Pk56kIRHHot3ke2C2j6FFF9dZRP6/q1Nl/+fYjN/XQ73rAo9g3i
C8Mt99rjwxqY9qe+nbgUEgJvaV+7usMU51/cNWl43OirX2FwIycJdRL+wOapDUIb
w9hQ3gIRGLFQwisW6Fh/jBR4Dj8zzOTWIk4yBWVs96erSY0AQFZpBycpLUDJbspb
r3nVwVHiF+IcHgUc1nInV2tpV9ZQuCDXF1/QCryVQzM34B8Jqpk=
=XAJu
-----END PGP SIGNATURE-----

--=-HGoB/ZzdighVW0YuU0RN--

