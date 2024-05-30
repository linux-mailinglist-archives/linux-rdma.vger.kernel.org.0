Return-Path: <linux-rdma+bounces-2695-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14FC08D4DED
	for <lists+linux-rdma@lfdr.de>; Thu, 30 May 2024 16:27:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD7631F239EC
	for <lists+linux-rdma@lfdr.de>; Thu, 30 May 2024 14:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1101817FAAF;
	Thu, 30 May 2024 14:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Md39lJSO"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7DDA17C207;
	Thu, 30 May 2024 14:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717079166; cv=none; b=dWEem0N0/5cAqtbS2qc+EplVOAEBNWVZqQzA4VSSwB3fRoiemjFbj+vNLSazp2/Qx6IVA/8OHD2QIYRsddVRk5mKC1hWTb/zQ4ruI5ODr2aRsbNDDyOJ7qp57/269K+vpGyEnkuJl81ho5W+7mb03B/Yr1X5YW2h8mHr50jwgLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717079166; c=relaxed/simple;
	bh=9jEmmMWKymF600ZOGE1JLvVfVJUEbG47TASDJMM3Gu4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=O9Vkm067rGEo2zWpnfcadm/F8CgeJKq/ZX7fVxSwCQCI9U//ng70fe6+oIM4++DR6s65VrfWmqUs9TCvDtD5E2mybPPMQ+p02hyHvq1EurCUZZhmxxvmI5lLDaSh2HL75tv6m+2mp9Mx4uMKsb48VrdFPpbu5epYyE+mQVWQMFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Md39lJSO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0339C2BBFC;
	Thu, 30 May 2024 14:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717079166;
	bh=9jEmmMWKymF600ZOGE1JLvVfVJUEbG47TASDJMM3Gu4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Md39lJSO6r/L4WHfGyyQsYRVVu+zeqdAkCRU/NsvNxSx/8Q41fUW+GERxfFMMCHKi
	 YNAKlYPmCeWFB7y0xoZl7CrLmF7WusbvUq5xo0hKPWZQll5safEBkKn/HIMaOr3EGx
	 mW26hO0bG3gB4E88C68RHkyc/49W3ISiPwzYPpgivLo9sijDUlxjxo1ENf0gY/tWmV
	 UQ/li0/IbIc8/gxz9ZyRQ8lYtfonc8DJ7md4Y/0nSvmeqXRtAswcK9fvuaOnk50oLN
	 3Sn/QHq1fPIOHFpb+i1GV+Jp9UkqkXXz7FGrKYXtngdIg/PoKUr+omE/EiJsSVJ8NE
	 PltfNWcAkizmA==
From: Leon Romanovsky <leon@kernel.org>
To: Mustafa Ismail <mustafa.ismail@intel.com>, 
 Shiraz Saleem <shiraz.saleem@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
 Kees Cook <keescook@chromium.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, 
 linux-rdma@vger.kernel.org, linux-hardening@vger.kernel.org
In-Reply-To: <2ca8b14adf79c4795d7aa95bbfc79253a6bfed82.1716102112.git.christophe.jaillet@wanadoo.fr>
References: <2ca8b14adf79c4795d7aa95bbfc79253a6bfed82.1716102112.git.christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH] RDMA/irdma: Annotate flexible array with
 __counted_by() in struct irdma_qvlist_info
Message-Id: <171707136517.115496.4990483419081659486.b4-ty@kernel.org>
Date: Thu, 30 May 2024 15:16:05 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev


On Sun, 19 May 2024 09:02:15 +0200, Christophe JAILLET wrote:
> 'num_vectors' is used to count the number of elements in the 'qv_info'
> flexible array in "struct irdma_qvlist_info".
> 
> So annotate it with __counted_by() to make it explicit and enable some
> additional checks.
> 
> This allocation is done in irdma_save_msix_info().
> 
> [...]

Applied, thanks!

[1/1] RDMA/irdma: Annotate flexible array with __counted_by() in struct irdma_qvlist_info
      https://git.kernel.org/rdma/rdma/c/38c02d813aa321

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


