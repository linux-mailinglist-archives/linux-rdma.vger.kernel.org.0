Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C570C396DA
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Jun 2019 22:31:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730378AbfFGUbJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 7 Jun 2019 16:31:09 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:3374 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729482AbfFGUbJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 7 Jun 2019 16:31:09 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cfac98c0000>; Fri, 07 Jun 2019 13:31:08 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 07 Jun 2019 13:31:08 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 07 Jun 2019 13:31:08 -0700
Received: from rcampbell-dev.nvidia.com (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 7 Jun
 2019 20:31:05 +0000
Subject: Re: [PATCH v2 hmm 07/11] mm/hmm: Use lockdep instead of comments
To:     Jason Gunthorpe <jgg@ziepe.ca>, Jerome Glisse <jglisse@redhat.com>,
        "John Hubbard" <jhubbard@nvidia.com>, <Felix.Kuehling@amd.com>
CC:     <linux-rdma@vger.kernel.org>, <linux-mm@kvack.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        <dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>,
        Jason Gunthorpe <jgg@mellanox.com>
References: <20190606184438.31646-1-jgg@ziepe.ca>
 <20190606184438.31646-8-jgg@ziepe.ca>
X-Nvconfidentiality: public
From:   Ralph Campbell <rcampbell@nvidia.com>
Message-ID: <a5c8ffcb-8fa7-3335-ed62-2bb56ddbdf65@nvidia.com>
Date:   Fri, 7 Jun 2019 13:31:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <20190606184438.31646-8-jgg@ziepe.ca>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL104.nvidia.com (172.18.146.11) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1559939468; bh=DJEgcc7UNUR1jWUy9v9yyTysVpXwgehmZtsnaBcLiV0=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=K1TI+oiuxer43MXruxn4aD6k38M1KgmLi/kNbIuGzmeeoT0eYPnPFzEvoKNL+bsga
         u5ORczu2FZ9nHhPCXpcwW8B2+X+xs/86E+K7GJt0nn0cUrJLjE9powkVwlMfgPsgbo
         RlRKemcVRsq2lMZhwvnnjgAsQnoLqVgASmOoiFwdjsiazBd8Emfwo13BUrJbwc1vh5
         zHolieE1lXx1gOo+FydkJqvrCK508ZMX+yo3gxl+xD8typ2aCzbLMBVKIsWpH7Rb0p
         +VyG/635Ox5E8uhpJ04SfqevaDaSIuNM708XWF+vU5ykOZliZ9S9HBBt7QILdCIPqv
         UiwXc/oGqPCMw==
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

Reviewed-by: Ralph Campbell <rcampbell@nvidia.com>

> ---
> v2
> - Fix missing & in lockdeps (Jason)
> ---
>   mm/hmm.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/mm/hmm.c b/mm/hmm.c
> index f67ba32983d9f1..c702cd72651b53 100644
> --- a/mm/hmm.c
> +++ b/mm/hmm.c
> @@ -254,11 +254,11 @@ static const struct mmu_notifier_ops hmm_mmu_notifi=
er_ops =3D {
>    *
>    * To start mirroring a process address space, the device driver must r=
egister
>    * an HMM mirror struct.
> - *
> - * THE mm->mmap_sem MUST BE HELD IN WRITE MODE !
>    */
>   int hmm_mirror_register(struct hmm_mirror *mirror, struct mm_struct *mm=
)
>   {
> +	lockdep_assert_held_exclusive(&mm->mmap_sem);
> +
>   	/* Sanity check */
>   	if (!mm || !mirror || !mirror->ops)
>   		return -EINVAL;
>=20
