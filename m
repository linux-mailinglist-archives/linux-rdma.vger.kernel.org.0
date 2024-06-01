Return-Path: <linux-rdma+bounces-2746-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A14AA8D6F89
	for <lists+linux-rdma@lfdr.de>; Sat,  1 Jun 2024 13:39:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5E0AB22366
	for <lists+linux-rdma@lfdr.de>; Sat,  1 Jun 2024 11:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10FB314F132;
	Sat,  1 Jun 2024 11:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bd7SFatw"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE8214D711;
	Sat,  1 Jun 2024 11:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717241958; cv=none; b=rftGOTlH3xHTW7FrIqwoJscir+kHW3HeIlV4b74t6f4iAQaFds3y4oiC/Zfjt7DgRnty5fdy+TGFQ/FNPPHvtHDLSKmJH+9W4APt6mqdu50jO5CBFPAigRgRs1yWTxHOXJtjzeWBnnWB9Zqt5Y/9WcYiJU6O2RMjjiuyLqQk9CI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717241958; c=relaxed/simple;
	bh=uuwR7hutA7pKITkfIA6u4uSVfOd+C8TZBNZEp+6j+8U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VAMCqS+4jcMuu32ihEbUtWmObD5pVPZ4SN94ROEYow4U1y9qnxwVGUFAsqlUquIbhoxFZJYWTs08T/me19vIXzzG0WXA3cUijWhILAVZXBR0lotrSV6SwTNo5L/EbCOiRarmGNgJRMpJUwf71stfrJHp+567CcKzUZ+K29gmYKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bd7SFatw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94BBEC116B1;
	Sat,  1 Jun 2024 11:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717241958;
	bh=uuwR7hutA7pKITkfIA6u4uSVfOd+C8TZBNZEp+6j+8U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bd7SFatwCvZwT33/Iz8DRCQfeq6XtaH+a5WpGVQptod9swvGOSMbWl6gJCEm6tRuC
	 2H86BDJTGqAA2d7smut09y5mtu25gUEhVF0V6j/Q80D2joIjMoN8WVFCBd7qoz7f4J
	 qd6V14DeXHR2ZHm1IkDzYLhtNdfyhszVZtZcWYv51mXWjL3O95iRPGBc3C89ie5Fc6
	 A9ThQxEi47w/N0LOmHR1nkeu/gNMrqRflqDXe0FK6lxHs2O8XGZTJniGvvfLob3cIi
	 x1DugOnkPmhQVUYsGy/V7pIC7GZpdoXrOTVlWAVqdVHVZdm94FxOtjqqSbUei6GJUU
	 ZnLczec4+srQQ==
Date: Sat, 1 Jun 2024 12:39:13 +0100
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
Message-ID: <20240601113913.GA696607@kernel.org>
References: <20240529031628.324117-1-jdamato@fastly.com>
 <20240529031628.324117-2-jdamato@fastly.com>
 <20240601113557.GE491852@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240601113557.GE491852@kernel.org>

On Sat, Jun 01, 2024 at 12:35:57PM +0100, Simon Horman wrote:
> On Wed, May 29, 2024 at 03:16:26AM +0000, Joe Damato wrote:
> > Add two helpers to:
> > 
> > 1. Compute the txq_ix given a channel and a tc offset (tc_to_txq_ix).
> > 2. Compute the channel index and tc offset given a txq_ix
> >    (txq_ix_to_chtc_ix).
> > 
> > The first helper, tc_to_txq_ix, is used in place of the mathematical
> > expressionin mlx5e_open_sqs when txq_ix values are computed.
> > 
> > The second helper, txq_ix_to_chtc_ix, will be used in a following patch.
> 
> Hi Joe,
> 
> I think it would be best to add txq_ix_to_chtc_ix as part of patch that
> uses it, because the current arrangement will cause allmodconfigs with
> clang-18 and W=1 to fail due to txq_ix_to_chtc_ix being unused.
> 
> ...

Sorry, one more thing.

Please don't use inline in .c files unless there is a demonstrable
reason - f.e. performance - to do so. Rather, let the compiler figure
out when to inline functions.

