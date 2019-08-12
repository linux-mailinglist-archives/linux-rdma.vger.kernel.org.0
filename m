Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D38F08A180
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Aug 2019 16:48:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbfHLOsM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 12 Aug 2019 10:48:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34822 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726796AbfHLOsM (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 12 Aug 2019 10:48:12 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 605C0C05168C;
        Mon, 12 Aug 2019 14:48:12 +0000 (UTC)
Received: from linux-ws.nc.xsintricity.com (ovpn-112-57.rdu2.redhat.com [10.10.112.57])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 471CA600C4;
        Mon, 12 Aug 2019 14:48:11 +0000 (UTC)
Message-ID: <e89dd9d3c6b38f826252c00d1f7becb96cac7bad.camel@redhat.com>
Subject: Re: [PATCH V4 for-next 14/14] RDMA/hns: Use the new APIs for
 printing log
From:   Doug Ledford <dledford@redhat.com>
To:     Lijun Ou <oulijun@huawei.com>, jgg@ziepe.ca
Cc:     leon@kernel.org, linux-rdma@vger.kernel.org, linuxarm@huawei.com
Date:   Mon, 12 Aug 2019 10:48:08 -0400
In-Reply-To: <1565276034-97329-15-git-send-email-oulijun@huawei.com>
References: <1565276034-97329-1-git-send-email-oulijun@huawei.com>
         <1565276034-97329-15-git-send-email-oulijun@huawei.com>
Organization: Red Hat, Inc.
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-zsyyuzO2UMA0ucmakBGT"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Mon, 12 Aug 2019 14:48:12 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


--=-zsyyuzO2UMA0ucmakBGT
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2019-08-08 at 22:53 +0800, Lijun Ou wrote:
> -               dev_err(&hr_dev->dev, "Destroy qp 0x%06lx
> failed(%d)\n",
> -                       hr_qp->qpn, ret);
> +               ibdev_err(&hr_dev->ib_dev, "Destroy qp 0x%06lx
> failed(%d)\n",
> +                         hr_qp->qpn, ret);

And then fixed it up here too.

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

--=-zsyyuzO2UMA0ucmakBGT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAl1RfCgACgkQuCajMw5X
L933dw/8CcNGACxfVOqrudwk7e73qHntRK4/3brnbdZYcaKLB7EVP4eUd6e6sM03
4IxhdRrp4UwYGAOH9anohMyqmXodJzpoY07OVdVjaYbR6R26QmhG0cm+GgmdhjAp
AmmQx+d7/QO/f18qZnSROYBUxv+82a24Uhv0AhQ7o/UK3NqVZaMyrn1ZMQHj3pMC
t31bN771yMmjD883HDztyRrogVTX8mqwGZU+4QX3lp3sb7BFdEn5NLFXwC+Bn4Zg
MowWggH6lMNl6EBWjzsoh4eD62rXZDfhP6DCsxu7iafCb8SY708usmy5eAOJ1u4h
HbzmfJ8Ry3A+h7KrhNTWX2hjziWcf2y9Ewr8kBuJni+BMFXouIDhxDt11uoIAg0r
N4JIN/GsO/6h0MMvNs53Rt0o7vgln3vLD5EWlyT6HPhxDrdkQ81VA7U/n7mrdVgB
Jewtml0aMtcj8SoW6o4oyAceET6smNwkVYggcCefYw5WwuS8mVgABZ2/s5C7oXbp
vKJcfj96Dwg+TobkgQoqxKtGD+jSILx0DCVVtI7nKgTRWjtvgfG7ToWrmGvimXh5
XF0BvebMlLDRQiAU9oU0p1CLG8b/05QYycIEFeyr+OzNfllYhiDKaPNicnQ+U+Qf
fJGye/zTX8fXIF4zdSHxK6ihN2d0hacNqQo2UuKctj1y+D9EAYE=
=iKln
-----END PGP SIGNATURE-----

--=-zsyyuzO2UMA0ucmakBGT--

