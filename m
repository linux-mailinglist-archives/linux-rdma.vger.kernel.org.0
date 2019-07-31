Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D78A47CC53
	for <lists+linux-rdma@lfdr.de>; Wed, 31 Jul 2019 20:53:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729504AbfGaSxE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 31 Jul 2019 14:53:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47010 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728486AbfGaSxE (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 31 Jul 2019 14:53:04 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AB543300CA39;
        Wed, 31 Jul 2019 18:53:03 +0000 (UTC)
Received: from linux-ws.nc.xsintricity.com (ovpn-112-50.rdu2.redhat.com [10.10.112.50])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 52D0D5D9C5;
        Wed, 31 Jul 2019 18:53:02 +0000 (UTC)
Message-ID: <c48b7b8db29126fe8991a4b65ed0b793f10501fa.camel@redhat.com>
Subject: Re: [PATCH V2] IB/core: Add mitigation for Spectre V1
From:   Doug Ledford <dledford@redhat.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        "Luck, Tony" <tony.luck@intel.com>, Ira Weiny <ira.weiny@intel.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        Parav Pandit <parav@mellanox.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 31 Jul 2019 14:52:59 -0400
In-Reply-To: <1fc90610-7189-c99b-2af1-ae516faa20b4@embeddedor.com>
References: <20190730202407.31046-1-tony.luck@intel.com>
         <95f5cf70-1a1d-f48c-efac-f389360f585e@embeddedor.com>
         <20190731042801.GA2179@iweiny-DESK2.sc.intel.com>
         <20190731043957.GA1600@agluck-desk2.amr.corp.intel.com>
         <09a994054e43c8bd6ee49b7d1087c9c4e793058f.camel@redhat.com>
         <1fc90610-7189-c99b-2af1-ae516faa20b4@embeddedor.com>
Organization: Red Hat, Inc.
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-Kz6X4pMiK+xltxZ6Stpo"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Wed, 31 Jul 2019 18:53:03 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


--=-Kz6X4pMiK+xltxZ6Stpo
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2019-07-31 at 12:52 -0500, Gustavo A. R. Silva wrote:
> This is insufficient. The speculation windows are large:
>=20
> "Speculative  execution  on  modern  CPUs  can  run  several
> hundred  instructions  ahead." [1]
>=20
> [1] https://spectreattack.com/spectre.pdf

Thanks, I'll take a look at that.  That issue aside, returning without
wasting time on two mutexes is still better IMO, so I like my patch more
than the proposed one.  Tony, would you like to resubmit?

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

--=-Kz6X4pMiK+xltxZ6Stpo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAl1B44wACgkQuCajMw5X
L92b3w/+PiKsN+nafJB7JMGvfkMhcfkiVXaEoo+CzRNozik2IngYkZ/YbBkOkLT2
V8NZ+8Ql/jfsdlfp+7sOHFsiDy5wnjmvcvAXSp7zdWy/B+He9VPcUY4Yx/LndVfV
f/SpX12RnqCf1qRG3g8ANl5cZp0vq4437bpevPp/0Zf5ZCdg+a9dZovQI25YY6e+
FUvroSESTQKxhm+6/TJEt7Stk7NGL9TmDptCNCmD1b9G10cEsPU36yma9jFAIA6r
XDG+4yaeXm5QT6EzhiCyj/wsDznXztwWStl2emJtpW/NcinKao4FONGWSSY41Uk+
4oitC16OIGrzKWsnrqX8axN1fw+jVyVFedaRJ37Yy1bhpERpU3AK48+6KjFwtqZA
+XPKQbxx+VBXYeh+OS/Aeo13D7ODzLT9ani/erhaRUe6suzy1mmXnJFxGCLsJCUB
8449FzjuZ7/i1mwKESqm+E/oak8AO1h02M3z28jJW4++HPmXplv8M/CZnsXVd3L3
OoY4ekJ+fDRZEApRPjuQPdwBtkW8RqJrYcDl4JUpG+I0Q5NWw07VRwcLqAEOUnUO
Gdhq3jqNNY9Xg6O1K4IJog3pGSirH1hFYY5XCCNu6bfa4b9Tw/83OofonGwz4b8c
IXtqfCNIWtsnoT6IjCA6A1rBmMJRp79YFaMROv+UEC1egghbTIc=
=7swa
-----END PGP SIGNATURE-----

--=-Kz6X4pMiK+xltxZ6Stpo--

