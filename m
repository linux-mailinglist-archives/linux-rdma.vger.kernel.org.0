Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5EFF138315
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Jun 2019 05:19:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726543AbfFGDTj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 6 Jun 2019 23:19:39 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:14807 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbfFGDTj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 6 Jun 2019 23:19:39 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cf9d7bb0000>; Thu, 06 Jun 2019 20:19:23 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Thu, 06 Jun 2019 20:19:38 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Thu, 06 Jun 2019 20:19:38 -0700
Received: from [10.110.48.28] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 7 Jun
 2019 03:19:34 +0000
Subject: Re: [PATCH v2 hmm 07/11] mm/hmm: Use lockdep instead of comments
To:     Jason Gunthorpe <jgg@ziepe.ca>, Jerome Glisse <jglisse@redhat.com>,
        "Ralph Campbell" <rcampbell@nvidia.com>, <Felix.Kuehling@amd.com>
CC:     <linux-rdma@vger.kernel.org>, <linux-mm@kvack.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        <dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>,
        Jason Gunthorpe <jgg@mellanox.com>
References: <20190606184438.31646-1-jgg@ziepe.ca>
 <20190606184438.31646-8-jgg@ziepe.ca>
X-Nvconfidentiality: public
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <c1916bf0-1cec-9742-da9a-cfb0620be1f6@nvidia.com>
Date:   Thu, 6 Jun 2019 20:19:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190606184438.31646-8-jgg@ziepe.ca>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL106.nvidia.com (172.18.146.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1559877563; bh=9gF3uYn8obWB5VlUA+vgwaf2NDgSDG+GUN4zo8V/T7s=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=Y2/wSIlTDTvSRdYSF0JE+b/OJ9Z37KAvZnjLdpqLblVoJpA9RpMEc1+t+7lodIvC+
         K+XHIKj+M0kiuZZIjR4KCP8V9ptM6hqYnxC2cmwq9/5357Hxxim2CabkXCAfwxfrHp
         9Wh+0tBCkMV3T7aTLJd2fnNgLpEF1E8MIZhoMqANxrZ1BOkL2sC/fAZ7g1TogRo44I
         f3D/LwtPMs0lhTGycNl7sIhQr0vmnOvaXB9iQrOFpj6N03P5RGYLZluNdASeuRNZUt
         CUq/h0Q3gYsBA60V6778+IW8VendGjD8aGz4nQuNAJjYGZUfIAaZiQeH5yD1+Xhn8R
         gdpnlOI2/wIHg==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 6/6/19 11:44 AM, Jason Gunthorpe wrote:
> From: Jason Gunthorpe <jgg@mellanox.com>
>=20
> So we can check locking at runtime.
>=20
> Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
> Reviewed-by: J=C3=A9r=C3=B4me Glisse <jglisse@redhat.com>
> ---
> v2
> - Fix missing & in lockdeps (Jason)
> ---
>  mm/hmm.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/mm/hmm.c b/mm/hmm.c
> index f67ba32983d9f1..c702cd72651b53 100644
> --- a/mm/hmm.c
> +++ b/mm/hmm.c
> @@ -254,11 +254,11 @@ static const struct mmu_notifier_ops hmm_mmu_notifi=
er_ops =3D {
>   *
>   * To start mirroring a process address space, the device driver must re=
gister
>   * an HMM mirror struct.
> - *
> - * THE mm->mmap_sem MUST BE HELD IN WRITE MODE !
>   */
>  int hmm_mirror_register(struct hmm_mirror *mirror, struct mm_struct *mm)
>  {
> +	lockdep_assert_held_exclusive(&mm->mmap_sem);
> +
>  	/* Sanity check */
>  	if (!mm || !mirror || !mirror->ops)
>  		return -EINVAL;
>=20

    Reviewed-by: John Hubbard <jhubbard@nvidia.com>


thanks,
--=20
John Hubbard
NVIDIA
