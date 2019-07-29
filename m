Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65A15792EF
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Jul 2019 20:19:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729123AbfG2STj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 29 Jul 2019 14:19:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:19882 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728781AbfG2STj (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 29 Jul 2019 14:19:39 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5B37130917F1;
        Mon, 29 Jul 2019 18:19:39 +0000 (UTC)
Received: from linux-ws.nc.xsintricity.com (ovpn-112-50.rdu2.redhat.com [10.10.112.50])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 35C235C1B5;
        Mon, 29 Jul 2019 18:19:38 +0000 (UTC)
Message-ID: <08d1942fa99465329348a1bbfd55823b590921c2.camel@redhat.com>
Subject: Re: [PATCH] rdma: siw: remove unused variable
From:   Doug Ledford <dledford@redhat.com>
To:     Anders Roxell <anders.roxell@linaro.org>, bmt@zurich.ibm.com,
        jgg@ziepe.ca
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 29 Jul 2019 14:19:35 -0400
In-Reply-To: <20190726092540.22467-1-anders.roxell@linaro.org>
References: <20190726092540.22467-1-anders.roxell@linaro.org>
Organization: Red Hat, Inc.
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-KSNZwsQLpkdKs2wwzNU2"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Mon, 29 Jul 2019 18:19:39 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


--=-KSNZwsQLpkdKs2wwzNU2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2019-07-26 at 11:25 +0200, Anders Roxell wrote:
> The variable 'p' si no longer used and the compiler rightly complains
> that it should be removed.
>=20
> ../drivers/infiniband/sw/siw/siw_mem.c: In function =E2=80=98siw_free_pli=
st=E2=80=99:
> ../drivers/infiniband/sw/siw/siw_mem.c:66:16: warning: unused variable
>  =E2=80=98p=E2=80=99 [-Wunused-variable]
>   struct page **p =3D chunk->plist;
>                 ^
>=20
> Rework to remove unused variable.
>=20
> Fixes: 8288d030447f ("mm/gup: add make_dirty arg to
> put_user_pages_dirty_lock()")

This commit hash and the commit subject does not exist in Linus' tree as
of today.  What tree is this being merged through, and is it slated to
merge soon or is this a for-next item?

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

--=-KSNZwsQLpkdKs2wwzNU2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAl0/OLcACgkQuCajMw5X
L92uAw/9HNQKehkFwok7Y0xgyXBoG97C+oVbRCPZ2JBoZ1yPlJUq2/d6tVUBTL1G
318/c2tcqIqKMo1F1lVcG6Lkv4pRZOrQ+0ZbXPp6TZV4Lnrv7BDjpb1S43jiHYdW
pa45K6UtGo5chquQI4yQRDcPDsyCcQMfyRdGUmRTtv6rYJiBH9UhU0RONji+jTVm
pZFn3j8aQvlvS3kmznbyI0KkKOaZ1ffnkSzISyQRCnluBuycKGsHbgoIyIgP1uli
MhwyA1TW461WWFVA3cYkmt1rkOt8T+AeXuNlC+5HxWu0h/slNccVh/hbuyPSbG+J
69mzHazulNDse+tqJglhd0QdK04IvxG3ncph29TCSvdizu8wd7Ec0wY00pKfWuwQ
0kaWdYt4aRpUod453dthDMiy8TIllxSrcf9Uj6zIS7qC7195JGaSh/ars+z7hoM3
T2V8/QnybDWVQFpw13fv5qoU0RGwG/1Uo/j00CpEwID3QHl7hAncY9uNZ4mTE6tU
7U/sRiVpe0N6GNfPQ78fr29tA9CSW7Y48cmMyz5JTQ1rGt51t8LdTFDEecO8rsJv
+C1/qCJlxPmQUXT56Zfb3oe3Z8SjciIYxPz8fUnKj202uIZA78eDtVWxxKc/yRI8
Fj/JpNR2RcLMhLwqLq8+32Xc3xw4Cudo2nZVlfIF7pNhS388Sbs=
=+fV9
-----END PGP SIGNATURE-----

--=-KSNZwsQLpkdKs2wwzNU2--

