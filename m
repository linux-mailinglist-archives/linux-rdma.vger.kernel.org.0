Return-Path: <linux-rdma+bounces-7876-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF3D9A3D178
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Feb 2025 07:42:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5244D3BA5E9
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Feb 2025 06:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D0BC1E3785;
	Thu, 20 Feb 2025 06:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aA18Qw0E"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C681E25F4
	for <linux-rdma@vger.kernel.org>; Thu, 20 Feb 2025 06:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740033749; cv=none; b=mj/BccoAMiskjRYkIbdzcE4RlwyXs5309Y+Ebo7lxDR9DX0lqKuatTdgpgUqMBuF81Oaa9B3YQVaiZPyBmVa9U+uHuBfp73pnpNjNDL9bkUIUsmNVbDscp35/75KY8zk9wdQJ4uqnAsOy/KnJxlLQgPkvQ2cAktL+Y9F2xZfM/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740033749; c=relaxed/simple;
	bh=xowMXrFRYNngbSsVQTUhXjVJz7iCsGKLBSDYLanIZ18=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=KGHsMsDYvVW01cDaFuHebirNLiHeyJSQOz7XrBEuEFbS/VQVI7bi3jDLikON+vEdXonfEBJWAlPrAEKFduMDCRjxbkCrwquio+NcVQMX6lCv+2H0JY2hy2+BhoPoe29yi9QKdLEcXCEiDQm5VbTMDLzXmq9eIG++wc3Kv/S7VxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aA18Qw0E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 359B9C4CED1;
	Thu, 20 Feb 2025 06:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740033748;
	bh=xowMXrFRYNngbSsVQTUhXjVJz7iCsGKLBSDYLanIZ18=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=aA18Qw0E+Fwbr7C7DaRSrgPOfZrxuipValTJe3g1cbozC886+lFQT5No116YHTDLr
	 DhDr3rasECt/OZwNCJ/GW1IWIxoNAZQ3qrA/slVakB3MSTQ+zMmGXOeY8kCC7gsrv3
	 7lv80xiDDYRp5eW239hDY4IJvMOoHdj5PhuIvTu7jGruJoQoEKSy4npQ+SugacM2bx
	 HkY4emEgYw314i46MhcBtNP8LSZR10b5txWQZFRhxXuPeKSEF2BlAlO3SXME9gGcSV
	 oi+SRoGQgmfY+Hy+6fFSExgK4KQ+mifDZvWgEJaB9657RjXjouJWZ3QPH2ZrVFAMmw
	 uUQqdS73fbbHw==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
Cc: Patrisious Haddad <phaddad@nvidia.com>, linux-rdma@vger.kernel.org, 
 Maor Gottlieb <maorg@nvidia.com>
In-Reply-To: <18ef4cc5396caf80728341eb74738cd777596f60.1739187089.git.leon@kernel.org>
References: <18ef4cc5396caf80728341eb74738cd777596f60.1739187089.git.leon@kernel.org>
Subject: Re: [PATCH rdma-rc] RDMA/mlx5: Fix AH static rate parsing
Message-Id: <174003374559.429204.2312293951806016385.b4-ty@kernel.org>
Date: Thu, 20 Feb 2025 01:42:25 -0500
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Mon, 10 Feb 2025 13:32:39 +0200, Leon Romanovsky wrote:
> Previously static rate wasn't translated according to our PRM but simply
> used the 4 lower bytes.
> 
> Correctly translate static rate value passed in AH creation attribute
> according to our PRM expected values.
> 
> In addition change 800GB mapping to zero, which is the PRM
> specified value.
> 
> [...]

Applied, thanks!

[1/1] RDMA/mlx5: Fix AH static rate parsing
      https://git.kernel.org/rdma/rdma/c/a91d5a250bd78e

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


