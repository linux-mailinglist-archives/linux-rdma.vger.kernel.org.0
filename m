Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7827F39704
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Jun 2019 22:46:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730072AbfFGUqe (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 7 Jun 2019 16:46:34 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:18451 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729640AbfFGUqe (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 7 Jun 2019 16:46:34 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cfacd1a0000>; Fri, 07 Jun 2019 13:46:18 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 07 Jun 2019 13:46:33 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 07 Jun 2019 13:46:33 -0700
Received: from rcampbell-dev.nvidia.com (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 7 Jun
 2019 20:46:31 +0000
Subject: Re: [PATCH v2 hmm 09/11] mm/hmm: Poison hmm_range during unregister
To:     Jason Gunthorpe <jgg@ziepe.ca>, Jerome Glisse <jglisse@redhat.com>,
        "John Hubbard" <jhubbard@nvidia.com>, <Felix.Kuehling@amd.com>
CC:     <linux-rdma@vger.kernel.org>, <linux-mm@kvack.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        <dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>,
        Jason Gunthorpe <jgg@mellanox.com>
References: <20190606184438.31646-1-jgg@ziepe.ca>
 <20190606184438.31646-10-jgg@ziepe.ca>
X-Nvconfidentiality: public
From:   Ralph Campbell <rcampbell@nvidia.com>
Message-ID: <96a2739f-6902-05be-7143-289b41c4304d@nvidia.com>
Date:   Fri, 7 Jun 2019 13:46:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <20190606184438.31646-10-jgg@ziepe.ca>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL108.nvidia.com (172.18.146.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1559940378; bh=+DzfkNN8iXOL7by8qMWBjVwFAYZtnua1XZdudIdSS1I=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=VluKSBvkfaYIX++zlv6XbGKYR777aYfJahPNKO/wmahQZbfZhQO0mclBAunQkei1x
         cmaNgrzDDMriQDpXTunXqzxWpXX2n2UXyyFCSG3yr1peoDkbHDXEL2lhubMUXxqVpx
         vflN1kbYMdCmz1XHBwtlcJK7eGpIO27Pznx1OsNID29nU27/Z8TKtxAqoQ4ZvR+NNG
         y9lD95yLdEEDsDCmGy22bIUny2N5+9ttBIp9Ndq4vra/BLx9O57G9SALrAnL40nMhY
         aeMl7wBddrI0belykCs3zCS0k7KMxawm1rABIt5Cn2NEifhgOtCyvgnknxVVQ+8WEt
         tVh+oG5gKD+NQ==
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

Reviewed-by: Ralph Campbell <rcampbell@nvidia.com>

> ---
> v2
> - Keep range start/end valid after unregistration (Jerome)
> ---
>   mm/hmm.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
>=20
> diff --git a/mm/hmm.c b/mm/hmm.c
> index 6802de7080d172..c2fecb3ecb11e1 100644
> --- a/mm/hmm.c
> +++ b/mm/hmm.c
> @@ -937,7 +937,7 @@ void hmm_range_unregister(struct hmm_range *range)
>   	struct hmm *hmm =3D range->hmm;
>  =20
>   	/* Sanity check this really should not happen. */
> -	if (hmm =3D=3D NULL || range->end <=3D range->start)
> +	if (WARN_ON(range->end <=3D range->start))
>   		return;

WARN_ON() is definitely better than silent return but I wonder how
useful it is since the caller shouldn't be modifying the hmm_range
once it is registered. Other fields could be changed too...

>   	mutex_lock(&hmm->lock);
> @@ -948,7 +948,10 @@ void hmm_range_unregister(struct hmm_range *range)
>   	range->valid =3D false;
>   	mmput(hmm->mm);
>   	hmm_put(hmm);
> -	range->hmm =3D NULL;
> +
> +	/* The range is now invalid, leave it poisoned. */
> +	range->valid =3D false;
> +	memset(&range->hmm, POISON_INUSE, sizeof(range->hmm));
>   }
>   EXPORT_SYMBOL(hmm_range_unregister);
>  =20
>=20
