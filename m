Return-Path: <linux-rdma+bounces-15130-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A705FCD3E7F
	for <lists+linux-rdma@lfdr.de>; Sun, 21 Dec 2025 11:29:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 440E0300160C
	for <lists+linux-rdma@lfdr.de>; Sun, 21 Dec 2025 10:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B070287265;
	Sun, 21 Dec 2025 10:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VnRgC/Kl"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D557A2472BA;
	Sun, 21 Dec 2025 10:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766312964; cv=none; b=rDzSu4JG75GFAx8upPvTdsMcjsF/R3fhwhBEye8ecFCU3Hpu+b7qYqKMyAA9mSW1jD0ZBp25rmlhaEARdMrumm0irUCxEKQWX3QkbTmsxf70skeO+Z3+zVamwiY8FwfW2Tg7pIrhWEVkVfFLre10Y7kXLUpwHQXC1S8d7M4+aSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766312964; c=relaxed/simple;
	bh=PU/pk328aJBx84jd19OJQ3evhxWyuQPC6TH76pCd5WE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=mUgO2b7yCz2u8FVa5HsITl5IeZUK7GILmmp2gZEZrizw0BtHXaQemH1gM+JwJR/S2pGrwAP+LgVKcod/55Ehn1IR0c60oPEo5j+ox3AxnzFX6AxYCmTgtUEK1EwExKrBY0QLqRVjnoDzf3BdB6sv8pfY41+gC5ZoHJtAyKIFQwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VnRgC/Kl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16DFCC4CEFB;
	Sun, 21 Dec 2025 10:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766312964;
	bh=PU/pk328aJBx84jd19OJQ3evhxWyuQPC6TH76pCd5WE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=VnRgC/KlI1IQsPjT2gw977tZt+ORy+RfrIhcUEVdu/V37jK+0eTiKNHVrxiyDBPeq
	 1vS+yQu8qbrnveyfsyQza31V1n3B9URtBT5mUnCaxOJ//bP3voFUBTYsVEOcRIilN3
	 9yXWWVzxHW2XU+hwfFtFPGAuCR2H8Z8HedaavvdqV24yoJW3NgWqKfU2SmckgErkPk
	 dOJA9FXRpVe+y/+mQUlMhZb4Z2N0/XBvt2FilCjT6d/C517kPO8TqWegdx+woriPVt
	 ebdTcBYesGDx+cENuHBCpAOGXTw0Mc5u52RtiVlSg+t8xwilkKDp25pq5d0t6jQYg+
	 dIfmhGDkVn6Jg==
From: Leon Romanovsky <leon@kernel.org>
To: linux-rdma@vger.kernel.org, Stefan Metzmacher <metze@samba.org>
Cc: Zhu Yanjun <zyjzyj2000@gmail.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, netdev@vger.kernel.org, 
 linux-cifs@vger.kernel.org
In-Reply-To: <20251219140408.2300163-1-metze@samba.org>
References: <20251219140408.2300163-1-metze@samba.org>
Subject: Re: [PATCH] RDMA/rxe: let rxe_reclassify_recv_socket() call
 sk_owner_put()
Message-Id: <176631296153.2404623.1401232430474772017.b4-ty@kernel.org>
Date: Sun, 21 Dec 2025 05:29:21 -0500
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-a6db3


On Fri, 19 Dec 2025 15:04:08 +0100, Stefan Metzmacher wrote:
> On kernels build with CONFIG_PROVE_LOCKING, CONFIG_MODULES
> and CONFIG_DEBUG_LOCK_ALLOC 'rmmod rdma_rxe' is no longer
> possible.
> 
> For the global recv sockets rxe_net_exit() is where we
> call rxe_release_udp_tunnel-> udp_tunnel_sock_release(),
> which means the sockets are destroyed before 'rmmod rdma_rxe'
> finishes, so there's no need to protect against
> rxe_recv_slock_key and rxe_recv_sk_key disappearing
> while the sockets are still alive.
> 
> [...]

Applied, thanks!

[1/1] RDMA/rxe: let rxe_reclassify_recv_socket() call sk_owner_put()
      https://git.kernel.org/rdma/rdma/c/de41cbc64d02ae

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


