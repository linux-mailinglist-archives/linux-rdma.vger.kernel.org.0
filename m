Return-Path: <linux-rdma+bounces-8496-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3286FA57CBF
	for <lists+linux-rdma@lfdr.de>; Sat,  8 Mar 2025 19:23:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B82731893334
	for <lists+linux-rdma@lfdr.de>; Sat,  8 Mar 2025 18:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17C831E8330;
	Sat,  8 Mar 2025 18:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PhfH1EdF"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E5B1598F4;
	Sat,  8 Mar 2025 18:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741458210; cv=none; b=YTOFY9s7aPx6nrYieTIxJ5n8KI5Y1KgGWijjEUmb2rPYu37hvrsMYvASBFMMvCdSpZI/8cQIjFxNMJ8c4vhR+quZN93Iriq/M0QNhFyGrCEWK2uH0ljUYyoOpArhW/GooLOdBzdaDK4DI42HR9MDLxGkD5q+o8WlSthdCOugYlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741458210; c=relaxed/simple;
	bh=z2Bg5YGUJrFEMfgqkyH7ctU3Cd3Va0P9EdjftEJNN8c=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=K5/PnJcWnQRBoFb3KAjacEX3Eftf5h4zO7UI4FNS1ODuGGbyw8rnwl4iTcRxx5yuW7R42/mBWqmGJLNT0CEF0M+0jJPt5RoI7y+nT9g9cr6AGaQp932/js07e+QC9j3Z7PVf4dp5wJKJgOvUtjoyor5HAztnRyihgp4TQN4fCNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PhfH1EdF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6E37C4CEE0;
	Sat,  8 Mar 2025 18:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741458210;
	bh=z2Bg5YGUJrFEMfgqkyH7ctU3Cd3Va0P9EdjftEJNN8c=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=PhfH1EdFchRmUXvtjwtanFJi/IBKBrDL9CU8VCMS+OGEGVKbaOs2gumE2PZ2XNGGK
	 qvkYXRPm++YL4iIx/BWauJwntJv92PjMNORcdverf47QoyN938hhJUAfgYJ8Z8OTdS
	 HzjBhLbUODPao4/CpRmCROEcb4zPvUbCTmsZJqWmEaJcFUcMUCYc+3CEYR6zgqpq2x
	 b8MIIUEyv5qd/J/tIrS0z3QVThvQcwsIFE58/IOqsBDKS4jV6cshqoxdNafRGIkqNI
	 ID/avvJUhbZ+/I32hTBtUr+kKzVoUHVoVAgBJ0TkbvtnQDZBynNv/MRmrF7B/k2nk9
	 /eFdFYUBfTXxw==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
 Chiara Meiohas <cmeiohas@nvidia.com>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, linux-rdma@vger.kernel.org, 
 Mark Bloch <mbloch@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, 
 netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, 
 Patrisious Haddad <phaddad@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>, 
 Tariq Toukan <tariqt@nvidia.com>
In-Reply-To: <cover.1740574103.git.leon@kernel.org>
References: <cover.1740574103.git.leon@kernel.org>
Subject: Re: [PATCH rdma-next 0/5] Add support and infrastructure for RDMA
 TRANSPORT
Message-Id: <174145820674.306480.17200525743736793706.b4-ty@kernel.org>
Date: Sat, 08 Mar 2025 13:23:26 -0500
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Wed, 26 Feb 2025 15:01:04 +0200, Leon Romanovsky wrote:
> This is preparation series targeted for mlx5-next, which will be used
> later in RDMA.
> 
> This series adds RDMA transport steering logic which would allow the
> vport group manager to catch control packets from VFs and forward them
> to control SW to help with congestion control.
> 
> [...]

Applied, thanks!

[1/5] net/mlx5: Add RDMA_CTRL HW capabilities
      https://git.kernel.org/rdma/rdma/c/f6f425f3d251c0
[2/5] net/mlx5: Allow the throttle mechanism to be more dynamic
      https://git.kernel.org/rdma/rdma/c/0a34fad1bed45f
[3/5] net/mlx5: Limit non-privileged commands
      https://git.kernel.org/rdma/rdma/c/f9deed0980fe29
[4/5] net/mlx5: Query ADV_RDMA capabilities
      https://git.kernel.org/rdma/rdma/c/ab7d228c7e0d0e
[5/5] net/mlx5: fs, add RDMA TRANSPORT steering domain support
      https://git.kernel.org/rdma/rdma/c/15b103df80b250

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


