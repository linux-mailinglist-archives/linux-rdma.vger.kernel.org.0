Return-Path: <linux-rdma+bounces-6305-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C07B9E57D5
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Dec 2024 14:51:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2009A1883732
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Dec 2024 13:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ED06219A6F;
	Thu,  5 Dec 2024 13:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nwjaOSm7"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD66219A66
	for <linux-rdma@vger.kernel.org>; Thu,  5 Dec 2024 13:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733406656; cv=none; b=G/6UE7sTnnzJKZzlA5uG6bHbeEgSd7gL8etpmfnztf3EmPtLL5fFWU+hnNSwum6ArRz9xleu5V613CEnFFJBFXqviKEQfYf6bR1w/l8uDHXq1MhnBTjwsOrv9g5MSK68rvo4QzRiKD5EOwEOkGSnKwGZfCK3blyfnUhQ8Td1eUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733406656; c=relaxed/simple;
	bh=RPbbxUBk6QMnTYSHV6a6heM1slVPEotMVolGHI6GXGc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kEwmEP0Fe9Zr7HxIVYnkkbxl8IPa7kXXQ8Xwr4BPfQPR7lbFwbc7s4ZxvVo2Nnvonquk+03HibFsYNY0EhBs98PY1jWG45NHuUpS689p6ue0Eb+eH+1KmwNHI7vuprAnwMiF04T9sgL64g+16MJwBcmxN1QfkrGY2P34d1EaMEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nwjaOSm7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5741C4CED1;
	Thu,  5 Dec 2024 13:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733406656;
	bh=RPbbxUBk6QMnTYSHV6a6heM1slVPEotMVolGHI6GXGc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nwjaOSm7P7tb0ddFFW0+CpcLxx2AvmRtWbny5ssm5pdLrCxyLyh7VaTOpQsoE1GZZ
	 gLJaQSaKYY6r2wGPBAmCniRJixqCwc/OYpnqOkluDbCqQm8V/gMm+nrptzWe7WiSic
	 kxqMxGd3+U3+m89RA0udjMtck6RP33x6oYbLtwkuR3zAgRpJa9f0fXeaDu/oxQIYpH
	 lM+6jfgxaTFwKfPEFtdISKRs+a0DLCpFu615PBGM54lQiAFFR404TVvDOc19/22muv
	 Pi12gGK/U7mSBxnWB/GmZemQ4rhSZ08loLIJS++d7ShU0z/0IZ8rDUDJox3Jewnu2U
	 pHGtEbKuK1TPg==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Vlad Dumitrescu <vdumitrescu@nvidia.com>,
	linux-rdma@vger.kernel.org,
	Sean Hefty <shefty@nvidia.com>
Subject: [PATCH rdma-next 6/9] IB/cm: Set deadline when sending MADs
Date: Thu,  5 Dec 2024 15:49:36 +0200
Message-ID: <94e82976688780ac43f5719d86c6630228c2e590.1733405453.git.leon@kernel.org>
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

With the current MAD retry algorithm, the expected total timeout is
roughly (retries + 1) * timeout_ms.  This is an approximation because
scheduling and completion delays are not strictly accounted for.

For CM the number of retries is typically CMA_MAX_CM_RETRIES (15),
unless the peer is setting REQ:Max CM Retries [1] to a different value.
In theory, the timeout could vary, being based on
CMA_CM_RESPONSE_TIMEOUT + Packet Life Time, as well as the peer's MRA
messages.  In practice, for RoCE, the formula above results in 65536ms.

Based on the above, set a constant deadline to a round 70s, for all
cases.  Note that MRAs will end up calling ib_modify_mad which will
extend the deadline accordingly.

This allows changes to the MAD layer's internal retry algorithm without
affecting the total timeout experienced by CM.

[1] IBTA v1.7 - Section 12.7.27 - Max CM Retries

Signed-off-by: Vlad Dumitrescu <vdumitrescu@nvidia.com>
Reviewed-by: Sean Hefty <shefty@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/cm.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index 142170473e75..36649faf9842 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -36,6 +36,7 @@ MODULE_LICENSE("Dual BSD/GPL");
 
 #define CM_DESTROY_ID_WAIT_TIMEOUT 10000 /* msecs */
 #define CM_DIRECT_RETRY_CTX ((void *) 1UL)
+#define CM_MAD_TOTAL_TIMEOUT 70000 /* msecs */
 
 static const char * const ibcm_rej_reason_strs[] = {
 	[IB_CM_REJ_NO_QP]			= "no QP",
@@ -279,6 +280,7 @@ static struct ib_mad_send_buf *cm_alloc_msg(struct cm_id_private *cm_id_priv)
 	struct ib_mad_agent *mad_agent;
 	struct ib_mad_send_buf *m;
 	struct ib_ah *ah;
+	int ret;
 
 	lockdep_assert_held(&cm_id_priv->lock);
 
@@ -309,6 +311,17 @@ static struct ib_mad_send_buf *cm_alloc_msg(struct cm_id_private *cm_id_priv)
 	}
 
 	m->ah = ah;
+	m->retries = cm_id_priv->max_cm_retries;
+	ret = ib_set_mad_deadline(m, CM_MAD_TOTAL_TIMEOUT);
+	if (ret) {
+		m = ERR_PTR(ret);
+		ib_free_send_mad(m);
+		rdma_destroy_ah(ah, 0);
+		goto out;
+	}
+
+	refcount_inc(&cm_id_priv->refcount);
+	m->context[0] = cm_id_priv;
 
 out:
 	spin_unlock(&cm_id_priv->av.port->cm_dev->mad_agent_lock);
-- 
2.47.0


