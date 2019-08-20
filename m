Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7ADD19681C
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Aug 2019 19:55:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730614AbfHTRzu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 20 Aug 2019 13:55:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56066 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730423AbfHTRzu (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 20 Aug 2019 13:55:50 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 255567BDAE;
        Tue, 20 Aug 2019 17:55:44 +0000 (UTC)
Received: from linux-ws.nc.xsintricity.com (ovpn-112-63.rdu2.redhat.com [10.10.112.63])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E7A04841DC;
        Tue, 20 Aug 2019 17:55:37 +0000 (UTC)
Message-ID: <b2251973c16b336c4d48e8417ce50f0c55598a9b.camel@redhat.com>
Subject: Re: [PATCH for-rc] siw: fix for 'is_kva' flag issue in siw_tx_hdt()
From:   Doug Ledford <dledford@redhat.com>
To:     Bernard Metzler <BMT@zurich.ibm.com>,
        Krishnamraju Eraparaju <krishna2@chelsio.com>
Cc:     jgg@ziepe.ca, linux-rdma@vger.kernel.org, bharat@chelsio.com,
        nirranjan@chelsio.com
Date:   Tue, 20 Aug 2019 13:55:35 -0400
In-Reply-To: <OFB7456B6B.E1C4D049-ON0025845B.00533DDF-0025845B.00776B49@notes.na.collabserv.com>
References: <20190819111338.9366-1-krishna2@chelsio.com>
         <OFB7456B6B.E1C4D049-ON0025845B.00533DDF-0025845B.00776B49@notes.na.collabserv.com>
Organization: Red Hat, Inc.
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-NaBbsG73tOAts70UNLLH"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Tue, 20 Aug 2019 17:55:50 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


--=-NaBbsG73tOAts70UNLLH
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2019-08-19 at 21:44 +0000, Bernard Metzler wrote:
> Hi Krishna,
> That is a good catch. I was not aware of the possibility of mixed
> PBL and kernel buffer addresses in one SQE.
>=20
> A correct fix must also handle the un-mapping of any kmap()'d
> buffers. The current TX code expects all buffers be either kmap()'d or
> all not kmap()'d. So the fix is a little more complex, if we must
> handle mixed SGL's during un-mapping. I think I can provide it by
> tomorrow. It's almost midnight ;)

I'll wait for a proper fix.  Dropping this patch.  Thanks.

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

--=-NaBbsG73tOAts70UNLLH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAl1cNBcACgkQuCajMw5X
L93TZRAAl91DrXalczEMvxAL//MFUeU8cgkxBce2aj4VcdVkvLLqLD1GHjqAi9bX
9XYXhdGfkB5rKYi1ZgXCRWz7In2KMj6we208D6v1IV+hUi1sWkqDVWQwTw3+1aW6
8fReBzQyEtwWwdw22/OS2YW8QSxTNv/+rNwMn8caG9EMckiGsxYKeqSiFcIz4swL
dHLashy4LS++cVet+uD/5GhjK545uiVZtBUA4rOYZFfI41CTgc14LMxqtZ+uJe4M
eOmqhbSU6t94DKqFZm+PBGQcrx/z2Uo7jRUK3AahuZq0m/bWp+I6r9Jzu5DUJ3Ws
U2ewt0i066gW8ZG4NhvL/SftPOTJlND3aEUr23JhnyhTMPZsWjOrtNwCbbyTvjFO
oXcMe4d2cooLjCdq4vXDvWuRzciqOqsmWufSF7zjbOTN+wSysdgpS10IhiPun4+Z
MNyBKsp0kyNmkRnodDh/Rf2fwHiorQixsGnSJj4BhGfh8MFX2xkyNorx/2UXHBhj
TsYtm9fpVWGvUaijao4BQPNwJyXTMLt5j6n96clkulj3GgslGLC9FG/rgvCX1maH
Zm3fg8HReSfsn/ZqcG22FB9dJbn7HEDIl18WVk810k93zJQWHQOePhjWog9kVswn
K6aObXpjk/HnHWATxl9LwHkRamTVVUiyYD4nFBVOXeWIq421jD8=
=LM/M
-----END PGP SIGNATURE-----

--=-NaBbsG73tOAts70UNLLH--

