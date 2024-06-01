Return-Path: <linux-rdma+bounces-2745-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 034E98D6F80
	for <lists+linux-rdma@lfdr.de>; Sat,  1 Jun 2024 13:36:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2BD9281F7A
	for <lists+linux-rdma@lfdr.de>; Sat,  1 Jun 2024 11:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D56A3824AB;
	Sat,  1 Jun 2024 11:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gzj36iIF"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF47335A7;
	Sat,  1 Jun 2024 11:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717241762; cv=none; b=Nf7yjwUP6YQaanub/hnnLIeo+R9f99LQfOSTkeO6UEfaf/gMixOoVpE31i+ZE9X1J12H9baox9kb0ipGWjkFarCuqp6jkUlReMFVC/Hx6oQsZscXRIrVN7S5GBo1BAdoXWkjgM0SgWdvtzEi39xIBhACqmhKy/UQKnOV+DdcDIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717241762; c=relaxed/simple;
	bh=kpQf4gwEeOOzDfhWhhcG3oI1znrd4vE/jJPK+EcV08I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uXtM+Hn4RHtV+qSYixDK48x/Vw5QBdSSguF5dxi4fc2qgmEnbYeCe/PlrN5mgt1wdk30LRDfo7/qTz/c3/2S/RJkKpGEAVUCHuLUtEcPOcyOThjjGyr5aZ0MC13GAZqH3epj86GUZQwsMBd3wjCXO+BZMNaQhHKgzG+1dnWYB0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gzj36iIF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66135C116B1;
	Sat,  1 Jun 2024 11:35:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717241762;
	bh=kpQf4gwEeOOzDfhWhhcG3oI1znrd4vE/jJPK+EcV08I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gzj36iIF2LvyS7Kv7+EL84VyeI6zM2JaoVBShSc4JqtM8sFYhlxcx0KUbWYikYebQ
	 kQHucV5qqOknsjNo2DRtp8y44jNhLyDoXX5Tqh0ZDOATy6DLSWeOFEscMrIutOCkhq
	 VkxP0kAuj9FJ+Lj+BErd1LWQD5TVNapB4zls0XCC16an1emBni6tZdToA+bcdJl1kQ
	 R09XGLRF3mXBTTZ/N/Zkh99tY0JV+LtFiSKmRu2OnM83b0aExNwB5i5XdLWHGPgUBt
	 zfFGV+2qNdmLYuqpG0fM4GamTMjYi6sN/iAe6xPID701LvsT5DwQLOCSwHVoUZEyeC
	 yb12Et9/B2rdA==
Date: Sat, 1 Jun 2024 12:35:57 +0100
From: Simon Horman <horms@kernel.org>
To: Joe Damato <jdamato@fastly.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	nalramli@fastly.com, Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"open list:MELLANOX MLX5 core VPI driver" <linux-rdma@vger.kernel.org>
Subject: Re: [RFC net-next v3 1/2] net/mlx5e: Add helpers to calculate txq
 and ch idx
Message-ID: <20240601113557.GE491852@kernel.org>
References: <20240529031628.324117-1-jdamato@fastly.com>
 <20240529031628.324117-2-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240529031628.324117-2-jdamato@fastly.com>

On Wed, May 29, 2024 at 03:16:26AM +0000, Joe Damato wrote:
> Add two helpers to:
> 
> 1. Compute the txq_ix given a channel and a tc offset (tc_to_txq_ix).
> 2. Compute the channel index and tc offset given a txq_ix
>    (txq_ix_to_chtc_ix).
> 
> The first helper, tc_to_txq_ix, is used in place of the mathematical
> expressionin mlx5e_open_sqs when txq_ix values are computed.
> 
> The second helper, txq_ix_to_chtc_ix, will be used in a following patch.

Hi Joe,

I think it would be best to add txq_ix_to_chtc_ix as part of patch that
uses it, because the current arrangement will cause allmodconfigs with
clang-18 and W=1 to fail due to txq_ix_to_chtc_ix being unused.

...

