Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9ECAB8A183
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Aug 2019 16:48:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbfHLOsh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 12 Aug 2019 10:48:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54008 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726710AbfHLOsh (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 12 Aug 2019 10:48:37 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3C1184FCD6;
        Mon, 12 Aug 2019 14:48:37 +0000 (UTC)
Received: from linux-ws.nc.xsintricity.com (ovpn-112-57.rdu2.redhat.com [10.10.112.57])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 27B69646B0;
        Mon, 12 Aug 2019 14:48:35 +0000 (UTC)
Message-ID: <28d5152d139227ef27a8cba1f76e3b9abbba08a5.camel@redhat.com>
Subject: Re: [PATCH V4 for-next 00/14] Updates for 5.3-rc2
From:   Doug Ledford <dledford@redhat.com>
To:     Lijun Ou <oulijun@huawei.com>, jgg@ziepe.ca
Cc:     leon@kernel.org, linux-rdma@vger.kernel.org, linuxarm@huawei.com
Date:   Mon, 12 Aug 2019 10:48:33 -0400
In-Reply-To: <1565276034-97329-1-git-send-email-oulijun@huawei.com>
References: <1565276034-97329-1-git-send-email-oulijun@huawei.com>
Organization: Red Hat, Inc.
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-VcYw/z3DIiNvedWQjoi1"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Mon, 12 Aug 2019 14:48:37 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


--=-VcYw/z3DIiNvedWQjoi1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2019-08-08 at 22:53 +0800, Lijun Ou wrote:
> Here are some updates for hns driver based 5.3-rc2, mainly
> include some codes optimization and comments style modification.
>=20
> Change from V3:
> 1. Separate ibdev print replace for a single patch
> 2. Fix the comments gived by Doug Ledford
>=20
> Change from V2:
> 1. Remove the unncessary memset opertion for the tenth patch
>=20
> Change from V1:
> 1. Fix the checkpatch warning
> 2. Use ibdev print interface instead of dev print interface in
>    this patchset.

Thanks, series applied to for-next.

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

--=-VcYw/z3DIiNvedWQjoi1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAl1RfEEACgkQuCajMw5X
L92X1w/+JGJs3wRQFqN+s3kVlafKaAU3iOuqg4foLYfIhbBCKIASBUZaglwL3Y7r
Y3zFCf26RJZVam1APnl6TTD5t/aFt4m6GlenXilnplIcGCccgnsz1sH3iO5Gzyw3
mAyzB6MZn0eO3HSteNOBA+SbMZG5tiK3CmEXOd+DV98j00sjpdOHH+cLvtYWNqeV
HPGqPM3iOcO3CYOyl7vlC5HsvJqYr1ZjCz4vv34fV97xVnt/FaT9lhaYSpbx3SwF
/Hkbp9qAt2SnXyr8uZMLT7LWrasUOM8MMFd2SuQCNp2alWV5QS8pFemi+0L0ENRt
8USXWRJQnKDieN/aFe/F8olXs3lKDUld5mfiogYHmt36WMOX9uVJAndzOWQ0cRqC
tgQPnSrLQdxcxvh8Lfe1I+hpDztkOBq+6lEzrGPwzm76WPinN0yW3MbQm6GvrHzn
pXN6XjpWozrGhfJXQdi/cRhzqNGqp0Z/JSXw8fcf9An/sYYskZUiSrKz82ryf0b8
5S0rWUjUgVz27e/bedg448aDvO84/VJNL4/KhPQcPVOaGjvjwsUNh27yKOPFizIC
/1JW8NmFQFPtyMypgRsMEonul2/sGbN3fiYBJCmLb+cbihBR0gznGBGYnFb6/xzt
0FdS8PqxPVIGCbNnYk7sKr27iacNylRimfrmMa7pL9UkimW65rY=
=Dew4
-----END PGP SIGNATURE-----

--=-VcYw/z3DIiNvedWQjoi1--

