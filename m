Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45E26396E0
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Jun 2019 22:33:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729920AbfFGUdO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 7 Jun 2019 16:33:14 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:19760 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729153AbfFGUdO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 7 Jun 2019 16:33:14 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cfaca070000>; Fri, 07 Jun 2019 13:33:11 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 07 Jun 2019 13:33:13 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 07 Jun 2019 13:33:13 -0700
Received: from rcampbell-dev.nvidia.com (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 7 Jun
 2019 20:33:09 +0000
Subject: Re: [PATCH v2 hmm 08/11] mm/hmm: Remove racy protection against
 double-unregistration
To:     Jason Gunthorpe <jgg@ziepe.ca>, Jerome Glisse <jglisse@redhat.com>,
        "John Hubbard" <jhubbard@nvidia.com>, <Felix.Kuehling@amd.com>
CC:     <linux-rdma@vger.kernel.org>, <linux-mm@kvack.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        <dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>,
        Jason Gunthorpe <jgg@mellanox.com>
References: <20190606184438.31646-1-jgg@ziepe.ca>
 <20190606184438.31646-9-jgg@ziepe.ca>
X-Nvconfidentiality: public
From:   Ralph Campbell <rcampbell@nvidia.com>
Message-ID: <ab93b81f-8d78-8760-6fc7-d981d528026d@nvidia.com>
Date:   Fri, 7 Jun 2019 13:33:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <20190606184438.31646-9-jgg@ziepe.ca>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL104.nvidia.com (172.18.146.11) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1559939591; bh=OLplF3FRcTtszyFZo8HGJ3SRTQEEwTp6Llhy0LgviKg=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=h/f6qK4es4H52bAwrizf7ejiA0ydq6aSXi0ApCfo8QG/yHMMZrPD6D9Nmp+9x+oSq
         Y+Nai5Z3GNqdygDYEjs8tRe4G+equLunHMzhtVh3Ciw8F8asoW37NWSbhIPrTfQHdd
         a0fJyGgIK8Tu4kQAsbdZd8AoQqCA/LCwiNlYM5clGsAnmVq+zds9aNO+EQXS3jycc2
         Np37o+70Rfn9F8dzE5xPDkw7sWgYKlmOrgPYJvgePUegOSCUDtbT8LfpwUJTntw+E+
         QyaZMFuwrE1L3P/k9EmQ6ReZp/TXbLu4f6FU+0KJhuGmXM05AU78hJi1m3gSauCf1R
         lf5e197AMSsgQ==
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

Reviewed-by: Ralph Campbell <rcampbell@nvidia.com>

> ---
>   mm/hmm.c | 9 ++-------
>   1 file changed, 2 insertions(+), 7 deletions(-)
>=20
> diff --git a/mm/hmm.c b/mm/hmm.c
> index c702cd72651b53..6802de7080d172 100644
> --- a/mm/hmm.c
> +++ b/mm/hmm.c
> @@ -284,18 +284,13 @@ EXPORT_SYMBOL(hmm_mirror_register);
>    */
>   void hmm_mirror_unregister(struct hmm_mirror *mirror)
>   {
> -	struct hmm *hmm =3D READ_ONCE(mirror->hmm);
> -
> -	if (hmm =3D=3D NULL)
> -		return;
> +	struct hmm *hmm =3D mirror->hmm;
>  =20
>   	down_write(&hmm->mirrors_sem);
>   	list_del_init(&mirror->list);
> -	/* To protect us against double unregister ... */
> -	mirror->hmm =3D NULL;
>   	up_write(&hmm->mirrors_sem);
> -
>   	hmm_put(hmm);
> +	memset(&mirror->hmm, POISON_INUSE, sizeof(mirror->hmm));
>   }
>   EXPORT_SYMBOL(hmm_mirror_unregister);
>  =20
>=20
