Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1FE58DB825
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Oct 2019 22:12:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389123AbfJQUMJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 17 Oct 2019 16:12:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37188 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727102AbfJQUMI (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 17 Oct 2019 16:12:08 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 48A183175295;
        Thu, 17 Oct 2019 20:12:08 +0000 (UTC)
Received: from linux-ws.nc.xsintricity.com (ovpn-112-37.rdu2.redhat.com [10.10.112.37])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0F70E60852;
        Thu, 17 Oct 2019 20:12:06 +0000 (UTC)
Message-ID: <cca910c4040961729f0f4d0ad248b6b5684c80eb.camel@redhat.com>
Subject: Re: [PATCH rdma-rc] RDMA/mlx5: Clear old rate limit when closing QP
From:   Doug Ledford <dledford@redhat.com>
To:     Leon Romanovsky <leon@kernel.org>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Rafi Wiener <rafiw@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Bodong Wang <bodong@mellanox.com>,
        Oleg Kuporosov <olegk@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>
Date:   Thu, 17 Oct 2019 16:12:04 -0400
In-Reply-To: <20191002120243.16971-1-leon@kernel.org>
References: <20191002120243.16971-1-leon@kernel.org>
Organization: Red Hat, Inc.
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-DezO5nhId02vegqqJ4R0"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Thu, 17 Oct 2019 20:12:08 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


--=-DezO5nhId02vegqqJ4R0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2019-10-02 at 15:02 +0300, Leon Romanovsky wrote:
> From: Rafi Wiener <rafiw@mellanox.com>
>=20
> Before QP is closed it changes to ERROR state, when this happens
> the QP was left with old rate limit that was already removed from
> the table.
>=20
> Fixes: 7d29f349a4b9 ("IB/mlx5: Properly adjust rate limit on QP state
> transitions")
> Signed-off-by: Rafi Wiener <rafiw@mellanox.com>
> Signed-off-by: Oleg Kuporosov <olegk@mellanox.com>
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>

If you are in the process of closing the queue pair, does this solve
some sort of multi-close race, or is it just being pedantic before
freeing the qp struct?

I took it regardless, just curious.

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

--=-DezO5nhId02vegqqJ4R0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAl2oyxQACgkQuCajMw5X
L912cg//UmBhfzZuLUkoVImxgC+KAVmTQ7Xk85J0pNgpvRl3+2Eoygr40Qqof+Rg
gTYXoDb5XDzZgJlZRKdfOO0RT0rDNlyYr8/sSpl6vzXME8zszwdFqR39aOmCsXhI
bkrTqKufm9mX+BxmtGZx946SvCWaOMWxZMeaODWij6xdOsWrDJzawA3k7vY00mSQ
7BsKDize9MWJEDFmjO+EZpKbMnuUqVmlj01+TUwW3IGxJxU8J0xfGAU24yQIS0Xg
PT7tbGVc4MoZo1RP6LHnXep1+LuwgCohIRFSsdbVdmxfhJdz66i0yW9RPVWleKgc
F+wORoyYMW9qRVG6TYxMa1b7yxGLA9JxSS9bBLE7343DvYpFmiF/2SSz34aOFjLx
osPNtfowatGubGGEfhVjpWnw/UPrTFymNi2dcx9+eCHORYE61UmVPbvGoA1SzKDb
UmPAc/MNwQhu/OapXUaIEV2DEpZDN4v3d96Oc8ojMN9lWJ/wYZdPtz+MQbR5MHTR
5y2peg7Seq5yL2HFnMYh7MLikFSrivN1HSm8UmuznXgc2Rl5tWCrAymrdJoq4uCf
dD7CW+zd52zpUOPkaa2DbutY2YLiESqWHDQa8K5K1QVydSm7ybdmfDJyy51PMK/t
o9ZF74ph83OiGHAUN5/ex3eLb+jRBnJUz/qBfaTdPjJQznVcisY=
=axDe
-----END PGP SIGNATURE-----

--=-DezO5nhId02vegqqJ4R0--

