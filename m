Return-Path: <linux-rdma+bounces-679-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 488DA83694B
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Jan 2024 16:58:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D47111F22AE3
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Jan 2024 15:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AD387E591;
	Mon, 22 Jan 2024 15:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uhWM56Fe"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 578CC7E58C;
	Mon, 22 Jan 2024 15:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705936203; cv=none; b=LNKDLBaDzbV07HSXcpRH7bkyUl28RhgBl/gWT3IkbaR06bZNBrXKmvM2HjYa56Iks9her58g974fXY+Wwe5l3sfpW3VUHjB+AELvCHtGH/mLr3sUvpgm1Pvq0GDYA7vDrrhAY93dWwxd5vbccPGVn0M5/bkmMvww2ENOTQVtqCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705936203; c=relaxed/simple;
	bh=JdZ4z4Xi4Q7kOn2EGUL3jGM0m56Qx8gGSJ6XgYAkvAw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pXS0MFH8mzkB+gCnDacCKBv1Yt6rYEhxjCYzkOPIAKzmqrR6LbAo2CzUDFYv7QzvTWO2sZpUxH9QHY3PKf8F1BB9SDCjRM20RJhPELOapQVKeiNnnUf+DjQBwEA2AYn7z8JTHTdKAh8QP1aXmKRhxj1Yravgw2Qik9A5mzJf++A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uhWM56Fe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 618A3C43390;
	Mon, 22 Jan 2024 15:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705936203;
	bh=JdZ4z4Xi4Q7kOn2EGUL3jGM0m56Qx8gGSJ6XgYAkvAw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uhWM56Fe3/PbeT9mADCzvcgYdhBjtA14gG6t0a3ys3C0T6P+bWR9lOj/IK8PNGwmn
	 k0EyhErVk7yhgf7vjzsiJcVtMHfPLEhz2k7T4veYtGnSwsXUpnlj3qS2xx8PoOmTH2
	 0Lydb7abMfBOqqtIhjoHBY1th+VBwrmjZlwxyVqELxKpO4G5ZeUq0812wQlXrSRsK2
	 8NBZMQHsItdn7FdsWsiaWvq1uBnL5MXYa3dGmsS14PicKIZ0G6i7xFA0vzHuyvccXF
	 0Ob6Mv5wUFupMnHHxk80pBjXpMWrqaBeFCJUPFauwo2TFF/v6tH25i8G9vhRcCJ6Nq
	 Ocmoxyi/oxc/g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jack Wang <jinpu.wang@ionos.com>,
	Leon Romanovsky <leon@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	neelx@redhat.com,
	linux-rdma@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 06/53] RDMA/IPoIB: Fix error code return in ipoib_mcast_join
Date: Mon, 22 Jan 2024 10:08:07 -0500
Message-ID: <20240122150949.994249-6-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122150949.994249-1-sashal@kernel.org>
References: <20240122150949.994249-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.74
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


