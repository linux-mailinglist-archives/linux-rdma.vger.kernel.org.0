Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 55E43E7BF
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Apr 2019 18:29:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728664AbfD2Q3A (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 29 Apr 2019 12:29:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57940 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728518AbfD2Q3A (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 29 Apr 2019 12:29:00 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6738C309264B;
        Mon, 29 Apr 2019 16:29:00 +0000 (UTC)
Received: from haswell-e.nc.xsintricity.com (ovpn-112-9.rdu2.redhat.com [10.10.112.9])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 890EC5D71D;
        Mon, 29 Apr 2019 16:28:59 +0000 (UTC)
Message-ID: <48cbd548d153d1d2a1cf6c4f2127a6cef5d55deb.camel@redhat.com>
Subject: [GIT PULL] Please pull rdma.git
From:   Doug Ledford <dledford@redhat.com>
To:     "Torvalds, Linus" <torvalds@linux-foundation.org>
Cc:     linux-rdma <linux-rdma@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Gunthorpe, Jason" <jgg@ziepe.ca>
Date:   Mon, 29 Apr 2019 12:28:57 -0400
Organization: Red Hat, Inc.
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-uUtEAudNqpCcJkrqUv+r"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Mon, 29 Apr 2019 16:29:00 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


--=-uUtEAudNqpCcJkrqUv+r
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Linus,

As per the thread on our last pull request, this is the two line build
fix for s390 and mips.

The following changes since commit
2557fabd6e29f349bfa0ac13f38ac98aa5eafc74:

  RDMA/hns: Bugfix for mapping user db (2019-04-25 10:40:04 -0300)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-
linus

for you to fetch changes up to d79a26b99f5f40db6863b1973750fd1d134d99b4:

  RDMA/uverbs: Fix compilation error on s390 and mips platforms (2019-
04-29 11:47:55 -0400)

----------------------------------------------------------------
Pull request for 5.1-rc

- Build fix for the last pull request on s390

----------------------------------------------------------------
Leon Romanovsky (1):
      RDMA/uverbs: Fix compilation error on s390 and mips platforms

 drivers/infiniband/core/uverbs_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Key fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

--=-uUtEAudNqpCcJkrqUv+r
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAlzHJkkACgkQuCajMw5X
L91InBAAl9wPAKjtoPDTK8G+FYEtytb74NlBVxkJXyh8axLo1YETZYy+Qv3S27L6
mnY5lK3ottBBCtiho1XxtG5mqKWmWWC1to5cSx/UG90oc8s3NXZ5dhmMEtLLEVbG
txuTL4X/TYy0veTlowDCUyYimPO8VZUy9agoybU6FBrvylobf/qU2gw0oP42oMr4
2AiAK/9XiZTOwswG/PVuTy4UUYwM5hzEH7un74Qb/gaeQKYyGwwk2wQUtOZ7bgmh
AoW1XnoAz2rrcvJGOGjpjY2ftHHIpB4ITIdBDC7sypNF9GJGYWMaVqLSe3L8DKNg
BwboJ+ZCYelbRHGO0SPy5f68bP+S64XHcW1skvPc/+XEQF+8qYXWTPwjMtCWs5aY
f67aC5k6yakbEDZ8vRp3tTqYXXzCcVNU27V+TCz2KyPas1hW/1x7ATo/czLjWP/1
Pw0sYrWl0cOdNw4Uk9jJPhgYDZmbbQILPSBbif7Njuuyf5cvRP/o8IDktThBCm7z
GKZguuTLJpHGwiE8VN6zntfB5s9jOPLPYO7K8dxsKNcmY8/RpVShibIK+T0d9PlD
qT9r7lha7ZimdS14I1M1fgGtsBBk6TXCwxQ9Pifxq5QDIw08mhI3TdlmuexMPmYB
3wgi6V1gWhlXZnulp3239r06xDSKU7iLmYfgHUVe8dA+ql6rpN4=
=SufS
-----END PGP SIGNATURE-----

--=-uUtEAudNqpCcJkrqUv+r--

