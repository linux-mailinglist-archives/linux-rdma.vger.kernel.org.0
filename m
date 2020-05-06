Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29A411C6B96
	for <lists+linux-rdma@lfdr.de>; Wed,  6 May 2020 10:24:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728636AbgEFIY5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 6 May 2020 04:24:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:59970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727956AbgEFIY5 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 6 May 2020 04:24:57 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 079BF206E6;
        Wed,  6 May 2020 08:24:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588753496;
        bh=fX7kiplsxEpr8vxP6dZQIZRX9eGAtCxrwGV/KYy0JwQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UPlnvTG7xvDs2Jbev5He2xE3RZNuSIRRV7DUjoc2LPV7sCKY3DAaa9Dwffws4kON2
         KQyQ8qaI2CqWNnScJUsb6fp473TTCQOZoUnqi8LeN0GYm/j+1A0CtlXgv4tmrAxtTZ
         DOBsCAkneiDmK42MEpzw8QeDSkvdhX2oBdBSXFkY=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Yishai Hadas <yishaih@mellanox.com>, linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next v1 03/10] IB/uverbs: Extend CQ to get its own asynchronous event FD
Date:   Wed,  6 May 2020 11:24:37 +0300
Message-Id: <20200506082444.14502-4-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200506082444.14502-1-leon@kernel.org>
References: <20200506082444.14502-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Yishai Hadas <yishaih@mellanox.com>

Extend CQ to get its own asynchronous event FD.
The event FD is an optional attribute, in case wasn't given the ufile
event FD will be used.

Signed-off-by: Yishai Hadas <yishaih@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/uverbs.h              | 18 ++++++++++++++++++
 drivers/infiniband/core/uverbs_std_types_cq.c |  9 ++++++---
 include/uapi/rdma/ib_user_ioctl_cmds.h        |  1 +
 3 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/core/uverbs.h b/drivers/infiniband/core/uverbs.h
index 55b47f110183..7241009045a5 100644
--- a/drivers/infiniband/core/uverbs.h
+++ b/drivers/infiniband/core/uverbs.h
@@ -293,6 +293,24 @@ static inline u32 make_port_cap_flags(const struct ib_port_attr *attr)
 	return res;
 }
 
+static inline struct ib_uverbs_async_event_file *
+ib_uverbs_get_async_event(struct uverbs_attr_bundle *attrs,
+			  u16 id)
+{
+	struct ib_uobject *async_ev_file_uobj;
+	struct ib_uverbs_async_event_file *async_ev_file;
+
+	async_ev_file_uobj = uverbs_attr_get_uobject(attrs, id);
+	if (IS_ERR(async_ev_file_uobj))
+		async_ev_file = attrs->ufile->default_async_file;
+	else
+		async_ev_file = container_of(async_ev_file_uobj,
+				       struct ib_uverbs_async_event_file,
+				       uobj);
+	if (async_ev_file)
+		uverbs_uobject_get(&async_ev_file->uobj);
+	return async_ev_file;
+}
 
 void copy_port_attr_to_resp(struct ib_port_attr *attr,
 			    struct ib_uverbs_query_port_resp *resp,
diff --git a/drivers/infiniband/core/uverbs_std_types_cq.c b/drivers/infiniband/core/uverbs_std_types_cq.c
index 59617c8b88ea..5d9b43a8904f 100644
--- a/drivers/infiniband/core/uverbs_std_types_cq.c
+++ b/drivers/infiniband/core/uverbs_std_types_cq.c
@@ -100,9 +100,8 @@ static int UVERBS_HANDLER(UVERBS_METHOD_CQ_CREATE)(
 		uverbs_uobject_get(ev_file_uobj);
 	}
 
-	obj->uevent.event_file = attrs->ufile->default_async_file;
-	if (obj->uevent.event_file)
-		uverbs_uobject_get(&obj->uevent.event_file->uobj);
+	obj->uevent.event_file = ib_uverbs_get_async_event(
+		attrs, UVERBS_ATTR_CREATE_CQ_EVENT_FD);
 
 	if (attr.comp_vector >= attrs->ufile->device->num_comp_vectors) {
 		ret = -EINVAL;
@@ -173,6 +172,10 @@ DECLARE_UVERBS_NAMED_METHOD(
 	UVERBS_ATTR_PTR_OUT(UVERBS_ATTR_CREATE_CQ_RESP_CQE,
 			    UVERBS_ATTR_TYPE(u32),
 			    UA_MANDATORY),
+	UVERBS_ATTR_FD(UVERBS_ATTR_CREATE_CQ_EVENT_FD,
+		       UVERBS_OBJECT_ASYNC_EVENT,
+		       UVERBS_ACCESS_READ,
+		       UA_OPTIONAL),
 	UVERBS_ATTR_UHW());
 
 static int UVERBS_HANDLER(UVERBS_METHOD_CQ_DESTROY)(
diff --git a/include/uapi/rdma/ib_user_ioctl_cmds.h b/include/uapi/rdma/ib_user_ioctl_cmds.h
index d4ddbe4e696c..286fdc1929e0 100644
--- a/include/uapi/rdma/ib_user_ioctl_cmds.h
+++ b/include/uapi/rdma/ib_user_ioctl_cmds.h
@@ -95,6 +95,7 @@ enum uverbs_attrs_create_cq_cmd_attr_ids {
 	UVERBS_ATTR_CREATE_CQ_COMP_VECTOR,
 	UVERBS_ATTR_CREATE_CQ_FLAGS,
 	UVERBS_ATTR_CREATE_CQ_RESP_CQE,
+	UVERBS_ATTR_CREATE_CQ_EVENT_FD,
 };
 
 enum uverbs_attrs_destroy_cq_cmd_attr_ids {
-- 
2.26.2

