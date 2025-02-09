Return-Path: <linux-rdma+bounces-7586-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3340A2DBC8
	for <lists+linux-rdma@lfdr.de>; Sun,  9 Feb 2025 10:25:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F4933A6F3D
	for <lists+linux-rdma@lfdr.de>; Sun,  9 Feb 2025 09:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8962514B092;
	Sun,  9 Feb 2025 09:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D2PXEBzF"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3981A143723;
	Sun,  9 Feb 2025 09:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739093099; cv=none; b=RdyNOaxbc0tyNXVctuwT87WSPnlzz2wrsZxQNU5oHML28rMOu2jLtC7w5oKVBa8F2TmznS0NsypPpXK1jHbFcIYFBDGzFOIz6wXqjXzZxv9RoItXQf2xhfYO7yhR0tmfgn1DhuHmf9GOtB+cfaGu6Hmd00ovOqTC6QJAx4ubOlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739093099; c=relaxed/simple;
	bh=ssQObEYlw8YT4fp9TnwZdyIO3kgihzlK1DnhYvED8kE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=NBbamSk2fb83IvR8cGv3EZtyng0sG63W6POaiE0nG21DUD5c1mYSwdm6T3hELQL7we/dhQ/OlmfnF60t0jTbRfulVFdiXfV5vW5HfhhIVnGU2e4HL1QtvJJoftHk5xCipeODr+1IiA9PPRRqPQ+//9zh5Cxrsr4Ku7J8jkA41S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D2PXEBzF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0418DC4CEDD;
	Sun,  9 Feb 2025 09:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739093098;
	bh=ssQObEYlw8YT4fp9TnwZdyIO3kgihzlK1DnhYvED8kE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=D2PXEBzFn2b5wylIjH7TeTYgGZO4dXFM+PH7XjVKP8QxV6SzI3Y+NAEmzS6CpuW8z
	 ubmWsK4vRtHByTLgg3swhZZ51iY8YMhxSFNj2YLsuDLsuekQrqVIkGccTcjfEbCKr0
	 gAg40Q00z92Ybw0Dk3hTikrpzlTcs2VaraM0q8jDxsNfW6lEItC2UGSqCuxRxxbIAU
	 qHeNosIOfOD2sopDQPrHLJrM6upEpBIpfQpKjVh8HfdwJixfbuIdVCaX9j5kpoBaMr
	 IViQyzToVGB3Zn4w7UyLx4nMiMZb9kBF0O1L38MEehKjEmqwmRXVlFxeo8mjwX6/0m
	 HJzkZyP3PynNQ==
From: Leon Romanovsky <leon@kernel.org>
To: Konstantin Taranov <kotaranov@microsoft.com>, 
 Dan Carpenter <dan.carpenter@linaro.org>
Cc: Long Li <longli@microsoft.com>, Ajay Sharma <sharmaajay@microsoft.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>, Shiraz Saleem <shirazsaleem@microsoft.com>, 
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel-janitors@vger.kernel.org
In-Reply-To: <2bbe900e-18b3-46b5-a08c-42eb71886da6@stanley.mountain>
References: <2bbe900e-18b3-46b5-a08c-42eb71886da6@stanley.mountain>
Subject: Re: [PATCH next] RDMA/mana_ib: Fix error code in probe()
Message-Id: <173909309517.4223.3295047094322113196.b4-ty@kernel.org>
Date: Sun, 09 Feb 2025 04:24:55 -0500
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Fri, 07 Feb 2025 12:16:03 +0300, Dan Carpenter wrote:
> Return -ENOMEM if dma_pool_create() fails.  Don't return success.
> 
> 

Applied, thanks!

[1/1] RDMA/mana_ib: Fix error code in probe()
      https://git.kernel.org/rdma/rdma/c/607a7dcf2e9814

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


