Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CAC874DEDA
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Jun 2019 03:55:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725911AbfFUBzo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 20 Jun 2019 21:55:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39522 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725906AbfFUBzn (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 20 Jun 2019 21:55:43 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A3DE530833B5;
        Fri, 21 Jun 2019 01:55:43 +0000 (UTC)
Received: from linux-ws.nc.xsintricity.com (ovpn-112-50.rdu2.redhat.com [10.10.112.50])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1C42D5C225;
        Fri, 21 Jun 2019 01:55:42 +0000 (UTC)
Message-ID: <400c83d11a11826648925defeef1a06e888f602d.camel@redhat.com>
Subject: Re: [PATCH] RDMA/uverbs: Use offsetofend instead of opencoding
From:   Doug Ledford <dledford@redhat.com>
To:     Jason Gunthorpe <jgg@mellanox.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Date:   Thu, 20 Jun 2019 21:55:40 -0400
In-Reply-To: <20190614001347.GA20629@ziepe.ca>
References: <20190614001347.GA20629@ziepe.ca>
Organization: Red Hat, Inc.
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-/fEiOks+afRdx+nMrd5k"
User-Agent: Evolution 3.32.2 (3.32.2-1.fc30) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Fri, 21 Jun 2019 01:55:43 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


--=-/fEiOks+afRdx+nMrd5k
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2019-06-14 at 00:13 +0000, Jason Gunthorpe wrote:
> Discovered this was available already.
>=20
> Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>

Thanks, applied to for-next.

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

--=-/fEiOks+afRdx+nMrd5k
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAl0MORwACgkQuCajMw5X
L90s6hAAjX+No2Jt3ziRWNoaTaPsipBiHAUEWjiV7yHpSWosWBM2Ny7jB5PYAhoD
WzHuhlat3SXfGmusnpyozndkg+kQiKTvo5yuT/55kmfc6f8yXIANloOiaZ0EcUQs
xusqmwly8CboE6dyeFkcYzdxvZ98aridGjXQ2SzKGMtwx0/Qmk4IMhpdesCpnJNz
wWcYLFCJfquvZaFae4cQ2s5N6mqYzmOTyg/2RfDFPoBpSGkDogCkt3QJNXrpBeNM
hKf6g7t9Pk9Noelrkb3baX/92EQOutAfYEWi5Amx11wYiveHTRSy2bn6dPVRrvLM
NGEakO8g2MQD9GW/VttHhYFw/RgpLBmMR+h9zXV6yl9mk1WWPvdosu+JZOeKTh0O
WmWsqohfWfKmOQkT4ALT2scmQD1iQ0qLewTyGwQzL1PpNBMKaCPY3hT9n8YnYlCn
t7b6Efi0fGTLpYpivnnX/hN622vQRCuWlo1oKvrTIo0rAUjkKMb+261piZswyYEw
XgPioRHrzm8hvCnhOV/zlccx5B+5Cio5gguWQh5jMeZMfUR/1ZinjG8/T9ZQXYjG
7GWF7mqlbBvIAQredvT5S+lHXWVTnOw9ibRa2GnTfA44FbnfeD2tIyQw4+j/tB0I
0gxHj59RzpKr60QnPr7Dismf51PcfNKkEmYHKkXnicPtpaLJCFE=
=lugI
-----END PGP SIGNATURE-----

--=-/fEiOks+afRdx+nMrd5k--

