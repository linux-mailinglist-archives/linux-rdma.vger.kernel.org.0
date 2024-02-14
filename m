Return-Path: <linux-rdma+bounces-1020-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AD53854517
	for <lists+linux-rdma@lfdr.de>; Wed, 14 Feb 2024 10:25:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9F7D2894C4
	for <lists+linux-rdma@lfdr.de>; Wed, 14 Feb 2024 09:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8A1A12E76;
	Wed, 14 Feb 2024 09:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mq1OhSPa"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56FF912E5C;
	Wed, 14 Feb 2024 09:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707902694; cv=none; b=MjUOebmbb0QfLzVmSudJFHsTTBswz31+yRbWz6g7fWbBxrSgcmzLIeEv3T79cL/O3uGNTWCKBWO+BeGfq6mGRTpPJadq+OPRnmeEUYIWeazmgAA+cFhMgoOGVwr6/Ug8Uj6uztzmEbjBYvifOcrns1k04y6HKK50ATIAPc9+NUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707902694; c=relaxed/simple;
	bh=f4Z4RZ8eKIicm12fqu8YuFsWnQnhPjcSmdnQR9J9hG8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=IHI2vQqxEs1Ckb+15K9B75lwuiw8/eP5/J0tEgxxpqtfgo1Tsf+P0KqGSj38WFfRTEdabqNYKmAGajY0GqxxjOM+LArnUaAtAun6hNJz3hOwwAcHABJ4NI6fyhGxG31uIQZWn2TtavZom87wgrWGlZ6PWbgFQPh8Z1lyo205R/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mq1OhSPa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EA5AC43390;
	Wed, 14 Feb 2024 09:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707902693;
	bh=f4Z4RZ8eKIicm12fqu8YuFsWnQnhPjcSmdnQR9J9hG8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Mq1OhSPaNxW05TOwj2nw4C31w47AUtJa9u1C5fXAwvQm64FrO2wDB1Ed4zNNdYtY/
	 JR/e3PM5qCsZ3uNQyLPmj5K11H1vU2SCxxwYDfkSX/nslwUIPReKatBeoujpVun+ZR
	 4rH3FAqbvJDT7noLse+pN2o1ks/vEfTNkQcVOYcc5813/1L/Asj9RJmIuKrosQrFjp
	 K3frkH6Wx7yivwgWEh/7t0MGU7m85RG9RsVSuHpN1MbwcJqt2/yweM7YjaVwP/BkLn
	 2zc/W7fyCVyqPUakdQemePRgklIzOZz/kaRf++/9u40M7Rj7uo0j3KYIlsATciXb0r
	 jvqs5jm4Mf6Zg==
From: Leon Romanovsky <leon@kernel.org>
To: Bart Van Assche <bvanassche@acm.org>, Arnd Bergmann <arnd@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Jason Gunthorpe <jgg@ziepe.ca>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>,
 Justin Stitt <justinstitt@google.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 "Nicholas A. Bellinger" <nab@risingtidesystems.com>,
 linux-rdma@vger.kernel.org, target-devel@vger.kernel.org,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev
In-Reply-To: <20240213100728.458348-1-arnd@kernel.org>
References: <20240213100728.458348-1-arnd@kernel.org>
Subject: Re: [PATCH] RDMA/srpt: fix function pointer cast warnings
Message-Id: <170790268857.386715.10695124519923198536.b4-ty@kernel.org>
Date: Wed, 14 Feb 2024 11:24:48 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-a055d


On Tue, 13 Feb 2024 11:07:13 +0100, Arnd Bergmann wrote:
> clang-16 notices that srpt_qp_event() gets called through an incompatible
> pointer here:
> 
> drivers/infiniband/ulp/srpt/ib_srpt.c:1815:5: error: cast from 'void (*)(struct ib_event *, struct srpt_rdma_ch *)' to 'void (*)(struct ib_event *, void *)' converts to incompatible function type [-Werror,-Wcast-function-type-strict]
>  1815 |                 = (void(*)(struct ib_event *, void*))srpt_qp_event;
> 
> Change srpt_qp_event() to use the correct prototype and adjust the
> argument inside of it.
> 
> [...]

Applied, thanks!

[1/1] RDMA/srpt: fix function pointer cast warnings
      https://git.kernel.org/rdma/rdma/c/eb5c7465c32401

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>

