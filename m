Return-Path: <linux-rdma+bounces-11654-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A81A0AE967D
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Jun 2025 08:49:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15E8717DD7A
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Jun 2025 06:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C65E22367D6;
	Thu, 26 Jun 2025 06:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bxWFGlh3"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF50219E0;
	Thu, 26 Jun 2025 06:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750920588; cv=none; b=trD6xOv4JEKbDRpiL4wk1o5g12ntiL3l4W+KqieuO059JXreEJLyMYRfxS1+M0bBqaX8hsRCyTe+viiPjoih3ei/+taqcIBZoAcH/Pa2t3UtiC5r2uCmD8nzZMQ9mvG6Y2zhsO7nz51t3/dRkkvc6gpq5OPSFEvOFfAOuL3otg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750920588; c=relaxed/simple;
	bh=PNmc9xgxnJ5qePBDBbiBmb6hiqyULTUckQN94+0242Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P1aoORIge46vNNnQoyKYlOAfnpTDt6XfgPsI+hf94tXF7OjISMIJfbzjECQ47+5bOkpz1B4G0CHiNiHbHV2ppAc7UHlsh1WudDJiH4i3I2Cts/q7KJ7X9/FAvx/tPo07xoOg1SxwmP3fzJGoVB9tAC50ym6275YQFLc8ayq4jHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bxWFGlh3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C88FC4CEEB;
	Thu, 26 Jun 2025 06:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750920588;
	bh=PNmc9xgxnJ5qePBDBbiBmb6hiqyULTUckQN94+0242Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bxWFGlh3xFvGB8gFBxf21XqZVCDQ+6w0632Gzw1FSpYM00ugCku+bBRf5XB0mwix7
	 6xl41W9VqOm37TxzzLstvOIMgl/yzdSqSg01YJq4OG1rwCpYXVtOiqv8CTCtY9Vjng
	 rFI03PiBpWuAykY77rjqGPSAqKLhtK/b6PutcF/wWah37BvJ3VPQ7JeJ4GVF/DOm4U
	 M0KD+qF9Ean8eGitVQKeYe7YZaFbLW/mjoP/OeDPcRhc3DPAbR6LOTvpLGrnhfv3yZ
	 mEfvaoCA53eBk+PHgY6xbyCxhuFcqHGCLs26RNN4pS5C1BmgsrsRZbc7587/NphTYf
	 fK+GB8c33zh7w==
Date: Thu, 26 Jun 2025 09:49:43 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>,
	Patrisious Haddad <phaddad@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>, linux-rdma@vger.kernel.org,
	Mark Bloch <mbloch@nvidia.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>
Subject: Re: [PATCH mlx5-next 1/2] net/mlx5: fs, add multiple prios to RDMA
 TRANSPORT steering domain
Message-ID: <20250626064943.GG17401@unreal>
References: <cover.1750148083.git.leon@kernel.org>
 <b299cbb4c8678a33da6e6b6988b5bf6145c54b88.1750148083.git.leon@kernel.org>
 <20250625164200.45fb717d@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250625164200.45fb717d@kernel.org>

On Wed, Jun 25, 2025 at 04:42:00PM -0700, Jakub Kicinski wrote:
> On Tue, 17 Jun 2025 11:19:15 +0300 Leon Romanovsky wrote:
> > +	for (i = 0; i < MLX5_RDMA_TRANSPORT_BYPASS_PRIO; i++) {
> > +		prio = fs_create_prio(&root_ns->ns, i, 1);
> > +		if (IS_ERR(prio))
> > +			return PTR_ERR(prio);
> > +	}
> > +	set_prio_attrs(root_ns);
> 
> Looking at the PR now -- y'all sure this doesn't need any extra cleanup
> if creation of non-first prio fails?

Yes, it was missed.

Thanks

