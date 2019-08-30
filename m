Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3DC8DA3AA0
	for <lists+linux-rdma@lfdr.de>; Fri, 30 Aug 2019 17:42:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727883AbfH3Pmk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 30 Aug 2019 11:42:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55312 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727751AbfH3Pmk (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 30 Aug 2019 11:42:40 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 45E0031752A9;
        Fri, 30 Aug 2019 15:42:40 +0000 (UTC)
Received: from linux-ws.nc.xsintricity.com (ovpn-112-63.rdu2.redhat.com [10.10.112.63])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5AE1860BE1;
        Fri, 30 Aug 2019 15:42:39 +0000 (UTC)
Message-ID: <cef8e627336f4a85b2860fd9bde25c71aef7e194.camel@redhat.com>
Subject: [PULL REQUEST] Please pull rdma.git
From:   Doug Ledford <dledford@redhat.com>
To:     "Torvalds, Linus" <torvalds@linux-foundation.org>
Cc:     linux-rdma <linux-rdma@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Gunthorpe, Jason" <jgg@ziepe.ca>
Date:   Fri, 30 Aug 2019 11:42:36 -0400
Organization: Red Hat, Inc.
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-9+g+DU5xRdEhDhCeiuFC"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Fri, 30 Aug 2019 15:42:40 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


--=-9+g+DU5xRdEhDhCeiuFC
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Linus,

*Much* calmer week this week.  Just one -rc patch queued up.  The way
the siw driver was locking around the traversal of the list of ipv6
addresses on a device was causing a scheduling while atomic issue.=20
Bernard straightened it out by using the rtnl_lock.

Here's the boiler plate:

The following changes since commit c536277e0db1ad2e9fbb9dfd940c3565a14d9c52=
:

  RDMA/siw: Fix 64/32bit pointer inconsistency (2019-08-23 12:08:27 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linu=
s

for you to fetch changes up to 531a64e4c35bb9844b0cf813a6c9a87e00be05ff:

  RDMA/siw: Fix IPv6 addr_list locking (2019-08-28 10:29:19 -0400)

----------------------------------------------------------------
Pull request for 5.3-rc6

- Fix locking on list traversal (siw)

Signed-off-by: Doug Ledford <dledford@redhat.com>

----------------------------------------------------------------
Bernard Metzler (1):
      RDMA/siw: Fix IPv6 addr_list locking

 drivers/infiniband/sw/siw/siw_cm.c | 31 ++++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 11 deletions(-)

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

--=-9+g+DU5xRdEhDhCeiuFC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAl1pQ+wACgkQuCajMw5X
L92RXw/+IG/iEPp7sY5SklyoC9WPxoghEvo59yRxJfdBkJAVi855MWF3SffCW0i9
YNJw0uMZ5CkY9XuXFxV7sPpLuUWNv/JET4Q7EeQkj/nTrSvr/+R9op5Uuy5p3Zsk
DymZCxKn+iW2mbphXVjbgMTgWcUzNVpgxlp92pDpZqmDtPKpt0rhL8hQAJ6ujq5h
oXuamdgmMSf+P600A8OfmP2c3G5io0cU2xozIfIRCKV4UO2k6qJg7YHlobQC08Xy
eT+MATALp8hoheret5TPC/Zxdewja3zEUqNiLL3kRFaHFkWy3khZW64Ih4RumdfS
etuRg8ZzovBVeK+wTXf5TETSd5dVDZpJ5ajme23+hbjGs4DsNhEHyl//TE7mo1uO
mFy+O1mNw97CZ1OzD70lRuYCflcgTXMVVRP2rROzQQQpVzew5XDIhdkrFohGsDdG
jduqt6jh3sGJZ+aLuicT7COtScVEks0HDPQDn+khw2EJlDfM9WURGPVzvdpx+yNL
dMp37Ny2z0c/hYAWuK4y3e3RVJ9xq+tyX54uD23+I8fVigM+g5VDn8N2W+De0Z89
aj5Gi6EDpHBTKKXW46WLCq+SdtnUgHBKWEH/xrItWxhJFxhH9Jevja5fkwzBasp7
9HVfPkKLtipEQoSOF+tNk7cdf9WneuQiz6rNUFWLn8P0JHHgJIg=
=ulam
-----END PGP SIGNATURE-----

--=-9+g+DU5xRdEhDhCeiuFC--

