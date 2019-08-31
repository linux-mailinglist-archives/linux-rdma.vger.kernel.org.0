Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9AE28A458B
	for <lists+linux-rdma@lfdr.de>; Sat, 31 Aug 2019 19:18:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728419AbfHaRRK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 31 Aug 2019 13:17:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35138 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728410AbfHaRRJ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sat, 31 Aug 2019 13:17:09 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 13BD3307D88D;
        Sat, 31 Aug 2019 17:17:09 +0000 (UTC)
Received: from linux-ws.nc.xsintricity.com (ovpn-112-63.rdu2.redhat.com [10.10.112.63])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 25A4B5C21E;
        Sat, 31 Aug 2019 17:17:07 +0000 (UTC)
Message-ID: <ee70c5983baee6ed42bd74b7b3dacfdb8bd035af.camel@redhat.com>
Subject: Re: qedr memory leak report
From:   Doug Ledford <dledford@redhat.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        Michal Kalderon <Michal.Kalderon@cavium.com>,
        linux-rdma <linux-rdma@vger.kernel.org>
Date:   Sat, 31 Aug 2019 13:17:05 -0400
In-Reply-To: <20190831151945.GJ12611@unreal>
References: <93085620-9DAA-47A3-ACE1-932F261674AC@oracle.com>
         <13F323F2-D618-46C3-BE1B-106FD2BEE7F4@oracle.com>
         <20190831073048.GH12611@unreal>
         <63286035eb752429fdb651750acf74765caecfe5.camel@redhat.com>
         <20190831151945.GJ12611@unreal>
Organization: Red Hat, Inc.
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-x5suQruzHAR19fER6E1T"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Sat, 31 Aug 2019 17:17:09 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


--=-x5suQruzHAR19fER6E1T
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 2019-08-31 at 18:19 +0300, Leon Romanovsky wrote:
> On Sat, Aug 31, 2019 at 10:33:13AM -0400, Doug Ledford wrote:
> > On Sat, 2019-08-31 at 10:30 +0300, Leon Romanovsky wrote:
> > > Doug,
> > >=20
> > > I think that it can be counted as good example why allowing memory
> > > leaks
> > > in drivers (HNS) is not so great idea.
> >=20
> > Crashing the machine is worse.
>=20
> The problem with it that you are "punishing" whole subsystem
> because of some piece of crap which anyway users can't buy.

No I'm not.  The patch in question was in the hns driver and only leaked
resources assigned to the hns card when the hns card timed out in
freeing those resources.  That doesn't punish the entire subsystem, it
only punishes the users of that card, and then only if the card has
flaked out.

> If HNS wants to have memory leaks, they need to do it outside
> of upstream kernel.

Nope.

> In general, if users buy shitty hardware, they need to be ready
> to have kernel panics too. It works with faulty DRAM where kernel
> doesn't hide such failures, so don't see any rationale to invent
> something special for ib_device.

What you are advocating for is not "shitty DRAM crashing the machine",
you are advocating for "having ECC DRAM and then intentionally turning
the ECC off and then crashing the machine".  Please repeat after me: WE
DONT CRASH MACHINES.  PERIOD.  If it is avoidable, we avoid it.  That's
why BUG_ONs have to go and why they piss Linus off so much.  If you
crash the machine, people are left scratching their head and asking why.
If you don't crash the machine, they have a chance to debug the issue
and resolve it.  The entire idea that you are advocating for crashing
the machine as being preferable to leaking a few resources is ludicrous.
WE DONT CRASH MACHINES.  PERIOD.  Please repeat that until it fully
sinks in.

> Thanks

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

--=-x5suQruzHAR19fER6E1T
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAl1qq5EACgkQuCajMw5X
L91znA/9FivABR7M/IWmunB9nfL23NQqOTkxqHyMKoruycnNzYbHiEeEQLFv69LC
v/f1CLRiJBQG5ygUC6Szx7hhKKd2qyQzJKKmhG+pBPL0L6LdvQf213szWXXgn2Xh
USGor4KiFjjKoqny1XcdOmSCXYGQAdyBkXctrJCYfLuAGSHV/UGezRLfrL5S7b20
Mg6pKNwzddlVH3FgnFyKKyCPD2tji8TBWqkGNeq+l4LcJRGQeqLvZ/D6zp8YhX0H
T4vijQa80NwpkY6CFABSEV0nbkzF0lWJ0hGK9+ZOR3VfoMkwKf2l4nFauj0hlbeD
6xYHbvgzVSpW8LEafD9dcqkdXoc9ldWfUESQz0nuToSbVXo3V56iS0a+fGphGYrM
Wwr3zQg/+mJI0AoycNL942ZIOJ6va2tzCj60532pMfeaZQgncc9rx+2ezWPkOplx
DO+MoHS5q9MRM7ADOmwFmypAXhtDE0NlNSF6i0ho8ZjAl5KBXPQ/hGZeuqrk5zS6
aJWPwGxg4kOu5QCrzYfGXJfvZx2VQYefsnCO5QPsmhKBnffswEbVobC3lIt5ohVY
SsqzYqPIDAboR9XFvQB6GmiM9wc0+j3qKhGs7eJAmCR+Txtk5dOoCp9LDitqn5h/
FNtABQ+Sqdl4gKJmad0zwE5+r/YRZCfre3PpKfg2+YxCz0brKTc=
=i5WY
-----END PGP SIGNATURE-----

--=-x5suQruzHAR19fER6E1T--

