Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4C7D966DE
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Aug 2019 18:56:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729833AbfHTQ4m (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 20 Aug 2019 12:56:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:12143 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729827AbfHTQ4m (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 20 Aug 2019 12:56:42 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C295A18C8903;
        Tue, 20 Aug 2019 16:56:41 +0000 (UTC)
Received: from linux-ws.nc.xsintricity.com (ovpn-112-63.rdu2.redhat.com [10.10.112.63])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E86C71B468;
        Tue, 20 Aug 2019 16:56:39 +0000 (UTC)
Message-ID: <a263ac8f6c8340f050ca28394361aa956ac94cb4.camel@redhat.com>
Subject: Re: [PATCH rdma-rc 0/8] Fixes for v5.3
From:   Doug Ledford <dledford@redhat.com>
To:     Leon Romanovsky <leon@kernel.org>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Guy Levi <guyle@mellanox.com>, Ido Kalir <idok@mellanox.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Majd Dibbiny <majd@mellanox.com>,
        Mark Zhang <markz@mellanox.com>,
        Moni Shoua <monis@mellanox.com>
Date:   Tue, 20 Aug 2019 12:56:37 -0400
In-Reply-To: <20190815083834.9245-1-leon@kernel.org>
References: <20190815083834.9245-1-leon@kernel.org>
Organization: Red Hat, Inc.
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-DczzZcyBpMhBrXO8E6DC"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.70]); Tue, 20 Aug 2019 16:56:41 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


--=-DczzZcyBpMhBrXO8E6DC
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2019-08-15 at 11:38 +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@mellanox.com>
>=20
> Hi,
>=20
> This is a collection of new fixes for v5.3, everything here is fixing
> kernel crash or visible bug with one exception: patch #5 "IB/mlx5:
> Consolidate use_umr checks into single function". That patch is nice
> to have improvement to implement rest of the series.
>=20
> Thanks
>=20
> Ido Kalir (1):
>   IB/core: Fix NULL pointer dereference when bind QP to counter
>=20
> Jason Gunthorpe (1):
>   RDMA/mlx5: Fix MR npages calculation for IB_ACCESS_HUGETLB
>=20
> Leon Romanovsky (2):
>   RDMA/counters: Properly implement PID checks
>   RDMA/restrack: Rewrite PID namespace check to be reliable
>=20
> Moni Shoua (4):
>   IB/mlx5: Consolidate use_umr checks into single function
>   IB/mlx5: Report and handle ODP support properly
>   IB/mlx5: Fix MR re-registration flow to use UMR properly
>   IB/mlx5: Block MR WR if UMR is not possible

Hi Leon,

I took everything except Jason's patch to for-rc.  He had tagged his
patch in patchworks as under review by himself, mainly because there are
some conflicts with other hmm patches I think, so he wanted to process
all the patches himself on a distinct branch to resolve the issues.=20
Thanks.

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

--=-DczzZcyBpMhBrXO8E6DC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAl1cJkUACgkQuCajMw5X
L91hgg//crG2vBnDVFXitj9Uo/pkGPA8rZM7nqzFkeTupe4tWZ3jM3Z/aFPjvSjS
QTXQ/XJMDJ0iWcX9845plKCk3pugWXeppg0z4W/AZiuGuQc+8qhTklofi+NhY8Dz
IPZStSvakcSAN+ZqtPG3m1nrkxpC5qw1tAtxdlo0jXeaE6aLH2LlCpuVfPKZr8cU
g6y0mJNQtcl0LjPjtXMH8mez6AUFH35jgMZV6rYZa2NkT0bpbHb0I6/SvZLsFo3h
MmxGmJsaAcY9fwAKmHIyPCF4vAEA6Rhy0Y8OS6yWLYaz2cf3Srf+JqhtJDQkl/Wu
ZekoQpM3CZsCCo5giZtEDcki/HFdLxK26rMeSshbV+9YfH48pbjMB2GUSJriNgZ7
eCisIWbUPJw40ShanNwRBXh+1kQ1CYE1GpfUUzvpVfY67pH3Ou5p99/ED8pnXAeX
tSi15wvuLzMEGZpkLFktIFX7DlqnGSTTsz6a1TZ/DiPmAYInKQU9SNM+lWPD4uWD
ZShZ/Cg5bMXgaga/nl2eW89Lkjr2hCKew10QUgNpdH3jmfvkqHqiHeiXSodcY8by
DTdzZutONGEHB99aSUqQ250Oo8vqmJXLVwRpGpcscKYQ+2oSBTpopi7Ow8q2MU1M
S0f6E8wG6xVG6JJWCxTecglGFyzCfcUPBfwtCvml4nmtblPd31Q=
=7bS8
-----END PGP SIGNATURE-----

--=-DczzZcyBpMhBrXO8E6DC--

