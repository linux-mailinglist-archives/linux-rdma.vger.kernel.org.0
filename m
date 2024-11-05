Return-Path: <linux-rdma+bounces-5754-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC0C49BC566
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Nov 2024 07:26:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC5F81C20CFB
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Nov 2024 06:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30C171D9353;
	Tue,  5 Nov 2024 06:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j7quLR56"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD1741C69;
	Tue,  5 Nov 2024 06:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730787982; cv=none; b=RRk4jgdP2oZVQH48uo7X3fSbjjgEFqOcJbPf8nt1jyFVW32ssareivW2ZINou88EORociw1PleI54qlOw2lpSjgrpTVrqDbVx8nSVuPdIVwuCOnqTS+XQ3nf2Q3flzivwgqjhalyZc15UwUuLFvQr4TCGCPrYfYpoN5FBpEDdyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730787982; c=relaxed/simple;
	bh=5CF6Tw0bonw+lH4rZxkMgEjTjw4gECwn5K3T3c1f7WM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ev8D+/fzhsfqADKA/0tZiQ3pRgdMy59LecmalV0zs/CRMqHeJicvaMe9kCxphaV7zJNnLLjhg86JtH53GRcvSLyqc2YEoAZIKsUQnPZ9alkOv0/QXIzXqKdblNUirNUd/IEQfIpT88fCtOmFXnwjNhq5DlMfMDHgmxS5+AbSLNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j7quLR56; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A35FC4CECF;
	Tue,  5 Nov 2024 06:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730787981;
	bh=5CF6Tw0bonw+lH4rZxkMgEjTjw4gECwn5K3T3c1f7WM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j7quLR56agEQagO7+BXKR1xut2dkSkQ3d8aCIRAs95LYb0KB0MOFFFgasvzej5+yj
	 SPCly5Msnpx3hJp06DbzM53/3V+tFcRey8dUign7ENQ9XHQp8RAOJJX0x353itDieT
	 Fy7QeRzwXVvrCYzYF7ChSlGFAK3IUchPBaQQFgOxBuxfJ4/uzSlR3o/etkUlhzZewd
	 bwHvULo0q53HdCDa8+Wcto80NBZ8oXqxHCx6VuXF4S66PiuGBfHWpljFnsbxuH3Kid
	 lGyTOHwizKPVmDce9Nh0S2GaRraNQ4rehXR5cr/6hXMnXGedGHsJm6FhQWSgYDAFb3
	 6V/0M2yCP9cgQ==
Date: Tue, 5 Nov 2024 08:26:13 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Edward Srouji <edwards@nvidia.com>,
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>, Yishai Hadas <yishaih@nvidia.com>
Subject: Re: [PATCH rdma-next 0/2] Introduce mlx5 data direct placement (DDP)
Message-ID: <20241105062613.GB311159@unreal>
References: <cover.1725362773.git.leon@kernel.org>
 <20241104082710.GB99170@unreal>
 <20241104185303.1b83bf8a@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241104185303.1b83bf8a@kernel.org>

On Mon, Nov 04, 2024 at 06:53:03PM -0800, Jakub Kicinski wrote:
> On Mon, 4 Nov 2024 10:27:10 +0200 Leon Romanovsky wrote:
> > Jakub,
> > 
> > We applied this series to RDMA and first patch generates merge conflicts
> > in include/linux/mlx5/mlx5_ifc.h between netdev and RDMA trees.
> > 
> > Can you please pull shared mlx5-next branch to avoid it?
> 
> Sorry I don't have the context, the thread looks 2 months old.
> If you'd like us to pull something please sense a pull request
> targeting net-next...

Sure, will do.

Thanks

