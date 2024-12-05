Return-Path: <linux-rdma+bounces-6308-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7E959E57D9
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Dec 2024 14:51:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B19518836F2
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Dec 2024 13:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFD73219A92;
	Thu,  5 Dec 2024 13:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u03dUrsI"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A82219A8B
	for <linux-rdma@vger.kernel.org>; Thu,  5 Dec 2024 13:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733406667; cv=none; b=EJc8MnU6qPhfYWoMOtKjQn0VMdQj7mutFad8jpb62/wn7iapdZqqaX7jmSy4CjpJLC6gEQeJkjPopT6mKM+QNhbl7HhNGpTRcZHGJCuRrLM3JNaC/p9HXQwI8puENogZZEkDAmBZikyaO/PbmTXo7KTXkHC6q1QwgiSCkjU1q2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733406667; c=relaxed/simple;
	bh=V554t4N8qQN+JBMC9l/npfafQer+nglMEicPSpXa1MQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PGvGW8njwCiOrMLVEwRVXKR01ipP9dDRXA9gWl9YyTfBPUUeA6KlSutVwGN8Bq+DAm+jBxjGXe0FI+QxA9SIu21yHOi9ZcWJDn8QkZoYx99W2TABajWXiDSXsB91OrnsBPopbN3YLCn5qiPSM0JTwn4Db0wMSBsHz7Oc+CwxeM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u03dUrsI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 925A7C4CED1;
	Thu,  5 Dec 2024 13:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733406667;
	bh=V554t4N8qQN+JBMC9l/npfafQer+nglMEicPSpXa1MQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u03dUrsIfYlSQsam3aK18R4jiMaI0Oxl/K1lfKptcxa9xFswXGDQ5DK6Dc2gDdTuM
	 aJjMk9iBf1scwGnEhc4VOhqy4yV1YOgwuU9fSS1khnGUsRSGKPfcpxAz7M5wE/Af1u
	 UGuBDUKrYCubVV9r/S665GAWeMOAKCI4L+WQdQkk4o9//YaFViCtRZi8miU/bzd6S1
	 tbqRfM9cddinRrfchVdu29LqqSqNSHKMpane/0lDigRZf4/oQ81AggrySD3TC6DL+W
	 W55iMQJMWJQ7KcohutmZsnesDDzh5pZAbyIp2aqCixFsdS0o9kMNwkQ7ahN7TZDkfW
	 PIEaPPKFTae6A==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Vlad Dumitrescu <vdumitrescu@nvidia.com>,
	linux-rdma@vger.kernel.org,
	Sean Hefty <shefty@nvidia.com>
Subject: [PATCH rdma-next 9/9] IB/cma: Lower response timeout to roughly 1s
Date: Thu,  5 Dec 2024 15:49:39 +0200
Message-ID: <7ff4bf69f132a204570eded9ff6788316df3e3b4.1733405453.git.leon@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1733405453.git.leon@kernel.org>
References: <cover.1733405453.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vlad Dumitrescu <vdumitrescu@nvidia.com>

Current CMA_CM_RESPONSE_TIMEOUT converts to 4096ms, which is high for
(low latency) RDMA networks.  Match TCP's initial RTO of 1s (RFC 6298).

Rely on the recently added MAD layer exponential backoff to
counter-balance this reduction in case of persistent loss.

Signed-off-by: Vlad Dumitrescu <vdumitrescu@nvidia.com>
Reviewed-by: Sean Hefty <shefty@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/cma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index 64ace0b968f0..ec4141b84351 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -44,7 +44,7 @@ MODULE_AUTHOR("Sean Hefty");
 MODULE_DESCRIPTION("Generic RDMA CM Agent");
 MODULE_LICENSE("Dual BSD/GPL");
 
-#define CMA_CM_RESPONSE_TIMEOUT 20
+#define CMA_CM_RESPONSE_TIMEOUT 18
 #define CMA_MAX_CM_RETRIES 15
 #define CMA_CM_MRA_SETTING (IB_CM_MRA_FLAG_DELAY | 24)
 #define CMA_IBOE_PACKET_LIFETIME 16
-- 
2.47.0


