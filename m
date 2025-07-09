Return-Path: <linux-rdma+bounces-11997-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D1F56AFE090
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Jul 2025 08:52:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 415911884F09
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Jul 2025 06:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C15C26CE18;
	Wed,  9 Jul 2025 06:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s/FexLNp"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C4726B955;
	Wed,  9 Jul 2025 06:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752043916; cv=none; b=cv3A5FnbTQpi5tqs7iYA+XDPpVyppeYYOdi4GhnSyXhQAL8GpjuKf8QRd8Twip5fo39wRcPAnwVqGhBeLu2JSYsFZKzGMv/HF3WGdPbY+dSMQdDsHuQJRU8+WxMFuJgXFlJ02OuZfQP33zRiczpNuEvRhiuk1HRr1wby5xlMLj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752043916; c=relaxed/simple;
	bh=+zipvY8WOI4EQ0v8MneRcgKln7S6CAObui1g3boB7e0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ra9yYf6mCCuNc5izUDeCEDggJiNly5/8mrkvGSHxTlmWRwfn+IPL2Kgd/ucsscPdHulNavnnaiuZ17rhEFDxURv7vaWjNrxdPfwpb9AGZ3+3Cr0DKDuOoHHb/x9VTmVoOuIfgc5vCWzX7HKAihmIRqN3zg9CUnFUgF78oTdJ1V8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s/FexLNp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 525FAC4CEF0;
	Wed,  9 Jul 2025 06:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752043915;
	bh=+zipvY8WOI4EQ0v8MneRcgKln7S6CAObui1g3boB7e0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=s/FexLNp0RqUyXPgbnrM2ZP8dPFr21ydj3UpMtC+J3ZH0+whgrTIhlg6RHM9cGyiU
	 +qOMCUpwO6yYPA3++68RrlQRazZJEbu7dWiBPKfrSmvkXRPE7vTzpJ0f7bGRQlL5oL
	 aos/Pn/wQEO8PtzOAtlmNILegZ0lE5dCRHNadnossP5scqheUa13tccvouoRi8Xbkb
	 l18pI3jCIWQFA18i/4B1Y47QQZUdaG2YpOR0TaFW2iZrKe7eaM6oSWi7Oe/lWXLFYe
	 hxz7kPav2ylSYCTReayFRpL4QLlkqQwrdCrKaAJx8ZlqCFvBbzq0U5iQ1vSAGxjMKk
	 Fo3xM3k9HGjwQ==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
 Maher Sanalla <msanalla@nvidia.com>, Or Har-Toov <ohartoov@nvidia.com>, 
 Sean Hefty <shefty@nvidia.com>, Vlad Dumitrescu <vdumitrescu@nvidia.com>
In-Reply-To: <cover.1751278420.git.leon@kernel.org>
References: <cover.1751278420.git.leon@kernel.org>
Subject: Re: [PATCH rdma-next v2 0/3] IB/mad: Add Flow Control for
 Solicited MADs
Message-Id: <175204391255.1575523.14180438560345592513.b4-ty@kernel.org>
Date: Wed, 09 Jul 2025 02:51:52 -0400
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Mon, 30 Jun 2025 13:16:41 +0300, Leon Romanovsky wrote:
> Changelog:
> v2:
>  * Add separate send-only agent for REPs to prevent starvation
>    of REPs when runnning both service and client on the same node.
>  * Instead of immediately resending a timed-out MAD, it will now   be
>  * placed in backlog queue if the queue is not empty.
> v1: https://lore.kernel.org/all/cover.1736258116.git.leonro@nvidia.com
>  * Add a cancel state to the state machine which allows removing the
>  * status field in MAD's struct.
>  * Add change_mad_state function which handles all the state transition.
>  * Add WARN_ONs to check MAD states
>  * Reorganize patches to have only two patches in this series instead of
>  * three.
> v0: https://lore.kernel.org/all/cover.1733233636.git.leonro@nvidia.com
> 
> [...]

Applied, thanks!

[1/3] IB/mad: Add state machine to MAD layer
      https://git.kernel.org/rdma/rdma/c/1cf0d8990155c1
[2/3] IB/mad: Add flow control for solicited MADs
      https://git.kernel.org/rdma/rdma/c/314cb74cea847d
[3/3] IB/cm: Use separate agent w/o flow control for REP
      https://git.kernel.org/rdma/rdma/c/8ab05a5456bb95

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


