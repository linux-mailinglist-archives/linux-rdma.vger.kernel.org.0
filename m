Return-Path: <linux-rdma+bounces-1013-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E998B852D77
	for <lists+linux-rdma@lfdr.de>; Tue, 13 Feb 2024 11:07:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85F911F2BB8D
	for <lists+linux-rdma@lfdr.de>; Tue, 13 Feb 2024 10:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 844FD224E7;
	Tue, 13 Feb 2024 10:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FoBBTJBn"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3478A22EE3;
	Tue, 13 Feb 2024 10:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707818855; cv=none; b=RJlnyoKagE8XbJ2kQvdqHkqabWBiBfx+6n6vBTlSdY9PKDCHoFO2/O+I2nnqf2yZNfvElo01k7ohwnSYcZpgsA5VWzYOW+H1e3iSA4m0lloE/qVUtguzBz++wKfBPdrdgxlFI+1gyiJ+xmLIU7uTSV4kHEROUvoBFTlZdK3avvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707818855; c=relaxed/simple;
	bh=TfBI8+XT35oYQJ/Alj2IsV1Q/w0MB4GZiDDW54Ji4wI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NVPDWBDlTDttTnU6LcuEnG0SlukQfhnYCIN2h0MrGdLJVJEcQeOdwgkJtJ/NgeWKqyixor1h1Zf1MfEsI8piz4YOI6QDZdq6UpDKy8pfJgw03PP8+DIF8MQMJWos5Slys1+42jmp5QolvNfa3S+mBtCeA/Yd25xhkpvSdztDLEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FoBBTJBn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0D8DC433F1;
	Tue, 13 Feb 2024 10:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707818854;
	bh=TfBI8+XT35oYQJ/Alj2IsV1Q/w0MB4GZiDDW54Ji4wI=;
	h=From:To:Cc:Subject:Date:From;
	b=FoBBTJBnT9jMzq2HQpaXgCfIU0GKlnax5THlFjXZ/lghnWleJee7NaysU/oungnq1
	 d5B8z6I6EDtKGApEceeeMZpaH3ffSfzp+kEZ1NrrB8E7BGRAM2oxzsqb9fCSHxO5AG
	 QUjRq4oU96o5xktf7ZiuOt12Vm3fFe5L2/otQ6dz14JisIV0OgQgJW5P3KQuMueVwv
	 1NKO9kHvC6y7owf7yOQrjQOUMa2G3X69ISNOzYft2GJzRhZD3KTTSjcq73dsT/6ctj
	 +yN0WHCTvSLkTwRPjzt/j5cztFC7nSJaQfHpQN7hAL+bZ+9PMtvVbC7Y9h0qZiEc7R
	 Jk/bpHkgLVNFw==
From: Arnd Bergmann <arnd@kernel.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	"Nicholas A. Bellinger" <nab@risingtidesystems.com>,
	linux-rdma@vger.kernel.org,
	target-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH] RDMA/srpt: fix function pointer cast warnings
Date: Tue, 13 Feb 2024 11:07:13 +0100
Message-Id: <20240213100728.458348-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

clang-16 notices that srpt_qp_event() gets called through an incompatible
pointer here:

drivers/infiniband/ulp/srpt/ib_srpt.c:1815:5: error: cast from 'void (*)(struct ib_event *, struct srpt_rdma_ch *)' to 'void (*)(struct ib_event *, void *)' converts to incompatible function type [-Werror,-Wcast-function-type-strict]
 1815 |                 = (void(*)(struct ib_event *, void*))srpt_qp_event;

Change srpt_qp_event() to use the correct prototype and adjust the
argument inside of it.

Fixes: a42d985bd5b2 ("ib_srpt: Initial SRP Target merge for v3.3-rc1")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/infiniband/ulp/srpt/ib_srpt.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/ulp/srpt/ib_srpt.c b/drivers/infiniband/ulp/srpt/ib_srpt.c
index 0875f197118f..942b311b6296 100644
--- a/drivers/infiniband/ulp/srpt/ib_srpt.c
+++ b/drivers/infiniband/ulp/srpt/ib_srpt.c
@@ -216,8 +216,10 @@ static const char *get_ch_state_name(enum rdma_ch_state s)
  * @event: Description of the event that occurred.
  * @ch: SRPT RDMA channel.
  */
-static void srpt_qp_event(struct ib_event *event, struct srpt_rdma_ch *ch)
+static void srpt_qp_event(struct ib_event *event, void *ptr)
 {
+	struct srpt_rdma_ch *ch = ptr;
+
 	pr_debug("QP event %d on ch=%p sess_name=%s-%d state=%s\n",
 		 event->event, ch, ch->sess_name, ch->qp->qp_num,
 		 get_ch_state_name(ch->state));
@@ -1811,8 +1813,7 @@ static int srpt_create_ch_ib(struct srpt_rdma_ch *ch)
 	ch->cq_size = ch->rq_size + sq_size;
 
 	qp_init->qp_context = (void *)ch;
-	qp_init->event_handler
-		= (void(*)(struct ib_event *, void*))srpt_qp_event;
+	qp_init->event_handler = srpt_qp_event;
 	qp_init->send_cq = ch->cq;
 	qp_init->recv_cq = ch->cq;
 	qp_init->sq_sig_type = IB_SIGNAL_REQ_WR;
-- 
2.39.2


