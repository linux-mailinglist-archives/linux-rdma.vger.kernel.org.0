Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45A3A496A9
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Jun 2019 03:28:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726088AbfFRB2O (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 17 Jun 2019 21:28:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37594 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725829AbfFRB2O (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 17 Jun 2019 21:28:14 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 269198535C;
        Tue, 18 Jun 2019 01:28:14 +0000 (UTC)
Received: from linux-ws.nc.xsintricity.com (ovpn-112-63.rdu2.redhat.com [10.10.112.63])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7530B1001DCF;
        Tue, 18 Jun 2019 01:28:13 +0000 (UTC)
Message-ID: <8c87efc3668a5f2eb8c3219bf4aae8300a989e2f.camel@redhat.com>
Subject: Re: [PATCH for-rc 0/7] IB/hfi1: Fix a stuck qp problem
From:   Doug Ledford <dledford@redhat.com>
To:     Dennis Dalessandro <dennis.dalessandro@intel.com>, jgg@ziepe.ca
Cc:     linux-rdma@vger.kernel.org
Date:   Mon, 17 Jun 2019 21:28:11 -0400
In-Reply-To: <4e80e6631acb78b1cb615dc322f87cc11f48f385.camel@redhat.com>
References: <20190614163146.44927.95985.stgit@awfm-01.aw.intel.com>
         <4e80e6631acb78b1cb615dc322f87cc11f48f385.camel@redhat.com>
Organization: Red Hat, Inc.
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-826Qx7OAPqnG6sj+iyfU"
User-Agent: Evolution 3.32.2 (3.32.2-1.fc30) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Tue, 18 Jun 2019 01:28:14 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


--=-826Qx7OAPqnG6sj+iyfU
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2019-06-17 at 21:19 -0400, Doug Ledford wrote:
> On Fri, 2019-06-14 at 12:32 -0400, Dennis Dalessandro wrote:
> > This series fixes a problem we encountered with a QP getting stuck.
> > It is a bit
> > bigger than we probably want for RC so I'm fine applying this to
> > for-
> > next
> > instead especially this late in the game for 5.2.
> > ---
> >=20
> > Mike Marciniszyn (7):
> >       IB/hfi1: Avoid hardlockup with flushlist_lock
> >       IB/hfi1: Silence txreq allocation warnings
> >       IB/hfi1: Create inline to get extended headers
> >       IB/hfi1: Use aborts to trigger RC throttling
> >       IB/hfi1: Wakeup QPs orphaned on wait list after flush
> >       IB/hfi1: Handle wakeup of orphaned QPs for pio
> >       IB/hfi1: Handle port down properly in pio
> >=20
>=20
> Hi Denny,
>=20
> These all look reasonably sane.  Their

They're*.  I really have better grammar than that.

>  big for a late rc, but they fix
> scale issues, not your typical one line typo bug, and those often are
> bigger fixes.  I'm comfortable arguing for these.  So, assuming my
> build test that's underway completes, applied to for-rc.  Thanks.
>=20

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Key fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57
2FDD

--=-826Qx7OAPqnG6sj+iyfU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAl0IPisACgkQuCajMw5X
L92HuQ/6A0FI3TTwbG8clUHOqsHdQjACrol6irBouIkkTISZHwyazfZrVJAWigT6
WhyNwN4gENqqyNub/qOpuso+c0m27rpUeCFtWmKAv9p0RC1Ut//5CLYdtX7JdUft
C6bWcO9unL2C/YD25osSSJGBhJg3fSaMNGCMXw/xLR7xYIVyM695z7XC4b72xWL3
S/0+HsxsXkcad7VeZGKhPzK+5YwaLYzBhxWG5YUnbTWGbB0PfuWNxVTPqePZa9x3
Wgcy+ewYAf//s+UcI0zEQNOaXE2d9GpQXyTp02PqI2wl8kXFI1MS/bxDzo++Ff4V
wgQqCqQ2bR28bvt2o3uP8rLgCUMfOvvUDHnQZQrk21PJAucSfyrX8VmE/bRsgvfb
T6WIsIaTfZ+4x9pFi3nfATE/D/R12Lo42vqnqaopYXy2beXHDY+vLgG38MycBI3/
0ny+Fe8g61YfG7rM6GbuzyNaoc+rYVwtCqI3eMyqsRbGCSC4ms5FtUvTY2Y0Ir42
Kn6Y7MsrrF8WFdtiC9AdPgXm4lGOrXzyUR2egEp/5EmdP49kbrqggbUEHdm2HT46
oHI8CJEyKIWoE7VFFtiX3Ep6b4hLmEOr07v2pN0aqGtbWtihd8fZejaC5m1Vj0Id
pqAsQ72XxxtIQ40Zm7K4Z9wCGg/nTH96pyuSHnJ6oF7URcybk+E=
=wPaH
-----END PGP SIGNATURE-----

--=-826Qx7OAPqnG6sj+iyfU--

