Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67E4ADF751
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Oct 2019 23:09:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbfJUVJF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 21 Oct 2019 17:09:05 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:47805 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728943AbfJUVJF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 21 Oct 2019 17:09:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571692143;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=K0Z8W68yUa9mRK8rnH8TTdSxHMIbym3Dqs881H5tBwI=;
        b=UAJXca0/2SDyA0wZL842Wdm+LnHc1+ygksrOAUsVNSpmht0uZDi2fada1GTwCAeWtv4cwj
        uGG6wtzOZgK1ZOfxN+3b2iFYldmpoN8FijrnnSmKZMkHNBkV8qOK+C2enFm5OybH8n7jWK
        iljhNOYhTePX3RAP4hmHK0I2VB51ffQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-46-xLZ80fs2M_WVBBw0tFv9FA-1; Mon, 21 Oct 2019 17:08:59 -0400
X-MC-Unique: xLZ80fs2M_WVBBw0tFv9FA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2928D1800D79;
        Mon, 21 Oct 2019 21:08:57 +0000 (UTC)
Received: from linux-ws.nc.xsintricity.com (ovpn-112-37.rdu2.redhat.com [10.10.112.37])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 819B35C207;
        Mon, 21 Oct 2019 21:08:54 +0000 (UTC)
Message-ID: <113038cde3f1335ba9bf4d66f22f0a536b70ef1f.camel@redhat.com>
Subject: Re: [PATCH] RDMA/hns: Fix build error again
From:   Doug Ledford <dledford@redhat.com>
To:     Arnd Bergmann <arnd@arndb.de>, Lijun Ou <oulijun@huawei.com>,
        "Wei Hu(Xavier)" <xavier.huwei@huawei.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Hulk Robot <hulkci@huawei.com>, YueHaibing <yuehaibing@huawei.com>,
        Shaobo Xu <xushaobo2@huawei.com>,
        Shamir Rabinovitch <shamir.rabinovitch@oracle.com>,
        Xi Wang <wangxi11@huawei.com>, Tao Tian <tiantao6@huawei.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 21 Oct 2019 17:08:51 -0400
In-Reply-To: <20191007211826.3361202-1-arnd@arndb.de>
References: <20191007211826.3361202-1-arnd@arndb.de>
Organization: Red Hat, Inc.
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-xdJ3eT+RkUC2bnG5G+ko"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--=-xdJ3eT+RkUC2bnG5G+ko
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2019-10-07 at 23:18 +0200, Arnd Bergmann wrote:
> This is not the first attempt to fix building random configurations,
> unfortunately the attempt in commit a07fc0bb483e ("RDMA/hns: Fix build
> error") caused a new problem when CONFIG_INFINIBAND_HNS_HIP06=3Dm
> and CONFIG_INFINIBAND_HNS_HIP08=3Dy:
>=20
> drivers/infiniband/hw/hns/hns_roce_main.o:(.rodata+0xe60): undefined
> reference to `__this_module'
>=20
> Revert commits a07fc0bb483e ("RDMA/hns: Fix build error") and
> a3e2d4c7e766 ("RDMA/hns: remove obsolete Kconfig comment") to get
> back to the previous state, then fix the issues described there
> differently, by adding more specific dependencies: INFINIBAND_HNS
> can now only be built-in if at least one of HNS or HNS3 are
> built-in, and the individual back-ends are only available if
> that code is reachable from the main driver.
>=20
> Fixes: a07fc0bb483e ("RDMA/hns: Fix build error")
> Fixes: a3e2d4c7e766 ("RDMA/hns: remove obsolete Kconfig comment")
> Fixes: dd74282df573 ("RDMA/hns: Initialize the PCI device for hip08
> RoCE")
> Fixes: 08805fdbeb2d ("RDMA/hns: Split hw v1 driver from hns roce
> driver")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

This fix looks reasonable, but since I can't test this at all, and I'm
personally tired of trying and failing to fix this issue, I need to ask
if you've tried all the permutations for this just to confirm it works
in all valid cases?

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

--=-xdJ3eT+RkUC2bnG5G+ko
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAl2uHmQACgkQuCajMw5X
L91tVQ/9FAENQf09oJLkU4SWaKcw3v/yjdgKyHgQT8JXUeDA43uoSE75p0aHninr
uyo7+nqCmvOXRMsrINbDAR+FfsVC1kNsqLXx0QJcTztVTCNfkXgHjn8X6c2CT/fi
6HupawhqmuklQO95W+MHijE/ej3qeBKTHOZIYsG1B0uTTQeSHU0PNlji7Cf/AcZr
nK1+8PHs1cxtM+aWjFRbQNXcL/pslrXcdYWJIoXHylXkBkjDH/OzIN8hzW8XfAa5
hSlmEMA6H/YsnUjOn7mKk18dgAm0tPSAGemDx3zv3j0vlJUOussfRU8t1DdOmR0r
nnRVsxF62Hrz0a3xQ0S3YSctv2dEzsAPno1fIWcAuqK5su93/kN9YcbLu98IPQ1o
2jMycnjtL7vEEzitbIwmcNXZ9Zl6pja9BhXMK34uEYRh/CIEqQt+esuhGNt3Kkua
jy+FRmgCxshvFVN234XFWHtgXuGPehciYR26lRFsGJlIxMResn6ENWPHXVcze4Ot
sVaHalxqElFmmEBW/p3JXp2GHSefrlndMpofIDTuRTudT2Q/t0ECVroknfDsmWNX
28rEqfGtUuHWeQr/zzV3SFVSMeo7tGhoSKAXy0e3rNuARvpzld9nM4M7SWdy4vkV
1pt7QmRU8g/OuXzsoQfRh087YxKHdFSjLtk3E/ZVvJmwsd/TTk0=
=lpPZ
-----END PGP SIGNATURE-----

--=-xdJ3eT+RkUC2bnG5G+ko--

