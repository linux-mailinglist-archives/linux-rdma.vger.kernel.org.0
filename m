Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65C6841677
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Jun 2019 22:53:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406629AbfFKUxf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 11 Jun 2019 16:53:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38218 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406036AbfFKUxf (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 11 Jun 2019 16:53:35 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AE4A33082231;
        Tue, 11 Jun 2019 20:53:29 +0000 (UTC)
Received: from linux-ws.nc.xsintricity.com (ovpn-112-8.rdu2.redhat.com [10.10.112.8])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CAFB11972B;
        Tue, 11 Jun 2019 20:53:24 +0000 (UTC)
Message-ID: <08ce5b4ed985b885e33054cae6426018b46f67ff.camel@redhat.com>
Subject: Re: [PATCH rdma-next v1 0/3] Convert CQ allocations
From:   Doug Ledford <dledford@redhat.com>
To:     Leon Romanovsky <leon@kernel.org>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Date:   Tue, 11 Jun 2019 16:53:22 -0400
In-Reply-To: <20190528113729.13314-1-leon@kernel.org>
References: <20190528113729.13314-1-leon@kernel.org>
Organization: Red Hat, Inc.
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-KtbPWzUDY0JPEMZJmmN4"
User-Agent: Evolution 3.32.2 (3.32.2-1.fc30) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Tue, 11 Jun 2019 20:53:35 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


--=-KtbPWzUDY0JPEMZJmmN4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2019-05-28 at 14:37 +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@mellanox.com>
>=20
> Hi,
>=20
> This is second version of my CQ allocation patches, rebased to latest
> rdma/wip/for-next branch with changes requested by Gal.
>=20
> Thanks
>=20
> Leon Romanovsky (3):
>   RDMA/nes: Avoid memory allocation during CQ destroy
>   RDMA: Clean destroy CQ in drivers do not return errors
>   RDMA: Convert CQ allocations to be under core responsibility

Series, minus the one hunk in 3/3 that Gal objected to, applied to for-
next.  Thanks.

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Key fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57
2FDD

--=-KtbPWzUDY0JPEMZJmmN4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAl0AFMIACgkQuCajMw5X
L91dHQ//YLNii+TAJVe+V4o5MYj1HBoY/MG/oECztr/jSj1OhEcMpDnb1nN/G1IZ
a4zHgJnWb3FrSfJyk9Tk5AtA7gA9ZuTBysBYYsWAKSKcqyXcE/fXcxI8TIyQyaBo
y08UsED74gJPrWptfDimqJW/7MqZ/+3gKOpUcgBS8TxFSdnV+UU/DcBxYN5UyIiH
pc/rCZNbpwcA5N/c/8+Us8bnWrsm16i/PrCK3L8m47SMF3H3bEcv0gtmkR7HQOfh
DKrPCnmUwxLygGhnUYvEtXSQaWM2mosgaKPSiSq2WpoTnZ72Z4KwI/gFXCoVhUMv
ztRY77CzUNHVgmfAlgVK1JNsAVjyzYoQesZ4loKjsHLh0zt3ICdUemn/hKPzCKzX
3UBiEYhWkEWytXWJCcPDwIwkGmDb1N4+VFvKsqktG1XQal6w/vOmtchUI5uWzIS7
wrdBe7K1tH3ZngC/3DH3jBQEvNIgLGvOz6m4GH5Q8YW7YcV8QaASKGxORJdsHrz8
rzbZgcTthhBrxxt8UCidzOnwKQUumrsWWpiAGft/EXnFZYQFDLey7Zxnh0wu3ygV
EQsyvUJ0iU8m8QbvhbMXng+o7b88fX+fDmkBFbgGs14VwGcHqw40zPcgOlZjz7Wl
5WnsO0dNx4mhoCdvmPKWYSMPRpkA5oL5kXgCmnSrQbx2vqyH1R4=
=CcgA
-----END PGP SIGNATURE-----

--=-KtbPWzUDY0JPEMZJmmN4--

