Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24CC3966ED
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Aug 2019 18:58:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730533AbfHTQ6B (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 20 Aug 2019 12:58:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41352 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726717AbfHTQ6B (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 20 Aug 2019 12:58:01 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1040165403;
        Tue, 20 Aug 2019 16:58:01 +0000 (UTC)
Received: from linux-ws.nc.xsintricity.com (ovpn-112-63.rdu2.redhat.com [10.10.112.63])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CF44587D3;
        Tue, 20 Aug 2019 16:57:59 +0000 (UTC)
Message-ID: <c0f3accee0862ed75e8883e365c54eea6954207b.camel@redhat.com>
Subject: Re: [PATCH] RDMA/hns: Fix some white space check_mtu_validate()
From:   Doug Ledford <dledford@redhat.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Lijun Ou <oulijun@huawei.com>
Cc:     "Wei Hu(Xavier)" <xavier.huwei@huawei.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Date:   Tue, 20 Aug 2019 12:57:57 -0400
In-Reply-To: <20190816113907.GA30799@mwanda>
References: <20190816113907.GA30799@mwanda>
Organization: Red Hat, Inc.
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-fADEci7REUl6PtuT6wyp"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Tue, 20 Aug 2019 16:58:01 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


--=-fADEci7REUl6PtuT6wyp
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2019-08-16 at 14:39 +0300, Dan Carpenter wrote:
> This line was indented a bit too far.
>=20
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Thanks, applied to for-next.

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

--=-fADEci7REUl6PtuT6wyp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAl1cJpUACgkQuCajMw5X
L91W8w/+ML8vmO2ZSR0gCHV0oETx4LZjT8n8usizjFpzoyh9XO3Xx7F3uMxI/msy
oo979dVm1iJjppzEsI5jZ7DQ8HVibJp6Mmak7JJ3r/2xNqSl4xMyVBm/dWxEadLQ
htoTPp1MISTIzieItJmexPK++dxa0s7u1AueDj2vbTEnZ4VB8BkGvyd+yE+CBoMq
udpqOEZiK22Q6A+yCrnmZJUGfuj3wwwn1xxUo99eRqrk4wjNSslOT/ppK2VTsl6B
9RAi2gECEMnU2RbQPTQHi74bcDY2/QHOJS0yCliZuM/WGG1QSP8ix/vdE66ru66X
4ZlT6zi8brLwK3oyjkEOBZGEMs0ZrWpsERuTjYodmvrDEhnZewjGg5efYChyt9o3
NKm7u7w7L0Kq5y+j4yahfCQ1zLolxkrm2b2uWcyQKAZw78wy7b7sUEXWPyKSIuFQ
0Eq70zqQMuPhQxelEpwqSNtXyOma87Hv8IhAYZjbjKpodqzl0YoS65CUoWbEdvpw
GyvwMW9r14X6kBchFT9o9ea4j3S/MUfUQvuT1TCEh290iwdv8fGK+Qs216lga8G8
SXwb3Gr6IlzlV3EC0ZLJu4LJpTGG4+SRU3ZuSrEujrn5E1HWxw2J37b0j9X4KNaV
0OxLxqkxrT9Oym5vAsQvv6HNWDEZ5ABno8bqkaro0N6venUGc+c=
=2VfS
-----END PGP SIGNATURE-----

--=-fADEci7REUl6PtuT6wyp--

