Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 39BBC6B25C
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Jul 2019 01:29:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389048AbfGPX2U (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 16 Jul 2019 19:28:20 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:41511 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728414AbfGPX2T (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 16 Jul 2019 19:28:19 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45pGmJ2zpSz9s3l;
        Wed, 17 Jul 2019 09:28:16 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1563319696;
        bh=rwxKbah4VfF7BG5Oj6ZkNXpTV6etHJFRWQvfPcRHh/M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Ka16flw1aRM5RL34BTfjnFB5oXVz0mnkGzNRqCRCPMOzgeF2cyHLOfAXOMcS4CAfT
         SojmXzZJJzEAyi0BiUof3x+e2qvBxDjfNDJaWFkoctgs7tcT44PwLfg+0ARhQfLqgA
         FXSRaHPDUhpBjTJ3YzChLzpyifdn83P8kal2RqI8DR8y3MfWb194oLxMvSRproA251
         Fz79n6JSEe/JTOCFHyR0ZQzyOEgBRk6NG3vlpiKgaN0EDQRYJKJlgHNim1K4AxVwMM
         YtMBIR+I1S61cYwwc681nTuRk31ZQYfRq5wapE8MprvFivMgt8ck+K+tARjkERHGrh
         xf3fVxbVb0YMA==
Date:   Wed, 17 Jul 2019 09:28:01 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Jason Gunthorpe <jgg@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        Mark Zhang <markz@mellanox.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Majd Dibbiny <majd@mellanox.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the rdma tree
Message-ID: <20190717092801.77037015@canb.auug.org.au>
In-Reply-To: <20190710143036.1582c79d@canb.auug.org.au>
References: <20190709133019.25a8cd27@canb.auug.org.au>
        <ba1dd3e2-3091-816c-c308-2f9dd4385596@mellanox.com>
        <20190709071758.GI7034@mtr-leonro.mtl.com>
        <20190709124631.GG3436@mellanox.com>
        <20190710110443.002220c8@canb.auug.org.au>
        <20190710143036.1582c79d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/KoH5lVAefuFawhjo7irS3qR"; protocol="application/pgp-signature"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--Sig_/KoH5lVAefuFawhjo7irS3qR
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, 10 Jul 2019 14:30:36 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> On Wed, 10 Jul 2019 11:04:43 +1000 Stephen Rothwell <sfr@canb.auug.org.au=
> wrote:
> >
> > On Tue, 9 Jul 2019 12:46:34 +0000 Jason Gunthorpe <jgg@mellanox.com> wr=
ote: =20
> > >
> > > It isn't quite enough to make the header compile stand alone, I'm
> > > adding this instead.
> > >=20
> > > From 37c1e072276b03b080eb24ff24c39080aeaf49ef Mon Sep 17 00:00:00 2001
> > > From: Jason Gunthorpe <jgg@mellanox.com>
> > > Date: Tue, 9 Jul 2019 09:44:47 -0300
> > > Subject: [PATCH] RDMA/counters: Make rdma_counter.h compile stand alo=
ne   =20
> >=20
> > I will apply this to linux-next today and reenable the stand alone
> > building for rdma_counter.h =20
>=20
> That worked for me ...

rdma_counter.h should be able to be removed from the exceptions list now.

I have been building linux-next with this patch for a while, so maybe
it could be applied to the kbuild tree?

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Wed, 10 Jul 2019 13:03:16 +1000
Subject: [PATCH] rdma: attempt to build rdma_counter.h stand alone again

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 include/Kbuild | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/Kbuild b/include/Kbuild
index 7e9f1acb9dd5..765ff864130d 100644
--- a/include/Kbuild
+++ b/include/Kbuild
@@ -949,7 +949,6 @@ header-test-			+=3D pcmcia/ds.h
 header-test-			+=3D rdma/ib.h
 header-test-			+=3D rdma/iw_portmap.h
 header-test-			+=3D rdma/opa_port_info.h
-header-test-			+=3D rdma/rdma_counter.h
 header-test-			+=3D rdma/rdmavt_cq.h
 header-test-			+=3D rdma/restrack.h
 header-test-			+=3D rdma/signature.h
--=20
2.20.1

--=20
Cheers,
Stephen Rothwell

--Sig_/KoH5lVAefuFawhjo7irS3qR
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0uXYEACgkQAVBC80lX
0GzDtAf/XyHO+dBLQ6dMUwGRO8Nb0lKbujqapttpU/NtqcBv5FrD6kOrlVJplXDB
UL+DCm8LEp33pb2FRchB2pPzDSWrJSR1YIW0MeJ9+0u+rPjqlq/duncNDm2eQKCZ
YhdmcoTpkbCO8YVt6EMddoZzBJq+cWVFf0f4JNpj5ZjiZdjIyV2EqQ0EyvSzsHkI
M1SN7p5H86XM3+1bKoHB5wIcsQODFJYAbGdTrXO4ySQmfz3hqmpnZOGcdnClsN27
VUjkIm4hDzbfhfT0QV+kVfShz3EtpUdNtO5sUDWMQ+Mm89F87W56nZC2gPiz9cII
RWLPpIIFYIxxp6rpGSlIYY3Xa2NtbA==
=9q44
-----END PGP SIGNATURE-----

--Sig_/KoH5lVAefuFawhjo7irS3qR--
