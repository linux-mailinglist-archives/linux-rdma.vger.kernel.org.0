Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 828BE4D53C
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Jun 2019 19:28:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726750AbfFTR2e (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 20 Jun 2019 13:28:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33800 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732248AbfFTR2d (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 20 Jun 2019 13:28:33 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7E13030832F4;
        Thu, 20 Jun 2019 17:28:33 +0000 (UTC)
Received: from linux-ws.nc.xsintricity.com (ovpn-112-50.rdu2.redhat.com [10.10.112.50])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6AECF608D0;
        Thu, 20 Jun 2019 17:28:31 +0000 (UTC)
Message-ID: <8dd66ca5a49c34ac118d5686a04512ddc0c65626.camel@redhat.com>
Subject: Re: [PATCH V5 for-next 0/3] Add mix multihop addressing for
 supporting 32K
From:   Doug Ledford <dledford@redhat.com>
To:     Lijun Ou <oulijun@huawei.com>, jgg@ziepe.ca
Cc:     leon@kernel.org, linux-rdma@vger.kernel.org, linuxarm@huawei.com
Date:   Thu, 20 Jun 2019 13:28:29 -0400
In-Reply-To: <1559976370-46306-1-git-send-email-oulijun@huawei.com>
References: <1559976370-46306-1-git-send-email-oulijun@huawei.com>
Organization: Red Hat, Inc.
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-t1x5hGmRMUzuv3ahC1cM"
User-Agent: Evolution 3.32.2 (3.32.2-1.fc30) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Thu, 20 Jun 2019 17:28:33 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


--=-t1x5hGmRMUzuv3ahC1cM
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 2019-06-08 at 14:46 +0800, Lijun Ou wrote:
> This patch series mainly adds a mix multihop addressing for support
> the 32K
> specification of send wqe from UM.
>=20
> It adds the MTR (memory translate region) design for unified
> management of
> MTT (memory translate table). The MTT design requires that the hopnum
> of
> the address space must be the same and cannot meet the requirements of
> the
> current max hopnum of the hip08. The hopnum of sqwqe up to 3 level and
> the extend sge up to 1 level. As a result, we add an MTR based on mtt
> to
> solve this problem.
>=20
> The MTR allows a contiguous address space to use different hopnums, so
> that
> the driver supports the mixed hop feature in UM.
>=20
> Change from V4:
> 1. Remove the unnecessary mb().

It looks like you addressed all comments lef ton v4, so after looking
through this eye bleeder, applied to for-next, thanks.

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

--=-t1x5hGmRMUzuv3ahC1cM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAl0Lwj0ACgkQuCajMw5X
L92rtg//dnHoTAvB+Dv5wdtyLjywqN7darx+gighPRrJssxbq5a5KBq1aKmreCzM
zGPNqYPjrfQkawnMUySqC02qXloYtye6uu/q2BtQHRRX/Xs8QgvSlTIqdqkjhKhe
bVT/3bJd7Tp9s+aKsM9izvAZ3P0KHp/2O9P+5eRXLEqlG/d9fJEALloQH1KHcrkx
cBAOvJfHjhszqCYe+mqNsYrxozj0SL4gGjx4MvIHkZSN7oFdWg2pRYwQ31WlryDv
C+MZgGECc7ou/z7TmPX5utln9/1G+C+vfwVIKMsHK4KTkwFDlGg3MC+DVE20QEvm
AAeT2JAnE0cKCc4IdNK7h1mu3RWK1hAVAGyC858qyOY5LyXN8PlEn/sgrdtqr2ww
7j7DO9jPqSttO6NVPgtYzxLHa7gOtnqzWjGuts873ENmyo/Aw55Ir02WAsd/DrUE
7Zc5/DT85HVBXmXijt0hzFvJCiGp4KRNltsRrsmu5YFL9ItfW6rwsUJf7umZC59H
bPAoqpZ2mEZFlUvcRoEj1FYodhYLEvj+KLh1aOUxdbO7vQ+TH5JiHS5FBM3c6I6C
1wf/1r6SjOOfP4X8D+UsL+0AvpOVsbUWdjHDm3rHpE0YK7Dem+4Siw3tYmg7AeNz
3+mfHG9Prij7u5g7iM0IaoAcYZwTZ7B78RAh9m1Ib3f4Vt0Y3ww=
=8aKm
-----END PGP SIGNATURE-----

--=-t1x5hGmRMUzuv3ahC1cM--

