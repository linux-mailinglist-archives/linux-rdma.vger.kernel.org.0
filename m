Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C078853D0
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Aug 2019 21:42:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388830AbfHGTmT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 7 Aug 2019 15:42:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48602 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388601AbfHGTmT (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 7 Aug 2019 15:42:19 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CC5D530017A3;
        Wed,  7 Aug 2019 19:42:18 +0000 (UTC)
Received: from linux-ws.nc.xsintricity.com (ovpn-112-53.rdu2.redhat.com [10.10.112.53])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B8C505C21E;
        Wed,  7 Aug 2019 19:42:17 +0000 (UTC)
Message-ID: <9b13eb08e454f641c55dfb0e459d8c1922632668.camel@redhat.com>
Subject: Re: [PATCH V3 for-next 03/13] RDMA/hns: Update the prompt message
 for creating and destroy qp
From:   Doug Ledford <dledford@redhat.com>
To:     Lijun Ou <oulijun@huawei.com>, jgg@ziepe.ca
Cc:     leon@kernel.org, linux-rdma@vger.kernel.org, linuxarm@huawei.com
Date:   Wed, 07 Aug 2019 15:42:15 -0400
In-Reply-To: <1564821919-100676-4-git-send-email-oulijun@huawei.com>
References: <1564821919-100676-1-git-send-email-oulijun@huawei.com>
         <1564821919-100676-4-git-send-email-oulijun@huawei.com>
Organization: Red Hat, Inc.
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-MCkHH9jm42bv8G3S+Ksc"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Wed, 07 Aug 2019 19:42:18 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


--=-MCkHH9jm42bv8G3S+Ksc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 2019-08-03 at 16:45 +0800, Lijun Ou wrote:
> -                       dev_err(dev, "modify QP %06lx to ERR
> failed.\n",
> -                               hr_qp->qpn);
> +                       ibdev_err(ibdev, "modify QP to Reset
> failed.\n");

Mixing a fix and a transition to a new API in the same patch...

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

--=-MCkHH9jm42bv8G3S+Ksc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAl1LKZcACgkQuCajMw5X
L93XXxAArnoDPGFb5jPeI31PjGwCmZ85u3jcD9lTDnqP8liu5bHgP2QtP7rO5sps
+eqdMz405AMOMSFdqkuQf19zzcbEc769MaqIjlPE3l76/qttrY2IGJNaSmDRrNkD
ozfRpnmMvq4OqMxtB0nAhF3SI9DQ0QNBUBiT5ngONnM0By7pKYnyFZPF1prx4Zk6
1VJ762YMF25rz25pXFN2jTw5iJHU7e8Iqois3XPLHBeROSJsdysgVe1COAJd9lIp
bT1pcg0exboVLNhycqYZZmFa94bf0hNSex9OAWu6O15qJgcUm0UPyDXzxrYVf4rg
P506ji/4YBJ38Gd9k5jvZhsYFa3VEhIell2kWN8/o5ieW299YPWPm80fLrTR3l1w
k8QRJ3CH38h4IdCgYvawsrj125xWEMx1b6El8mm6y9O73QQAUakDqpu/JW1rD1wM
4ehnlQg/gKKrcEQFuhCOaM5h58BX+DIXTfSWGd3RgcIZG/UHRgG1TYA0XHaRpkVm
UrSxTq7EUpUxBdVPMCQc6py4LPJm9vIOttjfNRGSjj9/GHRZrkxSJl2j0qA71rCD
+XyT3eZOJpRWAuSUfsPyAHZvp/BH49t44PLCtn4ZZE6SE8Ze2lSyG43JUcO9vPAT
KqLxSG1t9RUvU7IGvag/dMkDJcYRiVi4V7D5IBy/rRJIJfcmvKc=
=Vcmh
-----END PGP SIGNATURE-----

--=-MCkHH9jm42bv8G3S+Ksc--

