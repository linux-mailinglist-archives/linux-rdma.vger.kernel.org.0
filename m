Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD6BD3832B
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Jun 2019 05:37:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbfFGDho (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 6 Jun 2019 23:37:44 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:2084 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726331AbfFGDho (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 6 Jun 2019 23:37:44 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cf9dc050000>; Thu, 06 Jun 2019 20:37:41 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 06 Jun 2019 20:37:43 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 06 Jun 2019 20:37:43 -0700
Received: from [10.110.48.28] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 7 Jun
 2019 03:37:43 +0000
Subject: Re: [PATCH v2 hmm 09/11] mm/hmm: Poison hmm_range during unregister
To:     Jason Gunthorpe <jgg@ziepe.ca>, Jerome Glisse <jglisse@redhat.com>,
        "Ralph Campbell" <rcampbell@nvidia.com>, <Felix.Kuehling@amd.com>
CC:     <linux-rdma@vger.kernel.org>, <linux-mm@kvack.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        <dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>,
        Jason Gunthorpe <jgg@mellanox.com>
References: <20190606184438.31646-1-jgg@ziepe.ca>
 <20190606184438.31646-10-jgg@ziepe.ca>
X-Nvconfidentiality: public
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <c00da0f2-b4b8-813b-0441-a50d4de9d8be@nvidia.com>
Date:   Thu, 6 Jun 2019 20:37:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190606184438.31646-10-jgg@ziepe.ca>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL104.nvidia.com (172.18.146.11) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1559878661; bh=hnXE0MxsnGUyN9sEUkzf3xpow50f6NZj1i458LDKMRY=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=N8RlWv2xDfEYSaLNfEgPO8HsRXdEbSEQyaFJIissVJcwJeh7EjuWKFbHWPoKUPURH
         Oyg92crCE7PWV1skDH1Wku3scQRSMDd14bfAWi5o86TBFjDfjyWCzOrPaqDnbTl4zn
         XqRZYR7aWKsZMbWTAsMzcVZLDJEioManv8HzxlJokeKWhxh4uXeJ8hD2cstTzfUALU
         Gc6Xqz2sKONzjUtI1v4WwoaBYZqbiZZHCU1iDWDMoIw3CAJmVktcqr85nR0n6+VTZb
         MTpSPfxRwhRMQQkkeqmrf4zQs27WL6ZQjPKzghI1xvJN5/Jzgu5WHMLVh2S52fWdU+
         FRSERUmJs5aWA==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 6/6/19 11:44 AM, Jason Gunthorpe wrote:
> From: Jason Gunthorpe <jgg@mellanox.com>
>=20
> Trying to misuse a range outside its lifetime is a kernel bug. Use WARN_O=
N
> and poison bytes to detect this condition.
>=20
> Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
> Reviewed-by: J=C3=A9r=C3=B4me Glisse <jglisse@redhat.com>
> ---
> v2
> - Keep range start/end valid after unregistration (Jerome)
> ---
>  mm/hmm.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>=20
> diff --git a/mm/hmm.c b/mm/hmm.c
> index 6802de7080d172..c2fecb3ecb11e1 100644
> --- a/mm/hmm.c
> +++ b/mm/hmm.c
> @@ -937,7 +937,7 @@ void hmm_range_unregister(struct hmm_range *range)
>  	struct hmm *hmm =3D range->hmm;
> =20
>  	/* Sanity check this really should not happen. */

That comment can also be deleted, as it has the same meaning as
the WARN_ON() that you just added.

> -	if (hmm =3D=3D NULL || range->end <=3D range->start)
> +	if (WARN_ON(range->end <=3D range->start))
>  		return;
> =20
>  	mutex_lock(&hmm->lock);
> @@ -948,7 +948,10 @@ void hmm_range_unregister(struct hmm_range *range)
>  	range->valid =3D false;
>  	mmput(hmm->mm);
>  	hmm_put(hmm);
> -	range->hmm =3D NULL;
> +
> +	/* The range is now invalid, leave it poisoned. */

To be precise, we are poisoning the range's back pointer to it's
owning hmm instance.  Maybe this is clearer:

	/*
	 * The range is now invalid, so poison it's hmm pointer.=20
	 * Leave other range-> fields in place, for the caller's use.
	 */

...or something like that?

> +	range->valid =3D false;
> +	memset(&range->hmm, POISON_INUSE, sizeof(range->hmm));
>  }
>  EXPORT_SYMBOL(hmm_range_unregister);
> =20
>=20

The above are very minor documentation points, so:

    Reviewed-by: John Hubbard <jhubbard@nvidia.com>


thanks,
--=20
John Hubbard
NVIDIA
