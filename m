Return-Path: <linux-rdma+bounces-677-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 88F99836882
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Jan 2024 16:38:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8FF50B2A4AA
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Jan 2024 15:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF6C860B96;
	Mon, 22 Jan 2024 15:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W9+8jktL"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AECE60B8F;
	Mon, 22 Jan 2024 15:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705935888; cv=none; b=AM6/64EJh508LKbeJbUMDZUNgLrGXfEGUTkgLy1bWegShTCh7BcmnTgDcvT+CF9+FAO4CSnUR5GwZurFmMh1VeY+wMvocOdeQ4Uf9vQwTipgCjuaUl1ReoHhkdZPW76WXlzq/gi6sRax9r7B9DmDZNjljdJuh/zPEZafw8bY1zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705935888; c=relaxed/simple;
	bh=JdZ4z4Xi4Q7kOn2EGUL3jGM0m56Qx8gGSJ6XgYAkvAw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=avXb/OG/umNY5l67U0+l1c+qbnVbkRj8XgxeGp9toKWacQNar9b8NzkOnh89vmh3I4l0dJOdModoTxXCjCq5AceG/RelCVK3tvlvflsRSm+ABKRuvrZ2U/l7t3YUR1idT2ooqjrWF3Gy3WFKDqRgUiu39JdNm5gxOHy+cXWhWRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W9+8jktL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50470C433A6;
	Mon, 22 Jan 2024 15:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705935888;
	bh=JdZ4z4Xi4Q7kOn2EGUL3jGM0m56Qx8gGSJ6XgYAkvAw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W9+8jktLcNnTGtRiUL44rhlYboejL6bJSOOSzRtkRPy41ecEfeeacYS2MRhYM1/2G
	 cXk7UygFF0vWPTqMSnk6TxVtpuhacl/la6KtSFuVEzvv9niufsVw+kMXz55dU2pZRz
	 LugQV8iwqiCaVSPXw9hpW7dJNZsdJrnOas2B3oF0GKDrUurNk7aB8UfdjkMEucdpf/
	 d84GNeztDPX92KWhAsJ2Cq49SRD+bxD1U7cJDFDmhEKcQpOxzx6bzClkYlBuKjbWZy
	 i7ErAdBalOD+YgcA+64C5vt3eZjl+izio2wFBQ96rrDhQo/yQy7l0x7KyV9yYAKeKH
	 N6b8j7mCinlig==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jack Wang <jinpu.wang@ionos.com>,
	Leon Romanovsky <leon@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	neelx@redhat.com,
	linux-rdma@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 07/73] RDMA/IPoIB: Fix error code return in ipoib_mcast_join
Date: Mon, 22 Jan 2024 10:01:21 -0500
Message-ID: <20240122150432.992458-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122150432.992458-1-sashal@kernel.org>
References: <20240122150432.992458-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.13
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
index 5b3154503bf4..9e6967a40042 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_multicast.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_multicast.c
@@ -546,6 +546,7 @@ static int ipoib_mcast_join(struct net_device *dev, struct ipoib_mcast *mcast)
 		spin_unlock_irq(&priv->lock);
 		complete(&mcast->done);
 		spin_lock_irq(&priv->lock);
+		return ret;
 	}
 	return 0;
 }
-- 
2.43.0


