Return-Path: <linux-rdma+bounces-3425-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DAB19146AC
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Jun 2024 11:51:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE5861C22382
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Jun 2024 09:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1E7B131BDF;
	Mon, 24 Jun 2024 09:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hPInjxVW"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B12DE5380F
	for <linux-rdma@vger.kernel.org>; Mon, 24 Jun 2024 09:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719222665; cv=none; b=AQGKVL/ULd7+d49XvfEqKVzVkUgnLQbxX5PAcZNlvWHzLpyZByi60jtCgG8nmmPz6stMI5UYKJDkfThxoXctaH0seF93s+9mrYwSpqJZjG45Lzo9wAQEeqKsD6hdcfpj9LM0ymppESUiZbOymuHn2bkeXW+hi22f/+IUnV+Js1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719222665; c=relaxed/simple;
	bh=xaH/4J35xbCme9HEGkgjryqWRJEB69jz8NPRTkmWSE8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=IJ2HFpT9P04rL7SLghgxz5jnULMYmHKhKejgpebe4zzzzPEM14rDggNc4GVZhpgOIaeqwYI9LWf6iO17V2ReD4E5LL8D6Xc/3/2r4t9sz7pKvWZQz/4vUuJvtvS0CFtDymSZDf+MVruaMrOfgf5krXpzZO7INbYJY8nnwFzfrJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hPInjxVW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80403C32781;
	Mon, 24 Jun 2024 09:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719222665;
	bh=xaH/4J35xbCme9HEGkgjryqWRJEB69jz8NPRTkmWSE8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=hPInjxVWxfOlvjqKm8Ko163sDt4kwN1vfyT/MJQD5mVp+gn5tuYlbBt5L4SJfXxDK
	 fKutH/NQEQePf1Xk9pXo6ACkjYZ9U4iqTNHTXcvkqyiGwTlIgzIy88BFXL0MIpox+w
	 H0BMlgrfY5dWOpeVb4I667uM9hmNLrV6OPxJMIyLq6wEduyTNmX8vz8UT2fyWRjeKX
	 f9J+zx2HH/HdgjxRuF1GA/xOegdJsVZ3ZuS2nLbKm0+ovH5F2hqLMmFaBwbR5nXcXs
	 pASC4i5OjXveEnFdag9moy9Te3bwFK9Ens3j0eiJMqjO9uJwmUXfngf642SS2OV4MM
	 RsC7SzfI4ZrlA==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
Cc: Jack Morgenstein <jackm@dev.mellanox.co.il>, linux-rdma@vger.kernel.org, 
 Roland Dreier <roland@purestorage.com>, Yishai Hadas <yishaih@nvidia.com>, 
 Leon Romanovsky <leon@kernel.org>
In-Reply-To: <f3798b3ce9a410257d7e1ec7c9e285f1352e256a.1718554569.git.leon@kernel.org>
References: <f3798b3ce9a410257d7e1ec7c9e285f1352e256a.1718554569.git.leon@kernel.org>
Subject: Re: [PATCH rdma-next] RDMA/mlx4: Fix truncated output warning in
 mad.c
Message-Id: <171922266024.231623.17753094558924079919.b4-ty@kernel.org>
Date: Mon, 24 Jun 2024 12:51:00 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev-13183


On Sun, 16 Jun 2024 19:16:33 +0300, Leon Romanovsky wrote:
> Increase size of the name array to avoid truncated output warning.
> 
> drivers/infiniband/hw/mlx4/mad.c: In function ‘mlx4_ib_alloc_demux_ctx’:
> drivers/infiniband/hw/mlx4/mad.c:2197:47: error: ‘%d’ directive output
> may be truncated writing between 1 and 11 bytes into a region of size 4
> [-Werror=format-truncation=]
>  2197 |         snprintf(name, sizeof(name), "mlx4_ibt%d", port);
>       |                                               ^~
> drivers/infiniband/hw/mlx4/mad.c:2197:38: note: directive argument in
> the range [-2147483645, 2147483647]
>  2197 |         snprintf(name, sizeof(name), "mlx4_ibt%d", port);
>       |                                      ^~~~~~~~~~~~
> drivers/infiniband/hw/mlx4/mad.c:2197:9: note: ‘snprintf’ output between
> 10 and 20 bytes into a destination of size 12
>  2197 |         snprintf(name, sizeof(name), "mlx4_ibt%d", port);
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/infiniband/hw/mlx4/mad.c:2205:48: error: ‘%d’ directive output
> may be truncated writing between 1 and 11 bytes into a region of size 3
> [-Werror=format-truncation=]
>  2205 |         snprintf(name, sizeof(name), "mlx4_ibwi%d", port);
>       |                                                ^~
> drivers/infiniband/hw/mlx4/mad.c:2205:38: note: directive argument in
> the range [-2147483645, 2147483647]
>  2205 |         snprintf(name, sizeof(name), "mlx4_ibwi%d", port);
>       |                                      ^~~~~~~~~~~~~
> drivers/infiniband/hw/mlx4/mad.c:2205:9: note: ‘snprintf’ output between
> 11 and 21 bytes into a destination of size 12
>  2205 |         snprintf(name, sizeof(name), "mlx4_ibwi%d", port);
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/infiniband/hw/mlx4/mad.c:2213:48: error: ‘%d’ directive output
> may be truncated writing between 1 and 11 bytes into a region of size 3
> [-Werror=format-truncation=]
>  2213 |         snprintf(name, sizeof(name), "mlx4_ibud%d", port);
>       |                                                ^~
> drivers/infiniband/hw/mlx4/mad.c:2213:38: note: directive argument in
> the range [-2147483645, 2147483647]
>  2213 |         snprintf(name, sizeof(name), "mlx4_ibud%d", port);
>       |                                      ^~~~~~~~~~~~~
> drivers/infiniband/hw/mlx4/mad.c:2213:9: note: ‘snprintf’ output between
> 11 and 21 bytes into a destination of size 12
>  2213 |         snprintf(name, sizeof(name), "mlx4_ibud%d", port);
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> cc1: all warnings being treated as errors
> make[6]: *** [scripts/Makefile.build:244: drivers/infiniband/hw/mlx4/mad.o] Error 1
> 
> [...]

Applied, thanks!

[1/1] RDMA/mlx4: Fix truncated output warning in mad.c
      https://git.kernel.org/rdma/rdma/c/01c6d9f59148b6

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


