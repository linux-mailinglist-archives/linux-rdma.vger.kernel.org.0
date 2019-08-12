Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51F038A176
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Aug 2019 16:47:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726537AbfHLOrr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 12 Aug 2019 10:47:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34600 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726516AbfHLOrr (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 12 Aug 2019 10:47:47 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E0289C06511C;
        Mon, 12 Aug 2019 14:47:46 +0000 (UTC)
Received: from linux-ws.nc.xsintricity.com (ovpn-112-57.rdu2.redhat.com [10.10.112.57])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EB90E2934F;
        Mon, 12 Aug 2019 14:47:45 +0000 (UTC)
Message-ID: <608c05012ecf82397eee6cc829158fde7cea64d1.camel@redhat.com>
Subject: Re: [PATCH V4 for-next 03/14] RDMA/hns: Update the prompt message
 for creating and destroy qp
From:   Doug Ledford <dledford@redhat.com>
To:     Lijun Ou <oulijun@huawei.com>, jgg@ziepe.ca
Cc:     leon@kernel.org, linux-rdma@vger.kernel.org, linuxarm@huawei.com
Date:   Mon, 12 Aug 2019 10:47:43 -0400
In-Reply-To: <1565276034-97329-4-git-send-email-oulijun@huawei.com>
References: <1565276034-97329-1-git-send-email-oulijun@huawei.com>
         <1565276034-97329-4-git-send-email-oulijun@huawei.com>
Organization: Red Hat, Inc.
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-X9vuN2wytP+FoTDRc/Jc"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Mon, 12 Aug 2019 14:47:46 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


--=-X9vuN2wytP+FoTDRc/Jc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2019-08-08 at 22:53 +0800, Lijun Ou wrote:
> -               dev_err(hr_dev->dev, "Destroy qp failed(%d)\n", ret);
> +               dev_err(&hr_dev->dev, "Destroy qp 0x%06lx
> failed(%d)\n",
> +                       hr_qp->qpn, ret);

Oops, this would fail to compile.  I fixed this up while taking the
patch.

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

--=-X9vuN2wytP+FoTDRc/Jc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAl1RfA8ACgkQuCajMw5X
L92hrhAAmYMPcn0u/YCA6ig4CLGgZ/RTfL3qj3FuyVAn6IR7PCdNOZyvuUrrhEaG
Uq3L6X14IZi+04UBdYMXld2q0qMMO0S+zdNNNjnGUEjbEZN3oY4IbB/d/r8mOqTA
Z5ifaghRHvaXBOkGpvKShvIiEup2xic2s3U1k2VWm8vhoZ08oVmoMcicIJL6aqGt
LE0xf2WOlHVmfVswcAR2mAM8lXxW28g+Td73hX/nCPBVybxAISNdY0IEcKLkLk+4
SAGRTVtACWQ0D/NpFL1zzvXd944OkDlOwvIJ9sKpgkrknOTHdE0gpsSWP3jZYFWe
+0eTj7UE9KwlJcQFpPeL5ifVuGFpxI5BzM9hl6DvuAlrSuZdUW6R9B0yFmYGJdOG
KIdmK46fauV5XrUmef0l0Ae5XbigFCt+03MG2xZQy5nfm9Vq3HrIHuocoRxbNQqV
TLRWQHdneczdqldrH6GDId3n6vosnNdYrShI/1w9Y2dS1998nhwbVw6pRBRgwIhN
DFHPS5EWHcljefs28Kxid/TYmTYEp56bTjpPS5EPqEJmBMJvvi+MurndzmXcgctx
0iiCpyxFLk53nw93H93faCMo8X0RSdkrFcDMG3LnwLZRygCS603D3dKcNDfSFuiI
jZfvWRkG16khafSjcpaSop0imMm55GCqvyY/JQ6Qgxr+rH9vdsw=
=dxw7
-----END PGP SIGNATURE-----

--=-X9vuN2wytP+FoTDRc/Jc--

