Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 321378217C
	for <lists+linux-rdma@lfdr.de>; Mon,  5 Aug 2019 18:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728991AbfHEQQx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 5 Aug 2019 12:16:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59026 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728974AbfHEQQw (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 5 Aug 2019 12:16:52 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 958EF307F5E4;
        Mon,  5 Aug 2019 16:16:52 +0000 (UTC)
Received: from linux-ws.nc.xsintricity.com (ovpn-112-50.rdu2.redhat.com [10.10.112.50])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A0582608C1;
        Mon,  5 Aug 2019 16:16:51 +0000 (UTC)
Message-ID: <91e65313556c231157cae974244f0428ac88f00b.camel@redhat.com>
Subject: Re: [PATCH rdma-next] RDMA/hns: Remove not used UAR assignment
From:   Doug Ledford <dledford@redhat.com>
To:     Leon Romanovsky <leon@kernel.org>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Lijun Ou <oulijun@huawei.com>
Date:   Mon, 05 Aug 2019 12:16:49 -0400
In-Reply-To: <20190801114827.24263-1-leon@kernel.org>
References: <20190801114827.24263-1-leon@kernel.org>
Organization: Red Hat, Inc.
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-RRPfr814EB5STy3piX7m"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Mon, 05 Aug 2019 16:16:52 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


--=-RRPfr814EB5STy3piX7m
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2019-08-01 at 14:48 +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@mellanox.com>
>=20
> UAR in CQ is not used and generates the following compilation
> warning, clean the code by removing uar assignment.
>=20
> drivers/infiniband/hw/hns/hns_roce_cq.c: In function _create_user_cq_:
> drivers/infiniband/hw/hns/hns_roce_cq.c:305:27: warning: parameter
> _uar_ set but not used [-Wunused-but-set-parameter]
>   305 |      struct hns_roce_uar *uar,
>       |      ~~~~~~~~~~~~~~~~~~~~~^~~
>=20
> Fixes: 4f8f0d5e33dd ("RDMA/hns: Package the flow of creating cq")
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>

Thanks, applied to for-next.

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

--=-RRPfr814EB5STy3piX7m
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAl1IVnEACgkQuCajMw5X
L92lVw/9Eib54Evvi9UcK4Mr7pvREpwjrrLPA/E92ZDqVNt4FEWHua0JfibsvyU8
QBEuAYuSDU4XwBgQjsurdZemsCxijisWGldiSNlpno0Irm33mLDvvBxZ64c1brxl
FL7zPHBmpHbbhzdb8SdISy6zfoNASzDb9vgdcU6CnU+jUy7H4Ol8LEFkDZGdVnz/
fb9FPkVfaIMoPKSqNP1jooHiTNn1x+pi0G6pEuU7yeIrBHYhkAV7kyEZPFqEGKgy
PfNTRuOF9bHG5Pjlj3t4HghhVyNJTCdKfRuXjYIfuZR0rFPVtHv0T/yAjbT3+EQr
p1dylX8AfCXpOcMWa6JT+m8MU9eCUFl0PYGEFYk895rSp+UniR2/F9KrArvHq8Ha
W9m0ZV8r3tKgc2LRBETTLmipe7xxqPvfwvnyRrLV4ynbfsMDfhnTtglibqd1VeXO
xf/iIBC8w+LT8vsXKuBUZ+1PVULEMlOkVicQ9uKLoft8qg0GA6omGnnM8LLEwFBl
sf6T/9G1OIxy/LfDMkG+iIbKSbT+hOxnhUyz186VWEmWl6ZqFMMWOCfiueJUJt/Y
scJ3yiCwkFJWqx8O+erc/qkzuXQfKlSFehNu8S90pex3S4/xQdIHu3EDMMms5lsT
U2G/mFTcRUelQ/dIUen1vd2iWXQdFhgUSkx0ofCfMU98vo0/ry8=
=j4qe
-----END PGP SIGNATURE-----

--=-RRPfr814EB5STy3piX7m--

