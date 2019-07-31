Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05DFA7CCAB
	for <lists+linux-rdma@lfdr.de>; Wed, 31 Jul 2019 21:22:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730418AbfGaTWY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 31 Jul 2019 15:22:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46204 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730413AbfGaTWX (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 31 Jul 2019 15:22:23 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7D0917FDFB;
        Wed, 31 Jul 2019 19:22:23 +0000 (UTC)
Received: from linux-ws.nc.xsintricity.com (ovpn-112-50.rdu2.redhat.com [10.10.112.50])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E459010016EA;
        Wed, 31 Jul 2019 19:22:21 +0000 (UTC)
Message-ID: <96896eaeaac7cefed65098da268f92e96db69591.camel@redhat.com>
Subject: Re: [PATCH V2] IB/core: Add mitigation for Spectre V1
From:   Doug Ledford <dledford@redhat.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        "Luck, Tony" <tony.luck@intel.com>, Ira Weiny <ira.weiny@intel.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        Parav Pandit <parav@mellanox.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 31 Jul 2019 15:22:19 -0400
In-Reply-To: <c48b7b8db29126fe8991a4b65ed0b793f10501fa.camel@redhat.com>
References: <20190730202407.31046-1-tony.luck@intel.com>
         <95f5cf70-1a1d-f48c-efac-f389360f585e@embeddedor.com>
         <20190731042801.GA2179@iweiny-DESK2.sc.intel.com>
         <20190731043957.GA1600@agluck-desk2.amr.corp.intel.com>
         <09a994054e43c8bd6ee49b7d1087c9c4e793058f.camel@redhat.com>
         <1fc90610-7189-c99b-2af1-ae516faa20b4@embeddedor.com>
         <c48b7b8db29126fe8991a4b65ed0b793f10501fa.camel@redhat.com>
Organization: Red Hat, Inc.
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-Wv/u9qT9ydWeDsWxVynx"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Wed, 31 Jul 2019 19:22:23 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


--=-Wv/u9qT9ydWeDsWxVynx
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2019-07-31 at 14:52 -0400, Doug Ledford wrote:
> On Wed, 2019-07-31 at 12:52 -0500, Gustavo A. R. Silva wrote:
> > This is insufficient. The speculation windows are large:
> >=20
> > "Speculative  execution  on  modern  CPUs  can  run  several
> > hundred  instructions  ahead." [1]
> >=20
> > [1] https://spectreattack.com/spectre.pdf
>=20
> Thanks, I'll take a look at that.  That issue aside, returning without
> wasting time on two mutexes is still better IMO, so I like my patch
> more
> than the proposed one.  Tony, would you like to resubmit?
>=20

Never mind, I took your V2 and fixed it up like I wanted.  Patch
applied, thanks.

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

--=-Wv/u9qT9ydWeDsWxVynx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAl1B6msACgkQuCajMw5X
L920EQ//ZnYSHmoGTzfKPPATbtwiddtsOQRjlO2abLNYDTXpOCjGHf0FZBmvoWgt
jiRcT2P/pPCoHhijeJdpRJwazHTc6NXrtI7lz2kCjP3aZh17Fb5uWB6tupwokFrR
8ODtSzJ3emIn6bxiJy+Ej8RKUpAbqaIuytCN5EAsToqJoi1vxz5/I8HeLquMDf0a
RtKujhNtiGgGgqHiT6QfsREGiTF0KnCJUvJzpyqgbaHqI7HfFRrXda65pR/GKvWu
Oc45GQCACy9g8AorLaclu7WxxMMAkRwWY5oRHE6TyXhDdCu+551rzQMmYBZUPrZI
N1ybzIM+GXJigzEKrnQeMunxCe1NfWoTV9fUbRHk0ItDw+5QwRGOFPFC3bzPAxsw
BARfqsWhlUkD1paEaskXZLQP72bxGjnuXaCZbqcYoCquvN2yRpM2+C4mL8uZF1/X
tOcQL1GUS/H4i2+w1mNjoBV4g7ft0Rm7zmWzCuV4+y2lYbMIMaH/xY1wCf56cHsI
PZ10Nkb+KiXbivDvzbGqmJNyotxZh7JZw1ZfoOGgU6YQABY2vsMEiU/q5IOjM3Rt
5zo+9VpR9FQhmF2zAZ89trqFOR4xltv+b3iTKgvMl6gQEcrdcpOGaJvgSmiSzg8v
lzqJhIELmSF+ZlBobJejKZMDCUa29ZXGq0LSZneFII0HgVY6cUM=
=biB6
-----END PGP SIGNATURE-----

--=-Wv/u9qT9ydWeDsWxVynx--

