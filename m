Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F3D6A0608
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Aug 2019 17:19:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726394AbfH1PTX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 28 Aug 2019 11:19:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52122 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726315AbfH1PTX (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 28 Aug 2019 11:19:23 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BA6513CA0D;
        Wed, 28 Aug 2019 15:19:22 +0000 (UTC)
Received: from linux-ws.nc.xsintricity.com (ovpn-112-63.rdu2.redhat.com [10.10.112.63])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AB52719D7A;
        Wed, 28 Aug 2019 15:19:21 +0000 (UTC)
Message-ID: <e91d1e75aad3b283e3d232993b15c1bb33e522d7.camel@redhat.com>
Subject: Re: [PATCH for-next 2/9] RDMA/hns: Refactor the codes of creating qp
From:   Doug Ledford <dledford@redhat.com>
To:     Lijun Ou <oulijun@huawei.com>, jgg@ziepe.ca
Cc:     linux-rdma@vger.kernel.org, linuxarm@huawei.com
Date:   Wed, 28 Aug 2019 11:19:18 -0400
In-Reply-To: <1566393276-42555-3-git-send-email-oulijun@huawei.com>
References: <1566393276-42555-1-git-send-email-oulijun@huawei.com>
         <1566393276-42555-3-git-send-email-oulijun@huawei.com>
Organization: Red Hat, Inc.
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-m8jrDxGeHb3iDK9zPcSk"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Wed, 28 Aug 2019 15:19:22 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


--=-m8jrDxGeHb3iDK9zPcSk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2019-08-21 at 21:14 +0800, Lijun Ou wrote:
> +static int hns_roce_alloc_recv_inline_buffer(struct hns_roce_qp
> *hr_qp,
> +                                            struct ib_qp_init_attr
> *init_attr)
> +{
> +       int ret;
> +       int i;
> +
> +       /* allocate recv inline buf */
> +       hr_qp->rq_inl_buf.wqe_list =3D kcalloc(hr_qp->rq.wqe_cnt,
> +                                            sizeof(struct
> hns_roce_rinl_wqe),
> +                                            GFP_KERNEL);
> +       if (!hr_qp->rq_inl_buf.wqe_list) {
> +               ret =3D -ENOMEM;
> +               goto err;
> +       }
> +
> +       hr_qp->rq_inl_buf.wqe_cnt =3D hr_qp->rq.wqe_cnt;
> +
> +       /* Firstly, allocate a list of sge space buffer */
> +       hr_qp->rq_inl_buf.wqe_list[0].sg_list =3D
> +                                       kcalloc(hr_qp-
> >rq_inl_buf.wqe_cnt,
> +                                       init_attr->cap.max_recv_sge *
> +                                       sizeof(struct
> hns_roce_rinl_sge),
> +                                       GFP_KERNEL);
> +       if (!hr_qp->rq_inl_buf.wqe_list[0].sg_list) {
> +               ret =3D -ENOMEM;
> +               goto err_wqe_list;
> +       }
> +
> +       for (i =3D 1; i < hr_qp->rq_inl_buf.wqe_cnt; i++)
> +               /* Secondly, reallocate the buffer */
> +               hr_qp->rq_inl_buf.wqe_list[i].sg_list =3D
> +                                    &hr_qp-
> >rq_inl_buf.wqe_list[0].sg_list[i *
> +                                    init_attr->cap.max_recv_sge];
> +
> +       return 0;
> +
> +err_wqe_list:
> +       kfree(hr_qp->rq_inl_buf.wqe_list);
> +
> +err:
> +       return ret;
> +}

This function is klunky.  You don't need int ret; at all as there are
only two possible return values and you have distinct locations for each
return, so each return can use a constant.  It would be much more
readable like this:

+static int hns_roce_alloc_recv_inline_buffer(struct hns_roce_qp *hr_qp,
+                                            struct ib_qp_init_attr *init_a=
ttr)
+{
+	int num_sge =3D init_attr->cap.max_recv_sge;
+	int wqe_cnt =3D hr_qp->rq.wqe_cnt;
+       int i;
+
+       /* allocate recv inline WQE bufs */
+       hr_qp->rq_inl_buf.wqe_list =3D kcalloc(wqe_cnt,
+                                            sizeof(struct hns_roce_rinl_wq=
e),
+                                            GFP_KERNEL);
+       if (!hr_qp->rq_inl_buf.wqe_list)
+               goto err;
+
+       hr_qp->rq_inl_buf.wqe_cnt =3D wqe_cnt;
+
+       /* allocate a single sge array for all WQEs */
+       hr_qp->rq_inl_buf.wqe_list[0].sg_list =3D
+                                       kcalloc(wqe_cnt,
+                                       num_sge *
+                                       sizeof(struct hns_roce_rinl_sge),
+                                       GFP_KERNEL);
+       if (!hr_qp->rq_inl_buf.wqe_list[0].sg_list)
+               goto err_wqe_list;
+
+       for (i =3D 1; i < wqe_cnt; i++)
+               /* give each WQE a pointer to its array space */
+               hr_qp->rq_inl_buf.wqe_list[i].sg_list =3D
+                           &hr_qp->rq_inl_buf.wqe_list[0].sg_list[i * num_=
sge];
+
+       return 0;
+
+err_wqe_list:
+       kfree(hr_qp->rq_inl_buf.wqe_list);
+err:
+       return -ENOMEM;
+}

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

--=-m8jrDxGeHb3iDK9zPcSk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAl1mm3YACgkQuCajMw5X
L90/LxAAlQMskOoq8DFdyuqIb0Jc05KXMrEv4/FAacA7Jd9BHYdwqed2za6l43LR
/0adkxBtRqTZXF3hpJCU+/0DFy+QW7DR/FVDMWYa3S4doMQIVB6Aol11cQmZjsgE
3GN0eSraFIwqwqTOLjQ/vxsGELuzWTOTP1EJJQTxWTNBu86U+9TGB7lM3rcGJo82
bWOLRRppOBSzFTQoXFeRiE7TNvJmRmyEmJxykpZK7ULumFCQZSMgROOPWdvgoQJB
QCpG5dp64MIsaY1UWrTO2WfbOfuGI4rC4RgTu1G0zLm9PI+q3DZmECJFaSb2KGb0
ytMZUSxQlPUlleoMEg7W7JgyvFCvWZjAzxqUgwcNRhJv82W8bEOg/vjwlhT3MaXH
rTa+myZ1KHOv+QyLeXmTdaBTYjfYQNfAQlU3sgJ+GWb+YBAvA6ZJy8tzzN7XYZuY
qse/OOlYm8+fXRmQ/fgWGqPndxSVhwKtBmLQ5W/OpqrLklmz8rI/rAiHd8sEcLms
TNdNnP3Mg9PIE1gOEXMmTpjkvFeuCX2D+eKqNuruSi5K1OQQhW4CUOgVvTjhGEIb
hmU9t5p2KQB8XQtUPynBjomsP5kF9sFNjaON4rmGrdaE3H1yujpSxx+Z6O1WqNZb
hdEQnoKSyIJssLagWENvfcrJgrj5VLa0ckX4ix/8gZSELKb0dbY=
=35lI
-----END PGP SIGNATURE-----

--=-m8jrDxGeHb3iDK9zPcSk--

