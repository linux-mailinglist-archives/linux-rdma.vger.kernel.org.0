Return-Path: <linux-rdma+bounces-13628-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C2ECB9AD6A
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Sep 2025 18:17:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 385244A505C
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Sep 2025 16:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A350B313E06;
	Wed, 24 Sep 2025 16:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Giaxo+9W"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB5630F817;
	Wed, 24 Sep 2025 16:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758730654; cv=none; b=E6aXEgIrj1SFsMWeyMMo4hpDl3SrqhGX9FzNPTW07J9rr8NMUWtd4JI4QcCgCXxD9HTVr45r1UBGDr5aL4voqxLr0RBXComc1U0o7L8ecykDMSO0SLX76+tyO0gbyBBaUQg8pGP61mtezgPrh6glQDN4kCFbHMPegTrSkJPh+V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758730654; c=relaxed/simple;
	bh=YyScRpDeb10V1CIi0j2uShOHELjAnAul+CkQll9T1qQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ua8WuID7WLCcwfU74oAfXvqUJCSRpyOaHDaV+Lu7UyxbOZCD9AA7+aCyfwMKHGADYi6tzPg0SkDLTVjyG0Lg8lWTHt+9MzfaY+/mNBTMQjf74QIzPrCw2dENO2Kw8+mAz4IdZfNsBIwsbUyL+XyKoJ6ePhW1b7HX4HWzF/hyLHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Giaxo+9W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDA98C4CEE7;
	Wed, 24 Sep 2025 16:17:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758730652;
	bh=YyScRpDeb10V1CIi0j2uShOHELjAnAul+CkQll9T1qQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Giaxo+9WWVfQQcLn8VCqMpjQIOO/w/2HKqAyOLnXVxdUXqVJ+dE2TLIbCwjUuYflM
	 cKmfEEhP9shRWXiiYUIRtBy00/aES7x7gy38ueo/jMVtmpYHfqTsfU5W/GvoNJUyLZ
	 EWhrIb55nfjuZbpLqRA3wh9TGe/xGLjGQfH29qAkng+/DHahMel9nM1Ribxcbr+HkT
	 mM+OxZ9l5i4puI+G80RheK70Wh65yzm1nTki5DqrRx/TUq6TTJfKfWpcI4AWTURqtN
	 QX4Tev/PTpOKaMkH5QmyAxuYBM2yn7Rp//chCVIwAIAGiFPEBwKn20Vw+tp4yxo7Oo
	 7XA+cKuzBn6ig==
Date: Wed, 24 Sep 2025 17:17:27 +0100
From: Simon Horman <horms@kernel.org>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>,
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org, Gal Pressman <gal@nvidia.com>,
	Moshe Shemesh <moshe@nvidia.com>, Vlad Dogaru <vdogaru@nvidia.com>,
	Yevgeny Kliteynik <kliteyn@nvidia.com>
Subject: Re: [PATCH net-next 1/7] net/mlx5: HWS, Generalize complex matchers
Message-ID: <20250924161727.GM836419@horms.kernel.org>
References: <1758531671-819655-1-git-send-email-tariqt@nvidia.com>
 <1758531671-819655-2-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1758531671-819655-2-git-send-email-tariqt@nvidia.com>

On Mon, Sep 22, 2025 at 12:01:05PM +0300, Tariq Toukan wrote:
> From: Vlad Dogaru <vdogaru@nvidia.com>

...

> +static int hws_complex_subrule_create(struct mlx5hws_bwc_matcher *cmatcher,
> +				      struct mlx5hws_bwc_rule *subrule,
> +				      u32 *match_params, u32 flow_source,
> +				      int bwc_queue_idx, int subm_idx,
> +				      struct mlx5hws_rule_action *actions,
> +				      u32 *chain_id)
>  {

...

> +	ret = mlx5hws_bwc_rule_create_simple(subrule, match_params, actions,
> +					     flow_source, bwc_queue_idx);
> +	if (ret) {
> +		goto put_subrule_data;
> +		goto unlock;

Hi Tariq and Vlad,

I guess it's a simple editing artifact.
But it seems that the line above is dead code.

Flagged by Smatch.

>  	}

...

