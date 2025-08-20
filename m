Return-Path: <linux-rdma+bounces-12825-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65FCAB2D09A
	for <lists+linux-rdma@lfdr.de>; Wed, 20 Aug 2025 02:15:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 127D51BA2E5B
	for <lists+linux-rdma@lfdr.de>; Wed, 20 Aug 2025 00:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F60E6F53E;
	Wed, 20 Aug 2025 00:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FZt4sIJY"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197142C859;
	Wed, 20 Aug 2025 00:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755648907; cv=none; b=C3Kr1eRcH/WHpQOHHmDSvy77Ns9ER6xuhJVaUhxOlhXRODYhifO/qeb0x2RxIhclYQ/MutI+zeFSQpqomOsJ3BHPTHJLYaYX4sSNatgIng6zTugn0L0erywXYJuWzD+l1E3TDNUn6DQbUZrYVOzFv0iMFoO5PxptiUCWW9qhxrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755648907; c=relaxed/simple;
	bh=kzPn/YJEz3P/5bJQfIbsGMlkw33F/6kXcp2B3/hVnxg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XFkr2EeksjbbIXpn2CauwP1BMAVj/O9pkuRjGHHvJOTI6Ua3jrZ7kZ/HQWf1b34NUAXW2xMSVDPFLH5uCHNzJ8ip8rRzCuCwoZ3OZIJu//3Rci/N5aUDUWO2ZRCaVjvFePtvQkY/epFxos7EHQD1HmBj2tmJwNHk7vP2uI2hZZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FZt4sIJY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2721CC4CEF1;
	Wed, 20 Aug 2025 00:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755648906;
	bh=kzPn/YJEz3P/5bJQfIbsGMlkw33F/6kXcp2B3/hVnxg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FZt4sIJYj+5SDWKOoTklabwUDzLP1zxuCPLwdqAItQIVr9vTqB7nG4lHsUK2kYQD5
	 podavnBbhOdpiGcL6iTpICCB4OmKH7fKR/OZuvogq6KLE4CpWKzo9r5R2VVh/3CHCx
	 d9JSnjY8Xu6KSDaItD3iqyDxRPo1juL+PqhRCLP9sgGNEMoFpDzTK6BQhJ+Vz2i3Vn
	 Dd8xWHOVr5zRmV9ZLcHifGrtmf613TqDCjpc5XKDYaew6jNjWJAv2nu/c9Uh6v2MGe
	 9zGRT/jNgTsCc7BzdHjU5PXX1Y5rjs1z6vyP5gnfIKcTP5Qj5RIPxWJvN9ISI+NSSw
	 rXn3KDoDpsqkw==
Date: Tue, 19 Aug 2025 17:15:05 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: cpaasch@openai.com, Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky
 <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch
 <mbloch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Alexander Lobakin <aleksander.lobakin@intel.com>, Gal
 Pressman <gal@nvidia.com>, linux-rdma@vger.kernel.org,
 netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/2] net/mlx5: Avoid copying payload to the
 skb's linear part
Message-ID: <20250819171505.4ebbac36@kernel.org>
In-Reply-To: <6dguqontvbisoypbfxw5xyscyqhvskk5avf7gwqgwajc4ic75a@id3pume2f4hw>
References: <20250816-cpaasch-pf-927-netmlx5-avoid-copying-the-payload-to-the-malloced-area-v2-0-b11b30bc2d10@openai.com>
	<20250816-cpaasch-pf-927-netmlx5-avoid-copying-the-payload-to-the-malloced-area-v2-2-b11b30bc2d10@openai.com>
	<6dguqontvbisoypbfxw5xyscyqhvskk5avf7gwqgwajc4ic75a@id3pume2f4hw>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 19 Aug 2025 09:58:54 +0000 Dragos Tatulea wrote:
> > @@ -2009,10 +2040,14 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *w
> >  	u32 linear_frame_sz;
> >  	u16 linear_data_len;
> >  	u16 linear_hr;
> > +	u16 headlen;
> >  	void *va;
> >  
> >  	prog = rcu_dereference(rq->xdp_prog);
> >  
> > +	headlen = min3(mlx5e_cqe_estimate_hdr_len(cqe), cqe_bcnt,
> > +		       (u16)MLX5E_RX_MAX_HEAD);
> > +  
> How about keeping the old calculation for XDP and do this one for
> non-xdp in the following if/else block?
> 
> This way XDP perf will not be impacted by the extra call to 
> mlx5e_cqe_estimate_hdr_len().

Perhaps move it further down for XDP?
Ideally attaching a program which returns XDP_PASS shouldn't impact
normal TCP perf.

