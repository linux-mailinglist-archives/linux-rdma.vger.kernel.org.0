Return-Path: <linux-rdma+bounces-13199-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 08EFBB4AD21
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Sep 2025 14:02:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7EC5E7B896B
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Sep 2025 12:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A9762E11DC;
	Tue,  9 Sep 2025 12:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HSHQanX7"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E05DF2C029C;
	Tue,  9 Sep 2025 12:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757419279; cv=none; b=uAkT30acip3qLCpxSbzuQehTw7r8PqRZcgJQTZtMqbgB108ugyUDDtMJS1fbNQIYC6UjcFXjgoh0TcTn0zNioR4bF6haL5n8IsiWVzaqhJgN4prkxc+q4gYkmHyigNfxOp7BL+hX8lyfYFhfAVyIinGEjVTajzKToXKKa4v9iL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757419279; c=relaxed/simple;
	bh=mo6AUvUZ17yTMm1pVi/4T+mFBtewK+GFSPajZk+ut6g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OKu5TZkJnwm8psYf25D1lwFzZbcrsEXJWtPvGgYo4HNVcoo8wWHq+kh/WffCz5pKJRSnbNFlnQctdEpXkgYFB0WW09LTywhMjdf8RMpzatCAxbfb4ArZwFscIRvjB3FiozzI/CfWix3Zyt7FGu48WYpedK/JOG5QaR+Nrh6RhSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HSHQanX7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71D58C4CEF4;
	Tue,  9 Sep 2025 12:01:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757419278;
	bh=mo6AUvUZ17yTMm1pVi/4T+mFBtewK+GFSPajZk+ut6g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HSHQanX7DQgZ9w3geUPDEB3Np/9wwMkVAQF5Oiot4K0kzKK0+dCiEs4NpytQLl7/3
	 l1W46zWi6tkM+jE9pySgeh+7gMIToEBuZ4IisTHyVaqYtaTWDmEszWS8EzNva3GlBV
	 +9jpaPmBQ437eHkJizE6gis/qIlV1hhwh50yzly3Hl2orU9qbYlM/kkx8xM/LpzQNL
	 Jaq0jQNeW9cvoLiehL3TY3ilYVORLmtkAXHT1bR17a+RKizKJIxOmtfFHG8n91h05X
	 z2h7qiul/cDWl0uq2MSEvHKfYhArXvDLfcdTYuajIc6hbJaQIrmALnGwoF9hbX0ZzF
	 V13dB4mqkacVg==
Date: Tue, 9 Sep 2025 13:01:13 +0100
From: Simon Horman <horms@kernel.org>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>,
	Jonathan Corbet <corbet@lwn.net>, Jiri Pirko <jiri@resnulli.us>,
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	Gal Pressman <gal@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>
Subject: Re: [PATCH net-next 2/2] net/mlx5e: Add stale counter for PCIe
 congestion events
Message-ID: <20250909120113.GB14415@horms.kernel.org>
References: <1757237976-531416-1-git-send-email-tariqt@nvidia.com>
 <1757237976-531416-3-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1757237976-531416-3-git-send-email-tariqt@nvidia.com>

On Sun, Sep 07, 2025 at 12:39:36PM +0300, Tariq Toukan wrote:
> From: Dragos Tatulea <dtatulea@nvidia.com>
> 
> This ethtool counter is meant to help with observing how many times the
> congestion event was triggered but on query there was no state change.
> 
> This would help to indicate when a work item was scheduled to run too
> late and in the meantime the congestion state changed back to previous
> state.
> 
> While at it, do a driveby typo fix in documentation for
> pci_bw_inbound_high.
> 
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>


