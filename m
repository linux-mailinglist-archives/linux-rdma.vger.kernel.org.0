Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30EF639528
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Jun 2019 21:01:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729474AbfFGTBt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 7 Jun 2019 15:01:49 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:16015 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728595AbfFGTBs (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 7 Jun 2019 15:01:48 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cfab4990002>; Fri, 07 Jun 2019 12:01:45 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 07 Jun 2019 12:01:47 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 07 Jun 2019 12:01:47 -0700
Received: from rcampbell-dev.nvidia.com (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 7 Jun
 2019 19:01:45 +0000
Subject: Re: [PATCH v2 hmm 05/11] mm/hmm: Remove duplicate condition test
 before wait_event_timeout
To:     Jason Gunthorpe <jgg@ziepe.ca>, Jerome Glisse <jglisse@redhat.com>,
        "John Hubbard" <jhubbard@nvidia.com>, <Felix.Kuehling@amd.com>
CC:     <linux-rdma@vger.kernel.org>, <linux-mm@kvack.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        <dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>,
        Jason Gunthorpe <jgg@mellanox.com>
References: <20190606184438.31646-1-jgg@ziepe.ca>
 <20190606184438.31646-6-jgg@ziepe.ca>
From:   Ralph Campbell <rcampbell@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <6833be96-12a3-1a1c-1514-c148ba2dd87b@nvidia.com>
Date:   Fri, 7 Jun 2019 12:01:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <20190606184438.31646-6-jgg@ziepe.ca>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL106.nvidia.com (172.18.146.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1559934105; bh=Kx8oCHq1Rv6wVMPa9pb6SeAWwPMNVFkybn8lVkznCEc=;
        h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=lijWUGubJCR64HCSORX4QLqG3zil2s0//JM6B87DqP7lBJ5ltD/J/GDcaS3G2ZX2e
         gWemy5KFFY6h0iVAOYTmbphNBWI/LDNjC6c0xgS+2/+yBQohtbcmyE4AlfFOXpHeLQ
         4YgDqKoU4mYZGqM+umLyKSpCK/E7doCn27H3GCULDP4SwQcK4nXs8qHf75pHYEke5V
         rctRDR3GL/NH60mIG08uN5KRkBfiy+JXJoWm1LmB7A9hM2vDBjKAbzjpZxeZ8ZiLKT
         8GMvc9iw2Ylz1UmEP1JPMDGnTs0Sr5zjQDRTNK9WwdjtY1TvsxYmK0vrSaq1WqcRhY
         Z6k1iCiG9xexw==
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
> test:
>   - If range is valid memory then so is range->hmm
>   - If hmm_release() has run then range->valid is set to false
>     at the same time as dead, so no reason to check both.
>   - A valid hmm has a valid hmm->mm.
>=20
> Also, add the READ_ONCE for range->valid as there is no lock held here.
>=20
> Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
> Reviewed-by: J=C3=A9r=C3=B4me Glisse <jglisse@redhat.com>
> ---
>   include/linux/hmm.h | 12 ++----------
>   1 file changed, 2 insertions(+), 10 deletions(-)
>=20
> diff --git a/include/linux/hmm.h b/include/linux/hmm.h
> index 4ee3acabe5ed22..2ab35b40992b24 100644
> --- a/include/linux/hmm.h
> +++ b/include/linux/hmm.h
> @@ -218,17 +218,9 @@ static inline unsigned long hmm_range_page_size(cons=
t struct hmm_range *range)
>   static inline bool hmm_range_wait_until_valid(struct hmm_range *range,
>   					      unsigned long timeout)
>   {
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
>   			   msecs_to_jiffies(timeout));
> -	/* Return current valid status just in case we get lucky */
> -	return range->valid;
> +	return READ_ONCE(range->valid);
>   }
>  =20
>   /*
>=20

Since we are simplifying things, perhaps we should consider merging
hmm_range_wait_until_valid() info hmm_range_register() and
removing hmm_range_wait_until_valid() since the pattern
is to always call the two together.

In any case, this looks OK to me so you can add
Reviewed-by: Ralph Campbell <rcampbell@nvidia.com>
