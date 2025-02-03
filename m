Return-Path: <linux-rdma+bounces-7352-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C88C9A25847
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Feb 2025 12:37:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7ABB51889A3A
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Feb 2025 11:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA5EF202F90;
	Mon,  3 Feb 2025 11:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jhSgj5UM"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97FD91D618C
	for <linux-rdma@vger.kernel.org>; Mon,  3 Feb 2025 11:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738582632; cv=none; b=B9wnV6YG5FT0hGG6bxv+9VKfOPDjrrE5I033zmSMFQvgKNSzyUBog1Hz9YVxdN65cgeZQcn8C0qyOKU7OhxHZBrWe4KUHtdFEutcuHQfCMh5BZGGnoqCgByIoONTnPq+/SoVfPHaO5dbxDlKUt0XBgBCRzIJoJytPmgZImLSmXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738582632; c=relaxed/simple;
	bh=CJhmk/OdPWeT3yuFovslNUsnxcSiMT8+ZkEFZt/RuP4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=fu/8T/dxuJylRkYOzQvLgvJz7cCtA2af0qaAIHEtfSuGNF056/E2Uie1i8ZkqVUQCM0lZ02me1/Y2Tvsuyea1emjRjtzTXrc0673NjMNdgU4GnfYvTrJ4oBN3QJTA97nQsGhvBTeFn9/Boe9qptszVSwZGpepWEtLTKEV92OF9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jhSgj5UM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8B1EC4CED2;
	Mon,  3 Feb 2025 11:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738582632;
	bh=CJhmk/OdPWeT3yuFovslNUsnxcSiMT8+ZkEFZt/RuP4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=jhSgj5UMzdazW6YaerSh91sdJkZ3bCauaXA4J5GAE9K/NO3/XjUyF76shUGrTwxjN
	 nzh3NpzVdRQ+hTwhC+3+ecYysaUnjjV6NIykvWy/04MyNpHj5VCHws9nOjkuH54srm
	 pTVcZT1y5hSuO/XiJPjzvJ0bA40AM+mfiqEIRNahmRdaYtajuI/ZRL6EY2Nh0KOqDM
	 v0qTy5NNPLeSATuUevgHk1I4fIVg1Tcq9CaRHa+mhMKzMmWE8QcVh8huup5AioAr68
	 BYRAXOY9W3Lo89FTtQhLsM4tQO57MKePc3snC1d6hs3ZkE00vDcHCDIfyad9XAwKpN
	 O/I/fd/P7tjVQ==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
Cc: Yishai Hadas <yishaih@nvidia.com>, Aharon Landau <aharonl@nvidia.com>, 
 linux-rdma@vger.kernel.org, Michael Guralnik <michaelgur@nvidia.com>
In-Reply-To: <27b51b92ec42dfb09d8096fcbd51878f397ce6ec.1737290141.git.leon@kernel.org>
References: <27b51b92ec42dfb09d8096fcbd51878f397ce6ec.1737290141.git.leon@kernel.org>
Subject: Re: [PATCH rdma-next] RDMA/mlx5: Fix the recovery flow of the UMR
 QP
Message-Id: <173858262795.652207.473902353407914479.b4-ty@kernel.org>
Date: Mon, 03 Feb 2025 06:37:07 -0500
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Sun, 19 Jan 2025 14:36:13 +0200, Leon Romanovsky wrote:
> This patch addresses an issue in the recovery flow of the UMR QP,
> ensuring tasks do not get stuck, as highlighted by the call trace [1].
> 
> During recovery, before transitioning the QP to the RESET state, the
> software must wait for all outstanding WRs to complete.
> 
> Failing to do so can cause the firmware to skip sending some flushed
> CQEs with errors and simply discard them upon the RESET, as per the IB
> specification.
> 
> [...]

Applied, thanks!

[1/1] RDMA/mlx5: Fix the recovery flow of the UMR QP
      https://git.kernel.org/rdma/rdma/c/d97505baea64d9

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


