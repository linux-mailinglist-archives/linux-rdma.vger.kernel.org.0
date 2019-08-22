Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F58099811
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Aug 2019 17:22:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731012AbfHVPWQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 22 Aug 2019 11:22:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38898 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725892AbfHVPWQ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 22 Aug 2019 11:22:16 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0C740369AC;
        Thu, 22 Aug 2019 15:22:16 +0000 (UTC)
Received: from linux-ws.nc.xsintricity.com (ovpn-112-63.rdu2.redhat.com [10.10.112.63])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1C6075D9D3;
        Thu, 22 Aug 2019 15:22:11 +0000 (UTC)
Message-ID: <879535ec016eb017dcff54cb9b90f660be1c5cdb.camel@redhat.com>
Subject: Re: [PATCH] RDMA/siw: Fix SGL mapping issues
From:   Doug Ledford <dledford@redhat.com>
To:     Bernard Metzler <bmt@zurich.ibm.com>, linux-rdma@vger.kernel.org
Cc:     krishna2@chelsio.com
Date:   Thu, 22 Aug 2019 11:22:09 -0400
In-Reply-To: <20190822150741.21871-1-bmt@zurich.ibm.com>
References: <20190822150741.21871-1-bmt@zurich.ibm.com>
Organization: Red Hat, Inc.
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-b3bL03VyKIrZI5epZ62m"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Thu, 22 Aug 2019 15:22:16 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


--=-b3bL03VyKIrZI5epZ62m
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2019-08-22 at 17:07 +0200, Bernard Metzler wrote:
> All user level and most in-kernel applications submit WQEs
> where the SG list entries are all of a single type.
> iSER in particular, however, will send us WQEs with mixed SG
> types: sge[0] =3D kernel buffer, sge[1] =3D PBL region.
> Check and set is_kva on each SG entry individually instead of
> assuming the first SGE type carries through to the last.
> This fixes iSER over siw.
>=20
> Fixes: b9be6f18cf9e ("rdma/siw: transmit path")
> Reported-by: Krishnamraju Eraparaju <krishna2@chelsio.com>
> Tested-by: Krishnamraju Eraparaju <krishna2@chelsio.com>
> Signed-off-by: Bernard Metzler <bmt@zurich.ibm.com>

Thanks Bernard, applied to for-rc.

Also, please address Leon's comments on the 32/64bit patch and repost,
I'd like it to go in this week too.

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

--=-b3bL03VyKIrZI5epZ62m
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAl1esyEACgkQuCajMw5X
L91deA/+L0QHSnoE9sNZ1uiN22jPF5xG6zmCir7v18nk4nMpQQQ9+DPWLud1Uf+/
lyoTJR2Bo+b7ZYFH5Wql+Q0J2JdW9jcshNfCLBXHOxW5pT7qNIge4x3PJ012A6BR
oDVUoGC8AHvsyBmoSIEBRq62wkllsaCgf3Tn32d++bJXQyfJqJvnwKQK/ktyTUDB
Siatx5xHEKEDCzTUWBKlSraIq51LBv+N8OWLkRyJDOVGOWqYjPSAV3aUpCig9p52
YgjmPSAhdmNm6QJw2+mNExYvJQW8lXyBVn8TCcugaQa171rJK0+epJvdqPmnxJgZ
Iis1QXVF3VN6iGCjwprxLibez8DtoAzSrYvXaQqji75wIelNh3aROZAk2dw1xw7U
nigTFKdaguydb4phZ0hB33GP7uhWeQBPWNwGmgsSshQIYi4k9p2XYjoF+agR+R9J
VZYhP70ha3YCVhmLgJ7Mq9+oYhc46PN1yA33BvyaYXU7kYYVOvmgoMX/QvEgeasP
U9x6cNxWQK0xwFiN0r6FsVfs7KcZ5hwi/S2Bc5OfhyMWoNRsuRq50tvkkLznT6wr
NMSjMGDoKhsciwS24y7MQRsYPN7GnSb0BNelN2WAfW1g+ZNdOEMYg3Z+0LO5rNfI
f2Sk/IZvWKx+pVrC2wRLcFfPFZtRN7uThbAUL+63MYRikU8sLFQ=
=55ns
-----END PGP SIGNATURE-----

--=-b3bL03VyKIrZI5epZ62m--

