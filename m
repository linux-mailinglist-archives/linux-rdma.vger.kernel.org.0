Return-Path: <linux-rdma+bounces-15141-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CF1CCD4ECB
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Dec 2025 09:04:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CF5873004194
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Dec 2025 08:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21D9330B526;
	Mon, 22 Dec 2025 08:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g1TAz1Qs"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B191621CFFA
	for <linux-rdma@vger.kernel.org>; Mon, 22 Dec 2025 08:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766390664; cv=none; b=Gaol3DHxcHI2hqOLL41UNJGZE27g97I2qIxWmjHO29Jkk6NJmu7XluDbAvXThEfYv+XSj4OAZ6G68E7YFBz7lRERj0dI//jcFRfXBuiPop7xwW0MQhOt3tqS3xWy1/oG1byq3aPv2zQXBuzdZteO//PUdQ/OwrYzJve6sX9UQK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766390664; c=relaxed/simple;
	bh=4kpBpTV++U9Ilm8Y00Gko/IHEP/ZmMaJo0zgD2jJjZc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=WGmXWMCyVswT/vVYK1JgiEnlriYVuV/gZ4pUnUhr+Y4nyGdaTBBaiquvoWQpXPolX/UB0PjlL/WEKhkjAzW4XHFSQTFLw3b/IL1IHyzLXZqIPPaQYdreZD5GI3eS4h/XX0MQTOXCrRyPTbzAaImuPRxvj9kzNrEcp8neHlJZREI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g1TAz1Qs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C72D3C4CEF1;
	Mon, 22 Dec 2025 08:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766390663;
	bh=4kpBpTV++U9Ilm8Y00Gko/IHEP/ZmMaJo0zgD2jJjZc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=g1TAz1QsF+97vlpVaJi4b57S+pdtknugpwR/YnLdBV+ACblycSmKEHi35YdLocjsE
	 seEgbOvDhmYPw9vLm9hBewnfIzEj3H0XbKsb30krlV3o3zL/tcbzDsvVgTvBSyGAAV
	 hYHWH+RrBfsO+wRwk+1YUOuSCPFiylIoclMOUViO62e9+y0SRQU0TxAOjSAdu6O/xa
	 XPgMqG+45Z0KkDN88JKQMrgA3LlsocoLMrqbhA7cSKS/P4hQtYftzoQVwl3IRaiQkf
	 NATZRHSJvsvqQrl7SAxInljdimUaYI/OKDRPsuVKD2TwZwIVIedd3wbPOWo7FHtSaq
	 Q/JNjoaghWKeQ==
From: Leon Romanovsky <leon@kernel.org>
To: somnath.kotur@broadcom.com, sriharsha.basavapatna@broadcom.com, 
 jgg@ziepe.ca, kalesh-anakkur.purayil@broadcom.com, 
 selvin.xavier@broadcom.com, linux-rdma@vger.kernel.org, 
 Alok Tiwari <alok.a.tiwari@oracle.com>
Cc: alok.a.tiwarilinux@gmail.com
In-Reply-To: <20251219093308.2415620-1-alok.a.tiwari@oracle.com>
References: <20251219093308.2415620-1-alok.a.tiwari@oracle.com>
Subject: Re: [PATCH] RDMA/bnxt_re: Fix IB_SEND_IP_CSUM handling in
 post_send
Message-Id: <176639066011.3206.18098511728277573213.b4-ty@kernel.org>
Date: Mon, 22 Dec 2025 03:04:20 -0500
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-a6db3


On Fri, 19 Dec 2025 01:32:57 -0800, Alok Tiwari wrote:
> The bnxt_re SEND path checks wr->send_flags to enable features such as
> IP checksum offload. However, send_flags is a bitmask and may contain
> multiple flags (e.g. IB_SEND_SIGNALED | IB_SEND_IP_CSUM), while the
> existing code uses a switch() statement that only matches when
> send_flags is exactly IB_SEND_IP_CSUM.
> 
> As a result, checksum offload is not enabled when additional SEND
> flags are present.
> 
> [...]

Applied, thanks!

[1/1] RDMA/bnxt_re: Fix IB_SEND_IP_CSUM handling in post_send
      https://git.kernel.org/rdma/rdma/c/f01765a2361323

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


