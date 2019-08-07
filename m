Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7DB89853AC
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Aug 2019 21:39:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389165AbfHGTjC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 7 Aug 2019 15:39:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59934 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388881AbfHGTjC (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 7 Aug 2019 15:39:02 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 859578E594;
        Wed,  7 Aug 2019 19:39:01 +0000 (UTC)
Received: from linux-ws.nc.xsintricity.com (ovpn-112-53.rdu2.redhat.com [10.10.112.53])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 617785DA60;
        Wed,  7 Aug 2019 19:39:00 +0000 (UTC)
Message-ID: <c4af76063f6cd72b8dccf21d4256273a69fad309.camel@redhat.com>
Subject: Re: [PATCH V3 for-next 00/13] Updates for 5.3-rc2
From:   Doug Ledford <dledford@redhat.com>
To:     Lijun Ou <oulijun@huawei.com>, jgg@ziepe.ca
Cc:     leon@kernel.org, linux-rdma@vger.kernel.org, linuxarm@huawei.com
Date:   Wed, 07 Aug 2019 15:38:57 -0400
In-Reply-To: <1564821919-100676-1-git-send-email-oulijun@huawei.com>
References: <1564821919-100676-1-git-send-email-oulijun@huawei.com>
Organization: Red Hat, Inc.
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-fT4y31hq65L0X6rzCmvf"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Wed, 07 Aug 2019 19:39:01 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


--=-fT4y31hq65L0X6rzCmvf
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 2019-08-03 at 16:45 +0800, Lijun Ou wrote:
> Here are some updates for hns driver based 5.3-rc2, mainly
> include some codes optimization and comments style modification.
>=20
> Change from V2:
> 1. Remove the unncessary memset opertion for the tenth patch
>=20
> Change from V1:
> 1. Fix the checkpatch warning
> 2. Use ibdev print interface instead of dev print interface in
>    this patchset.

I need you to separate the ibdev changes from other changes.  I have
other comments on the patches that I'll make on the individual patches,
but just in general, do one single patch to switch to using ibdev prints
and have it cover the entire driver.  You can make it the first or last
patch, I don't care.  But don't mix anything else in with the ibdev
transition patch.  You shouldn't be mixing things like fixing an
incorrect print with a switch to ibdev print in the same patch because
it makes it very difficult on people that might be backporting these
patches to take the fix if they haven't also taken the ibdev print
patchset.

>=20
> Lang Cheng (6):
>   RDMA/hns: Clean up unnecessary initial assignment
>   RDMA/hns: Update some comments style
>   RDMA/hns: Handling the error return value of hem function
>   RDMA/hns: Split bool statement and assign statement
>   RDMA/hns: Refactor irq request code
>   RDMA/hns: Remove unnecessary kzalloc
>=20
> Lijun Ou (2):
>   RDMA/hns: Encapsulate some lines for setting sq size in user mode
>   RDMA/hns: Optimize hns_roce_modify_qp function
>=20
> Weihang Li (2):
>   RDMA/hns: Remove redundant print in hns_roce_v2_ceq_int()
>   RDMA/hns: Disable alw_lcl_lpbk of SSU
>=20
> Yangyang Li (1):
>   RDMA/hns: Refactor hns_roce_v2_set_hem for hip08
>=20
> Yixian Liu (2):
>   RDMA/hns: Update the prompt message for creating and destroy qp
>   RDMA/hns: Remove unnessary init for cmq reg
>=20
>  drivers/infiniband/hw/hns/hns_roce_device.h |  65 +++++----
>  drivers/infiniband/hw/hns/hns_roce_hem.c    |  15 +-
>  drivers/infiniband/hw/hns/hns_roce_hem.h    |   6 +-
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 211 ++++++++++++++-----
> ---------
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.h  |   2 -
>  drivers/infiniband/hw/hns/hns_roce_mr.c     |   1 -
>  drivers/infiniband/hw/hns/hns_roce_qp.c     | 178 ++++++++++++++-----
> ----
>  7 files changed, 260 insertions(+), 218 deletions(-)
>=20

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

--=-fT4y31hq65L0X6rzCmvf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAl1LKNEACgkQuCajMw5X
L910Qg/8CxICIit8f2Aalz+FEzIkvUItsOBhXrNZV0MrEXpQ1gZhP5DNp1+cMJwM
E0IWEABTomhRMQywii6qzV3wRc6pvRuqPkeZX/RaO+lgLYlXxgAPOs5H5bGEChVE
4wqnZ5SEpxni+CjwMHL7cTirLR4Xi+STnPtigglNllSp1cToKgPgozbKIwG4DgY/
96l2Ce1ggZlTh3ZWSQkfJ4bjNDo6zgpyLxKQPwZ9evf+wjrtZQLCzSrpVt+feg8F
lX7NxOVMvFvXPwvTIpjxjKR/vrzym29BTzwLe+ejSR5UVIh7WiV3Q9nVnrMb/HJm
P90YuHW+Zw5K5FJiEZ6+FlrmM5x3Ca3h/7Vg0NcRy+Fm2cjaqLYYR9s+BJ8gXqQ2
nCFnp9OXVnMJGGWgPWVhwCr53t09Qy1eVitTAIGAf7CSSgu0w9m5SLUz7cuK6Iju
3kmBHuQGM99NMZX23JebwcKCfiooHPxJpToynZHEdrDoAHLYAjoOtpcPSqTQw5cA
kLE2nAe5EcYhhyIOMAM2plMk5Qec+TmhdcloGncg/aGQQwxVzqeqBSPcfaUWWpPV
gMcDKRNnz/uageF9IRP39e7nNcmfmwJaV4ee49e1aoiD/OCP5R4gq3djMIlXIyYI
f2k3FIT+g+vbEOysiLaFVtPEPXffDnYai4Pi8k+zfhROBqACDDI=
=27kj
-----END PGP SIGNATURE-----

--=-fT4y31hq65L0X6rzCmvf--

