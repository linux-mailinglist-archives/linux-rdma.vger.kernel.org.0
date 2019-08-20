Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6058096793
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Aug 2019 19:29:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729803AbfHTR2u (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 20 Aug 2019 13:28:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42870 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726717AbfHTR2t (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 20 Aug 2019 13:28:49 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 86A242F3669;
        Tue, 20 Aug 2019 17:28:49 +0000 (UTC)
Received: from linux-ws.nc.xsintricity.com (ovpn-112-63.rdu2.redhat.com [10.10.112.63])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A850E18344;
        Tue, 20 Aug 2019 17:28:48 +0000 (UTC)
Message-ID: <c0215e8e0daea78d8188f15a210c1ace7e076107.camel@redhat.com>
Subject: Re: [PATCH rdma-next] RDMA: Delete DEBUG code
From:   Doug Ledford <dledford@redhat.com>
To:     Leon Romanovsky <leon@kernel.org>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Date:   Tue, 20 Aug 2019 13:28:46 -0400
In-Reply-To: <20190819114547.20704-1-leon@kernel.org>
References: <20190819114547.20704-1-leon@kernel.org>
Organization: Red Hat, Inc.
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-m055lBEZphSGOxlTGc7g"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Tue, 20 Aug 2019 17:28:49 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


--=-m055lBEZphSGOxlTGc7g
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2019-08-19 at 14:45 +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@mellanox.com>
>=20
> There is no need to keep DEBUG defines for out-of-the tree testing.
>=20
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>

Applied to for-next, thanks.

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

--=-m055lBEZphSGOxlTGc7g
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAl1cLc4ACgkQuCajMw5X
L93ljw//YCtMJfe4z44UDVr7OtUF4nGnKqLzqwfQNSQTZN11wHTgmAsQIYpLAxyx
xQBKYtJySHOT3Ua5gu+LbSfb5AzgVoCdISNBkSh/ovJNwadqAbf1dxsDXKiPkF5U
PXBDbKxwPKtg6WaOjHx+84mZIjx9pIN/q+gont6Ha727LxmMFsjK8rMvbSC4o/qs
OjU9z2oE+PgFdbwZZaNwmernqvWgP6OFTpLBvp3Nykmo5sJ9+bBDPwStr9EB7zQJ
uuW8K40+Dy6iyKo+txfst3uQvMSE4+h/rjla8Fj1scmBiR7uHuVRtH1eTF9dwgnE
OeOKYi14G4N4Q/DMjTvuKziAPB+JFbHIw8Nqb6hw9oIIWsz6ID+IsqQEOzwVyVAJ
JenbHajpGMzJcxnUQoI/CJ4hmP+/QAUzYmofPgtXp/eq53mj/sHlMSRt0SsX4w6c
cUK7JyJR+qkboMtFkUqx9Rhpi8CgrBHZRELD+Xq0QkJwud/zmBs9ouqdPGBMeuNz
0/Y6ujPSJrNh610NDSQUvINW2+Exnxq2A9Yep/EjcqMdhi85KhbMpj0YvYMTa5h+
BiP1+4e7mDM+CLMlerrQpXkwKmjIbfl+1ZGKibEm2tGhpQjwXxNzROtktyKqC24j
pA4gCFhgk9sSMtaMAHqI7ty6yKDvoB7jl5AMmCc0bjTgApZELYU=
=I3Ad
-----END PGP SIGNATURE-----

--=-m055lBEZphSGOxlTGc7g--

