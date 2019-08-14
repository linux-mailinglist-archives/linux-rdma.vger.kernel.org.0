Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF5B78D6D3
	for <lists+linux-rdma@lfdr.de>; Wed, 14 Aug 2019 17:05:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbfHNPFI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 14 Aug 2019 11:05:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36446 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726509AbfHNPFI (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 14 Aug 2019 11:05:08 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 308798E5AA;
        Wed, 14 Aug 2019 15:05:08 +0000 (UTC)
Received: from linux-ws.nc.xsintricity.com (ovpn-112-57.rdu2.redhat.com [10.10.112.57])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D95D688B2C;
        Wed, 14 Aug 2019 15:05:06 +0000 (UTC)
Message-ID: <f1609a31d9b0d1cdc3b2db38dda1543126755007.camel@redhat.com>
Subject: Re: [PATCH for-next 3/9] RDMA/hns: Completely release qp resources
 when hw err
From:   Doug Ledford <dledford@redhat.com>
To:     Yangyang Li <liyangyang20@huawei.com>,
        Lijun Ou <oulijun@huawei.com>, jgg@ziepe.ca
Cc:     leon@kernel.org, linux-rdma@vger.kernel.org, linuxarm@huawei.com
Date:   Wed, 14 Aug 2019 11:05:04 -0400
In-Reply-To: <0d325f78-a929-f088-cc29-e2c7af98fd40@huawei.com>
References: <1565343666-73193-1-git-send-email-oulijun@huawei.com>
         <1565343666-73193-4-git-send-email-oulijun@huawei.com>
         <f49c56933205d90d82ffd3fa55a951843e22cda1.camel@redhat.com>
         <0d325f78-a929-f088-cc29-e2c7af98fd40@huawei.com>
Organization: Red Hat, Inc.
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-r0AoODz9O6/ASb6poCGk"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Wed, 14 Aug 2019 15:05:08 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


--=-r0AoODz9O6/ASb6poCGk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2019-08-14 at 14:02 +0800, Yangyang Li wrote:
> > I don't know your hardware, but this patch sounds wrong/dangerous to
> > me.
> > As long as the resources this card might access are allocated by the
> > kernel, you can't get random data corruption by the card writing to
> > memory used elsewhere in the kernel.  So if your card is not
> > responding
> > to your requests to free the resources, it would seem safer to leak
> > those resources permanently than to free them and risk the card
> > coming
> > back to life long enough to corrupt memory reallocated to some other
> > task.
> >=20
> > Only if you can guarantee me that there is no way your commands to
> > the
> > card will fail and then the card start working again later would I
> > consider this patch safe.  And if it's possible for the card to hang
> > like this, should that be triggering a reset of the device?
> >=20
>=20
> Thanks for your suggestion, I agree with you, it would seem safer to
> leak
> those resources permanently than to free them. I will abandon this
> change
> and consider cleaning up these leaked resources during uninstallation
> or reset.

Ok, patch dropped from patchworks, thanks.

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

--=-r0AoODz9O6/ASb6poCGk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAl1UIyAACgkQuCajMw5X
L901PBAApBCQCDEYWdUDb4rWUSmsnvCgU8VevmSQgtuGKpiE2RBW2QlGDqxRSJf+
4S9v/vvLSHq9Qzg0euM3S8zZuTfUtqWwEgpfaTik572ou32uWv6lPirgoOatKdcL
VHtNZCy2Yj88gDewxUvCqxTA1e1O9fYou9EN7qbKmuT4UDaGgsX9zEib6lcE6nE/
Vfd5MJBXWzkZCcWsvE4PPE1ATyskOEut2Fd4Q1NdO4GzWz8M/l/DxDnW9Jx19XQe
WM4AvI3OybE9s+Xf2yEWhSb/gdkOqt1f9sZCnMJQtSCH7HoTHIt6jV6uDoUE+lc3
H9qgSMBSBkEUS6CFKVjvaPMYwn/04P1yxexE6d2Yj9Oq66QT0nFsWWrWzH/8JH69
HIFzKjR4ekiwyaM6S7MKiY1xOTh1IIrRhYiubY1fdBPSysBDwxTO13SzWqN0qfhV
P8MJjYDSU0+HzhjP8rbB1CuRvwZoqypmNeDgdUwhWkbY2U+n0X5SZml61R9k4u37
FzdaNCsT8+Y2WbKYCZUvKJmoS3cbFZk/gJBEuDePtO8B/gFoyXnMn9GehcS+Gdj8
tfcsLgmjVxxyZnKNrwnA26v3pN1MZDOPQ8jWoMKMK2xDs5X5NwR1w/KYPQ7byWwu
+1vyKtP8DYgrkn56ErJGc6/VFBYE2ob/oeoRrg1DTkK97xjlsk8=
=JlS9
-----END PGP SIGNATURE-----

--=-r0AoODz9O6/ASb6poCGk--

