Return-Path: <linux-rdma+bounces-11795-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CBED3AEF692
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Jul 2025 13:30:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B5844A4A6E
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Jul 2025 11:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AC44244695;
	Tue,  1 Jul 2025 11:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d2qjkLjL"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BFC721FF54;
	Tue,  1 Jul 2025 11:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751369421; cv=none; b=nJZKGsaFRALnFj/lTmRLVv3jOuSmLEj4TS2RPFG1KZo/rK1RgSWU6mRUNZBakFDtqkqiRFa5Uo/iONmZrO2K6C1xjQs5hIXHesRqtl3qfDP8g0J2ZqR7q1lVZWIK+8PAbqeF1j0hG02UQrLJXE8DjEZQMHRdLgMqdrNffh6BI90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751369421; c=relaxed/simple;
	bh=dswg9bWDsyU5K/rkhLpgwXZp6fvBIPVcg+nWuf/WKnw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rNCRBBXdhM2VCB8A/xUtJjFYAw405Gzeg3y3LiBBHR01AnX0jolDYj2JVf9GhUTDLn/3+dZ2AXPGAv1TcRil50XpNFj4VCokrT2UIAKlAaINmP3pV6H8XnjQnX+rYyp+RKk5ZKgmNY2YSRmdQLvkvqSyEiiWZmyTq/3I3haiuOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d2qjkLjL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A49B9C4CEEB;
	Tue,  1 Jul 2025 11:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751369420;
	bh=dswg9bWDsyU5K/rkhLpgwXZp6fvBIPVcg+nWuf/WKnw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d2qjkLjLdHNod91CztsAQEoSm0icARL5YjRBe4V2xZCE+MO7rMmRlcDnqUmXgtSkC
	 2FvcMiACGnsTBCabiDeLjPcLtxpP2Of706WmYdyv1y03EfkQOKNP/0Ek9Nh2a79Mtf
	 Uhcl6VjGMhZMk3pX2Xj47RmffDR6DyVOTtiQ2JMEt0XOnnuoUZBu/ZH12NyFmMlikT
	 1iqAkMuOfBj/Zsox51FHjqkGxAkUzYXZUJbddd7T6EijB5GPnXdblqCJpEirhDjxYp
	 W9uKETFZ8cZxE0+tCr0nq8EvG28aNlGXlKy/IUe74eqC4VvamblaU4JgmlyMsV+1xr
	 m75JqFkKFmI+A==
Date: Tue, 1 Jul 2025 14:30:14 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Stav Aviram <saviram@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, linux-rdma@vger.kernel.org,
	Mark Bloch <markb@mellanox.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>
Subject: Re: [PATCH mlx5-next] net/mlx5: Check device memory pointer before
 usage
Message-ID: <20250701113014.GA6278@unreal>
References: <e389fa6ef075af1049cd7026b912d736ebe3ad23.1751279408.git.leonro@nvidia.com>
 <ecd14fd4-91b2-4bdf-af9c-cc6f555f989b@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ecd14fd4-91b2-4bdf-af9c-cc6f555f989b@linux.intel.com>

On Mon, Jun 30, 2025 at 01:18:22PM +0200, Dawid Osuchowski wrote:
> On 2025-06-30 12:35 PM, Leon Romanovsky wrote:
> > From: Stav Aviram <saviram@nvidia.com>
> > 
> > Add a NULL check before accessing device memory to prevent a crash if
> > dev->dm allocation in mlx5_init_once() fails.
> > 
> > Fixes: c9b9dcb430b3 ("net/mlx5: Move device memory management to mlx5_core")
> > Signed-off-by: Stav Aviram <saviram@nvidia.com>
> > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> 
> Given this is a fix, the net tree should be targeted instead of next.

This fix is mainly for RDMA and changes in net-next are by-product. The
current target is mlx5-next.

Thanks

> 
> Best regards,
> Dawid

