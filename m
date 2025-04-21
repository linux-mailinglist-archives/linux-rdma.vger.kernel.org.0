Return-Path: <linux-rdma+bounces-9629-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C1F6A94DF4
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Apr 2025 10:19:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 419B41889242
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Apr 2025 08:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C17201624FE;
	Mon, 21 Apr 2025 08:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QR12ZU09"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C4ACC147;
	Mon, 21 Apr 2025 08:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745223534; cv=none; b=oRO3shwDlCMmMSN0S8hdK9JyqVfBjZkP7LmbJBHi4YWzUSVrO5WzFNzrKHhlwMG3w6sxY9aRWGzcmRCyFowChBnO/CrroDqNuDSXMLVeIm/0Si8B4aczKyVACB3ZgRq1e22zgoTjunHxXAAccBcwPEhr83cMdUivqo4LIhhADfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745223534; c=relaxed/simple;
	bh=cHVRu6mlQQJbRHom02aerV8BTiItIJ/hPF5ZJCNb89w=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=mWT3pTPNJKjNMFxY0Bh/u1+b05lGaT3bO+vsuIw/jnzAwMChQN7NnM21vUAFJZfM6YNKDREC9jPeuD27S9MDvi2pe8vybHmpBxDPsZp253wMLJANxBvLFTGac3bA4J+p7Kfc6qSOF3Bh4WVfP9Y32UryRx8rNaGN9s0kFW2fHLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QR12ZU09; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A489C4CEE4;
	Mon, 21 Apr 2025 08:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745223533;
	bh=cHVRu6mlQQJbRHom02aerV8BTiItIJ/hPF5ZJCNb89w=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=QR12ZU09MgBbHJPbbX5uR5Wd09qJYH2iR/itnJuadxX7vdNCmJwJv2WpXlH4ST10j
	 H+2sQgvffoEb3UikOKtvzqYQXaj0TEla6RqBzaqTzmxvfBWxQr5vGvJQRv1URVjsEZ
	 xfFGUDjP0oLiNE6R3WEJMgu23osEDaba7H/0uv+CXl0difW7zEd2OV2UN8PC8p+qdl
	 93ukXMkGr7y69osePOPWZFS9Z7iOd/y6nWiq6cyXODaaNPYnAMejYX9Iu57NN/1pOw
	 vzVV+k52OUvZZoSvNcQ0wx7iJb5EvaGiolR84LtIVbvfuEyMACuxXbPFRoBQF1cR3J
	 x562eTjyQn1/w==
From: Leon Romanovsky <leon@kernel.org>
To: linux-rdma@vger.kernel.org, jgg@ziepe.ca, zyjzyj2000@gmail.com, 
 Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20250421025101.3588139-1-matsuda-daisuke@fujitsu.com>
References: <20250421025101.3588139-1-matsuda-daisuke@fujitsu.com>
Subject: Re: [PATCH for-next] RDMA/rxe: Remove 32-bit architecture support
Message-Id: <174522352968.69399.1034185101684727251.b4-ty@kernel.org>
Date: Mon, 21 Apr 2025 04:18:49 -0400
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Mon, 21 Apr 2025 11:51:01 +0900, Daisuke Matsuda wrote:
> Major linux distibutions have phased out support for 32-bit machines. Since
> rxe is primarily used for development and testing, the benefit of
> maintaining 32-bit support is minimal. This change simplifies ATOMIC WRITE
> implementations and improves maintainability of the driver.
> 
> 

Applied, thanks!

[1/1] RDMA/rxe: Remove 32-bit architecture support
      https://git.kernel.org/rdma/rdma/c/23ea3c70ee426b

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


