Return-Path: <linux-rdma+bounces-5734-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66DF89BAE72
	for <lists+linux-rdma@lfdr.de>; Mon,  4 Nov 2024 09:47:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98DE61C21704
	for <lists+linux-rdma@lfdr.de>; Mon,  4 Nov 2024 08:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CC421ABEAC;
	Mon,  4 Nov 2024 08:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="efFrL0lH"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AAC5BA34
	for <linux-rdma@vger.kernel.org>; Mon,  4 Nov 2024 08:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730710018; cv=none; b=RjsFEM3OB/2JoTIhKn4hqM3nVqTqO3HY5n1zLR5j//TKX3UfJKmSsuaV2/3JMoMVCEXoHSamykL+yFGHBsACKZdeK3496YtASCKnBP5D41C9+R0UbQHcw5L+ZCmCXS7hSyFgxai+HnjZBK8YUhEsBlkEtM6PDiynxGAOiekOcZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730710018; c=relaxed/simple;
	bh=xLP8+ffyZB9247DF3k+meKWzbjTD9X7Y5umgUm8UFws=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ODqyQ/qg++5WAxncAZk8o4ZzwCXT25n9ZTCb69QkN5UWDc7mGgLHxiniluv54/SjSvJcOPdC0ACg0arWs4oevvgfzguPnNulUv4q+yUXwtQRLo7BBohd/dItoZ2C72DWHssjVxln06IyD0QeKsWKj5qwnd98UW8HOA2UNpLVuR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=efFrL0lH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BE02C4CECE;
	Mon,  4 Nov 2024 08:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730710017;
	bh=xLP8+ffyZB9247DF3k+meKWzbjTD9X7Y5umgUm8UFws=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=efFrL0lHX+6Yy/3nqftmbErpU8QVXVQ0e8b+CzZXDaMbN2GxfnOSYhbPfeWG4wF96
	 5lInnCVKu0Gh+D4cZ/nOArZx9y/chNnV0GDn/tF/KRCmDyDSVaPmGbC7xpJiaUcz5h
	 fQgS4IK91rDfehkWLFF0/tzpXGNGYvoqSA6O8hy6Wr8A+TlLw8OJoaigvsM2DypL4v
	 AhZaSSmim4GRe9NyqUvMBpftUPfHglo3/DCaKD605QDSVGorquQX+okIgImhMm8Aux
	 OtCqtpDZXFMnpWKkTLGPtvGRnH4pJ3pN1U7Xd3UQuFIlV9TIMpEGjI/VFasJEi8IvU
	 UTW6AW6MulPeg==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
Cc: Chiara Meiohas <cmeiohas@nvidia.com>, linux-rdma@vger.kernel.org
In-Reply-To: <093c978ef2766fd3ab4ff8798eeb68f2f11582f6.1730367038.git.leon@kernel.org>
References: <093c978ef2766fd3ab4ff8798eeb68f2f11582f6.1730367038.git.leon@kernel.org>
Subject: Re: [PATCH rdma-next] RDMA/nldev: Add IB device and net device
 rename events
Message-Id: <173071001480.156548.6028774385344679687.b4-ty@kernel.org>
Date: Mon, 04 Nov 2024 03:46:54 -0500
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Thu, 31 Oct 2024 11:31:14 +0200, Leon Romanovsky wrote:
> Implement event sending for IB device rename and IB device
> port associated netdevice rename.
> 
> In iproute2, rdma monitor displays the IB device name, port
> and the netdevice name when displaying event info. Since
> users can modiy these names, we track and notify on renaming
> events.
> 
> [...]

Applied, thanks!

[1/1] RDMA/nldev: Add IB device and net device rename events
      https://git.kernel.org/rdma/rdma/c/d6eed30e43be23

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


