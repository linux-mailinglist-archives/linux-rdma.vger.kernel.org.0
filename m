Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E3579674D
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Aug 2019 19:19:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727358AbfHTRSb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 20 Aug 2019 13:18:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41968 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725971AbfHTRSb (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 20 Aug 2019 13:18:31 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A03188CF1A3;
        Tue, 20 Aug 2019 17:18:30 +0000 (UTC)
Received: from linux-ws.nc.xsintricity.com (ovpn-112-63.rdu2.redhat.com [10.10.112.63])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9699E87D8;
        Tue, 20 Aug 2019 17:18:28 +0000 (UTC)
Message-ID: <7a31367cc513555572c5c29242c963517f62e99c.camel@redhat.com>
Subject: Re: [PATCH] IB/mlx4: Fix memory leaks
From:   Doug Ledford <dledford@redhat.com>
To:     Wenwen Wang <wenwen@cs.uga.edu>
Cc:     Yishai Hadas <yishaih@mellanox.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "open list:MELLANOX MLX4 IB driver" <linux-rdma@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Date:   Tue, 20 Aug 2019 13:18:26 -0400
In-Reply-To: <1566159781-4642-1-git-send-email-wenwen@cs.uga.edu>
References: <1566159781-4642-1-git-send-email-wenwen@cs.uga.edu>
Organization: Red Hat, Inc.
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-6zwfwL9XMtn/nWST38YW"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.69]); Tue, 20 Aug 2019 17:18:30 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


--=-6zwfwL9XMtn/nWST38YW
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 2019-08-18 at 15:23 -0500, Wenwen Wang wrote:
> In mlx4_ib_alloc_pv_bufs(), 'tun_qp->tx_ring' is allocated through
> kcalloc(). However, it is not always deallocated in the following
> execution
> if an error occurs, leading to memory leaks. To fix this issue, free
> 'tun_qp->tx_ring' whenever an error occurs.
>=20
> Signed-off-by: Wenwen Wang <wenwen@cs.uga.edu>
> ---

Thanks, applied to for-rc.

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

--=-6zwfwL9XMtn/nWST38YW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAl1cK2IACgkQuCajMw5X
L92MDA/+P579esW/9HD0X22caGRfpTLqsO8tlrS35MI7lksU4Bk0Y52wOxhBfmab
ZgoQ4GwP6ebfaix49PIlr00Wl3+9q2VYSo9xTjw1wA7EjWs70o9PeNdgka9PZmwI
ytuVIsiVrvsv5/ZrPJD2tF6q3+HGF1G2K8ow2KcCem3FRR+mANQjRKzZmc9S9P7N
GAqT5vGOo8inFvhQ4ZZ7lr41+ywMHRVJ7uXYqGkDU0ctddhHIZ9UqklbRM2XSOsz
+lZrSABfCZBzReQiHU2EkebKxkpymBhhZgQLwBfyOaI2tq726L7j47UoRDimyTgR
GIwO8uYtTWKkWb7eYWmL+nBQME+/aR/mlvjgAtxDy+rxBF4CgQbzpW9/kcTParxb
aHhhTRW7ZdnpidlriB0EZucLC3WwWjc5SCtKeCUPXYeLQwg66i+Vmsuu6DwDW9A/
0DPoB8kaKKvxmITwBl/cKRjJHclXLF8bp6eGFcua2tIGLuuCQpNk7eCEj1IK/Sy4
FI5enleFLoaqCT5H6ozDNIycL/e6yFlCght0fc1HXdYSh36bSrK9v+Y5vq4Ryung
ZJJ07yJcKECazHLF+foY2s+uIbSX6M+RdYRG53yBqCM8f7ysc/4h10IFHZ4HkQD2
DrYq3aEswCgEJe3QK9vm+6xg3L0q/vd260FS9wNWRxNWaoXMSH0=
=cRnD
-----END PGP SIGNATURE-----

--=-6zwfwL9XMtn/nWST38YW--

