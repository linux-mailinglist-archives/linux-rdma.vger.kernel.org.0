Return-Path: <linux-rdma+bounces-11627-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B7A5AE80BC
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Jun 2025 13:15:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7C9B1791A5
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Jun 2025 11:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC6D12D321A;
	Wed, 25 Jun 2025 11:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OBgDXICU"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7323E2BF009;
	Wed, 25 Jun 2025 11:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750850085; cv=none; b=LVoe+q7FQhzs1M8w8vraqiQixQwgJVTXUpxCh9mEB/2hgQpUw55l4NSJceZmQl3F5UVJlh2u1ihvAH3/XXeRpynwE+4R3xRL17H6NN31Xwu2MWKWmUU0Cjzt0oivxPSmbjm6gHZtWqb+sHwIBv4S84Dhu6BI3GINEukuxCZI6dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750850085; c=relaxed/simple;
	bh=LEf3scgWM8D2DC2IyWffDgVkoeaYoLwiJWBONY7kkTw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=hobRI+S5FyVM+TxwrICeXjDEvk/gx14ItSeIKwFMmXZ5ZFGg6N0d41Y3IJLRpdXgfozKaHLHH+It7ZfWCfcrNmDVEMbIB3AOu4xFOcTtUp8WDqjlfQdsqzusjiU5RQR2aAQb9RT6dx6qRGf4AVXh7fVZ4it7+gZfKeQM6CktocQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OBgDXICU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 539DBC4CEEF;
	Wed, 25 Jun 2025 11:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750850084;
	bh=LEf3scgWM8D2DC2IyWffDgVkoeaYoLwiJWBONY7kkTw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=OBgDXICUoc93HD17zL89gISojCojniKzH9sdpv+kbmMQ1MFYjvOiteW3dXeVrbWr5
	 A+U0J4kvoDMLxbl+dC0zGGaQYlqsPh+ASwWl/lYv+6puECBDFWBUzM7UVcYPvd3rZW
	 I3aqqRdZSktWTpP4Up5fBRo5q9KDp1DHdiKJ3I5kvTPRdBfhw05cu73/Rq4oJNPcTi
	 Z1QNjbDw4kYDkXPAbWpqP46nvUJzAOBWteMvyWCuYSYc15hdhe5TCSeNCVBG2jC8B6
	 48LwPYRgd5Asf1/G8xbMNCC5lCIsZnAcXOiLUa538DlMFVz2jelDU9QKrKQkkKrJXo
	 2MZEgFGI6JlCA==
From: Leon Romanovsky <leon@kernel.org>
To: Bernard Metzler <bmt@zurich.ibm.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
 Nathan Chancellor <nathan@kernel.org>, Arnd Bergmann <arnd@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 Potnuri Bharat Teja <bharat@chelsio.com>, Showrya M N <showrya@chelsio.com>, 
 Eric Biggers <ebiggers@google.com>, linux-rdma@vger.kernel.org, 
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev
In-Reply-To: <20250620114332.4072051-1-arnd@kernel.org>
References: <20250620114332.4072051-1-arnd@kernel.org>
Subject: Re: [PATCH] RDMA/siw: work around clang stack size warning
Message-Id: <175085008000.620753.10902476513418461854.b4-ty@kernel.org>
Date: Wed, 25 Jun 2025 07:14:40 -0400
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Fri, 20 Jun 2025 13:43:28 +0200, Arnd Bergmann wrote:
> clang inlines a lot of functions into siw_qp_sq_process(), with the
> aggregate stack frame blowing the warning limit in some configurations:
> 
> drivers/infiniband/sw/siw/siw_qp_tx.c:1014:5: error: stack frame size (1544) exceeds limit (1280) in 'siw_qp_sq_process' [-Werror,-Wframe-larger-than]
> 
> The real problem here is the array of kvec structures in siw_tx_hdt that
> makes up the majority of the consumed stack space.
> 
> [...]

Applied, thanks!

[1/1] RDMA/siw: work around clang stack size warning
      https://git.kernel.org/rdma/rdma/c/842cf5a6e35656

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


