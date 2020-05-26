Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 433661E1FBC
	for <lists+linux-rdma@lfdr.de>; Tue, 26 May 2020 12:33:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731887AbgEZKdS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 26 May 2020 06:33:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:50286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731745AbgEZKdR (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 26 May 2020 06:33:17 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 83AD2207CB;
        Tue, 26 May 2020 10:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590489197;
        bh=uvxN2us7wkssqLoUDqB/pwgdiWlimTT2EUWdmTR2kGM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zFdZqtzunPNW59LV3cbDX5z8hlK7t5n5LZZiM8mNcWRA3t+JTpwMA+MRHqUQMrp4+
         S/m3pHctZxP5pdqim2A30MPRT3wse6e+v0kYekZvQ1GkE6Sd42PsGa9il1YpOngXXe
         R3qjQrhV2mdqvLUJjk02A/RjicQtEqF7+EINd2MM=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>, linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next v3 3/6] RDMA/ucma: Deliver ECE parameters through UCMA events
Date:   Tue, 26 May 2020 13:33:01 +0300
Message-Id: <20200526103304.196371-4-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200526103304.196371-1-leon@kernel.org>
References: <20200526103304.196371-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

Passive side of CMID connection receives ECE request through
REQ message and needs to respond with relevant REP message which
will be forwarded to active side.

The UCMA events interface is responsible for such communication
with the user space (librdmacm). Extend it to provide ECE wire
data.

Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/ucma.c   | 6 +++++-
 include/rdma/rdma_cm.h           | 1 +
 include/uapi/rdma/rdma_user_cm.h | 1 +
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/ucma.c b/drivers/infiniband/core/ucma.c
index 7cbb63690241..3e5268cfa164 100644
--- a/drivers/infiniband/core/ucma.c
+++ b/drivers/infiniband/core/ucma.c
@@ -360,6 +360,9 @@ static int ucma_event_handler(struct rdma_cm_id *cm_id,
 		ucma_copy_conn_event(&uevent->resp.param.conn,
 				     &event->param.conn);
 
+	uevent->resp.ece.vendor_id = event->ece.vendor_id;
+	uevent->resp.ece.attr_mod = event->ece.attr_mod;
+
 	if (event->event == RDMA_CM_EVENT_CONNECT_REQUEST) {
 		if (!ctx->backlog) {
 			ret = -ENOMEM;
@@ -404,7 +407,8 @@ static ssize_t ucma_get_event(struct ucma_file *file, const char __user *inbuf,
 	 * Old 32 bit user space does not send the 4 byte padding in the
 	 * reserved field. We don't care, allow it to keep working.
 	 */
-	if (out_len < sizeof(uevent->resp) - sizeof(uevent->resp.reserved))
+	if (out_len < sizeof(uevent->resp) - sizeof(uevent->resp.reserved) -
+			      sizeof(uevent->resp.ece))
 		return -ENOSPC;
 
 	if (copy_from_user(&cmd, inbuf, sizeof(cmd)))
diff --git a/include/rdma/rdma_cm.h b/include/rdma/rdma_cm.h
index 4e2975eb3643..418590c9a9e8 100644
--- a/include/rdma/rdma_cm.h
+++ b/include/rdma/rdma_cm.h
@@ -111,6 +111,7 @@ struct rdma_cm_event {
 		struct rdma_conn_param	conn;
 		struct rdma_ud_param	ud;
 	} param;
+	struct rdma_ucm_ece ece;
 };
 
 struct rdma_cm_id;
diff --git a/include/uapi/rdma/rdma_user_cm.h b/include/uapi/rdma/rdma_user_cm.h
index c1409dd7225f..19c5c3f74af9 100644
--- a/include/uapi/rdma/rdma_user_cm.h
+++ b/include/uapi/rdma/rdma_user_cm.h
@@ -297,6 +297,7 @@ struct rdma_ucm_event_resp {
 		struct rdma_ucm_ud_param   ud;
 	} param;
 	__u32 reserved;
+	struct rdma_ucm_ece ece;
 };
 
 /* Option levels */
-- 
2.26.2

