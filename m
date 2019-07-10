Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BDE5264012
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jul 2019 06:30:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726020AbfGJEaj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 10 Jul 2019 00:30:39 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:47197 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725844AbfGJEaj (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 10 Jul 2019 00:30:39 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45k5pN6lTVz9sBF;
        Wed, 10 Jul 2019 14:30:36 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1562733037;
        bh=4L57TG7rgdzLRvI09vAA7MpNsJA58dgrIWQg4bmtJvE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kQ6SHQSwJEvcYnujg20uU5MIWTKNHJ9UABfXM+SbckwjnX5ca6behMvtG2iK0DRPc
         EuQXpmUYwoV36g75VAe3kCVV6t7CCK8YY7kaVpKEmtdbVrp9nxFBTBmIAKLQRn0C0Y
         +zIF97LzNiMSf/HIn7xI8StVaEgUgb/zMK1SFqUo8geSNoLfLSIycvWNWLNS+gsQ76
         Ce4PKxCdHCvVBWprsbXe34InBOPi8vp4RU0sZCo/u3DC9m8aAn+AX3TeHqFZVjrYfg
         NBKo0ccSMU93/4SDFOcm7YSDVwdyrnFu+5dHuNaHLy6DKj/k0NWeX4ZPOixkfStOi8
         bb5/03OVzUZlQ==
Date:   Wed, 10 Jul 2019 14:30:36 +1000
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
Message-ID: <20190710143036.1582c79d@canb.auug.org.au>
In-Reply-To: <20190710110443.002220c8@canb.auug.org.au>
References: <20190709133019.25a8cd27@canb.auug.org.au>
        <ba1dd3e2-3091-816c-c308-2f9dd4385596@mellanox.com>
        <20190709071758.GI7034@mtr-leonro.mtl.com>
        <20190709124631.GG3436@mellanox.com>
        <20190710110443.002220c8@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/tsgm_X+m5iHkF9nR_R2GokF"; protocol="application/pgp-signature"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--Sig_/tsgm_X+m5iHkF9nR_R2GokF
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Wed, 10 Jul 2019 11:04:43 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> On Tue, 9 Jul 2019 12:46:34 +0000 Jason Gunthorpe <jgg@mellanox.com> wrot=
e:
> >
> > It isn't quite enough to make the header compile stand alone, I'm
> > adding this instead.
> >=20
> > From 37c1e072276b03b080eb24ff24c39080aeaf49ef Mon Sep 17 00:00:00 2001
> > From: Jason Gunthorpe <jgg@mellanox.com>
> > Date: Tue, 9 Jul 2019 09:44:47 -0300
> > Subject: [PATCH] RDMA/counters: Make rdma_counter.h compile stand alone=
 =20
>=20
> I will apply this to linux-next today and reenable the stand alone
> building for rdma_counter.h

That worked for me ...

--=20
Cheers,
Stephen Rothwell

--Sig_/tsgm_X+m5iHkF9nR_R2GokF
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0laewACgkQAVBC80lX
0Gz5zQf9EK9PvRkNOZpnixbJefo3iFSLn/IAhoglVw7NaCHaMdQrZPB8VQL3O/ig
WfGYe9sprqT1Q9q8AX+6vpzDztvDKAS1wPCKBMLm2SI83/ZmioEHyX53BU1ldi7L
BxJdJi66Tylcs3IK/qWVwHrOYvdiUkZ4o/dEHNpBChpmWIgU04JSb+LOsEqvINc7
WO4cmhWxNpMy0E10CRNGd8TsY+T/OXeV6xKUZH+exEhWShIR4JZxXkqVyn7sqea9
hBj+dJ4z727G0/Q9EmRq49JjjL7pKS4YNQ5EN9XE563cP2KcfHRKP7zbSBDmg2Bi
Yha77U1TCmhisnsxMZzKuXuZcAtygw==
=0Mig
-----END PGP SIGNATURE-----

--Sig_/tsgm_X+m5iHkF9nR_R2GokF--
