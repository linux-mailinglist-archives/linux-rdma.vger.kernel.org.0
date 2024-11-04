Return-Path: <linux-rdma+bounces-5733-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B374A9BAE70
	for <lists+linux-rdma@lfdr.de>; Mon,  4 Nov 2024 09:47:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77E84283B5A
	for <lists+linux-rdma@lfdr.de>; Mon,  4 Nov 2024 08:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3597318C326;
	Mon,  4 Nov 2024 08:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SCWswPVc"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E59BA34;
	Mon,  4 Nov 2024 08:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730710015; cv=none; b=s3nB9GmgbBrH0PIa3Jf+XghQ1104CSK+CqisN8Rvk9Vxy6YWbMVVK095MXze/xALchOyy1x+ZwTyBUyyHmBXsSZy3Ds7eAMTIo5YDy4GixMcqGI6bYG0zlzkE9rM7NFbb53RKDrOEut2dPgpAPSwrlxox/WrSdUGHaz5zECOTQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730710015; c=relaxed/simple;
	bh=GXUklmKKu5s09QAYZKFDn2kAW2f8F22953+p7jkBS8w=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=pHNqD+QHEYjxmIx/gXJQDdBeWyjrSYwn24Y18cdSPbpPWZAVomvf2FCR+WcU/1VWrF/pLAXVUk7xyRPtMMcqfDF1iZOiwoyPmiOydvVuslpFnu8c9xfYqzOU+qhCcYk3AOzgBkFSH+L83iifiyX3hPDtrniWRDJY9oBhALVVwA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SCWswPVc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7295C4CECE;
	Mon,  4 Nov 2024 08:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730710014;
	bh=GXUklmKKu5s09QAYZKFDn2kAW2f8F22953+p7jkBS8w=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=SCWswPVcjza1xnej+IbAV4kFTwdU5Vxat3o1UbThR6quBeJ9qfolUFpmwnMJ1O5Zg
	 MciYBrgCC9ML4BTE0/J8G/pUIHqthjVzoJOrkLAXFEnyql3DERndXZHJTZGxQsyznb
	 9IIXNpDBjcz98TrNO4v9uIHDbudPJnuBSoJRIut1KskGP+kASUNGpwekzkutQGo+cB
	 owfPTtFgQsEWrhuEfDEQAwPvw3cXTqFp16Kx97q4juL6BnOraoKShU6JnYMmj2ORFr
	 HqEgdR7J7d3n0thiRZnxjDsoyIn7ss221nDyeG/eypH0Eltap3gCANZj9nrcv+7XFz
	 BXCnnKGaWIhgA==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
 Patrisious Haddad <phaddad@nvidia.com>
In-Reply-To: <cover.1730373303.git.leon@kernel.org>
References: <cover.1730373303.git.leon@kernel.org>
Subject: Re: [PATCH rdma-next 0/3] Allow parallel cleanup of HW objects
Message-Id: <173071001099.156548.3866842119477677232.b4-ty@kernel.org>
Date: Mon, 04 Nov 2024 03:46:50 -0500
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Thu, 31 Oct 2024 13:22:50 +0200, Leon Romanovsky wrote:
> This series from Patrisious adds a new device operation to allow the
> driver to cleanup HW objects in parallel to the ufile cleanup. This is
> useful for drivers that have HW objects that are not associated with a
> kernel structures and doesn't have any dependencies on other objects.
> 
> In mlx5 case, we are using this new operation to cleanup DEVX QP
> objects, which are independent from the rest verbs objects (like PD, CQ,
> e.t.c).
> 
> [...]

Applied, thanks!

[1/3] RDMA/core: Add device ufile cleanup operation
      https://git.kernel.org/rdma/rdma/c/e18f73a885df74
[2/3] RDMA/core: Move ib_uverbs_file struct to uverbs_types.h
      https://git.kernel.org/rdma/rdma/c/1e1faa6232cf05
[3/3] RDMA/mlx5: Add implementation for ufile_hw_cleanup device operation
      https://git.kernel.org/rdma/rdma/c/6c2af7e3ebe6b5

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


