Return-Path: <linux-rdma+bounces-11362-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95DF3ADB712
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Jun 2025 18:36:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F0B53A2050
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Jun 2025 16:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84FD81F9F7A;
	Mon, 16 Jun 2025 16:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NTqh2uC9"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 344262868A9;
	Mon, 16 Jun 2025 16:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750091767; cv=none; b=DApiSYNrRDMrVmincNuHCNNS5yI9vCtYpby0XD3L+c8oPZbYQ6jIaoqVZLW8Nd+JF3sDNIIeR6q+r/N44H4XeOQdshJjPqlGfbwGIYuosA95aAsf086nNKs1dvhkvN+XcvFcxxcS5WhY1gR5QlXbs1pX2xmzlxT9BREm8a6YHbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750091767; c=relaxed/simple;
	bh=O/rbvlewyv4zh4iApR/U5L/cjW7xA3XrORib+5XG93Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FUjX4YSHdipfbbZPeUO/AGwgTnUwTbgj79QvP2gX2bEAvcNcdNFWBTj/sZ4W2j3GIpEznIpmQ+WYJCBaDeXy/BUqwj3rwuGt+cHyr7OAE0LNlq6J0bRr/bNRhN8xO6bU5JSeY9P6dVjWjT5rRcxKTQ5Z5wudHnRKR25+dKEB6FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NTqh2uC9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67DD4C4CEEA;
	Mon, 16 Jun 2025 16:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750091766;
	bh=O/rbvlewyv4zh4iApR/U5L/cjW7xA3XrORib+5XG93Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NTqh2uC9+unq5Xg2/d6JIFhJi5iacVLkXd6rTOdbbgFbto/njMimSl983ubXWxze/
	 ZBEbQa17NZyjWwOZTRJefZ+cqieWwWZq1pjHMo4nz+be8cSRX43Z05EYa9JEHhzMNn
	 Bhc/zKfPAKcruBNu8zEpY0XVSj/9wdGc9o2qOw+AGmjSwXr13VP54CI4n84rW8kj5b
	 AmSdL53uvrxJowe1cXPUgIYxcFpsq9+ELgmtmEQ3nn7QSLjCp65R09J0pC8VJPA/kF
	 8kB9f+rWtU5SQEdeeTQbK907B36uwKDs22k1/SzNkp96i/gS8oDcQ+RXz1t8T8MydQ
	 JdnSHtNh2CGDA==
Date: Mon, 16 Jun 2025 17:36:02 +0100
From: Simon Horman <horms@kernel.org>
To: Leon Romanovsky <leon@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Mark Zhang <markzhang@nvidia.com>,
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Patrisious Haddad <phaddad@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH net] net/mlx4e: Remove redundant definition of IB_MTU_XXX
Message-ID: <20250616163602.GA4794@horms.kernel.org>
References: <aca9b2c482b4bea91e3750b15b2b00a33ee0265a.1750062150.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aca9b2c482b4bea91e3750b15b2b00a33ee0265a.1750062150.git.leon@kernel.org>

On Mon, Jun 16, 2025 at 11:24:23AM +0300, Leon Romanovsky wrote:
> From: Mark Zhang <markzhang@nvidia.com>
> 
> Remove them to avoid "redeclaration of enumerator" build error, as they
> are already defined in ib_verbs.h. This is needed for the following
> patch, which need to include the ib_verbs.h.
> 
> Fixes: 096335b3f983 ("mlx4_core: Allow dynamic MTU configuration for IB ports")
> Reviewed-by: Patrisious Haddad <phaddad@nvidia.com>
> Signed-off-by: Mark Zhang <markzhang@nvidia.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

Hi Mark, Leon, all,

If I understand things correctly, without this patch the driver
compiles and functions correctly. But if it is modified to
include rdma/ib_verbs.h, which is required for some other forthcoming
change, then the other parts of this patch are needed to avoid a build
failure.

If so, this doesn't match my understanding of a bug fix.
Rather, it seems like a change (for net-next; no fixess tag?) which could
be included in the patch-set that needs rdma/ib_verbs.h included
in this file.

