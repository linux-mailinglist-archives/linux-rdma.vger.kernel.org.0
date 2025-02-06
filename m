Return-Path: <linux-rdma+bounces-7477-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F252A2A36F
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Feb 2025 09:44:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE157188932B
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Feb 2025 08:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFFE7225786;
	Thu,  6 Feb 2025 08:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mvR7ZQ/Q"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D97A1FCCE1
	for <linux-rdma@vger.kernel.org>; Thu,  6 Feb 2025 08:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738831454; cv=none; b=eoVAYKw6suiqEm+Wr/nTghYsScJKhyZExTiGjooYzKen5CCRK7a1bry4xCruoLmvAbJagTZ+LrAOchQ/gmSaQOX/BeqGuNK239DnrB0UsyZ/DUfYUPO949CciBBci4CsYD4Nsd8Zx/SvRe+u6zEvxFD0JnrhjgjxuGvkimalqok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738831454; c=relaxed/simple;
	bh=bfyDKijHzvLIinT+rbSib+0IVWoP+w2GEGFC1wg8h+c=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=HZYRcf7YOwMaxdYIHtAKasATJbt3hp478pUTRjyIQQrqhXEki73KgU/7NsfkSjQZhpLQNY1+CNEAK5Q2PvznDa0fJzZDAQaBpLwtlofah/K/FyxxoCK3E2AnxaTVRwnY3Suxfh28p5FTOZmKw98xpdNIX2qBYOZlBt5cT9Z4Sqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mvR7ZQ/Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31304C4CEDD;
	Thu,  6 Feb 2025 08:44:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738831453;
	bh=bfyDKijHzvLIinT+rbSib+0IVWoP+w2GEGFC1wg8h+c=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=mvR7ZQ/Qsx9bpdA3WG6vBAp7BWQwxbwILHBF561tKp4yLktv4lOzokwxoJ4GS4bz5
	 mCT7V24qtL5loyomLbnBJpkdLExg2E9JG3gMXQNRnTUrMQiT0FbyS4zrbSVJIGeGj0
	 UsRTBldBWDylNyZTpKsLt2zUNtjeibQpVKUL0ORgDGDe8tdeV763YycQRRLcy+2STu
	 7FUhGH6biTLem9YZdJtUiIQKGAtPX533JPGZvwxuRlYi9B3pK9KnoIbJE7jL8P3X+0
	 gCYZpD0X7ZIcRH2PEWRE14NCDNKSzykx2c0y+hOjJ2Gz3JPc+/NmmM9ylrA/0fw0ro
	 /BYOk6zh88NVw==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
Cc: Yishai Hadas <yishaih@nvidia.com>, 
 Artemy Kovalyov <artemyko@mnvidia.com>, linux-rdma@vger.kernel.org
In-Reply-To: <70617067abbfaa0c816a2544c922e7f4346def58.1738587016.git.leon@kernel.org>
References: <70617067abbfaa0c816a2544c922e7f4346def58.1738587016.git.leon@kernel.org>
Subject: Re: [PATCH rdma-rc] RDMA/mlx5: Fix a race for DMABUF MR which can
 lead to CQE with error
Message-Id: <173883145019.837391.16150058350791831249.b4-ty@kernel.org>
Date: Thu, 06 Feb 2025 03:44:10 -0500
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Mon, 03 Feb 2025 14:50:59 +0200, Leon Romanovsky wrote:
> This patch addresses a potential race condition for a DMABUF MR that can
> result in a CQE with an error on the UMR QP.
> 
> During the __mlx5_ib_dereg_mr() flow, the following sequence of calls
> occurs:
> mlx5_revoke_mr()
> mlx5r_umr_revoke_mr()
> mlx5r_umr_post_send_wait()
> At this point, the lkey is freed from the hardware's perspective.
> 
> [...]

Applied, thanks!

[1/1] RDMA/mlx5: Fix a race for DMABUF MR which can lead to CQE with error
      https://git.kernel.org/rdma/rdma/c/cc668a11e6ac8a

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


