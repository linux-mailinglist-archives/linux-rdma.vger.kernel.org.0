Return-Path: <linux-rdma+bounces-2698-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A6F68D4DF3
	for <lists+linux-rdma@lfdr.de>; Thu, 30 May 2024 16:28:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2953283BB4
	for <lists+linux-rdma@lfdr.de>; Thu, 30 May 2024 14:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1D2917C206;
	Thu, 30 May 2024 14:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AHlyA8nJ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83747186E57
	for <linux-rdma@vger.kernel.org>; Thu, 30 May 2024 14:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717079180; cv=none; b=pdWG6tyUQHAExZ4OKxE8hDcl4TyFtt2qdqbPSwtyyIBJJJT31/6qHj3MoC0C41KxcT2pd4EdJWmcqxP9irWv42FDejQpgxtQxbs1UkNbolEkJP2vfC+TgM0UbGeQFr8PqxPCmT5OK0fZP1k5D6faOdKjipzJY/6NJnuhcjtvVz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717079180; c=relaxed/simple;
	bh=e2mKEjMTr94pShgIjjKxUEDyozqCxfjRCkadHLrRI1s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=tze3i+xKtMK1dk6DINIxOOIWEDR/bjfRQeZgd3uvEhjgZbei4BIq1/rYC50oW3QjxK++ET6WkNNI3rQDXlqTpkEj8fJRSYCVEOa7RNuJURFDJFZlaEsL4+ckTrqXaOH/GGlXNYuTZDuL/ZtzE02ie0QExotlcULOkssMtqguct8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AHlyA8nJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B5BDC2BBFC;
	Thu, 30 May 2024 14:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717079180;
	bh=e2mKEjMTr94pShgIjjKxUEDyozqCxfjRCkadHLrRI1s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=AHlyA8nJ4gwtXM22BFfdhEUqROrXvXonB44sh6Va58j/q5dRc5G1D5SfJedWvulcs
	 4IllOCwsCpJ3WMLt/AhiExmq5q+MZCoC5PuNvCrPLbSk1Koi3rCo6KE4exeSUGQxys
	 2PN7oTqhU7XMY+f3g4rEMHHB0T3EzhrerbXvV7qzxQLboSo2At/J8EV9swxslBa0vT
	 +3ygdo6O4fT7JX+HT5E0KQsnEXLlxybqYrkkS0ao8JalI4K5fE4HP9JPwui32HUbwl
	 2p8Yq3UYo+4P3GY3tP/NA7udYkZ9Au5b94tY1Wvwv7Y6EUk2RgUwxn3t2EF2p9vHOd
	 ZXz2TaYE+Uonw==
From: Leon Romanovsky <leon@kernel.org>
To: zyjzyj2000@gmail.com, jgg@ziepe.ca, Honggang LI <honggangli@163.com>
Cc: linux-rdma@vger.kernel.org
In-Reply-To: <20240516095052.542767-1-honggangli@163.com>
References: <20240516095052.542767-1-honggangli@163.com>
Subject: Re: [PATCH] RDMA/rxe: Fix data copy for IB_SEND_INLINE
Message-Id: <171707524508.127288.4316001486717061119.b4-ty@kernel.org>
Date: Thu, 30 May 2024 16:20:45 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev


On Thu, 16 May 2024 17:50:52 +0800, Honggang LI wrote:
> For RDMA Send and Write with IB_SEND_INLINE, the memory buffers
> specified in sge list will be placed inline in the Send Request.
> 
> The data should be copied by CPU from the virtual addresses of
> corresponding sge list DMA addresses.
> 
> 
> [...]

Applied, thanks!

[1/1] RDMA/rxe: Fix data copy for IB_SEND_INLINE
      https://git.kernel.org/rdma/rdma/c/03fa18a992d562

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


