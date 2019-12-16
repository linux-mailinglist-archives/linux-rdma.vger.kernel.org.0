Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 961E511FCE1
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Dec 2019 03:27:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbfLPC1o (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 15 Dec 2019 21:27:44 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:51110 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726426AbfLPC1o (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 15 Dec 2019 21:27:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576463263;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iBWIRYCxgBDNayW7R2wU1x9FTXVKsst2OT7Hm1mIDyM=;
        b=LF0NRn9vPsNtib8JO808QVK7LkfK0PHmywHV7e6GsGb3FiXKVJExEl0jTFOy4L/eZcZaH6
        ageYVw0/T1Iz45UShZY4kUliCdpJwI6WJsHvj3OlYCjK1ER4WI5YHSRn1Bc2XjyWZiJ8SX
        pkQAQ/rLW2OZLyrI6bbkRB4/153oT6E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-161-zobkvNRWMSCpg1x53cZlZQ-1; Sun, 15 Dec 2019 21:27:39 -0500
X-MC-Unique: zobkvNRWMSCpg1x53cZlZQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6C292107ACC4;
        Mon, 16 Dec 2019 02:27:38 +0000 (UTC)
Received: from linux-ws.nc.xsintricity.com (ovpn-112-42.rdu2.redhat.com [10.10.112.42])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B55535D726;
        Mon, 16 Dec 2019 02:27:37 +0000 (UTC)
Message-ID: <7be07aaeb819a3fad0fbbc6b60377c87fbc8d3af.camel@redhat.com>
Subject: Re: [PULL REQUEST] Please pull rdma.git
From:   Doug Ledford <dledford@redhat.com>
To:     "Torvalds, Linus" <torvalds@linux-foundation.org>
Cc:     "Gunthorpe, Jason" <jgg@ziepe.ca>,
        linux-rdma <linux-rdma@vger.kernel.org>
Date:   Sun, 15 Dec 2019 21:27:29 -0500
In-Reply-To: <9249797ff05697261e7bc1f3fa42d43d184a44ac.camel@redhat.com>
References: <9249797ff05697261e7bc1f3fa42d43d184a44ac.camel@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Evolution 3.32.5 (3.32.5-1.fc30)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-76abVWIy5Jdf64siDb27"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--=-76abVWIy5Jdf64siDb27
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Pull request was taken, but because I forgot to include linux-kernel@ on
the Cc: list, we didn't get the pr-tracker bot reply.

On Sun, 2019-12-15 at 16:57 -0500, Doug Ledford wrote:
> Hi Linus,
>=20
> A small collection of -rc fixes.  Mostly.  One API addition, but
> that's
> because we wanted to use it in a fix.  There's also a bug fix that is
> going to render the 5.5 kernel's soft-RoCE driver incompatible with
> all
> soft-RoCE versions prior, but it's required to actually implement the
> protocol according to the RoCE spec and required in order for the
> soft-
> RoCE driver to be able to successfully work with actual RoCE
> hardware. =20
> Commit log message has more details of what's in the pull request.
>=20
> Here's the git boilerplate:
>=20
> The following changes since commit
> e42617b825f8073569da76dc4510bfa019b1c35a:
>=20
>   Linux 5.5-rc1 (2019-12-08 14:57:55 -0800)
>=20
> are available in the Git repository at:
>=20
>   git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git
> tags/for-linus
>=20
> for you to fetch changes up to
> dc2316eba73ff03da6dde082a372c6b5209304c5:
>=20
>   IB/mlx5: Fix device memory flows (2019-12-12 16:55:36 -0500)
>=20
> ----------------------------------------------------------------
> Pull request for 5.5-rc2
>=20
> - Update Steve Wise info
> - Fix for soft-RoCE crc calculations (will break back compatibility,
> but
>   only with the soft-RoCE driver, which has had this bug since it was
>   introduced and it is an on-the-wire bug, but will make soft-RoCE
> fully
>   compatible with real RoCE hardware)
> - cma init fixup
> - counters oops fix
> - fix for mlx4 init/teardown sequence
> - fix for mkx5 steering rules
> - introduce a cleanup API, which isn't a fix, but we want to use it in
>   the next fix
> - fix for mlx5 memory management that uses API in previous patch
>=20
> Signed-off-by: Doug Ledford <dledford@redhat.com>
>=20
> ----------------------------------------------------------------
> Chuhong Yuan (1):
>       RDMA/cma: add missed unregister_pernet_subsys in init failure
>=20
> Maor Gottlieb (1):
>       IB/mlx5: Fix steering rule of drop and count
>=20
> Mark Zhang (1):
>       RDMA/counter: Prevent auto-binding a QP which are not tracked
> with res
>=20
> Parav Pandit (1):
>       IB/mlx4: Follow mirror sequence of device add during device
> removal
>=20
> Steve Wise (2):
>       Update mailmap info for Steve Wise
>       rxe: correctly calculate iCRC for unaligned payloads
>=20
> Yishai Hadas (2):
>       IB/core: Introduce rdma_user_mmap_entry_insert_range() API
>       IB/mlx5: Fix device memory flows
>=20
>  .mailmap                                 |   2 +
>  drivers/infiniband/core/cma.c            |   1 +
>  drivers/infiniband/core/counters.c       |   3 +
>  drivers/infiniband/core/ib_core_uverbs.c |  48 ++++++++---
>  drivers/infiniband/hw/mlx4/main.c        |   9 ++-
>  drivers/infiniband/hw/mlx5/cmd.c         |  16 ++--
>  drivers/infiniband/hw/mlx5/cmd.h         |   2 +-
>  drivers/infiniband/hw/mlx5/main.c        | 133 ++++++++++++++++++++
> -----------
>  drivers/infiniband/hw/mlx5/mlx5_ib.h     |  19 ++++-
>  drivers/infiniband/sw/rxe/rxe_recv.c     |   2 +-
>  drivers/infiniband/sw/rxe/rxe_req.c      |   6 ++
>  drivers/infiniband/sw/rxe/rxe_resp.c     |   7 ++
>  include/rdma/ib_verbs.h                  |   5 ++
>  13 files changed, 180 insertions(+), 73 deletions(-)
>=20

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

--=-76abVWIy5Jdf64siDb27
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAl3265IACgkQuCajMw5X
L935wBAAw9pZJMn4N33HCNX2TAyBrf5VFg59hj67Isi7fMuFD26ZmAkgyIgBl4sD
qylsKOdDPs0utF+CiR9MHEUTrza0k6qRTqOTntmdePEj6meZa6X4Cd6iuY9x0YNK
Aji3dOlFZ1DKGsWL3kPYu1uZBotsGjvRHCMgBv7vyYkuNwksW8i+hxmah6AupjiR
tgI5/4sCOsA5t72xcE31Qxy2gCVG2kFHey79/KdBzlU2bL1cL/QnWGVoHo3XDgJx
AHiVZRgAlxtVEM9n5Px90t5kZVfBdlsH3obYj6B9PJuIAZ2JusL/LpsNHaSxJ0dr
J+So6nR7/R40HgQcm+X4FXY7oMbVLRKa5rt4XqZauY2U0kfoeVo//bHrMpoFHqUe
BUM1l/HXNkt9qlSJQkWZkPzsHX9NplcSE2l7VJLy8ZE03QXKEBUb49YY4KUaF3Ie
Ukyg1BngWWLep2nTzqsj15w3uJVYvDAXZhFLr2RNdUBBPdHDicV4dBQomPqa0A9T
2Y0MBydolZe1n0RNUqwDGAcHtEhk5oZ/kEPoE/8cvvKIWXNG6BAZ7j7neAPc+5Si
oiGnMEofg1l7NaHj4rCFLzZu3yClU1cRhTWD53uyv05T96I2RwvSslxN0BWKEQ51
e5ndhENVD2j34AihYsLlEVggvw/72je8idu9dzpn2dmHMLTYIMI=
=sR1k
-----END PGP SIGNATURE-----

--=-76abVWIy5Jdf64siDb27--

