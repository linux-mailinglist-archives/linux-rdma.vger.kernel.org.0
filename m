Return-Path: <linux-rdma+bounces-11255-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 573A9AD6C1A
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Jun 2025 11:27:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F9813AFAD3
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Jun 2025 09:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 161DE22A804;
	Thu, 12 Jun 2025 09:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fRriv/CX"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2AB222A1EF
	for <linux-rdma@vger.kernel.org>; Thu, 12 Jun 2025 09:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749720464; cv=none; b=V2yco3ihDpYeG7EbMpZS4k9NbsBpSQ/uguLVHNhIB3KnM6KWRtbpBaJrckwL+zy/cUUyP+/lWJKMGInfft2lJ1aKxP3GhzyKgpKbZOn3XP0APMrl7cQHVBDmF8KCF15/qPi8iTW2tNcIV30/4hQxbWRu9Hs2hE/cDVD+EBp8DUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749720464; c=relaxed/simple;
	bh=CSBd8jdfVzC+eUgV8H/B0h/s8espbsdVMeZR4Qy5HwA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=A/7M/s4Ch5i03V0LJ9TBmR+j5BIWRlqjPDOVFBjet5VxuYUmKl2FbVEWKtdMjJrjVpt2ct8tJQ36IZRSU7w/79Widpt8PCRCAgZEKVSSp4hNoynjqVBrfQp1jaJiL1uoTw9wBFnGiUjqKdPUh09olj1n0G2kl+s2ffvJNBPmIjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fRriv/CX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF590C4CEEE;
	Thu, 12 Jun 2025 09:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749720464;
	bh=CSBd8jdfVzC+eUgV8H/B0h/s8espbsdVMeZR4Qy5HwA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=fRriv/CXNz6oUDV59rb+AAfWBk2mrth7p/smRvJUWOyhvjRNNMrF3qAKZrL4AAK9n
	 8cmaC4L/dCvsLM4V6ZhqOlv/lvoDWihnyumbOOxvl50Ik3G9Nph7zEZQoGXT/XbsFb
	 ZuaKuyUEwTPrhzR/l6zaPkL04Anj+b+Qdi9iWzN3/X8BRfZQGj0cEq2nY4/BoyiNvz
	 Fj6D3p4ufKFip8BGNOwUZzTs4iSGz50Wrpuz/kP39KQav3F2l7j+6oFt3utwWQaZvh
	 g8mrwxUEvQIaRUDqnOtKyNLbRQxsue3qSzKziBmhT/4BMYQN7DNE1f9xoMW9bOuyex
	 +jEGJTtR0Vu2g==
From: Leon Romanovsky <leon@kernel.org>
To: linux-rdma@vger.kernel.org, jgg@ziepe.ca, zyjzyj2000@gmail.com, 
 Daisuke Matsuda <dskmtsd@gmail.com>
Cc: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20250611162758.10000-1-dskmtsd@gmail.com>
References: <20250611162758.10000-1-dskmtsd@gmail.com>
Subject: Re: [PATCH for-next v3] RDMA/rxe: Remove redundant page presence
 check
Message-Id: <174972046104.3922281.15201599027070691237.b4-ty@kernel.org>
Date: Thu, 12 Jun 2025 05:27:41 -0400
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Wed, 11 Jun 2025 16:27:58 +0000, Daisuke Matsuda wrote:
> hmm_pfn_to_page() does not return NULL. ib_umem_odp_map_dma_and_lock()
> should return an error in case the target pages cannot be mapped until
> timeout, so these checks can safely be removed.
> 
> Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> Signed-off-by: Daisuke Matsuda <dskmtsd@gmail.com>
> 
> [...]

Applied, thanks!

[1/1] RDMA/rxe: Remove redundant page presence check
      https://git.kernel.org/rdma/rdma/c/d629cf6ce09a0c

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


