Return-Path: <linux-rdma+bounces-6970-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D5884A0A7D5
	for <lists+linux-rdma@lfdr.de>; Sun, 12 Jan 2025 09:58:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A461618884A4
	for <lists+linux-rdma@lfdr.de>; Sun, 12 Jan 2025 08:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D6A8188CAE;
	Sun, 12 Jan 2025 08:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cmGDvKJZ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55790BA3F;
	Sun, 12 Jan 2025 08:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736672306; cv=none; b=gClpV6od14nzUjHV8/jbPxFyjP0limRn+AhsiKCt98TinH6+iaFZm2tMkcCAny6A0SjEVqJaTu3mEv0JR8RvtpWECIufpWesl+PsrCmQIVHg5AX3R+ABlN6+9OApO1LvX3y55VVRGznQwpGtl32H9rDuB90CD6weAfy1Qns+7MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736672306; c=relaxed/simple;
	bh=v0achWYsfTqjctn1My0eZ+7zXEt9WGcj1uKRGMBNaKA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=pXYTaEGZA/HzGIpMeJ+1HPgmyXzsbBY5bz6gPv0eF5d9j07YWlA2v3zQY40ipbVfuzSlZ75IOFsVBz/5YaqwuQLuCFJRtDcYji3rgN9ac0fcUv8FQI/leRCBlC5Szjg49CNmoZOxHyWNr3viPaXOchihZpRl+5/ohoXHMB3HJLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cmGDvKJZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A130C4CEDF;
	Sun, 12 Jan 2025 08:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736672305;
	bh=v0achWYsfTqjctn1My0eZ+7zXEt9WGcj1uKRGMBNaKA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=cmGDvKJZXxwxYwfR7UOSN+/lxdWl/PCWRFuvG51FM3vtR7pULEcXP8ODTItptNaUH
	 /cHh4cUkIrtB3wLdxvv/G0oNl1TB6mDDZkdD6Bmb1NzPiinhd1/9v6qQ+WAn6bCh1i
	 urfrLN+DldLyOQG6ldEwBXO/TnpiNAvWCFMsr0GKwsYOh/s8lRVXyCt54H3/fZ9WLE
	 SpP5DMQuZ/ekWEl/lziHzVDjj8zwPbRQyTdZPlleacfDipFtMEIGWFbK5opu1GibVE
	 GkuUaKdJH8BOom47LzA+OCTWkuo31jmZ5MNLQbG5JgLB6GQ0wJPOqvpivbUYQodkk2
	 27SwS1rStQlgA==
From: Leon Romanovsky <leon@kernel.org>
To: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
 Jason Gunthorpe <jgg@ziepe.ca>, Tariq Toukan <tariqt@nvidia.com>
Cc: netdev@vger.kernel.org, linux-rdma@vger.kernel.org, 
 Jakub Kicinski <kuba@kernel.org>, Gal Pressman <gal@nvidia.com>, 
 Mark Bloch <mbloch@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>
In-Reply-To: <20250109204231.1809851-1-tariqt@nvidia.com>
References: <20250109204231.1809851-1-tariqt@nvidia.com>
Subject: Re: [PATCH mlx5-next 0/4] mlx5-next updates 2025-01-09
Message-Id: <173667230255.1013956.8857479733504746208.b4-ty@kernel.org>
Date: Sun, 12 Jan 2025 03:58:22 -0500
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Thu, 09 Jan 2025 22:42:27 +0200, Tariq Toukan wrote:
> This series contains mlx5 IFC updates as preparation for upcoming
> features.
> 
> Regards,
> Tariq
> 
> Akiva Goldberger (1):
>   net/mlx5: Add nic_cap_reg and vhca_icm_ctrl registers
> 
> [...]

Applied, thanks!

[1/4] net/mlx5: Update mlx5_ifc to support FEC for 200G per lane link modes
      https://git.kernel.org/rdma/rdma/c/387bef82d0b4af
[2/4] net/mlx5: Add support for MRTCQ register
      https://git.kernel.org/rdma/rdma/c/e2685ef5f56295
[3/4] net/mlx5: SHAMPO: Introduce new SHAMPO specific HCA caps
      https://git.kernel.org/rdma/rdma/c/df75ad562a6f9a
[4/4] net/mlx5: Add nic_cap_reg and vhca_icm_ctrl registers
      https://git.kernel.org/rdma/rdma/c/6ca00ec47b70ac

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


