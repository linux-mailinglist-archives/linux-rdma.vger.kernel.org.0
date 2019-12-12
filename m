Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71A5411D8FE
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Dec 2019 23:01:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731199AbfLLWB1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 12 Dec 2019 17:01:27 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:57027 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730942AbfLLWB1 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 12 Dec 2019 17:01:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576188085;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=m22C95Paeme7JTHvJ55ubi1a/2k90u/xN4SlJ+0A+6I=;
        b=CAQDHjLVb7TFfGgwj9UpgVDMMsEw+wmCuqIx0xKk8i3e/fnbwE2eXbVxXm+hwICNEwOeyX
        3lxfO+6UyvEUfd40Ze2dyniUUX8C7JAAC/l+TUOMQSGeZ5LeV02F6aPil4XRH9HMYiz4v3
        qQO9mYlbzvl2rGIY67mPeCCI/uoPvto=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-360-NNDjoSYENWS16utK7F9-2Q-1; Thu, 12 Dec 2019 17:01:13 -0500
X-MC-Unique: NNDjoSYENWS16utK7F9-2Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B85E51083E94;
        Thu, 12 Dec 2019 22:01:12 +0000 (UTC)
Received: from linux-ws.nc.xsintricity.com (ovpn-112-42.rdu2.redhat.com [10.10.112.42])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E14E7669E5;
        Thu, 12 Dec 2019 22:01:11 +0000 (UTC)
Message-ID: <2e16247d69f4c2ab924b67ae85757184f6bcc741.camel@redhat.com>
Subject: Re: [PATCH rdma-rc 2/2] IB/mlx5: Fix device memory flows
From:   Doug Ledford <dledford@redhat.com>
To:     Leon Romanovsky <leonro@mellanox.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     RDMA mailing list <linux-rdma@vger.kernel.org>,
        Ariel Levkovich <lariel@mellanox.com>,
        Yishai Hadas <yishaih@mellanox.com>
Date:   Thu, 12 Dec 2019 17:00:49 -0500
In-Reply-To: <20191212112144.GW67461@unreal>
References: <20191212100237.330654-1-leon@kernel.org>
         <20191212100237.330654-3-leon@kernel.org> <20191212111457.GV67461@unreal>
         <20191212112144.GW67461@unreal>
Organization: Red Hat, Inc.
User-Agent: Evolution 3.32.5 (3.32.5-1.fc30)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-ff0B/LWO7x57lIpg7cUR"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--=-ff0B/LWO7x57lIpg7cUR
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2019-12-12 at 11:21 +0000, Leon Romanovsky wrote:
> > > @@ -2288,8 +2332,9 @@ static int handle_alloc_dm_memic(struct
> > > ib_ucontext *ctx,
> > >   {
> > >      struct mlx5_dm *dm_db =3D &to_mdev(ctx->device)->dm;
> > >      u64 start_offset;
> > > -   u32 page_idx;
> > > +   u16 page_idx =3D 0;
> >=20
> > This hunk is not needed.
>=20
> To be clear, I wanted to say this about "=3D 0" part. The change of the
> type is still needed.
>=20
> Thanks

I fixed it up when I took the two patches.  Applied to for-rc, thanks.

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

--=-ff0B/LWO7x57lIpg7cUR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAl3yuJEACgkQuCajMw5X
L93VjA/9G5zVnVNwVv2NX+GhqORwoP9W2R/yTxwHVe2Jl18AoW/Yg2fob40zpQ8D
eJZgbYMpjOXHy5zAYkZyPitmtPY+Jy6YjZWthwfeMwtLhCoDF/4hwkMHHk0GzIjk
9YVnrHdc8cxxlcF+fVycGAkiX0t4ZUm5fVTirfkcQHPeSVSOh7AxVxq9S6haC+Dr
ikGICzOQo6LttEAJumy+0GXiZDPF8KK0+KprDIwNe4BSFORh6RZ2miLrmt1FkXP3
ny9zEDjfe2yCvVWgo/HLkEgwM/BQrZ7glPEhuQGrNU8cD0jA6dVNV7PZRKdhPee/
RcmXnrd2zsNEssiUVMDgJsMBqnrnYcWZuYIgRoYU5OvQGH1607grb3AWh3h2Vwe6
3tNiJe3GEOyzov5OTJC57qggwK6UcAuz1vrUGO/UTtX06jNWmtnUu0eX7GdcEv27
g2Dl9l8P44S8a4+O7qL56aXaJpBLe+7qa6pPM4y1Wx572rHy+N6lmZMYJER/iJTh
Eupam7RkmObKAYIy29ZZ3UQqRrSD6lqAexmhHr6glsBr6W+7A6QqZJuwIBy5iD8Z
GzeGOIPdeuYkcSY2+d7uOUtomGTYKn3AEQGioOfsoix9juaxThTyja1m5NpDyGOC
eqvkD13gv3MBVMfyTjh0rEW1Jn187GE+8t+B0vfuxkjGKv7vAeY=
=ogHv
-----END PGP SIGNATURE-----

--=-ff0B/LWO7x57lIpg7cUR--

