Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC09C1239B
	for <lists+linux-rdma@lfdr.de>; Thu,  2 May 2019 22:50:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726304AbfEBUuN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 2 May 2019 16:50:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55606 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726145AbfEBUuM (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 2 May 2019 16:50:12 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1BEC2308FF30;
        Thu,  2 May 2019 20:50:12 +0000 (UTC)
Received: from haswell-e.nc.xsintricity.com (ovpn-112-9.rdu2.redhat.com [10.10.112.9])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5738F5DA34;
        Thu,  2 May 2019 20:50:11 +0000 (UTC)
Message-ID: <6ff4c15a28b585f41125fc264086c0d1aedefe4d.camel@redhat.com>
Subject: Re: Is this a known build issue on s390x for v5.1-rc7?
From:   Doug Ledford <dledford@redhat.com>
To:     jtoppins@redhat.com, Jason Gunthorpe <jgg@mellanox.com>
Cc:     RDMA mailing list <linux-rdma@vger.kernel.org>
Date:   Thu, 02 May 2019 16:50:04 -0400
In-Reply-To: <9dd7f774-2b14-d4a7-3a85-edff758e36d0@redhat.com>
References: <9dd7f774-2b14-d4a7-3a85-edff758e36d0@redhat.com>
Organization: Red Hat, Inc.
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-DMYumEvgswNIgGT9jKvy"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Thu, 02 May 2019 20:50:12 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


--=-DMYumEvgswNIgGT9jKvy
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2019-05-02 at 16:48 -0400, Jonathan Toppins wrote:
> $ git log --oneline -1
> 37624b58542f (HEAD, tag: v5.1-rc7, stable/master, rdma/master,
> acpi/master) Linux 5.1-rc7
>=20
> $ make ARCH=3Ds390 CROSS_COMPILE=3Ds390x-linux-gnu-
> KCONFIG_CONFIG=3D../kernel-4.18.0-s390x.config all
>   CALL    scripts/checksyscalls.sh
>   CALL    scripts/atomic/check-atomics.sh
>   CHK     include/generated/compile.h
>   LD [M]  drivers/infiniband/core/ib_core.o
>   LD [M]  drivers/infiniband/core/ib_cm.o
>   LD [M]  drivers/infiniband/core/iw_cm.o
>   LD [M]  drivers/infiniband/core/rdma_cm.o
>   CC [M]  drivers/infiniband/core/uverbs_main.o
> In file included from ./arch/s390/include/asm/page.h:180:0,
>                  from ./arch/s390/include/asm/thread_info.h:26,
>                  from ./include/linux/thread_info.h:38,
>                  from ./arch/s390/include/asm/preempt.h:6,
>                  from ./include/linux/preempt.h:78,
>                  from ./include/linux/spinlock.h:51,
>                  from ./include/linux/seqlock.h:36,
>                  from ./include/linux/time.h:6,
>                  from ./include/linux/stat.h:19,
>                  from ./include/linux/module.h:10,
>                  from drivers/infiniband/core/uverbs_main.c:37:
> drivers/infiniband/core/uverbs_main.c: In function =E2=80=98rdma_umap_fau=
lt=E2=80=99:
> drivers/infiniband/core/uverbs_main.c:898:28: error: =E2=80=98struct vm_f=
ault=E2=80=99
> has no member named =E2=80=98vm_start=E2=80=99
>    vmf->page =3D ZERO_PAGE(vmf->vm_start);
>                             ^
> ./include/asm-generic/memory_model.h:54:40: note: in definition of macro
> =E2=80=98__pfn_to_page=E2=80=99
>  #define __pfn_to_page(pfn) (vmemmap + (pfn))
>                                         ^
> ./arch/s390/include/asm/page.h:162:29: note: in expansion of macro =E2=80=
=98__pa=E2=80=99
>  #define virt_to_pfn(kaddr) (__pa(kaddr) >> PAGE_SHIFT)
>                              ^
> ./arch/s390/include/asm/page.h:166:41: note: in expansion of macro
> =E2=80=98virt_to_pfn=E2=80=99
>  #define virt_to_page(kaddr) pfn_to_page(virt_to_pfn(kaddr))
>                                          ^
> ./arch/s390/include/asm/pgtable.h:60:3: note: in expansion of macro
> =E2=80=98virt_to_page=E2=80=99
>   (virt_to_page((void *)(empty_zero_page + \
>    ^
> drivers/infiniband/core/uverbs_main.c:898:15: note: in expansion of
> macro =E2=80=98ZERO_PAGE=E2=80=99
>    vmf->page =3D ZERO_PAGE(vmf->vm_start);
>                ^
> make[4]: *** [drivers/infiniband/core/uverbs_main.o] Error 1
> make[3]: *** [drivers/infiniband/core] Error 2
> make[2]: *** [drivers/infiniband] Error 2
> make[1]: *** [drivers] Error 2
> make: *** [sub-make] Error 2

Yes, there's a fix in Linus' tree for it.

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Key fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

--=-DMYumEvgswNIgGT9jKvy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAlzLV/wACgkQuCajMw5X
L93V5A//f1vNdanrQXTYWpgy7lh4w0cA0icud4N3ZO/Dw55eXkzDB45hoUnMr5gA
uMDYZFggUJp9xLVJclN8u6HyIfHluR1JdBdAcfRXMwnqM5uTdTu/3FgDenXuHV/k
s1KTqi5VQxy6tKALztcgOgBmWds66edXzzIsO3Syos5GLCyhPcAJ6tlOF3GMtM1h
XzsSQROes9gJzANy24q7BjiZQPbwiJLYo7Io8EvtZjkYiQ7xbjx9mTDQboPYPbMA
d1ug7/q4WoItzCp45F0NjqmmrlPN/Q8wfvQzDw7saypYEHwUaMHE/WxSFnijZDk4
3v6vGxZ8XZ/BgulTIXMgewLv02pJwaGC6iWSeKrKvOtiBNT4En3B2nMsnyAFk3w5
oKP3zXlaECnTcuubFbcs1ddGK4AVYS4vEdT9EJqVc2LwuQlst4pzmdRBZp1CLrZK
oUdeDJNvta3I9RyP3YyWaYxaf51VQ40dvp9P9DLndXke5WBiOS7NTmxiDFSTPs1I
8snlHhzRGMX2QvJYmbzU+7pFNdGXUAYDhiJz7nTAR4iQL21K1i21kd2YxjDjwpOe
Oq/bSG5ZGC2eb/JkhtmN9oPyMOG1LMlGOhnR6PcyKwGzrbosMCPx936DUs+6LIm7
gJfzbCv2UI1zZAcIg41hdXMMuBEjbNMHEt1mm5AMzdVwwU6h7Bc=
=SPPV
-----END PGP SIGNATURE-----

--=-DMYumEvgswNIgGT9jKvy--

