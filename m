Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 665A74DA6C
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Jun 2019 21:41:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbfFTTle (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 20 Jun 2019 15:41:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36464 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726293AbfFTTle (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 20 Jun 2019 15:41:34 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 285E1308339E;
        Thu, 20 Jun 2019 19:41:34 +0000 (UTC)
Received: from linux-ws.nc.xsintricity.com (ovpn-112-50.rdu2.redhat.com [10.10.112.50])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2497A19C77;
        Thu, 20 Jun 2019 19:41:32 +0000 (UTC)
Message-ID: <6db360d5794ddbc5d5e98e2fbc6cb653fddb83fd.camel@redhat.com>
Subject: Re: [PATCH rdma-next] RDMa/hns: Don't stuck in endless timeout loop
From:   Doug Ledford <dledford@redhat.com>
To:     Leon Romanovsky <leon@kernel.org>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Lang Cheng <chenglang@huawei.com>
Date:   Thu, 20 Jun 2019 15:41:30 -0400
In-Reply-To: <20190616120558.12960-1-leon@kernel.org>
References: <20190616120558.12960-1-leon@kernel.org>
Organization: Red Hat, Inc.
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-Pa1tB4SdZZlCNktuqBOq"
User-Agent: Evolution 3.32.2 (3.32.2-1.fc30) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Thu, 20 Jun 2019 19:41:34 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


--=-Pa1tB4SdZZlCNktuqBOq
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 2019-06-16 at 15:05 +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@mellanox.com>
>=20
> The "end" variable is declared as unsigned and can't be negative, it
> leads to the situation where timeout limit is not honored, so let's
> convert logic to ensure that loop is bounded.
>=20
> drivers/infiniband/hw/hns/hns_roce_hw_v1.c: In function
> _hns_roce_v1_clear_hem_:
> drivers/infiniband/hw/hns/hns_roce_hw_v1.c:2471:12: warning:
> comparison of unsigned expression < 0 is always false [-Wtype-limits]
>  2471 |    if (end < 0) {
>       |            ^
>=20
> Fixes: 669cefb654cb ("RDMA/hns: Remove jiffies operation in disable
> interrupt context")
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>

Thanks, applied to for-next.

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

--=-Pa1tB4SdZZlCNktuqBOq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAl0L4WoACgkQuCajMw5X
L93QtBAAoHmiK7d7oEqZocRBVPi9zpcDfZsLQdf59C/1tWdszmta3OQbcVt7MlA8
oD0GmBWovWonVD1sAUSHKilSgdoUVeVNhklrkIN2uxQ1nhmp0RCMI8XFLSfqtSlg
Xu7jTKVYKPW+TinWrNms+Wzj5Sj0ptJ1oJCcYqOeJ3V1F2jS88P1weXsC0Dqotdz
wszF4cZd4CKzXfsZ/CDVrCsUcJISL2OVdZ0mWK6DeZtIciSHBKhvLQWBjcqNqw0S
GK40Xkp52wt6VO46G38g6I21/8hhNBTQTo1wdPO/yyXAqJjT0kJy5jarvrwyRzfC
2hZ5Hf1Hux/jhWx49qYNtUg49Ov2woBkH4MKLxCDDs/T41IW4E5ONA6vCXJ5mx+9
HKsOJZwp6nMhgHQhOcbQy2HwWmxdFNUef4Zhb6Mj9fh/xymK1CvpnAsNvt23P23J
28181MYIavFaQXNQU1If1NGBuEE8rbfPHtn55N7imzmlVJu+4yU7N+W1wR16qUaG
2EPg2/miV1slGNDv2MKcFUenOcU3f7B5KMMujsvTtdCJ1daRYBk2Hl+BaloWvl/N
SEx+/eHdLcWRs0Zn2Yb9ZUoQBsLiLFniULONWU6QqrxADKpvwZxSVhh2bOj7AW8V
NAaahWa4TWY1RwvaCTpOOr8sj52+n0jKuyYz+wpYqzk2mqWwdxA=
=+aR6
-----END PGP SIGNATURE-----

--=-Pa1tB4SdZZlCNktuqBOq--

