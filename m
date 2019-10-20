Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4739CDDD25
	for <lists+linux-rdma@lfdr.de>; Sun, 20 Oct 2019 09:16:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726204AbfJTHQM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 20 Oct 2019 03:16:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:34334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726125AbfJTHQM (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 20 Oct 2019 03:16:12 -0400
Received: from localhost (unknown [77.137.89.37])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F2201222C3;
        Sun, 20 Oct 2019 07:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571555771;
        bh=z3fgPrxRL2hl1SSlqBetc7WaCtjnugbXR7ex5JgOCic=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MIeh0BDyZS7MD9TGg7a+LwhDywXaGCOn0B3jx0hXbjZN19a/nrRzHJdRUQCrdU8co
         Lxr0FTSXlCMtI7y9/a+U9IbwfbnZYS6MnycArYmE46x7oC9zIpqBNY0xipeePf4dJl
         1fQO9qIEjl5+44diiKQDecOJWVm66BW8gclOIihM=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH rdma-next 2/6] RDMA/cm: Use specific keyword to check define
Date:   Sun, 20 Oct 2019 10:15:55 +0300
Message-Id: <20191020071559.9743-3-leon@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191020071559.9743-1-leon@kernel.org>
References: <20191020071559.9743-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

There is a specific define keyword to check if define exists or not,
let's use it instead of open-coded variant.

Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/cm_msgs.h | 2 +-
 include/rdma/ib_cm.h              | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/core/cm_msgs.h b/drivers/infiniband/core/cm_msgs.h
index 3d16d614aff6..0a9e2d3fb9df 100644
--- a/drivers/infiniband/core/cm_msgs.h
+++ b/drivers/infiniband/core/cm_msgs.h
@@ -31,7 +31,7 @@
  * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS THE
  * SOFTWARE.
  */
-#if !defined(CM_MSGS_H)
+#ifndef CM_MSGS_H
 #define CM_MSGS_H
 
 #include <rdma/ib_mad.h>
diff --git a/include/rdma/ib_cm.h b/include/rdma/ib_cm.h
index 49f4f75499b3..5dc4ec986527 100644
--- a/include/rdma/ib_cm.h
+++ b/include/rdma/ib_cm.h
@@ -32,7 +32,7 @@
  * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
  * SOFTWARE.
  */
-#if !defined(IB_CM_H)
+#ifndef IB_CM_H
 #define IB_CM_H
 
 #include <rdma/ib_mad.h>
-- 
2.20.1

