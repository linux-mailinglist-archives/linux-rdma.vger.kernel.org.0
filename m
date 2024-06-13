Return-Path: <linux-rdma+bounces-3133-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E0167907A9B
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Jun 2024 20:06:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6CACAB227F3
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Jun 2024 18:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEE3614A601;
	Thu, 13 Jun 2024 18:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HszoVfLf"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A19B12CD8F;
	Thu, 13 Jun 2024 18:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718301965; cv=none; b=b/SSkmnta7enrfrdqcOORYE4emC3Rw2b9/EwSsJXCouWJxEj58gTCxpHD2upUBc6dDtl9upCQJNi5DpctAzkYaELR8A7fZWLkTdCSPKUOomjQnPRmwJyX3KrcahVQIx2fNGkcdzD+izWzBOArSs5pKsYsSbhp8p4V/J0zLMn2hQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718301965; c=relaxed/simple;
	bh=QwvzegSeNr0GThvzbTDK0Wv3wO31UJw7Nd92YC4pHiE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SWqn5NXhDIsTdu93SIMyBzM+tyFIh7TEgQdL1pVmhH8025TFdc5I/s2YeBO2H69rRAAd0UjEDa22oHrOlRDjdylqPjq0JqG57Y5Jjhr7mMiJ4VTWK7KdP2a5A00MmUDKRDq8KKmALJNybDtClYxS6K2/NCzWDRxdf3WgCuPXX/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HszoVfLf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A309C2BBFC;
	Thu, 13 Jun 2024 18:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718301965;
	bh=QwvzegSeNr0GThvzbTDK0Wv3wO31UJw7Nd92YC4pHiE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HszoVfLfnTjXFZsmmNJ9QHvm2b9F4eVN2rGAR6K+Mx7Mi0Ul8pYJdqilcjsyA/WT/
	 bBKpsGcF72QPciLhPOYiYar84bzuRYjbd7z2/mXElt7mBYlTwXZUViYsgU+VMzJCzv
	 eH+KTRNEjrotuIJpA/bvXLSlzHkBfBBmj7XXwRlly61rnTGD6hg46FZtes20znoK/F
	 gQ+llYhEBs3JxL3vtvPMv2ex1eOZdgiBlZb8sxO89fQHEgQ+YTXGvd6EeGoqWqroS5
	 YEG+Q2YbAe7Qpj7FaUGHEWkoTDg9yCua1GPc5KwHpsGdo/qtowLdYAa7Edjh+mdZTb
	 P2qAj4sNmx7nw==
Date: Thu, 13 Jun 2024 21:06:00 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Jianbo Liu <jianbol@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>
Subject: Re: [PATCH rdma-next 2/3] IB/mlx5: Create UMR QP just before first
 reg_mr occurs
Message-ID: <20240613180600.GG4966@unreal>
References: <cover.1717409369.git.leon@kernel.org>
 <55d3c4f8a542fd974d8a4c5816eccfb318a59b38.1717409369.git.leon@kernel.org>
 <20240607173003.GN19897@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240607173003.GN19897@nvidia.com>

On Fri, Jun 07, 2024 at 02:30:03PM -0300, Jason Gunthorpe wrote:
> On Mon, Jun 03, 2024 at 01:26:38PM +0300, Leon Romanovsky wrote:
> > From: Jianbo Liu <jianbol@nvidia.com>
> > 
> > UMR QP is not used in some cases, so move QP and its CQ creations from
> > driver load flow to the time first reg_mr occurs, that is when MR
> > interfaces are first called.
> 
> We use UMR for kernel MRs too, don't we?

Strange, I know that I answered to this email, but I don't see it in the ML.

As far as I checked, we are not. Did I miss something?

Thanks

> 
> Jason

