Return-Path: <linux-rdma+bounces-12006-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1506AAFEFC3
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Jul 2025 19:24:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1104C4E80CB
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Jul 2025 17:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0985822D9EB;
	Wed,  9 Jul 2025 17:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uKf1aGOn"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1ED5226D1F;
	Wed,  9 Jul 2025 17:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752081866; cv=none; b=puErdMAG/n8QUnMs2xlrUOOBwVVkLPMIkk0CySPaLjS+GbHg2iypRLfS3No3XIOyYQgdWp+bopmvoi8oO13i46Zr+E8+mBwkpLjQrtH2qFl5FdJeHsQnm6GSMnnQKSs8DPt1IoGpOvN0z3F+dHXDvTsOvVCzhcNIABKLEMKs878=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752081866; c=relaxed/simple;
	bh=mNrQvrpL6JhPAZvARj2HZWQRznAsLMJX6wdu0qS1IzA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eLTE6/2TCTkKOKLdClFTzofsjPS0BZSF8PUzE4sakMLQH0LtrmL+w77uB+8w3f1KvFg//nnuy4cG2QR1zA3fmDJ0mnpdSkZq80RusU6U8Y4h2e9E15pQnvsi1QXgp8xT5djBZwAyS52cMZ9xrPphqRYLthM+0BCRg4TjUo307h4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uKf1aGOn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 799A5C4CEEF;
	Wed,  9 Jul 2025 17:24:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752081866;
	bh=mNrQvrpL6JhPAZvARj2HZWQRznAsLMJX6wdu0qS1IzA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uKf1aGOnWn3FWguBUcfzsEfu/CNL7HM4ZBlForHIZbCbZeCZwd4MFyY4REzKXTfFX
	 CAvDoKb11COW2PXJ74Rtm0D70CS+32/8575zjLi36Nh+EGp598z33gg+T7CUb4In8V
	 rExJLXDOwYcPEp9UukdkwS3DleP94myt/AagP3HeYMKD6Nj9KnJESSzN5g+nPN32y5
	 fkB6YCAYxJxLfHUQp+djqbMxVZ1iXa34cWK8qBT1d4Pg7qfzqoqtCjC2RaSx6HNt3z
	 Yg01FVET4CE9qncmdLhlYE+tBB4NmJYDEBfVyIPULBfymRyKLTZn7ZWFo+lm6qut10
	 iOZ4ubKKzZwwg==
Date: Wed, 9 Jul 2025 18:24:21 +0100
From: Simon Horman <horms@kernel.org>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Saeed Mahameed <saeed@kernel.org>, Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Saeed Mahameed <saeedm@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 3/5] net/mlx5e: Replace recursive VLAN push
 handling with an iterative loop
Message-ID: <20250709172421.GD721198@horms.kernel.org>
References: <1752009387-13300-1-git-send-email-tariqt@nvidia.com>
 <1752009387-13300-4-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1752009387-13300-4-git-send-email-tariqt@nvidia.com>

On Wed, Jul 09, 2025 at 12:16:25AM +0300, Tariq Toukan wrote:
> From: Gal Pressman <gal@nvidia.com>
> 
> mlx5e_tc_act_vlan_add_push_action() uses tail-recursion to walk through
> a stack of VLAN devices.
> 
> There is no need for a complicated recursion with unnecessary stack
> consumption and less obvious code flow, rewrite the function so that it
> uses a do while loop instead.
> 
> Signed-off-by: Gal Pressman <gal@nvidia.com>
> Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>


