Return-Path: <linux-rdma+bounces-1905-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A68778A1387
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Apr 2024 13:48:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60E9C28B1A4
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Apr 2024 11:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25B0614C5B5;
	Thu, 11 Apr 2024 11:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J/6odvY8"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB18614B088
	for <linux-rdma@vger.kernel.org>; Thu, 11 Apr 2024 11:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712836070; cv=none; b=Z7KKln86LRcPuy0NR9O0ll2ow8xR0Zas19t9KdJXf0CcrFEUeZkOGtDeNEZfn8UUFlDLqhIT+a+gqrfFipCbSe+rdtJT0hq52gpEOPiqIxwhsvHCsTLdle4EbSdwHeOhgPxj4H0F1kMk0nSP60Hmd4zAgVdCJT5DCXjpcb6kbzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712836070; c=relaxed/simple;
	bh=K921edKts/HiYXWL01eCo1PV4BxxDRSv3ovKo0ycnX0=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=PLQkxHVNi0ILIY2KpUG/mDJKq8IuPRY7Bk1XaXYldYEzEcmqMFP0OChlMmYtEXJbp6zCLtQ5X2fH5NRWb6dA68wds6rCoR5eBf4i4uNyZDzBgaAqcYCKK8/r/JKA0PwXFVOAuvDSjqhLOOImO4teDe1QwalW2UTctjy65GXuZpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J/6odvY8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB8B7C433F1;
	Thu, 11 Apr 2024 11:47:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712836070;
	bh=K921edKts/HiYXWL01eCo1PV4BxxDRSv3ovKo0ycnX0=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=J/6odvY8LxPClAGwnKIYXaDtTWMtolweh0L9d5B4sVxOz7UGyjGRRr75BzzaBAksc
	 2cA02SMUwrwKSPEBV+nnYwKqpeNb83BkycRmeUMNYwKLa5DpVXqnHE6Ms6cv83J4n2
	 a38/Z2ptAbSC/4YWoLdsdN/w21TepVWHNsd1wNrQ0/+a/Td2P0a+deXeQeixYtPD4g
	 +474AwUcnVpM/mRTid+AUeJGVZXNl3oei4hfQdPAZjkOGIhPWXU8P1pmUyTFNwx81G
	 ENCIP9XWvOQp/rKs6DVoyzHrN2o+BmotfrEUIDqGL2lyW5fVZqxaEEBYz1f/S71+1u
	 CeJnE3f2CmxQg==
From: Leon Romanovsky <leon@kernel.org>
To: zyjzyj2000@gmail.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org, 
 Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20240408142142.792413-1-yanjun.zhu@linux.dev>
References: <20240408142142.792413-1-yanjun.zhu@linux.dev>
Subject: Re: [PATCH 1/1] RDMA/rxe: Return the correct errno
Message-Id: <171283606600.706662.5746945868707859451.b4-ty@kernel.org>
Date: Thu, 11 Apr 2024 14:47:46 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev


On Mon, 08 Apr 2024 16:21:42 +0200, Zhu Yanjun wrote:
> In the function __rxe_add_to_pool, the function xa_alloc_cyclic is
> called. The return value of the function xa_alloc_cyclic is as below:
> "
>  Return: 0 if the allocation succeeded without wrapping.  1 if the
>  allocation succeeded after wrapping, -ENOMEM if memory could not be
>  allocated or -EBUSY if there are no free entries in @limit.
> "
> But now the function __rxe_add_to_pool only returns -EINVAL. All the
> returned error value should be returned to the caller.
> 
> [...]

Applied, thanks!

[1/1] RDMA/rxe: Return the correct errno
      https://git.kernel.org/rdma/rdma/c/dfcdb38b21e4fb

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


