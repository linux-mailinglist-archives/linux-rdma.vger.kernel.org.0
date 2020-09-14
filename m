Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44CDF2684F8
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Sep 2020 08:36:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726039AbgINGgA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 14 Sep 2020 02:36:00 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:10566 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726033AbgINGf6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 14 Sep 2020 02:35:58 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f5f0ec20001>; Sun, 13 Sep 2020 23:33:38 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Sun, 13 Sep 2020 23:35:58 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Sun, 13 Sep 2020 23:35:58 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 14 Sep
 2020 06:35:57 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Mon, 14 Sep 2020 06:35:57 +0000
Received: from mtl-vdi-864.wap.labs.mlnx. (Not Verified[10.228.136.155]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5f5f0f4b0002>; Sun, 13 Sep 2020 23:35:57 -0700
From:   Yishai Hadas <yishaih@nvidia.com>
To:     <linux-rdma@vger.kernel.org>
CC:     <jgg@nvidia.com>, <yishaih@nvidia.com>, <maorg@nvidia.com>,
        <avihaih@nvidia.com>
Subject: [PATCH rdma-core 1/8] Update kernel headers
Date:   Mon, 14 Sep 2020 09:34:56 +0300
Message-ID: <20200914063503.192997-2-yishaih@nvidia.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200914063503.192997-1-yishaih@nvidia.com>
References: <20200914063503.192997-1-yishaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1600065218; bh=XIuCYwaYCj2oDMlctjwiTI4QE40tilpmn+NRYx+mRCA=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
         Content-Type;
        b=r4U/fWPh2ZGYIOBLw4vrWKS8jGJv9kpdPdgW3IFF0kuTUhVVc3KjCHF/9Bvn0VMiE
         ZY8n8JTH/PHSjTc0mKOr4e026C/HtRqDFwbmbMlo8lK+a6HSmSQGeC39Kxvv5ftsBZ
         PZA/oIYHr41aUW24DG4siTj1VFl0cUqyFBsm1vU/T7vnjzNhNB9aPVUC+Ac+SkY6wa
         NLlrdvYemZVDVm2OIuL5JRFNJAYphg0BH4WDQexJn5wqwYvjkRB8rrHx0gf79DIFgS
         fLYL8bOqCBiiHt/pvVZ3yTr6Prs+rZClnO8yey6XYIb+lXKb4QD2PbFALDTOJFuh3n
         BS3A99Yn4hlSw==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

To commit 320a6a2fef0b ("RDMA/uverbs: Expose the new GID query API to
user space")

Signed-off-by: Yishai Hadas <yishaih@nvidia.com>
---
 kernel-headers/rdma/ib_user_ioctl_cmds.h  | 16 ++++++++++++++++
 kernel-headers/rdma/ib_user_ioctl_verbs.h | 14 ++++++++++++++
 kernel-headers/rdma/ib_user_verbs.h       | 11 +++++++++++
 kernel-headers/rdma/rdma_user_rxe.h       |  6 +++---
 4 files changed, 44 insertions(+), 3 deletions(-)

diff --git a/kernel-headers/rdma/ib_user_ioctl_cmds.h b/kernel-headers/rdma=
/ib_user_ioctl_cmds.h
index 99dcabf..7968a18 100644
--- a/kernel-headers/rdma/ib_user_ioctl_cmds.h
+++ b/kernel-headers/rdma/ib_user_ioctl_cmds.h
@@ -70,6 +70,8 @@ enum uverbs_methods_device {
 	UVERBS_METHOD_QUERY_PORT,
 	UVERBS_METHOD_GET_CONTEXT,
 	UVERBS_METHOD_QUERY_CONTEXT,
+	UVERBS_METHOD_QUERY_GID_TABLE,
+	UVERBS_METHOD_QUERY_GID_ENTRY,
 };
=20
 enum uverbs_attrs_invoke_write_cmd_attr_ids {
@@ -352,4 +354,18 @@ enum uverbs_attrs_async_event_create {
 	UVERBS_ATTR_ASYNC_EVENT_ALLOC_FD_HANDLE,
 };
=20
+enum uverbs_attrs_query_gid_table_cmd_attr_ids {
+	UVERBS_ATTR_QUERY_GID_TABLE_ENTRY_SIZE,
+	UVERBS_ATTR_QUERY_GID_TABLE_FLAGS,
+	UVERBS_ATTR_QUERY_GID_TABLE_RESP_ENTRIES,
+	UVERBS_ATTR_QUERY_GID_TABLE_RESP_NUM_ENTRIES,
+};
+
+enum uverbs_attrs_query_gid_entry_cmd_attr_ids {
+	UVERBS_ATTR_QUERY_GID_ENTRY_PORT,
+	UVERBS_ATTR_QUERY_GID_ENTRY_GID_INDEX,
+	UVERBS_ATTR_QUERY_GID_ENTRY_FLAGS,
+	UVERBS_ATTR_QUERY_GID_ENTRY_RESP_ENTRY,
+};
+
 #endif
diff --git a/kernel-headers/rdma/ib_user_ioctl_verbs.h b/kernel-headers/rdm=
a/ib_user_ioctl_verbs.h
index 5debab4..cfea82a 100644
--- a/kernel-headers/rdma/ib_user_ioctl_verbs.h
+++ b/kernel-headers/rdma/ib_user_ioctl_verbs.h
@@ -250,4 +250,18 @@ enum rdma_driver_id {
 	RDMA_DRIVER_SIW,
 };
=20
+enum ib_uverbs_gid_type {
+	IB_UVERBS_GID_TYPE_IB,
+	IB_UVERBS_GID_TYPE_ROCE_V1,
+	IB_UVERBS_GID_TYPE_ROCE_V2,
+};
+
+struct ib_uverbs_gid_entry {
+	__aligned_u64 gid[2];
+	__u32 gid_index;
+	__u32 port_num;
+	__u32 gid_type;
+	__u32 netdev_ifindex; /* It is 0 if there is no netdev associated with it=
 */
+};
+
 #endif
diff --git a/kernel-headers/rdma/ib_user_verbs.h b/kernel-headers/rdma/ib_u=
ser_verbs.h
index 0474c74..456438c 100644
--- a/kernel-headers/rdma/ib_user_verbs.h
+++ b/kernel-headers/rdma/ib_user_verbs.h
@@ -457,6 +457,17 @@ struct ib_uverbs_poll_cq {
 	__u32 ne;
 };
=20
+enum ib_uverbs_wc_opcode {
+	IB_UVERBS_WC_SEND =3D 0,
+	IB_UVERBS_WC_RDMA_WRITE =3D 1,
+	IB_UVERBS_WC_RDMA_READ =3D 2,
+	IB_UVERBS_WC_COMP_SWAP =3D 3,
+	IB_UVERBS_WC_FETCH_ADD =3D 4,
+	IB_UVERBS_WC_BIND_MW =3D 5,
+	IB_UVERBS_WC_LOCAL_INV =3D 6,
+	IB_UVERBS_WC_TSO =3D 7,
+};
+
 struct ib_uverbs_wc {
 	__aligned_u64 wr_id;
 	__u32 status;
diff --git a/kernel-headers/rdma/rdma_user_rxe.h b/kernel-headers/rdma/rdma=
_user_rxe.h
index aae2e69..d8f2e0e 100644
--- a/kernel-headers/rdma/rdma_user_rxe.h
+++ b/kernel-headers/rdma/rdma_user_rxe.h
@@ -99,8 +99,8 @@ struct rxe_send_wr {
 				struct ib_mr *mr;
 				__aligned_u64 reserved;
 			};
-			__u32        key;
-			__u32        access;
+			__u32	     key;
+			__u32	     access;
 		} reg;
 	} wr;
 };
@@ -112,7 +112,7 @@ struct rxe_sge {
 };
=20
 struct mminfo {
-	__aligned_u64  		offset;
+	__aligned_u64		offset;
 	__u32			size;
 	__u32			pad;
 };
--=20
1.8.3.1

