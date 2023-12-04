Return-Path: <linux-rdma+bounces-203-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D7D78037B5
	for <lists+linux-rdma@lfdr.de>; Mon,  4 Dec 2023 15:56:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2631F281176
	for <lists+linux-rdma@lfdr.de>; Mon,  4 Dec 2023 14:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6234A28E08;
	Mon,  4 Dec 2023 14:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AhPJCnGD"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE6128DD8;
	Mon,  4 Dec 2023 14:56:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55B33C433C8;
	Mon,  4 Dec 2023 14:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701701792;
	bh=Kw/MFeFz9MC+VuOB2WA2B7m0vKnyWQh2Vd92KJmcFcw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=AhPJCnGD5CbkhUzwvGPEivaSFdIQphP8Lir0YnkXA6PRsINIpOHEU+jr05AMvNNI7
	 d1rnEsXCRx/eg5P3fUttyC1BSGqv4JI4IjjrWOi4kmqjST7+jjGgCyxTc8VWqVkRiw
	 l+HPAgdVPw2nY6zAl9T5y+mNgrLhVXXjcX89oFBMK0Qgifna0+AFzrd2Z0VQFSCyQ3
	 dSr8Tj3SyZdYyjgXkRBLJGxY/TlDyK5Dg43sURyYQWNdhrQs0qgmImuo4RyTwC9zix
	 AgVxvy1I5BBsNZk/vqPo1GTG3NU4C0QmPRH4Hr05YAkKIKjbCWRtEFhRJUllfY+E8x
	 5195g4jPQH25g==
Subject: [PATCH v1 02/21] svcrdma: Acquire the svcxprt_rdma pointer from the
 CQ context
From: Chuck Lever <cel@kernel.org>
To: linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Cc: tom@talpey.com
Date: Mon, 04 Dec 2023 09:56:31 -0500
Message-ID: 
 <170170179141.54779.897060268410599638.stgit@bazille.1015granger.net>
In-Reply-To: 
 <170170144201.54779.9877683240030806819.stgit@bazille.1015granger.net>
References: 
 <170170144201.54779.9877683240030806819.stgit@bazille.1015granger.net>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Chuck Lever <chuck.lever@oracle.com>

Enable the removal of the svc_rdma_chunk_ctxt::cc_rdma field in a
subsequent patch.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/svc_rdma_rw.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/sunrpc/xprtrdma/svc_rdma_rw.c b/net/sunrpc/xprtrdma/svc_rdma_rw.c
index 69010ab7f0c3..6fa818dc5b11 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_rw.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_rw.c
@@ -278,10 +278,10 @@ static void svc_rdma_write_info_free(struct svc_rdma_write_info *info)
  */
 static void svc_rdma_write_done(struct ib_cq *cq, struct ib_wc *wc)
 {
+	struct svcxprt_rdma *rdma = cq->cq_context;
 	struct ib_cqe *cqe = wc->wr_cqe;
 	struct svc_rdma_chunk_ctxt *cc =
 			container_of(cqe, struct svc_rdma_chunk_ctxt, cc_cqe);
-	struct svcxprt_rdma *rdma = cc->cc_rdma;
 	struct svc_rdma_write_info *info =
 			container_of(cc, struct svc_rdma_write_info, wi_cc);
 
@@ -345,6 +345,7 @@ static void svc_rdma_read_info_free(struct svc_rdma_read_info *info)
  */
 static void svc_rdma_wc_read_done(struct ib_cq *cq, struct ib_wc *wc)
 {
+	struct svcxprt_rdma *rdma = cq->cq_context;
 	struct ib_cqe *cqe = wc->wr_cqe;
 	struct svc_rdma_chunk_ctxt *cc =
 			container_of(cqe, struct svc_rdma_chunk_ctxt, cc_cqe);
@@ -363,7 +364,7 @@ static void svc_rdma_wc_read_done(struct ib_cq *cq, struct ib_wc *wc)
 		trace_svcrdma_wc_read_err(wc, &cc->cc_cid);
 	}
 
-	svc_rdma_wake_send_waiters(cc->cc_rdma, cc->cc_sqecount);
+	svc_rdma_wake_send_waiters(rdma, cc->cc_sqecount);
 	cc->cc_status = wc->status;
 	complete(&cc->cc_done);
 	return;



