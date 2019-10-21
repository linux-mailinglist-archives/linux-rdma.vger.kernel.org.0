Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB751DF0A8
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Oct 2019 16:58:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727406AbfJUO65 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 21 Oct 2019 10:58:57 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35029 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727111AbfJUO65 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 21 Oct 2019 10:58:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571669936;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PJ88JUe2zlP/DIcCN3rDW26plMW/uQwu1zn5crFxXMU=;
        b=GFEjuJp5h3IHKloshrc39b3BQyC7cQKFIA7nxuYoaamMTGh4gR9JhztfX8u9x8mt3vMjoi
        ppqGzxU+uOYN4ODU0q5mjaDBmewu14q30V0kt6eLFJbcBevxJ0bGxgVw6iMYnGdZA1HOZ2
        dz3kGxJ9SWIgPEVaCqmbZaeyoTMWeFk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-15-WvG7SxzWNxWWZiuotoA5ww-1; Mon, 21 Oct 2019 10:58:52 -0400
X-MC-Unique: WvG7SxzWNxWWZiuotoA5ww-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6DD921005500;
        Mon, 21 Oct 2019 14:58:45 +0000 (UTC)
Received: from linux-ws.nc.xsintricity.com (ovpn-112-37.rdu2.redhat.com [10.10.112.37])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5B50017278;
        Mon, 21 Oct 2019 14:58:44 +0000 (UTC)
Message-ID: <ad4a492cfd16ab37186d7fdead215ba52f5c3da5.camel@redhat.com>
Subject: Re: [RFC PATCH V2 for-next] RDMA/hns: Add UD support for hip08
From:   Doug Ledford <dledford@redhat.com>
To:     oulijun <oulijun@huawei.com>, Jason Gunthorpe <jgg@ziepe.ca>
Cc:     leon@kernel.org, linux-rdma@vger.kernel.org, linuxarm@huawei.com
Date:   Mon, 21 Oct 2019 10:58:41 -0400
In-Reply-To: <9eea1f7b-fef1-080a-2f54-64b914822c94@huawei.com>
References: <1571474772-2212-1-git-send-email-oulijun@huawei.com>
         <20191021141312.GD25178@ziepe.ca>
         <9eea1f7b-fef1-080a-2f54-64b914822c94@huawei.com>
Organization: Red Hat, Inc.
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-R6IZ3O0s/FbqLMCuCpJq"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--=-R6IZ3O0s/FbqLMCuCpJq
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2019-10-21 at 22:20 +0800, oulijun wrote:
> =E5=9C=A8 2019/10/21 22:13, Jason Gunthorpe =E5=86=99=E9=81=93:
> > On Sat, Oct 19, 2019 at 04:46:12PM +0800, Lijun Ou wrote:
> > > index bd78ff9..722cc5f 100644
> > > +++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
> > > @@ -377,6 +377,10 @@ static int hns_roce_set_user_sq_size(struct
> > > hns_roce_dev *hr_dev,
> > >  =09=09hr_qp->sge.sge_cnt =3D roundup_pow_of_two(hr_qp-
> > > >sq.wqe_cnt *
> > >  =09=09=09=09=09=09=09(hr_qp-
> > > >sq.max_gs - 2));
> > > =20
> > > +=09if (hr_qp->ibqp.qp_type =3D=3D IB_QPT_UD)
> > > +=09=09hr_qp->sge.sge_cnt =3D roundup_pow_of_two(hr_qp-
> > > >sq.wqe_cnt *
> > > +=09=09=09=09=09=09       hr_qp-
> > > >sq.max_gs);
> > > +
> > >  =09if ((hr_qp->sq.max_gs > 2) && (hr_dev->pci_dev->revision =3D=3D
> > > 0x20)) {
> > >  =09=09if (hr_qp->sge.sge_cnt > hr_dev->caps.max_extend_sg) {
> > >  =09=09=09dev_err(hr_dev->dev,
> > > @@ -1022,6 +1026,9 @@ struct ib_qp *hns_roce_create_qp(struct
> > > ib_pd *pd,
> > >  =09int ret;
> > > =20
> > >  =09switch (init_attr->qp_type) {
> > > +=09case IB_QPT_UD:
> > > +=09=09if (!capable(CAP_NET_RAW))
> > > +=09=09=09return -EPERM;
> > This needs a big comment explaining why this HW requires it.
> >=20
> > Jason
> >=20
> Add the detail comments for HW limit?

I can add those comments while taking the pactch.  Plus we need to add a
fallthrough annotation at the same place.  I'll fix it up and unfreeze
the hns queue.

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

--=-R6IZ3O0s/FbqLMCuCpJq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAl2tx6EACgkQuCajMw5X
L91iwBAAmmOgBVPMgjyYPpQgf58veBcuXWLLgW+oHdBq0lX8jMDzKxEqJAanZeTY
XbgyrUwk6J4O2kP/DBuiRC7LK2YWN+gSu4kEeaJDSWbWJ2CJUNaWag/RTIZSHTpm
ed+rqVVQq7UJlNKnfcaHFhHors1xEqGS4S6DlQcbWm0z8CPeKYiYiKwnTot49mBD
UiYcLtyPrDbIIlUd9WgL/+D/6oAZbmOxDZq8ivZABtd6jkyRRhx7ipWasi+Doy1x
xH8n329Gh3UhSvtjnGx+yEwX9ZUlZtqvIfm610fDY/yeqZrA46g31+goVe6P3+4V
8MQTtoEiasQsi2zy44ucjUD1CC2GK4x5/557PkVXK9qLQylIEx6ryAulLWXL+X5y
9Ti5Ev3ME+YNPM0BROe52nguOgjbaZTCjOoUe2wME885aa975jpyzs6nDXZSuEQF
evp26/dgjGvnspvc4AsIliVTk36xVEf2m0Qe3YBC6TkfS2HNVEJhlEmNdV/xvXYc
87/NjlGLaGVrkc8VWincNsoKBQlS+7Nh1JuMD0hjMmhmJ0/0fJGfezgaz0Md+CMR
mMOHfd3CDhL+6Ko+8eFb6E9Gw5ge40OcYGqxHr5I0oxZDQPHTCjbJinvfqggux1e
VyV76Hh3ntM1rK3uPKgn64ay2KvMpaZjeg8AneDjMgc6J3YLxgQ=
=tONA
-----END PGP SIGNATURE-----

--=-R6IZ3O0s/FbqLMCuCpJq--

