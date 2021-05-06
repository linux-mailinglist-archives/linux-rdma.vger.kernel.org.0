Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EA01375D8A
	for <lists+linux-rdma@lfdr.de>; Fri,  7 May 2021 01:38:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232800AbhEFXjL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 6 May 2021 19:39:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232896AbhEFXjJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 6 May 2021 19:39:09 -0400
Received: from hr2.samba.org (hr2.samba.org [IPv6:2a01:4f8:192:486::2:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1391EC061574
        for <linux-rdma@vger.kernel.org>; Thu,  6 May 2021 16:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
         s=42; h=Message-Id:Date:Cc:To:From;
        bh=tFyEeOJh+aZyZhLhVw9Pu179zrnwDo6xMfSVp0eSes0=; b=WJRmC4J0DvS/wOkKD/9azm86rJ
        ZFV85845ThkPF35metkF7UnwWfHanoWzKPLNUrq9/tBZO/e7kFHjNrM7qkmmYL0WkxEKiZxHA3Ipa
        idZz+SxeLG37CkGQj1rYCpPYQLcwE+WuFJbvzjZEcle3ZgCVlcDzaDhdDFhD+GxT113h6FmMpW4T5
        GGScodwIogLOF2knQ9dMqEer5LL2W0FkSjY7QKEOH8N0U3ZE1tEShB3kjXIHeb2rx7vzs5kcaZOzl
        QPsE+lISlzCQr2n5AHPYZS6V28mg/zLhHn3tzLrL7EsjgVqTQIlWKb+67Ms8GjjzRKOYIOLZWGk9b
        SFPpPj9R8X9VT88dJXXNZjvQOm5qQUTSaCI8vbcqSrCWYvhL32CCi3mYKi0VefoG22nW1NmyrYW0S
        EEntvloqDu0lz9aJwxTDASNSIAiPKYR83MJ/xbSM7zqwaEUOFuVtpHm2XWjMrgGSAojIXp7T44WJM
        jchIyTV3+IrIDQTEvYrN5w+s;
Received: from [127.0.0.2] (localhost [127.0.0.1])
        by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_RSA_CHACHA20_POLY1305:256)
        (Exim)
        id 1lenZI-0004Ka-6Z; Thu, 06 May 2021 23:38:08 +0000
From:   Stefan Metzmacher <metze@samba.org>
To:     Bernard Metzler <bmt@zurich.ibm.com>
Cc:     linux-rdma@vger.kernel.org, Stefan Metzmacher <metze@samba.org>
Subject: [PATCH 11/31] rdma/siw: introduce SIW_EPSTATE_ACCEPTING/REJECTING for rdma_accept/rdma_reject
Date:   Fri,  7 May 2021 01:36:17 +0200
Message-Id: <b6d45ce73a6d67748723175b2e2a3cbedf2efe57.1620343860.git.metze@samba.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1620343860.git.metze@samba.org>
References: <cover.1620343860.git.metze@samba.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

When we received the MPA Request, we set SIW_EPSTATE_RECVD_MPAREQ
and port IW_CM_EVENT_CONNECT_REQUEST to the IWCM layer.

In that state we expect the caller to reacted with rdma_accept() or
rdma_reject(), which will turn the connection into SIW_EPSTATE_RDMA_MODE
or SIW_EPSTATE_CLOSED finally.

I think it much saner that rdma_accept and rdma_reject change the state
instead of keeping it as SIW_EPSTATE_RECVD_MPAREQ in order to make
the logic more understandable and allow more useful debug messages.

In all cases we need to inform the IWCM layer about that error!
As it only allows IW_CM_EVENT_ESTABLISHED to be posted after
IW_CM_EVENT_CONNECT_REQUEST was posted, we need to go through
IW_CM_EVENT_ESTABLISHED via IW_CM_EVENT_DISCONNECT to
IW_CM_EVENT_CLOSE.

Fixes: 6c52fdc244b5 ("rdma/siw: connection management")
Signed-off-by: Stefan Metzmacher <metze@samba.org>
Cc: Bernard Metzler <bmt@zurich.ibm.com>
Cc: linux-rdma@vger.kernel.org
---
 drivers/infiniband/sw/siw/siw_cm.c | 31 ++++++++++++++++++++++++++++--
 drivers/infiniband/sw/siw/siw_cm.h |  2 ++
 2 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/sw/siw/siw_cm.c b/drivers/infiniband/sw/siw/siw_cm.c
index d03c7a66c6d1..3cc1d22fe232 100644
--- a/drivers/infiniband/sw/siw/siw_cm.c
+++ b/drivers/infiniband/sw/siw/siw_cm.c
@@ -146,10 +146,35 @@ static void __siw_cep_terminate_upcall(struct siw_cep *cep,
 
 	case SIW_EPSTATE_RECVD_MPAREQ:
 		/*
-		 * Wait for the ulp/CM to call accept/reject
+		 * Waited for the ulp/CM to call accept/reject
 		 */
-		siw_dbg_cep(cep, "mpa req recvd, wait for ULP\n");
 		WARN(!suspended, "SIW_EPSTATE_RECVD_MPAREQ called without suspended\n");
+		siw_dbg_cep(cep, "mpa req recvd, post established/disconnect/close\n");
+		siw_cm_upcall(cep, IW_CM_EVENT_ESTABLISHED, 0);
+		siw_cm_upcall(cep, IW_CM_EVENT_DISCONNECT, 0);
+		siw_cm_upcall(cep, IW_CM_EVENT_CLOSE, 0);
+		break;
+
+	case SIW_EPSTATE_ACCEPTING:
+		/*
+		 * We failed during the rdma_accept/siw_accept handling
+		 */
+		WARN(!suspended, "SIW_EPSTATE_ACCEPTING called without suspended\n");
+		siw_dbg_cep(cep, "accepting, post established/disconnect/close\n");
+		siw_cm_upcall(cep, IW_CM_EVENT_ESTABLISHED, 0);
+		siw_cm_upcall(cep, IW_CM_EVENT_DISCONNECT, 0);
+		siw_cm_upcall(cep, IW_CM_EVENT_CLOSE, 0);
+		break;
+
+	case SIW_EPSTATE_REJECTING:
+		/*
+		 * We failed during the rdma_reject/siw_reject handling
+		 */
+		WARN(!suspended, "SIW_EPSTATE_REJECTING called without suspended\n");
+		siw_dbg_cep(cep, "rejecting, post established/disconnect/close\n");
+		siw_cm_upcall(cep, IW_CM_EVENT_ESTABLISHED, 0);
+		siw_cm_upcall(cep, IW_CM_EVENT_DISCONNECT, 0);
+		siw_cm_upcall(cep, IW_CM_EVENT_CLOSE, 0);
 		break;
 
 	case SIW_EPSTATE_AWAIT_MPAREQ:
@@ -1563,6 +1588,7 @@ int siw_accept(struct iw_cm_id *id, struct iw_cm_conn_param *params)
 
 		return -ECONNRESET;
 	}
+	cep->state = SIW_EPSTATE_ACCEPTING;
 	qp = siw_qp_id2obj(sdev, params->qpn);
 	if (!qp) {
 		WARN(1, "[QP %d] does not exist\n", params->qpn);
@@ -1743,6 +1769,7 @@ int siw_reject(struct iw_cm_id *id, const void *pdata, u8 pd_len)
 	}
 	siw_dbg_cep(cep, "cep->state %d, pd_len %d\n", cep->state,
 		    pd_len);
+	cep->state = SIW_EPSTATE_REJECTING;
 
 	if (__mpa_rr_revision(cep->mpa.hdr.params.bits) >= MPA_REVISION_1) {
 		cep->mpa.hdr.params.bits |= MPA_RR_FLAG_REJECT; /* reject */
diff --git a/drivers/infiniband/sw/siw/siw_cm.h b/drivers/infiniband/sw/siw/siw_cm.h
index 8c59cb3e2868..4f6219bd746b 100644
--- a/drivers/infiniband/sw/siw/siw_cm.h
+++ b/drivers/infiniband/sw/siw/siw_cm.h
@@ -20,6 +20,8 @@ enum siw_cep_state {
 	SIW_EPSTATE_AWAIT_MPAREQ,
 	SIW_EPSTATE_RECVD_MPAREQ,
 	SIW_EPSTATE_AWAIT_MPAREP,
+	SIW_EPSTATE_ACCEPTING,
+	SIW_EPSTATE_REJECTING,
 	SIW_EPSTATE_RDMA_MODE,
 	SIW_EPSTATE_CLOSED
 };
-- 
2.25.1

