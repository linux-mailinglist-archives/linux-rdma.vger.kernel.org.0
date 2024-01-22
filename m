Return-Path: <linux-rdma+bounces-675-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 422A58366AD
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Jan 2024 16:06:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF8F1288D7B
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Jan 2024 15:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70B1A48CC7;
	Mon, 22 Jan 2024 14:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QCGPo+tt"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BBA8487BC;
	Mon, 22 Jan 2024 14:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705935391; cv=none; b=bSgLs5uGTgAOW0GFPI8dk6Qd9mJHZxj2UwKDEUriQ2FRnvS5WpdNKWkJ/N1pkNsZejroCS84huUaiGeWj9xdMo4EnE9v9D81CU01Lgc3ZlMUQjtTwdxR8BrXrhY6rI6f91swqAKbBElE5SOm3thv4gMYzNAsM1HsDkVj6Jhpaik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705935391; c=relaxed/simple;
	bh=JdZ4z4Xi4Q7kOn2EGUL3jGM0m56Qx8gGSJ6XgYAkvAw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BvH4AdSslM7FdraOLf6EQfiDEvKxlrpG4XQuOXnKBpwhYTl5GyyQs5gx7pOvXoqniC4QfnaQZZAA8HMM7jci3M2Ovv2NDe50zsHpRakWBtY7aokD6ORABAkwGcgdFof+sW/McgmMSijB0QgUTO1aQp2h4krMGu5GcxXQy2n0jhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QCGPo+tt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8660C433F1;
	Mon, 22 Jan 2024 14:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705935390;
	bh=JdZ4z4Xi4Q7kOn2EGUL3jGM0m56Qx8gGSJ6XgYAkvAw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QCGPo+ttxNmwUnX6vLjgfx1Xrfu/CwBhZvOQ5s3KGylrHrtD6PLfcnI5BebU1H/6k
	 u/qk4PxHY+Lr7AIab0GdTArrvgIPG2BEtAgkhfIkW2gqI5x+9xH6P3rUjKVnmGC20m
	 DQ0lw+CTXEdfpRZmXWSJspMnX/YYqXN/uuf0O0BXt0rFwhuwWj4AmwngaGNb1AGonk
	 JA+cPt7gjc/Zz3q70IHVklSLzGKs4nlnuHXy5k8J0YAPzxa2/EX0a7uA8VE2m0qFiK
	 N8ocoicPOZctxREFinvVsSuz3+GyYhfOZImq0A25ydVrs8BRiyvKZDqadE5v6dGNW5
	 LzTtTRefThKpA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jack Wang <jinpu.wang@ionos.com>,
	Leon Romanovsky <leon@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	neelx@redhat.com,
	linux-rdma@vger.kernel.org
Subject: [PATCH AUTOSEL 6.7 09/88] RDMA/IPoIB: Fix error code return in ipoib_mcast_join
Date: Mon, 22 Jan 2024 09:50:42 -0500
Message-ID: <20240122145608.990137-9-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122145608.990137-1-sashal@kernel.org>
References: <20240122145608.990137-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.1
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


