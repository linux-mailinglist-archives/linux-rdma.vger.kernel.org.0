Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 818A98A24F
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Aug 2019 17:30:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728286AbfHLP3z (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 12 Aug 2019 11:29:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55116 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726818AbfHLP3z (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 12 Aug 2019 11:29:55 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4513F3172D8F;
        Mon, 12 Aug 2019 15:29:55 +0000 (UTC)
Received: from linux-ws.nc.xsintricity.com (ovpn-112-57.rdu2.redhat.com [10.10.112.57])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3A69F4142;
        Mon, 12 Aug 2019 15:29:54 +0000 (UTC)
Message-ID: <b24ec049045f5700f31c90d5bbe3d70521c0b534.camel@redhat.com>
Subject: Re: [PATCH for-next 2/9] RDMA/hns: Bugfix for creating qp attached
 to srq
From:   Doug Ledford <dledford@redhat.com>
To:     Lijun Ou <oulijun@huawei.com>, jgg@ziepe.ca
Cc:     leon@kernel.org, linux-rdma@vger.kernel.org, linuxarm@huawei.com
Date:   Mon, 12 Aug 2019 11:29:51 -0400
In-Reply-To: <1565343666-73193-3-git-send-email-oulijun@huawei.com>
References: <1565343666-73193-1-git-send-email-oulijun@huawei.com>
         <1565343666-73193-3-git-send-email-oulijun@huawei.com>
Organization: Red Hat, Inc.
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-oMYPbOCquJvFLBxwKgf8"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Mon, 12 Aug 2019 15:29:55 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


--=-oMYPbOCquJvFLBxwKgf8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2019-08-09 at 17:40 +0800, Lijun Ou wrote:
>                 hr_qp->sq.wrid =3D kcalloc(hr_qp->sq.wqe_cnt,
> sizeof(u64),
> -                                        GFP_KERNEL);
> -               hr_qp->rq.wrid =3D kcalloc(hr_qp->rq.wqe_cnt,
> sizeof(u64),
> -                                        GFP_KERNEL);
> -               if (!hr_qp->sq.wrid || !hr_qp->rq.wrid) {
> +                                              GFP_KERNEL);

Whitespace breakage.

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

--=-oMYPbOCquJvFLBxwKgf8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAl1Rhe8ACgkQuCajMw5X
L91HaA/7BkGdEjdNO3cNrPc1Cij++WuKW87GkafIFPp6Dw4vmo8eW/j4pnvGQgDZ
YFB2pMfWHsK0YRSVzpt0LzsRZCZms3T2XRn8+HM999e42aN51Dl4lv9WF2niifwn
Up4wB/BT7DMF+Fzw8M51a2M81u+mcfJP2TVDE52clPCB/maOnlwnnNvQcaeMrvDq
NqvDmRGpjiCqF5mQJx0HDLHuxP0zA09eM/Be2HgkcvyQJ2i51MJ9FtedB7tqkBeH
6u4YK9OwQ0MSrt2O4K+pBqG93UkIpd9fDCMbxWJ4Ff+9oozq8zjXYA7cLStiE4cJ
39qwA5e8URZuDqEgCwplL8K2L7RMH+rGBiPeV/cJkGFq7/ltIsmMQ06Fhiqx2ig2
IQcLtzq2vkz8Gx4Glcj6ijfYh1LyRyh7HOK2zRTVhRGiC35pAT6/qUxKRXFwWpei
bLWJaF/mrGAZFzYvDUmct4a90Gs9tOPgrl9HyuExOjaScnuxEUnctf7gWQAhewUL
B0lTrfCGKbvkW+HX3DEfNNN0yPjBXnB3FqbQejhVi9zKHEyZQAMpm8teCwZq6l5K
3KDwg78PEbO5LIoKOLGFyYD51E52//Nbi9gt0KJLiEItfA2aL1iBcMvL4PEeTGUR
e88gW1hmln0VdlQtGOlvLb3/iroWpXVuDGpa124IqGJPsuUHo6U=
=2zd1
-----END PGP SIGNATURE-----

--=-oMYPbOCquJvFLBxwKgf8--

