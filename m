Return-Path: <linux-rdma+bounces-6301-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE8269E57CE
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Dec 2024 14:50:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 969FD284242
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Dec 2024 13:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CBDB219A78;
	Thu,  5 Dec 2024 13:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g7whkiMH"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD78218EAF
	for <linux-rdma@vger.kernel.org>; Thu,  5 Dec 2024 13:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733406642; cv=none; b=fn0yPH0c9nys1/KuzpaXjpjmrolOXI6ShCinBccWHvTsmcTlzYa7QDKSEr9uoZiyAFMJpHi8nirwulUNuQ+7NcTWa+W4rK+1A7JuLU1eqknTx9k07XFB61V6eJRoivSJXL+sD/s1DCKV+qp26KlP/75CmAA9w513eiqJhAxAJ/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733406642; c=relaxed/simple;
	bh=L4BZ+9Q6I3k4gyiXav/kuyPNUbzeOrJ8tE/7fSExGvQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TSeUFpWtBFY/YZyvayHBWjgxA/o7GCKiTVSLEmYpCmPz94B9WIdjfmYy3ZAMqAPsywppUNVOgdGWYEBc9WlvSKQL8HGkItEmMB3OAFTUkyib4hDJ8IueV4dNtnypKC/1vyxsVsaU9QnnNWhhnqFawkwKXPKPwczY/1637Ck3tSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g7whkiMH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F36D4C4CED1;
	Thu,  5 Dec 2024 13:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733406641;
	bh=L4BZ+9Q6I3k4gyiXav/kuyPNUbzeOrJ8tE/7fSExGvQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g7whkiMHqJPkTiQLkM+fnYWmvzwKqpEMhaU9gz1Ux0p1DwwtNxZIkZc5orAF2hM46
	 YzdUY/m6GTOvhibQunc7QjtbgCNPJYSLxdaOjWS9v9G0kPu2MQnO5gmDLcgJFQOaS9
	 qPe8j55jNkPhLck3mEDtDU93je/UXYBsLCpmDhFT23f2Q1LHTtKqjJzLMvf3pZ8IpL
	 mPHk39riYAB1WaZBpFGDye57z/p2iYMtVuikHOuVpavEqX4v26ryA7h30yEAKe5wjq
	 LjCz4RqXEusrtkhTfT8l15jIzyiHPOePKgrcLvUpER+AWOU24mJyWT3voJeE0wojAd
	 VbN5Yl/u+ByCg==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Vlad Dumitrescu <vdumitrescu@nvidia.com>,
	linux-rdma@vger.kernel.org,
	Sean Hefty <shefty@nvidia.com>
Subject: [PATCH rdma-next 1/9] IB/mad: Apply timeout modification (CM MRA) only once
Date: Thu,  5 Dec 2024 15:49:31 +0200
Message-ID: <14281da695b89e5d58890996f29d15145d85b960.1733405453.git.leon@kernel.org>
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

ib_modify_mad with non-zero timeout is used exclusively for CM MRA [1].
The timeout is computed as the sum of the local timeout (set via
cm_init_av_by_path) and a constant 60s+ Service Timeout
(CMA_CM_MRA_SETTING) passed via the MRA message by the remote.  MRAs are
generated when duplicate messages are received.

Overwriting send_buf.timeout_ms means the MRA Service Timeout requested
by the remote will apply to all remaining retry attempts.  This can lead
to unnecessary and extreme delays when a receiver is only temporarily
overloaded.

Do not save the MRA timeout so that it only applies to the next retry.

ib_modify_mad is also called with a zero timeout, to implement
ib_cancel_mad.  The timeout was also saved in that case, but it is not
required as timeout_sends will skip the retry_send (which reads the
saved value) call anyway, based on the non-successful status.

[1] IBTA v1.7 - Section 12.6.6 - MRA - Message Receipt Acknowledgment

Signed-off-by: Vlad Dumitrescu <vdumitrescu@nvidia.com>
Reviewed-by: Sean Hefty <shefty@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/mad.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/infiniband/core/mad.c b/drivers/infiniband/core/mad.c
index 86e846b12e2f..bcfbb2a5c02b 100644
--- a/drivers/infiniband/core/mad.c
+++ b/drivers/infiniband/core/mad.c
@@ -2623,7 +2623,6 @@ int ib_modify_mad(struct ib_mad_send_buf *send_buf, u32 timeout_ms)
 	if (!timeout_ms)
 		mad_send_wr->status = IB_WC_WR_FLUSH_ERR;
 
-	mad_send_wr->send_buf.timeout_ms = timeout_ms;
 	if (mad_send_wr->state == IB_MAD_STATE_SEND_START ||
 	    (mad_send_wr->state == IB_MAD_STATE_QUEUED && timeout_ms))
 		mad_send_wr->timeout = msecs_to_jiffies(timeout_ms);
-- 
2.47.0


