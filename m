Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D9318542C
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Aug 2019 21:58:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388542AbfHGT6U (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 7 Aug 2019 15:58:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53990 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388425AbfHGT6R (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 7 Aug 2019 15:58:17 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AC50530017A7;
        Wed,  7 Aug 2019 19:58:17 +0000 (UTC)
Received: from linux-ws.nc.xsintricity.com (ovpn-112-53.rdu2.redhat.com [10.10.112.53])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5A20B5D717;
        Wed,  7 Aug 2019 19:58:16 +0000 (UTC)
Message-ID: <5900d9f5e0b5657738feaf91806e672ae86142e6.camel@redhat.com>
Subject: Re: [PATCH] RDMA/hns: remove obsolete Kconfig comment
From:   Doug Ledford <dledford@redhat.com>
To:     YueHaibing <yuehaibing@huawei.com>, oulijun@huawei.com,
        xavier.huwei@huawei.com, jgg@ziepe.ca
Cc:     linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Wed, 07 Aug 2019 15:58:13 -0400
In-Reply-To: <20190807032228.6788-1-yuehaibing@huawei.com>
References: <20190807032228.6788-1-yuehaibing@huawei.com>
Organization: Red Hat, Inc.
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-apdjrjw/Omwao7RfCSd/"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Wed, 07 Aug 2019 19:58:17 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


--=-apdjrjw/Omwao7RfCSd/
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2019-08-07 at 11:22 +0800, YueHaibing wrote:
> Since commit a07fc0bb483e ("RDMA/hns: Fix build error")
> these kconfig comment is obsolete, so just remove it.
>=20
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Thanks, applied to for-next.

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

--=-apdjrjw/Omwao7RfCSd/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAl1LLVUACgkQuCajMw5X
L90KUBAAsRGmyM/FtMfAnIMI2GICn3znFimKrljqYyihs6EnqMd7v4OpiPHqoLE8
rS0rCudzXEAuqJ2SZFySqq5YMMhA6YqMvMBzGCAyiTiEmFH+u1Q7cPy9qNJtVNv7
mYoKUw3rNle9jfefSwgbVHrYrZqTOMkknqWVnbuSJWolTr8n0mEZ/C42zhh96dXE
A61zXwzhxZFCZFgZoa+P2gXJRNqPAJJQkSwLr17yQq5smInOP2+N6HFIZlniQRSp
sMyZF4/VrJU/UJa4IttsEg2mhURzr9E23dgA//XfxRtp4oMukpbqgdnFSSJBRBLJ
kcM2apco6qmvBptqHNoCkB4qYf2T8WubzOoEh1xrd2ZVhmXe8N7wIl9tzROQWjVT
ohfc3HwVvceUeeFuZ9WPy3uRwfXhVwr76eLNK2pJX8eUm+iKzDybJGqa6ykfCDyV
g+kPv0ytPwKCjqEyHOipAncbWprnpPDF8bVz4OX+RUv4b7E2mZtuZgic60eSxwIX
bTymiVIgxYvkomzYdxLd8fGtxk6c8MZDe3Mz75r9onVEVuD5NS23Ha9LGZLdUCxW
eSkFkfnOrpVQuKIGokv8WJoGRKRNLRig7VrinOMWkiXZjF8IWULLhvqzl8IQYXHe
QI2Wg0nKyuUdZMvXOTKSakW1zZM7KqEmB7Oux5ZhKltxBwYYPT0=
=fpmo
-----END PGP SIGNATURE-----

--=-apdjrjw/Omwao7RfCSd/--

