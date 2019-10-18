Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F073BDCEB6
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Oct 2019 20:51:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406456AbfJRSvA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 18 Oct 2019 14:51:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44770 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730816AbfJRSvA (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 18 Oct 2019 14:51:00 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 02C1C7E424;
        Fri, 18 Oct 2019 18:51:00 +0000 (UTC)
Received: from linux-ws.nc.xsintricity.com (ovpn-112-37.rdu2.redhat.com [10.10.112.37])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DEA7860BF4;
        Fri, 18 Oct 2019 18:50:58 +0000 (UTC)
Message-ID: <17b52af6f560552446dc9a56ed87979d5faa0b39.camel@redhat.com>
Subject: Re: [PATCH v1,for-rc] RDMA/siw: free siw_base_qp in kref release
 routine
From:   Doug Ledford <dledford@redhat.com>
To:     Krishnamraju Eraparaju <krishna2@chelsio.com>, jgg@ziepe.ca,
        bmt@zurich.ibm.com
Cc:     linux-rdma@vger.kernel.org, bharat@chelsio.com,
        nirranjan@chelsio.com
Date:   Fri, 18 Oct 2019 14:50:56 -0400
In-Reply-To: <20191007104229.29412-1-krishna2@chelsio.com>
References: <20191007104229.29412-1-krishna2@chelsio.com>
Organization: Red Hat, Inc.
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-/QwhAK2N0lzH/6+HpKFD"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Fri, 18 Oct 2019 18:51:00 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


--=-/QwhAK2N0lzH/6+HpKFD
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2019-10-07 at 16:12 +0530, Krishnamraju Eraparaju wrote:
> As siw_free_qp() is the last routine to access 'siw_base_qp'
> structure,
> freeing this structure early in siw_destroy_qp() could cause
> touch-after-free issue.
> Hence, moved kfree(siw_base_qp) from siw_destroy_qp() to
> siw_free_qp().
>=20
> Fixes: 303ae1cdfdf7 ("rdma/siw: application interface")
> Signed-off-by: Krishnamraju Eraparaju <krishna2@chelsio.com>

Thanks, applied to for-rc.

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

--=-/QwhAK2N0lzH/6+HpKFD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAl2qCZAACgkQuCajMw5X
L92Fcw/+O8tTIzuUJZBGjJthzJA1tXP8OWKtXyTNrdaW42UVihPodk3G9PWUgAma
NZfGTcggBlT7Lt55b6wmygeV2CGZ4IUGL9P5/uPHSimmeaZ9Jg4wqdiuxqm3qVwi
Y497y8DzC8N57OaxD6yVaW0kkn+8fuICpKmQNUh0Y6jLzI57EouM6X1al3x86wXW
PVJCeAwELBcZnE03jIACnm5QdcH3aeWpn1p6/WQWwLH1A+EKNsNfOCBVBOdt+l/c
Mh/HHqXF5ttAUqpF7gYFYpAkxh2GwGRQCbBHBIAAo20PwY7UJd5bA7HnKv6iHJIV
K2VY7YPCFZwtuoCr7ilh5wS0V0u3NoPLE0buw7LEAga5puHXIJ9oOFEKJRMo4+cL
BMuo7FEoBt88m/GOmSTJY7Ix9TCSLFcL/fy4UvNefSB84m7TZXW/tmZ4HpVjLVQV
QAcePRcgM11n7RKg4nVFnhKA6zswOcdude6KT3S33OZZjXDL5SJMKXAURY+/kiz0
KwvvvTVBYJ61wWm9lQNb/YLjRRkEiJsPB+8iKGnxL3BGfEEZx3wCbjwL6Nt9XuxG
3dwWve7JCIBN13ZCRbgy4PF1WN9ERk0gJZ8bJdhK79V3npp6otxmNLkhvmYv+iI4
ffpYvjVdGrFXuU+gVa7X6G7lWJK12Jgqos3j2ZHn56xClkIdIbw=
=uTN8
-----END PGP SIGNATURE-----

--=-/QwhAK2N0lzH/6+HpKFD--

