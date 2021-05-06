Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0BD4375D9C
	for <lists+linux-rdma@lfdr.de>; Fri,  7 May 2021 01:39:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232900AbhEFXky (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 6 May 2021 19:40:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232896AbhEFXky (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 6 May 2021 19:40:54 -0400
Received: from hr2.samba.org (hr2.samba.org [IPv6:2a01:4f8:192:486::2:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7833FC061574
        for <linux-rdma@vger.kernel.org>; Thu,  6 May 2021 16:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
         s=42; h=Message-Id:Date:Cc:To:From;
        bh=yjCAzb3OrX6FYHNFPxKWeZzACgrDqv6fUiFQuSGKF+I=; b=Xgr81s44okSKOsPPocXNTb3XG7
        qSU5Pq/a66JabEOX3OLfGrKhRRi07KjFAINaCLc0eCzhjZnVcykVIReuIQ2ZkrOLNiwcq6XNbzgcv
        0IPJN+0ohChBnlNb+V4iQRKmNg+q9xO8fHJ0OTcdFYyoE63IkXGjtFx/oU2oSzPamVpp7TdECpnkW
        xATs3WpPuw0LripgZxIAM6zxBlyQq7dO0qQgBpNTn96xOusFTI9QNBGuthLWEeCuPFpHfn7gRzrJX
        YpcBCh+Gp5e3+RPASFrtIwNiEQMmayDQruQmZ9I0RpJJ2GbW7HewE5XyRv8LjX2V5Et1TayyMaX2x
        YAgB6sm7nKNNreo9z65F90l3xYw+zRCg49nFVicfRYgk+vUH2nkAKpizoTXQE/IelFSgyLWkQRGjb
        /UdErdHEpZ4NwuBQdZXIFNe2pn3Cwq62NwozrtzYWzFGKNIoOj5Uol2mskJc7F55BMS6+SfmtGJ1Q
        OofvLgKmxGq0LufKsuUpDlGf;
Received: from [127.0.0.2] (localhost [127.0.0.1])
        by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_RSA_CHACHA20_POLY1305:256)
        (Exim)
        id 1lenaz-0004OM-JI; Thu, 06 May 2021 23:39:53 +0000
From:   Stefan Metzmacher <metze@samba.org>
To:     Bernard Metzler <bmt@zurich.ibm.com>
Cc:     linux-rdma@vger.kernel.org, Stefan Metzmacher <metze@samba.org>
Subject: [PATCH 27/31] rdma/siw: fix the "close" logic in siw_qp_cm_drop()
Date:   Fri,  7 May 2021 01:36:33 +0200
Message-Id: <2a9916bda4eb2ec63fcbf8b01041723383c3f844.1620343860.git.metze@samba.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1620343860.git.metze@samba.org>
References: <cover.1620343860.git.metze@samba.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

cep->cm_id->rem_ref(cep->cm_id) is no reason to call
siw_cep_put(cep), we never call siw_cep_get(cep) when
calling id->add_ref(id).

But the cep->qp cleanup needs to drop both references!

Fixes: 6c52fdc244b5 ("rdma/siw: connection management")
Signed-off-by: Stefan Metzmacher <metze@samba.org>
Cc: Bernard Metzler <bmt@zurich.ibm.com>
Cc: linux-rdma@vger.kernel.org
---
 drivers/infiniband/sw/siw/siw_cm.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/sw/siw/siw_cm.c b/drivers/infiniband/sw/siw/siw_cm.c
index 3dc80c21ac60..9f9750237e75 100644
--- a/drivers/infiniband/sw/siw/siw_cm.c
+++ b/drivers/infiniband/sw/siw/siw_cm.c
@@ -546,7 +546,6 @@ void siw_qp_cm_drop(struct siw_qp *qp, int schedule)
 		if (cep->cm_id) {
 			cep->cm_id->rem_ref(cep->cm_id);
 			cep->cm_id = NULL;
-			siw_cep_put(cep);
 		}
 		cep->state = SIW_EPSTATE_CLOSED;
 
@@ -559,8 +558,11 @@ void siw_qp_cm_drop(struct siw_qp *qp, int schedule)
 			cep->sock = NULL;
 		}
 		if (cep->qp) {
+			BUG_ON(cep->qp->cep != cep);
+			cep->qp->cep = NULL;
+			siw_qp_put(cep->qp);
 			cep->qp = NULL;
-			siw_qp_put(qp);
+			siw_cep_put(cep);
 		}
 out:
 		siw_cep_set_free(cep);
-- 
2.25.1

