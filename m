Return-Path: <linux-rdma+bounces-7047-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9282BA14276
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Jan 2025 20:42:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 146DB3A3F3D
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Jan 2025 19:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90929231C8B;
	Thu, 16 Jan 2025 19:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UVdbgkkP"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DCA422E409;
	Thu, 16 Jan 2025 19:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737056525; cv=none; b=Y2b5nCjdLw/old0ZPmg8U8Jy9hgLj0B4IpOdrgzMctNy5TESWMi4H+J1BAsnpIKqJWwWJ4ZXdTLuS4QTscyN+pmkqeGbfj8o5fWVZnRa3SdoOfd1NzKURV5gDJSadIer0bW60AbLJXmfE7V91TPsHqx1MZSp9sbMeQZl+KX7pus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737056525; c=relaxed/simple;
	bh=oKoppv2OOBLirvwLeV0l9yiRg1FVzD1o0o8labWBews=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mkHyedFNEvyMPVWWzoJx2WO7gaYOackXK7pHfhOcPCot/D6DRTiELLVG3HzMG/1fFF4Wwu1o4N9YxlC7pJKocAvpA2bLbWuRJmKGWP82u3BM+vVX5Bf9X/U9Iz6kCdn/Xjh7KQcbF/z9dOkS4AWW6/v0D8Ui1PK2VWgVRqJVIsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UVdbgkkP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4D5EC4CED6;
	Thu, 16 Jan 2025 19:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737056525;
	bh=oKoppv2OOBLirvwLeV0l9yiRg1FVzD1o0o8labWBews=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UVdbgkkPVNQvaJkuUwF7vyExPXtjHtAzrXscBU7D4GEHkKLbGDl7iK1Rh/+kfvfjF
	 NKrGmZi8eBVAV3Ih3WBSNncEe/WNFUo2OKWuAE7yFH4A0BRhBW2gN4hV1Cu4MbcJA/
	 2d9YQ4bZ8MzjuXjmFApDeSxeF8ib/L9/u8XdF0mc6o2CuVjaC/0+kgoY7isFlde50q
	 4JHuvwH/i7Ib0VGXEJKraD3PcIV5UbWsRW5W9/UG49k1WJQEGdMpSI6DJSu3bpRM6E
	 QEOBc0llbf92q3LxkV8blmb2bPKQ1WrghBS9PdMgZ3i4wCs9qKwd7nzkz9oFxcNePS
	 RBtNppG7n6Kew==
Date: Thu, 16 Jan 2025 09:42:03 -1000
From: Tejun Heo <tj@kernel.org>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Maxime Ripard <mripard@kernel.org>,
	Maarten Lankhorst <dev@lankhorst.se>,
	Friedrich Vock <friedrich.vock@gmx.de>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	dri-devel@lists.freedesktop.org, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH next] cgroup/rdma: Drop bogus PAGE_COUNTER select
Message-ID: <Z4lhC8DUFdLc4A3d@slm.duckdns.org>
References: <b4d462f038a2f895f30ae759928397c8183f6f7e.1737020925.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b4d462f038a2f895f30ae759928397c8183f6f7e.1737020925.git.geert+renesas@glider.be>

On Thu, Jan 16, 2025 at 10:56:35AM +0100, Geert Uytterhoeven wrote:
> When adding the Device memory controller (DMEM), "select PAGE_COUNTER"
> was added to CGROUP_RDMA, presumably instead of CGROUP_DMEM.
> While commit e33b51499a0a6bca ("cgroup/dmem: Select PAGE_COUNTER") added
> the missing select to CGROUP_DMEM, the bogus select is still there.
> Remove it.
> 
> Fixes: b168ed458ddecc17 ("kernel/cgroup: Add "dmem" memory accounting cgroup")
> Closes: https://lore.kernel.org/CAMuHMdUmPfahsnZwx2iB5yfh8rjjW25LNcnYujNBgcKotUXBNg@mail.gmail.com
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun

