Return-Path: <linux-rdma+bounces-10029-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C9F61AAB064
	for <lists+linux-rdma@lfdr.de>; Tue,  6 May 2025 05:37:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50977189EA7D
	for <lists+linux-rdma@lfdr.de>; Tue,  6 May 2025 03:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E30F82FA104;
	Mon,  5 May 2025 23:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aWVQeEJk"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A292FAEA2;
	Mon,  5 May 2025 23:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746487385; cv=none; b=sJIRbUn0eg2XsDRNdsdD6zttCSeNZGydLrdKwg5fr5Qz2uyJQ17QkIE0gkbf3Jm+EMOAwFB3qk7eK4c3QIoylAwFvnM+9nC4H9GuXHnvCHZjou6N3pKL3u9JjQcjYJzLEo9e+OJW4FXelUcqTEBmCL5B5C5CJnPjaCjyBn/gZN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746487385; c=relaxed/simple;
	bh=KTy838vSImfgRkAZls9shdxJHt8SBKKLmKVJeLwAxaE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oHWXHcluQyRicnUBNjeyRdUZiI2wMeBjv9RhSgTTLiNc8aej1jnfq/e1BfhrTdP+0hZ8Np52LEt2Ypw+VtIW7METiQL0bRW1xWBJBfB0x5AmzcxefurCBFRLYFzjaEnq5xQ2KCDLc1KVbfk8RGUrRQMahlsLBlc7FrIaq5aNxUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aWVQeEJk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17E50C4CEE4;
	Mon,  5 May 2025 23:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746487384;
	bh=KTy838vSImfgRkAZls9shdxJHt8SBKKLmKVJeLwAxaE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aWVQeEJkFdeK7w7K9NTU9yCCH9wAfpoy+HachPrmlb8F9jk2VWV8my0dAnxnVFFSF
	 U517jWA4kO8+nP3Gb28cFDfu1oJb4o1iT4GPIZkNXts5wjrlyvQ79zbUXixrlrVbUi
	 f912ILY+QiK1fItrPdSM0dF5wUjNkd+g36bdvL6JdUPEkbGmID6oY8sbmOT7r8+Wlc
	 dpUkFAxDRLj5pwqYKC8b2qHgI+y/+MabMMnF+JBNst+r/LWlaAk7ibWjStndwRvA8p
	 vmxoE6//5cdCiPyPVN6bbi2HMaJAkdeXZ6G41oqxxzo8dcr1ui5/uqagNO0MzF4Psk
	 3PY0padauGIDw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Moshe Shemesh <moshe@nvidia.com>,
	Shahar Shitrit <shshitrit@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>,
	saeedm@nvidia.com,
	andrew+netdev@lunn.ch,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 41/79] net/mlx5: Avoid report two health errors on same syndrome
Date: Mon,  5 May 2025 19:21:13 -0400
Message-Id: <20250505232151.2698893-41-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505232151.2698893-1-sashal@kernel.org>
References: <20250505232151.2698893-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.293
Content-Transfer-Encoding: 8bit

From: Moshe Shemesh <moshe@nvidia.com>

[ Upstream commit b5d7b2f04ebcff740f44ef4d295b3401aeb029f4 ]

In case health counter has not increased for few polling intervals, miss
counter will reach max misses threshold and health report will be
triggered for FW health reporter. In case syndrome found on same health
poll another health report will be triggered.

Avoid two health reports on same syndrome by marking this syndrome as
already known.

Signed-off-by: Moshe Shemesh <moshe@nvidia.com>
Reviewed-by: Shahar Shitrit <shshitrit@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/health.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/health.c b/drivers/net/ethernet/mellanox/mlx5/core/health.c
index d4ad0e4192bbe..44e3f8cfecacb 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/health.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/health.c
@@ -736,6 +736,7 @@ static void poll_health(struct timer_list *t)
 	health->prev = count;
 	if (health->miss_counter == MAX_MISSES) {
 		mlx5_core_err(dev, "device's health compromised - reached miss count\n");
+		health->synd = ioread8(&h->synd);
 		print_health_info(dev);
 		queue_work(health->wq, &health->report_work);
 	}
-- 
2.39.5


