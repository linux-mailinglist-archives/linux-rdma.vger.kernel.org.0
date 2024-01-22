Return-Path: <linux-rdma+bounces-687-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F16F7836B35
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Jan 2024 17:41:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3077E1C238FD
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Jan 2024 16:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B82D114F559;
	Mon, 22 Jan 2024 15:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fjHMK1Ar"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E9414F550;
	Mon, 22 Jan 2024 15:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705936715; cv=none; b=Xt1zoYHQtTa1NQIrDrMCcGIWmglmz2gaZa3E4dlfOgUCpyWl+20NYEgzhlEY2ClWfQnUkSikHUnPV2R1YxU3t7EGNQ5EJUzwAYjyO4LAiVswZFPH+aBRNkzX9DT85SIbodhT57iZfXzPnyjbO4SdMlUwQ58f8n3kv5FAXsJ0xnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705936715; c=relaxed/simple;
	bh=zVd1vHkBWjOJeDjtpFzmGfRvb3/uYv7cnMKgXT3fNGE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rqgSW4OCVWbnmGt3jIO5aVPIwZuOtPY8DM8ZhI5eZoYKXIb5n+3lR6KgaMnokF9StfFq3capNpPHEBXXkwc0Yo7p0MRLTEve5pMa82K59DIV3KfBXuctH9oGfU+VHaUUCJ3lTXiZFUuhUYA70c6uj2nPa5zn023yF16f/Qa2Wrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fjHMK1Ar; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A378C433F1;
	Mon, 22 Jan 2024 15:18:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705936715;
	bh=zVd1vHkBWjOJeDjtpFzmGfRvb3/uYv7cnMKgXT3fNGE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fjHMK1ArK1f+NCs/mKKz3pRb4ILls9hY/49pik4VX1ZGhmWPHBKUbYVujTUHeAi/T
	 87XJ0t9PThQy8CwdEQ1PCPyIbCI9xxOz8lMgk6/RM0B+m/aA60nPgWqFS9qxuuBtxs
	 HiwQOEvi5YKLcKnTIQOTZBXU9EaDb0pKLv//kT919lazSwyMeXvWyYJR70lp3PoYHD
	 xcb8lxR+fhdIsJ3gZLrxMgR+Zg6Laviao25iptaRe68waNFQRlyjiKrmrqXnlY5Nrc
	 wqKJAurDf+xfqTxaEOdMr+b5zYSVHrv9DhpXQS/L1xZS/PO93gr+RqkgQIaSLpfcup
	 V9DaPCFRrVCCw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jack Wang <jinpu.wang@ionos.com>,
	Leon Romanovsky <leon@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	neelx@redhat.com,
	linux-rdma@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 05/23] RDMA/IPoIB: Fix error code return in ipoib_mcast_join
Date: Mon, 22 Jan 2024 10:17:45 -0500
Message-ID: <20240122151823.997644-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122151823.997644-1-sashal@kernel.org>
References: <20240122151823.997644-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.305
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


