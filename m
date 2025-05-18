Return-Path: <linux-rdma+bounces-10393-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 78E72ABAE85
	for <lists+linux-rdma@lfdr.de>; Sun, 18 May 2025 09:52:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 812BF18999FB
	for <lists+linux-rdma@lfdr.de>; Sun, 18 May 2025 07:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5897C1DE2DC;
	Sun, 18 May 2025 07:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ADkawgIU"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195223C30
	for <linux-rdma@vger.kernel.org>; Sun, 18 May 2025 07:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747554771; cv=none; b=MBLfk4Rdz8t+ZHDvpyyC/llEwFNTYhP9DsjDQpd53tRawBsBn25hhLXDuUt/fSOao/CbDRcOpqbpWgJFgEakZxjV+2v1HM63pMXZiRhSuNwFkkknXfJLa1mzDr/VdK5XMWXdLUL+32v5muQ+nU6hChGMfaZk6+M+QKqekD18VSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747554771; c=relaxed/simple;
	bh=zyCmGMA58DYmRY15PIDqRYhLgJZ88TQ9jOKNYN/e8qo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=TeSMriNUTftObQsdUBV2khfPWAQKgHvXwXJCtVfKxbchju6ir0FjI+roCxeIkpwmiAGbxBvD7SQKzZQIzyUD768eMDloJLzmp32c5OXR7Nikh7dExuQ9QD9O5d3+96WcbDPztwvn7WgM9378s0M0EhrVDtGQzyV7jJ4ROPwHMmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ADkawgIU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03A78C4CEE9;
	Sun, 18 May 2025 07:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747554770;
	bh=zyCmGMA58DYmRY15PIDqRYhLgJZ88TQ9jOKNYN/e8qo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=ADkawgIUksS20TF9ycFmdreqivRiYAsdKojOGTyQGJaDmTuItJk6QpK8vpwEqcf38
	 94sYmyakGTeysut/lQLITxWuBSjgP2Ne/bljRQAzxRLCHIDnOzt2fNHUjbMvwN7n5E
	 Cz9EsUL64f7a1Oy6cC4iXZJVt7cxxRifZ1QzKDrcsoP6iCnfOF3ivB/rcrgO8KVWO/
	 qchGVVic3GDDGLqZwKFqyAszr6eKswVdeZdD06mXr7IUOrHrny29rmIPmSQrT/kAbl
	 MggcK22qCMhl0ilBphkgp5+PUyr1NrUMjmX9Oi8jJEeA7hscyVj77XkfVC9nlU0OKb
	 NasfrkhNtnlDQ==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
Cc: Yishai Hadas <yishaih@nvidia.com>, Fan Li <fanl@nvidia.com>, 
 linux-rdma@vger.kernel.org
In-Reply-To: <feaa84ec6f20468b4935c439923e9266122a93d0.1747134130.git.leon@kernel.org>
References: <feaa84ec6f20468b4935c439923e9266122a93d0.1747134130.git.leon@kernel.org>
Subject: Re: [PATCH rdma-next] RDMA/mlx5: Remove the redundant
 MLX5_IB_STAGE_UAR stage
Message-Id: <174755476739.2823432.10400640835791063013.b4-ty@kernel.org>
Date: Sun, 18 May 2025 03:52:47 -0400
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Tue, 13 May 2025 14:02:40 +0300, Leon Romanovsky wrote:
> The MLX5_IB_STAGE_UAR stage in the RDMA driver is redundant and should
> be removed.
> 
> Responsibility for initializing the device's UAR pointer
> (mdev->priv.uar) lies with mlx5_core, which already sets it during the
> mlx5_load() process.
> 
> [...]

Applied, thanks!

[1/1] RDMA/mlx5: Remove the redundant MLX5_IB_STAGE_UAR stage
      https://git.kernel.org/rdma/rdma/c/972db388d40ded

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


