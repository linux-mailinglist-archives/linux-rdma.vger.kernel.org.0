Return-Path: <linux-rdma+bounces-8231-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D967A4B15A
	for <lists+linux-rdma@lfdr.de>; Sun,  2 Mar 2025 13:02:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6208216E00E
	for <lists+linux-rdma@lfdr.de>; Sun,  2 Mar 2025 12:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B6E11B6D06;
	Sun,  2 Mar 2025 12:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E2fqzBPh"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79B54C85;
	Sun,  2 Mar 2025 12:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740916915; cv=none; b=PcxlPysKAdJPeVyckoyy4/3tQ33JgCi4Rq4/N21WiR6QUcTOXWi3Qgu3NxXyfT2O30oP/xgwTQQKvYTXecLvSOeksfPek8Nc0XeqHLuNRqhsc06JeK/8so2XNCKtsuaMrWMyar/ft1DqoxUHNhjii6ijInOnv7jRheFR21VvqWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740916915; c=relaxed/simple;
	bh=GdCDFgExan4TObvsvDkJFxTk3tl/Ajpy9tXvSJ+dBoI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=VjSSeWko8Zw0Dg4JSLn61QGnGoxkpOcUSRTy50WksxM51bEj0YaxIYWG4p9J90MPNg0Z6hTR8q/Sg/vutOoF06Povh3PGYxJTcvaE8LiwVH90Sm3YmMUq5KKhvPZuQb0c8cwEJXiV/Nan34DCHC3mNcKKxYcCnGbiZrxS9D91hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E2fqzBPh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81D22C4CED6;
	Sun,  2 Mar 2025 12:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740916915;
	bh=GdCDFgExan4TObvsvDkJFxTk3tl/Ajpy9tXvSJ+dBoI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=E2fqzBPhyXNl8r9TVXbRDVwIEbBPztG/U1pVkW9TAS2TGwnAWLUh+plHO/fZoWyP9
	 xHX/OxKV03kVyW7qonlD0gGEGUP1qX+lF5dFHfixIa7XUQKcogo6ElBEbF6/YgzknZ
	 78nccDYRmOzwMXJU2X9VbURQTnElpmDDIHZr1Ud7bC+e8JwTWk+7uKwZdDoxoCVkJW
	 CmGx0c24pxS9ufBt8wEu50Bq4tOghSkVFy1nLxC8nPofWk64u6ImpsXpUmcY6ENLzp
	 CXs3TutRMpx6gN3PnVawVfDmlzu0ElmI/c6n+TPKceKrGyfMmnpijhk0FV7q/od33T
	 bFfSUs+5/DSFA==
From: Leon Romanovsky <leon@kernel.org>
To: Bernard Metzler <bmt@zurich.ibm.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
 linux-rdma@vger.kernel.org, Eric Biggers <ebiggers@kernel.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20250227051207.19470-1-ebiggers@kernel.org>
References: <20250227051207.19470-1-ebiggers@kernel.org>
Subject: Re: [PATCH v2] RDMA/siw: switch to using the crc32c library
Message-Id: <174091691135.677350.16695129314216487446.b4-ty@kernel.org>
Date: Sun, 02 Mar 2025 07:01:51 -0500
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Wed, 26 Feb 2025 21:12:07 -0800, Eric Biggers wrote:
> Now that the crc32c() library function directly takes advantage of
> architecture-specific optimizations, it is unnecessary to go through the
> crypto API.  Just use crc32c().  This is much simpler, and it improves
> performance due to eliminating the crypto API overhead.
> 
> 

Applied, thanks!

[1/1] RDMA/siw: switch to using the crc32c library
      https://git.kernel.org/rdma/rdma/c/b90b9877368d3c

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


