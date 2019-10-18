Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD77FDCED2
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Oct 2019 20:58:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2443176AbfJRS6E (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 18 Oct 2019 14:58:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46988 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726421AbfJRS6E (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 18 Oct 2019 14:58:04 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5530988FFF7;
        Fri, 18 Oct 2019 18:58:04 +0000 (UTC)
Received: from linux-ws.nc.xsintricity.com (ovpn-112-37.rdu2.redhat.com [10.10.112.37])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3AD2B5C21E;
        Fri, 18 Oct 2019 18:58:03 +0000 (UTC)
Message-ID: <cff5838fdda4c0c5a87c86c13713da153761b04b.camel@redhat.com>
Subject: Re: [PATCH rdma-rc] IB/core: Use rdma_read_gid_l2_fields to compare
 GID L2 fields
From:   Doug Ledford <dledford@redhat.com>
To:     Leon Romanovsky <leon@kernel.org>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Parav Pandit <parav@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Matan Barak <matanb@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>
Date:   Fri, 18 Oct 2019 14:58:00 -0400
In-Reply-To: <20191002121750.17313-1-leon@kernel.org>
References: <20191002121750.17313-1-leon@kernel.org>
Organization: Red Hat, Inc.
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-WyEDtCuJ73XQ/jXolVNa"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.68]); Fri, 18 Oct 2019 18:58:04 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


--=-WyEDtCuJ73XQ/jXolVNa
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2019-10-02 at 15:17 +0300, Leon Romanovsky wrote:
> From: Parav Pandit <parav@mellanox.com>
>=20
> Current code tries to derive VLAN ID and compares it with GID
> attribute for matching entry. This raw search fails on macvlan
> netdevice as its not a VLAN device, but its an upper device of a VLAN
> netdevice.
>=20
> Due to this limitation, incoming QP1 packets fail to match in the
> GID table. Such packets are dropped.
>=20
> Hence, to support it, use the existing rdma_read_gid_l2_fields()
> that takes care of diffferent device types.
>=20
> Fixes: dbf727de7440 ("IB/core: Use GID table in AH creation and dmac
> resolution")
> Signed-off-by: Parav Pandit <parav@mellanox.com>
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>

Thanks, applied to for-rc.

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

--=-WyEDtCuJ73XQ/jXolVNa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAl2qCzgACgkQuCajMw5X
L92KzQ/+MOJZ52WTDAuChIPCuBAzYTwxLGey+3htp5m5bJU/2N+Ghw7GK2JtNOCD
8FIWT4UFIUzT6VJRFcrP4GY+M75asvq/uUp0P0f/WnVFgvEmGuygTzcRAbfgd4Pa
LJ4CPZCTCXdbXskYw9JAlNjbIjPeH42D77NYvQuegHaB+aPSEU09ho9wO64y2ESJ
T8/4mQDD8SxkeEWpqmz9Z+lL8w8B0aigwgWTCc0tUu/wzMdfMv0YY297WYkranuO
GYViPlmoSmANDRCDS6DnPo7Mi66aFr49KHBHqQOuGxrOVMqjON2jhGq+5bhGhAiU
w+kDUT30yC3TREO5Dy6tSFFzgPF7tAWNfD6EpAnMm4puX8SV4BpQNZIJwWx4Vmjc
RnlNk0RB0BuAJCXCMVzM/kanlvOsoPci9b3YsvV74CVXmP2ZzISHGmU+EM2mzVFP
7sfxNxT27aYnDDcemoiZBS3ASFH49MKYOqSggQWKsTenDmQp8Twvq2yyQlJQwM3G
SX1j0TnaWsRb4Fyn8GCMAIBI5rmXfYDso5Nx13Txa6fNcZPcxZM8av+0ZromLR/w
jAi1WEBqIMtQ+VUEsFGzluPYkctKNtHaxzqYwc7NqtVZEy37+ZrsmodPfXlPcFCk
i7fHDWQdI6fm+BKQeZwA4piADdS4vwLl19QIsq1QO73pWZIugAY=
=ovCH
-----END PGP SIGNATURE-----

--=-WyEDtCuJ73XQ/jXolVNa--

