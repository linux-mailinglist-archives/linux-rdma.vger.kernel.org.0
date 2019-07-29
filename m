Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C9AC78F15
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Jul 2019 17:22:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387925AbfG2PW6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 29 Jul 2019 11:22:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51428 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387913AbfG2PW6 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 29 Jul 2019 11:22:58 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3E3AB30A7C63;
        Mon, 29 Jul 2019 15:22:58 +0000 (UTC)
Received: from linux-ws.nc.xsintricity.com (ovpn-112-50.rdu2.redhat.com [10.10.112.50])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 15A84600F8;
        Mon, 29 Jul 2019 15:22:56 +0000 (UTC)
Message-ID: <c6070b365c50bdaeeaa6ab0f51408bc8ee760d41.camel@redhat.com>
Subject: Re: [PATCH rdma-next 0/2] Add per-device Q counters support
From:   Doug Ledford <dledford@redhat.com>
To:     Leon Romanovsky <leon@kernel.org>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Daniel Jurgens <danielj@mellanox.com>,
        Parav Pandit <parav@mellanox.com>
Date:   Mon, 29 Jul 2019 11:22:54 -0400
In-Reply-To: <20190723073117.7175-1-leon@kernel.org>
References: <20190723073117.7175-1-leon@kernel.org>
Organization: Red Hat, Inc.
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-m4We9HYsJwfs2LuGyMub"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Mon, 29 Jul 2019 15:22:58 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


--=-m4We9HYsJwfs2LuGyMub
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2019-07-23 at 10:31 +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@mellanox.com>
>=20
> Hi,
>=20
> This series is based on top -rc series [1] and may be considered
> to be part of it, but can go to -next too.
>=20
> Thanks
>=20
> [1]=20
> https://lore.kernel.org/linux-rdma/20190723065733.4899-1-leon@kernel.org
>=20
> Parav Pandit (2):
>   IB/mlx5: Refactor code for counters allocation
>   IB/mlx5: Support per device q counters in switchdev mode

I don't think this series is really -rc material.  Too much churn for
something where the user would have to actively go read files in /sys in
order to even make any sort of problems appear.

Assuming my build test completes, applied to for-next.  Thanks.

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

--=-m4We9HYsJwfs2LuGyMub
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAl0/D04ACgkQuCajMw5X
L91+rg/8CDqyR312PlRp7U2JPiA42uYBH1mifCIE4nXqcEEpRlCCytImTZ/CUOPW
ZmdkVQMmFj3+Xi7OVFXFi2XlkkOxKrQoEDIIfUxjyy/mPTa+Cq0iJ8iv3L+7IUxO
jUAVTvTMlsbd3i9PmUW9gVfOm+VUQ4nvhRlspWdjc15pPvLATQcfkrIoVJxAW7mb
/0/oLXrr6oR90IkXTcRkV69LpFKIelaeZd/QfdIEDDSg2C2AEN5vynEHA2EwuImf
ucB8i2tmLCZr6PctZ/1kHog5iUsIYSTlMtoSHG+SeS5OlbcxtIvtwIijJJYmIhj0
VEojmPY1BJMOKZDRUYPvgFFLeAf7lCWVNAS9JyYx9NeLNlCoz70js7nlLusjluqS
p3UiNxeFJoqURLpaF0XR1nEY+Ab7pA2HjPAXb9Nc/dx0QX6o/Ebe2XNcJ9m4ytHx
qa4/idgP1OlyDP6Njc27EFd6hD5TTQptc+50grfPPWid5YwcbZ5mFB7E0dm52a9c
KTKuHMvE50sALElMRS7klsXg/EEQkWTAwIPGu9gXFJNTDeD+1InpygKfL+VXYBEc
daT5RPq8kj8avNvTRhe0loX2V2GNFYjqjLW7KBHtoSRQYB1pgLLZkhFEdLNm+TfQ
ITjw8/9pzhkH5zaXJkYSXMswbsZPabgK++ewyVndoHFqWs4Boa0=
=gIgl
-----END PGP SIGNATURE-----

--=-m4We9HYsJwfs2LuGyMub--

