Return-Path: <linux-rdma+bounces-9651-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ADB08A955D7
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Apr 2025 20:21:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F1CC188F5B3
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Apr 2025 18:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8B461E5B83;
	Mon, 21 Apr 2025 18:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BqAvUn3q"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978E01E5729
	for <linux-rdma@vger.kernel.org>; Mon, 21 Apr 2025 18:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745259677; cv=none; b=n4cMLBO6mxXW3TvoWtwsCw/Y+8ex8RC0Izu7gnKTJWQly6duh24Jt/KiwvzAiqUHcAIVlvgijahrH2y0A9hMIWpFuD9cMpZIDpysBe7ExU6Yco63ylGNs6dK914dUbrJiATf8Kq3dLEa70TsmoQCgDUlxor4DfBXalLPFVXpJ20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745259677; c=relaxed/simple;
	bh=1f8uYyOoTcQj4gbrty0YoZr8it2hQ2ARZmae+NGXQ48=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=tG4ySuPO6SnyMnjXH9iRIo9tpwcqHjs+B83gW8YgD7MwjhLY9KFMS2I0Um1qMBqldLu5hxqVWVhLVUPCkINlkVSkpuOiKxRfLKObYabQoAYKmVIYnAE1thfRYGpiCX8xwagIaFP92WKoC3ivNXsPtJRh+s1SYZEJBVd3wOWIxo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BqAvUn3q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C8D8C4CEE4;
	Mon, 21 Apr 2025 18:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745259676;
	bh=1f8uYyOoTcQj4gbrty0YoZr8it2hQ2ARZmae+NGXQ48=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=BqAvUn3qrJpWPBLMoQ7TVqRTRHP7lAu4mDE9z6pBDUFG/tKtcLpJ0zB7LdwCu6J86
	 LLv0+6hTTE11SZg6+iswNbbnrbJ66/rTeSdgO8OYdb9LC/fv76pG+/jZiJGsX/m6hK
	 ei83Os/E0T3mzcJEYAOS2fXaRNlBOwIpHVFQPPF8IBc8UUjgWYBNH8Wjbh+c6Upnve
	 LNjiz3GeOvz4wnx+HlYMGIfHu0sUCA3g539zCD+KGBnJaCtNluBhsmiTYLYI3l4xNF
	 dOIBd6CgPBGNE4Sny34ml0iHEmDWLPuaK3RUoSC0MOwCIFMleVPZKypW4zbnRr7X5w
	 juU2/Dw6mImIg==
From: Leon Romanovsky <leon@kernel.org>
To: jgg@ziepe.ca, Junxian Huang <huangjunxian6@hisilicon.com>
Cc: linux-rdma@vger.kernel.org, linuxarm@huawei.com, 
 tangchengchang@huawei.com
In-Reply-To: <20250421132750.1363348-1-huangjunxian6@hisilicon.com>
References: <20250421132750.1363348-1-huangjunxian6@hisilicon.com>
Subject: Re: [PATCH v2 for-next 0/6] RDMA/hns: Add trace support
Message-Id: <174525967272.140063.10385292481504861063.b4-ty@kernel.org>
Date: Mon, 21 Apr 2025 14:21:12 -0400
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Mon, 21 Apr 2025 21:27:44 +0800, Junxian Huang wrote:
> Add trace support for hns. Set tracepoints for flushe CQE, WQE,
> AEQE, MT/MTR and CMDQ.
> 
> Patch #5 fixes the dependency issue of hns_roce_hw_v2.h on hnae3.h,
> otherwise there will be a compilation error when hns_roce_hw_v2.h
> is included in hns_roce_trace.h in patch #6.
> 
> [...]

Applied, thanks!

[1/6] RDMA/hns: Add trace for flush CQE
      https://git.kernel.org/rdma/rdma/c/02007e3ddc0790
[2/6] RDMA/hns: Add trace for WQE dumping
      https://git.kernel.org/rdma/rdma/c/6c98c86708063a
[3/6] RDMA/hns: Add trace for AEQE dumping
      https://git.kernel.org/rdma/rdma/c/1e63e2f96613bc
[4/6] RDMA/hns: Add trace for MR/MTR attribute dumping
      https://git.kernel.org/rdma/rdma/c/48ffc152576d63
[5/6] RDMA/hns: Include hnae3.h in hns_roce_hw_v2.h
      https://git.kernel.org/rdma/rdma/c/2b11d33de23262
[6/6] RDMA/hns: Add trace for CMDQ dumping
      https://git.kernel.org/rdma/rdma/c/6bd18dabf1c946

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


