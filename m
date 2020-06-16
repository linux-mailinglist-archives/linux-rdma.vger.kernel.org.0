Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54DBA1FAEC9
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Jun 2020 12:58:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728176AbgFPK6s (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 16 Jun 2020 06:58:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:37762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728217AbgFPK6r (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 16 Jun 2020 06:58:47 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 685DC20786;
        Tue, 16 Jun 2020 10:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592305127;
        bh=8dHtFT+Xgsn5PoproOlb+NrrHko3XMgogqG/ThGrTRs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zKGJ956oSgCx5Z75BSW9cqbODa4Tco1C7PA88m/Yg3pTQAaTyVzQyvg9kVEdJ/veG
         yteTgTkNQqVF5oWC8+uJnQarPp0sgxg1eBxF/59wZZZlfy9F0zGt7U2N/trqn9SJOK
         XtcNu6x9DuSvhP8Eke0wRLauj4ffWl7BZv/nYkXo=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Yishai Hadas <yishaih@mellanox.com>, linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next 7/7] IB/uverbs: Expose KABI to query MR
Date:   Tue, 16 Jun 2020 13:55:31 +0300
Message-Id: <20200616105531.2428010-8-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200616105531.2428010-1-leon@kernel.org>
References: <20200616105531.2428010-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Yishai Hadas <yishaih@mellanox.com>

Expose KABI to query MR, this will let user space application that
didn't allocate the MR but has access to by owning the matching command
FD to retrieve its information.

Signed-off-by: Yishai Hadas <yishaih@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/uverbs_std_types_mr.c | 50 ++++++++++++++++++-
 include/uapi/rdma/ib_user_ioctl_cmds.h        |  9 ++++
 2 files changed, 58 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/uverbs_std_types_mr.c b/drivers/infiniband/core/uverbs_std_types_mr.c
index a2722ef8496e..f6763151fbcd 100644
--- a/drivers/infiniband/core/uverbs_std_types_mr.c
+++ b/drivers/infiniband/core/uverbs_std_types_mr.c
@@ -148,6 +148,34 @@ static int UVERBS_HANDLER(UVERBS_METHOD_DM_MR_REG)(
 	return ret;
 }
 
+static int UVERBS_HANDLER(UVERBS_METHOD_QUERY_MR)(
+	struct uverbs_attr_bundle *attrs)
+{
+	struct ib_mr *mr =
+		uverbs_attr_get_obj(attrs, UVERBS_ATTR_QUERY_MR_HANDLE);
+	int ret;
+
+	ret = uverbs_copy_to(attrs, UVERBS_ATTR_QUERY_MR_RESP_LKEY, &mr->lkey,
+			     sizeof(mr->lkey));
+	if (ret)
+		return ret;
+
+	ret = uverbs_copy_to(attrs, UVERBS_ATTR_QUERY_MR_RESP_RKEY,
+			     &mr->rkey, sizeof(mr->rkey));
+
+	if (ret)
+		return ret;
+
+	ret = uverbs_copy_to(attrs, UVERBS_ATTR_QUERY_MR_RESP_LENGTH,
+			     &mr->length, sizeof(mr->length));
+
+	if (ret)
+		return ret;
+
+	return uverbs_copy_to(attrs, UVERBS_ATTR_QUERY_MR_RESP_IOVA,
+			      &mr->iova, sizeof(mr->iova));
+}
+
 DECLARE_UVERBS_NAMED_METHOD(
 	UVERBS_METHOD_ADVISE_MR,
 	UVERBS_ATTR_IDR(UVERBS_ATTR_ADVISE_MR_PD_HANDLE,
@@ -165,6 +193,25 @@ DECLARE_UVERBS_NAMED_METHOD(
 			   UA_MANDATORY,
 			   UA_ALLOC_AND_COPY));
 
+DECLARE_UVERBS_NAMED_METHOD(
+	UVERBS_METHOD_QUERY_MR,
+	UVERBS_ATTR_IDR(UVERBS_ATTR_QUERY_MR_HANDLE,
+			UVERBS_OBJECT_MR,
+			UVERBS_ACCESS_READ,
+			UA_MANDATORY),
+	UVERBS_ATTR_PTR_OUT(UVERBS_ATTR_QUERY_MR_RESP_RKEY,
+			    UVERBS_ATTR_TYPE(u32),
+			    UA_MANDATORY),
+	UVERBS_ATTR_PTR_OUT(UVERBS_ATTR_QUERY_MR_RESP_LKEY,
+			    UVERBS_ATTR_TYPE(u32),
+			    UA_MANDATORY),
+	UVERBS_ATTR_PTR_OUT(UVERBS_ATTR_QUERY_MR_RESP_LENGTH,
+			    UVERBS_ATTR_TYPE(u64),
+			    UA_MANDATORY),
+	UVERBS_ATTR_PTR_OUT(UVERBS_ATTR_QUERY_MR_RESP_IOVA,
+			    UVERBS_ATTR_TYPE(u64),
+			    UA_MANDATORY));
+
 DECLARE_UVERBS_NAMED_METHOD(
 	UVERBS_METHOD_DM_MR_REG,
 	UVERBS_ATTR_IDR(UVERBS_ATTR_REG_DM_MR_HANDLE,
@@ -206,7 +253,8 @@ DECLARE_UVERBS_NAMED_OBJECT(
 	UVERBS_TYPE_ALLOC_IDR(uverbs_free_mr),
 	&UVERBS_METHOD(UVERBS_METHOD_DM_MR_REG),
 	&UVERBS_METHOD(UVERBS_METHOD_MR_DESTROY),
-	&UVERBS_METHOD(UVERBS_METHOD_ADVISE_MR));
+	&UVERBS_METHOD(UVERBS_METHOD_ADVISE_MR),
+	&UVERBS_METHOD(UVERBS_METHOD_QUERY_MR));
 
 const struct uapi_definition uverbs_def_obj_mr[] = {
 	UAPI_DEF_CHAIN_OBJ_TREE_NAMED(UVERBS_OBJECT_MR,
diff --git a/include/uapi/rdma/ib_user_ioctl_cmds.h b/include/uapi/rdma/ib_user_ioctl_cmds.h
index 83b6e71ea216..99dcabf61a71 100644
--- a/include/uapi/rdma/ib_user_ioctl_cmds.h
+++ b/include/uapi/rdma/ib_user_ioctl_cmds.h
@@ -248,6 +248,7 @@ enum uverbs_methods_mr {
 	UVERBS_METHOD_DM_MR_REG,
 	UVERBS_METHOD_MR_DESTROY,
 	UVERBS_METHOD_ADVISE_MR,
+	UVERBS_METHOD_QUERY_MR,
 };
 
 enum uverbs_attrs_mr_destroy_ids {
@@ -261,6 +262,14 @@ enum uverbs_attrs_advise_mr_cmd_attr_ids {
 	UVERBS_ATTR_ADVISE_MR_SGE_LIST,
 };
 
+enum uverbs_attrs_query_mr_cmd_attr_ids {
+	UVERBS_ATTR_QUERY_MR_HANDLE,
+	UVERBS_ATTR_QUERY_MR_RESP_LKEY,
+	UVERBS_ATTR_QUERY_MR_RESP_RKEY,
+	UVERBS_ATTR_QUERY_MR_RESP_LENGTH,
+	UVERBS_ATTR_QUERY_MR_RESP_IOVA,
+};
+
 enum uverbs_attrs_create_counters_cmd_attr_ids {
 	UVERBS_ATTR_CREATE_COUNTERS_HANDLE,
 };
-- 
2.26.2

