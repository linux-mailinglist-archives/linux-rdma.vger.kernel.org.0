Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B6F7996700
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Aug 2019 18:59:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727272AbfHTQ7g (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 20 Aug 2019 12:59:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49896 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727077AbfHTQ7g (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 20 Aug 2019 12:59:36 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 28D7B10F23E0;
        Tue, 20 Aug 2019 16:59:36 +0000 (UTC)
Received: from linux-ws.nc.xsintricity.com (ovpn-112-63.rdu2.redhat.com [10.10.112.63])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5355960BF3;
        Tue, 20 Aug 2019 16:59:34 +0000 (UTC)
Message-ID: <9cb7936eb5d3f29ce6116a9e93d6acd4d1566d92.camel@redhat.com>
Subject: Re: [PATCH] RDMA/cma: fix null-ptr-deref Read in cma_cleanup
From:   Doug Ledford <dledford@redhat.com>
To:     zhengbin <zhengbin13@huawei.com>, jgg@ziepe.ca, leon@kernel.org,
        parav@mellanox.com, swise@opengridcomputing.com,
        danielj@mellanox.com, danitg@mellanox.com, willy@infradead.org,
        linux-rdma@vger.kernel.org
Cc:     yi.zhang@huawei.com
Date:   Tue, 20 Aug 2019 12:59:31 -0400
In-Reply-To: <1566188859-103051-1-git-send-email-zhengbin13@huawei.com>
References: <1566188859-103051-1-git-send-email-zhengbin13@huawei.com>
Organization: Red Hat, Inc.
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-tPT3RJqRTDGREqlQvN31"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.66]); Tue, 20 Aug 2019 16:59:36 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


--=-tPT3RJqRTDGREqlQvN31
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2019-08-19 at 12:27 +0800, zhengbin wrote:
> In cma_init, if cma_configfs_init fails, need to free the
> previously memory and return fail, otherwise will trigger
> null-ptr-deref Read in cma_cleanup.
>=20
> cma_cleanup
>   cma_configfs_exit
>     configfs_unregister_subsystem
>=20
> Fixes: 045959db65c6 ("IB/cma: Add configfs for rdma_cm")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: zhengbin <zhengbin13@huawei.com>

Thanks, applied to for-rc.

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

--=-tPT3RJqRTDGREqlQvN31
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAl1cJvMACgkQuCajMw5X
L92udA/+NNAqdpgA+Mi+HbfVNkdFC6lqdAVbSS7qvrDOB240kmalWh2ncj9Z9cWL
7SvBVf3Yhi8BwMJAQPcRRYDykIj+4KIOQ6UYOs5phg3yQcvYplACGfmnwLpolde8
2zTcTShuKByCEmZ7hKreObXtf4dCBNZLRd5/xsaUd1qdByKuZE5mK153c9z59pF0
KixM3vBJGf2Ytnjo5l7iMZO1tr1yedZk7YRqhsqf6S4G0IUwwUc7LwID21i4MF3E
saBvlDfORcqgLUu55vG4yb/eP/KoBcKK/fQqzBFxZXgdlLtZJ6OJWMMrtWzXu3X8
0J2IXJq8S0r+StnalcotKhEfyB3rnLK3e0ZcLLN+G59dqHMS7GHGl7V7j+F9xQp9
8sUGGPCyn6dIFFtE/++DVNLzIbFPZv2LNmPGZb43sgfVRhTh4PZbPsoxeVMQ6e1P
pm5moGlpUM9tvXGYP/dtUs6veQ/HO2E44dTbdmVMIPBHJdkzqU+zYEipkJTIFiBN
vSlslD4P3Fozu51IJ9YsHVY16aSR2ucTEFZ67FPG43JCzhlm6DCBCs4wZZqGbX3y
nn2ZghvjLUYhKX3AAs9R2HyHZ4bIGVXyeg5DxssJCx7MoShL8h+CIeeWCfL1ubrn
iSPggMbMWvlyXk7izKIxy7s0hbsImht6BJbR074ROF24mmiJBb0=
=d+Qj
-----END PGP SIGNATURE-----

--=-tPT3RJqRTDGREqlQvN31--

