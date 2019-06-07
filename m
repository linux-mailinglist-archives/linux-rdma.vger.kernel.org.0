Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31323382F8
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Jun 2019 05:07:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbfFGDG7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 6 Jun 2019 23:06:59 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:1338 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726519AbfFGDG6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 6 Jun 2019 23:06:58 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cf9d4d00000>; Thu, 06 Jun 2019 20:06:56 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Thu, 06 Jun 2019 20:06:58 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Thu, 06 Jun 2019 20:06:58 -0700
Received: from [10.110.48.28] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 7 Jun
 2019 03:06:53 +0000
Subject: Re: [PATCH v2 hmm 05/11] mm/hmm: Remove duplicate condition test
 before wait_event_timeout
To:     Jason Gunthorpe <jgg@ziepe.ca>, Jerome Glisse <jglisse@redhat.com>,
        "Ralph Campbell" <rcampbell@nvidia.com>, <Felix.Kuehling@amd.com>
CC:     <linux-rdma@vger.kernel.org>, <linux-mm@kvack.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        <dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>,
        Jason Gunthorpe <jgg@mellanox.com>
References: <20190606184438.31646-1-jgg@ziepe.ca>
 <20190606184438.31646-6-jgg@ziepe.ca>
X-Nvconfidentiality: public
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <86962e22-88b1-c1bf-d704-d5a5053fa100@nvidia.com>
Date:   Thu, 6 Jun 2019 20:06:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190606184438.31646-6-jgg@ziepe.ca>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1559876816; bh=70o7ZS6CN7LiHClrr+qrAlqXgM2IDbvgx4VtZ9W6MfI=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=rcX/eN6SVVb8ntWY1bOCeo2lBWMdj/N0N59oEGCkUxTi+CQysb8+Bm72YdWdznjXv
         uMOqdy7CCjAssMyL0E+Wpqk7VGurL+Y48RwVXOiE8ewwA1U8PM/9NZJE3xkitfRbtm
         2R0tTcKErsh4WABPJBiUUMm4qcT3D6UQGwZHfks5mqPWmj/hL5PzkvqZmoGIUzQXf3
         h9jcXai0x0Nv32FWsJ/50DqS9x6531hNChV2FjPMMCXA0i+ZaV8RiLIfBNHoaTVury
         k8sBx3IJeGnHRXFDISxYSujNyNbyr19jEa+rGYPb4C2q0guYMp9a4Ef1nDI5HcNP4z
         RX+XUhHxNd0JQ==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 6/6/19 11:44 AM, Jason Gunthorpe wrote:
> From: Jason Gunthorpe <jgg@mellanox.com>
>=20
> The wait_event_timeout macro already tests the condition as its first
> action, so there is no reason to open code another version of this, all
> that does is skip the might_sleep() debugging in common cases, which is
> not helpful.
>=20
> Further, based on prior patches, we can no simplify the required conditio=
n

                                          "now simplify"

> test:
>  - If range is valid memory then so is range->hmm
>  - If hmm_release() has run then range->valid is set to false
>    at the same time as dead, so no reason to check both.
>  - A valid hmm has a valid hmm->mm.
>=20
> Also, add the READ_ONCE for range->valid as there is no lock held here.
>=20
> Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
> Reviewed-by: J=C3=A9r=C3=B4me Glisse <jglisse@redhat.com>
> ---
>  include/linux/hmm.h | 12 ++----------
>  1 file changed, 2 insertions(+), 10 deletions(-)
>=20
> diff --git a/include/linux/hmm.h b/include/linux/hmm.h
> index 4ee3acabe5ed22..2ab35b40992b24 100644
> --- a/include/linux/hmm.h
> +++ b/include/linux/hmm.h
> @@ -218,17 +218,9 @@ static inline unsigned long hmm_range_page_size(cons=
t struct hmm_range *range)
>  static inline bool hmm_range_wait_until_valid(struct hmm_range *range,
>  					      unsigned long timeout)
>  {
> -	/* Check if mm is dead ? */
> -	if (range->hmm =3D=3D NULL || range->hmm->dead || range->hmm->mm =3D=3D=
 NULL) {
> -		range->valid =3D false;
> -		return false;
> -	}
> -	if (range->valid)
> -		return true;
> -	wait_event_timeout(range->hmm->wq, range->valid || range->hmm->dead,
> +	wait_event_timeout(range->hmm->wq, range->valid,
>  			   msecs_to_jiffies(timeout));
> -	/* Return current valid status just in case we get lucky */
> -	return range->valid;
> +	return READ_ONCE(range->valid);

Just to ensure that I actually understand the model: I'm assuming that the=
=20
READ_ONCE is there solely to ensure that range->valid is read *after* the
wait_event_timeout() returns. Is that correct?


>  }
> =20
>  /*
>=20

In any case, it looks good, so:

    Reviewed-by: John Hubbard <jhubbard@nvidia.com>

thanks,
--=20
John Hubbard
NVIDIA
