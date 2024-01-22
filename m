Return-Path: <linux-rdma+bounces-683-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4E31836A62
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Jan 2024 17:26:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D75F1F245BA
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Jan 2024 16:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EED0013AA47;
	Mon, 22 Jan 2024 15:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NADIfuXQ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA26313B791;
	Mon, 22 Jan 2024 15:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705936535; cv=none; b=US5xN+L2QS/LU79G999ZsBe+d5QfezaddIkrc9JdzjLyLmWPv6DO3wmaZTs6ES7eprHDx7lL7JBp0h3n3qG9chnoAqeknuWZ18htkZWUEs1w5rGZPpg2WVl9D4v+CO3VJuYN2T962fdwO1k0ffFdNEeAt2NcEFgjsnxiOTpBT04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705936535; c=relaxed/simple;
	bh=cWo7YuSlunsz7usgTvxCagPcAzLZJnbyK/Mk14vIiB0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dbVngVBmQhRYZ9cPyassIcZSjA0iUEIfIvpI6/Scorsc4n0tlqflh8KTUTtNNMHn/Aw6yq8OJ+TX/DuJ0F0DN316uCZZGcq9UWTy274Spz1IhNTIyBeysn/1YyEXXJ4ZQnhf3Vb5PYPqULA9u/tL5x/UARuMZT8OUMtP7MfIP9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NADIfuXQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20D2CC433C7;
	Mon, 22 Jan 2024 15:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705936535;
	bh=cWo7YuSlunsz7usgTvxCagPcAzLZJnbyK/Mk14vIiB0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NADIfuXQ78/53DYJVkWSzsGW3zan89wwFxeClvshxWu4lSdnjRtpyAO4002YbcxUB
	 zLVFs+sM0m10R2bXcQPrNyiQ5kEYTn0p1ZVqfQpwhBclT7L/eP8KeOE6HL+qxIpRBB
	 bryCwrM/FLxf6q3TAAAiAsb67eogzU1xCz6/YPC9DhQOnNFNemY6moQuaMj7x7tCrc
	 FddeYAHS6nZnyhGigxnp8WafdvDWlizK7fGUnPICwWDr5gcvYjUGy4WJIpTAOdMrZR
	 ZI6pDsiz29r3513VeGUx2pD4xHKz1Mh2o50lp9zX2AACJ4t167rNWBrUD6POy2arhx
	 pyVC41R2IWsBQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jack Wang <jinpu.wang@ionos.com>,
	Leon Romanovsky <leon@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	neelx@redhat.com,
	linux-rdma@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 06/28] RDMA/IPoIB: Fix error code return in ipoib_mcast_join
Date: Mon, 22 Jan 2024 10:14:32 -0500
Message-ID: <20240122151521.996443-6-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122151521.996443-1-sashal@kernel.org>
References: <20240122151521.996443-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.208
Content-Transfer-Encoding: 8bit

From: Jack Wang <jinpu.wang@ionos.com>

[ Upstream commit 753fff78f430704548f45eda52d6d55371a52c0f ]

Return the error code in case of ib_sa_join_multicast fail.

Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
Link: https://lore.kernel.org/r/20231121130316.126364-2-jinpu.wang@ionos.com
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/ulp/ipoib/ipoib_multicast.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/infiniband/ulp/ipoib/ipoib_multicast.c b/drivers/infiniband/ulp/ipoib/ipoib_multicast.c
index 86e4ed64e4e2..5633809dc61e 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_multicast.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_multicast.c
@@ -557,6 +557,7 @@ static int ipoib_mcast_join(struct net_device *dev, struct ipoib_mcast *mcast)
 		spin_unlock_irq(&priv->lock);
 		complete(&mcast->done);
 		spin_lock_irq(&priv->lock);
+		return ret;
 	}
 	return 0;
 }
-- 
2.43.0


