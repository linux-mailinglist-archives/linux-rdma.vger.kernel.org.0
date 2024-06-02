Return-Path: <linux-rdma+bounces-2752-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 666AD8D7446
	for <lists+linux-rdma@lfdr.de>; Sun,  2 Jun 2024 10:30:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC300B20D83
	for <lists+linux-rdma@lfdr.de>; Sun,  2 Jun 2024 08:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE9D41CD16;
	Sun,  2 Jun 2024 08:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E+wtuyFb"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862A7469D
	for <linux-rdma@vger.kernel.org>; Sun,  2 Jun 2024 08:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717317034; cv=none; b=quVHhDJEO3rx/zSWfx/oYznOOYMBmEgS6NiGqx7MsdhRUbxfJ2ycks2HFLUdJQwuePtXMhv0FsFtaaFvo+K4sLlEh15liHK5bA9YsH6IDV7/sT57PP3zfponivzcWGMSeESnoLN9XHNijHGCSP+yOXL4dnAFJPAQ8c9qTkloqCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717317034; c=relaxed/simple;
	bh=5kZBMMKdVZ9Atf9gE2ZRlFEDNG8VtmoJaJHIpviShOI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=n2z9uiG+t1rnPQMxdvWXiaVmEBXmZF6GmGPYJHtx2tiLlWQ6j0U9xZVQf0MuDD/NgtY8KEwEhnBISHo76YZ1VKmguEnVIOxuIeKSTipqIEUMzu0IqTjVu/Yk80yWrdcVSDWrc8HO8gKTymS36VZLX283B5vOhxY7HeV7SQz9JUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E+wtuyFb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49C16C2BBFC;
	Sun,  2 Jun 2024 08:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717317034;
	bh=5kZBMMKdVZ9Atf9gE2ZRlFEDNG8VtmoJaJHIpviShOI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=E+wtuyFbH1GSaGnBRHv21ZuU1O7npomMZYF0OQ1tVHW3AfW/AqUzr1gjgfCzmKB9f
	 xRwnlI9cPkOyJ2RY0+ggnQV+6QQv3o+uJTagRUetZvuof53/9X9TFEPjbjOWltpSak
	 n9lYC18WhOqT3We3nErFEwG6ijvcwrubfM5bH7rDxplWkizUjPH36GKVJrCKWAUgab
	 xs7kTKB6x6lnUBijrYqbOb2NcgsF0G889LgCC9QAqC0SFiec4gIyjWKsgOvtmtmUPC
	 mbHpVLXes03CLIRtIzDNtAZBXfghrybQy9qCY3uT46w8J4V/LPoLyRT8bSfvSk3ofO
	 ofsoVmDOVAXXQ==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
Cc: linux-rdma@vger.kernel.org, Mark Zhang <markzhang@nvidia.com>, 
 Michael Guralnik <michaelgur@nvidia.com>, Or Har-Toov <ohartoov@nvidia.com>, 
 Patrisious Haddad <phaddad@nvidia.com>, Yishai Hadas <yishaih@nvidia.com>, 
 Leon Romanovsky <leon@kernel.org>
In-Reply-To: <cover.1716900410.git.leon@kernel.org>
References: <cover.1716900410.git.leon@kernel.org>
Subject: Re: [PATCH rdma-rc 0/6] Batch of mlx5 fixes for v6.10
Message-Id: <171731702935.679323.4920994492251966989.b4-ty@kernel.org>
Date: Sun, 02 Jun 2024 11:30:29 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev


On Tue, 28 May 2024 15:52:50 +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Various fixes which I collected during the last few weeks.
> 
> Thanks
> 
> Jason Gunthorpe (3):
>   RDMA/mlx5: Remove extra unlock on error path
>   RDMA/mlx5: Follow rb_key.ats when creating new mkeys
>   RDMA/mlx5: Ensure created mkeys always have a populated rb_key
> 
> [...]

Applied, thanks!

[1/6] RDMA/cache: Release GID table even if leak is detected
      https://git.kernel.org/rdma/rdma/c/3ac844148b9b80
[2/6] RDMA/mlx5: Remove extra unlock on error path
      https://git.kernel.org/rdma/rdma/c/36e1ea42751ce8
[3/6] RDMA/mlx5: Follow rb_key.ats when creating new mkeys
      https://git.kernel.org/rdma/rdma/c/0f28eefd6bdb6c
[4/6] RDMA/mlx5: Ensure created mkeys always have a populated rb_key
      https://git.kernel.org/rdma/rdma/c/7322d666dbd55f
[5/6] RDMA/mlx5: Fix unwind flow as part of mlx5_ib_stage_init_init
      https://git.kernel.org/rdma/rdma/c/6bb41bed95ec39
[6/6] RDMA/mlx5: Add check for srq max_sge attribute
      https://git.kernel.org/rdma/rdma/c/c405e9cac10239

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


