Return-Path: <linux-rdma+bounces-13327-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61E4FB55AC3
	for <lists+linux-rdma@lfdr.de>; Sat, 13 Sep 2025 02:34:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39C681C81D58
	for <lists+linux-rdma@lfdr.de>; Sat, 13 Sep 2025 00:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6838238FB9;
	Sat, 13 Sep 2025 00:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A8EoKhr2"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB8FA2629C;
	Sat, 13 Sep 2025 00:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757723648; cv=none; b=ppcgvvvgBgP8Z+IuX71Q8wmrmWYlaZrVhpjzE88xQucgBi5CMhM9VEaq+DhLBRaEquYF8gguGbSQsHCS58QiL9ulgC01+8b6XRxOMH2HkMTc/QsAYlx3/lV8/4opipYCaRIThBxpCtN7thzxNAaSJA3El9JOW5HsG0jvkcbn3jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757723648; c=relaxed/simple;
	bh=dfAC4+lFsRLVhxjoVCgW1aNCl36foZU5xBMDEvLDt8M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LoAbsLirZ0yVuePinZjetUCOHyf7s1zSwz/fFM+925EvmTqp9ga5/QLA/QtMHMl2BQxQqbQGai/i9zwEC5YOAsY+/OHdb0pgvBikBUk8NjX93yua8+HeOJtfybEAoV7Ga9f+ocdnq7H07bjvIF2xyklPr3wD+LqiShYvuPPH0pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A8EoKhr2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B11FC4CEF1;
	Sat, 13 Sep 2025 00:34:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757723647;
	bh=dfAC4+lFsRLVhxjoVCgW1aNCl36foZU5xBMDEvLDt8M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=A8EoKhr27QPKybvcMCEROcQN4YnSqT6+JPWp9+g+C8qZ9736Kaw+6Hr+9Qt+CVHR5
	 A9qjXnu005gva8k2aAwHe8Fhzu2fYEiY9BBw3+g6KshB1tyyw7hY8Vl/+p8b4DyJNH
	 wJFFwuKcZLECEiausoP7L6pOwBlQFdI2Bp8fBoCPg3WBM3njD0GAngUFKNuE+aQes8
	 s3Gms3TSfbPRwuPjjOLtDHAaTcMf8hEfCnh/95XuiBT5B6Ie4n4cKbTlp/fHG/BS8O
	 MigsoVSvT6trYr7Kw+jtj00J05slUXAEe18kWczxtEz+ji902hAu6k2rnI7AcQJeLn
	 cKRdkF7M2srFw==
Date: Fri, 12 Sep 2025 17:34:06 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky
 <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>,
 <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
 <linux-rdma@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Leon
 Romanovsky <leonro@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>, Michael
 Guralnik <michaelgur@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>,
 Patrisious Haddad <phaddad@nvidia.com>
Subject: Re: [PATCH net-next] net/mlx5: Improve write-combining test
 reliability for ARM64 Grace CPUs
Message-ID: <20250912173406.1dc8c201@kernel.org>
In-Reply-To: <1757572873-602396-1-git-send-email-tariqt@nvidia.com>
References: <1757572873-602396-1-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 11 Sep 2025 09:41:13 +0300 Tariq Toukan wrote:
> Lastly, this was concluded from the discussion with ARM maintainers
> which confirms that this is the best approach for the solution:
> https://lore.kernel.org/r/aHqN_hpJl84T1Usi@arm.com

You should still CC them (and the arm ML) on the patch submission, 
and hopefully they will ack. Please repost.
-- 
pw-bot: cr

