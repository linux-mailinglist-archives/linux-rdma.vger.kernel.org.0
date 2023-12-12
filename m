Return-Path: <linux-rdma+bounces-385-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E5EE80E4A1
	for <lists+linux-rdma@lfdr.de>; Tue, 12 Dec 2023 08:09:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C965C283C3D
	for <lists+linux-rdma@lfdr.de>; Tue, 12 Dec 2023 07:09:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 860CC1642B;
	Tue, 12 Dec 2023 07:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VyUljDow"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 392EB15AF5;
	Tue, 12 Dec 2023 07:09:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3949BC433C8;
	Tue, 12 Dec 2023 07:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702364965;
	bh=pB8+fIZhzR492UWfipR7CODlOesDHwNffafvM9Vgtrk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=VyUljDowqbRlOWaI5ynH5FOKn6SM4FmBvpZ9i7jyQn4k3gBEzyiGyeliZWsFa54Ks
	 EFIoMKgRD8fGUYhwFfXPvHEy53EnGHSyOYvSgR9j1Qbk3EkvX2quUN4XeLfqNnsHlh
	 4UvGBO6s2SpW8izhAnhQTjq83O+tT0bZ8WF0P5lU4PvrBsIqgsTYfX08kexF0YcA/B
	 QDdpECiOrczg0nK/612ofONN1Oa+RdgL33bAjqDGRSrMakjycpUGsf3wnee+ZGWRye
	 O5hyNTNLsFqX/ZrXMyW2Um75V90M470jv5PzdQQEZKXnFvEgUeU0DKRw1wevwNxKR9
	 Wv5ZQv6FStZEw==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
 Mark Bloch <mbloch@nvidia.com>, Michael Guralnik <michaelgur@nvidia.com>,
 netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
 Saeed Mahameed <saeedm@nvidia.com>, Shun Hao <shunh@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>
In-Reply-To: <cover.1701871118.git.leon@kernel.org>
References: <cover.1701871118.git.leon@kernel.org>
Subject: Re: [PATCH mlx5-next v1 0/5] Expose c0 and SW encap ICM for RDMA
Message-Id: <170236496138.251016.9253831188442382874.b4-ty@kernel.org>
Date: Tue, 12 Dec 2023 09:09:21 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-a055d


On Wed, 06 Dec 2023 16:01:33 +0200, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Changelog:
> v1:
>  * Reordered patches
> v0: https://lore.kernel.org/all/cover.1701172481.git.leon@kernel.org
> 
> [...]

Applied, thanks!

[1/5] net/mlx5: Introduce indirect-sw-encap ICM properties
      https://git.kernel.org/rdma/rdma/c/1ca51628e73037
[2/5] RDMA/mlx5: Support handling of SW encap ICM area
      https://git.kernel.org/rdma/rdma/c/a429ec96c07f30
[3/5] net/mlx5: Manage ICM type of SW encap
      https://git.kernel.org/rdma/rdma/c/abf8e8f29a3cb6
[4/5] net/mlx5: E-Switch, expose eswitch manager vport
      https://git.kernel.org/rdma/rdma/c/eb524d0fd46249
[5/5] RDMA/mlx5: Expose register c0 for RDMA device
      https://git.kernel.org/rdma/rdma/c/d727d27db536fa

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>

