Return-Path: <linux-rdma+bounces-2420-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A81A38C31D0
	for <lists+linux-rdma@lfdr.de>; Sat, 11 May 2024 16:23:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0A98B210E3
	for <lists+linux-rdma@lfdr.de>; Sat, 11 May 2024 14:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12C795381A;
	Sat, 11 May 2024 14:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kZ4ulFkd"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B80F8537F8;
	Sat, 11 May 2024 14:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715437391; cv=none; b=XK3123Co9bAL6DE4VorGJhmQMt7+EWCNb940BfHpLuTGagATSjb4Hdg2TMfR3OBut+/RbdkwJSANRDektFHYUvY3V7kU0XMtqEZFLqwIGx2ZfDjGhO5Cc10TWy/slrC929mTBbADRP1ZfCHsLXCXKUQ7+u0evo8u8oACC6jpAeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715437391; c=relaxed/simple;
	bh=Qr8OpivSWnfs8bmKLMFIrsKgWu6HXAneyPPW5cVew7E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kX4Q+59i6ciW9ESxzypQqbQjRWgJ2mcKBcBEluf/4j79PHUoNpCxn0Za+DGXLnoAmdu49+EJvQfqIxdTYLeyljSmf1idQCbVBdtZCekRRjhAduWFKcmxvqL9qLkJrfamIxemUqU+tea5yxd/hOOVmryQHxldSPJ+sVnXY4AY+NI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kZ4ulFkd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6E9BC2BBFC;
	Sat, 11 May 2024 14:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715437391;
	bh=Qr8OpivSWnfs8bmKLMFIrsKgWu6HXAneyPPW5cVew7E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kZ4ulFkdNsrM7k7LM1jL5rioqRbHu1PZmHoCDp2vK8uLoX4HjbiGskqQuy25zJW/Q
	 P4OiwrJL7eBs/ydGg6dzsacLJeu9NXOVLzMpueRnCC/ZXOcHk3PeLZ6YicfHr9PACQ
	 Y99ZdSUFZ6lRaedOktxIifDlCPzTbL5A31nnsJ+DYepknjqmBXRUjYC9phHKucV6V5
	 8rW/kDUR2AYxN758gD+8iaokNdeTVXamk1iKLF6yI35hoiBVVk13fdeDtu4tmducYp
	 YQuTS6Vx4o546E5lTdtjY6V8NxNDA92+bOH1BeojsY19YedJvh/wcRfDV5eAhnXw65
	 57XnoW++ZtrZg==
Date: Sat, 11 May 2024 15:23:04 +0100
From: Simon Horman <horms@kernel.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Shay Drory <shayd@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Moshe Shemesh <moshe@nvidia.com>, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH net] net/mlx5: Fix error handling in mlx5_init_one_light()
Message-ID: <20240511142304.GH2347895@kernel.org>
References: <a2bb6a55-5415-4c15-bee9-9e63f4b6a339@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a2bb6a55-5415-4c15-bee9-9e63f4b6a339@moroto.mountain>

On Thu, May 09, 2024 at 02:00:18PM +0300, Dan Carpenter wrote:
> If mlx5_query_hca_caps_light() fails then calling devl_unregister() or
> devl_unlock() is a bug.  It's not registered and it's not locked.  That
> will trigger a stack trace in this case because devl_unregister() checks
> both those things at the start of the function.
> 
> If mlx5_devlink_params_register() fails then this code will call
> devl_unregister() and devl_unlock() twice which will again lead to a
> stack trace or possibly something worse as well.
> 
> Fixes: bf729988303a ("net/mlx5: Restore mistakenly dropped parts in register devlink flow")
> Fixes: c6e77aa9dd82 ("net/mlx5: Register devlink first under devlink lock")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Hi Dan,

I believe that after you posted this patch, a different fix for this was
added to net as:

3c453e8cc672 ("net/mlx5: Fix peer devlink set for SF representor devlink port")

-- 
pw-bot: rejected

