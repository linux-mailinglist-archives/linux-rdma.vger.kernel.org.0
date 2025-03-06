Return-Path: <linux-rdma+bounces-8408-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D5BBA545BB
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Mar 2025 10:01:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3748116460A
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Mar 2025 09:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABC5619D880;
	Thu,  6 Mar 2025 09:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ih3EFOfC"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D20C8828
	for <linux-rdma@vger.kernel.org>; Thu,  6 Mar 2025 09:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741251690; cv=none; b=k8Yaeemi57Nk2c2j9bE+ze+RbLmSiPytBApr2u0JMXbswjmk+LjDaqKAJc86ec6khjJqS1czQcLqv9D0y8x3pHEvRoea2RfFwlEJh+RAHhbBPgEzhEsEMi1fiX835rRxI0ClU3ExKJXU9+K/C/6We9xlf51XR1DyxpWOsYzfbWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741251690; c=relaxed/simple;
	bh=r53vPphmVgfRN06v87WMtmffReHf5dKoVcuwNBKgtlk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u5jhEDbnM8S+SSG9l9YTfai0XPpFsD+3+2HO75VOf5kqh+nCjHxEFctx6ghsC9y0ES5GXQJe3RVfzN/1fVa40EKsGBhP5zEuMoXMDt0/KkuTEEQ7r3GA3Y00q5/Isej6YOE1t1tCRmP4NQCcz4AS9E81JnaV2gAQcVCcHmhAoBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ih3EFOfC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18070C4CEE0;
	Thu,  6 Mar 2025 09:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741251689;
	bh=r53vPphmVgfRN06v87WMtmffReHf5dKoVcuwNBKgtlk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ih3EFOfCOUorP4uXAw48G5s94s9G0ROF4JDJrQNBirGEoCG3VpKmLCF0KROTfChvn
	 +vqt960yFaSOXwWQHn3UJJ6dja6byOLH9MYK6MbAghQc4gUp+9EjPrynRt+3IKjSCv
	 ROFUWgwqdDJhXv5YChGJakv/cWJNpcpjBkzDU59Pxll2RVfwUA4wyJXy642uUXILxl
	 Sp2MDvkrvs9rKX8oTKUuaUZuw+D9Ejie84t6S4UP3BlT8Q4lnH58QxFefZAYnwwNre
	 ooXKV/fuZdw0Dia3rMlekz1SOcid+yYEBoNn7jlBfcR6iMYE8ypecTMaw/TjdskUUO
	 eScY1wXdnVAIg==
Date: Thu, 6 Mar 2025 11:01:25 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Konstantin Taranov <kotaranov@microsoft.com>,
	linux-rdma@vger.kernel.org
Subject: Re: [bug report] RDMA/mana_ib: implement uapi for creation of rnic cq
Message-ID: <20250306090125.GS1955273@unreal>
References: <26f9cf15-2446-4a73-bc34-5d07dfcfa751@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26f9cf15-2446-4a73-bc34-5d07dfcfa751@stanley.mountain>

On Wed, Mar 05, 2025 at 10:57:49PM +0300, Dan Carpenter wrote:
> Hello Konstantin Taranov,
> 
> Commit 44b607ad4cdf ("RDMA/mana_ib: implement uapi for creation of
> rnic cq") from Apr 26, 2024 (linux-next), leads to the following
> Smatch static checker warning:
> 
> 	drivers/infiniband/hw/mana/cq.c:48 mana_ib_create_cq()
> 	warn: potential user controlled sizeof overflow 'cq->cqe * 64' 's32min-s32max * 64'
> 
> drivers/infiniband/hw/mana/cq.c
>     8 int mana_ib_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
>     9                       struct uverbs_attr_bundle *attrs)
>     10 {
>     11         struct ib_udata *udata = &attrs->driver_udata;
>     12         struct mana_ib_cq *cq = container_of(ibcq, struct mana_ib_cq, ibcq);
>     13         struct mana_ib_create_cq_resp resp = {};
>     14         struct mana_ib_ucontext *mana_ucontext;
>     15         struct ib_device *ibdev = ibcq->device;
>     16         struct mana_ib_create_cq ucmd = {};
>     17         struct mana_ib_dev *mdev;
>     18         struct gdma_context *gc;
>     19         bool is_rnic_cq;
>     20         u32 doorbell;
>     21         u32 buf_size;
>     22         int err;
>     23 
>     24         mdev = container_of(ibdev, struct mana_ib_dev, ib_dev);
>     25         gc = mdev_to_gc(mdev);
>     26 
>     27         cq->comp_vector = attr->comp_vector % ibdev->num_comp_vectors;
>     28         cq->cq_handle = INVALID_MANA_HANDLE;
>     29 
>     30         if (udata) {
>     31                 if (udata->inlen < offsetof(struct mana_ib_create_cq, flags))
>     32                         return -EINVAL;
>     33 
>     34                 err = ib_copy_from_udata(&ucmd, udata, min(sizeof(ucmd), udata->inlen));
>                                                  ^^^^
> ucmd.flags is set by the user here.
> 
>     35                 if (err) {
>     36                         ibdev_dbg(ibdev, "Failed to copy from udata for create cq, %d\n", err);
>     37                         return err;
>     38                 }
>     39 
>     40                 is_rnic_cq = !!(ucmd.flags & MANA_IB_CREATE_RNIC_CQ);
>     41 
>     42                 if (!is_rnic_cq && attr->cqe > mdev->adapter_caps.max_qp_wr) {
>                                           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> attr->cqe used to be bounds checked every time, but now the user can
> skip setting the flag for bounds checking.
> 
>     43                         ibdev_dbg(ibdev, "CQE %d exceeding limit\n", attr->cqe);
>     44                         return -EINVAL;
>     45                 }
>     46 
>     47                 cq->cqe = attr->cqe;
> --> 48                 err = mana_ib_create_queue(mdev, ucmd.buf_addr, cq->cqe * COMP_ENTRY_SIZE,
>                                                                        ^^^^^^^^^^^^^^^^^^^^^^^^^
> 
> This can lead to integer wrapping.
> 
> The call tree is:
> 
> ib_uverbs_create_cq() <- copies cmd.cqe from the user
>   -> create_cq() calls (struct ib_device_ops)->create_cq()
>      -> mana_ib_create_cq()
> 
> I'm not sure if this integer overflow has any negative effects.  I think
> it's probably fine?

It is not nice and worth to be fixed, but technically it looks like size
(cq->cqe * COMP_ENTRY_SIZE) is used to get UMEM memory, so we will allocate
less than driver would like to.

Thanks

