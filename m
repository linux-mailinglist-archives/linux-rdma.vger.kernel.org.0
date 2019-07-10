Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6370A63EC7
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jul 2019 03:04:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbfGJBEr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 9 Jul 2019 21:04:47 -0400
Received: from ozlabs.org ([203.11.71.1]:45661 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726218AbfGJBEr (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 9 Jul 2019 21:04:47 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45k1Dr04l5z9sNf;
        Wed, 10 Jul 2019 11:04:44 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1562720684;
        bh=TQR0GcQ36S035CtDAlaimOx2Kh2rr7zoQ9d5zOLqMgw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CR8b8ol+4YW7RxwEBW6ekFtajem3SLsA5zjXGXXNLUbp2ca72zkLQWel/BzO/P60B
         jWdndw34LXKz2BUe0mVM6VqBPYkKdm36CmHLK1uudxTQ3LxJtHhAgZSybh0fKJ9wEW
         QNDhBdZoXzpRx8vAo7Si0mBrqxyk3scVDWLDKSgoljqoTI66Oo9jSspquNnsHTTWsW
         eNzAt1/lr8LByS0ufKBqzgh+FSfncSL6edBvl2WGz0C7he8AKS73BqAlM4V+wRJX0O
         dpJvkqmegRGgSsaK50OAUqBCZ4tcKmFlLSkWlbpAwdT99ei6tm3zOyey2qrA1lToVz
         CzIA7A6gQIICA==
Date:   Wed, 10 Jul 2019 11:04:43 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        Mark Zhang <markz@mellanox.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Majd Dibbiny <majd@mellanox.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the rdma tree
Message-ID: <20190710110443.002220c8@canb.auug.org.au>
In-Reply-To: <20190709124631.GG3436@mellanox.com>
References: <20190709133019.25a8cd27@canb.auug.org.au>
        <ba1dd3e2-3091-816c-c308-2f9dd4385596@mellanox.com>
        <20190709071758.GI7034@mtr-leonro.mtl.com>
        <20190709124631.GG3436@mellanox.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/hi2rpc5Dd+yZzkhXjD3njhm"; protocol="application/pgp-signature"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--Sig_/hi2rpc5Dd+yZzkhXjD3njhm
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Jason,

On Tue, 9 Jul 2019 12:46:34 +0000 Jason Gunthorpe <jgg@mellanox.com> wrote:
>
> It isn't quite enough to make the header compile stand alone, I'm
> adding this instead.
>=20
> From 37c1e072276b03b080eb24ff24c39080aeaf49ef Mon Sep 17 00:00:00 2001
> From: Jason Gunthorpe <jgg@mellanox.com>
> Date: Tue, 9 Jul 2019 09:44:47 -0300
> Subject: [PATCH] RDMA/counters: Make rdma_counter.h compile stand alone

I will apply this to linux-next today and reenable the stand alone
building for rdma_counter.h

--=20
Cheers,
Stephen Rothwell

--Sig_/hi2rpc5Dd+yZzkhXjD3njhm
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0lOasACgkQAVBC80lX
0GyBPAf+KwnFQFn+T7H3mJspDCclYT1OTlcBVNEiGGah4HETQyR89ZleqPNOYEAO
l9q/jxzwae54yR1p1nzO0SRkW7sokBRUMa/scO8TQIWULG5VvTNo9bCgVy+w29HA
02pCRBtMB2AZfjZYD+uhzJ8K7ToEdJkdFtG3oZ8ZUxn36k9Ay2u8eZ05fE2Zf2Ua
dXk04FSis6gPXiKqtsgv8lKdswOFXTMvSQ8W4nKSmznkEFcMZmdrv89vE45mHprj
R4+84/KJCAqxe9t6wvOTJfY7JF71lFYpjO4jA/fRjz9/uBMNDYaqZCbdXfcjM82A
rt+Z+qoHmAPDFSkKYd3JpkIp4e0nEg==
=fUKg
-----END PGP SIGNATURE-----

--Sig_/hi2rpc5Dd+yZzkhXjD3njhm--
