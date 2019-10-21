Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C40C4DF6E8
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Oct 2019 22:42:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730297AbfJUUmx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 21 Oct 2019 16:42:53 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:28656 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728914AbfJUUmx (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 21 Oct 2019 16:42:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571690572;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cYa9VxRUhyQagegxe07UahH8eNhiy0ByEwADC3xi3cQ=;
        b=hpOb8PzfiOO0GNdrzEEs83/XAqgNu5BVtsQhnTHvv+gkrampNcbT5z0USuec5h3yOXVdzM
        LnJJGoIF6CkYR8sVFJ+uBuOqW5DMfCXhBOqt8a3IY74E3+tYzkNuKGoiIOjMdbWJvDDSkF
        reeo++nNeaAr16FWklVNFj+PGinJVj4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-313-k3TSP4bCOLW9xBjJ2baJPQ-1; Mon, 21 Oct 2019 16:42:46 -0400
X-MC-Unique: k3TSP4bCOLW9xBjJ2baJPQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6220F800D41;
        Mon, 21 Oct 2019 20:42:45 +0000 (UTC)
Received: from linux-ws.nc.xsintricity.com (ovpn-112-37.rdu2.redhat.com [10.10.112.37])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7CB8060C57;
        Mon, 21 Oct 2019 20:42:44 +0000 (UTC)
Message-ID: <d425d78e2fba5258e3f3c2c4dab02258986775b6.camel@redhat.com>
Subject: Re: [PATCH v2 for-next] RDMA/hns: Release qp resources when failed
 to destroy qp
From:   Doug Ledford <dledford@redhat.com>
To:     Weihang Li <liweihang@hisilicon.com>, jgg@ziepe.ca
Cc:     linux-rdma@vger.kernel.org, linuxarm@huawei.com
Date:   Mon, 21 Oct 2019 16:42:41 -0400
In-Reply-To: <1570584110-3659-1-git-send-email-liweihang@hisilicon.com>
References: <1570584110-3659-1-git-send-email-liweihang@hisilicon.com>
Organization: Red Hat, Inc.
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-ozj0f7vKcv+QnlaTMwCR"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--=-ozj0f7vKcv+QnlaTMwCR
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2019-10-09 at 09:21 +0800, Weihang Li wrote:
> From: Yangyang Li <liyangyang20@huawei.com>
>=20
> Even if no response from hardware, we should make sure that qp related
> resources are released to avoid memory leaks.
>=20
> Fixes: 926a01dc000d ("RDMA/hns: Add QP operations support for hip08
> SoC")
>=20
> Signed-off-by: Yangyang Li <liyangyang20@huawei.com>
> Signed-off-by: Weihang Li <liweihang@hisilicon.com>
>=20

Thanks, applied to for-next.  For the future sake, no space between
Fixes: and Signed-off-by: lines please.  They're all just metadata, they
don't need to be separated.

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

--=-ozj0f7vKcv+QnlaTMwCR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAl2uGEEACgkQuCajMw5X
L90U8w//VptxHeSsJTzJBaInSK5BCem8/bIU8pPJyrmzfOgPUzFRYBLLRBBOqetC
FQX5L90xzMNkjqkjAbMqR97mjrO6NlrtUEf5Y+jjtjnbRNyQzmK7K+uvRIZM+fCW
FlCA0rcbPkIF+VaApBlgRFAPnwXlApPr57fOjdgS+qcTN6/S/xsMBmxPjuk0V4OS
UePY3m3iCcBvNi6URQCbt/Jq8imin/LWLofvwpBTkGSqeiZz+MF9TOEDit7KHBuT
k8oNSvH9GlRP/k8ZOj/NBeWWeop4stURrF6InG+Ps4okCC0GqESyPHMqrC38StV5
aeePsQ3qDrHHFnFUm6RxlIQcScZtDAQGzaVui188wY/dHp8Lufg2VOGqJPpzkhNR
Q43ZE50MQYDtrxEXNvusdUTVmbBhK9uxFKMfwM7OsWaxeUam3GFXoXw0QcVFNXs4
EOBjgSDArb9tT7jgQIAvNsItt6Nt9w9d1OHwDhD3tocZQnMLlzOZT4E7Xq3tF4TW
bzwA3TiBl77+15sumsepTnNyZ6uM9cTN/EKefMmxIW2McmEFNb0UTdq4SfBkuuta
/EfHp+EsidNZuOpETfQHNivn2BUgVy7Ri81TkUkZo8koojGhHskh0EjT0cSGmd3A
Q0aZbKGjPqvL1d/K/Da26yH9VXn1XIinROOiznO+7Wf+XkA4d4I=
=kN43
-----END PGP SIGNATURE-----

--=-ozj0f7vKcv+QnlaTMwCR--

