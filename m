Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96B1432D3E1
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Mar 2021 14:06:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241081AbhCDNG1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 4 Mar 2021 08:06:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:43106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241080AbhCDNFz (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 4 Mar 2021 08:05:55 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A096B64F2B;
        Thu,  4 Mar 2021 13:05:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614863115;
        bh=7SzjOSZ/DE2sl6l96P72s0ZeGNzFpnBBipNCOn8K2yQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ilp0M7ey1tWHh0grZQOjnEFq7hgzaPgv/vahyAJi9hktozOcqsLF3aMzVLjp29HCg
         qLagTph8FzFIh/NEhCW0XhL9QeQ2UbpCCB33mQ+ib2fAqaFkcETPM3gOt+V/V6xwU8
         6ZVnUKa89orhJtY8i1psf2qcpg48hn52yMplrkVg7//XCateugwGU5q1M9/Bo1iuZM
         bG2iNa6l9rkhII6JkTwJyvjjo1PlpGEe5bWfMrb/emnwudw9zGd/bkyNz3ux7vtR25
         LnwHjatk/QRXoS1s1WmSWUR4ZmbyI7eb9Twdcv6iRpfpNTY03oxosDfJAoEIhDh4J9
         qjUYInovFsLLw==
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Yishai Hadas <yishaih@nvidia.com>, linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next 2/3] IB/core: Split uverbs_get_const/default to consider target type
Date:   Thu,  4 Mar 2021 15:05:00 +0200
Message-Id: <20210304130501.1102577-3-leon@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210304130501.1102577-1-leon@kernel.org>
References: <20210304130501.1102577-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Yishai Hadas <yishaih@nvidia.com>

Change uverbs_get_const/uverbs_get_const_default to work properly with
both signed/unsigned parameters.

Current APIs mix s64 and u64 which leads to incorrect check when u64
value was supplied and its upper bit was set. In that case
uverbs_get_const() / uverbs_get_const_default() lower bound check may
fail unexpectedly, target is unsigned (lower bound is 0) but value
became negative as of the s64 usage.

Split to have two different APIs, no change to callers as the required
API will be called internally according to the target type.

Signed-off-by: Yishai Hadas <yishaih@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/uverbs_ioctl.c | 32 +++++++++--
 drivers/infiniband/hw/mlx5/main.c      |  1 +
 include/rdma/uverbs_ioctl.h            | 80 +++++++++++++++++++++-----
 3 files changed, 96 insertions(+), 17 deletions(-)

diff --git a/drivers/infiniband/core/uverbs_ioctl.c b/drivers/infiniband/core/uverbs_ioctl.c
index ff047eb024ab..990f0724acc6 100644
--- a/drivers/infiniband/core/uverbs_ioctl.c
+++ b/drivers/infiniband/core/uverbs_ioctl.c
@@ -752,9 +752,10 @@ int uverbs_output_written(const struct uverbs_attr_bundle *bundle, size_t idx)
 	return uverbs_set_output(bundle, attr);
 }
 
-int _uverbs_get_const(s64 *to, const struct uverbs_attr_bundle *attrs_bundle,
-		      size_t idx, s64 lower_bound, u64 upper_bound,
-		      s64  *def_val)
+int _uverbs_get_const_signed(s64 *to,
+			     const struct uverbs_attr_bundle *attrs_bundle,
+			     size_t idx, s64 lower_bound, u64 upper_bound,
+			     s64  *def_val)
 {
 	const struct uverbs_attr *attr;
 
@@ -773,7 +774,30 @@ int _uverbs_get_const(s64 *to, const struct uverbs_attr_bundle *attrs_bundle,
 
 	return 0;
 }
-EXPORT_SYMBOL(_uverbs_get_const);
+EXPORT_SYMBOL(_uverbs_get_const_signed);
+
+int _uverbs_get_const_unsigned(u64 *to,
+			       const struct uverbs_attr_bundle *attrs_bundle,
+			       size_t idx, u64 upper_bound, u64 *def_val)
+{
+	const struct uverbs_attr *attr;
+
+	attr = uverbs_attr_get(attrs_bundle, idx);
+	if (IS_ERR(attr)) {
+		if ((PTR_ERR(attr) != -ENOENT) || !def_val)
+			return PTR_ERR(attr);
+
+		*to = *def_val;
+	} else {
+		*to = attr->ptr_attr.data;
+	}
+
+	if (*to > upper_bound)
+		return -EINVAL;
+
+	return 0;
+}
+EXPORT_SYMBOL(_uverbs_get_const_unsigned);
 
 int uverbs_copy_to_struct_or_zero(const struct uverbs_attr_bundle *bundle,
 				  size_t idx, const void *from, size_t size)
diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index aa3e90594a88..5226664f1bda 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -42,6 +42,7 @@
 #include "counters.h"
 #include <linux/mlx5/accel.h>
 #include <rdma/uverbs_std_types.h>
+#include <rdma/uverbs_ioctl.h>
 #include <rdma/mlx5_user_ioctl_verbs.h>
 #include <rdma/mlx5_user_ioctl_cmds.h>
 #include <rdma/ib_umem_odp.h>
diff --git a/include/rdma/uverbs_ioctl.h b/include/rdma/uverbs_ioctl.h
index 39ef204753ec..3829b6ef4bb6 100644
--- a/include/rdma/uverbs_ioctl.h
+++ b/include/rdma/uverbs_ioctl.h
@@ -875,9 +875,14 @@ static inline __malloc void *uverbs_kcalloc(struct uverbs_attr_bundle *bundle,
 		return ERR_PTR(-EOVERFLOW);
 	return uverbs_zalloc(bundle, bytes);
 }
-int _uverbs_get_const(s64 *to, const struct uverbs_attr_bundle *attrs_bundle,
-		      size_t idx, s64 lower_bound, u64 upper_bound,
-		      s64 *def_val);
+
+int _uverbs_get_const_signed(s64 *to,
+			     const struct uverbs_attr_bundle *attrs_bundle,
+			     size_t idx, s64 lower_bound, u64 upper_bound,
+			     s64 *def_val);
+int _uverbs_get_const_unsigned(u64 *to,
+			       const struct uverbs_attr_bundle *attrs_bundle,
+			       size_t idx, u64 upper_bound, u64 *def_val);
 int uverbs_copy_to_struct_or_zero(const struct uverbs_attr_bundle *bundle,
 				  size_t idx, const void *from, size_t size);
 #else
@@ -921,27 +926,76 @@ uverbs_copy_to_struct_or_zero(const struct uverbs_attr_bundle *bundle,
 {
 	return -EINVAL;
 }
+static int
+_uverbs_get_const_signed(s64 *to, const struct uverbs_attr_bundle *attrs_bundle,
+			 size_t idx, s64 lower_bound, u64 upper_bound,
+			 s64 *def_val)
+{
+	return -EINVAL;
+}
+static int
+_uverbs_get_const_unsigned(u64 *to,
+			   const struct uverbs_attr_bundle *attrs_bundle,
+			   size_t idx, u64 upper_bound, u64 *def_val)
+{
+	return -EINVAL;
+}
 #endif
 
-#define uverbs_get_const(_to, _attrs_bundle, _idx)                             \
+#define uverbs_get_const_signed(_to, _attrs_bundle, _idx)                      \
 	({                                                                     \
 		s64 _val;                                                      \
-		int _ret = _uverbs_get_const(&_val, _attrs_bundle, _idx,       \
-					     type_min(typeof(*_to)),           \
-					     type_max(typeof(*_to)), NULL);    \
-		(*_to) = _val;                                                 \
+		int _ret =                                                     \
+			_uverbs_get_const_signed(&_val, _attrs_bundle, _idx,   \
+					  type_min(typeof(*(_to))),            \
+					  type_max(typeof(*(_to))), NULL);     \
+		(*(_to)) = _val;                                               \
 		_ret;                                                          \
 	})
 
-#define uverbs_get_const_default(_to, _attrs_bundle, _idx, _default)           \
+#define uverbs_get_const_unsigned(_to, _attrs_bundle, _idx)                    \
+	({                                                                     \
+		u64 _val;                                                      \
+		int _ret =                                                     \
+			_uverbs_get_const_unsigned(&_val, _attrs_bundle, _idx, \
+					  type_max(typeof(*(_to))), NULL);     \
+		(*(_to)) = _val;                                               \
+		_ret;                                                          \
+	})
+
+#define uverbs_get_const_default_signed(_to, _attrs_bundle, _idx, _default)    \
 	({                                                                     \
 		s64 _val;                                                      \
 		s64 _def_val = _default;                                       \
 		int _ret =                                                     \
-			_uverbs_get_const(&_val, _attrs_bundle, _idx,          \
-					  type_min(typeof(*_to)),              \
-					  type_max(typeof(*_to)), &_def_val);  \
-		(*_to) = _val;                                                 \
+			_uverbs_get_const_signed(&_val, _attrs_bundle, _idx,   \
+				type_min(typeof(*(_to))),                      \
+				type_max(typeof(*(_to))), &_def_val);          \
+		(*(_to)) = _val;                                               \
+		_ret;                                                          \
+	})
+
+#define uverbs_get_const_default_unsigned(_to, _attrs_bundle, _idx, _default)  \
+	({                                                                     \
+		u64 _val;                                                      \
+		u64 _def_val = _default;                                       \
+		int _ret =                                                     \
+			_uverbs_get_const_unsigned(&_val, _attrs_bundle, _idx, \
+				type_max(typeof(*(_to))), &_def_val);          \
+		(*(_to)) = _val;                                               \
 		_ret;                                                          \
 	})
+
+#define uverbs_get_const(_to, _attrs_bundle, _idx)                             \
+	(is_signed_type(typeof(*(_to))) ?                                      \
+		 uverbs_get_const_signed(_to, _attrs_bundle, _idx) :           \
+		 uverbs_get_const_unsigned(_to, _attrs_bundle, _idx))          \
+
+#define uverbs_get_const_default(_to, _attrs_bundle, _idx, _default)           \
+	(is_signed_type(typeof(*(_to))) ?                                      \
+		 uverbs_get_const_default_signed(_to, _attrs_bundle, _idx,     \
+						  _default) :                  \
+		 uverbs_get_const_default_unsigned(_to, _attrs_bundle, _idx,   \
+						    _default))
+
 #endif
-- 
2.29.2

