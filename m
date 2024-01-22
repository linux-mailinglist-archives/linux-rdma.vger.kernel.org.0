Return-Path: <linux-rdma+bounces-685-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3019836ACB
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Jan 2024 17:34:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 121191C24CCB
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Jan 2024 16:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E35471474A7;
	Mon, 22 Jan 2024 15:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rEBmC+Om"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E84514691E;
	Mon, 22 Jan 2024 15:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705936631; cv=none; b=DG9dDM3mwuG8K9EGaxjLAZutUXtip4I5Qk1pOPooC6K54ChoKT+NN48LVvYUfMoLVA84xf3vVRy/NM2nbCSA8lDiM9O5UpzgRa5zdTFz2ySiNYgbVJluL2v4D1yT8PpQDhy8ClKDEAlTq9KjOmpy2UfMIDrYofgoywMFEvnZ8Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705936631; c=relaxed/simple;
	bh=zVd1vHkBWjOJeDjtpFzmGfRvb3/uYv7cnMKgXT3fNGE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q9dXAe5Ko3q2asnX0GmBIECFxFv1ZSNKQc4NdgHnz8DJY2fDtx3PKEJSi5vA7YR0hTggDmHUVJhKAc5aixY+Dnkwff+73GETonUpM16fxUdFR7flyVn9hB6otysWhnLhg8g9WtIavJ/UzNN/0oOsy5oMQqtfvVhy77dRR64sjO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rEBmC+Om; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65010C43390;
	Mon, 22 Jan 2024 15:17:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705936631;
	bh=zVd1vHkBWjOJeDjtpFzmGfRvb3/uYv7cnMKgXT3fNGE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rEBmC+OmX/kO2wBrmWQu05wlvbSaMlFRa2ewr8dL6G+I0hns14QfYzZR/lM81OzFT
	 Y6E5DZ+C3oMgVzAvQcg6nYRvURkb7YVKsUd2OXVJho0mCQuBVgENOOeGdbrNlYQv2y
	 4J/qg9D8yLZXb6Hb8ZyooVImkPYSNp8Ke8ku8kKObxIefTb8CYBb8QZKsdSPSZjLhk
	 3q17bLmY7t9LJImit/sQq0Pww0gG2cZ8xvENcG6QJbJilCtmGuPb0k1aBytoNXtnqz
	 bpQ4EyvVwxfC8lmhXpz+UglcfOpkUrI75nPPOgdi23g0kZL3ZQ0Ur/y21xKMUTU0fQ
	 wKlb6w5nPd0hw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jack Wang <jinpu.wang@ionos.com>,
	Leon Romanovsky <leon@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	neelx@redhat.com,
	linux-rdma@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 05/24] RDMA/IPoIB: Fix error code return in ipoib_mcast_join
Date: Mon, 22 Jan 2024 10:16:19 -0500
Message-ID: <20240122151659.997085-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122151659.997085-1-sashal@kernel.org>
References: <20240122151659.997085-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.267
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
index b9e9562f5034..805df1fcba84 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_multicast.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_multicast.c
@@ -558,6 +558,7 @@ static int ipoib_mcast_join(struct net_device *dev, struct ipoib_mcast *mcast)
 		spin_unlock_irq(&priv->lock);
 		complete(&mcast->done);
 		spin_lock_irq(&priv->lock);
+		return ret;
 	}
 	return 0;
 }
-- 
2.43.0


