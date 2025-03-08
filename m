Return-Path: <linux-rdma+bounces-8500-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FDDCA57DC0
	for <lists+linux-rdma@lfdr.de>; Sat,  8 Mar 2025 20:23:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A565E16D64C
	for <lists+linux-rdma@lfdr.de>; Sat,  8 Mar 2025 19:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31A531EB5EE;
	Sat,  8 Mar 2025 19:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="isbRYJPR"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB370188CB1;
	Sat,  8 Mar 2025 19:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741461822; cv=none; b=UMsvxn/WUMSt5O67C9Y1eh6COJRKlCyoZ23mfFJYupbEgFTXtXTyD+8twdFRaYnoA56f6x20mSIemUg6m7qVZ6KgIrB8FwVjWrDliQMHComnkhsM7SIAbVsgxrsADmvhQIXHLjvHjYYuXLFYvdp+QYjEeCMS8+0h3lKc2z0PJ4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741461822; c=relaxed/simple;
	bh=Pnbag/N8foQKG7DD9O5heajQUOEuMY9izXwVS6F+LX8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=LzFGb4HBKHPkKzUwqQGa9wOZiWnA4NWCmBJmyy7CDtZivVlI/QR8Rsa+iX6wlKpv7U++NzBZRS/oYY4myF+x5RXMg5PvCgJLpiRLqvsyiQ2mUFhQ1FS9gvxDeBibg7mg16VhVzvtY1v+PjiS3h+0l41ZuLFo8C2iyBEIPaqmm1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=isbRYJPR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1552FC4CEE0;
	Sat,  8 Mar 2025 19:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741461820;
	bh=Pnbag/N8foQKG7DD9O5heajQUOEuMY9izXwVS6F+LX8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=isbRYJPRGigVuV4fVAAg638PF8ZwoomWWCwU66duyOYFQli2XPTIT6yawwaz0H6NT
	 2oLx+NjgbkiVv+RikeaIGDz37tIw655/bDZ7qrnWP7iFVDTGrv9IXoIMhYbuQ1yT2P
	 wItiARK0nhAE+GV2/Lsx+N5c6W53zx/l2KiLNw5lfZAmoUuMebFCINJb3xjbGqdFkD
	 2+OQVCeGc3Xi1Peno2Heu9aDsyQ8yw3FdptMfuYPBK8L99LNPIay9UxmtWogKus+U1
	 M1SW/gp9U4vFWYdR8WqrSlETX258jICt8pIim1fOOxUV9WEy8dfKSSpGJGbkdQEt0d
	 7G5Y7JikD6gRg==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
Cc: Chiara Meiohas <cmeiohas@nvidia.com>, Jonathan Corbet <corbet@lwn.net>, 
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-rdma@vger.kernel.org, Mark Bloch <mbloch@nvidia.com>, 
 Patrisious Haddad <phaddad@nvidia.com>, Yishai Hadas <yishaih@nvidia.com>
In-Reply-To: <cover.1741261611.git.leon@kernel.org>
References: <cover.1741261611.git.leon@kernel.org>
Subject: Re: [PATCH rdma-next v1 0/6] Introduce UCAP API and usage in mlx5
Message-Id: <174146181739.309515.6405198590405946645.b4-ty@kernel.org>
Date: Sat, 08 Mar 2025 14:23:37 -0500
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Thu, 06 Mar 2025 13:51:25 +0200, Leon Romanovsky wrote:
> Changelog:
> v1:
>  * Used kref primitives instead of open-coded variant
>  * Check return value from dev_set_name()
>  * Added extra brackets around type in UCAP_ENABLED macro
> v0: https://lore.kernel.org/all/cover.1740574943.git.leon@kernel.org
> 
> [...]

Applied, thanks!

[1/6] RDMA/uverbs: Introduce UCAP (User CAPabilities) API
      https://git.kernel.org/rdma/rdma/c/054220ae51ceca
[2/6] RDMA/mlx5: Create UCAP char devices for supported device capabilities
      https://git.kernel.org/rdma/rdma/c/dc0633dbb2abcc
[3/6] RDMA/uverbs: Add support for UCAPs in context creation
      https://git.kernel.org/rdma/rdma/c/8108812389cf29
[4/6] RDMA/mlx5: Check enabled UCAPs when creating ucontext
      https://git.kernel.org/rdma/rdma/c/984ec408e39bf8
[5/6] RDMA/mlx5: Expose RDMA TRANSPORT flow table types to userspace
      https://git.kernel.org/rdma/rdma/c/bec5f67b886710
[6/6] docs: infiniband: document the UCAP API
      https://git.kernel.org/rdma/rdma/c/850a5ea27782a5

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


