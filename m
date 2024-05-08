Return-Path: <linux-rdma+bounces-2339-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C6D38BF86C
	for <lists+linux-rdma@lfdr.de>; Wed,  8 May 2024 10:23:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 322171F26B5E
	for <lists+linux-rdma@lfdr.de>; Wed,  8 May 2024 08:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3BDA446D5;
	Wed,  8 May 2024 08:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sfnNeqHs"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50292C861
	for <linux-rdma@vger.kernel.org>; Wed,  8 May 2024 08:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715156605; cv=none; b=q9YpEPVC0ohC1VTfqVAZMfzRIAB2qkQpc44/VKScKVHhF8zCW+S9TF3i40JfggPfer0yGDVe9aci6klwnHW3U196aTd0RFikLTm89p6qj5hZ4cQUBgYsi7QQNYF6s1qSwZS8Fr+iEmcxAr0CNXO/hp6wN+jRcEFTKM9EwMCEU8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715156605; c=relaxed/simple;
	bh=UxiQWB3WnxAwxf2L2635Qwc9AV8OOgw+pXZCt8eKGu8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=f6qplmuem6FQoMOFng3+Crmtytke+6ofOQwiU37besEHA3zFPO5LYYs04NnxUZkuBRdd2OWrJfAmDTOQXk09Xo9Fp8q6Yi3SmoeanWzE+MGDHvnL1WM/BD2K2rlMC4JhpySPO4khwxGvGE99oCog0siiQxxFYjxNEQUBnRPMp3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sfnNeqHs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6367C113CC;
	Wed,  8 May 2024 08:23:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715156605;
	bh=UxiQWB3WnxAwxf2L2635Qwc9AV8OOgw+pXZCt8eKGu8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=sfnNeqHs5zH8MdEmz1DInGKnbS0Vknx87uX8vxolOvYREcJ+BQ11xRc/7icfXSwJs
	 Gq+VzNCTyvSG9+10tN/oIQsZfBVHHtOpK9LQU6lXbIsk6dM+tBQ2krRw1GiVtXzVaN
	 btz7xt0ofTsFrMtD2J63wmO6mTtA5tSg1hSNZnpxplk0XLqNsKqL//hqmXj7J/oSrJ
	 +qqKhRcyCBIPtcujpt4Om7FBiesWwKanIiOGCqMV5MS7QCudVtytSQMIeY/2Kk+uj6
	 swziygy3iKpM3BEvnafRzcjnuDjBhDwV0lNBPmzPKfKyBySP0uM+GM6SsJG3BKu5ie
	 4DfqprimsCGxQ==
From: Leon Romanovsky <leon@kernel.org>
To: linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>, 
 Michael Margolin <mrgolin@amazon.com>
Cc: sleybo@amazon.com, matua@amazon.com, gal.pressman@linux.dev, 
 Daniel Kranzdorf <dkkranzd@amazon.com>, Firas Jahjah <firasj@amazon.com>
In-Reply-To: <20240506151829.6475-1-mrgolin@amazon.com>
References: <20240506151829.6475-1-mrgolin@amazon.com>
Subject: Re: [PATCH for-next v2] RDMA/efa: Support QP with unsolicited
 write w/ imm. receive
Message-Id: <171515660135.221862.16854907913390436638.b4-ty@kernel.org>
Date: Wed, 08 May 2024 11:23:21 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev


On Mon, 06 May 2024 15:18:29 +0000, Michael Margolin wrote:
> Add a new EFA flags attribute for QP creation, and support unsolicited
> write with immediate flag. QPs created with this flag set will not
> consume receive work requests for incoming RDMA write with immediate.
> Expose device capability bit for this feature support.
> 
> 

Applied, thanks!

[1/1] RDMA/efa: Support QP with unsolicited write w/ imm. receive
      https://git.kernel.org/rdma/rdma/c/2b8af5001abdf5

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


