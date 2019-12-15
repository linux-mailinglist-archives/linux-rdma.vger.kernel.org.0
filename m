Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29F9B11FB95
	for <lists+linux-rdma@lfdr.de>; Sun, 15 Dec 2019 22:57:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726219AbfLOV5N (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 15 Dec 2019 16:57:13 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:40843 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726146AbfLOV5N (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 15 Dec 2019 16:57:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576447031;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=Msvls+smTfugP8yTYOgGlNZxBRCNhGv5tqO3Bav8AAc=;
        b=PRZKcLehVrACUEDU0lSyn7JvrzOot4ynkPHAjRyIeooT5ycBTiAdVgER3AEuxNC6T9xsBu
        XDhE6pF4mZhpNbnygK2OhgVxa8YPFIytCZZAjiP2ehNu3qaOG1PyB15PZ60XnflLAVMst7
        aX++zXyL7IPk1aD+4npHFxvmzUciGUQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-174-H4Fh0ThbPd6aRqu5P2-VWg-1; Sun, 15 Dec 2019 16:57:07 -0500
X-MC-Unique: H4Fh0ThbPd6aRqu5P2-VWg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A3BE410509A0;
        Sun, 15 Dec 2019 21:57:06 +0000 (UTC)
Received: from linux-ws.nc.xsintricity.com (ovpn-112-42.rdu2.redhat.com [10.10.112.42])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EAF0A28D00;
        Sun, 15 Dec 2019 21:57:05 +0000 (UTC)
Message-ID: <9249797ff05697261e7bc1f3fa42d43d184a44ac.camel@redhat.com>
Subject: [PULL REQUEST] Please pull rdma.git
From:   Doug Ledford <dledford@redhat.com>
To:     "Torvalds, Linus" <torvalds@linux-foundation.org>
Cc:     "Gunthorpe, Jason" <jgg@ziepe.ca>,
        linux-rdma <linux-rdma@vger.kernel.org>
Date:   Sun, 15 Dec 2019 16:57:03 -0500
Organization: Red Hat, Inc.
User-Agent: Evolution 3.32.5 (3.32.5-1.fc30)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-+J9pf77DtowpWYxy4Ysj"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--=-+J9pf77DtowpWYxy4Ysj
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Linus,

A small collection of -rc fixes.  Mostly.  One API addition, but that's
because we wanted to use it in a fix.  There's also a bug fix that is
going to render the 5.5 kernel's soft-RoCE driver incompatible with all
soft-RoCE versions prior, but it's required to actually implement the
protocol according to the RoCE spec and required in order for the soft-
RoCE driver to be able to successfully work with actual RoCE hardware. =20
Commit log message has more details of what's in the pull request.

Here's the git boilerplate:

The following changes since commit e42617b825f8073569da76dc4510bfa019b1c35a=
:

  Linux 5.5-rc1 (2019-12-08 14:57:55 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linu=
s

for you to fetch changes up to dc2316eba73ff03da6dde082a372c6b5209304c5:

  IB/mlx5: Fix device memory flows (2019-12-12 16:55:36 -0500)

----------------------------------------------------------------
Pull request for 5.5-rc2

- Update Steve Wise info
- Fix for soft-RoCE crc calculations (will break back compatibility, but
  only with the soft-RoCE driver, which has had this bug since it was
  introduced and it is an on-the-wire bug, but will make soft-RoCE fully
  compatible with real RoCE hardware)
- cma init fixup
- counters oops fix
- fix for mlx4 init/teardown sequence
- fix for mkx5 steering rules
- introduce a cleanup API, which isn't a fix, but we want to use it in
  the next fix
- fix for mlx5 memory management that uses API in previous patch

Signed-off-by: Doug Ledford <dledford@redhat.com>

----------------------------------------------------------------
Chuhong Yuan (1):
      RDMA/cma: add missed unregister_pernet_subsys in init failure

Maor Gottlieb (1):
      IB/mlx5: Fix steering rule of drop and count

Mark Zhang (1):
      RDMA/counter: Prevent auto-binding a QP which are not tracked with re=
s

Parav Pandit (1):
      IB/mlx4: Follow mirror sequence of device add during device removal

Steve Wise (2):
      Update mailmap info for Steve Wise
      rxe: correctly calculate iCRC for unaligned payloads

Yishai Hadas (2):
      IB/core: Introduce rdma_user_mmap_entry_insert_range() API
      IB/mlx5: Fix device memory flows

 .mailmap                                 |   2 +
 drivers/infiniband/core/cma.c            |   1 +
 drivers/infiniband/core/counters.c       |   3 +
 drivers/infiniband/core/ib_core_uverbs.c |  48 ++++++++---
 drivers/infiniband/hw/mlx4/main.c        |   9 ++-
 drivers/infiniband/hw/mlx5/cmd.c         |  16 ++--
 drivers/infiniband/hw/mlx5/cmd.h         |   2 +-
 drivers/infiniband/hw/mlx5/main.c        | 133 ++++++++++++++++++++-------=
----
 drivers/infiniband/hw/mlx5/mlx5_ib.h     |  19 ++++-
 drivers/infiniband/sw/rxe/rxe_recv.c     |   2 +-
 drivers/infiniband/sw/rxe/rxe_req.c      |   6 ++
 drivers/infiniband/sw/rxe/rxe_resp.c     |   7 ++
 include/rdma/ib_verbs.h                  |   5 ++
 13 files changed, 180 insertions(+), 73 deletions(-)

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

--=-+J9pf77DtowpWYxy4Ysj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAl32rC8ACgkQuCajMw5X
L90KjQ/+L8Ne7l4eH+h35uQJ43FHtoarJy8Jlqv40SFP9SWfwWJLkcWX3lQm6kVO
CpYFfCjRB6H6QLmZAPYAYliJAy7Ar5zZpZOKBG/RH6ZHZl5902kW9i4zGMzGpKoE
SE7Z67B6CHZbd6884zMk4OvI329fUH62Dx5SmQL6yNPOGZ68Z1NIkOWtXV5nxQwF
3ANAcuYO2n6LRRlgHPj1Dy+Z/7cCoGP5z8wn7dk/Y4JrfHC8IvmNrYXDuRDy5nyR
WQALS9aGIwxAg6jdWRWvGnWyP1wmMjRC/SKpVRpEqakoV0vg3Xn85XbTd9QB8744
exEemi3mw6x89D0kT4URr2C9sTDn2s/AWdLubeAyllwo9l4oAj5QYWBl6wUmI28P
TuTnTe0pzghGp3OOinFJ7/TAaAnzec7AYGSXhb8Zl0WafglN67AzmKLSxY8j8ifh
Y4ldx+cdZvLeYqUX0MI1AC1cAcrBi2UMi02itUGt4hEbxESWibveTdQXdioWiZVC
MLXcTIqWoLRC7hhegiCfvqiyUKYQZ8smCd1HcQb2X2codYPPOwootFXBGNFTBqAP
qjwl0dwkug07S1zGs2Bu73CBT/MVkochNahcVHJ9lL3bNogfbDoY/Mgl1YL9HzPn
RgxLNKM/2RtlkrwwDIck2HV/7Tel4oL/RSxpBISl0YsCnEZNdSM=
=Ko19
-----END PGP SIGNATURE-----

--=-+J9pf77DtowpWYxy4Ysj--

