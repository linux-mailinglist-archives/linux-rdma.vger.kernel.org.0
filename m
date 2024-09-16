Return-Path: <linux-rdma+bounces-4975-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8713C97A6C9
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Sep 2024 19:29:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1F741C265D5
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Sep 2024 17:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64DDA15B0FF;
	Mon, 16 Sep 2024 17:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UtNuGfBi"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 206A6157A59;
	Mon, 16 Sep 2024 17:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726507739; cv=none; b=fNQ1yRywO+QH8CaEhHKhY8vbkXUd0LZLp4f5cZg6JiAfHMyXwoPsXjLhjTEFJqv40zjyjAt6nC9mpp660pkk5WkHX8MzOz/tYqL2k1XSv0If4h1QYpFAwcVQjbq7067ppdKLrUkcZKQOKk3g0hB9yAVL15XoUWsZUHUrYYPdNTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726507739; c=relaxed/simple;
	bh=7ewgDKv3cUGK89J2yYCksoB1SygrxZKYrWplNWob5yc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=dj/wqZvHdd5uX4RcOhWwzUUSaqryAvgjCrMp4/9U+bHPZt0fAcslADHzgVbZO4v++duko/6mR0bg4ryIjKe5QZrhA1rJK7cUzE01w97ymPOSIRuge4q1YlxgRd5Ghgz/nd400B/Wd90h3D3v3mmVOVy0ZrdM1zEfRdtmFi64rEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UtNuGfBi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 841B1C4CEC4;
	Mon, 16 Sep 2024 17:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726507739;
	bh=7ewgDKv3cUGK89J2yYCksoB1SygrxZKYrWplNWob5yc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=UtNuGfBi0c7jGY7nd4a2YHZyAcML5BV6WF5U2zXGx4F+3Ig4//SnCkBv7wl3JiSDC
	 /XLMm9UGmtVAFC15CL4LWOx8n4iY7Vob7TILFeJlfa/vRXsUnA+G+ycBrIaruSHvHZ
	 d6UBMUMxftqCGVo1IOCo8BM8ib4h7Ykb9tqCr2g0UJYLWn6QXJvM53OvyiyhJXRH0F
	 oKXGwbLV3B2xgclzl/gIEFdckxQMPMu63BeLFzlaWe9c22uE7wEXgYYFvcaanBRtk7
	 K7/jL6c7c0AYxzTc9cVMKqeWQKNjGP+ipmIo2Xd3t3sDOI/yhZOWfwHs+xswYPDnRM
	 DfFO5F5tYOHEQ==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>, Nathan Chancellor <nathan@kernel.org>
Cc: Chiara Meiohas <cmeiohas@nvidia.com>, 
 Michael Guralnik <michaelgur@nvidia.com>, linux-rdma@vger.kernel.org, 
 llvm@lists.linux.dev, patches@lists.linux.dev
In-Reply-To: <20240916-rdma-fix-clang-fallthrough-nl_notify_err_msg-v1-1-89de6a7423f1@kernel.org>
References: <20240916-rdma-fix-clang-fallthrough-nl_notify_err_msg-v1-1-89de6a7423f1@kernel.org>
Subject: Re: [PATCH] RDMA/nldev: Add missing break in
 rdma_nl_notify_err_msg()
Message-Id: <172650773549.4797.15102898598079197251.b4-ty@kernel.org>
Date: Mon, 16 Sep 2024 20:28:55 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Mon, 16 Sep 2024 06:24:34 -0700, Nathan Chancellor wrote:
> Clang warns (or errors with CONFIG_WERROR=y):
> 
>   drivers/infiniband/core/nldev.c:2795:2: error: unannotated fall-through between switch labels [-Werror,-Wimplicit-fallthrough]
>    2795 |         default:
>         |         ^
> 
> Clang is a little more pedantic than GCC, which does not warn when
> falling through to a case that is just break or return. Clang's version
> is more in line with the kernel's own stance in deprecated.rst, which
> states that all switch/case blocks must end in either break,
> fallthrough, continue, goto, or return. Add the missing break to silence
> the warning.
> 
> [...]

Applied, thanks!

[1/1] RDMA/nldev: Add missing break in rdma_nl_notify_err_msg()
      https://git.kernel.org/rdma/rdma/c/7acad3c442df6d

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


