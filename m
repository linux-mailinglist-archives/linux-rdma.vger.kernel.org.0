Return-Path: <linux-rdma+bounces-11240-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 071A3AD69FD
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Jun 2025 10:10:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 470243A682B
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Jun 2025 08:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED5771DF270;
	Thu, 12 Jun 2025 08:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H+YBBpd5"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E7172617;
	Thu, 12 Jun 2025 08:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749715819; cv=none; b=hcH3kl2cH8EhmWR2pqi/vq8s9mp3XJlGD3TJK/tOQ1m7S1mFSZvTPMkMLCR7B80wuTpgoadHcmI/kgThtjPyZy/rYGiFo3T70WGB+dakPjOol9HE2AIb54yx5Ub/FymYGsvJX2nxAtHtUfcEkK5jhwqhhmr4fhdwrmBUDJnfoaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749715819; c=relaxed/simple;
	bh=R8smtZMz1KfCJkACZnNlGNn06zmQCj/f3RK4UO5qVBo=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=HVpsLHhcXRY/Os3mxH5/YT/2oV42waDnQJwwjmtvgI38vTnh2RxOxTZLHOl4/IJNiTDDwHMctBb57Cfk7z/rxEmKNWo8z+sM0xYCyhCY1Q4x9GCQlnQWcGdd5xRcLbFyB3isuaMuNpJysAq67XtUoASk6Pu13rfy2Ceo7sVNO7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H+YBBpd5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B452FC4CEEA;
	Thu, 12 Jun 2025 08:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749715819;
	bh=R8smtZMz1KfCJkACZnNlGNn06zmQCj/f3RK4UO5qVBo=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=H+YBBpd55qg21iLRh5P7TPfyNSNJJZ1EEZXhUCEpLPScGpZa0u7la724jeshOgCxD
	 KnHUMGFNt0gtdhpVB/e4Ti4SdDV9GhC6HdazGw38xWHoTu6Pc9gpcL6HzpVQhLznuh
	 kU+CupX/b+ct70j8HC/I/eNUvskKJscv/djR3iDMX+mIJnARVErLX62k9ioxwhUPxA
	 H0fk1cgt/kI0zG5rcehyRTgblOxYxs8Yuhe+/xQGA/F8QeHp8KG1phQLRlpqVEdcQh
	 o9g/SCEvXR3oe+KQPnEjGXmvB777CfMlE0TZj4oPl13uikqIBDSCrxvRqHvZ64OAuq
	 2FVsJHwFF6kmA==
From: Leon Romanovsky <leon@kernel.org>
To: linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, jgg@ziepe.ca, 
 zyjzyj2000@gmail.com, Daisuke Matsuda <dskmtsd@gmail.com>
In-Reply-To: <20250522111955.3227-1-dskmtsd@gmail.com>
References: <20250522111955.3227-1-dskmtsd@gmail.com>
Subject: Re: [PATCH for-next v4 0/2] RDMA/rxe: Prefetching pages with
 explicit ODP
Message-Id: <174971581559.3643081.8509512449861509335.b4-ty@kernel.org>
Date: Thu, 12 Jun 2025 04:10:15 -0400
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Thu, 22 May 2025 11:19:53 +0000, Daisuke Matsuda wrote:
> There is ibv_advise_mr(3) that can be used by applications to optimize
> memory access. This series enables the feature on rxe driver, which has
> already been available in mlx5.
> 
> There is a tiny change on the rdma-core util.
> cf. https://github.com/linux-rdma/rdma-core/pull/1605
> 
> [...]

Applied, thanks!

[1/2] RDMA/rxe: Implement synchronous prefetch for ODP MRs
      https://git.kernel.org/rdma/rdma/c/3576b0df1588a0
[2/2] RDMA/rxe: Enable asynchronous prefetch for ODP MRs
      https://git.kernel.org/rdma/rdma/c/9284bc34c77399

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


