Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19CDD849A0
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Aug 2019 12:34:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbfHGKeS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 7 Aug 2019 06:34:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:41814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726269AbfHGKeR (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 7 Aug 2019 06:34:17 -0400
Received: from localhost (unknown [77.137.115.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 257AE2086D;
        Wed,  7 Aug 2019 10:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565174056;
        bh=fZj+Mth0sbWtyNo1AMEpJyoqbZvZDKBwq9xQcpG3X/I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aYibTEIEQrSzMW+7kEolZIOZASdBCJaKP4oi1B71BpknCX6P7l9+uRpXq76PKiwH+
         whFrRqla9RNCr30Ugh8EEgQ8rCMqdJ13hSGE8jrTE0CLlumNHVxqx2mrA3l+T3WAvS
         TTDd3E+lz0ZRlJksPkNEyG5Q9+srQpCQ92fyzcY8=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Erez Alfasi <ereza@mellanox.com>
Subject: [PATCH rdma-next 2/6] RDMA/umem: Add ODP type indicator within ib_umem_odp
Date:   Wed,  7 Aug 2019 13:33:59 +0300
Message-Id: <20190807103403.8102-3-leon@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190807103403.8102-1-leon@kernel.org>
References: <20190807103403.8102-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Erez Alfasi <ereza@mellanox.com>

ODP type can be divided into 2 subclasses:
Explicit and Implicit ODP.

Adding a type enums and an odp type flag within
ib_umem_odp will give us an indication whether a
given MR is ODP implicit/explicit registered.

Signed-off-by: Erez Alfasi <ereza@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/umem.c    |  1 +
 include/rdma/ib_umem_odp.h        | 14 ++++++++++++++
 include/uapi/rdma/ib_user_verbs.h |  5 +++++
 3 files changed, 20 insertions(+)

diff --git a/drivers/infiniband/core/umem.c b/drivers/infiniband/core/umem.c
index 08da840ed7ee..04b737739b74 100644
--- a/drivers/infiniband/core/umem.c
+++ b/drivers/infiniband/core/umem.c
@@ -236,6 +236,7 @@ struct ib_umem *ib_umem_get(struct ib_udata *udata, unsigned long addr,
 		if (!umem)
 			return ERR_PTR(-ENOMEM);
 		umem->is_odp = 1;
+		ib_umem_odp_set_type(to_ib_umem_odp(umem), addr, size);
 	} else {
 		umem = kzalloc(sizeof(*umem), GFP_KERNEL);
 		if (!umem)
diff --git a/include/rdma/ib_umem_odp.h b/include/rdma/ib_umem_odp.h
index 479db5c98ff6..81dc53a2848c 100644
--- a/include/rdma/ib_umem_odp.h
+++ b/include/rdma/ib_umem_odp.h
@@ -67,6 +67,11 @@ struct ib_umem_odp {
 	struct mutex		umem_mutex;
 	void			*private; /* for the HW driver to use. */
 
+	/*
+	 * ODP type indicator e.g. implicit/explicit.
+	 */
+	u8			type;
+
 	int notifiers_seq;
 	int notifiers_count;
 	int npages;
@@ -104,6 +109,15 @@ static inline size_t ib_umem_odp_num_pages(struct ib_umem_odp *umem_odp)
 	       umem_odp->page_shift;
 }
 
+static inline void ib_umem_odp_set_type(struct ib_umem_odp *umem_odp,
+					unsigned long start, size_t end)
+{
+	if (!start && !end)
+		umem_odp->type = IB_ODP_TYPE_IMPLICIT;
+	else
+		umem_odp->type = IB_ODP_TYPE_EXPLICIT;
+}
+
 /*
  * The lower 2 bits of the DMA address signal the R/W permissions for
  * the entry. To upgrade the permissions, provide the appropriate
diff --git a/include/uapi/rdma/ib_user_verbs.h b/include/uapi/rdma/ib_user_verbs.h
index 0474c7400268..42c9bda21f16 100644
--- a/include/uapi/rdma/ib_user_verbs.h
+++ b/include/uapi/rdma/ib_user_verbs.h
@@ -46,6 +46,11 @@
 #define IB_USER_VERBS_ABI_VERSION	6
 #define IB_USER_VERBS_CMD_THRESHOLD    50
 
+enum ib_odp_type {
+	IB_ODP_TYPE_IMPLICIT,
+	IB_ODP_TYPE_EXPLICIT,
+};
+
 enum ib_uverbs_write_cmds {
 	IB_USER_VERBS_CMD_GET_CONTEXT,
 	IB_USER_VERBS_CMD_QUERY_DEVICE,
-- 
2.20.1

