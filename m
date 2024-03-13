Return-Path: <linux-rdma+bounces-1413-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A1FB87A507
	for <lists+linux-rdma@lfdr.de>; Wed, 13 Mar 2024 10:32:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E56BB213A8
	for <lists+linux-rdma@lfdr.de>; Wed, 13 Mar 2024 09:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C69B820313;
	Wed, 13 Mar 2024 09:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XJMZGVjn"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8855F20309
	for <linux-rdma@vger.kernel.org>; Wed, 13 Mar 2024 09:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710322318; cv=none; b=G57kzt2mMI88dBFPblAnhXPLj2+27X4SLhq5XYZQc0lFcEFarPKwgEgfeVt5LCQFyAhO99A+/Yiic3IbT7RGTYTbD7QXB6cWZ9cl8Xsg+DfrEvwsHgVWBWt9JAnNC6ag4jw9KA1RcphbGOLSwGwYPw/mlNYC2OtYWkEApsKSmMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710322318; c=relaxed/simple;
	bh=FdllY8GnB+a2D54kw7S46CkXEzpODUCOU0GcJrXDEHc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sj0OtJWO69Vplw2Er1yQRwlXvSvQV5PdNOqS32a/OILzRUctnashaEzyZirjSyuBe7vTbowpXOK/SFFLIAWB9CjxpSvsx7HiIULeFqudBlK/+ZgzYu9z21fYC2nt1qjRsxFSsYjtGzwVs1uT73C/pHue0ym0R0r/N/XQJW50Vb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XJMZGVjn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C8EBC433F1;
	Wed, 13 Mar 2024 09:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710322318;
	bh=FdllY8GnB+a2D54kw7S46CkXEzpODUCOU0GcJrXDEHc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XJMZGVjnW96i/KVX7pI8klGVkvpyztDeGl9Ar66JAC9Fh7CgjW30M6s+xn1m802eo
	 eY41PscMfyopoUrhwp9QdjnlK0kjHaOSLT4FRrh+FNaTPVfGPPzKKUxf6ISn4s6liA
	 trEsUtCyWozUw07Dqhlted77Ui7EUHEBXw94t5L1NpW57dPspbyfcLUcyh2HaMP9Ff
	 Lo6sxtJSTLE1C0P647PxgIlUHQcoziNWnGmy1sIvSMEIh7UBUi0Xgu1+emVRWqE3wN
	 Wt6a5iZzAaGGaKnpC90tvJxZ53AHIKDyUo3dulhqShzS9xOTVywQugUzEh/WwN90jh
	 IxVd2De3adL1w==
Date: Wed, 13 Mar 2024 11:31:53 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Boshi Yu <boshiyu@linux.alibaba.com>
Cc: jgg@ziepe.ca, linux-rdma@vger.kernel.org, chengyou@linux.alibaba.com,
	KaiShen@linux.alibaba.com
Subject: Re: [PATCH for-next 3/3] RDMA/erdma: Remove unnecessary __GFP_ZERO
 flag
Message-ID: <20240313093153.GX12921@unreal>
References: <20240311113821.22482-1-boshiyu@alibaba-inc.com>
 <20240311113821.22482-4-boshiyu@alibaba-inc.com>
 <20240312105305.GR12921@unreal>
 <ZfESBtLmXfs27Ya-@xy-macbook.local>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZfESBtLmXfs27Ya-@xy-macbook.local>

On Wed, Mar 13, 2024 at 10:40:06AM +0800, Boshi Yu wrote:
> On Tue, Mar 12, 2024 at 12:53:05PM +0200, Leon Romanovsky wrote:
> > On Mon, Mar 11, 2024 at 07:38:21PM +0800, Boshi Yu wrote:
> > > From: Boshi Yu <boshiyu@linux.alibaba.com>
> > > 
> > > The dma_alloc_coherent() interface automatically zero the memory returned.
> > 
> > Can you please point to the DMA code which does that?
> 
> We have noticed a patchset which ensures that dma_alloc_coherent() always
> returns zeroed memory. The url of this patchset is listed as below:
> https://lore.kernel.org/all/20181214082515.14835-1-hch@lst.de/T/#m70c723c646004445713f31b7837f7e9d910c06f5
> 
> Besides, you may refer to commit 518a2f1925c3 ("dma-mapping: zero memory returned from dma_alloc_*")
> for details. This commit zeros memory by passing __GFP_ZERO flag or
> calling memset internally. For example, the dma_alloc_direct() interface
> calls memset() to zero the allocated memory.

Thanks

