Return-Path: <linux-rdma+bounces-681-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 37B658369F9
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Jan 2024 17:15:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B2701C244AD
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Jan 2024 16:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B161D12FF81;
	Mon, 22 Jan 2024 15:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B5KQNMqH"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A54C12FF79;
	Mon, 22 Jan 2024 15:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705936398; cv=none; b=UaFXqwp0BdKpmwpORjTVnUm5/8fMAcXBlnk3GuwNzaF3MIsqJMxURByZxSBgDn4yNgHqb8uk/Pljdm/glSPL5Gct37U9fkub3STJ2s9rPZ5gyUxqK7eI0Dat7XVh33X/oRC/FSRlhSA8+2QwkZ6xQoEystUDqBqkxxHfvBVBNqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705936398; c=relaxed/simple;
	bh=JdZ4z4Xi4Q7kOn2EGUL3jGM0m56Qx8gGSJ6XgYAkvAw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P5KPY4hOQDa2k/4IEh/JjAEoc9ikWSfybUKBpu2J0FWAxRaLw86E9M0Mm89XUP3ZExB4ZhiSQvArI8lCXdIQQ1CmEMVdo/xZN5xiUxJkygtiHVBKISwCHynWywcwXbBfJGcZNK1kMQGJq2fbc395s0jehbokPppUihhc1qTidxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B5KQNMqH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31899C433F1;
	Mon, 22 Jan 2024 15:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705936398;
	bh=JdZ4z4Xi4Q7kOn2EGUL3jGM0m56Qx8gGSJ6XgYAkvAw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B5KQNMqHYyaHx0mihtBHnYbyjISqG64Cx2CYrSGMwRCPeKmjHpgX+70uOQ/4ZKyMO
	 xAs6PF3n8mAqKBrCE+R5mL5ne/hedGes60GQfg4vGCt8RiMmc9dMhktYcc30IkeRA9
	 FqBPqw1C3tsxiwKa2X+Xfsa0qqtYe4p9TvT6A+UAtvYjYXIwBjvOfch2Sr1ZOVbKOe
	 0WWYTLr8dwjuHTqe2VHW9inR7RPBwZ5vQ4InJl4ojQ/MgYOsOkwNXLdqc+GGNp6tYO
	 j3OveHEbIvDgvXC12XKPED33E7mUPVnKpUzOlIM2jHO9TAaY/dO/Fv11kt/PUAmzzM
	 JC1bJHJgsUTKQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jack Wang <jinpu.wang@ionos.com>,
	Leon Romanovsky <leon@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	neelx@redhat.com,
	linux-rdma@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 06/35] RDMA/IPoIB: Fix error code return in ipoib_mcast_join
Date: Mon, 22 Jan 2024 10:12:03 -0500
Message-ID: <20240122151302.995456-6-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122151302.995456-1-sashal@kernel.org>
References: <20240122151302.995456-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.147
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


