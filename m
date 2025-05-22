Return-Path: <linux-rdma+bounces-10536-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 31A70AC0D12
	for <lists+linux-rdma@lfdr.de>; Thu, 22 May 2025 15:42:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9589F1BC3AA5
	for <lists+linux-rdma@lfdr.de>; Thu, 22 May 2025 13:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 067BE28BA9B;
	Thu, 22 May 2025 13:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iRi0u0AF"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6ED3010C
	for <linux-rdma@vger.kernel.org>; Thu, 22 May 2025 13:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747921361; cv=none; b=Uv9bjdz2uL23Mm2yTTbK+qdKfJEpOLASTrLPy9FvMfvgS/SiA5/wm7uR++KeA5PyDipgxVygxH55pU+94qnVQW//UWrn2CqtdTgqcbjY3NaLOPan1xZwJHexPNFBWv57pAIAKmQ4HNxMxlqQnC3aDkSjNxdItSaA0gGAjIMxbBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747921361; c=relaxed/simple;
	bh=tqbP+M97s7IBB/SeIrcSVxmpEdXD4UKgf/2WxGNV5F4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CPLgJiyyY7PnXsD/mDnOdEEKrQvePTOhNtSXpXpQNB8E2dh08fKbyB+gk+SrYUtgA6bkqWUnpD/QjUx394O89LFNXZydSZv1CI+GZY2zDJt8QnZneOt2/5tSzzo9CW/RvBTDg1DBCB5GJzEP8LIDpvte21RpOkPdKLSevRh5DDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iRi0u0AF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F497C4CEE4;
	Thu, 22 May 2025 13:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747921361;
	bh=tqbP+M97s7IBB/SeIrcSVxmpEdXD4UKgf/2WxGNV5F4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iRi0u0AFKw+yeyBWCHyBuxXYS0qX0Bj9yDoWvIDR8X85ChQz524e5JcCyeMjHXHD+
	 xYMgEzts9mv0oyM6oaJkkkye8PRC3EcGOXs/8mbTelFxnvxlx/towqRqt6ZhltQ/iC
	 kPgKUlx2Zj1xnHhFEV13Xt5HZQZqphbhID3w8oCW5FnxRZKbiLtfem6dO9HxTsEsDh
	 ND7ZJ60VsnvouHaG7TddtoOKc1LS8qK+K1Nc3IjS5FEMFbsI/CQagIfnLg9uUYHEy1
	 NACwcl6iT4Q14rirTMXjwlTq/sdzF8SXPAoj2Zib+7me/qmBOqvG+v5D1oaanewSst
	 X45bTkKgT5QpA==
Date: Thu, 22 May 2025 16:42:36 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Daisuke Matsuda <dskmtsd@gmail.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, linux-rdma@vger.kernel.org,
	Zhu Yanjun <zyjzyj2000@gmail.com>
Subject: Re: [PATCH rdma-next] RDMA/rxe: Break endless pagefault loop for RO
 pages
Message-ID: <20250522134236.GR7435@unreal>
References: <096fab178d48ed86942ee22eafe9be98e29092aa.1747913377.git.leonro@nvidia.com>
 <72a82333-b005-4383-888c-7632bf1ce4ae@gmail.com>
 <20250522133716.GQ7435@unreal>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250522133716.GQ7435@unreal>

On Thu, May 22, 2025 at 04:37:16PM +0300, Leon Romanovsky wrote:
> On Thu, May 22, 2025 at 10:29:02PM +0900, Daisuke Matsuda wrote:
> > 
> > On 2025/05/22 20:36, Leon Romanovsky wrote:
> > > From: Leon Romanovsky <leonro@nvidia.com>
> > > 
> > > RO pages has "perm" equal to 0, that caused to the situation
> > > where such pages were marked as needed to have fault and caused
> > > to infinite loop.
> > > 
> > > Fixes: eedd5b1276e7 ("RDMA/umem: Store ODP access mask information in PFN")
> > > Reported-by: Daisuke Matsuda <dskmtsd@gmail.com>
> > > Closes: https://lore.kernel.org/all/3e8f343f-7d66-4f7a-9f08-3910623e322f@gmail.com
> > > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> > 
> > Tested-by: Daisuke Matsuda <dskmtsd@gmail.com>
> > 
> > Thank you!
> > This change fixes one of the two issues I reported.
> > The kernel module does not get stuck in rxe_ib_invalidate_range() anymore.
> > 
> > 
> > The remaining one is the stuck issue in uverbs_destroy_ufile_hw().
> > cf. https://lore.kernel.org/all/3e8f343f-7d66-4f7a-9f08-3910623e322f@gmail.com/
> 
> Thanks, I updated the link to point to https://lore.kernel.org/all/3016329a-4edd-4550-862f-b298a1b79a39@gmail.com/
> 
> > 
> > The issue occurs with test_odp_async_prefetch_rc_traffic, which is not yet
> > enabled in rxe. It might indicate that the root cause lies in ib_uverbs layer.
> 
> Unlikely, up till now, it indicated that driver didn't release some
> uverb object.

BTW, all places in RXE driver which do the following:
page = hmm_pfn_to_page(umem_odp->map.pfn_list[index]);
if (!page) {
...

are incorrect, hmm_pfn_to_page() will always return something.

Thanks

