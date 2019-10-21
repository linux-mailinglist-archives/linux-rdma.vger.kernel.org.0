Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86AEBDF60C
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Oct 2019 21:33:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729906AbfJUTbW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 21 Oct 2019 15:31:22 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:45316 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726672AbfJUTbV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 21 Oct 2019 15:31:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571686280;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wMHE9njDUR2fpWn8rPDCgex+R5/8QXywGbmF+npogjM=;
        b=WhVZ8/I+v9iVkfmCItopF/zbpecFf1DfaTNEDGhG6g6nia1hcO2HuOigYJ3qayJPZT4nK4
        rMAnVeP/aQSI7PrgV/nz0XihfwwBNKf7UMlBjeER6kP0c1J5BqILWGdwXPQt695m45hYrP
        vav88GmhYpm4snoUS6LoWm6338vSLfw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-278-qJE8eBYeOWyCwUiIDWxcww-1; Mon, 21 Oct 2019 15:31:16 -0400
X-MC-Unique: qJE8eBYeOWyCwUiIDWxcww-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 77617107AD31;
        Mon, 21 Oct 2019 19:31:15 +0000 (UTC)
Received: from linux-ws.nc.xsintricity.com (ovpn-112-37.rdu2.redhat.com [10.10.112.37])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 79D9E1001B33;
        Mon, 21 Oct 2019 19:31:14 +0000 (UTC)
Message-ID: <1da5615253c63911af50644ca7e42fe313be1222.camel@redhat.com>
Subject: Re: [PATCH for-next 0/5] Some bugfixes and cleanups for hip08
From:   Doug Ledford <dledford@redhat.com>
To:     Weihang Li <liweihang@hisilicon.com>, jgg@ziepe.ca
Cc:     linux-rdma@vger.kernel.org, linuxarm@huawei.com
Date:   Mon, 21 Oct 2019 15:31:11 -0400
In-Reply-To: <1567566885-23088-1-git-send-email-liweihang@hisilicon.com>
References: <1567566885-23088-1-git-send-email-liweihang@hisilicon.com>
Organization: Red Hat, Inc.
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-SatJYLOpRZUeq0xHb4PZ"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--=-SatJYLOpRZUeq0xHb4PZ
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2019-09-04 at 11:14 +0800, Weihang Li wrote:
> This patchset fixes two bugs in previous patches, and does some
> cleanups
> to increase readability.
>=20
> Lang Cheng (1):
>   RDMA/hns: Modify return value of restrack fucntions
>=20
> Weihang Li (3):
>   RDMA/hns: remove a redundant le16_to_cpu
>   RDMA/hns: Fix wrong parameters when initial mtt of srq->idx_que
>   RDMA/hns: Modify variable/field name from vlan to vlan_id
>=20
> Yixing Liu (1):
>   RDMA/hns: Fix a spelling mistake in a macro
>=20
>  drivers/infiniband/hw/hns/hns_roce_ah.c       | 14 +++++++-------
>  drivers/infiniband/hw/hns/hns_roce_device.h   |  4 ++--
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c    | 10 +++++-----
>  drivers/infiniband/hw/hns/hns_roce_qp.c       | 24 ++++++++++++----
> --------
>  drivers/infiniband/hw/hns/hns_roce_restrack.c |  2 +-
>  drivers/infiniband/hw/hns/hns_roce_srq.c      | 24 ++++++++++++++--
> --------
>  6 files changed, 41 insertions(+), 37 deletions(-)
>=20

I fixed some typos in the commit messages, but otherwise these look OK.=20
Applied to for-next.

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

--=-SatJYLOpRZUeq0xHb4PZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAl2uB38ACgkQuCajMw5X
L938/Q//Uwd4mAXgSDXAmd2Yc3USakDjb9J3qxjGEMoyvGDTLUy6Qpzg0Ymx3p3g
rahmsRr9rh/aBUaX5l/K/ST6RpOf0iXUMsxfxLzCEV5YaIjjdxxIF61ww43BeN0w
+/fee9VcqCMQr9+wVhQlOBXgu4CmEgqsNAg208PPkdig/heOgvYSzJqQ5FcmdyoR
XcPVHU8VqLQBxqJ+qtQbxQtSdq8rmRIocWOspJAMKDXV5tEeFPQlOlleYRW75qQg
WqR9JrnG6hQvXp6osNVUCtaZ9PRw+8FL4J/CwKeMGLyMiOTE+P0lcuXvoh1KIZKi
JIy6qdcLnMOcBXr0q5SkltNJgplCHJ/1Y/DDZinV6slJQ+kcl4exD+ssAtsyvA1W
FPjlND/4pM5JpNdyM64SmwhYUkbOB6O1g+bx0j4veqMme2x5+oK81Ztpgpb9Vbit
qSLfrS+EkM4pru5RMGlCGWJ4LDSNrbt+RK4SSrt2iZj2ogo/Dw7a0FP+nA84RrTF
UpSACwinqcueVpDIiLtUzpF2/69k4+wuavesvlPoYasglnlRltzjZ3DfSro7g7kE
rPy+RQEYfnQk/uaUJaxtRbr2JoJ9P1qktd7aVSnCpFXPFADpQbVgCs/p/fluC7bX
VDDLI0j4OoKqvPeVPoCKwLoad4d+tHtP+VxXaf+76FpBIH9BUWc=
=65UG
-----END PGP SIGNATURE-----

--=-SatJYLOpRZUeq0xHb4PZ--

