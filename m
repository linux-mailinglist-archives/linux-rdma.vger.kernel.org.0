Return-Path: <linux-rdma+bounces-3161-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C5F8909891
	for <lists+linux-rdma@lfdr.de>; Sat, 15 Jun 2024 16:01:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C84B1C20D84
	for <lists+linux-rdma@lfdr.de>; Sat, 15 Jun 2024 14:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E22B31E880;
	Sat, 15 Jun 2024 14:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lYDjIGpf"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938468F49;
	Sat, 15 Jun 2024 14:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718460081; cv=none; b=bADpkQVYqfloYemeUERzmlHNDfGB7G4qa5zNuSbgBCuTFFVi4ZsLvTLS4rYgcfbZB9kvmxccwFeekTEXSzzaGQfuuFq+1JsCE2N3YxQPQePIvrJtyx9rtR2KhVQlmlwMC+zc72H7jyJ6X7suG/xJArNa38oOxQg+zPHNI570XDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718460081; c=relaxed/simple;
	bh=IsxKzE/HmgWh8VZzRAf30TKKzYJD2eMOIxM3xKuR0gs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ReS4Yb0jYbzPayg/Vi9Q5LIqmZRomsW7alnZJl6LlPGXDbfblAJCWFpOaT9X0XWwCTkGIom246/AaEo25HyfwNGfwSkdCJU/V7UV+mfBgMChyCLLcpwHqeB11ZSdAA2b+FZZ70rlpcrAlMmv9sslmj6KbmDZfxVEr3erMaIaS4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lYDjIGpf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90C74C116B1;
	Sat, 15 Jun 2024 14:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718460081;
	bh=IsxKzE/HmgWh8VZzRAf30TKKzYJD2eMOIxM3xKuR0gs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lYDjIGpfuIJTylGIhZpcN330hkrVOh2g34HHpVYyVdpsEYQk1pIlPKW7Dlr+TsKT0
	 gQkpkmy8oyvsp9YW9m7IouUN7DFmMgl6eLD6VjixPIlQtJjJ5DLnwHI1QqOgkBfLNY
	 AV6EDzdVk72EX7yQlHkC8dRBq/d8HymGRr88LxW/oJZbREWDTZ+8FZfVUsHmSbsOYy
	 ND7n9ka9xum0ezDTaup8y/kDkEfHql8yjJ4gpiPwlhca5PX21ZDtui83OMVyM0Mks4
	 Wk9pIleya05aleMv9rYZj/eENUr6XomOc2kReB/JdRBxlMlaSlJWd2/0+5hErrrdLy
	 cG94whQ0ct/Xg==
Date: Sat, 15 Jun 2024 15:01:17 +0100
From: Simon Horman <horms@kernel.org>
To: Leon Romanovsky <leon@kernel.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>,
	Patrisious Haddad <phaddad@nvidia.com>, linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>
Subject: Re: [PATCH mlx5-next] RDMA/mlx5: Add Qcounters
 req_transport_retries_exceeded/req_rnr_retries_exceeded
Message-ID: <20240615140117.GC8447@kernel.org>
References: <250466af94f4989d638fab168e246035530e912f.1718301543.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <250466af94f4989d638fab168e246035530e912f.1718301543.git.leon@kernel.org>

On Thu, Jun 13, 2024 at 09:00:04PM +0300, Leon Romanovsky wrote:
> From: Patrisious Haddad <phaddad@nvidia.com>
> 
> The req_transport_retries_exceeded counter shows the number of times
> requester detected transport retries exceed error.
> 
> The req_rnr_retries_exceeded counter show the number of times the
> requester detected RNR NAKs retries exceed error.
> 
> Signed-off-by: Patrisious Haddad <phaddad@nvidia.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>


