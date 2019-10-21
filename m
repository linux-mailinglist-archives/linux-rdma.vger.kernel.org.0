Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 301E1DF37E
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Oct 2019 18:46:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbfJUQqF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 21 Oct 2019 12:46:05 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:20131 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728305AbfJUQqF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 21 Oct 2019 12:46:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571676363;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=td2Yy+ZPt/Fj+knnX4kkCtLM9yXLmmBiQFArVkbUplY=;
        b=YygE2LaZhJWMsh5bF8D5mgZ7M51B4nfFCIwmK5BRJEZOU8xkAZSfhBPnwHdPeU60U0Q9oQ
        RQtEaTE0W9q6p7Ft0kPNsRKIm3rbPMan1n9C93V7vz5wrldgpSPUfVQeHZsApV1AK5bM/5
        /UutSZjvfbvtJqN+thvgn/Vov6e5tzY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-133-i4-p4HfwM7yIoOUaU5AGKw-1; Mon, 21 Oct 2019 12:46:01 -0400
X-MC-Unique: i4-p4HfwM7yIoOUaU5AGKw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9B175100550E;
        Mon, 21 Oct 2019 16:46:00 +0000 (UTC)
Received: from linux-ws.nc.xsintricity.com (ovpn-112-37.rdu2.redhat.com [10.10.112.37])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 541585DA60;
        Mon, 21 Oct 2019 16:45:58 +0000 (UTC)
Message-ID: <4ab0f98e4569a9700d94173c7f3d93e00bd9635b.camel@redhat.com>
Subject: Re: [RFC PATCH V2 for-next] RDMA/hns: Add UD support for hip08
From:   Doug Ledford <dledford@redhat.com>
To:     oulijun <oulijun@huawei.com>, Jason Gunthorpe <jgg@ziepe.ca>
Cc:     leon@kernel.org, linux-rdma@vger.kernel.org, linuxarm@huawei.com
Date:   Mon, 21 Oct 2019 12:45:56 -0400
In-Reply-To: <ad4a492cfd16ab37186d7fdead215ba52f5c3da5.camel@redhat.com>
References: <1571474772-2212-1-git-send-email-oulijun@huawei.com>
         <20191021141312.GD25178@ziepe.ca>
         <9eea1f7b-fef1-080a-2f54-64b914822c94@huawei.com>
         <ad4a492cfd16ab37186d7fdead215ba52f5c3da5.camel@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-+tOKK735i0uUN64ntpdZ"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--=-+tOKK735i0uUN64ntpdZ
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2019-10-21 at 10:58 -0400, Doug Ledford wrote:
> On Mon, 2019-10-21 at 22:20 +0800, oulijun wrote:
> > =E5=9C=A8 2019/10/21 22:13, Jason Gunthorpe =E5=86=99=E9=81=93:
> > > On Sat, Oct 19, 2019 at 04:46:12PM +0800, Lijun Ou wrote:
> > > > index bd78ff9..722cc5f 100644
> > > > +++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
> > > > @@ -377,6 +377,10 @@ static int hns_roce_set_user_sq_size(struct
> > > > hns_roce_dev *hr_dev,
> > > >  =09=09hr_qp->sge.sge_cnt =3D roundup_pow_of_two(hr_qp-
> > > > > sq.wqe_cnt *
> > > >  =09=09=09=09=09=09=09(hr_qp-
> > > > > sq.max_gs - 2));
> > > > =20
> > > > +=09if (hr_qp->ibqp.qp_type =3D=3D IB_QPT_UD)
> > > > +=09=09hr_qp->sge.sge_cnt =3D roundup_pow_of_two(hr_qp-
> > > > > sq.wqe_cnt *
> > > > +=09=09=09=09=09=09       hr_qp-
> > > > > sq.max_gs);
> > > > +
> > > >  =09if ((hr_qp->sq.max_gs > 2) && (hr_dev->pci_dev->revision=20
> > > > =3D=3D
> > > > 0x20)) {
> > > >  =09=09if (hr_qp->sge.sge_cnt > hr_dev-
> > > > >caps.max_extend_sg) {
> > > >  =09=09=09dev_err(hr_dev->dev,
> > > > @@ -1022,6 +1026,9 @@ struct ib_qp *hns_roce_create_qp(struct
> > > > ib_pd *pd,
> > > >  =09int ret;
> > > > =20
> > > >  =09switch (init_attr->qp_type) {
> > > > +=09case IB_QPT_UD:
> > > > +=09=09if (!capable(CAP_NET_RAW))
> > > > +=09=09=09return -EPERM;
> > > This needs a big comment explaining why this HW requires it.
> > >=20
> > > Jason
> > >=20
> > Add the detail comments for HW limit?
>=20
> I can add those comments while taking the pactch.  Plus we need to add
> a
> fallthrough annotation at the same place.  I'll fix it up and unfreeze
> the hns queue.
>=20

Does this meet people's approval?

        switch (init_attr->qp_type) {
        case IB_QPT_UD:
                /*
                 * DO NOT REMOVE!
                 * The HNS RoCE hardware has a security vulnerability.
                 * Normally, UD packet routing is achieved using nothing
                 * but the ib_ah struct, which contains the src gid in the
                 * sgid_attr element.  Th src gid is sufficient for the
                 * hardware to know if any vlan tag is needed, as well as
                 * any priority tag.  In the case of HNS RoCE, the vlan
                 * tag is passed to the hardware along with the src gid.
                 * This allows a situation where a malicious user could
                 * intentionally send packets with a gid that belongs to
                 * vlan A, but direct the packets to go out to vlan B
                 * instead.
                 * Because the ability to send out packets with arbitrary
                 * headers is reserved for CAP_NET_RAW, and because UD
                 * queue pairs can be tricked into doing that, make all
                 * UD queue pairs on this hardware require CAP_NET_RAW.
                 */
                if (!capable(CAP_NET_RAW))
                        return -EPERM;
                /* fallthrough */
        case IB_QPT_RC: {

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

--=-+tOKK735i0uUN64ntpdZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAl2t4MQACgkQuCajMw5X
L93ZrQ//Qwdja4MjlsTUOhB/dtLHSQJUn9lpSFnhNhapVVVo6QNBEYd7VjdQ2pyN
zZcoDDoPRQYKOSPZ7Gcec6UQEAPnJ/yG5b2AnZKlRe6kxkeGIuaM814OEcw3mgOC
vMqOGSsRFqRsSpwDu/cdxRGVhPG9KQH1itTV/qOUEDb9y5qIYd9IlrTUK2z8uCth
DddFUW8VsPJcPxjJ0c+Iq6nvSU6SZMGPBNEiFU+8scZv/vYvHEd+hJlM78CXh3re
57KX61RvZLB/wr0owYAitGU3Rt2TD3+ywqVDmKuKnVw16sV77uBc7nkIBpaKie5X
7PnQrTKnSePaR37+6YDOb7+SkErh1TfYNx6ktrRSkGrf06FsWlErx6F0I/mbBnqb
2cmBqUA+vyGIklCIAX5iTdaCZDTSZjJeb51IaEpMdR78eP65DDwkDtbdMeZ54fJe
auhPlkIUF8mcHKbyeb/0Sex5imT2bLpEJ2fAS7NlpqvFhBULPI9xQqOCZeUk2Lsa
/beVcYMTkqWUlChT0Uj8Hxz+/jO1i0SGUNJh/4T57AZJMj/ey3hA3ftfp8D2ep3q
aPtsb0XoJcFu9VPQGDlojOGpwKL2//DvkGcbbtg78ZgFpMG7UvvOgJXHljKyegsv
E0d9VJ+NKATNIMr976yMhL7h8o5p0zngL3sa8LMkZ5yLMBkzOpw=
=n9YP
-----END PGP SIGNATURE-----

--=-+tOKK735i0uUN64ntpdZ--

