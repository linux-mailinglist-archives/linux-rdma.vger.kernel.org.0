Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5360E8045
	for <lists+linux-rdma@lfdr.de>; Tue, 29 Oct 2019 07:28:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732278AbfJ2G2K (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 29 Oct 2019 02:28:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:58898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730814AbfJ2G2K (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 29 Oct 2019 02:28:10 -0400
Received: from localhost (unknown [77.137.89.37])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B9AA020862;
        Tue, 29 Oct 2019 06:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572330489;
        bh=rH9N17oHRghNUA840rywTiRT9SNwB85XPSc4UwTJhAU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AyeNizjBz8H6FYoP2SsNL9NpaYjUq/ItE3bAr6jTsX+wvvb5VFq+jwti1qD9PJrCW
         1PUXQ2OCBp0VXKQMmxJmyBsHouqj6fv1knpHXTW3lpW3W3M1imAu9K2f7M0KQB2u4I
         6wwojW0kRTN9u5KD+Nh8IruJ5E/8S5e+Zldft5Ho=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Ralph Campbell <ralph.campbell@qlogic.com>
Subject: [PATCH rdma-next 01/16] RDMA/mad: Delete never implemented functions
Date:   Tue, 29 Oct 2019 08:27:30 +0200
Message-Id: <20191029062745.7932-2-leon@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191029062745.7932-1-leon@kernel.org>
References: <20191029062745.7932-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

Delete never implemented and used MAD functions.

Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/mad.c | 19 -----------------
 include/rdma/ib_mad.h         | 40 -----------------------------------
 2 files changed, 59 deletions(-)

diff --git a/drivers/infiniband/core/mad.c b/drivers/infiniband/core/mad.c
index 9947d16edef2..8adb487eb314 100644
--- a/drivers/infiniband/core/mad.c
+++ b/drivers/infiniband/core/mad.c
@@ -1397,25 +1397,6 @@ void ib_free_recv_mad(struct ib_mad_recv_wc *mad_recv_wc)
 }
 EXPORT_SYMBOL(ib_free_recv_mad);
 
-struct ib_mad_agent *ib_redirect_mad_qp(struct ib_qp *qp,
-					u8 rmpp_version,
-					ib_mad_send_handler send_handler,
-					ib_mad_recv_handler recv_handler,
-					void *context)
-{
-	return ERR_PTR(-EINVAL);	/* XXX: for now */
-}
-EXPORT_SYMBOL(ib_redirect_mad_qp);
-
-int ib_process_mad_wc(struct ib_mad_agent *mad_agent,
-		      struct ib_wc *wc)
-{
-	dev_err(&mad_agent->device->dev,
-		"ib_process_mad_wc() not implemented yet\n");
-	return 0;
-}
-EXPORT_SYMBOL(ib_process_mad_wc);
-
 static int method_in_use(struct ib_mad_mgmt_method_table **method,
 			 struct ib_mad_reg_req *mad_reg_req)
 {
diff --git a/include/rdma/ib_mad.h b/include/rdma/ib_mad.h
index eea946fcc819..4e62650e2127 100644
--- a/include/rdma/ib_mad.h
+++ b/include/rdma/ib_mad.h
@@ -814,46 +814,6 @@ void ib_cancel_mad(struct ib_mad_agent *mad_agent,
 int ib_modify_mad(struct ib_mad_agent *mad_agent,
 		  struct ib_mad_send_buf *send_buf, u32 timeout_ms);
 
-/**
- * ib_redirect_mad_qp - Registers a QP for MAD services.
- * @qp: Reference to a QP that requires MAD services.
- * @rmpp_version: If set, indicates that the client will send
- *   and receive MADs that contain the RMPP header for the given version.
- *   If set to 0, indicates that RMPP is not used by this client.
- * @send_handler: The completion callback routine invoked after a send
- *   request has completed.
- * @recv_handler: The completion callback routine invoked for a received
- *   MAD.
- * @context: User specified context associated with the registration.
- *
- * Use of this call allows clients to use MAD services, such as RMPP,
- * on user-owned QPs.  After calling this routine, users may send
- * MADs on the specified QP by calling ib_mad_post_send.
- */
-struct ib_mad_agent *ib_redirect_mad_qp(struct ib_qp *qp,
-					u8 rmpp_version,
-					ib_mad_send_handler send_handler,
-					ib_mad_recv_handler recv_handler,
-					void *context);
-
-/**
- * ib_process_mad_wc - Processes a work completion associated with a
- *   MAD sent or received on a redirected QP.
- * @mad_agent: Specifies the registered MAD service using the redirected QP.
- * @wc: References a work completion associated with a sent or received
- *   MAD segment.
- *
- * This routine is used to complete or continue processing on a MAD request.
- * If the work completion is associated with a send operation, calling
- * this routine is required to continue an RMPP transfer or to wait for a
- * corresponding response, if it is a request.  If the work completion is
- * associated with a receive operation, calling this routine is required to
- * process an inbound or outbound RMPP transfer, or to match a response MAD
- * with its corresponding request.
- */
-int ib_process_mad_wc(struct ib_mad_agent *mad_agent,
-		      struct ib_wc *wc);
-
 /**
  * ib_create_send_mad - Allocate and initialize a data buffer and work request
  *   for sending a MAD.
-- 
2.20.1

