Return-Path: <linux-rdma+bounces-388-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 105ED80E624
	for <lists+linux-rdma@lfdr.de>; Tue, 12 Dec 2023 09:29:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC51F1F21910
	for <lists+linux-rdma@lfdr.de>; Tue, 12 Dec 2023 08:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1B9118AEF;
	Tue, 12 Dec 2023 08:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VPIgkCUS"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C77182A8
	for <linux-rdma@vger.kernel.org>; Tue, 12 Dec 2023 08:29:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FFA5C433C8;
	Tue, 12 Dec 2023 08:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702369776;
	bh=vHjfn2BQPRZ2rrdN6+fIB1WMP3nGWTkfEKZYxRvs6o4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=VPIgkCUSlJYWd6EVmfo6CLJ+RAW4I6rMQ63h0+7bn6w8odIKL6IGWMS1IPu45J4mP
	 1m9xCm+QNxHv0FgqxP6yt7IT9BtwAeO4jTPvJTeuCDs4ayynDv7Ih0I8ao1NK4mafj
	 zlIYlhTCNcYwbbSGPgMxxmvlaAw97EZoUuJm1VP9tGVR9jop623EVxNan9brDU7ELw
	 73PxTLrjmeUuo+H+FJavHK+prWM2vWZM6HwQt8PTtwnCVkozOhM/BNOV42QSJ2AmhN
	 cv4tLpaPx/61xDuxl16//iMww+UqGJuKsIbUISVQAS+9mIyiNoWm1SujwD5TrwV4qU
	 SQonCo9AFgZ4g==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>, Daniel Vacek <neelx@redhat.com>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231211130426.1500427-1-neelx@redhat.com>
References: <20231211130426.1500427-1-neelx@redhat.com>
Subject: Re: [PATCH 0/2] IB/ipoib fixes
Message-Id: <170236977177.265346.10129245400198931968.b4-ty@kernel.org>
Date: Tue, 12 Dec 2023 10:29:31 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-a055d


On Mon, 11 Dec 2023 14:04:23 +0100, Daniel Vacek wrote:
> The first patch (hopefully) fixes a real issue while the second is an
> unrelated cleanup. But it shares a context so sending as a series.
> 
> Daniel Vacek (2):
>   IB/ipoib: Fix mcast list locking
>   IB/ipoib: Clean up redundant netif_addr_lock
> 
> [...]

Applied, thanks!

[1/1] IB/ipoib: Fix mcast list locking
      https://git.kernel.org/rdma/rdma/c/4f973e211b3b1c

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>

