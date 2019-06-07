Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B4FD38322
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Jun 2019 05:29:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbfFGD3O (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 6 Jun 2019 23:29:14 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:1872 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbfFGD3O (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 6 Jun 2019 23:29:14 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cf9da070000>; Thu, 06 Jun 2019 20:29:11 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Thu, 06 Jun 2019 20:29:13 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Thu, 06 Jun 2019 20:29:13 -0700
Received: from [10.110.48.28] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 7 Jun
 2019 03:29:11 +0000
Subject: Re: [PATCH v2 hmm 08/11] mm/hmm: Remove racy protection against
 double-unregistration
To:     Jason Gunthorpe <jgg@ziepe.ca>, Jerome Glisse <jglisse@redhat.com>,
        "Ralph Campbell" <rcampbell@nvidia.com>, <Felix.Kuehling@amd.com>
CC:     <linux-rdma@vger.kernel.org>, <linux-mm@kvack.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        <dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>,
        Jason Gunthorpe <jgg@mellanox.com>
References: <20190606184438.31646-1-jgg@ziepe.ca>
 <20190606184438.31646-9-jgg@ziepe.ca>
X-Nvconfidentiality: public
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <88400de9-e1ae-509b-718f-c6b0f726b14c@nvidia.com>
Date:   Thu, 6 Jun 2019 20:29:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190606184438.31646-9-jgg@ziepe.ca>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1559878151; bh=/7QlQ0a6Qyg58unwdWuoBgEG7TwvTAAHiFUhlj29yto=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=AHwcMydKA1TgfD4RJqQNpr6LIUb1oEFYg5HcRS/+RnCuAUqh2s7TgUqrXgG40f3zE
         CJbyyUnf+fEgpmDguw/J/dlmtapUWsYu4zRJwhG4lAk5KJ1z8hJaflgO4aauzkfIkD
         9a2Ifmnv/v31YF4oOrOxY6hiYuHKUt7RRpZc6d4hjn0du6hzhHC9Jdt90HeTerzaxu
         XC8jJUk3O8sSZPt55m8DSfEC3PSlY/vAH6Oghir+BEoKhkyJwlBGxXxfzp+mlg1D4M
         7QMfUuHCK7AUT545Pbb+BjXQV38Ce4Tbu/TuqHGQ1UQDAgvY9y6XaDAZE3Q3dpYi+I
         q2SN2/KlPavkA==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 6/6/19 11:44 AM, Jason Gunthorpe wrote:
> From: Jason Gunthorpe <jgg@mellanox.com>
>=20
> No other register/unregister kernel API attempts to provide this kind of
> protection as it is inherently racy, so just drop it.
>=20
> Callers should provide their own protection, it appears nouveau already
> does, but just in case drop a debugging POISON.
>=20
> Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
> Reviewed-by: J=C3=A9r=C3=B4me Glisse <jglisse@redhat.com>
> ---
>  mm/hmm.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
>=20
> diff --git a/mm/hmm.c b/mm/hmm.c
> index c702cd72651b53..6802de7080d172 100644
> --- a/mm/hmm.c
> +++ b/mm/hmm.c
> @@ -284,18 +284,13 @@ EXPORT_SYMBOL(hmm_mirror_register);
>   */
>  void hmm_mirror_unregister(struct hmm_mirror *mirror)
>  {
> -	struct hmm *hmm =3D READ_ONCE(mirror->hmm);
> -
> -	if (hmm =3D=3D NULL)
> -		return;
> +	struct hmm *hmm =3D mirror->hmm;
> =20
>  	down_write(&hmm->mirrors_sem);
>  	list_del_init(&mirror->list);
> -	/* To protect us against double unregister ... */
> -	mirror->hmm =3D NULL;
>  	up_write(&hmm->mirrors_sem);
> -
>  	hmm_put(hmm);
> +	memset(&mirror->hmm, POISON_INUSE, sizeof(mirror->hmm));

I hadn't thought of POISON_* for these types of cases, it's a=20
good technique to remember.

I noticed that this is now done outside of the lock, but that
follows directly from your commit description, so that all looks=20
correct.

>  }
>  EXPORT_SYMBOL(hmm_mirror_unregister);
> =20
>=20


    Reviewed-by: John Hubbard <jhubbard@nvidia.com>

thanks,
--=20
John Hubbard
NVIDIA
