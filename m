Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7603B6B775
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Jul 2019 09:45:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726075AbfGQHpW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 17 Jul 2019 03:45:22 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:37671 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725890AbfGQHpW (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 17 Jul 2019 03:45:22 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45pTnp5rQhz9s8m;
        Wed, 17 Jul 2019 17:45:18 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1563349519;
        bh=bl60vOig14zWA2evz/r+S3XrkL3DivP5HljgKsG8JkI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RILUrEmX+/fB7xdTBBla9ngVqWnAEGA/VeV/IHLrWkyXdKaZMoVRRSqGAKAOUXsQ9
         nXPcLYlI2hci/BUCO9tifKs4WKvTVZl/Voq5Wi2L9qXYKDy+AHItse4rb0x2eut4rS
         P0m0WTR6nxnCecyNc2EZLeciFlPW4MmQ9NFAbL21Hr6y19tAEoB3byEe4Qp/cGmks7
         mlzEiwGFTc2rneo2xYn1Fh/mErGSN8w600aFIJytsglcz0NWtDY2DJHVCbNLOpiy89
         eWk3TkA5LTvs+kbPVPNLQTAqiW6IUh4IB5MEYhw9GhL7RRBmk1nO97ZT2CgDOyGK6L
         hlfkru4tdaH0g==
Date:   Wed, 17 Jul 2019 17:45:11 +1000
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
Message-ID: <20190717174511.67e64609@canb.auug.org.au>
In-Reply-To: <CAK7LNARZqi-QcGaTEaoTEASbnBaGzYchgDoWeuthR+G8jxQHMg@mail.gmail.com>
References: <20190709133019.25a8cd27@canb.auug.org.au>
        <ba1dd3e2-3091-816c-c308-2f9dd4385596@mellanox.com>
        <20190709071758.GI7034@mtr-leonro.mtl.com>
        <20190709124631.GG3436@mellanox.com>
        <20190710110443.002220c8@canb.auug.org.au>
        <20190710143036.1582c79d@canb.auug.org.au>
        <20190717092801.77037015@canb.auug.org.au>
        <CAK7LNARZqi-QcGaTEaoTEASbnBaGzYchgDoWeuthR+G8jxQHMg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/wuxKlRL/Cq6k9EEPfnjU2QV"; protocol="application/pgp-signature"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--Sig_/wuxKlRL/Cq6k9EEPfnjU2QV
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Masahiro,

On Wed, 17 Jul 2019 15:33:28 +0900 Masahiro Yamada <yamada.masahiro@socione=
xt.com> wrote:
>
> Yes, this is just a one-liner fix-up,
> so I'd like to fold it into this:
>=20
> https://patchwork.kernel.org/patch/11047283/

Fine by me.

--=20
Cheers,
Stephen Rothwell

--Sig_/wuxKlRL/Cq6k9EEPfnjU2QV
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0u0gcACgkQAVBC80lX
0GwWQQgAjcYWFWotF20wXVads8YJF5lZpSVBWK2za6mGL6y3PMs6sNetT/N7Nvt8
gYriTJ5znXShX/htF+P+HlWX+ZAPRull/2E+vXjHlH6VZIYWHoC6wq/u7g4xnxav
/090YXWwXqbWv7T0rv0fNliSfbIfu9bZgF60scgFObF2Y0/CwmFgmw1cqN2hySLN
oNQd8iCGNpkIcmjx3CMK/DeVovLi44YnPbNx3pA5JHbyWtI2CnPvc9ep//veYviW
62wLK8Fz4c/cbVat4f9DzEBmBfmEdGP9WZbYCOQN2OgWDLonQuhdVfL4nh2kt124
pm1mQh4lFmEz1IKdakRNUhsvHwC+Hg==
=HsqA
-----END PGP SIGNATURE-----

--Sig_/wuxKlRL/Cq6k9EEPfnjU2QV--
