Return-Path: <linux-rdma+bounces-2428-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C99398C35E1
	for <lists+linux-rdma@lfdr.de>; Sun, 12 May 2024 11:42:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 548A0281824
	for <lists+linux-rdma@lfdr.de>; Sun, 12 May 2024 09:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC96C1BF47;
	Sun, 12 May 2024 09:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RvhCeWP2"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB6CD1BC44
	for <linux-rdma@vger.kernel.org>; Sun, 12 May 2024 09:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715506938; cv=none; b=HcO+i+iRsS4vi/8vm3eSMt2SVw+i63Z8ZuqunLor3SjZCBNLiLQFTiPCuccX1bDMe3tBWx1wi0yKSySTzzW7mkGs0k0UNGu6bpCwCZeh8Z3LLhU3Cxjg08WTgyn8wM1V+aRrpY8StU7Lf15du4P4eXMgVGp7sbT/ZT3yJ1/cy/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715506938; c=relaxed/simple;
	bh=OdQhbTVR7FIBJgYHaSs9TcD6eevn71O2Eh1hhNfRJ18=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=pG6FsgZ24WnKqY0WXqbUlbc7GmcJtKxsvJDhPH653JVHFOphEPa/ruLjqTWYdI0f5FX3hytncLek3IHieE/oSH2McW3HeUtU8FptnCUWPobE12GW6nuEXLRaOIi5S5E+rd9TU1+O4Q0s6U9bSKy4fa16tAqU1ZLpR/xi7+z0L9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RvhCeWP2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A166C116B1;
	Sun, 12 May 2024 09:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715506938;
	bh=OdQhbTVR7FIBJgYHaSs9TcD6eevn71O2Eh1hhNfRJ18=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=RvhCeWP28VcJV4smGpYDLSDen4/Y4oBPV7RDm3X7nM9nuruTP66IkQ+a3mpPVnJtQ
	 efmeX0VtgLGRWf3+miKc68ajUOTO2OTlpvW/1LoB8np+lEXL55v8EeB5GyU1TXq1lL
	 7BiUT1sIUPqySNVMaNJfyxV4mrReXvUCeWLoN8XiphBIi8Cwg+euWw+3U3P4H6sQ8F
	 Z/VRVlnAO0B8wzH6EDhWArCOJQ2wFCM1nVR2HyjjUCL9/2Kk4chSG7K6CJhoWjqtQo
	 6iG0lntoHseomAy1Q2T3Is9QAQeEtIlVvoFyxVLpYOZG8g+0ZOnOen7N8jE7y0mg/v
	 dwN5coaTtPZTQ==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
Cc: linux-rdma@vger.kernel.org, Leon Romanovsky <leon@kernel.org>
In-Reply-To: <e9d3e1fef69df4c9beaf402cc3ac342bad680791.1715240029.git.leon@kernel.org>
References: <e9d3e1fef69df4c9beaf402cc3ac342bad680791.1715240029.git.leon@kernel.org>
Subject: Re: [PATCH rdma-next v1] RDMA/IPoIB: Fix format truncation
 compilation errors
Message-Id: <171550693384.115362.6327463065943357914.b4-ty@kernel.org>
Date: Sun, 12 May 2024 12:42:13 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14-dev


On Thu, 09 May 2024 10:39:33 +0300, Leon Romanovsky wrote:
> Truncate the device name to store IPoIB VLAN name.
> 
> [leonro@5b4e8fba4ddd kernel]$ make -s -j 20 allmodconfig
> [leonro@5b4e8fba4ddd kernel]$ make -s -j 20 W=1 drivers/infiniband/ulp/ipoib/
> drivers/infiniband/ulp/ipoib/ipoib_vlan.c: In function ‘ipoib_vlan_add’:
> drivers/infiniband/ulp/ipoib/ipoib_vlan.c:187:52: error: ‘%04x’
> directive output may be truncated writing 4 bytes into a region of size
> between 0 and 15 [-Werror=format-truncation=]
>   187 |         snprintf(intf_name, sizeof(intf_name), "%s.%04x",
>       |                                                    ^~~~
> drivers/infiniband/ulp/ipoib/ipoib_vlan.c:187:48: note: directive
> argument in the range [0, 65535]
>   187 |         snprintf(intf_name, sizeof(intf_name), "%s.%04x",
>       |                                                ^~~~~~~~~
> drivers/infiniband/ulp/ipoib/ipoib_vlan.c:187:9: note: ‘snprintf’ output
> between 6 and 21 bytes into a destination of size 16
>   187 |         snprintf(intf_name, sizeof(intf_name), "%s.%04x",
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   188 |                  ppriv->dev->name, pkey);
>       |                  ~~~~~~~~~~~~~~~~~~~~~~~
> cc1: all warnings being treated as errors
> make[6]: *** [scripts/Makefile.build:244: drivers/infiniband/ulp/ipoib/ipoib_vlan.o] Error 1
> make[6]: *** Waiting for unfinished jobs....
> 
> [...]

Applied, thanks!

[1/1] RDMA/IPoIB: Fix format truncation compilation errors
      https://git.kernel.org/rdma/rdma/c/49ca2b2ef3d003

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


