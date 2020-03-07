Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9ACFE17CD6A
	for <lists+linux-rdma@lfdr.de>; Sat,  7 Mar 2020 11:02:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726017AbgCGKCX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 7 Mar 2020 05:02:23 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:38792 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725878AbgCGKCX (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sat, 7 Mar 2020 05:02:23 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 7FE6A1B59B34554F928E;
        Sat,  7 Mar 2020 18:02:17 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.487.0; Sat, 7 Mar 2020 18:02:11 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>
Subject: [PATCH] MAINTAINERS: Update maintainers for HISILICON ROCE DRIVER
Date:   Sat, 7 Mar 2020 17:58:34 +0800
Message-ID: <1583575114-32194-1-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Add myself as a maintainer for HNS RoCE drivers, and update Xavier's e-amil
address.

Cc: Lijun Ou <oulijun@huawei.com>
Cc: Wei Hu(Xavier) <huwei87@hisilicon.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 MAINTAINERS | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6158a14..e8ae08e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7575,7 +7575,8 @@ F:	Documentation/admin-guide/perf/hisi-pmu.rst
 
 HISILICON ROCE DRIVER
 M:	Lijun Ou <oulijun@huawei.com>
-M:	Wei Hu(Xavier) <xavier.huwei@huawei.com>
+M:	Wei Hu(Xavier) <huwei87@hisilicon.com>
+M:	Weihang Li <liweihang@huawei.com>
 L:	linux-rdma@vger.kernel.org
 S:	Maintained
 F:	drivers/infiniband/hw/hns/
-- 
2.8.1

