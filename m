Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26A6199731
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Aug 2019 16:44:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387705AbfHVOo2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 22 Aug 2019 10:44:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37478 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387660AbfHVOo2 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 22 Aug 2019 10:44:28 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1892C7F762;
        Thu, 22 Aug 2019 14:44:28 +0000 (UTC)
Received: from linux-ws.nc.xsintricity.com (ovpn-112-63.rdu2.redhat.com [10.10.112.63])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 65C6561F27;
        Thu, 22 Aug 2019 14:44:27 +0000 (UTC)
Message-ID: <fced439fbf0de8b9036bb071251562b3183debef.camel@redhat.com>
Subject: Re: [PATCH] RDMA/siw: Enable SGL's with mixed memory types
From:   Doug Ledford <dledford@redhat.com>
To:     Bernard Metzler <bmt@zurich.ibm.com>, linux-rdma@vger.kernel.org
Cc:     krishna2@chelsio.com
Date:   Thu, 22 Aug 2019 10:44:24 -0400
In-Reply-To: <20190822121614.21146-1-bmt@zurich.ibm.com>
References: <20190822121614.21146-1-bmt@zurich.ibm.com>
Organization: Red Hat, Inc.
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-3sB6FhuC34wN+78UM3zX"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.71]); Thu, 22 Aug 2019 14:44:28 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


--=-3sB6FhuC34wN+78UM3zX
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2019-08-22 at 14:16 +0200, Bernard Metzler wrote:
> This patch enables the transmission of work requests with SGL's
> of mixed types, e.g. kernel buffers and PBL regions referenced
> by same work request. This enables iSER as a kernel client.
>=20
> Reported-by: Krishnamraju Eraparaju <krishna2@chelsio.com>
> Tested-by: Krishnamraju Eraparaju <krishna2@chelsio.com>
> Signed-off-by: Bernard Metzler <bmt@zurich.ibm.com>

Hi Bernard,

Commit subject and message are much better this time.  However, it's rc5
already, and we *just* merged siw this merge cycle, so I'd rather have
this in the next -rc pull and not in for-next so that siw "just works"
across the board on initial release.  Your language in a commit message
makes all the difference in the world in terms of whether or not a
commit should go to for-rc.  In this case, you used "Enable SGL's...".=20
Enable is new feature language.  For the rc cycles, you need Fix
language.  Something like this:

RDMA/siw: Fix SGE element mapping issues

Most upper layer kernel modules submit WQEs where the SG list entries
are all of a single type.  iSER in particular, however, will send us
WQEs with mixed SG types: sge[0] =3D kernel buffer, sge[1] =3D PBL region.=
=20
Check and set is_kva on each SG entry individually instead of assuming
the first SGE type carries through to the last.  This fixes iSER over
siw.

Same patch, but the difference in wording makes a world of difference in
terms of whether or not Linus will give you the evil eye for sending it
in an -rc cycle.  And really, you didn't care about enabling SGLs with
mixed memory types.  It's not like that's some sort of sought after
feature.  It was what was needed to fix siw.  So just remember that in
the future.  Fix language for fixes, enable language for features.  The
difference does matter ;-)

Please resubmit with a fixed commit message and a Fixes: tag.

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

--=-3sB6FhuC34wN+78UM3zX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAl1eqkgACgkQuCajMw5X
L93zBhAAkXk6s7lE4dOLe/nbfdEgsDkZDk5MAhM5VCOcOutFABN2P/XHaotb4XRE
WrFSwBqRdBS3nkqywX6J0Yk3zFht4d0PC138QGJ6fSM0WEsAsTPOBu6lTBDGXNPC
HUHowLsrEW9PtWwHYMC846XrE3bMClb63tmyydgHAaWMbf969R016DoigzGfss+Y
z6IwC9I1wpbozWWokhgp6yPkC3EHEaR1lTjOlTYjYDwoYithS3L2n+kWJObawdRK
spXyE3/tOuMca9zYIAaty+2Ol/BWBe+++ZwY/MyOzYRq/DJqv3gWKOFSJAmZT89I
kKoKmljYi8+UlO3HSU+UlUSxHgUvFEV5av1n3xKxe5BZwSRmcBscGXAg/dJ9RF+v
2UDrrU3WbyBD5Xo8dXMXEEgNtv0VelnJHTei/izzZQnx5iLPhp6davAovbcp+w/K
4ooUA8KjAKFa3L4mvSDgZ/HOMtmqxEXUw7w4yQ3JfeDh7qSRO5vv5JZbRglAdNTJ
SeZqWzltZ4D28P8eDZe+D45DSEt9AymCaEBh4d2tNYpaUvxjnAo3ltvdptruqRPL
ySeY9rh137ljRukwCbVW2pKaS3ELgcix0D9mw9ZVOQPqii7colZeQ5ew6ccQ4M2X
HjV7MoKvFiRX8NnlRCLsDTtc/BBebNiG75FvoAjktruRtugyFWs=
=PJOQ
-----END PGP SIGNATURE-----

--=-3sB6FhuC34wN+78UM3zX--

