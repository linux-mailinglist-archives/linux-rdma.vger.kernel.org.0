Return-Path: <linux-rdma+bounces-3265-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2658390CB27
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Jun 2024 14:09:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 979FC2895A8
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Jun 2024 12:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07DAE2139BC;
	Tue, 18 Jun 2024 12:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bngoNAx2"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCEF82139B6
	for <linux-rdma@vger.kernel.org>; Tue, 18 Jun 2024 12:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718712500; cv=none; b=pPox4sFvPlh6vFaXzHU4B2SqUEpO3j3pkbQIa4edCc2v13JqJuF3QSGqBhvQVxOwNVchVbZcanLsU2GR4hnktE9lwIT8Y/IPzG/OUPsx201ePNTelDxx4i61cM5gAUqVX1zc3rXtXge/cmo+wR6msMO0BbaUUNv4t4rt/bvP64U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718712500; c=relaxed/simple;
	bh=jdZJjJpj2Wf0HYaA8AS8+eHfh4+rayq9JE1wGZLL2vs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aIar44etyTvH8tlNA5zBI8F0jDThNIofzoiWoFg3s/4RnIk7hn3kkIL+cAHjLd3Zuml3/HXFYpONQC4myzXo/6TF1Lmc5aEvE9HMHFHuLX4/l+05B/MFyWW57Lo2nEp7QqdXFoTmHu96VKW9dIhwR00NfyiJJLrDitrZNdvt4sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bngoNAx2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20DDFC3277B;
	Tue, 18 Jun 2024 12:08:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718712499;
	bh=jdZJjJpj2Wf0HYaA8AS8+eHfh4+rayq9JE1wGZLL2vs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bngoNAx2hW2KpMsFyyGNRizUeDW4aeEv/6Vtpv/SyJToY94NMncAigTsHSrTQ2dmB
	 u7ZWq6Bpuf5Uonkaua2+gTYBMY5hUPjl+932/yggDKVLnlEoMrnFxXS9k5LEulwJCj
	 9pAT1yvZggQTV83z97SCCVjy4lfvaVNncm6mP94wsMrt0xI+Qep0v3jUDkaQpb+b4W
	 y8HVoSg2FwZNhfOazN856E0o3sV3QD+n6oK/aJ+THeVOTFSyyZZLfHuouWsK0r44or
	 vbc6zB98QcqieSet7BEhT6ESUDJUf09gdrtU9U5sUwSy9W0rBM0FhrQ0IIfxTE3WpL
	 +tyUef51gAhsw==
Date: Tue, 18 Jun 2024 15:08:14 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Chiara Meiohas <cmeiohas@nvidia.com>,
	Christian Koenig <christian.koenig@amd.com>,
	Jianxin Xiong <jianxin.xiong@intel.com>, linux-rdma@vger.kernel.org,
	Michael Guralnik <michaelgur@nvidia.com>,
	"Michael J. Ruhl" <michael.j.ruhl@intel.com>,
	Sean Hefty <sean.hefty@intel.com>
Subject: Re: [PATCH rdma-next] RDMA/mlx5: Set mkeys for dmabuf at PAGE_SIZE
Message-ID: <20240618120814.GF4025@unreal>
References: <1e2289b9133e89f273a4e68d459057d032cbc2ce.1718301631.git.leon@kernel.org>
 <20240617135905.GL19897@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240617135905.GL19897@nvidia.com>

On Mon, Jun 17, 2024 at 10:59:05AM -0300, Jason Gunthorpe wrote:
> On Thu, Jun 13, 2024 at 09:01:42PM +0300, Leon Romanovsky wrote:
> > From: Chiara Meiohas <cmeiohas@nvidia.com>
> > 
> > Set the mkey for dmabuf at PAGE_SIZE to support any SGL
> > after a move operation.
> > 
> > ib_umem_find_best_pgsz returns 0 on error, so it is
> > incorrect to check the returned page_size against PAGE_SIZE
> 
> This commit message is not clear enough for something that need to be
> backported:

This patch is going to be backported without any relation to the commit
message as it has Fixes line.

Thanks

> 
> RDMA/mlx5: Support non-page size aligned DMABUF mkeys
> 
> The mkey page size for DMABUF is fixed at PAGE_SIZE because we have to
> support a move operation that could change a large-sized page list
> into a small page-list and the mkey must be able to represent it.
> 
> The test for this is not quite correct, instead of checking the output
> of mlx5_umem_find_best_pgsz() the call to ib_umem_find_best_pgsz
> should specify the exact HW/SW restriction - only PAGE_SIZE is
> accepted.
> 
> Then the normal logic for dealing with leading/trailing sub page
> alignment works correctly and sub page size DMBUF mappings can be
> supported.
> 
> This is particularly painful on 64K kernels.

Unfortunately, the patch was already merged, so I can't change the
commit message in for-next branch.

Thanks

> 
> Jason

