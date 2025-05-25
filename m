Return-Path: <linux-rdma+bounces-10675-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C617AC32D0
	for <lists+linux-rdma@lfdr.de>; Sun, 25 May 2025 09:51:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6601F7AC374
	for <lists+linux-rdma@lfdr.de>; Sun, 25 May 2025 07:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3B92156236;
	Sun, 25 May 2025 07:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CtiURjyd"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C962F32;
	Sun, 25 May 2025 07:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748159472; cv=none; b=DBGaqGaedmvwPPA0pegEQBwNNhZyzuyd3W/zMP+9RcfBEbRb/TAg/jhAniGt/kh2bxBJm+IJhx858oXzfTegrXiaTXLsqwVicXwEArfdJzlVSx43OLXVex1RRD6ahgk0BRzEu6YDP3ECiEdQvEb114QiAW4LGyLCojoOoqIWISo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748159472; c=relaxed/simple;
	bh=GKYfq/ie+yDDynczG4hW+SNp7xxSrW8/69VgSBYlRgk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=YVa63Fzm9zSyVjK7dYNRTDg9Vg+WZhQjFJbCu7y7U0hN4pN0iGGjTWCVuWKHLldOf+8s48Db3o5vgX9+7HeNTZuIpTtaAe/WqmHZprhzTy6YMhhX+lcy2XBNeHvcILk1qGOcBydC8eDBE71mmIibXuxhYaCVqopNyndUqorA5J0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CtiURjyd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86C71C4CEEA;
	Sun, 25 May 2025 07:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748159471;
	bh=GKYfq/ie+yDDynczG4hW+SNp7xxSrW8/69VgSBYlRgk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=CtiURjyd9myWSJWcWcCUE9+eAcx8tAGafyUxV8xV7gi8IkmtAkqE7EySpp1shV5yZ
	 5StLheP46JVqe1DuIUSOmtx+y7HyeXCArUTRLTIiUKMQZTnjsBiJXW/tzbWnfAylwK
	 G8DfBaVGS4Bww2hsU16RylSYgNG7op3lFwRR6agZtkjNBzEo+F8hkDVHuPmhqTtmBO
	 Uo63nSuoDJYau/2tjiymPopHyKfcgoVnUBntFEGTZmtrxd7O6DeoZmzZqYwnKX78h3
	 CBygYxPBNzp3DgWQK2IDOFR7BJjfHo3hcTUkv/DPY3Y9Fenh2rAvoLi9ZYEc+jfDTW
	 hqB5Dc6xK/EyQ==
From: Leon Romanovsky <leon@kernel.org>
To: linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, jgg@ziepe.ca, 
 zyjzyj2000@gmail.com, Daisuke Matsuda <dskmtsd@gmail.com>
Cc: hch@infradead.org
In-Reply-To: <20250524144328.4361-1-dskmtsd@gmail.com>
References: <20250524144328.4361-1-dskmtsd@gmail.com>
Subject: Re: [PATCH for-next v3] RDMA/core: Avoid hmm_dma_map_alloc() for
 virtual DMA devices
Message-Id: <174815946854.1055673.18158398913709776499.b4-ty@kernel.org>
Date: Sun, 25 May 2025 03:51:08 -0400
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Sat, 24 May 2025 14:43:28 +0000, Daisuke Matsuda wrote:
> Drivers such as rxe, which use virtual DMA, must not call into the DMA
> mapping core since they lack physical DMA capabilities. Otherwise, a NULL
> pointer dereference is observed as shown below. This patch ensures the RDMA
> core handles virtual and physical DMA paths appropriately.
> 
> This fixes the following kernel oops:
> 
> [...]

Applied, thanks!

[1/1] RDMA/core: Avoid hmm_dma_map_alloc() for virtual DMA devices
      https://git.kernel.org/rdma/rdma/c/5071e94f47af42

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


