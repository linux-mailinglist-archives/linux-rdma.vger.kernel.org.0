Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4724496717
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Aug 2019 19:08:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728277AbfHTRIT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 20 Aug 2019 13:08:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44514 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727358AbfHTRIT (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 20 Aug 2019 13:08:19 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A84EA7F74D;
        Tue, 20 Aug 2019 17:08:18 +0000 (UTC)
Received: from linux-ws.nc.xsintricity.com (ovpn-112-63.rdu2.redhat.com [10.10.112.63])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4EA8960BF3;
        Tue, 20 Aug 2019 17:08:17 +0000 (UTC)
Message-ID: <75a7f1551a26a4df5bef1d6934cf14b361da7932.camel@redhat.com>
Subject: Re: [PATCH] RDMA/srpt: Filter out AGN bits
From:   Doug Ledford <dledford@redhat.com>
To:     Bart Van Assche <bvanassche@acm.org>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Hal Rosenstock <hal@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        oulijun <oulijun@huawei.com>
Date:   Tue, 20 Aug 2019 13:08:14 -0400
In-Reply-To: <6cd489d0-6af1-38e8-3d69-d95b7df03452@acm.org>
References: <20190814151507.140572-1-bvanassche@acm.org>
         <20190819122126.GA6509@ziepe.ca>
         <d2429292-be75-ee67-2cce-081d9d0aa676@acm.org>
         <20190819151722.GG5080@mellanox.com>
         <ad0d3211-bf70-d349-7e14-e4b515bb3e98@acm.org>
         <20190819161658.GJ5058@ziepe.ca>
         <6cd489d0-6af1-38e8-3d69-d95b7df03452@acm.org>
Organization: Red Hat, Inc.
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-Fby8tyyYWBX19K7cbpXu"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.71]); Tue, 20 Aug 2019 17:08:18 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


--=-Fby8tyyYWBX19K7cbpXu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2019-08-19 at 09:48 -0700, Bart Van Assche wrote:
> Hi Jason,
>=20
> When I read Lijun Ou's e-mails for the first time I was assuming that
> my=20
> patch had been tested on top of a recent kernel. After having reread=20
> these e-mails I think my patch had been tested on top of kernel v4.14=20
> and is not necessary for more recent kernels. So I think we can drop
> the=20
> patch at the start of this e-mail thread.

Hi Bart,

Thanks for the heads up.  I'll drop this out of patchworks and we can
revisit things if that turns out to be incorrect.

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

--=-Fby8tyyYWBX19K7cbpXu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAl1cKP4ACgkQuCajMw5X
L90Kgw//YboewaKjx535f3XyaABal9l9YaLH2XwYHZII94oL5UWbk8B1Eoxx0vzJ
kz9N5FH7yAmEZNGDouQvAc4xGqmjO3KYvjwt1rMoi8zQiMVnuVUJuTPNV7yej/ss
CrkvXayZFxecgkRVc6up6owO0depg71fOP3rkq5yOvSxFejvqve0qRzYDjpiWvYX
JFsKn8ZyPBeNLVxoB5ORZjQVmLyjE4koz+WSHbfhMUoiMu1kczjhsuFsGKRa4P3s
VLivfY3y/UHzm6Fb4wpmAKV9hRYvuSB6CaIIr9taaY522zY/V2FIJCH7ykW1N1tT
xXDH+19qeofHlyv1sru+jLSuqY7TCLdE8Jt2xoVRs4ix9C0SGThCjV4HyvRYK9Zx
xketn67RcqhRr8QQjUr6Df07SaaFDRuHhwth5LbwBae34zEqX7b0aML2j+u2MNqG
+gKFPh2ol29jS5epW5Su6SIAm8BAGT8CHiaD0A0SH9kkhVUsKdIVkL0wqhYL9L3W
Q7CXApL6GDsNFfomnIja+VRfefWthUdLh8XHf/+JKNsahTMfQZ+OyJHMjsnLvZK8
y5iVdiPwLBClcf48pVGG9TLQpgbJOz4HQiFHQnl9Y8bzisgGPRCjN4rxxPIRmHot
MVIVoOpCnViDyYQBIMlYwui4z1s/nHzPS4udrMli2iMvZVLK7Mo=
=J6O9
-----END PGP SIGNATURE-----

--=-Fby8tyyYWBX19K7cbpXu--

