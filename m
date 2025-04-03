Return-Path: <linux-rdma+bounces-9135-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55372A7A0A9
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Apr 2025 12:09:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BEA23B1EBB
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Apr 2025 10:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0884242914;
	Thu,  3 Apr 2025 10:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XvEV8kPe"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A175D3C0B
	for <linux-rdma@vger.kernel.org>; Thu,  3 Apr 2025 10:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743674980; cv=none; b=rHy/hQT1TH4A3YO7B4CQdFW8pZEF6HzG0wUZABx8e1jF4wqV3Ikf0bsemCJkEeTKPQjqCAm8GeGvACb5gshitaa9jQ1oOf+VIHdMratur5uUb4yzlrtSfxszfLCvrVn+8disalncd2eFeS2/Vi/eIvtJPU7km/kxbupcBLNwgV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743674980; c=relaxed/simple;
	bh=G6IHi0Nomjgu7vD6VC+pnaPMSmwbDLNe8bp67I9iHHY=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=u/FNTgcRp7Ho3nGYILDh4BxFGclleEUpxHe0hSQuFbHAMxWRd6J9nCJddcqEmyHY68OlmXQvzSha1Q7J7R6/jjkvW9P4WuSYPzMerlzK8Q8z4qVRWnoYy/64tLduEbwo1o00s0vqNfMvhBTLMh724pGUK02NuZ9xZHywz5urCrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XvEV8kPe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBC59C4CEE9;
	Thu,  3 Apr 2025 10:09:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743674980;
	bh=G6IHi0Nomjgu7vD6VC+pnaPMSmwbDLNe8bp67I9iHHY=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=XvEV8kPejLtyr5sRx/Ze7zspWewI6G07MFL9mNadVfj+sMMd21VbOJerQCX2R4Jcl
	 59yHy4ahkKjX7olhI0XSdz5o2HXqFzPAhG1NVEdZFvckt81aw3VWSMcJE/9VVF85Id
	 jqlEP4p1bd67diH1W8PCdu7HChRbF8fMZtXYVpNfZ8yiJzRqmwjqR8mS6kLVH1pFym
	 IaMbF+ez1u/R6SdTpc9h01QsiMDrQS5aeSQyP/kn/Ccsoi2YQfT9qlHbuBBmNk7XqQ
	 ydPOEe1+2SijYhYRJ9tTiJxLWHyxIdbWlDm9trEYkXu8ppTUBpHg6cIQdTr3EyPjUK
	 gOkgPHZhqDAWQ==
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfauth.phl.internal (Postfix) with ESMTP id 95D971200068;
	Thu,  3 Apr 2025 06:09:38 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-12.internal (MEProxy); Thu, 03 Apr 2025 06:09:38 -0400
X-ME-Sender: <xms:Yl7uZ5Tcb36JxiK4-tQiOPHuFQEl70s4WAc0vGv736mTWG-5zc3zBA>
    <xme:Yl7uZyz_M07qe4y1qTx3bvhdaCR-KBhFiz5vDS4SDV0GFqfiEpMx5zmFXaX5BdsLW
    _2qUYTXQ7zduNoe938>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddukeekvdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertder
    tddtnecuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusehkvghrnh
    gvlhdrohhrgheqnecuggftrfgrthhtvghrnhepjeejffetteefteekieejudeguedvgfef
    feeitdduieekgeegfeekhfduhfelhfevnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomheprghrnhguodhmvghsmhhtphgruhhthhhpvghrshhonhgr
    lhhithihqdduvdekhedujedtvdegqddvkeejtddtvdeigedqrghrnhgupeepkhgvrhhnvg
    hlrdhorhhgsegrrhhnuggsrdguvgdpnhgspghrtghpthhtohephedpmhhouggvpehsmhht
    phhouhhtpdhrtghpthhtoheplhgvohhnsehkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hjghhgsehnvhhiughirgdrtghomhdprhgtphhtthhopehmsghlohgthhesnhhvihguihgr
    rdgtohhmpdhrtghpthhtohepphhhrgguuggrugesnhhvihguihgrrdgtohhmpdhrtghpth
    htoheplhhinhhugidqrhgumhgrsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:Yl7uZ-2FVV-YYFZWV-PaEKL22Ysb0zyDCWM8tSPnq1m8YTksrNp3TQ>
    <xmx:Yl7uZxBgHK8SAL3Szy5-4VIYksvi_mv0OSi_6Bcui-ZL2iv0U-KSiw>
    <xmx:Yl7uZygLZ7j2_K0aYkov4ZckydrpveAkVVrf7S7B10UwIS7XZ9U7KQ>
    <xmx:Yl7uZ1pMrJGOpZBmUHcsehUZcK0btwbv59srakBY9XXBG8K_Vl6bpA>
    <xmx:Yl7uZ9jvirTWv0UwvNPKIVIWRcz_gFNaRo_BBRsIPXlcDvltYF6ABGzW>
Feedback-ID: i36794607:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 690ED2220073; Thu,  3 Apr 2025 06:09:38 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T7d4c7476b56b3c54
Date: Thu, 03 Apr 2025 12:08:30 +0200
From: "Arnd Bergmann" <arnd@kernel.org>
To: "Mark Bloch" <mbloch@nvidia.com>, "Jason Gunthorpe" <jgg@nvidia.com>,
 "Leon Romanovsky" <leon@kernel.org>
Cc: "Patrisious Haddad" <phaddad@nvidia.com>, linux-rdma@vger.kernel.org
Message-Id: <4e7e983e-7aae-4318-b05b-0f9c8d88b930@app.fastmail.com>
In-Reply-To: <20250402070944.1022093-1-mbloch@nvidia.com>
References: <20250402070944.1022093-1-mbloch@nvidia.com>
Subject: Re: [PATCH rdma-next] RDMA/mlx5: Fix compilation warning when USER_ACCESS
 isn't set
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Apr 2, 2025, at 09:09, Mark Bloch wrote:
> The cited commit made fs.c always compile, even when
> INFINIBAND_USER_ACCESS isn't set. This results in a compilation
> warning about an unused object when compiling with W=1 and
> USER_ACCESS is unset.
>
> Fix this by defining uverbs_destroy_def_handler() even when
> USER_ACCESS isn't set.
>
> Fixes: 36e0d433672f ("RDMA/mlx5: Compile fs.c regardless of 
> INFINIBAND_USER_ACCESS config")
> Signed-off-by: Mark Bloch <mbloch@nvidia.com>

I've tested this on my randconfig build machine for a day now,
and saw no other problems with it.

Tested-by: Arnd Bergmann <arnd@arndb.de>

