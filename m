Return-Path: <linux-rdma+bounces-11619-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3732AE78FD
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Jun 2025 09:45:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9720F3AB5BF
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Jun 2025 07:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DFAA1F463C;
	Wed, 25 Jun 2025 07:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NGTXROoT"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A951E47CC
	for <linux-rdma@vger.kernel.org>; Wed, 25 Jun 2025 07:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750837526; cv=none; b=B4UOxPEcu7Bhx18VCbWNw12ugl0AQ0uuDTf1C2NPCWaCpgFlLHvOcoPUvHXwWaTKKLsc0J2goUFJWrMFNMYxi2/A7Vzz6cUgWfuBIww7Upou1HaD6wuGZ1e48kTO0guKSoAXaiwbPVEe3tatlgFBX4gsUkQFr446S4RjYca20ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750837526; c=relaxed/simple;
	bh=cK5OvEL9YsieUd/4deew+VvPmfXaBeySmUShg9onF1Q=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=nu/aLbeylFOXRQryrNgrbcIAeEdhtN3kZiqDKo7HHr+eIwyKP7oqPGU6Is6wU03z0hYO9G1a7eESOzR2wuHGzgoM9xmwgmoDom8coAjbhSLiiSiX2ynaMws3t7LeVTH4Z81Im1Sgn2WT/TyH/G1gmHj8ATlxokOyXAj7yP4KMGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NGTXROoT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2065C4CEEA;
	Wed, 25 Jun 2025 07:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750837526;
	bh=cK5OvEL9YsieUd/4deew+VvPmfXaBeySmUShg9onF1Q=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=NGTXROoTe8O/YfB3UzWScQR6mROpTEsZ1Pnumrv3uqAliC1HC2xknItaJklbiAAKJ
	 G8NrGr7WBdPckeBDlzBb7JXS5EyRJ9E8Ip17mR7eOJ9ydvfCyAV3O9q9Rixno+Z1Sb
	 /L2oC9efQMYNsnIv+iBfoMqlIGlFCqRaPVbDKGF9KRbbCHNInaK3yIG66GE+QPZZVh
	 s0aguGJ/FyYagiFp3NliN5H5xxQBtfsXLs0qQGoXEdmp/GKU2vwvckwtSs5X1BSVYl
	 aTjS9wqj8Hw/Pv0bn/13H8mIj4hJVMVQSupUUkqocmrkticzyfyV2+RzG9VcyhI1hL
	 u2hD0CcEYFknA==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
Cc: linux-rdma@vger.kernel.org, Maher Sanalla <msanalla@nvidia.com>, 
 Mark Bloch <mbloch@nvidia.com>, Michael Guralnik <michaelgur@nvidia.com>, 
 Parav Pandit <parav@mellanox.com>, Patrisious Haddad <phaddad@nvidia.com>
In-Reply-To: <cover.1750064969.git.leon@kernel.org>
References: <cover.1750064969.git.leon@kernel.org>
Subject: Re: [PATCH rdma-rc 0/3] Batch of mlx5_ib fixes
Message-Id: <175083752341.552151.14414008626199300882.b4-ty@kernel.org>
Date: Wed, 25 Jun 2025 03:45:23 -0400
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Mon, 16 Jun 2025 12:14:51 +0300, Leon Romanovsky wrote:
> The batch of different mlx5_ib fixes from Patrisious.
> 
> Patrisious Haddad (3):
>   RDMA/mlx5: Fix HW counters query for non-representor devices
>   RDMA/mlx5: Fix CC counters query for MPV
>   RDMA/mlx5: Fix vport loopback for MPV device
> 
> [...]

Applied, thanks!

[1/3] RDMA/mlx5: Fix HW counters query for non-representor devices
      https://git.kernel.org/rdma/rdma/c/3cc1dbfddf88dc
[2/3] RDMA/mlx5: Fix CC counters query for MPV
      https://git.kernel.org/rdma/rdma/c/acd245b1e33fc4
[3/3] RDMA/mlx5: Fix vport loopback for MPV device
      https://git.kernel.org/rdma/rdma/c/a9a9e68954f29b

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


