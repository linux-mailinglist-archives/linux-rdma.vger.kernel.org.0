Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B50023970A
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Jun 2019 22:49:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729915AbfFGUtJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 7 Jun 2019 16:49:09 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:1432 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729640AbfFGUtJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 7 Jun 2019 16:49:09 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cfacdc20001>; Fri, 07 Jun 2019 13:49:06 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 07 Jun 2019 13:49:08 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 07 Jun 2019 13:49:08 -0700
Received: from rcampbell-dev.nvidia.com (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 7 Jun
 2019 20:49:06 +0000
Subject: Re: [PATCH v2 hmm 10/11] mm/hmm: Do not use list*_rcu() for
 hmm->ranges
To:     Jason Gunthorpe <jgg@ziepe.ca>, Jerome Glisse <jglisse@redhat.com>,
        "John Hubbard" <jhubbard@nvidia.com>, <Felix.Kuehling@amd.com>
CC:     <linux-rdma@vger.kernel.org>, <linux-mm@kvack.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        <dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>,
        Jason Gunthorpe <jgg@mellanox.com>
References: <20190606184438.31646-1-jgg@ziepe.ca>
 <20190606184438.31646-11-jgg@ziepe.ca>
X-Nvconfidentiality: public
From:   Ralph Campbell <rcampbell@nvidia.com>
Message-ID: <57cf91db-bebe-24f0-29c3-64274f10d10b@nvidia.com>
Date:   Fri, 7 Jun 2019 13:49:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <20190606184438.31646-11-jgg@ziepe.ca>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL108.nvidia.com (172.18.146.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1559940546; bh=oGeyU71GSCfi4k4k8mSueh4JEltagVCe/KlNbvsSutg=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=UJz2Qt1QfanMEhOyt/3R/g2DHXV8MDxZ8h5tNqHZXgifBkiWanoofMHj0WGWGojU3
         r7hVfwPkjuzgQD7LU06bneMH68aqOd5ZgdE2TfB1EmRGNULUoGCRnsfVCsdcub+iS1
         03SomttNcSlu+bgApB2KFIb/oMQ8U6aQKkg+bakwP+c+sQwjrKCDv8TUTDpkPUHIMr
         sGnkKrGR06RJOx8WxR7boji2N9rK6vQxJGwimzGESBTMzTX7Rla6rzRRhoGVTpbSc+
         pJlxWklk2KTdXTtn3LcrHxzebmMdPEOIuDL28O14ysFKMaSnkp4n1nQImnJoYkwMRl
         ITLcdbPEakgYg==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 6/6/19 11:44 AM, Jason Gunthorpe wrote:
> From: Jason Gunthorpe <jgg@mellanox.com>
>=20
> This list is always read and written while holding hmm->lock so there is
> no need for the confusing _rcu annotations.
>=20
> Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
> Reviewed-by: J=C3=A9r=C3=B4me Glisse <jglisse@redhat.com>

Reviewed-by: Ralph Campbell <rcampbell@nvidia.com>

> ---
>   mm/hmm.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/mm/hmm.c b/mm/hmm.c
> index c2fecb3ecb11e1..709d138dd49027 100644
> --- a/mm/hmm.c
> +++ b/mm/hmm.c
> @@ -911,7 +911,7 @@ int hmm_range_register(struct hmm_range *range,
>   	mutex_lock(&hmm->lock);
>  =20
>   	range->hmm =3D hmm;
> -	list_add_rcu(&range->list, &hmm->ranges);
> +	list_add(&range->list, &hmm->ranges);
>  =20
>   	/*
>   	 * If there are any concurrent notifiers we have to wait for them for
> @@ -941,7 +941,7 @@ void hmm_range_unregister(struct hmm_range *range)
>   		return;
>  =20
>   	mutex_lock(&hmm->lock);
> -	list_del_rcu(&range->list);
> +	list_del(&range->list);
>   	mutex_unlock(&hmm->lock);
>  =20
>   	/* Drop reference taken by hmm_range_register() */
>=20
