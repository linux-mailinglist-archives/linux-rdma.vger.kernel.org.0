Return-Path: <linux-rdma+bounces-3529-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC6E7918616
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Jun 2024 17:41:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7704C2813AD
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Jun 2024 15:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63DD118E76C;
	Wed, 26 Jun 2024 15:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fk/duFQS"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24807A92F
	for <linux-rdma@vger.kernel.org>; Wed, 26 Jun 2024 15:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719416495; cv=none; b=fJxzDEyaywVJ4AD6PDLVQxm3T8uyc6g3F3qWgODGRu0LhlmgVRj9hVuUFEuHoYwLp4h4O4btDse72/yxA4PYW/ed+egpm/b2jg1r/DLBe45JXYNEARIrv45geqNUjGcsUNLvrCe4AD6pcdHFrjbhsxw+RLzBjk0r8nl5dDg7TsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719416495; c=relaxed/simple;
	bh=MKHDToXyK+NDCk9HFJPQo71cWHqKV2siZ7/bHgbQ+4c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PbPKnCfAXP13pptR8x6Ga7gUcNsahFFrrK6L/mnZGJNeyMfykSysAZ6qwOM3cjdxD+ogSbBIeRZDGGo3HpTEWC8LbPK5eOWy/NkiyQpL/k9nUnBcYWD9Pk4HbtHWzpooiH5sx+AAjcCBIFqF87VV+M6U89E8T8vJMYG5v8NMzQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fk/duFQS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6726FC116B1;
	Wed, 26 Jun 2024 15:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719416494;
	bh=MKHDToXyK+NDCk9HFJPQo71cWHqKV2siZ7/bHgbQ+4c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Fk/duFQSTOOPBvRxcKu9dU+NFxNek4JiJNSjdDcOuHztrtGrOlNcKRBZKw3O8KAA0
	 L4KMRSBBpXbKX5JY7CJpLdh+3Y/6s3EQ6zMZewwxqg9iI7nZRhCUpe5olq9lKM9Dlt
	 yOMnLWJPdiHOgfMDuJFLd/lqiVSvRw0YRefNEFKx34dAJEf+A6es3wuMuDP3bzEtE1
	 X0RVPVQ4HRWWGNIcO0+qwnXj63JjcFNyJRPes2jenyM4WCqRbl1zpM3NmWQoWvPPO7
	 vQnZZjYr403hCZKD4uEBADQn7OYV5dqguGL881SJKOJYXgjJ6cu1DmZYugqMJlpP/+
	 ITIrFq+exG8Ng==
Date: Wed, 26 Jun 2024 18:41:30 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Akiva Goldberger <agoldberger@nvidia.com>,
	Ajay Sharma <sharmaajay@microsoft.com>,
	Bernard Metzler <bmt@zurich.ibm.com>,
	Chengchang Tang <tangchengchang@huawei.com>,
	Cheng Xu <chengyou@linux.alibaba.com>,
	Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
	Junxian Huang <huangjunxian6@hisilicon.com>,
	Kai Shen <kaishen@linux.alibaba.com>, linux-rdma@vger.kernel.org,
	Long Li <longli@microsoft.com>,
	Michael Margolin <mrgolin@amazon.com>,
	Mustafa Ismail <mustafa.ismail@intel.com>,
	Potnuri Bharat Teja <bharat@chelsio.com>,
	Selvin Xavier <selvin.xavier@broadcom.com>,
	Shiraz Saleem <shiraz.saleem@intel.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Zhu Yanjun <zyjzyj2000@gmail.com>,
	Zhu Yanjun <yanjun.zhu@linux.dev>
Subject: Re: [PATCH rdma-next v1 1/2] RDMA: Pass entire uverbs attr bundle to
 create cq function
Message-ID: <20240626154130.GR29266@unreal>
References: <cover.1719244483.git.leon@kernel.org>
 <d9f70aadfbd0739472988610055ffe102c2a61fc.1719244483.git.leon@kernel.org>
 <20240626152848.GG2494510@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240626152848.GG2494510@nvidia.com>

On Wed, Jun 26, 2024 at 12:28:48PM -0300, Jason Gunthorpe wrote:
> On Mon, Jun 24, 2024 at 07:00:10PM +0300, Leon Romanovsky wrote:
> > From: Akiva Goldberger <agoldberger@nvidia.com>
> > 
> > Changes the create_cq verb signature by sending the entire uverbs attr
> > bundle as a parameter. This allows drivers to send driver specific attrs
> > through ioctl for the create_cq verb and access them in their driver
> > specific code.
> > 
> > Also adds a new enum value for driver specific ioctl attributes for
> > methods already supporting UHW.
> 
> I was going to pick this up but it doesn't compile:
> 
> ../drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c:156:15: error: incompatible function pointer types initializing 'int (*)(struct ib_cq *, const struct ib_cq_init_attr *, struct uverbs_attr_bundle *)' with an expression of type 'int (struct ib_cq *, const struct ib_cq_init_attr *, struct ib_udata *)' [-Wincompatible-function-pointer-types]
>   156 |         .create_cq = pvrdma_create_cq,
>       |                      ^~~~~~~~~~~~~~~~
> ../drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c:814:46: warning: shift count >= width of type [-Wshift-count-overflow]
>   814 |         ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
>       |                                                     ^~~~~~~~~~~~~~~~
> ../include/linux/dma-mapping.h:77:54: note: expanded from macro 'DMA_BIT_MASK'
>    77 | #define DMA_BIT_MASK(n) (((n) == 64) ? ~0ULL : ((1ULL<<(n))-1))
>       |                                                      ^ ~~~
> 1 warning and 1 error generated.
> 
> Didn't get all the drivers? Don't have all the drivers turned on in
> your kconfig?

They are supposed to be, but for some reason my mkt CI didn't catch it,
but this patch clearly missing pvrdma.

Thanks

> 
> Jason

