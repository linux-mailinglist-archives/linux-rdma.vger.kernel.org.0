Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA4549678B
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Aug 2019 19:27:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727272AbfHTR0s (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 20 Aug 2019 13:26:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42582 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728770AbfHTR0s (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 20 Aug 2019 13:26:48 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CDA2DC06511B;
        Tue, 20 Aug 2019 17:26:47 +0000 (UTC)
Received: from linux-ws.nc.xsintricity.com (ovpn-112-63.rdu2.redhat.com [10.10.112.63])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B5C2818398;
        Tue, 20 Aug 2019 17:26:46 +0000 (UTC)
Message-ID: <07b4dc9dc8e7c6f63d9b291cc6b65b60279d8878.camel@redhat.com>
Subject: Re: [PATCH] infiniband: hfi1: fix memory leaks
From:   Doug Ledford <dledford@redhat.com>
To:     Wenwen Wang <wenwen@cs.uga.edu>
Cc:     Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "open list:HFI1 DRIVER" <linux-rdma@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Date:   Tue, 20 Aug 2019 13:26:44 -0400
In-Reply-To: <1566154486-3713-1-git-send-email-wenwen@cs.uga.edu>
References: <1566154486-3713-1-git-send-email-wenwen@cs.uga.edu>
Organization: Red Hat, Inc.
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-sSFn/1mFmw9WT7aLHt6k"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Tue, 20 Aug 2019 17:26:47 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


--=-sSFn/1mFmw9WT7aLHt6k
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 2019-08-18 at 13:54 -0500, Wenwen Wang wrote:
> In fault_opcodes_write(), 'data' is allocated through kcalloc().
> However,
> it is not deallocated in the following execution if an error occurs,
> leading to memory leaks. To fix this issue, introduce the 'free_data'
> label
> to free 'data' before returning the error.
>=20
> Signed-off-by: Wenwen Wang <wenwen@cs.uga.edu>

Applied to for-rc, thanks.

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

--=-sSFn/1mFmw9WT7aLHt6k
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAl1cLVQACgkQuCajMw5X
L93jZg/+MxcKvHb+QXykPs2/eT8ONmImDf0YevpfmiDJd0ViT1vPW5hHHk63HtOc
NWRS2O2M0PJWVq/JPfIrxgA/B9QwtyNOIh3E7B4WZRgXNT2yWsMO+UFTNIHY4VNH
Sxm1NCsSgcswoZszkkxg8x8m5OLeiCtpzWw4svDEVGsnveqLRebvhG49K+KuuZnF
naktESmo/3IW+kMIPiY/a7PPCeXcPXDjLaZO4L0IZUrDnOQlJMfN5SxptHTTkegg
jPnWMaY5IEzU7s6xcqTaov6AdF8LXUwFP5UhIvlYa6gj5jkkBcDddo9ArHU4pJZ/
Ci+qm5wdLNbKW/CUt3wStnjWA0twy/OuS+adAG+0myDiUya2T7k1mJVOUNNnjxpi
4bQxtnn52nL3wUfWhr+fhm1w++hKCufmR8x4o4+7WpiamYC+MYxjKPRijYKI2wq6
bvMhw7NE0lA+p0V7eCqvY2fRcnJDVvejogNTZkQZLZtvk1y0NMg1PARwkEZA6a4F
mpJNwWjwR5UWFUzy7xO1wC4PY0tH2pDMVukbQ4iViigNPAff6Cf6XP2wRoYiTWlI
9ZN9uonhOIZ1OSNpqA+SnysPl1KbOTSUfadYljKkRIDQ2ieuCqaws1xbZWmosQol
o/ZuMNlo1cD0n0iwuDo/mq+NzKzrD21+Ceh94kc+0S5pROVl16w=
=xI7k
-----END PGP SIGNATURE-----

--=-sSFn/1mFmw9WT7aLHt6k--

