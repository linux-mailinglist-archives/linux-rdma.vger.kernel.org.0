Return-Path: <linux-rdma+bounces-17844-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QOqBEiKUr2kragIAu9opvQ
	(envelope-from <linux-rdma+bounces-17844-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Mar 2026 04:46:42 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DA9CB244FCF
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Mar 2026 04:46:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 78F553035A40
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Mar 2026 03:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADE3C399007;
	Tue, 10 Mar 2026 03:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R+OwhDdf"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716822C11E8
	for <linux-rdma@vger.kernel.org>; Tue, 10 Mar 2026 03:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773114394; cv=none; b=aIg+Dj3+AADuQKQM930fJvCFTIGam+pWKWd6mHHYN+FCuD/CbW0orSAiCkKCvT40FNCyh52DGbpJPgg8ha2W9yBym/Oah9qnShQity6Wspjz/XccoUgtpYmErCPzdDmcvgzEr8RtQX9I40O6IjVAgz6FzTY+N5i568H6+n0ioPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773114394; c=relaxed/simple;
	bh=RysuK8zAMacIz/hro6RBL1NV5q15p2awiZTeDZd5dpI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j5V6FnYpOILkbeRZ6hygqQYCvophmFHNI0MyPOQx9CjIWWYusCX0oO/zEN6ZlQ3gyGXeGQT2ttOTSnuA6XZIJQ6CkzTW2HGSgcKP+ABqz59dglN1HYr7XMPxDwKjVWdqmH2Mvs4WGXHTl7c5b9svSHlGK8DKU1pxk9CDJZoTCrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R+OwhDdf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE525C4CEF7;
	Tue, 10 Mar 2026 03:46:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773114394;
	bh=RysuK8zAMacIz/hro6RBL1NV5q15p2awiZTeDZd5dpI=;
	h=From:To:Cc:Subject:Date:From;
	b=R+OwhDdfo64SYOocaBoI0qRc6u6rKufkX0tCcTd1av2S1tl7FLHucJHJdP1lYt+nA
	 I6hsrMR8i5N3j4Rh2INkOJPlSog0wXEWq6bhLQ9/ThplqxkWoIQx6j5pn0+kWpnK7e
	 /eowVy77VcqpP2i7xStWsoxPRI5JbhpY5e+YbDzLCWDH0gPX1X2lBgmle1zi3kx0f/
	 Ezn75pX/PfDVH2o7RQzx23h40zDOmYqAr+wV52I+/vSbk6j1YhNGPqnt6ys0Vqm2CR
	 gxrqvj5j/Yh9SlBFj+s3lqFWFhtvCVSGdcyghERzzZuP4B+DP4eQMFl28LNfbQJL4s
	 ABDKHvpQLhUuw==
From: Chuck Lever <cel@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Christoph Hellwig <hch@lst.de>
Cc: <linux-rdma@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH] RDMA/rw: Fix MR pool exhaustion in bvec RDMA READ path
Date: Mon,  9 Mar 2026 23:46:21 -0400
Message-ID: <20260310034621.5799-1-cel@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: DA9CB244FCF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17844-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,oracle.com:email]
X-Rspamd-Action: no action

From: Chuck Lever <chuck.lever@oracle.com>

When IOVA-based DMA mapping is unavailable (eg IOMMU passthrough
mode), rdma_rw_ctx_init_bvec() falls back to checking
rdma_rw_io_needs_mr() with the raw bvec count. Unlike the
scatterlist path in rdma_rw_ctx_init(), which passes a
post-DMA-mapping entry count that reflects coalescing of
physically contiguous pages, the bvec path passes the
pre-mapping page count. This overstates the number of DMA
entries, causing every multi-bvec RDMA READ to consume an MR
from the QP's pool.

Under NFS WRITE workloads the server performs RDMA READs to
pull data from the client. With the inflated MR demand, the
pool is rapidly exhausted, ib_mr_pool_get() returns NULL, and
rdma_rw_init_one_mr() returns -EAGAIN. svcrdma treats this as
a DMA mapping failure, closes the connection, and the client
reconnects -- producing a cycle of 71% RPC retransmissions and
~100 reconnections per test run. RDMA WRITEs (NFS READ
direction) are unaffected because DMA_TO_DEVICE never triggers
the max_sgl_rd check.

Fixes: bea28ac14cab ("RDMA/core: add MR support for bvec-based RDMA operations")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 drivers/infiniband/core/rw.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/core/rw.c b/drivers/infiniband/core/rw.c
index fc45c384833f..9e227b7746a1 100644
--- a/drivers/infiniband/core/rw.c
+++ b/drivers/infiniband/core/rw.c
@@ -686,14 +686,15 @@ int rdma_rw_ctx_init_bvec(struct rdma_rw_ctx *ctx, struct ib_qp *qp,
 		return ret;
 
 	/*
-	 * IOVA mapping not available. Check if MR registration provides
-	 * better performance than multiple SGE entries.
+	 * IOVA not available; map each bvec individually. Do not
+	 * check max_sgl_rd here: nr_bvec is a raw page count that
+	 * overstates DMA entry demand and exhausts the MR pool.
+	 *
+	 * TODO: A bulk DMA mapping API for bvecs analogous to
+	 * dma_map_sgtable() would provide a proper post-DMA-
+	 * coalescing segment count here, enabling the map_wrs
+	 * path in more cases.
 	 */
-	if (rdma_rw_io_needs_mr(dev, port_num, dir, nr_bvec))
-		return rdma_rw_init_mr_wrs_bvec(ctx, qp, port_num, bvecs,
-						nr_bvec, &iter, remote_addr,
-						rkey, dir);
-
 	return rdma_rw_init_map_wrs_bvec(ctx, qp, bvecs, nr_bvec, &iter,
 			remote_addr, rkey, dir);
 }
-- 
2.53.0


