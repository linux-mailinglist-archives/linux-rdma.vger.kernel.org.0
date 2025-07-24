Return-Path: <linux-rdma+bounces-12455-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C966B101A0
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Jul 2025 09:24:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B499AC12C4
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Jul 2025 07:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AEAF2309B3;
	Thu, 24 Jul 2025 07:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="La47Z99u"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C1AB23026B
	for <linux-rdma@vger.kernel.org>; Thu, 24 Jul 2025 07:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753341835; cv=none; b=m+PP4Y74Km9EDcZ8PWV/YCXw0T4fUyZUW2UXXYFDQiRciB3LQMZbZS8t4ubSNo2hCQxW76PgeoMX2StimL6SE5dYQvKImhC10OpOyDTM55mzZh3sF6rE76m1Ppe8/CC1Z7KdDse/aQaxS4xupGUNXRXINBg8TFqXzU4fQGsNpmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753341835; c=relaxed/simple;
	bh=shN2T2Q781CIMOXzgRnXz4ZAwql5906xcAbDirM2Blw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=G1Q+KuJd6FgKUksNohsXN/r89yVjaM7lce4e6gJEypeItQ9n/4zOC9MoI4l9z1KRYnAe10HSHkIURnxdkejyOsYjKInlWVceLm/1mCehBHbmwzsk9a/Vo4v1MiFW9QWB1NzKu3RkumawX7PJcJIzeZmpnKzS6Ls2kuEFlbGlqW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=La47Z99u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52335C4CEED;
	Thu, 24 Jul 2025 07:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753341834;
	bh=shN2T2Q781CIMOXzgRnXz4ZAwql5906xcAbDirM2Blw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=La47Z99uSCb1SdwgleUIsFKLavPpdGPbMMuIf25bCWmVEmT09PrpyWHH9HCS+RVxz
	 6icltgVTu1L8Tb+Mx8we9SbaHkRoAdVpdfqsRxCGI6hfrMwpa9K8FfTNXzvAkQC4+H
	 DNi0PZFvjkF+BTBW/I6ya+Zf3/2h/i1EayDx/CuttWyYxzcIo1BaUsCO4IoyLyNs3P
	 pE4/pORRnDqIargjrX9COSHlBxdumFYq8cjJBC4FocXKPhSfnrmyvWPGHEW9jpjdLO
	 VO75awqk/Retw7s2xYfxpmy512GhGMXUgPFTZjdOxPJLa4fYgb1nKCk+rfPrUGZxWt
	 /BnoNEObUE+2A==
From: Leon Romanovsky <leon@kernel.org>
To: jgg@ziepe.ca, bernard.metzler@linux.dev
Cc: linux-rdma@vger.kernel.org
In-Reply-To: <20250723132107.2188-1-bernard.metzler@linux.dev>
References: <20250723132107.2188-1-bernard.metzler@linux.dev>
Subject: Re: [PATCH RESEND] RDMA/siw: Change maintainer email address
Message-Id: <175334183149.1552570.9568137163377412408.b4-ty@kernel.org>
Date: Thu, 24 Jul 2025 03:23:51 -0400
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Wed, 23 Jul 2025 15:21:07 +0200, bernard.metzler@linux.dev wrote:
> Change siw maintainer email address since old address
> will become disfunctional. Also add info to .mailmap
> 
> 

Applied, thanks!

[1/1] RDMA/siw: Change maintainer email address
      https://git.kernel.org/rdma/rdma/c/ee235923d205c6

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


