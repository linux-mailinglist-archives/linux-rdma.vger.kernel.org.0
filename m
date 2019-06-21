Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3359E4EF9E
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Jun 2019 21:49:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726010AbfFUTt5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 21 Jun 2019 15:49:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34024 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725992AbfFUTt5 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 21 Jun 2019 15:49:57 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 91FCD59451;
        Fri, 21 Jun 2019 19:49:56 +0000 (UTC)
Received: from linux-ws.nc.xsintricity.com (ovpn-112-50.rdu2.redhat.com [10.10.112.50])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DBDDF5C21E;
        Fri, 21 Jun 2019 19:49:53 +0000 (UTC)
Message-ID: <320d7b6ed5ba7c133bd8ca42b020028fff7bd166.camel@redhat.com>
Subject: Re: iWARP and soft-iWARP interop testing
From:   Doug Ledford <dledford@redhat.com>
To:     Bernard Metzler <BMT@zurich.ibm.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-rdma <linux-rdma@vger.kernel.org>
Date:   Fri, 21 Jun 2019 15:49:51 -0400
In-Reply-To: <OF86155861.EB9F4D23-ON00258420.0044617C-00258420.0053DFF0@notes.na.collabserv.com>
References: <20190507161304.GH6201@ziepe.ca>
        ,<49b807221e5af3fab8813a9ce769694cb536072a.camel@redhat.com>
         <OF86155861.EB9F4D23-ON00258420.0044617C-00258420.0053DFF0@notes.na.collabserv.com>
Organization: Red Hat, Inc.
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-ZB6jLv+VMAuEAVXjA8Mr"
User-Agent: Evolution 3.32.2 (3.32.2-1.fc30) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Fri, 21 Jun 2019 19:49:56 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


--=-ZB6jLv+VMAuEAVXjA8Mr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2019-06-21 at 15:16 +0000, Bernard Metzler wrote:
> -----"Jason Gunthorpe" <jgg@ziepe.ca> wrote: -----
>=20
> > To: "Doug Ledford" <dledford@redhat.com>
> > From: "Jason Gunthorpe" <jgg@ziepe.ca>
> > Date: 05/07/2019 06:13PM
> > Cc: "linux-rdma" <linux-rdma@vger.kernel.org>, "Bernard Metzler"
> > <BMT@zurich.ibm.com>
> > Subject: Re: iWARP and soft-iWARP interop testing
> >=20
> > On Mon, May 06, 2019 at 04:38:27PM -0400, Doug Ledford wrote:
> > > So, Jason and I were discussing the soft-iWARP driver submission,
> > and he
> > > thought it would be good to know if it even works with the various
> > iWARP
> > > hardware devices.  I happen to have most of them on hand in one
> > form or
> > > another, so I set down to test it.  In the process, I ran across
> > some
> > > issues just with the hardware versions themselves, let alone with
> > soft-
> > > iWARP.  So, here's the results of my matrix of tests.  These
> > > aren't
> > > performance tests, just basic "does it work" smoke tests...
> >=20
> > Well, lets imagine to merge this at 5.2-rc1?=20
> >=20
> > Bernard you'll need to rebase and resend when it comes out in two
> > weeks.
> >=20
> > Thanks,
> > Jason
> >=20
> >=20
>=20
> Now, quite some rework and a few 5.2-rc's later ... any
> remaining real obstacles to get siw pulled in?

I'm basically ready.  I'll do one final cursory review and if I don't
see anything, pull it in.

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

--=-ZB6jLv+VMAuEAVXjA8Mr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAl0NNN8ACgkQuCajMw5X
L92vkBAAheGfYq1ZL7edoFByGhBb4IqReUOlBBar9PBOsTGt2snCMoyvqgMG2mhn
3+D10fzXv0GljyEKXdMv6MrH5Q05L9FQp/7XAohe2geE12tsHXZO6N8nMTDdO1k0
GAhaof9zL2q6jv93r5zs2c2qJOn+x2SuCxpqOiF9Sy7+09j1Gt6+geShPXvmEI0E
IMiVfP4hk+TsIqetcHTZeJugBrTciOIWloRv2pUSh8DA/BRzDu967kU8tHaqhNGW
AHpHz1w+iCinwvjipN29PwDqERtQ80/zfVob5RGZPhY+HFxvARS9Vw+fFSVAsk2p
ELY/U4XJ2YBdWxrQaeXl9Qie92+MMur7LpTuCh/ZcSa1ltT7ypLPaQf2apQY7lkH
19u203qwBlNGzbxBtn8marIkXNV79ZIUZFvELq58LvvQ1Tb8oBElJSyTFjuljDhZ
ziIuQg4x6596OkOw9C84XeKJM/nTuZFK7m7TqJyY9YIUzqRuyV9fnFAFFcHxzrEk
oq2zQYqt6IzXZ169qJ7o7gDieKtkRP148nSG1NTwG34gdxYp4OCIH/DuwdJODJSV
gjmF3W1RegQSvojZitGUdkckPGy9PvdWziCj0TOKOEIEAE64eKkgr2M9dp91k/D9
Nw0eXl5UBgJZ7BW5UDdNFApUHYqCiGU/l1uWpILXbEs9yObHvGM=
=s6Hk
-----END PGP SIGNATURE-----

--=-ZB6jLv+VMAuEAVXjA8Mr--

