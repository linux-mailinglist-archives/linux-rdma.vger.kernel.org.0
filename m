Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E539B350C68
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Apr 2021 04:11:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232492AbhDACLL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 31 Mar 2021 22:11:11 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:15838 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232271AbhDACLC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 31 Mar 2021 22:11:02 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4F9mnY2tk6z93hs;
        Thu,  1 Apr 2021 10:08:49 +0800 (CST)
Received: from localhost (10.174.179.96) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.498.0; Thu, 1 Apr 2021
 10:10:46 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] RDMA/uverbs: Fix -Wunused-function warning
Date:   Thu, 1 Apr 2021 10:10:28 +0800
Message-ID: <20210401021028.25720-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.96]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

make W=1 warns this:

In file included from drivers/infiniband/sw/rdmavt/mmap.c:51:0:
./include/rdma/uverbs_ioctl.h:937:1:
 warning: ‘_uverbs_get_const_unsigned’ defined but not used [-Wunused-function]
 _uverbs_get_const_unsigned(u64 *to,
 ^~~~~~~~~~~~~~~~~~~~~~~~~~
./include/rdma/uverbs_ioctl.h:930:1:
 warning: ‘_uverbs_get_const_signed’ defined but not used [-Wunused-function]
 _uverbs_get_const_signed(s64 *to, const struct uverbs_attr_bundle *attrs_bundle,
 ^~~~~~~~~~~~~~~~~~~~~~~~

Make these functions inline to fix this warnings.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 include/rdma/uverbs_ioctl.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/rdma/uverbs_ioctl.h b/include/rdma/uverbs_ioctl.h
index 3829b6ef4bb6..23bb404aba12 100644
--- a/include/rdma/uverbs_ioctl.h
+++ b/include/rdma/uverbs_ioctl.h
@@ -926,14 +926,15 @@ uverbs_copy_to_struct_or_zero(const struct uverbs_attr_bundle *bundle,
 {
 	return -EINVAL;
 }
-static int
-_uverbs_get_const_signed(s64 *to, const struct uverbs_attr_bundle *attrs_bundle,
+static inline int
+_uverbs_get_const_signed(s64 *to,
+			 const struct uverbs_attr_bundle *attrs_bundle,
 			 size_t idx, s64 lower_bound, u64 upper_bound,
 			 s64 *def_val)
 {
 	return -EINVAL;
 }
-static int
+static inline int
 _uverbs_get_const_unsigned(u64 *to,
 			   const struct uverbs_attr_bundle *attrs_bundle,
 			   size_t idx, u64 upper_bound, u64 *def_val)
-- 
2.17.1

