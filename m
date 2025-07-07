Return-Path: <linux-rdma+bounces-11926-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 81DBEAFB200
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Jul 2025 13:10:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DBEE1891634
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Jul 2025 11:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C060296155;
	Mon,  7 Jul 2025 11:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g51tBcF+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 242EF1C4A0A;
	Mon,  7 Jul 2025 11:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751886584; cv=none; b=eV5vBX5YY4Ygvj8wEXIYRBXWlQgzE70ZG5IP3JQ9uHqUzIZhYr1+XjfaC2odU9UlrgRfViqZcB3jFVjNQE6XE1cH7yULtDL8AGrWQvhqEakhC2vJMoGVBtVGoKmoXMoI3AdbDYZWiHYgw+VNeW/QyOcv7CPXhR28FcZ54Q0SCn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751886584; c=relaxed/simple;
	bh=KDi0xnn1z8fWLXNP3jfNQOwvxp4azmsYLqQyuE5iCMY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qHN26Sjq6TUZebVKKaS8/GUIaiJomMvCnX5ceIk1iQ6UaTkFapV1c76tHGoBApd9Bq/krJG6TQ8+FzYTMfwfBQeeciq0j36XxJj/C4vVxyu+Ug0Ig+FLVlTQNU9OmU70Z7J0kvB85Ii0Yt11pGU340PiMAnJf7t9rxrKQmbXzf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g51tBcF+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10FDCC4CEE3;
	Mon,  7 Jul 2025 11:09:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751886584;
	bh=KDi0xnn1z8fWLXNP3jfNQOwvxp4azmsYLqQyuE5iCMY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g51tBcF+3Bzr4QpSAtYZHj+2nQRtBwK5/RcmJthB1fjIHb+SljJdboFO3WDVsywM+
	 3Kkg/u8jWMHvYoeYCQuIlSR7soGlrQOgJVLDs/cnzmyY85bdIwZzWhbWQILlMQbuCv
	 U0EuZFOnBoacfZl1GxUBcaLLj6yWmYkExlYmTtO81+fmiRhZEXTmn9a5FWp0uXFXPa
	 I4JiHFFsU05MIy9WFKVcdHHgDyzoS60VTqBlnRzp1kWnW8KOh2FL2p9exoxjCSM+Bc
	 3jmomt2rvOrnHF1BVKyySWLIaSrfRHy4JftajT4cuhEyCGeEsaY3apbsjRbv1bNulC
	 swXGDrf3e50uA==
Date: Mon, 7 Jul 2025 12:09:38 +0100
From: Simon Horman <horms@kernel.org>
To: Mark Bloch <mbloch@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, saeedm@nvidia.com,
	gal@nvidia.com, leonro@nvidia.com, tariqt@nvidia.com,
	Leon Romanovsky <leon@kernel.org>, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yevgeny Kliteynik <kliteyn@nvidia.com>,
	Vlad Dogaru <vdogaru@nvidia.com>
Subject: Re: [PATCH net-next v3 09/10] net/mlx5: HWS, Shrink empty matchers
Message-ID: <20250707110938.GK89747@horms.kernel.org>
References: <20250703185431.445571-1-mbloch@nvidia.com>
 <20250703185431.445571-10-mbloch@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250703185431.445571-10-mbloch@nvidia.com>

On Thu, Jul 03, 2025 at 09:54:30PM +0300, Mark Bloch wrote:
> From: Yevgeny Kliteynik <kliteyn@nvidia.com>
> 
> Matcher size is dynamic: it starts at initial size, and then it grows
> through rehash as more and more rules are added to this matcher.
> When rules are deleted, matcher's size is not decreased. Rehash
> approach is greedy. The idea is: if the matcher got to a certain size
> at some point, chances are - it will get to this size again, so it is
> better to avoid costly rehash operations whenever possible.
> 
> However, when all the rules of the matcher are deleted, this should
> be viewed as special case. If the matcher actually got to the point
> where it has zero rules, it might be an indication that some usecase
> from the past is no longer happening. This is where some ICM can be
> freed.
> 
> This patch handles this case: when a number of rules in a matcher
> goes down to zero, the matcher's tables are shrunk to the initial
> size.
> 
> Signed-off-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
> Reviewed-by: Vlad Dogaru <vdogaru@nvidia.com>
> Signed-off-by: Mark Bloch <mbloch@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>


