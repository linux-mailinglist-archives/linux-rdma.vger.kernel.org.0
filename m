Return-Path: <linux-rdma+bounces-6375-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C1F59EAB2C
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Dec 2024 09:59:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 239411888706
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Dec 2024 08:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48C90230D17;
	Tue, 10 Dec 2024 08:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jm1sffvk"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0912223098A
	for <linux-rdma@vger.kernel.org>; Tue, 10 Dec 2024 08:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733821160; cv=none; b=p/E9V29WR5YhtFYsTx0bRmbMEWbJM77LIgpIbDLgUDX8wI/RJ8HQEIH+uqPTcRTBHlIeWcW7KSYWi3b1NFD7RikZHHMOUjt2JNb94inhdgr7j+xS2XgZORfK0Ny6flMhgHGeZ8JBlcppUtfAz/fuypPcamX6UqGc/zElu19mXtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733821160; c=relaxed/simple;
	bh=zrDSyVUwsQwuDvtddzCy9xuT4/5/rH9uP2u8Kmk7QRM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=QESeBLFgDaTJMub7PzsS3UxfikBpqYWdZ2oCW+G90nHrsrTkwUxoNyYS3MgsDI0su/yYhNdE+Qj6idoMFfiXcmbvR1l5br3/TdgL7WS3V/MZTY9eDQC+SuueyHoXprejPp/a/3H1pHN2aG5fI3Q243wJBlnom1jMoaIG4f+hIZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jm1sffvk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20BD7C4CEE3;
	Tue, 10 Dec 2024 08:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733821158;
	bh=zrDSyVUwsQwuDvtddzCy9xuT4/5/rH9uP2u8Kmk7QRM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Jm1sffvkpbsrMM68Sk06rwoTUyBtNR/XGUQdpyOnBjx7Bd4HfCkJYhwcC+HnlHua8
	 IBl0sZwKXh7lAOLVxxxPwGd8ljCuzIpWDYOL72RWgxIOd1u4ncIyqNFMpFd194TGFJ
	 J61krDPl9sJjDhXfFUV4WHrwN1FfCVB/EFOxESXkLFa/scmCXXvexMv7NJIP+zBxDj
	 TE/Z38l758n7d86hemgUtd0os6LU1lMBQLOYC5bY/sdR8vHviXwoRpyhV3uXE2pQby
	 i4iEIZxxYjg2+DVaHk1BatOqO683I7//vAI0rkgyU9asPMp4uEt8GypF7w2SpLKPOU
	 Vse+E6wi0ToPQ==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, 
 Anumula Murali Mohan Reddy <anumula@chelsio.com>
Cc: linux-rdma@vger.kernel.org, bharat@chelsio.com
In-Reply-To: <20241203140052.3985-1-anumula@chelsio.com>
References: <20241203140052.3985-1-anumula@chelsio.com>
Subject: Re: [PATCH for-rc v2] RDMA/core: Fix ENODEV error for iWARP test
 over vlan
Message-Id: <173382115388.4110998.12320888918451751022.b4-ty@kernel.org>
Date: Tue, 10 Dec 2024 03:59:13 -0500
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Tue, 03 Dec 2024 19:30:53 +0530, Anumula Murali Mohan Reddy wrote:
> If traffic is over vlan, cma_validate_port() fails to match
> net_device ifindex with bound_if_index and results in ENODEV error.
> As iWARP gid table is static, it contains entry corresponding  to
> only one net device which is either real netdev or vlan netdev for
> cases like  siw attached to a vlan interface.
> This patch fixes the issue by assigning bound_if_index with net
> device index, if real net device obtained from bound if index matches
> with net device retrieved from gid table
> 
> [...]

Applied, thanks!

[1/1] RDMA/core: Fix ENODEV error for iWARP test over vlan
      https://git.kernel.org/rdma/rdma/c/a4048c83fd87c6

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


