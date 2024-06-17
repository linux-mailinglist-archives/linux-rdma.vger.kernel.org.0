Return-Path: <linux-rdma+bounces-3238-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02EC590B719
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Jun 2024 18:55:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4915B47714
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Jun 2024 16:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 912EB14F128;
	Mon, 17 Jun 2024 15:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X59TQY8k"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A45414EC62
	for <linux-rdma@vger.kernel.org>; Mon, 17 Jun 2024 15:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718639393; cv=none; b=lRpkja4ySU/r+E7Amd911t2X6RzfM1kbZrKt0nIubvFI/vzWT19lhVPSBQr39qxvrIj2i9ZWwEeQu/A4V0/iOcrLs7H8vR617f3QGEhtL3K8xUTfdpkglxbDElA+5hQGt59wOOfdXkS8/kIvWuDvLI/dyeSHY0YOAcfDaGXURw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718639393; c=relaxed/simple;
	bh=T+CxpqpurzDJTho6858bRNYmboTOFWTAyQElNgHExxI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u/Ur/bfUFoqgA4dCLYy0wm/0ZFw8LxfBgGqUBmB4alA18gjXHpUKYJXe8N7i0cBXO72NUX0h0w8PB6JSjF8Y0pGHWCdZfXogzB1WC4D8tpZ97wYIAyrSrXUR3/bbTz0UMdxNEiW76Uruoaw0x70OtVsJJtjpjMZnBSEg1koZ+lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X59TQY8k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D03AC2BD10;
	Mon, 17 Jun 2024 15:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718639392;
	bh=T+CxpqpurzDJTho6858bRNYmboTOFWTAyQElNgHExxI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X59TQY8kF/zrPSxH0qiHIsg2V/5EhssiKTDKvGh3tQFB8CFX2L9f39Fe4NtgBStBQ
	 dsNLacycSjL/Xsj3TTZiZJR+Ju9HMANaJZ34JhrGq1kGHTbf7p6YPGtFGRg2oUfBNW
	 WrYCJfSiDhMgDjtNUcHMt2GIPVoVvXDQnuXi7vljhbO/WA0LCAB2wfODi+YK4pzRRB
	 nyTEamXJrfN5ZuCPlepBqWIZUmUSl4OBnUlTta2ay3KZ9aPkdQneutVXmGqoLdzYfq
	 f6KXXcYAjYKOLyKhNw7fJPCgWFYVZZK6d6dHzqisbH31woopSN/3jp5YsyNhxUUlGt
	 uue9PHtVe67XA==
Date: Mon, 17 Jun 2024 18:49:47 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Akiva Goldberger <agoldberger@nvidia.com>,
	Ajay Sharma <sharmaajay@microsoft.com>,
	Bernard Metzler <bmt@zurich.ibm.com>,
	Chengchang Tang <tangchengchang@huawei.com>,
	Cheng Xu <chengyou@linux.alibaba.com>,
	Junxian Huang <huangjunxian6@hisilicon.com>,
	Kai Shen <kaishen@linux.alibaba.com>, linux-rdma@vger.kernel.org,
	Long Li <longli@microsoft.com>,
	Michael Margolin <mrgolin@amazon.com>,
	Mustafa Ismail <mustafa.ismail@intel.com>,
	Potnuri Bharat Teja <bharat@chelsio.com>,
	Selvin Xavier <selvin.xavier@broadcom.com>,
	Shiraz Saleem <shiraz.saleem@intel.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Zhu Yanjun <zyjzyj2000@gmail.com>
Subject: Re: [PATCH rdma-next 1/2] RDMA: Pass entire uverbs attr bundle to
 create cq function
Message-ID: <20240617154947.GA4025@unreal>
References: <cover.1718554263.git.leon@kernel.org>
 <7d0deae3798c9314ea41f4eb7a211d1b8b05a7fd.1718554263.git.leon@kernel.org>
 <20240617134409.GK19897@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240617134409.GK19897@nvidia.com>

On Mon, Jun 17, 2024 at 10:44:09AM -0300, Jason Gunthorpe wrote:
> On Sun, Jun 16, 2024 at 07:15:57PM +0300, Leon Romanovsky wrote:
> 
> > @@ -63,6 +63,7 @@ enum uverbs_default_objects {
> >  enum {
> >  	UVERBS_ATTR_UHW_IN = UVERBS_UDATA_DRIVER_DATA_FLAG,
> >  	UVERBS_ATTR_UHW_OUT,
> > +	UVERBS_ATTR_UHW_DRIVER_DATA,
> 
> The start of the driver's attributes is not a "UHW", the UHW is only
> the old structs.

I asked from Akiva to keep existing naming convention UVERBS_ATTR_UHW_XXX
to emphasize the namespace and the position of this attribute as
relevant for existing UHW calls.

> 
> Something like UVERBS_ATTR_DRIVER_NS_WITH_UHW

I think that my proposed name is better.

Thanks

> 
> Jason

