Return-Path: <linux-rdma+bounces-1194-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BFDA886F52C
	for <lists+linux-rdma@lfdr.de>; Sun,  3 Mar 2024 14:42:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41E731F213EE
	for <lists+linux-rdma@lfdr.de>; Sun,  3 Mar 2024 13:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4247759B4E;
	Sun,  3 Mar 2024 13:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AVromr9A"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF75B58212;
	Sun,  3 Mar 2024 13:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709473314; cv=none; b=mUh7Bv6l8SayoNzkaXHsEDIDl5ReueKOCQnE1y6hOGW8Bd/RoK/HZRJ8Az2c0NB5XeXUyW/JdCrqIXuF4O7/9LgZVVetaQYnccqzXc9ejsHNVuQDnvsRf7nO3w6mzk/1wc3BakxMbtn4RXnnX5Dr9hQwTJBn7jML0QIg/VTHWCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709473314; c=relaxed/simple;
	bh=/LKK/gSvDJcHii+LVnHZWh4p11aKw93bUXQ3iuGv9zQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=WtsUEMOTN5DMnOpErkSF8XpuwVW2tnFE71MZpJFUc9H1XmwiPzV2Uni0O9MZPBQkCvvuaWufYPogjDFyj79AdgYeS5goJwPnBIdzQkT7guKu1hLTw1pVlB8NalhyTqbKYCMB+Wty57l/tMWEoauh1xOPHNZ7XHat41C5V34F8P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AVromr9A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1455C433F1;
	Sun,  3 Mar 2024 13:41:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709473313;
	bh=/LKK/gSvDJcHii+LVnHZWh4p11aKw93bUXQ3iuGv9zQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=AVromr9AMGyhj+dSFI14InpyvyGVbtwDGr0IJuwaB6u8c7LhbyePuwStKyqLwqW7I
	 T0EW5OmAF3ZJ2B7iDB8BfIdGLnBaR0b5JwkNVpXASrx8S/kwRZu6IYbEYTbW+UGLf0
	 IfjvJlt6ma8Nr2QxJEsKos7gMVF0vhNLUNVSHG+aP0De3bmRdBYciCGXXQXBXOkWwl
	 sqFKJDpPTmVZaAKq+DSjABefp00LL70juMKXQCsS3PN4+6ka98zrBzvhPSjIScTOUa
	 V0AbGBLlBD+4Lqp0fnFGqV0D6p7YWrQ2Ds3ej0PJDbCILmF2O3XosMVCYD8vR7eLtI
	 YHXWxdUD0uEhA==
From: Leon Romanovsky <leon@kernel.org>
To:
 Jason Gunthorpe <jgg@ziepe.ca>, "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org, Kees Cook <keescook@chromium.org>
In-Reply-To: <ZeIgeZ5Sb0IZTOyt@neat>
References: <ZeIgeZ5Sb0IZTOyt@neat>
Subject:
 Re: [PATCH][next] RDMA/uverbs: Avoid -Wflex-array-member-not-at-end warnings
Message-Id: <170947330942.248794.6765878456401516827.b4-ty@kernel.org>
Date: Sun, 03 Mar 2024 15:41:49 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-a055d


On Fri, 01 Mar 2024 12:37:45 -0600, Gustavo A. R. Silva wrote:
> -Wflex-array-member-not-at-end is coming in GCC-14, and we are getting
> ready to enable it globally.
> 
> There are currently a couple of objects (`alloc_head` and `bundle`) in
> `struct bundle_priv` that contain a couple of flexible structures:
> 
> struct bundle_priv {
>         /* Must be first */
>         struct bundle_alloc_head alloc_head;
> 
> [...]

Applied, thanks!

[1/1] RDMA/uverbs: Avoid -Wflex-array-member-not-at-end warnings
      https://git.kernel.org/rdma/rdma/c/155f04366e3cad

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>

