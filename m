Return-Path: <linux-rdma+bounces-11426-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79DBCADE92C
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Jun 2025 12:39:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBF3E189E4F7
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Jun 2025 10:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98C24277CAC;
	Wed, 18 Jun 2025 10:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ufBR6gQ0"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F9215D1;
	Wed, 18 Jun 2025 10:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750243146; cv=none; b=KUpnR/SwXSZ9LjEES/tGF03G7UZJhHy/+iC2RffzC2iiwlswwCDgnZy7e1btU+xJ7o8vUW7b5Ag2gOa8VmHJ4Xhvmiuls01MGvmkYcfT2y4jLZi6MEsQkgYXnca6WGSe/eKvpql4FcrxoHRzPsFN2MtX8gPO7UEuD5cMeSQAjjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750243146; c=relaxed/simple;
	bh=x/ii5cd/H2744JUIqWy+BehbbhjlhkKbeCryPgtWCZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mrSpbs2/jcpsUDMcVTWAE4YzHH4QWBKLRydrhM0Ln81OsitfkNan3lsKx/pU/H4WFh6hOJJ9ue/JB3szHpc3h/DptDksqn2ltLINAZS/fE7SKBRiwDq1HOqwbtcggXKX3gFWC3wruJn4wD6GSVYiXzBQ7VPPYZT/mjXon8t7UXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ufBR6gQ0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 337E5C4CEE7;
	Wed, 18 Jun 2025 10:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750243145;
	bh=x/ii5cd/H2744JUIqWy+BehbbhjlhkKbeCryPgtWCZM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ufBR6gQ0Q0g+rm8bh1sdujGDj34/9jT16c3+IvqrLwMbtx8fjfC3HUbFfTFJ/D3PC
	 s2Hp0Ii4opOPbJXcrts2Yzwq+ia6LDP7uZV3nGyzM/WTQgYtNsPS6MQnSuum+dYBdV
	 iW2o7qSHHNXLHfbsSpOQTgwzYJRL8zK1+R97hEzkSGWpytQubF6QBxGadeYJLBHfZU
	 8nCHxp/zIuHrdDxMG7pMU/hxBk6Gzhvagr3nnTXtfyyt4/LOEG8/6FF/i3V0Z3Muep
	 KyhOwx/dgb0+JI8S1YBaBQqCUtLqUzyiuWb/k8sc4j9d/Dte7G4OmGdleaZ06upic6
	 +ELHaILeYaE/Q==
Date: Wed, 18 Jun 2025 13:39:01 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Zhu Yanjun <yanjun.zhu@linux.dev>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, linux-rdma@vger.kernel.org,
	Mark Bloch <mbloch@nvidia.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Patrisious Haddad <phaddad@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>
Subject: Re: [PATCH rdma-next 0/2] Add multiple priorities support to mlx5
 RDMA TRANSPORT tables
Message-ID: <20250618103901.GA17401@unreal>
References: <cover.1750148083.git.leon@kernel.org>
 <80df50e4-a215-4d19-801d-f1d24b91af1c@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <80df50e4-a215-4d19-801d-f1d24b91af1c@linux.dev>

On Tue, Jun 17, 2025 at 09:53:18PM -0700, Zhu Yanjun wrote:
> 在 2025/6/17 1:19, Leon Romanovsky 写道:
> > Hi,
> > 
> > This short series from Patrisious extends mlx5 flow steering logic to
> > allow creation rule creation with priorities in RDMA TRANSPORT tables.
>         ^^^^^^^^
> This "creation" should be removed?

This is typo on cover letter which is going to be disposed.

Thanks

> 
> Yanjun.Zhu
> 
> > 
> > Thanks
> > 
> > Patrisious Haddad (2):
> >    net/mlx5: fs, add multiple prios to RDMA TRANSPORT steering domain
> >    RDMA/mlx5: Add multiple priorities support to RDMA TRANSPORT userspace
> >      tables
> > 
> >   drivers/infiniband/hw/mlx5/fs.c               | 40 ++++++++++++-------
> >   drivers/infiniband/hw/mlx5/fs.h               |  8 +++-
> >   drivers/infiniband/hw/mlx5/mlx5_ib.h          |  4 +-
> >   .../net/ethernet/mellanox/mlx5/core/fs_core.c | 30 ++++++++++----
> >   include/linux/mlx5/fs.h                       |  2 +-
> >   5 files changed, 56 insertions(+), 28 deletions(-)
> > 
> 
> 

