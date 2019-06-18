Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C446496C6
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Jun 2019 03:38:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726047AbfFRBiN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 17 Jun 2019 21:38:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53492 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725829AbfFRBiN (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 17 Jun 2019 21:38:13 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 706BD85543;
        Tue, 18 Jun 2019 01:38:12 +0000 (UTC)
Received: from linux-ws.nc.xsintricity.com (ovpn-112-63.rdu2.redhat.com [10.10.112.63])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7D865176BD;
        Tue, 18 Jun 2019 01:38:09 +0000 (UTC)
Message-ID: <c3122608a162ff645bb3efb3e8d59d8eceb39906.camel@redhat.com>
Subject: Re: [PATCH for-rc 1/2] RDMA/efa: Fix success return value in case
 of error
From:   Doug Ledford <dledford@redhat.com>
To:     Gal Pressman <galpress@amazon.com>, Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-rdma@vger.kernel.org, Firas JahJah <firasj@amazon.com>,
        Yossi Leybovich <sleybo@amazon.com>
Date:   Mon, 17 Jun 2019 21:38:06 -0400
In-Reply-To: <20190612072842.99285-2-galpress@amazon.com>
References: <20190612072842.99285-1-galpress@amazon.com>
         <20190612072842.99285-2-galpress@amazon.com>
Organization: Red Hat, Inc.
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-wDlxlXCdvjnV6lzWhAQS"
User-Agent: Evolution 3.32.2 (3.32.2-1.fc30) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Tue, 18 Jun 2019 01:38:13 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


--=-wDlxlXCdvjnV6lzWhAQS
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2019-06-12 at 10:28 +0300, Gal Pressman wrote:
> Existing code would mistakenly return success in case of error
> instead
> of a proper return value.
>=20
> Fixes: e9c6c5373088 ("RDMA/efa: Add common command handlers")
> Reviewed-by: Firas JahJah <firasj@amazon.com>
> Reviewed-by: Yossi Leybovich <sleybo@amazon.com>
> Signed-off-by: Gal Pressman <galpress@amazon.com>

I applied this to for-rc, thanks.

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Key fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57
2FDD

--=-wDlxlXCdvjnV6lzWhAQS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAl0IQH8ACgkQuCajMw5X
L90tGw//Vn4DeICpmZOF/QgruRak0vyFlODMyDXk3BZWMaXU2aVCcXZifxccE+/I
FaQKzL/1fcu38awxoIMS34M+qYJw7Yba9wkmxiF0a53ywT0DTFCzk4L1/S8fUehB
dYyHHzPFr9eN+BUF7nu8maG9JYXiti6uhc4sdb5gpf02HxAoo6cJfFSXXX9WupmN
cyyoqJg4VzgqUR2yyAzgx4rhuH16eFBnqBPomiPac1CsirND3c9et0IzeAwKOolB
V00+J1oeJiSQPMrCn8mES8o6yI3/LojlO5Q7GK2PCoXgm0ye6ppCIW9IeX8ObDuP
f208Fpep+50UdxGI8mH+VG+EJfvZWFSzoMB900Q4MT5gAwLDjmm6lXABX8VX7Mwi
dPKEqX312yI9t4uGzzBYtP38CqrzwWzBNjDz4qFoUsXnCj3AtS/eqnq+8az7gxv+
2LD6GG5ELSFT0WHdmkII74mVezrGeJq2PnRDeMLRioTPDBYbnWxpd63guQgIOOMJ
LThIyGmZz6Y9CnsuDH+oGCQSkggNXfhyu2YBl6Rg/L7rZyX2oHYn9KfxhkNPxAtJ
a6A9fKvQfK+Dg4fl46kQBSobJZMpGv/zq1QrTmywpPf5o+GaCWeHHLHe0GcyQh+e
whkruTszMniaYQqE3ZUKd+1FL30H9g6D8LrnAx89v2iBHFlqhF0=
=3zsw
-----END PGP SIGNATURE-----

--=-wDlxlXCdvjnV6lzWhAQS--

