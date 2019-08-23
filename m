Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5886F9B8C7
	for <lists+linux-rdma@lfdr.de>; Sat, 24 Aug 2019 01:27:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbfHWXYo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 23 Aug 2019 19:24:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51980 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727065AbfHWXYo (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 23 Aug 2019 19:24:44 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7325D36955;
        Fri, 23 Aug 2019 23:24:43 +0000 (UTC)
Received: from linux-ws.nc.xsintricity.com (ovpn-112-63.rdu2.redhat.com [10.10.112.63])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9F0AF5D6B2;
        Fri, 23 Aug 2019 23:24:42 +0000 (UTC)
Message-ID: <558c67120506011fdb903a18b56ce494a202405f.camel@redhat.com>
Subject: Re: [PULL REQUEST] Please pull rdma.git
From:   Doug Ledford <dledford@redhat.com>
To:     "dledford@redhat.com" <dledford@redhat.com>
Cc:     "Gunthorpe, Jason" <jgg@ziepe.ca>,
        linux-rdma <linux-rdma@vger.kernel.org>
Date:   Fri, 23 Aug 2019 19:24:40 -0400
In-Reply-To: <324f57e86a1e9240657dd0c3beede10d6c89baea.camel@redhat.com>
References: <5b0aa103f6007e1887f9b2cacaec8015834589b8.camel@xsintricity.com>
         <324f57e86a1e9240657dd0c3beede10d6c89baea.camel@redhat.com>
Organization: Red Hat, Inc.
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-u4vYlDaGMr3xaT0zWXPa"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Fri, 23 Aug 2019 23:24:43 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


--=-u4vYlDaGMr3xaT0zWXPa
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The mixup with me sending the original pull request from the wrong
address kept the pull request from appearing on the lists, but not from
Linus' mailbox.  As a result, it's been taken, but there doesn't appear
to be any pr-tracker-bot update forthcoming.  So I decided I'd let y'all
know ;-)

Deet-doot-dot I am *not* a bot.

On Fri, 2019-08-23 at 15:14 -0400, Doug Ledford wrote:
> Hi Linus,
>=20
> I didn't notice I was on my personal email identity when I sent the
> pull
> request.  Sorry about that.  It's really me ;-)
>=20
> On Fri, 2019-08-23 at 14:48 -0400, Doug Ledford wrote:
> > Hi Linus,
> >=20
> > No beating around the bush: this is a monster pull request for an
> > -rc5
> > kernel.  Intel hit me with a series of fixes for TID processing.=20
> > Mellanox hit me with a series for their UMR memory support.
> >=20
> > And we had one fix for siw that fixes the 32bit build warnings and
> > because of the number of casts that had to be changed to properly
> > silence the warnings, that one patch alone is a full 40% of the LOC
> > of
> > this entire pull request.  Given that this is the initial release
> > kernel
> > for siw, I'm trying to fix anything in it that we can, so that adds
> > to
> > the impetus to take fixes for it like this one.
> >=20
> > I had to do a rebase early in the week.  Jason had thought he put a
> > patch on the rc queue that he needed to be there so he could base
> > some
> > work off of it, and it had actually not been placed there.  So he
> > asked
> > me (on Tuesday) to fix that up before pushing my wip branch to the
> > official rc branch.  I did, and that's why the early patches look
> > like
> > they were all committed at the same time on Tuesday.  That bunch had
> > been in my queue prior.
> >=20
> > The various patches all pass my test for being legitimate fixes and
> > not
> > attempts to slide new features or development into a late rc.  Well,
> > they were all fixes with the exception of a couple clean up patches
> > people wrote for making the fixes they also wrote better (like a
> > cleanup
> > patch to move UMR checking into a function so that the remaining UMR
> > fix
> > patches can reference that function), so I left those in place too.
> >=20
> > My apologies for the LOC count and the number of patches here, it's
> > just
> > how the cards fell this cycle.  I hope you agree with me that
> > they're
> > justified fixes.
> >=20
> > Here's the boilerplate:
> >=20
> > The following changes since commit
> > d1abaeb3be7b5fa6d7a1fbbd2e14e3310005c4c1:
> >=20
> >   Linux 5.3-rc5 (2019-08-18 14:31:08 -0700)
> >=20
> > are available in the Git repository at:
> >=20
> >   git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git
> > tags/for-linus
> >=20
> > for you to fetch changes up to
> > c536277e0db1ad2e9fbb9dfd940c3565a14d9c52:
> >=20
> >   RDMA/siw: Fix 64/32bit pointer inconsistency (2019-08-23 12:08:27
> > -0400)
> >=20
> > ----------------------------------------------------------------
> > Pull request for 5.3-rc5
> >=20
> > - Fix siw buffer mapping issue
> > - Fix siw 32/64 casting issues
> > - Fix a KASAN access issue in bnxt_re
> > - Fix several memory leaks (hfi1, mlx4)
> > - Fix a NULL deref in cma_cleanup
> > - Fixes for UMR memory support in mlx5 (4 patch series)
> > - Fix namespace check for restrack
> > - Fixes for counter support
> > - Fixes for hfi1 TID processing (5 patch series)
> > - Fix potential NULL deref in siw
> > - Fix memory page calculations in mlx5
> >=20
> > Signed-off-by: Doug Ledford <dledford@redhat.com>
> >=20
> > ----------------------------------------------------------------
> > Bernard Metzler (3):
> >       RDMA/siw: Fix potential NULL de-ref
> >       RDMA/siw: Fix SGL mapping issues
> >       RDMA/siw: Fix 64/32bit pointer inconsistency
> >=20
> > Ido Kalir (1):
> >       IB/core: Fix NULL pointer dereference when bind QP to counter
> >=20
> > Jason Gunthorpe (1):
> >       RDMA/mlx5: Fix MR npages calculation for IB_ACCESS_HUGETLB
> >=20
> > Kaike Wan (5):
> >       IB/hfi1: Drop stale TID RDMA packets
> >       IB/hfi1: Unsafe PSN checking for TID RDMA READ Resp packet
> >       IB/hfi1: Add additional checks when handling TID RDMA READ
> > RESP
> > packet
> >       IB/hfi1: Add additional checks when handling TID RDMA WRITE
> > DATA
> > packet
> >       IB/hfi1: Drop stale TID RDMA packets that cause TIDErr
> >=20
> > Leon Romanovsky (2):
> >       RDMA/counters: Properly implement PID checks
> >       RDMA/restrack: Rewrite PID namespace check to be reliable
> >=20
> > Moni Shoua (4):
> >       IB/mlx5: Consolidate use_umr checks into single function
> >       IB/mlx5: Report and handle ODP support properly
> >       IB/mlx5: Fix MR re-registration flow to use UMR properly
> >       IB/mlx5: Block MR WR if UMR is not possible
> >=20
> > Selvin Xavier (1):
> >       RDMA/bnxt_re: Fix stack-out-of-bounds in
> > bnxt_qplib_rcfw_send_message
> >=20
> > Wenwen Wang (3):
> >       IB/mlx4: Fix memory leaks
> >       infiniband: hfi1: fix a memory leak bug
> >       infiniband: hfi1: fix memory leaks
> >=20
> > zhengbin (1):
> >       RDMA/cma: fix null-ptr-deref Read in cma_cleanup
> >=20
> >  drivers/infiniband/core/cma.c              |  6 ++-
> >  drivers/infiniband/core/counters.c         | 10 ++--
> >  drivers/infiniband/core/nldev.c            |  3 +-
> >  drivers/infiniband/core/restrack.c         | 15 +++---
> >  drivers/infiniband/core/umem.c             |  7 +--
> >  drivers/infiniband/hw/bnxt_re/qplib_rcfw.c |  8 ++-
> >  drivers/infiniband/hw/bnxt_re/qplib_rcfw.h | 11 ++--
> >  drivers/infiniband/hw/hfi1/fault.c         | 12 +++--
> >  drivers/infiniband/hw/hfi1/tid_rdma.c      | 76 ++++++++++---------
> > --
> > ------
> >  drivers/infiniband/hw/mlx4/mad.c           |  4 +-
> >  drivers/infiniband/hw/mlx5/main.c          |  6 +--
> >  drivers/infiniband/hw/mlx5/mem.c           |  5 +-
> >  drivers/infiniband/hw/mlx5/mlx5_ib.h       | 14 +++++
> >  drivers/infiniband/hw/mlx5/mr.c            |  7 ++-
> >  drivers/infiniband/hw/mlx5/odp.c           | 17 ++++---
> >  drivers/infiniband/hw/mlx5/qp.c            | 24 +++++++--
> >  drivers/infiniband/sw/siw/siw.h            |  8 +--
> >  drivers/infiniband/sw/siw/siw_cm.c         | 82 ++++++++++++++-----
> > --
> > ---------
> >  drivers/infiniband/sw/siw/siw_cq.c         |  5 +-
> >  drivers/infiniband/sw/siw/siw_mem.c        | 14 ++---
> >  drivers/infiniband/sw/siw/siw_mem.h        |  2 +-
> >  drivers/infiniband/sw/siw/siw_qp.c         |  2 +-
> >  drivers/infiniband/sw/siw/siw_qp_rx.c      | 26 +++++-----
> >  drivers/infiniband/sw/siw/siw_qp_tx.c      | 80 ++++++++++++++-----
> > --
> > --------
> >  drivers/infiniband/sw/siw/siw_verbs.c      | 40 +++++++--------
> >  include/rdma/restrack.h                    |  3 +-
> >  26 files changed, 248 insertions(+), 239 deletions(-)
> >=20

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

--=-u4vYlDaGMr3xaT0zWXPa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAl1gdbgACgkQuCajMw5X
L91SXg//b7w6iFPstbotOkdpFBAAivWmIM2gwn6rZ9OpYTpq3JyF/pnFSUyg6aoJ
gO9+j0Kc1YAbAuwgXemRz0TmbvOeHDx2j4LBY3ZD+F5BFsYmzfTqESqPrtbtN9J0
h+RNaBgCq5bLo+POE1EzENhmdtGwKJz3JAlf5V/OpgbKG2kr6LQ+dH0/oE4DkSVa
fvES/AiONqW7RpqfKgjX7IrAOW0+qNBO0l5TXsthH9E+aSVso17+a3QiFEqiRanW
MpJoXNe+xUQOP3cYXBiX5rk87EzzBsKLVFrUwrq0npOuY9cRs64+YxC+7rdiHoa8
Z0fqe4kzbbXEB1PADXRCQt36x1jI475j8R9cDrezTLxZTeqmDG6VF1+1UamV65NC
nzGYSQEkmqtKGguj0MhFinbj7rjtBZyoi1GabzDn5iP9N2PcBI99SwfVNDfV+176
KU85xwG2Kv1ENRubtgp9H8wrwm4ushZjMB47KC8Fsn4J5CYOap+ukjSHtMYXT0uJ
L/qCW+eMwogq2Cx0srSXBWC560WnNjrDx/tUAAPHd4fg6DXspZgt+VoAmuG2hacQ
/K2QFJgCx9u/gSnkJhoM9aH2KBZO6oiPBD5c2w2kW4mMTYGR+H76qeDfvPN9lcJI
r1Dv2TyYCyGC4/1jl4+iUflZSiiyIsuN+FZv9Qfl6y04qiU1xEk=
=BCIJ
-----END PGP SIGNATURE-----

--=-u4vYlDaGMr3xaT0zWXPa--

