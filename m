Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0399D4EF94
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Jun 2019 21:42:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725992AbfFUTmN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 21 Jun 2019 15:42:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43654 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725985AbfFUTmN (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 21 Jun 2019 15:42:13 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 831463688E;
        Fri, 21 Jun 2019 19:42:12 +0000 (UTC)
Received: from linux-ws.nc.xsintricity.com (ovpn-112-50.rdu2.redhat.com [10.10.112.50])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9709860A97;
        Fri, 21 Jun 2019 19:42:11 +0000 (UTC)
Message-ID: <3ed43fc8399c5b8efa262699a1d3559cbe41fed5.camel@redhat.com>
Subject: [PULL REQUEST] Please pull rdma.git
From:   Doug Ledford <dledford@redhat.com>
To:     "Torvalds, Linus" <torvalds@linux-foundation.org>
Cc:     "Gunthorpe, Jason" <jgg@ziepe.ca>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Fri, 21 Jun 2019 15:42:09 -0400
Organization: Red Hat, Inc.
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-BxiJK0wsevTO9MrcGUQb"
User-Agent: Evolution 3.32.2 (3.32.2-1.fc30) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Fri, 21 Jun 2019 19:42:12 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


--=-BxiJK0wsevTO9MrcGUQb
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Linus,

This is probably our last -rc pull request.  We don't have anything else
outstanding at the moment anyway, and with the summer months on us and
people taking trips, I expect the next weeks leading up to the merge
window to be pretty calm and sedate.

This has two simple, no brainer fixes for the EFA driver.

Then it has ten not quite so simple fixes for the hfi1 driver.  The
problem with them is that they aren't simply one liner typo fixes.=20
They're still fixes, but they're more complex issues like livelock under
heavy load where the answer was to change work queue usage and spinlock
usage to resolve the problem, or issues with orphaned requests during
certain types of failures like link down which required some more
complex work to fix too.  They all look like legitimate fixes to me,
they just aren't small like I wish they were.

Here's the boilerplate:

The following changes since commit d1fdb6d8f6a4109a4263176c84b899076a5f8008=
:

  Linux 5.2-rc4 (2019-06-08 20:24:46 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linu=
s

for you to fetch changes up to 7a5834e456f7fb3eca9b63af2a6bc7f460ae482f:

  RDMA/efa: Handle mmap insertions overflow (2019-06-18 16:27:24 -0400)

----------------------------------------------------------------
Pull request for 5.1-rc5

- 2 minor EFA fixes
- 10 hfi1 fixes related to scaling issues

----------------------------------------------------------------
Gal Pressman (2):
      RDMA/efa: Fix success return value in case of error
      RDMA/efa: Handle mmap insertions overflow

Kaike Wan (1):
      IB/hfi1: Validate fault injection opcode user input

Mike Marciniszyn (9):
      IB/hfi1: Close PSM sdma_progress sleep window
      IB/hfi1: Correct tid qp rcd to match verbs context
      IB/hfi1: Avoid hardlockup with flushlist_lock
      IB/hfi1: Silence txreq allocation warnings
      IB/hfi1: Create inline to get extended headers
      IB/hfi1: Use aborts to trigger RC throttling
      IB/hfi1: Wakeup QPs orphaned on wait list after flush
      IB/hfi1: Handle wakeup of orphaned QPs for pio
      IB/hfi1: Handle port down properly in pio

 drivers/infiniband/hw/efa/efa_com_cmd.c  | 24 +++++++++++----
 drivers/infiniband/hw/efa/efa_verbs.c    | 21 ++++++++++---
 drivers/infiniband/hw/hfi1/chip.c        | 13 ++++++++
 drivers/infiniband/hw/hfi1/chip.h        |  1 +
 drivers/infiniband/hw/hfi1/fault.c       |  5 +++
 drivers/infiniband/hw/hfi1/hfi.h         | 31 +++++++++++++++++++
 drivers/infiniband/hw/hfi1/pio.c         | 21 +++++++++++--
 drivers/infiniband/hw/hfi1/rc.c          | 53 +++++++++++++++++++---------=
----
 drivers/infiniband/hw/hfi1/sdma.c        | 26 ++++++++++++----
 drivers/infiniband/hw/hfi1/tid_rdma.c    |  4 +--
 drivers/infiniband/hw/hfi1/ud.c          |  4 +--
 drivers/infiniband/hw/hfi1/user_sdma.c   | 12 +++-----
 drivers/infiniband/hw/hfi1/user_sdma.h   |  1 -
 drivers/infiniband/hw/hfi1/verbs.c       | 14 +++++----
 drivers/infiniband/hw/hfi1/verbs.h       |  1 +
 drivers/infiniband/hw/hfi1/verbs_txreq.c |  2 +-
 drivers/infiniband/hw/hfi1/verbs_txreq.h |  3 +-
 17 files changed, 174 insertions(+), 62 deletions(-)

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

--=-BxiJK0wsevTO9MrcGUQb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAl0NMxEACgkQuCajMw5X
L90Ejw/9HNVIwSjBM02c0aSeSwBP2Ie4aasjlB/Kqg828G/DCbts1/ryVLZMSAWE
FAHWRsvswPXZEbUgOV5w80SwHgoPfspHrkOXObTi5NQGwQISMVRnRyMeWu1a2guQ
mP3vuhmTDhhB9gk3I19Tvmvn58TT99xdoebfPrYWjl53/llIta9JNgXwBZ5UNwkO
r6iwbl3Yly9Sz72dfM2bapJ2r2bGIOUDDjBCPIv024yu4RIeQkHExTajy/CLnSMj
Cjze2SrQL+VPNqm9Ro2ZJAWJh9WRrlHu366wwdT0ntH3zvcdrgENeUI4sMWCy4yg
NLMwLJGBU//a7naY6Zqx3DYzGoGOyNBzYa6t3ni4lQoPWSmfvb9uuB9EzTIRd0x2
9M8lL1xYdp++pOYf41ThlaeSd+whDBoRI2m4uK3V58FOQ3w3qL/i7y1t6J9ORuH7
2e2NJeOENxN4SPdrDnJUVQ5268zLXh8mY4+T6rN9xwlKTYTO9w9GrqHR5TFLjldx
k2UtC5zhV9fMnHoHsuHHZL2aD+QvwJaBiell2wF6hGen8cNU8DymKSAuEdXmx6cJ
BESTZp1Ry+cLowNqI0GKAdto6Pz+5tHAmbC9f3pOnsUrYlPMDfeSwMtmL7mPs3Xe
KHRpbVburKoCLzhWbeLoklAZ5nNyZMZfSflhtujyFxVT5cSGius=
=WI49
-----END PGP SIGNATURE-----

--=-BxiJK0wsevTO9MrcGUQb--

