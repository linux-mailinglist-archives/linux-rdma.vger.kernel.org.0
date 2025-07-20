Return-Path: <linux-rdma+bounces-12317-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B128B0B408
	for <lists+linux-rdma@lfdr.de>; Sun, 20 Jul 2025 09:03:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCF6D189CA30
	for <lists+linux-rdma@lfdr.de>; Sun, 20 Jul 2025 07:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 023681D5141;
	Sun, 20 Jul 2025 07:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fqMoLfKH"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABEDB4A23;
	Sun, 20 Jul 2025 07:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752994996; cv=none; b=Qjh1MygXB+mwE7d1mga++KYPYQflZ402qzD+iX9jxcOJ8snZ5dUtC59cxCXSVrs/gZ6rKtirzElcPP+z3nrTdEmtGRwXs3vqYzoUtelSrPy9ECSdeXsRTWH0C+OxbZkTpGQGmsGTwsPJkU/da/0mVDqLjuniYHK2v9XBzr9n784=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752994996; c=relaxed/simple;
	bh=KrHbmEeIzqyXY1EX4RYscC1LkQaWORQxYXkfbeaojgs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Px2yffEVTJqIx60tj0G4vgsQD7pS6kQJfK8i7059yR1ddpwYFAEqptutPplFVfrHBf2ERRquQRfecqb6fzX7V33sbvWCYnbCGM1Qe2KiOYOxawA2UwJE7MyIrunpd1SflfOOqJZIoZULwHE2AISAE7tazROdeM/1b7tRECNkQm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fqMoLfKH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 959D5C4CEE7;
	Sun, 20 Jul 2025 07:03:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752994996;
	bh=KrHbmEeIzqyXY1EX4RYscC1LkQaWORQxYXkfbeaojgs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=fqMoLfKHhY9Fy4jKoiUqiiT+/pEPCGF/+2brV0e1TCSmY+tY7LQehfz6MoY1UbiAV
	 eF837YlmYzMT6iDJnIqimwqN/1CtnqEdK0jxqPbd4FOGNdVedEEeeYl4Y3XB+leRoH
	 0iz3ycJTLhgU//Ohh5RUpjBH7ZID1puSXE2pCEomJz0aI8NJg/rcc1uw468P0QHeWA
	 IDSbpUEa2MZjvmEc4dCjx8ZxyhtcYf2ddwIsHsj8AooIawuHB/QRWSx//L20p9KYZU
	 fJvRCAXZdn8YmPMpjFcY0LDjFKiXa1NmP1Tqf2A+YsqZFtjryeuh4+rXS/CJfZ4tRO
	 Y7B0dfNjbrKmg==
From: Leon Romanovsky <leon@kernel.org>
To: Saeed Mahameed <saeed@kernel.org>, Tariq Toukan <tariqt@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Gal Pressman <gal@nvidia.com>, 
 Saeed Mahameed <saeedm@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, 
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <1752734895-257735-1-git-send-email-tariqt@nvidia.com>
References: <1752734895-257735-1-git-send-email-tariqt@nvidia.com>
Subject: Re: [PATCH mlx5-next 0/3] mlx5-next updates 2025-07-17
Message-Id: <175299499263.667508.14308656303084331740.b4-ty@kernel.org>
Date: Sun, 20 Jul 2025 03:03:12 -0400
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Thu, 17 Jul 2025 09:48:12 +0300, Tariq Toukan wrote:
> This series contains mlx5 shared updates as preparation for upcoming
> features.
> 
> Regards,
> Tariq
> 
> 
> [...]

Applied, thanks!

[1/3] net/mlx5: Add IFC bits to support RSS for IPSec offload
      https://git.kernel.org/rdma/rdma/c/438794e93f6271
[2/3] net/mlx5: Add IFC bits and enums for buf_ownership
      https://git.kernel.org/rdma/rdma/c/6f09ee0b583cad
[3/3] net/mlx5: Expose cable_length field in PFCC register
      https://git.kernel.org/rdma/rdma/c/9a0048e0ae14cb

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


